#!/bin/bash

source config.sh

echo
echo -e "\tUploading ${LAYER_NAME%.zip} wiht description:\n\t$DESCRIPTION"
echo -e "\tThe layer contains: $PACKAGES"
echo

aws s3 cp $LAYER_NAME s3://$S3_LAMBDA_BUCKET/

# https://docs.aws.amazon.com/cli/latest/reference/lambda/publish-layer-version.html
aws lambda publish-layer-version \
    --layer-name ${LAYER_NAME%.zip} \
    --description "$DESCRIPTION" \
    --content S3Bucket=$S3_LAMBDA_BUCKET,S3Key=$LAYER_NAME \
    --compatible-runtimes $RUNTIMES \
    > upload.log

#    --zip-file fileb://$LAYER_NAME \

if [ $? -eq 0 ]
    then
        echo
        echo -e "\tOK"
        cat upload.log |jq .LayerArn
    else
        echo -e "\tThere was an error..."
fi
echo
