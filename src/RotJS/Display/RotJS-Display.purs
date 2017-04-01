module RotJS.Display (
    TTY
  , Display
  , Coord
  , Color
  , initDisplay
  , setOptions
  , draw
  , width
  , height
  , fontSize
  , fg
  , bg
  , spacing
  , layout
  , DisplayConfig
  ) where

import Prelude
import Control.Monad.Eff (Eff, kind Effect)
import Data.Function.Uncurried (Fn4, runFn4, Fn2, runFn2)
import Data.Options (Option(), Options(), options, opt, (:=))
import Data.Foreign (Foreign())

-- | `TTY` effect denotes computations which manipulate the ROT.js Display`
foreign import data TTY :: Effect

-- | ROT.js display context
foreign import data Display :: Type
foreign import data DisplayConfig :: Type

type Coord = {x :: Int, y :: Int}
type Color = String

width :: Option DisplayConfig Int
width = opt "width"

height :: Option DisplayConfig Int
height = opt "height"

fontSize :: Option DisplayConfig Int
fontSize = opt "fontSize"

fg :: Option DisplayConfig Color
fg = opt "fg"

bg :: Option DisplayConfig Color
bg = opt "bg"

spacing :: Option DisplayConfig Number
spacing = opt "spacing"

layout :: Option DisplayConfig String
layout = opt "layout"


foreign import initDisplayRaw :: forall eff. Foreign -> Eff (tty :: TTY | eff) Display

initDisplay :: forall eff. Options DisplayConfig -> Eff (tty :: TTY | eff) Display
initDisplay opts = initDisplayRaw (options opts)

foreign import setOptionsRaw :: forall eff. Fn2 Display
                                                Foreign
                                                (Eff (tty :: TTY | eff) Unit)

setOptions :: forall eff. Display -> Options DisplayConfig -> (Eff (tty :: TTY | eff) Unit)
setOptions display config = runFn2 setOptionsRaw display (options config)


foreign import drawRaw ::
  forall eff. Fn4 Display
                  Coord
                  String
                  Color
                  (Eff (tty :: TTY | eff) Unit)

draw :: forall eff. Display -> Coord -> String -> Color -> Eff (tty :: TTY | eff) Unit
draw = runFn4 drawRaw
