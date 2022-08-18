# Zero Trust Networking with ServiceMesh

## Cloning

```bash
git clone ...
git submodule init
git submodule update
```

## Demo

1. Cleanup and run the deployments without service mesh
    ```bash
    ./cleanup.sh
    ./run.sh
    ```
1a. Start k9s show all pods in project namepsaces
    ```bash
    ./k9s.sh
    ```
    Use this command in k8s to filter to the project namespaces:
    ```bash
    /project
    ```
2. Open NetObserv to view the traffic. Try the link in the OCP application menu
3. Curl some test data
    ```bash
    oc rsh test -n project0
    curl -kvvv http://app-1.project2:8080
    ```
4. Navigate to kiali
5. Annotate the pods for servicemesh
    ```bash
    ./enable-istio.sh
    ```
6. Once the pods are redeployed, not that they now containe two containers instead of 1.
7. Start the traffic script again, view traffic in kiali. Note mTLS is enabled.
8. Try to curl from the test pod, not we can't get any data
    ```bash
    curl -kvvv http://app-1.project2:8080
    curl -kvvv https://app-1.project2:8080
    ```
