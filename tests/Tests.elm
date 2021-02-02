module Tests exposing (all)

import Expect
import Test



-- Check out http://package.elm-lang.org/packages/elm-community/elm-test/latest to learn more about testing in Elm!


all : Test.Test
all =
    Test.describe "A Test Suite"
        [ Test.test "Addition" <|
            \_ ->
                Expect.equal 10 (3 + 7)
        ]
