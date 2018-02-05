# Kubernetes

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


### The new stack
- decouple different aspects of the stack

##### Application Ops
- Dev ops

##### Cluster Ops
- **Kubernetes**

##### Kernel/OS Ops
- CoreOS

##### Hardware Ops
- aws, google cloud or bare metal


### Why is Kubernetes
- goal is to provide a decoupling between the cluster ops and the layers of the stack

## Kubernetes Architecture
![](../pictures/kubernetes-arch.png)

- api server is stateless
- etcd provides the storage for configurations
- small focused binaries
	- scheduler
		- assigns pod to nodes
	- controller manager

### Pods
![](../pictures/kubernetes-pods.png)

1. Collection of one or more containers that work well together
2. Volumes that are data volumes. Life span is independent of the container lifespan
3. Namespaces. ie: network, IPC
	- can link stuff with localhost. shared network namespace
4. Labels: key value pairs for organizing stuff

- Pods are an atomic unit of scheduling
	- doesnt make sense for these containers to live on different machines
- containers can have shared memory

### Labels

- label pods
- are key value pairs
- can query against labels

### Reconciliation

- desired state vs actual state
	- reconciliation loop job is to diff desired and actual and try to achieve the desired state
- runs on each node and gets the desired state from the schedule
- does health checking

### Replication Controller --> Deployments
- combination of a template, labels and a number
- abstracted out to deployments

### Services
-  get a known static fixed ip address
-  gets a dns entry
-  internal "fake" ip address
-  ex: frontend can reference backend without knowing where it is
-  each service should have a load balancer at the very edge
-  has a name, ports and label query

[source](https://www.youtube.com/watch?v=WwBdNXt6wO4)