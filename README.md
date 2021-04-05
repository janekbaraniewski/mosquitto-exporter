Mosquitto Exporter
=============================

What's different in this fork:
---
- support for multiplatform builds
- multistage dockerfile build
- helm chart for k8s deployments

Docker images are available [here](https://hub.docker.com/repository/docker/janekbaraniewski/mosquitto-exporter)

---

Prometheus exporter for the [Mosquitto MQTT message broker](https://mosquitto.org/).

There is a docker image available:
```
docker run \
  -e BROKER_ENDPOINT=tcp://mosquitto:1883 \
  -p 9234:9234 sapcc/mosquitto-exporter
```

Usage:
======

```
NAME:
   Mosquitto exporter - Prometheus exporter for broker metrics

USAGE:
   bin/mosquitto_exporter [global options] command [command options] [arguments...]

VERSION:
   0.1 (78978f1), go1.7.4

AUTHOR(S):
   Arturo Reuschenbach Puncernau <a.reuschenbach.puncernau@sap.com> Fabian Ruff <fabian.ruff@sap.com>

COMMANDS:
   help, h	Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --endpoint, -e "tcp://127.0.0.1:1883"	Endpoint for the Mosquitto message broker [$BROKER_ENDPOINT]
   --bind-address, -b "0.0.0.0:9234"		Listen address for metrics HTTP endpoint [$BIND_ADDRESS]
   --help, -h					show help
   --version, -v				print the version

```
