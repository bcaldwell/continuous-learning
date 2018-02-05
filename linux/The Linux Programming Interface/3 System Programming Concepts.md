# 3 System Programming Concepts

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


## Syscalls
- syscalls from C are called through a wrapper function 
- syscalls return negative int if an error occurred 
	- check errno register to find positive value identifying specific error
		- errno not reset to 0 by successful exit