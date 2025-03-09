# ppsspp-1.18.1_fork
Try to cross compile PPSSPP 1.18.1 GLES no X11 version

## Original Readme  
* https://github.com/hrydgard/ppsspp/blob/v1.18.1/README.md  
* https://github.com/hrydgard/ppsspp/blob/v1.18.1/history.md  

## References  
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
```

## (WIP) How to build for Trimui Smart Pro
* Modify Makefile for cross compile toolchain  
* make MIYOO=2 clean && make MIYOO=2 -j8
* (or use cmake) sudo apt install cmake
* (or use cmake) cd build; make -f ppsspp_v2.mk clean; make -f ppsspp_v2.mk; make -j8
* (or use cmake) cd build; make -f ppsspp_v2.mk clean; . ./ppsspp_v2.sh; make -j8

## Bugs  
* Too slow
* imouto.iso (实妹相伴的大泉君psp移植版) too slow (especially audo delay) and sometimes crash  
* Toheart2 psp crash, need to disable buffer (but also crash?)      

## TODO  
* (done) Remove ext\armips\Tests\Core\Includes\??asm  
* Change to -O3 -g0
```
Makefile
#-O3 -g0 some games will crash
CCFLAGS += -O0 -g3
```
* Support Raspberry Pi Zero 2 W and Waveshare GPM280Z2
* (changed ? not sync) assets/redump.csv  

# Build ffmpeg, only for official ppsspp code      
```
cd ffmpeg  
PATH=/home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin:$PATH ./linux_arm64.sh
PATH=/home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin:$PATH ./linux_armhf.sh
```

# sleep bug for rpi32 (rpizero2w), waveshare gpm280z2     
* see UI/NativeApp.cpp, NO_NATIVE_FRAME_SLEEP  
