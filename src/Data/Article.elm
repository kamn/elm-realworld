module Data.Article exposing (Articles, TagsContainer, ArticleContainer, Article)

import Data.Profile exposing (Profile)


type alias Articles =
    { articles : List Article
    , articlesCount : Int
    }


type alias TagsContainer =
    { tags : List String }


type alias ArticleContainer =
    { article : Article }


type alias Article =
    { slug : String
    , title : String
    , description : Maybe String
    , body : String
    , tagList : List String
    , createdAt : String -- TODO - Use a Date library
    , updatedAt : String -- TODO - Use a Date library
    , favorited : Bool
    , favoritesCount : Int
    , author : Profile
    }
