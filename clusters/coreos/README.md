# CoreOS

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


CoreOS is a Linux distribution that focuses on making large, scalable deployments clusters easy to manage. It is based on Chrome OS and uses Docker containers for all applications and thus doesn't have a package manager.

## Parts of CoreOs
### etcd 
#### Consensus & Discovery
Etcd was developed to provide consistent set of global data across the cluster and to enable service discovery. At its core it is a highly available key-value store. It is used by each node to get configuration data, query information about running services, and publish information that should be known to other members. Etcd runs on every node and is configured to communicate with the other nodes in the cluster to share and distribute information. To interact with the etcd you can use `http://127.0.0.1:4001/v2/keys/` or use the included utility called `etcdctl`

### fleet
#### A distributed init system
Fleet is a cluster-wide init system used by CoreOs. At its core it provides an interface for controlling the `systemd` system on each of the nodes. Fleet allows you to start, stop and get state information about running on the cluster. It can also handle process distribution so it can for example start a service on the least busy host.


## Setting up a cluster

### Generate a Discovery URL
To set up CoreOs a discovery URL, a URL that stores peer CoreOS addresses and metadata. CoreOS creates provide such a service for free at https://discovery.etcd.io. To generate a new URL `curl -w "\n" "https://discovery.etcd.io/new`

### Write a Cloud-Config File
blah!!!

[source](https://www.digitalocean.com/community/tutorials/an-introduction-to-coreos-system-components)
[source](https://coreos.com)