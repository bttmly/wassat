(function() {
  var Human, Mammal, chai, downcaseFirst, getError, runAssertTest, runIsTest, runMainFnTest, things, wassat,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  wassat = require("../lib/index.js");

  chai = require("chai");

  downcaseFirst = function(str) {
    return str[0].toLowerCase() + str.slice(1);
  };

  chai.should();

  Mammal = (function() {
    function Mammal() {}

    return Mammal;

  })();

  Human = (function(superClass) {
    extend(Human, superClass);

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

  getError = function(f) {
    var err;
    try {
      f();
    } catch (error) {
      err = error;
      return err;
    }
    throw new Error("Expected error didn't occur");
  };

  runAssertTest = function(prop, method, ok) {
    var bool, err, key, message, results, target, thing;
    if (ok == null) {
      ok = true;
    }
    target = things[prop];
    bool = wassat[method].maybe(target);
    if (ok) {
      wassat[method].assert(target);
      return;
    }
    try {
      wassat[method].assert(target);
    } catch (error) {
      err = error;
      message = err.message;
      chai.expect(/^Expected/.test(message)).to.be["true"];
      chai.expect(/to be of type/.test(message)).to.be["true"];
      return;
    }
    throw new Error("shouldn't reach");
    results = [];
    for (key in things) {
      thing = things[key];
      if (key !== prop) {
        results.push((function() {
          return wassat[method].assert(thing);
        }).should["throw"](new RegExp("to be of type " + (downcaseFirst(method.slice(2))))));
      } else {
        results.push(void 0);
      }
    }
    return results;
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
    it("isIt() doesn't give false positives for primitives and Object", function() {
      wassat.isIt(Object, "abc").should.equal(false);
      wassat.isIt(Object, true).should.equal(false);
      return wassat.isIt(Object, 1234).should.equal(false);
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
      wassat.isAll("object", [{}, 1, []]).should.equal(false);
      return wassat.isAll("object", [0, {}]).should.equal(false);
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

  describe("assert methods", function() {
    it("isString.assert", function() {
      runAssertTest("str", "isString");
      return runAssertTest("func", "isString", false);
    });
    it("isNumber.assert", function() {
      runAssertTest("num", "isNumber");
      return runAssertTest("func", "isNumber", false);
    });
    it("isBoolean.assert", function() {
      runAssertTest("bool", "isBoolean");
      return runAssertTest("func", "isBoolean", false);
    });
    it("isObject.assert", function() {
      runAssertTest("obj", "isObject");
      return runAssertTest("func", "isObject", false);
    });
    it("isArray.assert", function() {
      runAssertTest("arr", "isArray");
      return runAssertTest("func", "isArray", false);
    });
    it("isFunction.assert", function() {
      runAssertTest("func", "isFunction");
      return runAssertTest("str", "isArray", false);
    });
    it("isDate.assert", function() {
      runAssertTest("date", "isDate");
      return runAssertTest("func", "isDate", false);
    });
    it("isRegExp.assert", function() {
      runAssertTest("regExp", "isRegExp");
      return runAssertTest("func", "isRegExp", false);
    });
    it("isError.assert", function() {
      runAssertTest("err", "isError");
      return runAssertTest("func", "isError", false);
    });
    it("isArguments.assert", function() {
      runAssertTest("args", "isArguments");
      return runAssertTest("func", "isArguments", false);
    });
    it("isNull.assert", function() {
      runAssertTest("null", "isNull");
      return runAssertTest("func", "isNull", false);
    });
    return it("isUndefined.assert", function() {
      runAssertTest("undef", "isUndefined");
      return runAssertTest("func", "isUndefined", false);
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
    it("doesn't have other random stuff", function() {
      chai.expect(wassat.types.hasOwnProperty).to.not.be.ok;
      return chai.expect(wassat.types.constructor).to.not.be.ok;
    });
    return it("is frozen", function() {
      wassat.types.xyz = 1;
      return (typeof wassat.types.xyz).should.equal("undefined");
    });
  });

}).call(this);
