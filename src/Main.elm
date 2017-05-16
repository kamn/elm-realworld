import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)
import Views.Layout exposing (layout)
import Views.Home exposing (home)
import Debug exposing (log)
import Navigation exposing (Location)
import UrlParser exposing (..)

-- ROUTING

type Route
  = Home
  | Settings
  | NotFoundRoute

route =
  oneOf
    [ map Home top
    , map Settings (s "settings")
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
      div [] [text "Settings"]
    _ ->
      div [] [text "NotFound"]


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

