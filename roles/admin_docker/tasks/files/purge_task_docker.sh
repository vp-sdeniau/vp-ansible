#!/bin/bash

ids=$(docker ps -aq --filter status=exited)

if [ -n "$ids" ] ;then
docker rm $ids
else
echo "empty"
fi

