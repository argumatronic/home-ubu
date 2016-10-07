myWords   :: String -> [String]
myWords [] = []
myWords (' ':xs) = myWords xs
myWords xs = takeWhile (/= ' ') xs:myWords (dropWhile (/= ' ') xs)



































myLines :: String -> [String]
myLines [] = []
myLines ('\n':xs) = myLines xs
myLines xs = takeWhile (/= '\n') xs:myLines (dropWhile (/= '\n') xs)

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful symmetry?"
sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen