
with open('bwajobs.txt', 'w') as fp:
    for i in range(1,11):
        fp.write("module load SAMtools BWA; bwa mem ../Data/BWAIndex/genome.fa ../Data/Reads/reads_%(i)03d.fq > Results/out%(i)03d.sam && samtools sort -O bam -o Results/out%(i)03d.bam Results/out%(i)03d.sam\n" % locals())

with open('bwajobsbetter.txt', 'w') as fp:
    for i in range(1,11):
        fp.write("module load SAMtools BWA; bwa mem ../Data/BWAIndex/genome.fa ../Data/Reads/reads_%(i)03d.fq | samtools sort -O bam -o Results/out%(i)03d.bam -\n" % locals())

