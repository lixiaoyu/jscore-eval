
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