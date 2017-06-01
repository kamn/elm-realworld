module Views.Login exposing (..)

import Html exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (..)
import Data.Msg exposing (Msg(..))

import Utils exposing(onNoBubbleClick)

login : Html Msg
login =
    div [ class "auth-page" ]
        [ div [ class "container page" ]
            [ div [ class "row" ]
                [ div [ class "col-md-6 offset-md-3 col-xs-12" ]
                    [ h1 [ class "text-xs-center" ]
                        [ text "Sign in" ]
                    , p [ class "text-xs-center" ]
                        [ a [ href "#/register" ]
                            [ text "Need an account?" ]
                        ]
                    , Html.form []
                        [ fieldset [ class "form-group" ]
                            [ input [ class "form-control form-control-lg", placeholder "Email", type_ "text", onInput LoginName]
                                []
                            ]
                        , fieldset [ class "form-group" ]
                            [ input [ class "form-control form-control-lg", placeholder "Password", type_ "password", onInput LoginPassword ]
                                []
                            ]
                        , button [ class "btn btn-lg btn-primary pull-xs-right", onNoBubbleClick LoginPress ]
                            [ text "Sign in " ]
                        ]
                    ]
                ]
            ]
        ]
