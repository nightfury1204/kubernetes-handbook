# Distributor


### Flags

```
  -billing.ingester string
        points to the billing ingester sidecar (should be on localhost) (default "localhost:24225")
  -billing.max-buffered-events int
        Maximum number of billing events to buffer in memory (default 1024)
  -billing.retry-delay duration
        How often to retry sending events to the billing ingester. (default 500ms)
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
  -distributor.client-cleanup-period duration
        How frequently to clean up clients for ingesters that have gone away. (default 15s)
  -distributor.compress-to-ingester
        DEPRECATED. Compress data in calls to ingesters. (DEPRECATED: use ingester.client.compress-to-ingester instead
  -distributor.enable-billing
        Report number of ingested samples to billing system.
  -distributor.extra-query-delay duration
        Time to wait before sending more than the minimum successful query requests.
  -distributor.health-check-ingesters
        Run a health check on each ingester client during periodic cleanup.
  -distributor.ingestion-burst-size int
        Per-user allowed ingestion burst size (in number of samples). Warning, very high limits will be reset every -distributor.limiter-reload-period. (default 50000)
  -distributor.ingestion-rate-limit float
        Per-user ingestion rate limit in samples per second. (default 25000)
  -distributor.limiter-reload-period duration
        Period at which to reload user ingestion limits. (default 5m0s)
  -distributor.remote-timeout duration
        Timeout for downstream ingesters. (default 2s)
  -distributor.replication-factor int
        The number of ingesters to write to and read from. (default 3)
  -distributor.shard-by-all-labels
        Distribute samples based on all labels, as opposed to solely by user and metric name.
  -httptest.serve string
        if non-empty, httptest.NewServer serves on this address and blocks
  -ingester-client.expected-labels int
        Expected number of labels per timeseries, used for preallocations. (default 20)
  -ingester-client.expected-samples-per-series int
        Expected number of samples per timeseries, used for preallocations. (default 10)
  -ingester-client.expected-timeseries int
        Expected number of timeseries per request, use for preallocations. (default 100)
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
  -ingester.max-samples-per-query int
        The maximum number of samples that a query can return. (default 1000000)
  -ingester.max-series-per-metric int
        Maximum number of active series per metric name. (default 50000)
  -ingester.max-series-per-query int
        The maximum number of series that a query can return. (default 100000)
  -ingester.max-series-per-user int
        Maximum number of active series per user. (default 5000000)
  -limits.per-user-override-config string
        File name of per-user overrides.
  -limits.per-user-override-period duration
        Period with this to reload the overrides. (default 10s)
  -log.level value
        Only log messages with the given severity or above. Valid levels: [debug, info, warn, error] (default info)
  -ring.heartbeat-timeout duration
        The heartbeat timeout after which ingesters are skipped for reads/writes. (default 1m0s)
  -ring.store string
        Backend storage to use for the ring (consul, inmemory). (default "consul")
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
  -store.max-query-length duration
        Limit to length of chunk store queries, 0 to disable.
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