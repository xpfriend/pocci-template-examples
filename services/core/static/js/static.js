'use strict';
var path = require('path');
var parse = require('url').parse;
var util = require('pocci/util.js');

module.exports = {
  addDefaults: function(options) {
    options.static      = options.static      || {};
    options.static.url  = options.static.url  || 'http://static.' + options.pocci.domain;
    options.static.dir  = options.static.dir  || path.resolve(process.env.POCCI_DIR, 'config/volumes/static');
  },
  addEnvironment: function(options, environment) {
    var url = parse(options.static.url);
    environment.STATIC_URL      = util.getHref(url);
    environment.STATIC_PROTOCOL = url.protocol;
    environment.STATIC_HOST     = url.hostname;
    environment.STATIC_PORT     = util.getPort(url);
    environment.STATIC_DIR      = options.static.dir;
  }
};
