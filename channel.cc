#include "channel.h"
#include "Logger.h"
#include "sys/epoll.h"

const int kNoneEvents = 0;
const int kReadEvents = EPOLLIN | EPOLLPRI;
const int kWriteEvents = EPOLLOUT;

Channel::Channel(EventLoop* loop, int fd)
    :loop_(loop),
    fd_(fd),
    events_(0),
    revents_(0),
    index_(-1),
    tied_(false) { } 

Channel::~Channel() { }

void Channel::HandleEvent(Timestamp receiveTime)
{
    if(tied_)
    {
        // 将weakptr指针升级为 sharedptr
        std::shared_ptr<void> guard = tie_.lock();
        if(guard) handleEventWithGuard(receiveTime);
    }
    else handleEventWithGuard(receiveTime);
}

void Channel::handleEventWithGuard(Timestamp receiveTime)
{
    LOG_INFO("handle Event with guard revents_ = %d\n",events_);
    // 
    if((revents_ & EPOLLHUP) && !(revents_ & EPOLLIN))
    {
        if(closeCallback_) closeCallback_();
    }

    if((revents_ & EPOLLERR))
    {
        if(errorCallback_) errorCallback_();
    }

    if((revents_ & (EPOLLIN | EPOLLPRI | EPOLLRDHUP)))
    {
        if(readCallback_) readCallback_(receiveTime);
    }

    if((revents_ & EPOLLOUT))
    {
        if(writeCallback_) writeCallback_();
    }
}

void Channel::tie(std::shared_ptr<void>& obj) 
{
    tie_ = obj;
    tied_ = true;
}

void Channel::remove()
{
    loop_->removeChannel(this);
}

void Channel::update()
{
    loop_->updateChannel(this);
}