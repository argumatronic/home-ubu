import Data.Time

data DatabaseItem = DbString String
                  | DbNumber Integer
                  | DbDate UTCTime
                  deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase =
    [ DbDate (UTCTime 
             (fromGregorian 1911 5 1)
             (secondsToDiffTime 34123)), 
      DbNumber 9001, 
      DbString "Hello, world!", 
      DbDate (UTCTime
             (fromGregorian 1921 5 1)
             (secondsToDiffTime 34123))
    ]

-- filters for DbDate values, returns a list of the UTCTime values inside them
filterDate :: [DatabaseItem] -> [UTCTime]
filterDate = foldr f []
  where f (DbDate a) b = a : b
        f _ b = b

-- (a -> b -> b) -> b -> [a] -> b
--       f         []    theDb 
-- (a ->       b -> b)
-- (DbDate a)  b  

-- filters for DbNumber values, returns a list of the Integer values inside them
filterNum :: [DatabaseItem] -> [Integer]
filterNum = foldr f []
  where f (DbNumber a) b = a : b
        f _ b = b

-- gets the most recent date
mostRecent :: [DatabaseItem] -> UTCTime
mostRecent = foldr f (UTCTime (fromGregorian 0 1 1) (secondsToDiffTime 0))
  where f (DbDate a) b
          | a > b = a
          | otherwise = b
        f _ b = b

-- sums of the DbNumber values
sumDb :: [DatabaseItem] -> Integer
sumDb = foldr f 0
  where f (DbNumber a) b = a + b
        f _ b = b

-- averages the DbNumber values
-- may need fromIntegral to get from Integer to Double
avgDb :: [DatabaseItem] -> Double
avgDb = average . filterNum
  where average [] = 0
        average xs = fromIntegral (sum xs) / fromIntegral (length xs)


