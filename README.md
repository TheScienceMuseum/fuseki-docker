# fuseki-docker

fork of [AtomGraph/fuseki-docker](https://github.com/AtomGraph/fuseki-docker)

## Usage (local)

### To build:

``` bash
docker build . -t fuseki
```

### To run:

Dataset from file `data.nt` (which is mounted as part of the current directory), with dataset path `/ds`:

``` bash
docker run --rm -p 3030:3030 -v $(pwd):/usr/share/data fuseki --file=/usr/share/data/data.nt /ds
```

Help (all run options explained):

``` bash
docker run --rm fuseki --help
```

## Endpoints

In the following examples which use `/ds` as the dataset path, these main endpoints are available:

* http://localhost:3030/ds/sparql for SPARQL Query
* http://localhost:3030/ds/update for SPARQL Update
* http://localhost:3030/ds/data for Graph Store (read-write)
* http://localhost:3030/ds/get for Graph Store (read-only)

They can be redefined in [configuration](https://jena.apache.org/documentation/fuseki2/fuseki-configuration.html#defining-the-service-name-and-endpoints-available).

Post 3030 has to be [mapped](https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose) to be able to access it on the Docker host.
