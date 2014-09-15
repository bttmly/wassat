toString = Object.prototype.toString

capitalize = ( str ) ->
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
  "null": "null"
  "undefined": "undefined"

wassat = ( obj ) ->
  return "undefined" if obj is undefined
  return "null" if obj is null
  types[ toString.call obj ]

Object.keys( types ).forEach ( key ) ->
  type = types[key]
  fnName = "is" + capitalize( type )
  fnName = if fnName is "isRegexp" then "isRegExp" else fnName
  wassat[fnName] = ( obj ) ->
    wassat( obj ) is type

wassat.isNothing = ( obj ) ->
  result = wassat obj
  result is "null" or result is "undefined"

module.exports = wassat
