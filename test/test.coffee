wassat = require "../"
require( "chai" ).should()

class Mammal

class Human extends Mammal

things =
  str : "abc"
  num : 123
  bool : false
  obj : key: "value"
  arr : ["a", 1]
  func: ->
  date : new Date()
  regexp : new RegExp()
  args : do ->
    arguments
  undef: undefined
  null: null

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

  it "works for functions", ->
    runMainFnTest "func", "function"

  it "works for dates", ->
    runMainFnTest "date", "date"

  it "works for regexes", ->
    runMainFnTest "regexp", "regexp"

  it "works for arguments", ->
    runMainFnTest "args", "arguments"

  it "works for null", ->
    runMainFnTest "null", "null"

  it "works for undefined", ->
    runMainFnTest "undef", "undefined"

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

  it "isFunction() works", ->
    runIsTest "func", "isFunction"

  it "isDate() works", ->
    runIsTest "date", "isDate"

  it "isRegExp() works", ->
    runIsTest "regexp", "isRegExp"

  it "isArguments() works", ->
    runIsTest "args", "isArguments"

  it "isNull() works", ->
    runIsTest "null", "isNull"

  it "isUndefined() works", ->
    runIsTest "undef", "isUndefined"

  it "isNil() works", ->
    wassat.isNil( null ).should.equal true
    wassat.isNil( undefined ).should.equal true

  it "isIt() works for built-in objects & primitives", ->
    wassat.isIt( String, "abc" ).should.equal true
    wassat.isIt( Object, [] ).should.equal true
    wassat.isIt( Array, [] ).should.equal true

  it "isIt() works for user defined classes & subclasses", ->
    joe = new Human()
    wassat.isIt( Human, joe ).should.equal true
    wassat.isIt( Mammal, joe ).should.equal true

  it "isItExactly() works for built-in objects & primitives", ->
    wassat.isItExactly( Number, "abc" ).should.equal false
    wassat.isItExactly( String, "abc" ).should.equal true
    wassat.isItExactly( Object, [] ).should.equal false
    wassat.isItExactly( Array, [] ).should.equal true

  it "isItExactly() works for user defined classes & subclasses", ->
    jane = new Human()
    wassat.isItExactly( Human, jane ).should.equal true
    wassat.isItExactly( Mammal, jane ).should.equal false

  it "isAll() correctly checks if all members of an iterable are a type", ->
    str = "abcdefgh"
    wassat.isAll( "string", str ).should.equal true
    wassat.isAll( "number", [ 1, 2, 3 ]).should.equal true
    wassat.isAll( "number", [ 1, "a", 3 ]).should.equal false
    wassat.isAll( "object", [ {}, {}, {} ]).should.equal true
    wassat.isAll( "object", [ {}, 1, [] ]).should.equal false



