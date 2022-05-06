#pragma once

#include "noncopyable.h"
#include "Timestamp.h"
#include "channel.h"

#include <vector>
#include <unordered_map>

class EventLoop;
// muduo库中多路事件分发器的核心 IO复用模块
class Poller : noncopyable
{
public:
    using ChannelList = std::vector<Channel*>;

    Poller(EventLoop* loop);
    virtual ~Poller() = 0;

    virtual Timestamp poll(int timeoutMs, ChannelList* activeChannels) = 0;
    virtual void updateChannel(Channel* channel) = 0;
    virtual void removeChannel(Channel* channel) = 0;

    // 判断channel 是否在当前poller 当中
    bool hasChannel(Channel* channel) const ;

    // EventLoop 可以通过该接口获取默认的IO复用的具体实现
    static Poller* newDefaultPoller(EventLoop* loop);
protected:
    using ChannelMap = std::unordered_map<int, Channel*>;
    ChannelMap channels_;
private:
    EventLoop* ownerloop_;
};