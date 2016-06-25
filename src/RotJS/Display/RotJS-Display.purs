module RotJS.Display (
    TTY
  , Display
  , Coord
  , Color
  , Configuration
  , defaultConfiguration
  , initDisplay
  , setOptions
  , draw
  ) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn4, runFn4, Fn2, runFn2)

-- | `TTY` effect denotes computations which manipulate the ROT.js Display`
foreign import data TTY :: !

-- | ROT.js display context
foreign import data Display :: *

type Coord = {x :: Int, y :: Int}
type Color = String

type Configuration = {  width :: Int
                      , height :: Int
                      , fontSize :: Int
                      , fontFamily :: String
                      , fg :: Color
                      , bg :: Color
                      , spacing :: Number
                      , layout :: String
                    }

defaultConfiguration :: Configuration
defaultConfiguration = {  width: 80
                        , height:  40
                        , fontSize:  14
                        , fontFamily:  "Courier New"
                        , fg:  "#fff"
                        , bg:  "#000"
                        , spacing:  1.0
                        , layout:  "rect"
                      }

foreign import initDisplay :: forall eff. Configuration -> Eff (tty :: TTY | eff) Display

foreign import setOptionsRaw :: forall eff. Fn2 Display
                                                Configuration
                                                (Eff (tty :: TTY | eff) Unit)

setOptions :: forall eff. Display -> Configuration -> (Eff (tty :: TTY | eff) Unit)
setOptions = runFn2 setOptionsRaw


foreign import drawRaw ::
  forall eff. Fn4 Display
                  Coord
                  String
                  Color
                  (Eff (tty :: TTY | eff) Unit)

draw :: forall eff. Display -> Coord -> String -> Color -> Eff (tty :: TTY | eff) Unit
draw = runFn4 drawRaw
