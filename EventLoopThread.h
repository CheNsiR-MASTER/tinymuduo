#pragma once

#include "noncopyable.h"
#include "Eventloop.h"
#include "Thread.h"

#include <functional>
#include <string>
#include <mutex>
#include <condition_variable>

class EventLoopThread : noncopyable
{
public:
    using ThreadInitCallback = std::function<void(EventLoop*)>;

    EventLoopThread(const ThreadInitCallback& cb = ThreadInitCallback(),
            const std::string& name = std::string());
    ~EventLoopThread();

    EventLoop* startloop();
private:
    void threadFunc();
    EventLoop* loop_;
    bool existing_;
    Thread thread_;
    std::mutex mutex_;
    std::condition_variable cond_;
    ThreadInitCallback callback_;
};