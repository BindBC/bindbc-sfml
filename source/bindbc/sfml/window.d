
//          Copyright 2020 - 2021 Michael D. Parker
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module bindbc.sfml.window;

import bindbc.sfml.config;
static if(bindSFMLWindow):

import bindbc.sfml.system;

// Window/Types.h
struct sfContext;
struct sfWindow;

static if(sfmlSupport >= SFMLSupport.sfml250) {
    struct sfCursor;
}

static if(sfmlSupport >= SFMLSupport.sfml250) {
    // Window/Cursor.h
    enum sfCursorType {
        sfCursorArrow,
        sfCursorArrowWait,
        sfCursorWait,
        sfCursorText,
        sfCursorHand,
        sfCursorSizeHorizontal,
        sfCursorSizeVertical,
        sfCursorSizeTopLeftBottomRight,
        sfCursorSizeBottomLeftTopRight,
        sfCursorSizeAll,
        sfCursorCross,
        sfCursorHelp,
        sfCursorNotAllowed
    }
}


// Window/Sensor.h
// Had to put this above sfSensorEvent declaration, else there was
// a compile failure due to the static if.
static if(sfmlSupport >= SFMLSupport.sfml220) {
    enum sfSensorType {
        sfSensorAccelerometer,
        sfSensorGyroscope,
        sfSensorMagnetometer,
        sfSensorGravity,
        sfSensorUserAcceleration,
        sfSensorOrientation,

        sfSensorCount,
    }
    mixin(expandEnum!sfSensorType);
}

// Window/Mouse.h
// Had to put this above sfMouseWheelScrollEvent declaration, else there was
// a compile failure due to the static if.
enum sfMouseButton {
    sfMouseLeft,
    sfMouseRight,
    sfMouseMiddle,
    sfMouseXButton1,
    sfMouseXButton2,
    sfMouseButtonCount,
}
mixin(expandEnum!sfMouseButton);

static if(sfmlSupport >= SFMLSupport.sfml230) {
    enum sfMouseWheel {
        sfMouseVerticalWheel,
        sfMouseHorizontalWheel,
    }
    mixin(expandEnum!sfMouseWheel);
}


// Window/Event.h
static if(sfmlSupport >= SFMLSupport.sfml230) {
    enum sfEventType {
        sfEvtClosed,
        sfEvtResized,
        sfEvtLostFocus,
        sfEvtGainedFocus,
        sfEvtTextEntered,
        sfEvtKeyPressed,
        sfEvtKeyReleased,
        sfEvtMouseWheelMoved,
        sfEvtMouseWheelScrolled,
        sfEvtMouseButtonPressed,
        sfEvtMouseButtonReleased,
        sfEvtMouseMoved,
        sfEvtMouseEntered,
        sfEvtMouseLeft,
        sfEvtJoystickButtonPressed,
        sfEvtJoystickButtonReleased,
        sfEvtJoystickMoved,
        sfEvtJoystickConnected,
        sfEvtJoystickDisconnected,
        sfEvtTouchBegan,
        sfEvtTouchMoved,
        sfEvtTouchEnded,
        sfEvtTouchChanged,
    }
}
else static if(sfmlSupport == SFMLSupport.sfml220) {
    enum sfEventType {
        sfEvtClosed,
        sfEvtResized,
        sfEvtLostFocus,
        sfEvtGainedFocus,
        sfEvtTextEntered,
        sfEvtKeyPressed,
        sfEvtKeyReleased,
        sfEvtMouseWheelMoved,
        sfEvtMouseButtonPressed,
        sfEvtMouseButtonReleased,
        sfEvtMouseMoved,
        sfEvtMouseEntered,
        sfEvtMouseLeft,
        sfEvtJoystickButtonPressed,
        sfEvtJoystickButtonReleased,
        sfEvtJoystickMoved,
        sfEvtJoystickConnected,
        sfEvtJoystickDisconnected,
        sfEvtTouchBegan,
        sfEvtTouchMoved,
        sfEvtTouchEnded,
        sfEvtTouchChanged,
    }
}
else {
    enum sfEventType {
        sfEvtClosed,
        sfEvtResized,
        sfEvtLostFocus,
        sfEvtGainedFocus,
        sfEvtTextEntered,
        sfEvtKeyPressed,
        sfEvtKeyReleased,
        sfEvtMouseWheelMoved,
        sfEvtMouseButtonPressed,
        sfEvtMouseButtonReleased,
        sfEvtMouseMoved,
        sfEvtMouseEntered,
        sfEvtMouseLeft,
        sfEvtJoystickButtonPressed,
        sfEvtJoystickButtonReleased,
        sfEvtJoystickMoved,
        sfEvtJoystickConnected,
        sfEvtJoystickDisconnected,
    }
}
mixin(expandEnum!sfEventType);

struct sfKeyEvent {
    sfEventType type;
    sfKeyCode code;
    sfBool alt;
    sfBool control;
    sfBool shift;
    sfBool system;
}

struct sfTextEvent {
    sfEventType type;
    sfUint32 unicode;
}

struct sfMouseMoveEvent {
    sfEventType type;
    int x;
    int y;
}

struct sfMouseButtonEvent {
    sfEventType type;
    sfMouseButton button;
    int x;
    int y;
}

struct sfMouseWheelEvent {
    sfEventType type;
    int delta;
    int x;
    int y;
}

static if(sfmlSupport >= SFMLSupport.sfml230) {
    struct sfMouseWheelScrollEvent {
        sfEventType type;
        sfMouseWheel wheel;
        float delta;
        int x;
        int y;
    }
}

struct sfJoystickMoveEvent {
    sfEventType type;
    uint joystickId;
    sfJoystickAxis axis;
    float position;
}

struct sfJoystickButtonEvent {
    sfEventType type;
    uint joystickId;
    uint button;
}

struct sfJoystickConnectEvent {
    sfEventType type;
    uint joystickId;
}

struct sfSizeEvent{
    sfEventType type;
    uint width;
    uint height;
}

static if(sfmlSupport >= SFMLSupport.sfml220) {
    struct sfTouchEvent {
        sfEventType type;
        uint finger;
        int x;
        int y;
    }

    struct sfSensorEvent {
        sfEventType type;
        sfSensorType sensorType;
        float x;
        float y;
        float z;
    }
}

union sfEvent {
    sfEventType type;
    sfSizeEvent size;
    sfKeyEvent key;
    sfTextEvent text;
    sfMouseMoveEvent mouseMove;
    sfMouseButtonEvent mouseButton;
    sfMouseWheelEvent mouseWheel;
    static if(sfmlSupport >= SFMLSupport.sfml230) {
        sfMouseWheelScrollEvent mouseWheelScroll;
    }
    sfJoystickMoveEvent joystickMove;
    sfJoystickButtonEvent joystickButton;
    sfJoystickConnectEvent joystickConnect;

    static if(sfmlSupport >= SFMLSupport.sfml220) {
        sfTouchEvent touch;
        sfSensorEvent sensor;
    }
}

// Window/Joystick.h
enum sfJoystickCount = 8;
enum sfJoystickButtonCount = 32;
enum sfJoystickAxisCount = 8;

enum sfJoystickAxis {
    sfJoystickX,
    sfJoystickY,
    sfJoystickZ,
    sfJoystickR,
    sfJoystickU,
    sfJoystickV,
    sfJoystickPovX,
    sfJoystickPovY,
}
mixin(expandEnum!sfJoystickAxis);

// Window/JoystickIndentification.h
static if(sfmlSupport >= SFMLSupport.sfml220) {
    struct sfJoystickIdentification {
        const(char)* name;
        uint vendorId;
        uint productId;
    }
}

// Window/Keyboard.h
enum sfKeyCode {
    sfKeyUnknown = -1,
    sfKeyA,
    sfKeyB,
    sfKeyC,
    sfKeyD,
    sfKeyE,
    sfKeyF,
    sfKeyG,
    sfKeyH,
    sfKeyI,
    sfKeyJ,
    sfKeyK,
    sfKeyL,
    sfKeyM,
    sfKeyN,
    sfKeyO,
    sfKeyP,
    sfKeyQ,
    sfKeyR,
    sfKeyS,
    sfKeyT,
    sfKeyU,
    sfKeyV,
    sfKeyW,
    sfKeyX,
    sfKeyY,
    sfKeyZ,
    sfKeyNum0,
    sfKeyNum1,
    sfKeyNum2,
    sfKeyNum3,
    sfKeyNum4,
    sfKeyNum5,
    sfKeyNum6,
    sfKeyNum7,
    sfKeyNum8,
    sfKeyNum9,
    sfKeyEscape,
    sfKeyLControl,
    sfKeyLShift,
    sfKeyLAlt,
    sfKeyLSystem,
    sfKeyRControl,
    sfKeyRShift,
    sfKeyRAlt,
    sfKeyRSystem,
    sfKeyMenu,
    sfKeyLBracket,
    sfKeyRBracket,
    sfKeySemicolon,
    sfKeyComma,
    sfKeyPeriod,
    sfKeyQuote,
    sfKeySlash,
    sfKeyBackslash,
    sfKeyTilde,
    sfKeyEqual,
    sfKeyHyphen,
    sfKeySpace,
    sfKeyEnter,
    sfKeyBackspace,
    sfKeyTab,
    sfKeyPageUp,
    sfKeyPageDown,
    sfKeyEnd,
    sfKeyHome,
    sfKeyInsert,
    sfKeyDelete,
    sfKeyAdd,
    sfKeySubtract,
    sfKeyMultiply,
    sfKeyDivide,
    sfKeyLeft,
    sfKeyRight,
    sfKeyUp,
    sfKeyDown,
    sfKeyNumpad0,
    sfKeyNumpad1,
    sfKeyNumpad2,
    sfKeyNumpad3,
    sfKeyNumpad4,
    sfKeyNumpad5,
    sfKeyNumpad6,
    sfKeyNumpad7,
    sfKeyNumpad8,
    sfKeyNumpad9,
    sfKeyF1,
    sfKeyF2,
    sfKeyF3,
    sfKeyF4,
    sfKeyF5,
    sfKeyF6,
    sfKeyF7,
    sfKeyF8,
    sfKeyF9,
    sfKeyF10,
    sfKeyF11,
    sfKeyF12,
    sfKeyF13,
    sfKeyF14,
    sfKeyF15,
    sfKeyPause,
    sfKeyCount,

    // Changed in 2.5
    sfKeySemiColon = sfKeySemicolon,
    sfKeyBackSlash = sfKeyBackslash,
    sfKeyDash = sfKeyHyphen,
    sfKeyReturn = sfKeyEnter,
    sfKeyBack = sfKeyBackspace,
}
mixin(expandEnum!sfKeyCode);

// Window/VideoMode.h
struct sfVideoMode {
    uint width;
    uint height;
    uint bitsPerPixel;
}

// Window/Window.h
enum sfWindowStyle {
    sfNone = 0,
    sfTitlebar = 1 << 0,
    sfResize = 1 << 1,
    sfClose = 1 << 2,
    sfFullscreen = 1 << 3,
    sfDefaultStyle = sfTitlebar | sfResize | sfClose,
}
mixin(expandEnum!sfWindowStyle);

static if(sfmlSupport >= SFMLSupport.sfml230) {
    enum sfContextAttribute {
        sfContextDefault = 0,
        sfContextCore    = 1 << 0,
        sfContextDebug   = 1 << 2,
    }
    mixin(expandEnum!sfContextAttribute);
}

struct sfContextSettings {
    uint depthBits;
    uint stencilBits;
    uint antialiasingLevel;
    uint majorVersion;
    uint minorVersion;
    static if(sfmlSupport >= SFMLSupport.sfml230) {
        sfUint32 attributeFlags;
    }
    static if(sfmlSupport >= SFMLSupport.sfml240) {
        sfBool sRgbCapable;
    }
}

// Window/WindowHandle.h
version(Windows) alias sfWindowHandle = void*;
else version(OSX) alias sfWindowHandle = void*;
else version(Posix) {
    import core.stdc.config : c_ulong;
    alias sfWindowHandle = c_ulong;
}

static if(staticSFML) {
    extern(C) @nogc nothrow {
        // Window/Context.h
        sfContext* sfContext_create();
        void sfContext_destroy(sfContext* context);

        static if(sfmlSupport >= sfmlSupport.sfml240) {
            sfBool sfContext_setActive(sfContext* context, sfBool active);
        }
        else void sfContext_setActive(sfContext* context, sfBool active);

        // Window/Joystick.h
        sfBool sfJoystick_isConnected(uint joystick);
        uint sfJoystick_getButtonCount(uint joystick);
        sfBool sfJoystick_hasAxis(uint joystick, sfJoystickAxis axis);
        sfBool sfJoystick_isButtonPressed(uint joystick, uint button);
        float sfJoystick_getAxisPosition(uint joystick, sfJoystickAxis axis);
        void sfJoystick_update();

        // Window/Keyboard.h
        sfBool sfKeyboard_isKeyPressed(sfKeyCode key);

        // Window/Mouse.h
        sfBool sfMouse_isButtonPressed(sfMouseButton button);
        sfVector2i sfMouse_getPosition(const(sfWindow)* relativeTo);
        void sfMouse_setPosition(sfVector2i position, const(sfWindow)* relativeTo);

        // Window/VideoMode.h
        sfVideoMode sfVideoMode_getDesktopMode();
        const(sfVideoMode)* sfVideoMode_getFullscreenModes(size_t* count);
        sfBool sfVideoMode_isValid(sfVideoMode mode);

        // Window/Window.h
        sfWindow* sfWindow_create(sfVideoMode mode, const(char)* title, sfUint32 style, const(sfContextSettings)* settings);
        sfWindow* sfWindow_createUnicode(sfVideoMode mode, const(sfUint32)* title, sfUint32 style, const(sfContextSettings)* settings);
        sfWindow* sfWindow_createFromHandle(sfWindowHandle handle, const(sfContextSettings)* settings);
        void sfWindow_destroy(sfWindow* window);
        void sfWindow_close(sfWindow* window);
        sfBool sfWindow_isOpen(const(sfWindow)* window);
        sfContextSettings sfWindow_getSettings(const(sfWindow)* window);
        sfBool sfWindow_pollEvent(sfWindow* window, sfEvent* event);
        sfBool sfWindow_waitEvent(sfWindow* window, sfEvent* event);
        sfVector2i sfWindow_getPosition(const(sfWindow)* window);
        void sfWindow_setPosition(sfWindow* window, sfVector2i position);
        sfVector2u sfWindow_getSize(const(sfWindow)* window);
        void sfWindow_setSize(sfWindow* window, sfVector2u size);
        void sfWindow_setTitle(sfWindow* window, const(char)* title);
        void sfWindow_setUnicodeTitle(sfWindow* window, const(sfUint32)* title);
        void sfWindow_setIcon(sfWindow* window, uint width, uint height, const(sfUint8)* pixels);
        void sfWindow_setVisible(sfWindow* window, sfBool visible);
        void sfWindow_setMouseCursorVisible(sfWindow* window, sfBool visible);
        void sfWindow_setVerticalSyncEnabled(sfWindow* window, sfBool enabled);
        void sfWindow_setKeyRepeatEnabled(sfWindow* window, sfBool enabled);
        sfBool sfWindow_setActive(sfWindow* window, sfBool active);
        void sfWindow_display(sfWindow* window);
        void sfWindow_setFramerateLimit(sfWindow* window, uint limit);
        void sfWindow_setJoystickThreshold(sfWindow* window, float threshold);
        sfWindowHandle sfWindow_getSystemHandle(const(sfWindow)* window);

        static if(sfmlSupport >= SFMLSupport.sfml220) {
            // Window/Joystick.h
            sfJoystickIdentification sfJoystick_getIdentification(uint joystick);

            // Window/Sensor.h
            sfBool sfSensor_isAvailable(sfSensorType sensor);
            void sfSensor_setEnabled(sfSensorType sensor, sfBool enabled);
            sfVector3f sfSensor_getValue(sfSensorType sensor);

            // Window/Touch.h
            sfBool sfTouch_isDown(uint finger);
            sfVector2i sfTouch_getPosition(uint finger, const(sfWindow)* relativeTo);

            // Window/Window.h
            void sfWindow_requestFocus(sfWindow* window);
            sfBool sfWindow_hasFocus(const(sfWindow)* window);
        }
        static if(sfmlSupport >= SFMLSupport.sfml240) {
            // Window/Context.h
            sfContextSettings sfContext_getSettings(const(sfContext)* context);

            // Window/Keyboard.h
            void sfKeyboard_setVirtualKeyboardVisible(sfBool visible);

            // Window/Window.h
            void sfWindow_setMouseCursorGrabbed(sfWindow* window, sfBool grabbed);
        }
        static if(sfmlSupport >= SFMLSupport.sfml250) {
            // Window/Clipboard.h
            const(char)* sfClipboard_getString();
            const(sfUint32)* sfClipboard_getUnicodeString();
            void sfClipboard_setString(const(char)* text);
            void sfClipboard_setUnicodeString(const(sfUint32)* text);

            // Window/Context.h
            sfUint64 sfContext_getActiveContextId();

            // Window/Cursor.h
            sfCursor* sfCursor_createFromPixels(const(sfUint8)* pixels, sfVector2u size, sfVector2u hotspot);
            sfCursor* sfCursor_createFromSystem(sfCursorType type);
            void sfCursor_destroy(sfCursor* cursor);

            // Window/Window.h
            void sfWindow_setMouseCursor(sfWindow* window, const(sfCursor)* cursor);
        }
    }
}
else {
    import bindbc.loader;

    extern(C) @nogc nothrow {
        // Window/Context.h
        alias psfContext_create = sfContext* function();
        alias psfContext_destroy = void function(sfContext* context);

        static if(sfmlSupport >= SFMLSupport.sfml240) {
            alias psfContext_setActive = sfBool function(sfContext* context, sfBool active);
        }
        else alias psfContext_setActive = void function(sfContext* context, sfBool active);

        // Window/Joystick.h
        alias psfJoystick_isConnected = sfBool function(uint joystick);
        alias psfJoystick_getButtonCount = uint function(uint joystick);
        alias psfJoystick_hasAxis = sfBool function(uint joystick, sfJoystickAxis axis);
        alias psfJoystick_isButtonPressed = sfBool function(uint joystick, uint button);
        alias psfJoystick_getAxisPosition = float function(uint joystick, sfJoystickAxis axis);
        alias psfJoystick_update = void function();

        // Window/Keyboard.h
        alias psfKeyboard_isKeyPressed = sfBool function(sfKeyCode key);

        // Window/Mouse.h
        alias psfMouse_isButtonPressed = sfBool function(sfMouseButton button);
        alias psfMouse_getPosition = sfVector2i function(const(sfWindow)* relativeTo);
        alias psfMouse_setPosition = void function(sfVector2i position, const(sfWindow)* relativeTo);

        // Window/VideoMode.h
        alias psfVideoMode_getDesktopMode = sfVideoMode function();
        alias psfVideoMode_getFullscreenModes = const(sfVideoMode)* function(size_t* count);
        alias psfVideoMode_isValid = sfBool function(sfVideoMode mode);

        // Window/Window.h
        alias psfWindow_create = sfWindow* function(sfVideoMode mode, const(char)* title, sfUint32 style, const(sfContextSettings)* settings);
        alias psfWindow_createUnicode = sfWindow* function(sfVideoMode mode, const(sfUint32)* title, sfUint32 style, const(sfContextSettings)* settings);
        alias psfWindow_createFromHandle = sfWindow* function(sfWindowHandle handle, const(sfContextSettings)* settings);
        alias psfWindow_destroy = void function(sfWindow* window);
        alias psfWindow_close = void function(sfWindow* window);
        alias psfWindow_isOpen = sfBool function(const(sfWindow)* window);
        alias psfWindow_getSettings = sfContextSettings function(const(sfWindow)* window);
        alias psfWindow_pollEvent = sfBool function(sfWindow* window, sfEvent* event);
        alias psfWindow_waitEvent = sfBool function(sfWindow* window, sfEvent* event);
        alias psfWindow_getPosition = sfVector2i function(const(sfWindow)* window);
        alias psfWindow_setPosition = void function(sfWindow* window, sfVector2i position);
        alias psfWindow_getSize = sfVector2u function(const(sfWindow)* window);
        alias psfWindow_setSize = void function(sfWindow* window, sfVector2u size);
        alias psfWindow_setTitle = void function(sfWindow* window, const(char)* title);
        alias psfWindow_setUnicodeTitle = void function(sfWindow* window, const(sfUint32)* title);
        alias psfWindow_setIcon = void function(sfWindow* window, uint width, uint height, const(sfUint8)* pixels);
        alias psfWindow_setVisible = void function(sfWindow* window, sfBool visible);
        alias psfWindow_setMouseCursorVisible = void function(sfWindow* window, sfBool visible);
        alias psfWindow_setVerticalSyncEnabled = void function(sfWindow* window, sfBool enabled);
        alias psfWindow_setKeyRepeatEnabled = void function(sfWindow* window, sfBool enabled);
        alias psfWindow_setActive = sfBool function(sfWindow* window, sfBool active);
        alias psfWindow_display = void function(sfWindow* window);
        alias psfWindow_setFramerateLimit = void function(sfWindow* window, uint limit);
        alias psfWindow_setJoystickThreshold = void function(sfWindow* window, float threshold);
        alias psfWindow_getSystemHandle = sfWindowHandle function(const(sfWindow)* window);

        static if(sfmlSupport >= SFMLSupport.sfml220) {
            // Window/Joystick.h
            alias psfJoystick_getIdentification = sfJoystickIdentification function(uint joystick);

            // Window/Sensor.h
            alias psfSensor_isAvailable = sfBool function(sfSensorType sensor);
            alias psfSensor_setEnabled = void function(sfSensorType sensor, sfBool enabled);
            alias psfSensor_getValue = sfVector3f function(sfSensorType sensor);

            // Window/Touch.h
            alias psfTouch_isDown = sfBool function(uint finger);
            alias psfTouch_getPosition = sfVector2i function(uint finger, const(sfWindow)* relativeTo);

            // Window/Window.h
            alias psfWindow_requestFocus = void function(sfWindow* window);
            alias psfWindow_hasFocus = sfBool function(const(sfWindow)* window);
        }
        static if(sfmlSupport >= SFMLSupport.sfml240) {
            // Window/Context.h
            alias psfContext_getSettings = sfContextSettings function(const(sfContext)* context);

            // Window/Keyboard.h
            alias psfKeyboard_setVirtualKeyboardVisible = void function(sfBool visible);

            // Window/Window.h
            alias psfWindow_setMouseCursorGrabbed = void function(sfWindow* window, sfBool grabbed);
        }
        static if(sfmlSupport >= SFMLSupport.sfml250) {
            // Window/Clipboard.h
            alias psfClipboard_getString = const(char)* function();
            alias psfClipboard_getUnicodeString = const(sfUint32)* function();
            alias psfClipboard_setString = void function(const(char)* text);
            alias psfClipboard_setUnicodeString = void function(const(sfUint32)* text);

            // Window/Context.h
            alias psfContext_getActiveContextId = sfUint64 function();

            // Window/Cursor.h
            alias psfCursor_createFromPixels = sfCursor* function(const(sfUint8)* pixels, sfVector2u size, sfVector2u hotspot);
            alias psfCursor_createFromSystem = sfCursor* function(sfCursorType type);
            alias psfCursor_destroy = void function(sfCursor* cursor);

            // Window/Window.h
            alias psfWindow_setMouseCursor = void function(sfWindow* window, const(sfCursor)* cursor);
        }
    }

    __gshared {
        psfContext_create sfContext_create;
        psfContext_destroy sfContext_destroy;
        psfContext_setActive sfContext_setActive;
        psfJoystick_isConnected sfJoystick_isConnected;
        psfJoystick_getButtonCount sfJoystick_getButtonCount;
        psfJoystick_hasAxis sfJoystick_hasAxis;
        psfJoystick_isButtonPressed sfJoystick_isButtonPressed;
        psfJoystick_getAxisPosition sfJoystick_getAxisPosition;
        psfJoystick_update sfJoystick_update;
        psfKeyboard_isKeyPressed sfKeyboard_isKeyPressed;
        psfMouse_isButtonPressed sfMouse_isButtonPressed;
        psfMouse_getPosition sfMouse_getPosition;
        psfMouse_setPosition sfMouse_setPosition;
        psfVideoMode_getDesktopMode sfVideoMode_getDesktopMode;
        psfVideoMode_getFullscreenModes sfVideoMode_getFullscreenModes;
        psfVideoMode_isValid sfVideoMode_isValid;
        psfWindow_create sfWindow_create;
        psfWindow_createUnicode sfWindow_createUnicode;
        psfWindow_createFromHandle sfWindow_createFromHandle;
        psfWindow_destroy sfWindow_destroy;
        psfWindow_close sfWindow_close;
        psfWindow_isOpen sfWindow_isOpen;
        psfWindow_getSettings sfWindow_getSettings;
        psfWindow_pollEvent sfWindow_pollEvent;
        psfWindow_waitEvent sfWindow_waitEvent;
        psfWindow_getPosition sfWindow_getPosition;
        psfWindow_setPosition sfWindow_setPosition;
        psfWindow_getSize sfWindow_getSize;
        psfWindow_setSize sfWindow_setSize;
        psfWindow_setTitle sfWindow_setTitle;
        psfWindow_setUnicodeTitle sfWindow_setUnicodeTitle;
        psfWindow_setIcon sfWindow_setIcon;
        psfWindow_setVisible sfWindow_setVisible;
        psfWindow_setMouseCursorVisible sfWindow_setMouseCursorVisible;
        psfWindow_setVerticalSyncEnabled sfWindow_setVerticalSyncEnabled;
        psfWindow_setKeyRepeatEnabled sfWindow_setKeyRepeatEnabled;
        psfWindow_setActive sfWindow_setActive;
        psfWindow_display sfWindow_display;
        psfWindow_setFramerateLimit sfWindow_setFramerateLimit;
        psfWindow_setJoystickThreshold sfWindow_setJoystickThreshold;
        psfWindow_getSystemHandle sfWindow_getSystemHandle;

        static if(sfmlSupport >= SFMLSupport.sfml220) {
            psfJoystick_getIdentification sfJoystick_getIdentification;
            psfSensor_isAvailable sfSensor_isAvailable;
            psfSensor_setEnabled sfSensor_setEnabled;
            psfSensor_getValue sfSensor_getValue;
            psfTouch_isDown sfTouch_isDown;
            psfTouch_getPosition sfTouch_getPosition;
            psfWindow_requestFocus sfWindow_requestFocus;
            psfWindow_hasFocus sfWindow_hasFocus;
        }
        static if(sfmlSupport >= SFMLSupport.sfml240) {
            psfContext_getSettings sfContext_getSettings;
            psfKeyboard_setVirtualKeyboardVisible sfKeyboard_setVirtualKeyboardVisible;
            psfWindow_setMouseCursorGrabbed sfWindow_setMouseCursorGrabbed;
        }
        static if(sfmlSupport >= SFMLSupport.sfml250) {
            psfClipboard_getString sfClipboard_getString;
            psfClipboard_getUnicodeString sfClipboard_getUnicodeString;
            psfClipboard_setString sfClipboard_setString;
            psfClipboard_setUnicodeString sfClipboard_setUnicodeString;
            psfContext_getActiveContextId sfContext_getActiveContextId;
            psfCursor_createFromPixels sfCursor_createFromPixels;
            psfCursor_createFromSystem sfCursor_createFromSystem;
            psfCursor_destroy sfCursor_destroy;
            psfWindow_setMouseCursor sfWindow_setMouseCursor;
        }
    }
    private {
        SharedLib lib;
        SFMLSupport loadedVersion;
    }

@nogc nothrow:
    SFMLSupport loadedSFMLWindowVersion() { return loadedVersion; }

    bool isSFMLWindowLoaded()
    {
        return lib != invalidHandle;
    }

    SFMLSupport loadSFMLWindow()
    {
        version(Windows) {
            const(char)[][3] libNames = [
                "csfml-window.dll",
                "csfml-window-2.dll",
                "csfml-window-2.0.dll"
            ];
        }
        else version(OSX) {
            const(char)[][3] libNames = [
                "libcsfml-window.dylib",
                "libcsfml-window.2.dylib",
                "libcsfml-window.2.0.dylib"
            ];
        }
        else version(Posix) {
            const(char)[][3] libNames = [
                "libcsfml-window.so",
                "libcsfml-window.so.2",
                "libcsfml-window.so.2.0"
            ];
        }

        SFMLSupport ret;
        foreach(name; libNames) {
            ret = loadSFMLWindow(name.ptr);
            if(ret != SFMLSupport.noLibrary) break;
        }
        return ret;
    }

    SFMLSupport loadSFMLWindow(const(char)* libName)
    {
        lib = load(libName);
        if(lib == invalidHandle) {
            return SFMLSupport.noLibrary;
        }

        auto errCount = errorCount();
        loadedVersion = SFMLSupport.badLibrary;

        // Now load the functions
        lib.bindSymbol(cast(void**)&sfContext_create,"sfContext_create");
        lib.bindSymbol(cast(void**)&sfContext_destroy,"sfContext_destroy");
        lib.bindSymbol(cast(void**)&sfContext_setActive,"sfContext_setActive");
        lib.bindSymbol(cast(void**)&sfJoystick_isConnected,"sfJoystick_isConnected");
        lib.bindSymbol(cast(void**)&sfJoystick_getButtonCount,"sfJoystick_getButtonCount");
        lib.bindSymbol(cast(void**)&sfJoystick_hasAxis,"sfJoystick_hasAxis");
        lib.bindSymbol(cast(void**)&sfJoystick_isButtonPressed,"sfJoystick_isButtonPressed");
        lib.bindSymbol(cast(void**)&sfJoystick_getAxisPosition,"sfJoystick_getAxisPosition");
        lib.bindSymbol(cast(void**)&sfJoystick_update,"sfJoystick_update");
        lib.bindSymbol(cast(void**)&sfKeyboard_isKeyPressed,"sfKeyboard_isKeyPressed");
        lib.bindSymbol(cast(void**)&sfMouse_isButtonPressed,"sfMouse_isButtonPressed");
        lib.bindSymbol(cast(void**)&sfMouse_getPosition,"sfMouse_getPosition");
        lib.bindSymbol(cast(void**)&sfMouse_setPosition,"sfMouse_setPosition");
        lib.bindSymbol(cast(void**)&sfVideoMode_getDesktopMode,"sfVideoMode_getDesktopMode");
        lib.bindSymbol(cast(void**)&sfVideoMode_getFullscreenModes,"sfVideoMode_getFullscreenModes");
        lib.bindSymbol(cast(void**)&sfVideoMode_isValid,"sfVideoMode_isValid");
        lib.bindSymbol(cast(void**)&sfWindow_create,"sfWindow_create");
        lib.bindSymbol(cast(void**)&sfWindow_createUnicode,"sfWindow_createUnicode");
        lib.bindSymbol(cast(void**)&sfWindow_createFromHandle,"sfWindow_createFromHandle");
        lib.bindSymbol(cast(void**)&sfWindow_destroy,"sfWindow_destroy");
        lib.bindSymbol(cast(void**)&sfWindow_close,"sfWindow_close");
        lib.bindSymbol(cast(void**)&sfWindow_isOpen,"sfWindow_isOpen");
        lib.bindSymbol(cast(void**)&sfWindow_getSettings,"sfWindow_getSettings");
        lib.bindSymbol(cast(void**)&sfWindow_pollEvent,"sfWindow_pollEvent");
        lib.bindSymbol(cast(void**)&sfWindow_waitEvent,"sfWindow_waitEvent");
        lib.bindSymbol(cast(void**)&sfWindow_getPosition,"sfWindow_getPosition");
        lib.bindSymbol(cast(void**)&sfWindow_setPosition,"sfWindow_setPosition");
        lib.bindSymbol(cast(void**)&sfWindow_getSize,"sfWindow_getSize");
        lib.bindSymbol(cast(void**)&sfWindow_setSize,"sfWindow_setSize");
        lib.bindSymbol(cast(void**)&sfWindow_setTitle,"sfWindow_setTitle");
        lib.bindSymbol(cast(void**)&sfWindow_setUnicodeTitle,"sfWindow_setUnicodeTitle");
        lib.bindSymbol(cast(void**)&sfWindow_setIcon,"sfWindow_setIcon");
        lib.bindSymbol(cast(void**)&sfWindow_setVisible,"sfWindow_setVisible");
        lib.bindSymbol(cast(void**)&sfWindow_setMouseCursorVisible,"sfWindow_setMouseCursorVisible");
        lib.bindSymbol(cast(void**)&sfWindow_setVerticalSyncEnabled,"sfWindow_setVerticalSyncEnabled");
        lib.bindSymbol(cast(void**)&sfWindow_setKeyRepeatEnabled,"sfWindow_setKeyRepeatEnabled");
        lib.bindSymbol(cast(void**)&sfWindow_setActive,"sfWindow_setActive");
        lib.bindSymbol(cast(void**)&sfWindow_display,"sfWindow_display");
        lib.bindSymbol(cast(void**)&sfWindow_setFramerateLimit,"sfWindow_setFramerateLimit");
        lib.bindSymbol(cast(void**)&sfWindow_setJoystickThreshold,"sfWindow_setJoystickThreshold");
        lib.bindSymbol(cast(void**)&sfWindow_getSystemHandle,"sfWindow_getSystemHandle");

        if(errorCount() != errCount) return SFMLSupport.badLibrary;
        else loadedVersion = sfmlSupport.sfml200;

        static if(sfmlSupport >= SFMLSupport.sfml220) {
            lib.bindSymbol(cast(void**)&sfJoystick_getIdentification,"sfJoystick_getIdentification");
            lib.bindSymbol(cast(void**)&sfSensor_isAvailable,"sfSensor_isAvailable");
            lib.bindSymbol(cast(void**)&sfSensor_setEnabled,"sfSensor_setEnabled");
            lib.bindSymbol(cast(void**)&sfSensor_getValue,"sfSensor_getValue");
            lib.bindSymbol(cast(void**)&sfTouch_isDown,"sfTouch_isDown");
            lib.bindSymbol(cast(void**)&sfTouch_getPosition,"sfTouch_getPosition");
            lib.bindSymbol(cast(void**)&sfWindow_requestFocus,"sfWindow_requestFocus");
            lib.bindSymbol(cast(void**)&sfWindow_hasFocus,"sfWindow_hasFocus");

            if(errorCount() != errCount) return SFMLSupport.badLibrary;
            else {
                static if(sfmlSupport >= SFMLSupport.sfml230) {
                    loadedVersion = sfmlSupport.sfml230;
                }
                else loadedVersion = sfmlSupport.sfml220;
            }
        }
        static if(sfmlSupport >= SFMLSupport.sfml240) {
            lib.bindSymbol(cast(void**)&sfContext_getSettings,"sfContext_getSettings");
            lib.bindSymbol(cast(void**)&sfKeyboard_setVirtualKeyboardVisible,"sfKeyboard_setVirtualKeyboardVisible");
            lib.bindSymbol(cast(void**)&sfWindow_setMouseCursorGrabbed,"sfWindow_setMouseCursorGrabbed");

            if(errorCount() != errCount) return SFMLSupport.badLibrary;
            else loadedVersion = sfmlSupport.sfml240;
        }
        static if(sfmlSupport >= SFMLSupport.sfml250) {
            lib.bindSymbol(cast(void**)&sfClipboard_getString,"sfClipboard_getString");
            lib.bindSymbol(cast(void**)&sfClipboard_getUnicodeString,"sfClipboard_getUnicodeString");
            lib.bindSymbol(cast(void**)&sfClipboard_setString,"sfClipboard_setString");
            lib.bindSymbol(cast(void**)&sfClipboard_setUnicodeString,"sfClipboard_setUnicodeString");
            lib.bindSymbol(cast(void**)&sfContext_getActiveContextId,"sfContext_getActiveContextId");
            lib.bindSymbol(cast(void**)&sfCursor_createFromPixels,"sfCursor_createFromPixels");
            lib.bindSymbol(cast(void**)&sfCursor_createFromSystem,"sfCursor_createFromSystem");
            lib.bindSymbol(cast(void**)&sfCursor_destroy,"sfCursor_destroy");
            lib.bindSymbol(cast(void**)&sfWindow_setMouseCursor,"sfWindow_setMouseCursor");

            if(errorCount() != errCount) return SFMLSupport.badLibrary;
            else loadedVersion = sfmlSupport.sfml250;
        }


        return loadedVersion;
    }
}

