module RotJS.Scheduler where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn2, runFn2, Fn3, runFn3)

-- | `TTY` effect denotes computations which manipulate the ROT.js Scheduler`
foreign import data Scheduling :: !

foreign import data SchedulerObject :: *
foreign import data ActorObject :: *

data SimpleScheduler = SimpleScheduler SchedulerObject
data ActionScheduler = ActionScheduler SchedulerObject

-- type Actor = {  getSpeed :: Unit -> Int }
type RepeatedActor = Boolean


class SimpleScheduling s where
  create :: forall eff. Eff (scheduling :: Scheduling | eff) s
  add :: forall eff. s -> ActorObject -> RepeatedActor -> Eff (scheduling :: Scheduling | eff) Unit
  remove :: forall eff. s  -> ActorObject -> (Eff (scheduling :: Scheduling | eff) Unit)
  next :: forall eff. s -> Eff (scheduling :: Scheduling | eff) ActorObject
  clear :: forall eff. s -> Eff (scheduling :: Scheduling | eff) Unit

instance simpleScheduling :: SimpleScheduling SimpleScheduler where
  create = SimpleScheduler <$> newSimpleScheduler
  add (SimpleScheduler scheduler) actor repeat = runFn3 addRaw scheduler actor repeat
  remove (SimpleScheduler scheduler) actor = runFn2 removeRaw scheduler actor
  next (SimpleScheduler scheduler) = nextRaw scheduler
  clear (SimpleScheduler scheduler) = clearRaw scheduler

instance simpleSchedulingAction :: SimpleScheduling ActionScheduler where
  create = ActionScheduler <$> newActionScheduler
  add (ActionScheduler scheduler) actor repeat = runFn3 addRaw scheduler actor repeat
  remove (ActionScheduler scheduler) actor = runFn2 removeRaw scheduler actor
  next (ActionScheduler scheduler) = nextRaw scheduler
  clear (ActionScheduler scheduler) = clearRaw scheduler

class (SimpleScheduling s) <= ActionScheduling s where
  setDuration :: forall eff. s -> Int -> Eff (scheduling :: Scheduling | eff) Unit

instance actionScheduling :: ActionScheduling ActionScheduler where
  setDuration (ActionScheduler scheduler) duration = runFn2 setDurationRaw scheduler duration


foreign import newSimpleScheduler :: forall eff. Eff (scheduling :: Scheduling | eff) SchedulerObject
foreign import newActionScheduler :: forall eff. Eff (scheduling :: Scheduling | eff) SchedulerObject

foreign import addRaw :: forall eff. Fn3  SchedulerObject
                                          ActorObject
                                          RepeatedActor
                                          (Eff (scheduling :: Scheduling | eff) Unit)

foreign import removeRaw :: forall eff. Fn2 SchedulerObject
                                            ActorObject
                                            (Eff (scheduling :: Scheduling | eff) Unit)

foreign import nextRaw :: forall eff. SchedulerObject -> Eff (scheduling :: Scheduling | eff) ActorObject
foreign import clearRaw :: forall eff. SchedulerObject -> Eff (scheduling :: Scheduling | eff) Unit
foreign import setDurationRaw :: forall eff. Fn2  SchedulerObject
                                                  Int
                                                  (Eff (scheduling :: Scheduling | eff) Unit)


-- foreign import newSpeedScheduler :: forall eff. Eff (scheduling :: Scheduling | eff) Scheduler

-- foreign import newActionScheduler :: forall eff. Eff (scheduling :: Scheduling | eff) Scheduler
--
--

--
-- remove :: forall eff. Scheduler -> Actor -> (Eff (scheduling :: Scheduling | eff) Unit)
-- remove = runFn2 removeRaw
--

--
-- add :: forall eff. Scheduler -> Actor -> RepeatedActor -> (Eff (scheduling :: Scheduling | eff) Unit)
-- add = runFn3 addRaw
--

--

--
-- foreign import setDuration :: forall eff. Scheduler -> Eff (scheduling :: Scheduling | eff) Unit
