# spark-connector

The couchbase spark connector inside spark.

Example of `docker-compose.yml`

```yaml
version: '2'
services:
  couchbase:
    image: couchbase
    ports:
      - "8091-8094:8091-8094"
      - "11210:11210"
    container_name: 'db'
#    volumes:
#      - "/opt/couchbase/var:/opt/couchbase/var"
  spark:
    image: svlentink/spark-connector
    ports:
      - "7077:7077"
      - "6066:6066"
    depends_on:
      - couchbase
    links:
      - couchbase:db
#    volumes:
#      - $PWD/Quickstart.scala:/tmp/src/main/scala/Quickstart.scala:ro
#      - $PWD/build.sbt:/tmp/build.sbt:ro
#    command: sbt
```