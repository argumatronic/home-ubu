-- source https://pbrisbin.com/posts/applicative_functors/

data User = User
    { userFirstName :: Text
    , userLastName  :: Text
    , userEmail     :: Text
    }

type Profile = [(Text, Text)]

    -- Example:
    -- [ ("first_name", "Pat"            )
    -- , ("last_name" , "Brisbin"        )
    -- , ("email"     , "me@pbrisbin.com")
    -- ]

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

-- f :: a    -> b    -> c    -> d
User :: Text -> Text -> Text -> User

-- x                  :: f     a
lookup "first_name" p :: Maybe Text

-- y                 :: f     b
lookup "last_name" p :: Maybe Text

-- z             :: f     c
lookup "email" p :: Maybe Text

-- result :: f d
-- result = f <$> x <*> y <*> z
buildUserA :: Profile -> Maybe User
buildUserA p = User
    <$> lookup "first_name" p
    <*> lookup "last_name" p
    <*> lookup "email" p
