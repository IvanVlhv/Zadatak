#!/usr/bin/env bash
set -e

# remove all data from redis master
kubectl -n redis exec -i $(kubectl get pod -n redis -l app=redis-master -o jsonpath="{.items[0].metadata.name}") -- \
  redis-cli FLUSHALL
