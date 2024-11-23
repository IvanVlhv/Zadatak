#!/usr/bin/env bash
set -e

#ensure that namespace exists
kubectl create namespace redis || echo "Namespace 'redis' already exists"

#deploys redis master
kubectl apply -f redis-master-deployment.yaml
echo "Redis master deployed"

#deploys redis slave
kubectl apply -f redis-slave-deployment.yaml
echo "Redis slave deployed"

#exposes redis services
kubectl expose deployment redis-master --type=NodePort --name=redis-master-service -n redis
echo "Redis master service exposed on NodePort"
kubectl expose deployment redis-slave --type=NodePort --name=redis-slave-service -n redis
echo "Redis slave service exposed on NodePort"


#-------checking master and slave status-------------
echo "Waiting for Redis pods to be ready..."

# function to wait for a pod to be in running state
wait_for_pod() {
    local label=$1
    echo "Waiting for pod with label '$label' to be ready..."
    kubectl -n redis wait --for=condition=ready pod -l $label --timeout=120s
}

# use of function for master and slave
wait_for_pod "app=redis-master"
wait_for_pod "app=redis-slave"

# verifying services
MASTER_STATUS=$(kubectl get pods -n redis -l app=redis-master -o jsonpath='{.items[0].status.phase}')
SLAVE_STATUS=$(kubectl get pods -n redis -l app=redis-slave -o jsonpath='{.items[0].status.phase}')

if [[ "$MASTER_STATUS" == "Running" && "$SLAVE_STATUS" == "Running" ]]; then
    echo "Success: Redis master and slave are running correctly."
else
    echo "Error: There is an issue with the Redis deployment."
    echo "Master Status: $MASTER_STATUS"
    echo "Slave Status: $SLAVE_STATUS"
    exit 1
fi
