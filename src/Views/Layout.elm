module Views.Layout exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Data.Msg exposing (Msg)
import Data.User exposing (User)
import Routes exposing (Route(..))


stylesheet : String -> Html Msg
stylesheet url =
    let
        tag =
            "link"

        attrs =
            [ attribute "rel" "stylesheet"
            , attribute "property" "stylesheet"
            , type_ "text/css"
            , attribute "href" url
            ]

        children =
            []
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
                Home ->
                    "nav-link active"

                _ ->
                    "nav-link"

        Routes.Editor ->
            case navLinks of
                NewPost ->
                    "nav-link active"

                _ ->
                    "nav-link"

        Routes.Settings ->
            case navLinks of
                Settings ->
                    "nav-link active"

                _ ->
                    "nav-link"

        Routes.Register ->
            case navLinks of
                SignUp ->
                    "nav-link active"

                _ ->
                    "nav-link"

        Routes.Login ->
            case navLinks of
                SignIn ->
                    "nav-link active"

                _ ->
                    "nav-link"

        _ ->
            "nav-link"


getLoggedInNav : User -> Route -> List (Html Msg)
getLoggedInNav user route =
    [ li [ class "nav-item" ]
        [ a [ class (getLinkClasses Home route), href "#/" ]
            [ text "Home" ]
        ]
    , li [ class "nav-item" ]
        [ a [ class (getLinkClasses NewPost route), href "#/editor" ]
            [ i [ class "ion-compose" ]
                []
            , text " New Post"
            ]
        ]
    , li [ class "nav-item" ]
        [ a [ class (getLinkClasses Settings route), href "#/settings" ]
            [ i [ class "ion-gear-a" ]
                []
            , text " Settings"
            ]
        ]
    , li [ class "nav-item" ]
        [ a [ class (getLinkClasses SignUp route), href ("#/profile/" ++ user.username)]
            [ text user.username ]
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
    div [ class "page-frame" ]
        [  nav [ class "navbar navbar-light" ]
            [ div [ class "container" ]
                [ a [ class "navbar-brand", href "#/" ]
                    [ text "conduit" ]
                , ul [ class "nav navbar-nav pull-xs-right" ]
                    (case maybeUser of
                        Just user ->
                            getLoggedInNav user route

                        Nothing ->
                            getNotLoggedInNav route
                    )
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
