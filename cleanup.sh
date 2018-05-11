#!/bin/bash

source ./vars.sh

echo "Deleting the worker service"
kubectl delete -f ./worker/k8config/service.yaml

echo "Deleting the worker deployment"
kubectl delete -f ./worker/k8config/deployment.yaml

echo "Deleting the web service"
kubectl delete -f ./web/k8config/service.yaml

echo "Deleting the web ingress"
kubectl delete -f ./web/k8config/ingress.yaml

echo "Deleting the web deployment"
kubectl delete -f ./web/k8config/deployment.yaml

echo "Deleting the cluster ${CLUSTER}"
gcloud container clusters delete ${CLUSTER} --zone ${ZONE}
