#!/bin/bash

# Create demo links on ocp dashboard
export KIALI_DASHBOARD=$(kubectl get route kiali -n smcp -o custom-columns=:.spec.host --no-headers)
export OCP_CONSOLE=$(kubectl get route console -n openshift-console -o custom-columns=:.spec.host --no-headers)

envsubst < ./ServiceMeshOverview-tpl.yaml | oc apply -f -
envsubst < ./ServiceMeshGraph-tpl.yaml | oc apply -f -
envsubst < ./NetObservGraph-tpl.yaml | oc apply -f -

# Delete pods
for i in {0..2}
do
  for resource in deployment service
  do
    oc delete $resource --all -n project$i
  done
done

oc delete pod test --grace-period=0 -n project0

# Reset loki data
oc delete pod --all -n loki
oc delete pvc --all -n loki
