module Main where

import Prelude
import RotJS.Display as Display
import RotJS.Scheduler as Scheduler
import RotJS.Map as MapGen
import RotJS.RNG as Random
import Control.Monad.Eff (Eff, forE)
import Control.Monad.Eff.Console (CONSOLE, log)

-- main :: forall eff. Eff (console :: CONSOLE, scheduler :: Scheduler.SCHEDULING | eff) Unit
main :: forall eff. Eff ( tty :: Display.TTY
                        , scheduling :: Scheduler.SCHEDULING
                        , console :: CONSOLE
                        , rotrng :: Random.RNG
                        | eff
                        ) Unit
main = do
  Random.setSeed 1
  uniform <- Random.getUniform
  percent <- Random.getPercentage
  normal <- Random.getNormal 3.0 0.1
  log (show uniform)
  log (show percent)
  log (show normal)

  -- log $ show $ MapGen.buildArena 10 20
--   display <- Display.initDisplay Display.defaultConfiguration
--   Display.draw display {x: 10, y: 20} "@" "#fff"
--   schedule <- Scheduler.mkActionScheduler
--   Scheduler.add schedule {id: 1, speed: 100} true
--   Scheduler.add schedule {id: 2, speed: 50} true
--   Scheduler.add schedule {id: 3, speed: 25} true
--   forE 0 20 (loop schedule)
--
--
-- loop :: forall eff. Scheduler.ActionScheduler -> Int -> Eff ( tty :: Display.TTY
--                         , scheduling :: Scheduler.SCHEDULING
--                         , console :: CONSOLE
--                         | eff
--                         ) Unit
-- loop schedule cycle = do
--   out <- Scheduler.next schedule
--   time <- Scheduler.getTime schedule
--   Scheduler.setDuration schedule (if cycle == 3 then 5 else 1)
--   log $ "At cycle: " <> (show cycle) <> ": ID= " <> (show (out.id)) <> "(time is " <> (show time) <> ")"
