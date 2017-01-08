#!/usr/bin/env stack
-- stack --resolver lts-7.14 --install-ghc runghc

module Main where

import Options.Applicative as O
import Data.Semigroup ((<>))
import Control.Monad (replicateM_)
import Data.Char

-- data MyApp = MyApp { appGreet :: String }

-- runWithOptions :: MyApp -> IO ()
-- runWithOptions opts =
--   putStrLn ("Merry Christmas, " ++ appGreet opts ++ "!")

-- main :: IO ()
-- main = execParser opts >>= runWithOptions
--   where
--     parser = MyApp <$> argument str (metavar "NAME")
--     opts = info parser mempty

-- this sample is from Oliver Charles 24 Days of Hackage
-- stack exec optex Julie
-- Merry Christmas, Julie!


data MyApp = MyApp { appGreet :: String
                   , appSuperExcited :: Bool
                   }
-- add a field to the datatype for the new argument
-- notice that a flag is a Bool type

runWithOptions :: MyApp -> IO ()
runWithOptions opts =
  putStrLn $ transform $
    "Merry Christmas, " ++ appGreet opts ++ "!"

  where
    transform = if appSuperExcited opts then map toUpper else id
-- add the where clause to handle what to do if the options change

main :: IO ()
main = execParser opts >>= runWithOptions
  where
    parser = MyApp <$> argument str (metavar "NAME")
                   <*> switch (short 'e' O.<>
                               long "excited" O.<>
                               help "Run in excited mode")
    opts = info parser mempty
-- have an argument str -- the metavar allows it to provide usage information to us
-- applicatively, we have a switch (a flag) -- if that is False, we can still return the successful first parse (the string arg)
-- because the first parse isn't dependent on the second one's success in order to be parsed and return a result

-- stack exec optex Julie
-- Merry Christmas, Julie!
-- but 
-- stack exec optex Julie -e
-- Invalid option `-e'

-- ah finally
-- stack exec -- optex Julie
-- Merry Christmas, Julie!
-- $ stack exec -- optex Julie -e
-- MERRY CHRISTMAS, JULIE!

-- env PATH=$(stack path --bin-path) optex Julie -e


