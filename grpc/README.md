
# What is GRPC
If I simplify GRPC, then it is data serialization format (like JSON or XML) + http/2 server (like Apache Tomcat for example). In Java terminology, We still have the implement the "Servlets" (grpc services) to do the server side things. The auto generated native client codes are a nice bonus.

# Documentation

## Protocol Buffer v3
- https://developers.google.com/protocol-buffers/docs/overview
- https://developers.google.com/protocol-buffers/docs/proto3
- https://developers.google.com/protocol-buffers/docs/techniques
- https://developers.google.com/protocol-buffers/docs/javatutorial

# GRPC
- http://www.grpc.io/docs/
- http://www.grpc.io/docs/guides/concepts.html
- http://www.grpc.io/docs/guides/auth.html
## GO:
- http://www.grpc.io/docs/installation/go.html
- http://www.grpc.io/docs/tutorials/basic/go.html
## Java:
- http://www.grpc.io/docs/tutorials/basic/java.html
- Example Google API definitions:
- https://github.com/google/googleapis/tree/master/google

## Go GRPC Quick Start
```
$ sudo apt-get update
$ sudo apt-get install curl unzip git build-essential automake libtool

# install protobuf v3 compiler
$ mkdir -p ~/AppsCode/Source/grpc
$ cd ~/AppsCode/Source/grpc
$ git clone https://github.com/google/protobuf.git
$ cd protobuf/
$ git checkout tags/v3.5.1

$ ./autogen.sh
$ ./configure
$ make
$ make check
$ sudo make install
$ sudo ldconfig

If the installation process is successful, the following command should return protoc version.
$ protoc --version
libprotoc 3.5.1



# install the protoc Go plugin
$ go get -u github.com/golang/protobuf/protoc-gen-go

# get the example
$ go get -u google.golang.org/grpc


$ go get -u google.golang.org/grpc/examples/helloworld/greeter_client
$ go get -u google.golang.org/grpc/examples/helloworld/greeter_server

# generate go code from .proto file
# from the examples/helloworld dir; invoke protoc

$ cd $GOPATH/src/google.golang.org/grpc/examples/helloworld/
$ protoc -I helloworld helloworld/helloworld.proto --go_out=plugins=grpc:helloworld


Run the server sh $ greeter_server &

Run the client sh $ greeter_client
Cd 
View source $ subl $GOPATH/src/google.golang.org/grpc/examples
```

## GOGO protobuf

```
$ rm -rf ~/go/src/github.com/gogo
$ go get -u github.com/gogo/protobuf
```



## GRPC PHP Example
```
https://github.com/grpc/grpc/tree/master/src/php

$ git clone -b $(curl -L http://grpc.io/release) https://github.com/grpc/grpc

$ git clone https://github.com/grpc/grpc
$ cd grpc
$ git submodule update --init
$ make
$ [sudo] make install
```

### GRPC Python Example
```
http://www.grpc.io/docs/quickstart/python.html 

pip install grpcio-tools
```




https://bitbucket.org/appscode/api/branch/testGRPC#diff
https://github.com/grpc/grpc/tree/master/src/php
If you just want to write a client, you need 3 things:
sudo pecl install grpc
Add composer dependency on datto/protobuf-php
Copy lib/Grpc php library using composer
Now write your client code
If you want to generate PHO files, you need:
Install protoc (skip if already done for GO).
sudo pecl install grpc-beta
Install protoc-gen-php 
$ git clone https://github.com/grpc/grpc.git
$ cd grpc/src/php
$ composer install
$ cd vendor/datto/protobuf-php
$ gem install rake ronn
$ rake pear:package version=1.0
$ sudo pear install Protobuf-1.0.tgz
You can find a working code generation command in api repo.

GRPC-Gateway 
https://github.com/gengo/grpc-gateway

Google provided spec for proto rpcs to HTTP JSON REST https://github.com/google/googleapis/tree/master/google/api

# install grpc-gateway
$ go get -u github.com/gengo/grpc-gateway/protoc-gen-grpc-gateway
gRPC
Development Workflow
The workflow looks like this:

Write the *.proto files. In the proto files you define the messages (C struct-like) and rpc service (Java interface like).

Use protoc (protocol buffer compiler) to generate the server interfaces and client stubs.

Implement the server interfaces.

That's it.

If we want to access this api from Web Browser (JS ajax call) or from an http 1.1 client, we need to decorate the grpc protos and generate the reverse proxy using grpc-gateway. (this looks options for kube-dashboard and cli at this point. We will need this if the dashboard wants to access this api from browser).

The Protocol v3 also supports JSON or YAML text serialization natively. We should use it for any data objects.

