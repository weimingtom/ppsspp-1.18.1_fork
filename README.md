# ppsspp-1.18.1_fork
Try to cross compile PPSSPP 1.18.1 GLES no X11 version

## Original Readme  
* https://github.com/hrydgard/ppsspp/blob/v1.18.1/README.md  
* https://github.com/hrydgard/ppsspp/blob/v1.18.1/history.md  

## Bugs  
* (done) Too slow
```
Use -O3, and use -DNDEBUG instead of -D_DEBUG (too many log make it slow)
```
* (done) imouto.iso (实妹相伴的大泉君psp移植版) too slow (especially audio delay) and sometimes crash  
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
* (done) imouto.iso voice sound delay is bad (but music is good)
* LR肩键无效，AB键交换，
* (done) 人物声音变尖（但背景音却正常）  
* For TRIMUI SMART PRO version building, vulkan does not work when running

## TODO  
* (done) Remove ext\armips\Tests\Core\Includes\??asm  
* (done) Change to -O3 -g0
```
Fixed, see upper imouto.iso bug  

Makefile
#-O3 -g0 some games will crash
CCFLAGS += -O0 -g3
```
* (done) Support Raspberry Pi Zero 2 W and Waveshare GPM280Z2
```
use START+SELECT to emulate MENU button, see USE_EMULATE_MENU_BUTTON  
use Joystick to emulate dpad, see USE_MOTION_AS_JOYBUTTON  
```
* (changed ? not sync) assets/redump.csv  

## Original code compare
* ppsspp-1.18.1.tar.xz  
No code changed, but not include dependencies  
see https://github.com/hrydgard/ppsspp/releases/tag/v1.18.1  
see https://github.com/hrydgard/ppsspp/releases/download/v1.18.1/ppsspp-1.18.1.tar.xz  
* ppsspp_1.18.1_cmake2.tar.gz  
Some code changed, but includes dependencies  

## Unofficial Releases and Builds by make without cmake     
* For GPM2804 (rotate 270 degrees, but not good)    
```
make MIYOO=6 clean && make MIYOO=6 -j8
```
* For GPM280Z2  
```
make MIYOO=5 clean && make MIYOO=5 -j8
```
* For Trimui Smart Pro  
```
make MIYOO=2 clean && make MIYOO=2 -j8  
```
* For debugging on Xubuntu 20.04, 64bit  
```
make MIYOO=0 clean && make MIYOO=0 -j8  
```

## Cross compile toolchains and staging files    
* For aarch64, like Trimui Smart Pro and Trimui Brick   
https://github.com/trimui/toolchain_sdk_smartpro/releases/tag/20231018  
* For armv7-a, like Miyoo A30, Raspberry Pi 4B, Raspberry Pi 3B, Waveshare GPM280Z2, Waveshare GPM2804  
https://github.com/XK9274/a30-sdk-miyoo/releases/tag/16042024  

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
【补注：不要用这种方法，会导致按键影响到mc，
建议做法：（1）点击elf文件或者去掉sh文件内的&
（2）或者在/home/pi/RetroPie/retropiemenu/目录下创建sh文件，
这样就能在retropie内创建快捷方式（需要重启一下emulationstation）】

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

## Build ffmpeg, only for official ppsspp code      
```
cd ffmpeg  

# for trimui smart pro
PATH=/home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin:$PATH ./linux_arm64.sh

# for gpm280z2. linux_rpi32.sh is a mod from linux_rpi.sh
PATH=/home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin:$PATH ./linux_rpi32.sh

# not tested
PATH=/home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin:$PATH ./linux_armhf.sh
```

## Sleep bug for rpi32 (rpizero2w), waveshare gpm280z2     
* see UI/NativeApp.cpp, NO_NATIVE_FRAME_SLEEP  

## How to launch in Retropie for Waveshare GPM2804 without mc (File Manager) 
```
找到方法解决GPM2804运行PPSSPP和运行onscripter没有声音输出的问题——
方法是不用mc（树莓派retropie上的一个文件管理器）运行，
而是创建一个sh文件在/home/pi/RetroPie/retropiemenu/onscripter.sh，
然后重启即可添加一个快捷方式在retropie分类下，
然后用这个方法启动任意程序即可有声音输出
```
* To solve no audio problem. If use mc (File Manager) to launch, SDL2 will have no audio output   
* Create file (need reboot to refresh retropie menu) : /home/pi/RetroPie/retropiemenu/ppsspp.sh   
```
#!/bin/sh

/home/pi/pi/work_ppsspp/ppsspp_rpi32_1181/PPSSPPSDL
```
* (Not recommended) Or modify file and append it to : /opt/retropie/configs/all/autostart.sh  
```
#emulationstation #auto
emulationstation --screenrotate 3 --screensize 640 480
/home/pi/pi/work_ppsspp/ppsspp_rpi32_1181/PPSSPPSDL
```

## About ulimit in TrimUI Smart Pro
* ulimit -c unlimited
* If you use ulimit -c unlimited, the core dump file may be saved to /tmp folder
* cat /proc/sys/kernel/core_pattern
```
 _____  _              __     _
|_   _||_| ___  _ _   |  |   |_| ___  _ _  _ _
  | |   _ |   ||   |  |  |__ | ||   || | ||_'_|
  | |  | || | || _ |  |_____||_||_|_||___||_,_|
  |_|  |_||_|_||_|_|  Tina is Based on OpenWrt!
 ----------------------------------------------
 Tina Linux (Neptune, 5C1C9C53)
 ----------------------------------------------
root@TinaLinux:/# cat /proc/sys/kernel/core_pattern
cat /proc/sys/kernel/core_pattern
/tmp/%e.%t.%p.%s.core
``` 
* But core dump file may be too big (about 300 MB)

## About running PPSSPP in retropie menu 
```
If running on GPM280Z2 or GPM2804, run through mc (File Manager),

or put a ppsspp.sh file in /home/pi/RetroPie/retropiemenu
(you need to edit ppsspp.sh to point to a path)
and then run PPSSPP in retropie menu
```
```
#!/bin/sh

# put this file ppsspp.sh to put to /home/pi/RetroPie/retropiemenu

/home/pi/pi/work_ppsspp/ppsspp_rpi32_1181/PPSSPPSDL
```

## Rotate 90 degrees (270 degrees) with two states in GPM2804   
* rotate 90 degrees (270 degrees) with two states, 双状态旋转90度   
* Another method is rotating 90 degrees but using Software Rendering (Slow)  
* weibo record  
```
其实我有一个很奇怪的疑惑，为什么很多开源linux掌机打不开自制的PSP游戏呢？
会闪退，但打开非自制的PSP游戏则大多数都是正常的。
如果这个问题可以解决就好了，这样可以玩很多galgame移植，
不过暂时不知道如何解决，因为我没研究过怎么调试PPSSPP——
最棘手的是用PC版的PPSSPP是可以正常打开这些自制PSP游戏的

ppsspp闪退好像是因为一个函数sceMpegAvcDecode出问题，
不过可能升级到最新版就会没事，问题是我不会编译这个，
等以后有时间再研究 ​​​

我试过可以很容易在xubuntu 20下编译PC版linux版的PPSSPP，
前提是要git submodule update --init，如果不做子模块导出的话，
直接cmake会提示错误，简单来说就是不能下官方的zip源码包，
而是应该检出tag版本，例如git checkout v1.5.4，
最好预留两三G的硬盘，然后直接cmake和make即可编译成功——
可能只是用了一下OpenGL和SDL2的系统库，其他大多数库都是静态链接的

关于linux掌机跑psp自制游戏会闪退的问题，我现在可以在xubuntu 20下编译
PPSSPP 1.5.4版并且正确运行会在linux掌机上闪退的自制游戏（这个移植游戏不是我做的）
——事实上我编译默认release版，跑这个游戏也会闪退，只不过我找到解决办法，
就是把CMakeCache.txt的CMAKE_BUILD_TYPE的值改成debug（默认空白），
然后再编译一次即可，体积会增加一倍，但好处是不会出现闪退的情况。
当然这只是对于1.5.4版而言，最新版估计也能用类似的方法解决

我现在可以编译和交叉编译ppsspp 1.5.4（用蛮力解决，写Makefile），
但问题是在掌机上跑不起来，EGL初始化失败，可能有时间再研究——
不过这个问题不是很重要，可能要几个月时间

其实我也很想把ppsspp的掌机arm版编译出来，我甚至发现可能它的RA插件
也是用同一份代码编译出来的，你说厉不厉害，而且还有可能解决很多问题，
譬如闪退问题，ONS for PSP版（还有别的自制软件）会产生的黑屏
（但其实是可以操作的，可能需要缩放刷新一下窗口）——
不过我能编译出来但跑不起来，气笑了 ​​​

ppsspp的linux掌机版，我现在可以进去界面了，不过打开游戏失败——
声音和手柄输入和界面似乎都没问题（界面目前还没全屏），
可能就是文件读写的问题，不确定会不会还有别的问题，
能不能跑起来目前还没什么把握，有时间才研究 

关于ppsspp在各种linux掌机上的情况，我发现：
（1）目前看来R36S的PPSSPP的兼容似乎可能是做得最好的（版本是1.17.1），
不过比较卡（2）R36S应该不兼容Trimui Smart Pro的用到GLES2动态库的elf
（3）其实Miyoo Mini也支持ppsspp，作者就是司徒大神，不过我测试过很卡，
而且兼容能力也只是一般，有些游戏也是会闪退

我编译的PPSSPP现在可以勉强进游戏（TRIMUI Smart Pro版，但有些游戏仍然进不去），
但必须按MENU键（ESC）进入设置菜单，然后在Graphics-Rendering mode选择
Skip buffer effects（第一项），否则整个屏幕都会花掉，
但这个模式会导致显示内容丢失——暂时不研究了，
可能准备分一个新的代码分支看能不能升级到较新的版本，
然后再想办法研究下去

今天修复了onscripter_jh_libretro（我自己编译版本）导致3个游戏无法进入的闪退bug，
有个地方空指针了——没办法，PPSSPP也有类似的情况，onscripter
原作者没有做防御编程，但我觉得没什么性能损失。不清楚类似的问题还有多少，
也不清楚如何导致的，应该是ONS解释器逻辑代码的问题，和RA无关。
我发现可以不用编译调试版的ra也能获取调用栈（确保so文件带有调试信息），
但行号信息有缺失，可能是因为这份RA核心的代码用到协程导致的，
当然这个bug我是直接作为elf来调试，而不是作为RA核心去调试，
这样的话闪退后行号信息是全的

找不到PPSSPP的交叉编译到ARM Linux掌机的步骤的资料，难道是太容易没人写么？
我只能试试重新用cmake参数来交叉编译了——比较接近我想要的是
recalbox的编译makefile，我晚上试试能不能交叉编译成功——
最麻烦是它的cmake配置过程会失败，我这次试试能不能把工具链
合并到一个目录下，我看到别人似乎是这样做的

我终于找到交叉编译ARM版PPSSPP的方法，用了cmake定义参数至少用了35个——
我是参考magicseb/recalbox-rk3399-internal中的ppsspp.mk，
额外加了几个cmake参数——然而并没用，虽然可以编译出来，
但运行还是会crash，但好处是我就不用浪费时间手写Makefile。
具体的方法等我能跑通了再放到gh上

关于ppsspp的cmake编译和交叉编译，我想得还是太天真了，
因为我目前研究的版本都是在1.9之前——1.5.4和1.8其实改动不是太大，
所以用cmake交叉编译出来的结果应该是类似的，
所以我还需要测试1.9或以上的版本，我上次说的
magicseb/recalbox-rk3399-internal其实也是1.8版本，
所以我不确定能否用类似的方法cmake编译新版本，
需要时间再测试

我现在可以cmake编译和交叉编译ppsspp 1.18.1了，不过ARM版依然无法运行
（PC版可以但仍然需要编译成调试版才能避免有些游戏闪退）。
方法类似于我之前编译1.8和1.5.4，区别是
（1）需要递归导出子模块，而不是非递归
（2）ffmpeg需要自己执行sh文件去交叉编译，
否则最终交叉编译PPSSPPSDL会链接失败（PC版则不需要）
（3）交叉编译cmake需要更多的定义参数，我是加上SDL_ttf相关的参数

我打算下一步研究ppsspp 1.17.1的cmake交叉编译（应该类似于1.18.1，
不会更难吧，我猜是差不多的），
再试试能不能运行ARM版，如果ARM版还是不能运行，就编译树莓派版，
因为树莓派版在很多地方都显示是可以编译运行的，
而且应该不需要交叉编译，而且官方也直接支持编译这个目标机，
如果这样都跑不了就真没辙了（我主要想看看是否真的可以在非x11下运行）——
当然我也可以不这样研究，只是我目前还不打算直接改代码，
我觉得应该有一些方法可以不用自己魔改代码，
或者说我还没有把握去改

大概测试cmake编译运行ppsspp 1.17.1（1）PC版依然需要修改成
构建Debug类型才能避免一些闪退问题
（2）编译方式同1.18.1（3）也需要交叉编译ffmpeg，
否则最后链接会失败（4）ARM版未测试是否仍然crash，
晚上再测试 ​​​

我找到一个更新一点版本的PPSSPP的cmake参数配置Ruka-CFW/s30-cfw，
版本是1.11.3，用于掌机Pocket Go S30，只是这个是配置成32位的，
有时间测试一下能不能用

其实更简单的方法是找ppsspp.mk这个就能找到一些cmake配置方法，
最新的应该是巴托塞拉的仓库 ​​​

ppsspp linux掌机研究，今天可以在trimui smart pro上运行1.5.4版
的Buffered rendering模式了，不会再出现花屏情况（当然还有别的闪退问题，
未完善），解决方法是，需要打一个patch，这个patch在
knulli-cfw/distribution中。不确定这个方法能否适用于1.9
以后的版本，至少目前看来我用cmake交叉编译1.9以后的版本
全都无法运行，我可能先研究一下树莓派的ppsspp，等回过头再研究
1.5.4版的其他闪退问题。

我怀疑确实可以通过RA的PPSSPP核心插件和PPSSPP单独运行两种方式
去尝试在linux掌机上打开PSP游戏——这两者的确是存在区别的，
但并不是因为这俩代码不一样，而是这俩是同一份代码，
只是很有可能RA插件的PPSSPP版本要比单独运行版的PPSSPP版本更旧
（1.9版以上和1.8版以下是分水岭），所以运行效果会不一样——
当然也有可能两者都无法运行一些PSP游戏，毕竟在很久以前
PPSSPP还是被很多人诟病的，只是近几年它的口碑在直线上升

晚上试用了一下最新版的树莓派版batocera系统。这个系统应该非常久远，
从界面看应该常用于hdmi显示的（可能界面类似于kodi），
如果说界面像什么，就有点类似于R36S的ArkOS系统和ES前端
（EmulationStation），点进去游戏会有个放大封面的动画效果，
但也有很多地方跟ArkOS不一样。支持PPSSPP最新的1.18.1，
可能里面的模拟器大部分都是单独运行而不是基于RA的。
总之就是不是太喜欢，但它可能是目前比较活跃的游戏系统了，
软件方面是非常新的

树莓派4b编译安装PPSSPP 1.18.1成功（32位），我试过可以在
x11和纯CLI命令行环境下都能运行（命令行下SDL2鼠标可以显示但不能点击）。
编译方法：（1）刷2023-05-03-raspios
（2）sudo apt install cmake libsdl2-dev
（3）复制ffmpeg的linux armv7目录到aarch6（原aarch可以改名）
（4）./b.sh --rpi但注意这种方法会全部重新编译，
所以必要时需要cd build; make（5）大部分效果类似于PC版，
包括部分闪退游戏也可能需要用Debug类型编译才能不闪退

今天晚上试试编译6位版OS下的树莓派的ppsspp 1.18.1。
32位版已经能编译和运行，我打算把编译verbose输出来
准备手写Makefile（为了看能否交叉编译到trimui smart pro上运行）。
32位版编译一次大概需要15分钟到20分钟（不需要编译ffmpeg）

树莓派4b上编译6位的ppsspp 1.18.1也成功（耗时23分钟），
编译方法和运行效果和32位的编译方法和运行效果差不多——
只是编译时候不需要替换ffmpeg linux aarch目录，而且./b.sh
的参数是--rpi6（后面多两个数字）。
上次说它命令行下鼠标没用，其实不对，准确来说鼠标的
点击位置和显示不符，其实是可以点击的。闪退也会闪退——
其实我不太确定把verbose编译过程拿出来有没有用，
可能用处也不大，随便了，反正ppsspp也不是很好玩，
如果不能用也真的不会改，最多只是小修小补一下

我现在可以手写makefile和cmake两种方式交叉编译PPSSPP 1.18.1，
以及用手写makefile方式交叉编译PPSSPP 1.5.4，并且能运行在
Trimui Smart Pro上。方法是，需要打knulli-cfw/distribution
的glgetstringi的patch，并且修改SDL2 main的入口逻辑，
去掉vulkan（开头会检测是否支持vulkan）并且加上SDL全屏标志，
改了这两个地方就能正常运行了——当然，效果不如自带的版本好，
不过自己编译可以改成Debug版让某些游戏不闪退。至于cmake，
可以参考magicseb/recalbox-rk3399-internal，
不过还需要加比较多的参数才行

我现在可以用自己编译的PPSSPP 1.18.1调试版在Trimui Smart Pro
上运行实妹相伴大泉君这个移植游戏（好像是掌机之家移植的），
其他掌机全都会crash（就除了第三张R36S可以跑，
连GKD的机也跑不了这个游戏），不知道有没有别的方法
可以避免自己编译，暂时还不确定 ​​​

《PSP已经不出新游戏了，PPSSPP模拟器也已经很完善了，
为什么作者还在继续完善PPSSPP？》PPSSPP不是很完善，
有两个最大的问题，一个是闪退，还有一个是少数游戏会屏幕没显示，
需要关闭缓冲，但关闭缓冲又会导致其他游戏的显示会少一些
显示内容——这玩意就不能做到自动关闭缓冲？
所以关闭缓冲就能显示的原因是什么？

如果没什么问题，我打算周末把我之前研究的ppsspp 1.18.1和
godot 3.5的掌机移植版（实际只用了trimui smart pro
测试）的交叉编译方法（包括cmake方法）和代码放到gh上。
惯例不fork，而是另外开两个新repo，名称带fork字。
我发现交叉编译的相关资料很少，我打算慢慢收集这方面的资料。
注意这里大部分移植代码和工作都不是我做的，我只是记录下来。
其实不修改源代码也没关系，我是喜欢研究这些东西，
godot的话用的人比较少，有开发上的门槛，
所以很少人会研究它的SDL2移植（frt移植代码不是我写的）。
至于PPSSPP，其实很多掌机上自带的版本都比我自己修改和
交叉编译的版本要强，我只是提供一个额外测试用的版本，
看是否能解决别人未解决的问题，例如闪退和无显示输出这俩大问题

我试过用PPSSPP的PC版和Trimui Smart Pro版都可以运行
Little Busters的PSP版日版和汉化，不过Trimui Smart Pro
版运行汉化版会声音卡顿（声音延迟），OP开场动画
（出现在过道恭介说打棒球队名叫Little Busters之后）
也会声音延迟，原因不明。我第一次遇到要换盘
（第一盘要安装到存档）的PSP游戏，PPSSPP的菜单支持换盘，
然后按继续就可以玩下去，汉化版不需要换盘，
但日本语版要，我偷懒直接用汉化版当作日本语版的
第二张盘（汉化版只需要一张盘）

我试了一下trimui smart pro的crossmixos（用一张新tf卡，
解压到fat32文件系统中即可），
感想是，有点后悔——总体来说我是不推荐的，配置项太多，
从表面来看，和原厂系统没有明显的差别，当然它支持选择启动方式，
支持遮罩，有些核心版本会比较新（但原来的PPSSPP跑不了的游戏
这个系统也照样跑不了），不过我觉得这些好处并不是很重要。
crossmixos和原厂系统确实也可以共存（换一张tf卡就行），
但也是有一定的影响，它可能会修改和升级了原厂系统的某些功能
（例如选择启动方式）。总体而言我不太喜欢这个crossmixos，
我认为没必要用这个

我尝试在树莓派4b上编译ppsspp 1.18.1然后放到retropie上运行，
提示glibc版本不兼容（很正常，我后来发现glibc是分版本的，
低版本的不支持高版本新增的API函数，所以是不允许运行的，
这有点类似windows的系统dll），我打算找时间直接在
retropie（我入手的树莓派掌机微雪GPM280Z2）上编译ppsspp，
只是比较慢（相当于树莓派3b），但tf卡的空间足够——
然后测试是否能跑起来

我尝试编译运行树莓派掌机版的PPSSPP，你猜怎么着，编译和运行都可以，
但卡在第一帧不动，气晕，所以暂时来看应该是没辙的 ​​​

话说回来，我现在还真想买复古旗GPi CASE 2（插树莓派CM4的版本，带底座），
因为我感觉应该是可以跑PPSSPP——但这价格方面有点离谱，
咸鱼整机需要700——不过树莓派4B的4G内存版也不便宜，
现在是425，我买的时候还是450还高一些，这么久也没有降多少——
当然目前也只是想想，还不是很必要买，因为GPi CASE的手感不好，
大概率会串键，玩游戏很容易误操作，除非不是拿来玩游戏只是拿来研究

上次说的我尝试用树莓派掌机跑PPSSPP 1.18.1失败的问题，
我发现好像是render线程锁卡死而非crash（可以通过wifi ssh
然后gdb运行，然后按CtrlC查看调用栈），
所以有一点点的可能可以改好——但我没有十足把握，
所以买树莓派CM4掌机的计划要推迟，
因为就算买了CM4掌机但软件方面没跑通也是无用

在树莓派上编译ppsspp太慢，似乎是因为retropie交换分区太小
导致编译卡在某些cpp文件上，我的做法是这样：
sudo nano /etc/dphys-swapfile，从100改成1024，
然后重启生效，这样就能稍微好一点，
避免编译被卡住——我觉得交换分区会写到tf卡，
虽然可行但会稍微会慢一些 ​​​

我现在可以让树莓派掌机（相当于树莓派Zero2W）跑PPSSPP 1.18.1
启动成功，但进游戏后不行，运行非常卡，可能因为调试版的原因。
具体的修改和编译办法我有时间会记录到gh上。
我以后可能会入手树莓派CM4掌机，那个可能会更好一些——
当然也可能会卡 

我尝试直接在树莓派Zero2W上直接编译PPSSPP，
即便我加大了交换分区的大小，依然不成功——
如果是编译带调试信息的debug版，
会在最后的链接时候卡住编译不了——
所以我最终还是改用交叉编译，
不过我也不是简单的交叉编译，
我是用MIYOO A30的工具链交叉编译（同样是armhf），
在此基础上链接树莓派特有的libbcm_host库，
我测试过可以用这种不太好的方法链接出能
正常运行的elf可执行文件

用树莓派掌机GPM280Z2运行PPSSPP 1.18.1的初步运行效果——
其实没跑成功，只是勉强能进去主菜单，
如果没跑成功我可能会不买树莓派CM4掌机，因为买了也用不了PPSSPP，
我没有十足的把握（除非我没其他可研究的东西） ​​​

我已经决定买树莓派CM4掌机了。理由是这样的，虽然树莓派zero2w
跑PPSSPP勉强可以（类似早期手机那样会声音延迟卡顿，
但还是能运行起来的，当然只是对于很少游戏而言能跑）——
不过实际上zero2w的内存很少，它的GPU会占用一部分内存，
而且这部分内存不能太少，太少的话连GLES都会跑出bug来，
例如有贴图错误，所有字体显示不出来，是黑色的。
所以我考虑再三还是买CM4，但实际上CM4的性能仍然
低于一些开源掌机，所以很可能还会有声音延迟的问题，
反正我没有抱有多大的期望——我可能先研究好PPSSPP
键位的修改，下星期正式开始买GPM2804

树莓派掌机gpm280z2移植ppsspp研究。声音延迟问题解决，
键位问题还没研究出来方法。
关于第一个问题声音延迟，其实解决办法是把日志给关了就不会声音延迟了
（把-D_DEBUG改成-DNDEBUG），我晕；至于第二个问题键位，
其实是因为gpm280z2没有dpad方向键——它的方向键其实是摇杆——
这样就可以解释为什么它在主菜单是可以方向键的，
但到了游戏里面却不能，但改成发送按键模拟仍然无法发送方向键，
我还没搞清楚为什么（我改了很多回都不行），
有点怀疑类似我之前改的krkrsdl2源代码那样，
难道是多个代码接收手柄输入吗？例如同时使用pollevents和
使用按键状态查询，只改pollevents没用，不过我还没找到依据

我看过CM4的retropie好像也是32位的，无所谓，我可以不用retropie，
而且ppsspp也不需要太大内存，其实32位也是够用的了 ​​​

树莓派掌机gpm280z2移植ppsspp研究。修复了键位问题的一部分，
关于方向键的映射。之前尝试改，这个掌机的方向键dpad其实是摇杆motion，
所以我加了模拟按键，但没成功，今天大概成功了，
我猜测之前不成功是因为没考虑消抖（需要在KEY_DOWN和KEY_UP之间加延迟），
我改成用线程发送模拟按键，KEY_DOWN和KEY_UP之间加上50毫秒左右的延迟，
但这个延迟不能太长或者太短，太短的话相当于没按（被消抖了），
太长的话会触发两次按键。其实还没完全解决键位问题，
还需要模拟ESC唤出PPSSPP菜单，这个功能暂时还没做。
另外我还修复了SDL光标显示问题，其实原来代码已经考虑了，
只是因为MOBILE宏定义的问题没生效，
我另外加一个宏去隐藏SDL光标

我似乎找到方法解决PPSSPP运行imouto.iso实妹相伴的大泉君
这个移植版PSP游戏会闪退的问题。方法是在闪退的代码附近
加上std::mutex互斥锁——其实在析构函数用usleep或者printf也可以解决。
不过我不确定这样改对不对。另外这个bug出现在sceMpeg，
所以只有很少情况下才会触发

我尝试在GPM2804上运行PPSSPP，虽然可以运行，但旋转了90度（270度），
所以我也卡在相同的问题上——怎么让PPSSPP旋转90度（270度）呢？
暂时无解，甚至在gh的issues上也有人问这个问题，
有人说是通过修改SDL2底层来旋转，但我倾向于用类似cocos2d-x的方法，
在GLES层面上旋转，但目前还做不到，这个问题估计要想很久，
我没有十足把握能解决这个问题

关于PPSSPP的转屏（它自己的说法是横屏和竖屏），我初步研究，
结论是很可能我也搞不定，虽然它自己自带了转屏功能——
只是转屏游戏本身，
但不能转屏UI，例如设置界面和文件管理器这些不能旋转90度。
有一些折衷方法，例如自己写一个可旋转90度的UI，
或者慢慢微调，但似乎现在没有很好的方法解决 ​​​

我目前PPSSPP旋转90度（270度）能做到的最好效果是这样
（看标题栏是在短边的上方），但我依然还是没做出来，
因为这只是PC版，我现在还没办法保证在掌机上也能这样子旋转90度，
而且即便能让UI旋转90度，里面的游戏显示仍然不行，
旋转了但偏移了而且长宽比不对——所以现在还是无解，
我也不知道能不能做出来

我现在能做到PPSSPP旋转90度的最好程度，显示Frame Buffer Object
贴图的一部分，但显示出来还是不行（下半部分缺失），
无语，不知道还要研究多久，可能永远都到达不到目的地，
反正研究不出来我也没办法开源出去，只能自己拿来琢磨。
其实还有俩问题，其一是热量明显比树莓派zero2w大，
其二是没声音，不过这俩问题我都无所谓了

PPSSPP的windows版里面的GE调试器，我猜测可能是一种内存断点——
在下面的列表中纹理标签下选择一个地址（列表中有些是内存地址有些不是，
右键菜单添加内存断点），然后当程序写入这个纹理数据的内存地址时
会触发断点暂停，就能显示出来，左边正方形的可能是源的纹理
（必须是方形），右边矩形可能是目标的屏幕

其实从某种意义上来说，我已经解决了PPSSPP在掌机上旋转90度的问题，
因为我发现我把设置改成软件渲染就会显示正常了，只有OpenGL下才会
显示不对——不过软件渲染很慢（纯2D也慢的程度），相当于不用
OpenGL的大部分功能，所以我还是暂时不开源我的修改方法，
除非等年底我实在搞不定再开源吧，当然如果能搞定
OpenGL显示问题也会立刻开源的——不过话说回来我还没看到有
其他人做PPSSPP屏幕旋转90度的尝试，至少官方没有给出明确的方法

PPSSPP的Windows版有个功能，掌机版是没有的，就是可以设置壁纸，
至于安卓版就不知道了。这个功能之所以没有，可能是因为它是硬着拉伸铺平的，
而且选择壁纸文件的对话框是用系统的文件选择对话框，
如果是掌机的话，可能这个文件选择就不好做了——那如果我想做金手指功能呢？
似乎PPSSPP也没做这样的功能

关于PPSSPP屏幕旋转90度的问题，PPSSPP源码里面确实有屏幕旋转这个菜单项，
叫Screen Rotation，对应的是这段代码：UI/GameSettingsScreen.cpp的
"Screen Rotation"这个字符串常量，不过我看过它其实只会在编译Android端的时候
才会被编译进系统菜单中，在非Android端下例如linux下是不生效的，
我测试过Android端确实是有这个菜单——我顺便试试安卓版PPSSPP也支持壁纸。
其他有些人演示PPSSPP的屏幕旋转功能也只是在安卓下演示

PPSSPP旋转90度研究。关于这个问题，现状是我可以在勾选Software Rendering
慢速的时候旋转90度，但OpenGL下不行，原因不明。
所以我现在没刻意一定要解决旋转问题，
我只是随意欣赏分析研究代码，希望能水到渠成。
之前说它的OpenGL是用FrameBufferObject显示，
准确说它分两种情况，当显示mpeg时（少数情况下），
vfb->fbo为空会走另外一个逻辑 FramebufferManagerCommon::DrawFramebufferToOutput，
但仍旧在FramebufferManagerCommon::CopyDisplayToOutput里面；
当不是mpeg（通常情况下）则跳过DrawFramebufferToOutput，
两种逻辑最终都会执行PresentationCommon::CopyToOutput。
至于勾选慢速软件显示下，则没有这种区别，
都会走SoftGPU::CopyToCurrentFboFromDisplayRam，
并且最终也会执行CopyToOutput完成显示。
这些操作都包裹在__DisplayFlip函数中（参考Core/HLE/sceDisplay.cpp）

PPSSPP旋转90度研究。无头绪。我猜测PPSSPP用FrameBufferObject
的原因是用于后处理，例如在设置-屏幕布局/滤镜-后处理着色器，
如果不用FrameBufferObject可能会很难做到类似的效果——
我觉得FrameBufferObject类似于赛车游戏的后视镜，
将一些3d显示转换成一个纹理，而FrameBufferObject
的用法主要就是绑定到一个纹理上，当绘画完OpenGL后
显示结果只出现在纹理上，相当于离屏绘画（不画在屏幕上），
有点类似于截屏

PPSSPP旋转90度研究。又再次完全没有头绪了，本来我以为找到
FrameBufferObject对应的纹理的大小，就可以解决显示不出来的问题，
不过我看了那个大小也是正常的。FrameBufferObject的初始化代码
可能是在这里，搜索glTexImage2D（在glGenFramebuffers和
glFramebufferTexture2D附近）：Common/GPU/OpenGL/GLQueueRunner.cpp。
另外我顺便修复一下截屏（这个功能需要绑定快捷键才能用）
在屏幕旋转下失败的问题，应该是作者故意这样写的
（这个bug最新版已经修复了，1.18.1才有），
位置是在Core/Screenshot.cpp，ApplyRotation和
TakeGameScreenshot，temp变量没有被填充所以
ApplyRotation会返回0宽度0高度的buf——当然我也不知道怎么改，
我只是让它在转屏下可以成功截屏罢了，但截屏的结果仍然是不对的

PPSSPP旋转90度研究，我尝试编译比1.18.1更新的版本，最新的git，
转屏问题依然没办法解决。我测试过最新的版本的sceMpeg依然有一定机会crash，
解决方法仍然需要加一个usleep延迟加在析构函数中（我的做法是用std::mutex） ​​​

PPSSPP旋转90度研究，想了一个折中的方法，虽然不是很完美，但似乎可行。
我的想法是同时支持0度和90度，当处于UI状态时或者UI暂停时旋转90度，
当进入游戏时旋转0度，这样就可以避免framebufferobject贴图缺失的问题
（原因不明）。至于我是怎么判断是否在游戏里面呢？
可以用UpdateUIState和GetUIState判断

PPSSPP旋转90度研究。我测试用gpm2804运行我的旋转90度双状态的修改方法，
效果勉强可以（很快我会更新开源到gh上，只是折中方法），
只是有几个问题未解决，非常的不完美：
（1）双状态导致fps跑到右下角（相当于竖屏的右上角），不过关掉fps就没事
（2）有些游戏可能会有奇怪的边缘线，
例如imouto.iso（中文移植的实妹相伴的大泉君），
不过其他游戏就不会出现
（3）声音还不行，要另外想办法修复

总体来说，我魔改编译的GPM2804版的PPSSPP，还是比不上R36S上那个PPSSPP那个好，
那个PPSSPP 1.17.1跑《实妹相伴的大泉君》移植PSP版几乎完美，除了两个地方，
一个是对话框显示似乎会有延迟，另一个是LR肩键按下去也有一些画面闪烁。
而我的魔改版就问题更多了，LR肩键无效，AB键交换，人物声音变尖
（但背景音却正常），不知道能否改好这些问题，暂时还是不如R36S版
```

## Fix MP3 sound bug (character voice in imouto.iso)  
* https://github.com/hrydgard/ppsspp/issues/5654
* Use FFmpegAudioDecoder instead of MiniMp3Audio
* https://github.com/weimingtom/ppsspp-1.18.1_fork/blob/master/Core/HW/SimpleAudioDec.cpp
* https://github.com/weimingtom/ppsspp-1.18.1_fork/blob/steamdeck/Core/HW/SimpleAudioDec.cpp
```
AudioDecoder *CreateAudioDecoder(PSPAudioType audioType, int sampleRateHz, int channels, size_t blockAlign, const uint8_t *extraData, size_t extraDataSize) {
	switch (audioType) {
	case PSP_CODEC_MP3:
#if 0
		return new MiniMp3Audio();
#else
		return new FFmpegAudioDecoder(audioType, sampleRateHz, channels);
#endif
	case PSP_CODEC_AT3:
		return CreateAtrac3Audio(channels, blockAlign, extraData, extraDataSize);
	case PSP_CODEC_AT3PLUS:
		return CreateAtrac3PlusAudio(channels, blockAlign);
	default:
		// Only AAC falls back to FFMPEG now.
		return new FFmpegAudioDecoder(audioType, sampleRateHz, channels);
	}
}
```

## Adding Steam Deck default key mapping
* Steam Deck Keymap My Changes (differences from default linux pad keymap)  
```
Remove all keyboard keymaps, and no ESC keyboard keymap
L==pad.b6;
R==pad.b5;
Accelerate==pad.ThumbL(Left joystick press);
Pause(a.k.a. PPSSPP Menu)==pad.ThumbR(Right joystick press) 
```
* https://github.com/weimingtom/ppsspp-1.18.1_fork/blob/master/Core/Config.cpp
```
void Config::LoadStandardControllerIni() {
	IniFile controllerIniFile;
//like this: $HOME/.config/ppsspp/PSP/SYSTEM/controls.ini
printf(">>> begin Config::LoadStandardControllerIni: %s\n", controllerIniFilename_.c_str());
printf(">>> g_isSteamDeck == %d\n", g_isSteamDeck);
	if (!controllerIniFile.Load(controllerIniFilename_)) {
printf(">>> after 1 Config::LoadStandardControllerIni\n");
g_isLoadControlsFailed = 1;
		ERROR_LOG(Log::Loader, "Failed to read %s. Setting controller config to default.", controllerIniFilename_.c_str());
		KeyMap::RestoreDefault();
	} else {
printf(">>> after 2 Config::LoadStandardControllerIni\n");
		// Continue anyway to initialize the config. It will just restore the defaults.
		KeyMap::LoadFromIni(controllerIniFile);
	}
printf(">>> end Config::LoadStandardControllerIni\n");
}
```
* https://github.com/weimingtom/ppsspp-1.18.1_fork/blob/master/SDL/SDLJoystick.cpp
```
	if (name && 0 == strcmp(name, "Steam Deck"))
	{
		g_isSteamDeck = 1;
		SDL_Log("<<< Found Steam Deck, g_isSteamDeck = 1\n");
if (g_isLoadControlsFailed == 1) {
	SDL_Log("<<< Found Steam Deck, g_isSteamDeck = 1, RestoreDefault again\n");
	//RestoreDefault again
	KeyMap::RestoreDefault();
}
	}
```
* https://github.com/weimingtom/ppsspp-1.18.1_fork/blob/master/Core/KeyMap.cpp
```
void RestoreDefault() {
...
	if (!g_isSteamDeck) {
		SetDefaultKeyMap(DEFAULT_MAPPING_KEYBOARD, true);
		SetDefaultKeyMap(DEFAULT_MAPPING_PAD, false);
	} else {
		SetDefaultKeyMap(DEFAULT_MAPPING_PAD, true);	
	}
```
* https://github.com/weimingtom/ppsspp-1.18.1_fork/blob/master/Core/KeyMapDefaults.cpp
```
static const DefMappingStruct defaultPadMapSteamDeck[] = {
	{CTRL_CROSS          , NKCODE_BUTTON_2},
	{CTRL_CIRCLE         , NKCODE_BUTTON_3},
	{CTRL_SQUARE         , NKCODE_BUTTON_4},
	{CTRL_TRIANGLE       , NKCODE_BUTTON_1},
	{CTRL_UP             , NKCODE_DPAD_UP},
	{CTRL_RIGHT          , NKCODE_DPAD_RIGHT},
	{CTRL_DOWN           , NKCODE_DPAD_DOWN},
	{CTRL_LEFT           , NKCODE_DPAD_LEFT},
	{CTRL_START          , NKCODE_BUTTON_10},
	{CTRL_SELECT         , NKCODE_BUTTON_9},
#if 1
	{CTRL_LTRIGGER       , NKCODE_BUTTON_6},
	{CTRL_RTRIGGER       , NKCODE_BUTTON_5},
#endif
	{VIRTKEY_AXIS_X_MIN, JOYSTICK_AXIS_X, -1},
	{VIRTKEY_AXIS_X_MAX, JOYSTICK_AXIS_X, +1},
	{VIRTKEY_AXIS_Y_MIN, JOYSTICK_AXIS_Y, +1},
	{VIRTKEY_AXIS_Y_MAX, JOYSTICK_AXIS_Y, -1},
#if 1
	{VIRTKEY_FASTFORWARD  , NKCODE_BUTTON_THUMBL},
	{VIRTKEY_PAUSE       , NKCODE_BUTTON_THUMBR},
#endif
};
```
```
void SetDefaultKeyMap(DefaultMaps dmap, bool replace) {
	switch (dmap) {
 ...
	case DEFAULT_MAPPING_PAD:
		if (!g_isSteamDeck) {
			SetDefaultKeyMap(DEVICE_ID_PAD_0, defaultPadMap, ARRAY_SIZE(defaultPadMap), replace);
		} else {
			SetDefaultKeyMap(DEVICE_ID_PAD_0, defaultPadMapSteamDeck, ARRAY_SIZE(defaultPadMapSteamDeck), replace);		
		}
		break;
```
* Weibo record
```
ppsspp研究，我试试晚上能不能解决steam deck的ppsspp键位问题——它的默认键位可能有问题，
很可能是因为它把键盘也加入到键位里面，但steam deck的一个按键可能会同时对应手柄和键盘
两者都有——当然这只是我猜测的原因，实际不清楚。别的linux掌机没这个问题，
因为别的掌机例如trimui smart pro压根就不会产生键盘输入

ppsspp研究，关于steam deck键位问题，我找到方法解决了，不过我不确定是否有别的问题，
待测试。总体来说，就是要复制默认键位到另一个数组（KeyMapDefaults.cpp），
然后修改L键、R键、加速键、暂停键（即PPSSPP菜单键）的键位，
映射到正确的按键上（后两个按键我是映射到左摇杆拇指按下和右摇杆拇指按下），
然后判断设备是否是steam deck，如果是就换成这个默认键位。至于怎么判断steam deck，
我的做法是判断控制器的名称（具体代码参考SDL2的test代码，我是整段复制过来用的，
ppsspp代码里面可能没有这样的判断）

ppsspp研究，关于昨天steam deck检测和默认键位问题，
我改了一下，改成检测steam deck和同时检测是否没有controls.ini配置文件。
如果判断到当前属于没有配置文件而初始化了，则需要再复位一次键位以冲走前一次复位，
因为如果不这样做，复位键位会在检测到steam deck控制器之前执行，
就没办法复位到steam deck的默认键位
```

