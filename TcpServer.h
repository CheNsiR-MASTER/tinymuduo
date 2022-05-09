#pragma once

#include "Eventloop.h"
#include "Acceptor.h"
#include "InetAddress.h"
#include "noncopyable.h"
#include "EventLoopThreadPool.h"
#include "Callback.h"
#include "TcpConnection.h"
#include "Buffer.h"

#include <functional>
#include <string>
#include <unordered_map>
#include <memory>
#include <atomic>

class EventLoop;
class InetAddress;
class EventLoopThreadPool;

// 对外的服务器编程使用的类
class TcpServer : noncopyable
{
public:
    using ThreadInitCallback = std::function<void(EventLoop*)>;

    enum Option
    {
        kNoReusePort,
        kReusePort
    };
    TcpServer(
        EventLoop* loop,
        const InetAddress& addr,
        const std::string& nameArg,
        Option option = kNoReusePort
    );
    ~TcpServer();

    // 设置底层线程的数量
    void setThreadNum(int num);

    void setThreadInitcallback(const ThreadInitCallback &cb) { threadInitCallback_ = cb; }
    void setConnectionCallback(const ConnectionCallback &cb) { connectionCallback_ = cb; }
    void setMessageCallback(const MessageCallback &cb) { messageCallback_ = cb; }
    void setWriteCompleteCallback(const WriteCompleteCallback &cb) { writeCompleteCallback_ = cb; }

    // 开启服务器监听
    void start();
private:
    void newConnection(int sockfd, const InetAddress &peerAddr);
    void removeConnection(const TcpConnectionPtr &conn);
    void removeConnectionInLoop(const TcpConnectionPtr &conn);
    EventLoop* loop_;
    const std::string ipPort_;
    const std::string name_;

    std::unique_ptr<Acceptor> acceptor_;
    std::shared_ptr<EventLoopThreadPool> threadPool_;

    std::atomic_int started_;
    int nextConnId_;
    using ConnectionMap =  std::unordered_map<std::string, TcpConnectionPtr>;
    ConnectionMap connections_;

    ConnectionCallback connectionCallback_; // 有新连接时的回调
    MessageCallback messageCallback_; // 有读写消息时的回调
    WriteCompleteCallback writeCompleteCallback_; // 消息发送完成以后的回调

    ThreadInitCallback threadInitCallback_; // loop线程初始化的回调
};