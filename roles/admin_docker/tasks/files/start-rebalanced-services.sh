#!/bin/sh
services=$(docker service ls -q)
for service in $services
do
  docker service update ${service} --force
  name=$(docker service ls --filter id=${service} --format "{{.Name}}")
  echo ${name} updated
done
