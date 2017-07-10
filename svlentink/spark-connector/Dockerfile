FROM gettyimages/spark:2.0.2-hadoop-2.7

# undo last two steps of base container
# we don not want SPARK_PACKAGE .... 'bin-without-hadoop' but 'bin-hadoopVERSION''
RUN rm -rf $HADOOP_HOME
RUN rm -rf $SPARK_HOME
# HADOOP
ENV HADOOP_VERSION 2.7
ENV HADOOP_HOME /usr/hadoop-$HADOOP_VERSION
# SPARK
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}
ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
RUN curl -sL --retry 3 \
  "http://d3kbcqa49mib13.cloudfront.net/${SPARK_PACKAGE}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
 && mv /usr/$SPARK_PACKAGE $SPARK_HOME \
 && chown -R root:root $SPARK_HOME


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

#start Spark
CMD bash -c "$SPARK_HOME/sbin/start-master.sh && $SPARK_HOME/sbin/start-thriftserver.sh && tail -f /var/log/lastlog"
