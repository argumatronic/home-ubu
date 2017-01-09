module Exercises where

-- exercises from that Snoyman article, possibly adapt for workshop use 

import Safe (readMay)

-- -- yearDiff is really just subtraction. Try to replace the calls to yearDiff with explicit usage of the - operator.

displayAge maybeAge =
    case maybeAge of
        Nothing -> putStrLn "You provided invalid input"
        Just age -> putStrLn $ "In that year, you will be: " ++ show age

main = do
    putStrLn "Please enter your birth year"
    birthYearString <- getLine
    putStrLn "Please enter some year in the future"
    futureYearString <- getLine
    let maybeAge = do
            futureYear <- readMay futureYearString
            birthYear <- readMay birthYearString
            return $
-- show
                if futureYear < birthYear
                    then yearDiff birthYear futureYear
                    else yearDiff futureYear birthYear
-- /show
    displayAge maybeAge

-- show
                -- if futureYear < birthYear
                --     then birthYear - futureYear
                --     else futureYear - birthYear
-- /show


-- It's possible to write an applicative functor version of the auto-reverse-arguments code by modifying the yearDiff function. Try to do so.

import Safe (readMay)
import Control.Applicative ((<$>), (<*>))

displayAge maybeAge =
    case maybeAge of
        Nothing -> putStrLn "You provided invalid input"
        Just age -> putStrLn $ "In that year, you will be: " ++ show age

-- show
yearDiff futureYear birthYear = FIXME
-- /show

test
    | yearDiff 5 6 == 1 = putStrLn "Correct!"
    | otherwise = putStrLn "Please try again"

displayAge maybeAge =
    case maybeAge of
        Nothing -> putStrLn "You provided invalid input"
        Just age -> putStrLn $ "In that year, you will be: " ++ show age

-- show
-- yearDiff futureYear birthYear
--     | futureYear > birthYear = futureYear - birthYear
--     | otherwise = birthYear - futureYear
-- /show

main = do
    putStrLn "Please enter your birth year"
    birthYearString <- getLine
    putStrLn "Please enter some year in the future"
    futureYearString <- getLine
    let maybeAge = do
            futureYear <- readMay futureYearString
            birthYear <- readMay birthYearString
            return $
                if futureYear < birthYear
                    then yearDiff birthYear futureYear
                    else yearDiff futureYear birthYear
    displayAge maybeAge
-- where is the applicative? are you supposed to modify here too? i think so.

-- Now try to do it without modifying yearDiff directly, but by using a helper function which is applied to yearDiff.


displayAge maybeAge =
    case maybeAge of
        Nothing -> putStrLn "You provided invalid input"
        Just age -> putStrLn $ "In that year, you will be: " ++ show age

yearDiff futureYear birthYear = futureYear - birthYear
-- show
yourHelperFunction f ...
-- /show

main
    | yourHelperFunction yearDiff 5 6 == 1 = putStrLn "Correct!"
    | otherwise = putStrLn "Please try again"
import Safe (readMay)

displayAge maybeAge =
    case maybeAge of
        Nothing -> putStrLn "You provided invalid input"
        Just age -> putStrLn $ "In that year, you will be: " ++ show age

yearDiff futureYear birthYear = futureYear - birthYear

main = do
    putStrLn "Please enter your birth year"
    birthYearString <- getLine
    putStrLn "Please enter some year in the future"
    futureYearString <- getLine
    let maybeAge = do
            futureYear <- readMay futureYearString
            birthYear <- readMay birthYearString
            return $
                if futureYear < birthYear
                    then yourHelperFunction yearDiff birthYear futureYear
                    else yourHelperFunction yearDiff futureYear birthYear
    displayAge maybeAge

-- show
yourHelperFunction f x y
    | x > y = f x y
    | otherwise = f y x
-- /show