# Applicative workshop

## fmap

## Monad

## partial application    
- see here: https://www.schoolofhaskell.com/school/advanced-haskell/functors-applicative-functors-and-monads#partial-application 
- but use example from whatever code you've been working on

## Applicative  

- less powerful than Monad  
- the two functions must be independent, not relying on each other for outcome  
- if you are gonna use the palindrome thing, then you'll need two parameters, not just one input string  
- oh maybe do an anagram checker?

## Applicatives vs Monads  
- context  
- composability (applicatives compose; monads need transformers)  

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