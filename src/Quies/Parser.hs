{-# LANGUAGE OverloadedStrings #-}

module Quies.Parser where

import Data.Text
import Data.Char (isAlphaNum)
import Data.Void
import Text.Megaparsec
import Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer as L
import Control.Monad.Combinators.Expr

type Parser = Parsec Void Text

data Expr = Add Expr Expr | Val Text | Constant Int deriving Show

parse :: Text -> Expr
parse t = 
    case runParser expr "" t of
        Left _ -> undefined
        Right result -> result

expr :: Parser Expr
expr = makeExprParser term optable

binary :: Text -> (Expr -> Expr -> Expr) -> Operator Parser Expr
binary name f = InfixL  (f <$ symbol name)
optable = [[ binary "+" Add ]]

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
