# 3 System Programming Concepts

## Syscalls
- syscalls from C are called through a wrapper function 
- syscalls return negative int if an error occurred 
	- check errno register to find positive value identifying specific error
		- errno not reset to 0 by successful exit