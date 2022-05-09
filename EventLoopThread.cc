#include "EventLoopThread.h"

EventLoopThread::EventLoopThread(const ThreadInitCallback& cb,
        const std::string& name)
    :loop_(nullptr),
    existing_(false),
    thread_(std::bind(&EventLoopThread::threadFunc,this),name),
    mutex_(),
    cond_(),
    callback_(cb)
{
    
}

EventLoopThread::~EventLoopThread()
{
    existing_ = true;
    if(loop_ != nullptr)
    {
        loop_->quit();
        thread_.join();
    }
}

EventLoop* EventLoopThread::startloop()
{
    thread_.start(); // 启动底层的新线程
    EventLoop* loop = nullptr;
    {
        std::unique_lock<std::mutex> lk(mutex_);
        while(loop_ == nullptr)
        {
            cond_.wait(lk);
        }
        loop = loop_;
    }
    return loop;
}

void EventLoopThread::threadFunc()
{
    // 创建一个独立的loop 和 上面的线程一一对应
    EventLoop loop;
    if(callback_)
    {
        callback_(&loop);
    }
    {
        std::unique_lock<std::mutex> lk(mutex_);
        loop_ = &loop;
        cond_.notify_one();
    }
    loop_->loop();
    // 退出loop 需要释放loop_的资源        
    std::unique_lock<std::mutex> lk(mutex_);
    loop_ = nullptr;
}