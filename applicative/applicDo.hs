{-# LANGUAGE ApplicativeDo #-}

rdr = do
    x <- (!! 2)
    y <- (!! 5)
    return [x,y] 
-- desugar this

-- Main> rdr "abcdefghijkl"
-- "cf"

-- but makes a tuple, how to make a list
rdr2 = (,) <$> (!! 2) <*> (!! 5)

rdr3 =  (!! 2) <*> (!! 5)
-- (\x y -> [x, y] <$>