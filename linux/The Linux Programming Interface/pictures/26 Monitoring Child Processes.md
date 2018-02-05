# 26 Monitoring Child Processes

## Waiting
- `pid_t wait(int *status)`
	- blocks if previously unwanted child process ha yet to terminate
	- waits for next child that terminates
	- return -1 if no child process exist and sets ERRNO to ECHILD
- `pid_t waitpid(pid_t pid, int *status, int options)`
	- waits for passed in pid if abs(pid) >= 1 or 1
	- can be non-blocking
- `int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);`
	- allows control over what child events to wait for

## Orphans and Zombies
- orphan
	- parent process dies
	- is adopted by init
- zombies
	- process dies before parent performs wait
	- cant be killed
	- removed after parent performs wait
	- init automatically performs wait on all its processes so it kills it if it is orphaned

## SIGCHLD signal
- signal sent to a parent whenever one of its children terminates
- if you call wait in handler some zombies might be missed…loop
- 