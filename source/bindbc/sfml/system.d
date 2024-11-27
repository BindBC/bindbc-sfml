
//          Copyright 2020 - 2021 Michael D. Parker
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module bindbc.sfml.system;

import bindbc.sfml.config;

// Config.h
enum CSFML_VERSION_MAJOR = 2;

static if(sfmlSupport == SFMLSupport.sfml252){
	enum CSFML_VERSION_MINOR = 5;
	enum CSFML_VERSION_PATCH = 2;
}else static if(sfmlSupport == SFMLSupport.sfml250){
	enum CSFML_VERSION_MINOR = 5;
	enum CSFML_VERSION_PATCH = 0;
}else static if(sfmlSupport == SFMLSupport.sfml240){
	enum CSFML_VERSION_MINOR = 4;
	enum CSFML_VERSION_PATCH = 0;
}else static if(sfmlSupport == SFMLSupport.sfml230){
	enum CSFML_VERSION_MINOR = 3;
	enum CSFML_VERSION_PATCH = 0;
}else static if(sfmlSupport == SFMLSupport.sfml220){
	enum CSFML_VERSION_MINOR = 2;
	enum CSFML_VERSION_PATCH = 0;
}else static if(sfmlSupport == SFMLSupport.sfml210){
	enum CSFML_VERSION_MINOR = 1;
	enum CSFML_VERSION_PATCH = 0;
}else{
	enum CSFML_VERSION_MINOR = 0;
	enum CSFML_VERSION_PATCH = 0;
}

alias sfBool = int;
enum sfFalse = 0;
enum sfTrue = 1;

alias sfInt8 = byte;
alias sfUint8 = ubyte;
alias sfInt16 = short;
alias sfUint16 = ushort;
alias sfInt32 = int;
alias sfUint32 = uint;
alias sfInt64 = long;
alias sfUint64 = ulong;

//System/Types.h
struct sfClock;
struct sfMutex;
struct sfThread;

//System/InputStream.h
extern(C) nothrow{
	alias sfInputStreamReadFunc = sfInt64 function(void*, sfInt64, void*);
	alias sfInputStreamSeekFunc = sfInt64 function(sfInt64, void*);
	alias sfInputStreamTellFunc = sfInt64 function(void*);
	alias sfInputStreamGetSizeFunc = sfInt64 function(void*);
}

struct sfInputStream{
	sfInputStreamReadFunc read;
	sfInputStreamSeekFunc seek;
	sfInputStreamTellFunc tell;
	sfInputStreamGetSizeFunc getSize;
	void* userData;
}

//System/Thread.h
/* This is not declared in the C header. It's solely for simplifying
the declaration of sfThread_Create in the binding */
extern(C) alias sfThreadFunc = void function(void*) nothrow;

//System/Time.h
struct sfTime{
	sfInt64 microseconds;
}

immutable(sfTime) sfTime_Zero;

//System/Vector2.h
struct sfVector2i{
	int x, y;
}

struct sfVector2u{
	uint x, y;
}

struct sfVector2f{
	float x, y;
}

//System/Vector3.h
struct sfVector3f{
	float x, y, z;
}

static if(staticSFML){
	extern(C) @nogc nothrow{
		//System/Clock.h
		sfClock* sfClock_create();
		sfClock* sfClock_copy(const(sfClock)* clock);
		void sfClock_destroy(sfClock* clock);
		sfTime sfClock_getElapsedTime(const(sfClock)* clock);
		sfTime sfClock_restart(sfClock* clock);
		
		//System/Mutex.h
		sfMutex* sfMutex_create();
		void sfMutex_destroy(sfMutex* mutex);
		void sfMutex_lock(sfMutex* mutex);
		void sfMutex_unlock(sfMutex* mutex);
		
		//System/Sleep.h
		void sfSleep(sfTime duration);
		
		//System/Thread.h
		sfThread* sfThread_create(sfThreadFunc _function,void* userData);
		void sfThread_destroy(sfThread* thread);
		void sfThread_launch(sfThread* thread);
		void sfThread_wait(sfThread* thread);
		void sfThread_terminate(sfThread* thread);
		
		//System/Time.h
		float sfTime_asSeconds(sfTime time);
		sfInt32 sfTime_asMilliseconds(sfTime time);
		sfInt64 sfTime_asMicroseconds(sfTime time);
		sfTime sfSeconds(float amount);
		sfTime sfMilliseconds(sfInt32 amount);
		sfTime sfMicroseconds(sfInt64 amount);
	}
}else{
	import bindbc.loader;
	
	extern(C) @nogc nothrow{
		//System/Clock.h
		alias psfClock_create = sfClock* function();
		alias psfClock_copy = sfClock* function(const(sfClock)* clock);
		alias psfClock_destroy = void function(sfClock* clock);
		alias psfClock_getElapsedTime = sfTime function(const(sfClock*) clock);
		alias psfClock_restart = sfTime function(sfClock* clock);
		
		//System/Mutex.h
		alias psfMutex_create = sfMutex* function();
		alias psfMutex_destroy = void function(sfMutex* mutex);
		alias psfMutex_lock = void function(sfMutex* mutex);
		alias psfMutex_unlock = void function(sfMutex* mutex);
		
		//System/Sleep.h
		alias psfSleep = void function(sfTime duration);
		
		//System/Thread.h
		alias psfThread_create = sfThread* function(sfThreadFunc _function,void* userData);
		alias psfThread_destroy = void function(sfThread* thread);
		alias psfThread_launch = void function(sfThread* thread);
		alias psfThread_wait = void function(sfThread* thread);
		alias psfThread_terminate = void function(sfThread* thread);
		
		//System/Time.h
		alias psfTime_asSeconds = float function(sfTime time);
		alias psfTime_asMilliseconds = sfInt32 function(sfTime time);
		alias psfTime_asMicroseconds = sfInt64 function(sfTime time);
		alias psfSeconds = sfTime function(float);
		alias psfMilliseconds = sfTime function(sfInt32);
		alias psfMicroseconds = sfTime function(sfInt64);
	}
	
	__gshared{
		psfClock_create sfClock_create;
		psfClock_copy sfClock_copy;
		psfClock_destroy sfClock_destroy;
		psfClock_getElapsedTime sfClock_getElapsedTime;
		psfClock_restart sfClock_restart;
		psfMutex_create sfMutex_create;
		psfMutex_destroy sfMutex_destroy;
		psfMutex_lock sfMutex_lock;
		psfMutex_unlock sfMutex_unlock;
		psfSleep sfSleep;
		psfThread_create sfThread_create;
		psfThread_destroy sfThread_destroy;
		psfThread_launch sfThread_launch;
		psfThread_wait sfThread_wait;
		psfThread_terminate sfThread_terminate;
		psfTime_asSeconds sfTime_asSeconds;
		psfTime_asMilliseconds sfTime_asMilliseconds;
		psfTime_asMicroseconds sfTime_asMicroseconds;
		psfSeconds sfSeconds;
		psfMilliseconds sfMilliseconds;
		psfMicroseconds sfMicroseconds;
	}
	
	private{
		SharedLib lib;
		SFMLSupport loadedVersion;
	}
	
	@nogc nothrow:
	SFMLSupport loadedSFMLSystemVersion(){ return loadedVersion; }
	
	bool isSFMLSystemLoaded(){
		return lib != invalidHandle;
	}
	
	SFMLSupport loadSFMLSystem(){
		version(Windows){
			const(char)[][3] libNames = [
				"csfml-system.dll",
				"csfml-system-2.dll",
				"csfml-system-2.0.dll"
			];
		}else version(OSX){
			const(char)[][3] libNames = [
				"libcsfml-system.dylib",
				"libcsfml-system.2.dylib",
				"libcsfml-system.2.0.dylib"
			];
		}else version(Posix){
			const(char)[][3] libNames = [
				"libcsfml-system.so",
				"libcsfml-system.so.2",
				"libcsfml-system.so.2.0"
			];
		}
		
		SFMLSupport ret;
		foreach(name; libNames){
			ret = loadSFMLSystem(name.ptr);
			if(ret != SFMLSupport.noLibrary) break;
		}
		return ret;
	}
	
	SFMLSupport loadSFMLSystem(const(char)* libName){
		lib = load(libName);
		if(lib == invalidHandle){
			return SFMLSupport.noLibrary;
		}
		
		auto errCount = errorCount();
		loadedVersion = SFMLSupport.badLibrary;
		
		lib.bindSymbol(cast(void**)&sfClock_create,"sfClock_create");
		lib.bindSymbol(cast(void**)&sfClock_copy,"sfClock_copy");
		lib.bindSymbol(cast(void**)&sfClock_destroy,"sfClock_destroy");
		lib.bindSymbol(cast(void**)&sfClock_getElapsedTime,"sfClock_getElapsedTime");
		lib.bindSymbol(cast(void**)&sfClock_restart,"sfClock_restart");
		lib.bindSymbol(cast(void**)&sfMutex_create,"sfMutex_create");
		lib.bindSymbol(cast(void**)&sfMutex_destroy,"sfMutex_destroy");
		lib.bindSymbol(cast(void**)&sfMutex_lock,"sfMutex_lock");
		lib.bindSymbol(cast(void**)&sfMutex_unlock,"sfMutex_unlock");
		lib.bindSymbol(cast(void**)&sfSleep,"sfSleep");
		lib.bindSymbol(cast(void**)&sfThread_create,"sfThread_create");
		lib.bindSymbol(cast(void**)&sfThread_destroy,"sfThread_destroy");
		lib.bindSymbol(cast(void**)&sfThread_launch,"sfThread_launch");
		lib.bindSymbol(cast(void**)&sfThread_wait,"sfThread_wait");
		lib.bindSymbol(cast(void**)&sfThread_terminate,"sfThread_terminate");
		lib.bindSymbol(cast(void**)&sfTime_asSeconds,"sfTime_asSeconds");
		lib.bindSymbol(cast(void**)&sfTime_asMilliseconds,"sfTime_asMilliseconds");
		lib.bindSymbol(cast(void**)&sfTime_asMicroseconds,"sfTime_asMicroseconds");
		lib.bindSymbol(cast(void**)&sfSeconds,"sfSeconds");
		lib.bindSymbol(cast(void**)&sfMilliseconds,"sfMilliseconds");
		lib.bindSymbol(cast(void**)&sfMicroseconds,"sfMicroseconds");
		
		loadedVersion = sfmlSupport;
		return loadedVersion;
	}
}

