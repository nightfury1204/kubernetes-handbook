#!/usr/bin/env bash

# https://github.com/m3db/m3/blob/b59ff4c6c4956f0a82fa836adf57e3c8f8ceb815/src/query/api/v1/handler/options.go#L75
curl -vvvsSf -X POST -H "Cluster-Environment-Name: demo/simple-cluster" http://localhost:7201/api/v1/services/m3aggregator/placement/init -d '{
    "num_shards": 64,
    "replication_factor": 2,
    "instances": [
        {
            "id": "m3aggregator-0:6000",
            "isolation_group": "availability-zone-a",
            "zone": "embedded",
            "weight": 100,
            "endpoint": "m3aggregator-0.m3aggregator.demo.svc:6000",
            "hostname": "m3aggregator-0",
            "port": 6000
        },
        {
            "id": "m3aggregator-copy-0:6000",
            "isolation_group": "availability-zone-b",
            "zone": "embedded",
            "weight": 100,
            "endpoint": "m3aggregator-copy-0.m3aggregator-copy.demo.svc:6000",
            "hostname": "m3aggregator-copy-0",
            "port": 6000
        }
    ]
}'


curl -vvvsSf -X POST -H "Cluster-Environment-Name: demo/simple-cluster" http://localhost:7201/api/v1/topic/init -d '{
    "numberOfShards": 64
}'

curl -vvvsSf -X POST -H "Cluster-Environment-Name: demo/simple-cluster" http://localhost:7201/api/v1/services/m3coordinator/placement/init -d '{
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

curl -vvvsSf -X POST -H "Cluster-Environment-Name: demo/simple-cluster" http://localhost:7201/api/v1/topic -d '{
  "consumerService": {
    "serviceId": {
      "name": "m3coordinator",
      "environment": "demo/simple-cluster",
      "zone": "embedded"
    },
    "consumptionType": "SHARED",
    "messageTtlNanos": "300000000000"
  }
}'


curl http://localhost:9003/query -s -X POST -d '{
      "namespace": "metrics-agg-2",
      "query": {
        "regexp": {
          "field": "__name__",
          "regexp": ".*"
        }
      },
      "rangeStart": 0,
      "rangeEnd":'"$(date +"%s")"'
    }' | jq .

curl -X POST http://localhost:7201/api/v1/namespace -d '{
  "name": "metrics_agg-2",
  "options": {
    "bootstrapEnabled": true,
    "flushEnabled": true,
    "writesToCommitLog": true,
    "cleanupEnabled": true,
    "snapshotEnabled": true,
    "repairEnabled": false,
    "retentionOptions": {
      "retentionPeriodDuration": "48h",
      "blockSizeDuration": "2h",
      "bufferFutureDuration": "40m",
      "bufferPastDuration": "40m",
      "blockDataExpiry": true,
      "blockDataExpiryAfterNotAccessPeriodDuration": "5m"
    },
    "indexOptions": {
      "enabled": true,
      "blockSizeDuration": "2h"
    }
  }
}'