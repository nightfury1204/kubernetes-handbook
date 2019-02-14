# Cortex

Set up cortex:

```commandline
kubectl apply -f cortex/yamls/
```

Set up prometheus:

```commandline
kubectl apply -f cortex/prometheus/
```

Query:

```
http://192.168.99.100:30080/api/prom/api/v1/query?query=up
```
