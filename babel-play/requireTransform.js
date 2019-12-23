const babylon = require("@babel/parser")
const generate = require("@babel/generator")
const {transformFromAstSync} = require("@babel/core")
const types = require("@babel/types")
const funcTplPlugin = require('./plugins/funcTemplatePlugin.js')
const requireTransform = (source, options) => {
    //  1.用 babylon 解析 ast
    let sourceAst = babylon.parse(source, {allowReturnOutsideFunction: true})
    // 2. 注入 plugin 到 babel，修改配置属性
    const plugins = [];
    plugins.push([funcTplPlugin,options]);
    const {ast, code} = transformFromAstSync(sourceAst, source,{
        ast: true,
        babelrc: false,
        code: true,
        configFile: false,
        comments: true,
        plugins,
        sourceMaps: false
    });
   // 3. 将 babel 处理之后的 ast 生成代码
   console.log(code)
    return code
}

module.exports = requireTransform;
