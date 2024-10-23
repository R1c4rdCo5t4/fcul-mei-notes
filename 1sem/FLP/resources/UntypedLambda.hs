{-|
Module      : The untyped lambda-calculus
Description : Terms, substitution, evaluation.

An Haskell adaptation of the code for Types and Programming Languages (TAPL), by
Benjamin Pierce, The MIT Press (2002), except for substitution which is taken
from Hindley, J.R., Seldin, J.P.: Introduction to Combinators and
Lambda-Calculus, Cambridge University Press (1986)

Fundamentals of Programming Languages
MSc on Informatics Engineering
Faculty of Sciences
University of Lisbon
2024/25
-}

module UntypedLambda where

import qualified Data.Set as Set
import Prelude hiding (id, and, fst, snd)

-- Names for variables
type Id = String 

-- 6.

data Term =
    Var Id -- variable
  | Abs Id Term -- lambda abstraction (\x.t)
  | App Term Term -- application (t1 t2)
  deriving (Eq, Show)

-- 7.

true :: Term
true = Abs "a" (Abs "b" (Var "a")) -- λa.λb.a

false :: Term
false = Abs "a" (Abs "b" (Var "b")) -- λa.λb.b

test :: Term
test = Abs "l" (Abs "m" (Abs "n" (App (App (Var "l") (Var "m")) (Var "n")))) -- λl.λm.λn.lmn

and :: Term
and = Abs "a" (Abs "b" (App (App (Var "a") (Var "b")) false)) -- λa.λb.ab false

or :: Term
or = Abs "a" (Abs "b" (App (App (Var "a") true) (Var "b"))) -- λa.λb.a true b

not :: Term
not = Abs "a" (App (App (Var "a") false) true) -- -- λa.a false true

-- 8.

pair, fst, snd :: Term
pair = Abs "f" (Abs "s" (Abs "b" (App (App (Var "b") (Var "f")) (Var "s"))))
fst = Abs "p" (App (Var "p") true)
snd = Abs "p" (App (Var "p") false)


instance Show Term where -- with special support for some constants
  show (Var x) = x
  show (Abs x (Var y)) | x == y = "id"
  show (Abs x (Abs _ (Var y))) | x == y = "true"
  show (Abs _ (Abs x (Var y))) | x == y = "false"
  show (App t1 t2) = "(" ++ show t1 ++ " " ++ show t2 ++ ")"
  show (Abs x t) = "(λ" ++ x ++ "." ++ show t ++ ")"

-- The set of the free variables in a term
freeVars :: Term -> Set.Set Id
freeVars = error "To be defined"

-- A fresh variable name, that is, a variable name that is not present in a set
-- of variables.
newId :: Set.Set Id -> Id
newId vs = head [v | n <- [0..], let v = '_':show n, v `Set.notMember` vs]

-- Substitution as in the books of Curry and Feys and Hindley and Seldin. The
-- first and the last equation for Abs are not in TAPL, for TAPL assumes the
-- variable convention, something Haskell cannot.
subs :: Id -> Term -> Term -> Term
subs x s (Var y)
  | y == x    = s
  | otherwise = Var y
subs x s (Abs y t)
  -- No need to continue in this case
  | x == y = Abs y t
  -- The easy case
  | y /= x && (y `Set.notMember` fvS || x `Set.notMember` fvT) = Abs y (subs x s t)
  -- Rename if danger of variable capture
  | otherwise = Abs z (subs x s (subs y (Var z) t))
  where fvS = freeVars s
        fvT = freeVars t
        z = newId (fvS `Set.union` fvT)
subs x s (App t1 t2) = App (subs x s t1) (subs x s t2)

-- Examples of substitution

-- Hindley and Seldin
t1, t2, t3, t4, t5, t6, t7, t8 :: Term
t1 = subs "x" (Var "w") (Abs "w" (Var "x"))
t2 = subs "x" (App (Var "u") (Var "v")) (Abs "y" (App (Var "x") (Abs "w" (App (Var "v") (App (Var "w") (Var "x"))))))
t3 = subs "x" (Abs "y" (App (Var "v") (Var "y"))) (App (Var "y") (Abs "v" (App (Var "x") (Var "v"))))
t4 = subs "x" (Abs "_0" (App (Var "_1") (Var "_0"))) (App (Var "_0") (Abs "_1" (App (Var "x") (Var "_1"))))
-- TAPL, page 70
t5 = subs "x" (Var "y") (Abs "x" (Var "x"))
t6 = subs "_0" (Var "_1") (Abs "_0" (Var "_0"))
-- Others
t7 = subs "x" (Var "z") (Abs "z" (Var "x"))
t8 = subs "_0" (Var "_1") (Abs "_1" (Var "_0"))
