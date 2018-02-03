# Install kubernetes on 1 cpu cluster with kubeadm

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}

### delete OutOfcpu dns pods
``` bash
kubectl --kubeconfig cluster.conf delete pod $(kubectl --kubeconfig cluster.conf get pods -n kube-system | grep OutOfcpu | cut -d' ' -f1) -n kube-system
```