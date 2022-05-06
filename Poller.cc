#include "Poller.h"

Poller::Poller(EventLoop* loop)
    :ownerloop_(loop) { }

bool Poller::hasChannel(Channel* channel) const 
{
    return channels_.count(channel->fd());
}

// Poller中没有 newDefaultPoller的实现
// 原因是 newDefaultPoller的实现需要具体创建出一个 Poll对象或Epoll对象
// 就需要包含派生类的头文件 这是一个很差的实现方式
// muduo库中的实现采用了 单独创建一个文件的方式