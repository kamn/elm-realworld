module Data.Comment exposing (Comment, ArticleComments)

import Data.Profile exposing (Profile)


type alias Comment =
    { id : Int
    , createdAt : String -- TODO - Use a Date library
    , updatedAt : String -- TODO - Use a Date library
    , body : String
    , author : Profile
    }


type alias ArticleComments =
    { comments : List Comment }
