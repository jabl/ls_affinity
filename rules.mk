CFLAGS := -O2 -g

SRC := ls_affinity.c
EXEC := ls_affinity ls_affinity_openmp ls_affinity_mpi ls_affinity_mpi_openmp

LIBS := -lhwloc

all: $(SRC) $(EXEC)

ls_affinity: $(SRC)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

ls_affinity_openmp: $(SRC)
	$(CC) $(OPENMP_FLAG) $(CFLAGS) -o $@ $^ $(LIBS)

ls_affinity_mpi: $(SRC)
	$(MPICC) -DMPI $(CFLAGS) -o $@ $^ $(LIBS)

ls_affinity_mpi_openmp: $(SRC)
	$(MPICC) -DMPI $(OPENMP_FLAG) $(CFLAGS) -o $@ $^ $(LIBS)

clean:
	rm -rf $(EXEC)
