#!/usr/bin/env python3
"""FS131-I5q: docstring edits applied with the `bv_l3` move (run once, from the worktree root): `exists_collarFit`'s docstring brought to
the route FS131-CC2 proved (ruling 417 (c)); `ARCHITECTURE.md`'s two rows naming `bv_l3`'s home."""
BC = 'Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean'
s = open(BC).read()
i = s.index("/-- **The collar exists** (the F-dependent choice; plan § 4, child C1). Route:")
j = s.index("theorem exists_collarFit ", i)
new = """/-- **The collar exists** (the F-dependent choice; plan § 4, child C1). The route proved (FS131-CC2, `plans/FS131-collar-C-implementation.md`
§ 7.1): the radii are one parameter, `R' = 1 − τ`, `R = 1 − τ/2`, `R'' = 1 + τ`, and each clause of `CollarFit` holds for all small `τ > 0`, so
one `τ` serves all. `clear` (`exists_lens_clear`): `hout` keeps the outer class a positive distance from `P`, and for small `τ` the lens lies
under `bend_toward`'s two profiles (`one_sub_lensProf_le` against `n2_env_toward`, `n2_env_near`), so `toward_clear` applies. Thin
(`collarK_thin`): a collar point is `P + t e(ψ)` with `ψ ∈ [θ₁, θ₂]` and `|1 − t| ≤ 2τ`, so the collar lies within `ε` of the arc and inside the
domain (a compact arc in an open set). `Γ`-free off the arc (`exists_collar_free`): near each end by the end's sector chart (`localSectors`)
read in the end's frame — a branch across the tangent leaves the crescent (`branch_transversal`), and a branch along it stays in the crescent
only with the circle's curvature, so it is the circle (`branch_tangent`; `exists_end_free`) — and in the middle by `hfree` and a thickening of
the arc's compact middle. `l60_le` gives `short`. -/
"""
s = s[:i] + new + s[j:]
open(BC, 'w').write(s)

A = 'ARCHITECTURE.md'
a = open(A).read()
old = "FS114-BV-HEX (`bv_hex`, `bv_l3`, `linkage_dot_ne_zero`, `bv_nd`, `bv_nd1`)"
assert a.count(old) == 1
a = a.replace(old, "FS114-BV-HEX (`bv_hex`, `linkage_dot_ne_zero`, `bv_nd`, `bv_nd1`, and the linkage to first order; `bv_l3` is in `Plane/ValidMap/BaseWalk`, moved by inventory item 370 (a))")
old = "proved over `orient_pair` (two change points `a → c` on one `a|c` continuum are impossible) and `colours_sub`. | `Plane/ValidMap/Dense`, `Plane/RingBand`, `Plane/ValidMap/MapTopology` |"
assert a.count(old) == 1
a = a.replace(old, "proved over `orient_pair` (two change points `a → c` on one `a|c` continuum are impossible) and `colours_sub`. Job FS131-I5q: FS114-BV-HEX's `bv_l3` (moved from `Plane/ValidMap/HexRing`, statement verbatim, inventory item 370 (a)) proved after `l3_base`, both over `l3_core` (Lemma 3's band-and-linkage argument); its double switch `bv_l3_dbl`, the ring bridge `ringCircle_val_germ`, `ringCircle_noSwap`. | `Plane/ValidMap/Dense`, `Plane/RingBand`, `Plane/ValidMap/MapTopology` |")
open(A, 'w').write(a)

BD = 'Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean'
d = open(BD).read()
for old, new in [
    ("/-- Two arcs of one unit circle with constant sides that share an interior point have the same sides. -/",
     "/-- Two arcs of one unit circle with constant sides that share an interior point have the same sides. `GENERIC`. -/"),
    ("/-- Two arcs of one unit circle with the same constant sides whose parameter intervals overlap join into one. -/",
     "/-- Two arcs of one unit circle with the same constant sides whose parameter intervals overlap join into one. `GENERIC`. -/"),
    ("(`RegularAt`, `IsRingArc.union_of_overlap`), and an arc of at most `60°` (`l60_le`) is not the set of a longer one. -/",
     "(`RegularAt`, `IsRingArc.union_of_overlap`), and an arc of at most `60°` (`l60_le`) is not the set of a longer one. `GENERIC`. -/"),
    ("/-- **Finitely many arcs meet a compact part of the domain** (local finiteness and compactness). -/",
     "/-- **Finitely many arcs meet a compact part of the domain** (local finiteness and compactness). `GENERIC`. -/"),
]:
    assert d.count(old) == 1, old
    d = d.replace(old, new)
open(BD, 'w').write(d)
print("docs applied")
