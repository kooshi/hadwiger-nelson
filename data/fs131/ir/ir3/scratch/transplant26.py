import sys
which = sys.argv[1]   # 'merge' or 'open'
p='Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean'
s=open(p).read()
def rep(a,b):
    global s
    assert s.count(a)==1, (s.count(a), a[:70])
    s=s.replace(a,b)
if which=='merge':
    sc=open('data/fs131/ir/ir3/scratch/Merge.lean').read()
    aux = sc[sc.index("/-- **The vertex step from MERGE's surgery**"):sc.index("end Near\n")]
    body = sc[sc.index("  classical\n  obtain ⟨X⟩ := exists_near", sc.index("theorem exists_mergeStep'")):sc.index("\nend ArcMap")]
    assert body.rstrip().endswith("hρc hgc hdeg hhorn⟩")
    old_doc = s[s.index("/-- **The vertex step, MERGE's case**"):s.index("theorem exists_mergeStep (hF")]
    new_doc = """/-- **The vertex step, MERGE's case** (FS110-W-MERGE, cleaned): `exists_merge_aux`'s hypotheses at a point of a clean map, with the
two counts; the vertex step's conclusion. Its map is `MergeMove`'s surgery (`mergeArcs`, `mergeCol` for the gap `Near.exists_gap`
gives, `Near.exists_mergeStep_aux`) at a radius also below `δ`, then `cleanKeep`; the count is `pot_lt_of_interior` at the gap's
first germ. Inhabitant: none in Lean (as `exists_vertexStep`). -/
"""
    rep(old_doc, "/-! ### MERGE's case (FS131-IR3) -/\n\nnamespace Near\n\nvariable {v : ℂ} {X : F.Near v} {s : Fin X.n} {a b : ℕ}\n\n" + aux.rstrip() + "\n\nend Near\n\n" + new_doc)
    i = s.index("theorem exists_mergeStep (hF")
    rep("""SHAVE's). -/""", """SHAVE's, MERGE's). -/""")
else:
    sc=open('data/fs131/ir/ir3/scratch/Open.lean').read()
    aux = sc[sc.index("/-- **The vertex step from OPEN's surgery**"):sc.index("end Near\n")]
    body = sc[sc.index("  classical\n  obtain ⟨X⟩ := exists_near", sc.index("theorem exists_openStep'")):sc.index("\nend ArcMap")]
    assert body.rstrip().endswith("hF hc hdeg hhorn⟩⟩")
    old_doc = s[s.index("/-- **The vertex step, OPEN's case**"):s.index("theorem exists_openStep (hF")]
    new_doc = """/-- **The vertex step, OPEN's case** (FS131-E6-OPEN, cleaned): `exists_open`'s hypotheses at a point of a clean map. Its map is
`OpenMove`'s surgery (`openArcs`, `openCol` for the configuration `Near.exists_openConfig` gives, `Near.exists_openStep_aux`) at a
radius below `δ` and below half the configuration's clear radius, then `cleanKeep`; the count is `open_degree_horns` and
`cleanKeep_pot_le`. Inhabitant: none in Lean (FS131-E6's twelve-colour map at [hand], as `exists_open`'s note says). -/
"""
    rep(old_doc, "/-! ### OPEN's case (FS131-IR3) -/\n\nnamespace Near\n\nvariable {v : ℂ} {X : F.Near v} {s : Fin X.n} {b : ℕ}\n\n" + aux.rstrip() + "\n\nend Near\n\n" + new_doc)
    i = s.index("theorem exists_openStep (hF")
    rep("""`exists_shave_aux`, `exists_open`) with cleanness and the two counts, and concludes the step. A case is open (`sorry`) until proved
from its construction (routes: `plans/FS131-limit-kernel-plan.md`, Stage 20; proved so far, by FS131-IR3: MERGE-RAY's and
SHAVE's, MERGE's). -/""", """`exists_shave_aux`, `exists_open`) with cleanness and the two counts, and concludes the step. All four are proved
(FS131-IR3; `plans/FS131-limit-kernel-plan.md`, Stages 24–27), each from its move's construction through `surgery_step`. -/""")
j = s.index("  sorry\n", i)
k_ = s.index(":= by\n", i)
assert k_ < j and j - k_ < 20, (k_, j)
s = s[:j] + body + "\n" + s[j+len("  sorry\n"):]
open(p,'w').write(s)
print('written', which)
