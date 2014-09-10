wassat = require "../"
require( "chai" ).should()

things =
  str : "abc"
  num : 123
  bool : false
  obj : key: "value"
  arr : ["a", 1]
  date : new Date()
  regexp : new RegExp()
  args : do ->
    arguments

runMainFnTest = ( prop, value ) ->

  wassat( things[prop] ).should.equal value

  Object.keys( things ).forEach ( key ) ->
    if key isnt prop
      wassat( things[key] ).should.not.equal value

runIsTest = ( prop, method ) ->

  wassat[method]( things[prop] ).should.equal true

  Object.keys( things ).filter ( key ) ->
    if key isnt prop
      wassat[method]( things[key] ).should.equal false

describe "main function", ->
  it "works for strings", ->
    runMainFnTest "str", "string"

  it "works for numbers", ->
    runMainFnTest "num", "number"

  it "works for booleans", ->
    runMainFnTest "bool", "boolean"

  it "works for plain objects", ->
    runMainFnTest "obj", "object"

  it "works for arrays", ->
    runMainFnTest "arr", "array"

  it "works for dates", ->
    runMainFnTest "date", "date"

  it "works for regexes", ->
    runMainFnTest "regexp", "regexp"

  it "works for arguments", ->
    runMainFnTest "args", "arguments"

describe "'is' methods", ->
  it "isString() works", ->
    runIsTest "str", "isString"

  it "isNumber() works", ->
    runIsTest "num", "isNumber"

  it "isBoolean() works", ->
    runIsTest "bool", "isBoolean"

  it "isObject() works", ->
    runIsTest "obj", "isObject"

  it "isArray() works", ->
    runIsTest "arr", "isArray"

  it "isDate() works", ->
    runIsTest "date", "isDate"

  it "isRegExp() works", ->
    runIsTest "regexp", "isRegExp"

  it "isArguments() works", ->
    runIsTest "args", "isArguments"
