module Request.General exposing (..)

import Http
import Json.Decode exposing (int, string, list, bool, nullable, Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode

import Data.Comment exposing (Comment, ArticleComments)
import Data.Article exposing (Articles, TagsContainer, ArticleContainer, Article)
import Data.Profile exposing (ProfileArticleView(..), ProfileContainer, Profile)
import Data.User exposing(..)

baseUrl : String
baseUrl =
    "https://conduit.productionready.io/api"


articlesApi : String
articlesApi =
    "/articles"


tagsApi : String
tagsApi =
    "/tags"


profileApi : String
profileApi =
    "/profiles"


decodeProfile : Decoder Profile
decodeProfile =
    decode Profile
        |> required "username" string
        |> required "bio" (nullable string)
        |> required "image" string
        |> required "following" bool


decodeProfileContainer : Decoder ProfileContainer
decodeProfileContainer =
    decode ProfileContainer
        |> required "profile" decodeProfile


decodeComment : Decoder Comment
decodeComment =
    decode Comment
        |> required "id" int
        |> required "createdAt" string
        |> required "updatedAt" string
        |> required "body" string
        |> required "author" decodeProfile


decodeArticleComments : Decoder ArticleComments
decodeArticleComments =
    decode ArticleComments
        |> required "comments" (list decodeComment)


decodeArticle : Decoder Article
decodeArticle =
    decode Article
        |> required "slug" string
        |> required "title" string
        |> required "description" (nullable string)
        |> required "body" string
        |> required "tagList" (list string)
        |> required "createdAt" string
        |> required "updatedAt" string
        |> required "favorited" bool
        |> required "favoritesCount" int
        |> required "author" decodeProfile


decodeArticleContainer : Decoder ArticleContainer
decodeArticleContainer =
    decode ArticleContainer
        |> required "article" decodeArticle


decodeArticles : Decoder Articles
decodeArticles =
    decode Articles
        |> required "articles" (list decodeArticle)
        |> required "articlesCount" int


decodeTagContainer : Decoder TagsContainer
decodeTagContainer =
    decode TagsContainer
        |> required "tags" (list string)


decodeUser : Decoder User
decodeUser =
    decode Data.User.User
        |> required "email" string
        |> required "token" string
        |> required "username" string
        |> required "bio" string
        |> required "image" (nullable string)


decodeUserContainer : Decoder LoginUserResponse
decodeUserContainer =
    decode LoginUserResponse
        |> required "user" decodeUser

encodeUserCred : UserCred -> Encode.Value
encodeUserCred model =
    Encode.object
        [ ("email", Encode.string model.email)
        , ("password", Encode.string model.password)]

encodeLogin : LoginUserRequest -> Encode.Value
encodeLogin model =
    Encode.object
        [("user", encodeUserCred model.user)]

getTags : Http.Request TagsContainer
getTags =
    Http.get (baseUrl ++ tagsApi) decodeTagContainer


getArticle : String -> Http.Request ArticleContainer
getArticle slug =
    Http.get (baseUrl ++ articlesApi ++ "/" ++ slug) decodeArticleContainer


getComments : String -> Http.Request ArticleComments
getComments slug =
    Http.get (baseUrl ++ articlesApi ++ "/" ++ slug ++ "/comments") decodeArticleComments


getArticles : Http.Request Articles
getArticles =
    Http.get (baseUrl ++ articlesApi) decodeArticles


getFilteredArticlesByTag : String -> Int -> Http.Request Articles
getFilteredArticlesByTag tag pageNum =
    Http.get (baseUrl ++ articlesApi ++ "?tag=" ++ tag ++ "&offset=" ++ (toString (pageNum * 20))) decodeArticles

getFilteredArticlesByPage : Int -> Http.Request Articles
getFilteredArticlesByPage pageNum =
    Http.get (baseUrl ++ articlesApi ++ "?offset=" ++ (toString (pageNum * 20))) decodeArticles

getProfile : String -> Http.Request ProfileContainer
getProfile username =
    Http.get (baseUrl ++ profileApi ++ "/" ++ username) decodeProfileContainer


getUsersArticles : String -> Http.Request Articles
getUsersArticles username =
    Http.get (baseUrl ++ articlesApi ++ "?author=" ++ username) decodeArticles


getUsersFavoriteArticles : String -> Http.Request Articles
getUsersFavoriteArticles username =
    Http.get (baseUrl ++ articlesApi ++ "?favorited=" ++ username) decodeArticles

postLogin : LoginUserRequest -> Http.Request Articles
postLogin loginData =
    Http.post  (baseUrl ++ "/users/" ++ "login") (Http.jsonBody (encodeLogin loginData)) decodeArticles