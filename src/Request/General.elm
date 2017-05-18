module Request.General exposing (..)

import Http
import Json.Decode as Decode


baseUrl = "https://conduit.productionready.io/api"

articlesApi = "/articles"

getArticles : Http.Request String
getArticles =
  Http.getString (baseUrl ++ articlesApi)