# ppsspp-1.18.1_fork
Try to cross compile PPSSPP 1.18.1 GLES no X11 version

## Original Readme  
* https://github.com/hrydgard/ppsspp/blob/v1.18.1/README.md  
* https://github.com/hrydgard/ppsspp/blob/v1.18.1/history.md  

## References  
* glgetstringi nullptr patch for Allwinners A133  
https://github.com/knulli-cfw/distribution/blob/bc90dbc9a8c785d7265b5fa3d3a8b976545ba45d/board/batocera/allwinner/a133/patches/ppsspp/001-glStringi-workaround.patch  
see https://github.com/weimingtom/ppsspp-1.18.1_fork/blob/master/build/001.txt  
* cmake build cross compile arguments  
https://github.com/Ruka-CFW/s30-cfw/blob/main/buildroot/package/emulators/ppsspp/ppsspp.mk   
https://github.com/weimingtom/ppsspp-1.18.1_fork/blob/master/build/ppsspp_s30-cfw.mk  
https://github.com/weimingtom/ppsspp-1.18.1_fork/blob/master/build/ppsspp_v2.mk  
https://github.com/weimingtom/ppsspp-1.18.1_fork/blob/master/build/ppsspp_v0.mk  
https://github.com/weimingtom/ppsspp-1.18.1_fork/blob/master/build/ppsspp_v2.sh  
* (TODO) https://github.com/OtherCrashOverride/ppsspp-go2  
https://github.com/OtherCrashOverride/ppsspp-go2/issues/3  
https://github.com/OtherCrashOverride/ppsspp-go2/blob/master/ext/native/gfx_es2/gpu_features.cpp  
https://github.com/christianhaitian/ppsspp-go2/compare/master...OtherCrashOverride%3Appsspp-go2%3Amaster  
https://github.com/christianhaitian/ppsspp-go2  
* (Seems not support no X11) https://github.com/ryanfortner/build-ppsspp-rpi  
https://github.com/ryanfortner/build-ppsspp-rpi/releases  
```
see ppsspp_1.12.3_armhf.zip
测试过build-ppsspp-rpi这个版本无法在非X11环境下运行
```
* (TODO) rotate screen  
https://github.com/hrydgard/ppsspp/issues/16630  

## (WIP) How to build for PC xubuntu 20.04  
* sudo apt install libsdl2-dev cmake
* make clean && make -j8  
* (or use cmake) cd build; make -f ppsspp_v2.mk clean; cmake ..; make -j8  

## (Not good) How to host build for retropie (Raspberry Pi Zero 2W, Waveshare GPM280Z2)  
* sudo nano /etc/dphys-swapfile  
* ./b.sh --rpi  
* cd build; cmake ..; make  
```
在树莓派上编译ppsspp太慢，似乎是因为retropie交换分区太小导致编译卡在某些cpp文件上，
我的做法是这样：sudo nano /etc/dphys-swapfile，从100改成1024，
然后重启生效，这样就能稍微好一点，避免编译被卡住——我觉得交换分区会写到tf卡，
虽然可行但会稍微会慢一些
```

## How to cross compile build for retropie (Raspberry Pi Zero 2W, Waveshare GPM280Z2)    
* make MIYOO=5 clean && make MIYOO=5 -j8
```
我尝试直接在树莓派Zero2W上直接编译PPSSPP，即便我加大了交换分区的大小，
依然不成功——如果是编译带调试信息的debug版，会在最后的链接时候卡住编译不了——
所以我最终还是改用交叉编译，不过我也不是简单的交叉编译，
我是用MIYOO A30的工具链交叉编译（同样是armhf），
在此基础上链接树莓派特有的libbcm_host库，
我测试过可以用这种不太好的方法链接出能正常运行的elf可执行文件

之前我在树莓派zero2w上跑PPSSPP卡住，好像是因为我用retropie
里面的文件管理器mc启动，
但mc会占用cpu百分之百，解决办法写一个sh然后在后面加个&，
这样mc就不会占用太多cpu了——虽然还是卡

树莓派掌机gpm280z2移植ppsspp研究。声音延迟问题解决，键位问题还没研究出来方法。
关于第一个问题声音延迟，其实解决办法是把日志给关了就不会声音延迟了
（把-D_DEBUG改成-DNDEBUG），我晕；
至于第二个问题键位，其实是因为gpm280z2没有dpad方向键——它的方向键其实是摇杆
——这样就可以解释为什么它在主菜单是可以方向键的，但到了游戏里面却不能，
但改成发送按键模拟仍然无法发送方向键，我还没搞清楚为什么（我改了很多回都不行），
有点怀疑类似我之前改的krkrsdl2源代码那样，难道是多个代码接收手柄输入吗？
例如同时使用pollevents和使用按键状态查询，只改pollevents没用，
不过我还没找到依据

树莓派掌机gpm280z2移植ppsspp研究。修复了键位问题的一部分，
关于方向键的映射。
之前尝试改，这个掌机的方向键dpad其实是摇杆motion，
所以我加了模拟按键，但没成功，
今天大概成功了，我猜测之前不成功是因为没考虑消抖
（需要在KEY_DOWN和KEY_UP之间加延迟），
我改成用线程发送模拟按键，KEY_DOWN和KEY_UP之间加上50毫秒左右的延迟，
但这个延迟不能太长或者太短，太短的话相当于没按（被消抖了），
太长的话会触发两次按键。其实还没完全解决键位问题，
还需要模拟ESC唤出PPSSPP菜单，这个功能暂时还没做。
另外我还修复了SDL光标显示问题，其实原来代码已经考虑了，
只是因为MOBILE宏定义的问题没生效，
我另外加一个宏去隐藏SDL光标
```

## (WIP) How to build for Trimui Smart Pro
* Modify Makefile for cross compile toolchain  
* make MIYOO=2 clean && make MIYOO=2 -j8
* (or use cmake) sudo apt install cmake
* (or use cmake) cd build; make -f ppsspp_v2.mk clean; make -f ppsspp_v2.mk; make -j8
* (or use cmake) cd build; make -f ppsspp_v2.mk clean; . ./ppsspp_v2.sh; make -j8

## Bugs  
* Too slow
```
Use -O3, and use -DNDEBUG instead of -D_DEBUG (too many log make it slow)
```
* imouto.iso (实妹相伴的大泉君psp移植版) too slow (especially audio delay) and sometimes crash  
```
Fixed
see Core/HLE/sceMpeg.cpp, use std::mutex to fix this bug

can use usleep(100) or printf() to solve this problem
I use std::mutex to solve it

crash in Core/HLE/sceMpeg.cpp:906
free(): double free detected in tcache 2

Fixed here:
~H264Frames()
void add(const u8 *str, int sz)
```
* Toheart2 psp crash, need to disable buffer (but also crash?)      

## TODO  
* (done) Remove ext\armips\Tests\Core\Includes\??asm  
* Change to -O3 -g0
```
Fixed, see upper imouto.iso bug  

Makefile
#-O3 -g0 some games will crash
CCFLAGS += -O0 -g3
```
* Support Raspberry Pi Zero 2 W and Waveshare GPM280Z2
```
use START+SELECT to emulate MENU button, see USE_EMULATE_MENU_BUTTON  
use Joystick to emulate dpad, see USE_MOTION_AS_JOYBUTTON  
```
* (changed ? not sync) assets/redump.csv  

# Build ffmpeg, only for official ppsspp code      
```
cd ffmpeg  

# for trimui smart pro
PATH=/home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin:$PATH ./linux_arm64.sh

# for gpm280z2. linux_rpi32.sh is a mod from linux_rpi.sh
PATH=/home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin:$PATH ./linux_rpi32.sh

# not tested
PATH=/home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin:$PATH ./linux_armhf.sh
```

# sleep bug for rpi32 (rpizero2w), waveshare gpm280z2     
* see UI/NativeApp.cpp, NO_NATIVE_FRAME_SLEEP  
