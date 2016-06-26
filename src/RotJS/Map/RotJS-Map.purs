module RotJS.Map (arena, digger, uniform, rogue) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn2, runFn2)

import RotJS.RNG as Random

type Map = Array Int

foreign import buildArenaRaw :: Fn2 Int Int (Map)
foreign import buildDiggerRaw :: forall eff. Fn2 Int Int (Eff (rotrng :: Random.RNG | eff) Map)
foreign import buildUniformRaw :: forall eff. Fn2 Int Int (Eff (rotrng :: Random.RNG | eff) Map)
foreign import buildRogueRaw :: forall eff. Fn2 Int Int (Eff (rotrng :: Random.RNG | eff) Map)



arena:: Int -> Int -> Map
arena = runFn2 buildArenaRaw

digger :: forall eff. Int -> Int -> Eff (rotrng :: Random.RNG | eff) Map
digger = runFn2 buildDiggerRaw

uniform :: forall eff. Int -> Int -> Eff (rotrng :: Random.RNG | eff) Map
uniform = runFn2 buildUniformRaw

rogue :: forall eff. Int -> Int -> Eff (rotrng :: Random.RNG | eff) Map
rogue = runFn2 buildRogueRaw
