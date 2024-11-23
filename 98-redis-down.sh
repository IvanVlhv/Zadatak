#!/usr/bin/env bash
set -e

# delete redis master deployment and service
kubectl delete deployment redis-master -n redis
echo "Redis master deployment deleted."

kubectl delete service redis-master-service -n redis
echo "Redis master service deleted."

# delete redis slave deployment and service
kubectl delete deployment redis-slave -n redis
echo "Redis slave deployment deleted."

kubectl delete service redis-slave-service -n redis
echo "Redis slave service deleted."

# delete the Redis namespace
kubectl delete namespace redis
echo "Redis namespace deleted."

echo "All Redis resources have been successfully deleted."

