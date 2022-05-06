#include "Eventloop.h"
#include "channel.h"

__thread EventLoop* t_loopInThisThread = nullptr;

const int kPollTimeMs = 10000;

// 创建wakeup_ 用于 唤醒 subreactor
int createEventfd()
{
    int evtfd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
    if(evtfd < 0)
    {
        LOG_FATAL("eventfd fatal error %d \n",evtfd);
    }
    return evtfd;
}

EventLoop::EventLoop()
    :looping_(false),
    quit_(false),
    callingPendingFunctors_(false),
    threadId_(CurrentThread::tid()),
    poller_(Poller::newDefaultPoller(this)),
    wakeupFd_(createEventfd()),
    wakeupChannel_(new Channel(this, wakeupFd_)),
    currentActiveChannels_(NULL)  
{
    LOG_DEBUG("EVENT loop create %p in thread %d \n",this,threadId_);
    if(t_loopInThisThread)
    {
        LOG_FATAL("Another EventLoop exists");
    }
    else
    {
        t_loopInThisThread = this;
    }
}

void EventLoop::handleRead()
{
    
}

EventLoop::~EventLoop()
{
    wakeupChannel_->disableAll();

}