// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0
echo "Building settlement ingestion container"
export DOCKER_BUILDKIT=0
echo "ACCOUNT_ID - $ACCOUNT_ID"
echo "REGION - $REGION"

cp -r ../../settlement_ingestion settlement_ingestion
#docker buildx create --name mybuilder
#buildx use mybuilder
#docker buildx inspect --bootstrap
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

#docker buildx build -t settlement-trade-generator:latest --build-arg ARG_NUM_OF_TRADES=$TRADE_COUNT --build-arg ARG_GENERATE_FILES="false" --build-arg ARG_GENERATE_QUEUE="true" --build-arg ARG_OUTPUT_DIR="output" --platform linux/amd64,linux/arm64 --push .
#docker buildx build -t 285719923712.dkr.ecr.$REGION.amazonaws.com/settlement-ingress-ecr:latest --build-arg ARG_REGION=$REGION --platform linux/amd64,linux/arm64 --push .

#docker build -t settlement-ingestion . --build-arg ARG_REGION=$REGION
#docker run -e CREDS="$TEMP_CREDS" -d settlement-ingestion

docker build -t settlement-ingress-ecr . --build-arg ARG_REGION=$REGION
docker tag settlement-ingress-ecr:latest $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/settlement-ingress-ecr:latest
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/settlement-ingress-ecr:latest

#docker tag settlement-trade-generator:1.0 public.ecr.aws/h2v4m9r5/settlement-trade-generator:latest
#docker push public.ecr.aws/h2v4m9r5/settlement-trade-generator:1.0

#aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
# docker tag trades-generator:latest $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/data-generator:latest
#docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/data-generator:latest
echo "Cleanup"
rm -rf settlement_ingestion
echo "Finished."
