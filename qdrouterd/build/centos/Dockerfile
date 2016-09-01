FROM centos:latest

Maintainer Andy Smith "ansmith@redhat.com"

USER root

RUN yum -y update && yum -y install \
    gcc \
    cmake \
    libuuid-devel \
    openssl-devel \
    cyrus-sasl-devel \
    cyrus-sasl-plain \
    cyrus-sasl-gssapi \
    cyrus-sasl-md5 \
    swig python-devel \
    ruby-devel \
    php-devel \
    perl-devel \
    java-1.8.0-openjdk-devel \
    git \
    make \
    doxygen \
    valgrind 

RUN mkdir /main && \
    cd /main && \
    git clone https://github.com/apache/qpid-proton.git && \
    cd /main/qpid-proton && \
    mkdir /main/qpid-proton/build

WORKDIR /main/qpid-proton/build

RUN cmake .. -DSYSINSTALL_BINDINGS=ON -DCMAKE_INSTALL_PREFIX=/usr -DSYSINSTALL_PYTHON=ON && make install

RUN cd /main && \
    git clone https://github.com/apache/qpid-dispatch.git && \
    mkdir /main/qpid-dispatch/build

WORKDIR /main/qpid-dispatch/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/usr && make install

RUN mkdir /var/lib/qdrouterd

COPY scripts/qdrouterd.conf /etc/qpid-dispatch
COPY scripts/qdrouterd_sasl.conf /etc/sasl2/qdrouterd.conf

RUN echo secretqpid | saslpasswd2 -c -p -f /var/lib/qdrouterd/qdrouterd.sasldb stackqpid

#ENTRYPOINT ["/usr/sbin/qdrouterd"]
