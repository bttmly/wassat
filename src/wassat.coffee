toString = Object.prototype.toString
getProto = Object.getPrototypeOf

capitalize = ( str ) ->
  str[0].toUpperCase() + str.slice 1

primitiveConstructors =
  "string": String
  "number": Number
  "boolean": Boolean

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
  "null": "null"

wassat = ( obj ) ->
  return "null" if obj is null
  types[ toString.call obj ]

Object.keys( types ).forEach ( key ) ->
  type = types[key]
  fnName = "is" + capitalize( type )
  fnName = if fnName is "isRegexp" then "isRegExp" else fnName
  wassat[fnName] = ( obj ) ->
    wassat( obj ) is type

wassat.isNil = ( obj ) ->
  result = wassat obj
  result is "null" or result is "undefined"

wassat.isIt = ( obj, Ctor ) ->
  result = wassat obj
  if result is "string" or result is "number" or result is "boolean"
    return Ctor is primitiveConstructors[result]
  obj instanceof Ctor

wassat.isItExactly = ( obj, Ctor ) ->
  result = wassat obj
  if result is "string" or result is "number" or result is "boolean"
    return Ctor is primitiveConstructors[result]
  getProto( obj ) is Ctor::

if typeof exports is "object"
  module.exports = wassat
else
  @wassat = wassat
