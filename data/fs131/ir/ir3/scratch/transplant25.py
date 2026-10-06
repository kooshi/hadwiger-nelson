sc=open('data/fs131/ir/ir3/scratch/Shave.lean').read()
def between(a,b):
    i=sc.index(a); j=sc.index(b,i)
    return sc[i:j]
asm1 = between("/-- **Joining a component across one of its open set's points**", "namespace Near\n")
asm2 = between("/-- **The vertex step from a `Near.move`**", "/-- **The vertex step from SHAVE's recolouring**")
shave = between("/-- **The vertex step from SHAVE's recolouring**", "end Near\n")
body = between("  have _ := hn\n", "\nend ArcMap")
assert body.rstrip().endswith("hσ₁ hσ₂ hcl hdeg hhorn⟩")
p='Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean'
s=open(p).read()
def rep(a,b):
    global s
    assert s.count(a)==1, (s.count(a), a[:70])
    s=s.replace(a,b)
# 1. the assembly block, before the four cases' header
m1 = "/-! ## The vertex step's four cases (FS131-IR2): one statement per move, in the vertex step's own conclusion\n"
blk = ("/-! ### The assembly the four cases share (FS131-IR3) -/\n\n" + asm1 +
       "namespace Near\n\nvariable {v : ℂ}\n\n" + asm2.rstrip() + "\n\nend Near\n\n")
rep(m1, blk + m1)
# 2. the ray step's tail, through the assembly
old_tail = s[s.index("  have hvd : v ∈ F₁.cleanKeep.dom := X.mem_dom\n", s.index("theorem RayConfig.exists_step")):s.index("end Near", s.index("theorem RayConfig.exists_step"))]
assert "pot_lt_of_interior X (X.two_le_of_isClean hc hn0) ?_ (p := i₀) ?_ hdeg hhorn hm' hj', hm', hj'⟩" in old_tail
new_tail = """  refine move_step hc hEin hcol (fun a ha => absurd ha (notMem_empty a)) hval hself hpts (fun m' j' hm' hj' =>
    pot_lt_of_interior X (X.two_le_of_isClean hc hn0) ?_ (p := i₀) ?_ hdeg hhorn hm' hj')
  · filter_upwards [Ioo_mem_nhdsGT h.1] with r hr
    rintro z ⟨hzI, hzb⟩
    exact F₁.interiorPts_subset_cleanKeep ((hint z (ball_subset_ball hr.2.le hzb)).mpr (Or.inr hzI))
  · filter_upwards [Ioo_mem_nhdsGT h.1] with s hs
    refine F₁.interiorPts_subset_cleanKeep ((hint _ ?_).mpr (Or.inl ?_))
    · rw [mem_ball, dist_branchPt _ hs.1.le]; exact hs.2
    · rw [branchPt_congr_dir hR.germ₂.1, hR.germ₂.2]
      exact branchPt_mem_hornSet v α hR.h12 (by linarith [hR.h23, hR.h34]) hs.1 hs.2 (hR.curv_lt hκ2 hs.2.le)

"""
rep(old_tail, new_tail)
# 3. SHAVE's case
old_doc = s[s.index("/-- **The vertex step, SHAVE's case**"):s.index("theorem exists_shaveStep")]
new_doc = """/-- **The vertex step, SHAVE's case** (FS110-N4-SHAVE, cleaned): `exists_shave_aux`'s hypotheses at a point of a clean map. Its
map is `exists_shave_recolour`'s (`Near.move` with every germ kept, `shaveArcs` and `shaveCol`, `Near.exists_shaveStep_aux`) at a
radius also below `δ`, then `cleanKeep`; the count is `pot_lt_of_sectors` with `H` the shaved horn. Neither flank colour need differ
from the horn's and the sector count `hn` is not read: `Moves`' two cut cases are not separated. Inhabitant: none in Lean (as
`exists_vertexStep`). -/
"""
rep(old_doc, "/-! ### SHAVE's case (FS131-IR3) -/\n\nnamespace Near\n\nvariable {v : ℂ}\n\n" + shave.rstrip() + "\n\nend Near\n\n" + new_doc)
i = s.index("theorem exists_shaveStep (hF")
j = s.index("  sorry\n", i)
k_ = s.index(":= by\n", i)
assert k_ < j and j - k_ < 20, (k_, j)
s = s[:j] + body + "\n" + s[j+len("  sorry\n"):]
rep("""from its construction (routes: `plans/FS131-limit-kernel-plan.md`, Stage 20; proved so far, by FS131-IR3: MERGE-RAY's). -/""",
    """from its construction (routes: `plans/FS131-limit-kernel-plan.md`, Stage 20; proved so far, by FS131-IR3: MERGE-RAY's and
SHAVE's). -/""")
open(p,'w').write(s)
print('written')
