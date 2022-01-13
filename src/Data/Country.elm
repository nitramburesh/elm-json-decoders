module Data.Country exposing (Model, decode)

import Json.Decode as Decode


type Model
    = Model Country


type Country
    = CZ
    | SK
    | Other


decode : Decode.Decoder Model
decode =
    Decode.map Model decodeCountry


decodeCountry : Decode.Decoder Country
decodeCountry =
    Decode.string
        |> Decode.andThen
            (\country ->
                case country of
                    "cz" ->
                        Decode.succeed CZ

                    "sk" ->
                        Decode.succeed SK

                    "other" ->
                        Decode.succeed Other

                    _ ->
                        Decode.fail (country ++ " is invalid country")
            )
