# Intermediate HPC — Command Reference

Commands from the **Intermediate HPC (2026.10.06)** workshop by the Yale Center for Research Computing (YCRC).

- Examples repo: <https://github.com/ycrc/IntermediateHPC>
- Slides: <http://tinyurl.com/Intermediate-HPC>
- Documentation: <https://docs.ycrc.yale.edu>

> Replace placeholders like `JOBID`, `NetID`, and `<PATH>` with your own values.

## Examples Setup

Clone the repo:

```bash
cd <PATH>
mkdir repos
cd repos
git clone https://github.com/ycrc/IntermediateHPC.git
```

---

## Job-level Acceleration: Resource optimization

```bash
cd IntermediateHPC/Examples/Alphafold
cat alphafold-bad.sh
cat alphafold-msa.sh
cat alphafold-model.sh
```

## Job-level Acceleration: Slurm Job Arrays

### Serial job (for-loop) example

```bash
cd ../Serialjob
cat serial.sh
sbatch serial.sh
squeue --me
cat slurm-JOBID.out
seff JOBID
```

### Array job exercise

```bash
cd ../Arrayjob
cat array.sh
sbatch array.sh
squeue --me
seff-array JOBID
sacct -j JOBID
```

### dSQ (dead Simple Queue)

```bash
cd ../dSQ
cat bwajobs.txt
module load dSQ
dSQ --help
dSQ --job-file bwajobs.txt --time=15:00 --mem=8G -p day
cat dsq-bwajobs-2026-10-06.sh
```

Submit, monitor, and resubmit failed jobs:

```bash
sbatch dsq-bwajobs-2026-10-06.sh
squeue --me
dsqa -j JOBID
seff-array JOBID
dsqa -j JOBID -f bwajobs.txt -s FAILED > failedbwajobs.txt
dSQ --job-file failedbwajobs.txt --time=15:00 --mem=8G -p day
```

---

##  Application Acceleration (NAMD)

### Single CPU

```bash
cd ../NAMD
cat single.sh
jobstats JOBID         # or: seff JOBID  (use ID from single-JOBID.out)
```

### Multithreading (8 CPUs)

```bash
cat multi.sh
sbatch multi.sh
tail -f multi-JOBID.out
# ssh to the node and run top
jobstats JOBID
```

### Multithreading (16 CPUs)

```bash
cat multi2.sh
sbatch multi2.sh
squeue --me
tail -f multi2-JOBID.out
# ssh to the node and run top
jobstats JOBID
```

### MPI

```bash
cat mpi.sh
sbatch mpi.sh
squeue --me            # may show more than one node
# ssh to a node and run top
jobstats JOBID
```

### GPU

```bash
cat gpu.sh
sbatch gpu.sh
tail -f gpu-JOBID.out
# ssh to the node and run top
jobstats JOBID
```

---

## Code Acceleration: R

Serial bootstrap (use the ID from `boot-JOBID.out`):

```bash
cd ../R
cat boot.R
jobstats JOBID
```

Multicore bootstrap:

```bash
cat mcboot.R
sbatch mcboot.sh
jobstats JOBID
```

Cluster bootstrap:

```bash
cat parallelboot.R
sbatch parallelboot.sh
jobstats JOBID
```

MPI bootstrap:

```bash
cat mpiboot.R
sbatch mpiboot.sh      # may show more than one node
jobstats JOBID
```

---

## Code Acceleration: Python Profiling

```bash
cd ../Profiling
cat bad.py
```

Create a conda environment in an interactive session:

```bash
salloc -p devel --mem=32G --cpus-per-task=4
module load miniconda
conda env create -f profiler_env.yaml
```

Profile the slow version:

```bash
conda activate profiler
cat bad2.py
LINE_PROFILE=1 python bad2.py
python -m line_profiler -r profile_output.lprof
```

Profile the optimized version:

```bash
cat good.py
LINE_PROFILE=1 python good.py
python -m line_profiler -rmtz profile_output.lprof
```

---











