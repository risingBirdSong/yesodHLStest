{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE RecordWildCards #-}

import Import
getStuffR :: Handler Value 
getStuffR = do
    stuff :: [Entity Stuff ] <- runDB $ selectList [] []
    returnJson stuff

data StuffAPIPOST = StuffAPIPOST 
    {
       apiName :: Text 
     , apiCounter :: Int
     , apiToggleBool :: Bool  
    }
     deriving (Show, Eq, Generic)

instance FromJSON StuffAPIPOST
instance ToJSON StuffAPIPOST

postStuffR :: Handler () 
postStuffR = do 
   StuffAPIPOST {..} <- requireCheckJsonBody
   inserted <- runDB $ insert $ Stuff apiName apiCounter apiToggleBool
   pure ()