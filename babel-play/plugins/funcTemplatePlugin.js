const {template} = require('@babel/core')
const traverse = require('@babel/traverse').default
const generate = require('@babel/generator').default
const types = require('@babel/types')
const babylon = require("babylon")
const fs = require('fs')
// 1.根据sourcefile 扫描出 variable indentifier
const sourceCode = fs.readFileSync('./sources/sourcefile','utf-8').toString()
sourceCode.trim()
sourceCode.replace(/[\r\n]/g,"");        

// console.log(sourceCode);

var variableList = []
const ast = babylon.parse(sourceCode)
traverse(ast,{
    enter(path) {
        if (path.node.type === "Identifier" && !['includes','in'].includes(path.node.name)) {
            const nodeName = path.node.name
            if(variableList.indexOf(nodeName) === -1) variableList.push(nodeName)
        }
    }
})
// console.log(ast)
// console.log(variableList)
// 2. 根据扫描出的 varlist 构造 var表达式
const buildParams = template(`
    const {PARAM_LIST} = params;
`) 
const paramAST = buildParams({
    PARAM_LIST: types.identifier(variableList.join(','))
});
const paramAssignCode = generate(paramAST).code
// console.log(paramAssignCode);
// const returnExprTpl = template.expression(types.memberExpression(sourceCode));
//3. 根据template 组装 function 并返回
//  const param 的追加，returnStatement 的替换
module.exports = ({types: t},option) => {
    return {
        visitor: {
            ReturnStatement(path) {
                path.insertBefore(types.expressionStatement(types.stringLiteral(paramAssignCode)));
            },
            Identifier(path) {
                if (path.node.name === 'RETURN_STATMENT') {
                    path.replaceWithSourceString(sourceCode)
                }
            }
        }
    }
}
