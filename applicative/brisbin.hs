data User = User
    { userFirstName :: String
    , userLastName  :: String
    , userEmail     :: String
    } 
    deriving (Show, Eq)

type Profile = [(String, String)]

-- 
julie = [("first_name", "Julie"), ("last_name", "Moronuki"), ("email", "srs_haskell_cat@aol.com")]
user = [("first_name", "Jack"), ("email", "ice.skrig@gmail.com")]
mydude = [("email", "fire.keramik@hotmail.com")]


buildUser :: Profile -> Maybe User
buildUser p =
    case lookup "first_name" p of
        Nothing -> Nothing
        Just fn -> case lookup "last_name" p of
            Nothing -> Nothing
            Just ln -> case lookup "email" p of
                Nothing -> Nothing
                Just e  -> Just $ User fn ln e

buildUserM :: Profile -> Maybe User
buildUserM p = do
    fn <- lookup "first_name" p
    ln <- lookup "last_name" p
    e  <- lookup "email" p

    return $ User fn ln e

-- Using Monad means we have the ability to access the values returned 
-- by earlier lookup expressions in later ones. 
-- That ability is often critical, but not always. 
-- In many cases (like here), we do nothing but pass them all as-is 
-- to the User constructor “at once” as a last step.

--   f :: a    -> b    -> c    -> d
-- User :: Text -> Text -> Text -> User

-- x                  :: f     a
-- lookup "first_name" p :: Maybe Text

-- -- y                 :: f     b
-- lookup "last_name" p :: Maybe Text

-- -- z             :: f     c
-- lookup "email" p :: Maybe Text

-- result :: f d
-- result = f <$> x <*> y <*> z
buildUserA :: Profile -> Maybe User
buildUserA p = User
    <$> lookup "first_name" p
    <*> lookup "last_name" p
    <*> lookup "email" p

-- Main> buildUser user
-- Nothing
-- Main> buildUserM user
-- Nothing
-- Main> buildUserA user
-- Nothing
