# spark-connector

See [docker-compose.yml](https://github.com/svlentink/dockerfiles/blob/master/svlentink/spark-connector/docker-compose.yml)

## OLD info
The couchbase spark connector inside spark.

How to
[configure](https://developer.couchbase.com/documentation/server/4.5/connectors/spark-2.0/getting-started.html)
Spark:
```java
// Configure Spark
val spark = SparkSession
      .builder()
      .appName("KeyValueExample")
      .master("local[*]") // use the JVM as the master, great for testing
      .config("spark.couchbase.nodes", "couchbase") // connect to couchbase via docker links
      .config("spark.couchbase.bucket.travel-sample", "") // open the travel-sample bucket with empty password
      .getOrCreate()

// The SparkContext for easy access
val sc = spark.sparkContext
```

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