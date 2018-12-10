module Main exposing (..)

import Html exposing (Html, div, text)
import List.Extra as List exposing (splitAt)
import Parser exposing ((|.), (|=), Count(Exactly), Parser, end, ignore, ignoreUntil, int, keep, keyword, lazy, map, oneOf, oneOrMore, repeat, succeed, symbol, zeroOrMore)


main : Html msg
main =
    (text << toString)
        { part1 = part1 356 2017
        , part2 = part2 356 0 0 1
        }


part1 input n =
    let
        rotate n list =
            List.drop (n % List.length list) list ++ List.take (n % List.length list) list

        help m list =
            if n < m then
                list
            else
                help (m + 1) (m :: rotate (input + 1) list)
    in
    help 1 [ 0 ] |> List.getAt 1


part2 skip afterZero i n =
    if n == 50000001 then
        afterZero
    else
        let
            next =
                (i + skip) % n
        in
        part2 skip
            (if next == 0 then
                n
             else
                afterZero
            )
            (next + 1)
            (n + 1)
