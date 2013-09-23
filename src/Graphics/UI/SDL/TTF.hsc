{-# LANGUAGE CPP, ForeignFunctionInterface, DeriveDataTypeable #-}

module Graphics.UI.SDL.TTF
( withTTF
, Font
, Hint (..)
, openFont
, closeFont
, setFontHinting
, renderTextSolid
, renderTextBlended
, sizeText
) where

import Control.Applicative
import Control.Exception
import Control.Monad
import Data.Maybe
import Data.Typeable
import Foreign
import Foreign.C.String
import Foreign.C.Types
import Foreign.ForeignPtr.Safe
import Foreign.Marshal.Alloc
import Foreign.Marshal.Utils
import Foreign.Ptr

import qualified Graphics.UI.SDL as SDL

#include <SDL2/SDL_ttf.h>
#include "wrappers.h"

data SDLTTFException = InitFail String
                     | Other String
                     deriving (Show, Typeable)

instance Exception SDLTTFException

foreign import ccall safe "SDL2/SDL_ttf.h TTF_Init"
    c_ttf_init :: IO CInt

ttfInit :: IO ()
ttfInit = do
    e <- c_ttf_init
    case e of 0 -> return ()  -- Success!
              (-1) -> do err <- SDL.getError
                         throwIO $ InitFail (fromMaybe "Unknown" err)
              otherwise -> throwIO $ Other "Unknown return value from 'ttfInit'"

foreign import ccall safe "SDL2/SDL_ttf.h TTF_Quit"
    c_ttf_quit :: IO ()

ttfQuit :: IO ()
ttfQuit = c_ttf_quit

withTTF :: IO a -> IO a
withTTF action = do
    ttfInit
    x <- action
    ttfQuit
    return x

type FontStruct = ()

newtype Font = WrapFont { unwrapFont :: ForeignPtr FontStruct }

foreign import ccall safe "SDL2/SDL_ttf.h TTF_OpenFont"
    c_ttf_open_font :: CString -> CInt -> IO (Ptr FontStruct)

foreign import ccall safe "SDL2/SDL_ttf.h &TTF_CloseFont"
    c_ttf_close_font_ptr :: FunPtr (Ptr FontStruct -> IO ())

foreign import ccall safe "SDL2/SDL_ttf.h TTF_CloseFont"
    c_ttf_close_font :: Ptr FontStruct -> IO ()

openFont :: String -> Int -> IO Font
openFont file size = do
    csfile <- newCString file
    ptr <- c_ttf_open_font csfile (toEnum size)
    --WrapFont <$> newForeignPtr c_ttf_close_font ptr
    WrapFont <$> newForeignPtr_ ptr

closeFont :: Font -> IO ()
closeFont (WrapFont f) = withForeignPtr f c_ttf_close_font

foreign import ccall safe "SDL2/SDL_ttf.h TTF_RenderText_Solid_Ptrd"
    c_ttf_render_text_solid :: Ptr FontStruct -> CString -> Ptr SDL.Color -> IO (Ptr SDL.SurfaceStruct)

renderTextSolid :: Font -> SDL.Color -> String -> IO SDL.Surface
renderTextSolid f color t = do
    text <- newCString t
    withForeignPtr (unwrapFont f) $ \font ->
        with color $ \colorPtr -> c_ttf_render_text_solid font text colorPtr >>= SDL.mkFinalizedSurface

foreign import ccall safe "SDL2/SDL_ttf.h TTF_RenderText_Blended_Ptrd"
    c_ttf_render_text_blended :: Ptr FontStruct -> CString -> Ptr SDL.Color -> IO (Ptr SDL.SurfaceStruct)

renderTextBlended :: Font -> SDL.Color -> String -> IO SDL.Surface
renderTextBlended f color t = do
    text <- newCString t
    withForeignPtr (unwrapFont f) $ \font ->
        with color $ \colorPtr -> c_ttf_render_text_blended font text colorPtr >>= SDL.mkFinalizedSurface

foreign import ccall safe "SDL2/SDL_ttf.h TTF_SizeText"
    c_ttf_size_text :: Ptr FontStruct -> CString -> Ptr CInt -> Ptr CInt -> IO CInt

sizeText :: Font -> String -> IO (Int, Int)
sizeText f str = do
    cstr <- newCString str
    wptr <- malloc
    hptr <- malloc
    ret <- withForeignPtr (unwrapFont f) $ \font -> c_ttf_size_text font cstr wptr hptr
    w <- fromEnum <$> peek wptr
    h <- fromEnum <$> peek hptr
    free wptr
    free hptr
    return (w, h)

data Hint = Normal | Light | Mono | None deriving (Show, Eq, Enum)

foreign import ccall safe "SDL2/SDL_ttf.h TTF_SetFontHinting"
    c_ttf_set_font_hinting :: Ptr FontStruct -> CInt -> IO ()

setFontHinting :: Hint -> Font -> IO ()
setFontHinting h f = withForeignPtr (unwrapFont f) $ \font -> c_ttf_set_font_hinting font (toEnum $ fromEnum h)
