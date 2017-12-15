module Main exposing (..)

import Array exposing (Array)
import Bitwise exposing (shiftRightBy)
import Day10 exposing (knothash)
import Day12 exposing (countGroups)
import Dict exposing (Dict)
import Hex
import Html exposing (Html, div, pre, span, text)
import Html.Attributes exposing (style)
import Set exposing (Set)


main : Html msg
main =
    let
        arr =
            digitSuffixedList "oundnydw" |> toArray
    in
    div []
        [ { part1 = arr |> Array.foldr (\list sum -> sum + Array.length (Array.filter ((==) '1') list)) 0
          , part2 = arr |> toConnectionDict |> countGroups |> Tuple.first
          }
            |> toString
            |> text
        ]


toArray : List String -> Array (Array Char)
toArray =
    List.map (knothashToBinary >> Array.fromList) >> Array.fromList


toConnectionDict : Array (Array Char) -> Dict Int (Set Int)
toConnectionDict arr =
    let
        len =
            Array.length arr

        filterMap fn =
            List.filterMap
                (\( i, j ) ->
                    case Array.get i arr |> Maybe.andThen (\row -> Array.get j row) of
                        Just '1' ->
                            Just (fn ( i, j ))

                        _ ->
                            Nothing
                )

        connectionsFor ( i, j ) =
            [ ( i + 1, j )
            , ( i - 1, j )
            , ( i, j + 1 )
            , ( i, j - 1 )
            ]
                |> filterMap (\( i, j ) -> i * len + j)
                |> Set.fromList
    in
    List.range 0 len
        |> List.concatMap (\i -> List.range 0 len |> List.map ((,) i))
        |> filterMap (\( i, j ) -> ( i * len + j, connectionsFor ( i, j ) ))
        |> Dict.fromList


knothashToBinary : String -> List Char
knothashToBinary string =
    knothash string
        |> String.split ""
        |> List.map (Hex.fromString >> Result.withDefault 0 >> toBitString)
        |> String.join ""
        |> String.toList


digitSuffixedList : String -> List String
digitSuffixedList s =
    List.range 0 127
        |> List.map (\suffix -> s ++ "-" ++ toString suffix)


toBitString : Int -> String
toBitString i =
    let
        help i ones =
            if i > 0 then
                help (shiftRightBy 1 i) <|
                    if i % 2 == 1 then
                        "1" ++ ones
                    else
                        "0" ++ ones
            else
                String.padLeft 4 '0' ones
    in
    help i ""
