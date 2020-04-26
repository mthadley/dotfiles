import Data.List (sortBy)
import Data.Ord (comparing)
import System.Environment (getArgs)
import Text.EditDistance

main :: IO ()
main = do
  [name] <- getArgs
  let distance = levenshteinDistance defaultEditCosts name
  interact $ unlines . sortBy (comparing distance) . lines
