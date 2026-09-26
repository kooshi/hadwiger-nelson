import sys, re
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import claude_md_fact_audit as A
C = open("/home/kooshi/source/lean-dir/CLAUDE.md").read().split("\n")
F = open("/home/kooshi/source/lean-dir/plans/FRONTIER-STUBS.md").read().split("\n")
def toks(t):
    f = A.facts(A.normalise(t)); s=set()
    for cls in A.STRONG:
        if cls=="name": continue
        s |= set(f[cls])
    return s
frows = {}
for l in F:
    if l.startswith("| "):
        for fs in re.findall(r"FS-\d+", l.split("|")[2] if l.count("|")>2 else ""):
            frows.setdefault(fs, []).append(l)
tot=0
for i,l in enumerate(C):
    if re.match(r"^\| [\d–]+ \|", l) and 275 < i < 330:
        cell = l.split("|")[2]
        ids = re.findall(r"FS-\d+", cell)
        ft = "\n".join(x for fs in ids for x in frows.get(fs, []))
        miss = toks(l) - toks(ft)
        print(f"L{i+1} {len(l.encode()):5d} {ids[:3]} FSbytes={len(ft.encode())} missing={sorted(miss)}")
        tot += len(l.encode())
print("table bytes", tot)
