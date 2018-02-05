# 6 Processes

- every process has a process id and parent id
	- `pid_t getpid(void);`
	- `pid_t getppid(void);`
- PID 1 is the init process
	- to see all process back to 1 use `pstree(1)`
- **Orphaned**: if parent terminates
- Ppid can be found in /prod/PID/status file

## Memory layout of a process
- divided into segments
	- text segment: read-only machine-language instructions 
	- initialized data segment: global and static variables (read from executable when loaded into memory
	- uninitialized data segment: global and static variables which are not explicitly initialized. (space is allocated at runtime)
	- Stack: dynamically growing and shrinking segment containing stack frames. A track frame fro each called function and stores associated local variables, arguments and return value
		- includes:
			- functional arguments and local variables
			- call linkage information: information about steps to run after done
	- Heap: dynamically allocated variable at run time

## Command line arguments
- the first argv contains the name of the exec call. Useful to have one binary for multiple commands
- argv in C is terminated by a NULL
- available at /proc/PID/cmdline or /proc/self/cmdline

## Environment List
- each process has an accosted array of string call environment list
- format: *name=value*
- new process inherit parents environment
- in shell: `export NAME=value`
- in shell to modify descendants environment: `Name=value program`
- 