module RotJS.Map  ( arena
                  , digger
                  , uniform
                  , rogue
                  , MapGenConfig
                  , roomWidth
                  , roomHeight
                  , corridorLength
                  , dugPercentage
                  , timeLimit
                  , Door
                  , Room
                  , Corridor
                  , Map
                  ) where


import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn3, runFn3, Fn2, runFn2)
import Data.Options (Option(), Options(), options, opt, (:=))
import RotJS.RNG as Random
import Data.Foreign (Foreign())

type Door = {x :: Int, y :: Int }

type Room = {
              left :: Int,
              top :: Int,
              right :: Int,
              bottom :: Int,
              doors :: Array Door
            }

type Corridor = {
    startX :: Int,
    startY :: Int,
    endX :: Int,
    endY :: Int
}

type Map = {  width :: Int
            , height :: Int
            , grid :: Array Int
            , rooms :: Array Room
            , doors :: Array Door
            , corridors :: Array Corridor
          }

foreign import buildArenaRaw :: Fn2 Int Int (Map)
foreign import buildDiggerRaw :: forall eff. Fn3 Int Int Foreign (Eff (rotrng :: Random.RNG | eff) Map)
foreign import buildUniformRaw :: forall eff. Fn3 Int Int Foreign (Eff (rotrng :: Random.RNG | eff) Map)
foreign import buildRogueRaw :: forall eff. Fn2 Int Int (Eff (rotrng :: Random.RNG | eff) Map)

-- roomWidth – [min, max] room size
-- roomHeight – [min, max] room size
-- corridorLength – [min, max] corridor length
-- dugPercentage – algorithm stops after this fraction of map area has been dug out; default = 0.2
-- timeLimit – algorithm stops after this amount of milliseconds has passed

foreign import data MapGenConfig :: Type

roomWidth :: Option MapGenConfig (Array Int)
roomWidth = opt "roomWidth"

roomHeight :: Option MapGenConfig (Array Int)
roomHeight = opt "roomHeight"

corridorLength :: Option MapGenConfig (Array Int)
corridorLength = opt "corridorLength"

dugPercentage :: Option MapGenConfig Number
dugPercentage = opt "dugPercentage"

roomDugPercentage :: Option MapGenConfig Number
roomDugPercentage = opt "roomDugPercentage"

timeLimit :: Option MapGenConfig Int
timeLimit = opt "timeLimit"

arena:: Int -> Int -> Map
arena = runFn2 buildArenaRaw

digger :: forall eff. Int -> Int -> Options MapGenConfig -> Eff (rotrng :: Random.RNG | eff) Map
digger x y opts = runFn3 buildDiggerRaw x y (options opts)

uniform :: forall eff. Int -> Int -> Options MapGenConfig -> Eff (rotrng :: Random.RNG | eff) Map
uniform x y opts = runFn3 buildUniformRaw x y (options opts)

rogue :: forall eff. Int -> Int -> Eff (rotrng :: Random.RNG | eff) Map
rogue = runFn2 buildRogueRaw
