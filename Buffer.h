#pragma once

#include <vector>
#include <string>

///
/// @code
/// +-------------------+------------------+------------------+
/// | prependable bytes |  readable bytes  |  writable bytes  |
/// |                   |     (CONTENT)    |                  |
/// +-------------------+------------------+------------------+
/// |                   |                  |                  |
/// 0      <=      readerIndex   <=   writerIndex    <=     size
/// 8个字节的 perpendable    
class Buffer
{
public:
    static const size_t kCheapPrepend = 8;
    static const size_t kInitialSize = 1024;

    explicit Buffer(size_t initialSize = kInitialSize)
        :buffer_(kCheapPrepend + kInitialSize),
        readerIndex_(kCheapPrepend),
        writerIndex_(kCheapPrepend)
    { }

    size_t readableBytes() const 
    {
        return writerIndex_ - readerIndex_;
    }

    size_t writeableBytes() const
    {
        return buffer_.size() - writerIndex_;
    }

    size_t prependableBytes() const
    {
        return readerIndex_;
    }
    // 返回缓冲区中可读数据的起始地址
    const char* peek()
    {
        return begin() + readerIndex_;
    }

    // onMessage string <- Buffer
    void retrieve(size_t len)
    {
        if(len < readableBytes())
        {
            readerIndex_ += len; // 读取了len长度的数据
        }
        else
        {
            retrieveAll();
        }
    }

    void retrieveAll()
    {
        readerIndex_ = writerIndex_;
        writerIndex_ = kCheapPrepend;
    }

    // 把 onMessage 上报的buffer数据，转成string类型的数据返回
    std::string retrieveAllAsString()
    {
        return retrieveAsString(readableBytes());
    }

    std::string retrieveAsString(size_t len)
    {
        std::string result(peek(),len);
        retrieve(len); // 对缓冲区进行复位操作
        return result;
    }

    void ensureWriteableBytes(size_t len)
    {
        if(writeableBytes() < len)
        {
            makeSpace(len);
        }
    }

    // 把 [data, data + len] 的数据，追加到buffer中
    void append(char* data, size_t len)
    {
        ensureWriteableBytes(len);
        std::copy(data, data + len, beginWrite());
        writerIndex_ += len;
    }
    // 从 fd上读取数据
    ssize_t readFd(int fd, int* saveinfo);
    ssize_t writeFd(int fd, int* saveinfo);
private:
    char* begin()
    {
        return &*buffer_.begin(); // vector 数组首个元素的地址，即数组首地址
    }

    char* beginWrite()
    {
        return begin() + writerIndex_;
    }
    void makeSpace(size_t len)
    {
        if(writeableBytes() + prependableBytes() < len + kCheapPrepend )
        {
            buffer_.resize(len + kCheapPrepend);
        }
        else
        {
            size_t readablesize = readableBytes();
            std::copy(begin() + prependableBytes(),
                begin() + writeableBytes(),
                begin() + kCheapPrepend);
            readerIndex_ = kCheapPrepend;
            writerIndex_ = readablesize + readerIndex_;
        }
    }
    std::vector<char> buffer_;
    size_t readerIndex_;
    size_t writerIndex_;
};