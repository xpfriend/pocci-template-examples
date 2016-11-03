/*jshint camelcase: false */
'use strict';

module.exports = {
  addDefaults: function(options) {
    options.proxy         = options.proxy         || {};
    options.proxy.address = options.proxy.address || '172.20.0.253';
    options.proxy.url     = options.proxy.url     || 'http://' + options.proxy.address + ':8888';
  },
  addEnvironment: function(options, environment) {
    environment.PROXY_ADDRESS = options.proxy.address;

    if(options.pocci.allServices.indexOf('proxy') > -1) {
      environment.http_proxy  = options.proxy.url;
      environment.https_proxy = options.proxy.url;
    }
  }
};
