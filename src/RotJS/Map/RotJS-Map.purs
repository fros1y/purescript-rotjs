module RotJS.Map (buildArena) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn2, runFn2)

foreign import buildArenaRaw :: Fn2 Int Int (Array Int)

buildArena :: Int -> Int -> Array Int
buildArena = runFn2 buildArenaRaw
