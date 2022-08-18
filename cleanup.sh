#!/bin/bash

# Create link to kiali dashboard
export KIALI_DASHBOARD=$(kubectl get route kiali -n smcp -o custom-columns=:.spec.host --no-headers)
envsubst < ./ServiceMeshLink-tpl.yaml | oc apply -f -

# Delete pods
for i in {0..2}
do
  for resource in deployment service
  do
    oc delete $resource --all -n gallery$i
  done
done

oc delete pod test --grace-period=0 -n gallery0

# Reset loki data
oc delete pod --all -n loki
oc delete pvc --all -n loki
