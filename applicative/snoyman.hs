import Safe (readMay)


main = do
    putStrLn "Please enter your birth year"
    year <- getLine
    putStrLn $ "In 2020, you will be: " ++ show (2020 - read year)

-- but `read` is partial af


-- show how readMay works
-- We use explicit types to tell the compiler how to try and parse the
-- string.
    print (readMay "1980" :: Maybe Integer)
    print (readMay "hello" :: Maybe Integer)
    print (readMay "2000" :: Maybe Integer)
    print (readMay "two-thousand" :: Maybe Integer)

-- pattern match on the readMay result
main = do
    putStrLn "Please enter your birth year"
    yearString <- getLine
    case readMay yearString of
        Nothing -> putStrLn "You provided an invalid year"
        Just year -> putStrLn $ "In 2020, you will be: " ++ show (2020 - year)

-- decoupling the above
displayAge maybeAge =
    case maybeAge of
        Nothing -> putStrLn "You provided an invalid year"
        Just age -> putStrLn $ "In 2020, you will be: " ++ show age

yearToAge year = 2020 - year
-- now we have functions that do specific, limited things

main = do
    putStrLn "Please enter your birth year"
    yearString <- getLine
    let maybeAge =
            case readMay yearString of
                Nothing -> Nothing
                Just year -> Just (yearToAge year)
    displayAge maybeAge
-- maybeAge is pretty repetitive though. all we want is to conditionally apply `yearToAge` but we've gone through this elaborate pattern match first.
-- btw girly use this to refactor your palindrome checker -- indeed you may be able to just use that in the workshop

-- fmap does what we want it to do, because Maybe is a functor
-- i think (slight tangent coming) my insistence on thinking of functor and monad as fundamentally functions rather than 
-- types is coming from having read the little bit of category theory that i have read. but i think when people say "Maybe is a functor" 
-- they mean Maybe is a type that has (or is, ok?) a functor instance so satisfies that constraint on the f" .  
-- in Carnap and MacLane, a functor is a function (for Carnap this is less clear, granted). 
-- ok back to fmap
main = do
    putStrLn "Please enter your birth year"
    yearString <- getLine
    let maybeAge = fmap yearToAge (readMay yearString)
    displayAge maybeAge

-- "The only thing functors share is that they provide some fmap function which lets you modify their contents."
-- hmm. the type provides the function? the container provides the function? hmmm.

-- can also do with do notation
-- "Inside the do-block, we have the slurp operator <-. This operator is special for do-notation, and is used to pull a value out of its wrapper"
-- aka bind over/bind out

main = do
    putStrLn "Please enter your birth year"
    yearString <- getLine
    let maybeAge = do
            yearInteger <- readMay yearString
            return $ yearToAge yearInteger
    displayAge maybeAge

-- ok but do blocks are not really functors. they are applicatives or monads, each of which give us more power than a simple
-- fmap. let's demonstrate some of those powers.

-- we'll start by adding another function that allows us to choose two parameters

-- with pattern matching
displayAge maybeAge =
    case maybeAge of
        Nothing -> putStrLn "You provided invalid input"
        Just age -> putStrLn $ "In that year, you will be: " ++ show age

main = do
    putStrLn "Please enter your birth year"
    birthYearString <- getLine
    putStrLn "Please enter some year in the future"
    futureYearString <- getLine
    let maybeAge =
            case readMay birthYearString of
                Nothing -> Nothing
                Just birthYear ->
                    case readMay futureYearString of
                        Nothing -> Nothing
                        Just futureYear -> Just (futureYear - birthYear)
    displayAge maybeAge

-- less tediously with do-blocks and SLURPING

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
            birthYear <- readMay birthYearString
            futureYear <- readMay futureYearString
            return $ yearDiff futureYear birthYear
    displayAge maybeAge

-- "If either parse returns Nothing, then the entire do-block will return Nothing. 
-- This demonstrates an important property about Maybe: it provides short circuiting."
-- "Without resorting to other helper functions or pattern matching, there's no way to write 
--this code using just fmap. So we've found an example of code that requires more power than
-- Functors provide, and Monads provide that power."

-- but we may not have needed monads!
-- (probably go over partial application here to make sure we're all on the same page re types)

-- so we want applicative functors, to be able to apply a function which is inside a 
-- functor to a value inside a functor.

-- import Control.Applicative ((<*>))
-- is this import still necessary? i think it's in Prelude now


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
    let maybeAge =
            fmap yearDiff (readMay futureYearString)
                <*> readMay birthYearString
    displayAge maybeAge
--or
main = do
    putStrLn "Please enter your birth year"
    birthYearString <- getLine
    putStrLn "Please enter some year in the future"
    futureYearString <- getLine
-- show
    let maybeAge = yearDiff
            <$> readMay futureYearString
            <*> readMay birthYearString
-- /show
    displayAge maybeAge
-- wtf are these show comments?

-- so monads are necessary when there is *context sensitivity*
-- see brisbin.hs e.g.
-- with a monad you can make decisions on which path to follow 
-- based on *context*, i.e., previous results


-- Let's give a contrived example: if the future year is less than the birth year, we'll assume 
-- that the user just got confused and entered the values in reverse, so we'll automatically fix it by 
-- reversing the arguments to yearDiff. With do-notation and an if statement, it's easy:

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
                    then yearDiff birthYear futureYear
                    else yearDiff futureYear birthYear
    displayAge maybeAge

-- you should do exercises 3 and 4