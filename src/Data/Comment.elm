module Data.Comment exposing (..)

import Data.Profile exposing (Profile)

type alias Comment = 
 { id : Int
 , createdAt : String -- TODO - Use a Date library
 , updatedAt : String -- TODO - Use a Date library
 , body : String
 , author: Profile
 }