{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE TypeOperators     #-}
module Main
    ( main
    ) where

import Google.DataTable
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

type API = "slice-data" :> Get '[JSON] DataTable :<|> Raw

sliceData :: DataTable
sliceData = 
    DataTable { cols = [ Column { id_ = Nothing
                                , label = Just "Topping"
                                , type_ = StringT }
                       , Column { id_ = Nothing
                                , label = Just "Slices"
                                , type_ = NumberT }
                       ]
              , rows = [ Row { c = [ Cell { v = Just (String "Mushrooms")
                                          , f = Nothing }
                                   , Cell { v = Just (Integral 3)
                                          , f = Nothing }
                                   ] }
                       , Row { c = [ Cell { v = Just (String "Onions")
                                          , f = Nothing }
                                   , Cell { v = Just (Integral 1)
                                          , f = Nothing }
                                   ] }
                       , Row { c = [ Cell { v = Just (String "Olives")
                                          , f = Nothing }
                                   , Cell { v = Just (Integral 1)
                                          , f = Nothing }
                                   ] }
                       , Row { c = [ Cell { v = Just (String "Zucchini")
                                          , f = Nothing }
                                   , Cell { v = Just (Integral 1)
                                          , f = Nothing }
                                   ] }
                       , Row { c = [ Cell { v = Just (String "Pepperoni")
                                          , f = Nothing }
                                   , Cell { v = Just (Integral 2)
                                          , f = Nothing }
                                   ] }
                       ]
              }

api :: Proxy API
api = Proxy

server :: Server API
server = return sliceData
    :<|> serveDirectory "static"

app :: Application
app = serve api server

main :: IO ()
main = run 8081 app
