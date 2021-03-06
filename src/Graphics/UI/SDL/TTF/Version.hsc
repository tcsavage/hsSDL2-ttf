-----------------------------------------------------------------------------
-- |
-- Module      :  Graphics.UI.SDL.TTF.Types
-- Copyright   :  (c) David Himmelstrup 2005
-- License     :  BSD-like
--
-- Maintainer  :  Tom Savage <tcsavage@gmail.com>
-- Stability   :  provisional
-- Portability :  portable
--
-----------------------------------------------------------------------------

{-# LANGUAGE CPP, ForeignFunctionInterface #-}

module Graphics.UI.SDL.TTF.Version
    ( compiledFor
    , linkedWith
    ) where

#include <SDL2/SDL_ttf.h>

import Data.Version (Version(Version))

import Foreign (Word8, Ptr, Storable(sizeOf, alignment, peekByteOff, peek))

data SDLVersion
    = SDLVersion Word8 Word8 Word8

instance Storable SDLVersion where
    sizeOf _ = #{size SDL_version}
    alignment _ = 1
    peek ptr = do major <- #{peek SDL_version, major} ptr
                  minor <- #{peek SDL_version, minor} ptr
                  patch <- #{peek SDL_version, patch} ptr
                  return (SDLVersion major minor patch)

compiledFor :: Version
compiledFor = Version [ #{const TTF_MAJOR_VERSION}
                      , #{const TTF_MINOR_VERSION}
                      , #{const TTF_PATCHLEVEL}
                      ] []

foreign import ccall unsafe "TTF_Linked_Version" sdlLinkedVersion :: IO (Ptr SDLVersion)
linkedWith :: IO Version
linkedWith = do versionPtr <- sdlLinkedVersion
                SDLVersion major minor patch <- peek versionPtr
                return (Version (map fromIntegral [major,minor,patch]) [])
