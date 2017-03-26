# Install kubernetes on 1 cpu cluster with kubeadm
### delete OutOfcpu dns pods
``` bash
kubectl --kubeconfig cluster.conf delete pod $(kubectl --kubeconfig cluster.conf get pods -n kube-system | grep OutOfcpu | cut -d' ' -f1) -n kube-system
```