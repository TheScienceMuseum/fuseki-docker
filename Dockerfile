# Basic Fuseki Dockerfile.

# java
FROM java:8-jdk

LABEL maintainer="The Apache Jena community <users@jena.apache.org>"

ARG VERSION=3.16.0

# data
ENV DATA_URL=https://github.com/TheScienceMuseum/heritage-connector-data/blob/main/rdf/hc_dump_latest.nt\?raw\=true
ENV DATA_FILE=/mnt/heritageconnector.nt
RUN curl -L $DATA_URL > $DATA_FILE

# fuseki
ENV URL=https://repository.apache.org/content/repositories/releases/org/apache/jena/jena-fuseki-server/${VERSION}/jena-fuseki-server-${VERSION}.jar
ENV BASE=/mnt/apache-fuseki

RUN mkdir -p $BASE

WORKDIR $BASE

RUN curl --silent --show-error --output fuseki-server.jar $URL

EXPOSE 3030

ENTRYPOINT [ "/usr/bin/java", "-Xms2g" ,"-Xmx8g", "-XX:-UseGCOverheadLimit", "-XX:+UseParallelGC", "-jar", "fuseki-server.jar", "-v", "--debug", "--file=/mnt/heritageconnector.nt", "/heritage-connector"]