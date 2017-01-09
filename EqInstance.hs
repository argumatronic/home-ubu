data TisAnInteger = TisAn Integer deriving Show

instance Eq TisAnInteger where
    (==) (TisAn a) (TisAn a') = a == a'

data Tuple a b = Tuple a b deriving Show

instance (Eq a, Eq b) => Eq (Tuple a b) where
    (==) (Tuple a b) (Tuple a' b') = a == a' && b == b'
