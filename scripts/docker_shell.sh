#!/bin/env bash


docker build -t dev .

docker run -it --rm -v $PWD:/tmp -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION dev sh -c "cd /tmp; /bin/bash"
