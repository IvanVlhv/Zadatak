#!/usr/bin/env bash

# Fetch Minikube IP and service ports
MINIKUBE_IP=$(minikube ip)
REDIS_MASTER_PORT=$(kubectl get service redis-master-service -n redis -o jsonpath='{.spec.ports[0].nodePort}')
REDIS_SLAVE_PORT=$(kubectl get service redis-slave-service -n redis -o jsonpath='{.spec.ports[0].nodePort}')

# Export environment variables
export REDIS_MASTER_HOST_PORT="${MINIKUBE_IP}:${REDIS_MASTER_PORT}"
export REDIS_SLAVE_HOST_PORT="${MINIKUBE_IP}:${REDIS_SLAVE_PORT}"

echo "REDIS_MASTER_HOST_PORT=${REDIS_MASTER_HOST_PORT}"
echo "REDIS_SLAVE_HOST_PORT=${REDIS_SLAVE_HOST_PORT}"
