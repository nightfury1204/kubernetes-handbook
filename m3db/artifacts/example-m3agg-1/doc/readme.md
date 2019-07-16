# M3aggregator

### GET

```
curl -H "Cluster-Environment-Name: demo/simple-cluster"  http://localhost:7201/api/v1/services/m3aggregator/placement
```

### ADD

```
curl -X POST -H "Cluster-Environment-Name: demo/simple-cluster"  http://localhost:7201/api/v1/services/m3aggregator/placement  -d '{
    "instances": [
        {
            "id": "m3aggregator-2:6000",
            "isolation_group": "availability-zone-a",
            "zone": "embedded",
            "weight": 100,
            "endpoint": "m3aggregator-2.m3aggregator.demo.svc:6000",
            "hostname": "m3aggregator-2",
            "port": 6000
        },
        {
            "id": "m3aggregator-3:6000",
            "isolation_group": "availability-zone-b",
            "zone": "embedded",
            "weight": 100,
            "endpoint": "m3aggregator-3.m3aggregator.demo.svc:6000",
            "hostname": "m3aggregator-3",
            "port": 6000
        }
    ]
}'
```

# M3COORDINATOR

### GET

```yaml
curl -H "Cluster-Environment-Name: demo/simple-cluster"  http://localhost:7201/api/v1/services/m3coordinator/placement
```

### Replace

``` 
curl -H "Cluster-Environment-Name: demo/simple-cluster"  http://localhost:7201/api/v1/m3coordinator/replace -d '{
    "instances": [
            {
                "id": "m3coordinator-1",
                "zone": "embedded",
                "endpoint": "m3coordinator-0.m3crdntr.demo.svc:7507",
                "hostname": "m3coordinator-1",
                "port": 7507
            }
        ]
}
'
```

## dd

Hi guys,

I set up the m3aggregator by following this doc: https://github.com/m3db/m3/pull/1741. I have been running the m3aggregator for more than 1 hour. But the shard state is still in INITIALIZING state. That's why I can not scale.

```
$ curl  http://localhost:7201/api/v1/services/m3aggregator/placement
{  
   "placement":{  
      "instances":{  
         "m3aggregator-0:6000":{  
            "id":"m3aggregator-0:6000",
            "isolationGroup":"availability-zone-a",
            "zone":"embedded",
            "weight":100,
            "endpoint":"m3aggregator-0.m3aggregator.demo.svc:6000",
            "shards":[  
               {  
                  "id":0,
                  "state":"INITIALIZING",
                  "sourceId":"",
                  "cutoverNanos":"1561974000000000000",
                  "cutoffNanos":"0"
               },
...
```

When I try to add a new node to m3aggregator it gives the error.

```
$ curl -X POST  http://localhost:7201/api/v1/services/m3aggregator/placement  -d '{
    "instances": [
        {
            "id": "m3aggregator-2:6000",
            "isolation_group": "availability-zone-a",
            "zone": "embedded",
            "weight": 100,
            "endpoint": "m3aggregator-2.m3aggregator.demo.svc:6000",
            "hostname": "m3aggregator-2",
            "port": 6000
        },
        {
            "id": "m3aggregator-3:6000",
            "isolation_group": "availability-zone-b",
            "zone": "embedded",
            "weight": 100,
            "endpoint": "m3aggregator-3.m3aggregator.demo.svc:6000",
            "hostname": "m3aggregator-3",
            "port": 6000
        }
    ]
}'
```

```
{"error":"instances [m3aggregator-0:6000,m3aggregator-1:6000] do not have all shards available"}
```

But I am getting metric data for aggregated namespace. I have created an issue in m3: https://github.com/m3db/m3/issues/1789

It will be very helpful if you guys could tell me how to solve this issue or point me in the right direction.

Thank you,
Nahid