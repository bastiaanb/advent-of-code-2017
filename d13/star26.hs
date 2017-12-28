safe = map(\x -> x*2) (
        filter(\i ->
          (((i `mod` 27 == 4) || (i `mod` 27 == 22)) &&
           (i `mod` 13 == 6) &&
           (i `mod` 11 == 2) &&
           (i `mod` 7 == 5) &&
           (i `mod` 5 == 2) &&
           not(i `mod` 17 == 9))
        )
        [0,16..]
      )

main = do
  print $ take 1 $ safe
