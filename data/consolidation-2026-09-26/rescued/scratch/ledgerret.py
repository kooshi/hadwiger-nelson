import sys, re
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import claude_md_fact_audit as A
C = open("/home/kooshi/source/lean-dir/CLAUDE.md").read()
Lg = A.normalise(open("/home/kooshi/source/lean-dir/LEDGER.md").read())
FL = A.facts(Lg)
lines=C.split("\n")
a=[i for i,l in enumerate(lines) if l.startswith("## Grokkings")][0]
b=[i for i,l in enumerate(lines) if l.startswith("## Whose work")][0]
seg="\n".join(lines[a:b])
parts = re.split(r"(?<=[.;])\s+(?=[A-Z*(`])", seg)
res=[]
for p in parts:
    if len(p.encode())<200: continue
    if "*Do:" in p or "Killing test" in p or "Demotion record" in p: continue
    f=A.facts(A.normalise(p))
    strong=[(c,k) for c in ("chunk","code","num","row","bib","date") for k in f[c] if not (c=="num" and len(k)<3)]
    if len(strong)<4: continue
    inL=[x for x in strong if x[1] in FL[x[0]]]
    frac=len(inL)/len(strong)
    res.append((frac,len(p.encode()),p))
res.sort(key=lambda x:(-x[0],-x[1]))
tot=0
for fr,bb,p in res[:40]:
    if fr<0.85: break
    tot+=bb
    print(f"[{fr:.2f} {bb}B] {p[:200]!r}")
print("total",tot)
