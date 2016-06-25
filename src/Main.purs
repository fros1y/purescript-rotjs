module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

import RotJS.Display as RotJS

main :: forall e. Eff (console :: CONSOLE, tty :: RotJS.TTY | e) Unit
main = do
  display <- RotJS.initDisplay RotJS.defaultConfiguration
  RotJS.draw display {x: 10, y: 20} "@" "#fff"
  log "Hello sailor!"
