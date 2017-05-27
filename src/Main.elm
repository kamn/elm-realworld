module Main exposing (..)

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
import Data.User exposing (User)
import Data.Profile exposing (Profile, ProfileArticleView(..))
import Data.Comment exposing (..)
import Data.Msg exposing (Msg(..))


-- ROUTING

import Routes exposing (..)


type alias Model =
    { route : Route
    , mainPageData : Maybe Articles
    , articleData : Maybe Article
    , commentsData : List Comment
    , tags : List String
    , user : Maybe User
    , profile : Maybe Profile
    , profileArticles : List Article
    , profileFavArticles : List Article
    , profileView : ProfileArticleView
    , selectedTag : Maybe String
    }


model : Model
model =
    { route = Home
    , mainPageData = Nothing
    , articleData = Nothing
    , commentsData = []
    , tags = []
    , user = Nothing
    , profile = Nothing
    , profileArticles = []
    , profileFavArticles = []
    , profileView = MyArticles
    , selectedTag = Nothing
    }


parseUrlChange : Model -> Route -> ( Model, Cmd Msg )
parseUrlChange model newRoute =
    case newRoute of
        Home ->
            ( { model | route = newRoute }
            , Cmd.batch
                [ Http.send HomeReq getArticles
                , Http.send TagsReq getTags
                ]
            )

        Routes.Article s ->
            ( { model | route = newRoute }
            , Cmd.batch
                [ Http.send ArticleReq (getArticle s)
                , Http.send ArticleCommentsReq (getComments s)
                ]
            )

        Profile s ->
            ( { model | route = newRoute, profileView = MyArticles }
            , Cmd.batch
                [ Http.send ProfileReq (getProfile s)
                , Http.send ProfileArticlesReq (getUsersArticles s)
                ]
            )

        _ ->
            ( { model | route = newRoute }, (Http.send HomeReq getArticles) )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- CLIENT INTERACTIONS
        FilterTag s ->
            (log s)
                -- getFilteredArticlesByTag
                ( { model | selectedTag = Just s }, Http.send HomeReq (getFilteredArticlesByTag s) )

        ProfileFavArticles u ->
            ( { model | profileView = FavoritedArticles }, Http.send ProfileArticlesReq (getUsersFavoriteArticles u) )

        -- DATA REQUEST
        UrlChange loc ->
            parseUrlChange model (parseLocation loc)

        HomeReq (Ok data) ->
            ( { model | mainPageData = Just data }, Cmd.none )

        HomeReq _ ->
            (log "failed")
                (log (toString msg))
                ( model, Cmd.none )

        ArticleReq (Ok data) ->
            (log "-----------")
                (log (toString data))
                (log "-----------")
                ( { model | articleData = Just data.article }, Cmd.none )

        ArticleReq _ ->
            (log "failed")
                (log (toString msg))
                ( model, Cmd.none )

        ArticleCommentsReq (Ok data) ->
            (log "-----------")
                (log (toString data))
                (log "-----------")
                ( { model | commentsData = data.comments }, Cmd.none )

        ArticleCommentsReq _ ->
            (log "failed")
                (log (toString msg))
                ( model, Cmd.none )

        TagsReq (Ok data) ->
            ( { model | tags = data.tags }, Cmd.none )

        TagsReq _ ->
            ( model, Cmd.none )

        ProfileReq (Ok data) ->
            (log "-----------")
                (log (toString data))
                (log "-----------")
                ( { model | profile = Just data.profile }, Cmd.none )

        ProfileReq _ ->
            ( model, Cmd.none )

        ProfileArticlesReq (Ok data) ->
            (log "-----------")
                (log (toString data.articles))
                (log "-----------")
                ( { model | profileArticles = data.articles }, Cmd.none )

        ProfileArticlesReq _ ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    case model.route of
        Home ->
            case model.mainPageData of
                Just articles ->
                    layout model.user model.route (home model.user articles model.selectedTag model.tags)

                Nothing ->
                    -- TODO display an error?
                    layout model.user model.route (home model.user { articles = [], articlesCount = 0 } model.selectedTag [])

        Settings ->
            layout model.user model.route settings

        Login ->
            layout model.user model.route login

        Register ->
            layout model.user model.route register

        Profile s ->
            case model.profile of
                Just pro ->
                    layout model.user model.route (profile pro model.profileView model.profileArticles)

                Nothing ->
                    -- TODO Should be something else
                    layout model.user model.route (div [] [ text "NotFound" ])

        Editor ->
            layout model.user model.route editor

        Routes.Article s ->
            case model.articleData of
                Just a ->
                    layout model.user model.route (article model.user a model.commentsData)

                Nothing ->
                    -- TODO display an error?
                    layout model.user model.route (home model.user { articles = [], articlesCount = 0 } model.selectedTag [])

        NotFoundRoute ->
            layout model.user model.route (div [] [ text "NotFound" ])


init : Location -> ( Model, Cmd Msg )
init location =
    let
        newRoute =
            parseLocation location
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
