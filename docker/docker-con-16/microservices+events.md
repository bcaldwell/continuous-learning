# Mircoservices + Events +Docker = A Perfect Trio

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


## 3 attributes of successful software development
1. Architecture
    * Monolithic vs Microservices
2. Process
    * Agile
    * Continuous delivery/ deployment
3. Organization
    * Small, autonomous teams

## Monolithic Architecture
- Layered and modular
- uses the single database
- Everything is packaged together as a single application
- In the beginning, it is simple to Develop, test, deploy and scale
- **Problem:** successful applications keep growing...agile and small teams are difficult
 
![monolithic architecture](../../pictures/monolithic.png)

## Microservice Architecture
- 3 dimensional model of scalability
    * x: horizontal duplication
    * z: data partitioning, scale by splitting similar things. Ex. database sharding
    * y: function decomposition. Scale by splitting the application into smaller applications or services
- each service has its own DB
- fits well with the process and organization attributes of successful software development
- easier to choose new technologies
- **Problem:** complexity
    - developing a distributed system
    - handling partial failures 
    - the complexity of implementing business transactions that span multiple databases
    - testing is harder
    - deploying and operating is more complex
    - **unlike monolithic there are solutions to the problems**

![microservices architecture](../../pictures/microservices.png)

### Shared database
- simple to the problem (ACID transactions)
- **problem:** tight coupling...makes it hard to change anything
- no recommended

### Database per service
- loose coupling but more complex
- **problem:** How to maintain data consistency??
- **solution:** Event-driven architecture

### Event-driven architecture
- Ideal: whenever something happens such as a state change that service publishes an event that can be consumed by other services and react accordingly
    - services can emit "reply" events
- **challenge:** two things have to be done automatically, dual write problem

### Use event-sourcing
- In an event table store the sequence of events instead of the actual data. For example instead of having an order table: ![microservices architecture](../../pictures/event-table.png)
- don't have to handle the event and update the database you just update the event table
- Benefits
    - replay events to recreate the state
    - generates a stream of events coming out of your services
    - reliable event publishing: can be used for predictive analytics
    - eliminates O/R mapping problem
    - 100% reliable audit log
    - can go back in time to see the history of objects
    - preserved history => More easily implement future requirement (feed in past events)
- Drawbacks
    - requires application rewrite
    - weird and unfamiliar style of programming
    - Events = a historical record of your bad design decisions. Can't remove bad events
    - must handle duplicate events
    - query the event store can be challenging

### Dealing with queries
- Command Query Responsibility Segregation
    - split application into 2 parts
        1. Command side (handles HTTP)
        2. Query side (interacts with DB)
        3. Event store: communication between command side and query side
    - more complex by high performance, scalable views

### Deploying with Docker
- how to deploy 100's of services
- Forces
    - services can be written in a variety of languages and frameworks
    - building and deploying should be fast
    - service must be deployed and scaled independently
    - service instances need to be isolated
- **old school:** way: multiple services per host
- **new school:**: single server per host, where a host is a VM or a container
- Container benefits
    - great isolation
    - great manageability
    - container encapsulates implementation technology
    - efficient resource utilization
    - fast deployment

##### Docker Compose
- use docker compose
- simplifies development environment
- simplifies end-to-end testing




[source](https://www.youtube.com/watch?v=pD0rEtEEwck)