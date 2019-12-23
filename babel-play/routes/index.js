var express = require('express');
var router = express.Router();
const fs = require('fs');
const requireTransform = require('../requireTransform')
const path = require('path')

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
// get js code
router.get('/eval', function(req, res, next) {
   fs.readFile('./sources/funcTpl',(error,data) => {
      console.log(data.toString);
      const funcTpl = data.toString()
      const output = requireTransform(funcTpl)
      res.json({"data":output.toString()});
   });
});

// console.log('__dirname：', __dirname)
// console.log('__filename：', __filename)
// console.log('process.cwd()：', process.cwd())
// console.log('./：', path.resolve('./'))

module.exports = router;
