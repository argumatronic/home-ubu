
-- sum types
data Colors = Red | Blue | White | Black deriving Show

data Animals = Dog | Cat 

-- what's the cardinality of each?


-- product type
data Seuss =  Seuss Colors Animals

-- what's the cardinality of Seuss?
-- Seuss is a product of two other types
-- data constructor does not have to have the same name, but often does

type Subject = String
type Verb = String
type Object = String

data Sentence = Sentence Subject Verb Object
   deriving (Eq, Show)

s1 = Sentence "dogs" "drool"
s2 = Sentence "Julie" "loves" "dogs"

-- this typechecks all together
-- but s1 doesn't because it's missing one argument
-- No instance for (Show (Object -> Sentence))
--    (maybe you haven't applied enough arguments to a function?)
-- Main> s1 "a lot"