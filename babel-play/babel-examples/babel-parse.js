
const babylon = require("babylon")



const code = `function square(n) {
    return n*n;
}`;
const ast = babylon.parse(code)
console.log(ast);

/*



*/
