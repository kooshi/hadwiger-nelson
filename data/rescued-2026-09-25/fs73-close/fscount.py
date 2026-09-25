import re,sys
t=open('/home/kooshi/source/lean-dir/plans/FRONTIER-STUBS.md').read().split('\n')
N=int(sys.argv[1]) if len(sys.argv)>1 else 78
cnt={n:[] for n in range(1,N+1)}
for i,l in enumerate(t,1):
    m=None
    if l.startswith('|') or l.startswith('* '):
        # the row's id: first FS-n in the first two cells
        cells=l.split('|')
        head=' '.join(cells[:3]) if l.startswith('|') else l[:120]
        m=re.search(r'FS-(\d+)\b',head)
    if m:
        n=int(m.group(1))
        if n in cnt: cnt[n].append(i)
bad={n:v for n,v in cnt.items() if len(v)!=1}
print('ids not exactly once:',bad)
