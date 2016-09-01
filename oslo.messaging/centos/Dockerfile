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
#remove following when setup script is merged
RUN cd /main/oslo.messaging && git fetch https://git.openstack.org/openstack/oslo.messaging refs/changes/18/361418/3 && git checkout FETCH_HEAD

#WORKDIR /main/oslo.messaging

#RUN tox -epy27 -- oslo_messaging.tests.drivers.test_amqp_driver

#CMD ["/bin/bash"]
