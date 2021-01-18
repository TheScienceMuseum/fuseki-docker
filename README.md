# fuseki-docker

Docker image for Apache Jena's [Fuseki](https://jena.apache.org/documentation/fuseki2/) triplestore server. Fork of [AtomGraph/fuseki-docker](https://github.com/AtomGraph/fuseki-docker)

## Usage (local)

### To build:

``` bash
docker build --no-cache . -t fuseki
```

### To run:

``` bash
docker run -p 3030:3030 fuseki
```

We use the `-d` and `--restart=always` flags to detach the Fuseki instance and make it automatically restart if the database crashes.

Help (all run options explained):

``` bash
docker run --rm fuseki --help
```

## Fuseki Endpoints

In the following examples which use `/ds` as the dataset path, these main endpoints are available:

* http://localhost:3030/ds/sparql for SPARQL Query
* http://localhost:3030/ds/update for SPARQL Update
* http://localhost:3030/ds/data for Graph Store (read-write)
* http://localhost:3030/ds/get for Graph Store (read-only)

They can be redefined in [configuration](https://jena.apache.org/documentation/fuseki2/fuseki-configuration.html#defining-the-service-name-and-endpoints-available).

Post 3030 has to be [mapped](https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose) to be able to access it on the Docker host.
