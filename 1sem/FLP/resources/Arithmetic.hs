{-|
Module      : Arithmetic Expressions
Description : Expressions, types, and operations on these, including evaluation and typing

An Haskell adaptation of the code for Types and Programming Languages (TAPL), by
Benjamin Pierce, 2002, The MIT Press.

Fundamentals of Programming Languages
MSc on Informatics Engineering
Faculty of Sciences
University of Lisbon
2024/2025
-}

module Arithmetic where

import qualified Data.Set as Set

-- |Terms
data Term =
-- Figure 3.1, page 34
    TTrue
  | FFalse
  | If Term Term Term
-- Figure 3.2, page 41
  | TZero
  | TSucc Term
  | TPred Term
  | TIsZero Term
-- TODO
  deriving
    (Show, Eq, Ord) -- So that terms may go into Sets

-- Some terms
s, t :: Term
s = If TTrue FFalse FFalse
t = If s TTrue TTrue

-- |The set of constants appearing in a term, Definition 3.3.1, page 29
consts :: Term -> Set.Set Term
consts TTrue = Set.singleton TTrue
consts FFalse = Set.singleton FFalse
consts (If t1 t2 t3) = consts t1 `Set.union` consts t2 `Set.union` consts t3

-- TODO: add arithmetic

-- Exercise: size, Definition 3.3.2, page 29
size :: Term -> Int
size TTrue = 1
size FFalse = 1
size TZero = 1
size (TSucc t) = size t + 1
size (TPred t) = size t + 1
size (TIsZero t) = size t + 1
size (If t1 t2 t3) = 1 + size t1 + size t2 + size t3

-- Exercise: depth, Definition 3.3.2, page 29
depth :: Term -> Int
depth TTrue = 1
depth FFalse = 1
depth TZero = 1
depth (TSucc t) = depth t + 1
depth (TPred t) = depth t + 1
depth (TIsZero t) = depth t + 1
depth (If t1 t2 t3) = 1 + max (depth t1) (max (depth t2) (depth t3))

-- Exercise: width, see exercises-1-arithmetic.pdf
width :: Term -> Int
width TTrue = 1
width FFalse = 1
width TZero = 1
width (TSucc t) = width t
width (TPred t) = width t
width (TIsZero t) = width t
width (If t1 t2 t3) = width t1 + width t2 + width t3

-- Evaluation

-- |Single-step evaluator
eval1 :: Term -> Term
-- Figure 3.1, page 34
eval1 (If TTrue t2 _) = t2 -- E-IfTrue
eval1 (If FFalse _ t3) = t3 -- E-IfFalse
eval1 (If t1 t2 t3) = If (eval1 t1) t2 t3 -- E-If
-- Figure 3.2, page 41
eval1 (TSucc t) = TSucc (eval1 t) -- E-Succ
eval1 (TPred TZero) = TZero -- E-PredZero
eval1 (TPred (TSucc nv)) = nv -- E-PredSucc
eval1 (TPred t) = TPred (eval1 t) -- E-Pred
eval1 (TIsZero TZero) = TTrue -- E-IsZeroZero
eval1 (TIsZero (TSucc _)) = FFalse -- E-IsZeroSucc
eval1 (TIsZero t) = TIsZero (eval1 t) -- E-IsZero
eval1 t = t -- No rule applies

-- Function eval that finds the normal form of a given expression (use eval1)

-- helper function to check if a term is a numeric value
isNat :: Term -> Bool
isNat TZero = True
isNat (TSucc t) = isNat t  -- recursively check successors of 0
isNat _ = False  -- is not a natural number

-- helper function to check if a term is a value
isValue :: Term -> Bool
isValue TTrue = True
isValue FFalse = True
isValue t = isNat t  -- numeric values are considered values
-- isValue _ = False  -- other terms are not values

eval :: Term -> Term
eval t = 
  let t' = eval1 t
  in if t == t'  -- normal form
    then if isValue t then t else error "Resulting normal form is not a value"
    else eval t'  -- recursively evaluate

-- bigstep function
bigstep :: Term -> Term
bigstep TZero = TZero
bigstep (TSucc t) = TSucc (bigstep t)
bigstep (TPred TZero) = TZero
bigstep (TPred (TSucc t)) | isNat (bigstep t) = bigstep t
bigstep (TIsZero TZero) = TTrue
bigstep (TIsZero (TSucc t)) | isNat (bigstep t) = FFalse
bigstep t = t -- already in normal form

-- typeof function
data Type = TBool | TNat deriving (Show, Eq, Ord)

typeof :: Term -> Type
typeof TTrue = TBool -- T-True
typeof FFalse = TBool -- T-False
typeof (If t1 t2 t3) = -- T-If
  if typeof t1 == TBool && typeof t2 == typeof t3
    then typeof t2
    else error "Type error in If"
typeof TZero = TNat -- T-Zero
typeof (TSucc t) = -- T-Succ
  if typeof t == TNat
    then TNat
    else error "Type error in Succ"
typeof (TPred t) = -- T-Pred
  if typeof t == TNat
    then TNat
    else error "Type error in Pred"
typeof (TIsZero t) = -- T-IsZero
  if typeof t == TNat
    then TBool
    else error "Type error in IsZero"