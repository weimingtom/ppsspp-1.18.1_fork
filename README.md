# ppsspp-1.18.1_fork
Try to cross compile PPSSPP 1.18.1 GLES no X11 version

## Original Readme  
* https://github.com/hrydgard/ppsspp/blob/v1.18.1/README.md  
* https://github.com/hrydgard/ppsspp/blob/v1.18.1/history.md  

## (WIP) How to build for PC xubuntu 20.04  
* sudo apt install libsdl2-dev cmake
* make clean && make -j8  
* (or use cmake) cd build; make -f ppsspp_v2.mk clean; cmake ..; make -j8  

## How to build for retropie / Raspberry Pi Zero 2W
* sudo nano /etc/dphys-swapfile  
* ./b.sh --rpi  
* cd build; cmake ..; make  
```
在树莓派上编译ppsspp太慢，似乎是因为retropie交换分区太小导致编译卡在某些cpp文件上，
我的做法是这样：sudo nano /etc/dphys-swapfile，从100改成1024，
然后重启生效，这样就能稍微好一点，避免编译被卡住——我觉得交换分区会写到tf卡，
虽然可行但会稍微会慢一些
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

# Build ffmpeg    
```
cd ffmpeg  
PATH=/home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin:$PATH ./linux_arm64.sh
PATH=/home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin:$PATH ./linux_armhf.sh
```

# sleep bug for rpi32 (rpizero2w), waveshare gpm280z2     
* see UI/NativeApp.cpp, NO_NATIVE_FRAME_SLEEP  
