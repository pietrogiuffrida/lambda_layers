#!/bin/bash

# 2020 03 20
# https://towardsdatascience.com/hosting-your-ml-model-on-aws-lambdas-api-gateway-part-1-9052e6b63b25

#docker run --rm -it -v ${PWD}:/var/task lambci/lambda:build-python3.7 bash
docker run --rm -it -v ${PWD}:/var/task lambci/lambda:build-python3.7 sh /var/task/build_layer_inside_docker.sh
