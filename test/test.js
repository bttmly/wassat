(function() {
  var Human, Mammal, chai, runIsTest, runMainFnTest, things, wassat,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  wassat = require("../lib/index.js");

  chai = require("chai");

  chai.should();

  Mammal = (function() {
    function Mammal() {}

    return Mammal;

  })();

  Human = (function(_super) {
    __extends(Human, _super);

    function Human() {
      return Human.__super__.constructor.apply(this, arguments);
    }

    return Human;

  })(Mammal);

  things = {
    str: "abc",
    num: 123,
    bool: false,
    obj: {
      key: "value"
    },
    arr: ["a", 1],
    func: function() {},
    date: new Date(),
    regExp: new RegExp(),
    err: new Error(),
    args: (function() {
      return arguments;
    })(),
    undef: void 0,
    "null": null
  };

  runMainFnTest = function(prop, value) {
    wassat(things[prop]).should.equal(value);
    return Object.keys(things).forEach(function(key) {
      if (key !== prop) {
        return wassat(things[key]).should.not.equal(value);
      }
    });
  };

  runIsTest = function(prop, method) {
    wassat[method](things[prop]).should.equal(true);
    wassat[method].maybe(things[prop]).should.equal(true);
    wassat[method].maybe(null).should.equal(true);
    wassat[method].maybe(void 0).should.equal(true);
    return Object.keys(things).map(function(key) {
      var thing;
      thing = things[key];
      if (key !== prop) {
        wassat[method](thing).should.equal(false);
        if (thing !== null && thing !== void 0) {
          return wassat[method].maybe(thing).should.equal(false);
        }
      }
    });
  };

  describe("main function", function() {
    it("works for strings", function() {
      return runMainFnTest("str", "string");
    });
    it("works for numbers", function() {
      return runMainFnTest("num", "number");
    });
    it("works for booleans", function() {
      return runMainFnTest("bool", "boolean");
    });
    it("works for plain objects", function() {
      return runMainFnTest("obj", "object");
    });
    it("works for arrays", function() {
      return runMainFnTest("arr", "array");
    });
    it("works for functions", function() {
      return runMainFnTest("func", "function");
    });
    it("works for dates", function() {
      return runMainFnTest("date", "date");
    });
    it("works for regexes", function() {
      return runMainFnTest("regExp", "regExp");
    });
    it("works for errors", function() {
      return runMainFnTest("err", "error");
    });
    it("works for arguments", function() {
      return runMainFnTest("args", "arguments");
    });
    it("works for null", function() {
      return runMainFnTest("null", "null");
    });
    it("works for undefined", function() {
      return runMainFnTest("undef", "undefined");
    });
    return it("defaults to 'object' when @@toStringTag is some other thing", function() {
      wassat(Math).should.equal("object");
      return wassat(JSON).should.equal("object");
    });
  });

  describe("'is' methods", function() {
    it("isString() and isString.maybe() works", function() {
      return runIsTest("str", "isString");
    });
    it("isNumber() and isNumber.maybe() works", function() {
      return runIsTest("num", "isNumber");
    });
    it("isBoolean() and isBoolean.maybe() works", function() {
      return runIsTest("bool", "isBoolean");
    });
    it("isObject() and isObject.maybe() works", function() {
      return runIsTest("obj", "isObject");
    });
    it("isArray() and isArray.maybe() works", function() {
      return runIsTest("arr", "isArray");
    });
    it("isFunction() and isFunction.maybe() works", function() {
      return runIsTest("func", "isFunction");
    });
    it("isDate() and isDate.maybe() works", function() {
      return runIsTest("date", "isDate");
    });
    it("isRegExp() and isRegExp.maybe() works", function() {
      return runIsTest("regExp", "isRegExp");
    });
    it("isError() and isError.maybe() works", function() {
      return runIsTest("err", "isError");
    });
    it("isArguments() and isArguments.maybe() works", function() {
      return runIsTest("args", "isArguments");
    });
    it("isNull() and and isNull.maybe() works", function() {
      return runIsTest("null", "isNull");
    });
    it("isUndefined() and isUndefined.maybe() works", function() {
      return runIsTest("undef", "isUndefined");
    });
    it("isNil() and works", function() {
      wassat.isNil(null).should.equal(true);
      return wassat.isNil(void 0).should.equal(true);
    });
    it("isIt() works for built-in objects & primitives", function() {
      wassat.isIt(String, "abc").should.equal(true);
      wassat.isIt(Boolean, true).should.equal(true);
      wassat.isIt(Number, 20000).should.equal(true);
      wassat.isIt(Object, []).should.equal(true);
      return wassat.isIt(Array, []).should.equal(true);
    });
    it("isIt() works for user defined classes & subclasses", function() {
      var joe;
      joe = new Human();
      wassat.isIt(Human, joe).should.equal(true);
      return wassat.isIt(Mammal, joe).should.equal(true);
    });
    it("isItExactly() works for built-in objects & primitives", function() {
      wassat.isItExactly(Number, "abc").should.equal(false);
      wassat.isItExactly(String, "abc").should.equal(true);
      wassat.isItExactly(Object, []).should.equal(false);
      return wassat.isItExactly(Array, []).should.equal(true);
    });
    it("isItExactly() works for user defined classes & subclasses", function() {
      var jane;
      jane = new Human();
      wassat.isItExactly(Human, jane).should.equal(true);
      return wassat.isItExactly(Mammal, jane).should.equal(false);
    });
    it("isAll() correctly checks if all members of an iterable are a type", function() {
      var str;
      str = "abcdefgh";
      wassat.isAll("string", str).should.equal(true);
      wassat.isAll("number", [1, 2, 3]).should.equal(true);
      wassat.isAll("number", [1, "a", 3]).should.equal(false);
      wassat.isAll("object", [{}, {}, {}]).should.equal(true);
      return wassat.isAll("object", [{}, 1, []]).should.equal(false);
    });
    return it("isPrimitive() only returns true for strings, numbers, booleans", function() {
      ["asdf", 12345, true].forEach(function(val) {
        return wassat.isPrimitive(val).should.equal(true);
      });
      return [{}, [], new Date(), Function(), new RegExp()].forEach(function(val) {
        return wassat.isPrimitive(val).should.equal(false);
      });
    });
  });

  describe("types property", function() {
    it("has all the right properties", function() {
      wassat.types.string.should.equal(true);
      wassat.types.number.should.equal(true);
      wassat.types.boolean.should.equal(true);
      wassat.types.array.should.equal(true);
      wassat.types.object.should.equal(true);
      wassat.types["function"].should.equal(true);
      wassat.types.date.should.equal(true);
      wassat.types.regExp.should.equal(true);
      wassat.types.undefined.should.equal(true);
      return wassat.types["null"].should.equal(true);
    });
    return it("doesn't have other random stuff", function() {
      chai.expect(wassat.types.hasOwnProperty).to.not.be.ok;
      return chai.expect(wassat.types.constructor).to.not.be.ok;
    });
  });

}).call(this);
