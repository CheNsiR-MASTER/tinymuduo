#include "Poller.h"
#include "EpollPoller.h"

#include <stdlib.h>

Poller* Poller::newDefaultPoller(EventLoop* loop)
{
    if(::getenv("MUDUO_USE_POLL"))
    {
        return nullptr;// 生成一个poll的实例
    }
    else return new EpollPoller(loop); // 生成一个 epoll的实例
}