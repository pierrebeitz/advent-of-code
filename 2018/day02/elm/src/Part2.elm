module Part2 exposing (main)

import Html exposing (Html)
import List.Extra as List
import String.Extra as String


main : Html msg
main =
    Html.text <| part2 0


{-| removes the nth index from all boxIDs and then looks for identical IDs.
If none are found the next index is tried.
-}
part2 : Int -> String
part2 n =
    let
        sortedWithoutNthIndex =
            input
                |> List.map (String.replaceSlice "" n (n + 1))
                |> List.sort

        zippedList =
            List.zip sortedWithoutNthIndex ("" :: sortedWithoutNthIndex)
    in
    case List.find (\( a, b ) -> a == b) zippedList of
        Just ( a, b ) ->
            a

        Nothing ->
            part2 (n + 1)


input : List String
input =
    String.split "\n" <|
        """PASTE_YOUR_INPUT_HERE"""
