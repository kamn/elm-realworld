module Data.Msg exposing (Msg(..))

import Navigation exposing (Location)
import Http
import Data.Comment exposing (Comment, ArticleComments)
import Data.Article exposing (Articles, TagsContainer, ArticleContainer, Article)
import Data.Profile exposing (ProfileArticleView(..), ProfileContainer, Profile)
import Data.User exposing (LoginUserResponse)

-- UPDATE


type Msg
    = FilterTag String
    | FilterPage Int
    | ProfileFavArticles String
    | LoginName String
    | LoginPassword String
    | LoginPress
    | LogoutPress
    | UrlChange Navigation.Location
    | HomeReq (Result Http.Error Articles)
    | ArticleReq (Result Http.Error ArticleContainer)
    | ArticleCommentsReq (Result Http.Error ArticleComments)
    | TagsReq (Result Http.Error TagsContainer)
    | ProfileReq (Result Http.Error ProfileContainer)
    | ProfileArticlesReq (Result Http.Error Articles)
    | LoginReq (Result Http.Error LoginUserResponse) -- TODO : It will not really be articles but use that data for now
