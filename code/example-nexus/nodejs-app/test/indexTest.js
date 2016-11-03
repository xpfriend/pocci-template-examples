'use strict';
/*global describe, it*/
var assert = require('chai').assert;
var hello2 = require('../app/index.js');

describe('index.js', function() {
  it('says hello to Shoichi', function() {
    assert.equal('hello, Shoichi', hello2('Shoichi '));
  });
});
