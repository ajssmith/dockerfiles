#!/bin/bash -ex
#

IMAGE=$(sudo docker build ./oslo.messaging/$OS/. | tail -1 | awk '{ print $NF }')

CONTAINER=$(sudo docker run -d $IMAGE /bin/bash -c 'cd /main/oslo.messaging && tox -epy27 -- oslo_messaging.tests.drivers.test_amqp_driver')

sudo docker attach $CONTAINER

RC=$(sudo docker wait $CONTAINER)

sudo docker rm -f $CONTAINER
sudo docker rmi $IMAGE

exit $RC
