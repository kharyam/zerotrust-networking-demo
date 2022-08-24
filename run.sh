#!/bin/bash

# Update OCP Banner
oc apply -f ConsoleNotification.yaml

# Create demo links on ocp dashboard
export KIALI_DASHBOARD=$(kubectl get route kiali -n smcp -o custom-columns=:.spec.host --no-headers)
export OCP_CONSOLE=$(kubectl get route console -n openshift-console -o custom-columns=:.spec.host --no-headers)

envsubst < ./ServiceMeshOverview-tpl.yaml | oc apply -f -
envsubst < ./ServiceMeshGraph-tpl.yaml | oc apply -f -
envsubst < ./NetObservGraph-tpl.yaml | oc apply -f -

# Create test pod if it doesn't exist
oc get pod test -n project0 || oc run test --image=ubi8 -n project0 --command -- sleep 365d

# Create pods and network traffic
cd hey-ho
./hey-ho.sh -n 3 -z 10m -q 10 -w 10 -d 4 -y -s 
