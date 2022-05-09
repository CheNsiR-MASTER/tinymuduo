#pragma once

#include "noncopyable.h"
#include "Callback.h"
#include "Logger.h"
#include "InetAddress.h"
#include "Buffer.h"
#include "Timestamp.h"

#include <string>
#include <atomic>
#include <memory>
#include <functional>

class EventLoop;
class Socket;
class Channel;
// enable_shared_from_this < TcpConnection > 表示可以获得一个指向自身对象的智能指针 
class TcpConnection : noncopyable,public std::enable_shared_from_this<TcpConnection>
{
public:
    TcpConnection(EventLoop* loop,
                const std::string& nameArg,
                int fd,
                const InetAddress localAddr,
                const InetAddress peerAddr
                );
    ~TcpConnection();

    EventLoop* getLoop() const { return loop_; }
    const std::string& getName() const { return name_; }
    const InetAddress& localAddress() const { return localAddr_; }
    const InetAddress& peerAddress() const { return peerAddr_; }
    
    bool connected() const { return state_ == kConnected; }

    /**
     * @brief 发送数据
     * 
     */
    void send(const std::string& buf);
    /**
     * @brief 关闭连接
     * 
     */
    void shutdown();

    // 连接建立
    void connectionEstablished();

    // 连接销毁
    void connectionDestroy();

    // 设置回调
    void setConnectionCallback(const ConnectionCallback& cb) { connectionCallback_ = cb; }
    void setMessageCallback(const MessageCallback& cb) { messageCallback_ = cb; }
    void setWriteCompleteCallback(const WriteCompleteCallback& cb) { writeCompleteCallback_ = cb; }
    void setCloseCallback(const CloseCallback& cb) { closeCallback_ = cb; }
    void setHighWaterMarkCallback(const HighWaterMarkCallback& cb, size_t highWaterMark)
    { highWaterMark_ = highWaterMark; highWaterMarkCallback_ = cb; }

private:
    enum stateE
    {
        kDisConnected,
        kConnected,
        kDisConnecting,
        kConnecting
    };

    void sendInLoop(const void* data,size_t len);
    void shutdownInLoop();

    void handleRead(Timestamp receiveTime);
    void handleWrite();
    void handleClose();
    void handleError();

    void setState(stateE state) { state_ = state; }
    // 这里的loop不是 baseLoop => 因为 TcpConnection都是在 subloop里面
    EventLoop* loop_;
    const std::string name_;
    std::atomic_int state_;
    bool reading_;

    /**
     * @brief 这里的实现对应了 Acceptor
     * Acceptor -> mainLoop   TcpConnection -> subLoop
     */
    std::unique_ptr<Socket> socket_;
    std::unique_ptr<Channel> channel_;

    const InetAddress localAddr_;
    const InetAddress peerAddr_;

    /**
     * @brief 定义了需要使用的几种回调函数
     * connectionCallback -> 有新连接建立时的回调函数
     * closeCallback ->      关闭连接时用的回调函数
     * writeCompleteCallback -> 消息发送完之后的回调函数
     * messageCallback    ->   有消息读写时的回调函数
     * highWaterMarkCallback; -> 高水位标记回调函数，防止缓冲区数据过多
     */
    ConnectionCallback connectionCallback_;
    CloseCallback closeCallback_;
    WriteCompleteCallback writeCompleteCallback_;
    MessageCallback messageCallback_;
    HighWaterMarkCallback highWaterMarkCallback_;

    size_t highWaterMark_;

    /**
     * @brief 接受数据的缓冲区 和 输出数据的缓冲区
     */
    Buffer inputBuffer_;
    Buffer outputBuffer_;
};