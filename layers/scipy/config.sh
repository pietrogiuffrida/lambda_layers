#!/bin/bash

# A LIST OF PACKAGE TO INSTALL, SPACE SEPARATED
PACKAGES="scipy==1.4.1"
RUNTIMES="python3.7"

#LAYER_NAME='layer_numpy_1_18_2_scipy_1_4_1.zip'
p=$(echo $PACKAGES|sed -e 's/\=//g' -e 's/\.//g' -e 's/ /_/g' -e 's/-//g')
r=$(echo $RUNTIMES|sed -e 's/\.//g')
LAYER_NAME=$r"_"$p".zip"
echo $LAYER_NAME

DESCRIPTION="$PACKAGES for $RUNTIMES"
