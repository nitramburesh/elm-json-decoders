module Data.DateTests exposing (all)

import Data.Date as Date
import Expect
import Json.Decode as Decode
import Test


all : Test.Test
all =
    Test.describe "Date Test Suite"
        [ Test.test "Decode date in valid format" <|
            \_ ->
                """ "2021-02-03T08:15:30-00:00" """
                    |> Decode.decodeString Date.decode
                    |> Expect.ok
        , Test.test "Should fail - invalid ISO8601 format" <|
            \_ ->
                """ "string" """
                    |> Decode.decodeString Date.decode
                    |> Expect.err
        , Test.test "Should fail - invalid type" <|
            \_ ->
                """ { "date": "2021-02-03T08:15:30-00:00" } """
                    |> Decode.decodeString Date.decode
                    |> Expect.err
        ]
