# What is new in Docker 1.12

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


## Swarm mode
- `docker swarm init`
	- creates docker swarm manager
- `docker swarm join <IP of manager>:2377`

## Services
- swarm engines will enforce desired state
- `docker service create --replicas 3 --name frontend --network mynet --publish 80:80/tcp frontend_image:latest`
	- creates 3 containers and connects them on an overlay network
- `docker service create --name redis --network mynet redis:latest`
	- dns based service discovery

- ![services](../../pictures/What's New in Docker - Docker Track - YouTube 2016-07-26 21-17-38.png)
- general scheduler that in the future will support more like setting up vm
- 

#### Node failure
- maintain current state with desired state even when machine fails

##### Scaling
- `docker service scale frontend=10`

##### Global services
- `docker service create --mode=global -name prometheus prom/prometheus`
- runs on every machine automatically (runs one copy on each machine)
- automatically runs on new machines

##### Constraints
- contain docker contains to engine labels
- `docker daemon --label com.example.storage="ssd"`
- `docker service create --replicas 3 --name frontend --network mynet --publish 80:80/tcp --constraint com.example.storage="ssd" frontend_image:latest`

##### Stacks
- services are grouped into stacks
- distributed application bundle (.dab files) declares a stack
- stacks are a deployed bundle
- json generated from a compose file?

- docker swarm mode is optional
- backwards compatible

## Routing mesh
- ![routing mesh](../../pictures/What's New in Docker - Docker Track - YouTube 2016-07-26 21-25-21.png)
- ![routing mesh](../../pictures/What's New in Docker - Docker Track - YouTube 2016-07-26 21-29-24.png)
- - `docker service create --replicas 3 --name frontend --network mynet --publish 80:80/tcp frontend_image:latest`
- operator reserves a swarm wide ingress port (80) for myapp
- every node listens on 80
- container aware routing mesh can transparently reroute traffic from Worker3 to a node that is running container
- built in load balancing into the engine
- DNS based service discovery 
- abstraction that the entire cluster is like a single machine

## Security out of the box
- cryptographic node identity
	- workload segregation (think PCI)
- there is no "insecure mode"
	- TLS mutual auth
	- TLS encryption
	- certificate rotation
- default end to end encryption
	- cryptographic node identity
	- automatic encryption and mutual auth (TLS)
	- automatic cert rotation
	- external CA integration

## Health checks
- container health checks in Dockerfile
- `HEALTHCHECK --interval=5m --timeout=3s --retries 3 CMD curl -f http://localhost/ || exit 1
	- 3 consecutive failures puts container in an unhealthy state
- let orchestration take down the app.

## New plugin subcommands
- `docker plugin install tiborvass/no-remove`
- `docker plugin enable no-remove`
- `docker plugin disable no-remove`
##### docker permission model
- grant permissions to plugins

## Orchestration deep dive
- node have roles
	- manager
		- orchestrate the workers
	- work
		- takes work and reports back the status
- each node starts the same
	- roles are dynamic
- ![layers](../../pictures/What's New in Docker - Docker Track - YouTube 2016-07-26 21-38-44.png)

#### Quorum Layer
- manager layer
- strongly consistent: holds desired state
- simple to operate
- blazing fast (in-memory reads, domain specific indexing, ...) uses internal key value store
- secure

#### Worker-to-worker gossip
- eventually consistent: routing mesh, load balancing rules
- high volume, p2p network between workers
- secure: symmetric encryption with key rotation in raft

#### Node breakdown

![node breakdown](../../pictures/What's New in Docker - Docker Track - YouTube 2016-07-26 21-46-40.png)