#
# Dockerfile for frps
#

FROM alpine:latest

ARG FRP_VER 0.32.1
ARG FRP_URL https://github.com/fatedier/frp/releases/download/v${FRP_VER}/frp_${FRP_VER}_linux_amd64.tar.gz
ARG FRP_DIR frp_${FRP_VER}_linux_amd64

WORKDIR /etc/frps

RUN set -ex \
    && apk --update add --no-cache curl \
    && curl -sSL $FRP_URL | tar xz \
    && cd $FRP_DIR \
    && mv frps /etc/frps/ \
    && mv frps.ini  /etc/frps/ \
    && cd .. \
    && rm -rf $FRP_DIR \
    && apk del curl \
    && rm -rf /var/cache/apk

ENV PATH /etc/frps:$PATH

EXPOSE 7000

CMD ["frps"]
