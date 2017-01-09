-- main = do  
--     contents <- getContents  
--     putStr (shortLinesOnly contents)  
  
shortLinesOnly :: String -> String  
shortLinesOnly input =   
    let allLines = lines input  
        shortLines = filter (\line -> length line <= 10) allLines  
        result = unlines shortLines  
    in  result  


-- try turning this into an optparse thing where the different arguments 
-- represent different things you want to filter the text for
-- usage:
-- $ ghc --make shortlinesonly  
-- [1 of 1] Compiling Main             ( shortlinesonly.hs, shortlinesonly.o )  
-- Linking shortlinesonly ...  
-- $ cat shortlines.txt | ./shortlinesonly  

-- main = interact shortLinesOnly  
-- interact takes a String -> String function and returns IO () and can be used in much the same way as the original getContents do block above

-- could rewrite the whole thing as:
mainAlt = interact $ unlines . filter ((<10) . length) . lines 
-- but this seems a little "hold my beer"

-- interact can either get piped a single dose of content or
-- it can repeatedly take user input and dump the result over and over
-- as in the next example

respondPalindromes contents = unlines (map (\xs -> if isPalindrome xs then "palindrome" else "not a palindrome") (lines contents))  
    where   isPalindrome xs = xs == reverse xs  

main = interact respondPalindromes 
-- use this one like this 
-- runhaskell short.hs
-- unless you want to pipe it the contents of a file
