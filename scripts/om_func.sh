#!/bin/bash -ex
#

# must be run from top level directory for context
BE_NW=$(docker network create -d bridge --subnet 172.25.0.0/16 be_nw)

RTR_IMG=$(docker build -f qdrouterd/$BORP/$OS/Dockerfile . | tail -1 | awk '{print $NF }')
OM_IMG=$(docker build -f oslo.messaging/$OS/Dockerfile . | tail -1 | awk '{print $NF }')

RTR_CNTR=$(docker run --net=be_nw --ip=172.25.1.2 -d $RTR_IMG /bin/bash -c '/usr/sbin/qdrouterd')
#OM_CNTR=$(docker run --net=be_nw --ip=172.25.1.3 -d $OM_IMG /bin/bash -c 'cd /main/oslo.messaging && tox -epy27 --notest && source .tox/py27/bin/activate && export TRANSPORT_URL=amqp://stackqpid:secretqpid@172.25.1.2:5672// && python setup.py testr --slowest --testr-args=oslo_messaging.tests.functional')
OM_CNTR=$(docker run --net=be_nw --ip=172.25.1.3 -d $OM_IMG /bin/bash -c 'cd /main/oslo.messaging && tox -epy27 --notest && source .tox/py27/bin/activate && export TRANSPORT_URL=amqp://172.25.1.2:5672// && python setup.py testr --slowest --testr-args=oslo_messaging.tests.functional')

docker attach $OM_CNTR

RC=$(docker wait $OM_CNTR)

docker rm -f $RTR_CNTR
docker rm -f $OM_CNTR
docker network rm $BE_NW
docker rmi $RTR_IMG
docker rmi $OM_IMG

exit $RC
