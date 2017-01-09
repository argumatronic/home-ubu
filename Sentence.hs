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