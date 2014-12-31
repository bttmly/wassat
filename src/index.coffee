toString = (value) ->
  return Object.prototype.toString.call value

getProto = (value) ->
  return Object.getPrototypeOf Object value

capitalize = (str) ->
  return str[0].toUpperCase() + str.slice 1

typeNames = [ 
  "string"
  "number"
  "boolean"
  "object"
  "array"
  "function"
  "regExp"
  "date"
  "error"
  "arguments"
  "undefined"
  "null"
]

typeMap = typeNames.reduce (map, key) ->
  map["[object #{capitalize(key)}]"] = key
  return map
, Object.create null 

wassat = (value) ->
  return typeMap[toString value] or "object"

wassat.types = Object.create null

Object.keys(typeMap).forEach (key) ->
  type = typeMap[key]
  fnName = "is" + capitalize(type)
  wassat.types[type] = true
  wassat[fnName] = (value) ->
    return wassat(value) is type
  wassat[fnName].maybe = (value) ->
    return wassat.isNil(value) or wassat(value) is type

Object.freeze wassat.types

wassat.isPrimitive = (value) ->
  type = typeof value
  type is "string" or type is "number" or type is "boolean"

wassat.isNil = (value) ->
  return value is null or value is undefined

wassat.isIt = (Ctor, value) ->
  return Object(value) instanceof Ctor

wassat.isItExactly = (Ctor, value) ->
  return getProto(value) is Ctor::

wassat.isAll = (type, iterable) ->
  (return false unless wassat(item) is type) for item in iterable
  return true

module.exports = wassat
