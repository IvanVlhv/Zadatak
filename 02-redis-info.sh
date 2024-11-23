#!/usr/bin/env bash
set -e

# checks if redis namespace exists
kubectl get namespace redis >/dev/null 2>&1 || { echo "Namespace 'redis' not found!"; exit 1; }
# creates a cron job that .yaml(INFO replication every minute)
kubectl apply -f redis-info-cronjob.yaml
