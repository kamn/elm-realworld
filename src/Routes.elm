module Routes exposing (Route(..), parseLocation, route)

import Navigation exposing (Location)
import UrlParser exposing (..)


type Route
    = Home
    | Settings
    | Login
    | Register
    | Profile String
    | Editor
    | Article String
    | NotFoundRoute


route : Parser (Route -> c) c
route =
    oneOf
        [ map Home top
        , map Settings (s "settings")
        , map Login (s "login")
        , map Register (s "register")
        , map Profile (s "profile" </> UrlParser.string)
        , map Editor (s "editor")
        , map Article (s "article" </> UrlParser.string)
        ]


parseLocation : Location -> Route
parseLocation location =
    case parseHash route location of
        Just r ->
            r

        Nothing ->
            NotFoundRoute
