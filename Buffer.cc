#include "Buffer.h"

#include <unistd.h>
#include <sys/uio.h>
// 封装系统调用的 readv
ssize_t Buffer::readFd(int fd, int* saveinfo)
{
    // 64k
    char extraBuf[65536] = {0};

    struct iovec vec[2];

    size_t writeable = writeableBytes();
    vec[0].iov_base = begin() + writerIndex_;
    vec[0].iov_len = writeable;

    vec[1].iov_base = extraBuf;
    vec[1].iov_len = sizeof extraBuf;

    int iovcnt = (writeable < sizeof extraBuf) ? 2 : 1;
    const int n = readv(fd, vec, iovcnt);

    if(n < 0)
    {
        *saveinfo = errno;
    }
    else if(n <= writeable)
    {
        writerIndex_ += n;
    }
    else
    {
        writerIndex_ = buffer_.size();
        append(extraBuf, n - writeable);
    }
    return n;
}

// 封装系统调用的 write
ssize_t Buffer::writeFd(int fd, int* saveinfo)
{
    int n = ::write(fd, peek() ,readableBytes());
    if(n < 0)
    {
        *saveinfo = errno;
    }
    return n;
}