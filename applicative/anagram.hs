import Data.List (sort)

anagram :: String -> String -> Maybe Bool
anagram xs ys = 
    case (sort xs == sort ys) of
        False -> Nothing
        True -> Just True