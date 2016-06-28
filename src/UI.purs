module UI where

import Control.Monad.Eff (Eff, forE)
import DOM
import Prelude
import Data.Array ((!!))
import Data.Maybe (Maybe(..))
import Control.MonadPlus (guard)

import RotJS.Display as Display
import RotJS.FOV as FOV
import RotJS.Map as MapGen

foreign import onDOMContentLoaded :: forall a eff. Eff (dom :: DOM | eff) a -> Eff (eff) Unit

renderPlayer display player = do
  Display.draw display player "@" "#fff"

renderMap display state = do
  let map = state.level
      xsize = map.width
      ysize = map.height
      fov = FOV.preciseShadowCast (toVisibilityMap map)
      visible = FOV.compute fov state.player.x state.player.y 10
  forE 0 xsize $ \x -> forE 0 ysize $ \y ->
    if isVisible visible x y
    then let val = map.grid !! (x * ysize + y) in
            case val of
              Nothing -> pure unit
              Just 0 -> Display.draw display {x: x, y: y} "." "#fff"
              Just 1 -> Display.draw display {x: x, y: y} "#" "#fff"
              Just v -> Display.draw display {x: x, y: y} (show v) "#f00"
    else Display.draw display {x: x, y: y} " " "#111"

render display gameStateE = do
  gameState <- gameStateE
  renderMap display gameState
  renderPlayer display gameState.player

isVisible :: FOV.VisibilityMap -> Int -> Int -> Boolean
isVisible map x y = case val of
                      Just true -> true
                      _ -> false
                    where
                      ysize = map.height
                      val = map.cells !! (x * ysize + y)

toVisibilityMap :: MapGen.Map -> FOV.VisibilityMap
toVisibilityMap map = { width: map.width,
                        height: map.height,
                        cells: toVisibility <$> map.grid
                      } where
                          toVisibility cell = if cell == 0 then true else false
