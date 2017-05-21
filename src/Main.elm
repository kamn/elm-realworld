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

import Data.Article exposing (Articles, Article)
import Data.Msg exposing (Msg(..))

-- ROUTING
import Routes exposing (..)

type alias Model = 
  { route : Route
  , mainPageData : Maybe Articles
  , articleData : Maybe Article
  , tags : List String
  }

model : Model
model =
  { route = Home
  , mainPageData = Nothing
  , articleData = Nothing
  , tags = []
  }


parseUrlChange : Model -> Route -> (Model, Cmd Msg)
parseUrlChange model newRoute =
  case newRoute of
      Home ->
        ({model | route = newRoute}, 
         Cmd.batch 
          [ (Http.send HomeReq getArticles)
          , (Http.send TagsReq getTags)])
      Routes.Article s ->
        ({model | route = newRoute}, (Http.send ArticleReq (getArticle s)))
      _ ->
        ({model | route = newRoute}, (Http.send HomeReq getArticles))


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UrlChange loc ->
      parseUrlChange model (parseLocation loc)
    HomeReq (Ok data) ->
      ({model | mainPageData = Just data}, Cmd.none)
    HomeReq (_) ->
      (log "failed")
      (log (toString msg))
      (model, Cmd.none)
    ArticleReq (Ok data) ->
      (log "-----------")
      (log (toString data))
      (log "-----------")
      ({model | articleData = Just data.article}, Cmd.none)
    ArticleReq (_) ->
      (log "failed")
      (log (toString msg))
      (model, Cmd.none)
    TagsReq (Ok data) ->
      ({model | tags = data.tags}, Cmd.none)
    TagsReq (_) ->
      (model, Cmd.none)

view : Model -> Html Msg
view model =
  case model.route of
    Home ->
      case model.mainPageData of
        Just articles ->
          layout (home articles model.tags)
        Nothing ->
          -- TODO display an error?
          layout (home {articles = []} [])
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
    Routes.Article s ->
      case model.articleData of
        Just a ->
          layout (article a)
        Nothing ->
          -- TODO display an error?
          layout (home {articles = []} [])
    NotFoundRoute ->
      layout (div [] [text "NotFound"])

init : Location -> (Model, Cmd Msg)
init location =
  let 
    newRoute = parseLocation location
  in
    parseUrlChange model newRoute

main : Program Never Model Msg
main =
  Navigation.program UrlChange
  { init = init
  , view = view
  , update = update
  , subscriptions = (\_ -> Sub.none)
  }