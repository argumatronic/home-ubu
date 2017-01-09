--`or`, recursive
myOr       :: [Bool] -> Bool
myOr = foldr (||) False


-- any
myAny :: (a -> Bool) -> [a] -> Bool
myAny f = foldr (\ x y ->  f x || y) False

-- myAny f (x:xs) = if (f x == True) then True else (myAny f xs)

myReverse x = foldl (flip (:)) [] x



-- myAny f [] = False
-- myAny f (x:xs) 
--    | f x == True = True
--    | otherwise   = (myAny f xs)

-
- later
myAny :: (a -> Bool) -> [a] -> Bool
-- myAny f (x:xs) = if (f x == True) then True else (myAny f xs)
myAny f (x:xs) 
   | f x == True = True
   | otherwise (myAny f xs)

-- i think you can rewrite this as a fold with where instead of the anon function
