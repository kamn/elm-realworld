module Data.Profile exposing (..)

type ProfileArticleView = MyArticles | FavoritedArticles

type alias ProfileContainer =
  { profile: Profile}

type alias Profile =
  { username : String
  , bio : Maybe String
  , image : String
  , following: Bool
  }