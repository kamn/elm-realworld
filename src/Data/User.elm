module Data.User exposing (..)

type alias User =
  { email : String
  , token : String
  , username : String
  , bio : String
  , image : Maybe String
  }