#include "CurrentThread.h"

namespace CurrentThread
{
    __thread int t_cachedTid = 0; 
    void cacheTid()
    {
        if(cacheTid == 0)
        {
            // 通过系统调用 得到当前线程的值
            t_cachedTid = static_cast<pid_t>(::syscall(SYS_gettid));
        }
    }
} // namespace CurrentThread
