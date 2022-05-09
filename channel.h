#pragma once

#include "noncopyable.h"
#include "Timestamp.h"
#include "Eventloop.h"

#include <functional>
#include <memory>

class EventLoop;
// Channel 理解为通道，封装了 Sockfd 和 其感兴趣的 event，如 EPOLLIN EPOLLOUT
class Channel : noncopyable
{
public:
    // 定义回调函数
    using EventCallback = std::function<void()>;
    using ReadEventCallback = std::function<void(Timestamp)>;

    Channel(EventLoop* loop, int fd);
    ~Channel();

    // 成员函数
    void HandleEvent(Timestamp receiveTime);
    void setReadCallback(ReadEventCallback cb)
    { readCallback_ = std::move(cb); }
    void setWriteCallback(EventCallback cb)
    { writeCallback_ = std::move(cb); }
    void setCloseCallback(EventCallback cb)
    { closeCallback_ = std::move(cb); }
    void setErrorCallback(EventCallback cb)
    { errorCallback_ = std::move(cb); }

    // 使 weakptr 升级为 sharedptr
    void tie(const std::shared_ptr<void> &);

    int fd() const { return fd_; }
    int events() const { return events_; }
    int set_revents(int revt) { revents_ = revt; }

    // 改变event的状态
    void enableReading() { events_ |= kReadEvents; update(); }
    void disableReading() { events_ &= ~kReadEvents; update(); }
    void enableWritting() { events_ |= kWriteEvents; update(); }
    void disableWritting() { events_ &= ~kWriteEvents; update(); }

    void disableAll() { events_ |= kNoneEvents; update(); }
    // 判断 events 的状态
    bool isNoneEvent() const { return events_ == kNoneEvents; }
    bool isReadint() const { return events_ & kReadEvents; }
    bool isWrtting() const { return events_ & kWriteEvents; }

    // epoll 抽象类使用的成员函数
    int index() { return index_; }
    void set_index(int idx) { index_ = idx; }

    // 获取 loop
    EventLoop* ownerLooper() { return loop_; }

    // 将该 channel 从 channelList移除出去
    void remove();

private:
    void update();

    void handleEventWithGuard(Timestamp receiveTime);
    static const int kNoneEvents;
    static const int kReadEvents;
    static const int kWriteEvents;

    EventLoop* loop_;
    const int fd_;
    int events_;
    int revents_;
    int index_;
    
    std::weak_ptr<void> tie_;
    bool tied_;
    bool eventHandling_;
    bool addedToLoop_;

    // 定义回调的类型
    ReadEventCallback readCallback_;
    EventCallback writeCallback_;
    EventCallback closeCallback_;
    EventCallback errorCallback_;
};