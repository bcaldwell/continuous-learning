# Linux Performance Tools

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}

~ Velocity Brendan Gregg


## Methodologies
- there are dozens of performance tools for linux
- methodologies can provide guide for choosing tools effetely as well as a starting, a process and ending point

- Street light anti-method
	- guy looking under streetlight because that is where the light is best not because its where you lost it
	- aka…pick servility tool that are
		- familiar
		- found on internet
		- at random
- Dunk man anti-method
	- tune things at random until the problem goes away
- Blame someone else anti-method
	- find a system or environment component that you are not responsible for and redirect it to them

### Actual Methodologies

- Problem statement method
	- What makes you think there is a performance problem?
	- has this system ever performed well?
	- what has changed recently?
	- can the performance degraded be expressed in terms of latency or run time
	- does the problem affect people or applications
	- Redefine the problem
- Workload Characterization Method
	- Who is causing the load? PID, UID, IP add, ..
	- Why is the load called? code path, stack trace
	- What is the load? IOPS, tput, type, r/w
	- How is the load changing over time?
	- performance monitoring tool are generally good at finding
- The USE Method
	- for every resource in a functional (block) diagram of your system/software/environment, check:
		- Utilization (busy time)
		- Saturation (queue length or queue time)
		- Error (easy to interpret (objective))
	- Component examples:
		- CPU, I/O bridge, etc.
	- could also be software (full stack environment)
		- redis, database
	- [check list](http://www.brendangregg.com/USEmethod/use-linux.html)
- Off-CPU Analysis
	- could be block for whatever reason
	- learn when application steps off CPU and why
- CPU Profile Method
	- take a CPU profile
	- understand all software in profile >1%
		- discovers a wide range of performance issues by their CPU usage
		- tells you what is actually running
- RTGM Method
	- how to understand performance tools or metrics
	- man pages, books, web search, source code, experimentation


## Tools

### Basic
- uptime
	- a measure of resource demand: CPU and dick
	- 1, 5, 15 minute load averages
- top (or stop)
	- shows %cpu, memory usage and other stats for each PID (also shows command)
	- system wide summary
	- short lived processes can be missed (atop better)
- htop
	- pretty top
- ps
	- process status listing
	- custom fields (`ps -eo user, sz,rss,minfit,pcpu,args`)
	- can show parent process graph (`ps -ef f`)
- vmstat
	- virtual memory statistics
	- shows memory, swap, io, cpu usage
- iostat
	- very useful set of stats
	- disk write/read
		- %util
		- await (average time waiting for disk io)
	- `iostat -xmdz 1`
- mpstat
	- multi-processor statistics per CPU
	- look for unbalanced workloads
	- %idle
- free
	- main memory usage
	- buffers: block device I/O cache
	- cached: virtual page cache


- USE method example
	- *lab 5*
	- top
		- a little busy in kernel time
	- vmstat 1
	- mpstat -P ALL 1
	- vmstat 1
		- check memory
	- iostat -x 1
		- pretty busy
	- sar -n DEV 1
		- network IO
	- conclude disks are pretty busy..why?

### Intermediate
- strace
	- system call tracer
	- can by slow
	- very helpful for solving system usage issues
- tcpdump
	- sniff network packets for post analysis
	- study packet sequences with timestamp
	- can use a lot of CPU
	- harder to use in modern environments 
- netstat
	- various network protocol statistics using -s
	- -i interface stats
	- -r route table
- nicstat
	- network interface stats, iostat-like output
	- check network throughput and interface %util
- pidstat
	- user time and system time for each process
	- -d shows block device IO
- swapon
	- check swap usage
- lsof
	- more of a debug tool, shows file descriptor usage, which apps, shows current active network connections
	- who is connect to who
	- `lsof -iTCP -sTCP:ESTABLISHED`
- sar
	- system activity report. Many stats
	- networking 
	- logical groups (TCP, ETCP, DEV, EDEV)


- tool not that important, just a tool to measure everything

- DEMO; lab 3
	- wmstat 1
		- a lot of user time and system time
	- mpstat 1
	- pidstat 1
	- iostat -x 1
		- not disk
	- sar -n DEV 1
		- network no
	- vmstat -1
		- not swapping
	- `strace -p `prep lab003` 2>&1 | head -100`
		- read(3,””,0) -> repeatingly…reading 0 bytes at a time

### Advanced Tools
- ss
	- more socket statistics
- iptraf
	- histogram of network packets sent on each interface
- iotop
	- block devices by process
- slabtop
	- kernel slab allocator memory usage
	- memory leaks
- pcstat
	- show page cache residency by file
	- files in linus page cache
- perf_events
	- provides the “perf” command
	- in linux source code
	- Multi tool with:
		- CPU profiling
		- PMC profiling
		- static and dynamic tracing
	- tiptop
		- IPC by process, %MISS, %BUS
	- rdmsr
		- model specific registers (MSRs), unlike PMCs can be read by default in Xen guests
		- CPU temp and power

## Benchmarking Tools
- hard to do accurately 
- results mislead, you benchmark A, but measured B and concluded you measured C
- method
	- active benchmarking
		- run benchmarking for hours
		- verify using tools
### Tools
- imbench
	- CPU, memory and kernel micro-benchmarks
- fio
	- FS or disk I/O micro-benchmarks
	- uses both cache and disk read
- pchar
	- trace route with bandwidth per hop
	- speed between each hop

## Tuning Tools
- Tools
	- sysctl
	- Network: ethtool, tc, ip, route
- Tuning methods
	- Scientific method
		- question
		- hypothesis
		- production
		- test
		- analysis

## Static Tools
- check static state of the system when system load
- CPU types and flags
	- `more /proc/cpuinfo`
- CPU frequency scaling
	- `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies`
- storage devices
	- `cat proc/scsi/scsi`
	- `lsscsi`
- Routing table
	- `netstat -rn`
	- `ip route get 54.214.28.210`
		- how to get to route
- etc
	- system message: dmesg
	- network interface config: ifconfig -a; ip link
	- file system capacity: df -h

## Profiling
- objectives:
	- profile CPU usage by stack sampling
	- generate CPU flame graphs
	- understand gotchas
- cpu profiling
	- record stacks st a timed interval: simple and effective
		- pro: low overhead
		- cons: coarse accuracy
	- perf_events
		- `perf record -F 99 -ag -- sleep 30`
			- 99 hz, dont sample at lock stop (not 100)
		- `perf report -n —stdio`
		- can be shown as a flame graph
			- `git clone --depth 1 https://github.com/brendangregg/FlameGraph`
			- `perf record -F 99 -a –g -- sleep 30`
			- `perf script | ./stackcollapse-perf.pl |./flamegraph.pl > perf.svg`
			- x-axis: alphabetical stack sort, to maximize merging
			- y-axis: stack depth

- example: lab 4

- perf_events: workflow
- ![](.././pictures/perf_events_workflow.png)
- perf_events gotchas
	- stack traces and symbols often dont work
- perf_events Counters
	- identify CPU cycle breakdown

## Tracing
- statically placed tracepoints in logical places in the kernel
- provides key event details as a “format” string
- kprobes:
	- dynamic kernel tracing (function calls, returns, line numbers
- uprobes: 
	- dynamic user-lever tracing
- many different tools (ftrace, perf_events, eBPF..)
- Use what is in Linux already has built in if it is sufficient

- ftrace:
	- iosnoop
		- block I/O disk events with latency
		- work load characterization 
	- islatency
		- blockI/O disk latency distributions
	- opensnoop
		- what file are open?
		- trace open syscalls showing filenames
	- tpoint
		- who is creating disk IO and of what type?
	- funccount
		- count a kernel function call rate
	- funcgraph
		- trace a graph of kernel code
	- kprobe
		- dynamically trace a kernel function call or return with variables

- eBPF
- sysdig
	- innovative new tracer with simple expressions
