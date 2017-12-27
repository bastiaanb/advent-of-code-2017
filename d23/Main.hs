import Data.Numbers.Primes

main = do
  print $ length $ filter(not.isPrime) $ take 1001 $ [109300,109317..]
