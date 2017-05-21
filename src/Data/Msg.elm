module Data.Msg exposing (..)

import Navigation exposing (Location)
import Http

import Data.Article exposing (..)
import Data.Profile exposing (..)


-- UPDATE

type Msg 
  = UrlChange Navigation.Location
  | HomeReq (Result Http.Error Articles)
  | ArticleReq (Result Http.Error ArticleContainer)
  | TagsReq (Result Http.Error TagsContainer)
  | ProfileReq (Result Http.Error ProfileContainer)