module Vignette.Update exposing (..)

import Vignette.Messages exposing (Msg(..))
import Vignette.Models exposing (Vignette, nextSlide)


update : Msg -> Vignette -> ( Maybe Vignette, Cmd Msg )
update message vignette =
    case message of
        Progress ->
            case nextSlide vignette of
                Vignette.Models.Finished ->
                    ( Nothing, Cmd.none )

                Vignette.Models.Next index ->
                    ( Just ({ vignette | currentSlide = index }), Cmd.none )
