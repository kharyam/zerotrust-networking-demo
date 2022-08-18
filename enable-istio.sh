#!/bin/bash

for namespace in {0..2}
do
  for app in {0..3}
  do
oc patch deployment app-$app -n project$namespace -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject":"true"}}}}}'
  done
done

