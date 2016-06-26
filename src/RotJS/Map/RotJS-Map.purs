module RotJS.Map  ( arena
                  , digger
                  , uniform
                  , rogue
                  , DiggerConfig
                  , roomWidth
                  , roomHeight
                  , corridorLength
                  , dugPercentage
                  , timeLimit
                  ) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn3, runFn3, Fn2, runFn2)
import Data.Options (Option(), Options(), optional, options, opt, (:=))
import RotJS.RNG as Random
import Data.Maybe (Maybe(..))
import Data.Foreign (Foreign())

type Map = Array Int

foreign import buildArenaRaw :: Fn2 Int Int (Map)
foreign import buildDiggerRaw :: forall eff. Fn3 Int Int Foreign (Eff (rotrng :: Random.RNG | eff) Map)
foreign import buildUniformRaw :: forall eff. Fn2 Int Int (Eff (rotrng :: Random.RNG | eff) Map)
foreign import buildRogueRaw :: forall eff. Fn2 Int Int (Eff (rotrng :: Random.RNG | eff) Map)

-- roomWidth – [min, max] room size
-- roomHeight – [min, max] room size
-- corridorLength – [min, max] corridor length
-- dugPercentage – algorithm stops after this fraction of map area has been dug out; default = 0.2
-- timeLimit – algorithm stops after this amount of milliseconds has passed

foreign import data DiggerConfig :: *

roomWidth :: Option DiggerConfig (Maybe (Array Int))
roomWidth = optional (opt "roomWidth")

roomHeight :: Option DiggerConfig (Maybe (Array Int))
roomHeight = optional (opt "roomHeight")

corridorLength :: Option DiggerConfig (Maybe (Array Int))
corridorLength = optional (opt "corridorLength")

dugPercentage :: Option DiggerConfig (Maybe Number)
dugPercentage = optional (opt "dugPercentage")

timeLimit :: Option DiggerConfig (Maybe Int)
timeLimit = optional (opt "timeLimit")

arena:: Int -> Int -> Map
arena = runFn2 buildArenaRaw

digger :: forall eff. Int -> Int -> Options DiggerConfig -> Eff (rotrng :: Random.RNG | eff) Map
digger x y opts = runFn3 buildDiggerRaw x y (options opts)

uniform :: forall eff. Int -> Int -> Eff (rotrng :: Random.RNG | eff) Map
uniform = runFn2 buildUniformRaw

rogue :: forall eff. Int -> Int -> Eff (rotrng :: Random.RNG | eff) Map
rogue = runFn2 buildRogueRaw
