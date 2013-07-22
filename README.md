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
