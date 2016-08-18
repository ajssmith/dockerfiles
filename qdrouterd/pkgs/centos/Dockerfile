FROM centos:latest

Maintainer Andy Smith "ansmith@redhat.com"

RUN yum -y install epel-release
RUN yum -y update
RUN yum -y install \
    qpid-dispatch-router \
    qpid-dispatch-tools

RUN mkdir /var/lib/qdrouterd

RUN echo secretqpid | saslpasswd2 -c -p -f /var/lib/qdrouterd/qdrouterd.sasldb stackqpid

COPY scripts/qdrouterd.conf /etc/qpid-dispatch

#ENTRYPOINT ["/usr/sbin/qdrouterd"]

