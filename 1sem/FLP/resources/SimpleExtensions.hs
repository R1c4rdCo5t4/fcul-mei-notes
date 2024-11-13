module Main where

import qualified Data.Set as Set
import Prelude hiding (id, and, fst, snd)

-- Names for variables
type Id = String 

data Term =
    Var Id
  | Abs Id Term
  | App Term Term
  | Let Id Term Term -- for let bindings
  | Rec (Map.Map Id Term) -- for record terms
  | RecProj Term Id -- for record projection
  | Fix Term -- fix combinator

instance Show Term where -- with special support for some constants
  show (Var x) = x
  show (Abs x (Var y)) | x == y = "id"
  show (Abs x (Abs _ (Var y))) | x == y = "true"
  show (Abs _ (Abs x (Var y))) | x == y = "false"
  show (App t1 t2) = "(" ++ show t1 ++ " " ++ show t2 ++ ")"
  show (Abs x t) = "(\\" ++ x ++ "." ++ show t ++ ")"

instance Eq Term where
    (Var x) == (Var y) = x == y
    (Abs x t1) == (Abs y t2) = x == y && t1 == t2
    (App t1 t2) == (App u1 u2) = t1 == u1 && t2 == u2
    _ == _ = False


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
-- let bindings
subs x s (Let y t1 t2)
  | x == y = Let y (subs x s t1) t2  -- No substitution in t2 if bound variable matches x
  | otherwise = Let y (subs x s t1) (subs x s t2)
-- records
subs x s (Rec m) = Rec $ Map.map (subs x s) m -- Rec
subs x s (RecProj t field) = RecProj (subs x s t) field -- RecProj

-- determines the set of the free variables in a term
freeVars :: Term -> Set.Set Id
freeVars (Var x) = Set.singleton x
freeVars (Abs x t) = Set.delete x (freeVars t)
freeVars (App t1 t2) = Set.union (freeVars t1) (freeVars t2)

-- determines if a term is a value
isValue :: Term -> Bool
isValue (Abs _ _) = True
isValue _ = False

-- one step evalutation
eval1 :: Term -> Term
-- ruduce applications of an abstraction
eval1 (App (Abs x t12) t2) = subs x t2 t12 -- E-AppAbs
-- reduce applications
eval1 (App t1 t2)
    | t1' /= t1 = App t1' t2 -- E-App1
    | t2' /= t2 = App t1 t2' -- E-App2
    | otherwise = App t1 t2 -- no reduction possible
  where
    t1' = eval1 t1
    t2' = eval1 t2
-- reduce inside an abstraction
eval1 (Abs x t1)
    | t1' /= t1  = Abs x t1' -- E-Abs
    | otherwise  = Abs x t1 -- no reduction possible
  where
    t1' = eval1 t1
-- reduce inside let binding
eval1 (Let x t1 t2)
  | isValue t1 = subs x t1 t2 -- E-LetV
  | otherwise = Let x (eval1 t1) t2 -- E-Let
-- reduce records
eval1 (Rec m) = Rec $ fmap eval1 m -- E-Rec
eval1 (RecProj (Rec m) field) = maybe (RecProj (Rec m) field) id (Map.lookup field m) -- E-RecProj
-- fix combinator
eval1 (Fix t) = App t (Fix t) -- apply the term to itself to evaluate fix
-- variables dont reduce
eval1 t = t

-- multi step evaluation until no further reduction possible
eval :: Term -> Term
eval t =
    let t' = eval1 t
    in if t == t' then t else eval t'

-- term definitions
id = Abs "x" (Var "x") -- λx.x
tru = Abs "a" (Abs "b" (Var "a")) -- λa.λb.a
fls = Abs "a" (Abs "b" (Var "b")) -- λa.λb.b
test = Abs "l" (Abs "m" (Abs "n" (App (App (Var "l") (Var "m")) (Var "n")))) -- λl.λm.λn.lmn
and = Abs "a" (Abs "b" (App (App (Var "a") (Var "b")) fls)) -- λa.λb.ab false
or = Abs "a" (Abs "b" (App (App (Var "a") tru) (Var "b"))) -- λa.λb.a true b
not = Abs "a" (App (App (Var "a") fls) tru) -- -- λa.a false true
pair = Abs "a" (Abs "b" (Abs "f" (App (App (Var "f") (Var "a")) (Var "b")))) -- λa.λb.λf. f a b
fst = Abs "p" (App (Var "p") tru) -- λp. p true
snd = Abs "p" (App (Var "p") fls) -- λp. p false
c0 = Abs "f" (Abs "x" (Var "x")) -- λf.λx.x
c1 = Abs "f" (Abs "x" (App (Var "f") (Var "x"))) -- λf.λx.f x
c2 = Abs "f" (Abs "x" (App (Var "f") (App (Var "f") (Var "x")))) -- λf.λx.f (f x)
c3 = Abs "f" (Abs "x" (App (Var "f") (App (Var "f") (App (Var "f") (Var "x"))))) -- λf.λx.f (f (f x))
suc = Abs "n" (Abs "f" (Abs "x" (App (Var "f") (App (App (Var "n") (Var "f")) (Var "x"))))) -- λn.λf.λx.f (n f x)
plus = Abs "m" (Abs "n" (Abs "f" (Abs "x" (App (App (Var "m") (Var "f")) (App (App (Var "n") (Var "f")) (Var "x")))))) -- λm.λn.λf.λx. m f (n f x)
times = Abs "m" (Abs "n" (Abs "f" (App (Var "m") (App (Var "n") (Var "f"))))) -- λm.λn.λf. m (n f)
power = Abs "m" (Abs "n" (App (Var "n") (Var "m"))) -- λm.λn. n m

-- expressions to evaluate
expr1 = App id (App id (Abs "z" (App id (Var "z")))) -- id (id (λz.id z))
expr2 = App (App (App test tru) v) w -- test tru v w
expr3 = App (App and tru) tru -- and true true
expr4 = App (App and tru) fls -- and true false
expr5 = App fst (App (App pair v) w) -- fst (pair v w)

main :: IO ()
main = do
    print $ eval expr1   -- Should reduce to λz.z
    print $ eval expr2   -- Should reduce to v
    print $ eval expr3   -- Should reduce to true
    print $ eval expr4   -- Should reduce to false
    print $ eval expr5   -- Should reduce to v
