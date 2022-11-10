#
# Dockerfile for frps
#

FROM alpine:latest

ARG FRP_VER="0.45.0"
ENV FRP_URL=https://github.com/fatedier/frp/releases/download/v${FRP_VER}/frp_${FRP_VER}_
ENV FRP_DIR=frp_${FRP_VER}_

WORKDIR /etc/frps

RUN set -ex \
    && if [ "$(uname -m)" == aarch64 ]; then \
           export PLATFORM='linux_arm64'; \
       elif [ "$(uname -m)" == x86_64 ]; then \
           export PLATFORM='linux_amd64'; \
       fi \
    && export FRP_URL=${FRP_URL}${PLATFORM}.tar.gz \
    && export FRP_DIR=${FRP_DIR}${PLATFORM} \
    && apk add --update --no-cache curl \
    && curl -sSL $FRP_URL | tar xz \
    && mv $FRP_DIR/frps /etc/frps/ \
    && mv $FRP_DIR/frps.ini /etc/frps/ \
    && rm -rf $FRP_DIR \
    && rm -rf /tmp/* /var/cache/apk/*

ENV PATH /etc/frps:$PATH

EXPOSE 7000

CMD ["frps"]
