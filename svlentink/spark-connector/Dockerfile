FROM gettyimages/spark:2.0.2-hadoop-2.7

# https://developer.couchbase.com/documentation/server/4.5/connectors/spark-2.0/download-links.html
# https://spark-packages.org/package/couchbase/couchbase-spark-connector
RUN bin/spark-shell --packages com.couchbase.client:spark-connector_2.11:2.0.0

# http://www.scala-sbt.org/0.13/docs/Installing-sbt-on-Linux.html
RUN apt update \
  && apt install apt-transport-https -y \
  && echo "deb https://dl.bintray.com/sbt/debian /" >> /etc/apt/sources.list.d/sbt.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
  && apt update \
  && apt install sbt -y \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

