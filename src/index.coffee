toString = Object.prototype.toString

getProto = (value) ->
  Object.getPrototypeOf Object value

getCtor = (value) -> 
  Object(value).constructor

capitalize = (str) ->
  str[0].toUpperCase() + str.slice 1

types =
  "[object String]": "string"
  "[object Number]": "number"
  "[object Boolean]": "boolean"
  "[object Object]": "object"
  "[object Array]": "array"
  "[object Function]": "function"
  "[object RegExp]": "regexp"
  "[object Date]": "date"
  "[object Arguments]": "arguments"
  "[object Undefined]": "undefined"
  "[object Null]": "null"

wassat = (obj) ->
  types[ toString.call obj ]

wassat.types = Object.create null

Object.keys(types).forEach (key) ->
  type = types[key]
  fnName = "is" + capitalize(type)
  fnName = if fnName is "isRegexp" then "isRegExp" else fnName
  wassat[fnName] = (value) ->
    wassat(value) is type
  wassat.types[type] = true

wassat.isPrimitive = (value) ->
  return Object(value) isnt value

wassat.isNil = (value) ->
  return value is null or value is undefined

wassat.isIt = (Ctor, value) ->
  return Object(value) instanceof Ctor

wassat.isItExactly = (Ctor, value) ->
  return getProto(value) is Ctor::

wassat.isAll = (type, iterable) ->
  (return false unless wassat(item) is type) for item in iterable
  return true

if wassat(exports) is "object"
  module.exports = wassat
else
  global.wassat = wassat
