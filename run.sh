#!/bin/bash
set -ex

case $DEFAULT_ARTIFACT_ROOT in
  gs:*)
    echo "GCP Storage. Required environment variables: GCLOUD_SERVICE_KEY_ENC with base64-encoded service account key JSON file"
    echo $GCLOUD_SERVICE_KEY_ENC | base64 --decode > ./secrets_dec.json
    export GOOGLE_CLOUD_KEYFILE_JSON=./secrets_dec.json
    ;;
  s3:*)
    echo "S3 Storage. Required environment variables: AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY"
    ;;
  wasbs:*)
    echo "Azure Storage. Required environment variables: AZURE_STORAGE_CONNECTION_STRING and AZURE_STORAGE_ACCESS_KEY"
    ;;
  *)
    echo "Default Storage"
    DEFAULT_ARTIFACT_ROOT="./mlruns"
    ;;
esac

mlflow server \
    --host 0.0.0.0 \
    --default-artifact-root $DEFAULT_ARTIFACT_ROOT \
    --port 5000
