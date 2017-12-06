import Data.Char
import Data.List
import Data.List.Split
import Data.Array

runit p = jump p 1 0

jump p c t =
  if (c < 1) || (c > (length p)) then
    (c, t)
  else
    jump (p // [(c, 1 + p!c)]) (c + p!c) (t + 1)

main = do
  contents <- getContents
  let
    input = map (read :: String -> Int) $ words contents
  print $ runit $ listArray (1, length input) input
