module Views.Settings exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Data.Msg exposing (Msg(..))


settings : Html Msg
settings =
    div [ class "settings-page" ]
        [ div [ class "container page" ]
            [ div [ class "row" ]
                [ div [ class "col-md-6 offset-md-3 col-xs-12" ]
                    [ h1 [ class "text-xs-center" ]
                        [ text "Your Settings" ]
                    , Html.form []
                        [ fieldset []
                            [ fieldset [ class "form-group" ]
                                [ input [ class "form-control", placeholder "URL of profile picture", type_ "text" ]
                                    []
                                ]
                            , fieldset [ class "form-group" ]
                                [ input [ class "form-control form-control-lg", placeholder "Your Name", type_ "text" ]
                                    []
                                ]
                            , fieldset [ class "form-group" ]
                                [ textarea [ class "form-control form-control-lg", placeholder "Short bio about you", attribute "rows" "8" ]
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
                                [ text "Update Settings              " ]
                            ]
                        ]
                    , hr [] []
                    , button [class "btn btn-outline-danger", onClick LogoutPress]
                        [text "Or click here to logout."]
                    ]
                ]
            ]
        ]
