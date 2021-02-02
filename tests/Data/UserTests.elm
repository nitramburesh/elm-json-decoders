module Data.UserTests exposing (all)

import Data.User as User
import Expect
import Json.Decode as Decode
import Test


all : Test.Test
all =
    Test.describe "User Test Suite"
        [ Test.test "Decode user with 1 document" <|
            \_ ->
                """ 
                    { "familyMembers": [ { "relationship": "mother" }, { "relationship": "father" },  { "relationship": "sister" },  { "relationship": "brother" } ],
                      "personalDetails": { "id": "userId", "name": "John Doe", "bornDate": "2021-02-03T08:15:30-00:00", "documents": [ { "id": "docId", "documentType": "identityCard", "expireDate": "2021-02-03T08:15:30-00:00" } ], "address": { "city": "Prague", "zip": "12345", "country": "CZ", "address": "address line" } }
                    }
                """
                    |> Decode.decodeString User.decode
                    |> Expect.ok
        , Test.test "Decode user with 2 documents" <|
            \_ ->
                """ 
                    { "familyMembers": [ { "relationship": "mother" }, { "relationship": "father" },  { "relationship": "sister" },  { "relationship": "brother" } ],
                      "personalDetails": { "id": "userId", "name": "John Doe", "bornDate": "2021-02-03T08:15:30-00:00", "documents": [ { "id": "docId", "documentType": "identityCard", "expireDate": "2021-02-03T08:15:30-00:00" }, { "id": "docId", "documentType": "drivingLicense", "expireDate": "2021-02-03T08:15:30-00:00", "group": "B" } ], "address": { "city": "Prague", "zip": "12345", "country": "CZ", "address": "address line" } }
                    }
                """
                    |> Decode.decodeString User.decode
                    |> Expect.ok
        , Test.test "Should fail - no documents" <|
            \_ ->
                """ 
                    { "familyMembers": [ { "relationship": "mother" }, { "relationship": "father" },  { "relationship": "sister" },  { "relationship": "brother" } ],
                      "personalDetails": { "id": "userId", "name": "John Doe", "bornDate": "2021-02-03T08:15:30-00:00", "documents": [], "address": { "city": "Prague", "zip": "12345", "country": "CZ", "address": "address line" } }
                    }
                """
                    |> Decode.decodeString User.decode
                    |> Expect.err
        ]
