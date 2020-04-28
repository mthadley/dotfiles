import Data.ByteString.Char8 (pack, unpack)
import Data.List (sortBy)
import Data.Ord (comparing)
import System.Environment (getArgs)
import Text.EditDistance.Linear (levenshteinDistance)

main :: IO ()
main = do
  [name] <- getArgs
  let distance = levenshteinDistance $ pack name
  interact $ unlines . map unpack . sortBy (comparing distance) . map pack . lines
