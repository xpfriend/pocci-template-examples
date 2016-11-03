'use strict';
/*global describe, it*/
var assert = require('chai').assert;
var hello = require('../app/hello.js');

describe('hello.js', function() {
  it('says hello to Shoichi', function() {
    assert.equal('hello, Shoichi', hello('Shoichi'));
  });
});
