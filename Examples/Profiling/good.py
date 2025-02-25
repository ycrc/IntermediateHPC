
'''
This function takes a file containing gene annotions, and another file with mapped reads,
and annotates the reads with the annotations.
This version does it in a more efficient way.
'''

from __future__ import print_function

@profile
def annotate(gf, mf, of):
    ofp=open(of, "w")
    geneinfo={}
    for l in open(gf):
        gn, chrm, strand, start, end = l.strip().split()
        geneinfo[gn]=[chrm, strand, start, end]

    for l in open(mf):
        e=l.strip().split()
        genename=e[-1]
        print('\t'.join(e + geneinfo[genename]), file=ofp)

if __name__=='__main__':
    annotate("genes.txt", "mappedreadswithgenes.txt", "goodgenes.out")
