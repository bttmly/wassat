fs = require "fs"
path = require "path"

CoffeeScript = require "coffee-script"

coffeeTest = path.join __dirname, "./index.coffee"
jsTest = path.join __dirname, "./index.js"

code = fs.readFileSync coffeeTest, (encoding: "utf8")
js = CoffeeScript.compile(code).replace("../src/index", "../lib/index.js")
fs.writeFileSync jsTest, js