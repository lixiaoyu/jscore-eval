const template = require("babel-template")
const t = require("babel-types")
const generate = require("babel-generator").default

// template
const buildRequire = template(`
    var IMPORT_NAME = require(SOURCE);
`)
const ast1 = buildRequire({
    IMPORT_NAME: t.identifier("myModule"),
    SOURCE: t.stringLiteral("my-module")
})
console.log(generate(ast).code)
