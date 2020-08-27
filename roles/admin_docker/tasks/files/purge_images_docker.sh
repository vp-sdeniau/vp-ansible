#!/bin/bash

images=$(docker images -aq)

if [ -n "$images" ] ;then
docker rmi $images
else
echo "empty"
fi

