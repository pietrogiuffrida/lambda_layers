#!/bin/bash

# A LIST OF PACKAGE TO INSTALL, SPACE SEPARATED
PACKAGES="numpy==1.18.2"
RUNTIMES="python3.7"

p=$(echo $PACKAGES|sed -e 's/\=//g' -e 's/\.//g' -e 's/ /_/g' -e 's/-//g')
r=$(echo $RUNTIMES|sed -e 's/\.//g')
LAYER_NAME=$r"_"$p".zip"
echo $LAYER_NAME

DESCRIPTION="$PACKAGES for $RUNTIMES"
