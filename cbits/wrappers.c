#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>
#include "wrappers.h"

SDL_Surface *TTF_RenderText_Solid_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg) {
    return TTF_RenderText_Solid(font, text, *fg);
}
