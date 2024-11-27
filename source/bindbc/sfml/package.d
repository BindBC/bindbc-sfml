//          Copyright 2020 - 2021 Michael D. Parker
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module bindbc.sfml;

public import bindbc.sfml.config, bindbc.sfml.system;
static if(bindSFMLAudio) public import bindbc.sfml.audio;
static if(bindSFMLGraphics) public import bindbc.sfml.graphics;
static if(bindSFMLNetwork) public import bindbc.sfml.network;
static if(bindSFMLWindow) public import bindbc.sfml.window;

static if(!staticSFML):
/**
	A convenience function that attempts to load all configured SFML binding.
	
	This function will always call `loadSFMLSystem` and will call the load function
	of every binding that is configured. If `SFML_Graphics` is configured, both
	`loadSFMLWindow` and `loadSFMLGraphics` will be called. This function will
	return false as soon as one of the load functions returns `SFMLSupport.noLibrary`
	or `SFMLSupport.badLibrary`.
	
	There is no variation of this function allowing for alternative shared library
	file names.
	
	Returns: `true` if all libraries loaded successfully, `false` if any library
	failed to load.
*/
bool loadSFML(){
	bool isBad(SFMLSupport val){
		return val == SFMLSupport.noLibrary || val == SFMLSupport.badLibrary;
	}
	
	auto ret = loadSFMLSystem();
	if(isBad(ret)) return false;
	
	static if(bindSFMLAudio){
		ret = loadSFMLAudio();
		if(isBad(ret)) return false;
	}
	static if(bindSFMLNetwork){
		ret = loadSFMLNetwork();
		if(isBad(ret)) return false;
	}
	static if(bindSFMLWindow){
		ret = loadSFMLWindow();
		if(isBad(ret)) return false;
	}
	static if(bindSFMLGraphics){
		ret = loadSFMLGraphics();
		if(isBad(ret)) return false;
	}
	
	return true;
}
