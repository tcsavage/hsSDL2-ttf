module Main where

import Control.Concurrent
import Graphics.UI.SDL
import Graphics.UI.SDL.TTF

main :: IO ()
main = withInit [InitEverything] $ withTTF $ do
    f <- ttfOpenFont "Aldrich-Regular.ttf" 100
    withWindow "Hello World!" (Position 100 100) (Size 640 480) [WindowShown] $ \win ->
        withRenderer win (Device (-1)) [Accelerated, PresentVSync] $ \ren -> do
            --bmp <- loadBMP "hello.bmp"
            --tex1 <- createTextureFromSurface ren bmp
            txt <- ttfRenderTextSolid f (Color 0 0 255) "Foo"
            tex2 <- createTextureFromSurface ren txt
            (w, h) <- ttfSizeText f "Foo"
            renderClear ren
            --renderCopy ren tex1 Nothing Nothing
            renderCopy ren tex2 Nothing (Just $ Rect 20 20 w h)
            renderPresent ren

            threadDelay (10^6 * 2)
            return ()
    ttfCloseFont f
