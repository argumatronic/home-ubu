tensD :: Integral a => a -> a 
tensD x = d 
    where d = snd (divMod x' 10)
          x' = fst (divMod x 10)

tensDig :: Integral a => a -> a 
tensDig x = d 
    where xLast = x `div` 10 
          d = xLast `mod` 10

hunsDig :: Integral a => a -> a
hunsDig x = d
    where d = fst (divMod x' 10)
          x' = fst (divMod x 10)