#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>
#include "wrappers.h"

SDL_Surface *TTF_RenderText_Solid_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg) {
    return TTF_RenderText_Solid(font, text, *fg);
}

SDL_Surface *TTF_RenderUTF8_Solid_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg) {
    return TTF_RenderUTF8_Solid(font, text, *fg);
}

SDL_Surface *TTF_RenderGlyph_Solid_Ptrd(TTF_Font *font, Uint16 ch, SDL_Color *fg) {
    return TTF_RenderGlyph_Solid(font, ch, *fg);
}


SDL_Surface *TTF_RenderText_Shaded_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg, SDL_Color *bg) {
    return TTF_RenderText_Shaded(font, text, *fg, *bg);
}

SDL_Surface *TTF_RenderUTF8_Shaded_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg, SDL_Color *bg) {
    return TTF_RenderUTF8_Shaded(font, text, *fg, *bg);
}

SDL_Surface *TTF_RenderGlyph_Shaded_Ptrd(TTF_Font *font, Uint16 ch, SDL_Color *fg, SDL_Color *bg) {
    return TTF_RenderGlyph_Shaded(font, ch, *fg, *bg);
}


SDL_Surface *TTF_RenderText_Blended_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg) {
    return TTF_RenderText_Blended(font, text, *fg);
}

SDL_Surface *TTF_RenderUTF8_Blended_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg) {
    return TTF_RenderUTF8_Blended(font, text, *fg);
}

SDL_Surface *TTF_RenderGlyph_Blended_Ptrd(TTF_Font *font, Uint16 ch, SDL_Color *fg) {
    return TTF_RenderGlyph_Blended(font, ch, *fg);
}
