#!/bin/bash
TAG=$(date +%s)
docker build -t gcr.io/dk-cloudcatz/ccweb:$TAG .
gcloud docker -- push gcr.io/dk-cloudcatz/ccweb:$TAG
kubectl set image deployment cloudcats-web cloudcats-web=gcr.io/dk-cloudcatz/ccweb:$TAG
kubectl rollout status deployment cloudcats-web
