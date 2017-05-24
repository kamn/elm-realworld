module Data.Msg exposing (..)

import Navigation exposing (Location)
import Http

import Data.Comment exposing (..)
import Data.Article exposing (..)
import Data.Profile exposing (..)


-- UPDATE

type Msg 
  = FilterTag String
  | UrlChange Navigation.Location
  | HomeReq (Result Http.Error Articles)
  | ArticleReq (Result Http.Error ArticleContainer)
  | ArticleCommentsReq (Result Http.Error ArticleComments)
  | TagsReq (Result Http.Error TagsContainer)
  | ProfileReq (Result Http.Error ProfileContainer)
  | ProfileArticlesReq (Result Http.Error Articles)