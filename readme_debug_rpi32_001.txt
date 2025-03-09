

(gdb) r
Starting program: /home/pi/pi/work_ppsspp/ppsspp_rpi32_1181/PPSSPPSDL
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/arm-linux-gnueabihf/libthread_db.so.1".
[New Thread 0x7631d400 (LWP 769)]
[New Thread 0x759ff400 (LWP 770)]
[New Thread 0x751fe400 (LWP 771)]
[New Thread 0x749fd400 (LWP 772)]
DEBUG: Vulkan is not available, not using Vulkan.
[New Thread 0x73933400 (LWP 774)]
Info: We compiled against SDL version 2.26.1, but we are linking against SDL version 2.0.10., be aware that this can lead to unexpected behaviors
ThreadManager::Init(compute threads: 4, all: 8)
[New Thread 0x72fff400 (LWP 775)]
[New Thread 0x727fe400 (LWP 776)]
[New Thread 0x71ffd400 (LWP 777)]
[New Thread 0x717fc400 (LWP 778)]
[New Thread 0x70ffb400 (LWP 779)]
[New Thread 0x707fa400 (LWP 780)]
[New Thread 0x6fff9400 (LWP 781)]
[New Thread 0x6f7f8400 (LWP 782)]
Registered VFS for prefix : /usr/local/share/ppsspp/assets
Registered VFS for prefix : /home/pi/pi/work_ppsspp/ppsspp_rpi32_1181/assets
Registered VFS for prefix : /home/pi/pi/work_ppsspp/ppsspp_rpi32_1181
Registered VFS for prefix : /usr/local/share/ppsspp/assets
Registered VFS for prefix : /usr/local/share/games/ppsspp/assets
Registered VFS for prefix : /usr/share/ppsspp/assets
Registered VFS for prefix : /usr/share/games/ppsspp/assets
Registered VFS for prefix : assets
Registered VFS for prefix : /home/pi
52:57:118 Core/Config.cpp:373 I[G3D]: Longest display side: 640 pixels. Choosing scale 1
52:57:152 Core/Config.cpp:1280 I[LOADER]: Loading controller config: /home/pi/.config/ppsspp/PSP/SYSTEM/controls.ini
[New Thread 0x6eb7d400 (LWP 783)]
52:57:160 Core/Config.cpp:1296 I[LOADER]: Config loaded: '/home/pi/.config/ppsspp/PSP/SYSTEM/ppsspp.ini' (161.6 ms)
52:57:162 Core/Config.cpp:1598 I[LOADER]: No recents list found.
[Thread 0x6eb7d400 (LWP 783) exited]
52:57:237 Core/System.cpp:723 I[IO]: Creating '/home/pi/.config/ppsspp/PSP' and subdirs:
52:57:239 File/FileUtil.cpp:548 D[COMMON]: CreateDir('/home/pi/.config/ppsspp/PSP')
52:57:240 File/FileUtil.cpp:572 W[COMMON]: CreateDir: mkdir failed on /home/pi/.config/ppsspp/PSP: already exists
52:57:240 File/FileUtil.cpp:584 D[COMMON]: CreateFullPath: path exists /home/pi/.config/ppsspp/PSP/Cheats
52:57:241 File/FileUtil.cpp:584 D[COMMON]: CreateFullPath: path exists /home/pi/.config/ppsspp/PSP/SAVEDATA
52:57:241 File/FileUtil.cpp:584 D[COMMON]: CreateFullPath: path exists /home/pi/.config/ppsspp/PSP/PPSSPP_STATE
52:57:241 File/FileUtil.cpp:584 D[COMMON]: CreateFullPath: path exists /home/pi/.config/ppsspp/PSP/GAME
52:57:242 File/FileUtil.cpp:584 D[COMMON]: CreateFullPath: path exists /home/pi/.config/ppsspp/PSP/SYSTEM
52:57:243 File/FileUtil.cpp:584 D[COMMON]: CreateFullPath: path exists /home/pi/.config/ppsspp/PSP/TEXTURES
52:57:243 File/FileUtil.cpp:584 D[COMMON]: CreateFullPath: path exists /home/pi/.config/ppsspp/PSP/PLUGINS
52:57:243 File/FileUtil.cpp:584 D[COMMON]: CreateFullPath: path exists /home/pi/.config/ppsspp/PSP/SYSTEM/CACHE
52:57:245 UI/NativeApp.cpp:751 D[SYSTEM]: ScreenManager!
52:57:251 UI/NativeApp.cpp:287 N[LOADER]: Not checking for failed graphics backends in debug mode
52:57:281 Core/RetroAchievements.cpp:324 I[ACHIEVEMENTS]: RetroAchievements: Using host: http://retroachievements.org
52:57:281 Core/RetroAchievements.cpp:324 I[ACHIEVEMENTS]: RetroAchievements: Encore mode disabled
52:57:281 Core/RetroAchievements.cpp:324 I[ACHIEVEMENTS]: RetroAchievements: Unofficial disabled
52:57:487 OpenGL/GLFeatures.cpp:203 I[G3D]: GPU Vendor : Broadcom ; renderer: VideoCore IV HW version str: OpenGL ES 2.0 ; GLSL version str: OpenGL ES GLSL ES 1.00
glGetError 0x500
52:57:491 OpenGL/GLFeatures.cpp:108 D[G3D]: Checking for GL driver bugs... vendor=7 model='VideoCore IV HW'
52:57:540 SDL/SDLMain.cpp:163 I[AUDIO]: SDL: Trying a different audio device
[New Thread 0x6e1ff400 (LWP 784)]
loading control pad mappings from gamecontrollerdb.txt: SUCCESS!
found control pad: DragonRise Inc.   Generic   USB  Joystick  , loading mapping: SUCCESS, mapping is:
03000000790000000600000010010000,DragonRise Inc.   Generic   USB  Joystick  ,platform:Linux,x:b3,a:b2,b:b1,y:b0,back:b8,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a3,righty:a4,
pad 1 has been assigned to control pad: DragonRise Inc.   Generic   USB  Joystick
[New Thread 0x6d7ff400 (LWP 785)]
52:57:714 UI/NativeApp.cpp:802 I[SYSTEM]: NativeInitGraphics
52:57:725 OpenGL/GLRenderManager.cpp:62 I[G3D]: Updating inflight frames to 3
found control pad: DragonRise Inc.   Generic   USB  Joystick  , loading mapping: SUCCESS, mapping is:
03000000790000000600000010010000,DragonRise Inc.   Generic   USB  Joystick  ,platform:Linux,x:b3,a:b2,b:b1,y:b0,back:b8,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a3,righty:a4,
52:57:822 UI/NativeApp.cpp:863 I[SYSTEM]: NativeInitGraphics completed
52:57:825 UI/Screen.cpp:22 D[SYSTEM]: Screen Logo got FOCUS_BECAME_TOP
53:02:089 SDL/SDLGLGraphicsContext.cpp:443 I[G3D]: SDL SwapInterval: 0

















^C
Thread 1 "PPSSPPSDL" received signal SIGINT, Interrupt.
futex_wait_cancelable (private=0, expected=0, futex_word=0x1c740e4)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
88      ../sysdeps/unix/sysv/linux/futex-internal.h: No such file or directory.
(gdb) bt
#0  futex_wait_cancelable (private=0, expected=0, futex_word=0x1c740e4)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
#1  __pthread_cond_wait_common (abstime=0x0, mutex=0x0, cond=0x1c740b8)
    at pthread_cond_wait.c:502
#2  __pthread_cond_wait (cond=0x1c740b8, mutex=0x0) at pthread_cond_wait.c:655
#3  0x76ceac94 in std::condition_variable::wait(std::unique_lock<std::mutex>&)
    () from /lib/arm-linux-gnueabihf/libstdc++.so.6
#4  0x008ac990 in GLRenderManager::ThreadFrame (this=0x1c73aa0)
    at Common/GPU/OpenGL/GLRenderManager.cpp:141
#5  0x00805e98 in SDLGLGraphicsContext::ThreadFrame (this=0x1c9e708)
    at SDL/SDLGLGraphicsContext.h:37
#6  0x00800914 in main (argc=1, argv=0x7efff654) at SDL/SDLMain.cpp:1537








(gdb) b GLRenderManager::FlushSync
Breakpoint 1 at 0x8ae43c: file Common/GPU/OpenGL/GLRenderManager.cpp, line 554.
(gdb) b GLRenderManager::Present
Breakpoint 2 at 0x8addbc: file Common/GPU/OpenGL/GLRenderManager.cpp, line 429.
(gdb) r
Thread 17 "Emu" hit Breakpoint 2, GLRenderManager::Present (this=0x1c74118)
    at Common/GPU/OpenGL/GLRenderManager.cpp:429
429     Common/GPU/OpenGL/GLRenderManager.cpp: No such file or directory.
(gdb) bt
#0  GLRenderManager::Present (this=0x1c74118)
    at Common/GPU/OpenGL/GLRenderManager.cpp:429
#1  0x0089d664 in Draw::OpenGLContext::Present (this=0x1c735a0,
    presentMode=Draw::PresentMode::IMMEDIATE, vblanks=0)
    at Common/GPU/OpenGL/thin3d_gl.cpp:821
#2  0x0007676c in NativeFrame (graphicsContext=0x1c9e578)
    at UI/NativeApp.cpp:1156
#3  0x0021aa44 in UpdateRunLoop (ctx=0x1c9e578) at Core/Core.cpp:212
#4  0x007fdb08 in EmuThreadFunc (graphicsContext=0x1c9e578)
    at SDL/SDLMain.cpp:698
#5  0x00802c78 in std::__invoke_impl<void, void (*)(GraphicsContext*), GraphicsContext*> (__f=@0x1c653b8: 0x7fda98 <EmuThreadFunc(GraphicsContext*)>)
    at /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/7.5.0/bits/invoke.h:60
#6  0x0080267c in std::__invoke<void (*)(GraphicsContext*), GraphicsContext*> (
    __fn=@0x1c653b8: 0x7fda98 <EmuThreadFunc(GraphicsContext*)>)
    at /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/7.5.0/bits/invoke.h:95
#7  0x00804df8 in std::thread::_Invoker<std::tuple<void (*)(GraphicsContext*), GraphicsContext*> >::_M_invoke<0u, 1u> (this=0x1c653b4)
    at /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/7.5.0/thread:234
#8  0x00804d94 in std::thread::_Invoker<std::tuple<void (*)(GraphicsContext*), G--Type <RET> for more, q to quit, c to continue without paging--
raphicsContext*> >::operator() (this=0x1c653b4)
    at /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/7.5.0/thread:243
#9  0x00804d6c in std::thread::_State_impl<std::thread::_Invoker<std::tuple<void (*)(GraphicsContext*), GraphicsContext*> > >::_M_run (this=0x1c653b0)
    at /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/7.5.0/thread:186
#10 0x76cf09b0 in ?? () from /lib/arm-linux-gnueabihf/libstdc++.so.6
#11 0x76b80494 in start_thread (arg=0x6d7ff400) at pthread_create.c:486
#12 0x76b03568 in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73
   from /lib/arm-linux-gnueabihf/libc.so.6
Backtrace stopped: previous frame identical to this frame (corrupt stack?)







(gdb) info threads
  Id   Target Id                                     Frame
* 1    Thread 0x76ff5240 (LWP 846) "PPSSPPSDL"       futex_wait_cancelable (
    private=0, expected=0, futex_word=0x1c74758)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  2    Thread 0x7631d400 (LWP 852) "VCHIQ completio" 0x76afb50c in ioctl ()
    at ../sysdeps/unix/syscall-template.S:78
  3    Thread 0x759ff400 (LWP 853) "HDispmanx Notif" 0x76b8a088 in futex_abstimed_wait_cancelable (private=0, abstime=0x0, expected=1,
    futex_word=0x76e27f80 <dispmanx_notify_available_event+24>)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:205
  4    Thread 0x751fe400 (LWP 854) "HTV Notify"      0x76b8a088 in futex_abstimed_wait_cancelable (private=0, abstime=0x0, expected=1,
    futex_word=0x76e270f4 <tvservice_notify_available_event+24>)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:205
  5    Thread 0x749fd400 (LWP 855) "HCEC Notify"     0x76b8a088 in futex_abstimed_wait_cancelable (private=0, abstime=0x0, expected=1,
    futex_word=0x76e27e84 <cecservice_notify_available_event+24>)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:205
  6    Thread 0x73933400 (LWP 856) "SDLHotplugALSA"  __GI___nanosleep (
    remaining=0x73932d40, requested_time=0x73932d48)
    at ../sysdeps/unix/sysv/linux/nanosleep.c:28
  7    Thread 0x72fff400 (LWP 857) "PoolWorker 0"    futex_wait_cancelable (
    private=0, expected=0, futex_word=0x1c68990)
--Type <RET> for more, q to quit, c to continue without paging--
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  8    Thread 0x727fe400 (LWP 858) "PoolWorker 1"    futex_wait_cancelable (
    private=0, expected=0, futex_word=0x1c5bc28)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  9    Thread 0x71ffd400 (LWP 859) "PoolWorker 2"    futex_wait_cancelable (
    private=0, expected=0, futex_word=0x1c52ad8)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  10   Thread 0x717fc400 (LWP 860) "PoolWorker 3"    futex_wait_cancelable (
    private=0, expected=0, futex_word=0x1c78f08)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  11   Thread 0x70ffb400 (LWP 861) "PoolWorkerIO 4"  futex_wait_cancelable (
    private=0, expected=0, futex_word=0x1c77c54)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  12   Thread 0x707fa400 (LWP 862) "PoolWorkerIO 5"  futex_wait_cancelable (
    private=0, expected=0, futex_word=0x1c78218)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  13   Thread 0x6fff9400 (LWP 863) "PoolWorkerIO 6"  futex_wait_cancelable (
    private=0, expected=0, futex_word=0x1c79450)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  14   Thread 0x6f7f8400 (LWP 864) "PoolWorkerIO 7"  futex_wait_cancelable (
    private=0, expected=0, futex_word=0x1c77858)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  16   Thread 0x6e1ff400 (LWP 866) "SDLAudioP2"      0x76afb50c in ioctl ()
--Type <RET> for more, q to quit, c to continue without paging--
    at ../sysdeps/unix/syscall-template.S:78
  17   Thread 0x6d7ff400 (LWP 867) "Emu"             __GI___nanosleep (
    remaining=0x0, requested_time=0x6d7fec4c)
    at ../sysdeps/unix/sysv/linux/nanosleep.c:28
	

	
	
	
	
	
	
	

(gdb) thread 17
[Switching to thread 17 (Thread 0x6d7ff400 (LWP 867))]
#0  __GI___nanosleep (remaining=0x0, requested_time=0x6d7fec4c)
    at ../sysdeps/unix/sysv/linux/nanosleep.c:28
28      ../sysdeps/unix/sysv/linux/nanosleep.c: No such file or directory.
(gdb) bt
#0  __GI___nanosleep (remaining=0x0, requested_time=0x6d7fec4c)
    at ../sysdeps/unix/sysv/linux/nanosleep.c:28
#1  __GI___nanosleep (requested_time=0x6d7fec4c,
    requested_time@entry=0x6d7fec44, remaining=remaining@entry=0x0)
    at ../sysdeps/unix/sysv/linux/nanosleep.c:25
#2  0x76afcfb0 in usleep (useconds=<optimized out>)
    at ../sysdeps/posix/usleep.c:32
#3  0x009ae684 in sleep_ms (ms=2147416491) at Common/TimeUtil.cpp:262
#4  0x0007699c in NativeFrame (graphicsContext=0x1c9e578)
    at UI/NativeApp.cpp:1202
#5  0x0021aa44 in UpdateRunLoop (ctx=0x1c9e578) at Core/Core.cpp:212
#6  0x007fdb08 in EmuThreadFunc (graphicsContext=0x1c9e578)
    at SDL/SDLMain.cpp:698
#7  0x00802c78 in std::__invoke_impl<void, void (*)(GraphicsContext*), GraphicsContext*> (__f=@0x1c653b8: 0x7fda98 <EmuThreadFunc(GraphicsContext*)>)
    at /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/7.5.0/bits/invoke.h:60
#8  0x0080267c in std::__invoke<void (*)(GraphicsContext*), GraphicsContext*> (
    __fn=@0x1c653b8: 0x7fda98 <EmuThreadFunc(GraphicsContext*)>)
    at /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/7.5.0/bits/invoke.h:95
#9  0x00804df8 in std::thread::_Invoker<std::tuple<void (*)(GraphicsContext*), GraphicsContext*> >::_M_invoke<0u, 1u> (this=0x1c653b4)
--Type <RET> for more, q to quit, c to continue without paging--
    at /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/7.5.0/thread:234
#10 0x00804d94 in std::thread::_Invoker<std::tuple<void (*)(GraphicsContext*), GraphicsContext*> >::operator() (this=0x1c653b4)
    at /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/7.5.0/thread:243
#11 0x00804d6c in std::thread::_State_impl<std::thread::_Invoker<std::tuple<void (*)(GraphicsContext*), GraphicsContext*> > >::_M_run (this=0x1c653b0)
    at /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/7.5.0/thread:186
#12 0x76cf09b0 in ?? () from /lib/arm-linux-gnueabihf/libstdc++.so.6
#13 0x76b80494 in start_thread (arg=0x6d7ff400) at pthread_create.c:486
#14 0x76b03568 in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73
   from /lib/arm-linux-gnueabihf/libc.so.6
   
