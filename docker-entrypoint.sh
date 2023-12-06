#!/bin/sh
set -e

if [ ! -f /frps/frps.toml ]; then
	cp /etc/frps/frps.toml /frps/frps.toml
fi

exec "$@"
