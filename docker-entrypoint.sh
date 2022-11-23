#!/bin/sh
set -e

if [ ! -f /frps/frps.ini ]; then
	cp /etc/frps/frps.ini /frps/frps.ini
fi

exec "$@"
