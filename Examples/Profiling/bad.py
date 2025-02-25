'''
This function takes a file containing gene annotions, and another file with mapped reads,
and annotates the reads with the annotations.
This version does it in a very inefficient way.
'''

from __future__ import print_function

def annotate(gf, mf, of):
    ofp=open(of, "w")
    genenames=[]
    geneinfo=[]
    for l in open(gf):
        gn, chrm, strand, start, end = l.strip().split()
        genenames.append(gn)
        geneinfo.append([chrm, strand, start, end])

    for l in open(mf):
        e=l.strip().split()
        genename=e[-1]
        idx=genenames.index(genename)
        print('\t'.join(e + geneinfo[idx]), file=ofp)

if __name__=='__main__':
    annotate("genes.txt", "mappedreadswithgenes.txt", "badgenes.out")
