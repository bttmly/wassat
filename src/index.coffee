toString = Object.prototype.toString

capitalize = ( str ) ->
  str[0].toUpperCase() + str.slice 1

types =
  "[object String]": "string"
  "[object Number]": "number"
  "[object Boolean]": "boolean"
  "[object Object]": "object"
  "[object Array]": "array"
  "[object RegExp]": "regexp"
  "[object Date]": "date"
  "[object Arguments]": "arguments"

wassat = ( obj ) ->
  type = types[ toString.call obj ]

Object.keys( types ).forEach ( key ) ->
  type = types[key]
  fnName = "is" + capitalize( type )
  fnName = if fnName is "isRegexp" then "isRegExp" else fnName
  wassat[fnName] = ( obj ) ->
    wassat( obj ) is type

module.exports = wassat
