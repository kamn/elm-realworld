port module Ports exposing (..)

-- PORTS
port saveSession : String -> Cmd msg
port doLoadSession: () -> Cmd msg
port loadSession: (Maybe String -> msg) -> Sub msg
