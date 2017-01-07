data Colors = Red | Blue | White | Black deriving (Show, Eq, Enum, Ord, Bounded)

data Animals = Dog | Cat deriving Show

instance Eq Animals where
    (==) Dog Dog = True
    (==) Cat Cat = True
    (==) _ _     = False


data Choices = Blah Colors Animals deriving (Show, Eq)

-- instance Eq Choices where
--     (==) (Blah color animal) 
--          (Blah color' animal') =
--         (color == color') && (animal == animal')