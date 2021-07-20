#!/bin/bash
env

aws configure --profile=GlobalECR set aws_access_key_id $ecr_ak
aws configure --profile=GlobalECR set aws_secret_access_key $ecr_sk
aws configure --profile=GlobalECR set default.region us-west-1