import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)
import Views.Layout exposing (layout)
import Views.Home exposing (home)
import Navigation

type alias Model = Int
model : Model
model =
  0

-- UPDATE

type Msg = Increment | Decrement | UrlChange Navigation.Location

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      (model + 1, Cmd.none)
    Decrement ->
      (model + 1, Cmd.none)
    _ ->
      (model, Cmd.none)

view : Model -> Html Msg
view model =
  layout home


init location =
  (model, Cmd.none)

main =
  Navigation.program UrlChange
  { init = init
  , view = view
  , update = update
  , subscriptions = (\_ -> Sub.none)
  }
  --Html.beginnerProgram {model = model, view = view, update = update}

