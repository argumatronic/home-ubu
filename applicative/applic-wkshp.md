# Applicative workshop

-- you're gonna need to start a new project that just has all the sample files in there you want them to be able to run, and also one for the optparse project
-- sample code:
-- AccValidation something
-- do vs ApplicativeDo
-- 
-- optparse example
-- optparse example with flag

## fmap

## Monad

## partial application    
- see here: https://www.schoolofhaskell.com/school/advanced-haskell/functors-applicative-functors-and-monads#partial-application 
- but use example from whatever code you've been working on

## Applicative  

- the two functions must be independent, not relying on each other for outcome  
- if you are gonna use the palindrome thing, then you'll need two parameters, not just one input string  
- oh maybe do an anagram checker?

## Applicatives vs Monads

### Context 

Here's what this means. In the monadic chain

return 42            >>= (\x ->
if x == 1
   then
        return (x+1) 
   else 
        return (x-1) >>= (\y -> 
        return (1/y)     ))
the if chooses what computation to construct.

In case of Applicative, in

pure (1/) <*> ( pure (+(-1)) <*> pure 1 )
all the functions work "inside" computations, there's no chance to break up a chain. Each function just transforms a value it's fed. The "shape" of the computation structure is entirely "on the outside" from the functions' point of view.  

### Applicatives are closed under composition

 If we compare the types

(<*>) :: Applicative a => a (s -> t) -> a s -> a t
(>>=) :: Monad m =>       m s -> (s -> m t) -> m t
we get a clue to what separates the two concepts. That (s -> m t) in the type of (>>=) shows that a value in s can determine the behaviour of a computation in m t. Monads allow interference between the value and computation layers. The (<*>) operator allows no such interference: the function and argument computations don't depend on values. This really bites. Compare

miffy :: Monad m => m Bool -> m x -> m x -> m x
miffy mb mt mf = do
  b <- mb
  if b then mt else mf
which uses the result of some effect to decide between two computations (e.g. launching missiles and signing an armistice), whereas

iffy :: Applicative a => a Bool -> a x -> a x -> a x
iffy ab at af = pure cond <*> ab <*> at <*> af where
  cond b t f = if b then t else f
which uses the value of ab to choose between the values of two computations at and af, having carried out both, perhaps to tragic effect.

The monadic version relies essentially on the extra power of (>>=) to choose a computation from a value, and that can be important. However, supporting that power makes monads hard to compose. If we try to build ‘double-bind’

(>>>>==) :: (Monad m, Monad n) => m (n s) -> (s -> m (n t)) -> m (n t)
mns >>>>== f = mns >>-{-m-} \ ns -> let nmnt = ns >>= (return . f) in ???
we get this far, but now our layers are all jumbled up. We have an n (m (n t)), so we need to get rid of the outer n. As Alexandre C says, we can do that if we have a suitable

swap :: n (m t) -> m (n t)
to permute the n inwards and join it to the other n.

### AccValidation

My favorite example is the "purely applicative Either". We'll start by analyzing the base Monad instance for Either

instance Monad (Either e) where
  return = Right
  Left e  >>= _ = Left e
  Right a >>= f = f a
This instance embeds a very natural short-circuiting notion: we proceed from left to right and once a single computation "fails" into the Left then all the rest do as well. There's also the natural Applicative instance that any Monad has

instance Applicative (Either e) where
  pure  = return
  (<*>) = ap
where ap is nothing more than left-to-right sequencing before a return:

ap :: Monad m => m (a -> b) -> m a -> m b
ap mf ma = do 
  f <- mf
  a <- ma
  return (f a)
Now the trouble with this Either instance comes to light when you'd like to collect error messages which occur anywhere in a computation and somehow produce a summary of errors. This flies in the face of short-circuiting. It also flies in the face of the type of (>>=)

(>>=) :: m a -> (a -> m b) -> m b
If we think of m a as "the past" and m b as "the future" then (>>=) produces the future from the past so long as it can run the "stepper" (a -> m b). This "stepper" demands that the value of a really exists in the future... and this is impossible for Either. Therefore (>>=) demands short-circuiting.

So instead we'll implement an Applicative instance which cannot have a corresponding Monad.

instance Monoid e => Applicative (Either e) where
  pure = Right
Now the implementation of (<*>) is the special part worth considering carefully. It performs some amount of "short-circuiting" in its first 3 cases, but does something interesting in the fourth.

  Right f <*> Right a = Right (f a)     -- neutral
  Left  e <*> Right _ = Left e          -- short-circuit
  Right _ <*> Left  e = Left e          -- short-circuit
  Left e1 <*> Left e2 = Left (e1 <> e2) -- combine!
Notice again that if we think of the left argument as "the past" and the right argument as "the future" then (<*>) is special compared to (>>=) as it's allowed to "open up" the future and the past in parallel instead of necessarily needing results from "the past" in order to compute "the future".

This means, directly, that we can use our purely Applicative Either to collect errors, ignoring Rights if any Lefts exist in the chain

> Right (+1) <*> Left [1] <*> Left [2]
> Left [1,2]
So let's flip this intuition on its head. What can we not do with a purely applicative Either? Well, since its operation depends upon examining the future prior to running the past, we must be able to determine the structure of the future without depending upon values in the past. In other words, we cannot write

ifA :: Applicative f => f Bool -> f a -> f a -> f a
which satisfies the following equations

ifA (pure True)  t e == t
ifA (pure False) t e == e
while we can write ifM

ifM :: Monad m => m Bool -> m a -> m a -> m a
ifM mbool th el = do
  bool <- mbool
  if bool then th else el
such that

ifM (return True)  t e == t
ifM (return False) t e == e
This impossibility arises because ifA embodies exactly the idea of the result computation depending upon the values embedded in the argument computations.


### ApplicativeDo vs Monadic


## Examples of monadic code and applicative code  
- Validation  
  - gonna need good examples 
  - it appears you can show how a diff in applicative and monadic uses of it
<!--   - https://hackage.haskell.org/package/validation
 -->

## Parsing

## Monadic parsing  
- trifecta or attoparsec?

## Alternative

## Applicative parsing  
- usually context free due to the independent outcomes quality
- can also be used to parse context-sensitive grammars tho!  
- do not address this - reference to Yorgey's post about it

## Examples of monadic and applicative parsing  
- context free and context sensitive

## optparse-applicative  
- what it is, general outline  
- a brief example  

## Project