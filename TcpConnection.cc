#include "TcpConnection.h"
#include "Eventloop.h"
#include "Socket.h"
#include "channel.h"
#include "Callback.h"

#include <functional>
#include <errno.h>
#include <sys/types.h>         
#include <sys/socket.h>
#include <strings.h>
#include <netinet/tcp.h>
#include <sys/socket.h>
#include <string>

static EventLoop* checkNotNullLoop(EventLoop* loop)
{
    if(loop == nullptr)
    {
        LOG_FATAL("%s:%s:%d TcpConnection Loop is null! \n", __FILE__, __FUNCTION__, __LINE__);
    }
    return loop;
}

TcpConnection::TcpConnection(EventLoop* loop,
            const std::string& nameArg,
            int fd,
            const InetAddress localAddr,
            const InetAddress peerAddr
            )
    :loop_(checkNotNullLoop(loop)),
    name_(nameArg),
    state_(kConnecting),
    reading_(true),
    socket_(new Socket(fd)),
    channel_(new Channel(loop,fd)),
    localAddr_(localAddr),
    peerAddr_(peerAddr),
    highWaterMark_(64 * 1024 * 1024) // 64Mb
{
    // 给channel 设置相应的回调函数，
    // poller给channel 设置的相应事件发生，channel会调用相应的回调函数
    channel_->setReadCallback(
        std::bind(&TcpConnection::handleRead, this, std::placeholders::_1)
    );
    channel_->setWriteCallback(
        std::bind(&TcpConnection::handleWrite, this)
    );
     channel_->setCloseCallback(
        std::bind(&TcpConnection::handleClose, this)
    );
    channel_->setErrorCallback(
        std::bind(&TcpConnection::handleError, this)
    );
    LOG_INFO("TcpConnection::ctor[%s] at fd=%d\n", name_.c_str(), fd);
    socket_->setKeepAlive(true);
}

TcpConnection::~TcpConnection()
{
    LOG_INFO("TcpConnection::dtor[%s] at fd=%d state=%d \n", 
        name_.c_str(), channel_->fd(), (int)state_);
}

void TcpConnection::handleRead(Timestamp receiveTime)
{
    int saveinfo = 0;
    ssize_t n = inputBuffer_.readFd(channel_->fd(), &saveinfo);
    if(n > 0)
    {
        // 已经建立连接的用户，有可读事件发生，调用传入的回调函数
        messageCallback_(shared_from_this(), &inputBuffer_, receiveTime);    
    }
    else if(n == 0)
    {
        handleClose();
    }
    else
    {
        errno = saveinfo;
        LOG_ERROR("TcpConnection::handleRead");
        handleError();
    }
}

void TcpConnection::handleWrite()
{
    if( channel_-> isWrtting())
    {
        int saveinfo = 0;
        ssize_t n = outputBuffer_.writeFd(channel_->fd(), &saveinfo);
        if(n > 0)
        {
            // 已经处理完写事件，将 writeIndex_ 复位
            outputBuffer_.retrieve(n);
            if(outputBuffer_.readableBytes() == 0)
            {
                channel_->disableWritting();
                if(writeCompleteCallback_)
                {
                    // 唤醒相应的loop 处理回调
                    loop_->queueInLoop(std::bind(
                        writeCompleteCallback_, shared_from_this()
                    ));
                }
                if(state_ == kDisConnecting)
                {
                    shutdownInLoop();
                }
            }
        }
        else
        {
            LOG_ERROR("TcpConnection::handleWrite");
        }
    }
    else
    {
        LOG_ERROR("TcpConnection fd=%d is down, no more writing \n", channel_->fd());
    }
}

/**
 * @brief 
 * 执行顺序， Poller -> channel::closeCallback -> TcpConnection::handleClose() 
 */
void TcpConnection::handleClose()
{
    LOG_INFO("TcpConnection::handleClose fd=%d state=%d \n", channel_->fd(), (int)state_);
    setState(kDisConnected);
    channel_->disableAll();

    TcpConnectionPtr connPtr(shared_from_this());
    // 执行连接关闭的回调
    connectionCallback_(connPtr);
    // 执行关闭连接的回调 => TcpServer::removeConnection
    closeCallback_(connPtr);
}

void TcpConnection::handleError()
{
    int optval;
    socklen_t optlen = sizeof optval;
    int err = 0;
    if (::getsockopt(channel_->fd(), SOL_SOCKET, SO_ERROR, &optval, &optlen) < 0)
    {
        err = errno;
    }
    else
    {
        err = optval;
    }
    LOG_ERROR("TcpConnection::handleError name:%s - SO_ERROR:%d \n", name_.c_str(), err);
}


void TcpConnection::send(const std::string& buf)
{
    if(state_ == kConnected)
    {
        if(loop_->isInLoopThread())
        {
            sendInLoop(buf.c_str(), buf.size());
        }
        else
        {
            loop_->runInLoop(
                std::bind(&TcpConnection::sendInLoop,
                        this,
                        buf.c_str(),
                        buf.size()
                )
            );
        }
    }
}

void TcpConnection::shutdown()
{
    if (state_ == kConnected)
    {
        setState(kDisConnecting);
        loop_->runInLoop(
            std::bind(&TcpConnection::shutdownInLoop, this)
        );
    }
}

// 发送数据，应用写的快，而内核数据发送数据慢，需要把待发送的数据写入缓冲区，且设置了水位回调
void TcpConnection::sendInLoop(const void* data,size_t len)
{
    ssize_t nwrote = 0;
    size_t remaining = len;
    bool faultError = false;

    // 之前调用过该connection的shutdown，不能再进行发送了
    if (state_ == kDisConnected)
    {
        LOG_ERROR("disconnected, give up writing!");
        return;
    }

    // channel 第一次开始写数据，而且缓冲区没有待发送数据
    if(!channel_->isWrtting() && outputBuffer_.readableBytes() == 0)
    {
        nwrote = ::write(channel_->fd(), data, len);
        if(nwrote >= 0)
        {
            remaining = len - nwrote;

            // 如果数据全部读完，且用户注册了回调
            if(remaining == 0 && writeCompleteCallback_)
            {
                loop_->queueInLoop(
                    std::bind(writeCompleteCallback_,shared_from_this())
                );
            }
        }
        else
        {
            nwrote = 0;
            if (errno != EWOULDBLOCK)
            {
                LOG_ERROR("TcpConnection::sendInLoop");
                if (errno == EPIPE || errno == ECONNRESET) // SIGPIPE  RESET
                {
                    faultError = true;
                }
            }
        }
    }

    // 此时 remaining > 0 数据没有全部读完
    if(!faultError && remaining > 0)
    {
        size_t oldlen = outputBuffer_.readableBytes();
        // 确保数据不会超过 高水位
        if(oldlen + remaining > highWaterMark_
        && oldlen < highWaterMark_
        && highWaterMarkCallback_)
        {
            loop_->queueInLoop(
                std::bind(
                    highWaterMarkCallback_,
                    shared_from_this(),
                    oldlen + remaining
                )
            );
        }

         // 如果数据没有超过高水位，就从 data + nwrote（已经写完的数据）开始，追加到buffer中
        outputBuffer_.append((char*)data + nwrote, remaining);

        if(!channel_->isWrtting())
        {
            // 给channel_注册写事件，否则 poller 不会给 channel 通知 epollout
            channel_->enableWritting();
        }
    }
}

void TcpConnection::shutdownInLoop()
{
    if(!channel_->isWrtting())
    {
        socket_->shutdownWrite();
    }
}

void TcpConnection::connectionEstablished()
{
    setState(kConnected);
    
    channel_->tie(shared_from_this());
    // 向poller 注册读事件
    channel_->enableReading();
    // 新连接建立，执行回调
    connectionCallback_(shared_from_this());
}

void TcpConnection::connectionDestroy()
{
    if (state_ == kConnected)
    {
        setState(kDisConnected);
        channel_->disableAll(); // 把channel的所有感兴趣的事件，从poller中del掉
        connectionCallback_(shared_from_this());
    }
    channel_->remove(); // 把channel从poller中删除掉
}