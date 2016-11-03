'use strict';

var hello = require('nodejs-lib');

module.exports = function(name) {
  return hello(name).trim();
};
