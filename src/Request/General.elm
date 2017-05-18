module Request.General exposing (..)

import Http
import Json.Decode exposing (int, string, float, list, bool, nullable, Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)

import Data.Article exposing (..)
import Data.Profile exposing (..)


baseUrl = "https://conduit.productionready.io/api"

articlesApi = "/articles"


decodeProfile =
  decode Profile
    |> required "username" string
    |> required "bio" (nullable string)
    |> required "image" string
    |> required "following" bool

decodeArticle = 
  decode Article
    |> required "slug" string
    |> required "title" string
    |> required "description" string
    |> required "body" string
    |> required "tagList" (list string)
    |> required "createdAt" string
    |> required "updatedAt" string
    |> required "favorited" bool
    |> required "favoritesCount" int
    |> required "author" decodeProfile



decodeArticles =
  decode Articles
    |> required "articles" (list decodeArticle)


getArticles : Http.Request Articles
getArticles =
  Http.get (baseUrl ++ articlesApi) decodeArticles