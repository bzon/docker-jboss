#!/bin/bash

docker rm -f jboss
if [ $1 == 'bash' ]; then
docker run --name jboss -p 8080:8080 -p 9990:9990 -p 9999:9999 -it bzon/jboss-eap bash
else
docker-compose up -d
fi
