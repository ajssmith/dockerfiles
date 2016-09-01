FROM ubuntu:trusty

MAINTAINER Andy Smith "ansmith@redhat.com"

RUN apt-get update && apt-get -y install \
    software-properties-common \
    python-software-properties \
    sasl2-bin

RUN add-apt-repository -y ppa:qpid/testing && apt-get update

RUN apt-get install -y \
    qdrouterd \
    qdmanage

RUN mkdir /var/lib/qdrouterd

COPY scripts/qdrouterd.conf /etc/qpid-dispatch/
COPY scripts/qdrouterd_sasl.conf /etc/sasl2/qdrouterd.conf

RUN echo secretqpid | saslpasswd2 -c -p -f /var/lib/qdrouterd/qdrouterd.sasldb stackqpid

#ENTRYPOINT ["/usr/sbin/qdrouterd"]
