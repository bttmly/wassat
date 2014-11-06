toString = Object.prototype.toString
getProto = Object.getPrototypeOf

capitalize = ( str ) ->
  str[0].toUpperCase() + str.slice 1

isPrimitive = ( obj ) ->
  if primitives[wassat obj] then true else false

primitives =
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

wassat = ( obj ) ->
  return "null" if obj is null
  types[ toString.call obj ]

Object.keys( types ).forEach ( key ) ->
  type = types[key]
  fnName = "is" + capitalize( type )
  fnName = if fnName is "isRegexp" then "isRegExp" else fnName
  wassat[fnName] = ( obj ) ->
    wassat( obj ) is type

wassat.isNull = ( obj ) ->
  wassat( obj ) is "null"

wassat.isNil = ( obj ) ->
  result = wassat obj
  result is "null" or result is "undefined"

wassat.isIt = ( Ctor, obj ) ->
  type = wassat obj
  if isPrimitive obj
    return Ctor is primitives[type]
  obj instanceof Ctor

wassat.isItExactly = ( Ctor, obj ) ->
  type = wassat obj
  if isPrimitive obj
    return Ctor is primitives[type]
  getProto( obj ) is Ctor::

wassat.isAll = ( type, iterable ) ->
  ( return false if wassat( item ) isnt type ) for item in iterable
  true

if wassat( exports ) is "object"
  module.exports = wassat
else
  global.wassat = wassat
