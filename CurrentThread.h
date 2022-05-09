#pragma once

#include <unistd.h>
#include <sys/syscall.h> 

namespace CurrentThread
{
    extern __thread int t_cachedTid;

    void cacheTid();

    inline int tid()
    {
        // __builtin_expect 是 gcc提供的宏
        // __builtin_expect(exp, 1) 表示 exp表达式很可能为真
        // __builtin_expect(exp, 0) 表示 exp表达式很可能为假
        if(__builtin_expect(t_cachedTid == 0,0))
        {
            cacheTid();
        }
        return t_cachedTid;
    }
} // namespace CurrentThread
