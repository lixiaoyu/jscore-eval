const babylon = require("@babel/parser")
const generate = require("@babel/generator")
const {transformFileSync} = require("babel-core")
const types = require("@babel/types")

const requireTransform = (source, options) => {
    //  1.用 babylon 解析 ast

    // 2. 注入 plugin 到 babel，修改配置属性

    // 3. 将 babel 处理之后的 ast 生成代码
    
}

module.exports = requireTransform;
