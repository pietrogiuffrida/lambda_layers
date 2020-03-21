#!/bin/bash

source config.sh

echo
echo -e "\tUploading ${LAYER_NAME%.zip} wiht description:\n\t$DESCRIPTION"
echo -e "\tThe layer contains: $PACKAGES"
echo

# https://docs.aws.amazon.com/cli/latest/reference/lambda/publish-layer-version.html
aws lambda publish-layer-version \
    --layer-name ${LAYER_NAME%.zip} \
    --description "$DESCRIPTION" \
    --zip-file fileb://$LAYER_NAME \
    --compatible-runtimes $RUNTIMES \
    > upload.log

if [ $? -eq 0 ]
then
echo
echo -e "\tOK"
else
echo -e "\tThere was an error..."
fi
echo
