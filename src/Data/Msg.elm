module Data.Msg exposing (..)

import Navigation exposing (Location)
import Http

import Data.Article exposing (..)

-- UPDATE

type Msg 
  = UrlChange Navigation.Location
  | HomeReq (Result Http.Error Articles)
  | Article (Result Http.Error Article)