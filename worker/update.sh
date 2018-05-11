#!/bin/bash
TAG=$(date +%s)
docker build -t gcr.io/dk-cloudcatz/ccworker:$TAG .
gcloud docker -- push gcr.io/dk-cloudcatz/ccworker:$TAG
kubectl set image deployment cloudcats-worker cloudcats-worker=gcr.io/dk-cloudcatz/ccworker:$TAG
kubectl rollout status deployment cloudcats-worker
