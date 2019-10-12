FROM debian:buster-slim

ENV DOVECOT_USER=dovecot
ENV DOVECOT_GROUP=dovecot
ENV DOVECOT_CONF_DIR=/usr/local/etc/dovecot
ENV DOVECOT_CONF_FILE=dovecot.conf

COPY start-dovecot.sh /usr/local/bin

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
        curl gnupg dirmngr ca-certificates \
        apt-transport-https && \
    curl https://repo.dovecot.org/DOVECOT-REPO-GPG | apt-key add - && \
    echo "deb https://repo.dovecot.org/ce-2.3-latest/debian/buster buster main" \
        > /etc/apt/sources.list.d/dovecot.list && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        dovecot-imapd dovecot-sieve \
        dovecot-lmtpd dovecot-managesieved && \
    apt-get clean && \
    chmod +x /usr/local/bin/start-dovecot.sh && \
    mkdir /usr/local/etc/dovecot/

VOLUME /usr/local/etc/dovecot/

CMD ["/usr/local/bin/start-dovecot.sh"]
