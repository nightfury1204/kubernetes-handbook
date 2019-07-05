# M3DB

> Specified Multi tenant in `https://m3db.github.io/m3/introduction/motivation/motivation`

> Time series that are not read frequently are not kept in memory. Variable durability. `https://m3db.github.io/m3/m3db/architecture/` 


### Storage

https://m3db.github.io/m3/m3db/architecture/engine/

Key points:

- One of M3DB's biggest strengths as a time series database (as opposed to using a more general-purpose horizontally scalable, distributed database like Cassandra) is its ability to compress time series data resulting in huge memory and disk savings.

- The compression comes with a few caveats though, namely that you cannot read individual datapoints in a compressed block. In other words, in order to read a single datapoint you must decompress the entire block up to the datapoint that you're trying to read.

- If M3DB kept everything in memory (and in fact, early versions of it did), than you could conceptually think of it as being a composed from a hierarchy of maps:
  
  database_obect => map namespace_object => map shard_object => map series_object => map series_object => map (This map should only have one or two entries)
  
- there is still a heavy cost associated with any query that has to retrieve data from disk because going to disk is always much slower than accessing main memory. To compensate for that, M3DB support various caching policies which can significantly improve the performance of reads by caching data in memory.

- Since M3DB nodes return compressed blocks (the M3DB client decompresses them), it's not possible to return "partial results" for a given block. In practice, this ends up being not much of an issue because of the high compression ratio that M3DB is able to achieve.

- M3DB does not support storing data with an indefinite retention period, every namespace in M3DB is required to have a retention policy which specifies how long data in that namespace will be retained for. While there is no upper bound on that value (Uber has production databases running with retention periods as high as 5 years), its still required and generally speaking M3DB is optimized for workloads with a well-defined TTL.

- M3DB does not support either background data repair or Cassandra-style read repairs. Future versions of M3DB will support automatic repairs of data as an ongoing background process.


### Sharding

https://m3db.github.io/m3/m3db/architecture/sharding/

Key points:

- They make horizontal scaling easier and adding / removing nodes without downtime trivial at the cluster level.

- or a write to appear as successful for a given replica it must succeed against all assigned hosts for that shard. That means if there is a given shard with a host assigned as LEAVING and another host assigned as INITIALIZING for a given replica writes to both these hosts must appear as successful to return success for a write to that given replica. Currently however only AVAILABLE shards count towards consistency, the work to group the LEAVING and INITIALIZING shards together when calculating a write success/error is not complete, see [issue 417](https://github.com/m3db/m3/issues/417).


### Consistency Levels

https://m3db.github.io/m3/m3db/architecture/consistencylevels/

- types of consistency levels

### Storage

https://m3db.github.io/m3/m3db/architecture/storage/

### Commit logs

https://m3db.github.io/m3/m3db/architecture/commitlogs/

equivalent to the commit log or write-ahead-log in other databases

- multiple namespaces in a single process will share a commit log.

- Integrity Levels

- Compaction / Snapshotting

### Peer streaming

https://m3db.github.io/m3/m3db/architecture/peer_streaming/

- In terms of error handling, the client will respect the consistency level specified for bootstrap. This means that when fetching metadata, indefinite retry is performed until the consistency level is achieved, for instance for quorum a majority of peers must successfully return metadata. For fetching the block data, if checksum matches from all peers then one successful fetch must occur, unless bootstrap consistency level "none" is specified, and if checksum mismatches then the specified consistency level must be achieved when the series block fetch is fanned out to peers. Fetching block data as well will indefinitely retry until the consistency level is achieved.

### Caching

https://m3db.github.io/m3/m3db/architecture/caching/

- cache policies


### Namespaces

https://m3db.github.io/m3/operational_guide/namespace_configuration/

- Adding namespace

- Deleting namespace

- Modifying namespace

- namespace configuration

### placement

https://m3db.github.io/m3/operational_guide/placement_configuration/

- shard size


### query

https://m3db.github.io/m3/how_to/query/

https://eng.uber.com/billion-data-point-challenge/

http://m3db.github.io/m3/query_engine/

## Notes

#### pod delete

when running m3db using operator, i deleted a pod, but new pod doesn't get bootstrapped. Possible reason because of Podidentity.
 it used pod uid for identity, so deleting pod caused change in uid, that result configuration error.
  
```
  placement":{  
        "instances":{  
           "{\"name\":\"simple-cluster-rep0-0\",\"uid\":\"d34bf68a-43dc-11e9-b694-42010a8001ab\"}":{  },
           "{\"name\":\"simple-cluster-rep0-0\",\"uid\":\"d9b2de4f-43c3-11e9-b694-42010a8001ab\"}":{  },
           "{\"name\":\"simple-cluster-rep1-0\",\"uid\":\"e37fef0e-43c3-11e9-b694-42010a8001ab\"}":{  }
        }
```

```
https://github.com/m3db/m3/issues/1395
```

solution: https://operator.m3db.io/configuration/pod_identity/

- replication factor replicate the shard

- for replication factor 1 and 2 zone, shards are distributed across the zonec
```json
{
   "placement":{
      "instances":{
         "{\"name\":\"simple-cluster-rep0-0\"}":{
            "id":"{\"name\":\"simple-cluster-rep0-0\"}",
            "isolationGroup":"us-central1-a",
            "zone":"embedded",
            "weight":100,
            "endpoint":"simple-cluster-rep0-0.m3dbnode-simple-cluster:9000",
            "shards":[
               {
                  "id":0,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":1,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":3,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":5,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":7,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":11,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":12,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":14,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               }
            ],
            "shardSetId":0,
            "hostname":"simple-cluster-rep0-0.m3dbnode-simple-cluster",
            "port":9000
         },
         "{\"name\":\"simple-cluster-rep1-0\"}":{
            "id":"{\"name\":\"simple-cluster-rep1-0\"}",
            "isolationGroup":"us-central1-b",
            "zone":"embedded",
            "weight":100,
            "endpoint":"simple-cluster-rep1-0.m3dbnode-simple-cluster:9000",
            "shards":[
               {
                  "id":2,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":4,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":6,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":8,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":9,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":10,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":13,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               },
               {
                  "id":15,
                  "state":"AVAILABLE",
                  "sourceId":"",
                  "cutoverNanos":"0",
                  "cutoffNanos":"0"
               }
            ],
            "shardSetId":0,
            "hostname":"simple-cluster-rep1-0.m3dbnode-simple-cluster",
            "port":9000
         }
      },
      "replicaFactor":1,
      "numShards":16,
      "isSharded":true,
      "cutoverTime":"0",
      "isMirrored":false,
      "maxShardSetId":0
   },
   "version":3
}
```

- for replication 1, if 1 pod is deleted, then it will could cause query down time. In statefulset and pvc, it depends on the volume whether pervious data lost or not.

- is it possible to change the replication factor and nums of shard after m3db deployed? if yes, then how? will it cause down time?
    - From gitter, Not currently. You have to destroy the placement and rebuild it 

- distribution of shard after scaling multi zone cluster.
     - simple-cluster-rep0-0 : [3, 4, 5, 6, 7, 8, 13, 15]
     - simple-cluster-rep0-1 : [0, 1, 2, 9, 10, 11, 12, 14]
     - simple-cluster-rep1-0 : [0, 2, 5, 7, 9, 10, 12, 13]
     - simple-cluster-rep1-1:  [1, 3, 4, 6, 8, 11, 14, 15]

- current value for vm.swappiness(60) is above recommended threshold(1)], refer to linked documentation for more information [{url https://m3db.github.io/m3/operational_guide/kernel_configuration}]  06:48:59.387899[W] invalid configuration found [current value for vm.max_map_count(65530) is below recommended threshold(3000000)

- vm.max_map_count

    - https://github.com/pires/kubernetes-elasticsearch-cluster/issues/137
    - https://github.com/pires/kubernetes-elasticsearch-cluster/issues/85
    - https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/
    
- Know configuration details: https://github.com/m3db/m3/blob/master/src/dbnode/config/m3dbnode-all-config.yml#L148

- Dynamic namespace creation: https://m3db.github.io/m3/operational_guide/namespace_configuration/

    - Note that deleting a namespace will not have any effect on the M3DB nodes until they are all restarted. In addition, the namespace will need to be removed from the M3Coordinator configuration and then the M3Coordinator node will need to be restarted

- cache policy: https://m3db.github.io/m3/m3db/architecture/caching/
    ```yaml
    cache:
        series:
          policy: lru
        postingsList:
          size: 262144
    ```

- query engine cache: https://github.com/m3db/m3/blob/master/docs/performance/m3query/index.md


- aggregation 
    
    ``` 
    it seems the problem solved. In the config file and init api curl -X POST localhost:7201/api/v1/placement/init -d,hostID,id,hostname all need to be set to the full hostname as hostname -f commad show. I think it's better show up in the how-to doc, and let user pay attentions to it
    
    maozi07 @maozi07 Feb 28 15:05
    Is there any detailed doc for downsample metrics.For exaple I want to downsample like 10s for 48 hour,2min for 7day,10 min for 1month..., and where can I do this coordinator node or when create the namespace or some other way
    
    Benjamin Raskin @benraskin92 Feb 28 19:39
    @maozi07 all downsampling is done in the coordinator process. all you need to do is make sure the aggregated namespace is included in both the m3db and coordinator configs. example:
    - namespace: metrics_10s_48h
      type: aggregated
      retention: 48h
      resolution: 10s
    here are some docs on aggregation http://m3db.github.io/m3/how_to/query#aggregation
    ```
   - what's the difference between aggregated and unaggregated namespace?
    
        - At the namespace level in M3DB there is no difference. At the coordinator level it tells the coordinator whether it should aggregate metrics in memory before shipping them to M3DB
        - The coordinator becomes responsible for all aggregation, and the backend nodes just take data, stick it into commitlogs, hold it in memory, and compress it + write it out. They also respond to queries, of course.
   
   - if you're doing your own aggregation (I.E pre-coordinator you have statsite or something running) then you can just round robin I'm pretty sure and that will be fine. If you're relying on the coordinator to do aggregation for you, you need to make sure that each timeseries always reaches the same coordinator (because if the coordinator is aggregating its basically stateful at that point)
   
- namespace/multi tenancy:
    -  How do m3db supports multi tenancy ? is it by creating namespace? Is there any limit of creating namespace?
        -  we actually just rely on users enforcing certain tags on their metrics for multintenancy
           There’s too much overhead to have a namespace per customer
           (In terms of number of file volumes, etc)

    ```json
    {
       "registry":{
          "namespaces":{
             "metrics-10s:2d":{
                "bootstrapEnabled":true,
                "flushEnabled":true,
                "writesToCommitLog":true,
                "cleanupEnabled":true,
                "repairEnabled":false,
                "retentionOptions":{
                   "retentionPeriodNanos":"172800000000000",
                   "blockSizeNanos":"7200000000000",
                   "bufferFutureNanos":"600000000000",
                   "bufferPastNanos":"600000000000",
                   "blockDataExpiry":true,
                   "blockDataExpiryAfterNotAccessPeriodNanos":"300000000000"
                },
                "snapshotEnabled":true,
                "indexOptions":{
                   "enabled":true,
                   "blockSizeNanos":"7200000000000"
                }
             }
          }
       }
    } 
    ```
    
- m3query
    - I have 2 namespace 1 is aggregated, another is unaggregated
        ```yaml
        - namespace: metrics-10s:2d
          retention: 180s
          resolution: 10s
          type: unaggregated
        - namespace: metrics
          retention: 960h
          resolution: 120s
          type: aggregated
        ```
     - query results: for time intervals different results different depends on the retention 
        ``` 
        up{metrics_storage="m3db_remote"}[2m]
        
        1 @1553169996.933
        1 @1553170026.933
        1 @1553170056.933
        1 @1553170086.933
        ```
        ```
        up{metrics_storage="m3db_remote"}[10m]
        
        1 @1553169720
        1 @1553169840
        1 @1553169960
        1 @1553170080
        ```
     - resolveClusterNamespacesForQuery: /home/ac/go/src/github.com/m3db/m3/src/query/storage/m3/cluster_resolver.go#75
        - First check if the unaggregated cluster can fully satisfy the query range. If so, return it and shortcircuit, as unaggregated will necessarily have every metric.
        - If any of the aggregated clusters have a complete set of metrics, use those that have the smallest resolutions, supplemented by lower resolution partially aggregated metrics.

- m3coordiantor:
    - https://gist.github.com/schallert/66d9d7b1cd1d870a5ee520e0fd193ff6

- m3db client example: 
    - https://gist.github.com/benraskin92/58585a9c97a07857e616edd2d50afd2d

Questions:

``` 
General question: I'm planning on ingesting all of my metrics via the carbon interface.
I would like these metrics to exist in three buckets - 30s resolutions for 14 days, 5 minutes resolutions for 360 days, etc

Currently, I create three namespaces with the correct retention (14 days, 360 days), then in the coordinator config I say that they're aggregated namespaces.

On ingest, the docs say that my metrics are supposed to hit all of my aggregated namespaces (which is what I want). My questions are as follows:

Do I need any unaggregated namespaces, or can I just use aggregated ones?
Should I separate my coordinator from my data nodes?
When I ingest carbon-style metrics, can I simply round-robin between my ingest nodes?

Richard Artoul @richardartoul Mar 14 22:33
1) I think M3Coordinator may require (for unreleated reasons) an unaggregated namespce. @arnikola Have we changed that yet?
2) 100%. We never recommend running coordinator instances on the same machine as the data nodes. The coordinators haven't had as much performance work put into them so you want to avoid any performance issues / OOMs there from affecting your stateful tier
3) If you're doing your own aggregation (I.E pre-coordinator you have statsite or something running) then you can just round robin I'm pretty sure and that will be fine. If you're relying on the coordinator to do aggregation for you, you need to make sure that each timeseries always reaches the same coordinator (because if the coordinator is aggregating its basically stateful at that point)
```

```

After some rigorous testing, it's clear that aggregated namespaces are causing some performance implications that I did not anticipate. One unaggregated namespace + one 30s resolution aggregated namespace can easily ingest 10 million points per minute on my test cluster. As soon as I add a 5 minute + 10 minute resolution aggregated namespace, we crash ingesting 5 million.

My theory is that aggregated namespaces work by holding data in memory and aggregating it before writing it out every N resolution. This means that our memory requirements go way up, when I'd anticipate them staying the same.

Ultimately we need the following setup:

14 days of high-resolution metrics (30s points)
3 years of low-resolution metrics (10m - 20m points depending on the specific metric)

In my limited testing, it seems like this has some real performance implications. Is there a design I am not considering that I should be? Are there any snapshots I can take you or similar?

Tl;dr I think that aggregated namespaces cause ingested data to be held more than once in memory, causing us to go explodey

arnikola @arnikola Mar 18 21:33
To clarify, you're using the coordinator prometheus remote write endpoint for ingestion?
oh wait sorry you're probably using the graphite ingestion

jessifer @bioxcession_twitter Mar 18 21:36
Graphite ingestion. I have a separate coordinator and 3 data/seed nodes. one of the data/seed nodes OOMs eventually, which to me means that it's keeping blocks open for too long.

arnikola @arnikola Mar 18 21:38
So for memory implication the unaggregated namespace can be ignored (graphite path ignores it), and in your situation you're going from storing aggregated metrics over 30 seconds in memory to storing them for 30 seonds, 5 minutes and 10 minutes as well, which could explain the jump in memory usage you're describing

Unfortunately I'm not super familiar with this ingestion path and how it aggregates before writing, @richardartoul would know better


jessifer @bioxcession_twitter Mar 18 21:39
Gotcha, it'd be useful to have that described. The memory jump is significant - +30GB in the case of the dying node.

Richard Artoul @richardartoul Mar 18 21:39
@bioxcession_twitter Which part of the stack is OOMing, the m3db node or the coordinator nodes?

jessifer @bioxcession_twitter Mar 18 21:39
One m3db node

Richard Artoul @richardartoul Mar 18 21:39
oh
so
you can probably just turn off your unaggregated namespace / give it a tiny block size, that will save you some mem
you can also just add more hardware and that will solve the problem
although its weird only one node is OOMing

jessifer @bioxcession_twitter Mar 18 21:41
I cannot turn off the unagg namespace as it's required for the coordinator to function, according to y'all?

Richard Artoul @richardartoul Mar 18 21:41
they should all have the same amount of data

arnikola @arnikola Mar 18 21:41
re:unagg if it's really small should be fine :)

jessifer @bioxcession_twitter Mar 18 21:41
currently the unagg namespace has 5m retention and a 5m blocksize
so it is indeed tiny

Richard Artoul @richardartoul Mar 18 21:41
yeah but
its a lot of extra RPC
the nodes have to do
@arnikola The coordinator wont let you turn off the unaggregated namespace still right?

arnikola @arnikola Mar 18 21:42
yeah unfortunately not
if you think it's a notable hit i can try and scope out how long it would be to drop it?

jessifer @bioxcession_twitter Mar 18 21:43
right, which is why i've tried to make it so small.

the other namespaces are:
resolution/retention
30s/1h
5m/2h
10m/3h

if I just have the 30s/1h namespace, I have no problems. When I add the other two, the cluster doesn't like it.
all of them have a 1h blocksize and 5m future/past.
```

``` 
Md. Nure Alam Nahid @N_A_Nahid_twitter Mar 20 12:48
Does resolution has effects on m3db node? since when i saw namespace api here, it has no resolution field .
How Resolution effects on m3 coordinator? If namespace has 30s resolution, does it means that coordinator will hold data for 30s seconds before sending it to m3db and also will send 1 data point per 30s?

arnikola @arnikola Mar 20 18:20
It's recommended to add namespaces on the database/create API here: https://m3db.io/openapi/#tag/M3DB-Database
Yep, that's how coordinator handles resolution.

Md. Nure Alam Nahid @N_A_Nahid_twitter Mar 20 19:36
@arnikola so resolution is for aggregated namespace, right? for unaggregated namespace all points(no downsampling for that) will be written in m3db, right?

arnikola @arnikola Mar 20 19:37
yeah, thats right

Md. Nure Alam Nahid @N_A_Nahid_twitter Mar 20 19:40
That's makes m3coordinator stateful in case of aggregated namespace, right?
if there is no aggregated namespace, then m3coordinator will be stateless, right?

arnikola @arnikola Mar 20 19:41
Yeah exactly; when no aggregated namespaces are present it's stateless

Md. Nure Alam Nahid @N_A_Nahid_twitter Mar 20 19:42
What's the benefits of aggregated namespace?

arnikola @arnikola Mar 20 19:43
Largely it's for historical data with longer resolutions so that you can keep data for long periods without blowing up disk space by saving every received data point

Md. Nure Alam Nahid @N_A_Nahid_twitter Mar 20 19:46
If i use aggregated namespace, then m3coordinator will be stateful. In that case, can i scale it?

arnikola @arnikola Mar 20 19:50
I'm not super sure exactly what the recommendation is for scaling stateful coordinators, I believe you may have to run your own sharding tier in front of it; we have something like this internally but not sure how much of it is available in open source yet

Richard Artoul @richardartoul Mar 20 19:51
@N_A_Nahid_twitter Its more difficult to scale stateful coordinators
If you can't do it all with one big server (with maybe a secondary for H.A)
you'll have to do some sharding on your application side which isn't great
We have a distributed, sharded aggregation tier that basically runs all of the aggregation logic in a clustered setup similar to M3DB
and it is open-source, unfortunately its not documented or easy to use right now :/


```

``` 
@richardartoul is this https://github.com/m3db/m3/tree/master/src/cmd/services/m3aggregator the code for distributed, sharded aggregation?
Can give me an idea how to use it in m3coordinator so that i can scale coordinator?

Richard Artoul @richardartoul Mar 21 19:49
@N_A_Nahid_twitter Yeah thats the service code
Right now m3aggregator is actually embedded inside of m3coordinator
but we don't have any support right now for running m3aggregator in open source
@robskillington Was working on that I think

Md. Nure Alam Nahid @N_A_Nahid_twitter Mar 21 20:35
@richardartoul thanks for the response.
For m3query does it matter whether namespace is aggregated or not?

Rob Skillington @robskillington Mar 21 20:41
Yes this is the work in progress PR to use the m3aggregator [m3db/m3#1403](https://github.com/m3db/m3/pull/1403)
@N_A_Nahid_twitter so I don't believe for PromQL it matters whether it's aggregated or not, however m3query does need to know what resolution it is (which means you have to mention that it is aggregated) so it knows if you have two retention/resolutions for a given time period
which one is preferable
to give you back data for

Md. Nure Alam Nahid @N_A_Nahid_twitter Mar 21 20:47
@robskillington will m3query merge data from different namespace or it just give the preferable namespace data?

hey so we dont have any documentation in our docs (yet), but the tl;dr is that we look at the query range and from that determine which namespaces can satisfy it based on the id’s that are being queried
```

``` 
I’ve got 1 prometheus node scraping around 100k metrics every 10s writing to 3 m3 nodes and I’m getting queue full and messages dropped, but the m3 nodes are mostly idle. I’m guessing it’s queue configuration. Any recomendations for batch sizes, min shards etc.. ?
 
Matt Stump @mattstump_twitter 05:20
Seems to have worked:
    queueConfig:
      minShards: 6
      capacity: 1000000
      maxSamplesPerSend: 100000
```