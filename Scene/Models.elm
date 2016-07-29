module Scene.Models exposing (..)

-- Pictures, Scene


type alias Picture =
    String


type Order
    = Background
    | Foreground


type alias Target =
    { position : ( Int, Int )
    , targetShape : TargetShape
    }


type TargetShape
    = Circle Int
    | Rect ( Int, Int )


type alias Scene =
    { background : Picture
    , foreground : Picture
    , targets : List Target
    , mouseOverTarget : Bool
    }


new : Int -> Scene
new n =
    { background = "http://gwil.co/projects/dog-statue/bg1.png"
    , foreground = "http://gwil.co/projects/dog-statue/fg" ++ toString (n + 1) ++ ".png"
    , targets = [ Target ( 300, 300 ) (Circle 100) ]
    , mouseOverTarget = False
    }



-- Mouse events, used for determining mouse positions


type ParentElement
    = Nothing
    | ParentElement (ElementWithOffsets)


type alias ElementWithOffsets =
    { offsetLeft : Int
    , offsetTop : Int
    , parentElement : ParentElement
    }


type alias MouseEvent =
    { pageX : Int
    , pageY : Int
    , target : ElementWithOffsets
    }


toRelativeCoords : MouseEvent -> ( Int, Int )
toRelativeCoords mouseEvent =
    let
        ( accumulatedLeft, accumulatedRight ) =
            accumulateOffsets mouseEvent.target
    in
        ( mouseEvent.pageX - accumulatedLeft, mouseEvent.pageY - accumulatedRight )


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



-- Targeting stuff


isMouseOverSceneTarget : ( Int, Int ) -> Scene -> Bool
isMouseOverSceneTarget mousePosition scene =
    List.any (\bool -> bool) <|
        List.map
            (\target -> isMouseOverTarget mousePosition target)
            scene.targets


isMouseOverTarget : ( Int, Int ) -> Target -> Bool
isMouseOverTarget ( x, y ) target =
    let
        ( targetX, targetY ) =
            target.position
    in
        case target.targetShape of
            Circle radius ->
                (x - targetX) ^ 2 + (y - targetY) ^ 2 < radius ^ 2

            Rect ( width, height ) ->
                let
                    widthHalf =
                        (toFloat width) / 2

                    heightHalf =
                        (toFloat height) / 2

                    top =
                        (toFloat targetY) - heightHalf

                    right =
                        (toFloat targetX) + widthHalf

                    bottom =
                        (toFloat targetY) + heightHalf

                    left =
                        (toFloat targetX) - widthHalf
                in
                    (toFloat x >= left && toFloat x <= right)
                        && (toFloat y >= top && toFloat y <= bottom)
