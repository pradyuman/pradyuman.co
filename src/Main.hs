{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid (mappend)
import Hakyll

main :: IO ()
main = hakyll $ do

  match "images/*" $ do
    route idRoute
    compile copyFileCompiler


  match "css/*" $ do
      route   idRoute
      compile compressCssCompiler

  match "templates/*" $ compile templateBodyCompiler

  match "index.html" $ do
    route idRoute
    let homeContext = constField "title" "Home" `mappend` defaultContext
    compile $ getResourceBody
      >>= loadAndApplyTemplate "templates/default.html" homeContext
      >>= relativizeUrls
