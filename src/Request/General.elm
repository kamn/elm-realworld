module Request.General exposing (..)

import Http
import Json.Decode exposing (int, string, float, list, bool, nullable, Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)

import Data.Article exposing (..)
import Data.Profile exposing (..)

baseUrl : String
baseUrl = "https://conduit.productionready.io/api"

articlesApi : String
articlesApi = "/articles"

tagsApi : String
tagsApi = "/tags"

profileApi : String
profileApi = "/profiles"

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

decodeTagContainer : Decoder TagsContainer
decodeTagContainer =
  decode TagsContainer
    |> required "tags" (list string)

getTags : Http.Request TagsContainer
getTags =
  Http.get (baseUrl ++ tagsApi) decodeTagContainer

getArticle : String -> Http.Request ArticleContainer
getArticle slug =
  Http.get (baseUrl ++ articlesApi ++ "/" ++ slug) decodeArticleContainer

getArticles : Http.Request Articles
getArticles =
  Http.get (baseUrl ++ articlesApi) decodeArticles

getProfile : String -> Http.Request ProfileContainer
getProfile username =
  Http.get (baseUrl ++ profileApi ++ "/" ++ username) decodeProfileContainer