# The filing that makes FS-132 Derived: FS132-Z2's drafts (plans/FS132-Z2-record.md § Drafts for the front page), FS132-Z1's two
# ledger drafts, and the asking lane's first unfiled sentence for G94 — each applied at its slot, each slot asserted to occur once.
import importlib.util,re
R="/home/kooshi/source/lean-dir/"
spec=importlib.util.spec_from_file_location("z2",R+"tools/fs132_z2_frontpage.py"); z=importlib.util.module_from_spec(spec); spec.loader.exec_module(z)
def rd(p): return open(R+p).read()
def wr(p,s): open(R+p,"w").write(s)
def after(s,slot,text,name):
    assert s.count(slot)==1,(name,s.count(slot)); assert text.strip()[:60] not in s,(name,"already filed")
    return s.replace(slot,slot+text)
def swap(s,old,new,name):
    assert s.count(old)==1,(name,s.count(old)); return s.replace(old,new)
rec=rd("plans/FS132-Z2-record.md"); z1=rd("plans/FS132-Z1-record.md")
def z1draft(sec):
    i=z1.index(sec); j=z1.index("\n### ",i+5); m=[l for l in z1[i:j].split("\n") if l.startswith("> ")]; assert len(m)==1,sec
    return m[0][2:]
# 1. LEDGER.md
L=rd("LEDGER.md"); rows=[]
for n in range(155,161):
    r=z.fill(z.ROWS[n]); assert r in rec and "\n" not in r and "??" not in r; rows.append(r)
assert not z.ERR,z.ERR
ls=L.split("\n"); k=[i for i,l in enumerate(ls) if l.startswith("| 154 | **The map step at five, as an equivalence:**")]; assert len(k)==1
assert not any(l.startswith("| 155 |") for l in ls)
ls[k[0]+1:k[0]+1]=rows; L="\n".join(ls)
L=after(L,"a GAP at cusp vertices",z1draft("### 5.1"),"row 133")
note=" "+z1draft("### 5.2")
assert L.count("(SQ9 at nine meets every other hypothesis).")==1 and L.count("(FS129-SR1's attacks on the chain's two named steps found no gap — checking readings, not second minds).")==1
L=L.replace("(SQ9 at nine meets every other hypothesis).","(SQ9 at nine meets every other hypothesis)."+note)
L=L.replace("(FS129-SR1's attacks on the chain's two named steps found no gap — checking readings, not second minds).","(FS129-SR1's attacks on the chain's two named steps found no gap — checking readings, not second minds)."+note)
wr("LEDGER.md",L)
# 2. CLAUDE.md — six slots; the coordinator's one qualifier in item 31's sentence (FS-132 inventory item 35 (d)); the row count
C=rd("CLAUDE.md"); n0=len(C.encode())
for name,old,new in z.CL:
    if "item 31 — its last sentence" in name:
        q="and the turning ring places a four-label point"; assert new.count(q)==1
        new=new.replace(q,"and a turning ring in step form with witnesses near the centre places a four-label point")
    C=swap(C,old,new,name)
C=swap(C,"**Rows 1–154 live in `LEDGER.md`**","**Rows 1–160 live in `LEDGER.md`**","row count")
wr("CLAUDE.md",C); print("CLAUDE.md bytes",n0,"->",len(C.encode()))
# 3. the grokkings
G=rd(z.G); g0=len(G.encode())
ls=G.split("\n"); k=[i for i,l in enumerate(ls) if l.startswith("* **G51 —")]; assert len(k)==1 and ls[k[0]-1].strip()!=""
assert "* **G96 —" not in G
ls[k[0]:k[0]]=[z.G96,z.G97,z.G98]; G="\n".join(ls)
G=after(G,"a control the instrument cannot see is\n  not a control.",z.G21_ADD,"G21")
G=after(G,"never ask a selection from a cover to be saturated unless the cover is a partition.",z.G84_ADD,"G84")
G=after(G,"and given a NO for honest saturated colourings it is the answer (FS121-D3-EQ).",z.G89_ADD,"G89")
p2=rd("plans/POROS-2026-10-07-fs132-night.md"); i=p2.index("### Draft for `.claude/skills/grokkings/SKILL.md`, G94"); j=p2.index("\n### ",i+5)
m=re.search(r'"(What the exclusions derived so far read at a centre.*?)"',p2[i:j],flags=re.S); assert m
s94=" "+re.sub(r"\s+"," ",m.group(1))+" What joins a centre to that data, and what does not: G96."
G=after(G,"finiteness on a disc of radius above 1 suffices and is not necessary).",s94,"G94")
wr(z.G,G); print("grokkings bytes",g0,"->",len(G.encode())); assert len(G.encode())<200000
# 4. the instances
I=rd("plans/GROKKING-INSTANCES.md"); ls=I.split("\n")
def section_end(prefix):
    k=[i for i,l in enumerate(ls) if l.startswith(prefix)]; assert len(k)==1,(prefix,len(k))
    e=k[0]+1
    while e<len(ls) and not ls[e].startswith("## "): e+=1
    return e
def add(prefix,paras):
    e=section_end(prefix)
    while ls[e-1].strip()=="": e-=1
    ins=[]
    for p in paras: ins+=["",p]
    ls[e:e]=ins
assert "FS-132 (2026-10-07), controls with a margin" not in I
for key,prefix in (("G21","## G21 — "),("G84","## G84 — "),("G87","## G87 — "),("G92","## G92 — ")):
    add(prefix,z.INST[key])
e=section_end("## G87 — "); ls[e:e]=["## G89 — Honesty is free","",z.INST["G89"][0],""]
e=section_end("## G92 — "); ls[e:e]=["## G95 — Tightness is not regularity","",z.INST["G95"][0],""]
wr("plans/GROKKING-INSTANCES.md","\n".join(ls))
# 5. the atlas facts
A=rd("tools/viz_proof_atlas_facts.py"); ls=A.split("\n"); assert 'N("MEXCL"' not in A
k=[i for i,l in enumerate(ls) if l.startswith('N("QPRUNE"')]; assert len(k)==1
e=k[0]
while 'sector="seven")' not in ls[e]: e+=1
nodes=[c for c,_ in z.ATLAS if c.startswith("N(")]; edges=[c for c,_ in z.ATLAS if c.startswith("E(")]; assert len(nodes)==6 and len(edges)==2
ls[e+1:e+1]=nodes
k=[i for i,l in enumerate(ls) if l.startswith('E("QFREE", "LOCALF"')]; assert len(k)==1 and ls[k[0]].rstrip().endswith(")")
ls[k[0]+1:k[0]+1]=edges
wr("tools/viz_proof_atlas_facts.py","\n".join(ls))
# 6. the bibliography
B=rd("BIBLIOGRAPHY.md")
B=after(B,z.BIB_SLOT[1]," Cited by FS-132's C132-NOESS for a textbook fact (§ 1.2 and Proposition 1.26), recalled, not read.","Hatcher")
wr("BIBLIOGRAPHY.md",B)
# 7. the stub list: the same two sentences as the front page's, and the two new stubs named, unranked
F=rd("plans/FRONTIER-STUBS.md")
for name,old,new in z.CL[1:3]:
    if F.count(old)==1: F=F.replace(old,new); print("FRONTIER-STUBS: replaced —",name[:60])
    else: print("FRONTIER-STUBS: slot absent (",F.count(old),") —",name[:60])
slot="where every exclusion of FS-132 stops."
if F.count(slot)==1:
    F=F.replace(slot,slot+" **Minted by FS-132's record job (2026-10-07), unranked until the asking lane's next re-rank: FS-134, the exclusion back to maps** (`plans/STUB-exclusion-back-to-maps.md`) **and FS-135, the seed's remainder** (`plans/STUB-seed-remainder.md`).")
    print("FRONTIER-STUBS: the two new stubs named")
wr("plans/FRONTIER-STUBS.md",F)
print("filed")
