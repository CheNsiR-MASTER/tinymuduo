# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/admin/linux/tinyMuduo

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/admin/linux/tinyMuduo/build

# Include any dependencies generated for this target.
include CMakeFiles/tinymuduo.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/tinymuduo.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/tinymuduo.dir/flags.make

CMakeFiles/tinymuduo.dir/Acceptor.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/Acceptor.o: ../Acceptor.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/tinymuduo.dir/Acceptor.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/Acceptor.o -c /home/admin/linux/tinyMuduo/Acceptor.cc

CMakeFiles/tinymuduo.dir/Acceptor.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/Acceptor.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/Acceptor.cc > CMakeFiles/tinymuduo.dir/Acceptor.i

CMakeFiles/tinymuduo.dir/Acceptor.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/Acceptor.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/Acceptor.cc -o CMakeFiles/tinymuduo.dir/Acceptor.s

CMakeFiles/tinymuduo.dir/Acceptor.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/Acceptor.o.requires

CMakeFiles/tinymuduo.dir/Acceptor.o.provides: CMakeFiles/tinymuduo.dir/Acceptor.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/Acceptor.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/Acceptor.o.provides

CMakeFiles/tinymuduo.dir/Acceptor.o.provides.build: CMakeFiles/tinymuduo.dir/Acceptor.o


CMakeFiles/tinymuduo.dir/Buffer.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/Buffer.o: ../Buffer.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/tinymuduo.dir/Buffer.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/Buffer.o -c /home/admin/linux/tinyMuduo/Buffer.cc

CMakeFiles/tinymuduo.dir/Buffer.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/Buffer.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/Buffer.cc > CMakeFiles/tinymuduo.dir/Buffer.i

CMakeFiles/tinymuduo.dir/Buffer.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/Buffer.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/Buffer.cc -o CMakeFiles/tinymuduo.dir/Buffer.s

CMakeFiles/tinymuduo.dir/Buffer.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/Buffer.o.requires

CMakeFiles/tinymuduo.dir/Buffer.o.provides: CMakeFiles/tinymuduo.dir/Buffer.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/Buffer.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/Buffer.o.provides

CMakeFiles/tinymuduo.dir/Buffer.o.provides.build: CMakeFiles/tinymuduo.dir/Buffer.o


CMakeFiles/tinymuduo.dir/CurrentThread.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/CurrentThread.o: ../CurrentThread.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/tinymuduo.dir/CurrentThread.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/CurrentThread.o -c /home/admin/linux/tinyMuduo/CurrentThread.cc

CMakeFiles/tinymuduo.dir/CurrentThread.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/CurrentThread.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/CurrentThread.cc > CMakeFiles/tinymuduo.dir/CurrentThread.i

CMakeFiles/tinymuduo.dir/CurrentThread.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/CurrentThread.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/CurrentThread.cc -o CMakeFiles/tinymuduo.dir/CurrentThread.s

CMakeFiles/tinymuduo.dir/CurrentThread.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/CurrentThread.o.requires

CMakeFiles/tinymuduo.dir/CurrentThread.o.provides: CMakeFiles/tinymuduo.dir/CurrentThread.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/CurrentThread.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/CurrentThread.o.provides

CMakeFiles/tinymuduo.dir/CurrentThread.o.provides.build: CMakeFiles/tinymuduo.dir/CurrentThread.o


CMakeFiles/tinymuduo.dir/EpollPoller.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/EpollPoller.o: ../EpollPoller.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/tinymuduo.dir/EpollPoller.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/EpollPoller.o -c /home/admin/linux/tinyMuduo/EpollPoller.cc

CMakeFiles/tinymuduo.dir/EpollPoller.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/EpollPoller.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/EpollPoller.cc > CMakeFiles/tinymuduo.dir/EpollPoller.i

CMakeFiles/tinymuduo.dir/EpollPoller.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/EpollPoller.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/EpollPoller.cc -o CMakeFiles/tinymuduo.dir/EpollPoller.s

CMakeFiles/tinymuduo.dir/EpollPoller.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/EpollPoller.o.requires

CMakeFiles/tinymuduo.dir/EpollPoller.o.provides: CMakeFiles/tinymuduo.dir/EpollPoller.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/EpollPoller.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/EpollPoller.o.provides

CMakeFiles/tinymuduo.dir/EpollPoller.o.provides.build: CMakeFiles/tinymuduo.dir/EpollPoller.o


CMakeFiles/tinymuduo.dir/EventLoopThread.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/EventLoopThread.o: ../EventLoopThread.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/tinymuduo.dir/EventLoopThread.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/EventLoopThread.o -c /home/admin/linux/tinyMuduo/EventLoopThread.cc

CMakeFiles/tinymuduo.dir/EventLoopThread.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/EventLoopThread.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/EventLoopThread.cc > CMakeFiles/tinymuduo.dir/EventLoopThread.i

CMakeFiles/tinymuduo.dir/EventLoopThread.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/EventLoopThread.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/EventLoopThread.cc -o CMakeFiles/tinymuduo.dir/EventLoopThread.s

CMakeFiles/tinymuduo.dir/EventLoopThread.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/EventLoopThread.o.requires

CMakeFiles/tinymuduo.dir/EventLoopThread.o.provides: CMakeFiles/tinymuduo.dir/EventLoopThread.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/EventLoopThread.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/EventLoopThread.o.provides

CMakeFiles/tinymuduo.dir/EventLoopThread.o.provides.build: CMakeFiles/tinymuduo.dir/EventLoopThread.o


CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o: ../EventLoopThreadPool.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o -c /home/admin/linux/tinyMuduo/EventLoopThreadPool.cc

CMakeFiles/tinymuduo.dir/EventLoopThreadPool.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/EventLoopThreadPool.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/EventLoopThreadPool.cc > CMakeFiles/tinymuduo.dir/EventLoopThreadPool.i

CMakeFiles/tinymuduo.dir/EventLoopThreadPool.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/EventLoopThreadPool.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/EventLoopThreadPool.cc -o CMakeFiles/tinymuduo.dir/EventLoopThreadPool.s

CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o.requires

CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o.provides: CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o.provides

CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o.provides.build: CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o


CMakeFiles/tinymuduo.dir/Eventloop.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/Eventloop.o: ../Eventloop.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object CMakeFiles/tinymuduo.dir/Eventloop.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/Eventloop.o -c /home/admin/linux/tinyMuduo/Eventloop.cc

CMakeFiles/tinymuduo.dir/Eventloop.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/Eventloop.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/Eventloop.cc > CMakeFiles/tinymuduo.dir/Eventloop.i

CMakeFiles/tinymuduo.dir/Eventloop.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/Eventloop.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/Eventloop.cc -o CMakeFiles/tinymuduo.dir/Eventloop.s

CMakeFiles/tinymuduo.dir/Eventloop.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/Eventloop.o.requires

CMakeFiles/tinymuduo.dir/Eventloop.o.provides: CMakeFiles/tinymuduo.dir/Eventloop.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/Eventloop.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/Eventloop.o.provides

CMakeFiles/tinymuduo.dir/Eventloop.o.provides.build: CMakeFiles/tinymuduo.dir/Eventloop.o


CMakeFiles/tinymuduo.dir/InetAddress.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/InetAddress.o: ../InetAddress.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object CMakeFiles/tinymuduo.dir/InetAddress.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/InetAddress.o -c /home/admin/linux/tinyMuduo/InetAddress.cc

CMakeFiles/tinymuduo.dir/InetAddress.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/InetAddress.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/InetAddress.cc > CMakeFiles/tinymuduo.dir/InetAddress.i

CMakeFiles/tinymuduo.dir/InetAddress.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/InetAddress.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/InetAddress.cc -o CMakeFiles/tinymuduo.dir/InetAddress.s

CMakeFiles/tinymuduo.dir/InetAddress.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/InetAddress.o.requires

CMakeFiles/tinymuduo.dir/InetAddress.o.provides: CMakeFiles/tinymuduo.dir/InetAddress.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/InetAddress.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/InetAddress.o.provides

CMakeFiles/tinymuduo.dir/InetAddress.o.provides.build: CMakeFiles/tinymuduo.dir/InetAddress.o


CMakeFiles/tinymuduo.dir/Logger.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/Logger.o: ../Logger.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object CMakeFiles/tinymuduo.dir/Logger.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/Logger.o -c /home/admin/linux/tinyMuduo/Logger.cc

CMakeFiles/tinymuduo.dir/Logger.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/Logger.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/Logger.cc > CMakeFiles/tinymuduo.dir/Logger.i

CMakeFiles/tinymuduo.dir/Logger.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/Logger.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/Logger.cc -o CMakeFiles/tinymuduo.dir/Logger.s

CMakeFiles/tinymuduo.dir/Logger.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/Logger.o.requires

CMakeFiles/tinymuduo.dir/Logger.o.provides: CMakeFiles/tinymuduo.dir/Logger.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/Logger.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/Logger.o.provides

CMakeFiles/tinymuduo.dir/Logger.o.provides.build: CMakeFiles/tinymuduo.dir/Logger.o


CMakeFiles/tinymuduo.dir/Poller.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/Poller.o: ../Poller.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Building CXX object CMakeFiles/tinymuduo.dir/Poller.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/Poller.o -c /home/admin/linux/tinyMuduo/Poller.cc

CMakeFiles/tinymuduo.dir/Poller.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/Poller.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/Poller.cc > CMakeFiles/tinymuduo.dir/Poller.i

CMakeFiles/tinymuduo.dir/Poller.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/Poller.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/Poller.cc -o CMakeFiles/tinymuduo.dir/Poller.s

CMakeFiles/tinymuduo.dir/Poller.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/Poller.o.requires

CMakeFiles/tinymuduo.dir/Poller.o.provides: CMakeFiles/tinymuduo.dir/Poller.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/Poller.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/Poller.o.provides

CMakeFiles/tinymuduo.dir/Poller.o.provides.build: CMakeFiles/tinymuduo.dir/Poller.o


CMakeFiles/tinymuduo.dir/Socket.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/Socket.o: ../Socket.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_11) "Building CXX object CMakeFiles/tinymuduo.dir/Socket.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/Socket.o -c /home/admin/linux/tinyMuduo/Socket.cc

CMakeFiles/tinymuduo.dir/Socket.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/Socket.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/Socket.cc > CMakeFiles/tinymuduo.dir/Socket.i

CMakeFiles/tinymuduo.dir/Socket.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/Socket.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/Socket.cc -o CMakeFiles/tinymuduo.dir/Socket.s

CMakeFiles/tinymuduo.dir/Socket.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/Socket.o.requires

CMakeFiles/tinymuduo.dir/Socket.o.provides: CMakeFiles/tinymuduo.dir/Socket.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/Socket.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/Socket.o.provides

CMakeFiles/tinymuduo.dir/Socket.o.provides.build: CMakeFiles/tinymuduo.dir/Socket.o


CMakeFiles/tinymuduo.dir/TcpConnection.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/TcpConnection.o: ../TcpConnection.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_12) "Building CXX object CMakeFiles/tinymuduo.dir/TcpConnection.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/TcpConnection.o -c /home/admin/linux/tinyMuduo/TcpConnection.cc

CMakeFiles/tinymuduo.dir/TcpConnection.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/TcpConnection.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/TcpConnection.cc > CMakeFiles/tinymuduo.dir/TcpConnection.i

CMakeFiles/tinymuduo.dir/TcpConnection.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/TcpConnection.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/TcpConnection.cc -o CMakeFiles/tinymuduo.dir/TcpConnection.s

CMakeFiles/tinymuduo.dir/TcpConnection.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/TcpConnection.o.requires

CMakeFiles/tinymuduo.dir/TcpConnection.o.provides: CMakeFiles/tinymuduo.dir/TcpConnection.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/TcpConnection.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/TcpConnection.o.provides

CMakeFiles/tinymuduo.dir/TcpConnection.o.provides.build: CMakeFiles/tinymuduo.dir/TcpConnection.o


CMakeFiles/tinymuduo.dir/TcpServer.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/TcpServer.o: ../TcpServer.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_13) "Building CXX object CMakeFiles/tinymuduo.dir/TcpServer.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/TcpServer.o -c /home/admin/linux/tinyMuduo/TcpServer.cc

CMakeFiles/tinymuduo.dir/TcpServer.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/TcpServer.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/TcpServer.cc > CMakeFiles/tinymuduo.dir/TcpServer.i

CMakeFiles/tinymuduo.dir/TcpServer.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/TcpServer.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/TcpServer.cc -o CMakeFiles/tinymuduo.dir/TcpServer.s

CMakeFiles/tinymuduo.dir/TcpServer.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/TcpServer.o.requires

CMakeFiles/tinymuduo.dir/TcpServer.o.provides: CMakeFiles/tinymuduo.dir/TcpServer.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/TcpServer.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/TcpServer.o.provides

CMakeFiles/tinymuduo.dir/TcpServer.o.provides.build: CMakeFiles/tinymuduo.dir/TcpServer.o


CMakeFiles/tinymuduo.dir/Thread.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/Thread.o: ../Thread.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_14) "Building CXX object CMakeFiles/tinymuduo.dir/Thread.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/Thread.o -c /home/admin/linux/tinyMuduo/Thread.cc

CMakeFiles/tinymuduo.dir/Thread.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/Thread.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/Thread.cc > CMakeFiles/tinymuduo.dir/Thread.i

CMakeFiles/tinymuduo.dir/Thread.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/Thread.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/Thread.cc -o CMakeFiles/tinymuduo.dir/Thread.s

CMakeFiles/tinymuduo.dir/Thread.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/Thread.o.requires

CMakeFiles/tinymuduo.dir/Thread.o.provides: CMakeFiles/tinymuduo.dir/Thread.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/Thread.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/Thread.o.provides

CMakeFiles/tinymuduo.dir/Thread.o.provides.build: CMakeFiles/tinymuduo.dir/Thread.o


CMakeFiles/tinymuduo.dir/Timestamp.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/Timestamp.o: ../Timestamp.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_15) "Building CXX object CMakeFiles/tinymuduo.dir/Timestamp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/Timestamp.o -c /home/admin/linux/tinyMuduo/Timestamp.cc

CMakeFiles/tinymuduo.dir/Timestamp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/Timestamp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/Timestamp.cc > CMakeFiles/tinymuduo.dir/Timestamp.i

CMakeFiles/tinymuduo.dir/Timestamp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/Timestamp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/Timestamp.cc -o CMakeFiles/tinymuduo.dir/Timestamp.s

CMakeFiles/tinymuduo.dir/Timestamp.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/Timestamp.o.requires

CMakeFiles/tinymuduo.dir/Timestamp.o.provides: CMakeFiles/tinymuduo.dir/Timestamp.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/Timestamp.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/Timestamp.o.provides

CMakeFiles/tinymuduo.dir/Timestamp.o.provides.build: CMakeFiles/tinymuduo.dir/Timestamp.o


CMakeFiles/tinymuduo.dir/channel.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/channel.o: ../channel.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_16) "Building CXX object CMakeFiles/tinymuduo.dir/channel.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/channel.o -c /home/admin/linux/tinyMuduo/channel.cc

CMakeFiles/tinymuduo.dir/channel.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/channel.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/channel.cc > CMakeFiles/tinymuduo.dir/channel.i

CMakeFiles/tinymuduo.dir/channel.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/channel.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/channel.cc -o CMakeFiles/tinymuduo.dir/channel.s

CMakeFiles/tinymuduo.dir/channel.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/channel.o.requires

CMakeFiles/tinymuduo.dir/channel.o.provides: CMakeFiles/tinymuduo.dir/channel.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/channel.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/channel.o.provides

CMakeFiles/tinymuduo.dir/channel.o.provides.build: CMakeFiles/tinymuduo.dir/channel.o


CMakeFiles/tinymuduo.dir/newDefaultPoller.o: CMakeFiles/tinymuduo.dir/flags.make
CMakeFiles/tinymuduo.dir/newDefaultPoller.o: ../newDefaultPoller.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_17) "Building CXX object CMakeFiles/tinymuduo.dir/newDefaultPoller.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tinymuduo.dir/newDefaultPoller.o -c /home/admin/linux/tinyMuduo/newDefaultPoller.cc

CMakeFiles/tinymuduo.dir/newDefaultPoller.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tinymuduo.dir/newDefaultPoller.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/admin/linux/tinyMuduo/newDefaultPoller.cc > CMakeFiles/tinymuduo.dir/newDefaultPoller.i

CMakeFiles/tinymuduo.dir/newDefaultPoller.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tinymuduo.dir/newDefaultPoller.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/admin/linux/tinyMuduo/newDefaultPoller.cc -o CMakeFiles/tinymuduo.dir/newDefaultPoller.s

CMakeFiles/tinymuduo.dir/newDefaultPoller.o.requires:

.PHONY : CMakeFiles/tinymuduo.dir/newDefaultPoller.o.requires

CMakeFiles/tinymuduo.dir/newDefaultPoller.o.provides: CMakeFiles/tinymuduo.dir/newDefaultPoller.o.requires
	$(MAKE) -f CMakeFiles/tinymuduo.dir/build.make CMakeFiles/tinymuduo.dir/newDefaultPoller.o.provides.build
.PHONY : CMakeFiles/tinymuduo.dir/newDefaultPoller.o.provides

CMakeFiles/tinymuduo.dir/newDefaultPoller.o.provides.build: CMakeFiles/tinymuduo.dir/newDefaultPoller.o


# Object files for target tinymuduo
tinymuduo_OBJECTS = \
"CMakeFiles/tinymuduo.dir/Acceptor.o" \
"CMakeFiles/tinymuduo.dir/Buffer.o" \
"CMakeFiles/tinymuduo.dir/CurrentThread.o" \
"CMakeFiles/tinymuduo.dir/EpollPoller.o" \
"CMakeFiles/tinymuduo.dir/EventLoopThread.o" \
"CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o" \
"CMakeFiles/tinymuduo.dir/Eventloop.o" \
"CMakeFiles/tinymuduo.dir/InetAddress.o" \
"CMakeFiles/tinymuduo.dir/Logger.o" \
"CMakeFiles/tinymuduo.dir/Poller.o" \
"CMakeFiles/tinymuduo.dir/Socket.o" \
"CMakeFiles/tinymuduo.dir/TcpConnection.o" \
"CMakeFiles/tinymuduo.dir/TcpServer.o" \
"CMakeFiles/tinymuduo.dir/Thread.o" \
"CMakeFiles/tinymuduo.dir/Timestamp.o" \
"CMakeFiles/tinymuduo.dir/channel.o" \
"CMakeFiles/tinymuduo.dir/newDefaultPoller.o"

# External object files for target tinymuduo
tinymuduo_EXTERNAL_OBJECTS =

../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/Acceptor.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/Buffer.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/CurrentThread.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/EpollPoller.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/EventLoopThread.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/Eventloop.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/InetAddress.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/Logger.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/Poller.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/Socket.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/TcpConnection.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/TcpServer.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/Thread.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/Timestamp.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/channel.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/newDefaultPoller.o
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/build.make
../lib/libtinymuduo.so: CMakeFiles/tinymuduo.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/admin/linux/tinyMuduo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_18) "Linking CXX shared library ../lib/libtinymuduo.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/tinymuduo.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/tinymuduo.dir/build: ../lib/libtinymuduo.so

.PHONY : CMakeFiles/tinymuduo.dir/build

CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/Acceptor.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/Buffer.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/CurrentThread.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/EpollPoller.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/EventLoopThread.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/EventLoopThreadPool.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/Eventloop.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/InetAddress.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/Logger.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/Poller.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/Socket.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/TcpConnection.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/TcpServer.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/Thread.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/Timestamp.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/channel.o.requires
CMakeFiles/tinymuduo.dir/requires: CMakeFiles/tinymuduo.dir/newDefaultPoller.o.requires

.PHONY : CMakeFiles/tinymuduo.dir/requires

CMakeFiles/tinymuduo.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/tinymuduo.dir/cmake_clean.cmake
.PHONY : CMakeFiles/tinymuduo.dir/clean

CMakeFiles/tinymuduo.dir/depend:
	cd /home/admin/linux/tinyMuduo/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/admin/linux/tinyMuduo /home/admin/linux/tinyMuduo /home/admin/linux/tinyMuduo/build /home/admin/linux/tinyMuduo/build /home/admin/linux/tinyMuduo/build/CMakeFiles/tinymuduo.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/tinymuduo.dir/depend

