# The filing after FS132-L2's landing: its drafts 1-11 (plans/FS132-L2-landing.md § Drafts for the front page), each applied
# at its slot, each slot asserted to occur once. Texts are read from the record's block quotes, never retyped.
import re
R="/home/kooshi/source/lean-dir/"
def rd(p): return open(R+p).read()
def wr(p,s): open(R+p,"w").write(s)
rec=rd("plans/FS132-L2-landing.md"); i=rec.index("## Drafts for the front page (FS132-L2)"); j=rec.index("\n## ",i+5); D=rec[i:j]
def block(n):
    a=D.index(f"\n**{n}. "); m=re.search(r"\n\*\*%d\. "%(n+1),D); b=m.start() if m else len(D); return D[a:b]
def quotes(n):
    out=[]; cur=None
    for l in block(n).split("\n"):
        if l.startswith("> "):
            cur=(cur or [])+[l[2:]]
        elif l.strip()==">" and cur is not None: cur.append("")
        else:
            if cur: out.append(cur); cur=None
    if cur: out.append(cur)
    return out
def flat(lines): return re.sub(r"\s+"," "," ".join(lines)).strip()
def swap(s,old,new,name):
    assert s.count(old)==1,(name,s.count(old)); return s.replace(old,new)
# CLAUDE.md
C=rd("CLAUDE.md")
C=swap(C,"the current audit reads 6533 clean and 5 declared purchases, and 18 imported (and 20 axiom-free; 6,576 records at the landing of FS-132's import, FS132-L1, 2026-10-07)",flat(quotes(1)[0]),"D1")
a="its first import, `[Falconer1981]` Lemma 2 (i), is a theorem since FS131-IF1."
C=swap(C,a,a+" "+flat(quotes(2)[0]),"D2")
C=swap(C,"`declarations=14845 refutations-skipped=215 sites=1447`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1404 unknown=2`.",flat(quotes(4)[0]),"D4")
old6="Its Lean phase has begun, on the first night's exclusion (row 155; branches `fs132-wk1`, `fs132-wi2`), what the module rests on being formalized in that phase (his word of the same day); Closed when the module passes the gate."
new6=flat(quotes(6)[0])
C=swap(C,old6,new6,"D6"); C=swap(C,"no value moved; its Lean phase begun)","no value moved; its first theorem through the gate at the whole plane, FS132-L2)","D6b")
wr("CLAUDE.md",C); print("CLAUDE.md bytes",len(C.encode()))
F=rd("plans/FRONTIER-STUBS.md")
if F.count(old6)==1: F=F.replace(old6,new6); wr("plans/FRONTIER-STUBS.md",F); print("FRONTIER-STUBS: the same sentence replaced")
# the audit tool
T=rd("tools/claude_md_fact_audit.py")
g=re.search(r"```python\n(.*?)\n```",block(5),flags=re.S).group(1)
a='    (("6521", "5"), ("6533", "5")): "FS-132, the landing of the import of [OAIMath2026] family 158'
k=T.index(a); e=T.index("\n",k); assert '("6910", "5")' not in T
T=T[:e+1]+g+"\n"+T[e+1:]
a2='    "6554": "superseded gate count, refiled at FS132-L1\'s landing'
k=T.index(a2); e=T.index("\n",k)
T=T[:e+1]+'''    "6533": "superseded gate count, refiled at FS132-L2's landing from data/fs132/l2/gate/receipt-axioms-final.log (6910 clean); the old count stays in data/fs132/l1/gate/receipt-axioms-final.log and in GATE_CHANGES",
    "6576": "superseded gate count, refiled at FS132-L2's landing from data/fs132/l2/gate/receipt-axioms-final.log (6,953 records); the old count stays in data/fs132/l1/gate/receipt-axioms-final.log and in GATE_CHANGES",
'''+T[e+1:]
wr("tools/claude_md_fact_audit.py",T)
# LEDGER.md row 155
L=rd("LEDGER.md"); q7=quotes(7)
oldg="**[hand], one mind, with a line-by-line checking reading of its steps M4–M9 by a second mind — the kernel lane's planner, whose own blind route reached the state, the chart, a forced label at each hub, the unit-pair relation and the kill for a clean change, and stopped at the step lemma; steps M6 and M8 have one derivation each; kernel pending (the first module of FS-132's Lean phase).**"
L=swap(L,oldg,flat(q7[0]),"D7a")
L=swap(L,"kernel-checked there at every number of labels (the transfer of palettes for a pair; the 60° disjointness), and its nine steps M1–M9;","kernel-checked there at every number of labels and, ported, here (`Outside.OAI158.palette_transfer_pair`, `palette_sixty_disjoint`) (the transfer of palettes for a pair; the 60° disjointness), and its nine steps M1–M9, each now a kernel theorem;","D7b")
L=swap(L,"for the whole plane an instance of `[OAIMath2026]`'s Lean theorem `two_state_impossible`;","for the whole plane an instance of `[OAIMath2026]`'s Lean theorem `two_state_impossible`, in this library `SixRing.no_alternating_pairs` (`Plane/SixRing/TwoPairs.lean`, [kernel], the standard three, from the ported theorem);","D7c")
L=swap(L,"`plans/FS132-kernel-plan.md` on branch `fs132-wk1` | FS-132 (2026-10-07) |","`plans/FS132-kernel-plan.md`; `Proofs/HadwigerNelson/Plane/SixRing/` (`Orbit.lean`: the four theorems; `TwoPairs.lean`), `plans/FS132-L2-landing.md` | FS-132 (2026-10-07) |","D7d")
wr("LEDGER.md",L)
# the theorem record's two dated paragraphs
d=rd("plans/FS132-derivation.md"); q8=quotes(8); assert len(q8)==2 and "FS132-L2 — [kernel]" not in d
a="local form is planned second (K1 § 3.6)."; assert d.count(a)==1
d=d.replace(a,a+"\n\n"+flat(q8[0]))
a="\n## 2. One side of a unit circle"; assert d.count(a)==1
d=d.replace(a,"\n"+flat(q8[1])+"\n"+a)
wr("plans/FS132-derivation.md",d)
# LEAN.md
M=rd("LEAN.md"); q9=quotes(9); assert len(q9)==4,len(q9); assert "may be ported instead of imported" not in M
def bullets(lines):
    out=[]; cur=None
    for l in lines:
        if l.startswith("- "):
            if cur: out.append(cur)
            cur=[l]
        elif cur is not None: cur.append(l)
    if cur: out.append(cur)
    return [re.sub(r"\s+"," "," ".join(b)).strip() for b in out]
ls=M.split("\n")
k=[n for n,l in enumerate(ls) if l.startswith("- **An imported theorem carries four things**")]; assert len(k)==1
e=k[0]+1
while not ls[e].startswith("- **") and not ls[e].startswith("## "): e+=1
ls[e:e]=bullets(q9[0]); M="\n".join(ls)
a="(`hexShell_plane5` given `Outside.OAI158.no_proper_five_coloring`, FS132-L1)."; assert M.count(a)==1
M=M.replace(a,a+" "+flat(q9[3]))
ls=M.split("\n"); b=[n for n,l in enumerate(ls) if l.startswith("## The package")]; e=b[0]
while ls[e-1].strip()=="": e-=1
ls[e:e]=bullets(q9[1])+bullets(q9[2]); wr("LEAN.md","\n".join(ls))
# BIBLIOGRAPHY.md
B=rd("BIBLIOGRAPHY.md"); bl=B.split("\n"); k=[n for n,l in enumerate(bl) if l.startswith("| **[OAIMath2026]**")]; assert len(k)==1
row=bl[k[0]].rstrip(); assert row.endswith(" |") and "Ported into this library" not in row
bl[k[0]]=row[:-2]+" "+flat(quotes(10)[0])+" |"; wr("BIBLIOGRAPHY.md","\n".join(bl))
# the atlas: the exclusion's node
A=rd("tools/viz_proof_atlas_facts.py")
og='"[hand], one mind, with a line-by-line checking reading of its steps M4–M9 by a second mind", at='
assert A.count(og)==1
A=A.replace(og,'"[kernel] for a Borel colouring of the whole plane", at=')
op="No map, no Siamese clause.\""; assert A.count(op)==1
A=A.replace(op,"No map, no Siamese clause. Kernel-checked for the whole plane, over the release's lemmas ported with their proofs; the open-set form is by hand.\"")
oj='job="FS132-Z2", as_of="FS-132, six by the nerve, Derived (rows 155–160)"'; assert A.count(oj)==1
A=A.replace(oj,'job="FS132-L2", as_of="FS-132\'s first theorem through the gate (row 155, the whole plane)"')
wr("tools/viz_proof_atlas_facts.py",A)
print("filed")
