
-- sum types
data Colors = Red | Blue | White | Black deriving (Show, Eq)

data Animals = Dog | Cat deriving Show

instance Eq Animals where
-- == :: a -> a -> Bool
    Dog == Dog = True
    Cat == Cat = True
    _ == _     = False 

-- what's the cardinality of each?




-- product type
data Seuss =  Seuss Colors Animals deriving Show

instance Eq Seuss where
    (Seuss color animal) == (Seuss color' animal') =
        (color == color') && (animal == animal')

-- what's the cardinality of Seuss?
-- Seuss is a product of two other types
-- data constructor does not have to have the same name, but often does


-- data Sentence = Sentence Subject Verb Object
--    deriving (Eq, Show)

-- s1 = Sentence "dogs" "drool"
-- s2 = Sentence "Julie" "loves" "dogs"

-- this typechecks all together
-- but s1 doesn't because it's missing one argument
-- No instance for (Show (Object -> Sentence))
--    (maybe you haven't applied enough arguments to a function?)
-- Main> s1 "a lot"

foldr :: Foldable t => (a -> (b -> b)) -> (b -> (t a -> b))
foldr                       (+)            0    [1..5]
                                                [] ~ t

(+) :: Num a => a -> (a -> a)