FROM debian:bullseye-slim

ENV DOVECOT_USER=dovecot
ENV DOVECOT_GROUP=dovecot

COPY start-dovecot.sh /usr/local/bin

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
        curl gnupg dirmngr ca-certificates \
        apt-transport-https && \
    curl https://repo.dovecot.org/DOVECOT-REPO-GPG | apt-key add - && \
    echo "deb https://repo.dovecot.org/ce-2.3-latest/debian/bullseye bullseye main" \
        > /etc/apt/sources.list.d/dovecot.list && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        dovecot-imapd dovecot-sieve \
        dovecot-lmtpd dovecot-managesieved \
        dovecot-lucene curl && \
    apt-get clean && \
    chmod +x /usr/local/bin/start-dovecot.sh

RUN mkdir -p /orig/etc && \
    cp -r /etc/dovecot /orig/etc

VOLUME /etc/dovecot

CMD ["/usr/local/bin/start-dovecot.sh"]
