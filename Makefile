# 5==waveshare gpm280z2, raspberry pi zero2w
# 4==raspberry pi 4b 64bit, 1.18.1
# 3==trimui brick
# 2==trimui smart pro
# 1==miyoo a30
# 0==xubuntu 20.04 64bit
MIYOO:=0

#Build ffmpeg linux aarch64 and armhf .a static library:  
#PATH=/home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin:$PATH ./linux_arm64.sh
#PATH=/home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin:$PATH ./linux_armhf.sh

#SDL/SDLJoystick.cpp
#<<<<<<<<<<<<getKeycodeForButton

#loading control pad mappings from gamecontrollerdb.txt: SUCCESS!
#found control pad: X360 Controller, loading mapping: SUCCESS, mapping is:
#see SDL/SDLJoystick.cpp


ifeq ($(MIYOO),5)
CC  := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc -mcpu=cortex-a7 -mfpu=neon -mfloat-abi=hard
CPP := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ -mcpu=cortex-a7 -mfpu=neon -mfloat-abi=hard
AR  := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ar cru
RANLIB := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ranlib
else ifeq ($(MIYOO),4)
CC := gcc
CPP := g++
AR := ar cru
RANLIB := ranlib
else ifeq ($(MIYOO),2)
CC  := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-gcc
CPP := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-g++
AR  := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-ar cru
RANLIB := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-ranlib
else ifeq ($(MIYOO),1)
CC  := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc -marm -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard
CPP := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ -marm -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard
AR  := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ar cru
RANLIB := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ranlib
else
#CC  := gcc
#CXX := g++
#AR  := ar
CC := gcc
CPP := g++
AR := ar cru
#ar qc
RANLIB := ranlib
endif
RM := rm -rf

CCFLAGS :=

#CCFLAGS += -g 
#-O3 -g0 some games will crash
ifeq ($(MIYOO),5)
CCFLAGS += -O3 -g0
#CCFLAGS += -D_DEBUG
CCFLAGS += -DNDEBUG
else
CCFLAGS += -O3 -g3
#CCFLAGS += -D_DEBUG
CCFLAGS += -DNDEBUG
endif

ifeq ($(MIYOO),5)
else ifeq ($(MIYOO),4)
else ifeq ($(MIYOO),2)
else ifeq ($(MIYOO),1)
else
endif

CCFLAGS += -DASSETS_DIR=\"/usr/local/share/ppsspp/assets/\" 

#for cpu_features
CCFLAGS += -DHAVE_DLFCN_H 
CCFLAGS += -DHAVE_STRONG_GETAUXVAL 

#for ext/glslang
CCFLAGS += -DENABLE_HLSL
CCFLAGS += -DENABLE_OPT=0
CCFLAGS += -DGLSLANG_OSINCLUDE_UNIX



CCFLAGS += -DHTTPS_NOT_AVAILABLE 
CCFLAGS += -DMINIUPNPC_SET_SOCKET_TIMEOUT 
CCFLAGS += -DMINIUPNP_STATICLIB 
CCFLAGS += -DPNG_ARM_NEON_OPT=0 
CCFLAGS += -DRC_DISABLE_LUA 
CCFLAGS += -DSDL #
CCFLAGS += -DSHARED_ZLIB #
CCFLAGS += -DSTACK_LINE_READER_BUFFER_SIZE=1024 
CCFLAGS += -DUSE_DISCORD=1 #
CCFLAGS += -DUSE_FFMPEG=1 #
CCFLAGS += -DUSING_GLES2 #

ifeq ($(MIYOO),5)
CCFLAGS += -DNO_SDLVULKAN=1 #
CCFLAGS += -DPPSSPP_PLATFORM_RPI=1
CCFLAGS += -U__GCC_HAVE_SYNC_COMPARE_AND_SWAP_2
CCFLAGS += -DNO_NATIVE_FRAME_SLEEP=1
CCFLAGS += -DUSE_MOTION_AS_JOYBUTTON=1
CCFLAGS += -DUSE_HIDE_SDL_SHOWCURSOR=1
else ifeq ($(MIYOO),4)
CCFLAGS += -DVK_USE_PLATFORM_XLIB_KHR #
else ifeq ($(MIYOO),2)
CCFLAGS += -DNO_SDLVULKAN=1 #
else ifeq ($(MIYOO),1)
CCFLAGS += -DNO_SDLVULKAN=1 #
else
CCFLAGS += -DVK_USE_PLATFORM_XLIB_KHR #
CCFLAGS += -DPC_NO_FULLSCREEN=1 #disable fullscreen
endif

CCFLAGS += -DWITH_UPNP 

CCFLAGS += -D_7ZIP_ST #for libchdr/deps/lzma-22.01


CCFLAGS += -D_BSD_SOURCE 
CCFLAGS += -D_DEFAULT_SOURCE 
CCFLAGS += -D_FILE_OFFSET_BITS=64 
CCFLAGS += -D_LARGEFILE64_SOURCE=1 
CCFLAGS += -D_POSIX_C_SOURCE=200112L 
CCFLAGS += -D_XOPEN_SOURCE=700 
CCFLAGS += -D_XOPEN_SOURCE_EXTENDED 
CCFLAGS += -D__BSD_VISIBLE=1 
CCFLAGS += -D__STDC_CONSTANT_MACROS 

#CCFLAGS += -D__SWITCH__ #for libchdr/deps/lzma-22.01
CCFLAGS += -DZSTD_DISABLE_ASM #for libzstd_static


CCFLAGS += -I. 
CCFLAGS += -I./include  #./build/include
CCFLAGS += -I./ext/glslang 
CCFLAGS += -I./ext/glew 
CCFLAGS += -I./ext/OpenXR-SDK/include 
CCFLAGS += -I./ext/libzip 
CCFLAGS += -I./ext/libpng17 
CCFLAGS += -I./ext/zstd/lib 
CCFLAGS += -I./ext/libchdr/deps/lzma-22.01/include #for libchdr
CCFLAGS += -I./ext/libchdr/include 
CCFLAGS += -I./ext/miniupnp/miniupnpc/src 
CCFLAGS += -I./ext/miniupnp/miniupnpc/include 
CCFLAGS += -I./ext/snappy 
CCFLAGS += -I./ext/cpu_features/include 
CCFLAGS += -I./ext/rcheevos/include 
CCFLAGS += -I./ext/rcheevos/src/rapi 
CCFLAGS += -I./ext/glslang 
CCFLAGS += -I./ext/SPIRV-Cross 
CCFLAGS += -I./ext/armips 
CCFLAGS += -I./ext/armips/ext/tinyformat 
CCFLAGS += -I./ext/armips/ext/filesystem/include 
CCFLAGS += -I./ext/zstd/lib 
CCFLAGS += -I./ext/discord-rpc/src 
CCFLAGS += -I./ext/discord-rpc/include 
CCFLAGS += -I./ext/rapidjson/include 

CCFLAGS += -I./ext/miniupnp/miniupnpc/src #for miniupnpc
CCFLAGS += -I./ext/miniupnp/miniupnpc/include #for miniupnpc

CCFLAGS += -I./Common #should put it to last
#FIXME: raspberry pi 4b
CCFLAGS += -isystem /opt/vc/include 
CCFLAGS += -isystem /opt/vc/include/interface/vcos/pthreads 
CCFLAGS += -isystem /opt/vc/include/interface/vmcx_host/linux

ifeq ($(MIYOO),5)
#FIXME:????-march
CCFLAGS += -isystem /home/wmt/work_a30/staging_dir/target/usr/include/SDL2
CCFLAGS += -isystem ./ffmpeg/linux/armv7rpi32/include  
CCFLAGS += -I./include/vc/include
CCFLAGS += -I/home/wmt/work_a30/staging_dir/target/usr/include
else ifeq ($(MIYOO),4)
CCFLAGS += -isystem /usr/include/SDL2
CCFLAGS += -isystem ./ffmpeg/linux/aarch64/include
#FIXME:raspberry pi
CCFLAGS += -march=armv8-a+crc 
CCFLAGS += -mtune=cortex-a72 
CCFLAGS += -funsafe-math-optimizations
else ifeq ($(MIYOO),2)
CCFLAGS += -isystem /home/wmt/work_trimui/usr/include/SDL2
CCFLAGS += -isystem ./ffmpeg/linux/aarch64/include  
CCFLAGS += -I/home/wmt/work_trimui/usr/include
else ifeq ($(MIYOO),1)
CCFLAGS += -isystem /home/wmt/work_a30/staging_dir/target/usr/include/SDL2
CCFLAGS += -isystem ./ffmpeg/linux/armv7/include  
CCFLAGS += -I/home/wmt/work_a30/staging_dir/target/usr/include
else
CCFLAGS += -isystem /usr/include/SDL2
CCFLAGS += -isystem ./ffmpeg/linux/x86_64/include  
CCFLAGS += -msse2 
endif

CCFLAGS += -Wno-multichar 
CCFLAGS += -Wno-psabi 

CCFLAGS += -fno-math-errno  
CCFLAGS += -fno-strict-aliasing 
CCFLAGS += -pthread 


CCFLAGS += -std=gnu++17


CCFLAGS += -Wall 
CCFLAGS += -Werror=return-type 
CCFLAGS += -Wno-unused-function 
CCFLAGS += -Wno-sign-compare 
CCFLAGS += -Wno-unused-but-set-variable 
CCFLAGS += -Wno-reorder 
CCFLAGS += -Wno-unknown-pragmas 
CCFLAGS += -Wno-unused-value 
CCFLAGS += -Wno-unused-variable 
CCFLAGS += -Wno-class-memaccess  
CCFLAGS += -Wformat 

CCFLAGS += -fPIC








LDFLAGS := 

#LDFLAGS += -funsafe-math-optimizations 
LDFLAGS += -pthread -lrt

LDFLAGS += -ldl 

ifeq ($(MIYOO),5)
LDFLAGS += -lSDL2 -lz -lbrcmGLESv2 -lbcm_host -lbrcmEGL -lvchiq_arm -lvcos -L./include/vc/lib -L/home/wmt/work_a30/staging_dir/target/usr/lib
LDFLAGS += ./ffmpeg/linux/armv7rpi32/lib/libavformat.a 
LDFLAGS += ./ffmpeg/linux/armv7rpi32/lib/libavcodec.a 
LDFLAGS += ./ffmpeg/linux/armv7rpi32/lib/libswresample.a 
LDFLAGS += ./ffmpeg/linux/armv7rpi32/lib/libswscale.a 
LDFLAGS += ./ffmpeg/linux/armv7rpi32/lib/libavutil.a
else ifeq ($(MIYOO),4)
#for raspberry pi 4b
LDFLAGS += -L/opt/vc/lib -lGLESv2 -lEGL
LDFLAGS += /usr/lib/aarch64-linux-gnu/libSM.so 
LDFLAGS += /usr/lib/aarch64-linux-gnu/libICE.so 
LDFLAGS += /usr/lib/aarch64-linux-gnu/libX11.so 
LDFLAGS += /usr/lib/aarch64-linux-gnu/libXext.so 
LDFLAGS += /usr/lib/aarch64-linux-gnu/libz.so
LDFLAGS += ./ffmpeg/linux/aarch64/lib/libavformat.a 
LDFLAGS += ./ffmpeg/linux/aarch64/lib/libavcodec.a 
LDFLAGS += ./ffmpeg/linux/aarch64/lib/libswresample.a 
LDFLAGS += ./ffmpeg/linux/aarch64/lib/libswscale.a 
LDFLAGS += ./ffmpeg/linux/aarch64/lib/libavutil.a
else ifeq ($(MIYOO),2)
LDFLAGS += /home/wmt/work_trimui/usr/lib/libSDL2.a 
LDFLAGS += /home/wmt/work_trimui/usr/lib/libz.a
LDFLAGS += /home/wmt/work_trimui/usr/lib/libEGL.so
LDFLAGS += /home/wmt/work_trimui/usr/lib/libGLESv2.so 
#for trimui smart pro
LDFLAGS += -lIMGegl -lsrv_um -lusc -lglslcompiler -L/home/wmt/work_trimui/usr/lib
LDFLAGS += ./ffmpeg/linux/aarch64/lib/libavformat.a 
LDFLAGS += ./ffmpeg/linux/aarch64/lib/libavcodec.a 
LDFLAGS += ./ffmpeg/linux/aarch64/lib/libswresample.a 
LDFLAGS += ./ffmpeg/linux/aarch64/lib/libswscale.a 
LDFLAGS += ./ffmpeg/linux/aarch64/lib/libavutil.a
else ifeq ($(MIYOO),1)
#LDFLAGS += /home/wmt/work_a30/staging_dir/target/usr/lib/libSDL2.a 
#LDFLAGS += /home/wmt/work_a30/staging_dir/target/usr/lib/libz.a
#LDFLAGS += /home/wmt/work_a30/staging_dir/target/usr/lib/libEGL.so 
#LDFLAGS += /home/wmt/work_a30/staging_dir/target/usr/lib/libGLESv2.so 
#for miyoo a30
LDFLAGS += -lSDL2 -lz -lGLESv2 -lEGL -L/home/wmt/work_a30/staging_dir/target/usr/lib
LDFLAGS += ./ffmpeg/linux/armv7/lib/libavformat.a 
LDFLAGS += ./ffmpeg/linux/armv7/lib/libavcodec.a 
LDFLAGS += ./ffmpeg/linux/armv7/lib/libswresample.a 
LDFLAGS += ./ffmpeg/linux/armv7/lib/libswscale.a 
LDFLAGS += ./ffmpeg/linux/armv7/lib/libavutil.a
else
LDFLAGS += /usr/lib/x86_64-linux-gnu/libSDL2.so 
LDFLAGS += /usr/lib/x86_64-linux-gnu/libz.so 
#LDFLAGS += /usr/lib/x86_64-linux-gnu/libSDL2_test.a #-DUSING_SDL_TEST
#LDFLAGS += /usr/lib/x86_64-linux-gnu/libGL.so 
#LDFLAGS += /usr/lib/x86_64-linux-gnu/libGLU.so 
LDFLAGS += /usr/lib/x86_64-linux-gnu/libEGL.so 
LDFLAGS += /usr/lib/x86_64-linux-gnu/libGLESv2.so 
LDFLAGS += ./ffmpeg/linux/x86_64/lib/libavformat.a 
LDFLAGS += ./ffmpeg/linux/x86_64/lib/libavcodec.a 
LDFLAGS += ./ffmpeg/linux/x86_64/lib/libswresample.a 
LDFLAGS += ./ffmpeg/linux/x86_64/lib/libswscale.a 
LDFLAGS += ./ffmpeg/linux/x86_64/lib/libavutil.a
endif 

LIBCORE_OBJS :=
LIBCORE_OBJS += Core/MIPS/IR/IRAnalysis.o 
LIBCORE_OBJS += Core/MIPS/IR/IRCompALU.o 
LIBCORE_OBJS += Core/MIPS/IR/IRCompBranch.o 
LIBCORE_OBJS += Core/MIPS/IR/IRCompFPU.o 
LIBCORE_OBJS += Core/MIPS/IR/IRCompLoadStore.o 
LIBCORE_OBJS += Core/MIPS/IR/IRCompVFPU.o 
LIBCORE_OBJS += Core/MIPS/IR/IRFrontend.o 
LIBCORE_OBJS += Core/MIPS/IR/IRInst.o 
LIBCORE_OBJS += Core/MIPS/IR/IRInterpreter.o 
LIBCORE_OBJS += Core/MIPS/IR/IRJit.o 
LIBCORE_OBJS += Core/MIPS/IR/IRNativeCommon.o 
LIBCORE_OBJS += Core/MIPS/IR/IRPassSimplify.o 
LIBCORE_OBJS += Core/MIPS/IR/IRRegCache.o 
LIBCORE_OBJS += Core/MIPS/ARM/ArmAsm.o 
LIBCORE_OBJS += Core/MIPS/ARM/ArmCompALU.o 
LIBCORE_OBJS += Core/MIPS/ARM/ArmCompBranch.o 
LIBCORE_OBJS += Core/MIPS/ARM/ArmCompFPU.o 
LIBCORE_OBJS += Core/MIPS/ARM/ArmCompLoadStore.o 
LIBCORE_OBJS += Core/MIPS/ARM/ArmCompVFPU.o 
LIBCORE_OBJS += Core/MIPS/ARM/ArmCompVFPUNEON.o 
LIBCORE_OBJS += Core/MIPS/ARM/ArmCompVFPUNEONUtil.o 
LIBCORE_OBJS += Core/MIPS/ARM/ArmCompReplace.o 
LIBCORE_OBJS += Core/MIPS/ARM/ArmJit.o 
LIBCORE_OBJS += Core/MIPS/ARM/ArmRegCache.o 
LIBCORE_OBJS += Core/MIPS/ARM/ArmRegCacheFPU.o 
LIBCORE_OBJS += GPU/Common/VertexDecoderArm.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64Asm.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64CompALU.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64CompBranch.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64CompFPU.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64CompLoadStore.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64CompVFPU.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64CompReplace.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64Jit.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64RegCache.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64RegCacheFPU.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64IRAsm.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64IRCompALU.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64IRCompBranch.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64IRCompFPU.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64IRCompLoadStore.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64IRCompSystem.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64IRCompVec.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64IRJit.o 
LIBCORE_OBJS += Core/MIPS/ARM64/Arm64IRRegCache.o 
LIBCORE_OBJS += GPU/Common/VertexDecoderArm64.o 
LIBCORE_OBJS += Core/Util/DisArm64.o 
LIBCORE_OBJS += Core/MIPS/x86/Asm.o 
LIBCORE_OBJS += Core/MIPS/x86/CompALU.o 
LIBCORE_OBJS += Core/MIPS/x86/CompBranch.o 
LIBCORE_OBJS += Core/MIPS/x86/CompFPU.o 
LIBCORE_OBJS += Core/MIPS/x86/CompLoadStore.o 
LIBCORE_OBJS += Core/MIPS/x86/CompVFPU.o 
LIBCORE_OBJS += Core/MIPS/x86/CompReplace.o 
LIBCORE_OBJS += Core/MIPS/x86/Jit.o 
LIBCORE_OBJS += Core/MIPS/x86/JitSafeMem.o 
LIBCORE_OBJS += Core/MIPS/x86/RegCache.o 
LIBCORE_OBJS += Core/MIPS/x86/RegCacheFPU.o 
LIBCORE_OBJS += Core/MIPS/x86/X64IRAsm.o 
LIBCORE_OBJS += Core/MIPS/x86/X64IRCompALU.o 
LIBCORE_OBJS += Core/MIPS/x86/X64IRCompBranch.o 
LIBCORE_OBJS += Core/MIPS/x86/X64IRCompFPU.o 
LIBCORE_OBJS += Core/MIPS/x86/X64IRCompLoadStore.o 
LIBCORE_OBJS += Core/MIPS/x86/X64IRCompSystem.o 
LIBCORE_OBJS += Core/MIPS/x86/X64IRCompVec.o 
LIBCORE_OBJS += Core/MIPS/x86/X64IRJit.o 
LIBCORE_OBJS += Core/MIPS/x86/X64IRRegCache.o 
LIBCORE_OBJS += GPU/Common/VertexDecoderX86.o 
LIBCORE_OBJS += GPU/Software/DrawPixelX86.o 
LIBCORE_OBJS += GPU/Software/SamplerX86.o 
LIBCORE_OBJS += Core/MIPS/MIPS/MipsJit.o 
LIBCORE_OBJS += Core/MIPS/RiscV/RiscVAsm.o 
LIBCORE_OBJS += Core/MIPS/RiscV/RiscVCompALU.o 
LIBCORE_OBJS += Core/MIPS/RiscV/RiscVCompBranch.o 
LIBCORE_OBJS += Core/MIPS/RiscV/RiscVCompFPU.o 
LIBCORE_OBJS += Core/MIPS/RiscV/RiscVCompLoadStore.o 
LIBCORE_OBJS += Core/MIPS/RiscV/RiscVCompSystem.o 
LIBCORE_OBJS += Core/MIPS/RiscV/RiscVCompVec.o 
LIBCORE_OBJS += Core/MIPS/RiscV/RiscVJit.o 
LIBCORE_OBJS += Core/MIPS/RiscV/RiscVRegCache.o 
LIBCORE_OBJS += GPU/Common/VertexDecoderRiscV.o 
LIBCORE_OBJS += Core/AVIDump.o 
LIBCORE_OBJS += Core/WaveFile.o 
LIBCORE_OBJS += Core/MIPS/JitCommon/JitCommon.o 
LIBCORE_OBJS += Core/MIPS/JitCommon/JitBlockCache.o 
LIBCORE_OBJS += Core/MIPS/JitCommon/JitState.o 
LIBCORE_OBJS += Core/Config.o 
LIBCORE_OBJS += Core/ConfigSettings.o 
LIBCORE_OBJS += Core/ControlMapper.o 
LIBCORE_OBJS += Core/Core.o 
LIBCORE_OBJS += Core/Compatibility.o 
LIBCORE_OBJS += Core/CoreTiming.o 
LIBCORE_OBJS += Core/CwCheat.o 
LIBCORE_OBJS += Core/FrameTiming.o 
LIBCORE_OBJS += Core/HDRemaster.o 
LIBCORE_OBJS += Core/Instance.o 
LIBCORE_OBJS += Core/KeyMap.o 
LIBCORE_OBJS += Core/KeyMapDefaults.o 
LIBCORE_OBJS += Core/RetroAchievements.o 
LIBCORE_OBJS += Core/TiltEventProcessor.o 
LIBCORE_OBJS += Core/WebServer.o 
LIBCORE_OBJS += Core/Debugger/Breakpoints.o 
LIBCORE_OBJS += Core/Debugger/MemBlockInfo.o 
LIBCORE_OBJS += Core/Debugger/SymbolMap.o 
LIBCORE_OBJS += Core/Debugger/DisassemblyManager.o 
LIBCORE_OBJS += Core/Debugger/WebSocket.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/BreakpointSubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/CPUCoreSubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/DisasmSubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/GameBroadcaster.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/GameSubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/ClientConfigSubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/GPUBufferSubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/GPURecordSubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/GPUStatsSubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/HLESubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/InputBroadcaster.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/InputSubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/LogBroadcaster.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/MemoryInfoSubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/MemorySubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/ReplaySubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/SteppingBroadcaster.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/SteppingSubscriber.o 
LIBCORE_OBJS += Core/Debugger/WebSocket/WebSocketUtils.o 
LIBCORE_OBJS += Core/Dialog/PSPDialog.o 
LIBCORE_OBJS += Core/Dialog/PSPGamedataInstallDialog.o 
LIBCORE_OBJS += Core/Dialog/PSPMsgDialog.o 
LIBCORE_OBJS += Core/Dialog/PSPNetconfDialog.o 
LIBCORE_OBJS += Core/Dialog/PSPNpSigninDialog.o 
LIBCORE_OBJS += Core/Dialog/PSPOskDialog.o 
LIBCORE_OBJS += Core/Dialog/PSPPlaceholderDialog.o 
LIBCORE_OBJS += Core/Dialog/PSPSaveDialog.o 
LIBCORE_OBJS += Core/Dialog/PSPScreenshotDialog.o 
LIBCORE_OBJS += Core/Dialog/SavedataParam.o 
LIBCORE_OBJS += Core/ELF/ElfReader.o 
LIBCORE_OBJS += Core/ELF/PBPReader.o 
LIBCORE_OBJS += Core/ELF/PrxDecrypter.o 
LIBCORE_OBJS += Core/ELF/ParamSFO.o 
LIBCORE_OBJS += Core/FileSystems/tlzrc.o 
LIBCORE_OBJS += Core/FileSystems/BlobFileSystem.o 
LIBCORE_OBJS += Core/FileSystems/BlockDevices.o 
LIBCORE_OBJS += Core/FileSystems/DirectoryFileSystem.o 
LIBCORE_OBJS += Core/FileSystems/FileSystem.o 
LIBCORE_OBJS += Core/FileSystems/ISOFileSystem.o 
LIBCORE_OBJS += Core/FileSystems/MetaFileSystem.o 
LIBCORE_OBJS += Core/FileSystems/VirtualDiscFileSystem.o 
LIBCORE_OBJS += Core/Font/PGF.o 
LIBCORE_OBJS += Core/HLE/HLE.o 
LIBCORE_OBJS += Core/HLE/ReplaceTables.o 
LIBCORE_OBJS += Core/HLE/HLEHelperThread.o 
LIBCORE_OBJS += Core/HLE/HLETables.o 
LIBCORE_OBJS += Core/HLE/KUBridge.o 
LIBCORE_OBJS += Core/HLE/Plugins.o 
LIBCORE_OBJS += Core/HLE/__sceAudio.o 
LIBCORE_OBJS += Core/HLE/sceAdler.o 
LIBCORE_OBJS += Core/HLE/AtracCtx.o 
LIBCORE_OBJS += Core/HLE/AtracCtx2.o 
LIBCORE_OBJS += Core/HLE/sceAtrac.o 
LIBCORE_OBJS += Core/HLE/sceAudio.o 
LIBCORE_OBJS += Core/HLE/sceAudiocodec.o 
LIBCORE_OBJS += Core/HLE/sceAudioRouting.o 
LIBCORE_OBJS += Core/HLE/sceCcc.o 
LIBCORE_OBJS += Core/HLE/sceChnnlsv.o 
LIBCORE_OBJS += Core/HLE/sceCtrl.o 
LIBCORE_OBJS += Core/HLE/sceDeflt.o 
LIBCORE_OBJS += Core/HLE/sceDisplay.o 
LIBCORE_OBJS += Core/HLE/sceDmac.o 
LIBCORE_OBJS += Core/HLE/sceG729.o 
LIBCORE_OBJS += Core/HLE/sceGameUpdate.o 
LIBCORE_OBJS += Core/HLE/sceGe.o 
LIBCORE_OBJS += Core/HLE/sceFont.o 
LIBCORE_OBJS += Core/HLE/sceHeap.o 
LIBCORE_OBJS += Core/HLE/sceHprm.o 
LIBCORE_OBJS += Core/HLE/sceHttp.o 
LIBCORE_OBJS += Core/HLE/sceImpose.o 
LIBCORE_OBJS += Core/HLE/sceIo.o 
LIBCORE_OBJS += Core/HLE/sceJpeg.o 
LIBCORE_OBJS += Core/HLE/sceKernel.o 
LIBCORE_OBJS += Core/HLE/sceKernelAlarm.o 
LIBCORE_OBJS += Core/HLE/sceKernelEventFlag.o 
LIBCORE_OBJS += Core/HLE/sceKernelHeap.o 
LIBCORE_OBJS += Core/HLE/sceKernelInterrupt.o 
LIBCORE_OBJS += Core/HLE/sceKernelMbx.o 
LIBCORE_OBJS += Core/HLE/sceKernelMemory.o 
LIBCORE_OBJS += Core/HLE/sceKernelModule.o 
LIBCORE_OBJS += Core/HLE/sceKernelMsgPipe.o 
LIBCORE_OBJS += Core/HLE/sceKernelMutex.o 
LIBCORE_OBJS += Core/HLE/sceKernelSemaphore.o 
LIBCORE_OBJS += Core/HLE/sceKernelThread.o 
LIBCORE_OBJS += Core/HLE/sceKernelTime.o 
LIBCORE_OBJS += Core/HLE/sceKernelVTimer.o 
LIBCORE_OBJS += Core/HLE/sceMpeg.o 
LIBCORE_OBJS += Core/HLE/sceNet.o 
LIBCORE_OBJS += Core/HLE/sceNetAdhoc.o 
LIBCORE_OBJS += Core/HLE/proAdhoc.o 
LIBCORE_OBJS += Core/HLE/proAdhocServer.o 
LIBCORE_OBJS += Core/HLE/sceOpenPSID.o 
LIBCORE_OBJS += Core/HLE/sceP3da.o 
LIBCORE_OBJS += Core/HLE/sceMt19937.o 
LIBCORE_OBJS += Core/HLE/sceMd5.o 
LIBCORE_OBJS += Core/HLE/sceMp4.o 
LIBCORE_OBJS += Core/HLE/sceMp3.o 
LIBCORE_OBJS += Core/HLE/sceParseHttp.o 
LIBCORE_OBJS += Core/HLE/sceParseUri.o 
LIBCORE_OBJS += Core/HLE/scePower.o 
LIBCORE_OBJS += Core/HLE/scePsmf.o 
LIBCORE_OBJS += Core/HLE/sceRtc.o 
LIBCORE_OBJS += Core/HLE/sceSas.o 
LIBCORE_OBJS += Core/HLE/sceSfmt19937.o 
LIBCORE_OBJS += Core/HLE/sceSha256.o 
LIBCORE_OBJS += Core/HLE/sceSircs.o 
LIBCORE_OBJS += Core/HLE/sceSsl.o 
LIBCORE_OBJS += Core/HLE/sceUmd.o 
LIBCORE_OBJS += Core/HLE/sceUsb.o 
LIBCORE_OBJS += Core/HLE/sceUsbAcc.o 
LIBCORE_OBJS += Core/HLE/sceUsbCam.o 
LIBCORE_OBJS += Core/HLE/sceUsbGps.o 
LIBCORE_OBJS += Core/HLE/sceUsbMic.o 
LIBCORE_OBJS += Core/HLE/sceUtility.o 
LIBCORE_OBJS += Core/HLE/sceVaudio.o 
LIBCORE_OBJS += Core/HLE/scePspNpDrm_user.o 
LIBCORE_OBJS += Core/HLE/sceNp.o 
LIBCORE_OBJS += Core/HLE/sceNp2.o 
LIBCORE_OBJS += Core/HLE/scePauth.o 
LIBCORE_OBJS += Core/HW/SimpleAudioDec.o 
LIBCORE_OBJS += Core/HW/Atrac3Standalone.o 
LIBCORE_OBJS += Core/HW/AsyncIOManager.o 
LIBCORE_OBJS += Core/HW/BufferQueue.o 
LIBCORE_OBJS += Core/HW/Camera.o 
LIBCORE_OBJS += Core/HW/Display.o 
LIBCORE_OBJS += Core/HW/MediaEngine.o 
LIBCORE_OBJS += Core/HW/MpegDemux.o 
LIBCORE_OBJS += Core/HW/MemoryStick.o 
LIBCORE_OBJS += Core/HW/SasAudio.o 
LIBCORE_OBJS += Core/HW/SasReverb.o 
LIBCORE_OBJS += Core/HW/StereoResampler.o 
LIBCORE_OBJS += Core/Loaders.o 
LIBCORE_OBJS += Core/FileLoaders/CachingFileLoader.o 
LIBCORE_OBJS += Core/FileLoaders/DiskCachingFileLoader.o 
LIBCORE_OBJS += Core/FileLoaders/HTTPFileLoader.o 
LIBCORE_OBJS += Core/FileLoaders/LocalFileLoader.o 
LIBCORE_OBJS += Core/FileLoaders/RamCachingFileLoader.o 
LIBCORE_OBJS += Core/FileLoaders/RetryingFileLoader.o 
LIBCORE_OBJS += Core/MIPS/MIPS.o 
LIBCORE_OBJS += Core/MIPS/MIPSAnalyst.o 
LIBCORE_OBJS += Core/MIPS/MIPSCodeUtils.o 
LIBCORE_OBJS += Core/MIPS/MIPSDebugInterface.o 
LIBCORE_OBJS += Core/MIPS/MIPSDis.o 
LIBCORE_OBJS += Core/MIPS/MIPSDisVFPU.o 
LIBCORE_OBJS += Core/MIPS/MIPSInt.o 
LIBCORE_OBJS += Core/MIPS/MIPSIntVFPU.o 
LIBCORE_OBJS += Core/MIPS/MIPSStackWalk.o 
LIBCORE_OBJS += Core/MIPS/MIPSTables.o 
LIBCORE_OBJS += Core/MIPS/MIPSVFPUUtils.o 
LIBCORE_OBJS += Core/MIPS/MIPSVFPUFallbacks.o 
LIBCORE_OBJS += Core/MIPS/MIPSAsm.o 
LIBCORE_OBJS += Core/MIPS/MIPSTracer.o 
LIBCORE_OBJS += Core/MemFault.o 
LIBCORE_OBJS += Core/MemMap.o 
LIBCORE_OBJS += Core/MemMapFunctions.o 
LIBCORE_OBJS += Core/PSPLoaders.o 
LIBCORE_OBJS += Core/Reporting.o 
LIBCORE_OBJS += Core/Replay.o 
LIBCORE_OBJS += Core/SaveState.o 
LIBCORE_OBJS += Core/Screenshot.o 
LIBCORE_OBJS += Core/System.o 
LIBCORE_OBJS += Core/ThreadPools.o 
LIBCORE_OBJS += Core/Util/AudioFormat.o 
LIBCORE_OBJS += Core/Util/GameManager.o 
LIBCORE_OBJS += Core/Util/MemStick.o 
LIBCORE_OBJS += Core/Util/GameDB.o 
LIBCORE_OBJS += Core/Util/PortManager.o 
LIBCORE_OBJS += Core/Util/BlockAllocator.o 
LIBCORE_OBJS += Core/Util/PPGeDraw.o 
LIBCORE_OBJS += GPU/GLES/StencilBufferGLES.o 
LIBCORE_OBJS += GPU/GLES/GPU_GLES.o 
LIBCORE_OBJS += GPU/GLES/FragmentTestCacheGLES.o 
LIBCORE_OBJS += GPU/GLES/FramebufferManagerGLES.o 
LIBCORE_OBJS += GPU/GLES/ShaderManagerGLES.o 
LIBCORE_OBJS += GPU/GLES/StateMappingGLES.o 
LIBCORE_OBJS += GPU/GLES/TextureCacheGLES.o 
LIBCORE_OBJS += GPU/GLES/DrawEngineGLES.o 
LIBCORE_OBJS += GPU/Vulkan/DebugVisVulkan.o 
LIBCORE_OBJS += GPU/Vulkan/DrawEngineVulkan.o 
LIBCORE_OBJS += GPU/Vulkan/FramebufferManagerVulkan.o 
LIBCORE_OBJS += GPU/Vulkan/GPU_Vulkan.o 
LIBCORE_OBJS += GPU/Vulkan/PipelineManagerVulkan.o 
LIBCORE_OBJS += GPU/Vulkan/ShaderManagerVulkan.o 
LIBCORE_OBJS += GPU/Vulkan/StateMappingVulkan.o 
LIBCORE_OBJS += GPU/Vulkan/TextureCacheVulkan.o 
LIBCORE_OBJS += GPU/Vulkan/VulkanUtil.o 
LIBCORE_OBJS += GPU/Common/Draw2D.o 
LIBCORE_OBJS += GPU/Common/DepthBufferCommon.o 
LIBCORE_OBJS += GPU/Common/TextureShaderCommon.o 
LIBCORE_OBJS += GPU/Common/DepalettizeShaderCommon.o 
LIBCORE_OBJS += GPU/Common/FragmentShaderGenerator.o 
LIBCORE_OBJS += GPU/Common/VertexShaderGenerator.o 
LIBCORE_OBJS += GPU/Common/GeometryShaderGenerator.o 
LIBCORE_OBJS += GPU/Common/FramebufferManagerCommon.o 
LIBCORE_OBJS += GPU/Common/GPUDebugInterface.o 
LIBCORE_OBJS += GPU/Common/GPUStateUtils.o 
LIBCORE_OBJS += GPU/Common/DrawEngineCommon.o 
LIBCORE_OBJS += GPU/Common/PresentationCommon.o 
LIBCORE_OBJS += GPU/Common/ReinterpretFramebuffer.o 
LIBCORE_OBJS += GPU/Common/ShaderId.o 
LIBCORE_OBJS += GPU/Common/ShaderUniforms.o 
LIBCORE_OBJS += GPU/Common/ShaderCommon.o 
LIBCORE_OBJS += GPU/Common/SplineCommon.o 
LIBCORE_OBJS += GPU/Common/StencilCommon.o 
LIBCORE_OBJS += GPU/Common/SoftwareTransformCommon.o 
LIBCORE_OBJS += GPU/Common/VertexDecoderCommon.o 
LIBCORE_OBJS += GPU/Common/VertexDecoderHandwritten.o 
LIBCORE_OBJS += GPU/Common/TransformCommon.o 
LIBCORE_OBJS += GPU/Common/IndexGenerator.o 
LIBCORE_OBJS += GPU/Common/TextureDecoder.o 
LIBCORE_OBJS += GPU/Common/TextureCacheCommon.o 
LIBCORE_OBJS += GPU/Common/TextureScalerCommon.o 
LIBCORE_OBJS += GPU/Common/PostShader.o 
LIBCORE_OBJS += GPU/Common/TextureReplacer.o 
LIBCORE_OBJS += GPU/Common/ReplacedTexture.o 
LIBCORE_OBJS += GPU/Debugger/Breakpoints.o 
LIBCORE_OBJS += GPU/Debugger/Debugger.o 
LIBCORE_OBJS += GPU/Debugger/GECommandTable.o 
LIBCORE_OBJS += GPU/Debugger/Playback.o 
LIBCORE_OBJS += GPU/Debugger/Record.o 
LIBCORE_OBJS += GPU/Debugger/Stepping.o 
LIBCORE_OBJS += GPU/GeConstants.o 
LIBCORE_OBJS += GPU/GeDisasm.o 
LIBCORE_OBJS += GPU/GPU.o 
LIBCORE_OBJS += GPU/GPUCommon.o 
LIBCORE_OBJS += GPU/GPUCommonHW.o 
LIBCORE_OBJS += GPU/GPUState.o 
LIBCORE_OBJS += GPU/Math3D.o 
LIBCORE_OBJS += GPU/Software/BinManager.o 
LIBCORE_OBJS += GPU/Software/Clipper.o 
LIBCORE_OBJS += GPU/Software/DrawPixel.o 
LIBCORE_OBJS += GPU/Software/FuncId.o 
LIBCORE_OBJS += GPU/Software/Lighting.o 
LIBCORE_OBJS += GPU/Software/Rasterizer.o 
LIBCORE_OBJS += GPU/Software/RasterizerRectangle.o 
LIBCORE_OBJS += GPU/Software/RasterizerRegCache.o 
LIBCORE_OBJS += GPU/Software/Sampler.o 
LIBCORE_OBJS += GPU/Software/SoftGpu.o 
LIBCORE_OBJS += GPU/Software/TransformUnit.o 
LIBCORE_OBJS += ext/disarm.o 
LIBCORE_OBJS += ext/riscv-disas.o 
LIBCORE_OBJS += git-version.o

LIBCOMMON_OBJS := 
LIBCOMMON_OBJS += Common/ABI.o 
LIBCOMMON_OBJS += Common/CPUDetect.o 
LIBCOMMON_OBJS += Common/Thunk.o 
LIBCOMMON_OBJS += Common/x64Analyzer.o 
LIBCOMMON_OBJS += Common/x64Emitter.o 
LIBCOMMON_OBJS += Common/ArmCPUDetect.o 
LIBCOMMON_OBJS += Common/ArmEmitter.o 
LIBCOMMON_OBJS += Common/Arm64Emitter.o 
LIBCOMMON_OBJS += Core/Util/DisArm64.o 
LIBCOMMON_OBJS += Common/MipsCPUDetect.o 
LIBCOMMON_OBJS += Common/MipsEmitter.o 
LIBCOMMON_OBJS += Core/MIPS/JitCommon/JitCommon.o 
LIBCOMMON_OBJS += Core/MIPS/JitCommon/JitBlockCache.o 
LIBCOMMON_OBJS += Core/MIPS/JitCommon/JitState.o 
LIBCOMMON_OBJS += Common/RiscVCPUDetect.o 
LIBCOMMON_OBJS += Common/RiscVEmitter.o 
LIBCOMMON_OBJS += Core/MIPS/fake/FakeJit.o 
LIBCOMMON_OBJS += Common/LoongArchCPUDetect.o 
LIBCOMMON_OBJS += Common/VR/OpenXRLoader.o 
LIBCOMMON_OBJS += Common/VR/PPSSPPVR.o 
LIBCOMMON_OBJS += Common/VR/VRBase.o 
LIBCOMMON_OBJS += Common/VR/VRFramebuffer.o 
LIBCOMMON_OBJS += Common/VR/VRInput.o 
LIBCOMMON_OBJS += Common/VR/VRMath.o 
LIBCOMMON_OBJS += Common/VR/VRRenderer.o 
LIBCOMMON_OBJS += Common/Serialize/Serializer.o 
LIBCOMMON_OBJS += Common/Crypto/md5.o 
LIBCOMMON_OBJS += Common/Crypto/sha1.o 
LIBCOMMON_OBJS += Common/Crypto/sha256.o 
LIBCOMMON_OBJS += Common/Data/Color/RGBAUtil.o 
LIBCOMMON_OBJS += Common/Data/Convert/ColorConv.o 
LIBCOMMON_OBJS += Common/Data/Convert/SmallDataConvert.o 
LIBCOMMON_OBJS += Common/Data/Encoding/Base64.o 
LIBCOMMON_OBJS += Common/Data/Encoding/Compression.o 
LIBCOMMON_OBJS += Common/Data/Encoding/Utf8.o 
LIBCOMMON_OBJS += Common/Data/Format/RIFF.o 
LIBCOMMON_OBJS += Common/Data/Format/IniFile.o 
LIBCOMMON_OBJS += Common/Data/Format/JSONReader.o 
LIBCOMMON_OBJS += Common/Data/Format/JSONWriter.o 
LIBCOMMON_OBJS += Common/Data/Format/DDSLoad.o 
LIBCOMMON_OBJS += Common/Data/Format/PNGLoad.o 
LIBCOMMON_OBJS += Common/Data/Format/ZIMLoad.o 
LIBCOMMON_OBJS += Common/Data/Format/ZIMSave.o 
LIBCOMMON_OBJS += Common/Data/Hash/Hash.o 
LIBCOMMON_OBJS += Common/Data/Text/I18n.o 
LIBCOMMON_OBJS += Common/Data/Text/Parsers.o 
LIBCOMMON_OBJS += Common/Data/Text/WrapText.o 
LIBCOMMON_OBJS += Common/File/VFS/VFS.o 
LIBCOMMON_OBJS += Common/File/VFS/ZipFileReader.o 
LIBCOMMON_OBJS += Common/File/VFS/DirectoryReader.o 
LIBCOMMON_OBJS += Common/File/AndroidStorage.o 
LIBCOMMON_OBJS += Common/File/AndroidContentURI.o 
LIBCOMMON_OBJS += Common/File/DiskFree.o 
LIBCOMMON_OBJS += Common/File/Path.o 
LIBCOMMON_OBJS += Common/File/PathBrowser.o 
LIBCOMMON_OBJS += Common/File/FileUtil.o 
LIBCOMMON_OBJS += Common/File/DirListing.o 
LIBCOMMON_OBJS += Common/File/FileDescriptor.o 
LIBCOMMON_OBJS += Common/GPU/GPUBackendCommon.o 
LIBCOMMON_OBJS += Common/GPU/thin3d.o 
LIBCOMMON_OBJS += Common/GPU/Shader.o 
LIBCOMMON_OBJS += Common/GPU/ShaderWriter.o 
LIBCOMMON_OBJS += Common/GPU/ShaderTranslation.o 
LIBCOMMON_OBJS += Common/GPU/OpenGL/GLDebugLog.o 
LIBCOMMON_OBJS += Common/GPU/OpenGL/GLSLProgram.o 
LIBCOMMON_OBJS += Common/GPU/OpenGL/gl3stub.o 
LIBCOMMON_OBJS += Common/GPU/OpenGL/GLFeatures.o 
LIBCOMMON_OBJS += Common/GPU/OpenGL/GLFrameData.o 
LIBCOMMON_OBJS += Common/GPU/OpenGL/thin3d_gl.o 
LIBCOMMON_OBJS += Common/GPU/OpenGL/GLMemory.o 
LIBCOMMON_OBJS += Common/GPU/OpenGL/GLRenderManager.o 
LIBCOMMON_OBJS += Common/GPU/OpenGL/GLQueueRunner.o 
LIBCOMMON_OBJS += Common/GPU/OpenGL/DataFormatGL.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/VulkanBarrier.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/VulkanDebug.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/VulkanContext.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/VulkanDescSet.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/VulkanFramebuffer.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/VulkanImage.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/VulkanLoader.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/VulkanMemory.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/VulkanProfiler.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/thin3d_vulkan.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/VulkanRenderManager.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/VulkanQueueRunner.o 
LIBCOMMON_OBJS += Common/GPU/Vulkan/VulkanFrameData.o 
LIBCOMMON_OBJS += Common/Input/GestureDetector.o 
LIBCOMMON_OBJS += Common/Input/InputState.o 
LIBCOMMON_OBJS += Common/Math/fast/fast_matrix.o 
LIBCOMMON_OBJS += Common/Math/curves.o 
LIBCOMMON_OBJS += Common/Math/expression_parser.o 
LIBCOMMON_OBJS += Common/Math/lin/matrix4x4.o 
LIBCOMMON_OBJS += Common/Math/lin/vec3.o 
LIBCOMMON_OBJS += Common/Math/math_util.o 
LIBCOMMON_OBJS += Common/Math/Statistics.o 
LIBCOMMON_OBJS += Common/Net/HTTPClient.o 
LIBCOMMON_OBJS += Common/Net/HTTPHeaders.o 
LIBCOMMON_OBJS += Common/Net/HTTPNaettRequest.o 
LIBCOMMON_OBJS += Common/Net/HTTPRequest.o 
LIBCOMMON_OBJS += Common/Net/HTTPServer.o 
LIBCOMMON_OBJS += Common/Net/NetBuffer.o 
LIBCOMMON_OBJS += Common/Net/Resolve.o 
LIBCOMMON_OBJS += Common/Net/Sinks.o 
LIBCOMMON_OBJS += Common/Net/URL.o 
LIBCOMMON_OBJS += Common/Net/WebsocketServer.o 
LIBCOMMON_OBJS += Common/Profiler/Profiler.o 
LIBCOMMON_OBJS += Common/Render/TextureAtlas.o 
LIBCOMMON_OBJS += Common/Render/DrawBuffer.o 
LIBCOMMON_OBJS += Common/Render/ManagedTexture.o 
LIBCOMMON_OBJS += Common/Render/Text/draw_text.o 
LIBCOMMON_OBJS += Common/Render/Text/draw_text_android.o 
LIBCOMMON_OBJS += Common/Render/Text/draw_text_sdl.o 
LIBCOMMON_OBJS += Common/Render/Text/draw_text_win.o 
LIBCOMMON_OBJS += Common/Render/Text/draw_text_uwp.o 
LIBCOMMON_OBJS += Common/System/Display.o 
LIBCOMMON_OBJS += Common/System/Request.o 
LIBCOMMON_OBJS += Common/System/OSD.o 
LIBCOMMON_OBJS += Common/Thread/ParallelLoop.o 
LIBCOMMON_OBJS += Common/Thread/ThreadUtil.o 
LIBCOMMON_OBJS += Common/Thread/ThreadManager.o 
LIBCOMMON_OBJS += Common/UI/AsyncImageFileView.o 
LIBCOMMON_OBJS += Common/UI/Root.o 
LIBCOMMON_OBJS += Common/UI/Screen.o 
LIBCOMMON_OBJS += Common/UI/UI.o 
LIBCOMMON_OBJS += Common/UI/Context.o 
LIBCOMMON_OBJS += Common/UI/IconCache.o 
LIBCOMMON_OBJS += Common/UI/UIScreen.o 
LIBCOMMON_OBJS += Common/UI/Tween.o 
LIBCOMMON_OBJS += Common/UI/View.o 
LIBCOMMON_OBJS += Common/UI/ViewGroup.o 
LIBCOMMON_OBJS += Common/UI/ScrollView.o 
LIBCOMMON_OBJS += Common/UI/PopupScreens.o 
LIBCOMMON_OBJS += Common/Buffer.o 
LIBCOMMON_OBJS += Common/FakeCPUDetect.o 
LIBCOMMON_OBJS += Common/ExceptionHandlerSetup.o 
LIBCOMMON_OBJS += Common/Log.o 
LIBCOMMON_OBJS += Common/Log/ConsoleListener.o 
LIBCOMMON_OBJS += Common/Log/StdioListener.o 
LIBCOMMON_OBJS += Common/Log/LogManager.o 
LIBCOMMON_OBJS += Common/LogReporting.o 
LIBCOMMON_OBJS += Common/MemArenaAndroid.o 
LIBCOMMON_OBJS += Common/MemArenaDarwin.o 
LIBCOMMON_OBJS += Common/MemArenaPosix.o 
LIBCOMMON_OBJS += Common/MemArenaWin32.o 
LIBCOMMON_OBJS += Common/MemArenaHorizon.o 
LIBCOMMON_OBJS += Common/MemoryUtil.o 
LIBCOMMON_OBJS += Common/MemoryUtilHorizon.o 
LIBCOMMON_OBJS += Common/OSVersion.o 
LIBCOMMON_OBJS += Common/StringUtils.o 
LIBCOMMON_OBJS += Common/SysError.o 
LIBCOMMON_OBJS += Common/TimeUtil.o

LIBSNAPPY_OBJS := 
LIBSNAPPY_OBJS += ext/snappy/snappy-c.o 
LIBSNAPPY_OBJS += ext/snappy/snappy-sinksource.o 
LIBSNAPPY_OBJS += ext/snappy/snappy-stubs-internal.o 
LIBSNAPPY_OBJS += ext/snappy/snappy.o

LIBNATIVE_OBJS := 
LIBNATIVE_OBJS += SDL/SDLJoystick.o 
LIBNATIVE_OBJS += SDL/SDLMain.o 
LIBNATIVE_OBJS += SDL/SDLGLGraphicsContext.o 
LIBNATIVE_OBJS += SDL/SDLVulkanGraphicsContext.o 
LIBNATIVE_OBJS += Common/Render/Text/draw_text_qt.o 
LIBNATIVE_OBJS += ext/jpge/jpgd.o 
LIBNATIVE_OBJS += ext/jpge/jpge.o

LIBCPU_FEATURES_OBJS := 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_aarch64_linux_or_android.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_aarch64_macos_or_iphone.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_aarch64_windows.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_arm_linux_or_android.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_loongarch_linux.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_mips_linux_or_android.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_ppc_linux.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_riscv_linux.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_s390x_linux.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_x86_freebsd.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_x86_linux_or_android.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_x86_macos.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/impl_x86_windows.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/filesystem.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/stack_line_reader.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/string_view.o 
LIBCPU_FEATURES_OBJS += ext/cpu_features/src/hwcaps.o

LIBLIBZIP_OBJS :=
LIBLIBZIP_OBJS += ext/libzip/zip_add.o 
LIBLIBZIP_OBJS += ext/libzip/zip_add_dir.o 
LIBLIBZIP_OBJS += ext/libzip/zip_add_entry.o 
LIBLIBZIP_OBJS += ext/libzip/zip_algorithm_deflate.o 
LIBLIBZIP_OBJS += ext/libzip/zip_buffer.o 
LIBLIBZIP_OBJS += ext/libzip/zip_close.o 
LIBLIBZIP_OBJS += ext/libzip/zip_delete.o 
LIBLIBZIP_OBJS += ext/libzip/zip_dir_add.o 
LIBLIBZIP_OBJS += ext/libzip/zip_dirent.o 
LIBLIBZIP_OBJS += ext/libzip/zip_discard.o 
LIBLIBZIP_OBJS += ext/libzip/zip_entry.o 
LIBLIBZIP_OBJS += ext/libzip/zip_error.o 
LIBLIBZIP_OBJS += ext/libzip/zip_error_clear.o 
LIBLIBZIP_OBJS += ext/libzip/zip_error_get.o 
LIBLIBZIP_OBJS += ext/libzip/zip_error_get_sys_type.o 
LIBLIBZIP_OBJS += ext/libzip/zip_error_strerror.o 
LIBLIBZIP_OBJS += ext/libzip/zip_error_to_str.o 
LIBLIBZIP_OBJS += ext/libzip/zip_extra_field.o 
LIBLIBZIP_OBJS += ext/libzip/zip_extra_field_api.o 
LIBLIBZIP_OBJS += ext/libzip/zip_fclose.o 
LIBLIBZIP_OBJS += ext/libzip/zip_fdopen.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_add.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_error_clear.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_error_get.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_get_comment.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_get_external_attributes.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_get_offset.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_rename.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_replace.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_set_comment.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_set_encryption.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_set_external_attributes.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_set_mtime.o 
LIBLIBZIP_OBJS += ext/libzip/zip_file_strerror.o 
LIBLIBZIP_OBJS += ext/libzip/zip_fopen.o 
LIBLIBZIP_OBJS += ext/libzip/zip_fopen_encrypted.o 
LIBLIBZIP_OBJS += ext/libzip/zip_fopen_index.o 
LIBLIBZIP_OBJS += ext/libzip/zip_fopen_index_encrypted.o 
LIBLIBZIP_OBJS += ext/libzip/zip_fread.o 
LIBLIBZIP_OBJS += ext/libzip/zip_fseek.o 
LIBLIBZIP_OBJS += ext/libzip/zip_ftell.o 
LIBLIBZIP_OBJS += ext/libzip/zip_get_archive_comment.o 
LIBLIBZIP_OBJS += ext/libzip/zip_get_archive_flag.o 
LIBLIBZIP_OBJS += ext/libzip/zip_get_encryption_implementation.o 
LIBLIBZIP_OBJS += ext/libzip/zip_get_file_comment.o 
LIBLIBZIP_OBJS += ext/libzip/zip_get_name.o 
LIBLIBZIP_OBJS += ext/libzip/zip_get_num_entries.o 
LIBLIBZIP_OBJS += ext/libzip/zip_get_num_files.o 
LIBLIBZIP_OBJS += ext/libzip/zip_hash.o 
LIBLIBZIP_OBJS += ext/libzip/zip_io_util.o 
LIBLIBZIP_OBJS += ext/libzip/zip_libzip_version.o 
LIBLIBZIP_OBJS += ext/libzip/zip_memdup.o 
LIBLIBZIP_OBJS += ext/libzip/zip_name_locate.o 
LIBLIBZIP_OBJS += ext/libzip/zip_new.o 
LIBLIBZIP_OBJS += ext/libzip/zip_open.o 
LIBLIBZIP_OBJS += ext/libzip/zip_pkware.o 
LIBLIBZIP_OBJS += ext/libzip/zip_progress.o 
LIBLIBZIP_OBJS += ext/libzip/zip_rename.o 
LIBLIBZIP_OBJS += ext/libzip/zip_replace.o 
LIBLIBZIP_OBJS += ext/libzip/zip_set_archive_comment.o 
LIBLIBZIP_OBJS += ext/libzip/zip_set_archive_flag.o 
LIBLIBZIP_OBJS += ext/libzip/zip_set_default_password.o 
LIBLIBZIP_OBJS += ext/libzip/zip_set_file_comment.o 
LIBLIBZIP_OBJS += ext/libzip/zip_set_file_compression.o 
LIBLIBZIP_OBJS += ext/libzip/zip_set_name.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_accept_empty.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_begin_write.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_begin_write_cloning.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_buffer.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_call.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_close.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_commit_write.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_compress.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_crc.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_error.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_file_common.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_file_stdio.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_free.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_function.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_get_file_attributes.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_is_deleted.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_layered.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_open.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_pkware_decode.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_pkware_encode.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_read.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_remove.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_rollback_write.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_seek.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_seek_write.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_stat.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_supports.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_tell.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_tell_write.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_window.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_write.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_zip.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_zip_new.o 
LIBLIBZIP_OBJS += ext/libzip/zip_stat.o 
LIBLIBZIP_OBJS += ext/libzip/zip_stat_index.o 
LIBLIBZIP_OBJS += ext/libzip/zip_stat_init.o 
LIBLIBZIP_OBJS += ext/libzip/zip_strerror.o 
LIBLIBZIP_OBJS += ext/libzip/zip_string.o 
LIBLIBZIP_OBJS += ext/libzip/zip_unchange.o 
LIBLIBZIP_OBJS += ext/libzip/zip_unchange_all.o 
LIBLIBZIP_OBJS += ext/libzip/zip_unchange_archive.o 
LIBLIBZIP_OBJS += ext/libzip/zip_unchange_data.o 
LIBLIBZIP_OBJS += ext/libzip/zip_utf-8.o 
LIBLIBZIP_OBJS += ext/libzip/zip_err_str.o 
LIBLIBZIP_OBJS += ext/libzip/zip_mkstempm.o 
LIBLIBZIP_OBJS += ext/libzip/zip_source_file_stdio_named.o 
LIBLIBZIP_OBJS += ext/libzip/zip_random_unix.o

LIBPNG17_OBJS :=
LIBPNG17_OBJS += ext/libpng17/png.o 
LIBPNG17_OBJS += ext/libpng17/pngerror.o 
LIBPNG17_OBJS += ext/libpng17/pngget.o 
LIBPNG17_OBJS += ext/libpng17/pngmem.o 
LIBPNG17_OBJS += ext/libpng17/pngpread.o 
LIBPNG17_OBJS += ext/libpng17/pngread.o 
LIBPNG17_OBJS += ext/libpng17/pngrio.o 
LIBPNG17_OBJS += ext/libpng17/pngrtran.o 
LIBPNG17_OBJS += ext/libpng17/pngrutil.o 
LIBPNG17_OBJS += ext/libpng17/pngset.o 
LIBPNG17_OBJS += ext/libpng17/pngtrans.o 
LIBPNG17_OBJS += ext/libpng17/pngwio.o 
LIBPNG17_OBJS += ext/libpng17/pngwrite.o 
LIBPNG17_OBJS += ext/libpng17/pngwtran.o 
LIBPNG17_OBJS += ext/libpng17/pngwutil.o 
LIBPNG17_OBJS += ext/libpng17/arm/arm_init.o 
LIBPNG17_OBJS += ext/libpng17/arm/filter_neon_intrinsics.o

LIBBASIS_UNIVERSAL_OBJS := 
LIBBASIS_UNIVERSAL_OBJS += ext/basis_universal/basisu_transcoder.o

LIBVMA_OBJS := 
LIBVMA_OBJS += ext/vma/vk_mem_alloc.o

LIBGASON_OBJS := 
LIBGASON_OBJS += ext/gason/gason.o

LIBCHDR_OBJS := 	
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/Alloc.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/Bcj2.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/Bcj2Enc.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/Bra.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/Bra86.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/CpuArch.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/Delta.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/LzFind.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/LzFindOpt.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/LzmaDec.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/LzmaEnc.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/Lzma86Dec.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/Lzma86Enc.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/LzmaLib.o 
LIBCHDR_OBJS += ext/libchdr/deps/lzma-22.01/src/Sort.o 
LIBCHDR_OBJS += ext/libchdr/src/libchdr_bitstream.o 
LIBCHDR_OBJS += ext/libchdr/src/libchdr_cdrom.o 
LIBCHDR_OBJS += ext/libchdr/src/libchdr_chd.o 
LIBCHDR_OBJS += ext/libchdr/src/libchdr_flac.o 
LIBCHDR_OBJS += ext/libchdr/src/libchdr_huffman.o

LIBUDIS86_OBJS := 
LIBUDIS86_OBJS += ext/udis86/decode.o 
LIBUDIS86_OBJS += ext/udis86/itab.o 
LIBUDIS86_OBJS += ext/udis86/syn-att.o 
LIBUDIS86_OBJS += ext/udis86/syn-intel.o 
LIBUDIS86_OBJS += ext/udis86/syn.o 
LIBUDIS86_OBJS += ext/udis86/udis86.o

LIBKIRK_OBJS := 
LIBKIRK_OBJS += ext/libkirk/AES.o 
LIBKIRK_OBJS += ext/libkirk/amctrl.o 
LIBKIRK_OBJS += ext/libkirk/SHA1.o 
LIBKIRK_OBJS += ext/libkirk/bn.o 
LIBKIRK_OBJS += ext/libkirk/ec.o 
LIBKIRK_OBJS += ext/libkirk/kirk_engine.o

LIBCITYHASH_OBJS := 
LIBCITYHASH_OBJS += ext/cityhash/city.o

LIBSFMT19937_OBJS := 
LIBSFMT19937_OBJS += ext/sfmt19937/SFMT.o

LIBXBRZ_OBJS := 
LIBXBRZ_OBJS += ext/xbrz/xbrz.o

LIBXXHASH_OBJS := 
LIBXXHASH_OBJS += ext/xxhash.o

LIBRCHEEVOS_OBJS := 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rapi/rc_api_common.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rapi/rc_api_editor.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rapi/rc_api_info.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rapi/rc_api_runtime.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rapi/rc_api_user.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/alloc.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/condition.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/condset.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/consoleinfo.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/format.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/lboard.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/memref.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/operand.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rc_compat.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rc_util.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rc_client.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/rc_validate.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/richpresence.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/runtime.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/runtime_progress.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/trigger.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rcheevos/value.o 
LIBRCHEEVOS_OBJS += ext/rcheevos/src/rhash/md5.o

LIBMINIMP3_OBJS := 
LIBMINIMP3_OBJS += ext/minimp3/minimp3.o

LIBAT3_STANDALONE_OBJS := 
LIBAT3_STANDALONE_OBJS += ext/at3_standalone/atrac.o
LIBAT3_STANDALONE_OBJS += ext/at3_standalone/atrac3.o
LIBAT3_STANDALONE_OBJS += ext/at3_standalone/atrac3plus.o
LIBAT3_STANDALONE_OBJS += ext/at3_standalone/atrac3plusdec.o
LIBAT3_STANDALONE_OBJS += ext/at3_standalone/atrac3plusdsp.o
LIBAT3_STANDALONE_OBJS += ext/at3_standalone/get_bits.o
LIBAT3_STANDALONE_OBJS += ext/at3_standalone/compat.o
LIBAT3_STANDALONE_OBJS += ext/at3_standalone/fft.o
LIBAT3_STANDALONE_OBJS += ext/at3_standalone/mem.o

LIBSPIRV_OBJS := 
LIBSPIRV_OBJS += ext/glslang/SPIRV/GlslangToSpv.o 
LIBSPIRV_OBJS += ext/glslang/SPIRV/InReadableOrder.o 
LIBSPIRV_OBJS += ext/glslang/SPIRV/Logger.o 
LIBSPIRV_OBJS += ext/glslang/SPIRV/SpvBuilder.o 
LIBSPIRV_OBJS += ext/glslang/SPIRV/SpvPostProcess.o 
LIBSPIRV_OBJS += ext/glslang/SPIRV/doc.o 
LIBSPIRV_OBJS += ext/glslang/SPIRV/SpvTools.o 
LIBSPIRV_OBJS += ext/glslang/SPIRV/disassemble.o 
LIBSPIRV_OBJS += ext/glslang/SPIRV/CInterface/spirv_c_interface.o 

LIBGLSLANG_OBJS := 
LIBGLSLANG_OBJS += ext/glslang/glslang/CInterface/glslang_c_interface.o

LIBMACHINE_INDEPENDENT_OBJS := 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/glslang_tab.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/attribute.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/Constant.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/iomapper.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/InfoSink.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/Initialize.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/IntermTraverse.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/Intermediate.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/ParseContextBase.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/ParseHelper.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/PoolAlloc.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/RemoveTree.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/Scan.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/ShaderLang.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/SpirvIntrinsics.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/SymbolTable.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/Versions.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/intermOut.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/limits.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/linkValidate.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/parseConst.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/reflection.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/preprocessor/Pp.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/preprocessor/PpAtom.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/preprocessor/PpContext.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/preprocessor/PpScanner.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/preprocessor/PpTokens.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/MachineIndependent/propagateNoContraction.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/HLSL/hlslAttributes.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/HLSL/hlslParseHelper.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/HLSL/hlslScanContext.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/HLSL/hlslOpMap.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/HLSL/hlslTokenStream.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/HLSL/hlslGrammar.o 
LIBMACHINE_INDEPENDENT_OBJS += ext/glslang/glslang/HLSL/hlslParseables.o

LIBOGLCOMPILER_OBJS := 
LIBOGLCOMPILER_OBJS += ext/glslang/OGLCompilersDLL/InitializeDll.o

LIBOSDEPENDENT_OBJS := 
LIBOSDEPENDENT_OBJS += ext/glslang/glslang/OSDependent/Unix/ossource.o

LIBGENERIC_CODE_GEN_OBJS := 
LIBGENERIC_CODE_GEN_OBJS += ext/glslang/glslang/GenericCodeGen/CodeGen.o 
LIBGENERIC_CODE_GEN_OBJS += ext/glslang/glslang/GenericCodeGen/Link.o

LIBSPIRV_CROSS_GLSL_OBJS := 
LIBSPIRV_CROSS_GLSL_OBJS += ext/SPIRV-Cross/spirv_glsl.o

LIBSPIRV_CROSS_CORE_OBJS := 
LIBSPIRV_CROSS_CORE_OBJS += ext/SPIRV-Cross/spirv_cross.o
LIBSPIRV_CROSS_CORE_OBJS += ext/SPIRV-Cross/spirv_cross_util.o 
LIBSPIRV_CROSS_CORE_OBJS += ext/SPIRV-Cross/spirv_cfg.o 
LIBSPIRV_CROSS_CORE_OBJS += ext/SPIRV-Cross/spirv_cross_parsed_ir.o 
LIBSPIRV_CROSS_CORE_OBJS += ext/SPIRV-Cross/spirv_parser.o

LIBARMIPS_OBJS := 
LIBARMIPS_OBJS += ext/armips/Archs/Architecture.o 
LIBARMIPS_OBJS += ext/armips/Archs/ARM/Arm.o 
LIBARMIPS_OBJS += ext/armips/Archs/ARM/ArmExpressionFunctions.o 
LIBARMIPS_OBJS += ext/armips/Archs/ARM/ArmElfRelocator.o 
LIBARMIPS_OBJS += ext/armips/Archs/ARM/ArmOpcodes.o 
LIBARMIPS_OBJS += ext/armips/Archs/ARM/ArmParser.o 
LIBARMIPS_OBJS += ext/armips/Archs/ARM/CArmInstruction.o 
LIBARMIPS_OBJS += ext/armips/Archs/ARM/CThumbInstruction.o 
LIBARMIPS_OBJS += ext/armips/Archs/ARM/Pool.o 
LIBARMIPS_OBJS += ext/armips/Archs/ARM/ThumbOpcodes.o 
LIBARMIPS_OBJS += ext/armips/Archs/MIPS/CMipsInstruction.o 
LIBARMIPS_OBJS += ext/armips/Archs/MIPS/Mips.o 
LIBARMIPS_OBJS += ext/armips/Archs/MIPS/MipsElfFile.o 
LIBARMIPS_OBJS += ext/armips/Archs/MIPS/MipsExpressionFunctions.o 
LIBARMIPS_OBJS += ext/armips/Archs/MIPS/MipsElfRelocator.o 
LIBARMIPS_OBJS += ext/armips/Archs/MIPS/MipsMacros.o 
LIBARMIPS_OBJS += ext/armips/Archs/MIPS/MipsOpcodes.o 
LIBARMIPS_OBJS += ext/armips/Archs/MIPS/MipsParser.o 
LIBARMIPS_OBJS += ext/armips/Archs/MIPS/PsxRelocator.o 
LIBARMIPS_OBJS += ext/armips/Archs/SuperH/SuperH.o 
LIBARMIPS_OBJS += ext/armips/Archs/SuperH/CShInstruction.o 
LIBARMIPS_OBJS += ext/armips/Archs/SuperH/ShParser.o 
LIBARMIPS_OBJS += ext/armips/Archs/SuperH/ShOpcodes.o 
LIBARMIPS_OBJS += ext/armips/Archs/SuperH/ShElfRelocator.o 
LIBARMIPS_OBJS += ext/armips/Archs/SuperH/ShExpressionFunctions.o 
LIBARMIPS_OBJS += ext/armips/Commands/CAssemblerCommand.o 
LIBARMIPS_OBJS += ext/armips/Commands/CAssemblerLabel.o 
LIBARMIPS_OBJS += ext/armips/Commands/CDirectiveArea.o 
LIBARMIPS_OBJS += ext/armips/Commands/CDirectiveConditional.o 
LIBARMIPS_OBJS += ext/armips/Commands/CDirectiveData.o 
LIBARMIPS_OBJS += ext/armips/Commands/CDirectiveFile.o 
LIBARMIPS_OBJS += ext/armips/Commands/CDirectiveMessage.o 
LIBARMIPS_OBJS += ext/armips/Commands/CommandSequence.o 
LIBARMIPS_OBJS += ext/armips/Core/ELF/ElfRelocator.o 
LIBARMIPS_OBJS += ext/armips/Core/ELF/ElfFile.o 
LIBARMIPS_OBJS += ext/armips/Core/Allocations.o 
LIBARMIPS_OBJS += ext/armips/Core/Assembler.o 
LIBARMIPS_OBJS += ext/armips/Core/Common.o 
LIBARMIPS_OBJS += ext/armips/Core/Expression.o 
LIBARMIPS_OBJS += ext/armips/Core/ExpressionFunctionHandler.o 
LIBARMIPS_OBJS += ext/armips/Core/ExpressionFunctions.o 
LIBARMIPS_OBJS += ext/armips/Core/FileManager.o 
LIBARMIPS_OBJS += ext/armips/Core/Misc.o 
LIBARMIPS_OBJS += ext/armips/Core/SymbolData.o 
LIBARMIPS_OBJS += ext/armips/Core/SymbolTable.o 
LIBARMIPS_OBJS += ext/armips/Core/Types.o 
LIBARMIPS_OBJS += ext/armips/Parser/DirectivesParser.o 
LIBARMIPS_OBJS += ext/armips/Parser/ExpressionParser.o 
LIBARMIPS_OBJS += ext/armips/Parser/Parser.o 
LIBARMIPS_OBJS += ext/armips/Parser/Tokenizer.o 
LIBARMIPS_OBJS += ext/armips/Util/ByteArray.o 
LIBARMIPS_OBJS += ext/armips/Util/CRC.o 
LIBARMIPS_OBJS += ext/armips/Util/EncodingTable.o 
LIBARMIPS_OBJS += ext/armips/Util/FileClasses.o 
LIBARMIPS_OBJS += ext/armips/Util/FileSystem.o 
LIBARMIPS_OBJS += ext/armips/Util/Util.o

LIBLIBZSTD_OBJS := 
LIBLIBZSTD_OBJS += ext/zstd/lib/common/debug.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/common/entropy_common.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/common/error_private.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/common/fse_decompress.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/common/pool.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/common/threading.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/common/xxhash.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/common/zstd_common.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/fse_compress.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/hist.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/huf_compress.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/zstd_compress.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/zstd_compress_literals.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/zstd_compress_sequences.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/zstd_compress_superblock.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/zstd_double_fast.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/zstd_fast.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/zstd_lazy.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/zstd_ldm.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/zstd_opt.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/compress/zstdmt_compress.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/decompress/huf_decompress.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/decompress/zstd_ddict.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/decompress/zstd_decompress.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/decompress/zstd_decompress_block.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/dictBuilder/cover.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/dictBuilder/divsufsort.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/dictBuilder/fastcover.o 
LIBLIBZSTD_OBJS += ext/zstd/lib/dictBuilder/zdict.o

LIBDISCORD_RPC_OBJS := 
LIBDISCORD_RPC_OBJS += ext/discord-rpc/src/discord_rpc.o
LIBDISCORD_RPC_OBJS += ext/discord-rpc/src/rpc_connection.o
LIBDISCORD_RPC_OBJS += ext/discord-rpc/src/serialization.o
LIBDISCORD_RPC_OBJS += ext/discord-rpc/src/connection_unix.o
LIBDISCORD_RPC_OBJS += ext/discord-rpc/src/discord_register_linux.o

LIBMINIUPNPC_OBJS := 
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/addr_is_reserved.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/connecthostport.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/igd_desc_parse.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/minisoap.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/minissdpc.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/miniupnpc.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/miniwget.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/minixml.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/minixmlvalid.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/portlistingparse.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/receivedata.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/upnpcommands.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/upnpdev.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/upnperrors.o
LIBMINIUPNPC_OBJS += ext/miniupnp/miniupnpc/src/upnpreplyparse.o

OBJS := 
OBJS += UI/AudioCommon.o 
OBJS += android/jni/TestRunner.o 
OBJS += UI/DiscordIntegration.o 
OBJS += UI/NativeApp.o 
OBJS += UI/BackgroundAudio.o 
OBJS += UI/ChatScreen.o 
OBJS += UI/DebugOverlay.o 
OBJS += UI/DevScreens.o 
OBJS += UI/DisplayLayoutScreen.o 
OBJS += UI/EmuScreen.o 
OBJS += UI/GameInfoCache.o 
OBJS += UI/MainScreen.o 
OBJS += UI/MiscScreens.o 
OBJS += UI/PauseScreen.o 
OBJS += UI/TabbedDialogScreen.o 
OBJS += UI/GameScreen.o 
OBJS += UI/GameSettingsScreen.o 
OBJS += UI/DriverManagerScreen.o 
OBJS += UI/GPUDriverTestScreen.o 
OBJS += UI/TiltAnalogSettingsScreen.o 
OBJS += UI/TouchControlLayoutScreen.o 
OBJS += UI/TouchControlVisibilityScreen.o 
OBJS += UI/GamepadEmu.o 
OBJS += UI/JoystickHistoryView.o 
OBJS += UI/OnScreenDisplay.o 
OBJS += UI/ControlMappingScreen.o 
OBJS += UI/RemoteISOScreen.o 
OBJS += UI/ReportScreen.o 
OBJS += UI/SavedataScreen.o 
OBJS += UI/Store.o 
OBJS += UI/CwCheatScreen.o 
OBJS += UI/InstallZipScreen.o 
OBJS += UI/JitCompareScreen.o 
OBJS += UI/MemStickScreen.o 
OBJS += UI/ProfilerDraw.o 
OBJS += UI/CustomButtonMappingScreen.o 
OBJS += UI/Theme.o 
OBJS += UI/RetroAchievementScreens.o

LIBS := 
LIBS += libCore.a
LIBS += libnative.a #should before libCommon.a
LIBS += libCommon.a
LIBS += libsnappy.a
LIBS +=    libcpu_features.a
LIBS += liblibzip.a
LIBS += libpng17.a
LIBS +=    libbasis_universal.a libvma.a libgason.a libchdr.a
LIBS += libudis86.a
LIBS += libkirk.a
LIBS += libcityhash.a
LIBS += libsfmt19937.a
LIBS += libxbrz.a
LIBS += libxxhash.a
LIBS +=    librcheevos.a libminimp3.a libat3_standalone.a
LIBS += libSPIRV.a
LIBS += libglslang.a
LIBS +=    libMachineIndependent.a
LIBS += libOGLCompiler.a
LIBS += libOSDependent.a
LIBS +=    libGenericCodeGen.a libspirv-cross-glsl.a libspirv-cross-core.a
LIBS += libarmips.a
LIBS +=    liblibzstd_static.a libdiscord-rpc.a libminiupnpc.a

all: PPSSPPSDL

PPSSPPSDL: $(LIBS) $(OBJS)
	$(CPP) $(CCFLAGS) -o $@ $(OBJS) $(LIBS) $(LDFLAGS)

libCore.a: $(LIBCORE_OBJS)
	$(AR) $@ $(LIBCORE_OBJS)
	$(RANLIB) $@

libCommon.a: $(LIBCOMMON_OBJS)
	$(AR) $@ $(LIBCOMMON_OBJS)
	$(RANLIB) $@

libsnappy.a: $(LIBSNAPPY_OBJS)
	$(AR) $@ $(LIBSNAPPY_OBJS)
	$(RANLIB) $@
	
libnative.a: $(LIBNATIVE_OBJS)
	$(AR) $@ $(LIBNATIVE_OBJS)
	$(RANLIB) $@

libcpu_features.a: $(LIBCPU_FEATURES_OBJS)
	$(AR) $@ $(LIBCPU_FEATURES_OBJS)
	$(RANLIB) $@
	
liblibzip.a: $(LIBLIBZIP_OBJS)
	$(AR) $@ $(LIBLIBZIP_OBJS)
	$(RANLIB) $@
	
libpng17.a: $(LIBPNG17_OBJS)
	$(AR) $@ $(LIBPNG17_OBJS)
	$(RANLIB) $@
	
libbasis_universal.a: $(LIBBASIS_UNIVERSAL_OBJS)
	$(AR) $@ $(LIBBASIS_UNIVERSAL_OBJS)
	$(RANLIB) $@
	
libvma.a: $(LIBVMA_OBJS)
	$(AR) $@ $(LIBVMA_OBJS)
	$(RANLIB) $@
	
libgason.a: $(LIBGASON_OBJS)
	$(AR) $@ $(LIBGASON_OBJS)
	$(RANLIB) $@
	
libchdr.a: $(LIBCHDR_OBJS)
	$(AR) $@ $(LIBCHDR_OBJS)
	$(RANLIB) $@	
	
libudis86.a: $(LIBUDIS86_OBJS)
	$(AR) $@ $(LIBUDIS86_OBJS)
	$(RANLIB) $@
	
libglew.a: $(LIBGLEW_OBJS)
	$(AR) $@ $(LIBGLEW_OBJS)
	$(RANLIB) $@
	
libkirk.a: $(LIBKIRK_OBJS)
	$(AR) $@ $(LIBKIRK_OBJS)
	$(RANLIB) $@
	
libcityhash.a: $(LIBCITYHASH_OBJS)
	$(AR) $@ $(LIBCITYHASH_OBJS)
	$(RANLIB) $@
	
libsfmt19937.a: $(LIBSFMT19937_OBJS)
	$(AR) $@ $(LIBSFMT19937_OBJS)
	$(RANLIB) $@
	
libxbrz.a: $(LIBXBRZ_OBJS)
	$(AR) $@ $(LIBXBRZ_OBJS)
	$(RANLIB) $@
	
libxxhash.a: $(LIBXXHASH_OBJS)
	$(AR) $@ $(LIBXXHASH_OBJS)
	$(RANLIB) $@
	
librcheevos.a: $(LIBRCHEEVOS_OBJS)
	$(AR) $@ $(LIBRCHEEVOS_OBJS)
	$(RANLIB) $@

libminimp3.a: $(LIBMINIMP3_OBJS)
	$(AR) $@ $(LIBMINIMP3_OBJS)
	$(RANLIB) $@
	
libat3_standalone.a: $(LIBAT3_STANDALONE_OBJS)
	$(AR) $@ $(LIBAT3_STANDALONE_OBJS)
	$(RANLIB) $@

libSPIRV.a: $(LIBSPIRV_OBJS)
	$(AR) $@ $(LIBSPIRV_OBJS)
	$(RANLIB) $@
	
libglslang.a: $(LIBGLSLANG_OBJS)
	$(AR) $@ $(LIBGLSLANG_OBJS)
	$(RANLIB) $@
	
libMachineIndependent.a: $(LIBMACHINE_INDEPENDENT_OBJS)
	$(AR) $@ $(LIBMACHINE_INDEPENDENT_OBJS)
	$(RANLIB) $@
	
libOGLCompiler.a: $(LIBOGLCOMPILER_OBJS)
	$(AR) $@ $(LIBOGLCOMPILER_OBJS)
	$(RANLIB) $@
	
libOSDependent.a: $(LIBOSDEPENDENT_OBJS)
	$(AR) $@ $(LIBOSDEPENDENT_OBJS)
	$(RANLIB) $@
	
libGenericCodeGen.a: $(LIBGENERIC_CODE_GEN_OBJS)
	$(AR) $@ $(LIBGENERIC_CODE_GEN_OBJS)
	$(RANLIB) $@
	
libspirv-cross-glsl.a: $(LIBSPIRV_CROSS_GLSL_OBJS)
	$(AR) $@ $(LIBSPIRV_CROSS_GLSL_OBJS)
	$(RANLIB) $@
	
libspirv-cross-core.a: $(LIBSPIRV_CROSS_CORE_OBJS)
	$(AR) $@ $(LIBSPIRV_CROSS_CORE_OBJS)
	$(RANLIB) $@

libarmips.a: $(LIBARMIPS_OBJS)
	$(AR) $@ $(LIBARMIPS_OBJS)
	$(RANLIB) $@

liblibzstd_static.a: $(LIBLIBZSTD_OBJS)
	$(AR) $@ $(LIBLIBZSTD_OBJS)
	$(RANLIB) $@
	
libdiscord-rpc.a: $(LIBDISCORD_RPC_OBJS)
	$(AR) $@ $(LIBDISCORD_RPC_OBJS)
	$(RANLIB) $@

libminiupnpc.a : $(LIBMINIUPNPC_OBJS)
	$(AR) $@ $(LIBMINIUPNPC_OBJS)
	$(RANLIB) $@


%.o : %.S
	$(CC) $(CCFLAGS) -o $@ -c $<	
	
%.o : %.c
	$(CC) $(CCFLAGS) -o $@ -c $<

%.o : %.cpp
	$(CPP) $(CCFLAGS) -o $@ -c $<


clean: 
	$(RM) PPSSPPSDL $(LIBS) $(OBJS)
	$(RM) $(LIBCORE_OBJS)
	$(RM) $(LIBCOMMON_OBJS)
	$(RM) $(LIBSNAPPY_OBJS)
	$(RM) $(LIBNATIVE_OBJS)
	$(RM)    $(LIBCPU_FEATURES_OBJS)
	$(RM) $(LIBLIBZIP_OBJS)
	$(RM) $(LIBPNG17_OBJS)
	$(RM)    $(LIBBASIS_UNIVERSAL_OBJS)
	$(RM)    $(LIBVMA_OBJS)
	$(RM)    $(LIBGASON_OBJS)
	$(RM)    $(LIBCHDR_OBJS)
	$(RM) $(LIBUDIS86_OBJS)
	$(RM) $(LIBKIRK_OBJS)
	$(RM) $(LIBCITYHASH_OBJS)
	$(RM) $(LIBSFMT19937_OBJS)
	$(RM) $(LIBXBRZ_OBJS)
	$(RM) $(LIBXXHASH_OBJS)
	$(RM)    $(LIBRCHEEVOS_OBJS)
	$(RM)    $(LIBMINIMP3_OBJS)
	$(RM)    $(LIBAT3_STANDALONE_OBJS)
	$(RM) $(LIBSPIRV_OBJS)
	$(RM) $(LIBGLSLANG_OBJS)
	$(RM)    $(LIBMACHINE_INDEPENDENT_OBJS)
	$(RM) $(LIBOGLCOMPILER_OBJS)
	$(RM) $(LIBOSDEPENDENT_OBJS)
	$(RM)    $(LIBGENERIC_CODE_GEN_OBJS)
	$(RM)    $(LIBSPIRV_CROSS_GLSL_OBJS)
	$(RM)    $(LIBSPIRV_CROSS_CORE_OBJS)	
	$(RM) $(LIBARMIPS_OBJS)
	$(RM)    $(LIBLIBZSTD_OBJS)
	$(RM)    $(LIBDISCORD_RPC_OBJS)
	$(RM)    $(LIBMINIUPNPC_OBJS)

test:
	./PPSSPPSDL

debug:
	gdb ./PPSSPPSDL

install5:
	cp PPSSPPSDL /media/wmt/retropie/home/pi/pi/work_ppsspp/ppsspp_rpi32_1181/.
	cp assets/gamecontrollerdb.txt /media/wmt/retropie/home/pi/pi/work_ppsspp/ppsspp_rpi32_1181/assets/.


