module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

-- import RotJS.Display as RotJS
import RotJS.Scheduler as Scheduler

main :: forall eff. Eff (console :: CONSOLE, scheduler :: Scheduler.SCHEDULING | eff) Unit
main = do
  -- display <- RotJS.initDisplay RotJS.defaultConfiguration
  -- RotJS.draw display {x: 10, y: 20} "@" "#fff"
  schedule <- Scheduler.mkSimpleScheduler
  let defItem = {id: 1, speed: 100}
  -- add schedule defItem true
  log "Hello sailor!"
