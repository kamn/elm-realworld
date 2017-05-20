module Views.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Data.Article exposing (..)
import Data.Msg exposing (Msg)

articlePreview : Article -> Html Msg
articlePreview article =
    div [ class "article-preview" ]
        [ div [ class "article-meta" ]
            [ a [ href "profile.html" ]
                [ img [ src article.author.image ]
                    []
                ]
            , div [ class "info" ]
                [ a [ class "author", href "" ]
                    [ text article.author.username ]
                , span [ class "date" ]
                    [ text article.updatedAt ] -- TODO: Convert to a actual time stamp of format "january 20th"
                    -- TODO: updatedAt or createdAt?
                ]
            , button [ class "btn btn-outline-primary btn-sm pull-xs-right" ]
                [ i [ class "ion-heart" ]
                    []
                , text (" " ++ (toString article.favoritesCount))
                ]
            ]
        , a [ class "preview-link", href "" ]
            [ h1 []
                [ text article.title ]
            , p []
                [ text 
                    (case article.description of
                        Just s -> s
                        Nothing -> "") ]
            , span []
                [ text "Read more..." ]
            ]
        ]


home : Articles -> Html Msg
home articles = 
  div [ class "home-page" ]
    [ div [ class "banner" ]
        [ div [ class "container" ]
            [ h1 [ class "logo-font" ]
                [ text "conduit" ]
            , p []
                [ text "A place to share your knowledge." ]
            ]
        ]
    , div [ class "container page" ]
        [ div [ class "row" ]
            [ div [ class "col-md-9" ]
                [ div [ class "feed-toggle" ]
                    [ ul [ class "nav nav-pills outline-active" ]
                        [ li [ class "nav-item" ]
                            [ a [ class "nav-link disabled", href "" ]
                                [ text "Your Feed" ]
                            ]
                        , li [ class "nav-item" ]
                            [ a [ class "nav-link active", href "" ]
                                [ text "Global Feed" ]
                            ]
                        ]
                    ]
                , (List.map articlePreview articles.articles) |> div []
                ]
            , div [ class "col-md-3" ]
                [ div [ class "sidebar" ]
                    [ p []
                        [ text "Popular Tags" ]
                    , div [ class "tag-list" ]
                        [ a [ class "tag-pill tag-default", href "" ]
                            [ text "programming" ]
                        , a [ class "tag-pill tag-default", href "" ]
                            [ text "javascript" ]
                        , a [ class "tag-pill tag-default", href "" ]
                            [ text "emberjs" ]
                        , a [ class "tag-pill tag-default", href "" ]
                            [ text "angularjs" ]
                        , a [ class "tag-pill tag-default", href "" ]
                            [ text "react" ]
                        , a [ class "tag-pill tag-default", href "" ]
                            [ text "mean" ]
                        , a [ class "tag-pill tag-default", href "" ]
                            [ text "node" ]
                        , a [ class "tag-pill tag-default", href "" ]
                            [ text "rails" ]
                        ]
                    ]
                ]
            ]
        ]
    ]