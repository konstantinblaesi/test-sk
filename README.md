## Containerized Production Build

`podman` and `docker` can be used interchangeably

### Building the container

`podman build -t test-sk -f Containerfile .`

### Running the container

`podman run --rm -it -p 3000:3000 --name test-sk test-sk:latest`

### Accessing the container

http://localhost:3000

### Stopping the container

`podman stop test-sk`