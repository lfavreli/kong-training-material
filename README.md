# Kong Training Material

## Prerequisites

* Docker installed - Should display the current Docker version

```bash
docker -v
```

* Existence of the `kong-net` network

```bash
docker network create --subnet=172.18.0.0/16 kong-net
```

* Existence of the `pgdata` and `esdata` volumes

```bash
docker volume create pgdata
docker volume create esdata
```

## Repository structure

✅ Develop custom plugin 🡆 Go to [./custom-plugin](/custom-plugin)

✅ Setup an ELK stack for logging 🡆 Go to [./elk-logging](/elk-logging)
