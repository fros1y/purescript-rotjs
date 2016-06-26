module RotJS.Scheduler (
      SimpleScheduler
    , ActionScheduler
    , SpeedScheduler
    , SCHEDULING
    , Actor
    , mkSimpleScheduler
    , mkSpeedScheduler
    , mkActionScheduler
    , class SimpleScheduling
    , add
    , remove
    , next
    , clear
    , getTime
    , class ActionScheduling
    , setDuration
    )  where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn2, runFn2, Fn3, runFn3)

-- | `Scheduling` effect denotes computations which manipulate the ROT.js Scheduler`
foreign import data SCHEDULING :: !
foreign import data SchedulerObject :: *

data SimpleScheduler = SimpleScheduler SchedulerObject
data ActionScheduler = ActionScheduler SchedulerObject
data SpeedScheduler = SpeedScheduler SchedulerObject

type RepeatedActor = Boolean

type Actor = {  id :: Int,
                speed :: Int
              }

class SimpleScheduling s where
  add :: forall eff. s -> Actor -> RepeatedActor -> Eff (scheduling :: SCHEDULING | eff) Unit
  remove :: forall eff. s  -> Actor -> (Eff (scheduling :: SCHEDULING | eff) Unit)
  next :: forall eff. s -> Eff (scheduling :: SCHEDULING | eff) Actor
  clear :: forall eff. s -> Eff (scheduling :: SCHEDULING | eff) Unit
  getTime :: forall eff. s -> Eff (scheduling :: SCHEDULING | eff) Int

instance simpleScheduling :: SimpleScheduling SimpleScheduler where
  add (SimpleScheduler scheduler) actor repeat = runFn3 addRaw scheduler actor repeat
  remove (SimpleScheduler scheduler) actor = runFn2 removeRaw scheduler actor
  next (SimpleScheduler scheduler) = nextRaw scheduler
  clear (SimpleScheduler scheduler) = clearRaw scheduler
  getTime (SimpleScheduler scheduler) = getTimeRaw scheduler

instance simpleSchedulingAction :: SimpleScheduling ActionScheduler where
  add (ActionScheduler scheduler) actor repeat = runFn3 addRaw scheduler actor repeat
  remove (ActionScheduler scheduler) actor = runFn2 removeRaw scheduler actor
  next (ActionScheduler scheduler) = nextRaw scheduler
  clear (ActionScheduler scheduler) = clearRaw scheduler
  getTime (ActionScheduler scheduler) = getTimeRaw scheduler

instance simpleSchedulingSpeed :: SimpleScheduling SpeedScheduler where
  add (SpeedScheduler scheduler) actor repeat = runFn3 addRaw scheduler actor repeat
  remove (SpeedScheduler scheduler) actor = runFn2 removeRaw scheduler actor
  next (SpeedScheduler scheduler) = nextRaw scheduler
  clear (SpeedScheduler scheduler) = clearRaw scheduler
  getTime (SpeedScheduler scheduler) = getTimeRaw scheduler

class (SimpleScheduling s) <= ActionScheduling s where
  setDuration :: forall eff. s -> Int -> Eff (scheduling :: SCHEDULING | eff) Unit

instance actionScheduling :: ActionScheduling ActionScheduler where
  setDuration (ActionScheduler scheduler) duration = runFn2 setDurationRaw scheduler duration

class (SimpleScheduling s) <= SpeedScheduling s
instance speedScheduling :: SpeedScheduling SpeedScheduler

mkSimpleScheduler :: forall eff. Eff (scheduling :: SCHEDULING | eff) SimpleScheduler
mkSimpleScheduler = SimpleScheduler <$> newSimpleScheduler

mkSpeedScheduler :: forall eff. Eff (scheduling :: SCHEDULING | eff) SpeedScheduler
mkSpeedScheduler = SpeedScheduler <$> newSpeedScheduler

mkActionScheduler :: forall eff. Eff (scheduling :: SCHEDULING | eff) ActionScheduler
mkActionScheduler = ActionScheduler <$> newActionScheduler

foreign import newSimpleScheduler :: forall eff. Eff (scheduling :: SCHEDULING | eff) SchedulerObject
foreign import newActionScheduler :: forall eff. Eff (scheduling :: SCHEDULING | eff) SchedulerObject
foreign import newSpeedScheduler :: forall eff. Eff (scheduling :: SCHEDULING | eff) SchedulerObject

foreign import addRaw :: forall eff. Fn3  SchedulerObject
                                          Actor
                                          RepeatedActor
                                          (Eff (scheduling :: SCHEDULING | eff) Unit)

foreign import removeRaw :: forall eff. Fn2 SchedulerObject
                                            Actor
                                            (Eff (scheduling :: SCHEDULING | eff) Unit)

foreign import nextRaw :: forall eff. SchedulerObject -> Eff (scheduling :: SCHEDULING | eff) Actor
foreign import clearRaw :: forall eff. SchedulerObject -> Eff (scheduling :: SCHEDULING | eff) Unit
foreign import setDurationRaw :: forall eff. Fn2  SchedulerObject
                                                  Int
                                                  (Eff (scheduling :: SCHEDULING | eff) Unit)

foreign import getTimeRaw :: forall eff. SchedulerObject -> Eff (scheduling :: SCHEDULING | eff) Int
