'use strict';

var config = require('./protractor-shared-conf').config;

config.specs = [
  'test/e2e/tests/**/*.js',
  'build/docs/ptore2e/**/*.js',
  'docs/app/e2e/**/*.scenario.js'
];

config.capabilities = {
  browserName: 'chrome',
  chromeOptions: {
    args: ['--no-sandbox',
      '--disable-setuid-sandbox',
      '--remote-debugging-port=9222',
      '--disable-dev-shm-using',
      '--disable-extensions',
      '--disable-gpu',
      'start-maximized',
      'disable-infobars']
  }
};

exports.config = config;
