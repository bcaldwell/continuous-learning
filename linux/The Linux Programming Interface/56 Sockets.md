# 56 Sockets

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


- sockets are for communication:
	- each application creates a socket
	- the server binds its socket to a well-known address (name) that clients can locate
- `fd = socket(domain, type, protocol)`
	- returns a file descriptor
	- protocol is 0 in this book
	- domains
		- UNIX: communication between applications on the same host
		- IPv4: communication between hosts using Internet Protocol version 4 (IPv4) [32 bit address + 16bit port]
		- IPv6: communication between hosts using Internet Protocol version 6 (IPv6) [128 bit address + 16 bit port]
	- types
		- stream (SOCK_STREAM)
			- reliable, bidirection, byte-stream (no concept of message boundaries) communication
			- operate in connected pair…connection-oriented
			- TCP
		- datagram (DOCK_DGRAM)
			- message boundaries are preserved but data transmission no reliable
			- messages and be out of order, duplicated or not arrive
			- UDP

## System calls

### Stream sockets
- `int socket(int domain, int type, int protocol)` create a new socket
- `int bind(int socked, const struct sockaddr *addr, socklen_t addrlen)` bind socket to an address
- `int listen(int sockfd, int backlog)` allow stream socket to accept incoming connection
	- makes socket as passive: accepting connection from other active sockets
	- backlog limits number of pending connections accepted
- `int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen)` accepts a connection from a peer application on a listening socket
	- blocks if there are no pending connections
	- creates a new socket that is connected to the other socket (fd of new socket is returned)
	- the existing socket can be used to accept new connections
	- A typical server application creates one listening socket, binds it to a well-known address, and then handles all client requests by accepting connections via that socket.
	- sockaddr returns the address of the connected socket
- `int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);` establishes a connection with another socket
- read and write for socket -> `send()`, `recv()`
- `close()` close socket

![](../pictures/socket_sys_call_overview.png)
![](../pictures/passive_socket_sys_call_overview.png)

### Datagram sockets

- `ssize_t sendto(int sockfd, const void *buffer, size_t length, int flags, const struct sockaddr *dest_addr, socklen_t addrlen);` send message to address
	- 
- `ssize_t recvfrom(int sockfd, void *buffer, size_t length, int flags, struct sockaddr *src_addr, socklen_t *addrlen);` receive message…gives us the address of sender…may block
- if a socket is connected using `connect` we can use write/send