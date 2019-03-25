# Cortex

### Components:

- Distributor: distributes matrics to ingestor.

- Ingestor: store and samples matrics data.

- Querier: Does the query. merge query data from ingestor and permanent storage

- Query Frontent: Provides api for query.

- Alertmanager: provides alerting facility

- Ruler: process alert and recording rule

- configs: provides api endpoints to configure alertmanager and ruler



### Flow:

- Prometheus sends data to distributor using remote write. nginx works as reverse proxy to set org id and authentication.

- Distributor sends data to Ingestor. 

- Ingestor holds data for limited hour, then send it to storage

- Query frontend sends query to Querier.

- Querier performs the query.


 ![image](cortex/images/cortex-flow.png)
 

#### Alert

- Configs provides api to configure alermanager and ruler. data stored in prostgres.

- rule process rules and communicate with alertmanager

- Alert manager gives alert

** Configs **

Set configurations:

```
curl -X POST http://localhost:9001/api/prom/configs/alertmanager -H "X-Scope-OrgID: 0" -d @cortex/aws/extra/config.json
```

Get current configurations:

```
curl -X GET "http://localhost:9001/api/prom/configs/alertmanager" -H "X-Scope-OrgID: 0"
```

Deactivate :

```
curl -X DELETE "http://localhost:9001/api/prom/configs/deactivate" -H "X-Scope-OrgID: 0"
```

Restore:

``` 
curl -X POST "http://localhost:9001/api/prom/configs/restore" -H "X-Scope-OrgID: 0"
```

**Alermanager**

```
curl -X GET "http://localhost:9002/api/prom/alertmanager/api/v1/alerts" -H "X-Scope-OrgID: 0" 
```

```
curl -X GET "http://localhost:9002/api/prom/alertmanager/" -H "X-Scope-OrgID: 0"
```

### Others

- It user consul to serivce discovery. Stores hash ring info.

- It has table manager to create tables in dynamo db.

- It uses memcached for caching purpose.


### Links or docs

- https://docs.google.com/document/d/1C7yhMnb1x2sfeoe45f4mnnKConvroWhJ8KQZwIHJOuw/edit#heading=h.nimsq29kl184

- https://promcon.io/2016-berlin/talks/multitenant-scale-out-prometheus/

- https://www.youtube.com/watch?v=9Uctgnazfwk

- https://docs.google.com/document/d/1lsvSkv0tiAMPQv-V8vI2LZ8f4i9JuTRsuPI_i-XcAqY

- https://speakerdeck.com/grafana/cortex-horizontally-scalable-highly-available-prometheus-monitoring

- https://www.youtube.com/watch?v=iyN40FsRQEo
