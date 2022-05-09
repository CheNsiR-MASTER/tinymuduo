#pragma once

#include "noncopyable.h"

#include <functional>
#include <string>
#include <vector>
#include <memory>
#include <strings.h>

class EventLoop;
class EventLoopThread;

class EventLoopThreadPool : noncopyable
{
public:
    using ThreadInitCallback = std::function<void(EventLoop*)>;

    EventLoopThreadPool(EventLoop* baseloop, const std::string& nameArg = std::string());
    ~EventLoopThreadPool();

    void setThreadNum(int numThread) { numThreads_ = numThread; }
    void start(const ThreadInitCallback& cb = ThreadInitCallback());

    // 在多个线程中，默认以轮询的方式寻找下一个 eventloop
    EventLoop* getNextLoop();

    std::vector<EventLoop*> getAllLoop();
    bool started() { return started_; }
    std::string name() { return name_; }

private:
    EventLoop* baseloop_;
    std::string name_;
    bool started_;
    int numThreads_;
    int next_;
    std::vector<std::unique_ptr<EventLoopThread>> threads_;
    std::vector<EventLoop*> loops_;
};