#!/bin/bash

aws s3api create-bucket --bucket crif-lambda-layers --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1
