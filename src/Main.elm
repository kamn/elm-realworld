import Html exposing (Html, text, div, button)

import Debug exposing (log)
import Navigation exposing (Location)
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

import Data.Article exposing (Articles)
import Data.Msg exposing (Msg(..))

-- ROUTING
import Routes exposing (..)

type alias Model = 
  { route : Route
  , mainPageData : Maybe Articles
  }

model : Model
model =
  { route = Home
  , mainPageData = Nothing
  }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UrlChange loc ->
      log loc.pathname
      log loc.hash
      log loc.href
      ({model | route = parseLocation loc}, Cmd.none)
    ArticleReq (Ok data) ->
      (log (toString data))
      ({model | mainPageData = Just data}, Cmd.none)
    ArticleReq (_) ->
      (log "failed")
      (log (toString msg))
      (model, Cmd.none)

view : Model -> Html Msg
view model =
  case model.route of
    Home ->
      case model.mainPageData of
        Just articles ->
          layout (home articles)
        Nothing ->
          -- TODO display an error?
          layout (home {articles = []})
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

init : Location -> (Model, Cmd Msg)
init location =
  -- TODO Based on the location do different requests
  ({model | route = parseLocation location}, (Http.send ArticleReq getArticles))

main : Program Never Model Msg
main =
  Navigation.program UrlChange
  { init = init
  , view = view
  , update = update
  , subscriptions = (\_ -> Sub.none)
  }