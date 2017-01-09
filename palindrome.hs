import Data.Char (isAlpha, toLower)
import Control.Monad (forever)
import System.Exit (exitSuccess)

isPal :: String -> IO ()
isPal xs
    | xs == reverse xs = putStrLn "It's a palindrome!"
    | otherwise = do
      putStrLn "Not a palindrome"
      exitSuccess


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
main = forever $ do
  word <- getLine
  case nonEmpty word of
    Nothing -> putStrLn "Please enter a word."
    Just word -> do
      let word' = pal' word
      case isWord word' of
        False -> putStrLn "This is not a word."
        True -> isPal word'

        -- True -> do
        --   case isPal word' of
        --     False -> putStrLn "This is not a palindrome."
        --     True -> putStrLn "It's a palindrome!"
