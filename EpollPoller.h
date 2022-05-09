#pragma once

#include "Poller.h"
#include "Eventloop.h"
#include "Logger.h"

#include <sys/epoll.h>

struct epoll_event;

class EpollPoller : public Poller
{
public:
    EpollPoller(EventLoop* loop);
    ~EpollPoller() override;

    Timestamp poll(int timeoutMs, ChannelList* activeChannels) override;
    void updateChannel(Channel* channel) override;
    void removeChannel(Channel* channel) override;

private:
// muduo库中，eventList 的底层的大小为 16
    static const int kInitEpolleventListSize = 16;
    
    void fillActiveChannels(int numEvents, ChannelList* activeChannels) const;
    void update(int operation, Channel* channel);
    using EventList = std::vector<struct epoll_event> ;

    int epollfd_;
    EventList events_;
};