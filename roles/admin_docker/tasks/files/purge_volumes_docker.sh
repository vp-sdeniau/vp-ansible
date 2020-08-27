#!/bin/bash

volumes=$(docker volume ls -qf dangling=true)

if [ -n "$volumes" ] ;then
docker volume rm $volumes
else
echo "empty"
fi

