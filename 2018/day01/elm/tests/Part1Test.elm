module Part1Test exposing (..)

import Expect
import Part1
import Test exposing (..)


suite : Test
suite =
    describe "part1"
        [ test "example1" <|
            \_ ->
                Part1.solve """+1
                               -2
                               +3
                               +1"""
                    |> Expect.equal "3"
        , test "example2" <|
            \_ ->
                Part1.solve """+1
                             +1
                             +1"""
                    |> Expect.equal "3"
        , test "example3" <|
            \_ ->
                Part1.solve """+1
                             +1
                             -2"""
                    |> Expect.equal "0"
        , test "example4" <|
            \_ ->
                Part1.solve """-1
                             -2
                             -3
                             """
                    |> Expect.equal "-6"
        ]
