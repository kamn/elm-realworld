module Views.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Data.Article exposing (..)
import Data.Msg exposing (Msg)
import Data.User exposing (User)

import Date.Format exposing (format)

import Date exposing (fromString)

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
                    [ text 
                        (case (fromString article.updatedAt) of
                            Err _ -> "..." -- What to really do here? 
                            Ok d -> 
                                format "%B %e, %Y" d) ]
                ]
            , button [ class "btn btn-outline-primary btn-sm pull-xs-right" ]
                [ i [ class "ion-heart" ]
                    []
                , text (" " ++ (toString article.favoritesCount))
                ]
            ]
        , a [ class "preview-link", href ("#/article/" ++ article.slug) ]
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


home : Maybe User -> Articles -> List String -> Html Msg
home user articles tags = 
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
                        [ li 
                            [ class "nav-item"
                            , style
                                (case user of
                                    Just m ->
                                        [] 
                                    Nothing ->
                                        [("display","none")])]
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
                        (List.map 
                            (\tag -> 
                                a [ class "tag-pill tag-default", href "" ]
                                  [ text tag ]) tags)
                    ]
                ]
            ]
        ]
    ]