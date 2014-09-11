# wassat
_(What's that?)_

### `wassat([Object anything]) -> String`
The main function accepts anything and returns a string. The result is an all-lowercase version of the JavaScript "class" of which the object is an instance. If it's something else (`HTMLElement` for example), it returns `"object"`. Under the hood, `wassat` uses `Object.prototype.toString`.

- `wassat('abc')` -> `'string'`
- `wassat(123)` -> `'number'`
- `wassat(true)` -> `'boolean'`
- `wassat({})` -> `'object'`
- `wassat([])` -> `'array'`
- `wassat(new Date())` -> `'date'`
- `wassat(new RegExp())` -> `'regexp'`
- `wassat((function(){return arguments})())` -> `arguments`
- `wassat(document.querySelector('div'))` -> `object`

There is a corresponding "is" method for each type, as follows:

### wassat.isString([Object anything])
`true` if `wassat(anything) === string`, else `false`

### wassat.isNumber([Object anything])
`true` if `wassat(anything) === number`, else `false`

### wassat.isBoolean([Object anything])
`true` if `wassat(anything) === boolean`, else `false`

### wassat.isArray([Object anything])
`true` if `wassat(anything) === array`, else `false`

### wassat.isObject([Object anything])
`true` if `wassat(anything) === object`, else `false`

### wassat.isDate([Object anything])
`true` if `wassat(anything) === date`, else `false`

### wassat.isRegExp([Object anything])
`true` if `wassat(anything) === regexp`, else `false`

### wassat.isArguments([Object anything])
`true` if `wassat(anything) === arguments`, else `false`
