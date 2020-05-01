#!/bin/bash

# Copy default config to config dir
if [ ! "$(ls -A /etc/dovecot)" ]; then
    echo "Initializing dovecot configuration"
    cp -r /orig/etc/dovecot/* /etc/dovecot

    echo >> /etc/dovecot/conf.d/10-logging.conf
    echo 'log_path = /dev/stdout' >> /etc/dovecot/conf.d/10-logging.conf
fi

/usr/sbin/dovecot -F -c /etc/dovecot/dovecot.conf
