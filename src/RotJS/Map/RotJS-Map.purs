module RotJS.Map (RNG, buildArena) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn2, runFn2)


-- | `TTY` effect denotes computations which manipulate the ROT.js Display`
foreign import data RNG :: !

-- | ROT.js mapgen context
foreign import data MapGen :: *

foreign import buildArenaRaw :: Fn2 Int Int (Array Int)

buildArena :: Int -> Int -> Array Int
buildArena = runFn2 buildArenaRaw
