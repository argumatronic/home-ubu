triple :: Integer -> Integer
triple x = x * 3

t = (\y -> y * 3) :: Integer -> Integer

-- have to give it a name for this to work which sort of defeats the purpose of the anonymous syntax! 

-- Prelude> (\y -> y * 3) :: Integer -> Integer

-- <interactive>:47:1:
--     No instance for (Show (Integer -> Integer))
--       (maybe you haven't applied enough arguments to a function?)
--       arising from a use of ‘print’
--     In a stmt of an interactive GHCi command: print it
-- Prelude> ((\y -> y * 3) :: Integer -> Integer) 1