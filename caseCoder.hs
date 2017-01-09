data Employee = Coder
              | Manager
              | Veep
              | CEO
              deriving (Eq, Ord, Show)

reportBoss :: Employee -> Employee -> IO ()
reportBoss e e' = 
    putStrLn $ show e ++ " is the boss of " ++ show e'

employeeRank :: Employee -> Employee -> IO ()
employeeRank e e' =
    case compare e e' of
        GT -> reportBoss e e'
        EQ -> putStrLn "Neither employee is the boss."
        LT -> (flip reportBoss) e e'
      -- flip :: (a -> b -> c) -> b -> a -> c

rankImprovement :: (Employee -> Employee -> Ordering) -> Employee -> Employee -> IO ()
-- now it accepts a function argument where we had compare before
-- you can get identical behavior to employeeRank by using compare as that function
rankImprovement f e e' =
    case f e e' of
        GT -> reportBoss e e'
        EQ -> putStrLn "Neither employee is the boss"
        LT -> (flip reportBoss) e e'

codersRule :: Employee -> Employee -> Ordering
codersRule Coder Coder = EQ
codersRule Coder _     = GT
codersRule _ Coder     = LT
codersRule e e'        = compare e e'
-- if we use codersRule instead of compare, we upend the hierarchy