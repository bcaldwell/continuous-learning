# Sharding Containers in Golang

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


## Problem

- **its not fast enough**
	- at uber they run a lot (1000s) of microservices
- **Goal:**
	- make go faster
	- spends relatively large slice of time doing useless things - GC, context switching, CPU stalling for memory access

## Computers
- they are complicated
- massively multi-core, multi-socket, with deep cache hierarchies
- same code can have different latency and throughput even when running on the same CPU
- hardware is hard
- "computers are networks on-a-chip, literally!" - Donald T.

## Solution

### Current solution
- dont think about it and just accept it
- modern languages expect OS will take care of it and dont worry about it. [example](https://github.com/golang/go/issues/14406)

### Workaround

##### Sharding
- a shard is a horizontal partition of data in a database or search engine. Each shard is held on a separate server instance, to spread load.
- databases are not the only thing you can shard
- load balancing is essentially sharding of your whole backend

##### Load Balancing
- a load balancer distributes workloads across multiple computing resources, such as computers, a computer cluster. It aims to optimize resource use, maximize throughput, minimize response time and avoid overload of any single resource
- normally only used to distribute traffic across network nodes
- ca be used to distribute load across physical CPU cores

##### Hardware locality
- the arrangement of various element of a computer network
- in modern computers, each core is essentially a separate network node
- Docker supports CPU pinning. This way, we can spin up multiple instances of the same container and pin them to separate cores.
- We can even pin linked components closer to each other

#### Project Tesson
- [github](https://github.com/kobolog/tesson)
- a tool that automatically analyzes your hardware topology to utilize it as much as possible by spawning and pinning multiple instances of your app behind a local load balancer
- library from openAPI project to analyze hardware
- supports different granularities: core, NUMA, node, etc.
- Integrates with gorb for seamless local load balancer setup & configuration