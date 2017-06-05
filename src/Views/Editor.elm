module Views.Editor exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Data.Msg exposing (Msg)


-- TODO -  For some reason the editor didn't work though html-to-elm


editor : Html Msg
editor =
    div [ class "editor-page" ]
        [ div [ class "container page" ]
            [ div [ class "row" ]
                [ div [ class "col-md-10 offset-md-1 col-xs-12" ]
                    [ Html.form []
                        [ fieldset []
                            [ fieldset [ class "form-group" ]
                                [ input [ class "form-control form-control-lg", placeholder "Article Title", type_ "text" ]
                                    []
                                ]
                            , fieldset [ class "form-group" ]
                                [ input [ class "form-control", placeholder "What's this article about?", type_ "text" ]
                                    []
                                ]
                            , fieldset [ class "form-group" ]
                                [ textarea [ class "form-control", placeholder "Write your article (in markdown)", attribute "rows" "8" ]
                                    []
                                ]
                            , fieldset [ class "form-group" ]
                                [ input [ class "form-control", placeholder "Enter tags", type_ "text" ]
                                    []
                                , div [ class "tag-list" ]
                                    []
                                ]
                            , button [ class "btn btn-lg pull-xs-right btn-primary", type_ "button" ]
                                [ text "Publish Article            " ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
