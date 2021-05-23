
//          Copyright 2020 - 2021 Michael D. Parker
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module bindbc.sfml.config;

enum SFMLSupport {
    noLibrary,
    badLibrary,
    sfml200         = 200,
    sfml210         = 210,
    sfml220         = 220,
    sfml230         = 230,
    sfml240         = 240,
    sfml250         = 250,
}

version(BindBC_Static) version = BindSFML_Static;
version(BindSFML_Static) enum staticSFML = true;
else enum staticSFML = false;

version(SFML_250) enum sfmlSupport = SFMLSupport.sfml250;
else version(SFML_240) enum sfmlSupport = SFMLSupport.sfml240;
else version(SFML_230) enum sfmlSupport = SFMLSupport.sfml230;
else version(SFML_220) enum sfmlSupport = SFMLSupport.sfml220;
else version(SFML_210) enum sfmlSupport = SFMLSupport.sfml210;
else enum sfmlSupport = SFMLSupport.sfml200;

version(SFML_Audio) enum bindSFMLAudio = true;
else enum bindSFMLAudio = false;

version(SFML_Network) enum bindSFMLNetwork = true;
else enum bindSFMLNetwork = false;

version(SFML_Graphics) {
    version = SFML_Window;
    enum bindSFMLGraphics = true;
}
else enum bindSFMLGraphics = false;

version(SFML_Window) enum bindSFMLWindow = true;
else enum bindSFMLWindow = false;

enum expandEnum(EnumType, string fqnEnumType = EnumType.stringof) = (){
    string expandEnum = "enum {";
    foreach(m;__traits(allMembers, EnumType)) {
        expandEnum ~= m ~ " = " ~ fqnEnumType ~ "." ~ m ~ ",";
    }
    expandEnum  ~= "}";
    return expandEnum;
}();