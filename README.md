# tinymuduo

## 使用方法

```
在根目录下                   ./autobuild.sh
就可以将编译的动态库文件添加到  /usr/lib
将头文件添加到               /usr/include/tinymuduo
```

## 模块解析

### forward ⇒ std::bind

```
因为，采用了 oop编程，所以使用了大量的bind 绑定 成员函数

1. 绑定的可调用对象无参数
		std::bind(可调用对象名，可调用对象的地址);
2. 绑定的可调用对象有参数
		std::bind(可调用对象名, 可调用对象的地址, 有几个参数就需要几个参数占位符)
```



### EventLoop、Channel 和 Poller

```CPP
对于每一个 fd(文件描述符)都需要创建一个 Channel，通过channel管理fd上发生事件的状态，channel上注册了fd感兴趣的事件，以及Poller返回的事件
(管理的方式 => 通过下发给Poller => Poller处理Channel上注册的事件)
--------------------------------------------------------
为什么需要下发给Poller处理？
	poller是对epoll_wait，epoll_ctl，epoll_create等epollApi的封装，所以具体的修改是在poller发生的，但是Channel和Poller之间不具备直接通信的手段
--------------------------------------------------------
如何进行通信？
通过EventLoop
如： channel 需要修改事件属性
channel::update()  =>  loop->updateChannel()
=> poller_->updateChannel();

在 poller_->updateChannel() 真正的对 事件状态进行修改
(例 ：修改了 EPOLL_ADD_CTL)

```

#### EventLoop中的 loop() 的调用逻辑:

```CPP
// EventLoop::loop() 的流程
EventLoop::loop() 
    => poller.poll() // poll() 本质上调用了一次 epoll_wait()
    		=> Poller::fillActiveChannel()
    		=> channel_->setRevents()
		// channel监听到Poller返回的事件;

	=> channel_->handleEvent()
		=>  Channel::handleEventWithGuard(receiveTime); // 处理具体的事件
	=> EventLoop::doPendingFunctors()
```



### Thread、EventLoopThread、EventLoopThreadPool

1. ### Thread

   ```
   1. 主要成员函数：
   		start();   =>   开启一个新的线程，执行线程中记录的回调函数
    		join();    =>   封装了 <thread> 的 join  => 回调函数执行完后，分离线程
   		tid();     =>   获取 tid_  =>  实际的 tid_ 的来源：
   										// 在CurrentThread.h 中 封装了系统调用
   						Thread::start()  =>   tid_ = CurrentThread::tid();
   										CurrentThread::tid()  =>   CurrentThread::cacheTid()  
   						cacheTid()   =>	  t_cacheTid_ = static_cast<pid_t>(::syscall(SYS_gettid))
   										从系统调用中得到当前线程的tid
   --------------------------------------------------------
   2. 主要成员变量：
   		std::shared_ptr<std::thread> thread_;
   		// 之所以将 thread 封装进一个智能指针对象，原因是:
   		//  thread() 对象构造出来的时候，就创建了一个新的线程，并且进入了线程执行了回调
   		//  这与预期逻辑不符，所以需要封装进一个智能指针，在执行 start()的时候，对线程进行创建
   	start() 成员函数实现的细节:
   					在start()中，使用了信号量，用于确保线程一定创建完成 =>
   					sem_t sem;
   					sem_init(&sem,false,0);
   		在新线程中执行 => sem_post(&sem); 然后执行回调
   		在新线程外   => sem_wait(&sem);   确保新线程能够确保创建，能够得到 tid
   ```

2. ### EventLoopThread

   ```
   1. 主要函数:
   		构造函数
   		EventLoop* startLoop();
   		void threadFunc();
   
   2. 主要成员变量:
   		EventLoop* loop_;
   		std::mutex mutex_;               //  mutex 和 condition_variable 
   		std::condition_variable cond_;  //   为了确保多个线程间的线程安全
   																		// 之所以要确保线程安全，是因为 可能有多个 subLoop同时执行cb
   		Thread thread_;  =>  EventLoopThread 中包含 Thread对象，通过Thread开启新线程
   
   --------------------------------------------------------------------------
   
   EventLoopThread 的构造方法:
   EventLoopThread::EventLoopThread(const ThreadInitCallback &cb, 
           const std::string &name)
           : loop_(nullptr)
           , exiting_(false)
           , thread_(std::bind(&EventLoopThread::threadFunc, this), name)
           , mutex_()
           , cond_()
           , callback_(cb) { }
   通过一个回调和线程名称构造  =>  thread_ 通过 threadFunc() 初始化
   
   --------------------------------------------------------------------------
   
   threadFunc() : // 这个方法作为新线程的回调函数，运行在新线程中
   			创建一个局部的 EventLoop* loop;  =>  one loop per thread思想
   			threadFunc()  => if(callback_) => callback_(&loop)
   			callback_是什么  => using ThreadInitCallback = std::function<void(EventLoop*)>;
   												   => ThreadInitCallback callback_;
   			callback_是一个接受了 EventLoop* 对象的回调函数;
   			因为 threadFunc() 是一个创建新线程的回调函数 => 所以这个 callback_的实际调用是在新线程中
   																										=> 具体是在 Thread::start() 中
   			为了确保线程安全 =>  需要使用了互斥锁和条件变量通知
   	=> 开启loop.loop()  => poller_.poll() => channel_->handleEvent() => doPendingFunctor()
   
   *** 注意 : callback_ 和 doPendingFunctor
   			callback_ 是接受了一个EventLoop对象的回调函数
   			doPendingFunctor: 是遍历 vector<Functor>  => 处理所有EventLoop中的回调函数
   具体有:  任何调用 runInLoop  和  queenInLoop  的地方
   			1. TcpConnection::send()  => 绑定了 TcpConnection::sendInLoop() 的回调
   			2. TcpConnection::shutdown() => 绑定了 TcpConnection::shutdownInLoop() 的回调
   			3. TcpServer::~TcpServer()  =>  绑定了 TcpConnection::connectionDestroy()的回调
   			4. TcpServer::newConnection() => 绑定了 TcpConnection::connectionEstablish()的回调
   			
   			5. TcpServer::start()  =>  绑定了 Acceptor::listen() 的回调
   具体分析  => TcpServer &  TcpConnection
   
   --------------------------------------------------------------------------
   EventLoopThread::startLoop():
   		首先调用了 thread_.start();  => 开启thread的线程  => 调用 callback_
   		创建一个 空的 EventLoop* 对象 => 为了确保线程安全  => 使用了互斥锁和条件变量
   		等待 loop_对象在 threadFunc()中  => loop_ = &loop;  => return loop_;
   		loop_ 对象 => EventLoopThreadPool::start() => loops_.push_back(t->startLoop());
   ```

   3. ### EventLoopThreadPool

   ```
   1. 主要成员函数：
   		构造函数
   		start();
   		getNextLoop();  // 如果 setThreadNum(n) => 分配了n个subloop  => baseLoop_ 默认以轮询
   										// 的方式去唤醒 subLoop();
   		getAllLoops();
   
   2. 主要成员变量:
   		EventLoop* baseLoop_;  => mainLoop  => 如果没有setThreadNum() subLoop和baseLoop在同一线程
   		std::vector<std::unique_ptr<EventLoopThread>> threads_; 
   		// Pool 管理了所有的 EventLoopThread对象
   		std::vector<EventLoop*> loops_;
   		// Pool 通过管理所有的 EventLoopThread 对象，调用EventLoopThread对象的 loop()
   		// 来管理所有的 loop对象
   
   --------------------------------------------------------------------------
   void EventLoopThreadPool::start(const ThreadInitCallback &cb);
   分析:
   		1. 主要逻辑
   		根据 numThreads_ 成员变量 => 遍历  => 创建EventLoopThread对象 => 
   			将 EventLoopThread 对象封装为 智能指针对象 => 存进 vector<> threads_ => 统一管理
   		=> 调用 EventLoopThread 对象的 loop() 方法 => 存进 vector<> loops_ => 统一管理
   		=> 可能有没有设置线程数量的逻辑 => 调用 baseLoop的callback
   
   	EventLoopThreadPool::start() 的调用逻辑:
   
   	TcpServer::start() => threadPool_->start(threadInitCallback_); // 启动底层的loop线程池
   	业务逻辑封装的 Server类 => Server::start() => TcpServer::start()
   ```

   

## Socket、Acceptor

### forward  ⇒  InetAddress

```cpp
InetAddress: 封装了 Socket地址类型
		1. 主要成员函数
		构造函数 => 提供了两种  => 根据 ip, port 创建
													=> 根据 sockaddr_in 创建
		toIp()  => 获得 ip地址
		toPort() => 获得端口
		toIpPort() => 获得 Ip:Port 格式的 ip和port

		getSockAddr() => 获得 sockaddr_in
		setSockAddr() => 设置 sockaddr_in

	2. 主要成员变量
		sockaddr_in

--------------------------------------------------------------------------

getSockAddr() 在何处被调用 => 用途是什么？
调用逻辑链：
	TcpServer的构造函数的初始化列表中 => Acceptor的构造函数被调用
		TcpServer::TcpServer(...):...,acceptor_(
							new Acceptor(loop, listenAddr, option = kReusePort)			
						),... { ... }
=>  Acceptor::Acceptor()  =>  Socket()::bindAddress(listenAddr)
=>  ::bind(sockfd_, (sockaddr*)localAddr.getSockAddr(), sizeof(sockaddr_in));

***区分: 这个 ::bind() 和 std::bind() 的区别：
::bind() => 在  #include <sys/types.h> #include <sys/socket.h> 中
在 socket 编程中用作绑定端口号
int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);

--------------------------------------------------------------------------

setSockAddr() 的调用逻辑链:
	TcpServer的构造函数的初始化列表中 => Acceptor的构造函数被调用
	TcpServer::TcpServer(...):...,acceptor_(
							new Acceptor(loop, listenAddr, option = kReusePort)			
						),... { ... }     =>    Acceptor::Acceptor() 中
	=> acceptChannel_.setReadCallback(std::bind(&Acceptor::handleRead, this));
	=> Acceptor::handleRead() => int connfd = acceptSocket_.accept(&peerAddr);
	=> 调用 Socket::accept() 
	=> int connfd = acceptSocket_.accept(&peerAddr);

--------------------------------------------------------------------------
总结:
调用都是从 TcpServer中 => 构造Acceptor => Socket() => 调用相应的成员函数
```

所以结构上：

```
TcpServer包含一个 Acceptor对象    —>    Acceptor包含一个 Socker对象
```

### Socket模块

```cpp
主要给sockfd封装了几个成员函数  提供给  Acceptor
1. bindAddress
2. accept
3. listen
4. fd
5. shutdownOnWrite

总结： Socket模块就是封装了 Linux内核中的socket API
***注意： 
Socket::accept() 的调用 => 是在 Acceptor 中的 handleRead() => 在TcpServer初始化中

Socket::listen() 的调用 => 是在 TcpServer::start() 中  =>
	loop_->runInLoop(std::bind(&Acceptor::listen, acceptor_.get()))
也就是说,在启动 TcpServer.start() 后， 底层 main loop 就绑定了 Acceptor 的 listen回调,
runInLoop() 会唤醒 某个 subLoop() => 调用底层的Channel =>通过 loop => 调用 poller的update
 => 更改 event的状态 

=> 在监听的 listenfd 有事件发生后，就会执行 Acceptor的 handleRead() => handleRead()就会执行
用户注册的 newConnectionCallback()
```

### Acceptor模块

```cpp
Acceptor 在 main loop中，负责监听新连接的建立 => 分发给 subloop (分发给 subLoop 是在
																								**TcpServer::newConnection()中完成
							具体 => EventLoop *ioLoop = threadPool_->getNextLoop(); 执行轮询算法** )

Acceptor的主要成员变量：
		1. EventLoop* loop_; 就是用户定义的loop => mainloop
		2. Socket acceptSocket_; 
		3. Channel acceptChannel_;
		4. NewConnectionCallback newConnectionCallback_;
// using NewConnectionCallback = std::function<void(int sockfd, const InetAddress&)>;

主要成员函数:
		1. void handleRead();  => 执行 newConnectionCallback_()
		2. void setNewConnectionCallback() => 设置用户定义的 onConnection();

***重要点：
		Acceptor对象 => 在TcpServer构造中被初始化
		setNewConnectionCallback() => 在TcpServer初始化中被初始化
```



## TcpConnection、TcpServer

### TcpConnection

在muduo库中 TcpConnection 被 智能指针管理

```cpp
using TcpConnectionPtr = std::shared_ptr<TcpConnection>;
```

TcpConnection 封装了：

```cpp
EventLoop* 对象
使用智能指针管理了:  =>  和 Acceptor 类似 => Acceptor对应mainloop 
																				=> TcpConnection对应subloop
		=> Socket对象
		=> Channel对象   
接受缓冲区 和 输出缓冲区:
		=> inputBuffer_
		=> outputBuffer_
封装了5中回调函数:
		=> 有新连接时的回调             ConnectionCallback
		=> 有读写消息时的回调           MessageCallback
		=> 消息发送完成之后的回调        WriteOnCompleteCallback
		=> 为了防止消息发送过快的回调    HighWaterMarkCallback
		=> 关闭连接的回调               CloseCallback
封装了本地连接地址和调用者地址
		=> localAddr_
		=> peerAddr_

--------------------------------------------------------------------------
主要的成员函数：
1. send()  => 底层调用 sendInLoop()  =>  将待发送数据写入缓冲区
	主要逻辑：
				=>  首先判断 connect的状态  => 如果是 disConnected(调用过shutdown)就返回error
				=>  如果channel是第一次写数据，且缓冲区内无带发送数据
						=> 就将数据写入 channel->fd()  => 如果全部写完 => 执行 写回调
				=>  如果数据没有全部发送出去,判断是否达到高水位回调的条件 =>  执行高水位回调
						=>  最后 将内容放到 outputBuffer_中   =>  注册 channel 的写事件
																								 => 目的是 使 poller 能够向 channel 通知
																		           (此时数据还没写完) EPOLLOUT事件
																								=> 使listenfd上有写事件发生，能够执行
																										handleWrite => 继续在buffer上写数据

2. handleRead() :  如果listenfd上有读事件发生  =>  从buffer上读取数据
3. handleWrite() : 如果listenfd上有写事件发生  =>  从buffer上写数据
4. handleClose() : poller 修改了EPOLL的状态 => channel 执行closecallback => handleClose()
```

### TcpConnection 调用逻辑链:

```cpp
TcpConnection 对象的创建  =>  
				// 有一个新的客户端的连接，acceptor会执行这个回调操作
				TcpServer::newConnection(int sockfd, const InetAddress &peerAddr)
				=> TcpConnectionPtr conn(new TcpConnection((
                            ioLoop,
                            connName,
                            sockfd,   // Socket Channel
                            localAddr,
                            peerAddr));
				=> 创建一个 TcpConnectionPtr 对象 conn

创建 conn的目的 => 首先 添加到 unordered_map<string, TcpConnectionPtr> connections_
		    =>  connections_[connName] = conn;
				=>  之后给  conn对象设置 4个回调
						=> connectionCallback_   
						=> messageCallback_
						=> writeCompleteCallback_
						=> closeCallback_
```

### TcpConnectionPtr 的使用

```cpp
# testserver.cc

// 连接建立或者断开的回调
    void onConnection(const TcpConnectionPtr &conn)
    {
        if (conn->connected())
        {
            LOG_INFO("Connection UP : %s", conn->peerAddress().toIpPort().c_str());
        }
        else
        {
            LOG_INFO("Connection DOWN : %s", conn->peerAddress().toIpPort().c_str());
        }
    }

    // 可读写事件回调
    void onMessage(const TcpConnectionPtr &conn,
                Buffer *buf,
                Timestamp time)
    {
        std::string msg = buf->retrieveAllAsString();
        conn->send(msg);
        conn->shutdown(); // 写端   EPOLLHUP =》 closeCallback_
    }
```

几种回调都是在何时触发：

```cpp
1. connectionCallback:

TcpServer::TcpServer()  =>  在构造函数中调用  => 
		acceptor_->setNewConnectionCallback(std::bind(&TcpServer::newConnection, this, 
        std::placeholders::_1, std::placeholders::_2));
	=>  通过绑定 TcpServer::newConnection   => 
					 ioLoop->runInLoop(std::bind(&TcpConnection::connectEstablished, conn));
  =>  绑定 TcpConnection::connectEstablished   => connectionEstablished中执行 =>
		connectionCallback回调

在析构函数 和 TcpServer::removeConnectionInLoop() 中，loop->runInLoop()都绑定了
TcpConnectionDestroy() => 在执行了 connectionCallback后  => 执行 channel->remove()
=>  将 channel 从 poller中删除

在TcpConnection::handleRead()中，如果 readFd返回的长度为0  => TcpConnection::handleClose()
=>  执行连接关闭的回调  connectionCallback()

2. writeComplete
	在 业务代码中（onMessage 回调） =>  调用 conn->send(msg)  =>  TcpConnection::sendInLoop()
=>  如果channel是第一次写数据，且缓冲区内无待发送数据
=>  loop_->queueInLoop(std::bind(writeCompleteCallback_, shared_from_this()))

如果有写事件发生 =>  TcpConnection::handleWrite()
=>  loop_->queueInLoop(std::bind(writeCompleteCallback_, shared_from_this()))
```

### TcpServer

```cpp
1. 构造函数
	TcpServer::TcpServer(EventLoop *loop,
                const InetAddress &listenAddr,
                const std::string &nameArg,
                Option option)
                : loop_(CheckLoopNotNull(loop))
                , ipPort_(listenAddr.toIpPort())
                , name_(nameArg)
                , acceptor_(new Acceptor(loop, listenAddr, option == kReusePort))
                , threadPool_(new EventLoopThreadPool(loop, name_))
                , connectionCallback_()
                , messageCallback_()
                , nextConnId_(1)
                , started_(0)
{
    // 当有先用户连接时，会执行TcpServer::newConnection回调
    acceptor_->setNewConnectionCallback(std::bind(&TcpServer::newConnection, this, 
        std::placeholders::_1, std::placeholders::_2));
}

在创建一个 TcpServer的时候  => 创建一个 Acceptor  =>  给Acceptor设置一个接受新连接的回调

TcpServer::newConnection()  =>  通过轮询算法，找到一个 subLoop()
				=> 设置 新建一个 TcpConnectionPtr  =>  绑定 连接、读、写、关闭连接回调
				=> subLoop 绑定TcpConnection::connectionEstablished 回调
				=> 将 weak_ptr 升级为shared_ptr => 向poller 注册 channel 的读事件
				=> 执行新连接的回调 ( 这个回调函数 是用户提供的 onConnection )

--------------------------------------------------------------------------

2. TcpServer::start()
	主要逻辑  =>  开启定义的线程数量的线程池  =>  在当前线程中执行 Acceptor::listen 的回调
细节处： 使用 原子类型 start_ 确保线程只会创建一次
```


