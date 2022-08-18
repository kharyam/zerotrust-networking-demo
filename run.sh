#!/bin/bash

oc apply -f ConsoleNotification.yaml
oc get pod test -n project0 || oc run test --image=ubi8 -n project0 --command -- sleep 365d

cd hey-ho
./hey-ho.sh -n 3 -z 10m -q 10 -w 10 -d 4 -y 
