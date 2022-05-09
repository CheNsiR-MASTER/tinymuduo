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
    wakeupChannel_(new Channel(this, wakeupFd_))
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

    // 设置 wakeupfd 的事件类型以及发生事件后的回调操作
    wakeupChannel_->setReadCallback(
        std::bind(&EventLoop::handleRead,this)
    );
    // 每一个 loop 都将监听wakeupchannel 的 EPOLLIN
    wakeupChannel_->enableReading();
}

void EventLoop::handleRead()
{
    uint64_t one = 1;
    ssize_t n = read(wakeupFd_, &one, sizeof one);
    if (n != sizeof one)
    {
        LOG_ERROR ("EventLoop::handleRead() reads %d bytes instead of 8" , (int)n);
    }
}

EventLoop::~EventLoop()
{
    wakeupChannel_->disableAll();
    wakeupChannel_->remove();
    ::close(wakeupFd_);
    t_loopInThisThread = nullptr;
}

// 开启事件循环
void EventLoop::loop()
{
    looping_ = true;
    quit_ = false;
    while (!quit_)
    {
        activeChannels_.clear();
        // 监听两类 fd ，一类是 client 的fd 另一类是 wakeupfd
        pollReturnTime_ = poller_->poll(kPollTimeMs,& activeChannels_);
        for(Channel* channel : activeChannels_)
        {
            // Poller监听了哪些channel发生事件了，然后上报给EventLoop
            // 通知channel 处理相应的事件
            channel-> HandleEvent(pollReturnTime_);
        }
        doPendingFunctors();
    }
    looping_ = false;
}
// 退出事件循环
void EventLoop::quit()
{
    quit_ = true;
    if(!isInLoopThread())
    {
        wakeup();
    }
}

// 在当前loop中执行 cb
void EventLoop::runInLoop(Functor cb)
{
    if(isInLoopThread())
    {
        cb();
    }
    else
    {
        EventLoop::queueInLoop(std::move(cb));
    }
}
// 将cb放入队列中，唤醒loop所在的线程，执行cb
void EventLoop::queueInLoop(Functor cb)
{
    {
        std::unique_lock<std::mutex> lk(mutex_);
        pendingFunctors_.emplace_back(cb);
    }
    // 且 callingPendingFunctors_ 为 true 表示当前线程正在执行回调
    // 此时 当前线程的 vector 已经跟 局部的 vector 置换
    if(!isInLoopThread() || callingPendingFunctors_)
    {
        wakeup();
    }
}

// EventLoop 中的 poller方法
void EventLoop::updateChannel(Channel* channel)
{
    poller_->updateChannel(channel);
}

void EventLoop::removeChannel(Channel* channel)
{
    poller_->removeChannel(channel);
}

bool EventLoop::hasChannel(Channel* channel)
{
    poller_->hasChannel(channel);
}

void EventLoop::wakeup()
{
    uint64_t one = 1;
    ssize_t n = write(wakeupFd_, &one, sizeof n);
    if(n != sizeof one)
    {
        LOG_ERROR("EventLoop::wakeup() writes %d bytes instead of 8",(int)n );
    }
}

 // 执行回调
void EventLoop::doPendingFunctors()
{
    // 之所以定义一个局部的vector 是为了防止单个线程处理事件的事件过长，且不断有 cb 注册
    std::vector<Functor> functors;
    callingPendingFunctors_ = true;
    {
        std::unique_lock<std::mutex> lk(mutex_);
        functors.swap(pendingFunctors_);
    }
    for(const Functor& func : functors)
    {
        func();
    }
    callingPendingFunctors_ = false;
}