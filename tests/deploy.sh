#!/bin/bash

# Skip deploy for staging branch
[ "$BRANCH" = "staging" ] && exit 0

docker login -u $DOCKER_UN -p $DOCKER_PW

if [ "$BRANCH" = "testing" ]
then
  docker-compose -f tests/build.yml push
  exit 0
fi

#Deploy for main releases
#Images are built with tag PINNED_MAILU_VERSION (x.y.z).
#We are tagging them as well with MAILU_VERSION (x.y)
#After that, both tags are pushed to the docker repository.
if [ "$PINNED_MAILU_VERSION" != "" ] && [ "$BRANCH" != "master" ]
then
  images=$(docker-compose -f tests/build.yml config | grep 'image: ' | awk -F ':' '{ print $2 }')
  for image in $images
  do
    docker tag "${image}":"${PINNED_MAILU_VERSION}" "${image}":${MAILU_VERSION}
  done
#Push MAILU_VERSION images
  docker-compose -f tests/build.yml push
#Push PINNED_MAILU_VERSION images
  MAILU_VERSION=$PINNED_MAILU_VERSION
  docker-compose -f tests/build.yml push
  exit 0
fi

#Deploy for master. For master we only publish images with tag master
if [ "$PINNED_MAILU_VERSION" != "" ] && [ "$BRANCH" == "master" ]
then
#Images are built with PINNED_MAILU_VERSION.
#We are tagging them as well with MAILU_VERSION
#Get all images
  images=$(docker-compose -f tests/build.yml config | grep 'image: ' | awk -F ':' '{ print $2 }')
  for image in $images
  do
    docker tag "${image}":"${PINNED_MAILU_VERSION}" "${image}":${MAILU_VERSION}
  done
#Push MAILU_VERSION images
  docker-compose -f tests/build.yml push
  exit 0
fi

#Fallback in case $PINNED_MAILU_VERSION is empty.
docker-compose -f tests/build.yml push

#MAILU_VERSION: ${{ env.MAILU_VERSION }} will be master or x.y
#PINNED_MAILU_VERSION: ${{ env.PINNED_MAILU_VERSION }} will be commit hash or x.y.z

