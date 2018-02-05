# 57 Sockets: Unix Domain

- `bind` bind socket to file system
- unix socket file can’t be opened using `open()`
- usually bind to /tmp
	- real world apps should bind to secure locations
- file socket is to be bound too much not already exist
- ownership and permissions work like files
- ownership and permissions determine who can talk to who
	- to connect write is required

- Unix domain socket binding
	- note memset to clear and strncpy
``` C
const char *SOCKNAME = "/tmp/mysock"; int sfd; struct sockaddr_un addr;

sfd = socket(AF_UNIX, SOCK_STREAM, 0); if (sfd == -1) errExit("socket");

/* Create socket */

memset(&addr, 0, sizeof(struct sockaddr_un)); /* Clear structure */ addr.sun_family = AF_UNIX; /* UNIX domain address */ strncpy(addr.sun_path, SOCKNAME, sizeof(addr.sun_path) - 1);

if (bind(sfd, (struct sockaddr *) &addr, sizeof(struct sockaddr_un)) == -1) errExit("bind");
```

- datagram
	- for UNIX domain sockets datagram is reliable since its handled by the kernel
- `int socketpair(int domain, int type, int protocol, int sockfd[2]);` creates a pair of sockets connected together
	- same as `pipe()`
	- sockets not bound to anything