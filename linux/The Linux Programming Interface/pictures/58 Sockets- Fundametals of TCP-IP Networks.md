# 58 Sockets: Fundamentals of TCP/IP Networks
- TCP: Transmission control protocol
	- a layered network protocol
	- Network interface hardware -> IP -> TCP -> Application
	- Data link Layer
		- Network interface hardward
		- encapsulates datagrams from the network layer into units called frames
		- frames include a header with destination address and frame size
		- Network layer: IP
			- breaks data into fragments small enough for transmission
			- routing data across the internet
			- providing service to the transport layer
			- IP transmits data in the form of datagrams (packets)
			- IP is connectionless and thus unreliable
				- reliability must be provided either by using a reliable transport layer TCP or within the application itself
			- special IP
				- 127.0.0.1 loopback
				- 0.0.0.0 wildcard, listens to any of the hosts IPS
				- ::1 IPv6 loopback
				- :: IPv6 wildcard
		- The transport later
			- TCP or UDP
			- port numbers 
				- 16 bit differentiation
				- 22: ssh
				- 80: HTTP
				- 0-1023: assigned by central authority. the internet assigned numbers authority
				- 0-1023 are privileged ports
			- UDP
				- adds IP port numbers and data checksum to allow detection of errors
				- cant cause IP fragmentation if datagram exceeds MTU
			- TCP
				- reliable, connection-oriented, bidirectional communication
				- data is broken into segments, each containing a checksum. Each segment is transmitted in a single IP datagram
				- acknowledgment is sent after transition is received. Will be resent if not acknowledged in time
				- each byte transmitted is assigned a logical sequence number
					- number is generated each time a connection is established
				- includes flow control to prevent fast sender from overwhelming  a slow receiver and congestion control to prevent a fast sender form overwhelming the network 
				- 