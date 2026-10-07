# The filing after FS124-L1's landing: its drafts 1-12 (plans/FS124-L1-landing.md § Drafts for the front page), each applied at
# its slot, each slot asserted to occur once. Texts are read from the record's block quotes, never retyped. Nothing is written
# until every slot has been found.
import re
R="/home/kooshi/source/lean-dir/"
def rd(p): return open(R+p).read()
OUT={}
rec=rd("plans/FS124-L1-landing.md"); i=rec.index("## Drafts for the front page (FS124-L1)"); j=rec.index("\n## Open gate items at this landing",i); D=rec[i:j]
def block(n):
    a=D.index(f"\n**{n}. "); m=re.search(r"\n\*\*%d\. "%(n+1),D); b=m.start() if m else len(D); return D[a:b]
def quotes(n):
    out=[]; cur=None
    for l in block(n).split("\n"):
        s=l.strip()
        if s.startswith("> "): cur=(cur or [])+[s[2:]]
        elif s==">" and cur is not None: cur.append("")
        else:
            if cur: out.append(cur); cur=None
    if cur: out.append(cur)
    return out
def flat(lines): return re.sub(r"\s+"," "," ".join(lines)).strip()
def swap(s,old,new,name):
    assert s.count(old)==1,(name,s.count(old)); return s.replace(old,new)
def swapws(s,old,new,name):
    pat=r"\s+".join(re.escape(t) for t in old.split()); ms=list(re.finditer(pat,s)); assert len(ms)==1,(name,len(ms))
    return s[:ms[0].start()]+new+s[ms[0].end():]
# ---- CLAUDE.md
C=rd("CLAUDE.md")
C=swap(C,"the current audit reads 6910 clean and 5 declared purchases, and 18 imported (and 20 axiom-free; 6,953 records at the landing of FS-132's first theorem, FS132-L2, 2026-10-07)",flat(quotes(1)[0]),"D1")
C=swap(C,"— no map `ℂ → Fin 5` separates every unit pair — with five, and","— no map `ℂ → Fin 5` separates every unit pair — with six, and","D2a")
C=swap(C,"— a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair — with five;","— a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair — with nine;","D2b")
C=swap(C,"`axioms=3 rests=18 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — three outside theorems declared as axioms, with eighteen theorems resting on them;",flat(quotes(3)[0]),"D3")
C=swap(C,"`declarations=15292 refutations-skipped=226 sites=1447`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1404 unknown=2`.",flat(quotes(4)[0]),"D4")
a="Falconer's everywhere-proper `χ_m` is one step further, a GAP; by Thm 1.4 `χ_m(ℝ²) ≥ χ_m⁰(ℝ²) ≥ 6`."
C=swap(C,a,a+" "+flat(quotes(6)[0]),"D6")
C=swap(C,"no value moved; its first Lean module complete on a branch, its landing owed)","no value moved; its first Lean module, the disc criterion, through the gate, FS124-L1)","D9a")
old9="Its first Lean module, the disc criterion, is complete on branch `fs124-wk1` (57 theorems; kernel-checked on a branch, not through the gate; its landing is owed); its second is being planned; Closed when its modules pass the gate."
q9=[q for q in quotes(9) if q[0].startswith("Its first Lean module")]; assert len(q9)==1
new9=flat(q9[0])
C=swap(C,old9,new9,"D9b")
C=swap(C,"the direction toward seven over the outside theorem on Borel transfer (row 161);","the direction toward seven over the outside theorem on Borel transfer (row 161, [kernel] since FS124-L1);","D9c")
# the one occurrence the landing's list did not find: § The aim, link 5 (the coordinator's own minimal wording, mirroring D9c)
C=swap(C,"(row 161; [hand], one mind; kernel-checked on a branch)","(row 161; [kernel] since FS124-L1)","aim5")
OUT["CLAUDE.md"]=C
F=rd("plans/FRONTIER-STUBS.md")
if F.count(old9)==1: OUT["plans/FRONTIER-STUBS.md"]=F.replace(old9,new9)
S=rd("plans/STUB-q-ring.md")
S=swapws(S,"the first is complete on a branch, the second is being planned","the first is through the gate (FS124-L1), the second is being planned","D9d")
S=swapws(S,"(§ 1; its module complete on branch `fs124-wk1`, kernel-checked on a branch, not through the gate, not held)","(§ 1; its module through the gate, FS124-L1 — [kernel], the half toward seven on one declared outside theorem)","D9e")
OUT["plans/STUB-q-ring.md"]=S
# ---- the audit tool
T=rd("tools/claude_md_fact_audit.py")
g=re.search(r"```python\n(.*?)\n```",block(5),flags=re.S).group(1)
a='    (("6533", "5"), ("6910", "5")): '; k=T.index(a); e=T.index("\n",k); assert '("6967", "5")' not in T
T=T[:e+1]+g+"\n"+T[e+1:]
a2='    "6576": "superseded gate count, refiled at FS132-L2\'s landing'; assert T.count(a2)==1; k=T.index(a2); e=T.index("\n",k)
T=T[:e+1]+'''    "6910": "superseded gate count, refiled at FS124-L1's landing from data/fs124/l1/gate/receipt-axioms-final.log (6967 clean); the old count stays in data/fs132/l2/gate/receipt-axioms-final.log and in GATE_CHANGES",
    "6953": "superseded gate count, refiled at FS124-L1's landing from data/fs124/l1/gate/receipt-axioms-final.log (7,015 records); the old count stays in data/fs132/l2/gate/receipt-axioms-final.log and in GATE_CHANGES",
'''+T[e+1:]
OUT["tools/claude_md_fact_audit.py"]=T
# ---- LEDGER.md row 161
L=rd("LEDGER.md")
oldg="**Grade:** [hand] or derived from [hand] entries, one mind each, kernel pending. **Kernel-checked on a branch, not through the gate, not held** (`fs124-wk1`, 57 theorems): `colorable_iff_forall_ball` and `seven_le_chromaticNumber_plane_iff_exists_ball`, each on the standard three axioms and that one declared outside theorem; (up) and its contrapositive on the standard three alone."
L=swap(L,oldg,flat(quotes(7)[0]),"D7a")
L=swap(L,"The kernel planner's own generalizations there are its module's, not entries:","The kernel module's own generalizations are its own, not entries:","D7b")
row=[l for l in L.split("\n") if l.startswith("| 161 |")]; assert len(row)==1 and row[0].count("branch `fs124-wk1`")==1,row[0].count("branch `fs124-wk1`")
L=L.replace(row[0],row[0].replace("branch `fs124-wk1`","`Proofs/HadwigerNelson/Plane/WeakColouringOn.lean`, `Radius.lean`, `RadiusOutside.lean`; `plans/FS124-kernel-plan.md`, `plans/FS124-I1-implementation.md`, `plans/FS124-L1-landing.md`"))
OUT["LEDGER.md"]=L
# ---- the theorem record
d=rd("plans/FS124-derivation.md"); q8=quotes(8); assert len(q8)==1 and "FS124-L1 — [kernel]" not in d
d=swapws(d,"the five entries of § 1's radius clause are a module complete on branch `fs124-wk1` (57 theorems) — **kernel-checked on a branch, not through the gate, not held**;","the five entries of § 1's radius clause are kernel theorems through the gate (FS124-L1; 57 theorems, three modules);","D8b")
d=swapws(d,"**Kernel**: first module, complete on a branch, not held.","**Kernel**: `radius_graph`, through the gate (FS124-L1).","D8c1")
d=swapws(d,"each on the standard three axioms and that one declared outside theorem, **on a branch**. By the planner's record (§ 4.4, on its branch):","each on the standard three axioms and that one declared outside theorem, **through the gate (FS124-L1)**. By the planner's record (§ 4.4):","D8c2")
a="calibrations. No radius is exhibited. **Kernel**: first module.\n"; assert d.count(a)==1
d=d.replace(a,a+"\n*One dated line for the five entries above (C124-RADIUS-GRAPH, -COUNTABLE, -UP, -DOWN, -FIVE), filed by the coordinator from the landing's draft 8 (`plans/FS124-L1-landing.md`):* "+flat(q8[0])+"\n")
OUT["plans/FS124-derivation.md"]=d
# ---- LEAN.md
M=rd("LEAN.md"); q10=quotes(10); assert len(q10)==3,len(q10); assert "names in the same way the parameter at which each hypothesis is inhabited" not in M
ls=M.split("\n"); b=[n for n,l in enumerate(ls) if l.startswith("## The package")]; e=b[0]
while ls[e-1].strip()=="": e-=1
bul=flat(q10[0]); assert bul.startswith("- A `#check` under `import Mathlib`"); ls[e:e]=[bul]; M="\n".join(ls)
a="(`latest` is the last complete run; `scripts/gate-log.sh`)"; M=swap(M,a,a+" "+flat(q10[1]),"D10b")
a="(FS132-L2, its record's stage 7)."; M=swap(M,a,a+" "+flat(q10[2]),"D10c")
a="the landing runs it again on the module as recompiled on the joined tree."; M=swap(M,a,a+" A copy carries the source's licence in its module docstring, with the text beside it (`Outside/OAI158`, since FS124-L1).","D10d")
OUT["LEAN.md"]=M
# ---- BIBLIOGRAPHY.md
B=rd("BIBLIOGRAPHY.md"); bl=B.split("\n"); k=[n for n,l in enumerate(bl) if l.startswith("| **[OAIMath2026]**")]; assert len(k)==1
row=bl[k[0]].rstrip(); assert row.endswith(" |") and "FS-124's disc criterion (FS124-L1" not in row
bl[k[0]]=row[:-2]+" "+flat(quotes(11)[0])+" |"; OUT["BIBLIOGRAPHY.md"]="\n".join(bl)
# ---- the atlas: the criterion's node, and the page's job line
A=rd("tools/viz_proof_atlas_facts.py")
A=swap(A,'"the plane needs seven colours precisely if some open disc has no weak measurable six-colouring", "[hand] or derived from [hand] entries, one mind each, kernel pending", at=','"the plane needs seven colours precisely if some open disc has no weak measurable six-colouring", "[kernel], through the gate", at=',"atlas-grade")
A=swap(A,'job="FS124-Z1", as_of="FS-124, the unit arc, Derived (rows 161–164); FS-132\'s first theorem held (row 155)"','job="FS124-L1", as_of="FS-124\'s disc criterion through the gate (row 161); FS-124, the unit arc, Derived (rows 161–164)"',"atlas-job")
OUT["tools/viz_proof_atlas_facts.py"]=A
for p,t in OUT.items(): open(R+p,"w").write(t)
print("filed:",", ".join(sorted(OUT))); print("CLAUDE.md bytes",len(OUT["CLAUDE.md"].encode()))
