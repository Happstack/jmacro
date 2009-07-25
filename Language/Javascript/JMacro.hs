-----------------------------------------------------------------------------
{- |
Module      :  Language.Javascript.JMacro
Copyright   :  (c) Gershom Bazerman, 2009
License     :  BSD 3 Clause
Maintainer  :  gershomb@gmail.com
Stability   :  experimental

Simple DSL for lightweight (untyped) programmatic generation of Javascript.

usage:

> renderJs [$jmacro|fun id x -> x|]

The above produces the id function at the top level.

> renderJs [$jmacro|var id = \x -> x|]

So does the above here. However, as id is brought into scope by the keyword var, you do not get a variable named id in the generated javascript, but a variable with an arbitrary unique identifier.

> renderJs [$jmacro|var !id = \x -> x|]

The above, by using the bang special form in a var declaration, produces a variable that really is named id.

> renderJs [$jmacro|function id(x) {return x;}|]

The above is also id.

> renderJs [$jmacro|function !id(x) {return x;}|]

As is the above (with the correct name).

> renderJs [$jmacro|fun id x {return x;}|]

As is the above.

> renderJs [$jmacroE|foo(x,y)|]

The above is an expression representing the application of foo to x and y.

> renderJs [$jmacroE|foo x y|]]

As is the above.

> renderJs [$jmacroE|foo (x,y)|]]

While the above is an error. (i.e. standard javascript function application cannot seperate the leading parenthesis of the argument from

> \x -> [$jmacroE|foo `(x)`|]]

The above is a haskell expression that provides a function that takes an x, and yields an expression representing the application of foo to the value of x as transformed to a Javascript expression.

> [$jmacroE|\x ->`(foo x)`|]]

Meanwhile, the above lambda is in Javascript, and brings the variable into scope both in javascript and in the enclosed antiquotes. The expression is a Javascript function that takes an x, and yields an expression produced by the application of the Haskell function foo as applied to the identifier x (which is of type JExpr -- i.e. a Javascript expression).

Additional datatypes can be marshalled to Javascript by proper instance declarations for the ToJExpr class.

An experimental typechecker is available in the Typed module.

-}
-----------------------------------------------------------------------------

module Language.Javascript.JMacro (
  module Language.Javascript.JMacro.Base,
  module Language.Javascript.JMacro.QQ
 ) where

import Prelude hiding (tail, init, head, last, minimum, maximum, foldr1, foldl1, (!!), read)

import Language.Javascript.JMacro.Base hiding (expr2stat)
import Language.Javascript.JMacro.QQ
