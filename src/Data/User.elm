module Data.User exposing (User, UserCred, LoginUserRequest, LoginUserResponse)


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

type alias LoginUserResponse =
    { user : User}