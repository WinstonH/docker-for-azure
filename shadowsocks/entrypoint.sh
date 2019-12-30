#!/bin/sh
# prepare nginx
mkdir -p /run/nginx/
# prepare sshd config
mkdir -p /var/run/sshd
# generate host keys if not present
ssh-keygen -A

nginx
/usr/bin/supervisord -c /etc/supervisord.conf
exec "$@"