module Main where

import Prelude
import RotJS.Display as Display
import RotJS.Scheduler as Scheduler
import RotJS.Map as MapGen
import RotJS.RNG as Random
import RotJS.FOV as FOV
import UI as UI
import Control.Monad.Eff (Eff, forE)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Array ((!!))
import Data.Maybe (Maybe(..))
import Data.Options (Option(), Options(), optional, options, opt, (:=))


import Signal (foldp, runSignal, sampleOn, Signal(), dropRepeats)
import Signal.DOM (animationFrame, keyPressed)

leftKeyCode = 37
upKeyCode = 38
rightKeyCode = 39
downKeyCode = 40

type Player = {
  x :: Int,
  y :: Int
}

type GameState = {
  turnCount :: Int,
  player :: Player,
  level :: MapGen.Map
}

type Delta = {x :: Int, y :: Int}

movePlayer :: Delta -> Player -> Player
movePlayer delta player = {x: player.x + delta.x, y: player.y + delta.y}

gameLogic :: Delta -> Eff _ GameState -> Eff _ GameState
gameLogic delta gameState = do
  state <- gameState
  pure (state {player = movePlayer delta state.player})

calcDelta :: Boolean -> Boolean -> Boolean -> Boolean -> Delta
calcDelta true _ _ _ = {x: -1, y: 0}
calcDelta _ true _ _ = {x: 1, y: 0}
calcDelta _ _ true _ = {x: 0, y: -1}
calcDelta _ _ _ true = {x: 0, y: 1}
calcDelta _ _ _ _ = {x: 0, y: 0}

mkInitialState :: MapGen.Map -> Eff _ GameState
mkInitialState map = do
  pure {  turnCount: 0,
          player: {
            x: 10,
            y: 10
            },
          level: map
        }

main :: Eff _ Unit
main = UI.onDOMContentLoaded do

  Random.setSeed 1
  display <- Display.initDisplay (  Display.width := 80
                                 <>  Display.height := 40)
  map <- MapGen.digger 30 30 (MapGen.roomWidth := [2, 5])

  frames <- animationFrame
  leftInput <- dropRepeats <$> keyPressed leftKeyCode
  rightInput <- dropRepeats <$> keyPressed rightKeyCode
  upInput <- dropRepeats <$> keyPressed upKeyCode
  downInput <- dropRepeats <$> keyPressed downKeyCode

  let delta = calcDelta <$> leftInput <*> rightInput <*> upInput <*> downInput
      game = foldp gameLogic initialState delta
      initialState = mkInitialState map

  runSignal ( (UI.render display) <$> game)
