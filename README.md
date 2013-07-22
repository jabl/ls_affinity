mpi_ls_affinity
===============

Check CPU affinity for each MPI rank. This program is mainly meant as
a debugging aid for understanding the interaction between MPI runtimes
and workload managers.

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

The out-of-the-box makefile assumes GCC. If you use another compiler
such as ICC, just edit the first few lines of the Makefile.


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

Running 2 MPI processes with 4 threads per rank, by default with
OpenMPI 1.4 one gets e.g.

	$ OMP_NUM_THREADS=4 mpirun -n 2 ./mpi_ls_affinity_mpi_openmp 
	MPI rank 0 thread 0 running on 0x000000ff
	MPI rank 1 thread 0 running on 0x000000ff
	MPI rank 0 thread 1 running on 0x000000ff
	MPI rank 0 thread 3 running on 0x000000ff
	MPI rank 0 thread 2 running on 0x000000ff
	MPI rank 1 thread 3 running on 0x000000ff
	MPI rank 1 thread 1 running on 0x000000ff
	MPI rank 1 thread 2 running on 0x000000ff

By setting the affinity for both OpenMP and OpenMPI one gets

	$ GOMP_CPU_AFFINITY=0-8 OMP_NUM_THREADS=4 mpirun -n 2 -bind-to-core -cpus-per-proc 4 ./mpi_ls_affinity_mpi_openmp 
	MPI rank 0 thread 0 running on 0x00000001
	MPI rank 1 thread 0 running on 0x00000010
	MPI rank 0 thread 1 running on 0x00000002
	MPI rank 0 thread 3 running on 0x00000008
	MPI rank 0 thread 2 running on 0x00000004
	MPI rank 1 thread 2 running on 0x00000040
	MPI rank 1 thread 1 running on 0x00000020
	MPI rank 1 thread 3 running on 0x00000080
