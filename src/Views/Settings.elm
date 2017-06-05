module Views.Settings exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Data.Msg exposing (Msg(..))
import Data.User exposing (User)

getUserBio: Maybe String -> String
getUserBio maybeBio =
    case maybeBio of
        Just bio ->
            bio
        Nothing ->
            ""

settings : User -> Html Msg
settings user =
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
                                [ input [ class "form-control form-control-lg", placeholder "Username", type_ "text", value user.username ]
                                    []
                                ]
                            , fieldset [ class "form-group" ]
                                [ textarea [ class "form-control form-control-lg", placeholder "Short bio about you", attribute "rows" "8", value (getUserBio user.bio) ]
                                    []
                                ]
                            , fieldset [ class "form-group" ]
                                [ input [ class "form-control form-control-lg", placeholder "Email", type_ "text", value user.email]
                                        []
                                ]
                            , fieldset [ class "form-group" ]
                                [ input [ class "form-control form-control-lg", placeholder "New Password", type_ "password" ]
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
