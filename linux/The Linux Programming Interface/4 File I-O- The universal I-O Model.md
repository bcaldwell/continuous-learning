# 4 File I/O: The Universal I/O Model

## File syscalls

### Opening a file
`int open(const char *pathname, in flags, … /* mode_t mode*/);`
- flags:
	- O_RDONLY: read only
	- O_WRONLY: write only 
	- O_RDWR: both read and write
	- O_CREAT: create file if it doesnt exist
- open will create file if it doesnt exist if called with O_CREAT, mode is used to set permission on the file (parameter 3)
- return file descriptor of opened file

### Creating a file
- used to use creat by now just use open
`fd = open(filename, O_WRONLY | O_CREAT| O_TRUNC, mode);`

### Reading from file
`ssize_t read(int rf, void *buffer, size_t count);`
- writes up to count byte to buffer from fd
- buffer must be initialized to size_t at least
- returns number of bytes read
	- returns 0 if done

### Writing to a file
`ssize_t write(int fd, void *buffer, size_t count);`
- writes up to count byte from buffer to fd
- returns number of bytes written

### Closing a file
`int close(int fd)`
- closes the file and allows fd to be use again
- check return value

### Changing the file offset
` off_t lseek(int fd, off_t offset, int whence)`
- file offset is the current location that is being written to or read from,
- returns current offset
- offset is required offset relative to whence
- whence:
	- SEEK_SET: start of file
	- SEEK_CUR: current location
	- SEEK_END: end of file˜

### Operations outside the universal I/O model
`int ioctl(int fd, int request, ….argp)`
- fd is the open file descriptor for the device or file upon which the control operation specified by request is to be performed on
