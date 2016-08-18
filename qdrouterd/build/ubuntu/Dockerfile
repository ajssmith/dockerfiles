FROM ubuntu:latest

MAINTAINER Andy Smith "ansmith@redhat.com"

RUN apt-get update && apt-get -y install \
    gcc \
    cmake \
    cmake-curses-gui \
    uuid-dev \
    libssl-dev \
    libsasl2-2 \
    libsasl2-dev \
    sasl2-bin \
    swig \
    python-dev \
    ruby-dev \
    libperl-dev \
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

ENV PYTHONPATH=/usr/lib/python2.7/site-packages

RUN mkdir /var/lib/qdrouterd

COPY scripts/qdrouterd.conf /etc/qpid-dispatch

#ENTRYPOINT ["/usr/sbin/qdrouterd"]
