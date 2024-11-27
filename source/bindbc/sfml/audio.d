
//          Copyright 2020 - 2021 Michael D. Parker
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module bindbc.sfml.audio;

import bindbc.sfml.config;
static if(bindSFMLAudio):

import bindbc.sfml.system;

//Audio/Types.h
struct sfMusic;
struct sfSound;
struct sfSoundBuffer;
struct sfSoundBufferRecorder;
struct sfSoundRecorder;
struct sfSoundStream;

static if(sfmlSupport >= SFMLSupport.sfml250){
	struct sfTimeSpan{
		sfTime offset;
		sfTime length;
	}
}

<<<<<<< HEAD
//Audio/SoundRecorder.h
=======
// Audio/SoundRecorder.h
>>>>>>> master
extern(C) nothrow{
	alias sfSoundRecorderStartCallback = sfBool function(void*);
	alias sfSoundRecorderProcessCallback = sfBool function(const(sfInt16)*,size_t,void*);
	alias sfSoundRecorderStopCallback = void function(void*);
}

<<<<<<< HEAD
//Audio/SoundStatus.h
=======
// Audio/SoundStatus.h
>>>>>>> master
enum sfSoundStatus{
	sfStopped,
	sfPaused,
	sfPlaying,
}
mixin(expandEnum!sfSoundStatus);

<<<<<<< HEAD
//Audio/SoundStream.h
=======
// Audio/SoundStream.h
>>>>>>> master
struct sfSoundStreamChunk{
	sfInt16* samples;
	uint sampleCount;
}

extern(C) nothrow{
	alias sfSoundStreamGetDataCallback = sfBool function(sfSoundStreamChunk*,void*);
	alias sfSoundStreamSeekCallback = void function(sfTime,void*);
}

static if(staticSFML){
	extern(C) @nogc nothrow{
<<<<<<< HEAD
		//Audio/Listener.h
=======
		// Audio/Listener.h
>>>>>>> master
		void sfListener_setGlobalVolume(float volume);
		float sfListener_getGlobalVolume();
		void sfListener_setPosition(sfVector3f position);
		sfVector3f sfListener_getPosition();
		void sfListener_setDirection(sfVector3f orientation);
		sfVector3f sfListener_getDirection();
<<<<<<< HEAD
		
		//Audio/Music.h
=======

		// Audio/Music.h
>>>>>>> master
		sfMusic* sfMusic_createFromFile(const(char)* filename);
		sfMusic* sfMusic_createFromMemory(const(void)* data, size_t sizeInBytes);
		sfMusic* sfMusic_createFromStream(sfInputStream* stream);
		void sfMusic_destroy(sfMusic* music);
		void sfMusic_setLoop(sfMusic* music, sfBool loop);
		sfBool sfMusic_getLoop(const(sfMusic)* music);
		sfTime sfMusic_getDuration(const(sfMusic)* music);
		void sfMusic_play(sfMusic* music);
		void sfMusic_pause(sfMusic* music);
		void sfMusic_stop(sfMusic* music);
		uint sfMusic_getChannelCount(const(sfMusic)* music);
		uint sfMusic_getSampleRate(const(sfMusic)* music);
		sfSoundStatus sfMusic_getStatus(const(sfMusic)* music);
		sfTime sfMusic_getPlayingOffset(const(sfMusic)* music);
		void sfMusic_setPitch(sfMusic* music, float pitch);
		void sfMusic_setVolume(sfMusic* music, float volume);
		void sfMusic_setPosition(sfMusic* music, sfVector3f position);
		void sfMusic_setRelativeToListener(sfMusic* music, sfBool relative);
		void sfMusic_setMinDistance(sfMusic* music, float distance);
		void sfMusic_setAttenuation(sfMusic* music, float attenuation);
		void sfMusic_setPlayingOffset(sfMusic* music, sfTime timeOffset);
		float sfMusic_getPitch(const(sfMusic)* music);
		float sfMusic_getVolume(const(sfMusic)* music);
		sfVector3f sfMusic_getPosition(const(sfMusic)* music);
		sfBool sfMusic_isRelativeToListener(const(sfMusic)* music);
		float sfMusic_getMinDistance(const(sfMusic)* music);
		float sfMusic_getAttenuation(const(sfMusic)* music);
<<<<<<< HEAD
		
		//Audio/Sound.h
=======

		// Audio/Sound.h
>>>>>>> master
		sfSound* sfSound_create();
		sfSound* sfSound_copy(const(sfSound)* sound);
		void sfSound_destroy(sfSound* sound);
		void sfSound_play(sfSound* sound);
		void sfSound_pause(sfSound* sound);
		void sfSound_stop(sfSound* sound);
		void sfSound_setBuffer(sfSound* sound, const(sfSoundBuffer)* buffer);
		const(sfSoundBuffer)* sfSound_getBuffer(const(sfSound)* sound);
		void sfSound_setLoop(sfSound* sound, sfBool loop);
		sfBool sfSound_getLoop(const(sfSound)* sound);
		sfSoundStatus sfSound_getStatus(const(sfSound)* sound);
		void sfSound_setPitch(sfSound* sound, float pitch);
		void sfSound_setVolume(sfSound* sound, float volume);
		void sfSound_setPosition(sfSound* sound, sfVector3f position);
		void sfSound_setRelativeToListener(sfSound* sound, sfBool relative);
		void sfSound_setMinDistance(sfSound* sound, float distance);
		void sfSound_setAttenuation(sfSound* sound, float attenuation);
		void sfSound_setPlayingOffset(sfSound* sound, sfTime timeOffset);
		float sfSound_getPitch(const(sfSound)* sound);
		float sfSound_getVolume(const(sfSound)* sound);
		sfVector3f sfSound_getPosition(const(sfSound)* sound);
		sfBool sfSound_isRelativeToListener(const(sfSound)* sound);
		float sfSound_getMinDistance(const(sfSound)* sound);
		float sfSound_getAttenuation(const(sfSound)* sound);
		sfTime sfSound_getPlayingOffset(const(sfSound)* sound);
<<<<<<< HEAD
		
		//Audio/SoundBuffer.h
=======

		// Audio/SoundBuffer.h
>>>>>>> master
		sfSoundBuffer* sfSoundBuffer_createFromFile(const(char)* filename);
		sfSoundBuffer* sfSoundBuffer_createFromMemory(const(void)* data, size_t sizeInBytes);
		sfSoundBuffer* sfSoundBuffer_createFromStream(sfInputStream* stream);
		sfSoundBuffer* sfSoundBuffer_copy(const(sfSoundBuffer)* soundBuffer);
		void sfSoundBuffer_destroy(sfSoundBuffer* soundBuffer);
		sfBool sfSoundBuffer_saveToFile(const(sfSoundBuffer)* soundBuffer, const(char)* filename);
		const(sfInt16)* sfSoundBuffer_getSamples(const(sfSoundBuffer)* soundBuffer);
		uint sfSoundBuffer_getSampleRate(const(sfSoundBuffer)* soundBuffer);
		uint sfSoundBuffer_getChannelCount(const(sfSoundBuffer)* soundBuffer);
		sfTime sfSoundBuffer_getDuration(const(sfSoundBuffer)* soundBuffer);
<<<<<<< HEAD
		
		static if(sfmlSupport >= SFMLSupport.sfml230){
			sfSoundBuffer* sfSoundBuffer_createFromSamples(const(sfInt16)* samples, sfUint64 sampleCount, uint channelCount, uint sampleRate);
			sfUint64 sfSoundBuffer_getSampleCount(const(sfSoundBuffer)* soundBuffer);
		}else{
			sfSoundBuffer* sfSoundBuffer_createFromSamples(const(sfInt16)* samples, size_t sampleCount, uint channelCount, uint sampleRate);
			size_t sfSoundBuffer_getSampleCount(const(sfSoundBuffer)* soundBuffer);
		}
		
		//Audio/SoundBufferRecorder.h
=======

		static if(sfmlSupport >= SFMLSupport.sfml230){
			sfSoundBuffer* sfSoundBuffer_createFromSamples(const(sfInt16)* samples, sfUint64 sampleCount, uint channelCount, uint sampleRate);
			sfUint64 sfSoundBuffer_getSampleCount(const(sfSoundBuffer)* soundBuffer);
		}
		else{
			sfSoundBuffer* sfSoundBuffer_createFromSamples(const(sfInt16)* samples, size_t sampleCount, uint channelCount, uint sampleRate);
			size_t sfSoundBuffer_getSampleCount(const(sfSoundBuffer)* soundBuffer);
		}

		// Audio/SoundBufferRecorder.h
>>>>>>> master
		sfSoundBufferRecorder* sfSoundBufferRecorder_create();
		void sfSoundBufferRecorder_destroy(sfSoundBufferRecorder* soundBufferRecorder);
		void sfSoundBufferRecorder_stop(sfSoundBufferRecorder* soundBufferRecorder);
		uint sfSoundBufferRecorder_getSampleRate(const(sfSoundBufferRecorder)* soundBufferRecorder);
		const(sfSoundBuffer)* sfSoundBufferRecorder_getBuffer(const(sfSoundBufferRecorder)* soundBufferRecorder);
<<<<<<< HEAD
		
		static if(sfmlSupport >= SFMLSupport.sfml240){
			sfBool sfSoundBufferRecorder_start(sfSoundBufferRecorder* soundBufferRecorder, uint sampleRate);
		}else{
			void sfSoundBufferRecorder_start(sfSoundBufferRecorder* soundBufferRecorder, uint sampleRate);
		}
		
		//Audio/SoundRecorder.h
		sfSoundRecorder* sfSoundRecorder_create(sfSoundRecorderStartCallback onStart, sfSoundRecorderProcessCallback onProcess, sfSoundRecorderStopCallback onStop, void* userData);
=======

		static if(sfmlSupport >= SFMLSupport.sfml240){
			sfBool sfSoundBufferRecorder_start(sfSoundBufferRecorder* soundBufferRecorder, uint sampleRate);
		}
		else void sfSoundBufferRecorder_start(sfSoundBufferRecorder* soundBufferRecorder, uint sampleRate);

		// Audio/SoundRecorder.h
		sfSoundRecorder* sfSoundRecorder_create(sfSoundRecorderStartCallback   onStart,
												sfSoundRecorderProcessCallback onProcess,
												sfSoundRecorderStopCallback    onStop,
												void*                          userData);
>>>>>>> master
		void sfSoundRecorder_destroy(sfSoundRecorder* soundRecorder);
		void sfSoundRecorder_stop(sfSoundRecorder* soundRecorder);
		uint sfSoundRecorder_getSampleRate(const(sfSoundRecorder)* soundRecorder);
		sfBool sfSoundRecorder_isAvailable();
<<<<<<< HEAD
		
		static if(sfmlSupport >= SFMLSupport.sfml220){
			sfBool sfSoundRecorder_start(sfSoundRecorder* soundRecorder, uint sampleRate);
		}else{
			void sfSoundRecorder_start(sfSoundRecorder* soundRecorder, uint sampleRate);
		}
		
		//Audio/SoundStream.h
		sfSoundStream* sfSoundStream_create(sfSoundStreamGetDataCallback onGetData, sfSoundStreamSeekCallback onSeek, uint channelCount, uint sampleRate, void* userData);
=======

		static if(sfmlSupport >= SFMLSupport.sfml220){
			sfBool sfSoundRecorder_start(sfSoundRecorder* soundRecorder, uint sampleRate);
		}
		else void sfSoundRecorder_start(sfSoundRecorder* soundRecorder, uint sampleRate);

		// Audio/SoundStream.h
		sfSoundStream* sfSoundStream_create(sfSoundStreamGetDataCallback onGetData,
											sfSoundStreamSeekCallback    onSeek,
											uint                 channelCount,
											uint                 sampleRate,
											void*                userData);
>>>>>>> master
		void sfSoundStream_destroy(sfSoundStream* soundStream);
		void sfSoundStream_play(sfSoundStream* soundStream);
		void sfSoundStream_pause(sfSoundStream* soundStream);
		void sfSoundStream_stop(sfSoundStream* soundStream);
		sfSoundStatus sfSoundStream_getStatus(const(sfSoundStream)* soundStream);
		uint sfSoundStream_getChannelCount(const(sfSoundStream)* soundStream);
		uint sfSoundStream_getSampleRate(const(sfSoundStream)* soundStream);
		void sfSoundStream_setPitch(sfSoundStream* soundStream, float pitch);
		void sfSoundStream_setVolume(sfSoundStream* soundStream, float volume);
		void sfSoundStream_setPosition(sfSoundStream* soundStream, sfVector3f position);
		void sfSoundStream_setRelativeToListener(sfSoundStream* soundStream, sfBool relative);
		void sfSoundStream_setMinDistance(sfSoundStream* soundStream, float distance);
		void sfSoundStream_setAttenuation(sfSoundStream* soundStream, float attenuation);
		void sfSoundStream_setPlayingOffset(sfSoundStream* soundStream, sfTime timeOffset);
		void sfSoundStream_setLoop(sfSoundStream* soundStream, sfBool loop);
		float sfSoundStream_getPitch(const(sfSoundStream)* soundStream);
		float sfSoundStream_getVolume(const(sfSoundStream)* soundStream);
		sfVector3f sfSoundStream_getPosition(const(sfSoundStream)* soundStream);
		sfBool sfSoundStream_isRelativeToListener(const(sfSoundStream)* soundStream);
		float sfSoundStream_getMinDistance(const(sfSoundStream)* soundStream);
		float sfSoundStream_getAttenuation(const(sfSoundStream)* soundStream);
		sfBool sfSoundStream_getLoop(const(sfSoundStream)* soundStream);
		sfTime sfSoundStream_getPlayingOffset(const(sfSoundStream)* soundStream);
<<<<<<< HEAD
		
		static if(sfmlSupport >= SFMLSupport.sfml220){
			//Audio/Listener.h
			void sfListener_setUpVector(sfVector3f upVector);
			sfVector3f sfListener_getUpVector();
			
			//Audio/SoundRecorder.h
=======

		static if(sfmlSupport >= SFMLSupport.sfml220){
			// Audio/Listener.h
			void sfListener_setUpVector(sfVector3f upVector);
			sfVector3f sfListener_getUpVector();

			// Audio/SoundRecorder.h
>>>>>>> master
			void sfSoundRecorder_setProcessingInterval(sfSoundRecorder* soundRecorder, sfTime interval);
			const(char*)* sfSoundRecorder_getAvailableDevices(size_t* count);
			const(char)* sfSoundRecorder_getDefaultDevice();
			sfBool sfSoundRecorder_setDevice(sfSoundRecorder* soundRecorder, const(char)* name);
			const(char)* sfSoundRecorder_getDevice(sfSoundRecorder* soundRecorder);
		}
		static if(sfmlSupport >= sfmlSupport.sfml240){
<<<<<<< HEAD
			//Audio/SoundBufferRecorder.h
			sfBool sfSoundBufferRecorder_setDevice(sfSoundBufferRecorder* soundBufferRecorder, const(char)* name);
			const(char)* sfSoundBufferRecorder_getDevice(sfSoundBufferRecorder* soundBufferRecorder);
			
			//Audio/SoundRecorder.h
=======
			// Audio/SoundBufferRecorder.h
			sfBool sfSoundBufferRecorder_setDevice(sfSoundBufferRecorder* soundBufferRecorder, const(char)* name);
			const(char)* sfSoundBufferRecorder_getDevice(sfSoundBufferRecorder* soundBufferRecorder);

			// Audio/SoundRecorder.h
>>>>>>> master
			void sfSoundRecorder_setChannelCount(sfSoundRecorder* soundRecorder, uint channelCount);
			uint sfSoundRecorder_getChannelCount(const(sfSoundRecorder)* soundRecorder);
		}
		static if(sfmlSupport >= sfmlSupport.sfml250){
<<<<<<< HEAD
			//Audio/Music.h
=======
			// Audio/Music.h
>>>>>>> master
			sfTimeSpan sfMusic_getLoopPoints(const(sfMusic)* music);
			void sfMusic_setLoopPoints(sfMusic* music, sfTimeSpan timePoints);
		}
	}
<<<<<<< HEAD
}else{
	import bindbc.loader;
	
	extern(C) @nogc nothrow{
		//Audio/Listener.h
		alias psfListener_setGlobalVolume = void function(float volume);
		alias psfListener_getGlobalVolume = float function();
		alias psfListener_setPosition = void function(sfVector3f position);
		alias psfListener_getPosition = sfVector3f function();
		alias psfListener_setDirection = void function(sfVector3f orientation);
		alias psfListener_getDirection = sfVector3f function();
		
		//Audio/Music.h
		alias psfMusic_createFromFile = sfMusic* function(const(char)* filename);
		alias psfMusic_createFromMemory = sfMusic* function(const(void)* data, size_t sizeInBytes);
		alias psfMusic_createFromStream = sfMusic* function(sfInputStream* stream);
		alias psfMusic_destroy = void function(sfMusic* music);
		alias psfMusic_setLoop = void function(sfMusic* music, sfBool loop);
		alias psfMusic_getLoop = sfBool function(const(sfMusic)* music);
		alias psfMusic_getDuration = sfTime function(const(sfMusic)* music);
		alias psfMusic_play = void function(sfMusic* music);
		alias psfMusic_pause = void function(sfMusic* music);
		alias psfMusic_stop = void function(sfMusic* music);
		alias psfMusic_getChannelCount = uint function(const(sfMusic)* music);
		alias psfMusic_getSampleRate = uint function(const(sfMusic)* music);
		alias psfMusic_getStatus = sfSoundStatus function(const(sfMusic)* music);
		alias psfMusic_getPlayingOffset = sfTime function(const(sfMusic)* music);
		alias psfMusic_setPitch = void function(sfMusic* music, float pitch);
		alias psfMusic_setVolume = void function(sfMusic* music, float volume);
		alias psfMusic_setPosition = void function(sfMusic* music, sfVector3f position);
		alias psfMusic_setRelativeToListener = void function(sfMusic* music, sfBool relative);
		alias psfMusic_setMinDistance = void function(sfMusic* music, float distance);
		alias psfMusic_setAttenuation = void function(sfMusic* music, float attenuation);
		alias psfMusic_setPlayingOffset = void function(sfMusic* music, sfTime timeOffset);
		alias psfMusic_getPitch = float function(const(sfMusic)* music);
		alias psfMusic_getVolume = float function(const(sfMusic)* music);
		alias psfMusic_getPosition = sfVector3f function(const(sfMusic)* music);
		alias psfMusic_isRelativeToListener = sfBool function(const(sfMusic)* music);
		alias psfMusic_getMinDistance = float function(const(sfMusic)* music);
		alias psfMusic_getAttenuation = float function(const(sfMusic)* music);
		
		//Audio/Sound.h
		alias psfSound_create = sfSound* function();
		alias psfSound_copy = sfSound* function(const(sfSound)* sound);
		alias psfSound_destroy = void function(sfSound* sound);
		alias psfSound_play = void function(sfSound* sound);
		alias psfSound_pause = void function(sfSound* sound);
		alias psfSound_stop = void function(sfSound* sound);
		alias psfSound_setBuffer = void function(sfSound* sound, const(sfSoundBuffer)* buffer);
		alias psfSound_getBuffer = const(sfSoundBuffer)* function(const(sfSound)* sound);
		alias psfSound_setLoop = void function(sfSound* sound, sfBool loop);
		alias psfSound_getLoop = sfBool function(const(sfSound)* sound);
		alias psfSound_getStatus = sfSoundStatus function(const(sfSound)* sound);
		alias psfSound_setPitch = void function(sfSound* sound, float pitch);
		alias psfSound_setVolume = void function(sfSound* sound, float volume);
		alias psfSound_setPosition = void function(sfSound* sound, sfVector3f position);
		alias psfSound_setRelativeToListener = void function(sfSound* sound, sfBool relative);
		alias psfSound_setMinDistance = void function(sfSound* sound, float distance);
		alias psfSound_setAttenuation = void function(sfSound* sound, float attenuation);
		alias psfSound_setPlayingOffset = void function(sfSound* sound, sfTime timeOffset);
		alias psfSound_getPitch = float function(const(sfSound)* sound);
		alias psfSound_getVolume = float function(const(sfSound)* sound);
		alias psfSound_getPosition = sfVector3f function(const(sfSound)* sound);
		alias psfSound_isRelativeToListener = sfBool function(const(sfSound)* sound);
		alias psfSound_getMinDistance = float function(const(sfSound)* sound);
		alias psfSound_getAttenuation = float function(const(sfSound)* sound);
		alias psfSound_getPlayingOffset = sfTime function(const(sfSound)* sound);
		
		//Audio/SoundBuffer.h
		alias psfSoundBuffer_createFromFile = sfSoundBuffer* function(const(char)* filename);
		alias psfSoundBuffer_createFromMemory = sfSoundBuffer* function(const(void)* data, size_t sizeInBytes);
		alias psfSoundBuffer_createFromStream = sfSoundBuffer* function(sfInputStream* stream);
		alias psfSoundBuffer_copy = sfSoundBuffer* function(const(sfSoundBuffer)* soundBuffer);
		alias psfSoundBuffer_destroy = void function(sfSoundBuffer* soundBuffer);
		alias psfSoundBuffer_saveToFile = sfBool function(const(sfSoundBuffer)* soundBuffer, const(char)* filename);
		alias psfSoundBuffer_getSamples = const(sfInt16)* function(const(sfSoundBuffer)* soundBuffer);
		alias psfSoundBuffer_getSampleRate = uint function(const(sfSoundBuffer)* soundBuffer);
		alias psfSoundBuffer_getChannelCount = uint function(const(sfSoundBuffer)* soundBuffer);
		alias psfSoundBuffer_getDuration = sfTime function(const(sfSoundBuffer)* soundBuffer);
		
		static if(sfmlSupport >= SFMLSupport.sfml230){
			alias psfSoundBuffer_createFromSamples = sfSoundBuffer* function(const(sfInt16)* samples, sfUint64 sampleCount, uint channelCount, uint sampleRate);
			alias psfSoundBuffer_getSampleCount = sfUint64 function(const(sfSoundBuffer)* soundBuffer);
		}else{
			alias psfSoundBuffer_createFromSamples = sfSoundBuffer* function(const(sfInt16)* samples, size_t sampleCount, uint channelCount, uint sampleRate);
			alias psfSoundBuffer_getSampleCount = size_t function(const(sfSoundBuffer)* soundBuffer);
		}
		
		//Audio/SoundBufferRecorder.h
		alias psfSoundBufferRecorder_create = sfSoundBufferRecorder* function();
		alias psfSoundBufferRecorder_destroy = void function(sfSoundBufferRecorder* soundBufferRecorder);
		alias psfSoundBufferRecorder_stop = void function(sfSoundBufferRecorder* soundBufferRecorder);
		alias psfSoundBufferRecorder_getSampleRate = uint function(const(sfSoundBufferRecorder)* soundBufferRecorder);
		alias psfSoundBufferRecorder_getBuffer = const(sfSoundBuffer)* function(const(sfSoundBufferRecorder)* soundBufferRecorder);
		
		static if(sfmlSupport >= SFMLSupport.sfml240){
			alias psfSoundBufferRecorder_start = sfBool function(sfSoundBufferRecorder* soundBufferRecorder, uint sampleRate);
		}else{
			alias psfSoundBufferRecorder_start = void function(sfSoundBufferRecorder* soundBufferRecorder, uint sampleRate);
		}
		
		//Audio/SoundRecorder.h
		alias psfSoundRecorder_create = sfSoundRecorder* function(sfSoundRecorderStartCallback onStart, sfSoundRecorderProcessCallback onProcess, sfSoundRecorderStopCallback onStop, void* userData);
		alias psfSoundRecorder_destroy = void function(sfSoundRecorder* soundRecorder);
		alias psfSoundRecorder_stop = void function(sfSoundRecorder* soundRecorder);
		alias psfSoundRecorder_getSampleRate = uint function(const(sfSoundRecorder)* soundRecorder);
		alias psfSoundRecorder_isAvailable = sfBool function();
		
		static if(sfmlSupport >= SFMLSupport.sfml220){
			alias psfSoundRecorder_start = sfBool function(sfSoundRecorder* soundRecorder, uint sampleRate);
		}else{
			alias psfSoundRecorder_start = void function(sfSoundRecorder* soundRecorder, uint sampleRate);
		}
		
		//Audio/SoundStream.h
		alias psfSoundStream_create = sfSoundStream* function(sfSoundStreamGetDataCallback onGetData, sfSoundStreamSeekCallback onSeek, uint channelCount, uint sampleRate, void* userData);
		alias psfSoundStream_destroy = void function(sfSoundStream* soundStream);
		alias psfSoundStream_play = void function(sfSoundStream* soundStream);
		alias psfSoundStream_pause = void function(sfSoundStream* soundStream);
		alias psfSoundStream_stop = void function(sfSoundStream* soundStream);
		alias psfSoundStream_getStatus = sfSoundStatus function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getChannelCount = uint function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getSampleRate = uint function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_setPitch = void function(sfSoundStream* soundStream, float pitch);
		alias psfSoundStream_setVolume = void function(sfSoundStream* soundStream, float volume);
		alias psfSoundStream_setPosition = void function(sfSoundStream* soundStream, sfVector3f position);
		alias psfSoundStream_setRelativeToListener = void function(sfSoundStream* soundStream, sfBool relative);
		alias psfSoundStream_setMinDistance = void function(sfSoundStream* soundStream, float distance);
		alias psfSoundStream_setAttenuation = void function(sfSoundStream* soundStream, float attenuation);
		alias psfSoundStream_setPlayingOffset = void function(sfSoundStream* soundStream, sfTime timeOffset);
		alias psfSoundStream_setLoop = void function(sfSoundStream* soundStream, sfBool loop);
		alias psfSoundStream_getPitch = float function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getVolume = float function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getPosition = sfVector3f function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_isRelativeToListener = sfBool function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getMinDistance = float function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getAttenuation = float function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getLoop = sfBool function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getPlayingOffset = sfTime function(const(sfSoundStream)* soundStream);
		
		static if(sfmlSupport >= SFMLSupport.sfml220){
			//Audio/Listener.h
			alias psfListener_setUpVector = void function(sfVector3f upVector);
			alias psfListener_getUpVector = sfVector3f function();
			
			//Audio/SoundRecorder.h
			alias psfSoundRecorder_setProcessingInterval = void function(sfSoundRecorder* soundRecorder, sfTime interval);
			alias psfSoundRecorder_getAvailableDevices = const(char*)* function(size_t* count);
			alias psfSoundRecorder_getDefaultDevice = const(char)* function();
			alias psfSoundRecorder_setDevice = sfBool function(sfSoundRecorder* soundRecorder, const(char)* name);
			alias psfSoundRecorder_getDevice = const(char)* function(sfSoundRecorder* soundRecorder);
		}
		static if(sfmlSupport >= sfmlSupport.sfml240){
			//Audio/SoundBufferRecorder.h
			alias psfSoundBufferRecorder_setDevice = sfBool function(sfSoundBufferRecorder* soundBufferRecorder, const(char)* name);
			alias psfSoundBufferRecorder_getDevice = const(char)* function(sfSoundBufferRecorder* soundBufferRecorder);
			
			//Audio/SoundRecorder.h
			alias psfSoundRecorder_setChannelCount = void function(sfSoundRecorder* soundRecorder, uint channelCount);
			alias psfSoundRecorder_getChannelCount = uint function(const(sfSoundRecorder)* soundRecorder);
		}
		static if(sfmlSupport >= sfmlSupport.sfml250){
			//Audio/Music.h
			alias psfMusic_getLoopPoints = sfTimeSpan function(const(sfMusic)* music);
			alias psfMusic_setLoopPoints = void function(sfMusic* music, sfTimeSpan timePoints);
		}
	}
	
	__gshared{
		psfListener_setGlobalVolume sfListener_setGlobalVolume;
		psfListener_getGlobalVolume sfListener_getGlobalVolume;
		psfListener_setPosition sfListener_setPosition;
		psfListener_getPosition sfListener_getPosition;
		psfListener_setDirection sfListener_setDirection;
		psfListener_getDirection sfListener_getDirection;
		psfMusic_createFromFile sfMusic_createFromFile;
		psfMusic_createFromMemory sfMusic_createFromMemory;
		psfMusic_createFromStream sfMusic_createFromStream;
		psfMusic_destroy sfMusic_destroy;
		psfMusic_setLoop sfMusic_setLoop;
		psfMusic_getLoop sfMusic_getLoop;
		psfMusic_getDuration sfMusic_getDuration;
		psfMusic_play sfMusic_play;
		psfMusic_pause sfMusic_pause;
		psfMusic_stop sfMusic_stop;
		psfMusic_getChannelCount sfMusic_getChannelCount;
		psfMusic_getSampleRate sfMusic_getSampleRate;
		psfMusic_getStatus sfMusic_getStatus;
		psfMusic_getPlayingOffset sfMusic_getPlayingOffset;
		psfMusic_setPitch sfMusic_setPitch;
		psfMusic_setVolume sfMusic_setVolume;
		psfMusic_setPosition sfMusic_setPosition;
		psfMusic_setRelativeToListener sfMusic_setRelativeToListener;
		psfMusic_setMinDistance sfMusic_setMinDistance;
		psfMusic_setAttenuation sfMusic_setAttenuation;
		psfMusic_setPlayingOffset sfMusic_setPlayingOffset;
		psfMusic_getPitch sfMusic_getPitch;
		psfMusic_getVolume sfMusic_getVolume;
		psfMusic_getPosition sfMusic_getPosition;
		psfMusic_isRelativeToListener sfMusic_isRelativeToListener;
		psfMusic_getMinDistance sfMusic_getMinDistance;
		psfMusic_getAttenuation sfMusic_getAttenuation;
		psfSound_create sfSound_create;
		psfSound_copy sfSound_copy;
		psfSound_destroy sfSound_destroy;
		psfSound_play sfSound_play;
		psfSound_pause sfSound_pause;
		psfSound_stop sfSound_stop;
		psfSound_setBuffer sfSound_setBuffer;
		psfSound_getBuffer sfSound_getBuffer;
		psfSound_setLoop sfSound_setLoop;
		psfSound_getLoop sfSound_getLoop;
		psfSound_getStatus sfSound_getStatus;
		psfSound_setPitch sfSound_setPitch;
		psfSound_setVolume sfSound_setVolume;
		psfSound_setPosition sfSound_setPosition;
		psfSound_setRelativeToListener sfSound_setRelativeToListener;
		psfSound_setMinDistance sfSound_setMinDistance;
		psfSound_setAttenuation sfSound_setAttenuation;
		psfSound_setPlayingOffset sfSound_setPlayingOffset;
		psfSound_getPitch sfSound_getPitch;
		psfSound_getVolume sfSound_getVolume;
		psfSound_getPosition sfSound_getPosition;
		psfSound_isRelativeToListener sfSound_isRelativeToListener;
		psfSound_getMinDistance sfSound_getMinDistance;
		psfSound_getAttenuation sfSound_getAttenuation;
		psfSound_getPlayingOffset sfSound_getPlayingOffset;
		psfSoundBuffer_createFromFile sfSoundBuffer_createFromFile;
		psfSoundBuffer_createFromMemory sfSoundBuffer_createFromMemory;
		psfSoundBuffer_createFromStream sfSoundBuffer_createFromStream;
		psfSoundBuffer_createFromSamples sfSoundBuffer_createFromSamples;
		psfSoundBuffer_copy sfSoundBuffer_copy;
		psfSoundBuffer_destroy sfSoundBuffer_destroy;
		psfSoundBuffer_saveToFile sfSoundBuffer_saveToFile;
		psfSoundBuffer_getSamples sfSoundBuffer_getSamples;
		psfSoundBuffer_getSampleCount sfSoundBuffer_getSampleCount;
		psfSoundBuffer_getSampleRate sfSoundBuffer_getSampleRate;
		psfSoundBuffer_getChannelCount sfSoundBuffer_getChannelCount;
		psfSoundBuffer_getDuration sfSoundBuffer_getDuration;
		psfSoundBufferRecorder_create sfSoundBufferRecorder_create;
		psfSoundBufferRecorder_destroy sfSoundBufferRecorder_destroy;
		psfSoundBufferRecorder_start sfSoundBufferRecorder_start;
		psfSoundBufferRecorder_stop sfSoundBufferRecorder_stop;
		psfSoundBufferRecorder_getSampleRate sfSoundBufferRecorder_getSampleRate;
		psfSoundBufferRecorder_getBuffer sfSoundBufferRecorder_getBuffer;
		psfSoundRecorder_create sfSoundRecorder_create;
		psfSoundRecorder_destroy sfSoundRecorder_destroy;
		psfSoundRecorder_start sfSoundRecorder_start;
		psfSoundRecorder_stop sfSoundRecorder_stop;
		psfSoundRecorder_getSampleRate sfSoundRecorder_getSampleRate;
		psfSoundRecorder_isAvailable sfSoundRecorder_isAvailable;
		psfSoundStream_create sfSoundStream_create;
		psfSoundStream_destroy sfSoundStream_destroy;
		psfSoundStream_play sfSoundStream_play;
		psfSoundStream_pause sfSoundStream_pause;
		psfSoundStream_stop sfSoundStream_stop;
		psfSoundStream_getStatus sfSoundStream_getStatus;
		psfSoundStream_getChannelCount sfSoundStream_getChannelCount;
		psfSoundStream_getSampleRate sfSoundStream_getSampleRate;
		psfSoundStream_setPitch sfSoundStream_setPitch;
		psfSoundStream_setVolume sfSoundStream_setVolume;
		psfSoundStream_setPosition sfSoundStream_setPosition;
		psfSoundStream_setRelativeToListener sfSoundStream_setRelativeToListener;
		psfSoundStream_setMinDistance sfSoundStream_setMinDistance;
		psfSoundStream_setAttenuation sfSoundStream_setAttenuation;
		psfSoundStream_setPlayingOffset sfSoundStream_setPlayingOffset;
		psfSoundStream_setLoop sfSoundStream_setLoop;
		psfSoundStream_getPitch sfSoundStream_getPitch;
		psfSoundStream_getVolume sfSoundStream_getVolume;
		psfSoundStream_getPosition sfSoundStream_getPosition;
		psfSoundStream_isRelativeToListener sfSoundStream_isRelativeToListener;
		psfSoundStream_getMinDistance sfSoundStream_getMinDistance;
		psfSoundStream_getAttenuation sfSoundStream_getAttenuation;
		psfSoundStream_getLoop sfSoundStream_getLoop;
		psfSoundStream_getPlayingOffset sfSoundStream_getPlayingOffset;
		
		static if(sfmlSupport >= SFMLSupport.sfml220){
			psfListener_setUpVector sfListener_setUpVector;
			psfListener_getUpVector sfListener_getUpVector;
			psfSoundRecorder_setProcessingInterval sfSoundRecorder_setProcessingInterval;
			psfSoundRecorder_getAvailableDevices sfSoundRecorder_getAvailableDevices;
			psfSoundRecorder_getDefaultDevice sfSoundRecorder_getDefaultDevice;
			psfSoundRecorder_setDevice sfSoundRecorder_setDevice;
			psfSoundRecorder_getDevice sfSoundRecorder_getDevice;
		}
		static if(sfmlSupport >= SFMLSupport.sfml240){
			psfSoundBufferRecorder_setDevice sfSoundBufferRecorder_setDevice;
			psfSoundBufferRecorder_getDevice sfSoundBufferRecorder_getDevice;
			psfSoundRecorder_setChannelCount sfSoundRecorder_setChannelCount;
			psfSoundRecorder_getChannelCount sfSoundRecorder_getChannelCount;
		}
		static if(sfmlSupport >= sfmlSupport.sfml250){
			psfMusic_getLoopPoints sfMusic_getLoopPoints;
			psfMusic_setLoopPoints sfMusic_setLoopPoints;
		}
	}
	private{
		SharedLib lib;
		SFMLSupport loadedVersion;
	}
	
	@nogc nothrow:
	SFMLSupport loadedSFMLAudioVersion(){ return loadedVersion; }
	
	bool isSFMLAudioLoaded(){
		return lib != invalidHandle;
	}
	
	SFMLSupport loadSFMLAudio(){
		version(Windows){
			const(char)[][3] libNames = [
				"csfml-audio.dll",
				"csfml-audio-2.dll",
				"csfml-audio-2.0.dll"
			];
		}else version(OSX){
			const(char)[][3] libNames = [
				"libcsfml-audio.dylib",
				"libcsfml-audio.2.dylib",
				"libcsfml-audio.2.0.dylib"
			];
		}else version(Posix){
			const(char)[][3] libNames = [
				"libcsfml-audio.so",
				"libcsfml-audio.so.2",
				"libcsfml-audio.so.2.0"
			];
		}
		
		SFMLSupport ret;
		foreach(name; libNames){
			ret = loadSFMLAudio(name.ptr);
			if(ret != SFMLSupport.noLibrary) break;
		}
		return ret;
	}
	
	SFMLSupport loadSFMLAudio(const(char)* libName){
		lib = load(libName);
		if(lib == invalidHandle){
			return SFMLSupport.noLibrary;
		}
		
		auto errCount = errorCount();
		loadedVersion = SFMLSupport.badLibrary;
		
		lib.bindSymbol(cast(void**)&sfListener_setGlobalVolume,"sfListener_setGlobalVolume");
		lib.bindSymbol(cast(void**)&sfListener_getGlobalVolume,"sfListener_getGlobalVolume");
		lib.bindSymbol(cast(void**)&sfListener_setPosition,"sfListener_setPosition");
		lib.bindSymbol(cast(void**)&sfListener_getPosition,"sfListener_getPosition");
		lib.bindSymbol(cast(void**)&sfListener_setDirection,"sfListener_setDirection");
		lib.bindSymbol(cast(void**)&sfListener_getDirection,"sfListener_getDirection");
		lib.bindSymbol(cast(void**)&sfMusic_createFromFile,"sfMusic_createFromFile");
		lib.bindSymbol(cast(void**)&sfMusic_createFromMemory,"sfMusic_createFromMemory");
		lib.bindSymbol(cast(void**)&sfMusic_createFromStream,"sfMusic_createFromStream");
		lib.bindSymbol(cast(void**)&sfMusic_destroy,"sfMusic_destroy");
		lib.bindSymbol(cast(void**)&sfMusic_setLoop,"sfMusic_setLoop");
		lib.bindSymbol(cast(void**)&sfMusic_getLoop,"sfMusic_getLoop");
		lib.bindSymbol(cast(void**)&sfMusic_getDuration,"sfMusic_getDuration");
		lib.bindSymbol(cast(void**)&sfMusic_play,"sfMusic_play");
		lib.bindSymbol(cast(void**)&sfMusic_pause,"sfMusic_pause");
		lib.bindSymbol(cast(void**)&sfMusic_stop,"sfMusic_stop");
		lib.bindSymbol(cast(void**)&sfMusic_getChannelCount,"sfMusic_getChannelCount");
		lib.bindSymbol(cast(void**)&sfMusic_getSampleRate,"sfMusic_getSampleRate");
		lib.bindSymbol(cast(void**)&sfMusic_getStatus,"sfMusic_getStatus");
		lib.bindSymbol(cast(void**)&sfMusic_getPlayingOffset,"sfMusic_getPlayingOffset");
		lib.bindSymbol(cast(void**)&sfMusic_setPitch,"sfMusic_setPitch");
		lib.bindSymbol(cast(void**)&sfMusic_setVolume,"sfMusic_setVolume");
		lib.bindSymbol(cast(void**)&sfMusic_setPosition,"sfMusic_setPosition");
		lib.bindSymbol(cast(void**)&sfMusic_setRelativeToListener,"sfMusic_setRelativeToListener");
		lib.bindSymbol(cast(void**)&sfMusic_setMinDistance,"sfMusic_setMinDistance");
		lib.bindSymbol(cast(void**)&sfMusic_setAttenuation,"sfMusic_setAttenuation");
		lib.bindSymbol(cast(void**)&sfMusic_setPlayingOffset,"sfMusic_setPlayingOffset");
		lib.bindSymbol(cast(void**)&sfMusic_getPitch,"sfMusic_getPitch");
		lib.bindSymbol(cast(void**)&sfMusic_getVolume,"sfMusic_getVolume");
		lib.bindSymbol(cast(void**)&sfMusic_getPosition,"sfMusic_getPosition");
		lib.bindSymbol(cast(void**)&sfMusic_isRelativeToListener,"sfMusic_isRelativeToListener");
		lib.bindSymbol(cast(void**)&sfMusic_getMinDistance,"sfMusic_getMinDistance");
		lib.bindSymbol(cast(void**)&sfMusic_getAttenuation,"sfMusic_getAttenuation");
		lib.bindSymbol(cast(void**)&sfSound_create,"sfSound_create");
		lib.bindSymbol(cast(void**)&sfSound_copy,"sfSound_copy");
		lib.bindSymbol(cast(void**)&sfSound_destroy,"sfSound_destroy");
		lib.bindSymbol(cast(void**)&sfSound_play,"sfSound_play");
		lib.bindSymbol(cast(void**)&sfSound_pause,"sfSound_pause");
		lib.bindSymbol(cast(void**)&sfSound_stop,"sfSound_stop");
		lib.bindSymbol(cast(void**)&sfSound_setBuffer,"sfSound_setBuffer");
		lib.bindSymbol(cast(void**)&sfSound_getBuffer,"sfSound_getBuffer");
		lib.bindSymbol(cast(void**)&sfSound_setLoop,"sfSound_setLoop");
		lib.bindSymbol(cast(void**)&sfSound_getLoop,"sfSound_getLoop");
		lib.bindSymbol(cast(void**)&sfSound_getStatus,"sfSound_getStatus");
		lib.bindSymbol(cast(void**)&sfSound_setPitch,"sfSound_setPitch");
		lib.bindSymbol(cast(void**)&sfSound_setVolume,"sfSound_setVolume");
		lib.bindSymbol(cast(void**)&sfSound_setPosition,"sfSound_setPosition");
		lib.bindSymbol(cast(void**)&sfSound_setRelativeToListener,"sfSound_setRelativeToListener");
		lib.bindSymbol(cast(void**)&sfSound_setMinDistance,"sfSound_setMinDistance");
		lib.bindSymbol(cast(void**)&sfSound_setAttenuation,"sfSound_setAttenuation");
		lib.bindSymbol(cast(void**)&sfSound_setPlayingOffset,"sfSound_setPlayingOffset");
		lib.bindSymbol(cast(void**)&sfSound_getPitch,"sfSound_getPitch");
		lib.bindSymbol(cast(void**)&sfSound_getVolume,"sfSound_getVolume");
		lib.bindSymbol(cast(void**)&sfSound_getPosition,"sfSound_getPosition");
		lib.bindSymbol(cast(void**)&sfSound_isRelativeToListener,"sfSound_isRelativeToListener");
		lib.bindSymbol(cast(void**)&sfSound_getMinDistance,"sfSound_getMinDistance");
		lib.bindSymbol(cast(void**)&sfSound_getAttenuation,"sfSound_getAttenuation");
		lib.bindSymbol(cast(void**)&sfSound_getPlayingOffset,"sfSound_getPlayingOffset");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_createFromFile,"sfSoundBuffer_createFromFile");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_createFromMemory,"sfSoundBuffer_createFromMemory");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_createFromStream,"sfSoundBuffer_createFromStream");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_createFromSamples,"sfSoundBuffer_createFromSamples");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_copy,"sfSoundBuffer_copy");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_destroy,"sfSoundBuffer_destroy");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_saveToFile,"sfSoundBuffer_saveToFile");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_getSamples,"sfSoundBuffer_getSamples");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_getSampleCount,"sfSoundBuffer_getSampleCount");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_getSampleRate,"sfSoundBuffer_getSampleRate");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_getChannelCount,"sfSoundBuffer_getChannelCount");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_getDuration,"sfSoundBuffer_getDuration");
		lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_create,"sfSoundBufferRecorder_create");
		lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_destroy,"sfSoundBufferRecorder_destroy");
		lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_start,"sfSoundBufferRecorder_start");
		lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_stop,"sfSoundBufferRecorder_stop");
		lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_getSampleRate,"sfSoundBufferRecorder_getSampleRate");
		lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_getBuffer,"sfSoundBufferRecorder_getBuffer");
		lib.bindSymbol(cast(void**)&sfSoundRecorder_create,"sfSoundRecorder_create");
		lib.bindSymbol(cast(void**)&sfSoundRecorder_destroy,"sfSoundRecorder_destroy");
		lib.bindSymbol(cast(void**)&sfSoundRecorder_start,"sfSoundRecorder_start");
		lib.bindSymbol(cast(void**)&sfSoundRecorder_stop,"sfSoundRecorder_stop");
		lib.bindSymbol(cast(void**)&sfSoundRecorder_getSampleRate,"sfSoundRecorder_getSampleRate");
		lib.bindSymbol(cast(void**)&sfSoundRecorder_isAvailable,"sfSoundRecorder_isAvailable");
		lib.bindSymbol(cast(void**)&sfSoundStream_create,"sfSoundStream_create");
		lib.bindSymbol(cast(void**)&sfSoundStream_destroy,"sfSoundStream_destroy");
		lib.bindSymbol(cast(void**)&sfSoundStream_play,"sfSoundStream_play");
		lib.bindSymbol(cast(void**)&sfSoundStream_pause,"sfSoundStream_pause");
		lib.bindSymbol(cast(void**)&sfSoundStream_stop,"sfSoundStream_stop");
		lib.bindSymbol(cast(void**)&sfSoundStream_getStatus,"sfSoundStream_getStatus");
		lib.bindSymbol(cast(void**)&sfSoundStream_getChannelCount,"sfSoundStream_getChannelCount");
		lib.bindSymbol(cast(void**)&sfSoundStream_getSampleRate,"sfSoundStream_getSampleRate");
		lib.bindSymbol(cast(void**)&sfSoundStream_setPitch,"sfSoundStream_setPitch");
		lib.bindSymbol(cast(void**)&sfSoundStream_setVolume,"sfSoundStream_setVolume");
		lib.bindSymbol(cast(void**)&sfSoundStream_setPosition,"sfSoundStream_setPosition");
		lib.bindSymbol(cast(void**)&sfSoundStream_setRelativeToListener,"sfSoundStream_setRelativeToListener");
		lib.bindSymbol(cast(void**)&sfSoundStream_setMinDistance,"sfSoundStream_setMinDistance");
		lib.bindSymbol(cast(void**)&sfSoundStream_setAttenuation,"sfSoundStream_setAttenuation");
		lib.bindSymbol(cast(void**)&sfSoundStream_setPlayingOffset,"sfSoundStream_setPlayingOffset");
		lib.bindSymbol(cast(void**)&sfSoundStream_setLoop,"sfSoundStream_setLoop");
		lib.bindSymbol(cast(void**)&sfSoundStream_getPitch,"sfSoundStream_getPitch");
		lib.bindSymbol(cast(void**)&sfSoundStream_getVolume,"sfSoundStream_getVolume");
		lib.bindSymbol(cast(void**)&sfSoundStream_getPosition,"sfSoundStream_getPosition");
		lib.bindSymbol(cast(void**)&sfSoundStream_isRelativeToListener,"sfSoundStream_isRelativeToListener");
		lib.bindSymbol(cast(void**)&sfSoundStream_getMinDistance,"sfSoundStream_getMinDistance");
		lib.bindSymbol(cast(void**)&sfSoundStream_getAttenuation,"sfSoundStream_getAttenuation");
		lib.bindSymbol(cast(void**)&sfSoundStream_getLoop,"sfSoundStream_getLoop");
		lib.bindSymbol(cast(void**)&sfSoundStream_getPlayingOffset,"sfSoundStream_getPlayingOffset");
		
		if(errorCount() != errCount) return SFMLSupport.badLibrary;
		else loadedVersion = sfmlSupport.sfml200;
		
		static if(sfmlSupport >= SFMLSupport.sfml220){
			lib.bindSymbol(cast(void**)&sfListener_setUpVector,"sfListener_setUpVector");
			lib.bindSymbol(cast(void**)&sfListener_getUpVector,"sfListener_getUpVector");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_setProcessingInterval,"sfSoundRecorder_setProcessingInterval");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_getAvailableDevices,"sfSoundRecorder_getAvailableDevices");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_getDefaultDevice,"sfSoundRecorder_getDefaultDevice");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_setDevice,"sfSoundRecorder_setDevice");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_getDevice,"sfSoundRecorder_getDevice");
			
			if(errorCount() != errCount) return SFMLSupport.badLibrary;
			else{
				static if(sfmlSupport >= SFMLSupport.sfml230){
					loadedVersion = SFMLSupport.sfml230;
				}else{
					loadedVersion = SFMLSupport.sfml220;
				}
			}
		}
		static if(sfmlSupport >= SFMLSupport.sfml240){
			lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_setDevice,"sfSoundBufferRecorder_setDevice");
			lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_getDevice,"sfSoundBufferRecorder_getDevice");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_setChannelCount,"sfSoundRecorder_setChannelCount");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_getChannelCount,"sfSoundRecorder_getChannelCount");
			
			if(errorCount() != errCount) return SFMLSupport.badLibrary;
			else loadedVersion = SFMLSupport.sfml240;
		}
		static if(sfmlSupport >= SFMLSupport.sfml250){
			lib.bindSymbol(cast(void**)&sfMusic_getLoopPoints,"sfMusic_getLoopPoints");
			lib.bindSymbol(cast(void**)&sfMusic_setLoopPoints,"sfMusic_setLoopPoints");
			
			if(errorCount() != errCount) return SFMLSupport.badLibrary;
			else loadedVersion = SFMLSupport.sfml250;
		}
		
		return loadedVersion;
	}
}
=======
}
else{
	import bindbc.loader;

	extern(C) @nogc nothrow{
		// Audio/Listener.h
		alias psfListener_setGlobalVolume = void function(float volume);
		alias psfListener_getGlobalVolume = float function();
		alias psfListener_setPosition = void function(sfVector3f position);
		alias psfListener_getPosition = sfVector3f function();
		alias psfListener_setDirection = void function(sfVector3f orientation);
		alias psfListener_getDirection = sfVector3f function();

		// Audio/Music.h
		alias psfMusic_createFromFile = sfMusic* function(const(char)* filename);
		alias psfMusic_createFromMemory = sfMusic* function(const(void)* data, size_t sizeInBytes);
		alias psfMusic_createFromStream = sfMusic* function(sfInputStream* stream);
		alias psfMusic_destroy = void function(sfMusic* music);
		alias psfMusic_setLoop = void function(sfMusic* music, sfBool loop);
		alias psfMusic_getLoop = sfBool function(const(sfMusic)* music);
		alias psfMusic_getDuration = sfTime function(const(sfMusic)* music);
		alias psfMusic_play = void function(sfMusic* music);
		alias psfMusic_pause = void function(sfMusic* music);
		alias psfMusic_stop = void function(sfMusic* music);
		alias psfMusic_getChannelCount = uint function(const(sfMusic)* music);
		alias psfMusic_getSampleRate = uint function(const(sfMusic)* music);
		alias psfMusic_getStatus = sfSoundStatus function(const(sfMusic)* music);
		alias psfMusic_getPlayingOffset = sfTime function(const(sfMusic)* music);
		alias psfMusic_setPitch = void function(sfMusic* music, float pitch);
		alias psfMusic_setVolume = void function(sfMusic* music, float volume);
		alias psfMusic_setPosition = void function(sfMusic* music, sfVector3f position);
		alias psfMusic_setRelativeToListener = void function(sfMusic* music, sfBool relative);
		alias psfMusic_setMinDistance = void function(sfMusic* music, float distance);
		alias psfMusic_setAttenuation = void function(sfMusic* music, float attenuation);
		alias psfMusic_setPlayingOffset = void function(sfMusic* music, sfTime timeOffset);
		alias psfMusic_getPitch = float function(const(sfMusic)* music);
		alias psfMusic_getVolume = float function(const(sfMusic)* music);
		alias psfMusic_getPosition = sfVector3f function(const(sfMusic)* music);
		alias psfMusic_isRelativeToListener = sfBool function(const(sfMusic)* music);
		alias psfMusic_getMinDistance = float function(const(sfMusic)* music);
		alias psfMusic_getAttenuation = float function(const(sfMusic)* music);

		// Audio/Sound.h
		alias psfSound_create = sfSound* function();
		alias psfSound_copy = sfSound* function(const(sfSound)* sound);
		alias psfSound_destroy = void function(sfSound* sound);
		alias psfSound_play = void function(sfSound* sound);
		alias psfSound_pause = void function(sfSound* sound);
		alias psfSound_stop = void function(sfSound* sound);
		alias psfSound_setBuffer = void function(sfSound* sound, const(sfSoundBuffer)* buffer);
		alias psfSound_getBuffer = const(sfSoundBuffer)* function(const(sfSound)* sound);
		alias psfSound_setLoop = void function(sfSound* sound, sfBool loop);
		alias psfSound_getLoop = sfBool function(const(sfSound)* sound);
		alias psfSound_getStatus = sfSoundStatus function(const(sfSound)* sound);
		alias psfSound_setPitch = void function(sfSound* sound, float pitch);
		alias psfSound_setVolume = void function(sfSound* sound, float volume);
		alias psfSound_setPosition = void function(sfSound* sound, sfVector3f position);
		alias psfSound_setRelativeToListener = void function(sfSound* sound, sfBool relative);
		alias psfSound_setMinDistance = void function(sfSound* sound, float distance);
		alias psfSound_setAttenuation = void function(sfSound* sound, float attenuation);
		alias psfSound_setPlayingOffset = void function(sfSound* sound, sfTime timeOffset);
		alias psfSound_getPitch = float function(const(sfSound)* sound);
		alias psfSound_getVolume = float function(const(sfSound)* sound);
		alias psfSound_getPosition = sfVector3f function(const(sfSound)* sound);
		alias psfSound_isRelativeToListener = sfBool function(const(sfSound)* sound);
		alias psfSound_getMinDistance = float function(const(sfSound)* sound);
		alias psfSound_getAttenuation = float function(const(sfSound)* sound);
		alias psfSound_getPlayingOffset = sfTime function(const(sfSound)* sound);

		// Audio/SoundBuffer.h
		alias psfSoundBuffer_createFromFile = sfSoundBuffer* function(const(char)* filename);
		alias psfSoundBuffer_createFromMemory = sfSoundBuffer* function(const(void)* data, size_t sizeInBytes);
		alias psfSoundBuffer_createFromStream = sfSoundBuffer* function(sfInputStream* stream);
		alias psfSoundBuffer_copy = sfSoundBuffer* function(const(sfSoundBuffer)* soundBuffer);
		alias psfSoundBuffer_destroy = void function(sfSoundBuffer* soundBuffer);
		alias psfSoundBuffer_saveToFile = sfBool function(const(sfSoundBuffer)* soundBuffer, const(char)* filename);
		alias psfSoundBuffer_getSamples = const(sfInt16)* function(const(sfSoundBuffer)* soundBuffer);
		alias psfSoundBuffer_getSampleRate = uint function(const(sfSoundBuffer)* soundBuffer);
		alias psfSoundBuffer_getChannelCount = uint function(const(sfSoundBuffer)* soundBuffer);
		alias psfSoundBuffer_getDuration = sfTime function(const(sfSoundBuffer)* soundBuffer);

		static if(sfmlSupport >= SFMLSupport.sfml230){
			alias psfSoundBuffer_createFromSamples = sfSoundBuffer* function(const(sfInt16)* samples, sfUint64 sampleCount, uint channelCount, uint sampleRate);
			alias psfSoundBuffer_getSampleCount = sfUint64 function(const(sfSoundBuffer)* soundBuffer);
		}
		else{
			alias psfSoundBuffer_createFromSamples = sfSoundBuffer* function(const(sfInt16)* samples, size_t sampleCount, uint channelCount, uint sampleRate);
			alias psfSoundBuffer_getSampleCount = size_t function(const(sfSoundBuffer)* soundBuffer);
		}

		// Audio/SoundBufferRecorder.h
		alias psfSoundBufferRecorder_create = sfSoundBufferRecorder* function();
		alias psfSoundBufferRecorder_destroy = void function(sfSoundBufferRecorder* soundBufferRecorder);
		alias psfSoundBufferRecorder_stop = void function(sfSoundBufferRecorder* soundBufferRecorder);
		alias psfSoundBufferRecorder_getSampleRate = uint function(const(sfSoundBufferRecorder)* soundBufferRecorder);
		alias psfSoundBufferRecorder_getBuffer = const(sfSoundBuffer)* function(const(sfSoundBufferRecorder)* soundBufferRecorder);

		static if(sfmlSupport >= SFMLSupport.sfml240){
			alias psfSoundBufferRecorder_start = sfBool function(sfSoundBufferRecorder* soundBufferRecorder, uint sampleRate);
		}
		else{
			alias psfSoundBufferRecorder_start = void function(sfSoundBufferRecorder* soundBufferRecorder, uint sampleRate);
		}

		// Audio/SoundRecorder.h
		alias psfSoundRecorder_create = sfSoundRecorder* function(sfSoundRecorderStartCallback   onStart,
												sfSoundRecorderProcessCallback onProcess,
												sfSoundRecorderStopCallback    onStop,
												void*                          userData);
		alias psfSoundRecorder_destroy = void function(sfSoundRecorder* soundRecorder);
		alias psfSoundRecorder_stop = void function(sfSoundRecorder* soundRecorder);
		alias psfSoundRecorder_getSampleRate = uint function(const(sfSoundRecorder)* soundRecorder);
		alias psfSoundRecorder_isAvailable = sfBool function();

		static if(sfmlSupport >= SFMLSupport.sfml220){
			alias psfSoundRecorder_start = sfBool function(sfSoundRecorder* soundRecorder, uint sampleRate);
		}
		else alias psfSoundRecorder_start = void function(sfSoundRecorder* soundRecorder, uint sampleRate);

		// Audio/SoundStream.h
		alias psfSoundStream_create = sfSoundStream* function(sfSoundStreamGetDataCallback onGetData,
											sfSoundStreamSeekCallback    onSeek,
											uint                 channelCount,
											uint                 sampleRate,
											void*                userData);
		alias psfSoundStream_destroy = void function(sfSoundStream* soundStream);
		alias psfSoundStream_play = void function(sfSoundStream* soundStream);
		alias psfSoundStream_pause = void function(sfSoundStream* soundStream);
		alias psfSoundStream_stop = void function(sfSoundStream* soundStream);
		alias psfSoundStream_getStatus = sfSoundStatus function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getChannelCount = uint function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getSampleRate = uint function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_setPitch = void function(sfSoundStream* soundStream, float pitch);
		alias psfSoundStream_setVolume = void function(sfSoundStream* soundStream, float volume);
		alias psfSoundStream_setPosition = void function(sfSoundStream* soundStream, sfVector3f position);
		alias psfSoundStream_setRelativeToListener = void function(sfSoundStream* soundStream, sfBool relative);
		alias psfSoundStream_setMinDistance = void function(sfSoundStream* soundStream, float distance);
		alias psfSoundStream_setAttenuation = void function(sfSoundStream* soundStream, float attenuation);
		alias psfSoundStream_setPlayingOffset = void function(sfSoundStream* soundStream, sfTime timeOffset);
		alias psfSoundStream_setLoop = void function(sfSoundStream* soundStream, sfBool loop);
		alias psfSoundStream_getPitch = float function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getVolume = float function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getPosition = sfVector3f function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_isRelativeToListener = sfBool function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getMinDistance = float function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getAttenuation = float function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getLoop = sfBool function(const(sfSoundStream)* soundStream);
		alias psfSoundStream_getPlayingOffset = sfTime function(const(sfSoundStream)* soundStream);


		static if(sfmlSupport >= SFMLSupport.sfml220){
			// Audio/Listener.h
			alias psfListener_setUpVector = void function(sfVector3f upVector);
			alias psfListener_getUpVector = sfVector3f function();

			// Audio/SoundRecorder.h
			alias psfSoundRecorder_setProcessingInterval = void function(sfSoundRecorder* soundRecorder, sfTime interval);
			alias psfSoundRecorder_getAvailableDevices = const(char*)* function(size_t* count);
			alias psfSoundRecorder_getDefaultDevice = const(char)* function();
			alias psfSoundRecorder_setDevice = sfBool function(sfSoundRecorder* soundRecorder, const(char)* name);
			alias psfSoundRecorder_getDevice = const(char)* function(sfSoundRecorder* soundRecorder);
		}
		static if(sfmlSupport >= sfmlSupport.sfml240){
			// Audio/SoundBufferRecorder.h
			alias psfSoundBufferRecorder_setDevice = sfBool function(sfSoundBufferRecorder* soundBufferRecorder, const(char)* name);
			alias psfSoundBufferRecorder_getDevice = const(char)* function(sfSoundBufferRecorder* soundBufferRecorder);

			// Audio/SoundRecorder.h
			alias psfSoundRecorder_setChannelCount = void function(sfSoundRecorder* soundRecorder, uint channelCount);
			alias psfSoundRecorder_getChannelCount = uint function(const(sfSoundRecorder)* soundRecorder);
		}
		static if(sfmlSupport >= sfmlSupport.sfml250){
			// Audio/Music.h
			alias psfMusic_getLoopPoints = sfTimeSpan function(const(sfMusic)* music);
			alias psfMusic_setLoopPoints = void function(sfMusic* music, sfTimeSpan timePoints);
		}
	}

	__gshared{
		psfListener_setGlobalVolume sfListener_setGlobalVolume;
		psfListener_getGlobalVolume sfListener_getGlobalVolume;
		psfListener_setPosition sfListener_setPosition;
		psfListener_getPosition sfListener_getPosition;
		psfListener_setDirection sfListener_setDirection;
		psfListener_getDirection sfListener_getDirection;
		psfMusic_createFromFile sfMusic_createFromFile;
		psfMusic_createFromMemory sfMusic_createFromMemory;
		psfMusic_createFromStream sfMusic_createFromStream;
		psfMusic_destroy sfMusic_destroy;
		psfMusic_setLoop sfMusic_setLoop;
		psfMusic_getLoop sfMusic_getLoop;
		psfMusic_getDuration sfMusic_getDuration;
		psfMusic_play sfMusic_play;
		psfMusic_pause sfMusic_pause;
		psfMusic_stop sfMusic_stop;
		psfMusic_getChannelCount sfMusic_getChannelCount;
		psfMusic_getSampleRate sfMusic_getSampleRate;
		psfMusic_getStatus sfMusic_getStatus;
		psfMusic_getPlayingOffset sfMusic_getPlayingOffset;
		psfMusic_setPitch sfMusic_setPitch;
		psfMusic_setVolume sfMusic_setVolume;
		psfMusic_setPosition sfMusic_setPosition;
		psfMusic_setRelativeToListener sfMusic_setRelativeToListener;
		psfMusic_setMinDistance sfMusic_setMinDistance;
		psfMusic_setAttenuation sfMusic_setAttenuation;
		psfMusic_setPlayingOffset sfMusic_setPlayingOffset;
		psfMusic_getPitch sfMusic_getPitch;
		psfMusic_getVolume sfMusic_getVolume;
		psfMusic_getPosition sfMusic_getPosition;
		psfMusic_isRelativeToListener sfMusic_isRelativeToListener;
		psfMusic_getMinDistance sfMusic_getMinDistance;
		psfMusic_getAttenuation sfMusic_getAttenuation;
		psfSound_create sfSound_create;
		psfSound_copy sfSound_copy;
		psfSound_destroy sfSound_destroy;
		psfSound_play sfSound_play;
		psfSound_pause sfSound_pause;
		psfSound_stop sfSound_stop;
		psfSound_setBuffer sfSound_setBuffer;
		psfSound_getBuffer sfSound_getBuffer;
		psfSound_setLoop sfSound_setLoop;
		psfSound_getLoop sfSound_getLoop;
		psfSound_getStatus sfSound_getStatus;
		psfSound_setPitch sfSound_setPitch;
		psfSound_setVolume sfSound_setVolume;
		psfSound_setPosition sfSound_setPosition;
		psfSound_setRelativeToListener sfSound_setRelativeToListener;
		psfSound_setMinDistance sfSound_setMinDistance;
		psfSound_setAttenuation sfSound_setAttenuation;
		psfSound_setPlayingOffset sfSound_setPlayingOffset;
		psfSound_getPitch sfSound_getPitch;
		psfSound_getVolume sfSound_getVolume;
		psfSound_getPosition sfSound_getPosition;
		psfSound_isRelativeToListener sfSound_isRelativeToListener;
		psfSound_getMinDistance sfSound_getMinDistance;
		psfSound_getAttenuation sfSound_getAttenuation;
		psfSound_getPlayingOffset sfSound_getPlayingOffset;
		psfSoundBuffer_createFromFile sfSoundBuffer_createFromFile;
		psfSoundBuffer_createFromMemory sfSoundBuffer_createFromMemory;
		psfSoundBuffer_createFromStream sfSoundBuffer_createFromStream;
		psfSoundBuffer_createFromSamples sfSoundBuffer_createFromSamples;
		psfSoundBuffer_copy sfSoundBuffer_copy;
		psfSoundBuffer_destroy sfSoundBuffer_destroy;
		psfSoundBuffer_saveToFile sfSoundBuffer_saveToFile;
		psfSoundBuffer_getSamples sfSoundBuffer_getSamples;
		psfSoundBuffer_getSampleCount sfSoundBuffer_getSampleCount;
		psfSoundBuffer_getSampleRate sfSoundBuffer_getSampleRate;
		psfSoundBuffer_getChannelCount sfSoundBuffer_getChannelCount;
		psfSoundBuffer_getDuration sfSoundBuffer_getDuration;
		psfSoundBufferRecorder_create sfSoundBufferRecorder_create;
		psfSoundBufferRecorder_destroy sfSoundBufferRecorder_destroy;
		psfSoundBufferRecorder_start sfSoundBufferRecorder_start;
		psfSoundBufferRecorder_stop sfSoundBufferRecorder_stop;
		psfSoundBufferRecorder_getSampleRate sfSoundBufferRecorder_getSampleRate;
		psfSoundBufferRecorder_getBuffer sfSoundBufferRecorder_getBuffer;
		psfSoundRecorder_create sfSoundRecorder_create;
		psfSoundRecorder_destroy sfSoundRecorder_destroy;
		psfSoundRecorder_start sfSoundRecorder_start;
		psfSoundRecorder_stop sfSoundRecorder_stop;
		psfSoundRecorder_getSampleRate sfSoundRecorder_getSampleRate;
		psfSoundRecorder_isAvailable sfSoundRecorder_isAvailable;
		psfSoundStream_create sfSoundStream_create;
		psfSoundStream_destroy sfSoundStream_destroy;
		psfSoundStream_play sfSoundStream_play;
		psfSoundStream_pause sfSoundStream_pause;
		psfSoundStream_stop sfSoundStream_stop;
		psfSoundStream_getStatus sfSoundStream_getStatus;
		psfSoundStream_getChannelCount sfSoundStream_getChannelCount;
		psfSoundStream_getSampleRate sfSoundStream_getSampleRate;
		psfSoundStream_setPitch sfSoundStream_setPitch;
		psfSoundStream_setVolume sfSoundStream_setVolume;
		psfSoundStream_setPosition sfSoundStream_setPosition;
		psfSoundStream_setRelativeToListener sfSoundStream_setRelativeToListener;
		psfSoundStream_setMinDistance sfSoundStream_setMinDistance;
		psfSoundStream_setAttenuation sfSoundStream_setAttenuation;
		psfSoundStream_setPlayingOffset sfSoundStream_setPlayingOffset;
		psfSoundStream_setLoop sfSoundStream_setLoop;
		psfSoundStream_getPitch sfSoundStream_getPitch;
		psfSoundStream_getVolume sfSoundStream_getVolume;
		psfSoundStream_getPosition sfSoundStream_getPosition;
		psfSoundStream_isRelativeToListener sfSoundStream_isRelativeToListener;
		psfSoundStream_getMinDistance sfSoundStream_getMinDistance;
		psfSoundStream_getAttenuation sfSoundStream_getAttenuation;
		psfSoundStream_getLoop sfSoundStream_getLoop;
		psfSoundStream_getPlayingOffset sfSoundStream_getPlayingOffset;

		static if(sfmlSupport >= SFMLSupport.sfml220){
			psfListener_setUpVector sfListener_setUpVector;
			psfListener_getUpVector sfListener_getUpVector;
			psfSoundRecorder_setProcessingInterval sfSoundRecorder_setProcessingInterval;
			psfSoundRecorder_getAvailableDevices sfSoundRecorder_getAvailableDevices;
			psfSoundRecorder_getDefaultDevice sfSoundRecorder_getDefaultDevice;
			psfSoundRecorder_setDevice sfSoundRecorder_setDevice;
			psfSoundRecorder_getDevice sfSoundRecorder_getDevice;
		}
		static if(sfmlSupport >= SFMLSupport.sfml240){
			psfSoundBufferRecorder_setDevice sfSoundBufferRecorder_setDevice;
			psfSoundBufferRecorder_getDevice sfSoundBufferRecorder_getDevice;
			psfSoundRecorder_setChannelCount sfSoundRecorder_setChannelCount;
			psfSoundRecorder_getChannelCount sfSoundRecorder_getChannelCount;
		}
		static if(sfmlSupport >= sfmlSupport.sfml250){
			psfMusic_getLoopPoints sfMusic_getLoopPoints;
			psfMusic_setLoopPoints sfMusic_setLoopPoints;
		}
	}
	private{
		SharedLib lib;
		SFMLSupport loadedVersion;
	}

@nogc nothrow:
	SFMLSupport loadedSFMLAudioVersion(){ return loadedVersion; }

	bool isSFMLAudioLoaded()
	{
		return lib != invalidHandle;
	}

	SFMLSupport loadSFMLAudio()
	{
		version(Windows){
			const(char)[][3] libNames = [
				"csfml-audio.dll",
				"csfml-audio-2.dll",
				"csfml-audio-2.0.dll"
			];
		}
		else version(OSX){
			const(char)[][3] libNames = [
				"libcsfml-audio.dylib",
				"libcsfml-audio.2.dylib",
				"libcsfml-audio.2.0.dylib"
			];
		}
		else version(Posix){
			const(char)[][3] libNames = [
				"libcsfml-audio.so",
				"libcsfml-audio.so.2",
				"libcsfml-audio.so.2.0"
			];
		}

		SFMLSupport ret;
		foreach(name; libNames){
			ret = loadSFMLAudio(name.ptr);
			if(ret != SFMLSupport.noLibrary) break;
		}
		return ret;
	}

	SFMLSupport loadSFMLAudio(const(char)* libName)
	{
		lib = load(libName);
		if(lib == invalidHandle){
			return SFMLSupport.noLibrary;
		}

		auto errCount = errorCount();
		loadedVersion = SFMLSupport.badLibrary;

		lib.bindSymbol(cast(void**)&sfListener_setGlobalVolume,"sfListener_setGlobalVolume");
		lib.bindSymbol(cast(void**)&sfListener_getGlobalVolume,"sfListener_getGlobalVolume");
		lib.bindSymbol(cast(void**)&sfListener_setPosition,"sfListener_setPosition");
		lib.bindSymbol(cast(void**)&sfListener_getPosition,"sfListener_getPosition");
		lib.bindSymbol(cast(void**)&sfListener_setDirection,"sfListener_setDirection");
		lib.bindSymbol(cast(void**)&sfListener_getDirection,"sfListener_getDirection");
		lib.bindSymbol(cast(void**)&sfMusic_createFromFile,"sfMusic_createFromFile");
		lib.bindSymbol(cast(void**)&sfMusic_createFromMemory,"sfMusic_createFromMemory");
		lib.bindSymbol(cast(void**)&sfMusic_createFromStream,"sfMusic_createFromStream");
		lib.bindSymbol(cast(void**)&sfMusic_destroy,"sfMusic_destroy");
		lib.bindSymbol(cast(void**)&sfMusic_setLoop,"sfMusic_setLoop");
		lib.bindSymbol(cast(void**)&sfMusic_getLoop,"sfMusic_getLoop");
		lib.bindSymbol(cast(void**)&sfMusic_getDuration,"sfMusic_getDuration");
		lib.bindSymbol(cast(void**)&sfMusic_play,"sfMusic_play");
		lib.bindSymbol(cast(void**)&sfMusic_pause,"sfMusic_pause");
		lib.bindSymbol(cast(void**)&sfMusic_stop,"sfMusic_stop");
		lib.bindSymbol(cast(void**)&sfMusic_getChannelCount,"sfMusic_getChannelCount");
		lib.bindSymbol(cast(void**)&sfMusic_getSampleRate,"sfMusic_getSampleRate");
		lib.bindSymbol(cast(void**)&sfMusic_getStatus,"sfMusic_getStatus");
		lib.bindSymbol(cast(void**)&sfMusic_getPlayingOffset,"sfMusic_getPlayingOffset");
		lib.bindSymbol(cast(void**)&sfMusic_setPitch,"sfMusic_setPitch");
		lib.bindSymbol(cast(void**)&sfMusic_setVolume,"sfMusic_setVolume");
		lib.bindSymbol(cast(void**)&sfMusic_setPosition,"sfMusic_setPosition");
		lib.bindSymbol(cast(void**)&sfMusic_setRelativeToListener,"sfMusic_setRelativeToListener");
		lib.bindSymbol(cast(void**)&sfMusic_setMinDistance,"sfMusic_setMinDistance");
		lib.bindSymbol(cast(void**)&sfMusic_setAttenuation,"sfMusic_setAttenuation");
		lib.bindSymbol(cast(void**)&sfMusic_setPlayingOffset,"sfMusic_setPlayingOffset");
		lib.bindSymbol(cast(void**)&sfMusic_getPitch,"sfMusic_getPitch");
		lib.bindSymbol(cast(void**)&sfMusic_getVolume,"sfMusic_getVolume");
		lib.bindSymbol(cast(void**)&sfMusic_getPosition,"sfMusic_getPosition");
		lib.bindSymbol(cast(void**)&sfMusic_isRelativeToListener,"sfMusic_isRelativeToListener");
		lib.bindSymbol(cast(void**)&sfMusic_getMinDistance,"sfMusic_getMinDistance");
		lib.bindSymbol(cast(void**)&sfMusic_getAttenuation,"sfMusic_getAttenuation");
		lib.bindSymbol(cast(void**)&sfSound_create,"sfSound_create");
		lib.bindSymbol(cast(void**)&sfSound_copy,"sfSound_copy");
		lib.bindSymbol(cast(void**)&sfSound_destroy,"sfSound_destroy");
		lib.bindSymbol(cast(void**)&sfSound_play,"sfSound_play");
		lib.bindSymbol(cast(void**)&sfSound_pause,"sfSound_pause");
		lib.bindSymbol(cast(void**)&sfSound_stop,"sfSound_stop");
		lib.bindSymbol(cast(void**)&sfSound_setBuffer,"sfSound_setBuffer");
		lib.bindSymbol(cast(void**)&sfSound_getBuffer,"sfSound_getBuffer");
		lib.bindSymbol(cast(void**)&sfSound_setLoop,"sfSound_setLoop");
		lib.bindSymbol(cast(void**)&sfSound_getLoop,"sfSound_getLoop");
		lib.bindSymbol(cast(void**)&sfSound_getStatus,"sfSound_getStatus");
		lib.bindSymbol(cast(void**)&sfSound_setPitch,"sfSound_setPitch");
		lib.bindSymbol(cast(void**)&sfSound_setVolume,"sfSound_setVolume");
		lib.bindSymbol(cast(void**)&sfSound_setPosition,"sfSound_setPosition");
		lib.bindSymbol(cast(void**)&sfSound_setRelativeToListener,"sfSound_setRelativeToListener");
		lib.bindSymbol(cast(void**)&sfSound_setMinDistance,"sfSound_setMinDistance");
		lib.bindSymbol(cast(void**)&sfSound_setAttenuation,"sfSound_setAttenuation");
		lib.bindSymbol(cast(void**)&sfSound_setPlayingOffset,"sfSound_setPlayingOffset");
		lib.bindSymbol(cast(void**)&sfSound_getPitch,"sfSound_getPitch");
		lib.bindSymbol(cast(void**)&sfSound_getVolume,"sfSound_getVolume");
		lib.bindSymbol(cast(void**)&sfSound_getPosition,"sfSound_getPosition");
		lib.bindSymbol(cast(void**)&sfSound_isRelativeToListener,"sfSound_isRelativeToListener");
		lib.bindSymbol(cast(void**)&sfSound_getMinDistance,"sfSound_getMinDistance");
		lib.bindSymbol(cast(void**)&sfSound_getAttenuation,"sfSound_getAttenuation");
		lib.bindSymbol(cast(void**)&sfSound_getPlayingOffset,"sfSound_getPlayingOffset");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_createFromFile,"sfSoundBuffer_createFromFile");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_createFromMemory,"sfSoundBuffer_createFromMemory");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_createFromStream,"sfSoundBuffer_createFromStream");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_createFromSamples,"sfSoundBuffer_createFromSamples");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_copy,"sfSoundBuffer_copy");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_destroy,"sfSoundBuffer_destroy");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_saveToFile,"sfSoundBuffer_saveToFile");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_getSamples,"sfSoundBuffer_getSamples");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_getSampleCount,"sfSoundBuffer_getSampleCount");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_getSampleRate,"sfSoundBuffer_getSampleRate");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_getChannelCount,"sfSoundBuffer_getChannelCount");
		lib.bindSymbol(cast(void**)&sfSoundBuffer_getDuration,"sfSoundBuffer_getDuration");
		lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_create,"sfSoundBufferRecorder_create");
		lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_destroy,"sfSoundBufferRecorder_destroy");
		lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_start,"sfSoundBufferRecorder_start");
		lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_stop,"sfSoundBufferRecorder_stop");
		lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_getSampleRate,"sfSoundBufferRecorder_getSampleRate");
		lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_getBuffer,"sfSoundBufferRecorder_getBuffer");
		lib.bindSymbol(cast(void**)&sfSoundRecorder_create,"sfSoundRecorder_create");
		lib.bindSymbol(cast(void**)&sfSoundRecorder_destroy,"sfSoundRecorder_destroy");
		lib.bindSymbol(cast(void**)&sfSoundRecorder_start,"sfSoundRecorder_start");
		lib.bindSymbol(cast(void**)&sfSoundRecorder_stop,"sfSoundRecorder_stop");
		lib.bindSymbol(cast(void**)&sfSoundRecorder_getSampleRate,"sfSoundRecorder_getSampleRate");
		lib.bindSymbol(cast(void**)&sfSoundRecorder_isAvailable,"sfSoundRecorder_isAvailable");
		lib.bindSymbol(cast(void**)&sfSoundStream_create,"sfSoundStream_create");
		lib.bindSymbol(cast(void**)&sfSoundStream_destroy,"sfSoundStream_destroy");
		lib.bindSymbol(cast(void**)&sfSoundStream_play,"sfSoundStream_play");
		lib.bindSymbol(cast(void**)&sfSoundStream_pause,"sfSoundStream_pause");
		lib.bindSymbol(cast(void**)&sfSoundStream_stop,"sfSoundStream_stop");
		lib.bindSymbol(cast(void**)&sfSoundStream_getStatus,"sfSoundStream_getStatus");
		lib.bindSymbol(cast(void**)&sfSoundStream_getChannelCount,"sfSoundStream_getChannelCount");
		lib.bindSymbol(cast(void**)&sfSoundStream_getSampleRate,"sfSoundStream_getSampleRate");
		lib.bindSymbol(cast(void**)&sfSoundStream_setPitch,"sfSoundStream_setPitch");
		lib.bindSymbol(cast(void**)&sfSoundStream_setVolume,"sfSoundStream_setVolume");
		lib.bindSymbol(cast(void**)&sfSoundStream_setPosition,"sfSoundStream_setPosition");
		lib.bindSymbol(cast(void**)&sfSoundStream_setRelativeToListener,"sfSoundStream_setRelativeToListener");
		lib.bindSymbol(cast(void**)&sfSoundStream_setMinDistance,"sfSoundStream_setMinDistance");
		lib.bindSymbol(cast(void**)&sfSoundStream_setAttenuation,"sfSoundStream_setAttenuation");
		lib.bindSymbol(cast(void**)&sfSoundStream_setPlayingOffset,"sfSoundStream_setPlayingOffset");
		lib.bindSymbol(cast(void**)&sfSoundStream_setLoop,"sfSoundStream_setLoop");
		lib.bindSymbol(cast(void**)&sfSoundStream_getPitch,"sfSoundStream_getPitch");
		lib.bindSymbol(cast(void**)&sfSoundStream_getVolume,"sfSoundStream_getVolume");
		lib.bindSymbol(cast(void**)&sfSoundStream_getPosition,"sfSoundStream_getPosition");
		lib.bindSymbol(cast(void**)&sfSoundStream_isRelativeToListener,"sfSoundStream_isRelativeToListener");
		lib.bindSymbol(cast(void**)&sfSoundStream_getMinDistance,"sfSoundStream_getMinDistance");
		lib.bindSymbol(cast(void**)&sfSoundStream_getAttenuation,"sfSoundStream_getAttenuation");
		lib.bindSymbol(cast(void**)&sfSoundStream_getLoop,"sfSoundStream_getLoop");
		lib.bindSymbol(cast(void**)&sfSoundStream_getPlayingOffset,"sfSoundStream_getPlayingOffset");

		if(errorCount() != errCount) return SFMLSupport.badLibrary;
		else loadedVersion = sfmlSupport.sfml200;

		static if(sfmlSupport >= SFMLSupport.sfml220){
			lib.bindSymbol(cast(void**)&sfListener_setUpVector,"sfListener_setUpVector");
			lib.bindSymbol(cast(void**)&sfListener_getUpVector,"sfListener_getUpVector");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_setProcessingInterval,"sfSoundRecorder_setProcessingInterval");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_getAvailableDevices,"sfSoundRecorder_getAvailableDevices");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_getDefaultDevice,"sfSoundRecorder_getDefaultDevice");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_setDevice,"sfSoundRecorder_setDevice");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_getDevice,"sfSoundRecorder_getDevice");

			if(errorCount() != errCount) return SFMLSupport.badLibrary;
			else{
				static if(sfmlSupport >= SFMLSupport.sfml230){
					loadedVersion = SFMLSupport.sfml230;
				}
				else loadedVersion = SFMLSupport.sfml220;
			}
		}
		static if(sfmlSupport >= SFMLSupport.sfml240){
			lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_setDevice,"sfSoundBufferRecorder_setDevice");
			lib.bindSymbol(cast(void**)&sfSoundBufferRecorder_getDevice,"sfSoundBufferRecorder_getDevice");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_setChannelCount,"sfSoundRecorder_setChannelCount");
			lib.bindSymbol(cast(void**)&sfSoundRecorder_getChannelCount,"sfSoundRecorder_getChannelCount");

			if(errorCount() != errCount) return SFMLSupport.badLibrary;
			else loadedVersion = SFMLSupport.sfml240;
		}
		static if(sfmlSupport >= SFMLSupport.sfml250){
			lib.bindSymbol(cast(void**)&sfMusic_getLoopPoints,"sfMusic_getLoopPoints");
			lib.bindSymbol(cast(void**)&sfMusic_setLoopPoints,"sfMusic_setLoopPoints");

			if(errorCount() != errCount) return SFMLSupport.badLibrary;
			else loadedVersion = SFMLSupport.sfml250;
		}

		return loadedVersion;
	}
}
>>>>>>> master
