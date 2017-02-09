# spark-connector

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

Example of `docker-compose.yml`

```yaml
version: '2'
services:
  couchbase:
    image: couchbase
    ports:
      - "8091-8094:8091-8094" # Couchbase Web Console and some REST ports
      - "11210:11210" # Used by smart client libraries or Moxi to directly connect to the data nodes. The XDCR client uses this port as well as the SDKs. This is a memcached port.
    volumes:
      - "/opt/couchbase/var:/opt/couchbase/var"
  spark:
    image: svlentink/spark-connector
    ports:
      - "8080-8081:8080-8081" # WebUI Master and Worker
      - "7077:7077" # Submit job to cluster / Join cluster
      - "6066:6066" # Master Spark REST URL
    depends_on:
      - couchbase
    links:
      - couchbase
      - couchbase:couchbase

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