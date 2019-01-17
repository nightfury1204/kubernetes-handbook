# Helm

https://docs.helm.sh/

```commandline
kubectl create ns demo
```

```commandline
kubectl create serviceaccount demo-sa -n demo
```

```commandline
helm init --tiller-namespace=demo --service-account=demo-sa
```

```commandline
$ helm version --tiller-namespace demo

Client: &version.Version{SemVer:"v2.12.1", GitCommit:"02a47c7249b1fc6d8fd3b94e6b4babf9d818144e", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.12.1", GitCommit:"02a47c7249b1fc6d8fd3b94e6b4babf9d818144e", GitTreeState:"clean"}
```

```commandline
$ helm search mysql

NAME                            	CHART VERSION	APP VERSION	DESCRIPTION                                                 
stable/mysql                    	0.12.0       	5.7.14     	Fast, reliable, scalable, and easy to use open-source rel...
stable/mysqldump                	2.0.0        	2.0.0      	A Helm chart to help backup MySQL databases using mysqldump 
stable/prometheus-mysql-exporter	0.2.1        	v0.11.0    	A Helm chart for prometheus mysql exporter with cloudsqlp...
stable/percona                  	0.3.4        	5.7.17     	free, fully compatible, enhanced, open source drop-in rep...
stable/percona-xtradb-cluster   	0.6.1        	5.7.19     	free, fully compatible, enhanced, open source drop-in rep...
stable/phpmyadmin               	2.0.2        	4.8.4      	phpMyAdmin is an mysql administration frontend              
stable/gcloud-sqlproxy          	0.6.1        	1.11       	DEPRECATED Google Cloud SQL Proxy                           
stable/mariadb                  	5.3.1        	10.1.37    	Fast, reliable, scalable, and easy to use open-source rel...

```

```commandline
helm install stable/mysql --name try --tiller-namespace demo
```

```commandline
 helm install stable/mysql --name try --tiller-namespace demo
```

```commandline
helm get values try --tiller-namespace demo
```

```commandline
helm delete try --tiller-namespace demo
```

```commandline
helm upgrade -f panda.yaml happy-panda stable/mariadb
```

```yaml
$ helm history try --tiller-namespace demo

REVISION	UPDATED                 	STATUS 	CHART       	DESCRIPTION      
1       	Mon Jan 14 17:34:04 2019	DELETED	mysql-0.12.0	Deletion complete

```

```commandline
helm rollback try 1 --tiller-namespace demo
```

```commandline
$ helm list --tiller-namespace demo
NAME	REVISION	UPDATED                 	STATUS  	CHART       	APP VERSION	NAMESPACE
try 	2       	Mon Jan 14 17:56:40 2019	DEPLOYED	mysql-0.12.0	5.7.14     	default
```

```commandline
$ helm list --deleted --tiller-namespace demo

NAME	REVISION	UPDATED                 	STATUS 	CHART       	APP VERSION	NAMESPACE
try 	2       	Mon Jan 14 17:56:40 2019	DELETED	mysql-0.12.0	5.7.14     	default
```


## How to create helm chart

```commandline
helm create mychart
```

```commandline
helm package helm/chart/mychart
```

```commandline
helm lint helm/chart/mychart
```

```commandline
helm install ./mychart-0.1.0.tgz --name busybox
```

```commandline
helm install ./mychart-0.1.0.tgz --name busybox --set echo="no world"
```

```commandline
helm get values busybox
```

it also clear it from the `helm list`
```commandline
helm delete busybox --purge
```