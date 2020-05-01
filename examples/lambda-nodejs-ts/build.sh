#!/usr/bin/env bash

docker build -t lambda .
docker create --name lambda lambda
docker cp lambda:/lambda/lambda.zip lambda.zip
docker rm lambda
