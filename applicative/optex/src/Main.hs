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


-- what Chris wants to know about is this:
-- yeah
-- subparsers I think
-- well
-- The concrete example I didn't know how to do was
-- Most programs have a --version flag, right
-- yah
-- Chris Martin (ch.martin@gmail.com)
-- So I wanted to be able to take the disjunction of two parsers
-- One for just --version, the other for the whole rest of the args
-- -version isn't an argument, it's a flag
-- the latter, other options should succeed without it
-- ok
-- Chris Martin (ch.martin@gmail.com)
-- actually idk I'm not sure if I understood what you meant by "argument" or not
-- because I'm about to call it an argument:
-- likewise if --version is the only argument, all the other args shouldn't be provided
-- ah you want that kind of disjunction
-- Chris Martin (ch.martin@gmail.com)
-- and if you provide both --version and some other args... idk, it should probably fail to parse
-- exclusive


-- ok so we should write a program that, given a text file for input, returns a list of the n most-frequently-appearing words