#!/bin/bash

# 2020 03 20
# https://towardsdatascience.com/hosting-your-ml-model-on-aws-lambdas-api-gateway-part-1-9052e6b63b25

source /var/task/config.sh

rm -rf python/
rm -f $LAYER_NAME

pip install $PACKAGES --no-deps -t python/lib/python3.7/site-packages/

find python/ -name "*.so" | xargs strip
find . -type d -name "tests" -exec rm -rf {} +
find . -type d -name "__pycache__" -exec rm -rf {} +

zip -r -9 -q $LAYER_NAME python

rm -rf python/
