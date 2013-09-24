#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>

SDL_Surface *TTF_RenderText_Solid_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg);
SDL_Surface *TTF_RenderUTF8_Solid_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg);
SDL_Surface *TTF_RenderGlyph_Solid_Ptrd(TTF_Font *font, Uint16 ch, SDL_Color *fg);

SDL_Surface *TTF_RenderText_Shaded_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg, SDL_Color *bg);
SDL_Surface *TTF_RenderUTF8_Shaded_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg, SDL_Color *bg);
SDL_Surface *TTF_RenderGlyph_Shaded_Ptrd(TTF_Font *font, Uint16 ch, SDL_Color *fg, SDL_Color *bg);

SDL_Surface *TTF_RenderText_Blended_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg);
SDL_Surface *TTF_RenderUTF8_Blended_Ptrd(TTF_Font *font, const char *text, SDL_Color *fg);
SDL_Surface *TTF_RenderGlyph_Blended_Ptrd(TTF_Font *font, Uint16 ch, SDL_Color *fg);
