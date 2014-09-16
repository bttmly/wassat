# wassat [![Build Status](https://travis-ci.org/nickb1080/wassat.svg)](https://travis-ci.org/nickb1080/wassat)
_(What's that?)_

#### `wassat([Object anything]) -> String`
The main function accepts anything and returns a string. The result is an all-lowercase version of the basic JavaScript "class" of which the object is an instance. If it's an instance of something else (`HTMLElement` for example), it returns `"object"`. Under the hood, `wassat` uses `Object.prototype.toString`. For `null` and `undefined`, `wassat()` uses strict equality.

- `wassat('abc')` -> `'string'`
- `wassat(123)` -> `'number'`
- `wassat(true)` -> `'boolean'`
- `wassat({})` -> `'object'`
- `wassat([])` -> `'array'`
- `wassat(function(){})` -> `'function'`
- `wassat(new Date())` -> `'date'`
- `wassat(new RegExp())` -> `'regexp'`
- `wassat((function(){return arguments})())` -> `'arguments'`
- `wassat(document.querySelector('div'))` -> `'object'`
- `wassat(null)` -> `'null'`
- `wassat(undefined)` -> `'undefined'`

There is a corresponding "is" method for each type, as follows:

#### `wassat.isString([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'string'`, else `false`

#### `wassat.isNumber([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'number'`, else `false`

#### `wassat.isBoolean([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'boolean'`, else `false`

#### `wassat.isArray([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'array'`, else `false`

#### `wassat.isObject([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'object'`, else `false`

#### `wassat.isFunction([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'function'`, else `false`

#### `wassat.isDate([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'date'`, else `false`

#### `wassat.isRegExp([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'regexp'`, else `false`

#### `wassat.isArguments([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'arguments'`, else `false`

#### `wassat.isNull([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'undefined'`, else `false`

#### `wassat.isUndefined([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'null'`, else `false`

There is one further method for checking if an object is `null` **or** `undefined`:

#### `wassat.isNothing([Object anything]) -> Boolean`
`true` if `wassat(anything) === 'null'` **or** `wassat(anything) === 'undefined'` else `false`
