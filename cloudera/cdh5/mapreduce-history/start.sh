#!/bin/bash

# Wait for DFS to come out of safe mode
until hdfs dfsadmin -safemode wait
do
    echo "Waiting for HDFS safemode to turn off"
    sleep 1
done

# Wait for resource manager to come alive on its standard port
until nc -z -w5 yarnresourcemanager.cdh5-lagoon 8032
do
    echo "Waiting for YARN ResourceManager to become available"
    sleep 1
done

service hadoop-mapreduce-historyserver start

tail -f `find /var/log -name *.log -or -name *.out`
