Enable PPSSPP's setting 'Software Rendering (slow, accurate)' 
then
(gdb) b PresentationCommon::CopyToOutput


#0  PresentationCommon::CopyToOutput (this=0x7fff441bc6e0, 
    flags=flags@entry=OutputFlags::BACKBUFFER_FLIPPED, uvRotation=1, 
    u0=u0@entry=0, v0=v0@entry=0, u1=u1@entry=0.9375, v1=v1@entry=1)
    at GPU/Common/PresentationCommon.cpp:639
#1  0x0000555555a806eb in SoftGPU::CopyToCurrentFboFromDisplayRam (
    this=0x7fff44100140, srcwidth=<optimized out>, srcheight=272)
    at GPU/Software/SoftGpu.cpp:650
#2  0x0000555555a80b14 in SoftGPU::CopyDisplayToOutput (this=0x7fff44100140, 
    reallyDirty=<optimized out>) at GPU/Software/SoftGpu.cpp:656
#3  0x00005555558a7711 in __DisplayFlip (cyclesLate=3)
    at Core/HLE/sceDisplay.cpp:650
#4  0x00005555558a8120 in hleEnterVblank (userdata=<optimized out>, 
    cyclesLate=3) at Core/HLE/sceDisplay.cpp:542
#5  0x0000555555822b52 in CoreTiming::ProcessEvents ()
    at /usr/include/c++/9/bits/stl_vector.h:1040
#6  0x0000555555822bec in CoreTiming::Advance () at Core/CoreTiming.cpp:405
#7  0x00005555359f90b4 in ?? ()
#8  0x00005555569e9940 in ?? ()
#9  0x00005555569e9940 in ?? ()
#10 0x0000000000000000 in ?? ()


#0  PresentationCommon::CopyToOutput (this=0x7fff441bc6e0, 
    flags=flags@entry=OutputFlags::BACKBUFFER_FLIPPED, uvRotation=1, 
    u0=u0@entry=0, v0=v0@entry=0, u1=u1@entry=0.9375, v1=v1@entry=1)
    at GPU/Common/PresentationCommon.cpp:639
#1  0x0000555555a806eb in SoftGPU::CopyToCurrentFboFromDisplayRam (
    this=0x7fff44100140, srcwidth=<optimized out>, srcheight=272)
    at GPU/Software/SoftGpu.cpp:650
#2  0x0000555555a80b14 in SoftGPU::CopyDisplayToOutput (this=0x7fff44100140, 
    reallyDirty=<optimized out>) at GPU/Software/SoftGpu.cpp:656
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
#11 0x0000000000000000 in ?? ()



