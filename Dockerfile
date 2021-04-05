FROM --platform=$BUILDPLATFORM golang:buster as builder
ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN apt update && apt install -y git tzdata ca-certificates

ARG PKG_NAME
COPY . $GOPATH/src/$PKG_NAME
WORKDIR $GOPATH/src/$PKG_NAME

RUN go mod init && go mod vendor
ARG opts
RUN env ${opts} GOOS=$(echo ${TARGETPLATFORM} | cut -d '/' -f1) GOARCH=$(echo ${TARGETPLATFORM} | cut -d '/' -f2) make go.build

FROM debian:stretch-slim
LABEL source_repository="https://github.com/sapcc/mosquitto-exporter"

RUN groupadd prom && \
    useradd -g prom prom

USER prom

COPY --from=builder --chown=prom:prom /builds/mosquitto_exporter /mosquitto_exporter
RUN chmod +x /mosquitto_exporter

EXPOSE 9234

ENTRYPOINT [ "/mosquitto_exporter" ]
