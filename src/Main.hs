{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Quies.Parser as Quies
import qualified Quies.Codegen as Quies

import qualified Data.Text.IO as T(readFile, putStrLn)

import System.Environment

main :: IO ()
main = do
    args <- getArgs

    case args of
        (file:_) -> do
            code <- T.readFile file
            let ast = Quies.parse code
            T.putStrLn $ Quies.build ast
        _ -> do
            print "Pass the filename with source"