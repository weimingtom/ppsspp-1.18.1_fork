
New Thread 0x7fff655fb700 (LWP 5028)]
[New Thread 0x7fff65dfc700 (LWP 5029)]
[New Thread 0x7fff64dfa700 (LWP 5030)]
[New Thread 0x7fff3d9fe700 (LWP 5031)]
[Thread 0x7fff3d9fe700 (LWP 5031) exited]
[New Thread 0x7fff3d1fd700 (LWP 5032)]
[New Thread 0x7fff3c9fc700 (LWP 5033)]
[Thread 0x7fff655fb700 (LWP 5028) exited]
21:47:105 root         N[BOOT]: UI/EmuScreen.cpp:385 Booted /home/wmt/imouto.iso...
<<<<<delete[]5 stream== 4CA1DEB0
21:49:132 decode       E[HLE]: HLE/HLE.cpp:374 sceMpegAvcDecode: Delaying a thread that's already waiting
free(): double free detected in tcache 2
--Type <RET> for more, q to quit, c to continue without paging--

Thread 54 "Emu" received signal SIGABRT, Aborted.
[Switching to Thread 0x7fff66ffd700 (LWP 5023)]
__GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
50	../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
#1  0x00007ffff78cb859 in __GI_abort () at abort.c:79
#2  0x00007ffff793626e in __libc_message (action=action@entry=do_abort, 
    fmt=fmt@entry=0x7ffff7a60298 "%s\n") at ../sysdeps/posix/libc_fatal.c:155
#3  0x00007ffff793e2fc in malloc_printerr (
    str=str@entry=0x7ffff7a625d0 "free(): double free detected in tcache 2")
    at malloc.c:5347
#4  0x00007ffff793ff6d in _int_free (av=0x7fff4c000020, p=0x7fff4ca12e20, 
    have_lock=0) at malloc.c:4201
#5  0x00005555559407aa in H264Frames::add (sz=1156, str=0x7ffe08aa6ffc "", 
    this=0x7fff440154e0) at Core/HLE/sceMpeg.cpp:906
#6  decodePmpVideo (pmpctxAddr=145320264, ringbuffer=...)
    at Core/HLE/sceMpeg.cpp:999
#7  sceMpegAvcDecode (initAddr=<optimized out>, bufferAddr=<optimized out>, 
    frameWidth=512, auAddr=<optimized out>, mpeg=145320264)
    at Core/HLE/sceMpeg.cpp:1175
#8  WrapU_UUUUU<sceMpegAvcDecode> () at ./Core/HLE/FunctionWrappers.h:707
#9  0x000055555588873d in CallSyscallWithoutFlags (
    info=0x555556932bc0 <sceMpeg+864>) at Core/HLE/HLE.cpp:659
#10 0x0000555535aba184 in ?? ()
#11 0x00005555569e8940 in ?? ()
#12 0x00005555569e8940 in ?? ()
#13 0x0000000000000000 in ?? ()





	~H264Frames(){
		size = 0;
		if (stream){ // && size > 0
//printf("<<<<<delete[]1 stream== %X, this==%X\n", stream, this);
			delete[] stream;
crash reason here???--->			stream = NULL;
//printf("<<<<<delete[]1 after stream== %X, this==%X\n", stream, this);
		}
	};
	
	void add(const H264Frames *p) {
		add(p->stream, p->size);
	};

	void add(const u8 *str, int sz) {
		int newsize = size + sz;
		u8* newstream = new u8[newsize];
		// join two streams
		memcpy(newstream, stream, size);
		memcpy(newstream + size, str, sz);
		// delete old stream
		if (stream) {
//printf("<<<<<delete[]2 stream== %X\n", stream);		
crash--->			delete[] stream;
			stream = NULL;
		}
		// replace with new stream
		stream = newstream;
		size = newsize;
	};


---------------


can use usleep(100) or printf() to solve this problem
I use std::mutex to solve it

