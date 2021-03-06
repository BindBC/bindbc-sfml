
//          Copyright Michael D. Parker 2018.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module bindbc.sfml.graphics;

import bindbc.sfml.config;
static if(bindSFMLGraphics):

import bindbc.sfml.system;
import bindbc.sfml.window;

// Graphics/Types.h
struct sfCircleShape;
struct sfConvexShape;
struct sfFont;
struct sfImage;
struct sfShader;
struct sfRectangleShape;
struct sfRenderTexture;
struct sfRenderWindow;
struct sfShape;
struct sfSprite;
struct sfText;
struct sfTexture;
struct sfTransformable;
struct sfVertexArray;
struct sfView;

static if(sfmlSupport >= SFMLSupport.sfml250) {
    struct sfVertexBuffer;
}

// Graphics/BlendMode.h
static if(sfmlSupport >= SFMLSupport.sfml220) {
    enum sfBlendFactor {
        sfBlendFactorZero,
        sfBlendFactorOne,
        sfBlendFactorSrcColor,
        sfBlendFactorOneMinusSrcColor,
        sfBlendFactorDstColor,
        sfBlendFactorOneMinusDstColor,
        sfBlendFactorSrcAlpha,
        sfBlendFactorOneMinusSrcAlpha,
        sfBlendFactorDstAlpha,
        sfBlendFactorOneMinusDstAlpha,
    }
    mixin(expandEnum!sfBlendFactor);

    static if(sfmlSupport >= SFMLSupport.sfml240) {
        enum sfBlendEquation {
            sfBlendEquationAdd,
            sfBlendEquationSubtract,
            sfBlendEquationReverseSubtract,
        }
    }
    else {
        enum sfBlendEquation {
            sfBlendEquationAdd,
            sfBlendEquationSubtract,
        }
    }
    mixin(expandEnum!sfBlendEquation);

    struct sfBlendMode {
        sfBlendFactor colorSrcFactor;
        sfBlendFactor colorDstFactor;
        sfBlendEquation colorEquation;
        sfBlendFactor alphaSrcFactor;
        sfBlendFactor alphaDstFactor;
        sfBlendEquation alphaEquation;
    }

    immutable(sfBlendMode) sfBlendAlpha = sfBlendMode(sfBlendFactorSrcAlpha, sfBlendFactorOneMinusSrcAlpha, sfBlendEquationAdd,
                                                      sfBlendFactorOne, sfBlendFactorOneMinusSrcAlpha, sfBlendEquationAdd);
    immutable(sfBlendMode) sfBlendAdd = sfBlendMode(sfBlendFactorSrcAlpha, sfBlendFactorOne, sfBlendEquationAdd,
                                                    sfBlendFactorOne, sfBlendFactorOne, sfBlendEquationAdd);
    immutable(sfBlendMode) sfBlendMultiply = sfBlendMode(sfBlendFactorDstColor, sfBlendFactorZero, sfBlendEquationAdd,
                                                         sfBlendFactorDstColor, sfBlendFactorZero, sfBlendEquationAdd);
    immutable(sfBlendMode) sfBlendNone = sfBlendMode(sfBlendFactorOne, sfBlendFactorZero, sfBlendEquationAdd,
                                                     sfBlendFactorOne, sfBlendFactorZero, sfBlendEquationAdd);
}
else {
    enum sfBlendMode {
        sfBlendAlpha,
        sfBlendAdd,
        sfBlendMultiply,
        sfBlendNone,
    }
    mixin(expandEnum!sfBlendMode);
}

// Graphics/Color.h
struct sfColor {
    sfUint8 r;
    sfUint8 g;
    sfUint8 b;
    sfUint8 a;
}

immutable(sfColor) sfBlack = sfColor(0, 0, 0, 255);
immutable(sfColor) sfWhite = sfColor(255, 255, 255, 255);
immutable(sfColor) sfRed = sfColor(255, 0, 0, 255);
immutable(sfColor) sfGreen = sfColor(0, 255, 0, 255);
immutable(sfColor) sfBlue = sfColor(0, 0, 255, 255);
immutable(sfColor) sfYellow = sfColor(255, 255, 0, 255);
immutable(sfColor) sfMagenta = sfColor(255, 0, 255, 255);
immutable(sfColor) sfCyan = sfColor(0, 255, 255, 255);
immutable(sfColor) sfTransparent = sfColor(0, 0, 0, 0);

static if(sfmlSupport >= SFMLSupport.sfml220) {
    // Graphics/FontInfo.h
    struct sfFontInfo {
        const(char)* family;
    }
}

// Graphics/Glsl.h
alias sfGlslVec2 = sfVector2f;
alias sfGlslIvec2 = sfVector2i;

struct sfGlslBvec2 {
    sfBool x;
    sfBool y;
}

alias sfGlslVec3 = sfVector3f;

struct sfGlslIvec3 {
    int x;
    int y;
    int z;
}

struct sfGlslBvec3 {
    sfBool x;
    sfBool y;
    sfBool z;
}

struct sfGlslVec4 {
    float x;
    float y;
    float z;
    float w;
}

struct sfGlslIvec4 {
    int x;
    int y;
    int z;
    int w;
}

struct sfGlslBvec4 {
    sfBool x;
    sfBool y;
    sfBool z;
    sfBool w;
}

struct sfGlslMat3 {
    float* array;
}

struct sfGlslMat4 {
    float* array;
}

// Graphics/Glyph.h
static if(sfmlSupport >= SFMLSupport.sfml220) {
    struct sfGlyph {
        float advance;
        sfFloatRect bounds;
        sfIntRect textureRect;
    }
}
else {
    struct sfGlyph {
        int advance;
        sfIntRect bounds;
        sfIntRect textureRect;
    }
}

// Graphics/PrimitiveType
enum sfPrimitiveType {
    sfPoints,
    sfLines,
    sfLineStrip,
    sfTriangles,
    sfTriangleStrip,
    sfTriangleFan,
    sfQuads,

    sfLinesStrip = sfLineStrip,
    sfTrianglesStrip = sfTriangleStrip,
    sfTrianglesFan = sfTriangleFan,
}
mixin(expandEnum!sfPrimitiveType);

// Graphics/Rect.h
struct sfFloatRect {
    float left;
    float top;
    float width;
    float height;
}

struct sfIntRect {
    int left;
    int top;
    int width;
    int height;
}

// Graphics/RenderStates.h
struct sfRenderStates {
    sfBlendMode blendMode;
    sfTransform transform;
    const(sfTexture)* texture;
    const(sfShader)* shader;
}

// Graphics/Text.h
static if(sfmlSupport >= SFMLSupport.sfml220) {
    enum sfTextStyle {
        sfTextRegular = 0,
        sfTextBold = 1 << 0,
        sfTextItalic = 1 << 1,
        sfTextUnderlined = 1 << 2,
        sfTextStrikeThrough = 1 << 3
    }
}
else {
    enum sfTextStyle {
        sfTextRegular = 0,
        sfTextBold = 1 << 0,
        sfTextItalic = 1 << 1,
        sfTextUnderlined = 1 << 2,
    }
}
mixin(expandEnum!sfTextStyle);

// Graphics/Shape.h
extern(C) nothrow {
    static if(sfmlSupport >= SFMLSupport.sfml230) {
        alias sfShapeGetPointCountCallback = size_t function(void*);
        alias sfShapeGetPointCallback = sfVector2f function(size_t, void*);
    }
    else {
        alias sfShapeGetPointCountCallback = uint function(void*);
        alias sfShapeGetPointCallback = sfVector2f function(uint, void*);
    }
}

// Graphics/Transform
struct sfTransform {
    float[9] matrix;
};

const(sfTransform) sfTransform_Identity = sfTransform(
    [1.0f, 0.0f, 0.0f,
    0.0f, 1.0f, 0.0f,
    0.0f, 0.0f, 1.0f]
);

// Graphics/Vertex.h
struct sfVertex {
    sfVector2f position;
    sfColor color;
    sfVector2f texCoords;
}

static if(sfmlSupport >= SFMLSupport.sfml250) {
    // Graphics/VertexBuffer.h
    enum sfVertexBufferUsage {
        sfVertexBufferStream,
        sfVertexBufferDynamic,
        sfVertexBufferStatic
    }
    mixin(expandEnum!sfVertexBufferUsage);
}

static if(staticSFML) {
    extern(C) @nogc nothrow {
        // Graphics/CircleShape.h
        sfCircleShape* sfCircleShape_create();
        sfCircleShape* sfCircleShape_copy(const(sfCircleShape)* shape);
        void sfCircleShape_destroy(sfCircleShape* shape);
        void sfCircleShape_setPosition(sfCircleShape* shape, sfVector2f position);
        void sfCircleShape_setRotation(sfCircleShape* shape, float angle);
        void sfCircleShape_setScale(sfCircleShape* shape, sfVector2f scale);
        void sfCircleShape_setOrigin(sfCircleShape* shape, sfVector2f origin);
        sfVector2f sfCircleShape_getPosition(const(sfCircleShape)* shape);
        float sfCircleShape_getRotation(const(sfCircleShape)* shape);
        sfVector2f sfCircleShape_getScale(const(sfCircleShape)* shape);
        sfVector2f sfCircleShape_getOrigin(const(sfCircleShape)* shape);
        void sfCircleShape_move(sfCircleShape* shape, sfVector2f offset);
        void sfCircleShape_rotate(sfCircleShape* shape, float angle);
        void sfCircleShape_scale(sfCircleShape* shape, sfVector2f factors);
        sfTransform sfCircleShape_getTransform(const(sfCircleShape)* shape);
        sfTransform sfCircleShape_getInverseTransform(const(sfCircleShape)* shape);
        void sfCircleShape_setTexture(sfCircleShape* shape, const(sfTexture)* texture, sfBool resetRect);
        void sfCircleShape_setTextureRect(sfCircleShape* shape, sfIntRect rect);
        void sfCircleShape_setFillColor(sfCircleShape* shape, sfColor color);
        void sfCircleShape_setOutlineColor(sfCircleShape* shape, sfColor color);
        void sfCircleShape_setOutlineThickness(sfCircleShape* shape, float thickness);
        const(sfTexture)* sfCircleShape_getTexture(const(sfCircleShape)* shape);
        sfIntRect sfCircleShape_getTextureRect(const(sfCircleShape)* shape);
        sfColor sfCircleShape_getFillColor(const(sfCircleShape)* shape);
        sfColor sfCircleShape_getOutlineColor(const(sfCircleShape)* shape);
        float sfCircleShape_getOutlineThickness(const(sfCircleShape)* shape);
        void sfCircleShape_setRadius(sfCircleShape* shape, float radius);
        float sfCircleShape_getRadius(const(sfCircleShape)* shape);
        void sfCircleShape_setPointCount(sfCircleShape* shape, uint count);
        sfFloatRect sfCircleShape_getLocalBounds(const(sfCircleShape)* shape);
        sfFloatRect sfCircleShape_getGlobalBounds(const(sfCircleShape)* shape);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            size_t sfCircleShape_getPointCount(const(sfCircleShape)* shape);
            sfVector2f sfCircleShape_getPoint(const(sfCircleShape)* shape, size_t index);
            void sfCircleShape_setPointCount(sfCircleShape* shape, size_t count);
        }
        else {
            uint sfCircleShape_getPointCount(const(sfCircleShape)* shape);
            sfVector2f sfCircleShape_getPoint(const(sfCircleShape)* shape, uint index);
            void sfCircleShape_setPointCount(sfCircleShape* shape, uint count);
        }

        // Graphics/Color.h
        sfColor sfColor_fromRGB(sfUint8 red, sfUint8 green, sfUint8 blue);
        sfColor sfColor_fromRGBA(sfUint8 red, sfUint8 green, sfUint8 blue, sfUint8 alpha);
        sfColor sfColor_add(sfColor color1, sfColor color2);
        sfColor sfColor_modulate(sfColor color1, sfColor color2);

        // Graphics/ConvexShape.h
        sfConvexShape* sfConvexShape_create();
        sfConvexShape* sfConvexShape_copy(const(sfConvexShape)* shape);
        void sfConvexShape_destroy(sfConvexShape* shape);
        void sfConvexShape_setPosition(sfConvexShape* shape, sfVector2f position);
        void sfConvexShape_setRotation(sfConvexShape* shape, float angle);
        void sfConvexShape_setScale(sfConvexShape* shape, sfVector2f scale);
        void sfConvexShape_setOrigin(sfConvexShape* shape, sfVector2f origin);
        sfVector2f sfConvexShape_getPosition(const(sfConvexShape)* shape);
        float sfConvexShape_getRotation(const(sfConvexShape)* shape);
        sfVector2f sfConvexShape_getScale(const(sfConvexShape)* shape);
        sfVector2f sfConvexShape_getOrigin(const(sfConvexShape)* shape);
        void sfConvexShape_move(sfConvexShape* shape, sfVector2f offset);
        void sfConvexShape_rotate(sfConvexShape* shape, float angle);
        void sfConvexShape_scale(sfConvexShape* shape, sfVector2f factors);
        sfTransform sfConvexShape_getTransform(const(sfConvexShape)* shape);
        sfTransform sfConvexShape_getInverseTransform(const(sfConvexShape)* shape);
        void sfConvexShape_setTexture(sfConvexShape* shape, const(sfTexture)* texture, sfBool resetRect);
        void sfConvexShape_setTextureRect(sfConvexShape* shape, sfIntRect rect);
        void sfConvexShape_setFillColor(sfConvexShape* shape, sfColor color);
        void sfConvexShape_setOutlineColor(sfConvexShape* shape, sfColor color);
        void sfConvexShape_setOutlineThickness(sfConvexShape* shape, float thickness);
        const(sfTexture)* sfConvexShape_getTexture(const(sfConvexShape)* shape);
        sfIntRect sfConvexShape_getTextureRect(const(sfConvexShape)* shape);
        sfColor sfConvexShape_getFillColor(const(sfConvexShape)* shape);
        sfColor sfConvexShape_getOutlineColor(const(sfConvexShape)* shape);
        float sfConvexShape_getOutlineThickness(const(sfConvexShape)* shape);
        sfFloatRect sfConvexShape_getLocalBounds(const(sfConvexShape)* shape);
        sfFloatRect sfConvexShape_getGlobalBounds(const(sfConvexShape)* shape);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            size_t sfConvexShape_getPointCount(const(sfConvexShape)* shape);
            sfVector2f sfConvexShape_getPoint(const(sfConvexShape)* shape, size_t index);
            void sfConvexShape_setPointCount(sfConvexShape* shape, size_t count);
            void sfConvexShape_setPoint(sfConvexShape* shape, size_t index, sfVector2f point);
        }
        else {
            uint sfConvexShape_getPointCount(const(sfConvexShape)* shape);
            sfVector2f sfConvexShape_getPoint(const(sfConvexShape)* shape, uint index);
            void sfConvexShape_setPointCount(sfConvexShape* shape, uint count);
            void sfConvexShape_setPoint(sfConvexShape* shape, uint index, sfVector2f point);
        }

        // Graphics/Font.h
        sfFont* sfFont_createFromFile(const(char)* filename);
        sfFont* sfFont_createFromMemory(const(void)* data, size_t sizeInBytes);
        sfFont* sfFont_createFromStream(sfInputStream* stream);
        sfFont* sfFont_copy(const(sfFont)* font);
        void sfFont_destroy(sfFont* font);
        const(sfTexture)* sfFont_getTexture(sfFont* font, uint characterSize);

        static if(sfmlSupport >= SFMLSupport.sfml220) {
            float sfFont_getKerning(const(sfFont)* font, sfUint32 first, sfUint32 second, uint characterSize);
            float sfFont_getLineSpacing(const(sfFont)* font, uint characterSize);
        }
        else {
            int sfFont_getKerning(sfFont* font, sfUint32 first, sfUint32 second, uint characterSize);
            int sfFont_getLineSpacing(sfFont* font, uint characterSize);
        }
        static if(sfmlSupport >= SFMLSupport.sfml240) {
            sfGlyph sfFont_getGlyph(const(sfFont)* font, sfUint32 codePoint, uint characterSize, sfBool bold, float outlineThickness);
        }
        else sfGlyph sfFont_getGlyph(sfFont* font, sfUint32 codePoint, uint characterSize, sfBool bold);

        // Graphics/Image.h
        sfImage* sfImage_create(uint width, uint height);
        sfImage* sfImage_createFromColor(uint width, uint height, sfColor color);
        sfImage* sfImage_createFromPixels(uint width, uint height, const(sfUint8)* pixels);
        sfImage* sfImage_createFromFile(const(char)* filename);
        sfImage* sfImage_createFromMemory(const(void)* data, size_t size);
        sfImage* sfImage_createFromStream(sfInputStream* stream);
        sfImage* sfImage_copy(const(sfImage)* image);
        void sfImage_destroy(sfImage* image);
        sfBool sfImage_saveToFile(const(sfImage)* image, const(char)* filename);
        sfVector2u sfImage_getSize(const(sfImage)* image);
        void sfImage_createMaskFromColor(sfImage* image, sfColor color, sfUint8 alpha);
        void sfImage_copyImage(sfImage* image, const(sfImage)* source, uint destX, uint destY, sfIntRect sourceRect, sfBool applyAlpha);
        void sfImage_setPixel(sfImage* image, uint x, uint y, sfColor color);
        sfColor sfImage_getPixel(const(sfImage)* image, uint x, uint y);
        const(sfUint8)* sfImage_getPixelsPtr(const(sfImage)* image);
        void sfImage_flipHorizontally(sfImage* image);
        void sfImage_flipVertically(sfImage* image);

        // Graphics/Rect.h
        sfBool sfFloatRect_contains(const(sfFloatRect)* rect, float x, float y);
        sfBool sfIntRect_contains(const(sfIntRect)* rect, int x, int y);
        sfBool sfFloatRect_intersects(const(sfFloatRect)* rect1, const(sfFloatRect)* rect2, sfFloatRect* intersection);
        sfBool sfIntRect_intersects(const(sfIntRect)* rect1, const(sfIntRect)* rect2, sfIntRect* intersection);

        // Graphics/RectangleShape.h
        sfRectangleShape* sfRectangleShape_create();
        sfRectangleShape* sfRectangleShape_copy(const(sfRectangleShape)* shape);
        void sfRectangleShape_destroy(sfRectangleShape* shape);
        void sfRectangleShape_setPosition(sfRectangleShape* shape, sfVector2f position);
        void sfRectangleShape_setRotation(sfRectangleShape* shape, float angle);
        void sfRectangleShape_setScale(sfRectangleShape* shape, sfVector2f scale);
        void sfRectangleShape_setOrigin(sfRectangleShape* shape, sfVector2f origin);
        sfVector2f sfRectangleShape_getPosition(const(sfRectangleShape)* shape);
        float sfRectangleShape_getRotation(const(sfRectangleShape)* shape);
        sfVector2f sfRectangleShape_getScale(const(sfRectangleShape)* shape);
        sfVector2f sfRectangleShape_getOrigin(const(sfRectangleShape)* shape);
        void sfRectangleShape_move(sfRectangleShape* shape, sfVector2f offset);
        void sfRectangleShape_rotate(sfRectangleShape* shape, float angle);
        void sfRectangleShape_scale(sfRectangleShape* shape, sfVector2f factors);
        sfTransform sfRectangleShape_getTransform(const(sfRectangleShape)* shape);
        sfTransform sfRectangleShape_getInverseTransform(const(sfRectangleShape)* shape);
        void sfRectangleShape_setTexture(sfRectangleShape* shape, const(sfTexture)* texture, sfBool resetRect);
        void sfRectangleShape_setTextureRect(sfRectangleShape* shape, sfIntRect rect);
        void sfRectangleShape_setFillColor(sfRectangleShape* shape, sfColor color);
        void sfRectangleShape_setOutlineColor(sfRectangleShape* shape, sfColor color);
        void sfRectangleShape_setOutlineThickness(sfRectangleShape* shape, float thickness);
        const(sfTexture)* sfRectangleShape_getTexture(const(sfRectangleShape)* shape);
        sfIntRect sfRectangleShape_getTextureRect(const(sfRectangleShape)* shape);
        sfColor sfRectangleShape_getFillColor(const(sfRectangleShape)* shape);
        sfColor sfRectangleShape_getOutlineColor(const(sfRectangleShape)* shape);
        float sfRectangleShape_getOutlineThickness(const(sfRectangleShape)* shape);
        void sfRectangleShape_setSize(sfRectangleShape* shape, sfVector2f size);
        sfVector2f sfRectangleShape_getSize(const(sfRectangleShape)* shape);
        sfFloatRect sfRectangleShape_getLocalBounds(const(sfRectangleShape)* shape);
        sfFloatRect sfRectangleShape_getGlobalBounds(const(sfRectangleShape)* shape);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            size_t sfRectangleShape_getPointCount(const(sfRectangleShape)* shape);
            sfVector2f sfRectangleShape_getPoint(const(sfRectangleShape)* shape, size_t index);
        }
        else {
            uint sfRectangleShape_getPointCount(const(sfRectangleShape)* shape);
            sfVector2f sfRectangleShape_getPoint(const(sfRectangleShape)* shape, uint index);
        }

        // Graphics/RenderTexture.h
        sfRenderTexture* sfRenderTexture_create(uint width, uint height, sfBool depthBuffer);
        void sfRenderTexture_destroy(sfRenderTexture* renderTexture);
        sfVector2u sfRenderTexture_getSize(const(sfRenderTexture)* renderTexture);
        sfBool sfRenderTexture_setActive(sfRenderTexture* renderTexture, sfBool active);
        void sfRenderTexture_display(sfRenderTexture* renderTexture);
        void sfRenderTexture_clear(sfRenderTexture* renderTexture, sfColor color);
        void sfRenderTexture_setView(sfRenderTexture* renderTexture, const(sfView)* view);
        const(sfView)* sfRenderTexture_getView(const(sfRenderTexture)* renderTexture);
        const(sfView)* sfRenderTexture_getDefaultView(const(sfRenderTexture)* renderTexture);
        sfIntRect sfRenderTexture_getViewport(const(sfRenderTexture)* renderTexture, const(sfView)* view);
        sfVector2f sfRenderTexture_mapPixelToCoords(const(sfRenderTexture)* renderTexture, sfVector2i point, const(sfView)* view);
        sfVector2i sfRenderTexture_mapCoordsToPixel(const(sfRenderTexture)* renderTexture, sfVector2f point, const(sfView)* view);
        void sfRenderTexture_drawSprite(sfRenderTexture* renderTexture, const(sfSprite)* object, const(sfRenderStates)* states);
        void sfRenderTexture_drawText(sfRenderTexture* renderTexture, const(sfText)* object, const(sfRenderStates)* states);
        void sfRenderTexture_drawShape(sfRenderTexture* renderTexture, const(sfShape)* object, const(sfRenderStates)* states);
        void sfRenderTexture_drawCircleShape(sfRenderTexture* renderTexture, const(sfCircleShape)* object, const(sfRenderStates)* states);
        void sfRenderTexture_drawConvexShape(sfRenderTexture* renderTexture, const(sfConvexShape)* object, const(sfRenderStates)* states);
        void sfRenderTexture_drawRectangleShape(sfRenderTexture* renderTexture, const(sfRectangleShape)* object, const(sfRenderStates)* states);
        void sfRenderTexture_drawVertexArray(sfRenderTexture* renderTexture, const(sfVertexArray)* object, const(sfRenderStates)* states);
        void sfRenderTexture_pushGLStates(sfRenderTexture* renderTexture);
        void sfRenderTexture_popGLStates(sfRenderTexture* renderTexture);
        void sfRenderTexture_resetGLStates(sfRenderTexture* renderTexture);
        const(sfTexture)* sfRenderTexture_getTexture(const(sfRenderTexture)* renderTexture);
        void sfRenderTexture_setSmooth(sfRenderTexture* renderTexture, sfBool smooth);
        sfBool sfRenderTexture_isSmooth(const(sfRenderTexture)* renderTexture);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            void sfRenderTexture_drawPrimitives(sfRenderTexture* renderTexture, const(sfVertex)* vertices, size_t vertexCount, sfPrimitiveType type, const(sfRenderStates)* states);
        }
        else void sfRenderTexture_drawPrimitives(sfRenderTexture* renderTexture, const(sfVertex)* vertices, uint vertexCount, sfPrimitiveType type, const(sfRenderStates)* states);

        // Graphics/RenderWindow.h
        sfRenderWindow* sfRenderWindow_create(sfVideoMode mode, const(char)* title, sfUint32 style, const(sfContextSettings)* settings);
        sfRenderWindow* sfRenderWindow_createUnicode(sfVideoMode mode, const(sfUint32)* title, sfUint32 style, const(sfContextSettings)* settings);
        sfRenderWindow* sfRenderWindow_createFromHandle(sfWindowHandle handle, const(sfContextSettings)* settings);
        void sfRenderWindow_destroy(sfRenderWindow* window);
        void sfRenderWindow_close(sfRenderWindow* window);
        sfBool sfRenderWindow_isOpen(const(sfRenderWindow)* window);
        sfContextSettings sfRenderWindow_getSettings(const(sfRenderWindow)* window);
        sfBool sfRenderWindow_pollEvent(sfRenderWindow* window, sfEvent* event);
        sfBool sfRenderWindow_waitEvent(sfRenderWindow* window, sfEvent* event);
        sfVector2i sfRenderWindow_getPosition(const(sfRenderWindow)* window);
        void sfRenderWindow_setPosition(sfRenderWindow* window, sfVector2i position);
        sfVector2u sfRenderWindow_getSize(const(sfRenderWindow)* window);
        void sfRenderWindow_setSize(sfRenderWindow* window, sfVector2u size);
        void sfRenderWindow_setTitle(sfRenderWindow* window, const(char)* title);
        void sfRenderWindow_setUnicodeTitle(sfRenderWindow* window, const(sfUint32)* title);
        void sfRenderWindow_setIcon(sfRenderWindow* window, uint width, uint height, const(sfUint8)* pixels);
        void sfRenderWindow_setVisible(sfRenderWindow* window, sfBool visible);
        void sfRenderWindow_setMouseCursorVisible(sfRenderWindow* window, sfBool visible);
        void sfRenderWindow_setVerticalSyncEnabled(sfRenderWindow* window, sfBool enabled);
        void sfRenderWindow_setKeyRepeatEnabled(sfRenderWindow* window, sfBool enabled);
        sfBool sfRenderWindow_setActive(sfRenderWindow* window, sfBool active);
        void sfRenderWindow_display(sfRenderWindow* window);
        void sfRenderWindow_setFramerateLimit(sfRenderWindow* window, uint limit);
        void sfRenderWindow_setJoystickThreshold(sfRenderWindow* window, float threshold);
        sfWindowHandle sfRenderWindow_getSystemHandle(const(sfRenderWindow)* window);
        void sfRenderWindow_clear(sfRenderWindow* renderWindow, sfColor color);
        void sfRenderWindow_setView(sfRenderWindow* renderWindow, const(sfView)* view);
        const(sfView)* sfRenderWindow_getView(const(sfRenderWindow)* renderWindow);
        const(sfView)* sfRenderWindow_getDefaultView(const(sfRenderWindow)* renderWindow);
        sfIntRect sfRenderWindow_getViewport(const(sfRenderWindow)* renderWindow, const(sfView)* view);
        sfVector2f sfRenderWindow_mapPixelToCoords(const(sfRenderWindow)* renderWindow, sfVector2i point, const(sfView)* view);
        sfVector2i sfRenderWindow_mapCoordsToPixel(const(sfRenderWindow)* renderWindow, sfVector2f point, const(sfView)* view);
        void sfRenderWindow_drawSprite(sfRenderWindow* renderWindow, const(sfSprite)* object, const(sfRenderStates)* states);
        void sfRenderWindow_drawText(sfRenderWindow* renderWindow, const(sfText)* object, const(sfRenderStates)* states);
        void sfRenderWindow_drawShape(sfRenderWindow* renderWindow, const(sfShape)* object, const(sfRenderStates)* states);
        void sfRenderWindow_drawCircleShape(sfRenderWindow* renderWindow, const(sfCircleShape)* object, const(sfRenderStates)* states);
        void sfRenderWindow_drawConvexShape(sfRenderWindow* renderWindow, const(sfConvexShape)* object, const(sfRenderStates)* states);
        void sfRenderWindow_drawRectangleShape(sfRenderWindow* renderWindow, const(sfRectangleShape)* object, const(sfRenderStates)* states);
        void sfRenderWindow_drawVertexArray(sfRenderWindow* renderWindow, const(sfVertexArray)* object, const(sfRenderStates)* states);
        void sfRenderWindow_pushGLStates(sfRenderWindow* renderWindow);
        void sfRenderWindow_popGLStates(sfRenderWindow* renderWindow);
        void sfRenderWindow_resetGLStates(sfRenderWindow* renderWindow);
        sfImage* sfRenderWindow_capture(const(sfRenderWindow)* renderWindow);
        sfVector2i sfMouse_getPositionRenderWindow(const(sfRenderWindow)* relativeTo);
        void sfMouse_setPositionRenderWindow(sfVector2i position, const(sfRenderWindow)* relativeTo);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            void sfRenderWindow_drawPrimitives(sfRenderWindow* renderWindow, const(sfVertex)* vertices, size_t vertexCount, sfPrimitiveType type, const(sfRenderStates)* states);
        }
        else void sfRenderWindow_drawPrimitives(sfRenderWindow* renderWindow, const(sfVertex)* vertices, uint vertexCount, sfPrimitiveType type, const(sfRenderStates)* states);
        // Graphics/Shader.h
        sfShader* sfShader_createFromFile(const(char)* vertexShaderFilename, const(char)* fragmentShaderFilename);
        sfShader* sfShader_createFromMemory(const(char)* vertexShader, const(char)* fragmentShader);
        void sfShader_destroy(sfShader* shader);
        void sfShader_setFloatParameter(sfShader* shader, const(char)* name, float x);
        void sfShader_setFloat2Parameter(sfShader* shader, const(char)* name, float x, float y);
        void sfShader_setFloat3Parameter(sfShader* shader, const(char)* name, float x, float y, float z);
        void sfShader_setFloat4Parameter(sfShader* shader, const(char)* name, float x, float y, float z, float w);
        void sfShader_setVector2Parameter(sfShader* shader, const(char)* name, sfVector2f vector);
        void sfShader_setVector3Parameter(sfShader* shader, const(char)* name, sfVector3f vector);
        void sfShader_setColorParameter(sfShader* shader, const(char)* name, sfColor color);
        void sfShader_setTransformParameter(sfShader* shader, const(char)* name, sfTransform transform);
        void sfShader_setTextureParameter(sfShader* shader, const(char)* name, const(sfTexture)* texture);
        void sfShader_setCurrentTextureParameter(sfShader* shader, const(char)* name);
        void sfShader_bind(const(sfShader)* shader);
        sfBool sfShader_isAvailable();

        static if(sfmlSupport >= SFMLSupport.sfml240) {
            sfShader* sfShader_createFromStream(sfInputStream* vertexShaderStream, sfInputStream* geometryShaderStream, sfInputStream* fragmentShaderStream);
        }
        else {
            sfShader* sfShader_createFromStream(sfInputStream* vertexShaderStream, sfInputStream* fragmentShaderStream);
        }

        // Graphics/Shape.h
        sfShape* sfShape_create(sfShapeGetPointCountCallback getPointCount, sfShapeGetPointCallback getPoint, void* userData);
        void sfShape_destroy(sfShape* shape);
        void sfShape_setPosition(sfShape* shape, sfVector2f position);
        void sfShape_setRotation(sfShape* shape, float angle);
        void sfShape_setScale(sfShape* shape, sfVector2f scale);
        void sfShape_setOrigin(sfShape* shape, sfVector2f origin);
        sfVector2f sfShape_getPosition(const(sfShape)* shape);
        float sfShape_getRotation(const(sfShape)* shape);
        sfVector2f sfShape_getScale(const(sfShape)* shape);
        sfVector2f sfShape_getOrigin(const(sfShape)* shape);
        void sfShape_move(sfShape* shape, sfVector2f offset);
        void sfShape_rotate(sfShape* shape, float angle);
        void sfShape_scale(sfShape* shape, sfVector2f factors);
        sfTransform sfShape_getTransform(const(sfShape)* shape);
        sfTransform sfShape_getInverseTransform(const(sfShape)* shape);
        void sfShape_setTexture(sfShape* shape, const(sfTexture)* texture, sfBool resetRect);
        void sfShape_setTextureRect(sfShape* shape, sfIntRect rect);
        void sfShape_setFillColor(sfShape* shape, sfColor color);
        void sfShape_setOutlineColor(sfShape* shape, sfColor color);
        void sfShape_setOutlineThickness(sfShape* shape, float thickness);
        const(sfTexture)* sfShape_getTexture(const(sfShape)* shape);
        sfIntRect sfShape_getTextureRect(const(sfShape)* shape);
        sfColor sfShape_getFillColor(const(sfShape)* shape);
        sfColor sfShape_getOutlineColor(const(sfShape)* shape);
        float sfShape_getOutlineThickness(const(sfShape)* shape);
        sfFloatRect sfShape_getLocalBounds(const(sfShape)* shape);
        sfFloatRect sfShape_getGlobalBounds(const(sfShape)* shape);
        void sfShape_update(sfShape* shape);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            size_t sfShape_getPointCount(const(sfShape)* shape);
            sfVector2f sfShape_getPoint(const(sfShape)* shape, size_t index);
        }
        else {
            uint sfShape_getPointCount(const(sfShape)* shape);
            sfVector2f sfShape_getPoint(const(sfShape)* shape, uint index);
        }

        // Graphics/Sprite.h
        sfSprite* sfSprite_create();
        sfSprite* sfSprite_copy(const(sfSprite)* sprite);
        void sfSprite_destroy(sfSprite* sprite);
        void sfSprite_setPosition(sfSprite* sprite, sfVector2f position);
        void sfSprite_setRotation(sfSprite* sprite, float angle);
        void sfSprite_setScale(sfSprite* sprite, sfVector2f scale);
        void sfSprite_setOrigin(sfSprite* sprite, sfVector2f origin);
        sfVector2f sfSprite_getPosition(const(sfSprite)* sprite);
        float sfSprite_getRotation(const(sfSprite)* sprite);
        sfVector2f sfSprite_getScale(const(sfSprite)* sprite);
        sfVector2f sfSprite_getOrigin(const(sfSprite)* sprite);
        void sfSprite_move(sfSprite* sprite, sfVector2f offset);
        void sfSprite_rotate(sfSprite* sprite, float angle);
        void sfSprite_scale(sfSprite* sprite, sfVector2f factors);
        sfTransform sfSprite_getTransform(const(sfSprite)* sprite);
        sfTransform sfSprite_getInverseTransform(const(sfSprite)* sprite);
        void sfSprite_setTexture(sfSprite* sprite, const(sfTexture)* texture, sfBool resetRect);
        void sfSprite_setTextureRect(sfSprite* sprite, sfIntRect rectangle);
        void sfSprite_setColor(sfSprite* sprite, sfColor color);
        const(sfTexture)* sfSprite_getTexture(const(sfSprite)* sprite);
        sfIntRect sfSprite_getTextureRect(const(sfSprite)* sprite);
        sfColor sfSprite_getColor(const(sfSprite)* sprite);
        sfFloatRect sfSprite_getLocalBounds(const(sfSprite)* sprite);
        sfFloatRect sfSprite_getGlobalBounds(const(sfSprite)* sprite);

        // Graphics/Text.h
        sfText* sfText_create();
        sfText* sfText_copy(const(sfText)* text);
        void sfText_destroy(sfText* text);
        void sfText_setPosition(sfText* text, sfVector2f position);
        void sfText_setRotation(sfText* text, float angle);
        void sfText_setScale(sfText* text, sfVector2f scale);
        void sfText_setOrigin(sfText* text, sfVector2f origin);
        sfVector2f sfText_getPosition(const(sfText)* text);
        float sfText_getRotation(const(sfText)* text);
        sfVector2f sfText_getScale(const(sfText)* text);
        sfVector2f sfText_getOrigin(const(sfText)* text);
        void sfText_move(sfText* text, sfVector2f offset);
        void sfText_rotate(sfText* text, float angle);
        void sfText_scale(sfText* text, sfVector2f factors);
        sfTransform sfText_getTransform(const(sfText)* text);
        sfTransform sfText_getInverseTransform(const(sfText)* text);
        void sfText_setString(sfText* text, const(char)* string);
        void sfText_setUnicodeString(sfText* text, const(sfUint32)* string);
        void sfText_setFont(sfText* text, const(sfFont)* font);
        void sfText_setCharacterSize(sfText* text, uint size);
        void sfText_setStyle(sfText* text, sfUint32 style);
        void sfText_setColor(sfText* text, sfColor color);
        const(char)* sfText_getString(const(sfText)* text);
        const(sfUint32)* sfText_getUnicodeString(const(sfText)* text);
        const(sfFont)* sfText_getFont(const(sfText)* text);
        uint sfText_getCharacterSize(const(sfText)* text);
        sfUint32 sfText_getStyle(const(sfText)* text);
        sfColor sfText_getColor(const(sfText)* text);
        sfVector2f sfText_findCharacterPos(const(sfText)* text, size_t index);
        sfFloatRect sfText_getLocalBounds(const(sfText)* text);
        sfFloatRect sfText_getGlobalBounds(const(sfText)* text);

        // Graphics/Texture.h
        sfTexture* sfTexture_create(uint width, uint height);
        sfTexture* sfTexture_createFromFile(const(char)* filename, const(sfIntRect)* area);
        sfTexture* sfTexture_createFromMemory(const(void)* data, size_t sizeInBytes, const(sfIntRect)* area);
        sfTexture* sfTexture_createFromStream(sfInputStream* stream, const(sfIntRect)* area);
        sfTexture* sfTexture_createFromImage(const(sfImage)* image, const(sfIntRect)* area);
        sfTexture* sfTexture_copy(const(sfTexture)* texture);
        void sfTexture_destroy(sfTexture* texture);
        sfVector2u sfTexture_getSize(const(sfTexture)* texture);
        sfImage* sfTexture_copyToImage(const(sfTexture)* texture);
        void sfTexture_updateFromPixels(sfTexture* texture, const(sfUint8)* pixels, uint width, uint height, uint x, uint y);
        void sfTexture_updateFromImage(sfTexture* texture, const(sfImage)* image, uint x, uint y);
        void sfTexture_updateFromWindow(sfTexture* texture, const(sfWindow)* window, uint x, uint y);
        void sfTexture_updateFromRenderWindow(sfTexture* texture, const(sfRenderWindow)* renderWindow, uint x, uint y);
        sfBool sfTexture_isSmooth(const(sfTexture)* texture);
        void sfTexture_setSmooth(sfTexture* texture, sfBool smooth);
        void sfTexture_setRepeated(sfTexture* texture, sfBool repeated);
        sfBool sfTexture_isRepeated(const(sfTexture)* texture);
        void sfTexture_bind(const(sfTexture)* texture);
        uint sfTexture_getMaximumSize();

        // Graphics/Transform.h
        sfTransform sfTransform_fromMatrix(float a00, float a01, float a02, float a10, float a11, float a12, float a20, float a21, float a22);
        void sfTransform_getMatrix(const(sfTransform)* transform, float* matrix);
        sfTransform sfTransform_getInverse(const(sfTransform)* transform);
        sfVector2f sfTransform_transformPoint(const(sfTransform)* transform, sfVector2f point);
        sfFloatRect sfTransform_transformRect(const(sfTransform)* transform, sfFloatRect rectangle);
        void sfTransform_combine(sfTransform* transform, const(sfTransform)* other);
        void sfTransform_translate(sfTransform* transform, float x, float y);
        void sfTransform_rotate(sfTransform* transform, float angle);
        void sfTransform_rotateWithCenter(sfTransform* transform, float angle, float centerX, float centerY);
        void sfTransform_scale(sfTransform* transform, float scaleX, float scaleY);
        void sfTransform_scaleWithCenter(sfTransform* transform, float scaleX, float scaleY, float centerX, float centerY);

        // Graphics/Transformable.h
        sfTransformable* sfTransformable_create();
        sfTransformable* sfTransformable_copy(const(sfTransformable)* transformable);
        void sfTransformable_destroy(sfTransformable* transformable);
        void sfTransformable_setPosition(sfTransformable* transformable, sfVector2f position);
        void sfTransformable_setRotation(sfTransformable* transformable, float angle);
        void sfTransformable_setScale(sfTransformable* transformable, sfVector2f scale);
        void sfTransformable_setOrigin(sfTransformable* transformable, sfVector2f origin);
        sfVector2f sfTransformable_getPosition(const(sfTransformable)* transformable);
        float sfTransformable_getRotation(const(sfTransformable)* transformable);
        sfVector2f sfTransformable_getScale(const(sfTransformable)* transformable);
        sfVector2f sfTransformable_getOrigin(const(sfTransformable)* transformable);
        void sfTransformable_move(sfTransformable* transformable, sfVector2f offset);
        void sfTransformable_rotate(sfTransformable* transformable, float angle);
        void sfTransformable_scale(sfTransformable* transformable, sfVector2f factors);
        sfTransform sfTransformable_getTransform(const(sfTransformable)* transformable);
        sfTransform sfTransformable_getInverseTransform(const(sfTransformable)* transformable);

        // Graphics/VertexArray.h
        sfVertexArray* sfVertexArray_create();
        sfVertexArray* sfVertexArray_copy(const(sfVertexArray)* vertexArray);
        void sfVertexArray_destroy(sfVertexArray* vertexArray);
        void sfVertexArray_clear(sfVertexArray* vertexArray);
        void sfVertexArray_append(sfVertexArray* vertexArray, sfVertex vertex);
        void sfVertexArray_setPrimitiveType(sfVertexArray* vertexArray, sfPrimitiveType type);
        sfPrimitiveType sfVertexArray_getPrimitiveType(sfVertexArray* vertexArray);
        sfFloatRect sfVertexArray_getBounds(sfVertexArray* vertexArray);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            size_t sfVertexArray_getVertexCount(const(sfVertexArray)* vertexArray);
            sfVertex* sfVertexArray_getVertex(sfVertexArray* vertexArray, size_t index);
            void sfVertexArray_resize(sfVertexArray* vertexArray, size_t vertexCount);
        }
        else {
            uint sfVertexArray_getVertexCount(const(sfVertexArray)* vertexArray);
            sfVertex* sfVertexArray_getVertex(sfVertexArray* vertexArray, uint index);
            void sfVertexArray_resize(sfVertexArray* vertexArray, uint vertexCount);
        }

        // Graphics/View.h
        sfView* sfView_create();
        sfView* sfView_createFromRect(sfFloatRect rectangle);
        sfView* sfView_copy(const(sfView)* view);
        void sfView_destroy(sfView* view);
        void sfView_setCenter(sfView* view, sfVector2f center);
        void sfView_setSize(sfView* view, sfVector2f size);
        void sfView_setRotation(sfView* view, float angle);
        void sfView_setViewport(sfView* view, sfFloatRect viewport);
        void sfView_reset(sfView* view, sfFloatRect rectangle);
        sfVector2f sfView_getCenter(const(sfView)* view);
        sfVector2f sfView_getSize(const(sfView)* view);
        float sfView_getRotation(const(sfView)* view);
        sfFloatRect sfView_getViewport(const(sfView)* view);
        void sfView_move(sfView* view, sfVector2f offset);
        void sfView_rotate(sfView* view, float angle);
        void sfView_zoom(sfView* view, float factor);

        static if(sfmlSupport >= SFMLSupport.sfml220) {
            // Graphics/Font.h
            float sfFont_getUnderlinePosition(const(sfFont)* font, uint characterSize);
            float sfFont_getUnderlineThickness(const(sfFont)* font, uint characterSize);
            sfFontInfo sfFont_getInfo(const(sfFont)* font);

            // Graphics/RenderWindow.h
            void sfRenderWindow_requestFocus(sfRenderWindow* renderWindow);
            sfBool sfRenderWindow_hasFocus(const(sfRenderWindow)* renderWindow);
            sfVector2i sfTouch_getPositionRenderWindow(uint finger, const(sfRenderWindow)* relativeTo);
        }
        static if(sfmlSupport >= SFMLSupport.sfml230) {
            // Graphics/Color.h
            sfColor sfColor_fromInteger(sfUint32 color);
            sfUint32 sfColor_toInteger(sfColor color);
            sfColor sfColor_subtract(sfColor color1, sfColor color2);

            // Graphics/Shader.h
            uint sfShader_getNativeHandle(const(sfShader)* shader);

            // Graphics/Texture.h
            uint sfTexture_getNativeHandle(const(sfTexture)* texture);
        }
        static if(sfmlSupport >= SFMLSupport.sfml240) {
            // Graphics/RenderTexture.h
            sfBool sfRenderTexture_generateMipmap(sfRenderTexture* renderTexture);

            // Graphics/RenderWindow.h
            void sfRenderWindow_setMouseCursorGrabbed(sfRenderWindow* renderWindow, sfBool grabbed);

            // Graphics/Shader.h
            void sfShader_setFloatUniform(sfShader* shader, const(char)* name, float x);
            void sfShader_setVec2Uniform(sfShader* shader, const(char)* name, sfGlslVec2 vector);
            void sfShader_setVec3Uniform(sfShader* shader, const(char)* name, sfGlslVec3 vector);
            void sfShader_setVec4Uniform(sfShader* shader, const(char)* name, sfGlslVec4 vector);
            void sfShader_setColorUniform(sfShader* shader, const(char)* name, sfColor color);
            void sfShader_setIntUniform(sfShader* shader, const(char)* name, int x);
            void sfShader_setIvec2Uniform(sfShader* shader, const(char)* name, sfGlslIvec2 vector);
            void sfShader_setIvec3Uniform(sfShader* shader, const(char)* name, sfGlslIvec3 vector);
            void sfShader_setIvec4Uniform(sfShader* shader, const(char)* name, sfGlslIvec4 vector);
            void sfShader_setIntColorUniform(sfShader* shader, const(char)* name, sfColor color);
            void sfShader_setBoolUniform(sfShader* shader, const(char)* name, sfBool x);
            void sfShader_setBvec2Uniform(sfShader* shader, const(char)* name, sfGlslBvec2 vector);
            void sfShader_setBvec3Uniform(sfShader* shader, const(char)* name, sfGlslBvec3 vector);
            void sfShader_setBvec4Uniform(sfShader* shader, const(char)* name, sfGlslBvec4 vector);
            void sfShader_setMat3Uniform(sfShader* shader, const(char)* name, const(sfGlslMat3)* matrix);
            void sfShader_setMat4Uniform(sfShader* shader, const(char)* name, const(sfGlslMat4)* matrix);
            void sfShader_setTextureUniform(sfShader* shader, const(char)* name, const(sfTexture)* texture);
            void sfShader_setCurrentTextureUniform(sfShader* shader, const(char)* name);
            void sfShader_setFloatUniformArray(sfShader* shader, const(char)* name, const(float)* scalarArray, size_t length);
            void sfShader_setVec2UniformArray(sfShader* shader, const(char)* name, const(sfGlslVec2)* vectorArray, size_t length);
            void sfShader_setVec3UniformArray(sfShader* shader, const(char)* name, const(sfGlslVec3)* vectorArray, size_t length);
            void sfShader_setVec4UniformArray(sfShader* shader, const(char)* name, const(sfGlslVec4)* vectorArray, size_t length);
            void sfShader_setMat3UniformArray(sfShader* shader, const(char)* name, const(sfGlslMat3)* matrixArray, size_t length);
            void sfShader_setMat4UniformArray(sfShader* shader, const(char)* name, const(sfGlslMat4)* matrixArray, size_t length);
            sfBool sfShader_isGeometryAvailable();

            // Graphics/Text.h
            void sfText_setFillColor(sfText* text, sfColor color);
            void sfText_setOutlineColor(sfText* text, sfColor color);
            void sfText_setOutlineThickness(sfText* text, float thickness);
            sfColor sfText_getFillColor(const(sfText)* text);
            sfColor sfText_getOutlineColor(const(sfText)* text);
            float sfText_getOutlineThickness(const(sfText)* text);

            // Graphics/Texture.h
            void sfTexture_setSrgb(sfTexture* texture, sfBool sRgb);
            sfBool sfTexture_isSrgb(const(sfTexture)* texture);
            sfBool sfTexture_generateMipmap(sfTexture* texture);
        }
        static if(sfmlSupport >= SFMLSupport.sfml250) {
            // Graphics/RenderTexture.h
            sfRenderTexture* sfRenderTexture_createWithSettings(uint width, uint height, sfContextSettings settings);
            void sfRenderTexture_drawVertexBuffer(sfRenderTexture* renderTexture, const(sfVertexBuffer)* object, const(sfRenderStates)* states);
            uint sfRenderTexture_getMaximumAntialiasingLevel();

            // Graphics/RenderWindow.h
            void sfRenderWindow_setMouseCursor(sfRenderWindow* window, const(sfCursor)* cursor);
            void sfRenderWindow_drawVertexBuffer(sfRenderWindow* renderWindow, const(sfVertexBuffer)* object, const(sfRenderStates)* states);

            // Graphics/Text.h
            void sfText_setLineSpacing(sfText* text, float spacingFactor);
            void sfText_setLetterSpacing(sfText* text, float spacingFactor);
            float sfText_getLetterSpacing(const(sfText)* text);
            float sfText_getLineSpacing(const(sfText)* text);

            // Graphics/Texture.h
            void sfTexture_updateFromTexture(sfTexture* destination, const(sfTexture)* source, uint x, uint y);
            void sfTexture_swap(sfTexture* left, sfTexture* right);

            // Graphics/Transform.h
            sfBool sfTransform_equal(sfTransform* left, sfTransform* right);

            // Graphics/VertexBuffer.h
            sfVertexBuffer* sfVertexBuffer_create(uint vertexCount, sfPrimitiveType type, sfVertexBufferUsage usage);
            sfVertexBuffer* sfVertexBuffer_copy(const(sfVertexBuffer)* vertexBuffer);
            void sfVertexBuffer_destroy(sfVertexBuffer* vertexBuffer);
            uint sfVertexBuffer_getVertexCount(const(sfVertexBuffer)* vertexBuffer);
            sfBool sfVertexBuffer_update(sfVertexBuffer* vertexBuffer, const(sfVertex)* vertices, uint vertexCount, uint offset);
            sfBool sfVertexBuffer_updateFromVertexBuffer(sfVertexBuffer* vertexBuffer, const(sfVertexBuffer)* other);
            void sfVertexBuffer_swap(sfVertexBuffer* left, sfVertexBuffer* right);
            uint sfVertexBuffer_getNativeHandle(sfVertexBuffer* vertexBuffer);
            void sfVertexBuffer_setPrimitiveType(sfVertexBuffer* vertexBuffer, sfPrimitiveType type);
            sfPrimitiveType sfVertexBuffer_getPrimitiveType(const(sfVertexBuffer)* vertexBuffer);
            void sfVertexBuffer_setUsage(sfVertexBuffer* vertexBuffer, sfVertexBufferUsage usage);
            sfVertexBufferUsage sfVertexBuffer_getUsage(const(sfVertexBuffer)* vertexBuffer);
            void sfVertexBuffer_bind(const(sfVertexBuffer)* vertexBuffer);
            sfBool sfVertexBuffer_isAvailable();
        }
    }
}
else {
    import bindbc.loader;

    extern(C) @nogc nothrow {
        // Graphics/CircleShape.h
        alias psfCircleShape_create = sfCircleShape* function();
        alias psfCircleShape_copy = sfCircleShape* function(const(sfCircleShape)* shape);
        alias psfCircleShape_destroy = void function(sfCircleShape* shape);
        alias psfCircleShape_setPosition = void function(sfCircleShape* shape, sfVector2f position);
        alias psfCircleShape_setRotation = void function(sfCircleShape* shape, float angle);
        alias psfCircleShape_setScale = void function(sfCircleShape* shape, sfVector2f scale);
        alias psfCircleShape_setOrigin = void function(sfCircleShape* shape, sfVector2f origin);
        alias psfCircleShape_getPosition = sfVector2f function(const(sfCircleShape)* shape);
        alias psfCircleShape_getRotation = float function(const(sfCircleShape)* shape);
        alias psfCircleShape_getScale = sfVector2f function(const(sfCircleShape)* shape);
        alias psfCircleShape_getOrigin = sfVector2f function(const(sfCircleShape)* shape);
        alias psfCircleShape_move = void function(sfCircleShape* shape, sfVector2f offset);
        alias psfCircleShape_rotate = void function(sfCircleShape* shape, float angle);
        alias psfCircleShape_scale = void function(sfCircleShape* shape, sfVector2f factors);
        alias psfCircleShape_getTransform = sfTransform function(const(sfCircleShape)* shape);
        alias psfCircleShape_getInverseTransform = sfTransform function(const(sfCircleShape)* shape);
        alias psfCircleShape_setTexture = void function(sfCircleShape* shape, const(sfTexture)* texture, sfBool resetRect);
        alias psfCircleShape_setTextureRect = void function(sfCircleShape* shape, sfIntRect rect);
        alias psfCircleShape_setFillColor = void function(sfCircleShape* shape, sfColor color);
        alias psfCircleShape_setOutlineColor = void function(sfCircleShape* shape, sfColor color);
        alias psfCircleShape_setOutlineThickness = void function(sfCircleShape* shape, float thickness);
        alias psfCircleShape_getTexture = const(sfTexture)* function(const(sfCircleShape)* shape);
        alias psfCircleShape_getTextureRect = sfIntRect function(const(sfCircleShape)* shape);
        alias psfCircleShape_getFillColor = sfColor function(const(sfCircleShape)* shape);
        alias psfCircleShape_getOutlineColor = sfColor function(const(sfCircleShape)* shape);
        alias psfCircleShape_getOutlineThickness = float function(const(sfCircleShape)* shape);
        alias psfCircleShape_setRadius = void function(sfCircleShape* shape, float radius);
        alias psfCircleShape_getRadius = float function(const(sfCircleShape)* shape);

        alias psfCircleShape_getLocalBounds = sfFloatRect function(const(sfCircleShape)* shape);
        alias psfCircleShape_getGlobalBounds = sfFloatRect function(const(sfCircleShape)* shape);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            alias psfCircleShape_getPointCount = size_t function(const(sfCircleShape)* shape);
            alias psfCircleShape_getPoint = sfVector2f function(const(sfCircleShape)* shape, size_t index);
            alias psfCircleShape_setPointCount = void function(sfCircleShape* shape, size_t count);
        }
        else {
            alias psfCircleShape_getPointCount = uint function(const(sfCircleShape)* shape);
            alias psfCircleShape_getPoint = sfVector2f function(const(sfCircleShape)* shape, uint index);
            alias psfCircleShape_setPointCount = void function(sfCircleShape* shape, uint count);
        }

        // Graphics/Color.h
        alias psfColor_fromRGB = sfColor function(sfUint8 red, sfUint8 green, sfUint8 blue);
        alias psfColor_fromRGBA = sfColor function(sfUint8 red, sfUint8 green, sfUint8 blue, sfUint8 alpha);
        alias psfColor_add = sfColor function(sfColor color1, sfColor color2);
        alias psfColor_modulate = sfColor function(sfColor color1, sfColor color2);

        // Graphics/ConvexShape.h
        alias psfConvexShape_create = sfConvexShape* function();
        alias psfConvexShape_copy = sfConvexShape* function(const(sfConvexShape)* shape);
        alias psfConvexShape_destroy = void function(sfConvexShape* shape);
        alias psfConvexShape_setPosition = void function(sfConvexShape* shape, sfVector2f position);
        alias psfConvexShape_setRotation = void function(sfConvexShape* shape, float angle);
        alias psfConvexShape_setScale = void function(sfConvexShape* shape, sfVector2f scale);
        alias psfConvexShape_setOrigin = void function(sfConvexShape* shape, sfVector2f origin);
        alias psfConvexShape_getPosition = sfVector2f function(const(sfConvexShape)* shape);
        alias psfConvexShape_getRotation = float function(const(sfConvexShape)* shape);
        alias psfConvexShape_getScale = sfVector2f function(const(sfConvexShape)* shape);
        alias psfConvexShape_getOrigin = sfVector2f function(const(sfConvexShape)* shape);
        alias psfConvexShape_move = void function(sfConvexShape* shape, sfVector2f offset);
        alias psfConvexShape_rotate = void function(sfConvexShape* shape, float angle);
        alias psfConvexShape_scale = void function(sfConvexShape* shape, sfVector2f factors);
        alias psfConvexShape_getTransform = sfTransform function(const(sfConvexShape)* shape);
        alias psfConvexShape_getInverseTransform = sfTransform function(const(sfConvexShape)* shape);
        alias psfConvexShape_setTexture = void function(sfConvexShape* shape, const(sfTexture)* texture, sfBool resetRect);
        alias psfConvexShape_setTextureRect = void function(sfConvexShape* shape, sfIntRect rect);
        alias psfConvexShape_setFillColor = void function(sfConvexShape* shape, sfColor color);
        alias psfConvexShape_setOutlineColor = void function(sfConvexShape* shape, sfColor color);
        alias psfConvexShape_setOutlineThickness = void function(sfConvexShape* shape, float thickness);
        alias psfConvexShape_getTexture = const(sfTexture)* function(const(sfConvexShape)* shape);
        alias psfConvexShape_getTextureRect = sfIntRect function(const(sfConvexShape)* shape);
        alias psfConvexShape_getFillColor = sfColor function(const(sfConvexShape)* shape);
        alias psfConvexShape_getOutlineColor = sfColor function(const(sfConvexShape)* shape);
        alias psfConvexShape_getOutlineThickness = float function(const(sfConvexShape)* shape);
        alias psfConvexShape_getLocalBounds = sfFloatRect function(const(sfConvexShape)* shape);
        alias psfConvexShape_getGlobalBounds = sfFloatRect function(const(sfConvexShape)* shape);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            alias psfConvexShape_getPointCount = size_t function(const(sfConvexShape)* shape);
            alias psfConvexShape_getPoint = sfVector2f function(const(sfConvexShape)* shape, size_t index);
            alias psfConvexShape_setPointCount = void function(sfConvexShape* shape, size_t count);
            alias psfConvexShape_setPoint = void function(sfConvexShape* shape, size_t index, sfVector2f point);
        }
        else {
            alias psfConvexShape_getPointCount = uint function(const(sfConvexShape)* shape);
            alias psfConvexShape_getPoint = sfVector2f function(const(sfConvexShape)* shape, uint index);
            alias psfConvexShape_setPointCount = void function(sfConvexShape* shape, uint count);
            alias psfConvexShape_setPoint = void function(sfConvexShape* shape, uint index, sfVector2f point);
        }

        // Graphics/Font.h
        alias psfFont_createFromFile = sfFont* function(const(char)* filename);
        alias psfFont_createFromMemory = sfFont* function(const(void)* data, size_t sizeInBytes);
        alias psfFont_createFromStream = sfFont* function(sfInputStream* stream);
        alias psfFont_copy = sfFont* function(const(sfFont)* font);
        alias psfFont_destroy = void function(sfFont* font);
        alias psfFont_getTexture = const(sfTexture)* function(sfFont* font, uint characterSize);

        static if(sfmlSupport >= SFMLSupport.sfml220) {
            alias psfFont_getKerning = float function(const(sfFont)* font, sfUint32 first, sfUint32 second, uint characterSize);
            alias psfFont_getLineSpacing = float function(const(sfFont)* font, uint characterSize);
        }
        else {
            alias psfFont_getKerning = int function(sfFont* font, sfUint32 first, sfUint32 second, uint characterSize);
            alias psfFont_getLineSpacing = int function(sfFont* font, uint characterSize);
        }
        static if(sfmlSupport >= SFMLSupport.sfml240) {
            alias psfFont_getGlyph = sfGlyph function(const(sfFont)* font, sfUint32 codePoint, uint characterSize, sfBool bold, float outlineThickness);
        }
        else alias psfFont_getGlyph = sfGlyph function(sfFont* font, sfUint32 codePoint, uint characterSize, sfBool bold);

        // Graphics/Image.h
        alias psfImage_create = sfImage* function(uint width, uint height);
        alias psfImage_createFromColor = sfImage* function(uint width, uint height, sfColor color);
        alias psfImage_createFromPixels = sfImage* function(uint width, uint height, const(sfUint8)* pixels);
        alias psfImage_createFromFile = sfImage* function(const(char)* filename);
        alias psfImage_createFromMemory = sfImage* function(const(void)* data, size_t size);
        alias psfImage_createFromStream = sfImage* function(sfInputStream* stream);
        alias psfImage_copy = sfImage* function(const(sfImage)* image);
        alias psfImage_destroy = void function(sfImage* image);
        alias psfImage_saveToFile = sfBool function(const(sfImage)* image, const(char)* filename);
        alias psfImage_getSize = sfVector2u function(const(sfImage)* image);
        alias psfImage_createMaskFromColor = void function(sfImage* image, sfColor color, sfUint8 alpha);
        alias psfImage_copyImage = void function(sfImage* image, const(sfImage)* source, uint destX, uint destY, sfIntRect sourceRect, sfBool applyAlpha);
        alias psfImage_setPixel = void function(sfImage* image, uint x, uint y, sfColor color);
        alias psfImage_getPixel = sfColor function(const(sfImage)* image, uint x, uint y);
        alias psfImage_getPixelsPtr = const(sfUint8)* function(const(sfImage)* image);
        alias psfImage_flipHorizontally = void function(sfImage* image);
        alias psfImage_flipVertically = void function(sfImage* image);

        // Graphics/Rect.h
        alias psfFloatRect_contains = sfBool function(const(sfFloatRect)* rect, float x, float y);
        alias psfIntRect_contains = sfBool function(const(sfIntRect)* rect, int x, int y);
        alias psfFloatRect_intersects = sfBool function(const(sfFloatRect)* rect1, const(sfFloatRect)* rect2, sfFloatRect* intersection);
        alias psfIntRect_intersects = sfBool function(const(sfIntRect)* rect1, const(sfIntRect)* rect2, sfIntRect* intersection);

        // Graphics/RectangleShape.h
        alias psfRectangleShape_create = sfRectangleShape* function();
        alias psfRectangleShape_copy = sfRectangleShape* function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_destroy = void function(sfRectangleShape* shape);
        alias psfRectangleShape_setPosition = void function(sfRectangleShape* shape, sfVector2f position);
        alias psfRectangleShape_setRotation = void function(sfRectangleShape* shape, float angle);
        alias psfRectangleShape_setScale = void function(sfRectangleShape* shape, sfVector2f scale);
        alias psfRectangleShape_setOrigin = void function(sfRectangleShape* shape, sfVector2f origin);
        alias psfRectangleShape_getPosition = sfVector2f function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_getRotation = float function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_getScale = sfVector2f function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_getOrigin = sfVector2f function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_move = void function(sfRectangleShape* shape, sfVector2f offset);
        alias psfRectangleShape_rotate = void function(sfRectangleShape* shape, float angle);
        alias psfRectangleShape_scale = void function(sfRectangleShape* shape, sfVector2f factors);
        alias psfRectangleShape_getTransform = sfTransform function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_getInverseTransform = sfTransform function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_setTexture = void function(sfRectangleShape* shape, const(sfTexture)* texture, sfBool resetRect);
        alias psfRectangleShape_setTextureRect = void function(sfRectangleShape* shape, sfIntRect rect);
        alias psfRectangleShape_setFillColor = void function(sfRectangleShape* shape, sfColor color);
        alias psfRectangleShape_setOutlineColor = void function(sfRectangleShape* shape, sfColor color);
        alias psfRectangleShape_setOutlineThickness = void function(sfRectangleShape* shape, float thickness);
        alias psfRectangleShape_getTexture = const(sfTexture)* function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_getTextureRect = sfIntRect function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_getFillColor = sfColor function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_getOutlineColor = sfColor function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_getOutlineThickness = float function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_setSize = void function(sfRectangleShape* shape, sfVector2f size);
        alias psfRectangleShape_getSize = sfVector2f function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_getLocalBounds = sfFloatRect function(const(sfRectangleShape)* shape);
        alias psfRectangleShape_getGlobalBounds = sfFloatRect function(const(sfRectangleShape)* shape);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            alias psfRectangleShape_getPointCount = size_t function(const(sfRectangleShape)* shape);
            alias psfRectangleShape_getPoint = sfVector2f function(const(sfRectangleShape)* shape, size_t index);
        }
        else {
            alias psfRectangleShape_getPointCount = uint function(const(sfRectangleShape)* shape);
            alias psfRectangleShape_getPoint = sfVector2f function(const(sfRectangleShape)* shape, uint index);
        }

        // Graphics/RenderTexture.h
        alias psfRenderTexture_create = sfRenderTexture* function(uint width, uint height, sfBool depthBuffer);
        alias psfRenderTexture_destroy = void function(sfRenderTexture* renderTexture);
        alias psfRenderTexture_getSize = sfVector2u function(const(sfRenderTexture)* renderTexture);
        alias psfRenderTexture_setActive = sfBool function(sfRenderTexture* renderTexture, sfBool active);
        alias psfRenderTexture_display = void function(sfRenderTexture* renderTexture);
        alias psfRenderTexture_clear = void function(sfRenderTexture* renderTexture, sfColor color);
        alias psfRenderTexture_setView = void function(sfRenderTexture* renderTexture, const(sfView)* view);
        alias psfRenderTexture_getView = const(sfView)* function(const(sfRenderTexture)* renderTexture);
        alias psfRenderTexture_getDefaultView = const(sfView)* function(const(sfRenderTexture)* renderTexture);
        alias psfRenderTexture_getViewport = sfIntRect function(const(sfRenderTexture)* renderTexture, const(sfView)* view);
        alias psfRenderTexture_mapPixelToCoords = sfVector2f function(const(sfRenderTexture)* renderTexture, sfVector2i point, const(sfView)* view);
        alias psfRenderTexture_mapCoordsToPixel = sfVector2i function(const(sfRenderTexture)* renderTexture, sfVector2f point, const(sfView)* view);
        alias psfRenderTexture_drawSprite = void function(sfRenderTexture* renderTexture, const(sfSprite)* object, const(sfRenderStates)* states);
        alias psfRenderTexture_drawText = void function(sfRenderTexture* renderTexture, const(sfText)* object, const(sfRenderStates)* states);
        alias psfRenderTexture_drawShape = void function(sfRenderTexture* renderTexture, const(sfShape)* object, const(sfRenderStates)* states);
        alias psfRenderTexture_drawCircleShape = void function(sfRenderTexture* renderTexture, const(sfCircleShape)* object, const(sfRenderStates)* states);
        alias psfRenderTexture_drawConvexShape = void function(sfRenderTexture* renderTexture, const(sfConvexShape)* object, const(sfRenderStates)* states);
        alias psfRenderTexture_drawRectangleShape = void function(sfRenderTexture* renderTexture, const(sfRectangleShape)* object, const(sfRenderStates)* states);
        alias psfRenderTexture_drawVertexArray = void function(sfRenderTexture* renderTexture, const(sfVertexArray)* object, const(sfRenderStates)* states);
        alias psfRenderTexture_pushGLStates = void function(sfRenderTexture* renderTexture);
        alias psfRenderTexture_popGLStates = void function(sfRenderTexture* renderTexture);
        alias psfRenderTexture_resetGLStates = void function(sfRenderTexture* renderTexture);
        alias psfRenderTexture_getTexture = const(sfTexture)* function(const(sfRenderTexture)* renderTexture);
        alias psfRenderTexture_setSmooth = void function(sfRenderTexture* renderTexture, sfBool smooth);
        alias psfRenderTexture_isSmooth = sfBool function(const(sfRenderTexture)* renderTexture);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            alias psfRenderTexture_drawPrimitives = void function(sfRenderTexture* renderTexture, const(sfVertex)* vertices, size_t vertexCount, sfPrimitiveType type, const(sfRenderStates)* states);
        }
        else alias psfRenderTexture_drawPrimitives = void function(sfRenderTexture* renderTexture, const(sfVertex)* vertices, uint vertexCount, sfPrimitiveType type, const(sfRenderStates)* states);

        // Graphics/RenderWindow.h
        alias psfRenderWindow_create = sfRenderWindow* function(sfVideoMode mode, const(char)* title, sfUint32 style, const(sfContextSettings)* settings);
        alias psfRenderWindow_createUnicode = sfRenderWindow* function(sfVideoMode mode, const(sfUint32)* title, sfUint32 style, const(sfContextSettings)* settings);
        alias psfRenderWindow_createFromHandle = sfRenderWindow* function(sfWindowHandle handle, const(sfContextSettings)* settings);
        alias psfRenderWindow_destroy = void function(sfRenderWindow* window);
        alias psfRenderWindow_close = void function(sfRenderWindow* window);
        alias psfRenderWindow_isOpen = sfBool function(const(sfRenderWindow)* window);
        alias psfRenderWindow_getSettings = sfContextSettings function(const(sfRenderWindow)* window);
        alias psfRenderWindow_pollEvent = sfBool function(sfRenderWindow* window, sfEvent* event);
        alias psfRenderWindow_waitEvent = sfBool function(sfRenderWindow* window, sfEvent* event);
        alias psfRenderWindow_getPosition = sfVector2i function(const(sfRenderWindow)* window);
        alias psfRenderWindow_setPosition = void function(sfRenderWindow* window, sfVector2i position);
        alias psfRenderWindow_getSize = sfVector2u function(const(sfRenderWindow)* window);
        alias psfRenderWindow_setSize = void function(sfRenderWindow* window, sfVector2u size);
        alias psfRenderWindow_setTitle = void function(sfRenderWindow* window, const(char)* title);
        alias psfRenderWindow_setUnicodeTitle = void function(sfRenderWindow* window, const(sfUint32)* title);
        alias psfRenderWindow_setIcon = void function(sfRenderWindow* window, uint width, uint height, const(sfUint8)* pixels);
        alias psfRenderWindow_setVisible = void function(sfRenderWindow* window, sfBool visible);
        alias psfRenderWindow_setMouseCursorVisible = void function(sfRenderWindow* window, sfBool visible);
        alias psfRenderWindow_setVerticalSyncEnabled = void function(sfRenderWindow* window, sfBool enabled);
        alias psfRenderWindow_setKeyRepeatEnabled = void function(sfRenderWindow* window, sfBool enabled);
        alias psfRenderWindow_setActive = sfBool function(sfRenderWindow* window, sfBool active);
        alias psfRenderWindow_display = void function(sfRenderWindow* window);
        alias psfRenderWindow_setFramerateLimit = void function(sfRenderWindow* window, uint limit);
        alias psfRenderWindow_setJoystickThreshold = void function(sfRenderWindow* window, float threshold);
        alias psfRenderWindow_getSystemHandle = sfWindowHandle function(const(sfRenderWindow)* window);
        alias psfRenderWindow_clear = void function(sfRenderWindow* renderWindow, sfColor color);
        alias psfRenderWindow_setView = void function(sfRenderWindow* renderWindow, const(sfView)* view);
        alias psfRenderWindow_getView = const(sfView)* function(const(sfRenderWindow)* renderWindow);
        alias psfRenderWindow_getDefaultView = const(sfView)* function(const(sfRenderWindow)* renderWindow);
        alias psfRenderWindow_getViewport = sfIntRect function(const(sfRenderWindow)* renderWindow, const(sfView)* view);
        alias psfRenderWindow_mapPixelToCoords = sfVector2f function(const(sfRenderWindow)* renderWindow, sfVector2i point, const(sfView)* view);
        alias psfRenderWindow_mapCoordsToPixel = sfVector2i function(const(sfRenderWindow)* renderWindow, sfVector2f point, const(sfView)* view);
        alias psfRenderWindow_drawSprite = void function(sfRenderWindow* renderWindow, const(sfSprite)* object, const(sfRenderStates)* states);
        alias psfRenderWindow_drawText = void function(sfRenderWindow* renderWindow, const(sfText)* object, const(sfRenderStates)* states);
        alias psfRenderWindow_drawShape = void function(sfRenderWindow* renderWindow, const(sfShape)* object, const(sfRenderStates)* states);
        alias psfRenderWindow_drawCircleShape = void function(sfRenderWindow* renderWindow, const(sfCircleShape)* object, const(sfRenderStates)* states);
        alias psfRenderWindow_drawConvexShape = void function(sfRenderWindow* renderWindow, const(sfConvexShape)* object, const(sfRenderStates)* states);
        alias psfRenderWindow_drawRectangleShape = void function(sfRenderWindow* renderWindow, const(sfRectangleShape)* object, const(sfRenderStates)* states);
        alias psfRenderWindow_drawVertexArray = void function(sfRenderWindow* renderWindow, const(sfVertexArray)* object, const(sfRenderStates)* states);
        alias psfRenderWindow_pushGLStates = void function(sfRenderWindow* renderWindow);
        alias psfRenderWindow_popGLStates = void function(sfRenderWindow* renderWindow);
        alias psfRenderWindow_resetGLStates = void function(sfRenderWindow* renderWindow);
        alias psfRenderWindow_capture = sfImage* function(const(sfRenderWindow)* renderWindow);
        alias psfMouse_getPositionRenderWindow = sfVector2i function(const(sfRenderWindow)* relativeTo);
        alias psfMouse_setPositionRenderWindow = void function(sfVector2i position, const(sfRenderWindow)* relativeTo);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            alias psfRenderWindow_drawPrimitives = void function(sfRenderWindow* renderWindow, const(sfVertex)* vertices, size_t vertexCount, sfPrimitiveType type, const(sfRenderStates)* states);
        }
        else alias psfRenderWindow_drawPrimitives = void function(sfRenderWindow* renderWindow, const(sfVertex)* vertices, uint vertexCount, sfPrimitiveType type, const(sfRenderStates)* states);


        // Graphics/Shader.h
        alias psfShader_createFromFile = sfShader* function(const(char)* vertexShaderFilename, const(char)* fragmentShaderFilename);
        alias psfShader_createFromMemory = sfShader* function(const(char)* vertexShader, const(char)* fragmentShader);
        alias psfShader_createFromStream = sfShader* function(sfInputStream* vertexShaderStream, sfInputStream* fragmentShaderStream);
        alias psfShader_destroy = void function(sfShader* shader);
        alias psfShader_setFloatParameter = void function(sfShader* shader, const(char)* name, float x);
        alias psfShader_setFloat2Parameter = void function(sfShader* shader, const(char)* name, float x, float y);
        alias psfShader_setFloat3Parameter = void function(sfShader* shader, const(char)* name, float x, float y, float z);
        alias psfShader_setFloat4Parameter = void function(sfShader* shader, const(char)* name, float x, float y, float z, float w);
        alias psfShader_setVector2Parameter = void function(sfShader* shader, const(char)* name, sfVector2f vector);
        alias psfShader_setVector3Parameter = void function(sfShader* shader, const(char)* name, sfVector3f vector);
        alias psfShader_setColorParameter = void function(sfShader* shader, const(char)* name, sfColor color);
        alias psfShader_setTransformParameter = void function(sfShader* shader, const(char)* name, sfTransform transform);
        alias psfShader_setTextureParameter = void function(sfShader* shader, const(char)* name, const(sfTexture)* texture);
        alias psfShader_setCurrentTextureParameter = void function(sfShader* shader, const(char)* name);
        alias psfShader_bind = void function(const(sfShader)* shader);
        alias psfShader_isAvailable = sfBool function();

        // Graphics/Shape.h
        alias psfShape_create = sfShape* function(sfShapeGetPointCountCallback getPointCount, sfShapeGetPointCallback getPoint, void* userData);
        alias psfShape_destroy = void function(sfShape* shape);
        alias psfShape_setPosition = void function(sfShape* shape, sfVector2f position);
        alias psfShape_setRotation = void function(sfShape* shape, float angle);
        alias psfShape_setScale = void function(sfShape* shape, sfVector2f scale);
        alias psfShape_setOrigin = void function(sfShape* shape, sfVector2f origin);
        alias psfShape_getPosition = sfVector2f function(const(sfShape)* shape);
        alias psfShape_getRotation = float function(const(sfShape)* shape);
        alias psfShape_getScale = sfVector2f function(const(sfShape)* shape);
        alias psfShape_getOrigin = sfVector2f function(const(sfShape)* shape);
        alias psfShape_move = void function(sfShape* shape, sfVector2f offset);
        alias psfShape_rotate = void function(sfShape* shape, float angle);
        alias psfShape_scale = void function(sfShape* shape, sfVector2f factors);
        alias psfShape_getTransform = sfTransform function(const(sfShape)* shape);
        alias psfShape_getInverseTransform = sfTransform function(const(sfShape)* shape);
        alias psfShape_setTexture = void function(sfShape* shape, const(sfTexture)* texture, sfBool resetRect);
        alias psfShape_setTextureRect = void function(sfShape* shape, sfIntRect rect);
        alias psfShape_setFillColor = void function(sfShape* shape, sfColor color);
        alias psfShape_setOutlineColor = void function(sfShape* shape, sfColor color);
        alias psfShape_setOutlineThickness = void function(sfShape* shape, float thickness);
        alias psfShape_getTexture = const(sfTexture)* function(const(sfShape)* shape);
        alias psfShape_getTextureRect = sfIntRect function(const(sfShape)* shape);
        alias psfShape_getFillColor = sfColor function(const(sfShape)* shape);
        alias psfShape_getOutlineColor = sfColor function(const(sfShape)* shape);
        alias psfShape_getOutlineThickness = float function(const(sfShape)* shape);
        alias psfShape_getLocalBounds = sfFloatRect function(const(sfShape)* shape);
        alias psfShape_getGlobalBounds = sfFloatRect function(const(sfShape)* shape);
        alias psfShape_update = void function(sfShape* shape);


        static if(sfmlSupport >= SFMLSupport.sfml230) {
            alias psfShape_getPointCount = size_t function(const(sfShape)* shape);
            alias psfShape_getPoint = sfVector2f function(const(sfShape)* shape, size_t index);
        }
        else {
            alias psfShape_getPointCount = uint function(const(sfShape)* shape);
            alias psfShape_getPoint = sfVector2f function(const(sfShape)* shape, uint index);
        }

        // Graphics/Sprite.h
        alias psfSprite_create = sfSprite* function();
        alias psfSprite_copy = sfSprite* function(const(sfSprite)* sprite);
        alias psfSprite_destroy = void function(sfSprite* sprite);
        alias psfSprite_setPosition = void function(sfSprite* sprite, sfVector2f position);
        alias psfSprite_setRotation = void function(sfSprite* sprite, float angle);
        alias psfSprite_setScale = void function(sfSprite* sprite, sfVector2f scale);
        alias psfSprite_setOrigin = void function(sfSprite* sprite, sfVector2f origin);
        alias psfSprite_getPosition = sfVector2f function(const(sfSprite)* sprite);
        alias psfSprite_getRotation = float function(const(sfSprite)* sprite);
        alias psfSprite_getScale = sfVector2f function(const(sfSprite)* sprite);
        alias psfSprite_getOrigin = sfVector2f function(const(sfSprite)* sprite);
        alias psfSprite_move = void function(sfSprite* sprite, sfVector2f offset);
        alias psfSprite_rotate = void function(sfSprite* sprite, float angle);
        alias psfSprite_scale = void function(sfSprite* sprite, sfVector2f factors);
        alias psfSprite_getTransform = sfTransform function(const(sfSprite)* sprite);
        alias psfSprite_getInverseTransform = sfTransform function(const(sfSprite)* sprite);
        alias psfSprite_setTexture = void function(sfSprite* sprite, const(sfTexture)* texture, sfBool resetRect);
        alias psfSprite_setTextureRect = void function(sfSprite* sprite, sfIntRect rectangle);
        alias psfSprite_setColor = void function(sfSprite* sprite, sfColor color);
        alias psfSprite_getTexture = const(sfTexture)* function(const(sfSprite)* sprite);
        alias psfSprite_getTextureRect = sfIntRect function(const(sfSprite)* sprite);
        alias psfSprite_getColor = sfColor function(const(sfSprite)* sprite);
        alias psfSprite_getLocalBounds = sfFloatRect function(const(sfSprite)* sprite);
        alias psfSprite_getGlobalBounds = sfFloatRect function(const(sfSprite)* sprite);

        // Graphics/Text.h
        alias psfText_create = sfText* function();
        alias psfText_copy = sfText* function(const(sfText)* text);
        alias psfText_destroy = void function(sfText* text);
        alias psfText_setPosition = void function(sfText* text, sfVector2f position);
        alias psfText_setRotation = void function(sfText* text, float angle);
        alias psfText_setScale = void function(sfText* text, sfVector2f scale);
        alias psfText_setOrigin = void function(sfText* text, sfVector2f origin);
        alias psfText_getPosition = sfVector2f function(const(sfText)* text);
        alias psfText_getRotation = float function(const(sfText)* text);
        alias psfText_getScale = sfVector2f function(const(sfText)* text);
        alias psfText_getOrigin = sfVector2f function(const(sfText)* text);
        alias psfText_move = void function(sfText* text, sfVector2f offset);
        alias psfText_rotate = void function(sfText* text, float angle);
        alias psfText_scale = void function(sfText* text, sfVector2f factors);
        alias psfText_getTransform = sfTransform function(const(sfText)* text);
        alias psfText_getInverseTransform = sfTransform function(const(sfText)* text);
        alias psfText_setString = void function(sfText* text, const(char)* string);
        alias psfText_setUnicodeString = void function(sfText* text, const(sfUint32)* string);
        alias psfText_setFont = void function(sfText* text, const(sfFont)* font);
        alias psfText_setCharacterSize = void function(sfText* text, uint size);
        alias psfText_setStyle = void function(sfText* text, sfUint32 style);
        alias psfText_setColor = void function(sfText* text, sfColor color);
        alias psfText_getString = const(char)* function(const(sfText)* text);
        alias psfText_getUnicodeString = const(sfUint32)* function(const(sfText)* text);
        alias psfText_getFont = const(sfFont)* function(const(sfText)* text);
        alias psfText_getCharacterSize = uint function(const(sfText)* text);
        alias psfText_getStyle = sfUint32 function(const(sfText)* text);
        alias psfText_getColor = sfColor function(const(sfText)* text);
        alias psfText_findCharacterPos = sfVector2f function(const(sfText)* text, size_t index);
        alias psfText_getLocalBounds = sfFloatRect function(const(sfText)* text);
        alias psfText_getGlobalBounds = sfFloatRect function(const(sfText)* text);

        // Graphics/Texture.h
        alias psfTexture_create = sfTexture* function(uint width, uint height);
        alias psfTexture_createFromFile = sfTexture* function(const(char)* filename, const(sfIntRect)* area);
        alias psfTexture_createFromMemory = sfTexture* function(const(void)* data, size_t sizeInBytes, const(sfIntRect)* area);
        alias psfTexture_createFromStream = sfTexture* function(sfInputStream* stream, const(sfIntRect)* area);
        alias psfTexture_createFromImage = sfTexture* function(const(sfImage)* image, const(sfIntRect)* area);
        alias psfTexture_copy = sfTexture* function(const(sfTexture)* texture);
        alias psfTexture_destroy = void function(sfTexture* texture);
        alias psfTexture_getSize = sfVector2u function(const(sfTexture)* texture);
        alias psfTexture_copyToImage = sfImage* function(const(sfTexture)* texture);
        alias psfTexture_updateFromPixels = void function(sfTexture* texture, const(sfUint8)* pixels, uint width, uint height, uint x, uint y);
        alias psfTexture_updateFromImage = void function(sfTexture* texture, const(sfImage)* image, uint x, uint y);
        alias psfTexture_updateFromWindow = void function(sfTexture* texture, const(sfWindow)* window, uint x, uint y);
        alias psfTexture_updateFromRenderWindow = void function(sfTexture* texture, const(sfRenderWindow)* renderWindow, uint x, uint y);
        alias psfTexture_isSmooth = sfBool function(const(sfTexture)* texture);
        alias psfTexture_setSmooth = void function(sfTexture* texture, sfBool smooth);
        alias psfTexture_setRepeated = void function(sfTexture* texture, sfBool repeated);
        alias psfTexture_isRepeated = sfBool function(const(sfTexture)* texture);
        alias psfTexture_bind = void function(const(sfTexture)* texture);
        alias psfTexture_getMaximumSize = uint function();

        // Graphics/Transform.h
        alias psfTransform_fromMatrix = sfTransform function(float a00, float a01, float a02, float a10, float a11, float a12, float a20, float a21, float a22);
        alias psfTransform_getMatrix = void function(const(sfTransform)* transform, float* matrix);
        alias psfTransform_getInverse = sfTransform function(const(sfTransform)* transform);
        alias psfTransform_transformPoint = sfVector2f function(const(sfTransform)* transform, sfVector2f point);
        alias psfTransform_transformRect = sfFloatRect function(const(sfTransform)* transform, sfFloatRect rectangle);
        alias psfTransform_combine = void function(sfTransform* transform, const(sfTransform)* other);
        alias psfTransform_translate = void function(sfTransform* transform, float x, float y);
        alias psfTransform_rotate = void function(sfTransform* transform, float angle);
        alias psfTransform_rotateWithCenter = void function(sfTransform* transform, float angle, float centerX, float centerY);
        alias psfTransform_scale = void function(sfTransform* transform, float scaleX, float scaleY);
        alias psfTransform_scaleWithCenter = void function(sfTransform* transform, float scaleX, float scaleY, float centerX, float centerY);

        // Graphics/Transformable.h
        alias psfTransformable_create = sfTransformable* function();
        alias psfTransformable_copy = sfTransformable* function(const(sfTransformable)* transformable);
        alias psfTransformable_destroy = void function(sfTransformable* transformable);
        alias psfTransformable_setPosition = void function(sfTransformable* transformable, sfVector2f position);
        alias psfTransformable_setRotation = void function(sfTransformable* transformable, float angle);
        alias psfTransformable_setScale = void function(sfTransformable* transformable, sfVector2f scale);
        alias psfTransformable_setOrigin = void function(sfTransformable* transformable, sfVector2f origin);
        alias psfTransformable_getPosition = sfVector2f function(const(sfTransformable)* transformable);
        alias psfTransformable_getRotation = float function(const(sfTransformable)* transformable);
        alias psfTransformable_getScale = sfVector2f function(const(sfTransformable)* transformable);
        alias psfTransformable_getOrigin = sfVector2f function(const(sfTransformable)* transformable);
        alias psfTransformable_move = void function(sfTransformable* transformable, sfVector2f offset);
        alias psfTransformable_rotate = void function(sfTransformable* transformable, float angle);
        alias psfTransformable_scale = void function(sfTransformable* transformable, sfVector2f factors);
        alias psfTransformable_getTransform = sfTransform function(const(sfTransformable)* transformable);
        alias psfTransformable_getInverseTransform = sfTransform function(const(sfTransformable)* transformable);

        // Graphics/VertexArray.h
        alias psfVertexArray_create = sfVertexArray* function();
        alias psfVertexArray_copy = sfVertexArray* function(const(sfVertexArray)* vertexArray);
        alias psfVertexArray_destroy = void function(sfVertexArray* vertexArray);
        alias psfVertexArray_clear = void function(sfVertexArray* vertexArray);
        alias psfVertexArray_append = void function(sfVertexArray* vertexArray, sfVertex vertex);
        alias psfVertexArray_setPrimitiveType = void function(sfVertexArray* vertexArray, sfPrimitiveType type);
        alias psfVertexArray_getPrimitiveType = sfPrimitiveType function(sfVertexArray* vertexArray);
        alias psfVertexArray_getBounds = sfFloatRect function(sfVertexArray* vertexArray);

        static if(sfmlSupport >= SFMLSupport.sfml230) {
            alias psfVertexArray_getVertexCount = size_t function(const(sfVertexArray)* vertexArray);
            alias psfVertexArray_getVertex = sfVertex* function(sfVertexArray* vertexArray, size_t index);
            alias psfVertexArray_resize = void function(sfVertexArray* vertexArray, size_t vertexCount);
        }
        else {
            alias psfVertexArray_getVertexCount = uint function(const(sfVertexArray)* vertexArray);
            alias psfVertexArray_getVertex = sfVertex* function(sfVertexArray* vertexArray, uint index);
            alias psfVertexArray_resize = void function(sfVertexArray* vertexArray, uint vertexCount);
        }

        // Graphics/View.h
        alias psfView_create = sfView* function();
        alias psfView_createFromRect = sfView* function(sfFloatRect rectangle);
        alias psfView_copy = sfView* function(const(sfView)* view);
        alias psfView_destroy = void function(sfView* view);
        alias psfView_setCenter = void function(sfView* view, sfVector2f center);
        alias psfView_setSize = void function(sfView* view, sfVector2f size);
        alias psfView_setRotation = void function(sfView* view, float angle);
        alias psfView_setViewport = void function(sfView* view, sfFloatRect viewport);
        alias psfView_reset = void function(sfView* view, sfFloatRect rectangle);
        alias psfView_getCenter = sfVector2f function(const(sfView)* view);
        alias psfView_getSize = sfVector2f function(const(sfView)* view);
        alias psfView_getRotation = float function(const(sfView)* view);
        alias psfView_getViewport = sfFloatRect function(const(sfView)* view);
        alias psfView_move = void function(sfView* view, sfVector2f offset);
        alias psfView_rotate = void function(sfView* view, float angle);
        alias psfView_zoom = void function(sfView* view, float factor);

        static if(sfmlSupport >= SFMLSupport.sfml220) {
            // Graphics/Font.h
            alias psfFont_getUnderlinePosition = float function(const(sfFont)* font, uint characterSize);
            alias psfFont_getUnderlineThickness = float function(const(sfFont)* font, uint characterSize);
            alias psfFont_getInfo = sfFontInfo function(const(sfFont)* font);

            // Graphics/RenderWindow.h
            alias psfRenderWindow_requestFocus = void function(sfRenderWindow* renderWindow);
            alias psfRenderWindow_hasFocus = sfBool function(const(sfRenderWindow)* renderWindow);
            alias psfTouch_getPositionRenderWindow = sfVector2i function(uint finger, const(sfRenderWindow)* relativeTo);
        }
        static if(sfmlSupport >= SFMLSupport.sfml230) {
            // Graphics/Color.h
            alias psfColor_fromInteger = sfColor function(sfUint32 color);
            alias psfColor_toInteger = sfUint32 function(sfColor color);
            alias psfColor_subtract = sfColor function(sfColor color1, sfColor color2);

            // Graphics/Shader.h
            alias psfShader_getNativeHandle = uint function(const(sfShader)* shader);

            // Graphics/Texture.h
            alias psfTexture_getNativeHandle = uint function(const(sfTexture)* texture);
        }
        static if(sfmlSupport >= SFMLSupport.sfml240) {
            // Graphics/RenderTexture.h
            alias psfRenderTexture_generateMipmap = sfBool function(sfRenderTexture* renderTexture);

            // Graphics/RenderWindow.h
            alias psfRenderWindow_setMouseCursorGrabbed = void function(sfRenderWindow* renderWindow, sfBool grabbed);

            // Graphics/Shader.h
            alias psfShader_setFloatUniform = void function(sfShader* shader, const(char)* name, float x);
            alias psfShader_setVec2Uniform = void function(sfShader* shader, const(char)* name, sfGlslVec2 vector);
            alias psfShader_setVec3Uniform = void function(sfShader* shader, const(char)* name, sfGlslVec3 vector);
            alias psfShader_setVec4Uniform = void function(sfShader* shader, const(char)* name, sfGlslVec4 vector);
            alias psfShader_setColorUniform = void function(sfShader* shader, const(char)* name, sfColor color);
            alias psfShader_setIntUniform = void function(sfShader* shader, const(char)* name, int x);
            alias psfShader_setIvec2Uniform = void function(sfShader* shader, const(char)* name, sfGlslIvec2 vector);
            alias psfShader_setIvec3Uniform = void function(sfShader* shader, const(char)* name, sfGlslIvec3 vector);
            alias psfShader_setIvec4Uniform = void function(sfShader* shader, const(char)* name, sfGlslIvec4 vector);
            alias psfShader_setIntColorUniform = void function(sfShader* shader, const(char)* name, sfColor color);
            alias psfShader_setBoolUniform = void function(sfShader* shader, const(char)* name, sfBool x);
            alias psfShader_setBvec2Uniform = void function(sfShader* shader, const(char)* name, sfGlslBvec2 vector);
            alias psfShader_setBvec3Uniform = void function(sfShader* shader, const(char)* name, sfGlslBvec3 vector);
            alias psfShader_setBvec4Uniform = void function(sfShader* shader, const(char)* name, sfGlslBvec4 vector);
            alias psfShader_setMat3Uniform = void function(sfShader* shader, const(char)* name, const(sfGlslMat3)* matrix);
            alias psfShader_setMat4Uniform = void function(sfShader* shader, const(char)* name, const(sfGlslMat4)* matrix);
            alias psfShader_setTextureUniform = void function(sfShader* shader, const(char)* name, const(sfTexture)* texture);
            alias psfShader_setCurrentTextureUniform = void function(sfShader* shader, const(char)* name);
            alias psfShader_setFloatUniformArray = void function(sfShader* shader, const(char)* name, const(float)* scalarArray, size_t length);
            alias psfShader_setVec2UniformArray = void function(sfShader* shader, const(char)* name, const(sfGlslVec2)* vectorArray, size_t length);
            alias psfShader_setVec3UniformArray = void function(sfShader* shader, const(char)* name, const(sfGlslVec3)* vectorArray, size_t length);
            alias psfShader_setVec4UniformArray = void function(sfShader* shader, const(char)* name, const(sfGlslVec4)* vectorArray, size_t length);
            alias psfShader_setMat3UniformArray = void function(sfShader* shader, const(char)* name, const(sfGlslMat3)* matrixArray, size_t length);
            alias psfShader_setMat4UniformArray = void function(sfShader* shader, const(char)* name, const(sfGlslMat4)* matrixArray, size_t length);
            alias psfShader_isGeometryAvailable = sfBool function();

            // Graphics/Text.h
            alias psfText_setFillColor = void function(sfText* text, sfColor color);
            alias psfText_setOutlineColor = void function(sfText* text, sfColor color);
            alias psfText_setOutlineThickness = void function(sfText* text, float thickness);
            alias psfText_getFillColor = sfColor function(const(sfText)* text);
            alias psfText_getOutlineColor = sfColor function(const(sfText)* text);
            alias psfText_getOutlineThickness = float function(const(sfText)* text);

            // Graphics/Texture.h
            alias psfTexture_setSrgb = void function(sfTexture* texture, sfBool sRgb);
            alias psfTexture_isSrgb = sfBool function(const(sfTexture)* texture);
            alias psfTexture_generateMipmap = sfBool function(sfTexture* texture);
        }
        static if(sfmlSupport >= SFMLSupport.sfml250) {
            // Graphics/RenderTexture.h
            alias psfRenderTexture_createWithSettings = sfRenderTexture* function(uint width, uint height, sfContextSettings settings);
            alias psfRenderTexture_drawVertexBuffer = void function(sfRenderTexture* renderTexture, const(sfVertexBuffer)* object, const(sfRenderStates)* states);
            alias psfRenderTexture_getMaximumAntialiasingLevel = uint function();

            // Graphics/RenderWindow.h
            alias psfRenderWindow_setMouseCursor = void function(sfRenderWindow* window, const(sfCursor)* cursor);
            alias psfRenderWindow_drawVertexBuffer = void function(sfRenderWindow* renderWindow, const(sfVertexBuffer)* object, const(sfRenderStates)* states);

            // Graphics/Text.h
            alias psfText_setLineSpacing = void function(sfText* text, float spacingFactor);
            alias psfText_setLetterSpacing = void function(sfText* text, float spacingFactor);
            alias psfText_getLetterSpacing = float function (const(sfText)* text);
            alias psfText_getLineSpacing = float function (const(sfText)* text);

            // Graphics/Texture.h
            alias psfTexture_updateFromTexture = void function(sfTexture* destination, const(sfTexture)* source, uint x, uint y);
            alias psfTexture_swap = void function(sfTexture* left, sfTexture* right);

            // Graphics/Transform.h
            alias psfTransform_equal = sfBool function(sfTransform* left, sfTransform* right);

            // Graphics/VertexBuffer.h
            alias psfVertexBuffer_create = sfVertexBuffer* function(uint vertexCount, sfPrimitiveType type, sfVertexBufferUsage usage);
            alias psfVertexBuffer_copy = sfVertexBuffer* function(const(sfVertexBuffer)* vertexBuffer);
            alias psfVertexBuffer_destroy = void function(sfVertexBuffer* vertexBuffer);
            alias psfVertexBuffer_getVertexCount = uint function(const(sfVertexBuffer)* vertexBuffer);
            alias psfVertexBuffer_update = sfBool function(sfVertexBuffer* vertexBuffer, const(sfVertex)* vertices, uint vertexCount, uint offset);
            alias psfVertexBuffer_updateFromVertexBuffer = sfBool function(sfVertexBuffer* vertexBuffer, const(sfVertexBuffer)* other);
            alias psfVertexBuffer_swap = void function(sfVertexBuffer* left, sfVertexBuffer* right);
            alias psfVertexBuffer_getNativeHandle = uint function(sfVertexBuffer* vertexBuffer);
            alias psfVertexBuffer_setPrimitiveType = void function(sfVertexBuffer* vertexBuffer, sfPrimitiveType type);
            alias psfVertexBuffer_getPrimitiveType = sfPrimitiveType function(const(sfVertexBuffer)* vertexBuffer);
            alias psfVertexBuffer_setUsage = void function(sfVertexBuffer* vertexBuffer, sfVertexBufferUsage usage);
            alias psfVertexBuffer_getUsage = sfVertexBufferUsage function(const(sfVertexBuffer)* vertexBuffer);
            alias psfVertexBuffer_bind = void function(const(sfVertexBuffer)* vertexBuffer);
            alias psfVertexBuffer_isAvailable = sfBool function();
        }
    }

    __gshared {
        psfCircleShape_create sfCircleShape_create;
        psfCircleShape_copy sfCircleShape_copy;
        psfCircleShape_destroy sfCircleShape_destroy;
        psfCircleShape_setPosition sfCircleShape_setPosition;
        psfCircleShape_setRotation sfCircleShape_setRotation;
        psfCircleShape_setScale sfCircleShape_setScale;
        psfCircleShape_setOrigin sfCircleShape_setOrigin;
        psfCircleShape_getPosition sfCircleShape_getPosition;
        psfCircleShape_getRotation sfCircleShape_getRotation;
        psfCircleShape_getScale sfCircleShape_getScale;
        psfCircleShape_getOrigin sfCircleShape_getOrigin;
        psfCircleShape_move sfCircleShape_move;
        psfCircleShape_rotate sfCircleShape_rotate;
        psfCircleShape_scale sfCircleShape_scale;
        psfCircleShape_getTransform sfCircleShape_getTransform;
        psfCircleShape_getInverseTransform sfCircleShape_getInverseTransform;
        psfCircleShape_setTexture sfCircleShape_setTexture;
        psfCircleShape_setTextureRect sfCircleShape_setTextureRect;
        psfCircleShape_setFillColor sfCircleShape_setFillColor;
        psfCircleShape_setOutlineColor sfCircleShape_setOutlineColor;
        psfCircleShape_setOutlineThickness sfCircleShape_setOutlineThickness;
        psfCircleShape_getTexture sfCircleShape_getTexture;
        psfCircleShape_getTextureRect sfCircleShape_getTextureRect;
        psfCircleShape_getFillColor sfCircleShape_getFillColor;
        psfCircleShape_getOutlineColor sfCircleShape_getOutlineColor;
        psfCircleShape_getOutlineThickness sfCircleShape_getOutlineThickness;
        psfCircleShape_getPointCount sfCircleShape_getPointCount;
        psfCircleShape_getPoint sfCircleShape_getPoint;
        psfCircleShape_setRadius sfCircleShape_setRadius;
        psfCircleShape_getRadius sfCircleShape_getRadius;
        psfCircleShape_setPointCount sfCircleShape_setPointCount;
        psfCircleShape_getLocalBounds sfCircleShape_getLocalBounds;
        psfCircleShape_getGlobalBounds sfCircleShape_getGlobalBounds;
        psfColor_fromRGB sfColor_fromRGB;
        psfColor_fromRGBA sfColor_fromRGBA;
        psfColor_add sfColor_add;
        psfColor_modulate sfColor_modulate;
        psfConvexShape_create sfConvexShape_create;
        psfConvexShape_copy sfConvexShape_copy;
        psfConvexShape_destroy sfConvexShape_destroy;
        psfConvexShape_setPosition sfConvexShape_setPosition;
        psfConvexShape_setRotation sfConvexShape_setRotation;
        psfConvexShape_setScale sfConvexShape_setScale;
        psfConvexShape_setOrigin sfConvexShape_setOrigin;
        psfConvexShape_getPosition sfConvexShape_getPosition;
        psfConvexShape_getRotation sfConvexShape_getRotation;
        psfConvexShape_getScale sfConvexShape_getScale;
        psfConvexShape_getOrigin sfConvexShape_getOrigin;
        psfConvexShape_move sfConvexShape_move;
        psfConvexShape_rotate sfConvexShape_rotate;
        psfConvexShape_scale sfConvexShape_scale;
        psfConvexShape_getTransform sfConvexShape_getTransform;
        psfConvexShape_getInverseTransform sfConvexShape_getInverseTransform;
        psfConvexShape_setTexture sfConvexShape_setTexture;
        psfConvexShape_setTextureRect sfConvexShape_setTextureRect;
        psfConvexShape_setFillColor sfConvexShape_setFillColor;
        psfConvexShape_setOutlineColor sfConvexShape_setOutlineColor;
        psfConvexShape_setOutlineThickness sfConvexShape_setOutlineThickness;
        psfConvexShape_getTexture sfConvexShape_getTexture;
        psfConvexShape_getTextureRect sfConvexShape_getTextureRect;
        psfConvexShape_getFillColor sfConvexShape_getFillColor;
        psfConvexShape_getOutlineColor sfConvexShape_getOutlineColor;
        psfConvexShape_getOutlineThickness sfConvexShape_getOutlineThickness;
        psfConvexShape_getPointCount sfConvexShape_getPointCount;
        psfConvexShape_getPoint sfConvexShape_getPoint;
        psfConvexShape_setPointCount sfConvexShape_setPointCount;
        psfConvexShape_setPoint sfConvexShape_setPoint;
        psfConvexShape_getLocalBounds sfConvexShape_getLocalBounds;
        psfConvexShape_getGlobalBounds sfConvexShape_getGlobalBounds;
        psfFont_createFromFile sfFont_createFromFile;
        psfFont_createFromMemory sfFont_createFromMemory;
        psfFont_createFromStream sfFont_createFromStream;
        psfFont_copy sfFont_copy;
        psfFont_destroy sfFont_destroy;
        psfFont_getGlyph sfFont_getGlyph;
        psfFont_getKerning sfFont_getKerning;
        psfFont_getLineSpacing sfFont_getLineSpacing;
        psfFont_getTexture sfFont_getTexture;
        psfImage_create sfImage_create;
        psfImage_createFromColor sfImage_createFromColor;
        psfImage_createFromPixels sfImage_createFromPixels;
        psfImage_createFromFile sfImage_createFromFile;
        psfImage_createFromMemory sfImage_createFromMemory;
        psfImage_createFromStream sfImage_createFromStream;
        psfImage_copy sfImage_copy;
        psfImage_destroy sfImage_destroy;
        psfImage_saveToFile sfImage_saveToFile;
        psfImage_getSize sfImage_getSize;
        psfImage_createMaskFromColor sfImage_createMaskFromColor;
        psfImage_copyImage sfImage_copyImage;
        psfImage_setPixel sfImage_setPixel;
        psfImage_getPixel sfImage_getPixel;
        psfImage_getPixelsPtr sfImage_getPixelsPtr;
        psfImage_flipHorizontally sfImage_flipHorizontally;
        psfImage_flipVertically sfImage_flipVertically;
        psfFloatRect_contains sfFloatRect_contains;
        psfIntRect_contains sfIntRect_contains;
        psfFloatRect_intersects sfFloatRect_intersects;
        psfIntRect_intersects sfIntRect_intersects;
        psfRectangleShape_create sfRectangleShape_create;
        psfRectangleShape_copy sfRectangleShape_copy;
        psfRectangleShape_destroy sfRectangleShape_destroy;
        psfRectangleShape_setPosition sfRectangleShape_setPosition;
        psfRectangleShape_setRotation sfRectangleShape_setRotation;
        psfRectangleShape_setScale sfRectangleShape_setScale;
        psfRectangleShape_setOrigin sfRectangleShape_setOrigin;
        psfRectangleShape_getPosition sfRectangleShape_getPosition;
        psfRectangleShape_getRotation sfRectangleShape_getRotation;
        psfRectangleShape_getScale sfRectangleShape_getScale;
        psfRectangleShape_getOrigin sfRectangleShape_getOrigin;
        psfRectangleShape_move sfRectangleShape_move;
        psfRectangleShape_rotate sfRectangleShape_rotate;
        psfRectangleShape_scale sfRectangleShape_scale;
        psfRectangleShape_getTransform sfRectangleShape_getTransform;
        psfRectangleShape_getInverseTransform sfRectangleShape_getInverseTransform;
        psfRectangleShape_setTexture sfRectangleShape_setTexture;
        psfRectangleShape_setTextureRect sfRectangleShape_setTextureRect;
        psfRectangleShape_setFillColor sfRectangleShape_setFillColor;
        psfRectangleShape_setOutlineColor sfRectangleShape_setOutlineColor;
        psfRectangleShape_setOutlineThickness sfRectangleShape_setOutlineThickness;
        psfRectangleShape_getTexture sfRectangleShape_getTexture;
        psfRectangleShape_getTextureRect sfRectangleShape_getTextureRect;
        psfRectangleShape_getFillColor sfRectangleShape_getFillColor;
        psfRectangleShape_getOutlineColor sfRectangleShape_getOutlineColor;
        psfRectangleShape_getOutlineThickness sfRectangleShape_getOutlineThickness;
        psfRectangleShape_getPointCount sfRectangleShape_getPointCount;
        psfRectangleShape_getPoint sfRectangleShape_getPoint;
        psfRectangleShape_setSize sfRectangleShape_setSize;
        psfRectangleShape_getSize sfRectangleShape_getSize;
        psfRectangleShape_getLocalBounds sfRectangleShape_getLocalBounds;
        psfRectangleShape_getGlobalBounds sfRectangleShape_getGlobalBounds;
        psfRenderTexture_create sfRenderTexture_create;
        psfRenderTexture_destroy sfRenderTexture_destroy;
        psfRenderTexture_getSize sfRenderTexture_getSize;
        psfRenderTexture_setActive sfRenderTexture_setActive;
        psfRenderTexture_display sfRenderTexture_display;
        psfRenderTexture_clear sfRenderTexture_clear;
        psfRenderTexture_setView sfRenderTexture_setView;
        psfRenderTexture_getView sfRenderTexture_getView;
        psfRenderTexture_getDefaultView sfRenderTexture_getDefaultView;
        psfRenderTexture_getViewport sfRenderTexture_getViewport;
        psfRenderTexture_mapPixelToCoords sfRenderTexture_mapPixelToCoords;
        psfRenderTexture_mapCoordsToPixel sfRenderTexture_mapCoordsToPixel;
        psfRenderTexture_drawSprite sfRenderTexture_drawSprite;
        psfRenderTexture_drawText sfRenderTexture_drawText;
        psfRenderTexture_drawShape sfRenderTexture_drawShape;
        psfRenderTexture_drawCircleShape sfRenderTexture_drawCircleShape;
        psfRenderTexture_drawConvexShape sfRenderTexture_drawConvexShape;
        psfRenderTexture_drawRectangleShape sfRenderTexture_drawRectangleShape;
        psfRenderTexture_drawVertexArray sfRenderTexture_drawVertexArray;
        psfRenderTexture_drawPrimitives sfRenderTexture_drawPrimitives;
        psfRenderTexture_pushGLStates sfRenderTexture_pushGLStates;
        psfRenderTexture_popGLStates sfRenderTexture_popGLStates;
        psfRenderTexture_resetGLStates sfRenderTexture_resetGLStates;
        psfRenderTexture_getTexture sfRenderTexture_getTexture;
        psfRenderTexture_setSmooth sfRenderTexture_setSmooth;
        psfRenderTexture_isSmooth sfRenderTexture_isSmooth;
        psfRenderWindow_create sfRenderWindow_create;
        psfRenderWindow_createUnicode sfRenderWindow_createUnicode;
        psfRenderWindow_createFromHandle sfRenderWindow_createFromHandle;
        psfRenderWindow_destroy sfRenderWindow_destroy;
        psfRenderWindow_close sfRenderWindow_close;
        psfRenderWindow_isOpen sfRenderWindow_isOpen;
        psfRenderWindow_getSettings sfRenderWindow_getSettings;
        psfRenderWindow_pollEvent sfRenderWindow_pollEvent;
        psfRenderWindow_waitEvent sfRenderWindow_waitEvent;
        psfRenderWindow_getPosition sfRenderWindow_getPosition;
        psfRenderWindow_setPosition sfRenderWindow_setPosition;
        psfRenderWindow_getSize sfRenderWindow_getSize;
        psfRenderWindow_setSize sfRenderWindow_setSize;
        psfRenderWindow_setTitle sfRenderWindow_setTitle;
        psfRenderWindow_setUnicodeTitle sfRenderWindow_setUnicodeTitle;
        psfRenderWindow_setIcon sfRenderWindow_setIcon;
        psfRenderWindow_setVisible sfRenderWindow_setVisible;
        psfRenderWindow_setMouseCursorVisible sfRenderWindow_setMouseCursorVisible;
        psfRenderWindow_setVerticalSyncEnabled sfRenderWindow_setVerticalSyncEnabled;
        psfRenderWindow_setKeyRepeatEnabled sfRenderWindow_setKeyRepeatEnabled;
        psfRenderWindow_setActive sfRenderWindow_setActive;
        psfRenderWindow_display sfRenderWindow_display;
        psfRenderWindow_setFramerateLimit sfRenderWindow_setFramerateLimit;
        psfRenderWindow_setJoystickThreshold sfRenderWindow_setJoystickThreshold;
        psfRenderWindow_getSystemHandle sfRenderWindow_getSystemHandle;
        psfRenderWindow_clear sfRenderWindow_clear;
        psfRenderWindow_setView sfRenderWindow_setView;
        psfRenderWindow_getView sfRenderWindow_getView;
        psfRenderWindow_getDefaultView sfRenderWindow_getDefaultView;
        psfRenderWindow_getViewport sfRenderWindow_getViewport;
        psfRenderWindow_mapPixelToCoords sfRenderWindow_mapPixelToCoords;
        psfRenderWindow_mapCoordsToPixel sfRenderWindow_mapCoordsToPixel;
        psfRenderWindow_drawSprite sfRenderWindow_drawSprite;
        psfRenderWindow_drawText sfRenderWindow_drawText;
        psfRenderWindow_drawShape sfRenderWindow_drawShape;
        psfRenderWindow_drawCircleShape sfRenderWindow_drawCircleShape;
        psfRenderWindow_drawConvexShape sfRenderWindow_drawConvexShape;
        psfRenderWindow_drawRectangleShape sfRenderWindow_drawRectangleShape;
        psfRenderWindow_drawVertexArray sfRenderWindow_drawVertexArray;
        psfRenderWindow_drawPrimitives sfRenderWindow_drawPrimitives;
        psfRenderWindow_pushGLStates sfRenderWindow_pushGLStates;
        psfRenderWindow_popGLStates sfRenderWindow_popGLStates;
        psfRenderWindow_resetGLStates sfRenderWindow_resetGLStates;
        psfRenderWindow_capture sfRenderWindow_capture;
        psfMouse_getPositionRenderWindow sfMouse_getPositionRenderWindow;
        psfMouse_setPositionRenderWindow sfMouse_setPositionRenderWindow;
        psfShader_createFromFile sfShader_createFromFile;
        psfShader_createFromMemory sfShader_createFromMemory;
        psfShader_createFromStream sfShader_createFromStream;
        psfShader_destroy sfShader_destroy;
        psfShader_setFloatParameter sfShader_setFloatParameter;
        psfShader_setFloat2Parameter sfShader_setFloat2Parameter;
        psfShader_setFloat3Parameter sfShader_setFloat3Parameter;
        psfShader_setFloat4Parameter sfShader_setFloat4Parameter;
        psfShader_setVector2Parameter sfShader_setVector2Parameter;
        psfShader_setVector3Parameter sfShader_setVector3Parameter;
        psfShader_setColorParameter sfShader_setColorParameter;
        psfShader_setTransformParameter sfShader_setTransformParameter;
        psfShader_setTextureParameter sfShader_setTextureParameter;
        psfShader_setCurrentTextureParameter sfShader_setCurrentTextureParameter;
        psfShader_bind sfShader_bind;
        psfShader_isAvailable sfShader_isAvailable;
        psfShape_create sfShape_create;
        psfShape_destroy sfShape_destroy;
        psfShape_setPosition sfShape_setPosition;
        psfShape_setRotation sfShape_setRotation;
        psfShape_setScale sfShape_setScale;
        psfShape_setOrigin sfShape_setOrigin;
        psfShape_getPosition sfShape_getPosition;
        psfShape_getRotation sfShape_getRotation;
        psfShape_getScale sfShape_getScale;
        psfShape_getOrigin sfShape_getOrigin;
        psfShape_move sfShape_move;
        psfShape_rotate sfShape_rotate;
        psfShape_scale sfShape_scale;
        psfShape_getTransform sfShape_getTransform;
        psfShape_getInverseTransform sfShape_getInverseTransform;
        psfShape_setTexture sfShape_setTexture;
        psfShape_setTextureRect sfShape_setTextureRect;
        psfShape_setFillColor sfShape_setFillColor;
        psfShape_setOutlineColor sfShape_setOutlineColor;
        psfShape_setOutlineThickness sfShape_setOutlineThickness;
        psfShape_getTexture sfShape_getTexture;
        psfShape_getTextureRect sfShape_getTextureRect;
        psfShape_getFillColor sfShape_getFillColor;
        psfShape_getOutlineColor sfShape_getOutlineColor;
        psfShape_getOutlineThickness sfShape_getOutlineThickness;
        psfShape_getPointCount sfShape_getPointCount;
        psfShape_getPoint sfShape_getPoint;
        psfShape_getLocalBounds sfShape_getLocalBounds;
        psfShape_getGlobalBounds sfShape_getGlobalBounds;
        psfShape_update sfShape_update;
        psfSprite_create sfSprite_create;
        psfSprite_copy sfSprite_copy;
        psfSprite_destroy sfSprite_destroy;
        psfSprite_setPosition sfSprite_setPosition;
        psfSprite_setRotation sfSprite_setRotation;
        psfSprite_setScale sfSprite_setScale;
        psfSprite_setOrigin sfSprite_setOrigin;
        psfSprite_getPosition sfSprite_getPosition;
        psfSprite_getRotation sfSprite_getRotation;
        psfSprite_getScale sfSprite_getScale;
        psfSprite_getOrigin sfSprite_getOrigin;
        psfSprite_move sfSprite_move;
        psfSprite_rotate sfSprite_rotate;
        psfSprite_scale sfSprite_scale;
        psfSprite_getTransform sfSprite_getTransform;
        psfSprite_getInverseTransform sfSprite_getInverseTransform;
        psfSprite_setTexture sfSprite_setTexture;
        psfSprite_setTextureRect sfSprite_setTextureRect;
        psfSprite_setColor sfSprite_setColor;
        psfSprite_getTexture sfSprite_getTexture;
        psfSprite_getTextureRect sfSprite_getTextureRect;
        psfSprite_getColor sfSprite_getColor;
        psfSprite_getLocalBounds sfSprite_getLocalBounds;
        psfSprite_getGlobalBounds sfSprite_getGlobalBounds;
        psfText_create sfText_create;
        psfText_copy sfText_copy;
        psfText_destroy sfText_destroy;
        psfText_setPosition sfText_setPosition;
        psfText_setRotation sfText_setRotation;
        psfText_setScale sfText_setScale;
        psfText_setOrigin sfText_setOrigin;
        psfText_getPosition sfText_getPosition;
        psfText_getRotation sfText_getRotation;
        psfText_getScale sfText_getScale;
        psfText_getOrigin sfText_getOrigin;
        psfText_move sfText_move;
        psfText_rotate sfText_rotate;
        psfText_scale sfText_scale;
        psfText_getTransform sfText_getTransform;
        psfText_getInverseTransform sfText_getInverseTransform;
        psfText_setString sfText_setString;
        psfText_setUnicodeString sfText_setUnicodeString;
        psfText_setFont sfText_setFont;
        psfText_setCharacterSize sfText_setCharacterSize;
        psfText_setStyle sfText_setStyle;
        psfText_setColor sfText_setColor;
        psfText_getString sfText_getString;
        psfText_getUnicodeString sfText_getUnicodeString;
        psfText_getFont sfText_getFont;
        psfText_getCharacterSize sfText_getCharacterSize;
        psfText_getStyle sfText_getStyle;
        psfText_getColor sfText_getColor;
        psfText_findCharacterPos sfText_findCharacterPos;
        psfText_getLocalBounds sfText_getLocalBounds;
        psfText_getGlobalBounds sfText_getGlobalBounds;
        psfTexture_create sfTexture_create;
        psfTexture_createFromFile sfTexture_createFromFile;
        psfTexture_createFromMemory sfTexture_createFromMemory;
        psfTexture_createFromStream sfTexture_createFromStream;
        psfTexture_createFromImage sfTexture_createFromImage;
        psfTexture_copy sfTexture_copy;
        psfTexture_destroy sfTexture_destroy;
        psfTexture_getSize sfTexture_getSize;
        psfTexture_copyToImage sfTexture_copyToImage;
        psfTexture_updateFromPixels sfTexture_updateFromPixels;
        psfTexture_updateFromImage sfTexture_updateFromImage;
        psfTexture_updateFromWindow sfTexture_updateFromWindow;
        psfTexture_updateFromRenderWindow sfTexture_updateFromRenderWindow;
        psfTexture_isSmooth sfTexture_isSmooth;
        psfTexture_setSmooth sfTexture_setSmooth;
        psfTexture_setRepeated sfTexture_setRepeated;
        psfTexture_isRepeated sfTexture_isRepeated;
        psfTexture_bind sfTexture_bind;
        psfTexture_getMaximumSize sfTexture_getMaximumSize;
        psfTransform_fromMatrix sfTransform_fromMatrix;
        psfTransform_getMatrix sfTransform_getMatrix;
        psfTransform_getInverse sfTransform_getInverse;
        psfTransform_transformPoint sfTransform_transformPoint;
        psfTransform_transformRect sfTransform_transformRect;
        psfTransform_combine sfTransform_combine;
        psfTransform_translate sfTransform_translate;
        psfTransform_rotate sfTransform_rotate;
        psfTransform_rotateWithCenter sfTransform_rotateWithCenter;
        psfTransform_scale sfTransform_scale;
        psfTransform_scaleWithCenter sfTransform_scaleWithCenter;
        psfTransformable_create sfTransformable_create;
        psfTransformable_copy sfTransformable_copy;
        psfTransformable_destroy sfTransformable_destroy;
        psfTransformable_setPosition sfTransformable_setPosition;
        psfTransformable_setRotation sfTransformable_setRotation;
        psfTransformable_setScale sfTransformable_setScale;
        psfTransformable_setOrigin sfTransformable_setOrigin;
        psfTransformable_getPosition sfTransformable_getPosition;
        psfTransformable_getRotation sfTransformable_getRotation;
        psfTransformable_getScale sfTransformable_getScale;
        psfTransformable_getOrigin sfTransformable_getOrigin;
        psfTransformable_move sfTransformable_move;
        psfTransformable_rotate sfTransformable_rotate;
        psfTransformable_scale sfTransformable_scale;
        psfTransformable_getTransform sfTransformable_getTransform;
        psfTransformable_getInverseTransform sfTransformable_getInverseTransform;
        psfVertexArray_create sfVertexArray_create;
        psfVertexArray_copy sfVertexArray_copy;
        psfVertexArray_destroy sfVertexArray_destroy;
        psfVertexArray_getVertexCount sfVertexArray_getVertexCount;
        psfVertexArray_getVertex sfVertexArray_getVertex;
        psfVertexArray_clear sfVertexArray_clear;
        psfVertexArray_resize sfVertexArray_resize;
        psfVertexArray_append sfVertexArray_append;
        psfVertexArray_setPrimitiveType sfVertexArray_setPrimitiveType;
        psfVertexArray_getPrimitiveType sfVertexArray_getPrimitiveType;
        psfVertexArray_getBounds sfVertexArray_getBounds;
        psfView_create sfView_create;
        psfView_createFromRect sfView_createFromRect;
        psfView_copy sfView_copy;
        psfView_destroy sfView_destroy;
        psfView_setCenter sfView_setCenter;
        psfView_setSize sfView_setSize;
        psfView_setRotation sfView_setRotation;
        psfView_setViewport sfView_setViewport;
        psfView_reset sfView_reset;
        psfView_getCenter sfView_getCenter;
        psfView_getSize sfView_getSize;
        psfView_getRotation sfView_getRotation;
        psfView_getViewport sfView_getViewport;
        psfView_move sfView_move;
        psfView_rotate sfView_rotate;
        psfView_zoom sfView_zoom;

        static if(sfmlSupport >= SFMLSupport.sfml220) {
            psfFont_getUnderlinePosition sfFont_getUnderlinePosition;
            psfFont_getUnderlineThickness sfFont_getUnderlineThickness;
            psfFont_getInfo sfFont_getInfo;
            psfRenderWindow_requestFocus sfRenderWindow_requestFocus;
            psfRenderWindow_hasFocus sfRenderWindow_hasFocus;
            psfTouch_getPositionRenderWindow sfTouch_getPositionRenderWindow;
        }
        static if(sfmlSupport >= SFMLSupport.sfml230) {
            psfColor_fromInteger sfColor_fromInteger;
            psfColor_toInteger sfColor_toInteger;
            psfColor_subtract sfColor_subtract;
            psfShader_getNativeHandle sfShader_getNativeHandle;
            psfTexture_getNativeHandle sfTexture_getNativeHandle;
        }
        static if(sfmlSupport >= SFMLSupport.sfml240) {
            psfRenderTexture_generateMipmap sfRenderTexture_generateMipmap;
            psfRenderWindow_setMouseCursorGrabbed sfRenderWindow_setMouseCursorGrabbed;
            psfShader_setFloatUniform sfShader_setFloatUniform;
            psfShader_setVec2Uniform sfShader_setVec2Uniform;
            psfShader_setVec3Uniform sfShader_setVec3Uniform;
            psfShader_setVec4Uniform sfShader_setVec4Uniform;
            psfShader_setColorUniform sfShader_setColorUniform;
            psfShader_setIntUniform sfShader_setIntUniform;
            psfShader_setIvec2Uniform sfShader_setIvec2Uniform;
            psfShader_setIvec3Uniform sfShader_setIvec3Uniform;
            psfShader_setIvec4Uniform sfShader_setIvec4Uniform;
            psfShader_setIntColorUniform sfShader_setIntColorUniform;
            psfShader_setBoolUniform sfShader_setBoolUniform;
            psfShader_setBvec2Uniform sfShader_setBvec2Uniform;
            psfShader_setBvec3Uniform sfShader_setBvec3Uniform;
            psfShader_setBvec4Uniform sfShader_setBvec4Uniform;
            psfShader_setMat3Uniform sfShader_setMat3Uniform;
            psfShader_setMat4Uniform sfShader_setMat4Uniform;
            psfShader_setTextureUniform sfShader_setTextureUniform;
            psfShader_setCurrentTextureUniform sfShader_setCurrentTextureUniform;
            psfShader_setFloatUniformArray sfShader_setFloatUniformArray;
            psfShader_setVec2UniformArray sfShader_setVec2UniformArray;
            psfShader_setVec3UniformArray sfShader_setVec3UniformArray;
            psfShader_setVec4UniformArray sfShader_setVec4UniformArray;
            psfShader_setMat3UniformArray sfShader_setMat3UniformArray;
            psfShader_setMat4UniformArray sfShader_setMat4UniformArray;
            psfShader_isGeometryAvailable sfShader_isGeometryAvailable;
            psfText_setFillColor sfText_setFillColor;
            psfText_setOutlineColor sfText_setOutlineColor;
            psfText_setOutlineThickness sfText_setOutlineThickness;
            psfText_getFillColor sfText_getFillColor;
            psfText_getOutlineColor sfText_getOutlineColor;
            psfText_getOutlineThickness sfText_getOutlineThickness;
            psfTexture_setSrgb sfTexture_setSrgb;
            psfTexture_isSrgb sfTexture_isSrgb;
            psfTexture_generateMipmap sfTexture_generateMipmap;
        }
        static if(sfmlSupport >= SFMLSupport.sfml250) {
            psfRenderTexture_createWithSettings sfRenderTexture_createWithSettings;
            psfRenderTexture_drawVertexBuffer sfRenderTexture_drawVertexBuffer;
            psfRenderTexture_getMaximumAntialiasingLevel sfRenderTexture_getMaximumAntialiasingLevel;
            psfRenderWindow_setMouseCursor sfRenderWindow_setMouseCursor;
            psfRenderWindow_drawVertexBuffer sfRenderWindow_drawVertexBuffer;
            psfText_setLineSpacing sfText_setLineSpacing;
            psfText_setLetterSpacing sfText_setLetterSpacing;
            psfText_getLetterSpacing sfText_getLetterSpacing;
            psfText_getLineSpacing sfText_getLineSpacing;
            psfTexture_updateFromTexture sfTexture_updateFromTexture;
            psfTexture_swap sfTexture_swap;
            psfTransform_equal sfTransform_equal;
            psfVertexBuffer_create sfVertexBuffer_create;
            psfVertexBuffer_copy sfVertexBuffer_copy;
            psfVertexBuffer_destroy sfVertexBuffer_destroy;
            psfVertexBuffer_getVertexCount sfVertexBuffer_getVertexCount;
            psfVertexBuffer_update sfVertexBuffer_update;
            psfVertexBuffer_updateFromVertexBuffer sfVertexBuffer_updateFromVertexBuffer;
            psfVertexBuffer_swap sfVertexBuffer_swap;
            psfVertexBuffer_getNativeHandle sfVertexBuffer_getNativeHandle;
            psfVertexBuffer_setPrimitiveType sfVertexBuffer_setPrimitiveType;
            psfVertexBuffer_getPrimitiveType sfVertexBuffer_getPrimitiveType;
            psfVertexBuffer_setUsage sfVertexBuffer_setUsage;
            psfVertexBuffer_getUsage sfVertexBuffer_getUsage;
            psfVertexBuffer_bind sfVertexBuffer_bind;
            psfVertexBuffer_isAvailable sfVertexBuffer_isAvailable;
        }
    }
    private {
        SharedLib lib;
        SFMLSupport loadedVersion;
    }

@nogc nothrow:
    SFMLSupport loadedSFMLGraphicsVersion() { return loadedVersion; }

    bool isSFMLGraphicsLoaded()
    {
        return lib != invalidHandle;
    }

    SFMLSupport loadSFMLGraphics()
    {
        version(Windows) {
            const(char)[][3] libNames = [
                "csfml-graphics.dll",
                "csfml-graphics-2.dll",
                "csfml-graphics-2.0.dll"
            ];
        }
        else version(OSX) {
            const(char)[][3] libNames = [
                "libcsfml-graphics.dylib",
                "libcsfml-graphics.2.dylib",
                "libcsfml-graphics.2.0.dylib"
            ];
        }
        else version(Posix) {
            const(char)[][3] libNames = [
                "libcsfml-graphics.so",
                "libcsfml-graphics.so.2",
                "libcsfml-graphics.so.2.0"
            ];
        }

        SFMLSupport ret;
        foreach(name; libNames) {
            ret = loadSFMLGraphics(name.ptr);
            if(ret != SFMLSupport.noLibrary) break;
        }
        return ret;
    }

    SFMLSupport loadSFMLGraphics(const(char)* libName)
    {
        lib = load(libName);
        if(lib == invalidHandle) {
            return SFMLSupport.noLibrary;
        }

        auto errCount = errorCount();
        loadedVersion = SFMLSupport.badLibrary;

        // Now load the functions
        lib.bindSymbol(cast(void**)&sfCircleShape_create,"sfCircleShape_create");
        lib.bindSymbol(cast(void**)&sfCircleShape_copy,"sfCircleShape_copy");
        lib.bindSymbol(cast(void**)&sfCircleShape_destroy,"sfCircleShape_destroy");
        lib.bindSymbol(cast(void**)&sfCircleShape_setPosition,"sfCircleShape_setPosition");
        lib.bindSymbol(cast(void**)&sfCircleShape_setRotation,"sfCircleShape_setRotation");
        lib.bindSymbol(cast(void**)&sfCircleShape_setScale,"sfCircleShape_setScale");
        lib.bindSymbol(cast(void**)&sfCircleShape_setOrigin,"sfCircleShape_setOrigin");
        lib.bindSymbol(cast(void**)&sfCircleShape_getPosition,"sfCircleShape_getPosition");
        lib.bindSymbol(cast(void**)&sfCircleShape_getRotation,"sfCircleShape_getRotation");
        lib.bindSymbol(cast(void**)&sfCircleShape_getScale,"sfCircleShape_getScale");
        lib.bindSymbol(cast(void**)&sfCircleShape_getOrigin,"sfCircleShape_getOrigin");
        lib.bindSymbol(cast(void**)&sfCircleShape_move,"sfCircleShape_move");
        lib.bindSymbol(cast(void**)&sfCircleShape_rotate,"sfCircleShape_rotate");
        lib.bindSymbol(cast(void**)&sfCircleShape_scale,"sfCircleShape_scale");
        lib.bindSymbol(cast(void**)&sfCircleShape_getTransform,"sfCircleShape_getTransform");
        lib.bindSymbol(cast(void**)&sfCircleShape_getInverseTransform,"sfCircleShape_getInverseTransform");
        lib.bindSymbol(cast(void**)&sfCircleShape_setTexture,"sfCircleShape_setTexture");
        lib.bindSymbol(cast(void**)&sfCircleShape_setTextureRect,"sfCircleShape_setTextureRect");
        lib.bindSymbol(cast(void**)&sfCircleShape_setFillColor,"sfCircleShape_setFillColor");
        lib.bindSymbol(cast(void**)&sfCircleShape_setOutlineColor,"sfCircleShape_setOutlineColor");
        lib.bindSymbol(cast(void**)&sfCircleShape_setOutlineThickness,"sfCircleShape_setOutlineThickness");
        lib.bindSymbol(cast(void**)&sfCircleShape_getTexture,"sfCircleShape_getTexture");
        lib.bindSymbol(cast(void**)&sfCircleShape_getTextureRect,"sfCircleShape_getTextureRect");
        lib.bindSymbol(cast(void**)&sfCircleShape_getFillColor,"sfCircleShape_getFillColor");
        lib.bindSymbol(cast(void**)&sfCircleShape_getOutlineColor,"sfCircleShape_getOutlineColor");
        lib.bindSymbol(cast(void**)&sfCircleShape_getOutlineThickness,"sfCircleShape_getOutlineThickness");
        lib.bindSymbol(cast(void**)&sfCircleShape_getPointCount,"sfCircleShape_getPointCount");
        lib.bindSymbol(cast(void**)&sfCircleShape_getPoint,"sfCircleShape_getPoint");
        lib.bindSymbol(cast(void**)&sfCircleShape_setRadius,"sfCircleShape_setRadius");
        lib.bindSymbol(cast(void**)&sfCircleShape_getRadius,"sfCircleShape_getRadius");
        lib.bindSymbol(cast(void**)&sfCircleShape_setPointCount,"sfCircleShape_setPointCount");
        lib.bindSymbol(cast(void**)&sfCircleShape_getLocalBounds,"sfCircleShape_getLocalBounds");
        lib.bindSymbol(cast(void**)&sfCircleShape_getGlobalBounds,"sfCircleShape_getGlobalBounds");
        lib.bindSymbol(cast(void**)&sfColor_fromRGB,"sfColor_fromRGB");
        lib.bindSymbol(cast(void**)&sfColor_fromRGBA,"sfColor_fromRGBA");
        lib.bindSymbol(cast(void**)&sfColor_add,"sfColor_add");
        lib.bindSymbol(cast(void**)&sfColor_modulate,"sfColor_modulate");
        lib.bindSymbol(cast(void**)&sfConvexShape_create,"sfConvexShape_create");
        lib.bindSymbol(cast(void**)&sfConvexShape_copy,"sfConvexShape_copy");
        lib.bindSymbol(cast(void**)&sfConvexShape_destroy,"sfConvexShape_destroy");
        lib.bindSymbol(cast(void**)&sfConvexShape_setPosition,"sfConvexShape_setPosition");
        lib.bindSymbol(cast(void**)&sfConvexShape_setRotation,"sfConvexShape_setRotation");
        lib.bindSymbol(cast(void**)&sfConvexShape_setScale,"sfConvexShape_setScale");
        lib.bindSymbol(cast(void**)&sfConvexShape_setOrigin,"sfConvexShape_setOrigin");
        lib.bindSymbol(cast(void**)&sfConvexShape_getPosition,"sfConvexShape_getPosition");
        lib.bindSymbol(cast(void**)&sfConvexShape_getRotation,"sfConvexShape_getRotation");
        lib.bindSymbol(cast(void**)&sfConvexShape_getScale,"sfConvexShape_getScale");
        lib.bindSymbol(cast(void**)&sfConvexShape_getOrigin,"sfConvexShape_getOrigin");
        lib.bindSymbol(cast(void**)&sfConvexShape_move,"sfConvexShape_move");
        lib.bindSymbol(cast(void**)&sfConvexShape_rotate,"sfConvexShape_rotate");
        lib.bindSymbol(cast(void**)&sfConvexShape_scale,"sfConvexShape_scale");
        lib.bindSymbol(cast(void**)&sfConvexShape_getTransform,"sfConvexShape_getTransform");
        lib.bindSymbol(cast(void**)&sfConvexShape_getInverseTransform,"sfConvexShape_getInverseTransform");
        lib.bindSymbol(cast(void**)&sfConvexShape_setTexture,"sfConvexShape_setTexture");
        lib.bindSymbol(cast(void**)&sfConvexShape_setTextureRect,"sfConvexShape_setTextureRect");
        lib.bindSymbol(cast(void**)&sfConvexShape_setFillColor,"sfConvexShape_setFillColor");
        lib.bindSymbol(cast(void**)&sfConvexShape_setOutlineColor,"sfConvexShape_setOutlineColor");
        lib.bindSymbol(cast(void**)&sfConvexShape_setOutlineThickness,"sfConvexShape_setOutlineThickness");
        lib.bindSymbol(cast(void**)&sfConvexShape_getTexture,"sfConvexShape_getTexture");
        lib.bindSymbol(cast(void**)&sfConvexShape_getTextureRect,"sfConvexShape_getTextureRect");
        lib.bindSymbol(cast(void**)&sfConvexShape_getFillColor,"sfConvexShape_getFillColor");
        lib.bindSymbol(cast(void**)&sfConvexShape_getOutlineColor,"sfConvexShape_getOutlineColor");
        lib.bindSymbol(cast(void**)&sfConvexShape_getOutlineThickness,"sfConvexShape_getOutlineThickness");
        lib.bindSymbol(cast(void**)&sfConvexShape_getPointCount,"sfConvexShape_getPointCount");
        lib.bindSymbol(cast(void**)&sfConvexShape_getPoint,"sfConvexShape_getPoint");
        lib.bindSymbol(cast(void**)&sfConvexShape_setPointCount,"sfConvexShape_setPointCount");
        lib.bindSymbol(cast(void**)&sfConvexShape_setPoint,"sfConvexShape_setPoint");
        lib.bindSymbol(cast(void**)&sfConvexShape_getLocalBounds,"sfConvexShape_getLocalBounds");
        lib.bindSymbol(cast(void**)&sfConvexShape_getGlobalBounds,"sfConvexShape_getGlobalBounds");
        lib.bindSymbol(cast(void**)&sfFont_createFromFile,"sfFont_createFromFile");
        lib.bindSymbol(cast(void**)&sfFont_createFromMemory,"sfFont_createFromMemory");
        lib.bindSymbol(cast(void**)&sfFont_createFromStream,"sfFont_createFromStream");
        lib.bindSymbol(cast(void**)&sfFont_copy,"sfFont_copy");
        lib.bindSymbol(cast(void**)&sfFont_destroy,"sfFont_destroy");
        lib.bindSymbol(cast(void**)&sfFont_getGlyph,"sfFont_getGlyph");
        lib.bindSymbol(cast(void**)&sfFont_getKerning,"sfFont_getKerning");
        lib.bindSymbol(cast(void**)&sfFont_getLineSpacing,"sfFont_getLineSpacing");
        lib.bindSymbol(cast(void**)&sfFont_getTexture,"sfFont_getTexture");
        lib.bindSymbol(cast(void**)&sfImage_create,"sfImage_create");
        lib.bindSymbol(cast(void**)&sfImage_createFromColor,"sfImage_createFromColor");
        lib.bindSymbol(cast(void**)&sfImage_createFromPixels,"sfImage_createFromPixels");
        lib.bindSymbol(cast(void**)&sfImage_createFromFile,"sfImage_createFromFile");
        lib.bindSymbol(cast(void**)&sfImage_createFromMemory,"sfImage_createFromMemory");
        lib.bindSymbol(cast(void**)&sfImage_createFromStream,"sfImage_createFromStream");
        lib.bindSymbol(cast(void**)&sfImage_copy,"sfImage_copy");
        lib.bindSymbol(cast(void**)&sfImage_destroy,"sfImage_destroy");
        lib.bindSymbol(cast(void**)&sfImage_saveToFile,"sfImage_saveToFile");
        lib.bindSymbol(cast(void**)&sfImage_getSize,"sfImage_getSize");
        lib.bindSymbol(cast(void**)&sfImage_createMaskFromColor,"sfImage_createMaskFromColor");
        lib.bindSymbol(cast(void**)&sfImage_copyImage,"sfImage_copyImage");
        lib.bindSymbol(cast(void**)&sfImage_setPixel,"sfImage_setPixel");
        lib.bindSymbol(cast(void**)&sfImage_getPixel,"sfImage_getPixel");
        lib.bindSymbol(cast(void**)&sfImage_getPixelsPtr,"sfImage_getPixelsPtr");
        lib.bindSymbol(cast(void**)&sfImage_flipHorizontally,"sfImage_flipHorizontally");
        lib.bindSymbol(cast(void**)&sfImage_flipVertically,"sfImage_flipVertically");
        lib.bindSymbol(cast(void**)&sfFloatRect_contains,"sfFloatRect_contains");
        lib.bindSymbol(cast(void**)&sfIntRect_contains,"sfIntRect_contains");
        lib.bindSymbol(cast(void**)&sfFloatRect_intersects,"sfFloatRect_intersects");
        lib.bindSymbol(cast(void**)&sfIntRect_intersects,"sfIntRect_intersects");
        lib.bindSymbol(cast(void**)&sfRectangleShape_create,"sfRectangleShape_create");
        lib.bindSymbol(cast(void**)&sfRectangleShape_copy,"sfRectangleShape_copy");
        lib.bindSymbol(cast(void**)&sfRectangleShape_destroy,"sfRectangleShape_destroy");
        lib.bindSymbol(cast(void**)&sfRectangleShape_setPosition,"sfRectangleShape_setPosition");
        lib.bindSymbol(cast(void**)&sfRectangleShape_setRotation,"sfRectangleShape_setRotation");
        lib.bindSymbol(cast(void**)&sfRectangleShape_setScale,"sfRectangleShape_setScale");
        lib.bindSymbol(cast(void**)&sfRectangleShape_setOrigin,"sfRectangleShape_setOrigin");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getPosition,"sfRectangleShape_getPosition");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getRotation,"sfRectangleShape_getRotation");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getScale,"sfRectangleShape_getScale");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getOrigin,"sfRectangleShape_getOrigin");
        lib.bindSymbol(cast(void**)&sfRectangleShape_move,"sfRectangleShape_move");
        lib.bindSymbol(cast(void**)&sfRectangleShape_rotate,"sfRectangleShape_rotate");
        lib.bindSymbol(cast(void**)&sfRectangleShape_scale,"sfRectangleShape_scale");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getTransform,"sfRectangleShape_getTransform");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getInverseTransform,"sfRectangleShape_getInverseTransform");
        lib.bindSymbol(cast(void**)&sfRectangleShape_setTexture,"sfRectangleShape_setTexture");
        lib.bindSymbol(cast(void**)&sfRectangleShape_setTextureRect,"sfRectangleShape_setTextureRect");
        lib.bindSymbol(cast(void**)&sfRectangleShape_setFillColor,"sfRectangleShape_setFillColor");
        lib.bindSymbol(cast(void**)&sfRectangleShape_setOutlineColor,"sfRectangleShape_setOutlineColor");
        lib.bindSymbol(cast(void**)&sfRectangleShape_setOutlineThickness,"sfRectangleShape_setOutlineThickness");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getTexture,"sfRectangleShape_getTexture");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getTextureRect,"sfRectangleShape_getTextureRect");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getFillColor,"sfRectangleShape_getFillColor");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getOutlineColor,"sfRectangleShape_getOutlineColor");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getOutlineThickness,"sfRectangleShape_getOutlineThickness");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getPointCount,"sfRectangleShape_getPointCount");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getPoint,"sfRectangleShape_getPoint");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getPoint,"sfRectangleShape_getPoint");
        lib.bindSymbol(cast(void**)&sfRectangleShape_setSize,"sfRectangleShape_setSize");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getLocalBounds,"sfRectangleShape_getLocalBounds");
        lib.bindSymbol(cast(void**)&sfRectangleShape_getGlobalBounds,"sfRectangleShape_getGlobalBounds");
        lib.bindSymbol(cast(void**)&sfRenderTexture_create,"sfRenderTexture_create");
        lib.bindSymbol(cast(void**)&sfRenderTexture_destroy,"sfRenderTexture_destroy");
        lib.bindSymbol(cast(void**)&sfRenderTexture_getSize,"sfRenderTexture_getSize");
        lib.bindSymbol(cast(void**)&sfRenderTexture_setActive,"sfRenderTexture_setActive");
        lib.bindSymbol(cast(void**)&sfRenderTexture_display,"sfRenderTexture_display");
        lib.bindSymbol(cast(void**)&sfRenderTexture_clear,"sfRenderTexture_clear");
        lib.bindSymbol(cast(void**)&sfRenderTexture_setView,"sfRenderTexture_setView");
        lib.bindSymbol(cast(void**)&sfRenderTexture_getView,"sfRenderTexture_getView");
        lib.bindSymbol(cast(void**)&sfRenderTexture_getDefaultView,"sfRenderTexture_getDefaultView");
        lib.bindSymbol(cast(void**)&sfRenderTexture_getViewport,"sfRenderTexture_getViewport");
        lib.bindSymbol(cast(void**)&sfRenderTexture_mapPixelToCoords,"sfRenderTexture_mapPixelToCoords");
        lib.bindSymbol(cast(void**)&sfRenderTexture_mapCoordsToPixel,"sfRenderTexture_mapCoordsToPixel");
        lib.bindSymbol(cast(void**)&sfRenderTexture_drawSprite,"sfRenderTexture_drawSprite");
        lib.bindSymbol(cast(void**)&sfRenderTexture_drawText,"sfRenderTexture_drawText");
        lib.bindSymbol(cast(void**)&sfRenderTexture_drawShape,"sfRenderTexture_drawShape");
        lib.bindSymbol(cast(void**)&sfRenderTexture_drawCircleShape,"sfRenderTexture_drawCircleShape");
        lib.bindSymbol(cast(void**)&sfRenderTexture_drawConvexShape,"sfRenderTexture_drawConvexShape");
        lib.bindSymbol(cast(void**)&sfRenderTexture_drawRectangleShape,"sfRenderTexture_drawRectangleShape");
        lib.bindSymbol(cast(void**)&sfRenderTexture_drawVertexArray,"sfRenderTexture_drawVertexArray");
        lib.bindSymbol(cast(void**)&sfRenderTexture_drawPrimitives,"sfRenderTexture_drawPrimitives");
        lib.bindSymbol(cast(void**)&sfRenderTexture_pushGLStates,"sfRenderTexture_pushGLStates");
        lib.bindSymbol(cast(void**)&sfRenderTexture_popGLStates,"sfRenderTexture_popGLStates");
        lib.bindSymbol(cast(void**)&sfRenderTexture_resetGLStates,"sfRenderTexture_resetGLStates");
        lib.bindSymbol(cast(void**)&sfRenderTexture_getTexture,"sfRenderTexture_getTexture");
        lib.bindSymbol(cast(void**)&sfRenderTexture_setSmooth,"sfRenderTexture_setSmooth");
        lib.bindSymbol(cast(void**)&sfRenderTexture_isSmooth,"sfRenderTexture_isSmooth");
        lib.bindSymbol(cast(void**)&sfRenderWindow_create,"sfRenderWindow_create");
        lib.bindSymbol(cast(void**)&sfRenderWindow_createUnicode,"sfRenderWindow_createUnicode");
        lib.bindSymbol(cast(void**)&sfRenderWindow_createFromHandle,"sfRenderWindow_createFromHandle");
        lib.bindSymbol(cast(void**)&sfRenderWindow_destroy,"sfRenderWindow_destroy");
        lib.bindSymbol(cast(void**)&sfRenderWindow_close,"sfRenderWindow_close");
        lib.bindSymbol(cast(void**)&sfRenderWindow_isOpen,"sfRenderWindow_isOpen");
        lib.bindSymbol(cast(void**)&sfRenderWindow_getSettings,"sfRenderWindow_getSettings");
        lib.bindSymbol(cast(void**)&sfRenderWindow_pollEvent,"sfRenderWindow_pollEvent");
        lib.bindSymbol(cast(void**)&sfRenderWindow_waitEvent,"sfRenderWindow_waitEvent");
        lib.bindSymbol(cast(void**)&sfRenderWindow_getPosition,"sfRenderWindow_getPosition");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setPosition,"sfRenderWindow_setPosition");
        lib.bindSymbol(cast(void**)&sfRenderWindow_getSize,"sfRenderWindow_getSize");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setSize,"sfRenderWindow_setSize");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setTitle,"sfRenderWindow_setTitle");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setUnicodeTitle,"sfRenderWindow_setUnicodeTitle");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setIcon,"sfRenderWindow_setIcon");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setVisible,"sfRenderWindow_setVisible");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setMouseCursorVisible,"sfRenderWindow_setMouseCursorVisible");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setVerticalSyncEnabled,"sfRenderWindow_setVerticalSyncEnabled");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setKeyRepeatEnabled,"sfRenderWindow_setKeyRepeatEnabled");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setActive,"sfRenderWindow_setActive");
        lib.bindSymbol(cast(void**)&sfRenderWindow_display,"sfRenderWindow_display");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setFramerateLimit,"sfRenderWindow_setFramerateLimit");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setJoystickThreshold,"sfRenderWindow_setJoystickThreshold");
        lib.bindSymbol(cast(void**)&sfRenderWindow_getSystemHandle,"sfRenderWindow_getSystemHandle");
        lib.bindSymbol(cast(void**)&sfRenderWindow_clear,"sfRenderWindow_clear");
        lib.bindSymbol(cast(void**)&sfRenderWindow_setView,"sfRenderWindow_setView");
        lib.bindSymbol(cast(void**)&sfRenderWindow_getView,"sfRenderWindow_getView");
        lib.bindSymbol(cast(void**)&sfRenderWindow_getDefaultView,"sfRenderWindow_getDefaultView");
        lib.bindSymbol(cast(void**)&sfRenderWindow_getViewport,"sfRenderWindow_getViewport");
        lib.bindSymbol(cast(void**)&sfRenderWindow_mapPixelToCoords,"sfRenderWindow_mapPixelToCoords");
        lib.bindSymbol(cast(void**)&sfRenderWindow_mapCoordsToPixel,"sfRenderWindow_mapCoordsToPixel");
        lib.bindSymbol(cast(void**)&sfRenderWindow_drawSprite,"sfRenderWindow_drawSprite");
        lib.bindSymbol(cast(void**)&sfRenderWindow_drawText,"sfRenderWindow_drawText");
        lib.bindSymbol(cast(void**)&sfRenderWindow_drawShape,"sfRenderWindow_drawShape");
        lib.bindSymbol(cast(void**)&sfRenderWindow_drawCircleShape,"sfRenderWindow_drawCircleShape");
        lib.bindSymbol(cast(void**)&sfRenderWindow_drawConvexShape,"sfRenderWindow_drawConvexShape");
        lib.bindSymbol(cast(void**)&sfRenderWindow_drawRectangleShape,"sfRenderWindow_drawRectangleShape");
        lib.bindSymbol(cast(void**)&sfRenderWindow_drawVertexArray,"sfRenderWindow_drawVertexArray");
        lib.bindSymbol(cast(void**)&sfRenderWindow_drawPrimitives,"sfRenderWindow_drawPrimitives");
        lib.bindSymbol(cast(void**)&sfRenderWindow_pushGLStates,"sfRenderWindow_pushGLStates");
        lib.bindSymbol(cast(void**)&sfRenderWindow_popGLStates,"sfRenderWindow_popGLStates");
        lib.bindSymbol(cast(void**)&sfRenderWindow_resetGLStates,"sfRenderWindow_resetGLStates");
        lib.bindSymbol(cast(void**)&sfRenderWindow_capture,"sfRenderWindow_capture");
        lib.bindSymbol(cast(void**)&sfMouse_getPositionRenderWindow,"sfMouse_getPositionRenderWindow");
        lib.bindSymbol(cast(void**)&sfMouse_setPositionRenderWindow,"sfMouse_setPositionRenderWindow");
        lib.bindSymbol(cast(void**)&sfShader_createFromFile,"sfShader_createFromFile");
        lib.bindSymbol(cast(void**)&sfShader_createFromMemory,"sfShader_createFromMemory");
        lib.bindSymbol(cast(void**)&sfShader_createFromStream,"sfShader_createFromStream");
        lib.bindSymbol(cast(void**)&sfShader_destroy,"sfShader_destroy");
        lib.bindSymbol(cast(void**)&sfShader_setFloatParameter,"sfShader_setFloatParameter");
        lib.bindSymbol(cast(void**)&sfShader_setFloat2Parameter,"sfShader_setFloat2Parameter");
        lib.bindSymbol(cast(void**)&sfShader_setFloat3Parameter,"sfShader_setFloat3Parameter");
        lib.bindSymbol(cast(void**)&sfShader_setFloat4Parameter,"sfShader_setFloat4Parameter");
        lib.bindSymbol(cast(void**)&sfShader_setVector2Parameter,"sfShader_setVector2Parameter");
        lib.bindSymbol(cast(void**)&sfShader_setVector3Parameter,"sfShader_setVector3Parameter");
        lib.bindSymbol(cast(void**)&sfShader_setColorParameter,"sfShader_setColorParameter");
        lib.bindSymbol(cast(void**)&sfShader_setTransformParameter,"sfShader_setTransformParameter");
        lib.bindSymbol(cast(void**)&sfShader_setTextureParameter,"sfShader_setTextureParameter");
        lib.bindSymbol(cast(void**)&sfShader_setCurrentTextureParameter,"sfShader_setCurrentTextureParameter");
        lib.bindSymbol(cast(void**)&sfShader_isAvailable,"sfShader_isAvailable");
        lib.bindSymbol(cast(void**)&sfShape_create,"sfShape_create");
        lib.bindSymbol(cast(void**)&sfShape_destroy,"sfShape_destroy");
        lib.bindSymbol(cast(void**)&sfShape_setPosition,"sfShape_setPosition");
        lib.bindSymbol(cast(void**)&sfShape_setRotation,"sfShape_setRotation");
        lib.bindSymbol(cast(void**)&sfShape_setScale,"sfShape_setScale");
        lib.bindSymbol(cast(void**)&sfShape_setOrigin,"sfShape_setOrigin");
        lib.bindSymbol(cast(void**)&sfShape_getPosition,"sfShape_getPosition");
        lib.bindSymbol(cast(void**)&sfShape_getRotation,"sfShape_getRotation");
        lib.bindSymbol(cast(void**)&sfShape_getScale,"sfShape_getScale");
        lib.bindSymbol(cast(void**)&sfShape_getOrigin,"sfShape_getOrigin");
        lib.bindSymbol(cast(void**)&sfShape_move,"sfShape_move");
        lib.bindSymbol(cast(void**)&sfShape_rotate,"sfShape_rotate");
        lib.bindSymbol(cast(void**)&sfShape_scale,"sfShape_scale");
        lib.bindSymbol(cast(void**)&sfShape_getTransform,"sfShape_getTransform");
        lib.bindSymbol(cast(void**)&sfShape_getInverseTransform,"sfShape_getInverseTransform");
        lib.bindSymbol(cast(void**)&sfShape_setTexture,"sfShape_setTexture");
        lib.bindSymbol(cast(void**)&sfShape_setTextureRect,"sfShape_setTextureRect");
        lib.bindSymbol(cast(void**)&sfShape_setFillColor,"sfShape_setFillColor");
        lib.bindSymbol(cast(void**)&sfShape_setOutlineColor,"sfShape_setOutlineColor");
        lib.bindSymbol(cast(void**)&sfShape_setOutlineThickness,"sfShape_setOutlineThickness");
        lib.bindSymbol(cast(void**)&sfShape_getTexture,"sfShape_getTexture");
        lib.bindSymbol(cast(void**)&sfShape_getTextureRect,"sfShape_getTextureRect");
        lib.bindSymbol(cast(void**)&sfShape_getFillColor,"sfShape_getFillColor");
        lib.bindSymbol(cast(void**)&sfShape_getOutlineColor,"sfShape_getOutlineColor");
        lib.bindSymbol(cast(void**)&sfShape_getOutlineThickness,"sfShape_getOutlineThickness");
        lib.bindSymbol(cast(void**)&sfShape_getPointCount,"sfShape_getPointCount");
        lib.bindSymbol(cast(void**)&sfShape_getPoint,"sfShape_getPoint");
        lib.bindSymbol(cast(void**)&sfShape_getLocalBounds,"sfShape_getLocalBounds");
        lib.bindSymbol(cast(void**)&sfShape_getGlobalBounds,"sfShape_getGlobalBounds");
        lib.bindSymbol(cast(void**)&sfShape_update,"sfShape_update");
        lib.bindSymbol(cast(void**)&sfSprite_create,"sfSprite_create");
        lib.bindSymbol(cast(void**)&sfSprite_copy,"sfSprite_copy");
        lib.bindSymbol(cast(void**)&sfSprite_destroy,"sfSprite_destroy");
        lib.bindSymbol(cast(void**)&sfSprite_setPosition,"sfSprite_setPosition");
        lib.bindSymbol(cast(void**)&sfSprite_setRotation,"sfSprite_setRotation");
        lib.bindSymbol(cast(void**)&sfSprite_setScale,"sfSprite_setScale");
        lib.bindSymbol(cast(void**)&sfSprite_setOrigin,"sfSprite_setOrigin");
        lib.bindSymbol(cast(void**)&sfSprite_getPosition,"sfSprite_getPosition");
        lib.bindSymbol(cast(void**)&sfSprite_getRotation,"sfSprite_getRotation");
        lib.bindSymbol(cast(void**)&sfSprite_getScale,"sfSprite_getScale");
        lib.bindSymbol(cast(void**)&sfSprite_getOrigin,"sfSprite_getOrigin");
        lib.bindSymbol(cast(void**)&sfSprite_move,"sfSprite_move");
        lib.bindSymbol(cast(void**)&sfSprite_rotate,"sfSprite_rotate");
        lib.bindSymbol(cast(void**)&sfSprite_scale,"sfSprite_scale");
        lib.bindSymbol(cast(void**)&sfSprite_getTransform,"sfSprite_getTransform");
        lib.bindSymbol(cast(void**)&sfSprite_getInverseTransform,"sfSprite_getInverseTransform");
        lib.bindSymbol(cast(void**)&sfSprite_setTexture,"sfSprite_setTexture");
        lib.bindSymbol(cast(void**)&sfSprite_setTextureRect,"sfSprite_setTextureRect");
        lib.bindSymbol(cast(void**)&sfSprite_setColor,"sfSprite_setColor");
        lib.bindSymbol(cast(void**)&sfSprite_getTexture,"sfSprite_getTexture");
        lib.bindSymbol(cast(void**)&sfSprite_getTextureRect,"sfSprite_getTextureRect");
        lib.bindSymbol(cast(void**)&sfSprite_getColor,"sfSprite_getColor");
        lib.bindSymbol(cast(void**)&sfSprite_getLocalBounds,"sfSprite_getLocalBounds");
        lib.bindSymbol(cast(void**)&sfSprite_getGlobalBounds,"sfSprite_getGlobalBounds");
        lib.bindSymbol(cast(void**)&sfText_create,"sfText_create");
        lib.bindSymbol(cast(void**)&sfText_copy,"sfText_copy");
        lib.bindSymbol(cast(void**)&sfText_destroy,"sfText_destroy");
        lib.bindSymbol(cast(void**)&sfText_setPosition,"sfText_setPosition");
        lib.bindSymbol(cast(void**)&sfText_setRotation,"sfText_setRotation");
        lib.bindSymbol(cast(void**)&sfText_setScale,"sfText_setScale");
        lib.bindSymbol(cast(void**)&sfText_setOrigin,"sfText_setOrigin");
        lib.bindSymbol(cast(void**)&sfText_getPosition,"sfText_getPosition");
        lib.bindSymbol(cast(void**)&sfText_getRotation,"sfText_getRotation");
        lib.bindSymbol(cast(void**)&sfText_getScale,"sfText_getScale");
        lib.bindSymbol(cast(void**)&sfText_getOrigin,"sfText_getOrigin");
        lib.bindSymbol(cast(void**)&sfText_move,"sfText_move");
        lib.bindSymbol(cast(void**)&sfText_rotate,"sfText_rotate");
        lib.bindSymbol(cast(void**)&sfText_scale,"sfText_scale");
        lib.bindSymbol(cast(void**)&sfText_getTransform,"sfText_getTransform");
        lib.bindSymbol(cast(void**)&sfText_getInverseTransform,"sfText_getInverseTransform");
        lib.bindSymbol(cast(void**)&sfText_setString,"sfText_setString");
        lib.bindSymbol(cast(void**)&sfText_setUnicodeString,"sfText_setUnicodeString");
        lib.bindSymbol(cast(void**)&sfText_setFont,"sfText_setFont");
        lib.bindSymbol(cast(void**)&sfText_setCharacterSize,"sfText_setCharacterSize");
        lib.bindSymbol(cast(void**)&sfText_setStyle,"sfText_setStyle");
        lib.bindSymbol(cast(void**)&sfText_setColor,"sfText_setColor");
        lib.bindSymbol(cast(void**)&sfText_getString,"sfText_getString");
        lib.bindSymbol(cast(void**)&sfText_getUnicodeString,"sfText_getUnicodeString");
        lib.bindSymbol(cast(void**)&sfText_getFont,"sfText_getFont");
        lib.bindSymbol(cast(void**)&sfText_getCharacterSize,"sfText_getCharacterSize");
        lib.bindSymbol(cast(void**)&sfText_getStyle,"sfText_getStyle");
        lib.bindSymbol(cast(void**)&sfText_getColor,"sfText_getColor");
        lib.bindSymbol(cast(void**)&sfText_findCharacterPos,"sfText_findCharacterPos");
        lib.bindSymbol(cast(void**)&sfText_getLocalBounds,"sfText_getLocalBounds");
        lib.bindSymbol(cast(void**)&sfText_getGlobalBounds,"sfText_getGlobalBounds");
        lib.bindSymbol(cast(void**)&sfTexture_create,"sfTexture_create");
        lib.bindSymbol(cast(void**)&sfTexture_createFromFile,"sfTexture_createFromFile");
        lib.bindSymbol(cast(void**)&sfTexture_createFromMemory,"sfTexture_createFromMemory");
        lib.bindSymbol(cast(void**)&sfTexture_createFromStream,"sfTexture_createFromStream");
        lib.bindSymbol(cast(void**)&sfTexture_createFromImage,"sfTexture_createFromImage");
        lib.bindSymbol(cast(void**)&sfTexture_copy,"sfTexture_copy");
        lib.bindSymbol(cast(void**)&sfTexture_destroy,"sfTexture_destroy");
        lib.bindSymbol(cast(void**)&sfTexture_getSize,"sfTexture_getSize");
        lib.bindSymbol(cast(void**)&sfTexture_copyToImage,"sfTexture_copyToImage");
        lib.bindSymbol(cast(void**)&sfTexture_updateFromPixels,"sfTexture_updateFromPixels");
        lib.bindSymbol(cast(void**)&sfTexture_updateFromImage,"sfTexture_updateFromImage");
        lib.bindSymbol(cast(void**)&sfTexture_updateFromWindow,"sfTexture_updateFromWindow");
        lib.bindSymbol(cast(void**)&sfTexture_updateFromRenderWindow,"sfTexture_updateFromRenderWindow");
        lib.bindSymbol(cast(void**)&sfTexture_isSmooth,"sfTexture_isSmooth");
        lib.bindSymbol(cast(void**)&sfTexture_setSmooth,"sfTexture_setSmooth");
        lib.bindSymbol(cast(void**)&sfTexture_setRepeated,"sfTexture_setRepeated");
        lib.bindSymbol(cast(void**)&sfTexture_isRepeated,"sfTexture_isRepeated");
        lib.bindSymbol(cast(void**)&sfTexture_bind,"sfTexture_bind");
        lib.bindSymbol(cast(void**)&sfTexture_getMaximumSize,"sfTexture_getMaximumSize");
        lib.bindSymbol(cast(void**)&sfTransform_fromMatrix,"sfTransform_fromMatrix");
        lib.bindSymbol(cast(void**)&sfTransform_getMatrix,"sfTransform_getMatrix");
        lib.bindSymbol(cast(void**)&sfTransform_getInverse,"sfTransform_getInverse");
        lib.bindSymbol(cast(void**)&sfTransform_transformPoint,"sfTransform_transformPoint");
        lib.bindSymbol(cast(void**)&sfTransform_transformRect,"sfTransform_transformRect");
        lib.bindSymbol(cast(void**)&sfTransform_combine,"sfTransform_combine");
        lib.bindSymbol(cast(void**)&sfTransform_translate,"sfTransform_translate");
        lib.bindSymbol(cast(void**)&sfTransform_rotate,"sfTransform_rotate");
        lib.bindSymbol(cast(void**)&sfTransform_rotateWithCenter,"sfTransform_rotateWithCenter");
        lib.bindSymbol(cast(void**)&sfTransform_scale,"sfTransform_scale");
        lib.bindSymbol(cast(void**)&sfTransform_scaleWithCenter,"sfTransform_scaleWithCenter");
        lib.bindSymbol(cast(void**)&sfTransformable_create,"sfTransformable_create");
        lib.bindSymbol(cast(void**)&sfTransformable_copy,"sfTransformable_copy");
        lib.bindSymbol(cast(void**)&sfTransformable_destroy,"sfTransformable_destroy");
        lib.bindSymbol(cast(void**)&sfTransformable_setPosition,"sfTransformable_setPosition");
        lib.bindSymbol(cast(void**)&sfTransformable_setRotation,"sfTransformable_setRotation");
        lib.bindSymbol(cast(void**)&sfTransformable_setScale,"sfTransformable_setScale");
        lib.bindSymbol(cast(void**)&sfTransformable_setOrigin,"sfTransformable_setOrigin");
        lib.bindSymbol(cast(void**)&sfTransformable_getPosition,"sfTransformable_getPosition");
        lib.bindSymbol(cast(void**)&sfTransformable_getRotation,"sfTransformable_getRotation");
        lib.bindSymbol(cast(void**)&sfTransformable_getScale,"sfTransformable_getScale");
        lib.bindSymbol(cast(void**)&sfTransformable_getOrigin,"sfTransformable_getOrigin");
        lib.bindSymbol(cast(void**)&sfTransformable_move,"sfTransformable_move");
        lib.bindSymbol(cast(void**)&sfTransformable_rotate,"sfTransformable_rotate");
        lib.bindSymbol(cast(void**)&sfTransformable_scale,"sfTransformable_scale");
        lib.bindSymbol(cast(void**)&sfTransformable_getTransform,"sfTransformable_getTransform");
        lib.bindSymbol(cast(void**)&sfTransformable_getInverseTransform,"sfTransformable_getInverseTransform");
        lib.bindSymbol(cast(void**)&sfVertexArray_create,"sfVertexArray_create");
        lib.bindSymbol(cast(void**)&sfVertexArray_copy,"sfVertexArray_copy");
        lib.bindSymbol(cast(void**)&sfVertexArray_destroy,"sfVertexArray_destroy");
        lib.bindSymbol(cast(void**)&sfVertexArray_getVertexCount,"sfVertexArray_getVertexCount");
        lib.bindSymbol(cast(void**)&sfVertexArray_getVertex,"sfVertexArray_getVertex");
        lib.bindSymbol(cast(void**)&sfVertexArray_clear,"sfVertexArray_clear");
        lib.bindSymbol(cast(void**)&sfVertexArray_resize,"sfVertexArray_resize");
        lib.bindSymbol(cast(void**)&sfVertexArray_append,"sfVertexArray_append");
        lib.bindSymbol(cast(void**)&sfVertexArray_setPrimitiveType,"sfVertexArray_setPrimitiveType");
        lib.bindSymbol(cast(void**)&sfVertexArray_getPrimitiveType,"sfVertexArray_getPrimitiveType");
        lib.bindSymbol(cast(void**)&sfVertexArray_getBounds,"sfVertexArray_getBounds");
        lib.bindSymbol(cast(void**)&sfView_create,"sfView_create");
        lib.bindSymbol(cast(void**)&sfView_createFromRect,"sfView_createFromRect");
        lib.bindSymbol(cast(void**)&sfView_copy,"sfView_copy");
        lib.bindSymbol(cast(void**)&sfView_destroy,"sfView_destroy");
        lib.bindSymbol(cast(void**)&sfView_setCenter,"sfView_setCenter");
        lib.bindSymbol(cast(void**)&sfView_setSize,"sfView_setSize");
        lib.bindSymbol(cast(void**)&sfView_setRotation,"sfView_setRotation");
        lib.bindSymbol(cast(void**)&sfView_setViewport,"sfView_setViewport");
        lib.bindSymbol(cast(void**)&sfView_reset,"sfView_reset");
        lib.bindSymbol(cast(void**)&sfView_getCenter,"sfView_getCenter");
        lib.bindSymbol(cast(void**)&sfView_getSize,"sfView_getSize");
        lib.bindSymbol(cast(void**)&sfView_getRotation,"sfView_getRotation");
        lib.bindSymbol(cast(void**)&sfView_getViewport,"sfView_getViewport");
        lib.bindSymbol(cast(void**)&sfView_move,"sfView_move");
        lib.bindSymbol(cast(void**)&sfView_rotate,"sfView_rotate");
        lib.bindSymbol(cast(void**)&sfView_zoom,"sfView_zoom");

        if(errorCount() != errCount) return SFMLSupport.badLibrary;
        else loadedVersion = sfmlSupport.sfml200;

        static if(sfmlSupport >= SFMLSupport.sfml220) {
            lib.bindSymbol(cast(void**)&sfFont_getUnderlinePosition,"sfFont_getUnderlinePosition");
            lib.bindSymbol(cast(void**)&sfFont_getUnderlineThickness,"sfFont_getUnderlineThickness");
            lib.bindSymbol(cast(void**)&sfFont_getInfo,"sfFont_getInfo");
            lib.bindSymbol(cast(void**)&sfRenderWindow_requestFocus,"sfRenderWindow_requestFocus");
            lib.bindSymbol(cast(void**)&sfRenderWindow_hasFocus,"sfRenderWindow_hasFocus");
            lib.bindSymbol(cast(void**)&sfTouch_getPositionRenderWindow,"sfTouch_getPositionRenderWindow");

            if(errorCount() != errCount) return SFMLSupport.badLibrary;
            else loadedVersion = sfmlSupport.sfml220;
        }
        static if(sfmlSupport >= SFMLSupport.sfml230) {
            lib.bindSymbol(cast(void**)&sfColor_fromInteger,"sfColor_fromInteger");
            lib.bindSymbol(cast(void**)&sfColor_toInteger,"sfColor_toInteger");
            lib.bindSymbol(cast(void**)&sfColor_subtract,"sfColor_subtract");
            lib.bindSymbol(cast(void**)&sfShader_getNativeHandle,"sfShader_getNativeHandle");
            lib.bindSymbol(cast(void**)&sfTexture_getNativeHandle,"sfTexture_getNativeHandle");

            if(errorCount() != errCount) return SFMLSupport.badLibrary;
            else loadedVersion = sfmlSupport.sfml230;
        }
        static if(sfmlSupport >= SFMLSupport.sfml240) {
            lib.bindSymbol(cast(void**)&sfRenderTexture_generateMipmap,"sfRenderTexture_generateMipmap");
            lib.bindSymbol(cast(void**)&sfRenderWindow_setMouseCursorGrabbed,"sfRenderWindow_setMouseCursorGrabbed");
            lib.bindSymbol(cast(void**)&sfShader_setVec2Uniform,"sfShader_setVec2Uniform");
            lib.bindSymbol(cast(void**)&sfShader_setVec3Uniform,"sfShader_setVec3Uniform");
            lib.bindSymbol(cast(void**)&sfShader_setVec4Uniform,"sfShader_setVec4Uniform");
            lib.bindSymbol(cast(void**)&sfShader_setColorUniform,"sfShader_setColorUniform");
            lib.bindSymbol(cast(void**)&sfShader_setIntUniform,"sfShader_setIntUniform");
            lib.bindSymbol(cast(void**)&sfShader_setIvec2Uniform,"sfShader_setIvec2Uniform");
            lib.bindSymbol(cast(void**)&sfShader_setIvec3Uniform,"sfShader_setIvec3Uniform");
            lib.bindSymbol(cast(void**)&sfShader_setIvec4Uniform,"sfShader_setIvec4Uniform");
            lib.bindSymbol(cast(void**)&sfShader_setIntColorUniform,"sfShader_setIntColorUniform");
            lib.bindSymbol(cast(void**)&sfShader_setBoolUniform,"sfShader_setBoolUniform");
            lib.bindSymbol(cast(void**)&sfShader_setBvec2Uniform,"sfShader_setBvec2Uniform");
            lib.bindSymbol(cast(void**)&sfShader_setBvec3Uniform,"sfShader_setBvec3Uniform");
            lib.bindSymbol(cast(void**)&sfShader_setBvec4Uniform,"sfShader_setBvec4Uniform");
            lib.bindSymbol(cast(void**)&sfShader_setMat3Uniform,"sfShader_setMat3Uniform");
            lib.bindSymbol(cast(void**)&sfShader_setMat4Uniform,"sfShader_setMat4Uniform");
            lib.bindSymbol(cast(void**)&sfShader_setTextureUniform,"sfShader_setTextureUniform");
            lib.bindSymbol(cast(void**)&sfShader_setCurrentTextureUniform,"sfShader_setCurrentTextureUniform");
            lib.bindSymbol(cast(void**)&sfShader_setFloatUniformArray,"sfShader_setFloatUniformArray");
            lib.bindSymbol(cast(void**)&sfShader_setVec2UniformArray,"sfShader_setVec2UniformArray");
            lib.bindSymbol(cast(void**)&sfShader_setVec3UniformArray,"sfShader_setVec3UniformArray");
            lib.bindSymbol(cast(void**)&sfShader_setVec4UniformArray,"sfShader_setVec4UniformArray");
            lib.bindSymbol(cast(void**)&sfShader_setMat3UniformArray,"sfShader_setMat3UniformArray");
            lib.bindSymbol(cast(void**)&sfShader_setMat4UniformArray,"sfShader_setMat4UniformArray");
            lib.bindSymbol(cast(void**)&sfShader_isGeometryAvailable,"sfShader_isGeometryAvailable");
            lib.bindSymbol(cast(void**)&sfText_setFillColor,"sfText_setFillColor");
            lib.bindSymbol(cast(void**)&sfText_setOutlineColor,"sfText_setOutlineColor");
            lib.bindSymbol(cast(void**)&sfText_setOutlineThickness,"sfText_setOutlineThickness");
            lib.bindSymbol(cast(void**)&sfText_getFillColor,"sfText_getFillColor");
            lib.bindSymbol(cast(void**)&sfText_getOutlineColor,"sfText_getOutlineColor");
            lib.bindSymbol(cast(void**)&sfText_getOutlineThickness,"sfText_getOutlineThickness");
            lib.bindSymbol(cast(void**)&sfTexture_setSrgb,"sfTexture_setSrgb");
            lib.bindSymbol(cast(void**)&sfTexture_isSrgb,"sfTexture_isSrgb");
            lib.bindSymbol(cast(void**)&sfTexture_generateMipmap,"sfTexture_generateMipmap");

            if(errorCount() != errCount) return SFMLSupport.badLibrary;
            else loadedVersion = sfmlSupport.sfml240;
        }
        static if(sfmlSupport >= SFMLSupport.sfml250) {
            lib.bindSymbol(cast(void**)&sfRenderTexture_createWithSettings,"sfRenderTexture_createWithSettings");
            lib.bindSymbol(cast(void**)&sfRenderTexture_drawVertexBuffer,"sfRenderTexture_drawVertexBuffer");
            lib.bindSymbol(cast(void**)&sfRenderTexture_getMaximumAntialiasingLevel,"sfRenderTexture_getMaximumAntialiasingLevel");
            lib.bindSymbol(cast(void**)&sfRenderWindow_setMouseCursor,"sfRenderWindow_setMouseCursor");
            lib.bindSymbol(cast(void**)&sfRenderWindow_drawVertexBuffer,"sfRenderWindow_drawVertexBuffer");
            lib.bindSymbol(cast(void**)&sfText_getLineSpacing,"sfText_getLineSpacing");
            lib.bindSymbol(cast(void**)&sfText_setLetterSpacing,"sfText_setLetterSpacing");
            lib.bindSymbol(cast(void**)&sfText_getLetterSpacing,"sfText_getLetterSpacing");
            lib.bindSymbol(cast(void**)&sfText_getLineSpacing,"sfText_getLineSpacing");
            lib.bindSymbol(cast(void**)&sfTexture_swap,"sfTexture_swap");
            lib.bindSymbol(cast(void**)&sfTransform_equal,"sfTransform_equal");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_create,"sfVertexBuffer_create");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_copy,"sfVertexBuffer_copy");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_destroy,"sfVertexBuffer_destroy");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_getVertexCount,"sfVertexBuffer_getVertexCount");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_update,"sfVertexBuffer_update");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_updateFromVertexBuffer,"sfVertexBuffer_updateFromVertexBuffer");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_swap,"sfVertexBuffer_swap");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_swap,"sfVertexBuffer_swap");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_setPrimitiveType,"sfVertexBuffer_setPrimitiveType");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_getPrimitiveType,"sfVertexBuffer_getPrimitiveType");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_setUsage,"sfVertexBuffer_setUsage");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_getUsage,"sfVertexBuffer_getUsage");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_bind,"sfVertexBuffer_bind");
            lib.bindSymbol(cast(void**)&sfVertexBuffer_isAvailable,"sfVertexBuffer_isAvailable");

            if(errorCount() != errCount) return SFMLSupport.badLibrary;
            else loadedVersion = sfmlSupport.sfml250;
        }
        return loadedVersion;
    }
}

