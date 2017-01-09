mc91 :: (Ord a, Num a) => a -> a
mc91 x 
    | x > 100 = (x - 10)
    | otherwise = 91

mc91' :: (Ord a, Num a) => a -> a
mc91' x = 
  case y of
    True -> x - 10
    False -> 91
  where y = x > 100

mcCarthy :: [Integer] -> [Integer]
mcCarthy [] = []
mcCarthy (x:xs) = mc91' x : (mcCarthy xs)

mcCarth :: (Num r, Ord r) => r -> r
mcCarth n 
   | n > 100 = n - 10
   | otherwise = mcCarth $ mcCarth (n + 11)