#!/usr/bin/env bash
set -e

# delete the redis INFO cron job
kubectl delete cronjob redis-info -n redis
