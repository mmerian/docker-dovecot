if [ ! -f "$DOVECOT_CONF_DIR/$DOVECOT_CONF_FILE" ]; then
    rm -rf $DOVECOT_CONF_DIR/*
    cp -r /etc/dovecot/* $DOVECOT_CONF_DIR

    echo >> $DOVECOT_CONF_DIR/conf.d/10-logging.conf
    echo 'log_path = /dev/stdout' >> $DOVECOT_CONF_DIR/conf.d/10-logging.conf
fi

if [ -d /etc/dovecot ]; then
    rm -rf /etc/dovecot
fi

/usr/sbin/dovecot -F -c $DOVECOT_CONF_DIR/$DOVECOT_CONF_FILE
