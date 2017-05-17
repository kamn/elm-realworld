module Views.Editor exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

-- TODO -  For some reason the editor didn't work though html-to-elm
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
                            []
                        ]
                    ]
                ]
            ]
        ]
    ]