#!/bin/bash

# Display all pods. For the demo, filter this down to the pods in the project* namespaces with:
# /project <enter>
k9s -A --command pods --headless
