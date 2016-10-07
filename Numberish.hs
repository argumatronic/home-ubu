class Numberish a where
   fromNumber :: Integer -> a
   toNumber :: a -> Integer
-- notice this is only types

newtype Age = A Integer deriving (Eq, Show)

instance Numberish Age where
    fromNumber n = A n
    toNumber (A n) = n

newtype Year = Year Integer deriving (Eq, Show)

instance Numberish Year where
    fromNumber n = Year n
    toNumber (Year n) = n

sumNumberish :: Numberish a => a -> a -> a
sumNumberish a a' = fromNumber summed
   where integerOfA = toNumber a
         integerOfAPrime = toNumber a'
         summed = integerOfA + integerOfAPrime

-- will it work for Year values?
-- where is it finding the code to execute? in the instances, per type.
