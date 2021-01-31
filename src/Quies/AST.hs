module Quies.AST where

import Data.Text

data Expr = Add Expr Expr | Val Text | Constant Int deriving Show
