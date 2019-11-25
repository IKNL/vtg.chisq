#!/bin/bash

# HOST='docker-registry.distributedlearning.ai'
HOST='harbor.distributedlearning.ai'
IMAGE='vantage/vantage.chisq'
TAG='test'

if [ -n "$1" ]
then
    TAG=$1
fi

docker build -t custom-r-base -f Dockerfile.custom-r-base .
docker build -t $IMAGE:$TAG -t $HOST/$IMAGE:$TAG .
docker push $HOST/$IMAGE:$TAG


