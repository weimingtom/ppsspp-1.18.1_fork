Thread 1 "PPSSPPSDL" received signal SIGINT, Interrupt.
futex_wait_cancelable (private=<optimized out>, expected=0, 
    futex_word=0x555557294558) at ../sysdeps/nptl/futex-internal.h:183
183	../sysdeps/nptl/futex-internal.h: No such file or directory.
(gdb) b PresentationCommon::CopyToOutput
Breakpoint 1 at 0x555555a33010: file GPU/Common/PresentationCommon.cpp, line 639.
(gdb) c
Continuing.
[Switching to Thread 0x7fff6a7fc700 (LWP 1645)]

Thread 53 "Emu" hit Breakpoint 1, PresentationCommon::CopyToOutput (
    this=0x7fff44008da0, flags=flags@entry=OutputFlags::BACKBUFFER_FLIPPED, 
    uvRotation=uvRotation@entry=1, u0=u0@entry=0, v0=v0@entry=0, 
    u1=u1@entry=0.9375, v1=v1@entry=1) at GPU/Common/PresentationCommon.cpp:639
639	void PresentationCommon::CopyToOutput(OutputFlags flags, int uvRotation, float u0, float v0, float u1, float v1) {
(gdb) bt
#0  PresentationCommon::CopyToOutput (this=0x7fff44008da0, 
    flags=flags@entry=OutputFlags::BACKBUFFER_FLIPPED, 
    uvRotation=uvRotation@entry=1, u0=u0@entry=0, v0=v0@entry=0, 
    u1=u1@entry=0.9375, v1=v1@entry=1) at GPU/Common/PresentationCommon.cpp:639
#1  0x0000555555a2419f in FramebufferManagerCommon::DrawFramebufferToOutput (
    this=this@entry=0x7fff440493f0, srcPixels=<optimized out>, 
    srcStride=<optimized out>, srcPixelFormat=<optimized out>)
    at GPU/Common/FramebufferManagerCommon.cpp:1550
#2  0x0000555555a27e1b in FramebufferManagerCommon::CopyDisplayToOutput (
    this=0x7fff440493f0, reallyDirty=reallyDirty@entry=true)
    at ./Core/MemMap.h:155
#3  0x0000555555b86112 in GPUCommonHW::CopyDisplayToOutput (
    this=0x7fff44063ec0, reallyDirty=<optimized out>)
    at GPU/GPUCommonHW.cpp:539
#4  0x00005555558a7711 in __DisplayFlip (cyclesLate=3)
    at Core/HLE/sceDisplay.cpp:650
#5  0x00005555558a8120 in hleEnterVblank (userdata=<optimized out>, 
    cyclesLate=3) at Core/HLE/sceDisplay.cpp:542
#6  0x0000555555822b52 in CoreTiming::ProcessEvents ()
    at /usr/include/c++/9/bits/stl_vector.h:1040
#7  0x0000555555822bec in CoreTiming::Advance () at Core/CoreTiming.cpp:405
#8  0x00005555359f90b4 in ?? ()
#9  0x00005555569e9940 in ?? ()




Thread 53 "Emu" hit Breakpoint 2, PresentationCommon::CopyToOutput (
    this=0x7fff44008da0, flags=flags@entry=OutputFlags::BACKBUFFER_FLIPPED, 
    uvRotation=uvRotation@entry=1, u0=u0@entry=0, v0=v0@entry=0, 
    u1=u1@entry=0.566666663, v1=v1@entry=1.7647059)
    at GPU/Common/PresentationCommon.cpp:639
639	void PresentationCommon::CopyToOutput(OutputFlags flags, int uvRotation, float u0, float v0, float u1, float v1) {
(gdb) bt
#0  PresentationCommon::CopyToOutput (this=0x7fff44008da0, 
    flags=flags@entry=OutputFlags::BACKBUFFER_FLIPPED, 
    uvRotation=uvRotation@entry=1, u0=u0@entry=0, v0=v0@entry=0, 
    u1=u1@entry=0.566666663, v1=v1@entry=1.7647059)
    at GPU/Common/PresentationCommon.cpp:639
#1  0x0000555555a27dfb in FramebufferManagerCommon::CopyDisplayToOutput (
    this=0x7fff440493f0, reallyDirty=reallyDirty@entry=true)
    at GPU/Common/FramebufferManagerCommon.cpp:1740
#2  0x0000555555b86112 in GPUCommonHW::CopyDisplayToOutput (
    this=0x7fff44063ec0, reallyDirty=<optimized out>)
    at GPU/GPUCommonHW.cpp:539
#3  0x00005555558a7711 in __DisplayFlip (cyclesLate=1)
    at Core/HLE/sceDisplay.cpp:650
#4  0x00005555558a8120 in hleEnterVblank (userdata=<optimized out>, 
    cyclesLate=1) at Core/HLE/sceDisplay.cpp:542
#5  0x0000555555822b52 in CoreTiming::ProcessEvents ()
    at /usr/include/c++/9/bits/stl_vector.h:1040
#6  0x0000555555822bec in CoreTiming::Advance () at Core/CoreTiming.cpp:405
#7  0x000055555592b937 in __KernelReSchedule (reason=0x5555565850cd "idle")
    at Core/HLE/sceKernelThread.cpp:1755
#8  0x00005555359fec21 in ?? ()
#9  0x00005555569e9940 in ?? ()
#10 0x00005555569e9940 in ?? ()





















b GLQueueRunner.cpp:477
Common/GPU/OpenGL/GLQueueRunner.cpp:477
b glTexImage2D

glScissor






