# strace

## Examples
- `strace ls` show system calls of ls
- `strace -e open ls` show only open system calls of ls
- `strace -e trace=open,read ls /home` show open and read system calls by passing trace=x,x,x,x to strace e
- `strace -o file ls` output result of the trace to the file
- `strace -o file -p process_id` trace existing process by PID and write result to file
- `strace -t ls` print timestamp for each syscall
- `strace -r ls` print relative time (from start) for each syscalls
- `strace -c ls /home` generate statistical report of which syscalls are called and how long they take


[7 examples of strace](https://www.thegeekstuff.com/2011/11/strace-examples/)