import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)
import Views.Layout exposing (layout)
import Views.Home exposing (home)

type alias Model = Int
model : Model
model =
  0

-- UPDATE

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1
    Decrement ->
      model - 1

view : Model -> Html Msg
view model =
  layout home


main =
  Html.beginnerProgram {model = model, view = view, update = update}

