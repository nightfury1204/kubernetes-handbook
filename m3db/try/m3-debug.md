## make multi tenant m3coordinator

- only one unaggregated namespace allowed

- [About loadblance for m3cordition](https://github.com/m3db/m3/issues/1137)

- [Explicit multi-tenancy support](https://github.com/m3db/m3/issues/790)

- /home/ac/go/src/github.com/m3db/m3/src/query/server/server.go#550: can i cofigure `clusters`, `m3.Clusters` for namespace? 