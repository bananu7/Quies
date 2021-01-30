{-# LANGUAGE OverloadedStrings #-}

module Main where

import Quies.Parser

main :: IO ()
main = do
    let code = "a + b + 4"
    let ast = parse code
    print ast
