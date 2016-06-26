module Main where

import Prelude
import RotJS.Display as Display
import RotJS.Scheduler as Scheduler
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

-- main :: forall eff. Eff (console :: CONSOLE, scheduler :: Scheduler.SCHEDULING | eff) Unit
main :: forall eff. Eff ( tty :: Display.TTY
                        , scheduling :: Scheduler.SCHEDULING
                        , console :: CONSOLE
                        | eff
                        ) Unit
main = do
  display <- Display.initDisplay Display.defaultConfiguration
  Display.draw display {x: 10, y: 20} "@" "#fff"
  schedule <- Scheduler.mkSimpleScheduler
  Scheduler.add schedule {id: 1, speed: 100} true
  Scheduler.add schedule {id: 2, speed: 100} true
  Scheduler.add schedule {id: 3, speed: 100} true
  out <- Scheduler.next schedule
  log (show (out.id))
  log "Hello sailor!"
