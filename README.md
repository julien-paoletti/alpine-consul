# alpine-consul
An alpine OS based docker container dedicated to Consul for service discovery

# Build container image

```shell
docker build -t jpao/consul:latest .
```

# Start one agent in server mode with ui (for test purpose)

```shell
docker run -d -p 192.168.99.100:8400:8400 -p 192.168.99.100:8500:8500 -p 192.168.99.100:8600:53/udp \
  -h consul-node --name consul jpao/consul:latest
docker logs consul
```

# Stop container

```shell
docker stop consul
```

# Starts registrator to automatically register docker containers within Consul
```shell
docker run -d \
    --name=registrator \
    --net=host \
    --volume=/var/run/docker.sock:/tmp/docker.sock \
    gliderlabs/registrator:latest \
      consul://192.168.99.100:8500
```
