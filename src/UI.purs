module UI where

import Control.Monad.Eff (Eff, forE)
import DOM
import Prelude
import Data.Array ((!!))
import Data.Maybe (Maybe(..))

import RotJS.Display as Display

foreign import onDOMContentLoaded :: forall a eff. Eff (dom :: DOM | eff) a -> Eff (eff) Unit

renderPlayer display player = do
  Display.draw display player "@" "#fff"

renderMap display map = do
  let xsize = map.width
      ysize = map.height
  forE 0 xsize $ \x -> forE 0 ysize $ \y ->
      let val = map.grid !! (x * ysize + y) in
        case val of
          Nothing -> pure unit
          Just 0 -> Display.draw display {x: x, y: y} "." "#fff"
          Just 1 -> Display.draw display {x: x, y: y} "#" "#fff"
          Just v -> Display.draw display {x: x, y: y} (show v) "#f00"
