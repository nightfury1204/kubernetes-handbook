# Query-frontend

### issues

- Query Frontend scalability: https://github.com/cortexproject/cortex/issues/1150
- Long query handling: https://github.com/cortexproject/cortex/issues/1148

### Flags

```
Usage of ./cmd/query-frontend/query-frontend:
  -cache.enable-diskcache
        Enable on-disk cache.
  -cache.enable-fifocache
        Enable in-memory cache.
  -default-validity duration
        The default validity of entries for caches unless overridden.
  -diskcache.path string
        Path to file used to cache chunks. (default "/var/run/chunks")
  -diskcache.size int
        Size of file (bytes) (default 1073741824)
  -fifocache.duration duration
        The expiry duration for the cache.
  -fifocache.size int
        The number of entries to cache.
  -frontend.max-cache-freshness duration
        Most recent allowed cacheable result, to prevent caching very recent results that might still be in flux. (default 1m0s)
  -httptest.serve string
        if non-empty, httptest.NewServer serves on this address and blocks
  -log.level value
        Only log messages with the given severity or above. Valid levels: [debug, info, warn, error] (default info)
  -memcache.write-back-buffer int
        How many chunks to buffer for background write back. (default 10000)
  -memcache.write-back-goroutines int
        How many goroutines to use to write back to memcache. (default 10)
  -memcached.batchsize int
        How many keys to fetch in each batch.
  -memcached.expiration duration
        How long keys stay in the memcache.
  -memcached.hostname string
        Hostname for memcached service to use when caching chunks. If empty, no memcached will be used.
  -memcached.max-idle-conns int
        Maximum number of idle connections in pool. (default 16)
  -memcached.parallelism int
        Maximum active requests to memcache. (default 100)
  -memcached.service string
        SRV service used to discover memcache servers. (default "memcached")
  -memcached.timeout duration
        Maximum time to wait before giving up on memcached requests. (default 100ms)
  -memcached.update-interval duration
        Period with which to poll DNS for memcache servers. (default 1m0s)
  -querier.align-querier-with-step
        Mutate incoming queries to align their start and end with their step.
  -querier.cache-results
        Cache query results.
  -querier.max-outstanding-requests-per-tenant int
        Maximum number of outstanding requests per tenant per frontend; requests beyond this error with HTTP 429. (default 100)
  -querier.max-retries-per-request int
        Maximum number of retries for a single request; beyond this, the downstream error is returned. (default 5)
  -querier.split-queries-by-day
        Split queries by day and execute in parallel.
  -query-frontend.max-recv-message-size-bytes int
        Limit on the size of a grpc message this server can receive. (default 67108864)
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

```