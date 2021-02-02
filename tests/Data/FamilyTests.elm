module Data.FamilyTests exposing (all)

import Data.Family as Family
import Expect
import Json.Decode as Decode
import Test


all : Test.Test
all =
    Test.describe "Family Test Suite"
        [ Test.test "No family members" <|
            \_ ->
                """ [] """
                    |> Decode.decodeString Family.decode
                    |> Expect.equal (Ok Family.noFamilyMembersDecoded)
        , Test.test "Decode only father" <|
            \_ ->
                """ [ { "relationship": "father" } ] """
                    |> Decode.decodeString Family.decode
                    |> Expect.equal (Ok Family.fatherDecoded)
        , Test.test "Decode only mother" <|
            \_ ->
                """ [ { "relationship": "mother" } ] """
                    |> Decode.decodeString Family.decode
                    |> Expect.equal (Ok Family.motherDecoded)
        , Test.test "Decode only sister" <|
            \_ ->
                """ [ { "relationship": "sister" } ] """
                    |> Decode.decodeString Family.decode
                    |> Expect.equal (Ok Family.sisterDecoded)
        , Test.test "Decode only brother" <|
            \_ ->
                """ [ { "relationship": "brother" } ] """
                    |> Decode.decodeString Family.decode
                    |> Expect.equal (Ok Family.brotherDecoded)
        , Test.test "Decode parents" <|
            \_ ->
                """ [ { "relationship": "mother" }, { "relationship": "father" } ] """
                    |> Decode.decodeString Family.decode
                    |> Expect.equal (Ok Family.bothParentsDecoded)
        , Test.test "Decode one sister and one brother" <|
            \_ ->
                """ [ { "relationship": "sister" },  { "relationship": "brother" } ] """
                    |> Decode.decodeString Family.decode
                    |> Expect.equal (Ok Family.withSiblingsDecoded)
        , Test.test "Decode all family members" <|
            \_ ->
                """ [ { "relationship": "mother" }, { "relationship": "father" },  { "relationship": "sister" },  { "relationship": "brother" } ] """
                    |> Decode.decodeString Family.decode
                    |> Expect.equal (Ok Family.withBothParentsAndsSiblingsDecoded)
        , Test.test "With unknown relationships" <|
            \_ ->
                """ [ { "relationship": "test" }, { "relationship": "ant" },  { "relationship": "cousin" },  { "relationship": "John Doe" } ] """
                    |> Decode.decodeString Family.decode
                    |> Expect.equal (Ok Family.noFamilyMembersDecoded)
        , Test.test "Decode noFamilyMembers for missing relationship field" <|
            \_ ->
                """ [ { "test": "father" }, { "ant": "father" }, { "father": "father" } ] """
                    |> Decode.decodeString Family.decode
                    |> Expect.equal (Ok Family.noFamilyMembersDecoded)
        , Test.test "Should fail - {}" <|
            \_ ->
                """ {} """
                    |> Decode.decodeString Family.decode
                    |> Expect.err
        , Test.test "Should fail - can't have 2 fathers" <|
            \_ ->
                """ [ { "relationship": "father" }, { "relationship": "father" } ] """
                    |> Decode.decodeString Family.decode
                    |> Expect.err
        , Test.test "Should fail - can't have 2 mothers" <|
            \_ ->
                """ [ { "relationship": "mother" }, { "relationship": "mother" } ] """
                    |> Decode.decodeString Family.decode
                    |> Expect.err
        ]
