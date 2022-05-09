#pragma once

#include "noncopyable.h"
#include "Socket.h"
#include "channel.h"

#include <functional>

class EventLoop;
class InetAddress;
class Acceptor : noncopyable
{
public:
    using NewConnectionCallback = std::function<void(int sockfd,const InetAddress& addr)>;
    Acceptor(EventLoop* loop,const InetAddress& addr, bool reuseport);
    ~Acceptor();
    
    bool listening() { return listening_; }
    void listen();

    void setNewConnectionCallback(const NewConnectionCallback& cb)
    {
        newConnectionCallback_ = cb;
    }
private:
    void handleRead();
    EventLoop* loop_;
    Socket acceptSocket_;
    Channel acceptChannel_;
    bool listening_;
    NewConnectionCallback newConnectionCallback_;
};