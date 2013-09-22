hsSDL2-ttf
==========

My attempt at porting the old SDL-ttf bindings for SDL 1.2 to SDL 2.

Mac OS X
--------

*Tested on Mountain Lion*

1. [Install Homebrew](http://brew.sh/) if you don't have it already
2. Install SDL C libraries: `brew install sdl2 && brew install sdl2_ttf`
3. Clone [hsSDL2](https://github.com/Lemmih/hsSDL2) and `cabal install` it
4. Clone hsSDL2_ttf and `cabal install` (optionally pass the `-fbuildExamples` flag to cabal-install to install the example programs)
