module Main exposing (..)

import Bitwise
import Html exposing (Html, div, text)


main : Html msg
main =
    div []
        [ { part1 = count16BitMatches ( always True, always True ) 40000000
          , part2 = count16BitMatches ( \i -> i % 4 == 0, \i -> i % 8 == 0 ) 5000000
          }
            |> toString
            |> text
        ]


count16BitMatches ( keepA, keepB ) n =
    let
        nextA =
            next 16807 keepA

        nextB =
            next 48271 keepB

        b16 =
            Bitwise.and 65535

        help n ( a, b ) sum =
            if n > 0 then
                let
                    ( a_, b_ ) =
                        ( nextA a, nextB b )

                    newSum =
                        (+) sum <|
                            if b16 a_ == b16 b_ then
                                1
                            else
                                0
                in
                help (n - 1) ( a_, b_ ) newSum
            else
                sum
    in
    help n ( 618, 814 ) 0


next mult keep val =
    let
        next val =
            let
                nextVal =
                    (val * mult) % 2147483647
            in
            if keep nextVal then
                nextVal
            else
                next nextVal
    in
    next val
