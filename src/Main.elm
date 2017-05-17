import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)

import Debug exposing (log)
import Navigation exposing (Location)
import UrlParser exposing (..)

-- Views
import Views.Layout exposing (layout)
import Views.Home exposing (home)
import Views.Settings exposing (settings)
import Views.Login exposing (login)
import Views.Register exposing (register)
import Views.Profile exposing (profile)
import Views.Editor exposing (editor)
import Views.Article exposing (article)


-- ROUTING

type Route
  = Home
  | Settings
  | Login
  | Register
  | Profile
  | Editor
  | Article
  | NotFoundRoute

route =
  oneOf
    [ map Home top
    , map Settings (s "settings")
    , map Login (s "login")
    , map Register (s "register")
    , map Profile (s "profile")
    , map Editor (s "editor")
    , map Article (s "article")
    ]


parseLocation: Location -> Route
parseLocation location =
  case (parseHash route location) of
    Just r ->
      r
    Nothing ->
      NotFoundRoute

type alias Model = 
  {
    value: Int
  , route: Route
  }

model : Model
model =
  { value = 0
  , route = Home
  }

-- UPDATE

type Msg = Increment | Decrement | UrlChange Navigation.Location

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      (model, Cmd.none)
    Decrement ->
      (model, Cmd.none)
    UrlChange loc ->
      log loc.pathname
      log loc.hash
      log loc.href
      ({model | route = parseLocation loc}, Cmd.none)

view : Model -> Html Msg
view model =
  case model.route of
    Home ->
      layout home
    Settings ->
      layout settings
    Login ->
      layout login
    Register ->
      layout register
    Profile ->
      layout profile
    Editor ->
      layout editor
    Article ->
      layout article
    NotFoundRoute ->
      layout (div [] [text "NotFound"])


init location =
  ({model | route = parseLocation location}, Cmd.none)

main =
  Navigation.program UrlChange
  { init = init
  , view = view
  , update = update
  , subscriptions = (\_ -> Sub.none)
  }
  --Html.beginnerProgram {model = model, view = view, update = update}

