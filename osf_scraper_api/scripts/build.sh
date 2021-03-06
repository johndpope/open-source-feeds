#!/bin/bash -e
echo "++ building docker image for build env: ${BUILD_ENV}"
BASEDIR=$(dirname $( cd $(dirname $0) ; pwd -P ))
echo "BASEDIR: ${BASEDIR}"
echo "++ compiling nunjucks templates"
nunjucks *.njk -p $BASEDIR/devops/templates \
    -o $BASEDIR/devops/build \
    -e "$BASEDIR/devops/config/${BUILD_ENV}.json"
echo "++ building docker image"
docker-compose build
osascript -e 'display notification "finished" with title "Notification"'