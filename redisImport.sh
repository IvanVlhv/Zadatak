#!/usr/bin/env bash
DATA_FILE=$(locate "/import/redis/data.txt")

# check if the data file exists
if [[ ! -f "${DATA_FILE}" ]]; then
  echo "Error: Data file '${DATA_FILE}' not found!"
  exit 1
fi

# import data into redis master
kubectl -n redis exec -i $(kubectl get pod -n redis -l app=redis-master -o jsonpath="{.items[0].metadata.name}") -- \
  redis-cli --pipe < "${DATA_FILE}"

echo "Data import completed successfully!"
