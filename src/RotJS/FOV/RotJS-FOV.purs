module RotJS.FOV (FOV, TransparencyMap, TransparencyCell, VisibilityMap, VisibilityCell, preciseShadowCast, recursiveShadowCast, compute) where


import Prelude
import Data.Function.Uncurried (Fn4, runFn4, Fn2, runFn2)

foreign import data FOV :: *

type TransparencyCell = Boolean
type VisibilityCell = Boolean

type TransparencyMap = {  width :: Int,
                          height :: Int,
                          cells :: Array TransparencyCell
                        }

type VisibilityMap = { width :: Int,
                       height :: Int,
                       cells :: Array VisibilityCell
                    }

foreign import preciseShadowCast :: TransparencyMap -> FOV
foreign import recursiveShadowCast :: TransparencyMap -> FOV

foreign import computeRaw ::  Fn4 FOV
                              Int
                              Int
                              Int
                              VisibilityMap

compute :: FOV -> Int -> Int -> Int -> VisibilityMap
compute = runFn4 computeRaw
