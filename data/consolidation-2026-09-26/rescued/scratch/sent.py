import sys, re
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import claude_md_fact_audit as A
from collections import Counter
C = open("/home/kooshi/source/lean-dir/CLAUDE.md").read()
L = open("/home/kooshi/source/lean-dir/LEDGER.md").read()
def counts(t):
    f = A.facts(A.normalise(t)); c = Counter()
    for cls in A.STRONG:
        if cls=="name": continue
        for k,v in f[cls].items(): c[(cls,k)] += v
    return c
total = counts(C)+counts(L)
a,b = int(sys.argv[1]), int(sys.argv[2]); minb=int(sys.argv[3])
lines = C.split("\n")
seg = "\n".join(lines[a-1:b])
# split into sentences
parts = re.split(r"(?<=[.;])\s+(?=[A-Z*(`])", seg)
out=[]
for p in parts:
    if len(p.encode())<minb: continue
    if "*Do:" in p or "Killing test" in p or "Demotion record" in p or "PROTECTED" in p: continue
    c=counts(p); u=[k[1] for k,v in c.items() if total[k]-v<=0]
    out.append((len(u), -len(p.encode()), p))
out.sort()
for n,b,p in out[:int(sys.argv[4])]:
    print(f"[{-b}B uniq={n}] {p[:260]!r}")
