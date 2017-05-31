module Data.User exposing (User)


type alias User =
    { email : String
    , token : String
    , username : String
    , bio : String
    , image : Maybe String
    }

type alias UserCred =
    { email : String
    , password : String
    }

type alias LoginUserRequest =
    { user : UserCred }