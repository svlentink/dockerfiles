FROM gettyimages/spark:2.0.2-hadoop-2.7

# https://developer.couchbase.com/documentation/server/4.5/connectors/spark-2.0/download-links.html
# https://spark-packages.org/package/couchbase/couchbase-spark-connector
RUN bin/spark-shell --packages com.couchbase.client:spark-connector_2.11:2.0.0

# http://www.scala-sbt.org/0.13/docs/Installing-sbt-on-Linux.html
RUN apt update \
  && apt install apt-transport-https net-tools -y \
  && echo "deb https://dl.bintray.com/sbt/debian /" >> /etc/apt/sources.list.d/sbt.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
  && apt update \
  && apt install sbt -y \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

#https://developer.couchbase.com/documentation/server/4.5/connectors/spark-2.0/getting-started.html
RUN mkdir /sbt \
  && cd /sbt \
  && echo 'libraryDependencies ++= Seq(\
    "org.apache.spark" %% "spark-core" % "2.0.1",\
    "org.apache.spark" %% "spark-streaming" % "2.0.1",\
    "org.apache.spark" %% "spark-sql" % "2.0.1",\
    "com.couchbase.client" %% "spark-connector" % "2.0.0"\
    )' > /sbt/build.sbt \
  && sbt --help # triggers the downloading of dependencies
