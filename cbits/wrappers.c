#import <SDL2/SDL.h>
#import <SDL2/SDL_ttf.h>
#import "wrappers.h"

SDL_Surface *TTF_RenderText_Solid_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg) {
    return TTF_RenderText_Solid(font, text, *fg);
}
