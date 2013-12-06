#!/bin/sh
root="doxy"
#json=`curl -s http://localhost:9011/status/ | tail -n 1`;
json=`curl -s http://localhost:9002 | tr "\n" " " | sed 's/ //g' | tail -n 1`;

json=$(echo "\"ROOT\":"$json)
json=$(echo $json  |  sed -r 's/([a-z]+)([A-Z][a-z]+)/\1_\l\2/g' | sed -r 's/(\"\w+\"\:\{)/\n\1/g' | sed 's/"//g' | tr '[:upper:]' '[:lower:]' | tail -n +2)

host=$(hostname)
for node in $json
do
    #echo $node
    nod=$(echo $node | awk -F ":{" '{print $1}')
    params=$(echo $node | sed 's/}//g' |   awk -F ":{" '{print $2}' | tr "," "\n")
    for param in $params
    do
        kv=$(echo $param | awk -F ":" '{print $1" "$2}')
        k=$(echo $kv | awk '{print $1}')
        v=$(echo $kv | awk '{print $2}')
        echo $host" "$root"."$nod"."$k" "$v
    done;
done

