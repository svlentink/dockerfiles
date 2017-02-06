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
# https://spark.apache.org/docs/latest/security.html#configuring-ports-for-network-security
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

I'm still debugging which ports to 'expose' and which to 'ports'


Current ports found:
```shell
$ docker exec -it tmp_couchbase_1 bash
root@ebc53dcb54a2:/# netstat -tulpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:8091            0.0.0.0:*               LISTEN      -               
tcp        0      0 0.0.0.0:8092            0.0.0.0:*               LISTEN      -               
tcp        0      0 0.0.0.0:43389           0.0.0.0:*               LISTEN      -               
tcp        0      0 127.0.0.11:34405        0.0.0.0:*               LISTEN      -               
tcp        0      0 0.0.0.0:11207           0.0.0.0:*               LISTEN      -               
tcp        0      0 0.0.0.0:11209           0.0.0.0:*               LISTEN      -               
tcp        0      0 0.0.0.0:11210           0.0.0.0:*               LISTEN      -               
tcp        0      0 0.0.0.0:18091           0.0.0.0:*               LISTEN      -               
tcp        0      0 0.0.0.0:18092           0.0.0.0:*               LISTEN      -               
tcp        0      0 0.0.0.0:21100           0.0.0.0:*               LISTEN      -               
tcp        0      0 0.0.0.0:21101           0.0.0.0:*               LISTEN      -               
tcp        0      0 0.0.0.0:11214           0.0.0.0:*               LISTEN      -               
tcp        0      0 127.0.0.1:9998          0.0.0.0:*               LISTEN      -               
tcp        0      0 127.0.0.1:11215         0.0.0.0:*               LISTEN      -               
tcp        0      0 0.0.0.0:4369            0.0.0.0:*               LISTEN      -               
tcp6       0      0 :::11207                :::*                    LISTEN      -               
tcp6       0      0 :::11209                :::*                    LISTEN      -               
tcp6       0      0 :::11210                :::*                    LISTEN      -               
udp        0      0 127.0.0.11:54443        0.0.0.0:*                           -   
# and spark:
root@5d9bc587db4a:/usr/spark-2.0.2# netstat -tulpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.11:44541        0.0.0.0:*               LISTEN      -               
tcp6       0      0 172.28.0.3:7077         :::*                    LISTEN      1/java          
tcp6       0      0 :::8080                 :::*                    LISTEN      1/java          
tcp6       0      0 172.28.0.3:6066         :::*                    LISTEN      1/java          
udp        0      0 127.0.0.11:38303        0.0.0.0:*                           - 

```
Documentation about
[spark](https://spark.apache.org/docs/latest/security.html#configuring-ports-for-network-security)
ports and
[couchbase](https://developer.couchbase.com/documentation/server/current/install/install-ports.html) ports.