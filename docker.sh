#!/bin/sh

DOCKER_REPO_NAME='user-api'
DOCKER_PATH='davidjohnmac'
BUILD_NUMBER=$1
echo
echo "Building and pushing docker image $DOCKER_REPO_NAME:$BUILD_NUMBER"
(docker build -t "$DOCKER_REPO_NAME:$BUILD_NUMBER" . && \
  docker tag "$DOCKER_REPO_NAME:$BUILD_NUMBER" "${DOCKER_PATH}/${DOCKER_REPO_NAME}:$BUILD_NUMBER" && \
  docker tag "$DOCKER_REPO_NAME:$BUILD_NUMBER" "${DOCKER_PATH}/${DOCKER_REPO_NAME}:latest" && \
  docker push "${DOCKER_PATH}/${DOCKER_REPO_NAME}:$BUILD_NUMBER" && \
  docker push "${DOCKER_PATH}/${DOCKER_REPO_NAME}:latest") || exit $?
echo
echo "Tagging git repo with build number $BUILD_NUMBER"
git tag $BUILD_NUMBER
git push --tags