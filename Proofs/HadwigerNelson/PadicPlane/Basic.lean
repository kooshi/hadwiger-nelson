import Proofs.HadwigerNelson.UnitQuadrance
import Mathlib.NumberTheory.Padics.RingHoms
import Mathlib.NumberTheory.Padics.ProperSpace
import Mathlib.MeasureTheory.Constructions.BorelSpace.Basic
import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex

/-!
# The p-adic plane: the Borel chromatic number, the tower ratio, and integral unit vectors (FS131-KPA1, skeleton)

**Read aloud, against `[BardestaniMallahiKarai2017]` §1 (pp. 1–2) and Definition 2.6 (p. 6).** The p-adic plane is
`unitQuadrance ℚ_[p]`: the vertices are the pairs `(x₁, x₂)` of p-adic numbers, and two are adjacent exactly when
`(x₁ − y₁)² + (x₂ − y₂)² = 1` — the posers' quadratic graph `QG_{𝒬_p}`, `𝒬_p = (ℚ_p², x₁² + x₂²)`. Its **Borel chromatic
number** (`borelChromaticNumber`) is the least `k` for which the vertices can be partitioned into `k` Borel sets none of which
contains two adjacent vertices: the posers' `χ_Bor` ("the least cardinal `c` such that the set `V(𝒢)` can be partitioned
into `c` Borel subsets none of which contains two adjacent vertices"), read in `ℕ∞` — every infinite cardinal is `⊤` here,
which no statement of these modules reads, since every bound they prove is finite. The plain chromatic number of the same
graph is Mathlib's `chromaticNumber`; nothing in these modules bounds it from below.

* `borelChromaticNumber`, `borelChromaticNumber_le_of_coloring`, `le_borelChromaticNumber`,
  `chromaticNumber_le_borelChromaticNumber` — the definition and its three faces.
* `TowerRatio p c` — **every level of the residue tower holds at most the fraction `c`**: every independent set of
  `UD(ℤ/p^k, 2) = unitQuadrance (ZMod (p ^ k))`, `k ≥ 1`, has at most `c · p^{2k}` points. This is the statement the
  posers' objection asks to see — the bound at levels two and above, with `c` independent of the level. Proved instances
  are in `PadicPlane/Tower` (Weil, and any certificate's `U`); its consumer is `PadicPlane/Measure`.
* `not_colorable_of_towerRatio` — FS-66's L6 at a level: `m·c < 1` refuses `m` colours at every level.
* `norm_le_one_of_sq_add_sq_eq_one` — **unit vectors are integral** at `p ≡ 3 (mod 4)` (`[Madore2015]` Prop. 3.2, first
  paragraph of the proof): `a² + b² = 1` in `ℚ_p` forces `‖a‖ ≤ 1` and `‖b‖ ≤ 1`.

**Models.** `TowerRatio p 1` holds at every prime `p` (`towerRatio_one`: an independent set is a set of the level); with it
`not_colorable_of_towerRatio`'s hypothesis `m·1 < 1` leaves `m = 0`, and `¬ Colorable 0` of a nonempty graph is true.
`borelChromaticNumber_le_of_coloring` is inhabited by the empty graph's constant colouring (the spec example) and by
`PadicPlane/Upper`'s residue colouring. The unit vector `(1, 0)` satisfies the hypothesis of
`norm_le_one_of_sq_add_sq_eq_one`.
-/

namespace HadwigerNelson.PadicPlane

open SimpleGraph MeasureTheory

section Borel

variable {X : Type*} [TopologicalSpace X]

/-- **The Borel chromatic number** of a graph on a topological space (`[BardestaniMallahiKarai2017]` §1, p. 1): the least
`k` such that the vertices are partitioned into `k` Borel sets none of which contains an edge — a proper colouring into
`Fin k` each of whose colour classes lies in `borel X`; `⊤` when there is none. -/
noncomputable def borelChromaticNumber (G : SimpleGraph X) : ℕ∞ :=
  ⨅ (k : ℕ) (_ : ∃ c : G.Coloring (Fin k), ∀ i, MeasurableSet[borel X] (⇑c ⁻¹' {i})), (k : ℕ∞)

/-- A proper colouring with Borel classes bounds the Borel chromatic number. -/
theorem borelChromaticNumber_le_of_coloring {G : SimpleGraph X} {k : ℕ} (c : G.Coloring (Fin k))
    (hc : ∀ i, MeasurableSet[borel X] (⇑c ⁻¹' {i})) : borelChromaticNumber G ≤ k :=
  iInf₂_le k ⟨c, hc⟩

/-- A lower bound on every Borel colouring's number of colours bounds the Borel chromatic number from below. -/
theorem le_borelChromaticNumber {G : SimpleGraph X} {n : ℕ∞}
    (h : ∀ k : ℕ, (∃ c : G.Coloring (Fin k), ∀ i, MeasurableSet[borel X] (⇑c ⁻¹' {i})) → n ≤ k) :
    n ≤ borelChromaticNumber G :=
  le_iInf₂ h

/-- **The plain number is at most the Borel number**: a Borel colouring is a colouring. Nothing is claimed in the other
direction. -/
theorem chromaticNumber_le_borelChromaticNumber (G : SimpleGraph X) :
    G.chromaticNumber ≤ borelChromaticNumber G :=
  le_borelChromaticNumber fun _ ⟨c, _⟩ => SimpleGraph.Colorable.chromaticNumber_le ⟨c⟩

/-- Spec: the graph with no edges on any topological space has a Borel one-colouring (the constant map; its one class is
the whole space). -/
example : borelChromaticNumber (⊥ : SimpleGraph X) ≤ 1 :=
  borelChromaticNumber_le_of_coloring (SimpleGraph.Coloring.mk (fun _ => 0) fun h => h.elim) fun i => by
    by_cases h : i = 0
    · subst h
      have : (⇑(SimpleGraph.Coloring.mk (G := (⊥ : SimpleGraph X)) (fun _ => (0 : Fin 1)) fun h => h.elim)) ⁻¹'
          {0} = Set.univ := by ext; simp [SimpleGraph.Coloring.mk]
      rw [this]
      exact @MeasurableSet.univ X (borel X)
    · exact absurd (Fin.fin_one_eq_zero i) h

end Borel

/-! ## The tower ratio -/

/-- **Every level of the residue tower at `p` holds at most the fraction `c`**: for every `k ≥ 1`, every independent set
of `UD(ℤ/p^k, 2)` has at most `c · p^{2k}` points. `c` does not depend on `k`. -/
def TowerRatio (p : ℕ) (c : ℝ) : Prop :=
  ∀ k : ℕ, 1 ≤ k → ∀ s : Finset (ZMod (p ^ k) × ZMod (p ^ k)),
    (unitQuadrance (ZMod (p ^ k))).IsIndepSet (s : Set (ZMod (p ^ k) × ZMod (p ^ k))) →
      (s.card : ℝ) ≤ c * (p : ℝ) ^ (2 * k)

/-- **The trivial tower ratio**: every level holds at most all of its points. The model of `TowerRatio`. -/
theorem towerRatio_one (p : ℕ) [Fact p.Prime] : TowerRatio p 1 := by
  sorry

/-- A larger constant is a tower ratio as well. -/
theorem TowerRatio.mono {p : ℕ} {c c' : ℝ} (h : TowerRatio p c) (hc : c ≤ c') : TowerRatio p c' := fun k hk s hs =>
  (h k hk s hs).trans (mul_le_mul_of_nonneg_right hc (by positivity))

/-- **FS-66's L6 at a level**: under a tower ratio `c`, no level `UD(ℤ/p^k, 2)`, `k ≥ 1`, is `m`-colourable when `m·c < 1`
(its `p^{2k}` points would be covered by `m` independent sets of at most `c·p^{2k}` points each). -/
theorem not_colorable_of_towerRatio {p : ℕ} [Fact p.Prime] {c : ℝ} (hc : TowerRatio p c) {m : ℕ}
    (hm : (m : ℝ) * c < 1) (k : ℕ) (hk : 1 ≤ k) : ¬ (unitQuadrance (ZMod (p ^ k))).Colorable m := by
  sorry

/-! ## Unit vectors are integral -/

/-- **Unit vectors of the p-adic plane are integral at `p ≡ 3 (mod 4)`** (`[Madore2015]` Prop. 3.2, the first paragraph of
its proof): if `a² + b² = 1` in `ℚ_p` then `‖a‖ ≤ 1` and `‖b‖ ≤ 1`. (Were `‖a‖ ≥ ‖b‖` and `‖a‖ > 1`, then `u = b/a` has
`‖u‖ ≤ 1` and `‖1 + u²‖ = ‖1/a²‖ < 1`, so `u² ≡ −1 (mod p)`, and `−1` is not a square modulo `p`.) -/
theorem norm_le_one_of_sq_add_sq_eq_one {p : ℕ} [Fact p.Prime] (hp : p % 4 = 3) {a b : ℚ_[p]}
    (h : a ^ 2 + b ^ 2 = 1) : ‖a‖ ≤ 1 ∧ ‖b‖ ≤ 1 := by
  sorry

/-- Spec: the hypothesis of `norm_le_one_of_sq_add_sq_eq_one` is inhabited by `(1, 0)` at `p = 3`. -/
example : haveI : Fact (Nat.Prime 3) := ⟨Nat.prime_three⟩; (1 : ℚ_[3]) ^ 2 + (0 : ℚ_[3]) ^ 2 = 1 := by norm_num

end HadwigerNelson.PadicPlane
