#!/bin/sh

while true
do
    ./parser.sh > tmp
    zabbix_sender -z $ZABBIX -i tmp
    sleep 10
done

