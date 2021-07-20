#!/bin/bash

ECR_REGION='us-west-1'
ECR_DN="859036681341.dkr.ecr.${ECR_REGION_FROM}.amazonaws.com"

# list all existing repos
allEcrRepos=$(aws --profile=GlobalECR --region $ECR_REGION ecr describe-repositories --query 'repositories[*].repositoryName' --output text)
#allEcrRepos="dockerhub/redis dockerhub/kope/dns-controller"
#echo "allEcrRepos:$allEcrRepos"

function replaceDomainName(){
  URI="$1"
  URI=${URI/#amazonecr/856654148726.dkr.ecr.cn-northwest-1.amazonaws.com.cn}
}

allEcrRepos=$(echo $allEcrRepos | tr " " "\n" | sort) 
for repo in $allEcrRepos
do
  tags=$(aws --profile GlobalECR --region $ECR_REGION ecr list-images --repository-name $repo |jq -r ".imageIds[]|.imageTag")
  tags=$(echo $tags | tr " " "\n" | sort) 
  for tag in $tags
  do
    if [ "$tag" != "null" ]; then
      replaceDomainName "${repo}:${tag}"
	  echo $URI >> mirrored-images.txt
	fi
  done
done
