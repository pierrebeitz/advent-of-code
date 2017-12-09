module Main exposing (..)

import Html exposing (Html, text)
import List.Extra as List
import Set exposing (Set)


type alias Banks =
    List ( Int, Int )


main : Html msg
main =
    { part1 = reallocate banks
    }
        |> toString
        |> text


reallocate banks =
    let
        -- cycles through states until a duplicate is hit.
        reallocate_ : List Banks -> Banks -> { loopOccursOnCycle : Int, seenAgo : Int }
        reallocate_ oldStates banks =
            let
                currentState =
                    cycle banks

                states =
                    currentState :: oldStates
            in
            if List.member currentState oldStates then
                { loopOccursOnCycle = List.length states
                , seenAgo = oldStates |> List.takeWhile ((/=) currentState) |> List.length |> (+) 1
                }
            else
                reallocate_ states currentState
    in
    reallocate_ [] banks


cycle : Banks -> Banks
cycle banks =
    let
        ( maxIndex, max ) =
            List.foldl findMax ( -1, -1 ) banks

        -- if the value at the highest bank is >len then every bank gets a +1
        wraparounds =
            max // len

        update ( index, val ) =
            ( index
            , if index == maxIndex then
                wraparounds
              else
                let
                    distanceFromMax =
                        (index - maxIndex) % len

                    getsOneUp =
                        (max % len) - distanceFromMax >= 0
                in
                val + wraparounds + boolToInt getsOneUp
            )
    in
    banks
        |> List.map update


banks : Banks
banks =
    List.indexedMap (,) [ 2, 8, 8, 5, 4, 2, 3, 1, 5, 5, 1, 2, 15, 13, 5, 14 ]


len : Int
len =
    List.length banks



-- Helpers


boolToInt : Bool -> number
boolToInt i =
    if i then
        1
    else
        0


{-| a fold to go through the banks and return the one with the highest value
-}
findMax : ( a, comparable ) -> ( a, comparable ) -> ( a, comparable )
findMax (( i, val ) as el) (( maxI, maxVal ) as acc) =
    if val > maxVal then
        el
    else
        acc
