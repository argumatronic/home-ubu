myHead :: [a] -> Maybe a
myHead [] = Nothing
myHead (x:xs) = Just x

myTail :: [a] -> [a]
myTail [] = []
myTail (_:xs) = xs 


-- what's wrong here?

-- how do we fix it? there are a couple of ways ()

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (_:xs) = Just xs

