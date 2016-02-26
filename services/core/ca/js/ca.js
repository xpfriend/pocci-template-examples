'use strict';
var parse = require('url').parse;
var util = require('pocci/util.js');

module.exports = {
  addDefaults: function(options) {
    options.ca      = options.ca      || {};
    options.ca.url  = options.ca.url  || 'http://ca.' + options.pocci.domain;
  },
  addEnvironment: function(options, environment) {
    var url = parse(options.ca.url);
    environment.CA_URL      = util.getHref(url);
    environment.CA_PROTOCOL = url.protocol;
    environment.CA_HOST     = url.hostname;
    environment.CA_PORT     = util.getPort(url);
  }
};
