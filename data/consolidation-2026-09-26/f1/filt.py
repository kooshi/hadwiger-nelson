import re,sys
t=open(sys.argv[1]).read().split('--- ')[1:]
skip=re.compile(r'^(Frontier|Where the problem stands|The novel-results ledger|Paths forward|The mission|Closed as directions|The open structural)')
bmax=float(sys.argv[2]) if len(sys.argv)>2 else 0.5
for e in t:
    m=re.match(r'\[(.*?)\] a=([\d.]+) b=([\d.]+) c=([\d.]+)',e)
    if not m: continue
    if skip.match(m.group(1)) and '--all' not in sys.argv: continue
    if float(m.group(3))<bmax: print('--- '+e.strip())
