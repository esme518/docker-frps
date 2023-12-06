#
# Dockerfile for frps
#

FROM alpine as source

ARG URL=https://api.github.com/repos/fatedier/frp/releases/latest

WORKDIR /root

RUN set -ex \
    && if [ "$(uname -m)" == aarch64 ]; then \
           export PLATFORM='linux_arm64'; \
       elif [ "$(uname -m)" == x86_64 ]; then \
           export PLATFORM='linux_amd64'; \
       fi \
    && apk add --update --no-cache curl \
    && wget -O frp.tar.gz $(curl -s $URL | grep browser_download_url | egrep -o 'http.+\.tar.gz' | grep -i "$PLATFORM") \
    && tar xvf frp.tar.gz --strip-components 1

FROM alpine
COPY --from=source /root/frps /usr/local/bin/frps
COPY --from=source /root/frps.toml /etc/frps/frps.toml

COPY docker-entrypoint.sh /entrypoint.sh

RUN set -ex \
    && apk --update add --no-cache \
       ca-certificates \
    && rm -rf /tmp/* /var/cache/apk/*

WORKDIR /frps

EXPOSE 7000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["frps","-c","/frps/frps.toml"]
