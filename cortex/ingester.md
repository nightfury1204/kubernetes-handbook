# Ingester

### Flags

```
Usage of ./cmd/ingester/ingester:
  -applicationautoscaling.url value
        ApplicationAutoscaling endpoint URL with escaped Key and Secret encoded.
  -bigtable.column-key-from value
        The date (in the format YYYY-MM-DD) after which we use bigtable column keys.
  -bigtable.grpc-max-recv-msg-size int
        gRPC client max receive message size (bytes). (default 104857600)
  -bigtable.grpc-max-send-msg-size int
        gRPC client max send message size (bytes). (default 16777216)
  -bigtable.grpc-use-gzip-compression
        Use compression when sending messages.
  -bigtable.instance string
        Bigtable instance ID.
  -bigtable.max-recv-msg-size int
        DEPRECATED. Bigtable grpc max receive message size. (default 104857600)
  -bigtable.project string
        Bigtable project ID.
  -boltdb.dir string
        Location of BoltDB index files.
  -cache.enable-diskcache
        Cache config for chunks. Enable on-disk cache.
  -cache.enable-fifocache
        Cache config for chunks. Enable in-memory cache.
  -cassandra.addresses string
        Comma-separated hostnames or ips of Cassandra instances.
  -cassandra.auth
        Enable password authentication when connecting to cassandra.
  -cassandra.ca-path string
        Path to certificate file to verify the peer.
  -cassandra.consistency string
        Consistency level for Cassandra. (default "QUORUM")
  -cassandra.disable-initial-host-lookup
        Instruct the cassandra driver to not attempt to get host info from the system.peers table.
  -cassandra.host-verification
        Require SSL certificate validation. (default true)
  -cassandra.keyspace string
        Keyspace to use in Cassandra.
  -cassandra.password string
        Password to use when connecting to cassandra.
  -cassandra.port int
        Port that Cassandra is running on (default 9042)
  -cassandra.replication-factor int
        Replication factor to use in Cassandra. (default 1)
  -cassandra.ssl
        Use SSL when connecting to cassandra instances.
  -cassandra.timeout duration
        Timeout when connecting to cassandra. (default 600ms)
  -cassandra.username string
        Username to use when connecting to cassandra.
  -chunk.storage-client string
        Which storage client to use (aws, gcp, cassandra, inmemory). (default "aws")
  -config-yaml string
        Schema config yaml
  -consul.acltoken string
        ACL Token used to interact with Consul.
  -consul.client-timeout duration
        HTTP timeout when talking to consul (default 20s)
  -consul.consistent-reads
        Enable consistent reads to consul. (default true)
  -consul.hostname string
        Hostname and port of Consul. (default "localhost:8500")
  -consul.prefix string
        Prefix for keys in Consul. (default "collectors/")
  -default-validity duration
        Cache config for chunks. The default validity of entries for caches unless overridden.
  -diskcache.path string
        Cache config for chunks. Path to file used to cache chunks. (default "/var/run/chunks")
  -diskcache.size int
        Cache config for chunks. Size of file (bytes) (default 1073741824)
  -distributor.compress-to-ingester
        DEPRECATED. Compress data in calls to ingesters. (DEPRECATED: use ingester.client.compress-to-ingester instead
  -distributor.ingestion-burst-size int
        Per-user allowed ingestion burst size (in number of samples). Warning, very high limits will be reset every -distributor.limiter-reload-period. (default 50000)
  -distributor.ingestion-rate-limit float
        Per-user ingestion rate limit in samples per second. (default 25000)
  -distributor.replication-factor int
        The number of ingesters to write to and read from. (default 3)
  -dynamodb.api-limit float
        DynamoDB table management requests per second limit. (default 2)
  -dynamodb.base64-buckets-from value
        The date (in the format YYYY-MM-DD) after which we will stop querying to non-base64 encoded values.
  -dynamodb.chunk-table.from value
        Date after which to write chunks to DynamoDB.
  -dynamodb.chunk-table.period duration
        DynamoDB table period. (default 168h0m0s)
  -dynamodb.chunk-table.prefix string
        DynamoDB table prefix for period tables. (default "cortex_chunks_")
  -dynamodb.chunk-table.tag value
        Tag (of the form key=value) to be added to all tables under management.
  -dynamodb.chunk.gang.size int
        Number of chunks to group together to parallelise fetches (zero to disable) (default 10)
  -dynamodb.chunk.get.max.parallelism int
        Max number of chunk-get operations to start in parallel (default 32)
  -dynamodb.daily-buckets-from value
        The date (in the format YYYY-MM-DD) of the first day for which DynamoDB index buckets should be day-sized vs. hour-sized.
  -dynamodb.max-backoff duration
        Maximum backoff time (default 50s)
  -dynamodb.max-retries int
        Maximum number of times to retry an operation (default 20)
  -dynamodb.min-backoff duration
        Minimum backoff time (default 100ms)
  -dynamodb.original-table-name string
        The name of the DynamoDB table used before versioned schemas were introduced. (default "cortex")
  -dynamodb.periodic-table.from value
        Date after which to use periodic tables.
  -dynamodb.periodic-table.period duration
        DynamoDB table period. (default 168h0m0s)
  -dynamodb.periodic-table.prefix string
        DynamoDB table prefix for period tables. (default "cortex_")
  -dynamodb.periodic-table.tag value
        Tag (of the form key=value) to be added to all tables under management.
  -dynamodb.url value
        DynamoDB endpoint URL with escaped Key and Secret encoded. If only region is specified as a host, proper endpoint will be deduced. Use inmemory:///<table-name> to use a mock in-memory implementation.
  -dynamodb.use-periodic-tables
        Should we use periodic tables.
  -dynamodb.v4-schema-from value
        The date (in the format YYYY-MM-DD) after which we enable v4 schema.
  -dynamodb.v5-schema-from value
        The date (in the format YYYY-MM-DD) after which we enable v5 schema.
  -dynamodb.v6-schema-from value
        The date (in the format YYYY-MM-DD) after which we enable v6 schema.
  -dynamodb.v9-schema-from value
        The date (in the format YYYY-MM-DD) after which we enable v9 schema (Series indexing).
  -event.sample-rate int
        How often to sample observability events (0 = never).
  -fifocache.duration duration
        Cache config for chunks. The expiry duration for the cache.
  -fifocache.size int
        Cache config for chunks. The number of entries to cache.
  -gcs.bucketname string
        Name of GCS bucket to put chunks in.
  -httptest.serve string
        if non-empty, httptest.NewServer serves on this address and blocks
  -index.memcached.hostname string
        Deprecated: Use -store.index-cache-read.*;Hostname for memcached service to use when caching chunks. If empty, no memcached will be used.
  -index.memcached.max-idle-conns int
        Deprecated: Use -store.index-cache-read.*;Maximum number of idle connections in pool. (default 16)
  -index.memcached.service string
        Deprecated: Use -store.index-cache-read.*;SRV service used to discover memcache servers. (default "memcached")
  -index.memcached.timeout duration
        Deprecated: Use -store.index-cache-read.*;Maximum time to wait before giving up on memcached requests. (default 100ms)
  -index.memcached.update-interval duration
        Deprecated: Use -store.index-cache-read.*;Period with which to poll DNS for memcache servers. (default 1m0s)
  -ingester-client.expected-labels int
        Expected number of labels per timeseries, used for preallocations. (default 20)
  -ingester-client.expected-samples-per-series int
        Expected number of samples per timeseries, used for preallocations. (default 10)
  -ingester-client.expected-timeseries int
        Expected number of timeseries per request, use for preallocations. (default 100)
  -ingester.ID string
        ID to register into consul. (default "appscode")
  -ingester.addr string
        IP address to advertise in consul.
  -ingester.chunk-age-jitter duration
        Range of time to subtract from MaxChunkAge to spread out flushes (default 20m0s)
  -ingester.chunk-encoding value
        Encoding version to use for chunks. (default 1)
  -ingester.claim-on-rollout
        Send chunks to PENDING ingesters on exit.
  -ingester.client.compress-to-ingester
        DEPRECATED. Compress data in calls to ingesters.
  -ingester.client.grpc-max-recv-msg-size int
        gRPC client max receive message size (bytes). (default 104857600)
  -ingester.client.grpc-max-send-msg-size int
        gRPC client max send message size (bytes). (default 16777216)
  -ingester.client.grpc-use-gzip-compression
        Use compression when sending messages.
  -ingester.client.max-recv-message-size int
        DEPRECATED. Maximum message size, in bytes, this client will receive. (default 67108864)
  -ingester.concurrent-flushes int
        Number of concurrent goroutines flushing to dynamodb. (default 50)
  -ingester.flush-op-timeout duration
        Timeout for individual flush operations. (default 1m0s)
  -ingester.flush-period duration
        Period with which to attempt to flush chunks. (default 1m0s)
  -ingester.heartbeat-period duration
        Period at which to heartbeat to consul. (default 5s)
  -ingester.interface value
        Name of network interface to read address from. (default [eth0 en0])
  -ingester.join-after duration
        Period to wait for a claim from another ingester; will join automatically after this.
  -ingester.max-chunk-age duration
        Maximum chunk age before flushing. (default 12h0m0s)
  -ingester.max-chunk-idle duration
        Maximum chunk idle time before flushing. (default 5m0s)
  -ingester.max-concurrent-streams uint
        Limit on the number of concurrent streams for gRPC calls (0 = unlimited) (default 1000)
  -ingester.max-label-names-per-series int
        DEPRECATED. Maximum number of label names per series.
  -ingester.max-samples-per-query int
        The maximum number of samples that a query can return. (default 1000000)
  -ingester.max-series-per-metric int
        Maximum number of active series per metric name. (default 50000)
  -ingester.max-series-per-query int
        The maximum number of series that a query can return. (default 100000)
  -ingester.max-series-per-user int
        Maximum number of active series per user. (default 5000000)
  -ingester.min-ready-duration duration
        Minimum duration to wait before becoming ready. This is to work around race conditions with ingesters exiting and updating the ring. (default 1m0s)
  -ingester.normalise-tokens
        Store tokens in a normalised fashion to reduce allocations.
  -ingester.num-tokens int
        Number of tokens for each ingester. (default 128)
  -ingester.port int
        port to advertise in consul (defaults to server.grpc-listen-port).
  -ingester.rate-update-period duration
        Period with which to update the per-user ingestion rates. (default 15s)
  -ingester.reject-old-samples
        DEPRECATED. Reject old samples.
  -ingester.reject-old-samples.max-age duration
        DEPRECATED. Maximum accepted sample age before rejecting.
  -ingester.retain-period duration
        Period chunks will remain in memory after flushing. (default 5m0s)
  -ingester.search-pending-for duration
        Time to spend searching for a pending ingester when shutting down. (default 30s)
  -ingester.validation.max-length-label-name int
        DEPRECATED. Maximum length accepted for label names.
  -ingester.validation.max-length-label-value int
        DEPRECATED. Maximum length accepted for label value. This setting also applies to the metric name.
  -limits.per-user-override-config string
        File name of per-user overrides.
  -limits.per-user-override-period duration
        Period with this to reload the overrides. (default 10s)
  -local.chunk-directory string
        Directory to store chunks in.
  -log.level value
        Only log messages with the given severity or above. Valid levels: [debug, info, warn, error] (default info)
  -memcache.write-back-buffer int
        Cache config for chunks. How many chunks to buffer for background write back. (default 10000)
  -memcache.write-back-goroutines int
        Cache config for chunks. How many goroutines to use to write back to memcache. (default 10)
  -memcached.batchsize int
        Cache config for chunks. How many keys to fetch in each batch.
  -memcached.expiration duration
        Cache config for chunks. How long keys stay in the memcache.
  -memcached.hostname string
        Cache config for chunks. Hostname for memcached service to use when caching chunks. If empty, no memcached will be used.
  -memcached.max-idle-conns int
        Cache config for chunks. Maximum number of idle connections in pool. (default 16)
  -memcached.parallelism int
        Cache config for chunks. Maximum active requests to memcache. (default 100)
  -memcached.service string
        Cache config for chunks. SRV service used to discover memcache servers. (default "memcached")
  -memcached.timeout duration
        Cache config for chunks. Maximum time to wait before giving up on memcached requests. (default 100ms)
  -memcached.update-interval duration
        Cache config for chunks. Period with which to poll DNS for memcache servers. (default 1m0s)
  -metrics.error-rate-query string
        query to fetch error rates per table (default "sum(rate(cortex_dynamo_failures_total{error=\"ProvisionedThroughputExceededException\",operation=~\".*Write.*\"}[1m])) by (table) > 0")
  -metrics.queue-length-query string
        query to fetch ingester queue length (default "sum(avg_over_time(cortex_ingester_flush_queue_length{job=\"cortex/ingester\"}[2m]))")
  -metrics.read-error-query string
        query to fetch read errors per table (default "sum(increase(cortex_dynamo_failures_total{operation=\"DynamoDB.QueryPages\",error=\"ProvisionedThroughputExceededException\"}[1m])) by (table) > 0")
  -metrics.read-usage-query string
        query to fetch read capacity usage per table (default "sum(rate(cortex_dynamo_consumed_capacity_total{operation=\"DynamoDB.QueryPages\"}[1h])) by (table) > 0")
  -metrics.scale-up-factor float
        Scale up capacity by this multiple (default 1.3)
  -metrics.target-queue-length int
        Queue length above which we will scale up capacity (default 100000)
  -metrics.url string
        Use metrics-based autoscaling, via this query URL
  -metrics.usage-query string
        query to fetch write capacity usage per table (default "sum(rate(cortex_dynamo_consumed_capacity_total{operation=\"DynamoDB.BatchWriteItem\"}[15m])) by (table) > 0")
  -ring.heartbeat-timeout duration
        The heartbeat timeout after which ingesters are skipped for reads/writes. (default 1m0s)
  -ring.store string
        Backend storage to use for the ring (consul, inmemory). (default "consul")
  -s3.url value
        S3 endpoint URL with escaped Key and Secret encoded. If only region is specified as a host, proper endpoint will be deduced. Use inmemory:///<bucket-name> to use a mock in-memory implementation.
  -server.graceful-shutdown-timeout duration
        Timeout for graceful shutdowns (default 30s)
  -server.grpc-listen-port int
        gRPC server listen port. (default 9095)
  -server.http-idle-timeout duration
        Idle timeout for HTTP server (default 2m0s)
  -server.http-listen-port int
        HTTP server listen port. (default 80)
  -server.http-read-timeout duration
        Read timeout for HTTP server (default 30s)
  -server.http-write-timeout duration
        Write timeout for HTTP server (default 30s)
  -server.register-instrumentation
        Register the intrumentation handlers (/metrics etc). (default true)
  -store.bigchunk-size-cap-bytes int
        When using bigchunk encoding, start a new bigchunk if over this size (0 = unlimited)
  -store.cache-lookups-older-than duration
        Cache index entries older than this period. 0 to disable.
  -store.cardinality-cache-size int
        Size of in-memory cardinality cache, 0 to disable.
  -store.cardinality-cache-validity duration
        Period for which entries in the cardinality cache are valid. (default 1h0m0s)
  -store.cardinality-limit int
        Cardinality limit for index queries. (default 100000)
  -store.fullsize-chunks
        When saving varbit chunks, pad to 1024 bytes (default true)
  -store.index-cache-read.cache.enable-diskcache
        Cache config for index entry reading. Enable on-disk cache.
  -store.index-cache-read.cache.enable-fifocache
        Cache config for index entry reading. Enable in-memory cache.
  -store.index-cache-read.default-validity duration
        Cache config for index entry reading. The default validity of entries for caches unless overridden.
  -store.index-cache-read.diskcache.path string
        Cache config for index entry reading. Path to file used to cache chunks. (default "/var/run/chunks")
  -store.index-cache-read.diskcache.size int
        Cache config for index entry reading. Size of file (bytes) (default 1073741824)
  -store.index-cache-read.fifocache.duration duration
        Cache config for index entry reading. The expiry duration for the cache.
  -store.index-cache-read.fifocache.size int
        Cache config for index entry reading. The number of entries to cache.
  -store.index-cache-read.memcache.write-back-buffer int
        Cache config for index entry reading. How many chunks to buffer for background write back. (default 10000)
  -store.index-cache-read.memcache.write-back-goroutines int
        Cache config for index entry reading. How many goroutines to use to write back to memcache. (default 10)
  -store.index-cache-read.memcached.batchsize int
        Cache config for index entry reading. How many keys to fetch in each batch.
  -store.index-cache-read.memcached.expiration duration
        Cache config for index entry reading. How long keys stay in the memcache.
  -store.index-cache-read.memcached.hostname string
        Cache config for index entry reading. Hostname for memcached service to use when caching chunks. If empty, no memcached will be used.
  -store.index-cache-read.memcached.max-idle-conns int
        Cache config for index entry reading. Maximum number of idle connections in pool. (default 16)
  -store.index-cache-read.memcached.parallelism int
        Cache config for index entry reading. Maximum active requests to memcache. (default 100)
  -store.index-cache-read.memcached.service string
        Cache config for index entry reading. SRV service used to discover memcache servers. (default "memcached")
  -store.index-cache-read.memcached.timeout duration
        Cache config for index entry reading. Maximum time to wait before giving up on memcached requests. (default 100ms)
  -store.index-cache-read.memcached.update-interval duration
        Cache config for index entry reading. Period with which to poll DNS for memcache servers. (default 1m0s)
  -store.index-cache-size int
        Deprecated: Use -store.index-cache-read.*; Size of in-memory index cache, 0 to disable.
  -store.index-cache-validity duration
        Cache validity for active index entries. Should be no higher than -ingester.max-chunk-idle. (default 5m0s)
  -store.index-cache-write.cache.enable-diskcache
        Cache config for index entry writing. Enable on-disk cache.
  -store.index-cache-write.cache.enable-fifocache
        Cache config for index entry writing. Enable in-memory cache.
  -store.index-cache-write.default-validity duration
        Cache config for index entry writing. The default validity of entries for caches unless overridden.
  -store.index-cache-write.diskcache.path string
        Cache config for index entry writing. Path to file used to cache chunks. (default "/var/run/chunks")
  -store.index-cache-write.diskcache.size int
        Cache config for index entry writing. Size of file (bytes) (default 1073741824)
  -store.index-cache-write.fifocache.duration duration
        Cache config for index entry writing. The expiry duration for the cache.
  -store.index-cache-write.fifocache.size int
        Cache config for index entry writing. The number of entries to cache.
  -store.index-cache-write.memcache.write-back-buffer int
        Cache config for index entry writing. How many chunks to buffer for background write back. (default 10000)
  -store.index-cache-write.memcache.write-back-goroutines int
        Cache config for index entry writing. How many goroutines to use to write back to memcache. (default 10)
  -store.index-cache-write.memcached.batchsize int
        Cache config for index entry writing. How many keys to fetch in each batch.
  -store.index-cache-write.memcached.expiration duration
        Cache config for index entry writing. How long keys stay in the memcache.
  -store.index-cache-write.memcached.hostname string
        Cache config for index entry writing. Hostname for memcached service to use when caching chunks. If empty, no memcached will be used.
  -store.index-cache-write.memcached.max-idle-conns int
        Cache config for index entry writing. Maximum number of idle connections in pool. (default 16)
  -store.index-cache-write.memcached.parallelism int
        Cache config for index entry writing. Maximum active requests to memcache. (default 100)
  -store.index-cache-write.memcached.service string
        Cache config for index entry writing. SRV service used to discover memcache servers. (default "memcached")
  -store.index-cache-write.memcached.timeout duration
        Cache config for index entry writing. Maximum time to wait before giving up on memcached requests. (default 100ms)
  -store.index-cache-write.memcached.update-interval duration
        Cache config for index entry writing. Period with which to poll DNS for memcache servers. (default 1m0s)
  -store.max-query-length duration
        Limit to length of chunk store queries, 0 to disable.
  -store.min-chunk-age duration
        Minimum time between chunk update and being saved to the store.
  -store.query-chunk-limit int
        Maximum number of chunks that can be fetched in a single query. (default 2000000)
  -validation.create-grace-period duration
        Duration which table will be created/deleted before/after it's needed; we won't accept sample from before this time. (default 10m0s)
  -validation.enforce-metric-name
        Enforce every sample has a metric name. (default true)
  -validation.max-label-names-per-series int
        Maximum number of label names per series. (default 30)
  -validation.max-length-label-name int
        Maximum length accepted for label names (default 1024)
  -validation.max-length-label-value int
        Maximum length accepted for label value. This setting also applies to the metric name (default 2048)
  -validation.reject-old-samples
        Reject old samples.
  -validation.reject-old-samples.max-age duration
        Maximum accepted sample age before rejecting. (default 336h0m0s)
```