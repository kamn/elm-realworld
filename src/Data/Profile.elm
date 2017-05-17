module Data.Profile exposing (..)

type alias Profile =
  { username : String
  , bio : String
  , image : String
  , following: Bool
  }