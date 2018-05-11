#!/bin/bash

source ./vars.sh

echo "Make sure the following are enabled:"
echo "* Kubernetes Engine API"
echo "* Google Cloud Storage"
echo "* Cloud Pub/Sub API"
echo "* Cloud Vision"
echo ""

echo "Create a JSON service account key for project ${PROJECT} and save the file"
echo "as 'keyfile.json' in the 'worker' and 'web' directories."
echo ""

echo "Ensure you have write permission to the gs://dk-cloudcatz bucket."
echo ""

echo "Ensure you have a 'cloudcats' dataset in BigQuery with a table called"
echo "'images' with a 'url' field of type 'string' and a 'type' field of"
echo "type 'string'."
echo ""

echo "In console.cloud.google.come, go to 'VPC network' -> 'External IP addresses'"
echo "click 'Reserve Static Address', specify 'IPv4' as the IP Version, 'Regional'"
echo "as the Type, '${ZONE}' as the Region, and 'None' as Attached to, and click"
echo "'Reserve'.  Then copy the value of the 'External Address' listed for the "
echo "new static address and use it to replace the value of 'loadBalancerIP' in"
echo "'./web/k8config/service.yaml'."
echo ""

echo "Setting the gcloud project to ${PROJECT}"
gcloud config set project ${PROJECT}

echo "Setting the compute/zone to ${ZONE}"
gcloud config set compute/zone ${ZONE}

echo "Creating the cluster ${CLUSTER}"
gcloud container clusters create ${CLUSTER} --scopes "cloud-platform"

echo "Authenticating the cluster"
gcloud container clusters get-credentials ${CLUSTER}

echo "Creating the worker service"
kubectl create -f ./worker/k8config/service.yaml

echo "Creating the worker deployment"
kubectl create -f ./worker/k8config/deployment.yaml

echo "Creating the web service"
kubectl create -f ./web/k8config/service.yaml

echo "Creating the web ingress"
kubectl create -f ./web/k8config/ingress.yaml

echo "Creating the web deployment"
kubectl create -f ./web/k8config/deployment.yaml

echo "Run update.sh to update the deployment"
