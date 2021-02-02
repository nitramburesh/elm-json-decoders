module Data.Date exposing (Model, decode)

import Iso8601
import Json.Decode as Decode
import Time


type Model
    = Model Time.Posix


decode : Decode.Decoder Model
decode =
    Decode.map Model Iso8601.decoder
