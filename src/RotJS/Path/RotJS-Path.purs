module RotJS.Path where
import Data.Function.Uncurried (Fn3, runFn3)

type TraversableCell = Boolean

type TraversableMap = {  width :: Int,
                          height :: Int,
                          cells :: Array TraversableCell
                        }

type Coord = {x :: Int, y :: Int}
type Path = Array Coord

foreign import data PathGen :: Type

foreign import dijkstraRaw :: Fn3 TraversableMap
                                  Int
                                  Int
                                  PathGen

foreign import aStarRaw :: Fn3    TraversableMap
                                  Int
                                  Int
                                  PathGen

foreign import computeRaw :: Fn3  PathGen
                                  Int
                                  Int
                                  Path

dijkstra :: TraversableMap -> Int -> Int -> PathGen
dijkstra = runFn3 dijkstraRaw

aStar:: TraversableMap -> Int -> Int -> PathGen
aStar = runFn3 aStarRaw

compute :: PathGen -> Int -> Int -> Path
compute = runFn3 computeRaw
