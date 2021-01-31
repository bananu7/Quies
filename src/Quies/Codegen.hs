{-# LANGUAGE OverloadedStrings #-}

module Quies.Codegen where

import Data.Text
import Data.Text.Lazy (toStrict)

-- basic block
import qualified LLVM.IRBuilder as LLVM
import qualified LLVM.IRBuilder.Monad as LLVM
import qualified LLVM.AST.Operand as LLVM
import qualified LLVM.AST.Global as LLVM(BasicBlock)

import qualified LLVM.AST.Type as LLVM(i32, i64)

-- module
import qualified LLVM.AST as LLVM (Module(..))
import qualified LLVM.IRBuilder.Module as LLVM

-- LLVM IR pretty-print
import LLVM.Pretty (ppllvm)

import Quies.AST

codegen :: LLVM.MonadIRBuilder m => Expr -> m LLVM.Operand
codegen (BinOp op lhs rhs) = do
    lhs' <- codegen lhs
    rhs' <- codegen rhs

    case op of
        Add -> LLVM.add lhs' rhs'
        Sub -> LLVM.sub lhs' rhs'
        Mul -> LLVM.mul lhs' rhs'
        Div -> LLVM.sdiv lhs' rhs'


codegen (Val name) = error "not implemented yet"
codegen (Constant num) = return . LLVM.int64 . fromIntegral $ num

--  runIRBuilder :: IRBuilderState -> IRBuilder a -> (a, [BasicBlock])

--build :: Expr -> (LLVM.Operand, [LLVM.BasicBlock])
--build e = LLVM.runIRBuilder LLVM.emptyIRBuilder (codegen e)

-- for actual asm
build :: Expr -> Text
build = toStrict . ppllvm . buildMyModule


buildMyModule :: Expr -> LLVM.Module
buildMyModule e = LLVM.buildModule "myModule" $ do
    buildFunction e
    bf

bf :: LLVM.ModuleBuilder LLVM.Operand
bf = do 
    LLVM.function "add" [(LLVM.i32, "a"), (LLVM.i32, "b")] LLVM.i32 $ \[a, b] -> do
        entry <- LLVM.block `LLVM.named` "entry"; do
            c <- LLVM.add a b
            LLVM.ret c


buildFunction :: Expr -> LLVM.ModuleBuilder LLVM.Operand
buildFunction e =
    LLVM.function "overmain" [] LLVM.i64 $ \_params -> do
        entry <- LLVM.block `LLVM.named` "entry"; do
            result <- codegen e
            LLVM.ret result

