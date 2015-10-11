{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}
module Main
    ( main
    ) where

import Data.Aeson
import GHC.Generics
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

data Cat = 
    Cat { name  :: String
        , breed :: String
        }
    deriving (Show, Generic)

instance ToJSON Cat

type API = "static" :> Raw 
      :<|> "cats" :> Get '[JSON] [Cat]

cats :: [Cat]
cats = [ Cat "Sigge" "Ragdoll", Cat "Frasse" "Maine Coon" ]

api :: Proxy API
api = Proxy

server :: Server API
server =
    serveDirectory "static"
    :<|> return cats

app :: Application
app = serve api server

main :: IO ()
main = run 8081 app
