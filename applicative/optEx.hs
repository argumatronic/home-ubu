import Options.Applicative as O
import Data.Semigroup ((<>))
import Control.Monad (replicateM_)

data Sample = Sample
  { hello  :: String
  , quiet  :: Bool
  , repeat :: Int }

sample :: Parser Sample
sample = Sample
     <$> strOption
         ( long "hello"
        O.<> metavar "TARGET"
        O.<> help "Target for the greeting" )
     <*> switch
         ( long "quiet"
        O.<> short 'q'
        O.<> help "Whether to be quiet" )
     <*> option auto
         ( long "repeat"
        O.<> help "Repeats for greeting"
        O.<> showDefault
        O.<> value 1
        O.<> metavar "INT" )

greet :: Sample -> IO ()
greet (Sample h False n) = replicateM_ n $ putStrLn $ "Hello, " ++ h
greet _ = return ()

main :: IO ()
main = execParser opts >>= greet
  where
    opts = info (helper <*> sample)
      ( fullDesc
     O.<> progDesc "Print a greeting for TARGET"
     O.<> header "hello - a test for optparse-applicative" )