-----------------------------------------------------------------------------
-- |
-- Module      :  Graphics.UI.SDL.TTF.General
-- Copyright   :  (c) David Himmelstrup 2005
-- License     :  BSD-like
--
-- Maintainer  :  Tom Savage <tcsavage@gmail.com>
-- Stability   :  provisional
-- Portability :  portable
--
-----------------------------------------------------------------------------

{-# LANGUAGE CPP, ForeignFunctionInterface #-}

module Graphics.UI.SDL.TTF.General
    ( init
    , wasInit
    , quit
    , withTTF
    ) where

#include <SDL2/SDL_ttf.h>

import Foreign
import Foreign.C.Types (CInt(..))

-- import Graphics.UI.SDL.General (failWithError)

import Prelude hiding (init)

-- int TTF_Init()
foreign import ccall unsafe "SDL2/SDL_ttf.h TTF_Init" ttfInit :: IO CInt
init :: IO Bool
init = fmap (not.toBool) ttfInit


--int TTF_WasInit()
foreign import ccall unsafe "SDL2/SDL_ttf.h TTF_WasInit" ttfWasInit :: IO CInt
wasInit :: IO Bool
wasInit = fmap toBool ttfWasInit

-- void TTF_Quit()
foreign import ccall unsafe "SDL2/SDL_ttf.h TTF_Quit" quit :: IO ()

withTTF :: IO a -> IO a
withTTF action = do
    init
    x <- action
    quit
    return x
