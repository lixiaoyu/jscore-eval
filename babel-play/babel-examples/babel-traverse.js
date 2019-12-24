const babylon = require("babylon")
const traverse = require("babel-traverse").default
const generate = require("babel-generator").default


const code = `function square(n) {
    return n * n;
  }`;
  
const ast = babylon.parse(code);

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


console.log(generate(ast).code);