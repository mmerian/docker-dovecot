#!/bin/bash

# Copy default config to config dir
if [ ! "$(ls -A /etc/dovecot)" ]; then
    echo "Initializing dovecot configuration"
    cp -r /orig/etc/dovecot/* /etc/dovecot

    echo >> /etc/dovecot/conf.d/10-logging.conf
    echo 'log_path = /dev/stdout' >> /etc/dovecot/conf.d/10-logging.conf
fi

if [ ! -z "$PRE_EXEC"  ] && [ -x "$PRE_EXEC" ]; then
    echo "Executing pre-exec $PRE_EXEC"
    $PRE_EXEC
fi

# Start dovecot
echo "Starting dovecot"
/usr/sbin/dovecot -F -c /etc/dovecot/dovecot.conf
