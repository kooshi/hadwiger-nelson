import Proofs.HadwigerNelson.FieldWall4

/-!
# The 2-adic law of four-colour compulsions over `K = ℚ(√3, √11)`

Theorem B (`FieldWall4.lean`) colours `K²` with four colours by a residue map at the
conjugation-fixed prime `𝔭` above `2`.  That colouring is *one* proper four-colouring, so every
four-colour compulsion in `K²` has to survive it — and which pairs it identifies is arithmetic,
not geometry.  This file turns that observation into the law and reads it off at the distances the
literature and this project have measured.

## The law

For `z, w` in `K²` at distance `d`, with `d` itself in `K` and of odd denominator:

  **the residue colouring identifies `z` and `w` if and only if `d` lies in the prime.**

`residueColouring_eq_iff_psiA_zero` is the statement; its proof is one line of algebra once the
difference is factored as `d · u` with `u` a unit vector — a unit vector is a *unit* of the odd
denominator ring, so it contributes an invertible residue and the whole residue is the scalar's.

**The same law through the squared distance**, which is the form the write-up states and which
does not need `d` itself to lie in `K`: for any difference lying in `A`,
`psiA_eq_zero_iff_normSq` says its residue vanishes exactly when `d²`'s does, because conjugation
induces Frobenius on the residue field (`psiA_conj`), so `ψ(v)³ = ψ(v · v̄) = ψ(d²)`, and in `𝔽₄`
a cube vanishes only with its base.  `1 + i` is the instance the scalar form cannot reach: a
difference of `K`-points of length `√2`, with `√2 ∉ K`.

Four consequences, in the vocabulary the hunt uses:

* `not_forces_of_residue_ne_zero` — a distance outside the prime carries **no forced-monochromatic
  pair** at four colours over `K`;
* `not_separated_of_residue_eq_zero` — a distance inside the prime carries **no virtual edge**;
* `not_forces_of_sub` / `not_separated_of_sub` — the same keyed on the difference rather than the
  distance, for pairs whose distance lies outside `K`.

## What it explains

`[Parts2020a]`'s Table 1 lists minimal gadget sizes for four-colour compulsions, found by
computer: pairs forced *monochromatic* at `8/3` and `8/√3`, pairs forced *distinct* at `3`, `7/3`,
`5/3`, `1/3` and `√(11/3)`.  Every monochromatic distance is 2-adically even and every distinct
one is a 2-adic unit; the paper offers no explanation and does not remark on the pattern.  §4
below proves the two columns cannot be swapped — each of the seven distances is barred from the
other column, by one bit of arithmetic apiece.

The same law explains this project's own M53 rigidity dial, which found forced pairs at that
depth and nowhere else over 15,230 pairs and recorded the regularity as unexplained.

## Scope, stated honestly

The law needs the distance itself to lie in `K` with odd denominator.  Every distance anybody has
measured does, but `K`-points at distances outside `K` exist and this file says nothing about them.

Everything here is about four-colourings of `K`-objects, and over `K` is the only place the
question has content at four colours: **the plane itself needs five, so the type of proper
four-colourings of the plane is empty** (`Instances/Interval.lean`'s
`isEmpty_coloring_plane_four`), and any statement quantified over one is vacuous.  That corrects
a companion argument the stub which minted this file carried, and it is worth stating plainly:
the stub read the plane-wide pigeonholes `core9_plane` (at `√3`) and `core122_plane` (at `2`) as
forbidding virtual edges at those distances, and a vacuous hypothesis forbids nothing.  What
survives is the arithmetic half proved here, which is not vacuous because Theorem B supplies the
colourings.  The pigeonhole half would need those carriers re-stated over `K` — where their
content is real and where their union with a hypothetical gadget would contradict Theorem B —
and that is open work, not done here.
-/

namespace HadwigerNelson

open SimpleGraph Complex

namespace FieldWall4

/-! ## §1 Scalars in the odd-denominator ring -/

/-- A point with an odd-integer multiple in the order has coordinates in `K`. -/
theorem oddDenom_subset_seamPlane {z : ℂ} (hz : z ∈ oddDenom) : z ∈ seamPlane := by
  obtain ⟨x, m, hm, hx⟩ := hz
  have hm0 : (m : ℂ) ≠ 0 := by
    have : m ≠ 0 := by rintro rfl; simp [Int.odd_iff] at hm
    exact_mod_cast this
  have hz' : z = ((1 / m : ℚ) : ℂ) * den x := by
    rw [← hx]; push_cast; field_simp
  rw [hz']
  exact seamPlane_ratMul (den_mem_seamPlane x) _

/-- Scaling a point of `K²` by a real element of `K` stays in `K²`. -/
theorem seamPlane_realMul {c : ℝ} (hc : c ∈ seamField) {z : ℂ} (hz : z ∈ seamPlane) :
    (c : ℂ) * z ∈ seamPlane := by
  obtain ⟨hre, him⟩ := mem_seamPlane_iff.mp hz
  refine mem_seamPlane_iff.mpr ⟨?_, ?_⟩
  · simpa [Complex.mul_re] using seamField.mul_mem hc hre
  · simpa [Complex.mul_im] using seamField.mul_mem hc him

-- Superseded 2026-09-09 by the `NoZeroDivisors F4` instance in `FieldWall4.lean`, which is the
-- same sixteen-case `decide` in the form `mul_eq_zero` and the general law consume. Kept because
-- the record cites the sixteen-pair exhaustion as this law's mechanism.
/-- **A residue is zero as soon as a cofactor of nonzero residue makes it so** — `𝔽₄` has no zero
divisors, by exhaustion over sixteen pairs. -/
theorem F4.eq_zero_of_mul_eq_zero {a b : F4} (h : a * b = 0) (hb : b ≠ 0) : a = 0 := by
  revert h hb; revert a b; decide

/-! ## §2 The law -/

/-- **Every pair of `K`-points at a distance lying in `A` has its difference in `A`, and that
difference's residue is the distance's.**  The unit vector `u = (z − w)/d` is a unit of `A`
(`conj_mem_oddDenom` supplies its inverse), so it cannot move the residue off zero. -/
theorem sub_mem_oddDenom_of_dist {z w : ℂ} (hz : z ∈ seamPlane) (hw : w ∈ seamPlane)
    {d : ℝ} (hd : (d : ℂ) ∈ oddDenom) (hd0 : d ≠ 0) (hdist : dist z w = d) :
    ∃ h : z - w ∈ oddDenom, (psiA ⟨z - w, h⟩ = 0 ↔ psiA ⟨(d : ℂ), hd⟩ = 0) := by
  have hdK : d ∈ seamField := (mem_seamPlane_iff.mp (oddDenom_subset_seamPlane hd)).1
  have hd0' : (d : ℂ) ≠ 0 := by exact_mod_cast hd0
  have hnsq : normSq (z - w) = d ^ 2 := by
    have hn : ‖z - w‖ = d := by rwa [← Complex.dist_eq]
    have hsq := congrArg (fun t : ℝ => t ^ 2) hn
    simpa only [Complex.sq_norm] using hsq
  have hquot : (z - w) / (d : ℂ) = ((d⁻¹ : ℝ) : ℂ) * (z - w) := by push_cast; field_simp
  have hqP : (z - w) / (d : ℂ) ∈ seamPlane :=
    hquot ▸ seamPlane_realMul (seamField.inv_mem hdK) (seamPlane_sub hz hw)
  have hqnorm : normSq ((z - w) / (d : ℂ)) = 1 := by
    rw [hquot, map_mul, Complex.normSq_ofReal, hnsq]
    field_simp
  refine map_eq_zero_iff_of_mul_conj_eq conj_mem_oddDenom psiA hd hd0'
    (mem_oddDenom_of_unit hqP hqnorm) ?_
  rw [Complex.mul_conj, Complex.mul_conj, hnsq, Complex.normSq_ofReal]
  push_cast
  ring

/-- **Within one coset of `A` the colouring is the residue map** — the general
`cosetResidue_eq_iff` at this file's subring, and the primitive both forms of the law travel. -/
theorem residueColouring_eq_iff_sub {z w : ℂ} (hmem : z - w ∈ oddDenom) :
    residueColouring z = residueColouring w ↔ psiA ⟨z - w, hmem⟩ = 0 :=
  cosetResidue_eq_iff_map psiA hmem

/-- **The law.**  Two points of `K²` at a distance `d` which itself lies in `K` with odd
denominator get the same residue colour exactly when `d` lies in the prime. -/
theorem residueColouring_eq_iff_psiA_zero {z w : ℂ} (hz : z ∈ seamPlane) (hw : w ∈ seamPlane)
    {d : ℝ} (hd : (d : ℂ) ∈ oddDenom) (hd0 : d ≠ 0) (hdist : dist z w = d) :
    residueColouring z = residueColouring w ↔ psiA ⟨(d : ℂ), hd⟩ = 0 := by
  obtain ⟨hmem, hiff⟩ := sub_mem_oddDenom_of_dist hz hw hd hd0 hdist
  exact (residueColouring_eq_iff_sub hmem).trans hiff

/-! ### The same law through the squared distance

The distance itself need not lie in `K`; the squared distance always does.  For a difference that
lies in `A` at all, its residue vanishes exactly when `d²`'s does — because conjugation induces
Frobenius on the residue field, so `ψ(v)³ = ψ(v · v̄) = ψ(d²)`, and in `𝔽₄` a cube vanishes only
with its base.  This is the form the write-up states ("`d²` 2-adically even"), and it reaches
pairs the scalar form cannot: `1 + i` is a `K`-point difference of length `√2`, and `√2 ∉ K`. -/

/-- **Conjugation induces Frobenius on `A`'s residue field** — `psiZero_conj` carried across the
odd denominators, which conjugation does not move. -/
theorem psiA_conj {z : ℂ} (hz : z ∈ oddDenom) :
    psiA ⟨(starRingEnd ℂ) z, conj_mem_oddDenom z hz⟩ = psiA ⟨z, hz⟩ * psiA ⟨z, hz⟩ := by
  obtain ⟨x, m, hm, hx⟩ := hz
  have hcx : (m : ℂ) * (starRingEnd ℂ) z = den (FieldWall4.conj x) := by
    rw [den_conj, ← hx, map_mul]
    congr 1
    simp
  rw [psiA_eq _ hm hcx, psiA_eq _ hm hx, psiZero_conj]

/-- The squared length of an element of `A` is again in `A` — it is `v · v̄`. -/
theorem normSq_mem_oddDenom {v : ℂ} (hv : v ∈ oddDenom) :
    ((normSq v : ℝ) : ℂ) ∈ oddDenom := by
  have h := oddDenom.mul_mem hv (conj_mem_oddDenom v hv)
  rwa [Complex.mul_conj] at h

/-- **Conjugation maps `psiA`'s kernel into itself** — the hypothesis the general law spends, and
the one `plans/FIELD-WALL-THEOREM.md` states Theorem A with: *the prime is fixed by complex
conjugation*. Here it follows from the sharper `psiA_conj` (conjugation induces Frobenius), which is
special to `𝔽₄`; the general statement asks only for this implication, and the red in
`ResidueColouring.lean` §7 shows a split prime where it fails. -/
theorem psiA_ker_stable (z : oddDenom) :
    psiA ((starRingEnd ℂ).restrict oddDenom oddDenom conj_mem_oddDenom z) = 0 → psiA z = 0 := by
  intro h
  rw [show ((starRingEnd ℂ).restrict oddDenom oddDenom conj_mem_oddDenom z)
      = (⟨(starRingEnd ℂ) (z : ℂ), conj_mem_oddDenom _ z.2⟩ : oddDenom) from rfl,
    psiA_conj z.2] at h
  exact mul_self_eq_zero.mp h

/-- **The law, through the squared distance.**  A difference lying in `A` has zero residue exactly
when its squared length does. -/
theorem psiA_eq_zero_iff_normSq {v : ℂ} (hv : v ∈ oddDenom) :
    psiA ⟨v, hv⟩ = 0 ↔ psiA ⟨((normSq v : ℝ) : ℂ), normSq_mem_oddDenom hv⟩ = 0 := by
  rw [show (⟨((normSq v : ℝ) : ℂ), normSq_mem_oddDenom hv⟩ : oddDenom)
      = ⟨v, hv⟩ * (starRingEnd ℂ).restrict oddDenom oddDenom conj_mem_oddDenom ⟨v, hv⟩ from
    Subtype.ext (Complex.mul_conj v).symm]
  exact (map_mul_conj_eq_zero_iff conj_mem_oddDenom psiA psiA_ker_stable ⟨v, hv⟩).symm

/-- **The law, through the squared distance, at the level of the colouring.** -/
theorem residueColouring_eq_iff_normSq {z w : ℂ} (hmem : z - w ∈ oddDenom) :
    residueColouring z = residueColouring w ↔
      psiA ⟨((normSq (z - w) : ℝ) : ℂ), normSq_mem_oddDenom hmem⟩ = 0 :=
  (residueColouring_eq_iff_sub hmem).trans (psiA_eq_zero_iff_normSq hmem)

/-! ## §3 The residue colouring as a four-colouring, and what it refutes -/

/-- **A unit step inside `K²` stays in the odd-denominator ring** — the integrality half of the
general residue theory's hypothesis, at this field. Written once because three declarations below
need it. -/
theorem sub_mem_oddDenom_of_adj {S : Set ℂ} (hS : S ⊆ seamPlane) :
    ∀ ⦃v w : S⦄, ((unitDistance ℂ).induce S).Adj v w → (v : ℂ) - (w : ℂ) ∈ oddDenom :=
  fun v w hvw => mem_oddDenom_of_unit (seamPlane_sub (hS v.2) (hS w.2))
    (mem_normOne_conj_iff.mp (sub_mem_normOne_conj_iff.mpr hvw))

/-- **A unit step is a unit vector** — the norm-one half, which is the whole of the geometry. -/
theorem sub_mem_normOne_of_adj {S : Set ℂ} :
    ∀ ⦃v w : S⦄, ((unitDistance ℂ).induce S).Adj v w →
      (v : ℂ) - (w : ℂ) ∈ normOne (starRingEnd ℂ) :=
  fun _ _ hvw => sub_mem_normOne_conj_iff.mpr hvw

/-- **Theorem B's colouring of a `K`-object, valued in `𝔽₄`** — the general `normOneColoring` at
this file's subring and residue map. This is the object the compulsion consumers evaluate; the
`Fin 4` presentation below is its recolouring. -/
noncomputable def seamResidueColouring (S : Set ℂ) (hS : S ⊆ seamPlane) :
    ((unitDistance ℂ).induce S).Coloring F4 :=
  normOneColoring conj_mem_oddDenom psiA _ (fun v : S => (v : ℂ))
    (sub_mem_oddDenom_of_adj hS) sub_mem_normOne_of_adj

theorem seamResidueColouring_apply {S : Set ℂ} (hS : S ⊆ seamPlane) (v : S) :
    seamResidueColouring S hS v = residueColouring (v : ℂ) := rfl

/-- `𝔽₄` numbered. Kept because the record cites `seamColouring` by name; the compulsion consumers
below no longer need it — `Palette.lean` translates a colouring of any four-element palette into
`Forces`/`Separated`'s own `Fin 4`. -/
noncomputable def F4.equivFin : F4 ≃ Fin 4 := Fintype.equivFinOfCardEq F4.card_eq_four

/-- **Theorem B's colouring, as a `Fin 4`-colouring of any `K`-object.** -/
noncomputable def seamColouring (S : Set ℂ) (hS : S ⊆ seamPlane) :
    ((unitDistance ℂ).induce S).Coloring (Fin 4) :=
  SimpleGraph.recolorOfEquiv _ F4.equivFin (seamResidueColouring S hS)

theorem seamColouring_apply {S : Set ℂ} (hS : S ⊆ seamPlane) (v : S) :
    seamColouring S hS v = F4.equivFin (residueColouring (v : ℂ)) := rfl

/-- A forced-monochromatic pair is monochromatic in *this* colouring. -/
theorem residueColouring_eq_of_forces {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (h : Forces ((unitDistance ℂ).induce S) 4 p q) :
    residueColouring (p : ℂ) = residueColouring (q : ℂ) :=
  h.eq_of_card F4.card_eq_four (seamResidueColouring S hS)

/-- A virtual edge is separated by *this* colouring. -/
theorem residueColouring_ne_of_separated {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (h : Separated ((unitDistance ℂ).induce S) 4 p q) :
    residueColouring (p : ℂ) ≠ residueColouring (q : ℂ) :=
  h.ne_of_card F4.card_eq_four (seamResidueColouring S hS)

/-- **A distance outside the prime carries no forced-monochromatic pair at four colours over
`K`** — the half that rules gadgets out. -/
theorem not_forces_of_residue_ne_zero {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    {d : ℝ} (hd : (d : ℂ) ∈ oddDenom) (hd0 : d ≠ 0) (hdist : dist (p : ℂ) (q : ℂ) = d)
    (hres : psiA ⟨(d : ℂ), hd⟩ ≠ 0) : ¬ Forces ((unitDistance ℂ).induce S) 4 p q := fun h =>
  hres ((residueColouring_eq_iff_psiA_zero (hS p.2) (hS q.2) hd hd0 hdist).mp
    (residueColouring_eq_of_forces hS h))

/-- **A distance inside the prime carries no virtual edge at four colours over `K`.** -/
theorem not_separated_of_residue_eq_zero {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    {d : ℝ} (hd : (d : ℂ) ∈ oddDenom) (hd0 : d ≠ 0) (hdist : dist (p : ℂ) (q : ℂ) = d)
    (hres : psiA ⟨(d : ℂ), hd⟩ = 0) : ¬ Separated ((unitDistance ℂ).induce S) 4 p q := fun h =>
  residueColouring_ne_of_separated hS h
    ((residueColouring_eq_iff_psiA_zero (hS p.2) (hS q.2) hd hd0 hdist).mpr hres)

/-- **A difference outside the prime carries no forced-monochromatic pair** — the distance-free
form, which reaches pairs whose distance does not lie in `K`. -/
theorem not_forces_of_sub {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hmem : (p : ℂ) - (q : ℂ) ∈ oddDenom) (hres : psiA ⟨(p : ℂ) - (q : ℂ), hmem⟩ ≠ 0) :
    ¬ Forces ((unitDistance ℂ).induce S) 4 p q :=
  not_forces_of_map_ne_zero F4.card_eq_four conj_mem_oddDenom psiA (fun v : S => (v : ℂ))
    (sub_mem_oddDenom_of_adj hS) sub_mem_normOne_of_adj hmem hres

/-- **A difference inside the prime carries no virtual edge**, likewise. -/
theorem not_separated_of_sub {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hmem : (p : ℂ) - (q : ℂ) ∈ oddDenom) (hres : psiA ⟨(p : ℂ) - (q : ℂ), hmem⟩ = 0) :
    ¬ Separated ((unitDistance ℂ).induce S) 4 p q :=
  not_separated_of_map_eq_zero F4.card_eq_four conj_mem_oddDenom psiA (fun v : S => (v : ℂ))
    (sub_mem_oddDenom_of_adj hS) sub_mem_normOne_of_adj hmem hres

/-! ## §4 The table

Each row is a distance, an odd integer, and an element of the order: `m · d = den x` pins the
distance, `decide` reads the residue of `x`, and the law does the rest.  The two helpers below
package that so a row is one line. -/

/-- **A distance whose order-witness has nonzero residue admits no forced-monochromatic pair.**
`d ≠ 0` is free here: a zero distance would make the witness zero, and zero has zero residue. -/
theorem not_forces_at {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S} {d : ℝ}
    (hdist : dist (p : ℂ) (q : ℂ) = d) (m : ℤ) (x : SeamOrder) (hm : Odd m)
    (hx : (m : ℂ) * (d : ℂ) = den x) (hres : psiZero x ≠ 0) :
    ¬ Forces ((unitDistance ℂ).induce S) 4 p q := by
  have hd0 : d ≠ 0 := by
    rintro rfl
    have hx0 : x = 0 := den_injective (by rw [← hx]; simp)
    exact hres (by rw [hx0]; exact map_zero psiZero)
  exact not_forces_of_residue_ne_zero hS ⟨x, m, hm, hx⟩ hd0 hdist
    (by rw [psiA_eq _ hm hx]; exact hres)

/-- **A distance whose order-witness has zero residue admits no virtual edge.** -/
theorem not_separated_at {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S} {d : ℝ}
    (hdist : dist (p : ℂ) (q : ℂ) = d) (hd0 : d ≠ 0) (m : ℤ) (x : SeamOrder) (hm : Odd m)
    (hx : (m : ℂ) * (d : ℂ) = den x) (hres : psiZero x = 0) :
    ¬ Separated ((unitDistance ℂ).induce S) 4 p q :=
  not_separated_of_residue_eq_zero hS ⟨x, m, hm, hx⟩ hd0 hdist
    (by rw [psiA_eq _ hm hx]; exact hres)

/-! ### The two radicals the table needs -/

/-- `√3` in the order: `i√3 = 1 + 2ω`, so `√3 = −i(1 + 2ω)`. -/
def ordSqrt3 : SeamOrder := -(ordI * (1 + 2 * ordOmega))

/-- `√33` in the order: `T = (1 + √33)/2`, so `√33 = 2T − 1`. -/
def ordSqrt33 : SeamOrder := 2 * ordTau - 1

theorem den_ordSqrt3 : den ordSqrt3 = ((Real.sqrt 3 : ℝ) : ℂ) := by
  rw [ordSqrt3]
  simp only [map_neg, map_mul, map_add, map_one, map_ofNat, den_ordOmega, den_ordI]
  apply Complex.ext <;> simp [omega3, Complex.mul_re, Complex.mul_im] <;> ring

theorem den_ordSqrt33 : den ordSqrt33 = ((Real.sqrt 33 : ℝ) : ℂ) := by
  rw [ordSqrt33]
  simp only [map_sub, map_mul, map_one, map_ofNat, den_ordTau]
  apply Complex.ext <;> simp [tau]
  ring

/-! ### `√3` and `2` — the two distances the six-colour programme needs

The law settles **one polarity at each**: `√3` is a 2-adic unit, so it admits no
forced-monochromatic pair over `K`; `2` lies in the prime, so it admits no virtual edge (the
compulsion face of `residueColouring_eq_of_dist_two`).

The *other* polarity at each is **open over `K`**, and is not supplied by the plane-wide
pigeonholes `core9_plane` and `core122_plane` — those are vacuous, per §Scope above.  An earlier
draft of this very section said they were, which is the reason the scope paragraph exists;
`plans/STUB-four-colour-valuation-law.md` carries the non-vacuous replacement and its price. -/

/-- **No pair at distance `√3` is forced monochromatic at four colours over `K`.** -/
theorem not_forces_dist_sqrt_three {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hdist : dist (p : ℂ) (q : ℂ) = Real.sqrt 3) :
    ¬ Forces ((unitDistance ℂ).induce S) 4 p q :=
  not_forces_at hS hdist 1 ordSqrt3 odd_one (by rw [den_ordSqrt3]; push_cast; ring) (by decide)

/-- **No pair at distance `2` is a virtual edge at four colours over `K`** — the compulsion face
of `residueColouring_eq_of_dist_two`. -/
theorem not_separated_dist_two {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hdist : dist (p : ℂ) (q : ℂ) = 2) :
    ¬ Separated ((unitDistance ℂ).induce S) 4 p q :=
  not_separated_at hS hdist (by norm_num) 1 2 odd_one (by rw [map_ofNat]; push_cast; ring)
    (by decide)

/-! ### `[Parts2020a]`'s Table 1, both columns barred from swapping

His monochromatic distances are `8/3` and `8/√3`; his distinct ones are `3`, `7/3`, `5/3`, `1/3`
and `√(11/3)`.  The first two lie in the prime and the last five do not, so each is barred from
the other column — the pattern his table shows and does not explain. -/

/-- `8/3` — 2-adically even, so no virtual edge there. -/
theorem not_separated_dist_eight_thirds {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hdist : dist (p : ℂ) (q : ℂ) = 8 / 3) :
    ¬ Separated ((unitDistance ℂ).induce S) 4 p q :=
  not_separated_at hS hdist (by norm_num) 3 8 ⟨1, by norm_num⟩ (by rw [map_ofNat]; push_cast; ring)
    (by decide)

/-- `8/√3` — 2-adically even, so no virtual edge there. -/
theorem not_separated_dist_eight_over_sqrt_three {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hdist : dist (p : ℂ) (q : ℂ) = 8 / Real.sqrt 3) :
    ¬ Separated ((unitDistance ℂ).induce S) 4 p q := by
  have h3 : Real.sqrt 3 ≠ 0 := by positivity
  refine not_separated_at hS hdist (by positivity) 3 (8 * ordSqrt3) ⟨1, by norm_num⟩ ?_ (by decide)
  have hreal : (3 : ℝ) * (8 / Real.sqrt 3) = 8 * Real.sqrt 3 := by
    field_simp
    nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 3)]
  rw [map_mul, map_ofNat, den_ordSqrt3,
    show ((3 : ℤ) : ℂ) = ((3 : ℝ) : ℂ) by push_cast; ring, ← Complex.ofReal_mul, hreal]
  push_cast
  ring

/-- `3`, `7/3`, `5/3`, `1/3` — 2-adic units, so no forced-monochromatic pair at any of them. -/
theorem not_forces_dist_three {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hdist : dist (p : ℂ) (q : ℂ) = 3) : ¬ Forces ((unitDistance ℂ).induce S) 4 p q :=
  not_forces_at hS hdist 1 3 odd_one (by rw [map_ofNat]; push_cast; ring) (by decide)

theorem not_forces_dist_seven_thirds {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hdist : dist (p : ℂ) (q : ℂ) = 7 / 3) : ¬ Forces ((unitDistance ℂ).induce S) 4 p q :=
  not_forces_at hS hdist 3 7 ⟨1, by norm_num⟩ (by rw [map_ofNat]; push_cast; ring) (by decide)

theorem not_forces_dist_five_thirds {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hdist : dist (p : ℂ) (q : ℂ) = 5 / 3) : ¬ Forces ((unitDistance ℂ).induce S) 4 p q :=
  not_forces_at hS hdist 3 5 ⟨1, by norm_num⟩ (by rw [map_ofNat]; push_cast; ring) (by decide)

theorem not_forces_dist_one_third {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hdist : dist (p : ℂ) (q : ℂ) = 1 / 3) : ¬ Forces ((unitDistance ℂ).induce S) 4 p q :=
  not_forces_at hS hdist 3 1 ⟨1, by norm_num⟩ (by rw [map_one]; push_cast; ring) (by decide)

/-- `√(11/3)` — a 2-adic unit, so no forced-monochromatic pair there. -/
theorem not_forces_dist_sqrt_eleven_thirds {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hdist : dist (p : ℂ) (q : ℂ) = Real.sqrt (11 / 3)) :
    ¬ Forces ((unitDistance ℂ).induce S) 4 p q := by
  refine not_forces_at hS hdist 3 ordSqrt33 ⟨1, by norm_num⟩ ?_ (by decide)
  have hreal : (3 : ℝ) * Real.sqrt (11 / 3) = Real.sqrt 33 := by
    rw [show (33 : ℝ) = 3 ^ 2 * (11 / 3) by norm_num, Real.sqrt_mul (by positivity),
      Real.sqrt_sq (by norm_num)]
  rw [den_ordSqrt33, show ((3 : ℤ) : ℂ) = ((3 : ℝ) : ℂ) by push_cast; ring,
    ← Complex.ofReal_mul, hreal]

/-! ## §5 Spec

The residues the table turns on, read out; a model of the hypotheses, so the rows are not
statements about an empty situation; and the reds. -/

section Spec

-- **The two columns of `[Parts2020a]`'s Table 1, as one bit each.** His monochromatic distances
-- land in the prime; his distinct ones do not. Nothing else separates the two lists.
#guard psiZero 8 == (0 : F4)                  -- `8/3`
#guard psiZero (8 * ordSqrt3) == (0 : F4)     -- `8/√3`
#guard psiZero 2 == (0 : F4)                  -- distance `2`
#guard psiZero 3 != (0 : F4)                  -- `3`
#guard psiZero 7 != (0 : F4)                  -- `7/3`
#guard psiZero 5 != (0 : F4)                  -- `5/3`
#guard psiZero 1 != (0 : F4)                  -- `1/3`
#guard psiZero ordSqrt33 != (0 : F4)          -- `√(11/3)`
#guard psiZero ordSqrt3 != (0 : F4)           -- `√3`

-- **Red: the criterion is not the denominator.** `8/3` and `7/3` share a denominator and land in
-- different columns, so the law is reading the numerator's 2-adic valuation and nothing else.
#guard psiZero 8 != psiZero 7

/-- **A model of the hypotheses.** The `√3` row is not about an empty situation: `0` and `√3` are
points of `K²`, and they are `√3` apart. -/
theorem zero_mem_seamPlane : (0 : ℂ) ∈ seamPlane :=
  mem_seamPlane_iff.mpr ⟨by simp, by simp⟩

theorem one_mem_seamPlane : (1 : ℂ) ∈ seamPlane :=
  mem_seamPlane_iff.mpr ⟨by simp, by simp⟩

theorem ofReal_sqrt3_mem_seamPlane : ((Real.sqrt 3 : ℝ) : ℂ) ∈ seamPlane :=
  mem_seamPlane_iff.mpr ⟨by simpa using sqrt3_mem, by simp⟩

example : dist (0 : ℂ) ((Real.sqrt 3 : ℝ) : ℂ) = Real.sqrt 3 := by
  rw [Complex.dist_eq, zero_sub, norm_neg, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (Real.sqrt_nonneg 3)]

/-- **The `√3` row instantiated**, so its hypotheses are known satisfiable rather than assumed to
be: on the two-point `K`-object `{0, √3}` the theorem says something. -/
example : ¬ Forces ((unitDistance ℂ).induce ({0, ((Real.sqrt 3 : ℝ) : ℂ)} : Set ℂ)) 4
    ⟨0, by simp⟩ ⟨((Real.sqrt 3 : ℝ) : ℂ), by simp⟩ := by
  refine not_forces_dist_sqrt_three ?_ ?_
  · rintro z (rfl | rfl)
    · exact zero_mem_seamPlane
    · exact ofReal_sqrt3_mem_seamPlane
  · show dist (0 : ℂ) ((Real.sqrt 3 : ℝ) : ℂ) = Real.sqrt 3
    rw [Complex.dist_eq, zero_sub, norm_neg, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg (Real.sqrt_nonneg 3)]

/-- **A difference the scalar form cannot reach.** `√2` does not lie in `K`, so the law's
distance form says nothing at that distance — but `1 + i` is a difference of `K`-points of length
`√2`, it lies in the order outright, and its residue is zero. So no pair of `K`-points differing
by `1 + i` is a virtual edge at four colours, and the squared-distance form is what sees it
(`normSq (1 + i) = 2`, which is in the prime). -/
theorem onePlusI_mem_oddDenom : (1 : ℂ) + Complex.I ∈ oddDenom :=
  ⟨onePlusI, 1, odd_one, by rw [den_onePlusI]; push_cast; ring⟩

theorem psiA_onePlusI : psiA ⟨(1 : ℂ) + Complex.I, onePlusI_mem_oddDenom⟩ = 0 := by
  rw [psiA_eq _ odd_one (x := onePlusI) (by rw [den_onePlusI]; push_cast; ring)]
  decide

example : normSq ((1 : ℂ) + Complex.I) = 2 := by norm_num [Complex.normSq_apply]

/-- **Red: the colouring is not constant**, so "the residues agree" is not automatic and "they
differ" is not impossible. Unit-apart points differ; the distance-2 red in `FieldWall4.lean` is
the other half. -/
example : residueColouring 0 ≠ residueColouring 1 := by
  refine residueColouring_ne_of_dist_one zero_mem_seamPlane one_mem_seamPlane ?_
  rw [Complex.dist_eq]; norm_num

/-- **Red: `𝔽₄` really has no zero divisors**, which is the step that lets a unit vector be
cancelled from a residue. The mutation — dropping the cofactor's nonvanishing — is false. -/
example : ¬ ∀ a b : F4, a * b = 0 → a = 0 := fun h => by
  have := h 1 0 (by decide)
  exact absurd this (by decide)

end Spec

end FieldWall4

end HadwigerNelson
