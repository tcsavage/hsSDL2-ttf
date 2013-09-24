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

{-# LANGUAGE EmptyDataDecls #-}

module Graphics.UI.SDL.TTF.Types
    ( FontStruct
    , Font
    ) where

import Foreign


data FontStruct
type Font = ForeignPtr FontStruct
