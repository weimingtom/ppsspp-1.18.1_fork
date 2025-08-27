Core\KeyMap.cpp
Core\KeyMapDefaults.h
Core\KeyMapDefaults.cpp


Core\KeyMap.cpp
void RestoreDefault() {
	std::lock_guard<std::recursive_mutex> guard(g_controllerMapLock);
	g_controllerMap.clear();
	g_controllerMapGeneration++;

	if (IsVREnabled()) {
		SetDefaultKeyMap(DEFAULT_MAPPING_VR_HEADSET, false);
		return;
	}

#if PPSSPP_PLATFORM(WINDOWS)
	SetDefaultKeyMap(DEFAULT_MAPPING_KEYBOARD, true);
	SetDefaultKeyMap(DEFAULT_MAPPING_XINPUT, false);
	SetDefaultKeyMap(DEFAULT_MAPPING_PAD, false);
#elif PPSSPP_PLATFORM(ANDROID)
	// Autodetect a few common (and less common) devices
	// Note that here we check the device name, not the controller name. We don't get
	// the controller name until a button has been pressed so can't use it to set defaults.
	std::string name = System_GetProperty(SYSPROP_NAME);
	if (IsNvidiaShield(name)) {
		SetDefaultKeyMap(DEFAULT_MAPPING_SHIELD, false);
	} else if (IsOuya(name)) {
		SetDefaultKeyMap(DEFAULT_MAPPING_OUYA, false);
	} else if (IsXperiaPlay(name)) {
		SetDefaultKeyMap(DEFAULT_MAPPING_XPERIA_PLAY, false);
	} else if (IsMOQII7S(name)) {
		SetDefaultKeyMap(DEFAULT_MAPPING_MOQI_I7S, false);
	} else if (IsRetroid(name)) {
		SetDefaultKeyMap(DEFAULT_MAPPING_RETROID_CONTROLLER, false);
	} else {
		SetDefaultKeyMap(DEFAULT_MAPPING_ANDROID_PAD, false);
	}
#elif PPSSPP_PLATFORM(IOS)
	SetDefaultKeyMap(DEFAULT_MAPPING_IOS_PAD, false);
#else
	SetDefaultKeyMap(DEFAULT_MAPPING_KEYBOARD, true);
	SetDefaultKeyMap(DEFAULT_MAPPING_PAD, false);
#endif
}


gamecontrollerdb.txt
SDL\SDLJoystick.cpp


SDL_GameControllerOpen



Core\Config.cpp
void Config::LoadStandardControllerIni() {
	IniFile controllerIniFile;
//like this: $HOME/.config/ppsspp/PSP/SYSTEM/controls.ini
printf(">>> Config::LoadStandardControllerIni %s\n", controllerIniFilename_.c_str());
	if (!controllerIniFile.Load(controllerIniFilename_)) {


