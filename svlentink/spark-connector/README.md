# spark-connector

See [docker-compose.yml](https://github.com/svlentink/dockerfiles/blob/master/svlentink/spark-connector/docker-compose.yml)

## Links

https://developer.couchbase.com/documentation/server/4.6/connectors/spark-2.0/getting-started.html
https://developer.couchbase.com/documentation/server/4.6/connectors/spark-2.0/working-with-rdds.html
https://developer.couchbase.com/documentation/server/4.6/connectors/spark-2.0/dev-workflow.html
https://docs.databricks.com/spark/latest/data-sources/couchbase.html
=>register dataframes


## OLD info
The couchbase spark connector inside spark.


Documentation about
[spark](https://spark.apache.org/docs/latest/security.html#configuring-ports-for-network-security)
ports and
[couchbase](https://developer.couchbase.com/documentation/server/current/install/install-ports.html) ports.

To manually test the connection, curl from inside the Spark container run:

```shell
root@f6d95a48ae24:/usr/spark-2.0.2# curl -I http://couchbase:8091
HTTP/1.1 301 Moved Permanently
Server: Couchbase Server
```
