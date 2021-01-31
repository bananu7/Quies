module Quies.AST where

import Data.Text

data Op =
      Add
    | Sub
    | Mul
    | Div
    deriving (Show, Eq)

data Expr =
      BinOp Op Expr Expr
    | Val Text
    | Constant Int
    deriving Show
