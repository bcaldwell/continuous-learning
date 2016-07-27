# Consul
- service discovery, configuration, and orchestration made easy. Distributed, highly available, and datacenter-aware

- does service discover
	- "Where can I find this service"
- service configuration
	- "what is my configuration"

### ways to interact:
- dns
	- legacy-friendly
- http
	- can have more data

### about consul
- can discover both internal and external services (such as service providers)

### failure detection
- dns wont return non-healthy services
- http gives more information

### key/value store
- what is the config of some service
- rest API
- highly available
- watch keys
- set ACL to protect sensitive information

### Multi datacenter
- supports multi data center
- closest/routing
- local by default

### Orchestration
- events, exec, watches

### Docker
- run the agent in or out in the container
- console in docker: health checks via network
- console on host: health checks that enter container

### Demo
