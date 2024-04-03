'use strict';

var config = require('./protractor-shared-conf').config;

config.specs = [
  'test/e2e/tests/**/*.js',
  'build/docs/ptore2e/**/*.js',
  'docs/app/e2e/**/*.scenario.js'
];

config.capabilities = {
  browserName: 'chrome'
};

config.chromeDriver = `./node_modules/chromedriver/lib/chromedriver/chromedriver${process.platform.indexOf('win') === 0 ? '.exe' : ''}`

exports.config = config;
