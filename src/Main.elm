import Html exposing (Html, text, div, button)

import Debug exposing (log)
import Navigation exposing (Location)
import UrlParser exposing (..)
import Http

import Request.General exposing (..)

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
import Routes exposing (..)

type alias Model = 
  { route: Route
  }

model : Model
model =
  { route = Home
  }

-- UPDATE

type Msg 
  = UrlChange Navigation.Location
  | ArticleReq (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UrlChange loc ->
      log loc.pathname
      log loc.hash
      log loc.href
      ({model | route = parseLocation loc}, Cmd.none)
    ArticleReq (Ok data) ->
      (log data)
      (model, Cmd.none)
    _ ->
      (model, Cmd.none)

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
  -- TODO Based on the location do different requests
  ({model | route = parseLocation location}, (Http.send ArticleReq getArticles))

main =
  Navigation.program UrlChange
  { init = init
  , view = view
  , update = update
  , subscriptions = (\_ -> Sub.none)
  }