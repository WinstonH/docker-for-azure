#!/bin/sh
#prepare sshd config
sudo mkdir -p /var/run/sshd
# generate host keys if not present
sudo ssh-keygen -A
#prepare xauth
sudo touch /root/.Xauthority

sudo /usr/bin/supervisord -c /etc/supervisord.conf
exec "$@"
