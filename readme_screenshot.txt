could not save screenshot
UI/NativeApp.cpp

ESC->Controls->Control mapping->Screenshot->set to F12

b TakeGameScreenshot
b Save888RGBScreenshot
b Core/Screenshot.cpp:365
b Core/Screenshot.cpp:338

buf.GetStride()
buf.GetHeight()
print(buf)
$6 = {alloc_ = false, data_ = 0x0, stride_ = 0, height_ = 0, fmt_ = GPU_DBG_FORMAT_INVALID, flipped_ = false}


Thread 54 "Emu" hit Breakpoint 1, TakeGameScreenshot (draw=draw@entry=0x5555572946b0, filename=..., fmt=ScreenshotFormat::JPG, type=type@entry=SCREENSHOT_OUTPUT, 
    width=width@entry=0x0, height=height@entry=0x0, maxRes=-1) at Core/Screenshot.cpp:332
332	bool TakeGameScreenshot(Draw::DrawContext *draw, const Path &filename, ScreenshotFormat fmt, ScreenshotType type, int *width, int *height, int maxRes) {
(gdb) bt
#0  TakeGameScreenshot (draw=draw@entry=0x5555572946b0, filename=..., fmt=ScreenshotFormat::JPG, type=type@entry=SCREENSHOT_OUTPUT, width=width@entry=0x0, 
    height=height@entry=0x0, maxRes=-1) at Core/Screenshot.cpp:332
#1  0x00005555556ea3ae in TakeScreenshot (draw=0x5555572946b0) at UI/NativeApp.cpp:993
#2  0x00005555556ea931 in CallbackPostRender (userdata=<optimized out>, dc=<optimized out>) at ./Common/UI/Context.h:103
#3  CallbackPostRender (dc=<optimized out>, userdata=<optimized out>) at UI/NativeApp.cpp:1012
#4  0x0000555555d3cfab in ScreenManager::render (this=0x555556fd6ef0) at ./Common/UI/Screen.h:138
#5  0x00005555556ee4a9 in NativeFrame (graphicsContext=0x555556fe01f0) at UI/NativeApp.cpp:1136
#6  0x000055555581f10d in UpdateRunLoop (ctx=<optimized out>) at Core/Core.cpp:212
#7  0x0000555555c4b048 in EmuThreadFunc (graphicsContext=0x555556fe01f0) at SDL/SDLMain.cpp:700
#8  0x00007ffff7cfedf4 in ?? () from /lib/x86_64-linux-gnu/libstdc++.so.6
#9  0x00007ffff7aa3609 in start_thread (arg=<optimized out>) at pthread_create.c:477
#10 0x00007ffff79c8353 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

(gdb) bt
#0  TakeGameScreenshot (draw=draw@entry=0x5555572946b0, filename=..., fmt=ScreenshotFormat::JPG, type=type@entry=SCREENSHOT_OUTPUT, width=width@entry=0x0, 
    height=height@entry=0x0, maxRes=-1) at Core/Screenshot.cpp:368
#1  0x00005555556ea3ae in TakeScreenshot (draw=0x5555572946b0) at UI/NativeApp.cpp:993
#2  0x00005555556ea931 in CallbackPostRender (userdata=<optimized out>, dc=<optimized out>) at ./Common/UI/Context.h:103
#3  CallbackPostRender (dc=<optimized out>, userdata=<optimized out>) at UI/NativeApp.cpp:1012
#4  0x0000555555d3cfab in ScreenManager::render (this=0x555556fd6ef0) at ./Common/UI/Screen.h:138
#5  0x00005555556ee4a9 in NativeFrame (graphicsContext=0x555556fe01f0) at UI/NativeApp.cpp:1136
#6  0x000055555581f10d in UpdateRunLoop (ctx=<optimized out>) at Core/Core.cpp:212
#7  0x0000555555c4b048 in EmuThreadFunc (graphicsContext=0x555556fe01f0) at SDL/SDLMain.cpp:700
#8  0x00007ffff7cfedf4 in ?? () from /lib/x86_64-linux-gnu/libstdc++.so.6
#9  0x00007ffff7aa3609 in start_thread (arg=<optimized out>) at pthread_create.c:477
#10 0x00007ffff79c8353 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95




	if (success) {
		u8 *flipbuffer = nullptr;
		const u8 *buffer = ConvertBufferToScreenshot(buf, false, flipbuffer, w, h);
		success = buffer != nullptr;
		if (success) {
			if (width)
				*width = w;
			if (height)
				*height = h;

//FIXME:w==0, h==0, so success==false
			success = Save888RGBScreenshot(filename, fmt, buffer, w, h);
		}
		delete[] flipbuffer;
	}

	if (!success) {
		ERROR_LOG(Log::IO, "Failed to write screenshot.");
	}




Thread 54 "Emu" hit Breakpoint 2, Save888RGBScreenshot (filename=..., fmt=ScreenshotFormat::JPG, bufferRGB888=0x7fff44a95ec0 "", w=0, h=0) at Core/Screenshot.cpp:385
385	bool Save888RGBScreenshot(const Path &filename, ScreenshotFormat fmt, const u8 *bufferRGB888, int w, int h) {
(gdb) bt
#0  Save888RGBScreenshot (filename=..., fmt=ScreenshotFormat::JPG, bufferRGB888=0x7fff44a95ec0 "", w=0, h=0) at Core/Screenshot.cpp:385
#1  0x00005555559f4a82 in TakeGameScreenshot (draw=draw@entry=0x5555572946b0, filename=..., fmt=ScreenshotFormat::JPG, type=type@entry=SCREENSHOT_OUTPUT, width=width@entry=0x0, 
    height=height@entry=0x0, maxRes=-1) at Core/Screenshot.cpp:373
#2  0x00005555556ea3ae in TakeScreenshot (draw=0x5555572946b0) at UI/NativeApp.cpp:993
#3  0x00005555556ea931 in CallbackPostRender (userdata=<optimized out>, dc=<optimized out>) at ./Common/UI/Context.h:103
#4  CallbackPostRender (dc=<optimized out>, userdata=<optimized out>) at UI/NativeApp.cpp:1012
#5  0x0000555555d3cfab in ScreenManager::render (this=0x555556fd6ef0) at ./Common/UI/Screen.h:138
#6  0x00005555556ee4a9 in NativeFrame (graphicsContext=0x555556fe01f0) at UI/NativeApp.cpp:1136
#7  0x000055555581f10d in UpdateRunLoop (ctx=<optimized out>) at Core/Core.cpp:212
#8  0x0000555555c4b048 in EmuThreadFunc (graphicsContext=0x555556fe01f0) at SDL/SDLMain.cpp:700
#9  0x00007ffff7cfedf4 in ?? () from /lib/x86_64-linux-gnu/libstdc++.so.6
#10 0x00007ffff7aa3609 in start_thread (arg=<optimized out>) at pthread_create.c:477
#11 0x00007ffff79c8353 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95












After ::GetOutputFramebuffer, buf gets its stride_ and height_ not zero
see L355, success = ::GetOutputFramebuffer(draw, buf);
(gdb) l
350			if (success) {
351				buf = ApplyRotation(temp, g_display.rotation);
352			}
353		} else {
354			_dbg_assert_(draw);
355			success = ::GetOutputFramebuffer(draw, buf);
356		}
357	
358		if (!success) {
359			ERROR_LOG(Log::G3D, "Failed to obtain screenshot data.");
(gdb) print(buf)
$6 = {alloc_ = false, data_ = 0x0, stride_ = 0, height_ = 0, fmt_ = GPU_DBG_FORMAT_INVALID, flipped_ = false}
(gdb) n
<<<<<<<<<<<<SDL_KEYUP, 1073741893
<<<<<<<<<<<<SDL_KEYDOWN, 13, 66
<<<<<<<<<<<<SDL_KEYUP, 13
358		if (!success) {
(gdb) print(buf)
$7 = {alloc_ = true, 
  data_ = 0x7fff4cbc59a0 "FV*\377DU)\377CS(\377CS(\377CT)\377EW*\377HY*\377K\\+\377K\\,\377HZ+\377DV)\377EV)\377P^8\377\\iG\377frP\377\\iD\377=N'\377-?\032\377'6\031\377#/\027\377 +\024\377\034%\022\377\034%\022\377 +\024\377/>\035\377AT)\377Ja/\377Mf1\377Le1\377Ha1\377B]-\377<V)\377\066P%\377;Y)\377Bc.\377Bd/\377Ac/\377Ad/\377Cg1\377Hl4\377Vv?\377d\201L\377j\205S\377i\205U\377b\177P\377]{L\377ZwJ\377Mn>\377@c3\377Ad4\377"..., stride_ = 481, height_ = 272, fmt_ = GPU_DBG_FORMAT_8888, flipped_ = true}





