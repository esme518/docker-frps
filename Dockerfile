#
# Dockerfile for frps
#

FROM alpine:3.8

ENV FRP_VER 0.27.1
ENV FRP_URL https://github.com/fatedier/frp/releases/download/v${FRP_VER}/frp_${FRP_VER}_linux_amd64.tar.gz
ENV FRP_DIR frp_${FRP_VER}_linux_amd64

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

EXPOSE 7000/tcp

CMD ["frps"]
