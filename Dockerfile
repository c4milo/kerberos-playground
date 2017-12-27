# This Dockerfile was written based on documentation from
# https://help.ubuntu.com/community/Kerberos

FROM ubuntu:16.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
            vim \
            apache2 \
            python3 \
            python3-pip \
            libapache2-mod-auth-kerb \
            krb5-kdc \
            krb5-admin-server

RUN apt-get install -y \
        libkrb5-dev \
        net-tools \
    &&  pip3 install \
        requests-kerberos

# Server configuration
COPY kadm5.acl /etc/krb5kdc/kadm5.acl
COPY kdc.conf /etc/krb5kdc/kdc.conf

# Client configuration
COPY krb5.conf /etc/krb5.conf

# Initialize Kerberos database
RUN kdb5_util create -s -P test

# Create principal for HTTP service on ENIGMA.COM reand generate its keytab
RUN mkdir -p /etc/apache2/auth \
    && kadmin.local -q "addprinc -randkey HTTP/files.enigma.com" \
    && kadmin.local -q "ktadd -k /etc/apache2/auth/apache2.keytab HTTP/files.enigma.com"

# Create principal for INGESTION service on ENIGMA.COM realm
RUN kadmin.local -q "addprinc -randkey INGESTION/asm.enigma.com"

# INGESTION keytab is generated from docker-compose
# RUN kadmin.local -q "ktadd -k /var/lib/ingestion/ingestion.keytab INGESTION/asm.enigma.com"

RUN chown www-data:www-data /etc/apache2/auth/apache2.keytab \
    && chmod 400 /etc/apache2/auth/apache2.keytab

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && echo "ErrorLog /dev/stderr" >> /etc/apache2/apache2.conf \
    && echo "TransferLog /dev/stdout" >> /etc/apache2/apache2.conf

COPY vhost.conf /etc/apache2/sites-enabled/00-default.conf

# Key Distribution Center server
CMD ["/usr/sbin/krb5kdc", "-n"]
