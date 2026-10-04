import Proofs.HadwigerNelson.Plane.Cover
import Mathlib.MeasureTheory.Measure.Lebesgue.VolumeOfBalls

/-!
# Partial colourings, band-properness, upper density, and the four suprema `µ_k` (FS-131 wave 2's foundation)

FS106-TQ § 3 (`plans/FS106-TQ-derivation.md`) defines four suprema, each over families of disjoint measurable classes,
of the upper density of their union; FS129-SR2-SUPK reads them at every `k`:

* `muZero k` — `µ_k⁰`: classes with null unit pairs (`Leb ⊗ σ`, the unit distance only);
* `mu k ε` — `µ_k(ε)`: classes with `Leb ⊗ Leb`-null monochromatic pairs at distances in `[1 − ε, 1 + ε]` (D-MU);
* `muTile k ε` — `µ_k^tile(ε)`: classes that are unions of half-open grid squares of one side `h > 0`, with **no**
  monochromatic pair at a distance in `[1 − ε, 1 + ε]`;
* `muPer k ε` — `µ_k^per(ε)`: the same, periodic.

Every class predicate is on **one set** (`BandNull`, `BandFree`, `IsGridUnion`, `IsPeriodicSet`), as `UnitPairsNull` is,
and a partial colouring is a family with `IsPartialColouring` (measurable, pairwise disjoint).

**Two readings fixed here** (the derivations leave them implicit; `plans/FS131-w2-kernel-plan.md` § 2):
* *upper density* is `limsup_{R → ∞} |S ∩ B(0, R)| / |B(0, R)|`, balls centred at the origin — the suprema do not see the
  centre or the shape (Lemma P re-centres and re-periodizes any window), but a single family's density does;
* *periodic* is invariance under the square lattice `Lℤ²` for some `L > 0` — Lemma P's lattice `(R + 2)ℤ²`, narrower than
  "under some lattice", which makes `lim µ^per = µ⁰` the stronger statement.

`HasSlack` and `Tight` are D-SLACK form (a) for a full colouring.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric Function

variable {k : ℕ}

/-! ## Upper density of a set in the plane -/

/-- `d̄(S) = limsup_{R → ∞} |S ∩ B(0, R)| / |B(0, R)|`. -/
noncomputable def upperDensity (S : Set ℂ) : ENNReal :=
  limsup (fun R : ℝ => volume (S ∩ ball 0 R) / volume (ball (0 : ℂ) R)) atTop

/-! ## Band pairs, band-properness, grid squares, periodicity (one set) -/

/-- The pairs of `A` at a distance in `[1 − ε, 1 + ε]`. -/
def bandPairSet (A : Set ℂ) (ε : ℝ) : Set (ℂ × ℂ) :=
  {q | q.1 ∈ A ∧ q.2 ∈ A ∧ 1 - ε ≤ dist q.1 q.2 ∧ dist q.1 q.2 ≤ 1 + ε}

/-- `A`'s pairs at distances in `[1 − ε, 1 + ε]` are `Leb ⊗ Leb`-null (D-SLACK form (a), one class). -/
def BandNull (A : Set ℂ) (ε : ℝ) : Prop := (volume.prod volume) (bandPairSet A ε) = 0

/-- `A` has **no** pair at a distance in `[1 − ε, 1 + ε]`. -/
def BandFree (A : Set ℂ) (ε : ℝ) : Prop := ∀ x ∈ A, ∀ y ∈ A, dist x y < 1 - ε ∨ 1 + ε < dist x y

/-- The half-open grid square of side `h` containing `x`: `[ih, (i+1)h) × [jh, (j+1)h)`. -/
def gridCell (h : ℝ) (x : ℂ) : Set ℂ := {y | ⌊y.re / h⌋ = ⌊x.re / h⌋ ∧ ⌊y.im / h⌋ = ⌊x.im / h⌋}

/-- `A` is a union of half-open grid squares of side `h`. -/
def IsGridUnion (h : ℝ) (A : Set ℂ) : Prop := ∀ x ∈ A, gridCell h x ⊆ A

/-- `A` is invariant under the square lattice `Lℤ²`. -/
def IsPeriodicSet (L : ℝ) (A : Set ℂ) : Prop := ∀ x : ℂ, (x + (L : ℂ) ∈ A ↔ x ∈ A) ∧ (x + (L : ℂ) * I ∈ A ↔ x ∈ A)

/-! ## Partial colourings and the four suprema -/

/-- A **partial colouring**: `k` measurable, pairwise disjoint classes (uncoloured points allowed). -/
def IsPartialColouring (C : Fin k → Set ℂ) : Prop := (∀ j, MeasurableSet (C j)) ∧ Pairwise (Disjoint on C)

/-- Every class of `C` is a union of half-open grid squares of one side `h > 0`. -/
def IsTiled (C : Fin k → Set ℂ) : Prop := ∃ h > 0, ∀ j, IsGridUnion h (C j)

/-- Every class of `C` is invariant under one square lattice `Lℤ²`, `L > 0`. -/
def IsPeriodic (C : Fin k → Set ℂ) : Prop := ∃ L > 0, ∀ j, IsPeriodicSet L (C j)

/-- `µ_k⁰`: the supremum of the upper density covered by an a.e.-proper partial `k`-colouring. -/
noncomputable def muZero (k : ℕ) : ENNReal :=
  ⨆ (C : Fin k → Set ℂ) (_ : IsPartialColouring C ∧ ∀ j, UnitPairsNull (C j)), upperDensity (⋃ j, C j)

/-- `µ_k(ε)`: the same over partial colourings whose classes are `BandNull` at `ε` (D-MU). -/
noncomputable def mu (k : ℕ) (ε : ℝ) : ENNReal :=
  ⨆ (C : Fin k → Set ℂ) (_ : IsPartialColouring C ∧ ∀ j, BandNull (C j) ε), upperDensity (⋃ j, C j)

/-- `µ_k^tile(ε)`: over tiled partial colourings whose classes are `BandFree` at `ε`. -/
noncomputable def muTile (k : ℕ) (ε : ℝ) : ENNReal :=
  ⨆ (C : Fin k → Set ℂ) (_ : IsPartialColouring C ∧ IsTiled C ∧ ∀ j, BandFree (C j) ε), upperDensity (⋃ j, C j)

/-- `µ_k^per(ε)`: over tiled, periodic partial colourings whose classes are `BandFree` at `ε`. -/
noncomputable def muPer (k : ℕ) (ε : ℝ) : ENNReal :=
  ⨆ (C : Fin k → Set ℂ) (_ : IsPartialColouring C ∧ IsTiled C ∧ IsPeriodic C ∧ ∀ j, BandFree (C j) ε),
    upperDensity (⋃ j, C j)

/-! ## Slack and tightness of a full colouring (D-SLACK form (a)) -/

/-- `c` has **slack `ε`**: every class is `BandNull` at `ε`. -/
def AeColouring.HasSlack (c : AeColouring k) (ε : ℝ) : Prop := ∀ j, BandNull (c.cls j) ε

/-- `c` is **tight**: it has slack for no `ε > 0`. -/
def AeColouring.Tight (c : AeColouring k) : Prop := ∀ ε > 0, ¬ c.HasSlack ε

/-! ## Basic facts the spec examples use -/

theorem volume_ball_ne_zero {R : ℝ} (hR : 0 < R) : volume (ball (0 : ℂ) R) ≠ 0 :=
  (measure_ball_pos volume 0 hR).ne'

theorem upperDensity_univ : upperDensity univ = 1 := by
  rw [upperDensity]
  have : (fun R : ℝ => volume (univ ∩ ball (0 : ℂ) R) / volume (ball (0 : ℂ) R)) =ᶠ[atTop] fun _ => 1 := by
    filter_upwards [eventually_gt_atTop 0] with R hR
    rw [univ_inter]
    exact ENNReal.div_self (volume_ball_ne_zero hR) measure_ball_lt_top.ne
  rw [limsup_congr this, limsup_const]

theorem upperDensity_empty : upperDensity ∅ = 0 := by
  simp [upperDensity]

/-- A colouring's classes form a partial colouring. -/
theorem AeColouring.isPartialColouring (c : AeColouring k) : IsPartialColouring c.cls :=
  ⟨c.measurableSet_cls, c.pairwise_disjoint_cls⟩

/-- Any a.e.-proper colouring makes `µ_k⁰` full. -/
theorem one_le_muZero (c : AeColouring k) : 1 ≤ muZero k := by
  calc (1 : ENNReal) = upperDensity (⋃ j, c.cls j) := by rw [c.iUnion_cls, upperDensity_univ]
    _ ≤ muZero k := le_iSup₂ (f := fun C (_ : IsPartialColouring C ∧ ∀ j, UnitPairsNull (C j)) =>
          upperDensity (⋃ j, C j)) c.cls ⟨c.isPartialColouring, c.unitPairsNull⟩

/-! ## Spec examples -/

/-- **Adversary** for `upperDensity`: a bounded set has upper density `0` (the limit is at `R → ∞`, not `R → 0`). -/
theorem upperDensity_ball_one : upperDensity (ball (0 : ℂ) 1) = 0 := by
  rw [upperDensity]
  refine Tendsto.limsup_eq ?_
  have hev : (fun R : ℝ => volume (ball (0 : ℂ) 1 ∩ ball 0 R) / volume (ball (0 : ℂ) R)) =ᶠ[atTop]
      fun R => ENNReal.ofReal ((R ^ 2)⁻¹) := by
    filter_upwards [eventually_gt_atTop 1] with R hR
    rw [inter_eq_left.2 (ball_subset_ball hR.le), Complex.volume_ball, Complex.volume_ball,
      ENNReal.mul_div_mul_right _ _ (by simp [NNReal.pi_ne_zero]) ENNReal.coe_ne_top, ENNReal.ofReal_one, one_pow,
      ← ENNReal.ofReal_pow (by linarith), one_div, ENNReal.ofReal_inv_of_pos (by positivity)]
  refine Tendsto.congr' hev.symm ?_
  rw [← ENNReal.ofReal_zero]
  refine ENNReal.tendsto_ofReal ?_
  exact (tendsto_pow_atTop two_ne_zero).inv_tendsto_atTop

/-- `sq9` makes `µ₉⁰` full. -/
example : 1 ≤ muZero 9 := one_le_muZero sq9

/-- The empty family is a band-free partial colouring (it covers nothing). -/
example (ε : ℝ) : IsPartialColouring (fun _ : Fin k => (∅ : Set ℂ)) ∧ ∀ j, BandFree ((fun _ : Fin k => (∅ : Set ℂ)) j) ε :=
  ⟨⟨fun _ => MeasurableSet.empty, fun _ _ _ => disjoint_bot_left⟩, fun _ _ hx => hx.elim⟩

/-- **Adversary** for `BandFree`: the plane is not band-free at any `ε ≥ 0` (`0` and `1` are at distance `1`). -/
example {ε : ℝ} (hε : 0 ≤ ε) : ¬ BandFree (univ : Set ℂ) ε := by
  intro h
  rcases h 0 trivial 1 trivial with h1 | h1 <;> simp at h1 <;> linarith

/-- The half-open grid square of side `1` at the origin holds `1/2` but not `1`. -/
example : (1 / 2 : ℂ) ∈ gridCell 1 0 ∧ (1 : ℂ) ∉ gridCell 1 0 := by
  refine ⟨by norm_num [gridCell], ?_⟩
  simp [gridCell]

/-- The plane is periodic under every square lattice, and `bandPairSet` holds a unit pair at `ε = 0`. -/
example (L : ℝ) : IsPeriodicSet L (univ : Set ℂ) ∧ ((0 : ℂ), (1 : ℂ)) ∈ bandPairSet univ 0 :=
  ⟨fun _ => ⟨Iff.rfl, Iff.rfl⟩, by simp [bandPairSet]⟩

/-- Every colouring has slack at a negative `ε` (the band is empty): `HasSlack` reads the band, not the colouring. -/
example (c : AeColouring k) : c.HasSlack (-1) := by
  intro j
  have : bandPairSet (c.cls j) (-1) = ∅ := by
    ext q; simp only [bandPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false]
    rintro ⟨-, -, h1, h2⟩; linarith
  rw [BandNull, this, measure_empty]

end HadwigerNelson.Plane
