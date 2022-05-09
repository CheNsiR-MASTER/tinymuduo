#include "Acceptor.h"
#include "InetAddress.h"
#include "Logger.h"

#include <sys/socket.h>
#include <sys/types.h>

static int createNoBlocking()
{
    int sockfd = ::socket(AF_INET, SOCK_STREAM | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
    if (sockfd < 0) 
    {
        LOG_FATAL("%s:%s:%d listen socket create err:%d \n", __FILE__, __FUNCTION__, __LINE__, errno);
    }
};

Acceptor::Acceptor(EventLoop* loop,const InetAddress& addr, bool reuseport)
    :loop_(loop),
    acceptSocket_(createNoBlocking()),
    acceptChannel_(loop, acceptSocket_.fd()),
    listening_(false)
{
    acceptSocket_.setReuseAddr(true);
    acceptSocket_.setReusePort(true);
    acceptSocket_.bindAddress(addr);

    // TcpServer::start() -> Acceptor::listen
    // 有新用户需要进行连接，需要 connfd -> channel -> subloop 
    acceptChannel_.setReadCallback(std::bind(&Acceptor::handleRead,this));
}

Acceptor::~Acceptor()
{
    acceptChannel_.disableAll();
    acceptChannel_.remove();
}

void Acceptor::listen()
{
    listening_ = true;
    acceptSocket_.listen();
    acceptChannel_.enableReading();
}

// listenfd 有读事件发生，表示有新用户连接
void Acceptor::handleRead()
{
    InetAddress peerAddr;
    int connfd = acceptSocket_.accept(&peerAddr);

    if(connfd >= 0)
    {
        if(newConnectionCallback_)
        {
            newConnectionCallback_(connfd, peerAddr); // 轮询找到subLoop，唤醒，分发当前的新客户端的Channel
        }
        else
        {
            ::close(connfd);
        }
    }
    else
    {
        LOG_ERROR("%s:%s:%d accept err:%d \n", __FILE__, __FUNCTION__, __LINE__, errno);
        if (errno == EMFILE)
        {
            LOG_ERROR("%s:%s:%d sockfd reached limit! \n", __FILE__, __FUNCTION__, __LINE__);
        }
    }
}