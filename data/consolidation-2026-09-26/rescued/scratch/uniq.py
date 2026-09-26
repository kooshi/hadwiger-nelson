import sys, re
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import claude_md_fact_audit as A
from collections import Counter
C = open("/home/kooshi/source/lean-dir/CLAUDE.md").read()
L = open("/home/kooshi/source/lean-dir/LEDGER.md").read()
def toks(t):
    f = A.facts(A.normalise(t))
    s = set()
    for cls in A.STRONG:
        for k in f[cls]: s.add((cls,k))
    return s
def counts(t):
    f = A.facts(A.normalise(t)); c = Counter()
    for cls in A.STRONG:
        for k,v in f[cls].items(): c[(cls,k)] += v
    return c
total = counts(C) + counts(L)
# blocks: split CLAUDE.md into units
lines = C.split("\n")
units = []  # (start_line, text)
cur=[]; start=0
def flush():
    global cur
    if cur: units.append((start, "\n".join(cur)))
    cur=[]
for i,l in enumerate(lines):
    newunit = (not l.strip()) or l.startswith("|") or re.match(r"^\* \*\*G\d+", l) or re.match(r"^\d+\. \*\*", l) or l.startswith("#") or re.match(r"^- ", l)
    if newunit:
        flush(); start=i
        if l.strip(): cur=[l]
    else:
        if not cur: start=i
        cur.append(l)
flush()
mode = sys.argv[1] if len(sys.argv)>1 else "units"
res=[]
for s,t in units:
    c = counts(t)
    uniq = [k for k,v in c.items() if total[k]-v <= 0]
    res.append((len(t.encode()), s+1, len(uniq), uniq, t[:90].replace("\n"," ")))
res.sort(reverse=True)
for b,s,n,u,t in res[:int(sys.argv[2]) if len(sys.argv)>2 else 60]:
    print(f"{b:6d} L{s:5d} uniq={n:3d} {t}")
if mode=="range":
    a,b = int(sys.argv[3]), int(sys.argv[4])
    for s,t in units:
        if a <= s+1 <= b:
            c = counts(t); uniq = [k[1] for k,v in c.items() if total[k]-v <= 0]
            print(f"{len(t.encode()):6d} L{s+1:5d} uniq={len(uniq):3d} {t[:60]!r} :: {uniq}")
