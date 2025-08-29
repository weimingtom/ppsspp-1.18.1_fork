======
$ nm PPSSPPSDL | grep 1.3.11 | c++filt


0113f11c b $d
0103d110 r alloc_table_3
01034114 r coeff_token_table_index.12541
0103611c r CSWTCH.252
01036114 r golomb_to_pict_type
0103e11c r mpa_huffbits_13
01134114 B npAuthMemStat
         U operator delete(void*, unsigned int, std::align_val_t)@@CXXABI_1.3.11
         U operator delete(void*, std::align_val_t)@@CXXABI_1.3.11
0113f11c u guard variable for SaveState::StateRingbuffer::Restore(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*)::buffer
0113d110 b tableVFPU3
0113f115 b SaveState::needsProcess
0113f114 b SaveState::needsRestart
0113f118 b SaveState::screenshotFailures
0113f110 b SaveState::lastSaveDataGeneration
         U operator new(unsigned int, std::align_val_t)@@CXXABI_1.3.11

====



