# File descriptor

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


In Unix systems, file descriptor (FD, or files) is an indicator used to access a file or other input/output resource, such as a pipe or network socket. File descriptors form part of the POSIX application programming interface. A file descriptor is a non-negative integer, usually represent as a type int. Negative numbers are reserved to indicate "no value" or an error condition.

Each Unix process (except perhaps a daemon) should expect to have three standard POSIX file descriptors, corresponding to the three standard streams:

| Integer value | Name           | <unistd.h> symbolic constant  | <stdio.h> file stream |
| ------------- |:-------------:| -----:|----------:|
|0|Standard|input|STDIN_FILENO|stdin|
|1|Standard|output|STDOUT_FILENO|stdout|
|2|Standard|error|STDERR_FILENO|stderr|

### Using go

The following streams the word "FOOBAR" to the file descriptor 9

```
package main

import "os"

func main() {
    fd9 := os.NewFile(9, "fd9")
    fd9.Write([]byte("FOOBAR\n"))
    fd9.Close()
}
```
### Redirect operators

Unix redirect operators `>`/`<` can redirect select file descriptors. For example to only redirect the file descriptor 9 from the pervious use `9>`
```
go run main.go 9> test.txt
```


