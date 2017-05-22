module Views.Layout exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Data.Msg exposing (Msg)
import Data.User exposing (User)
import Routes exposing (Route(..))

stylesheet : String -> Html Msg
stylesheet url =
    let
        tag = "link"
        attrs =
            [ attribute "rel"       "stylesheet"
            , attribute "property"  "stylesheet"
            , type_ "text/css"
            , attribute "href"      url
            ]
        children = []
    in 
        node tag attrs children

type NavbarLinks
    = Home
    | NewPost
    | Settings
    | SignUp
    | SignIn

getLinkClasses : NavbarLinks -> Route -> String
getLinkClasses navLinks route =
    case route of
        Routes.Home ->
            case navLinks of
                Home -> "nav-link active"
                _ -> "nav-link"
        Routes.Editor ->
            case navLinks of
                NewPost -> "nav-link active"
                _ -> "nav-link"
        Routes.Settings ->
            case navLinks of
                Settings -> "nav-link active"
                _ -> "nav-link"
        Routes.Register ->
            case navLinks of
                SignUp -> "nav-link active"
                _ -> "nav-link"
        Routes.Login ->
            case navLinks of
                SignIn -> "nav-link active"
                _ -> "nav-link"
        _ -> "nav-link"

getLoggedInNav : Route -> List (Html Msg)
getLoggedInNav route =
    [ li [ class "nav-item" ]
        [ a [ class (getLinkClasses Home route), href "#/" ]
            [ text "Home" ]
        ]
    , li [ class "nav-item" ]
        [ a [ class (getLinkClasses NewPost route), href "#/editor" ]
            [ i [ class "ion-compose" ]
                []
            , text " New Post            "
            ]
        ]
    , li [ class "nav-item" ]
        [ a [ class (getLinkClasses Settings route), href "#/settings" ]
            [ i [ class "ion-gear-a" ]
                []
            , text " Settings            "
            ]
        ]
    , li [ class "nav-item" ]
        [ a [ class (getLinkClasses SignUp route), href "#/register" ]
            [ text "Sign up" ]
        ]
    ]

getNotLoggedInNav : Route -> List (Html Msg)
getNotLoggedInNav route =
    [ li [ class "nav-item" ]
        [ a [ class (getLinkClasses Home route), href "#/" ]
            [ text "Home" ]
        ]
    , li [ class "nav-item" ]
        [ a [ class (getLinkClasses SignIn route), href "#/login" ]
            [ text "Sign in" ]
        ]
    , li [ class "nav-item" ]
        [ a [ class (getLinkClasses SignUp route), href "#/register" ]
            [ text "Sign up" ]
        ]
    ]

-- TODO Figure out how to do this outside of elm
-- node "title" [] [ text "Conduit" ]
layout : Maybe User -> Route -> Html Msg -> Html Msg
layout maybeUser route container =
    div [class "page-frame"]
          [ stylesheet "//code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"
          , stylesheet "//fonts.googleapis.com/css?family=Titillium+Web:700|Source+Serif+Pro:400,700|Merriweather+Sans:400,700|Source+Sans+Pro:400,300,600,700,300italic,400italic,600italic,700italic"
          , stylesheet "//demo.productionready.io/main.css"
          , node "style" [ type_ "text/css" ]
            [ text "@import url(http://fonts.googleapis.com/css?family=Source+Sans+Pro);html {  margin: 0;  height: auto;}" ]
          , nav [ class "navbar navbar-light" ]
                [ div [ class "container" ]
                    [ a [ class "navbar-brand", href "#/" ]
                        [ text "conduit" ]
                    , ul [ class "nav navbar-nav pull-xs-right" ]
                        (case maybeUser of
                            Just user -> getLoggedInNav route
                            Nothing -> getNotLoggedInNav route)
                    ]
                ]
            , container
            , footer []
                [ div [ class "container" ]
                    [ a [ class "logo-font", href "/" ]
                        [ text "conduit" ]
                    , span [ class "attribution" ]
                        [ text "An interactive learning project from "
                        , a [ href "https://thinkster.io" ]
                            [ text "Thinkster" ]
                        , text ". Code & design licensed under MIT.        "
                        ]
                    ]
                ]
            ]
