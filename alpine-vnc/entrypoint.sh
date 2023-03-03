#!/bin/sh
#prepare sshd config
sudo mkdir -p /var/run/sshd
# generate host keys if not present
sudo ssh-keygen -A
sudo /usr/bin/supervisord -c /etc/supervisord.conf
