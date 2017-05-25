module Views.Profile exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Data.Msg exposing (Msg)
import Data.Profile exposing (Profile)
import Data.Article exposing (Article)

import Utils exposing (..)

import Views.Article exposing (articlePreview)


profile : Profile -> List Article -> Html Msg
profile pro articles =
  div [ class "profile-page" ]
    [ div [ class "user-info" ]
        [ div [ class "container" ]
            [ div [ class "row" ]
                [ div [ class "col-xs-12 col-md-10 offset-md-1" ]
                    [ img [ class "user-img", src pro.image ]
                        []
                    , h4 []
                        [ text (pro.username) ]
                    , p []
                        [ text 
                            (case pro.bio of 
                                Just s -> s
                                Nothing -> "") ]
                    , button [ class "btn btn-sm btn-outline-secondary action-btn" ]
                        [ i [ class "ion-plus-round" ]
                            []
                        , text (" Follow " ++ pro.username ++ " ")
                        ]
                    ]
                ]
            ]
        ]
    , div [ class "container" ]
        [ div [ class "row" ]
            [ div [ class "col-xs-12 col-md-10 offset-md-1" ]
                [ div [ class "articles-toggle" ]
                    [ ul [ class "nav nav-pills outline-active" ]
                        [ li [ class "nav-item" ]
                            [ a [ class "nav-link active", href ("#/profile/" ++ pro.username)]
                                [ text "My Articles" ]
                            ]
                        , li [ class "nav-item" ]
                            [ a [ class "nav-link", href "", onNoBubbleClick (Data.Msg.ProfileFavArticles pro.username)]
                                [ text "Favorited Articles" ]
                            ]
                        ]
                    ]
                , (List.map articlePreview articles) |> div []
                ]
            ]
        ]
    ]
