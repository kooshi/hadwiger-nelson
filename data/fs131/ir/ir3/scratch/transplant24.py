import re
sc=open('data/fs131/ir/ir3/scratch/Kit.lean').read().split('\n')
def L(a,b): return '\n'.join(sc[a-1:b])
def find(prefix, start=0):
    for i,l in enumerate(sc):
        if i>=start and l.startswith(prefix): return i+1
    raise SystemExit('not found '+prefix)
root = L(7,81)
for nm in ['e_arg_sub_ne','im_ne_zero_of_far','mem_curveAt_of_dist_eq']:
    assert root.count('theorem '+nm+' ')==1
    root = root.replace('theorem '+nm+' ', 'theorem _root_.HadwigerNelson.Plane.'+nm+' ')
gen = L(86,363)
near1 = L(364,488)
near2 = L(490,638)
assert near1.startswith('namespace Near') and near1.rstrip().endswith('end Near')
assert near2.startswith('namespace Near') and near2.rstrip().endswith('end Near')
near1 = near1.replace('variable {F : ArcMap k} {v : ℂ}\n','variable {v : ℂ}\n',1)
a='variable {F : ArcMap k} {v : ℂ} {X : F.Near v} {ρ α κ₁ κ₂ κ₃ κ₄ : ℝ} {i₀ i₁ : Fin X.n}'
assert near2.count(a)==1
near2 = near2.replace(a,'variable {v : ℂ} {X : F.Near v} {ρ α κ₁ κ₂ κ₃ κ₄ : ℝ} {i₀ i₁ : Fin X.n}')
b0 = find('  have _ := hn')
b1 = find('end ArcMap', b0)
body = L(b0, b1-2)
assert body.rstrip().endswith('hdeg hhorn⟩'), body[-80:]

kit = '''/-! ### A point on two curves, and the points of a move's disc in one statement (FS131-IR3)

At a point where a germ meets a move's rim circle, `Γ` lies on two curves through the point — the circle about `v` and the germ's
line or circle — transversal there (`im_ne_zero_of_far`: the germ's curve passes through `v` and goes on past the rim). If one of the
junction's four branches is dead (points of it off `Γ` arbitrarily near), the degree is at most three, so a clean map has no site
there (`not_isSite_of_two_curves`, `not_isSite_of_rim_junction`). `not_isSite_of_branches` is the whole disc at once: if the arcs of a
clean map in the punctured ball lie on one circle about `v` and on finitely many branches from `v`, pairwise apart, then a point
other than `v` is no site and carries at most three colours, given a dead branch at each junction; `Near.not_isSite_of_chart` reads
it in the chart of the map before the move. Each case of the vertex step supplies the arcs' description and the dead branches. -/

''' + root + '\n' + gen + '\n' + near1 + '\n\n'

ray = '''/-! ### MERGE-RAY's case (FS131-IR3) -/

''' + near2 + '\n\n'

p='Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean'
s=open(p).read()
m1 = "/-! ## The vertex step's four cases (FS131-IR2): one statement per move, in the vertex step's own conclusion\n"
assert s.count(m1)==1
s = s.replace(m1, kit + m1)
old_doc = """/-- **The vertex step, MERGE-RAY's case** (FS110-N4-RAY, cleaned): `exists_rayMerge_aux`'s hypotheses at a point of a clean map.
Open: its map is `Moves`' `RayConfig.exists_merge` construction (`Near.move` with the kept germs `rayKeep`) at a radius also below
`δ`, then `cleanKeep`; the count is `pot_lt_of_interior` at the lower horn's upper germ. In a clean map the two horns are never
adjacent (`Near.col_ne_next_of_isClean`), so `exists_rayMerge_of_clear`'s cut case does not occur. Inhabitant: none in Lean. -/
theorem exists_rayStep"""
assert s.count(old_doc)==1
new_doc = """/-- **The vertex step, MERGE-RAY's case** (FS110-N4-RAY, cleaned): `exists_rayMerge_aux`'s hypotheses at a point of a clean map.
Its map is `Moves`' ray merge of the two given horns (`Near.move` with the kept germs `rayKeep` and the colouring `rayCol`,
`Near.RayConfig.exists_step`) at a radius also below `δ`, then `cleanKeep`; the gap is clear by `ray_clear`. The sector count `hn`
is not read: the step's count is the potential, and the merge needs no choice of a nearest horn. Inhabitant: none in Lean (as
`exists_vertexStep`). -/
theorem exists_rayStep"""
s = s.replace(old_doc, ray + new_doc)
old_body = """      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  sorry

/-- **The vertex step, SHAVE's case**"""
assert s.count(old_body)==1
s = s.replace(old_body, """      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
""" + body + """

/-- **The vertex step, SHAVE's case**""")
open(p,'w').write(s)
print('written')
