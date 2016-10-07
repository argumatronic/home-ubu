module Main where
  
import Data.Char

isPal :: String -> Bool
isPal xs = xs == reverse xs

pal' :: String -> String
pal' xs = (map toLower . concat . words) xs

nonEmpty :: String -> Maybe String
nonEmpty xs =
	case xs == "" of
		True  -> Nothing
		False -> Just xs

isWord :: String -> Bool
isWord xs = all isAlpha xs

main :: IO()
main = do
  word <- getLine
  case nonEmpty word of
    Nothing -> putStrLn "Please enter a word."
    Just word -> do
      let word' = pal' word
      case isWord word' of
        False -> putStrLn "This is not a word."
        True -> print $ isPal word'
