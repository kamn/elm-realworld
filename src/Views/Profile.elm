module Views.Profile exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Data.Msg exposing (Msg)
import Data.Profile exposing (Profile, ProfileArticleView(..))
import Data.Article exposing (Article)
import Utils exposing (..)
import Views.Article exposing (articlePreview)


profileTabClass : ProfileArticleView -> ProfileArticleView -> String
profileTabClass expected passed =
    if expected == passed then
        "nav-link active"
    else
        "nav-link"


profile : Profile -> ProfileArticleView -> List Article -> Html Msg
profile pro view articles =
    div [ class "profile-page" ]
        [ div [ class "user-info" ]
            [ div [ class "container" ]
                [ div [ class "row" ]
                    [ div [ class "col-xs-12 col-md-10 offset-md-1" ]
                        [ img [ class "user-img", src pro.image ]
                            []
                        , h4 []
                            [ text pro.username ]
                        , p []
                            [ text
                                (case pro.bio of
                                    Just s ->
                                        s

                                    Nothing ->
                                        ""
                                )
                            ]
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
                                [ a [ class (profileTabClass MyArticles view), href ("#/profile/" ++ pro.username) ]
                                    [ text "My Articles" ]
                                ]
                            , li [ class "nav-item" ]
                                [ a
                                    [ class (profileTabClass FavoritedArticles view)
                                    , href ""
                                    , onNoBubbleClick (Data.Msg.ProfileFavArticles pro.username)
                                    ]
                                    [ text "Favorited Articles" ]
                                ]
                            ]
                        ]
                    , if List.length articles /= 0 then
                        List.map articlePreview articles |> div []
                      else
                        div [ class "article-preview" ] [ text "No articles are here... yet." ]
                    ]
                ]
            ]
        ]
