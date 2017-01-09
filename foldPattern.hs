sum' :: [Integer] -> Integer
sum' [] = 0
sum' (x:xs) = x + sum xs

length' :: [a] -> Int
-- actually these both have a Foldable constraint now but let's say it's a list
length' [] = 0
length' (_:xs) = 1 + length xs

product' :: [Integer] -> Integer
product' [] = 1
product' (x:xs) = x * product xs

concat' :: [[a]] -> [a]
concat' [] = []
concat (x:xs) = x ++ concat xs

-- pattern?
-- base case is the identity value for the function 
-- recursive pattern associates to the right: the head gets evaluated, set aside, and then the function moves
-- to the right and evaluates the next head and so on

-- like foldr! 

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f acc [] = acc
myFoldr f acc (x:xs) = f x (foldr f acc xs)
-- this type is again generalized to Foldable but we're going to pretend it's *just* a list for now

-- the acc value is a fallback value, but it is also the first value used to start the fold
-- it is often, but not always, the identity value of our folding function, e.g., 0 for addition 

foldr (+) 0 [1..5]
scanr (+) 0 [1..5]