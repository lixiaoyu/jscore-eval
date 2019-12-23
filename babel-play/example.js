// import * as babylon from "babylon";
// import traverse from "babel-traverse";

const babylon = require("babylon")
const traverse = require("babel-traverse").default
const generate = require("babel-generator").default
const template = require("babel-template")
const t = require("babel-types")

/*
const code = `function square(n) {
    return n*n;
}`;
const ast = babylon.parse(code)


traverse(ast,{
    enter(path) {
        if (
            path.node.type === "Indentifier" &&
            path.node.name === "n"
        ) {
            path.node.name = "x"
        }
    }
});

// console.log(generate(ast,{},code));

// template
const buildRequire = template(`
    var IMPORT_NAME = require(SOURCE);
`)
const ast1 = buildRequire({
    IMPORT_NAME: t.identifier("myModule"),
    SOURCE: t.stringLiteral("my-module")
})
console.log(generate(ast1).code)

*/

const code = `foo === bar; `

export default function({ types: t}){
    return {
        visitor: {
            //
            Indentifier(path,state){},
            BinaryExpression(path) {
                if(path.node.operator !== "===") {
                    return
                }
                path.node.left = t.identifier("sebmck")
            }
        }
    }
}