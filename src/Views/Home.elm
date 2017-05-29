module Views.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Views.Article exposing (articlePreview)
import Utils exposing (..)
import Data.Article exposing (..)
import Data.Msg exposing (Msg(FilterTag, FilterPage))
import Data.User exposing (User)


paginationItem : Int -> Int -> Html Msg
paginationItem selectedPage page =
    li [ class (if (selectedPage + 1) == page then
                    "page-item active"
                else "page-item") ]
        -- TODO : Add class "active" to the current page
        [ a [ class "page-link", href "", onNoBubbleClick (FilterPage (page - 1)) ]
            [ text (toString page) ]
        ]


pagination : Int -> Int -> Html Msg
pagination page l =
    nav []
        [ ul [ class "pagination" ]
            (List.range 1 l
                |> List.map (\x -> paginationItem page x)
            )
        ]


home : Maybe User -> Articles -> Int -> Maybe String -> List String -> Html Msg
home user articles page selectedTag tags =
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
                                        Just _ ->
                                            []

                                        Nothing ->
                                            [ ( "display", "none" ) ]
                                    )
                                ]
                                [ a [ class "nav-link disabled", href "" ]
                                    [ text "Your Feed" ]
                                ]
                            , li [ class "nav-item" ]
                                [ a [ class "nav-link active", href "" ]
                                    [ text "Global Feed" ]
                                ]
                            , case selectedTag of
                                Just stag ->
                                    li [ class "nav-item" ]
                                        [ a [ class "nav-link", href "" ]
                                            [ i [ class "ion-pound" ] []
                                            , text (" " ++ stag)
                                            ]
                                        ]

                                Nothing ->
                                    span [] []
                            ]
                        ]
                    , List.concat
                        [ List.map articlePreview articles.articles
                        , [ pagination page (articles.articlesCount // 20) ]
                        ]
                        -- TODO : Can paginations be changed?
                        |> div []
                    ]
                , div [ class "col-md-3" ]
                    [ div [ class "sidebar" ]
                        [ p []
                            [ text "Popular Tags" ]
                        , div [ class "tag-list" ]
                            (List.map
                                (\tag ->
                                    a [ class "tag-pill tag-default", href "", onNoBubbleClick (FilterTag tag) ]
                                        [ text tag ]
                                )
                                tags
                            )
                        ]
                    ]
                ]
            ]
        ]
