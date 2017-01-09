#!/usr/bin/env stack
-- stack runghc --resolver 7.14 --install-ghc

import Data.Ord
import Data.Char
import Data.List
import System.Environment
import qualified Data.Text.IO as T
import qualified Data.Text as T
import qualified Data.Map.Strict as M


-- histogram: counts how many words of each length there are in a file
-- would like to modify to do sentence lengths
-- uses hash table
main = do
    [fp] <- getArgs
    text <- T.readFile fp
    let histo = 
        foldl' (\hash line -> M.insertWith (+) (T.length line) 1 hash)
               M.empty
               (T.lines text)
        mapM_(\(key, value) -> print (key, value))
             sortBy (flip (comparing snd) (M.toList histo)