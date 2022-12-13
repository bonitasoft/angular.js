AngularJS
=========

Fork from angularjs for Bonitasoft.

To make branch 1.3.x working, we need to:

* git checkout 1.3.x
* nvm install 6.17.1

1. node module not exist https://github.com/angular/angular.js/issues/13123

Dans copy-npm-shrinkwrap.js
Remplacer la fonction main

function _main() {
  process.chdir(PROJECT_ROOT);
  if (!fs.existsSync(NODE_MODULES_DIR)) {
    fs.mkdirSync(NODE_MODULES_DIR);
  }
  copyFile(NPM_SHRINKWRAP_FILE, NPM_SHRINKWRAP_CACHED_FILE, onCopied);
}

2. npm install -g grunt-cli@0.1.13
pour pouvoir lancer grunt package

3. Installer python2.7.18
https://tecadmin.net/install-python-2-7-on-ubuntu-and-linuxmint/

4. grunt package =>
Error: Could not create the Java Virtual Machine.
Error: A fatal exception has occurred. Program will exit.
Unrecognized option: -d32














AngularJS lets you write client-side web applications as if you had a smarter browser.  It lets you
use good old HTML (or HAML, Jade and friends!) as your template language and lets you extend HTML’s
syntax to express your application’s components clearly and succinctly.  It automatically
synchronizes data from your UI (view) with your JavaScript objects (model) through 2-way data
binding. To help you structure your application better and make it easy to test, AngularJS teaches
the browser how to do dependency injection and inversion of control.

Oh yeah and it helps with server-side communication, taming async callbacks with promises and
deferreds. It also makes client-side navigation and deeplinking with hashbang urls or HTML5 pushState a
piece of cake. Best of all?? It makes development fun!

* Web site: http://angularjs.org
* Tutorial: http://docs.angularjs.org/tutorial
* API Docs: http://docs.angularjs.org/api
* Developer Guide: http://docs.angularjs.org/guide
* Contribution guidelines: [CONTRIBUTING.md](https://github.com/angular/angular.js/blob/master/CONTRIBUTING.md)
* Dashboard: http://dashboard.angularjs.org

Building AngularJS
---------
[Once you have your environment setup](http://docs.angularjs.org/misc/contribute) just run:

    grunt package


Running Tests
-------------
To execute all unit tests, use:

    grunt test:unit

To execute end-to-end (e2e) tests, use:

    grunt package
    grunt test:e2e

To learn more about the grunt tasks, run `grunt --help` and also read our
[contribution guidelines](https://github.com/angular/angular.js/blob/master/CONTRIBUTING.md).


[![Analytics](https://ga-beacon.appspot.com/UA-8594346-11/angular.js/README.md?pixel)](https://github.com/igrigorik/ga-beacon)

