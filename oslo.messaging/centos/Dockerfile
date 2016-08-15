FROM centos:latest

MAINTAINER Andy Smith "ansmith@redhat.com"

RUN yum -y install epel-release

RUN yum -y group install "Development Tools"

Run yum -y install \
    python-pip \
    python-wheel \
    python-tox \
    libffi-devel

RUN pip install --upgrade \
    setuptools \
    tox \
    cffi

RUN mkdir /main && cd /main && git clone https://git.openstack.org/openstack/oslo.messaging

WORKDIR /main/oslo.messaging

RUN tox -epy27 -- oslo_messaging.tests.drivers.test_amqp_driver

CMD ["/bin/bash"]
