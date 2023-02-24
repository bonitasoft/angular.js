#!/bin/bash

# Script for updating the Angular bower repos from current local build.

echo "#################################"
echo "#### Update bower ###############"
echo "#################################"

ARG_DEFS=(
  "--action=(prepare|publish)"
  # the version number of the release.
  # e.g. 1.2.12 or 1.2.12-rc.1
  "--version-number=([0-9]+\.[0-9]+\.[0-9]+(-[a-z]+\.[0-9]+)?)"
)

function init {
  TMP_DIR=$(resolveDir ../../tmp)
  BUILD_DIR=$(resolveDir ../../build)
  NEW_VERSION=$VERSION_NUMBER
  if [ -z $NEW_VERSION ]
   then
    NEW_VERSION=$(cat $BUILD_DIR/version.txt)
  fi
  # get the npm dist-tag from a custom property (distTag) in package.json
#  DIST_TAG=$(readJsonProp "package.json" "distTag")
}


function prepare {
  #
  # clone repos
  #
  echo "-- Cloning bower-angular"
  git clone git@github.com:angular/bower-angular.git $TMP_DIR/bower-angular


  #
  # move the files from the build
  #

  if [ -f $BUILD_DIR/angular.js ] # ignore i18l
    then
      echo "-- Updating files in bower-angular"
      cp $BUILD_DIR/angular.* $TMP_DIR/bower-angular/
  fi

  # move i18n files
#  cp $BUILD_DIR/i18n/*.js $TMP_DIR/bower-angular-i18n/

  # move csp.css
  cp $BUILD_DIR/angular-csp.css $TMP_DIR/bower-angular


  #
  # Run local precommit script if there is one
  #
  if [ -f $TMP_DIR/bower-angular/precommit.sh ]
    then
      echo "-- Running precommit.sh script for bower-angular"
      cd $TMP_DIR/bower-angular
      $TMP_DIR/bower-angular/precommit.sh
      cd $SCRIPT_DIR
  fi


  #
  # update bower.json
  # tag each repo
  #
  echo "-- Updating version in bower-angular to $NEW_VERSION"
  cd $TMP_DIR/bower-angular
  replaceJsonProp "bower.json" "version" ".*" "$NEW_VERSION"
  replaceJsonProp "bower.json" "angular.*" ".*" "$NEW_VERSION"
  replaceJsonProp "package.json" "version" ".*" "$NEW_VERSION"
  replaceJsonProp "package.json" "angular.*" ".*" "$NEW_VERSION"

  git add -A

  echo "-- Committing and tagging bower-angular"
  git commit -m "v$NEW_VERSION"
  git tag v$NEW_VERSION
  cd $SCRIPT_DIR
}

function publish {
  echo "-- Pushing bower-angular"
  cd $TMP_DIR/bower-angular
  git push origin master
  git push origin v$NEW_VERSION

  # don't publish every build to npm
#  if [ "${NEW_VERSION/+sha}" = "$NEW_VERSION" ] ; then
#    echo "-- Publishing to npm as $DIST_TAG"
#    npm publish --tag=$DIST_TAG
#  fi

  cd $SCRIPT_DIR
}

source $(dirname $0)/../utils.inc
