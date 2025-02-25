
all: mm mm2

mm: mm.c
	gcc -o mm -fopenmp mm.c

mm2: mm2.c
	gcc -o mm2 -fopenmp mm2.c

clean:
	rm -f mm mm2 dotprod core.* slurm*.out


