'use strict';
var parse = require('url').parse;
var util = require('pocci/util.js');

module.exports = {
  addDefaults: function(options) {
    options.zabbix            = options.zabbix            || {};
    options.zabbix.url        = options.zabbix.url        || 'http://zabbix.' + options.pocci.domain;
    options.zabbix.dbUser     = options.zabbix.dbUser     || 'username';
    options.zabbix.dbPassword = options.zabbix.dbPassword || 'my_password';
  },
  addEnvironment: function(options, environment) {
    var url = parse(options.zabbix.url);
    environment.ZABBIX_URL        = util.getHref(url);
    environment.ZABBIX_PROTOCOL   = url.protocol;
    environment.ZABBIX_HOST       = url.hostname;
    environment.ZABBIX_PORT       = util.getPort(url);
    environment.ZABBIX_DB_USER    = options.zabbix.dbUser;
    environment.ZABBIX_DB_PASS    = options.zabbix.dbPassword;
  }
};
