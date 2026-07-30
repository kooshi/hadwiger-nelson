import Proofs.HadwigerNelson.Instances.DeGrey.Valid
import Proofs.HadwigerNelson.Reduction

/-!
# de Grey's graph — the geometry, certified

Aubrey de Grey's 2018 construction (arXiv:1804.02385v3 § 5.1) is a unit-distance graph on **1581
points of the plane** with **7877 edges** that cannot be 4-coloured. This module certifies the first
half of that sentence and nothing else: every one of the 7877 listed pairs really is at distance
exactly 1. The other half — that no 4-colouring exists — is the next milestone, and until it lands
this file proves no new bound.

## What is checked, and what is not

Checked here, by the kernel, from exact integers:

* every listed edge has squared distance exactly `768²` in `ℚ(√3,√5,√7,√11)`, hence real distance
  exactly 1 in the plane (`deGrey_valid`, `deGrey_unit_distances`);
* the shape of the data — 7877 edges, all distinct, all `i < j`, no vertex left out (the `#guard`s
  below, which run on every build).

**Not** checked here, and not claimed:

* that these 1581 points are *the same* 1581 points de Grey published. They came from
  `tools/degrey.py`, which reproduces the construction and the paper's counts (39 seed points, 397,
  1581, 7877), but that agreement is a property of the generator, not a theorem. It does not need to
  be one: a certificate does not claim provenance, it claims geometry, and a bound proved from *some*
  1581-point unit-distance graph is a bound on the plane whoever first drew it.
* that the graph needs five colours. That is the next milestone — a SAT solver's
  refutation, re-checked here from a certificate the proof checker replays itself.

## The hand-off

`deGrey_bound_of_not_colorable` states exactly what remains: supply "this graph has no
4-colouring" and the bound `χ(ℝ²) ≥ 5` follows. Every geometric hypothesis is already discharged
inside it.

## If the geometry ever fails to check

```lean
#eval deGrey.badEdges     -- every offending pair, and the squared distance it actually has
#eval deGrey.denomSq      -- the squared distance a real unit edge must show
```

Both run compiled, so they are instant at this size, and an empty `badEdges` is exactly a valid
certificate (`UDCert.badEdges_eq_nil_iff`).
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### The data, as it stands

`Valid = true` alone is a weak claim: a certificate with no edges satisfies it. These pin the shape
of the data itself, and they run compiled on every build, so they cost nothing and catch a
regenerated file that silently changed size or order. -/

#guard deGrey.edges.length = 7877
-- 45 chunks: 22 per half at 179 edges each (3938 = 22 × 179), plus the one joining edge. The chunk
-- size divides the half size on purpose — see `Instances/DeGrey/Split.lean`.
#guard deGreyChunks.length = 45
#guard deGrey.edges.eraseDups.length = 7877
#guard deGrey.edges.all fun e => e.1 < e.2
#guard (deGrey.edges.map (·.1) ++ deGrey.edges.map (·.2)).eraseDups.length = 1581
#guard deGrey.denom = 768

-- **The compiled cross-check.** `deGrey_valid` is 158 kernel reductions; this is the same
-- predicate evaluated by the *compiler* instead. Two independent evaluators agreeing on 7877 edges is
-- worth its runtime, and when they ever disagree this line is what says so.
#guard deGrey.badEdges.isEmpty

-- **The negative control.** Move vertex 0 to the origin and the check must fail, naming exactly
-- the edges at that vertex. Without this, every claim above would also hold of a `Valid` that is
-- constantly `true`.
#guard (({ deGrey with verts := fun i => if i = 0 then ⟨0, 0⟩ else deGrey.verts i } :
  UDCert 1581)).badEdges.all fun be => be.1.1 = 0 ∨ be.1.2 = 0

#guard !(({ deGrey with verts := fun i => if i = 0 then ⟨0, 0⟩ else deGrey.verts i } :
  UDCert 1581)).badEdges.isEmpty

/-! ### The theorem this milestone exists to prove -/

/-- **The geometry, in the plane's own terms.** Every listed edge of de Grey's graph joins two
points of `ℂ` at distance exactly 1 — no floating point anywhere, the whole claim reduced to an
identity between integers. -/
theorem deGrey_unit_distances :
    ∀ e ∈ deGrey.edges, dist (deGrey.point e.1) (deGrey.point e.2) = 1 :=
  deGrey.valid_sound (by decide) deGrey_valid

/-- **The hand-off to M05.** One hypothesis remains between here and `χ(ℝ²) ≥ 5`: that de Grey's
1581-vertex graph admits no 4-colouring. Everything geometric is discharged inside this proof.

Stated with the hypothesis explicit rather than proved outright, because it is *not* proved outright
— the colouring half is a separate milestone, and a file that read as though it were finished would
be lying about where the ratchet stands. -/
theorem deGrey_bound_of_not_colorable
    (hG : ¬ (edgeGraph 1581 deGrey.edges).Colorable 4) :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  deGrey.add_one_le_chromaticNumber_plane_of_valid deGrey_valid hG

end HadwigerNelson
