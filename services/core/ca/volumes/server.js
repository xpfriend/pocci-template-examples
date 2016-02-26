'use strict';
var fs = require('co-fs');
var koa = require('koa');
var logger = require('koa-logger');
var router = require('koa-router')();
var spawn = require('co-child-process');
var uuid = require('uuid');
var bodyParser = require('koa-body-parser');

var app = module.exports = koa();

router.post('/sign', function*() {
  var id = uuid.v4();
  var csrFile = '/tmp/' + id + '.csr';
  var crtFile = '/tmp/' + id + '.crt';

  console.log('-- Create: ' + id);
  console.log(this.request);
  yield fs.writeFile(csrFile, this.request.body);
  var args = ['sign.sh', csrFile, crtFile];
  yield spawn('/bin/bash', args, {stdio: 'inherit'});
  this.body = yield fs.readFile(crtFile);

  yield fs.unlink(csrFile);
  yield fs.unlink(crtFile);
});

router.get('/', function*() {
  this.body = "OK";
});

app
  .use(logger())
  .use(bodyParser())
  .use(router.routes())
  .use(router.allowedMethods());

if (!module.parent) {
  app.listen(process.env.APP_PORT || 9898);
}
