module Views.Login exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Data.Msg exposing (Msg)

login : Html Msg
login =
  div [ class "auth-page" ]
    [ div [ class "container page" ]
        [ div [ class "row" ]
            [ div [ class "col-md-6 offset-md-3 col-xs-12" ]
                [ h1 [ class "text-xs-center" ]
                    [ text "Sign up" ]
                , p [ class "text-xs-center" ]
                    [ a [ href "" ]
                        [ text "Have an account?" ]
                    ]
                , ul [ class "error-messages" ]
                    [ li []
                        [ text "That email is already taken" ]
                    ]
                , Html.form []
                    [ fieldset [ class "form-group" ]
                        [ input [ class "form-control form-control-lg", placeholder "Your Name", type_ "text" ]
                            []
                        ]
                    , fieldset [ class "form-group" ]
                        [ input [ class "form-control form-control-lg", placeholder "Email", type_ "text" ]
                            []
                        ]
                    , fieldset [ class "form-group" ]
                        [ input [ class "form-control form-control-lg", placeholder "Password", type_ "password" ]
                            []
                        ]
                    , button [ class "btn btn-lg btn-primary pull-xs-right" ]
                        [ text "Sign up          " ]
                    ]
                ]
            ]
        ]
    ]