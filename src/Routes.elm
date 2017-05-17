module RealWorld.Routes exposing(Route(..), match, route)

import Navigation exposing (Location)
import UrlParser exposing (..)


type Route
  = Home
  | Settings

route =
  oneOf
    [ map Home top
    , map Settings "settings"
    ]