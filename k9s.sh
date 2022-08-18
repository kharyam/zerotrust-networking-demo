#!/bin/bash

# Display all pods. For the demo, filter this down to the pods in the gallery* namespaces with:
# /gallery <enter>
k9s -A --command pods --headless
