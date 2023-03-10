{-# LANGUAGE GADTs #-}

module Crem.Example.BooleanStateMachine where

import Crem.BaseMachine
import Crem.StateMachine
import "singletons-base" Data.Singletons.Base.TH

booleanStateMachine
  :: forall a
   . SBool a
  -> StateMachine Int Int
booleanStateMachine initialState =
  unrestrictedMachine @Bool
    ( \state input -> case state of
        SFalse ->
          if even input
            then pureResult (input + 1) SFalse
            else pureResult (input * 3) STrue
        STrue ->
          if even input
            then pureResult (input - 1) STrue
            else pureResult (input * 5) SFalse
    )
    (InitialState initialState)
