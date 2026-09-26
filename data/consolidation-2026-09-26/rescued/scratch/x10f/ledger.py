import re, sys
L=open("plans/FS100-three-field-lemma.md",encoding="utf-8").read().split("\n")
start=[i for i,l in enumerate(L) if l.startswith("## §R-close (stage 5")][0]
rows={}; blines=[]
for l in L[start:]:
    m=re.match(r"^\| (12[0-2]) \|",l)
    if m: rows[m.group(1)]=l
    elif re.match(r"^\| FS100-\w+ \|",l): blines.append(l)
assert sorted(rows)==["120","121","122"] and len(blines)==16, (rows.keys(), len(blines))
esc="`h_m(u) = Σ_v log⁺\\|u\\|_v`"
raw="`h_m(u) = Σ_v log⁺|u|_v`"
def one(s, old, new):
    assert s.count(old)==1, (s.count(old), old[:60]); return s.replace(old,new)
rows["120"]=one(rows["120"], raw, esc)
rows["120"]=one(rows["120"], "no novelty claimed for PE-2 until it is read**; PE-2's shape is Johnson's nonlacunary theorem (1992, review only) transposed.",
  "no novelty claimed for PE-2 until it is read**; PE-2's shape is Johnson's nonlacunary theorem (1992, review only) transposed; prior-art gate on MR pending, X24R.")
rows["121"]=one(rows["121"], "— owed before any novelty or publication claim.", "— owed before any novelty or publication claim; prior-art gate pending, X24R.")
out=[]
for l in blines:
    cells=l.split(" | ")
    if "log⁺|u|_v" in l: l=l.replace(raw, esc)
    # address column: normalise a bare id to the § B convention (`plans/FS100-derivation.md` <id>)
    m=re.match(r"^(\| (FS100-\w+) \|.*\| )(FS100-\w+)( \| [^|]+ \|)$", l)
    if m: l=m.group(1)+"`plans/FS100-derivation.md` "+m.group(3)+m.group(4)
    n=len(re.findall(r"(?<!\\)\|",l)); assert n==7, (n,l[:40])
    out.append(l)
for k in rows: assert len(re.findall(r"(?<!\\)\|",rows[k]))==5, k
T=open("LEDGER.md",encoding="utf-8").read()
r119=[l for l in T.split("\n") if l.startswith("| 119 |")]; assert len(r119)==1
T=one(T, r119[0]+"\n", r119[0]+"\n"+rows["120"]+"\n"+rows["121"]+"\n"+rows["122"]+"\n")
# row 118 corrections (X09C 4.1)
T=one(T, "so EL2021 Thm 1.2 never applies** (FS-100; FS100-N1, T4, T5, T2).",
 "so EL2021 Thm 1.2 never applies on `R̂` itself; on the pieces `M̂` it applies exactly under admissibility (row 120)** (FS-100; FS100-N1, T4, T5, T2).")
T=one(T, "The card's answer [reading, one mind]: EL2021 Thm 1.3 is the in-print positive-entropy statement that can apply, and MR is its zero-entropy half plus an owed lemma PE-lim (from finitely generated `Γ` to `U`);",
 "The card's answer [reading, one mind] — MR as its zero-entropy half plus an owed PE-lim (from finitely generated `Γ` to `U`) — was right in shape; **both halves are now held (row 120)**: PE-lim through Thm 1.2 on the finitely generated pieces under admissibility, the zero-entropy half by Einsiedler–Fish;")
T=one(T, "**Not claimed:** PE-lim; MR; the rank-one density off `E` in general.", "**Not claimed:** the rank-one density off `E` in general.")
# § B lines at the end of the § B table (after row 119's lines)
last=[l for l in T.split("\n") if l.startswith("| FS75-H |")]; assert len(last)==1
T=one(T, last[0]+"\n", last[0]+"\n"+"\n".join(out)+"\n")
open("LEDGER.md","w",encoding="utf-8").write(T)
print("ok")
