# Alertmanager

## Flags

``` 
Usage of cmd/alertmanager/alertmanager:
  -alertmanager.configs.auto-slack-root string
        Root of URL to generate if config is internal://monitor
  -alertmanager.configs.auto-webhook-root string
        Root of URL to generate if config is http://internal.monitor
  -alertmanager.configs.client-timeout duration
        Timeout for requests to Weave Cloud configs service. (default 5s)
  -alertmanager.configs.fallback string
        Filename of fallback config to use if none specified for instance.
  -alertmanager.configs.poll-interval duration
        How frequently to poll Cortex configs (default 15s)
  -alertmanager.configs.url value
        URL of configs API server.
  -alertmanager.mesh.hardware-address string
        MAC address, i.e. Mesh peer ID (default "90:2b:34:7f:db:b8")
  -alertmanager.mesh.listen-address string
        Mesh listen address (default "0.0.0.0:6783")
  -alertmanager.mesh.nickname string
        Mesh peer nickname (default "appscode")
  -alertmanager.mesh.password string
        Password to join the Mesh peer network (empty password disables encryption)
  -alertmanager.mesh.peer.host string
        Hostname for mesh peers.
  -alertmanager.mesh.peer.refresh-interval duration
        Period with which to poll DNS for mesh peers. (default 1m0s)
  -alertmanager.mesh.peer.service string
        SRV service used to discover peers. (default "mesh")
  -alertmanager.storage.path string
        Base path for data storage. (default "data/")
  -alertmanager.storage.retention duration
        How long to keep data for. (default 120h0m0s)
  -alertmanager.web.external-url value
        The URL under which Alertmanager is externally reachable (for example, if Alertmanager is served via a reverse proxy). Used for generating relative and absolute links back to Alertmanager itself. If the URL has a path portion, it will be used to prefix all HTTP endpoints served by Alertmanager. If omitted, relevant URL components will be derived automatically.
  -httptest.serve string
        if non-empty, httptest.NewServer serves on this address and blocks
  -log.level value
        Only log messages with the given severity or above. Valid levels: [debug, info, warn, error] (default info)
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