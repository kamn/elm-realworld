module Data.Profile exposing (..)

type alias Profile =
  { username : String
  , bio : Maybe String
  , image : String
  , following: Bool
  }