(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var capitalize, toString, types, wassat;

toString = Object.prototype.toString;

capitalize = function(str) {
  return str[0].toUpperCase() + str.slice(1);
};

types = {
  "[object String]": "string",
  "[object Number]": "number",
  "[object Boolean]": "boolean",
  "[object Object]": "object",
  "[object Array]": "array",
  "[object RegExp]": "regexp",
  "[object Date]": "date",
  "[object Arguments]": "arguments"
};

wassat = function(obj) {
  var type;
  return type = types[toString.call(obj)];
};

Object.keys(types).forEach(function(key) {
  var fnName, type;
  type = types[key];
  fnName = "is" + capitalize(type);
  fnName = fnName === "isRegexp" ? "isRegExp" : fnName;
  return wassat[fnName] = function(obj) {
    return wassat(obj) === type;
  };
});

module.exports = wassat;



},{}]},{},[1])