ls_affinity
===========

List CPU affinity.  The program supports 4 different modes of
operation; serial, multithreaded (using OpenMP), MPI, and hybrid
OpenMP/MPI.  This program is mainly meant as a debugging aid for
understanding the interaction between MPI runtimes and workload
managers.

Prerequisites
-------------

You need the [hwloc](http://www.open-mpi.org/projects/hwloc/)
library. To compile the MPI version of the program, you need a MPI
library with development headers (typically including a mpicc compiler
wrapper). For the OpenMP version, you need a compiler with OpenMP
support. To build the program using the provided makefile, GNU make is
(probably) required.

Building
--------

The out-of-the-box makefile assumes GCC. If you use the Intel
compiler, use the Makefile.intel makefile, that is, run "make -f
Makefile.intel". If you use another compiler, you can make a copy of
the main makefile with a suitable suffic such as "Makefile.foo", and
edit it appropriately.


Running
-------

### Environment variables for OpenMP binding

As of OpenMP 3.1, there is the OMP_PROC_BIND environment variable
which can be set to the values "true" or "false". For more specific
binding schemes one must fall back on compiler specific methods. For
GCC, use
[GOMP_CPU_AFFINITY](http://gcc.gnu.org/onlinedocs/libgomp/GOMP_005fCPU_005fAFFINITY.html),
for the Intel compiler use KMP_AFFINITY.

### Example

Running 2 MPI processes with 4 threads per rank on a computer with 8
hardware threads, by default with OpenMPI 1.4 one gets e.g.

	$ OMP_NUM_THREADS=4 mpirun -n 2 ./ls_affinity_mpi_openmp 
	On host XXX, MPI rank 1 thread 0 bound to PU(s) 0-7
	On host XXX, MPI rank 0 thread 0 bound to PU(s) 0-7
	On host XXX, MPI rank 1 thread 1 bound to PU(s) 0-7
	On host XXX, MPI rank 1 thread 3 bound to PU(s) 0-7
	On host XXX, MPI rank 1 thread 2 bound to PU(s) 0-7
	On host XXX, MPI rank 0 thread 1 bound to PU(s) 0-7
	On host XXX, MPI rank 0 thread 3 bound to PU(s) 0-7
	On host XXX, MPI rank 0 thread 2 bound to PU(s) 0-7

By setting the affinity for both OpenMP and OpenMPI one gets

	$ GOMP_CPU_AFFINITY=0-7 OMP_NUM_THREADS=4 mpirun -n 2 -bind-to-core -cpus-per-proc 4 ./ls_affinity_mpi_openmp 
	On host XXX, MPI rank 0 thread 0 bound to PU(s) 0
	On host XXX, MPI rank 1 thread 0 bound to PU(s) 4
	On host XXX, MPI rank 0 thread 1 bound to PU(s) 1
	On host XXX, MPI rank 1 thread 1 bound to PU(s) 5
	On host XXX, MPI rank 1 thread 2 bound to PU(s) 6
	On host XXX, MPI rank 1 thread 3 bound to PU(s) 7
	On host XXX, MPI rank 0 thread 2 bound to PU(s) 2
	On host XXX, MPI rank 0 thread 3 bound to PU(s) 3

In the program output, "PU(s)" means "processing unit", per the hwloc
terminology: "The smallest processing element that can be represented
by a hwloc object. It may be a single-core processor, a core of a
multicore processor, or a single thread in a SMT processor. hwloc's PU
acronym stands for Processing Unit. "
