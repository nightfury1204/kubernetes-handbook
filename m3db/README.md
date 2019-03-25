# M3DB

``` 
https://github.com/m3db/m3db-operator
```

``` 
https://operator.m3db.io/
```

### Install operator

``` 
kubectl apply -f m3db/artifacts/m3db-operator.yaml
```

### Install etcd

```
kubectl apply -f m3db/artifacts/etcd-basic.yaml
```

Verify health 

```
kubectl exec -n demo etcd-0 -- env ETCDCTL_API=3 etcdctl endpoint health
```


