#pragma once

#include "noncopyable.h"
#include "Timestamp.h"
#include "CurrentThread.h"
#include "channel.h"
#include "Poller.h"
#include "Logger.h"

#include <functional>
#include <vector>
#include <atomic>
#include <memory>
#include <mutex>
#include <sys/eventfd.h>

// 事件循环类，主要包含了两个大模块 Channel 和 Poller (epoll 的抽象类)
class EventLoop : noncopyable
{
public:
    using Functor = std::function<void()>;

    EventLoop();
    ~EventLoop();

    // 开启事件循环
    void loop();
    // 退出事件循环
    void quit();

    Timestamp pollReturnTime() const { return pollReturnTime_; }

    // 在当前loop中执行 cb
    void runInLoop(Functor cb);
    // 将cb放入队列中，唤醒loop所在的线程，执行cb
    void queueInLoop(Functor cb);
    // EventLoop 中的 poller方法
    void updateChannel(Channel* channel);
    void removeChannel(Channel* channel);
    
    bool hasChannel(Channel* channel);
    // 判断loop是否在自己的线程中
    bool isInLoopThread() const { return threadId_ == CurrentThread::tid(); }
private:
    void handleRead(); // Wake up
    void doPendingFunctors(); // 执行回调
    using ChannelList = std::vector<Channel*>;

    std::atomic_bool looping_; // 原子操作，通过CAS实现
    std::atomic_bool quit_;    // 标识退出 loop循环
    std::atomic_bool callingPendingFunctors_; // 标识当前的loop是否有需要执行的回调
    const pid_t threadId_;     // 标识当前线程的ID

    Timestamp pollReturnTime_; // poller返回发生事件 channels的时间点
    std::unique_ptr<Poller> poller_;

    /**
     * @brief 这个 是muduo库的核心，通过wakeupFd_ 主Reactor 可以轮询算法唤醒subReactor
     * libevent 是通过旧的方法 socketpair 
     * wakeupFd_ 是通过 linux 内核提供的函数 eventfd() 创建的
     */
    int wakeupFd_;
    std::unique_ptr<Channel> wakeupChannel_;

    ChannelList activeChannels_;
    Channel* currentActiveChannels_;

    std::vector<Functor> pendingFunctors_; // 存储 loop需要执行的所有回调操作
    std::mutex mutex_; // 保证 pendingFunctor 的线程安全
};