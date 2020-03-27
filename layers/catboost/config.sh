#!/bin/bash

# A LIST OF PACKAGE TO INSTALL, SPACE SEPARATED
#PACKAGES="catboost==0.22 graphviz, pandas, numpy, scipy, plotly, matplotlib, six"
PACKAGES="catboost==0.22 six==1.14.0"
RUNTIMES="python3.7"

p=$(echo $PACKAGES|sed -e 's/\=//g' -e 's/\.//g' -e 's/ /_/g' -e 's/-//g')
r=$(echo $RUNTIMES|sed -e 's/\.//g')
LAYER_NAME=$r"_"$p".zip"
echo $LAYER_NAME

DESCRIPTION="$PACKAGES for $RUNTIMES"

S3_LAMBDA_BUCKET="crif-lambda-layers"
