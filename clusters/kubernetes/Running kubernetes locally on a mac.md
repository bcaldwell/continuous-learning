# Running kubernetes locally on a mac

To run kubernetes we can use a really cool application called minikube. To get started:

1. [install Virtualbox](https://www.virtualbox.org/wiki/Downloads)
2. run `sysctl -a | grep machdep.cpu.features | grep VMX` and ensure should thing is outputted. This ensures that VT-x/AMD-v virtualization is enabled in BIOS
3. Install minikube [latest release](https://github.com/kubernetes/minikube/releases) or `curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.4.0/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/`
4. Install kubectl `curl -sSL "http://storage.googleapis.com/kubernetes-release/release/v1.2.0/bin/darwin/amd64/kubectl" > /usr/bin/kubectl
chmod +x /usr/bin/kubectl`

### Starting a cluster

- To start the cluster run
`minikube start`
- Set kubectl to use the minikube context 
`kubectl config use-context minikube`
- Make sure the cluster is running `kubectl get pods --all-namespaces`. It should output something like

```
NAMESPACE     NAME                           READY     STATUS    RESTARTS   AGE
kube-system   kube-addon-manager-127.0.0.1   1/1       Running   0          1m
kube-system   kubernetes-dashboard-r2yz2     1/1       Running   0          1m
```

- check out the kubernetes dashboard `minikube dashboard`

### Testing it out

- list the nodes `kubectl get nodes`
- since minikube runs docker we can connect to its docker daemon and view the running containers
`eval $(minikube docker-env) && docker ps`
should output something like 

```
docker ps
CONTAINER ID        IMAGE                                                        COMMAND                  CREATED             STATUS              PORTS               NAMES
42c643fea98b        gcr.io/google_containers/kubernetes-dashboard-amd64:v1.0.1   "/dashboard --port=90"   3 minutes ago       Up 3 minutes                            k8s_kubernetes-dashboard.1d0d880_kubernetes-dashboard-9brhv_kube-system_5062dd0b-370b-11e6-84b6-5eab1f51187f_134cba4c
475db7659edf        gcr.io/google_containers/pause-amd64:3.0                     "/pause"                 3 minutes ago       Up 3 minutes                            k8s_POD.2225036b_kubernetes-dashboard-9brhv_kube-system_5062dd0b-370b-11e6-84b6-5eab1f51187f_e76d8136
e9096501addf        gcr.io/google-containers/kube-addon-manager-amd64:v2         "/opt/kube-addons.sh"    3 minutes ago       Up 3 minutes                            k8s_kube-addon-manager.a1c58ca2_kube-addon-manager-127.0.0.1_kube-system_48abed82af93bb0b941173334110923f_82655b7d
64748893cf7c        gcr.io/google_containers/pause-amd64:3.0                     "/pause"                 4 minutes ago       Up 4 minutes                            k8s_POD.d8dbe16c_kube-addon-manager-127.0.0.1_kube-system_48abed82af93bb0b941173334110923f_c67701c3
```

[source](http://kubernetes.io/docs/getting-started-guides/minikube/)
