port module Ports exposing (..)

import Data.Article exposing (Articles, Article)
import Data.User exposing (User, LoginUserRequest)
import Data.Profile exposing (Profile, ProfileArticleView(..))
import Data.Comment exposing (..)
import Data.Msg exposing (Msg(..))

-- PORTS
port saveSession : String -> Cmd msg
port doLoadSession: () -> Cmd msg
port loadSession: (Maybe String -> msg) -> Sub msg
