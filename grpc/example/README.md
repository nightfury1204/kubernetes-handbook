# Generate

``` 
protoc -I routeguide/ routeguide/route_guide.proto  --go_out=plugins=grpc:routeguide
```

Above code generate related code int `routeguide` directory.
