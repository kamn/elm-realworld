module Data.Article exposing (..)

import Data.Profile exposing (Profile)

type alias Articles =
  { articles: List Article
  }

type alias Article = 
 { slug : String
 , title : String
 , description : String
 , body : String
 , tagList : List String
 , createdAt : String -- TODO - Use a Date library
 , updatedAt : String -- TODO - Use a Date library
 , favorited : Bool
 , favoritesCount : Int
 , author: Profile
 }