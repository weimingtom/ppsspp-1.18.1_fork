
D:\ftp\ppsspp-1.18.1_fork-master_r2\ppsspp-1.18.1_fork-master\GPU\Common\PresentationCommon.cpp
FRect GetScreenFrame(float pixelWidth, float pixelHeight) {
CopyToOutput
GPU/Common/FramebufferManagerCommon.cpp
->CoputToOutput

D:\ftp\ppsspp-1.18.1_fork-master_r2\ppsspp-1.18.1_fork-master\SDL\SDLMain.cpp
System_GetPropertyInt
    case SYSPROP_DISPLAY_XRES:
        return g_DesktopWidth;

D:\ftp\ppsspp-1.18.1_fork-master_r2\ppsspp-1.18.1_fork-master\UI\NativeApp.cpp
b ComputeOrthoMatrix
dp_xres
dp_yres
UpdateScreenScale

试试改成软件渲染



oglPlayer_v3_sws_dir_conv.7z
extern int dumpBMPRaw(const char *filename,
    unsigned char * data, unsigned int width, unsigned int height);
https://github.com/weimingtom/game_dino_sdl/blob/0a1fe2f28e280b03a4e124e0c9cfc3021bd3454d/TextureLoader.h#L28
https://github.com/weimingtom/game_dino_vc6/blob/5dcaa0dc0ef71c2f2e19a31bf95b80e1534fff82/TextureLoader.h#L28
https://github.com/TheWatcher/SDL_imagesave
* picPlayer_v3_mod_sdl_code_support_save_yuv.7z
SDL_SaveBMP
https://github.com/driedfruit/SDL_SavePNG
struct VirtualFramebuffer
D:\ftp\compare\ppsspp-1.18.1_fork-master_r3_270\ppsspp-1.18.1_fork-master\GPU\Common\FramebufferManagerCommon.h
->fbo
Draw::Framebuffer *fbo;

class Framebuffer : public RefCountedObject {
D:\ftp\compare\ppsspp-1.18.1_fork-master_r3_270\ppsspp-1.18.1_fork-master\Common\GPU\thin3d.h

D:\ftp\compare\ppsspp-1.18.1_fork-master_r3_270\ppsspp-1.18.1_fork-master\Common\GPU\OpenGL\thin3d_gl.cpp
class OpenGLFramebuffer : public Framebuffer {
public:
    OpenGLFramebuffer(GLRenderManager *render, GLRFramebuffer *framebuffer) : render_(render), framebuffer_(framebuffer) {
        width_ = framebuffer->width;
        height_ = framebuffer->height;
    }
    ~OpenGLFramebuffer() {
        render_->DeleteFramebuffer(framebuffer_);
    }

    GLRenderManager *render_;
    GLRFramebuffer *framebuffer_ = nullptr;
};

D:\ftp\compare\ppsspp-1.18.1_fork-master_r3_270\ppsspp-1.18.1_fork-master\Common\GPU\OpenGL\GLRenderManager.h
class GLRFramebuffer {
class GLRTexture {

D:\ftp\compare\ppsspp-1.18.1_fork-master_r3_270\ppsspp-1.18.1_fork-master\GPU\Common\FramebufferManagerCommon.cpp
    if (vfb->fbo) {
        if (GetUIState() != UISTATE_PAUSEMENU) {
            if (Core_IsStepping())
                VERBOSE_LOG(Log::FrameBuf, "Displaying FBO %08x", vfb->fb_address);
            else
                DEBUG_LOG(Log::FrameBuf, "Displaying FBO %08x", vfb->fb_address);
        }
        float u0 = offsetX / (float)vfb->bufferWidth;
        float v0 = offsetY / (float)vfb->bufferHeight;
        float u1 = (480.0f + offsetX) / (float)vfb->bufferWidth;
        float v1 = (272.0f + offsetY) / (float)vfb->bufferHeight;

D:\ftp\compare\ppsspp-1.18.1_fork-master_r3_270\ppsspp-1.18.1_fork-master\GPU\ge_constants.h
enum GEBufferFormat : uint8_t {
    GE_FORMAT_565 = 0,
    GE_FORMAT_5551 = 1,
    GE_FORMAT_4444 = 2,
    GE_FORMAT_8888 = 3,
    GE_FORMAT_DEPTH16 = 4,  // Virtual format, just used to pass into Depal
    GE_FORMAT_CLUT8 = 5,    // Virtual format, for pre-decoded static textures with dynamic CLUT
    GE_FORMAT_INVALID = 0xFF,
};

here return fbo???
vfb = new VirtualFramebuffer();
D:\ftp\compare\ppsspp-1.18.1_fork-master_r3_270\ppsspp-1.18.1_fork-master\GPU\Common\FramebufferManagerCommon.cpp
VirtualFramebuffer *FramebufferManagerCommon::ResolveFramebufferColorToFormat(VirtualFramebuffer *src, GEBufferFormat newFormat) {
?????, line 3615
vfb->fbo = draw_->CreateFramebuffer({ vfb->renderWidth, vfb->renderHeight, 1, GetFramebufferLayers(), 0, true, tag });
see ???D:\ftp\compare\ppsspp-1.18.1_fork-master_r3_270\ppsspp-1.18.1_fork-master\Common\GPU\thin3d.h
    int Width() const { return width_; }
    int Height() const { return height_; }


GPU/common/TextureCacheCommon.cpp
GetCurrentFramebufferTextureDebug

GetOutputFramebuffer
D:\ftp\ppsspp-1.18.1_fork-master_r7_display_top_half\ppsspp-1.18.1_fork-master\GPU\Common\FramebufferManagerCommon.cpp
bool GetOutputFramebuffer(Draw::DrawContext *draw, GPUDebugBuffer &buffer) {
D:\ftp\ppsspp-1.18.1_fork-master_r7_display_top_half\ppsspp-1.18.1_fork-master\Core\Screenshot.cpp
bool TakeGameScreenshot(Draw::DrawContext *draw, const Path &filename, ScreenshotFormat fmt, ScreenshotType type, int *width, int *height, int maxRes) {


D:\ftp\ppsspp-1.18.1_fork-master_r7_display_top_half\ppsspp-1.18.1_fork-master\Common\GPU\OpenGL\GLRenderManager.cpp
void GLRenderManager::BlitFramebuffer(GLRFramebuffer *src, GLRect2D srcRect, GLRFramebuffer *dst, GLRect2D dstRect, int aspectMask, bool filter, const char *tag) {

b GLRenderManager::BlitFramebuffer


fbo用法
https://zhuanlan.zhihu.com/p/12078327088


D:\ftp\ppsspp-1.18.1_fork-master_r7_display_top_half\ppsspp-1.18.1_fork-master\Common\GPU\OpenGL\GLQueueRunner.cpp
L578:
glFramebufferTexture2D
void GLQueueRunner::InitCreateFramebuffer(const GLRInitStep &step) {
glTexImage2D
glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 800, 600, 0, GL_RGB, GL_UNSIGNED_BYTE, nullptr);
    



UISTATE_INGAME
if (GetUIState() != UISTATE_INGAME) {
D:\ftp\ppsspp-1.18.1_fork-master_r11_def\ppsspp-1.18.1_fork-master\Core\System.h
enum GlobalUIState {
    UISTATE_MENU,
    UISTATE_PAUSEMENU,
    UISTATE_INGAME,
    UISTATE_EXIT,
    UISTATE_EXCEPTION,
};
UpdateUIState(UISTATE_PAUSEMENU);
D:\ftp\ppsspp-1.18.1_fork-master_r11_def\ppsspp-1.18.1_fork-master\Core\System.cpp
void UpdateUIState(GlobalUIState newState) {
UI/NativeApp.cpp


D:\ftp\ppsspp-1.18.1_fork-master_r11_def\ppsspp-1.18.1_fork-master\UI\DisplayLayoutScreen.cpp
        static const char *displayRotation[] = { "Landscape", "Portrait", "Landscape Reversed", "Portrait Reversed" };
        auto rotation = new PopupMultiChoice(&g_Config.iInternalScreenRotation, gr->T("Rotation"), displayRotation, 1, ARRAY_SIZE(displayRotation), I18NCat::CONTROLS, screenManager());
iInternalScreenRotation
D:\ftp\ppsspp-1.18.1_fork-master_r11_def\ppsspp-1.18.1_fork-master\GPU\Common\FramebufferManagerCommon.cpp
int uvRotation = useBufferedRendering_ ? g_Config.iInternalScreenRotation : ROTATION_LOCKED_HORIZONTAL;
D:\ftp\ppsspp-1.18.1_fork-master_r11_def\ppsspp-1.18.1_fork-master\Core\ConfigValues.h
enum {
    ROTATION_AUTO = 0,
    ROTATION_LOCKED_HORIZONTAL = 1,
    ROTATION_LOCKED_VERTICAL = 2,
    ROTATION_LOCKED_HORIZONTAL180 = 3,
    ROTATION_LOCKED_VERTICAL180 = 4,
    ROTATION_AUTO_HORIZONTAL = 5,
};

