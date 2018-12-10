module Main exposing (..)

import Html exposing (Html, div, text)
import Parser exposing ((|.), (|=), Count(Exactly), Parser, end, ignore, ignoreUntil, int, keep, keyword, lazy, map, oneOf, oneOrMore, repeat, succeed, symbol, zeroOrMore)


main : Html msg
main =
    (text << toString)
        { part1 = "TODO"
        , part2 = "TODO"
        }


type Instruction
    = Snd String
    | Set
    | Add
    | Mul
    | Mod
    | Rcv
    | Jgz



-- snd X plays a sound with a frequency equal to the value of X.
-- set X Y sets register X to the value of Y.
-- add X Y increases register X by the value of Y.
-- mul X Y sets register X to the result of multiplying the value contained in register X by the value of Y.
-- mod X Y sets register X to the remainder of dividing the value contained in register X by the value of Y (that is, it sets X to the result of X modulo Y).
-- rcv X recovers the frequency of the last sound played, but only when the value of X is not zero. (If it is zero, the command does nothing.)
-- jgz X Y jumps with an offset of the value of Y, but only if the value of X is greater than zero. (An offset of 2 skips the next instruction, an offset of -1 jumps to the previous instruction, and so on.)


input =
    let
        instruction =
            oneOf
                []

        parser =
            repeat oneOrMore instruction

        parse stuff =
            case Parser.run parser stuff of
                Ok result ->
                    result

                Err err ->
                    Debug.crash (toString err)
    in
    parse """set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 735
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19"""
