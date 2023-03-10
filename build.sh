#!/bin/bash
#docker build
docker build -t react:v1 .
docker-compose down || true
#docker-compose up
docker-compose up -d
#eof
