# ppsspp-1.18.1_fork
Try to cross compile PPSSPP 1.18.1 GLES no X11 version

## Original Readme  
* https://github.com/hrydgard/ppsspp/blob/v1.18.1/README.md  
* https://github.com/hrydgard/ppsspp/blob/v1.18.1/history.md  

## TODO  
* Remove ext\armips\Tests\Core\Includes\??asm  

## (WIP) How to build for PC xubuntu 20.04  
* sudo apt install libsdl2-dev cmake
* make clean && make -j8  
* (or use cmake) cd build; make -f ppsspp_v2.mk clean; cmake ..; make -j8  

## (WIP) How to build for Trimui Smart Pro
* Modify Makefile for cross compile toolchain  
* make MIYOO=2 clean && make MIYOO=2 -j8
* (or use cmake) sudo apt install cmake
* (or use cmake) cd build; make -f ppsspp_v2.mk clean; make -f ppsspp_v2.mk; make -j8
* (or use cmake) cd build; make -f ppsspp_v2.mk clean; . ./ppsspp_v2.sh; make -j8
