module Scene.Models exposing (..)

-- Pictures, Scene


type alias Picture =
    String


type Order
    = Background
    | Foreground


type alias Scene =
    { background : Picture
    , foreground : Picture
    }


new : Int -> Scene
new n =
    { background = "http://gwil.co/projects/dog-statue/bg1.png"
    , foreground = "http://gwil.co/projects/dog-statue/fg" ++ toString (n + 1) ++ ".png"
    }



-- Event structure


type ParentElement
    = Nothing
    | ParentElement (ElementWithOffsets)


type alias ElementWithOffsets =
    { offsetLeft : Int
    , offsetTop : Int
    , parentElement : ParentElement
    }


type alias Click =
    { pageX : Int
    , pageY : Int
    , target : ElementWithOffsets
    }


toRelativeCoords : Click -> ( Int, Int )
toRelativeCoords click =
    let
        ( accumulatedLeft, accumulatedRight ) =
            accumulateOffsets click.target
    in
        ( click.pageX - accumulatedLeft, click.pageY - accumulatedRight )


accumulateOffsets : ElementWithOffsets -> ( Int, Int )
accumulateOffsets element =
    case element.parentElement of
        Nothing ->
            ( 0, 0 )

        ParentElement parentElement ->
            let
                ( x, y ) =
                    accumulateOffsets parentElement
            in
                ( element.offsetLeft + x, element.offsetTop + y )
