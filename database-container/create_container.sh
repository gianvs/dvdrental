#!/bin/bash

cd $(dirname $0)
docker build . -t dvdrental-database
#docker run --name dvdrental-container -p 15432:5432 -d dvdrental-database
docker-compose up -d
