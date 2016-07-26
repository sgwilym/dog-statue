module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Timeline.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TimelineMsg subMsg ->
            let
                ( updatedTimeline, cmd ) =
                    Timeline.Update.update subMsg model.timeline
            in
                ( { model | timeline = updatedTimeline }, Cmd.map TimelineMsg cmd )
