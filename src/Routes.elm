module RealWorld.Routes exposing(Route(..), match, route)

import Navigation exposing (Location)
import UrlParser exposing (..)

matchers =
  oneOf
    [ map ]