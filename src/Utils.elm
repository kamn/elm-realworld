module Utils exposing (..)

import Html exposing (..)
import Html.Events exposing (onWithOptions, Options, defaultOptions)
import Json.Decode as Json


-- TODO Move somewhere else?


onNoBubbleClick : msg -> Attribute msg
onNoBubbleClick msg =
    onWithOptions "click" { defaultOptions | preventDefault = True } (Json.succeed msg)
