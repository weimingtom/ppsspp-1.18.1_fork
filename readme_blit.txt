b GLRenderManager::BlitFramebuffer

hread 53 "Emu" hit Breakpoint 1, GLRenderManager::BlitFramebuffer (this=0x555557292370, src=0x7fff4ca20670, srcRect=..., dst=0x7fff4c9dc3a0, dstRect=..., 
    aspectMask=aspectMask@entry=16384, filter=false, tag=0x5555565a4ee2 "Blit_ReadFramebufferToMemory") at Common/GPU/OpenGL/GLRenderManager.cpp:293
293	void GLRenderManager::BlitFramebuffer(GLRFramebuffer *src, GLRect2D srcRect, GLRFramebuffer *dst, GLRect2D dstRect, int aspectMask, bool filter, const char *tag) {
(gdb) bt
#0  GLRenderManager::BlitFramebuffer (this=0x555557292370, src=0x7fff4ca20670, srcRect=..., dst=0x7fff4c9dc3a0, dstRect=..., aspectMask=aspectMask@entry=16384, filter=false, 
    tag=0x5555565a4ee2 "Blit_ReadFramebufferToMemory") at Common/GPU/OpenGL/GLRenderManager.cpp:293
#1  0x0000555555ccbbc4 in Draw::OpenGLContext::BlitFramebuffer (this=<optimized out>, fbsrc=<optimized out>, srcX1=<optimized out>, srcY1=<optimized out>, srcX2=<optimized out>, 
    srcY2=<optimized out>, fbdst=0x7fff4c9dc450, dstX1=0, dstY1=0, dstX2=480, dstY2=272, channels=1, linearFilter=Draw::FB_BLIT_NEAREST, 
    tag=0x5555565a4ee2 "Blit_ReadFramebufferToMemory") at Common/GPU/OpenGL/thin3d_gl.cpp:1538
#2  0x0000555555a253c4 in FramebufferManagerCommon::BlitFramebuffer (tag=0x5555565a4ee2 "Blit_ReadFramebufferToMemory", channel=RASTER_COLOR, bpp=0, h=<optimized out>, 
    w=<optimized out>, srcY=0, srcX=<optimized out>, src=0x7fff4c035070, dstY=<optimized out>, dstX=0, dst=0x7fff4c9dc330, this=0x7fff4c057890)
    at GPU/Common/FramebufferManagerCommon.cpp:3541
#3  FramebufferManagerCommon::BlitFramebuffer (this=0x7fff4c057890, dst=0x7fff4c9dc330, dstX=0, dstY=<optimized out>, src=0x7fff4c035070, srcX=<optimized out>, srcY=0, w=480, 
    h=272, bpp=0, channel=RASTER_COLOR, tag=0x5555565a4ee2 "Blit_ReadFramebufferToMemory") at GPU/Common/FramebufferManagerCommon.cpp:3449
#4  0x0000555555a26627 in FramebufferManagerCommon::ReadbackFramebuffer (this=0x7fff4c057890, vfb=<optimized out>, x=0, y=0, w=480, h=272, channel=RASTER_COLOR, 
    mode=Draw::ReadbackMode::BLOCK) at GPU/Common/FramebufferManagerCommon.cpp:3180
#5  0x0000555555a2154d in FramebufferManagerCommon::ReadFramebufferToMemory (mode=Draw::ReadbackMode::BLOCK, channel=<optimized out>, h=<optimized out>, w=<optimized out>, 
    y=<optimized out>, x=<optimized out>, vfb=<optimized out>, this=0x7fff4c057890) at GPU/Common/FramebufferManagerCommon.cpp:3272
#6  FramebufferManagerCommon::ReadFramebufferToMemory (this=0x7fff4c057890, vfb=<optimized out>, x=<optimized out>, y=<optimized out>, w=<optimized out>, h=<optimized out>, 
    channel=RASTER_COLOR, mode=Draw::ReadbackMode::BLOCK) at GPU/Common/FramebufferManagerCommon.cpp:3232
#7  0x0000555555a216a8 in FramebufferManagerCommon::DownloadFramebufferOnSwitch (vfb=0x7fff4c035070, this=<optimized out>) at GPU/Common/FramebufferManagerCommon.cpp:1062
#8  FramebufferManagerCommon::DownloadFramebufferOnSwitch (this=<optimized out>, vfb=0x7fff4c035070) at GPU/Common/FramebufferManagerCommon.cpp:1054
#9  0x0000555555a27ad1 in FramebufferManagerCommon::CopyDisplayToOutput (this=0x7fff4c057890, reallyDirty=reallyDirty@entry=true) at GPU/Common/FramebufferManagerCommon.cpp:1567
#10 0x0000555555b86112 in GPUCommonHW::CopyDisplayToOutput (this=0x7fff4c061610, reallyDirty=<optimized out>) at GPU/GPUCommonHW.cpp:539
#11 0x00005555558a7711 in __DisplayFlip (cyclesLate=0) at Core/HLE/sceDisplay.cpp:650
#12 0x00005555558a7b12 in __DisplaySetFramebuf (topaddr=<optimized out>, linesize=<optimized out>, pixelFormat=<optimized out>, sync=0) at Core/HLE/sceDisplay.cpp:829
#13 __DisplaySetFramebuf (topaddr=<optimized out>, linesize=<optimized out>, pixelFormat=<optimized out>, sync=<optimized out>) at Core/HLE/sceDisplay.cpp:812
#14 0x00005555558a7d36 in sceDisplaySetFramebuf (sync=0, pixelformat=3, linesize=512, topaddr=<optimized out>) at Core/HLE/sceDisplay.cpp:905
#15 sceDisplaySetFramebuf (topaddr=67665920, linesize=512, pixelformat=3, sync=0) at Core/HLE/sceDisplay.cpp:846
#16 0x00005555558a9450 in WrapU_UIII<&(sceDisplaySetFramebuf(unsigned int, int, int, int))> () at ./Core/HLE/FunctionWrappers.h:687
#17 0x00005555558887cd in CallSyscallWithoutFlags (info=0x555556988d30 <sceDisplay+48>) at Core/HLE/HLE.cpp:659



(gdb) bt
#0  GLRenderManager::CopyFramebufferToMemory (this=0x5555572968d0, src=0x7fff44048db0, aspectBits=16384, x=0, y=0, w=480, h=272, destFormat=Draw::DataFormat::R8G8B8A8_UNORM, 
    pixels=0x7ffe04000000 "", pixelStride=512, mode=Draw::ReadbackMode::BLOCK, tag=0x5555565a4f28 "ReadbackFramebufferSync") at Common/GPU/OpenGL/GLRenderManager.cpp:309
#1  0x0000555555a2682b in FramebufferManagerCommon::ReadbackFramebuffer (this=<optimized out>, vfb=0x7fff44056400, x=0, y=0, w=480, h=272, channel=RASTER_COLOR, 
    mode=Draw::ReadbackMode::BLOCK) at ./Core/MemMap.h:320
#2  0x0000555555a2154d in FramebufferManagerCommon::ReadFramebufferToMemory (mode=Draw::ReadbackMode::BLOCK, channel=<optimized out>, h=<optimized out>, w=<optimized out>, 
    y=<optimized out>, x=<optimized out>, vfb=<optimized out>, this=0x7fff44054a70) at GPU/Common/FramebufferManagerCommon.cpp:3272
#3  FramebufferManagerCommon::ReadFramebufferToMemory (this=0x7fff44054a70, vfb=<optimized out>, x=<optimized out>, y=<optimized out>, w=<optimized out>, h=<optimized out>, 
    channel=RASTER_COLOR, mode=Draw::ReadbackMode::BLOCK) at GPU/Common/FramebufferManagerCommon.cpp:3232
#4  0x0000555555a216a8 in FramebufferManagerCommon::DownloadFramebufferOnSwitch (vfb=0x7fff44019790, this=<optimized out>) at GPU/Common/FramebufferManagerCommon.cpp:1062
#5  FramebufferManagerCommon::DownloadFramebufferOnSwitch (this=<optimized out>, vfb=0x7fff44019790) at GPU/Common/FramebufferManagerCommon.cpp:1054
#6  0x0000555555a27ad1 in FramebufferManagerCommon::CopyDisplayToOutput (this=0x7fff44054a70, reallyDirty=reallyDirty@entry=true) at GPU/Common/FramebufferManagerCommon.cpp:1567
#7  0x0000555555b86112 in GPUCommonHW::CopyDisplayToOutput (this=0x7fff44023600, reallyDirty=<optimized out>) at GPU/GPUCommonHW.cpp:539
#8  0x00005555558a7711 in __DisplayFlip (cyclesLate=1) at Core/HLE/sceDisplay.cpp:650
#9  0x00005555558a8120 in hleEnterVblank (userdata=<optimized out>, cyclesLate=1) at Core/HLE/sceDisplay.cpp:542
#10 0x0000555555822b52 in CoreTiming::ProcessEvents () at /usr/include/c++/9/bits/stl_vector.h:1040
#11 0x0000555555822bec in CoreTiming::Advance () at Core/CoreTiming.cpp:405
#12 0x000055555592b937 in __KernelReSchedule (reason=0x5555565850cd "idle") at Core/HLE/sceKernelThread.cpp:1755
#13 0x00005555359fec21 in ?? ()
#14 0x00005555569e9940 in ?? ()
#15 0x00005555569e9940 in ?? ()
#16 0x0000000000000000 in ?? ()


Thread 54 "Emu" hit Breakpoint 6, GLRenderManager::BindFramebufferAsTexture (this=0x5555572968d0, fb=0x7fff44007ab0, binding=0, aspectBit=16384)
    at Common/GPU/OpenGL/GLRenderManager.cpp:267
267	void GLRenderManager::BindFramebufferAsTexture(GLRFramebuffer *fb, int binding, int aspectBit) {
(gdb) bt
#0  GLRenderManager::BindFramebufferAsTexture (this=0x5555572968d0, fb=0x7fff44007ab0, binding=0, aspectBit=16384) at Common/GPU/OpenGL/GLRenderManager.cpp:267
#1  0x0000555555a32faf in PresentationCommon::BindSource (bindStereo=<optimized out>, binding=<optimized out>, this=<optimized out>) at GPU/Common/PresentationCommon.cpp:626
#2  PresentationCommon::BindSource (this=<optimized out>, binding=<optimized out>, bindStereo=<optimized out>) at GPU/Common/PresentationCommon.cpp:611
#3  0x0000555555a34634 in PresentationCommon::CopyToOutput (this=0x7fff44003cc0, flags=flags@entry=OutputFlags::BACKBUFFER_FLIPPED, uvRotation=uvRotation@entry=1, u0=u0@entry=0, 
    v0=v0@entry=0, u1=u1@entry=0.566666663, v1=v1@entry=1.7647059) at GPU/Common/PresentationCommon.cpp:889
#4  0x0000555555a27dfb in FramebufferManagerCommon::CopyDisplayToOutput (this=0x7fff44054a70, reallyDirty=reallyDirty@entry=true) at GPU/Common/FramebufferManagerCommon.cpp:1740
#5  0x0000555555b86112 in GPUCommonHW::CopyDisplayToOutput (this=0x7fff44023600, reallyDirty=<optimized out>) at GPU/GPUCommonHW.cpp:539
#6  0x00005555558a7711 in __DisplayFlip (cyclesLate=1) at Core/HLE/sceDisplay.cpp:650
#7  0x00005555558a8120 in hleEnterVblank (userdata=<optimized out>, cyclesLate=1) at Core/HLE/sceDisplay.cpp:542
#8  0x0000555555822b52 in CoreTiming::ProcessEvents () at /usr/include/c++/9/bits/stl_vector.h:1040
#9  0x0000555555822bec in CoreTiming::Advance () at Core/CoreTiming.cpp:405
#10 0x000055555592b937 in __KernelReSchedule (reason=0x5555565850cd "idle") at Core/HLE/sceKernelThread.cpp:1755
#11 0x00005555359fec21 in ?? ()
#12 0x00005555569e9940 in ?? ()
#13 0x00005555569e9940 in ?? ()
#14 0x0000000000000000 in ?? ()



hread 54 "Emu" hit Breakpoint 6, GLRenderManager::BindFramebufferAsTexture (this=0x5555572968d0, fb=0x7fff44007ab0, binding=0, aspectBit=16384)
    at Common/GPU/OpenGL/GLRenderManager.cpp:267
267	void GLRenderManager::BindFramebufferAsTexture(GLRFramebuffer *fb, int binding, int aspectBit) {
(gdb) bt
#0  GLRenderManager::BindFramebufferAsTexture (this=0x5555572968d0, fb=0x7fff44007ab0, binding=0, aspectBit=16384) at Common/GPU/OpenGL/GLRenderManager.cpp:267
#1  0x0000555555a32faf in PresentationCommon::BindSource (bindStereo=<optimized out>, binding=<optimized out>, this=<optimized out>) at GPU/Common/PresentationCommon.cpp:626
#2  PresentationCommon::BindSource (this=<optimized out>, binding=<optimized out>, bindStereo=<optimized out>) at GPU/Common/PresentationCommon.cpp:611
#3  0x0000555555a34634 in PresentationCommon::CopyToOutput (this=0x7fff44003cc0, flags=flags@entry=OutputFlags::BACKBUFFER_FLIPPED, uvRotation=uvRotation@entry=1, u0=u0@entry=0, 
    v0=v0@entry=0, u1=u1@entry=0.566666663, v1=v1@entry=1.7647059) at GPU/Common/PresentationCommon.cpp:889
#4  0x0000555555a27dfb in FramebufferManagerCommon::CopyDisplayToOutput (this=0x7fff44054a70, reallyDirty=reallyDirty@entry=true) at GPU/Common/FramebufferManagerCommon.cpp:1740
#5  0x0000555555b86112 in GPUCommonHW::CopyDisplayToOutput (this=0x7fff44023600, reallyDirty=<optimized out>) at GPU/GPUCommonHW.cpp:539
#6  0x00005555558a7711 in __DisplayFlip (cyclesLate=0) at Core/HLE/sceDisplay.cpp:650
#7  0x00005555558a7b12 in __DisplaySetFramebuf (topaddr=<optimized out>, linesize=<optimized out>, pixelFormat=<optimized out>, sync=0) at Core/HLE/sceDisplay.cpp:829
#8  __DisplaySetFramebuf (topaddr=<optimized out>, linesize=<optimized out>, pixelFormat=<optimized out>, sync=<optimized out>) at Core/HLE/sceDisplay.cpp:812
#9  0x00005555558a7d36 in sceDisplaySetFramebuf (sync=0, pixelformat=3, linesize=512, topaddr=<optimized out>) at Core/HLE/sceDisplay.cpp:905
#10 sceDisplaySetFramebuf (topaddr=67108864, linesize=512, pixelformat=3, sync=0) at Core/HLE/sceDisplay.cpp:846
#11 0x00005555558a9450 in WrapU_UIII<&(sceDisplaySetFramebuf(unsigned int, int, int, int))> () at ./Core/HLE/FunctionWrappers.h:687
#12 0x00005555558887cd in CallSyscallWithoutFlags (info=0x555556988d30 <sceDisplay+48>) at Core/HLE/HLE.cpp:659
#13 0x00005555359fecc0 in ?? ()
#14 0x00005555569e9940 in ?? ()
#15 0x00005555569e9940 in ?? ()
#16 0x0000000000000000 in ?? ()




Thread 54 "Emu" hit Breakpoint 6, GLRenderManager::BindFramebufferAsTexture (this=0x5555572968d0, fb=0x7fff44007ab0, binding=0, aspectBit=16384)
    at Common/GPU/OpenGL/GLRenderManager.cpp:267
267	void GLRenderManager::BindFramebufferAsTexture(GLRFramebuffer *fb, int binding, int aspectBit) {
(gdb) bt
#0  GLRenderManager::BindFramebufferAsTexture (this=0x5555572968d0, fb=0x7fff44007ab0, binding=0, aspectBit=16384) at Common/GPU/OpenGL/GLRenderManager.cpp:267
#1  0x0000555555a32faf in PresentationCommon::BindSource (bindStereo=<optimized out>, binding=<optimized out>, this=<optimized out>) at GPU/Common/PresentationCommon.cpp:626
#2  PresentationCommon::BindSource (this=<optimized out>, binding=<optimized out>, bindStereo=<optimized out>) at GPU/Common/PresentationCommon.cpp:611
#3  0x0000555555a34634 in PresentationCommon::CopyToOutput (this=0x7fff44003cc0, flags=flags@entry=OutputFlags::BACKBUFFER_FLIPPED, uvRotation=uvRotation@entry=1, u0=u0@entry=0, 
    v0=v0@entry=0, u1=u1@entry=0.566666663, v1=v1@entry=1.7647059) at GPU/Common/PresentationCommon.cpp:889
#4  0x0000555555a27dfb in FramebufferManagerCommon::CopyDisplayToOutput (this=0x7fff44054a70, reallyDirty=reallyDirty@entry=true) at GPU/Common/FramebufferManagerCommon.cpp:1740
#5  0x0000555555b86112 in GPUCommonHW::CopyDisplayToOutput (this=0x7fff44023600, reallyDirty=<optimized out>) at GPU/GPUCommonHW.cpp:539
#6  0x00005555558a7711 in __DisplayFlip (cyclesLate=0) at Core/HLE/sceDisplay.cpp:650
#7  0x00005555558a7b12 in __DisplaySetFramebuf (topaddr=<optimized out>, linesize=<optimized out>, pixelFormat=<optimized out>, sync=0) at Core/HLE/sceDisplay.cpp:829
#8  __DisplaySetFramebuf (topaddr=<optimized out>, linesize=<optimized out>, pixelFormat=<optimized out>, sync=<optimized out>) at Core/HLE/sceDisplay.cpp:812
#9  0x00005555558a7d36 in sceDisplaySetFramebuf (sync=0, pixelformat=3, linesize=512, topaddr=<optimized out>) at Core/HLE/sceDisplay.cpp:905
#10 sceDisplaySetFramebuf (topaddr=67108864, linesize=512, pixelformat=3, sync=0) at Core/HLE/sceDisplay.cpp:846
#11 0x00005555558a9450 in WrapU_UIII<&(sceDisplaySetFramebuf(unsigned int, int, int, int))> () at ./Core/HLE/FunctionWrappers.h:687
#12 0x00005555558887cd in CallSyscallWithoutFlags (info=0x555556988d30 <sceDisplay+48>) at Core/HLE/HLE.cpp:659
#13 0x00005555359fecc0 in ?? ()
#14 0x00005555569e9940 in ?? ()
#15 0x00005555569e9940 in ?? ()
#16 0x0000000000000000 in ?? ()



Thread 54 "Emu" hit Breakpoint 6, GLRenderManager::BindFramebufferAsTexture (this=0x5555572968d0, fb=0x7fff44007ab0, binding=1, aspectBit=16384)
    at Common/GPU/OpenGL/GLRenderManager.cpp:267
267	void GLRenderManager::BindFramebufferAsTexture(GLRFramebuffer *fb, int binding, int aspectBit) {
(gdb) bt
#0  GLRenderManager::BindFramebufferAsTexture (this=0x5555572968d0, fb=0x7fff44007ab0, binding=1, aspectBit=16384) at Common/GPU/OpenGL/GLRenderManager.cpp:267
#1  0x0000555555a32faf in PresentationCommon::BindSource (bindStereo=<optimized out>, binding=<optimized out>, this=<optimized out>) at GPU/Common/PresentationCommon.cpp:626
#2  PresentationCommon::BindSource (this=<optimized out>, binding=<optimized out>, bindStereo=<optimized out>) at GPU/Common/PresentationCommon.cpp:611
#3  0x0000555555a33fdb in PresentationCommon::CopyToOutput (this=0x7fff44003cc0, flags=flags@entry=OutputFlags::BACKBUFFER_FLIPPED, uvRotation=uvRotation@entry=1, u0=u0@entry=0, 
    v0=v0@entry=0, u1=u1@entry=0.566666663, v1=v1@entry=1.7647059) at GPU/Common/PresentationCommon.cpp:892
#4  0x0000555555a27dfb in FramebufferManagerCommon::CopyDisplayToOutput (this=0x7fff44054a70, reallyDirty=reallyDirty@entry=true) at GPU/Common/FramebufferManagerCommon.cpp:1740
#5  0x0000555555b86112 in GPUCommonHW::CopyDisplayToOutput (this=0x7fff44023600, reallyDirty=<optimized out>) at GPU/GPUCommonHW.cpp:539
#6  0x00005555558a7711 in __DisplayFlip (cyclesLate=0) at Core/HLE/sceDisplay.cpp:650
#7  0x00005555558a7b12 in __DisplaySetFramebuf (topaddr=<optimized out>, linesize=<optimized out>, pixelFormat=<optimized out>, sync=0) at Core/HLE/sceDisplay.cpp:829
#8  __DisplaySetFramebuf (topaddr=<optimized out>, linesize=<optimized out>, pixelFormat=<optimized out>, sync=<optimized out>) at Core/HLE/sceDisplay.cpp:812
#9  0x00005555558a7d36 in sceDisplaySetFramebuf (sync=0, pixelformat=3, linesize=512, topaddr=<optimized out>) at Core/HLE/sceDisplay.cpp:905
#10 sceDisplaySetFramebuf (topaddr=67108864, linesize=512, pixelformat=3, sync=0) at Core/HLE/sceDisplay.cpp:846
#11 0x00005555558a9450 in WrapU_UIII<&(sceDisplaySetFramebuf(unsigned int, int, int, int))> () at ./Core/HLE/FunctionWrappers.h:687
#12 0x00005555558887cd in CallSyscallWithoutFlags (info=0x555556988d30 <sceDisplay+48>) at Core/HLE/HLE.cpp:659
#13 0x00005555359fecc0 in ?? ()
#14 0x00005555569e9940 in ?? ()
#15 0x00005555569e9940 in ?? ()
#16 0x0000000000000000 in ?? ()



