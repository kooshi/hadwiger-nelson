# The filing that makes FS-124 Derived: FS124-Z1's drafts (plans/FS124-Z1-record.md § Drafts for the front page) and the
# asking lane's re-rank (plans/POROS-2026-10-07-fs124-round2.md § Draft re-rank). Texts are read from the two records.
import re
R="/home/kooshi/source/lean-dir/"
def rd(p): return open(R+p).read()
def wr(p,s): open(R+p,"w").write(s)
def swap(s,old,new,name):
    assert s.count(old)==1,(name,s.count(old)); return s.replace(old,new)
def wsre(t): return r"\s+".join(re.escape(x) for x in t.split())
rec=rd("plans/FS124-Z1-record.md"); i=rec.index("## Drafts for the front page"); j=rec.index("\n## Stage 7",i); D=rec[i:j]
P=rd("plans/POROS-2026-10-07-fs124-round2.md"); pi=P.index("## Draft re-rank"); pj=P.index("\n## ",pi+5); PR=P[pi:pj]
# 1. LEDGER rows 161-164
L=rd("LEDGER.md"); ll=L.split("\n"); rows=[l for l in D.split("\n") if re.match(r"\| 16[1-4] \| \*\*",l)]; assert len(rows)==4
k=[n for n,l in enumerate(ll) if l.startswith("| 160 | ")]; assert len(k)==1 and not any(l.startswith("| 161 |") for l in ll)
ll[k[0]+1:k[0]+1]=rows; wr("LEDGER.md","\n".join(ll))
# 2. CLAUDE.md: the record's seven slots
a=D.index("### `CLAUDE.md` § Frontier and § The aim"); b=D.index("**Held for the landing of branch `fs124-wk1`"); S=D[a:b]
pairs=re.findall(r"\*Replaces, exactly:\*\n\n> (.*?)\n\n\*With:\*\n\n> (.*?)\n\n\*Net change",S,flags=re.S); assert len(pairs)==7,len(pairs)
C=rd("CLAUDE.md"); n0=len(C.encode())
for old,new in pairs:
    new=new.replace("its successor FS-136 named;","its successor FS-136 opened;").replace("(`plans/STUB-covering-pairs.md`), Not started.","(`plans/STUB-covering-pairs.md`), Opened 2026-10-07.")
    C=swap(C,old,new,old[:40])
# the top three (the asking lane's draft), the successor numbered
T=PR[PR.index("**The top three as `CLAUDE.md`"):]
t1=[l for l in T.split("\n") if l.startswith("| 1 | **the point across**")]; assert len(t1)==1
row1=t1[0].replace("| 1 | **the point across** —","| 1 | **FS-136 the point across** —").replace("`plans/STUB-covering-pairs.md` |","`plans/STUB-covering-pairs.md` (Opened 2026-10-07) |",1)
cl=C.split("\n"); k=[n for n,l in enumerate(cl) if l.startswith("| 1 | **FS-124 the unit arc**")]; assert len(k)==1
assert cl[k[0]+1].startswith("| 2 | **FS-135 the seed remainder**") and cl[k[0]+2].startswith("| 3 | **FS-127 lateral extent**")
cl[k[0]]=row1
r3=cl[k[0]+2].rstrip(); assert r3.endswith(" |"); cl[k[0]+2]=r3[:-2]+" — the seed every statement of FS-124 begins with \"if\" about |"
C="\n".join(cl); wr("CLAUDE.md",C); print("CLAUDE.md bytes",n0,"->",len(C.encode()))
# 3. FRONTIER-STUBS: the open-milestones sentence; the ranked table
F=rd("plans/FRONTIER-STUBS.md")
old,new=pairs[1]; new=new.replace("(`plans/STUB-covering-pairs.md`), Not started.","(`plans/STUB-covering-pairs.md`), Opened 2026-10-07.")
F=swap(F,old,new,"FS open-milestones")
fl=F.split("\n"); k=[n for n,l in enumerate(fl) if l.startswith("| 1 | **FS-124 the unit arc")]; assert len(k)==1
s1=[l for l in PR.split("\n") if l.startswith("| 1 | **the point across: a ring's covering pairs**")]; assert len(s1)==1
r=s1[0].replace("| 1 | **the point across: a ring's covering pairs**","| 1 | **FS-136 the point across: a ring's covering pairs**")
parts=r.split(" | "); assert len(parts)==7,len(parts); assert parts[5].strip()=="Not started"; parts[5]="Opened 2026-10-07 (FS-136 inventory item 1)"; fl[k[0]]=" | ".join(parts)
flatP=re.sub(r"\s*\n\s*"," ",PR)
c122=re.search(r'\*\*4 FS-122 the forced pair\*\*, with this clause at the end of its bearing cell: "(.*?)"; 5 FS-128',flatP).group(1)
c117=re.search(r'\*\*9 FS-117 route T\*\*, with this clause: "(.*?)"; the rest as filed',flatP).group(1)
def addcell(prefix,idx,text):
    k=[n for n,l in enumerate(fl) if l.startswith(prefix)]; assert len(k)==1,prefix
    parts=fl[k[0]].split(" | "); assert len(parts)==7,(prefix,len(parts)); parts[idx]=parts[idx].rstrip()+"; "+text; fl[k[0]]=" | ".join(parts)
addcell("| 4 | **FS-122 the forced pair**",3,c122); addcell("| 9 | **FS-117 route T",2,c117)
F="\n".join(fl); ranks=[int(re.match(r"\| (\d+) \|",l).group(1)) for l in F.split("\n") if re.match(r"\| \d+ \| \*\*",l)]; assert ranks==list(range(1,73))
wr("plans/FRONTIER-STUBS.md",F)
# 4. the grokkings: G97 amended with its demotion record; G99; G92's Do
G=rd(".claude/skills/grokkings/SKILL.md"); g0=len(G.encode())
gq=[re.sub(r"\s+"," "," ".join(l[2:] if l.startswith("> ") else "" for l in blk.split("\n"))).strip() for blk in re.findall(r"((?:^>.*\n)+)",D[D.index("**G97, amended in place**"):D.index("**Not proposed, and why.**")],flags=re.M)]
assert len(gq)==2,len(gq); g97,g99=gq
st=re.search(r"\*Status:\* \*\*(\[.*?\])\*\*",g97).group(1); dem=re.search(r"\*Demotion record \(FS-124, 2026-10-07\):\* (.*?) \*Do, amended:\*",g97).group(1)
do=re.search(r"\*Do, amended:\* (.*?) \*Killing test, amended:\* (.*)$",g97); assert do
G=swap(G,"[reading, one mind (the asking lane's identification of the two appearances as one object, unchecked); measured on three rounds and one search]",st,"G97 status")
a="and G84 says why a tight colouring has it everywhere: contact."
olddo=re.search(re.escape(a)+r" \*Do: before calling an exclusion in the measurable class progress.*?then the line was no wall\.\*",G,flags=re.S); assert olddo
G=G.replace(olddo.group(0),a+" **Demoted in part (FS-124, 2026-10-07):** "+dem+" *Do: "+do.group(1)[0].lower()+do.group(1)[1:]+" Killing test: "+do.group(2)+"*")
assert g99.startswith("* **G99 —") and "* **G99 —" not in G
gl=G.split("\n"); k=[n for n,l in enumerate(gl) if l.startswith("* **G51 —")]; assert len(k)==1; gl[k[0]:k[0]]=[g99]; G="\n".join(gl)
m1=re.search(wsre("restate it without them before asking where else it bears;"),G); assert m1 and len(re.findall(wsre("restate it without them before asking where else it bears;"),G))==1
G=G[:m1.end()]+" **and before posing a claim as open in another class, search the derivation files — not the ledger rows — of the milestones the stub cites for the entry the claim would restate, and name that entry in the claim;**"+G[m1.end():]
m2=re.search(wsre("a second milestone about to re-derive a near neighbour"),G); assert m2 and len(re.findall(wsre("a second milestone about to re-derive a near neighbour"),G))==1
G=G[:m2.end()]+", **or a card written from a reading of objects**"+G[m2.end():]
wr(".claude/skills/grokkings/SKILL.md",G); print("grokkings bytes",g0,"->",len(G.encode())); assert len(G.encode())<200000
# 5. the instances
I=rd("plans/GROKKING-INSTANCES.md"); il=I.split("\n")
iq=[re.sub(r"\s+"," "," ".join(l[2:] for l in blk.split("\n") if l.startswith("> "))).strip() for blk in re.findall(r"((?:^>.*\n)+)",D[D.index("### `plans/GROKKING-INSTANCES.md`"):D.index("### `BIBLIOGRAPHY.md`")],flags=re.M)]
assert len(iq)==2 and "three headlines larger than their statements" not in I
def add(prefix,para):
    k=[n for n,l in enumerate(il) if l.startswith(prefix)]; assert len(k)==1,prefix
    e=k[0]+1
    while e<len(il) and not il[e].startswith("## "): e+=1
    while il[e-1].strip()=="": e-=1
    il[e:e]=["",para]
add("## G21 — ",iq[0]); add("## G92 — ",iq[1]); wr("plans/GROKKING-INSTANCES.md","\n".join(il))
# 6. a banner in the milestone's stub
s=rd("plans/STUB-q-ring.md"); sl=s.split("\n"); assert sl[0].startswith("# ") and sl[1]==""
sl[2:2]=["> **Derived 2026-10-07 (FS124-Z1; `plans/FS124-derivation.md`, 30 entries; ledger rows 161–164).** Its eight cases pass to its successor, FS-136, the point across (`plans/STUB-covering-pairs.md`). Closed when its Lean modules pass the gate: the first is complete on a branch, the second is being planned.",""]
wr("plans/STUB-q-ring.md","\n".join(sl))
print("filed")
