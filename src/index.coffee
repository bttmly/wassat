toString = (value) ->
  Object.prototype.toString.call value

getProto = (value) ->
  Object.getPrototypeOf Object value

getCtor = (value) -> 
  Object(value).constructor

capitalize = (str) ->
  str[0].toUpperCase() + str.slice 1

typeNames = [ "string"
  "number"
  "boolean"
  "object"
  "array"
  "function"
  "regExp"
  "date"
  "arguments"
  "undefined"
  "null"
]

typeMap = typeNames.reduce (map, key) ->
  map["[object #{capitalize(key)}]"] = key
  map
, Object.create null 

wassat = (value) ->
  typeMap[toString value] or "object"

wassat.types = Object.create null

Object.keys(typeMap).forEach (key) ->
  type = typeMap[key]
  fnName = "is" + capitalize(type)
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

module.exports = wassat
