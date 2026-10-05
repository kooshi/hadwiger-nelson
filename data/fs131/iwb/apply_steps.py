#!/usr/bin/env python3
"""FS131-IWb: write step5_lt, step6 and their children into Plane/Woodall/Steps from the scratch proofs (data/fs131/iwb/scratch/t2.lean).
Renames the scratch primes to the module names; asserts each anchor occurs once."""
import re, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
t2 = (ROOT / "data/fs131/iwb/scratch/t2.lean").read_text()
steps_p = ROOT / "Proofs/HadwigerNelson/Plane/Woodall/Steps.lean"
s = steps_p.read_text()

def block(name_start, name_end):
    i = t2.index(name_start); j = t2.index(name_end, i)
    return t2[i:j]

ren = {"collarAt_iInter'": "collarAt_setOf_forall_mem", "CollarAt.of_near'": "CollarAt.of_abs_sub_lt",
       "false_of_cos_eq_zero_Icc'": "false_of_cos_eq_zero_on_Icc", "exists_of_cos_eq_zero'": "exists_eq_add_half_pi_of_cos_eq_zero",
       "cos_neg_of_mem'": "cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two",
       "Valid.region_dist_ne_one'": "Valid.region_dist_ne_one", "region_dist_ne_one'": "region_dist_ne_one",
       "exists_two_cover'": "exists_two_cover_of_three_le_card",
       "collarAt_closure_of_forall_shadow'": "collarAt_closure_of_forall_shadow", "SectorsAt.collarAt_opposite'": "SectorsAt.collarAt_opposite",
       "collarAt_opposite'": "collarAt_opposite", "step5_lt'": "step5_lt", "step6'": "step6"}
def rename(x):
    for a, b in sorted(ren.items(), key=lambda p: -len(p[0])):
        x = x.replace(a, b)
    return x

generic = block("theorem collarAt_iInter'", "namespace ArcMap")
mapl = block("theorem Valid.region_dist_ne_one'", "theorem step5_lt'")
p5 = block("theorem step5_lt'", "example : (finRotate 3).symm 0 = 2")
p6 = block("theorem step6'", "end ArcMap")

docs = {
 "theorem collarAt_setOf_forall_mem": "/-- Finitely many collars about one angle, on one side, intersect in a collar. -/\n",
 "theorem CollarAt.of_abs_sub_lt": "/-- A collar of thickness `h` about `y` is a collar about every angle within `h/2` of `y`. -/\n",
 "theorem false_of_cos_eq_zero_on_Icc": "/-- `cos (γ − θ)` does not vanish on a whole interval of positive length (its zeros are `π` apart). -/\n",
 "theorem exists_eq_add_half_pi_of_cos_eq_zero": "/-- If `cos (e − θ) = 0`, then `θ` is a normal `e ± π/2` of the direction `e`, mod `2π`. -/\n",
 "theorem cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two": "/-- `cos` is negative on `(π/2, 3π/2)`. -/\n",
 "theorem Valid.region_dist_ne_one": "/-- In a valid map no colour class holds a unit pair. -/\n",
 "theorem exists_two_cover_of_three_le_card": "/-- With at most five colours, the colours outside a set of at least three are covered by two. -/\n",
 "theorem collarAt_closure_of_forall_shadow": "/-- **The excluded set as a collar**: in a valid map of the plane, if a collar about `θ` (side `s`) lies in the shadow of every colour of `T`, and the\ncolours outside `T` are among `X`, `Y`, then a collar about `θ` lies in `closure (region X ∪ region Y)` (`subset_closure_of_subset_shadow`). -/\n",
 "theorem SectorsAt.collarAt_opposite": "/-- **The inner arc opposite a sector** (step 5's set-up): for `ψ` in `(d i.succ − 3π/2, d i.castSucc − π/2)`, the colours of sector `i` and of its two\nneighbours all put an inner collar about `ψ` in their shadows — the two edges of sector `i` lie in the far half `(ψ + π/2, ψ + 3π/2)` and in the cones of\nthe three colours (the cone clause; the neighbours' cones hold the shared edges, mod `2π`), and the connected piece (`collarAt_shadow_inner_of_mem_coneAt`)\nturns each into a collar. A horn (sector `i` or a neighbour of angle `0`) needs nothing more. -/\n",
}
def add_docs(x):
    for k, v in docs.items():
        x = x.replace(k, v + k, 1) if (v + k) not in x else x
    return x

generic = add_docs(rename(generic))
mapl = add_docs(rename(mapl))
p5 = rename(p5); p6 = rename(p6)
body5 = p5[p5.index(":= by"):]
body6 = p6[p6.index(":= by"):]

# generic lemmas after finRotate_ne_symm
anchor = "namespace ArcMap\n\nvariable {k : ℕ} {F : ArcMap k}\n\n/-! ## The picture at a point -/"
assert s.count(anchor) == 1
s = s.replace(anchor, "/-! ## Collars and normals: the real-variable children of steps 5 and 6 (FS131-IWb) -/\n\n" + generic + anchor)
# map-level children before step 5
anchor5 = "/-! ## Woodall's step 5, strict: every angle at least `π/3` -/\n"
assert s.count(anchor5) == 1
s = s.replace(anchor5, anchor5 + "\n" + mapl)
# the two bodies
old5 = """    (hnb : c (finRotate n i) ≠ c ((finRotate n).symm i)) : False := by
  sorry
"""
assert s.count(old5) == 1
s = s.replace(old5, "    (hnb : c (finRotate n i) ≠ c ((finRotate n).symm i)) : False " + body5.rstrip() + "\n")
old6 = """    (h : F.SectorsAt v 3 d c) (hc : Function.Injective c) (hang : ∀ i : Fin 3, π / 3 ≤ d i.succ - d i.castSucc) : False := by
  sorry
"""
assert s.count(old6) == 1
s = s.replace(old6, "    (h : F.SectorsAt v 3 d c) (hc : Function.Injective c) (hang : ∀ i : Fin 3, π / 3 ≤ d i.succ - d i.castSucc) : False " + body6.rstrip() + "\n")
steps_p.write_text(s)
print("ok")
