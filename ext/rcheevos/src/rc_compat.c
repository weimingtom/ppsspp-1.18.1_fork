#include "rc_compat.h"

#include <assert.h>
#include <ctype.h>
#include <stdarg.h>

#ifdef RC_C89_HELPERS

int rc_strncasecmp(const char* left, const char* right, size_t length)
{
  while (length)
  {
    if (*left != *right)
    {
      const int diff = tolower(*left) - tolower(*right);
      if (diff != 0)
        return diff;
    }

    ++left;
    ++right;
    --length;
  }

  return 0;
}

int rc_strcasecmp(const char* left, const char* right)
{
  while (*left || *right)
  {
    if (*left != *right)
    {
      const int diff = tolower(*left) - tolower(*right);
      if (diff != 0)
        return diff;
    }

    ++left;
    ++right;
  }

  return 0;
}

char* rc_strdup(const char* str)
{
  const size_t length = strlen(str);
  char* buffer = (char*)malloc(length + 1);
  if (buffer)
    memcpy(buffer, str, length + 1);
  return buffer;
}

int rc_snprintf(char* buffer, size_t size, const char* format, ...)
{
  int result;
  va_list args;

  va_start(args, format);

#ifdef __STDC_SECURE_LIB__
  result = vsprintf_s(buffer, size, format, args);
#else
  /* assume buffer is large enough and ignore size */
  (void)size;
  result = vsprintf(buffer, format, args);
#endif

  va_end(args);

  return result;
}

#endif

#ifndef __STDC_SECURE_LIB__

struct tm* rc_gmtime_s(struct tm* buf, const time_t* timer)
{
  struct tm* tm = gmtime(timer);
  memcpy(buf, tm, sizeof(*tm));
  return buf;
}

#endif

#ifndef RC_NO_THREADS

#if defined(_WIN32)

/* https://learn.microsoft.com/en-us/archive/msdn-magazine/2012/november/windows-with-c-the-evolution-of-synchronization-in-windows-and-c */
/* implementation largely taken from https://github.com/libsdl-org/SDL/blob/0fc3574/src/thread/windows/SDL_sysmutex.c */

#if defined(WINVER) && WINVER >= 0x0600

void rc_mutex_init(rc_mutex_t* mutex)
{
  InitializeSRWLock(&mutex->srw_lock);
  /* https://learn.microsoft.com/en-us/windows/win32/procthread/thread-handles-and-identifiers */
  /* thread ids are never 0 */
  mutex->owner = 0;
  mutex->count = 0;
}

void rc_mutex_destroy(rc_mutex_t* mutex)
{
  /* Nothing to do here */
  (void)mutex;
}

void rc_mutex_lock(rc_mutex_t* mutex)
{
  DWORD current_thread = GetCurrentThreadId();
  if (mutex->owner == current_thread) {
    ++mutex->count;
    assert(mutex->count > 0);
  }
  else {
    AcquireSRWLockExclusive(&mutex->srw_lock);
    assert(mutex->owner == 0 && mutex->count == 0);
    mutex->owner = current_thread;
    mutex->count = 1;
  }
}

void rc_mutex_unlock(rc_mutex_t* mutex)
{
  if (mutex->owner == GetCurrentThreadId()) {
    assert(mutex->count > 0);
    if (--mutex->count == 0) {
      mutex->owner = 0;
      ReleaseSRWLockExclusive(&mutex->srw_lock);
    }
  }
  else {
    assert(!"Tried to unlock unowned mutex");
  }
}

#else

void rc_mutex_init(rc_mutex_t* mutex)
{
  InitializeCriticalSection(&mutex->critical_section);
}

void rc_mutex_destroy(rc_mutex_t* mutex)
{
  DeleteCriticalSection(&mutex->critical_section);
}

void rc_mutex_lock(rc_mutex_t* mutex)
{
  EnterCriticalSection(&mutex->critical_section);
}

void rc_mutex_unlock(rc_mutex_t* mutex)
{
  LeaveCriticalSection(&mutex->critical_section);
}

#endif

#elif defined(GEKKO)

/* https://github.com/libretro/RetroArch/pull/16116 */

void rc_mutex_init(rc_mutex_t* mutex)
{
  LWP_MutexInit(mutex, NULL);
}

void rc_mutex_destroy(rc_mutex_t* mutex)
{
  LWP_MutexDestroy(mutex);
}

void rc_mutex_lock(rc_mutex_t* mutex)
{
  LWP_MutexLock(mutex);
}

void rc_mutex_unlock(rc_mutex_t* mutex)
{
  LWP_MutexUnlock(mutex);
}

#else

void rc_mutex_init(rc_mutex_t* mutex)
{
  pthread_mutex_init(mutex, NULL);
}

void rc_mutex_destroy(rc_mutex_t* mutex)
{
  pthread_mutex_destroy(mutex);
}

void rc_mutex_lock(rc_mutex_t* mutex)
{
  pthread_mutex_lock(mutex);
}

void rc_mutex_unlock(rc_mutex_t* mutex)
{
  pthread_mutex_unlock(mutex);
}

#endif
#endif /* RC_NO_THREADS */
