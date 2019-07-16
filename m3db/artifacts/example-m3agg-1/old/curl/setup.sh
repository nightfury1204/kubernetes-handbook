#!/usr/bin/env bash

curl -vvvsSf -X POST http://localhost:7201/api/v1/services/m3aggregator/placement/init -d '{
    "num_shards": 64,
    "replication_factor": 1,
    "instances": [
        {
            "id": "m3aggregator-0:6000",
            "isolation_group": "availability-zone-a",
            "zone": "embedded",
            "weight": 100,
            "endpoint": "m3aggregator-0.m3aggregator.demo.svc:6000",
            "hostname": "m3aggregator-0",
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
            "id": "m3coordinator-0",
            "zone": "embedded",
            "endpoint": "m3coordinator-0.m3crdntr.demo.svc:7507",
            "hostname": "m3coordinator-0",
            "port": 7507
        }
    ]
}'

curl -vvvsSf -X POST http://localhost:7201/api/v1/topic -d '{
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


curl http://localhost:9003/query -s -X POST -d '{
      "namespace": "metrics-agg",
      "query": {
        "regexp": {
          "field": "__name__",
          "regexp": ".*"
        }
      },
      "rangeStart": 0,
      "rangeEnd":'"$(date +"%s")"'
    }' | jq .