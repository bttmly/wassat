wassat = require "../src/index"
chai = require "chai"

chai.should()

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
  regExp : new RegExp()
  err: new Error()
  args : do ->
    arguments
  undef: undefined
  null: null

runMainFnTest = (prop, value) ->

  wassat(things[prop]).should.equal value

  Object.keys(things).forEach (key) ->
    if key isnt prop
      wassat(things[key]).should.not.equal value

runIsTest = (prop, method) ->

  wassat[method](things[prop]).should.equal true

  wassat[method].maybe(things[prop]).should.equal true
  wassat[method].maybe(null).should.equal true
  wassat[method].maybe(undefined).should.equal true

  Object.keys(things).map (key) ->
    thing = things[key]
    if key isnt prop
      wassat[method](thing).should.equal false

      if thing isnt null and thing isnt undefined
        wassat[method].maybe(thing).should.equal false

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
    runMainFnTest "regExp", "regExp"

  it "works for errors", ->
    runMainFnTest "err", "error"

  it "works for arguments", ->
    runMainFnTest "args", "arguments"

  it "works for null", ->
    runMainFnTest "null", "null"

  it "works for undefined", ->
    runMainFnTest "undef", "undefined"

  # https://people.mozilla.org/~jorendorff/es6-draft.html#sec-symbol.tostringtag
  it "defaults to 'object' when @@toStringTag is some other thing", ->
    wassat(Math).should.equal "object"
    wassat(JSON).should.equal "object"

describe "'is' methods", ->
  it "isString() and isString.maybe() works", ->
    runIsTest "str", "isString"

  it "isNumber() and isNumber.maybe() works", ->
    runIsTest "num", "isNumber"

  it "isBoolean() and isBoolean.maybe() works", ->
    runIsTest "bool", "isBoolean"

  it "isObject() and isObject.maybe() works", ->
    runIsTest "obj", "isObject"

  it "isArray() and isArray.maybe() works", ->
    runIsTest "arr", "isArray"

  it "isFunction() and isFunction.maybe() works", ->
    runIsTest "func", "isFunction"

  it "isDate() and isDate.maybe() works", ->
    runIsTest "date", "isDate"

  it "isRegExp() and isRegExp.maybe() works", ->
    runIsTest "regExp", "isRegExp"

  it "isError() and isError.maybe() works", ->
    runIsTest "err", "isError"

  it "isArguments() and isArguments.maybe() works", ->
    runIsTest "args", "isArguments"

  it "isNull() and and isNull.maybe() works", ->
    runIsTest "null", "isNull"

  it "isUndefined() and isUndefined.maybe() works", ->
    runIsTest "undef", "isUndefined"

  it "isNil() and works", ->
    wassat.isNil(null).should.equal true
    wassat.isNil(undefined).should.equal true

  it "isIt() works for built-in objects & primitives", ->
    wassat.isIt(String, "abc").should.equal true
    wassat.isIt(Boolean, true).should.equal true
    wassat.isIt(Number, 20000).should.equal true
    wassat.isIt(Object, []).should.equal true
    wassat.isIt(Array, []).should.equal true

  it "isIt() works for user defined classes & subclasses", ->
    joe = new Human()
    wassat.isIt(Human, joe).should.equal true
    wassat.isIt(Mammal, joe).should.equal true

  it "isItExactly() works for built-in objects & primitives", ->
    wassat.isItExactly(Number, "abc").should.equal false
    wassat.isItExactly(String, "abc").should.equal true
    wassat.isItExactly(Object, []).should.equal false
    wassat.isItExactly(Array, []).should.equal true

  it "isItExactly() works for user defined classes & subclasses", ->
    jane = new Human()
    wassat.isItExactly(Human, jane).should.equal true
    wassat.isItExactly(Mammal, jane).should.equal false

  it "isAll() correctly checks if all members of an iterable are a type", ->
    str = "abcdefgh"
    wassat.isAll("string", str).should.equal true
    wassat.isAll("number", [ 1, 2, 3 ]).should.equal true
    wassat.isAll("number", [ 1, "a", 3 ]).should.equal false
    wassat.isAll("object", [ {}, {}, {} ]).should.equal true
    wassat.isAll("object", [ {}, 1, [] ]).should.equal false

  it "isPrimitive() only returns true for strings, numbers, booleans", ->
    ["asdf", 12345, true].forEach (val) ->
      wassat.isPrimitive(val).should.equal true
    [{}, [], new Date(), Function(), new RegExp()].forEach (val) ->
      wassat.isPrimitive(val).should.equal false


describe "types property", ->
  it "has all the right properties", ->
    wassat.types.string.should.equal true
    wassat.types.number.should.equal true
    wassat.types.boolean.should.equal true
    wassat.types.array.should.equal true
    wassat.types.object.should.equal true
    wassat.types.function.should.equal true
    wassat.types.date.should.equal true
    wassat.types.regExp.should.equal true
    wassat.types.undefined.should.equal true
    wassat.types.null.should.equal true

  it "doesn't have other random stuff", ->
    chai.expect(wassat.types.hasOwnProperty).to.not.be.ok
    chai.expect(wassat.types.constructor).to.not.be.ok
