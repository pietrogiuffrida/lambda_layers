#!/bin/bash

# 2020 03 20
# https://towardsdatascience.com/hosting-your-ml-model-on-aws-lambdas-api-gateway-part-1-9052e6b63b25

source /var/task/config.sh

rm -rf python/
rm -f $LAYER_NAME
pip install $PACKAGES --no-deps -t python/lib/python3.7/site-packages/
zip -rq $LAYER_NAME python
rm -rf python/
