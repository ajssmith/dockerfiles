IMAGE=$(docker build ../oslo.messaging/$OS/. | tail -1 | awk '{ print $NF }')

CONTAINER=$(docker run -d $IMAGE /bin/bash -c 'cd /main/oslo.messaging && tox -epy27 -- oslo_messaging.tests.drivers.test_amqp_driver')

docker attach $CONTAINER

RC=$(docker wait $CONTAINER)

docker rm $CONTAINER

#exit $RC
