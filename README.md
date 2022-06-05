# bindbc-sfml
This project provides both static and dynamic D bindings to versions 2.0 &ndash; 2.5 of the CSFML libraries, which in turn are [the official C bindings](https://www.sfml-dev.org/download/csfml/) to [the SFML game and multimedia libraries](https://www.sfml-dev.org/index.php) written in C++. This package is intended as a replacement of [DerelictSFML2](https://github.com/DerelictOrg/DerelictSFML2).

## About CSFML
__NOTE__: This documentation describes how to use `bindbc-sfml`. As the maintainer of this library, I do not provide instructions on using CSFML. However, since these are direct bindings to the CSFML API, then the following quote from the CSFML download page applies (documentation link added by me for convenience):

> Since the CSFML API is similar to SFML, there's no tutorial for it; but you can follow the C++ tutorials available [on this website](https://www.sfml-dev.org/learn.php), and adapt them to the C API very easily.

[The CSFML download packages](https://www.sfml-dev.org/download/csfml/) include the C API documentation so that you can easily see how to translate the C++ examples to C, which in turn will be an almost direct translation to D. (In the future, I intend to create a D tutorial series that will use `bindbc-sfml`.)

## Usage
By default, `bindbc-sfml` is configured to compile as dynamic bindings that are not `-betterC` compatible. The dynamic bindings have no link-time dependency on the CSFML libraries, so the CSFML shared libraries must be manually loaded at runtime. When configured as static bindings, there is a link-time dependency on the CSFML libraries&mdash;either the static libraries or the appropriate files for linking with shared libraries on your system (see below).

When using DUB to manage your project, the static bindings can be enabled via a DUB `subConfiguration` statement in your project's package file. `-betterC` compatibility is also enabled via subconfigurations.

To use any of the supported CSFML libraries, add `bindbc-sfml` as a dependency to your project's package file and include the appropriate version for any of the CSFML libraries you want to use. Note that the CSFML System library is always loaded, and when the CSFML Graphics library is configured, the CSFML Window library will be loaded automatically.

As an example, the following is configured to use the Audio, Graphics, System, and Window libraries via dynamic bindings that are not `-betterC` compatible (replace the `1.0.0` `bindbc-sfml` version with the actual version you require):

__dub.json__
```
dependencies {
    "bindbc-sfml": "~>1.0.0",
}
"versions": [
    "SFML_Audio",
    "SFML_Graphics"
],
```

__dub.sdl__
```
dependency "bindbc-sfml" version="~>1.0.0"
versions "SFML_Audio" "SFML_Graphics"
```

### The dynamic bindings
The dynamic bindings require no special configuration when using DUB to manage your project. There is no link-time dependency. At runtime, the CSFML shared libraries are required to be on the shared library search path of the user's system. On Windows, this is typically handled by distributing the CSFML DLLs with your program. On other systems, it usually means installing the SFML runtime libraries through a package manager.

To load the shared libraries, you need to call the appropriate load function. Each CSFML library binding provides load functions that return a binding-specific value indicating either that the library failed to load (it couldn't be found) or that one or more symbols failed to load, or that a version number that matches a global constant based on the compile-time configuration.

There is also a global `loadSFML` function that will load all configured CSFML libraries, and which returns `true` on success or `false` on failure. This is possible due to the fact that all of the CSFML libraries are part of the same versioned release package. In other words, all of the CSFML libraries you distribute with your application should be from the same release, e.g. CSFML 2.2 or CSFML 2.5. Never mix different CSFML library versions in the same program.

Note that it is not necessary to load the CSFML System library unless you intend to call any functions from the System API. When using the CSFML Graphics library, the same holds true for the CSFML Window library; the Graphics library is dependent on the Window library, and both shared libraries need to be in the same directory (along with the System shared library, upon which all the CSFML libraries depend), but it is not necessary to load the Window library if you do not need to call any of its functions.

```d
/*
 The package modules for any CSFML libraries you have configured will be imported
 with this single import statement. In the case of the configuration example
 above, the Audio, Graphics, System, and Window package modules will be imported.
*/
import bindbc.sfml;

/*
 This version attempts to load the CSFML System library and all configured CSFML libraries using well-known variations of the library names for the host system. Note that when the Graphics library is configured, the Window library is also
 automatically configured, so `loadSFML` will attempt to load it as well.
*/
if(!loadSFML()) {
    /*
     A CSFML library failed to load. The error handling API in bindbc-loader
     can be used to fetch the error messages.
    */
}

/*
 This version attempts to load a specific CSFML library individually. This allows for more nuanced error handling, and avoids the loading of the System and, in this case, Window libraries when you don't need to use them.
*/
SFMLSupport ret = loadSFMLGraphics();
if(ret != sfmlSupport) {
    /*
     sfmlSupport is the compile-time constant representing the CSFML version that was configured, e.g., `SFMLSupport.sfml200`, `SFMLSupport.sfml220`, etc. If the load was successful, then the returned value should match the `sfmlSupport` value. If the load failed, the returned value will be one of `SFMLSupport.noLibrary` or `SFMLSupport.badLibrary`.
    */
    if(ret == SFMLSupport.noLibrary) {
        /*
         The system failed to load the library. Usually this means that either the library or one of its dependencies could not be found.
        */
    }
    else if(ret == SFMLSupport.badLibrary) {
        /*
         This indicates that the system was able to find and successfully load the library, but one or more symbols the binding expected to find was missing. This usually indicates that the loaded library is of a lower API version than the binding was configured to load, e.g., a CSFML 2.0 library loaded by a CSFML 2.5 configuration.

         For many C libraries, this is perfectly fine and the application can continue as long as none of the missing functions are called. Unfortunately, for CSFML, this can be problematic, as the maintainer sometimes changes the signature of functions from one minor version to the next. (This is addressed later in this documentation.)
        */
    }
}

/*
 This version attempts to load a specific CSFML library using a user-supplied file name.
 Usually, the name and/or path will be platform specific, as in this example
 which attempts to load `csfml-graphics.dll` from the `libs` subdirectory, relative
 to the executable, only on Windows. It has the same return values as the version above.
*/
version(Windows) {
    auto ret = loadSFMLGraphics("libs/csfml-graphics.dll");
    if(ret != sfmlSupport) {
        // Error handling as above.
    }
}
```
By default, each CSFML library binding is configured to compile bindings for version 2.0.0 the C library. This ensures the widest level of compatibility at runtime. This behavior can be overridden by using via specific identifiers. It is recommended that you always select the minimum version you require _and no higher_. In this example, the CSFML dynamic bindings (for each CSFML library you intend to use) is compiled to support CSFML version 2.5.0 (replace the `1.0.0` `bindbc-sfml` version with the actual version you require):

__dub.json__
```
"dependencies": {
    "bindbc-sfmll": "~>1.0.0"
},
"versions": [
    "SFML_Audio",
    "SFML_Graphics",
    "SFML_250",
],
```

__dub.sdl__
```
dependency "bindbc-sfml" version="~>1.0.0"
versions "SFML_Audio" "SFML_Graphics" "SFML_250"
```

Following are the supported CSFML library versions and the corresponding version IDs to pass to the compiler.

| Library Version    | Version ID       |
|--------------------|------------------|
|SFML 2.0.0           | Default         |
|SFML 2.1.0           | SFML_201        |
|SFML 2.2.0           | SFML_202        |
|SFML 2.3.0           | SFML_203        |
|SFML 2.4.0           | SFML_204        |
|SFML 2.5.0           | SFML_205        |

__NOTE__: Note that, unlike the main SFML libraries, CSFML does not tend to have patch releases. This means, for example, that CSFML 2.5.0 is compatible with SFML 2.5.0, SFML 2.5.1, and any future SFML 2.5.x releases. As a result, the `CSFML_VERSION_PATCH` constant is always `0`.

__NOTE__: There is no difference in the public API between CSFML 2.0 and CSFML 2.1.

### Version mismatch
Many C libraries have versioning schemes such that minor version releases, e.g. 2.0 vs 2.1, are still compatible. In that case, a dynamic binding can load e.g. a 2.0 library with a 2.1 binding and, as long as no 2.1 functions are called, run as normal. With SFML, this is actually only true with versions 2.0 and 2.1.

Beginning in CSFML 2.2 and continuing in later versions, some function signatures were changed from the previous versions. Due to the nature of dynamic loading, this *will not break library loading* when, say, a 2.0 library is loaded by a 2.5 binding. However, it will cause undefined behavior (most likely a crash) if an affected function is called.

For that reason, it is recommended that if you configure `bindbc-sfml` with version `SFML_230` or higher, you always treat a load function return value of `SFMLSupport.badLibrary` as an irrecoverable failure and do not attempt to continue with the lower library version.

If you insist on supporting older CSFML versions than the one you've configured, you'll need to be aware of the changes. In some cases, the type of one or more parameters, or of the return value, was changed, In other cases, parameters were added. Some of the changes might be harmless (like changing a return type from `int` to `float`), or harmless 64-bit builds (like changing a parameter or return type from `uint` to `size_t`), but the rest can cause issues.

These are the functions you need to watch out for, the version in which the change was made, and the nature of the change:

| Version  | Function Name                        | Change                               |
|-------------------------------------------------|--------------------------------------|
| SFML_220 | sfFont_getKerning                    | Return type (void to sfBool)         |
| SFML_220 | sfFont_getLineSpacing                | Return type (void to sfBool)         |
| SFML_220 | sfSoundRecorder_start                | Return type (void to sfBool)         |
| SFML_230 | sfCircleShape_getPoint               | Parameter type (uint to size_t)      |
| SFML_230 | sfCircleShape_getPointCount          | Return type (uint to size_t)         |
| SFML_230 | sfCircleShape_setPointCount          | Parameter type (uint to size_t)      |
| SFML_230 | sfConvexShape_getPoint               | Parameter type (uint to size_t)      |
| SFML_230 | sfConvexShape_getPointCount          | Return type (uint to size_t)         |
| SFML_230 | sfConvexShape_setPointCount          | Parameter type (uint to size_t)      |
| SFML_230 | sfRectangleShape_getPoint            | Parameter type (uint to size_t)      |
| SFML_230 | sfRectangleShape_getPointCount       | Return type (uint to size_t)         |
| SFML_230 | sfRenderTexture_drawPrimitives       | Parameter type (uint to size_t)      |
| SFML_230 | sfRenderWindow_drawPrimitives        | Parameter type (uint to size_t)      |
| SFML_230 | sfShader_createFromStream            | Additional parameter                 |
| SFML_230 | sfShape_getPoint                     | Parameter type (uint to size_t)      |
| SFML_230 | sfShape_getPointCount                | Return type (uint to size_t)         |
| SFML_230 | sfSoundBuffer_createFromSamples      | Parameter type (size_t to sfUint64)  |
| SFML_230 | sfSoundBuffer_getSampleCount         | Return type (size_t to sfUint64)     |
| SFML_230 | sfVertexArray_getVertexCount         | Return type (uint to size_t)         |
| SFML_230 | sfVertexArray_getVertex              | Parameter type (uint to size_t)      |
| SFML_230 | sfVertexArray_resize                 | Parameter type (uint to size_t)      |
| SFML_240 | sfContext_setActive                  | Return type (void to sfBool)         |
| SFML_240 | sfTcpListener_listen                 | Additional parameter                 |
| SFML_240 | sfUdpSocket_bind                     | Additional parameter                 |
| SFML_240 | sfSoundBufferRecorder_start          | Return type (void to sfBool)         |
| SFML_250 | sfFtp_upload                         | Additional parameter                 |

## The static bindings
The static bindings have a link-time dependency on either the shared or static CSFML libraries. On Windows, you can link with the static libraries or, to use the DLLs, the import libraries. On other systems, you can link with either the static libraries or directly with the shared libraries.

This requires the CSFML development packages be installed on your system at compile time. When linking with the static libraries, there is no runtime dependency on CSFML. When linking with the shared libraries, the runtime dependency is the same as the dynamic bindings, the difference being that the shared libraries are no longer loaded manually&mdash;loading is handled automatically by the system when the program is launched.

__NOTE__: The CSFML binary distributions on [the CSFML download page](https://www.sfml-dev.org/download/csfml/) do not include static libraries. The Windows packages contain import libraries, meaning the DLLs will still be required at runtime. To obtain the static libraries, you will either have to build them yourself or find prebuilt libraries somewhere else. I am unaware of anywhere that provides the CSFML static libraries for download, so if you do find them somewhere, please let me know.

Enabling the static bindings can be done in two ways.

### Via the compiler's `-version` switch or DUB's `versions` directive
Pass the `BindSFML_Static` version to the compiler and link with the appropriate libraries. Note that `BindSFML_Static` will also enable the static binding for all configured CSFML libraries.

When using the compiler command line or a build system that doesn't support DUB, this is the only option. The `-version=BindSFML_Static` option should be passed to the compiler when building your program. All of the required C libraries, as well as the `bindbc-sfml` and `bindbc-loader` static libraries, must also be passed to the compiler on the command line or via your build system's configuration.

__NOTE__: The version identifier `BindBC_Static` can be used to configure all of the _official_ BindBC packages used in your program, i.e., those maintained in [the BindBC GitHub organization](https://github.com/BindBC). Some third-party BindBC packages may support it as well.

For example, when using the static bindings for the SFML Audio and Graphics packages with DUB (replace the `1.0.0` `bindbc-sfml` version with the actual version you require):

__dub.json__
```
"dependencies": {
    "bindbc-sfml": "~>1.0.0"
},
"versions": ["BindSFML_Static", "SFML_Audio", "SFML_Graphics"],
"libs": ["csfml-audio", "csfml-graphics"]
```

__dub.sdl__
```
dependency "bindbc-sfml" version="~>1.0.0"
versions "BindSFML_Static" "SFML_Audio" "SFML_Graphics"
libs "csfml-audio"  "csfml-graphics"
```

Note that if you wished to call any CSFML System or Window functions, the `csdml-system` and `csfml-window` libraries would need to be linked as well.

### Via DUB subconfigurations
Instead of using DUB's `versions` directive, a `subConfiguration` can be used. Enable the `static` subconfiguration for the `bindbc-sfml` dependency:

__dub.json__
```
"dependencies": {
    "bindbc-sfml": "~>1.0.0"
},
"subConfigurations": {
    "bindbc-sfml": "static"
},
"versions": [
    "SFML_Audio",
    "SFML_Graphics",
],
"libs": ["csfml-audio", "csfml-graphics"]
```

__dub.sdl__
```
dependency "bindbc-sfml" version="~>1.0.0"
subConfiguration "bindbc-sfml" "static"
versions "SFML_Audio" "SFML_Graphics"
libs "csfml-audio"  "csfml-graphics"
```

Note that if you wished to call any CSFML System or Window functions, the `csdml-system` and `csfml-window` libraries would need to be linked as well.

## `-betterC` support
`-betterC` support is enabled via the `dynamicBC` and `staticBC` subconfigurations, for dynamic and static bindings respectively. To enable the static bindings with `-betterC` support:

__dub.json__
```
"dependencies": {
    "bindbc-sfml": "~>1.0.0"
},
"subConfigurations": {
    "bindbc-sfml": "staticBC"
},
"versions": [
    "SFML_Audio",
    "SFML_Graphics",
],
"libs": ["csfml-audio", "csfml-graphics"]
```

__dub.sdl__
```
dependency "bindbc-sfml" version="~>1.0.0"
subConfiguration "bindbc-sfml" "staticBC"
versions "SFML_Audio" "SFML_Graphics"
libs "csfml-audio"  "csfml-graphics"
```

Note that if you wished to call any CSFML System or Window functions, the `csdml-system` and `csfml-window` libraries would need to be linked as well.

When not using DUB to manage your project, first use DUB to compile the BindBC libraries with the `dynamicBC` or `staticBC` configuration, then pass `-betterC` to the compiler when building your project.