#!/usr/bin/env stack
-- stack runghc --resolver lts-7.14 --install-ghc --package fsnotify

{-# LANGUAGE OverloadedStrings #-} -- for FilePath literals

import System.FSNotify 
import Control.Concurrent (threadDelay)
import Control.Monad (forever)

-- this notifies you of any changes in the files in the current working directory (.)
-- Chris Done/fpco
main = 
    withManager $ \mgr -> do
        -- start a watching job (in the background)
        watchDir
          mgr             -- manager
          "."             -- directory to watch
          (const True)    -- predicate
          print           -- action
          -- sleep forever (until interrupted)
          forever $ threadDelay 1000000