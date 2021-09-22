# Basic Fuseki Dockerfile.

# java
FROM java:8-jdk

LABEL maintainer="The Apache Jena community <users@jena.apache.org>"

ARG VERSION=3.16.0

# data
ENV DATA_URL=https://heritageconnector.s3.eu-west-2.amazonaws.com/rdf/hc_dump_latest.nt
ENV DATA_FILE=/mnt/heritageconnector.nt
RUN curl -L $DATA_URL > $DATA_FILE

# jena - build TDB database
ENV TDB_LOC=/mnt/tdb_db
ENV JENA_URL = https://repository.apache.org/content/repositories/releases/org/apache/jena/apache-jena/${VERSION}/apache-jena-${VERSION}.tar.gz
RUN curl -L $JENA_URL > apache-jena.tar.gz
RUN tar -xvzf apache-jena.tar.gz
RUN apache-jena-${VERSION}/bin/tdbloader2 --loc $TDB_LOC $DATA_FILE

# fuseki
ENV URL=https://repository.apache.org/content/repositories/releases/org/apache/jena/jena-fuseki-server/${VERSION}/jena-fuseki-server-${VERSION}.jar
ENV BASE=/mnt/apache-fuseki

RUN mkdir -p $BASE

WORKDIR $BASE

RUN curl --silent --show-error --output fuseki-server.jar $URL

EXPOSE 3030

#ENTRYPOINT [ "/usr/bin/java", "-Xms4g" ,"-Xmx8g", "-XX:-UseGCOverheadLimit", "-XX:+UseParallelGC", "-jar", "fuseki-server.jar", "-v", "--debug", "--file=/mnt/heritageconnector.nt", "/heritage-connector"]
ENTRYPOINT [ "/usr/bin/java", "-Xms4g" ,"-Xmx8g", "-XX:-UseGCOverheadLimit", "-XX:+UseParallelGC", "-jar", "fuseki-server.jar", "--loc=/mnt/tdb_db", "/heritage-connector"]
