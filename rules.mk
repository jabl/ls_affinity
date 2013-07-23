CFLAGS := -O2 -g

SRC := mpi_ls_affinity.c
EXEC := mpi_ls_affinity mpi_ls_affinity_openmp mpi_ls_affinity_mpi mpi_ls_affinity_mpi_openmp

LIBS := -lhwloc

all: $(SRC) $(EXEC)

mpi_ls_affinity: $(SRC)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

mpi_ls_affinity_openmp: $(SRC)
	$(CC) $(OPENMP_FLAG) $(CFLAGS) -o $@ $^ $(LIBS)

mpi_ls_affinity_mpi: $(SRC)
	$(MPICC) -DMPI $(CFLAGS) -o $@ $^ $(LIBS)

mpi_ls_affinity_mpi_openmp: $(SRC)
	$(MPICC) -DMPI $(OPENMP_FLAG) $(CFLAGS) -o $@ $^ $(LIBS)

clean:
	rm -rf $(EXEC)
