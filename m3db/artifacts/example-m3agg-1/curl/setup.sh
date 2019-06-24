#!/usr/bin/env bash

curl -vvvsSf -X POST http://localhost:7201/api/v1/services/m3aggregator/placement/init -d '{
    "num_shards": 64,
    "replication_factor": 1,
    "instances": [
        {
            "id": "m3aggregator01:6000",
            "isolation_group": "availability-zone-a",
            "zone": "embedded",
            "weight": 100,
            "endpoint": "m3aggregator01.m3aggregator:6000",
            "hostname": "m3aggregator01",
            "port": 6000
        }
    ]
}'


curl -vvvsSf -X POST http://localhost:7201/api/v1/topic/init -d '{
    "numberOfShards": 64
}'

curl -vvvsSf -X POST http://localhost:7201/api/v1/services/m3coordinator/placement/init -d '{
    "instances": [
        {
            "id": "m3coordinator01",
            "zone": "embedded",
            "endpoint": "m3coordinator01.m3coordinator:7507",
            "hostname": "m3coordinator01",
            "port": 7507
        }
    ]
}'


curl -vvvsSf -X POST http://m3coordinator01:7201/api/v1/topic -d '{
  "consumerService": {
    "serviceId": {
      "name": "m3coordinator",
      "environment": "default_env",
      "zone": "embedded"
    },
    "consumptionType": "SHARED",
    "messageTtlNanos": "300000000000"
  }
}'