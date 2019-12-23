var express = require('express');
var router = express.Router();
const fs = require('fs');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
// get js code
router.get('/eval', function(req, res, next) {
   fs.readFile('./routes/template',(error,data) => {
      console.log(console.error);
      res.json({"data":data.toString()});
   });
});

module.exports = router;
