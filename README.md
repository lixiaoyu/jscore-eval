# jscore-eval
one technique presentation demo 


Create a babel plugin to generate a js function using for client side to eval.

try to introduce some knowledge about compiler stuff, like lexer、parser、ast etc.
This as a project to validate.

The function string respond by backend side is like :

function foo(param){
/* to be generated
const {age,level,interest,interests,profession} = param;
*/
return (
/**start**/
age > 18 || age < 18 + 12 && level === '3' && interests.includes('出国游') && ['出国游', '看电影'].includes(interest) || !(profession === '上班族')
/**end**/
)
}

