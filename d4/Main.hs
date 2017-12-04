import Data.List
import Data.List.Unique

countValid m = length . filter allUnique . map(m) . lines

main = do
  input <- getContents
  print $ countValid words input
  print $ countValid (map(sort) . words) input
