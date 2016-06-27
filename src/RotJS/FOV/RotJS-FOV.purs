module RotJS.FOV (FOV, Visibility, TransparencyFn, preciseShadowCast, recursiveShadowCast, compute) where

import Prelude
import Data.Function.Uncurried (Fn4, runFn4, Fn2, runFn2)

foreign import data FOV :: *

type Visibility = Array {visible :: Boolean, distance :: Int }
type TransparencyFn = Int -> Int -> Boolean

foreign import preciseShadowCast :: TransparencyFn -> FOV
foreign import recursiveShadowCast :: TransparencyFn -> FOV

foreign import computeRaw :: Fn4 FOV
                              Int
                              Int
                              Int
                              Visibility

compute :: FOV -> Int -> Int -> Int -> Visibility
compute = runFn4 computeRaw
