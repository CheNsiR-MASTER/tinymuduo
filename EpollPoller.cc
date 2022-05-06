#include "EpollPoller.h"

const int kNew = -1;
const int kAdded = 1;
const int kDeleted = 2;

EpollPoller::EpollPoller(EventLoop* loop)
    :Poller(loop), // 调用基类构造函数来初始化从基类继承得来得资源
    epollfd_(::epoll_create1(EPOLL_CLOEXEC)), // 为什么使用epoll_create1()
    // 使用 EPOLL_CLOSEXEC flag初始化，构造子进程是就不会关闭父进程中的资源
    events_(kInitEpolleventListSize)
{
    if(epollfd_ < 0)
    {
        LOG_FATAL("Epoll create error \n");
    }
}


EpollPoller::~EpollPoller()
{
    ::close(epollfd_);
}

// poll 封装了 epoll_wait()
Timestamp EpollPoller::poll(int timeoutMs, ChannelList* activeChannels)
{
    int numEvents = epoll_wait(epollfd_,&*events_.begin(),
            static_cast<int>(events_.size()),timeoutMs);
    
    int saveErrno = errno;
    Timestamp now(time(NULL));
    if(numEvents > 0)
    {
        fillActiveChannels(numEvents,activeChannels);
        if(static_cast<size_t>(events_.size() == numEvents))
        {
            events_.resize(2 * numEvents);
        }
    }
    else if (numEvents == 0) {}
    else 
    {
        LOG_ERROR("poll error %s \n" , __FUNCTION__);
    }
    return now;
}


// updateChannel 和 removeChannel 封装了 epoll_ctl
void EpollPoller::updateChannel(Channel* channel)
{
    const int index = channel->index();
    if(index == kNew || index == kDeleted)
    {
        if(index == kNew)
        {
            channels_[channel->fd()] = channel;
        }
        else {}// index == kDelete
        channel->set_index(kAdded);
        update(EPOLL_CTL_ADD,channel);
    }
    else
    {
        int fd = channel->fd();
        if(channel->isNoneEvent())
        {
            // 如果不存在
            // 且channel->index() == kAdded
            if(channel->index() == kAdded)
            {
                // 将index 设置为 kDelete
                channel->set_index(kDeleted);
                update(EPOLL_CTL_DEL,channel);
            }
            else
            {
                // 否则就将状态设置为 modify
                update(EPOLL_CTL_MOD, channel);
            }
        }
    }
}

void EpollPoller::removeChannel(Channel* channel)
{
    int fd = channel->fd();
    const int index = channel->index();

    channels_.erase(fd);

    if(index == kAdded)
    {
        update(EPOLL_CTL_DEL,channel);
    }
    channel->set_index(kNew);
}

void EpollPoller::fillActiveChannels(int numEvents, ChannelList* activeChannels) const
{
    for(int i = 0; i < numEvents; ++i)
    {
        Channel* channel = static_cast<Channel*> (events_[i].data.ptr);

        channel->set_revents(events_[i].events);
        activeChannels->push_back(channel);
    }
}


void EpollPoller::update(int operation, Channel* channel)
{
    struct epoll_event event;
    bzero(&event,sizeof event);
    event.events = channel->events();
    event.data.fd = channel->fd();
    event.data.ptr = channel;

    if(epoll_ctl(epollfd_, operation, event.data.fd, &event) < 0)
    {
        if(channel->index() == kDeleted)
        {
            LOG_ERROR("update error \n");
        }
        else
        {
            LOG_FATAL("update fatal error \n");
        }
    }
}