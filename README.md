# wassat [![Build Status](https://travis-ci.org/nickb1080/wassat.svg)](https://travis-ci.org/nickb1080/wassat) [![codecov.io](https://codecov.io/github/nickb1080/wassat/coverage.svg?branch=master)](https://codecov.io/github/nickb1080/wassat?branch=master)
_(What's that?)_

## Installation and Usage

`npm install wassat`

`var wassat = require('wassat');`

## API

#### `wassat(Object anything) -> String`
The main function accepts anything and returns a string. The result is an all-lowercase version of the basic JavaScript "class" of which the object is an instance. If it's an instance of something else (`HTMLElement` for example, or perhaps the `Math` object), it returns `"object"`. Under the hood, `wassat` uses `Object.prototype.toString`. For `null` and `undefined`, `wassat()` uses strict equality.

- `wassat('abc')` -> `'string'`
- `wassat(123)` -> `'number'`
- `wassat(NaN)` -> `'number'`
- `wassat(true)` -> `'boolean'`
- `wassat({})` -> `'object'`
- `wassat([])` -> `'array'`
- `wassat(function(){})` -> `'function'`
- `wassat(new Date())` -> `'date'`
- `wassat(new RegExp())` -> `'regexp'`
- `wassat(new Error())` -> `'error'`
- `wassat((function(){return arguments})())` -> `'arguments'`
- `wassat(document.querySelector('div'))` -> `'object'`
- `wassat(null)` -> `'null'`
- `wassat(undefined)` -> `'undefined'`

### `.is` methods

There is a corresponding "is" method for each type, as follows:

#### `wassat.isString([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'string'`, else `false`

#### `wassat.isNumber([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'number'`, else `false`

_Note: Returns `true` for `NaN`_

#### `wassat.isBoolean(Object anything) -> Boolean`
`true` if `wassat(anything) === 'boolean'`, else `false`

#### `wassat.isArray(Object anything) -> Boolean`
`true` if `wassat(anything) === 'array'`, else `false`

#### `wassat.isObject(Object anything) -> Boolean`
`true` if `wassat(anything) === 'object'`, else `false`

#### `wassat.isFunction(Object anything) -> Boolean`
`true` if `wassat(anything) === 'function'`, else `false`

#### `wassat.isDate(Object anything) -> Boolean`
`true` if `wassat(anything) === 'date'`, else `false`

#### `wassat.isRegExp(Object anything) -> Boolean`
`true` if `wassat(anything) === 'regexp'`, else `false`

#### `wassat.isError(Object anything) -> Boolean`
`true` if `wassat(anything) === 'error'`, else `false`

#### `wassat.isArguments(Object anything) -> Boolean`
`true` if `wassat(anything) === 'arguments'`, else `false`

#### `wassat.isNull(Object anything) -> Boolean`
`true` if `wassat(anything) === 'null'`, else `false`

#### `wassat.isUndefined(Object anything) -> Boolean`
`true` if `wassat(anything) === 'undefined'`, else `false`

### Other Methods

#### `wassat.isNil(Object anything) -> Boolean`
`true` if `wassat(anything) === 'null'` **or** `wassat(anything) === 'undefined'`

#### `wassat.isPrimitive(Object anything) -> Boolean`
`true` if `anything` is of a primitive type (string, number, boolean). Primitive types can't hold properties. Not yet tested with ES6 Symbols. 

#### `wassat.isIt(Function ctor, Object anything) -> Boolean`
Uses `instanceof` to check if `ctor`'s prototype is in `anything`'s prototype chain. Performs a little check for primitives so it can handle those too (since `"abc" instanceof String` is `false`). 

#### `wassat.isItExactly(Function ctor, Object anything) -> Boolean`
Compares the prototype of `anything` (via `Object.getPrototypeOf`) to the value of `ctor.prototype` to see if `ctor` is the constructor function of `anything`. Performs a little check for primitives so it can handle those too (since `Object.getPrototypeOf("abc")` throws).

#### `wassat.isAll(String type, Array iterable) -> Boolean`
For each `item` in `iterable`, returns false if `wassat(item)` isn't `type`. Else `true`.
