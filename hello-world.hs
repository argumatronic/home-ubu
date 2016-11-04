-- stack new hello simple
-- talk a little bit about what stack is
-- show the tree, show the cabal and yaml files. 

-- stack build
-- stack exec hello

module Main where
-- module name: capitalize, what is a module

-- first demonstrate how to print "hello world" in ze repl

-- IO () indicates this is an executable, will perform side effects, 
--monadic but usable w/o understanding monads, 
-- () is a return value that signifies nothing, i.e., no significant return value from
-- function application but performs effects

-- do syntax: syntactic sugar for monadic binding, but the handy thing is you don't have to care about that
-- allows you to sequence instructions for your program execution
-- order of declarations within a module doesn't matter; but ordering w/in a monadic context 
-- (do block here) does!

main :: IO ()
main = do 
    print "Hello, world!"
    putStrLn $ "hello " ++ "world!"

-- dollar sign means the right side will get eval'd first, could also write
-- putStrLn ("hello " ++ "world!")
-- stack exec hello
-- i think stack exec does not include a redo of stack build

main = do 
    name <- getLine
    putStrLn ("hello " ++ name)

-- stack build
-- stack exec hello
-- after this change, interact with it via repl.

** END LESSON ONE

-- introduce palindrome check
isPal :: String -> Bool
isPal xs = xs == reverse xs
-- demo in le repl

-- now we're going to add getLine which takes input and then uses the pure function isPal to check if the user input 
-- is a palindrome.
-- need the "print" there because it's gotta print the result of "isPal word" to the screen
-- ghci automatically invokes that for you, but outside of ghci you have to be explicit about wanting to print the result.
-- printing is also IO but we don't need to care about that
-- the type signature of main indicates that we perform IO actions and return no other result. the empty tuple is a value
-- signifying that we did some stuff but there's not output value other than those actions.
main :: IO ()
main = do 
    word <- getLine
    print $ isPal word

-- now, that's in IO, but we want to write some pure functions that we can combine in our main IO action

-- want to add checks for "is there a word?" "is it a word?" and "are there spaces/uppercase?"
-- we'll use Maybe to check if we even have a string

-- is the user input empty?
-- nonEmpty tells us if we have an empty string. we'll use the Maybe type to give us cases 
    -- (an "exception" case and a "success" case) to match on later
nonEmpty :: String -> Maybe String
nonEmpty xs =
    case xs == "" of
        True -> Nothing
        False -> Just xs

-- we can add that check to our main action like this, note the pattern matching within the case expression:
main = do
    word <- getLine
    case nonEmpty word of
        Nothing -> putStrLn "Please enter a word."
        Just word -> print (isPal word)

-- now we also want to know that the input we got is alphabetic, i.e., a word. or maybe you don't if you want to allow
    -- numbers in your palindromes! but we will check for that.
-- import Data.Char to use isAlpha

-- we'll write another pure function that just checks that every character in the string is alphabetic.
isWord :: String -> Bool
isWord xs = all isAlpha xs

-- and adding that to our main action. now we have nested case expressions and we're catching two potential problems with 
-- the user input
main = do 
    word <- getLine
    case nonEmpty word of 
        Nothing -> putStrLn "Please enter a word."
        Just word -> do
            case isWord word of
               False -> putStrLn "This is not a word."
               True -> print $ isPal word

-- but this will say "taco cat" is not a word because the space isn't alphabetic
-- modify the palindrome checker to eliminate uppercase and spaces
pal' :: String -> String
pal' xs = (map toLower . concat . words) xs

main = do 
    word <- getLine
    case nonEmpty word of 
        Nothing -> putStrLn "Please enter a word."
        Just word -> do
            let word' = pal' word
            -- i used pal' here after testing it first to see if it's an empty string, but before testing it for 
            -- being an alphabetic word
            case isWord word' of
               False -> putStrLn "This is not a word."
               True -> print $ isPal word'

-- let's have it tell us it is or is not a palindrome instead of just printing True/False

-- True -> do
    case isPal word' of
        False -> putStrLn "This is not a palindrome"
        True -> putStrLn "This is a palindrome."

** END LESSON TWO

BONUS ROUND:
-- forever plus exitSuccess
-- import Control.Monad (forever)
-- import System.Exit (exitSuccess)
-- need to give it an exit condition!
-- isPal no longer evaluates to a Bool, but to an IO action

isPal
isPal xs 
    | xs == reverse xs = putStrLn "It's a palindrome!"
    | otherwise = do
        putStrLn "Not a palindrome."
        exitSuccess

case isPal word' of
        False -> putStrLn "This is not a palindrome"
        True -> isPal word' 

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

** END LESSON THREE -- now they can make a looping IO program, which is handy for making games.


-- Prelude> let isPal xs = print (xs == reverse xs)
-- Prelude> :t isPal
-- isPal :: Eq a => [a] -> IO ()
-- Prelude> getLine >>= isPal
-- tacocat
-- True
-- to desugar that do-syntax you have to put the IO into the isPal function because TYPES girl.