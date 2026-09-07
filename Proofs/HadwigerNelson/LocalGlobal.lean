import Proofs.HadwigerNelson.ResidueObstruction
import Mathlib.NumberTheory.LegendreSymbol.Basic

/-!
# Local–global tightness: the periodic quotient, the counting bound, and the spindle that escapes its prime

The **local bound** of a real field `F` is the least number of colours any residue colouring of `F²` uses — at
the prime above `2` (Theorem B), at `3` (Fischer), and at every usable prime `p ≡ 3 (mod 4)` the chromatic number
of the finite plane `UD(𝔽_p, 2)` (M58). The conjecture M61 studies (`plans/M61-local-global-tightness.md`) is that
`χ(F²)` IS that bound wherever the bound is at most `6`. This module holds the three pieces of kernel content the
milestone's derivations produced:

* **The periodic quotient** (§S3). A colouring of a Cayley graph `addCayley S` that is constant on the cosets of a
  subgroup is a colouring of the quotient Cayley graph: an additive hom `π` whose kernel misses `S` is a graph hom
  `addCayley S →g addCayley D` for any `D` containing the projected connection set (`addCayleyMap`), so a colouring
  of the quotient pulls back (`colorable_of_addCayley_quotient`). For the finite plane the quotient along a null
  direction (`projAlong v`) is a circulant on `p` vertices, and a table on `ZMod p` that is proper along the projected
  circle is a periodic colouring of the plane (`addCayleyColoring`, `unitQuadrance_colorable_of_quotient`). At `19`
  this is a nineteen-entry certificate of `χ(UD(𝔽₁₉, 2)) ≤ 5` (`Instances/LocalGlobal19.lean`).
* **The counting bound** (§S2). A `k`-colourable finite graph has at most `k · a` vertices when every independent
  set has at most `a` (`card_le_mul_of_colorable`), so `card ≤ k · indepNum` and, in `ℕ∞`, `card ≤ χ · α` — the
  fractional face of the first digit, whose consumer is a certified refutation of an independent set (none exists
  yet; the tools' α refusals are the solver's).
* **The spindle escapes its prime** (§S5). In `ZMod p` with `p ≡ 3 (mod 4)` there are no isotropic vectors
  (`quadrance_eq_zero_iff`), so a pair whose residues coincide has a residue-`0` squared distance; and a ring hom
  into a field cannot send `d` to `0` when the source holds the spindle radicand `√(4d − 1)` up to a unit without
  making `−1` a square in the target (`isSquare_neg_one_of_spindle_radicand`). Composed with M60's transfer: **a graph
  forcing a pair equal at `k` colours, drawn in a ring that holds that pair's spindle radicand, admits no reduction to
  a plane that is forces-free at `k`** (`Forces.no_hom_of_spindle_radicand`, `Forces.isEmpty_ringHom_of_spindle_radicand`).
  That is the mechanism of tightness: a forcer built as "fabric forcing a pair at `k` colours + the spindle over it"
  lands in a field where the prime that sealed the fabric at `k` is no longer usable — the local bound it beats is the
  one its own construction removes.

## What a consumer may conclude, and what not

The quotient theorems are about Cayley graphs and additive homs; the plane instance needs the projection to miss the
circle (a null direction), decided per prime, and gives an UPPER bound only. The counting bound is unconditional. The
radicand lemma is ring-level: the field-level statement ("every prime of `F(√(4d² − 1))` above `p` has even residue
degree") is a hand argument (`plans/M61-local-global-tightness.md` §S5), exactly as M58's integrality is.
`Forces.no_hom_of_spindle_radicand` takes the plane's forces-freeness as a hypothesis — a theorem at `11`
(`finitePlane11_forces_iff`), a two-table witness at `3` (`Instances/LocalGlobal19.lean`), measured at `7` and `19` — and
that hypothesis can only hold when the plane is `k`-colourable (a plane refusing `k` colours forces every pair vacuously).
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### The circle and the quadrance, named -/

section Named

variable (R : Type*) [CommRing R]

/-- The unit circle of `R²`: the connection set `unitQuadrance R` is `addCayley` of. Reducible, so M58's inline
`v.1 ^ 2 + v.2 ^ 2 = 1` and this spelling never disagree. -/
abbrev unitCircle : Set (R × R) := {v | v.1 ^ 2 + v.2 ^ 2 = 1}

variable {R}

/-- The quadrance of a vector: Wildberger's squared length, `w.1 ^ 2 + w.2 ^ 2`. Reducible. -/
abbrev quadrance (w : R × R) : R := w.1 ^ 2 + w.2 ^ 2

theorem unitQuadrance_eq_addCayley : unitQuadrance R = addCayley (unitCircle R) := rfl

theorem mem_unitCircle {v : R × R} : v ∈ unitCircle R ↔ quadrance v = 1 := Iff.rfl

end Named

/-! ### The periodic quotient of a Cayley graph -/

section Quotient

variable {A B : Type*} [AddGroup A] [AddGroup B] {k : ℕ}

/-- **An additive hom whose kernel misses the connection set is a Cayley-graph homomorphism** onto any set holding the
projected connection set. Adjacent vertices differ by an element of `S`, whose image is nonzero and lies in `D`. -/
def addCayleyMap (π : A →+ B) {S : Set A} {D : Set B} (hS : ∀ s ∈ S, π s ≠ 0) (hD : ∀ s ∈ S, π s ∈ D) :
    addCayley S →g addCayley D where
  toFun := π
  map_rel' := sorry

@[simp] theorem addCayleyMap_apply (π : A →+ B) {S : Set A} {D : Set B} (hS : ∀ s ∈ S, π s ≠ 0)
    (hD : ∀ s ∈ S, π s ∈ D) (a : A) : addCayleyMap π hS hD a = π a := rfl

/-- **A colouring of the quotient is a colouring of the graph** — a periodic colouring, in the quotient's words. -/
theorem colorable_of_addCayley_quotient (π : A →+ B) {S : Set A} {D : Set B} (hS : ∀ s ∈ S, π s ≠ 0)
    (hD : ∀ s ∈ S, π s ∈ D) (h : (addCayley D).Colorable k) : (addCayley S).Colorable k :=
  h.of_hom (addCayleyMap π hS hD)

/-- **A table proper along the connection set is a colouring of the Cayley graph.** The hypothesis is the decidable
one a finite instance checks — no coincidence `tab (x + d) = tab x` at any `d ∈ D` (M60's `CoincidesAtNonedges`
demands the coincidence at every non-edge; properness forbids it at every edge). -/
def addCayleyColoring {D : Set B} (tab : B → Fin k) (h : ∀ d ∈ D, ∀ x, tab (x + d) ≠ tab x) :
    (addCayley D).Coloring (Fin k) :=
  sorry

/-- The pulled-back colouring is periodic at every element of the kernel — the periodic colourings of M60's
`Aperiodic` vocabulary are exactly these. -/
theorem periodic_comp_of_mem_ker (π : A →+ B) (tab : B → Fin k) {d : A} (hd : π d = 0) :
    Function.Periodic (fun a => tab (π a)) d :=
  sorry

/-- **A family of colourings with no common nonzero period refutes every forced pair** — M60's
`forces_iff_eq_of_aperiodic` is the singleton case. -/
theorem eq_of_forces_of_forall_exists_not_periodic {S : Set A} (cols : List ((addCayley S).Coloring (Fin k)))
    (h : ∀ d : A, d ≠ 0 → ∃ c ∈ cols, ¬ Function.Periodic c d) {x y : A} (hf : Forces (addCayley S) k x y) : x = y :=
  sorry

end Quotient

/-! ### The plane's periodic colourings -/

section Plane

variable {R : Type*} [CommRing R] {k : ℕ}

/-- **The projection along a direction `v`**: `w ↦ v.1·w.2 − v.2·w.1`, the 2-D determinant, whose kernel is the line
through `v`. When the line is null (misses the unit circle) it is the periodic quotient's projection. -/
def projAlong (v : R × R) : R × R →+ R where
  toFun w := v.1 * w.2 - v.2 * w.1
  map_zero' := by simp
  map_add' u w := by simp only [Prod.fst_add, Prod.snd_add]; ring

@[simp] theorem projAlong_apply (v w : R × R) : projAlong v w = v.1 * w.2 - v.2 * w.1 := rfl

/-- The direction itself lies in the kernel. -/
theorem projAlong_self (v : R × R) : projAlong v v = 0 := by simp [mul_comm]

/-- **The plane is `k`-colourable as soon as its quotient along a null direction is.** The circle must miss the
kernel (`hS`) and project into `D` (`hD`); a table on the quotient proper along `D` then colours the plane, with the
kernel's elements as periods. -/
theorem unitQuadrance_colorable_of_quotient (π : R × R →+ R) {D : Set R} (hS : ∀ s ∈ unitCircle R, π s ≠ 0)
    (hD : ∀ s ∈ unitCircle R, π s ∈ D) (tab : R → Fin k) (h : ∀ d ∈ D, ∀ x, tab (x + d) ≠ tab x) :
    (unitQuadrance R).Colorable k :=
  sorry

end Plane

/-! ### The counting bound -/

section Counting

variable {V : Type*} {G : SimpleGraph V} {k a : ℕ}

/-- **A `k`-colourable finite graph has at most `k · a` vertices when no independent set exceeds `a`**: the colour
classes partition the vertices into `k` independent sets. -/
theorem card_le_mul_of_colorable [Fintype V] [DecidableEq V] (hα : ∀ s : Finset V, G.IsIndepSet (s : Set V) → s.card ≤ a)
    (h : G.Colorable k) : Fintype.card V ≤ k * a :=
  sorry

/-- The bound at `a = indepNum`. -/
theorem card_le_mul_indepNum_of_colorable [Fintype V] [DecidableEq V] (h : G.Colorable k) :
    Fintype.card V ≤ k * G.indepNum :=
  card_le_mul_of_colorable (fun _ hs => hs.card_le_indepNum) h

/-- The contrapositive — the consumer of a certified refutation of an independent set. -/
theorem not_colorable_of_mul_lt [Fintype V] [DecidableEq V] (hα : ∀ s : Finset V, G.IsIndepSet (s : Set V) → s.card ≤ a)
    (h : k * a < Fintype.card V) : ¬ G.Colorable k :=
  fun hc => absurd (card_le_mul_of_colorable hα hc) (not_le.mpr h)

/-- **The fractional face: `card ≤ χ · α`**, in `ℕ∞`. -/
theorem card_le_chromaticNumber_mul_indepNum [Fintype V] [DecidableEq V] :
    (Fintype.card V : ℕ∞) ≤ G.chromaticNumber * G.indepNum :=
  sorry

end Counting

/-! ### No isotropic vectors, and the spindle radicand -/

section Spindle

variable {p : ℕ} [Fact p.Prime]

/-- **No isotropic vectors modulo a prime `≡ 3 (mod 4)`**: `a² + b² = 0` forces `a = b = 0`, because otherwise
`(a/b)² = −1` and `−1` is not a square (`ZMod.exists_sq_eq_neg_one_iff`). -/
theorem sq_add_sq_eq_zero_iff (hp : p % 4 = 3) {a b : ZMod p} : a ^ 2 + b ^ 2 = 0 ↔ a = 0 ∧ b = 0 :=
  sorry

/-- The same, for a vector of the plane. -/
theorem quadrance_eq_zero_iff (hp : p % 4 = 3) {w : ZMod p × ZMod p} : quadrance w = 0 ↔ w = 0 := by
  rw [quadrance, sq_add_sq_eq_zero_iff hp, Prod.ext_iff]; rfl

/-- A ring hom commutes with the quadrance. -/
theorem quadrance_map {R S : Type*} [CommRing R] [CommRing S] (φ : R →+* S) (w : R × R) :
    quadrance (φ w.1, φ w.2) = φ (quadrance w) := by
  simp only [quadrance, map_add, map_pow]

/-- **The spindle radicand forces `√−1` into the target.** If `R` holds `x, e` with `x² = (4d − 1)·e²` — the radicand
of the spindle over a pair at squared distance `d`, up to the unit `e` — then a ring hom `φ` into a field that sends
`d` to `0` and keeps `e` nonzero makes `−1` a square: `φ(x/e)² = −1`. -/
theorem isSquare_neg_one_of_spindle_radicand {R K : Type*} [CommRing R] [Field K] (φ : R →+* K) {x d e : R}
    (hx : x ^ 2 = (4 * d - 1) * e ^ 2) (hd : φ d = 0) (he : φ e ≠ 0) : IsSquare (-1 : K) :=
  sorry

/-- **The spindle radicand kills the prime**: at `p ≡ 3 (mod 4)` no such hom exists. -/
theorem no_ringHom_of_spindle_radicand {R : Type*} [CommRing R] (hp : p % 4 = 3) (φ : R →+* ZMod p) {x d e : R}
    (hx : x ^ 2 = (4 * d - 1) * e ^ 2) (hd : φ d = 0) (he : φ e ≠ 0) : False :=
  ZMod.exists_sq_eq_neg_one_iff.mp (isSquare_neg_one_of_spindle_radicand φ hx hd he) hp

/-- **A reduction that identifies two drawn points kills their squared distance.** A drawing `g` into `R` composed with
`φ` is a drawing into `S`; if that drawing sends `u` and `v` to one point, `φ` sends the quadrance of `g u − g v` to
`0`. -/
theorem quadrance_sub_eq_zero_of_map_eq {V R S : Type*} {G : SimpleGraph V} [CommRing R] [CommRing S] [Nontrivial S]
    (g : G →g unitQuadrance R) (φ : R →+* S) {u v : V}
    (h : (unitQuadrance.map φ).comp g u = (unitQuadrance.map φ).comp g v) : φ (quadrance (g u - g v)) = 0 :=
  sorry

/-- **A forced pair's spindle escapes every plane that is forces-free at that many colours.** `G` is drawn in `R`
by `g`; the pair `u, v` is forced equal at `k` colours; the plane `UD(ZMod p)` is `k`-forces-free; then no ring hom
`φ : R →+* ZMod p` can exist once `R` holds the pair's spindle radicand — along `φ` the pair's residues coincide
(`Forces.image` + forces-freeness), so `φ` kills the squared distance, which the radicand lemma forbids. -/
theorem Forces.no_hom_of_spindle_radicand {V R : Type*} {G : SimpleGraph V} [CommRing R] {k : ℕ} (hp : p % 4 = 3)
    (hfree : ∀ u v : ZMod p × ZMod p, Forces (finitePlane p) k u v → u = v)
    (g : G →g unitQuadrance R) (φ : R →+* ZMod p) {u v : V} (h : Forces G k u v) {x e : R}
    (hx : x ^ 2 = (4 * quadrance (g u - g v) - 1) * e ^ 2) (he : φ e ≠ 0) : False :=
  sorry

/-- The consumer's shape: with the unit `e` a unit of `R`, **no reduction of `R` at `p` exists at all**. -/
theorem Forces.isEmpty_ringHom_of_spindle_radicand {V R : Type*} {G : SimpleGraph V} [CommRing R] {k : ℕ}
    (hp : p % 4 = 3) (hfree : ∀ u v : ZMod p × ZMod p, Forces (finitePlane p) k u v → u = v)
    (g : G →g unitQuadrance R) {u v : V} (h : Forces G k u v) {x e : R}
    (hx : x ^ 2 = (4 * quadrance (g u - g v) - 1) * e ^ 2) (he : IsUnit e) : IsEmpty (R →+* ZMod p) :=
  ⟨fun φ => Forces.no_hom_of_spindle_radicand hp hfree g φ h hx (he.map φ).ne_zero⟩

end Spindle

/-! ### Spec: the radicand lemma on the towers -/

-- The Moser spindle's radicand: `11 = 4·3 − 1` for the rhombus's `√3`-pair. No hom `ℤ[√11] → ZMod 3`.
example : IsEmpty (Adjoin 11 ℤ →+* ZMod 3) := sorry

-- The 6-level's radicand over a 5-sealed field: `43 = 4·11 − 1` for a forced `√11`-pair. No hom `ℤ[√43] → ZMod 11`.
example : IsEmpty (Adjoin 43 ℤ →+* ZMod 11) := sorry

-- Positive controls: `√3 ↦ 5` reduces `ℤ[√3]` at `11` (`25 ≡ 3`), and `√11 ↦ 0` reduces `ℤ[√11]` at `11` — sending
-- the radicand's `d` to `0` alone is no obstruction; the spindle's `4d − 1 ≡ −1` is.
example : Adjoin 3 ℤ →+* ZMod 11 := Adjoin.lift (Int.castRingHom (ZMod 11)) 5 (by decide)
example : Adjoin 11 ℤ →+* ZMod 11 := Adjoin.lift (Int.castRingHom (ZMod 11)) 0 (by decide)

-- Red for the quotient: at `7` the direction `(1, 1)` is NOT null (`2 = 3²`), so `projAlong (1, 1)` kills a circle point
-- and `unitQuadrance_colorable_of_quotient` has no `hS` to take — a colouring constant on that line's cosets is improper.
example : ¬ ∀ s ∈ unitCircle (ZMod 7), projAlong ((1 : ZMod 7), (1 : ZMod 7)) s ≠ 0 := by decide

end HadwigerNelson
