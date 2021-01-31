{-# LANGUAGE OverloadedStrings #-}

module Quies.Parser where

import Data.Text
import Data.Char (isAlphaNum)
import Data.Void
import Text.Megaparsec
import Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer as L
import Control.Monad.Combinators.Expr

import Quies.AST

type Parser = Parsec Void Text

parse :: Text -> Expr
parse t = 
    case runParser expr "" t of
        Left _ -> undefined
        Right result -> result

expr :: Parser Expr
expr = makeExprParser term optable

optable =
    [
        [ 
            binary "*" (BinOp Mul),
            binary "/" (BinOp Div)
        ],
        [ 
            binary "+" (BinOp Add),
            binary "-" (BinOp Sub)
        ]
    ]

binary :: Text -> (Expr -> Expr -> Expr) -> Operator Parser Expr
binary name f = InfixL  (f <$ symbol name)


sc :: Parser ()
sc = L.space
  space1
  (L.skipLineComment "//")
  (L.skipBlockComment "/*" "*/")

lexeme :: Parser a -> Parser a
lexeme = L.lexeme sc

symbol :: Text -> Parser Text
symbol = L.symbol sc

integer :: Parser Int
integer = lexeme L.decimal

identifier :: Parser Text
identifier = lexeme $ takeWhile1P (Just "alpha num character") isAlphaNum

term = choice 
    [ Constant <$> integer
    , Val <$> identifier
    ]
