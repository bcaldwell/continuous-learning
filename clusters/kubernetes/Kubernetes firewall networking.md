# Kubernetes firewall networking

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


## Port allocation
### Master Node inbound

| Protocol | Port Range | Source                                    | Purpose                |
|----------|------------|-------------------------------------------|------------------------|
| TCP      | 443        | Worker Nodes, API Requests, and End-Users | Kubernetes API server. |
| TCP      | 6443       | Cluster administrator (kubectl)           | Kubernetes API server. |

### Worker Node Inbound

| Protocol | Port Range | Source                                    | Purpose                |
|----------|------------|-------------------------------------------|------------------------|
| TCP      | 443        | Worker Nodes, API Requests, and End-Users | Kubernetes API server. |
| TCP	| 10250 |	Master Nodes |	Worker node Kubelet API for exec and logs. |
| TCP | 	10255 |	Heapster	 | Worker node read-only Kubelet API. |
| TCP | 	30000-32767 |	External Application Consumers | Default port range for external service ports. Typically, these ports would need to be exposed to external load-balancers, or other external consumers of the application itself. |
| TCP |	ALL |	Master & Worker Nodes	| Intra-cluster communication (unnecessary if vxlan is used for networking) |
| UDP | 	8285 |	Worker Nodes	 | flannel overlay network - udp backend. This is the default network configuration (only required if using flannel) |
| UDP |	8472 |	Worker Nodes | 	flannel overlay network - vxlan backend (only required if using flannel) |
| TCP |	179 |	Worker Nodes	 | Calico BGP network (only required if the BGP backend is used) |

### etc Node Inbound

| Protocol | Port Range | Source                                    | Purpose                |
|----------|------------|-------------------------------------------|------------------------|
| TCP      | 2379-2380        | Worker Nodes | etcd server client API |
| TCP | 2379-2380 | Worker Nodes | etcd server client API (only required if using flannel or Calico).

### Ingress Nodes

| Protocol | Port Range | Source                                    | Purpose                |
|----------|------------|-------------------------------------------|------------------------|
| TCP      | 80, 443       | External | http/https traffic |

### Networking layer

- Allow incoming traffic on the networking layer interfaces. For example `flannel.1`
- Allow incoming traffic from other nodes

### Ansible playbook

[Ansible playbook](https://github.com/benjamincaldwell/ansible/blob/master/playbooks/kubernetes/firewall.yml)

[source](https://coreos.com/kubernetes/docs/latest/kubernetes-networking.html)