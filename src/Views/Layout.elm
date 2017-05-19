module Views.Layout exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Data.Msg exposing (Msg)

layout : Html Msg -> Html Msg
layout container =
    div []
          [ node "head" []
              [ node "meta" [ charset "utf-8" ]
                  []
              , node "title" []
                  [ text "Conduit" ]
              , node "link" [ href "//code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css", rel "stylesheet", type_ "text/css" ]
                  []
              , node "link" [ href "//fonts.googleapis.com/css?family=Titillium+Web:700|Source+Serif+Pro:400,700|Merriweather+Sans:400,700|Source+Sans+Pro:400,300,600,700,300italic,400italic,600italic,700italic", rel "stylesheet", type_ "text/css" ]
                  []
              , node "link" [ href "//demo.productionready.io/main.css", rel "stylesheet" ]
                  []
              ]
          , div [class "page-frame"]
                -- TODO - Highlight different components depending on where they are routing
              [ nav [ class "navbar navbar-light" ]
                  [ div [ class "container" ]
                      [ a [ class "navbar-brand", href "#/" ]
                          [ text "conduit" ]
                      , ul [ class "nav navbar-nav pull-xs-right" ]
                          [ li [ class "nav-item" ]
                              [ a [ class "nav-link active", href "#/" ]
                                  [ text "Home" ]
                              ]
                          , li [ class "nav-item" ]
                              [ a [ class "nav-link", href "#/editor" ]
                                  [ i [ class "ion-compose" ]
                                      []
                                  , text " New Post            "
                                  ]
                              ]
                          , li [ class "nav-item" ]
                              [ a [ class "nav-link", href "#/settings" ]
                                  [ i [ class "ion-gear-a" ]
                                      []
                                  , text " Settings            "
                                  ]
                              ]
                          , li [ class "nav-item" ]
                              [ a [ class "nav-link", href "#/register" ]
                                  [ text "Sign up" ]
                              ]
                          ]
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
          ]