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


decodeProfile : Decoder Profile
decodeProfile =
  decode Profile
    |> required "username" string
    |> required "bio" (nullable string)
    |> required "image" string
    |> required "following" bool

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


decodeArticles : Decoder Articles
decodeArticles =
  decode Articles
    |> required "articles" (list decodeArticle)


getArticle : String -> Http.Request Article
getArticle slug =
  Http.get (baseUrl ++ articlesApi ++ "/" ++ slug) decodeArticle


getArticles : Http.Request Articles
getArticles =
  Http.get (baseUrl ++ articlesApi) decodeArticles
