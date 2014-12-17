fs = require "fs"
path = require "path"

CoffeeScript = require "coffee-script"

coffeeTest = path.join __dirname, "./index.coffee"
jsTest = path.join __dirname, "./test.js"

fs.readFile coffeeTest, (encoding: "utf8"), (err, code) ->
  throw err if err
  js = CoffeeScript.compile(code).replace("../src/index", "../lib/index.js")
  fs.writeFile jsTest, js