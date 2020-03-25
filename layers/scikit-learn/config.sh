#!/bin/bash

# A LIST OF PACKAGE TO INSTALL, SPACE SEPARATED
PACKAGES="scikit-learn==0.22.1 joblib==0.14.1"
RUNTIMES="python3.7"

p=$(echo $PACKAGES|sed -e 's/\=//g' -e 's/\.//g' -e 's/ /_/g' -e 's/-//g')
r=$(echo $RUNTIMES|sed -e 's/\.//g')
LAYER_NAME=$r"_"$p".zip"
echo $LAYER_NAME

DESCRIPTION="$PACKAGES for $RUNTIMES"
