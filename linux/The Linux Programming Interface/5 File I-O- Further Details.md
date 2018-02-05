# 5 File I/O: Further Details

## Duplicating File Descriptors

`int dep(int oldfd)`

- creates a new fd that points to oldfd
- garenteed to be the lowest unused 
- example for `2>&1`

		```
		close(2) /*free up fd 2*/
		newfc = dup(1) /*create fd 2 to point to 1*/
		```
		
- to ensure we get the require fd we can use dup2
	- `int dup2(int oldfd, int newfd);`
- newfd is closed the pointed at oldfd
- since the new fd can have different flag then the original we have dup3
	- `int dup3(int oldfd, int newfd, int flags);`

## File I/O advanced functions
- pread and pwrite are just like read and write but the last parameter is the offset
- readv and readv just like read and write but can transfer to multiple buffers in a single system call
- truncate and ftruncate truncate files
	- `int truncate(const char *pathname, off_t length);`
	- `int ftruncate(int fd, off_t length);`