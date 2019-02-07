#!/bin/bash

export HOSTNAME_IP_ADDRESS=$(hostname -i)

CONFIG_FILE=/tmp/qdrouterd.conf
TEMPLATE_FILE=/etc/qpid-dispatch/qdrouterd.conf.template

IPS=()
COUNT=0
ALL_IPS="false"

while [ "$ALL_IPS" != "true" ]; do
    while read line
    do
        IPS+=("$line")
        let COUNT=COUNT+1
    done < <(/usr/bin/dig "$APPLICATION_NAME"-headless."$POD_NAMESPACE".svc.cluster.local +short)

    if [ $COUNT -eq "$POD_COUNT" ]; then
        ALL_IPS="true"
    else
        sleep 1
        IPS=()
        COUNT=0
    fi
done

if [ -f $TEMPLATE_FILE ]; then
    DOLLAR='$' envsubst < $TEMPLATE_FILE > $CONFIG_FILE
    ARGS="-c $CONFIG_FILE"
fi

for item in "${IPS[@]}"; do
    if [ "$item" \< "$HOSTNAME_IP_ADDRESS" ]; then
        cat <<EOF >> $CONFIG_FILE
    connector {
        name: $APPLICATION_NAME-$item
        host: ${item}
        port: 55672
        role: inter-router
    }
EOF
    fi
done

exec /sbin/qdrouterd $ARGS
