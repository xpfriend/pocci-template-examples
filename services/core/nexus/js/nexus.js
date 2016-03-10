'use strict';
var path = require('path');
var parse = require('url').parse;
var util = require('pocci/util.js');

module.exports = {
  addDefaults: function(options) {
    options.nexus            = options.nexus            || {};
    options.nexus.url        = options.nexus.url        || 'http://nexus.' + options.pocci.domain;
  },
  addEnvironment: function(options, environment) {
    var url = parse(options.nexus.url);
    environment.NEXUS_URL        = util.getHref(url);
    environment.NEXUS_PROTOCOL   = url.protocol;
    environment.NEXUS_HOST       = url.hostname;
    environment.NEXUS_PORT       = util.getPort(url);
  }
};
