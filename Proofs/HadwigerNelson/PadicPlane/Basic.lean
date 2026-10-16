import Proofs.HadwigerNelson.UnitQuadrance
import Mathlib.NumberTheory.Padics.RingHoms
import Mathlib.NumberTheory.Padics.ProperSpace
import Mathlib.MeasureTheory.Constructions.BorelSpace.Basic
import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex

/-!
# The p-adic plane: the Borel chromatic number, the tower ratio, and integral unit vectors (FS131-KPA1, skeleton)

**Read aloud, against `[BardestaniMallahiKarai2017]` §1 (pp. 1–2) and Definition 2.6 (p. 6).** The p-adic plane is
`padicPlane p`, an abbreviation for `unitQuadrance ℚ_[p]`: the vertices are the pairs `(x₁, x₂)` of p-adic numbers, and two are adjacent exactly when
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

/-! ## The p-adic plane -/

/-- **The p-adic plane** `QG_{𝒬_p}` (`[BardestaniMallahiKarai2017]` Definition 2.6, `𝒬_p = (ℚ_p², x₁² + x₂²)`): the pairs of
p-adic numbers, two adjacent when `(x₁ − y₁)² + (x₂ − y₂)² = 1`. An abbreviation for `unitQuadrance ℚ_[p]`, as
`finitePlane p` is for `unitQuadrance (ZMod p)`, so every lemma about `unitQuadrance` applies and the headlines read in the
domain's words. -/
noncomputable abbrev padicPlane (p : ℕ) [Fact p.Prime] : SimpleGraph (ℚ_[p] × ℚ_[p]) := unitQuadrance ℚ_[p]

/-- Spec: `(0, 0)` and `(1, 0)` are adjacent in the p-adic plane. -/
example (p : ℕ) [Fact p.Prime] : (padicPlane p).Adj (0, 0) (1, 0) := by
  rw [unitQuadrance_adj]
  exact ⟨by simp, by ring⟩

/-! ## The tower ratio -/

/-- **Every level of the residue tower at `p` holds at most the fraction `c`**: for every `k ≥ 1`, every independent set
of `UD(ℤ/p^k, 2)` has at most `c · p^{2k}` points. `c` does not depend on `k`. -/
def TowerRatio (p : ℕ) (c : ℝ) : Prop :=
  ∀ k : ℕ, 1 ≤ k → ∀ s : Finset (ZMod (p ^ k) × ZMod (p ^ k)),
    (unitQuadrance (ZMod (p ^ k))).IsIndepSet (s : Set (ZMod (p ^ k) × ZMod (p ^ k))) →
      (s.card : ℝ) ≤ c * (p : ℝ) ^ (2 * k)

/-- **The trivial tower ratio**: every level holds at most all of its points. The model of `TowerRatio`. -/
theorem towerRatio_one (p : ℕ) [Fact p.Prime] : TowerRatio p 1 := by
  intro k _ s _
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero k (Fact.out : p.Prime).ne_zero⟩
  have h := Finset.card_le_univ s
  rw [Fintype.card_prod, ZMod.card, ← pow_two, ← pow_mul, mul_comm] at h
  rw [one_mul]
  exact_mod_cast h

/-- A larger constant is a tower ratio as well. -/
theorem TowerRatio.mono {p : ℕ} {c c' : ℝ} (h : TowerRatio p c) (hc : c ≤ c') : TowerRatio p c' := fun k hk s hs =>
  (h k hk s hs).trans (mul_le_mul_of_nonneg_right hc (by positivity))

/-- **FS-66's L6 at a level**: under a tower ratio `c`, no level `UD(ℤ/p^k, 2)`, `k ≥ 1`, is `m`-colourable when `m·c < 1`
(its `p^{2k}` points would be covered by `m` independent sets of at most `c·p^{2k}` points each). -/
theorem not_colorable_of_towerRatio {p : ℕ} [Fact p.Prime] {c : ℝ} (hc : TowerRatio p c) {m : ℕ}
    (hm : (m : ℝ) * c < 1) (k : ℕ) (hk : 1 ≤ k) : ¬ (unitQuadrance (ZMod (p ^ k))).Colorable m := by
  classical
  rintro ⟨C⟩
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero k (Fact.out : p.Prime).ne_zero⟩
  have hcls : ∀ i : Fin m, ((Finset.univ.filter fun x => C x = i).card : ℝ) ≤ c * (p : ℝ) ^ (2 * k) := by
    intro i
    refine hc k hk _ fun x hx y hy _ hadj => ?_
    simp only [Finset.coe_filter, Finset.mem_univ, true_and, Set.mem_setOf_eq] at hx hy
    exact C.valid hadj (hx.trans hy.symm)
  have hsum : (Finset.univ : Finset (ZMod (p ^ k) × ZMod (p ^ k))).card =
      ∑ i : Fin m, (Finset.univ.filter fun x => C x = i).card :=
    Finset.card_eq_sum_card_fiberwise fun _ _ => Finset.mem_univ _
  have hcard : ((Finset.univ : Finset (ZMod (p ^ k) × ZMod (p ^ k))).card : ℝ) = (p : ℝ) ^ (2 * k) := by
    rw [Finset.card_univ, Fintype.card_prod, ZMod.card, ← pow_two, ← pow_mul, mul_comm]
    push_cast
    ring
  have hle' : ∑ i : Fin m, ((Finset.univ.filter fun x => C x = i).card : ℝ) ≤ m * c * (p : ℝ) ^ (2 * k) :=
    calc ∑ i : Fin m, ((Finset.univ.filter fun x => C x = i).card : ℝ)
        ≤ ∑ _i : Fin m, c * (p : ℝ) ^ (2 * k) := Finset.sum_le_sum fun i _ => hcls i
      _ = m * c * (p : ℝ) ^ (2 * k) := by
        rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
        ring
  have hle : (p : ℝ) ^ (2 * k) ≤ m * c * (p : ℝ) ^ (2 * k) := by
    have e : (p : ℝ) ^ (2 * k) = ∑ i : Fin m, ((Finset.univ.filter fun x => C x = i).card : ℝ) := by
      rw [← hcard, hsum]
      push_cast
      rfl
    exact e.le.trans hle'
  have hpos : (0 : ℝ) < (p : ℝ) ^ (2 * k) := pow_pos (Nat.cast_pos.2 (Fact.out : p.Prime).pos) _
  nlinarith

/-! ## Unit vectors are integral -/

/-- `−1` is not a square modulo a prime `p ≡ 3 (mod 4)`: a square root of `−1` would be a unit of order `4`, and `4` does
not divide `p − 1`. -/
private theorem not_sq_eq_neg_one {p : ℕ} [Fact p.Prime] (hp : p % 4 = 3) (x : ZMod p) : x ^ 2 ≠ -1 := by
  intro hx
  have hp2 : p ≠ 2 := by omega
  have hne : (-1 : ZMod p) ≠ 1 := by
    intro h
    have h2 : ((2 : ℕ) : ZMod p) = 0 := by
      have : (2 : ZMod p) = 1 - (-1) := by ring
      rw [Nat.cast_ofNat, this, h, sub_self]
    rw [ZMod.natCast_eq_zero_iff] at h2
    have := (Nat.prime_dvd_prime_iff_eq (Fact.out : p.Prime) Nat.prime_two).1 h2
    exact hp2 this
  have hx0 : x ≠ 0 := by
    rintro rfl
    rw [zero_pow two_ne_zero] at hx
    have h1 : (1 : ZMod p) = 0 := neg_eq_zero.mp hx.symm
    exact hne (by rw [h1, neg_zero])
  set u : (ZMod p)ˣ := Units.mk0 x hx0 with hu
  have hu2 : u ^ 2 ≠ 1 := by
    intro h
    have : x ^ 2 = 1 := by
      have := congrArg (fun v : (ZMod p)ˣ => (v : ZMod p)) h
      simpa [hu] using this
    exact hne (hx ▸ this)
  have hu4 : u ^ 4 = 1 := by
    ext
    simp only [hu, Units.val_pow_eq_pow_val, Units.val_mk0, Units.val_one]
    rw [show x ^ 4 = (x ^ 2) ^ 2 by ring, hx]
    ring
  have hd4 : orderOf u ∣ 4 := orderOf_dvd_of_pow_eq_one hu4
  have hd2 : ¬ orderOf u ∣ 2 := fun h => hu2 (orderOf_dvd_iff_pow_eq_one.1 h)
  have hdp : orderOf u ∣ p - 1 := by
    have := orderOf_dvd_card (x := u)
    rwa [Fintype.card_units, ZMod.card] at this
  have hpos : 0 < orderOf u := Nat.pos_of_dvd_of_pos hd4 (by norm_num)
  have hle : orderOf u ≤ 4 := Nat.le_of_dvd (by norm_num) hd4
  interval_cases h : orderOf u <;> omega

/-- The case `‖b‖ ≤ ‖a‖` of `norm_le_one_of_sq_add_sq_eq_one`: then `‖a‖ ≤ 1`. -/
private theorem norm_le_one_of_le_of_sq_add_sq {p : ℕ} [Fact p.Prime] (hp : p % 4 = 3) {a b : ℚ_[p]}
    (h : a ^ 2 + b ^ 2 = 1) (hab : ‖b‖ ≤ ‖a‖) : ‖a‖ ≤ 1 := by
  by_contra ha1
  push Not at ha1
  have ha0 : a ≠ 0 := by
    rintro rfl
    rw [norm_zero] at ha1
    linarith
  have hapos : 0 < ‖a‖ := norm_pos_iff.2 ha0
  set u : ℚ_[p] := b / a with hu
  have hu1 : ‖u‖ ≤ 1 := by
    rw [hu, norm_div, div_le_one hapos]
    exact hab
  have h1 : 1 + u ^ 2 = (a ^ 2)⁻¹ := by
    have ha2 : a ^ 2 ≠ 0 := pow_ne_zero 2 ha0
    rw [hu, div_pow]
    field_simp
    linear_combination h
  have hlt : ‖1 + u ^ 2‖ < 1 := by
    rw [h1, norm_inv, norm_pow]
    exact inv_lt_one_of_one_lt₀ (one_lt_pow₀ ha1 two_ne_zero)
  set U : ℤ_[p] := ⟨u, hu1⟩ with hU
  have hU' : ‖(1 + U ^ 2 : ℤ_[p])‖ < 1 := by
    rw [PadicInt.norm_def]
    push_cast
    exact hlt
  have hker : (1 + U ^ 2 : ℤ_[p]) ∈ RingHom.ker (PadicInt.toZMod : ℤ_[p] →+* ZMod p) := by
    rw [PadicInt.ker_toZMod, IsLocalRing.mem_maximalIdeal, PadicInt.mem_nonunits]
    exact hU'
  rw [RingHom.mem_ker, map_add, map_one, map_pow] at hker
  exact not_sq_eq_neg_one hp (PadicInt.toZMod U) (by linear_combination hker)

/-- **Unit vectors of the p-adic plane are integral at `p ≡ 3 (mod 4)`** (`[Madore2015]` Prop. 3.2, the first paragraph of
its proof): if `a² + b² = 1` in `ℚ_p` then `‖a‖ ≤ 1` and `‖b‖ ≤ 1`. (Were `‖a‖ ≥ ‖b‖` and `‖a‖ > 1`, then `u = b/a` has
`‖u‖ ≤ 1` and `‖1 + u²‖ = ‖1/a²‖ < 1`, so `u² ≡ −1 (mod p)`, and `−1` is not a square modulo `p`.) -/
theorem norm_le_one_of_sq_add_sq_eq_one {p : ℕ} [Fact p.Prime] (hp : p % 4 = 3) {a b : ℚ_[p]}
    (h : a ^ 2 + b ^ 2 = 1) : ‖a‖ ≤ 1 ∧ ‖b‖ ≤ 1 := by
  rcases le_total ‖b‖ ‖a‖ with hab | hab
  · have ha := norm_le_one_of_le_of_sq_add_sq hp h hab
    exact ⟨ha, hab.trans ha⟩
  · have hb := norm_le_one_of_le_of_sq_add_sq hp (by rw [add_comm]; exact h) hab
    exact ⟨hab.trans hb, hb⟩

/-- Spec: the hypothesis of `norm_le_one_of_sq_add_sq_eq_one` is inhabited by `(1, 0)` at `p = 3`. -/
example : haveI : Fact (Nat.Prime 3) := ⟨Nat.prime_three⟩; (1 : ℚ_[3]) ^ 2 + (0 : ℚ_[3]) ^ 2 = 1 := by norm_num

end HadwigerNelson.PadicPlane
