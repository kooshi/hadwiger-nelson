import Proofs.HadwigerNelson.Instances.CoreSpindle.Search
import Proofs.HadwigerNelson.Reduction

/-!
# `χ_f(ℝ²) ≥ 65/18` — the plane needs 3.6111… colours fractionally

**The milestone.** A *fractional* colouring may give each point several colours and asks only that
points one unit apart share none; if every point gets `b` of `n` colours, its cost is `n / b`. The
fractional chromatic number is the cheapest such cost, and the ordinary chromatic number is at
least its ceiling. This module proves the plane's is at least `65/18 = 3.6111…`.

## The witness, and how to rebuild it

63 points, 216 unit-distance pairs, and the construction is stated rather than merely tabulated —
so a reader can rebuild it instead of trusting these coordinates:

1. **Core** — a trapezoidal patch of the unit triangular lattice, rows of 6, 5 and 4 points.
2. A **diamond** is two core points at distance `√3` together with their two common neighbours.
3. To each of the 18 diamonds, attach a **Moser spindle**: rotate the diamond about its lower point
   by the angle with `cos θ = 5/6`, `sin θ = √11/6` — exactly the angle carrying the diamond's far
   tip to distance 1 from its original — and keep the three new points.
4. Join **every** pair at distance exactly 1.

This is Fisher and Ullman's construction as Cranston and Rabern describe it (arXiv:1501.01647 § 2),
rebuilt from that description by `tools/corespindle.py`. Nothing in `tools/` is trusted: every
coordinate identity and the whole weight bound are re-derived here by kernel reduction.

## The two halves

```
χ_f(ℝ²) ≥ 65/18
   └── χ_f(this graph) ≥ 260/72
         ├── geometry:  all 216 listed pairs are exactly 1 apart   (coreSpindle_valid)
         └── weights:   63 weights summing to 260, and no independent
                        set weighing more than 72                  (coreSpindle_noHeavy)
```

The second half is the one no human can check by inspection — it quantifies over every one of the
graph's `10⁹`-odd independent sets. `noHeavy_sound` is what makes the `Bool` mean it, and the
search visits 390,625 nodes rather than `10⁹` because of its prune.

## Where this sits

| bound | source |
|---|---|
| `7/2 = 3.5` | the Moser spindle, folklore |
| `32/9 ≈ 3.5556` | Fisher–Ullman 1992 — the published record until 2015 |
| `1732/481 ≈ 3.6008` | Cranston–Rabern 2015, their best **finite** graph (a linear program with over 25,000 constraints) |
| **`65/18 ≈ 3.6111`** | **here** |
| `76/21 ≈ 3.6190` | Cranston–Rabern 2015, by discharging over an **infinite** family |
| `≥ 4` | Matolcsi–Ruzsa–Varga–Zsámboki 2023/25, via a different invariant and an amenability argument |

**This is not the record, and it is not close to it.** The current best is `4`, reached through the
*geometric* fractional chromatic number and amenability of the plane's isometry group — an argument
no finite weighted graph can imitate. What is claimed here is narrower and exact: the best bound a
finite dual certificate gives at a size the kernel can check, which improves on every finite graph
in the 2015 paper at a sixth the size.

## For a reader who trusts none of this

Three things, none of which requires reading any Python:

* `coreSpindle_valid` decides 216 exact identities in `ℚ(√3,√5,√7,√11)` — integers, no floats.
* `coreSpindle_noHeavy` decides the weight bound by kernel reduction. Break it — lower the bound to
  71 — and it goes red; `Diagnose.lean` then names an independent set weighing 72.
* `four_le_chromaticNumber_plane_fractional` re-proves `χ(ℝ²) ≥ 4` from the fractional bound alone,
  sharing no certificate with either of M03's two routes to that statement.
-/

namespace HadwigerNelson

open SimpleGraph
open scoped ENNReal

/-! ### The data, as it stands

`Valid = true` alone is a weak claim — a certificate with no edges satisfies it — so these pin the
shape of the data and run compiled on every build. -/

#guard coreSpindle.edges.length = 216
#guard coreSpindle.edges.eraseDups.length = 216
#guard coreSpindle.edges.all fun e => e.1 < e.2
#guard (coreSpindle.edges.map (·.1) ++ coreSpindle.edges.map (·.2)).eraseDups.length = 63
#guard coreSpindle.denom = 12
#guard coreSpindleWeightList.length = 63
#guard coreSpindleWeightList.sum = 260
#guard coreSpindleOrder.length = 63
#guard coreSpindleSlots.length = 63

-- **The compiled cross-check on the geometry.** A structurally different evaluator over the same
-- 216 edges; when it and the kernel disagree, this line is what says so.
#guard coreSpindle.badEdges.isEmpty

-- **The negative control on the geometry.** Collapse vertex 1 onto vertex 0 — they are adjacent,
-- so that edge acquires length 0 — and the check must fail, naming only edges at vertex 1.
#guard !(({ coreSpindle with
    verts := fun i => if i = 1 then coreSpindle.verts 0 else coreSpindle.verts i } :
  UDCert 63)).badEdges.isEmpty

#guard (({ coreSpindle with
    verts := fun i => if i = 1 then coreSpindle.verts 0 else coreSpindle.verts i } :
  UDCert 63)).badEdges.all fun be => be.1.1 = 1 ∨ be.1.2 = 1

/-! ### The claims -/

/-- **The geometry, in the plane's own terms.** Every listed edge joins two points of `ℂ` at
distance exactly 1 — no floating point anywhere, the whole claim reduced to integer identities. -/
theorem coreSpindle_unit_distances :
    ∀ e ∈ coreSpindle.edges, dist (coreSpindle.point e.1) (coreSpindle.point e.2) = 1 :=
  coreSpindle.valid_sound (by decide) coreSpindle_valid

/-- **The graph's own bound.** `260/72` restated as `65/18`, which costs one inequality between
naturals rather than any arithmetic in `ℝ≥0∞`. -/
theorem coreSpindle_fractional :
    ((65 : ℕ) : ℝ≥0∞) / ((18 : ℕ) : ℝ≥0∞) ≤
      (edgeGraph 63 coreSpindle.edges).fractionalChromaticNumber := by
  refine le_fractionalChromaticNumber_of_noHeavy (D := 72) (rem := 260) coreSpindle.edges
    coreSpindleWeights coreSpindleOrder (by norm_num) coreSpindle_cover coreSpindle_rem ?_ ?_
  · rw [coreSpindle_weight_sum]
  · rw [← coreSpindle_slots]; exact coreSpindle_noHeavy

/-- The two models of the plane agree on the fractional chromatic number too, so the construction
may live in `ℂ` and the headline in `EuclideanSpace ℝ (Fin 2)`. -/
theorem fractionalChromaticNumber_plane_eq_complex :
    (unitDistance (EuclideanSpace ℝ (Fin 2))).fractionalChromaticNumber
      = (unitDistance ℂ).fractionalChromaticNumber :=
  (fractionalChromaticNumber_unitDistance_congr
    Complex.orthonormalBasisOneI.repr.toIsometryEquiv).symm

/-- **χ_f(ℝ²) ≥ 65/18 ≈ 3.6111.** The fractional chromatic number of the plane, from 63 points
whose pairwise unit distances are exact identities in `ℚ(√3,√5,√7,√11)` and 63 integer weights
summing to `260` that no independent set can push past `72`.

`260/72 = 65/18`; the reduced form is stated because it is the one a reader compares. -/
theorem fractionalChromaticNumber_plane_ge :
    (65 : ℝ≥0∞) / 18 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).fractionalChromaticNumber := by
  rw [fractionalChromaticNumber_plane_eq_complex]
  have h : ((65 : ℕ) : ℝ≥0∞) / ((18 : ℕ) : ℝ≥0∞) ≤ (unitDistance ℂ).fractionalChromaticNumber :=
    le_fractionalChromaticNumber_unitDistance_edgeList coreSpindle.edges coreSpindle.point
      coreSpindle_unit_distances coreSpindle_fractional
  simpa using h

/-- **`χ(ℝ²) ≥ 4`, a third time.** From the fractional bound alone: `65/18 > 3`, so the plane has no
3-colouring. This shares no certificate with either of M03's two routes to the same statement, and
it is the check that the fractional machinery is not vacuous — a definition that had drifted into
something weaker would not imply this. -/
theorem four_le_chromaticNumber_plane_fractional :
    (4 : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := by
  refine add_one_le_chromaticNumber_iff_not_colorable.mpr
    (not_colorable_of_lt_fractionalChromaticNumber ?_)
  refine lt_of_lt_of_le ?_ fractionalChromaticNumber_plane_ge
  rw [ENNReal.lt_div_iff_mul_lt (Or.inl (by norm_num)) (Or.inl (by norm_num))]
  norm_num

end HadwigerNelson
