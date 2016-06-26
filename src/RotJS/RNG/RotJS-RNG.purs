module RotJS.RNG  ( RNG
                  , setSeed
                  , getSeed
                  , getUniform
                  , getPercentage
                  , getNormal
                  ) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn2, runFn2)


-- | `RNG` effect denotes computations which manipulate the ROT.js RNG`
foreign import data RNG :: !

foreign import setSeed :: forall eff. Int -> Eff (rotrng :: RNG | eff) Unit
foreign import getSeed :: forall eff. Eff (rotrng :: RNG | eff) Int
foreign import getUniform :: forall eff. Eff (rotrng :: RNG | eff) Number
foreign import getPercentage:: forall eff. Eff (rotrng :: RNG | eff) Int
foreign import getNormalRaw:: forall eff. Fn2 Number
                                              Number
                                              (Eff (rotrng :: RNG | eff) Number)

getNormal :: forall eff. Number -> Number -> Eff (rotrng :: RNG | eff) Number
getNormal = runFn2 getNormalRaw
