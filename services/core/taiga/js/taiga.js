'use strict';
var path = require('path');
var parse = require('url').parse;
var util = require('pocci/util.js');
var smtp = require('pocci/smtp.js');

module.exports = {
  addDefaults: function(options) {
    options.taiga             = options.taiga             || {};
    options.taiga.url         = options.taiga.url         || 'http://taiga.' + options.pocci.domain;
    options.taiga.secretKey   = options.taiga.secretKey   || util.getRandomString();
    options.taiga.dbUser      = options.taiga.dbUser      || 'taiga';
    options.taiga.dbPassword  = options.taiga.dbPassword  || util.getRandomString();
    options.taiga.dbName      = options.taiga.dbName      || 'taiga';
    options.taiga.smtpDomain  = options.taiga.smtpDomain  || smtp.getDomain(options);
    options.taiga.smtpHost    = options.taiga.smtpHost    || smtp.getHost(options);
    options.taiga.smtpPort    = options.taiga.smtpPort    || smtp.getPort(options);
    options.taiga.mailAddress = options.taiga.mailAddress || options.pocci.adminMailAddress;
  },
  addEnvironment: function(options, environment) {
    var url = parse(options.taiga.url);
    environment.TAIGA_URL           = util.getHref(url);
    environment.TAIGA_PROTOCOL      = url.protocol;
    environment.TAIGA_HOST          = url.hostname;
    environment.TAIGA_PORT          = util.getPort(url);
    environment.TAIGA_DB_USER       = options.taiga.dbUser;
    environment.TAIGA_DB_PASS       = options.taiga.dbPassword;
    environment.TAIGA_DB_NAME       = options.taiga.dbName;
    environment.TAIGA_SECRET_KEY    = options.taiga.secretKey;
    environment.TAIGA_SMTP_DOMAIN   = options.taiga.smtpDomain;
    environment.TAIGA_SMTP_HOST     = options.taiga.smtpHost;
    environment.TAIGA_SMTP_PORT     = options.taiga.smtpPort;
    environment.TAIGA_MAIL_ADDRESS  = options.taiga.mailAddress;
  }
};
