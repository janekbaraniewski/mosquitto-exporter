PKG_NAME:=github.com/sapcc/mosquitto-exporter
BUILD_DOCKER_DIR:=/builds
MOSQUITTO_EXPORTER_DOCKER_PATH:=$(BUILD_DOCKER_DIR)/mosquitto_exporter
IMAGE := janekbaraniewski/mosquitto-exporter
VERSION=0.6.0
LDFLAGS=-s -w -X main.Version=$(VERSION) -X main.GITCOMMIT=`git rev-parse --short HEAD`
CGO_ENABLED=0
.PHONY: help
help:
	@echo
	@echo "Available targets:"
	@echo "  * build             - build the binary, output to $(ARC_BINARY)"
	@echo "  * linux             - build the binary, output to $(ARC_BINARY)"
	@echo "  * docker            - build docker image"

.PHONY: build

go.build:
	@mkdir -p $(BUILD_DOCKER_DIR)
	go build -o $(MOSQUITTO_EXPORTER_DOCKER_PATH) -ldflags="$(LDFLAGS)" $(PKG_NAME)

docker.release:
	docker buildx build \
		--no-cache \
		--build-arg \
		PKG_NAME=$(PKG_NAME) \
		--platform linux/amd64,linux/arm64,linux/arm/v6,linux/arm/v7 \
		--push \
		-t $(IMAGE):$(VERSION) .

docker:
	docker build -t $(IMAGE):$(VERSION) .

push:
	docker push $(IMAGE):$(VERSION)
