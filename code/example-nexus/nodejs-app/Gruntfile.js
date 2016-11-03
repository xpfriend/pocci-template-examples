'use strict';
module.exports = function(grunt) {
  grunt.initConfig({
    env: {
      test: {
        XUNIT_FILE: 'test-results/result.xml'
      },
    },
    mochaTest: {
      all: {
        options: {
          reporter: 'xunit-file',
          require: 'xunit-file'
        },
        src: ['test/*.js']
      },
    }
  });
  grunt.loadNpmTasks('grunt-env');
  grunt.loadNpmTasks('grunt-mocha-test');

  grunt.registerTask('default', ['env', 'mochaTest:all']);
};
