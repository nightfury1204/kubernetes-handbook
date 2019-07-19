
## Alert manager 

### configs

- set config:
    - POST /alertmanager/api/v1/config
    - Need bearer token
    - need request body containing config
    ```json
    {
      "config": "{\n  \"global\": {\n    \"resolve_timeout\": \"5m\"\n  },\n  \"route\": {\n    \"group_by\": [\n      \"alertname\"\n    ],\n    \"group_wait\": \"10s\",\n    \"group_interval\": \"10s\",\n    \"repeat_interval\": \"5m\",\n    \"receiver\": \"web.hook\"\n  },\n  \"receivers\": [\n    {\n      \"name\": \"web.hook\",\n      \"webhook_configs\": [\n        {\n          \"url\": \"http://alert-webhook-0.alert-webhook.demo.svc:5001/\"\n        }\n      ]\n    }\n  ]\n}"
    }
    ```

- web api: GET /alertmanager/api/prom/alertmanager/#/alerts


- get config: 
    - GET /alertmanager/api/v1/config
    - Need bearer token
    
## Ruler

- set rule:
    - POST /ruler/api/v1/rules
    - Need bearer token
    - need res
    ```json
    {
      "id": "1122",
      "groups": [
        {
          "name": "alert",
          "rules": [
            {
              "alert": "alert",
              "expr": "alert_test > 10",
              "for": "1m",
              "labels": {
                "severity": "warning"
              },
              "annotations": {
                "summary": "Testing alert"
              }
            }
          ]
        }
      ]
    }
    ```
- get rules:
    - GET /ruler/api/v1/rules
    
