module Day10 exposing (knothash)

import Bitwise
import Char
import Hex
import Html exposing (Html, text)
import List exposing (product, range, reverse, take)
import List.Extra as List exposing (groupsOf, splitAt)
import String


type alias State =
    { stepSize : Int
    , currentPosition : Int
    , lengths : List Int
    , list : List Int
    }


main : Html msg
main =
    { part1 = process part1InitialState |> .list |> take 2 |> product
    , part2 = knothash "70,66,255,2,48,0,54,48,80,141,244,254,160,108,1,41"
    }
        |> toString
        |> text


part1InitialState =
    State 0 0 [ 70, 66, 255, 2, 48, 0, 54, 48, 80, 141, 244, 254, 160, 108, 1, 41 ] (range 0 255)


{-| Idea:

       1) 2 3 ([4] 5 -- Start
    -> ([4] 5 1) 2 3 -- Move currentPosition to the front of the list.
    -> ([1] 5 4) 2 3 -- Reverse n items. Here 3:
    -> 4) 2 3 ([1] 5 -- Revert the first Operation.

-}
process ({ currentPosition, stepSize, lengths, list } as state) =
    let
        apply length =
            list
                |> moveToFront currentPosition
                |> (splitAt length >> (\( fst, snd ) -> reverse fst ++ snd))
                |> moveToFront (List.length list - currentPosition)
    in
    case lengths of
        length :: restLengths ->
            let
                newPosition =
                    (currentPosition + length + stepSize) % List.length list
            in
            process <| State (stepSize + 1) newPosition restLengths (apply length)

        [] ->
            state


moveToFront i =
    splitAt i >> (\( fst, snd ) -> snd ++ fst)



-- Part2


process64Rounds initialState =
    let
        processHelp r state =
            if r > 0 then
                processHelp (r - 1) (process { state | lengths = initialState.lengths })
            else
                state
    in
    processHelp 64 initialState


knothash string =
    let
        initialState =
            String.toList string
                |> List.map Char.toCode
                |> (\l -> State 0 0 (l ++ [ 17, 31, 73, 47, 23 ]) (range 0 255))
    in
    process64Rounds initialState
        |> .list
        |> groupsOf 16
        |> List.map (List.foldl1 Bitwise.xor >> Maybe.withDefault 0 >> Hex.toString >> String.padLeft 2 '0')
        |> String.join ""
