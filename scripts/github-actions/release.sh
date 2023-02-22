#!/bin/bash

# tags the current commit as a release and publishes all artifacts to
# the different repositories.
# Note: This will also works if the commit is in the past!

echo "#################################"
echo "#### cut release     ############"
echo "#################################"

ARG_DEFS=(
  # require the git dryrun flag so the script can't be run without
  # thinking about this!
  "--git-push-dryrun=(true|false)"
  # the version number of the release.
  # e.g. 1.2.12 or 1.2.12-rc.1
  "--version-number=([0-9]+\.[0-9]+\.[0-9]+(-[a-z]+\.[0-9]+)?)"
)

function init {
  if [[ ! $VERBOSE ]]; then
    VERBOSE=false
  fi
  VERBOSE_ARG="--verbose=$VERBOSE"
}

function build {
#  ./set-node-version.sh
  cd ../..

  npm install -g grunt-cli@0.1.13
  npm i
  npm i
  grunt package

  ./check-size.sh

  cd $SCRIPT_DIR
}

function phase {
  ACTION_ARG="--action=$1"
  ./tag-release.sh $ACTION_ARG $VERBOSE_ARG\
    --version-number=$VERSION_NUMBER

  if [[ $1 == "prepare" ]]; then
    # The build requires the tag to be set already!
    build
  fi

  ./publish.sh $ACTION_ARG --version-number=$VERSION_NUMBER $VERBOSE_ARG
}

function run {
  # First prepare all scripts (build, commit, tag, ...),
  # so we are sure everything is all right
  phase prepare
  # only then publish to github
  phase publish
}

source $(dirname $0)/../utils.inc
