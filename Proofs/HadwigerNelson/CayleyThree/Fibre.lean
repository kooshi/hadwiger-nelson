import Proofs.HadwigerNelson.CayleyThree.Circular
import Mathlib.Order.WellQuasiOrder

/-!
# Three colours on abelian Cayley graphs: heights, the fibre, tight relations (FS-131, planner FS131-KTC1; skeleton)

The layer FS73-T21/T23 and Coxeter's H-ii stand on, in the library's normalization: a colouring `c : A → ZMod 3` proper
along a family `s : Fin m → A` (`ThreeColour.ProperAlong`), steps lifted to `{1, 2}` (`ThreeColour.step`), the winding
`W : Winding s` on the relation lattice `R = ker (relMap s)`, and its **fibre** — the points `x ∈ [1/3, 2/3]^m` with
`r · x = W r` on `R` (nonempty: the held `Winding.exists_box_point`).

* §1 the height on `ℤ^m` (`liftHeight`, steps in `{1, 2}`; `pmHeight = 3Σx − 2·liftHeight`, steps `±1`) and the colouring's
  own winding `heightWinding`;
* §2 **tight relations** (`minRise σ = 3·W σ`) freeze every step along their directions (H-ii's combinatorial half);
* §3 **Dickson in place of LP duality**: with no tight relation through a direction, the slack is uniformly positive
  (`exists_slack_bound`), so some fibre point is strictly inside the box there (`exists_mem_fibre_gt`, `_lt`);
* §4 a **rational fibre point strict off the tight directions** (`exists_rat_mem_fibre_relint`), the slope H-iii uses;
* §5 the rigidity clause of row 79: if every band character has order 3, every colouring is affine.

**Not claimed:** the dichotomy's cell clause (`plans/FS131-KTC1-three-colour-plan.md` § 2.5); anything at four colours.
**Inhabitants:** `ThreeColour.properAlong_one_two` (`ℤ` along `(1, 2)`, `x ↦ x mod 3`) for every theorem taking `ProperAlong`;
`ThreeColour.nonempty_winding_one_two` for every theorem taking a `Winding`; `isTight_one_two` for `IsTight`.
-/

namespace HadwigerNelson.CayleyThree

open HadwigerNelson.ThreeColour HadwigerNelson.CharacterColouring HadwigerNelson.ThreeColourCharacter

variable {A : Type*} [AddCommGroup A] {m : ℕ}

/-! ## §1 The height on `ℤ^m` -/

/-- The `ℓ¹` norm on `ℤ^m`, the graph distance of the grid. -/
def l1 (v : Fin m → ℤ) : ℤ := ∑ j, |v j|

section Height

variable (s : Fin m → A) (c : A → ZMod 3)

/-- **The height on `ℤ^m`** (steps in `{1, 2}`): up the positive part of `x` from `0`, then down its negative part to
`π x`. -/
def liftHeight (x : Fin m → ℤ) : ℤ :=
  height s c 0 (word (posPart x)) - height s c (relMap s x) (word (negPart x))

/-- **The `±1` height**: `3·Σ_j x_j − 2·liftHeight x`; a step lifted to `1` is `+1`, to `2` is `−1`. -/
def pmHeight (x : Fin m → ℤ) : ℤ := 3 * ∑ j, x j - 2 * liftHeight s c x

variable {s c}

/-- The relation map at a basis vector. -/
theorem relMap_single (j : Fin m) : relMap s (Pi.single j 1) = s j := by
  -- `relMap` read by unfolding (a `simp [relMap]` would mint `relMap.eq_1` here)
  change ∑ k, (Pi.single j (1 : ℤ) : Fin m → ℤ) k • s k = s j
  simp [Pi.single_apply]

/-- The relation map through the two parts of a vector. -/
theorem relMap_eq_wsum (x : Fin m → ℤ) :
    relMap s x = wsum s (word (ThreeColour.posPart x)) - wsum s (word (ThreeColour.negPart x)) := by
  rw [wsum_word, wsum_word, ← Finset.sum_sub_distrib]
  change ∑ j, x j • s j = _
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← natCast_zsmul, ← natCast_zsmul, ← sub_smul, ThreeColour.posPart, ThreeColour.negPart, Int.toNat_sub_toNat_neg]

/-- **The height through any decomposition** `x = u − v` into natural parts. -/
theorem liftHeight_eq_of_sub (hc : ProperAlong s c) {x : Fin m → ℤ} (u v : Fin m → ℕ)
    (huv : ∀ j, (u j : ℤ) - v j = x j) :
    liftHeight s c x = height s c 0 (word u) - height s c (relMap s x) (word v) := by
  -- `u = x⁺ + t`, `v = x⁻ + t`
  set t : Fin m → ℕ := fun j => u j - ThreeColour.posPart x j with ht
  have hu : u = ThreeColour.posPart x + t := funext fun j => by
    have := huv j; simp only [ht, Pi.add_apply, ThreeColour.posPart] at this ⊢; omega
  have hv : v = ThreeColour.negPart x + t := funext fun j => by
    have := huv j; simp only [ht, Pi.add_apply, ThreeColour.posPart, ThreeColour.negPart] at this ⊢; omega
  have hP : relMap s x + wsum s (word (ThreeColour.negPart x)) = wsum s (word (ThreeColour.posPart x)) := by
    rw [relMap_eq_wsum]; abel
  rw [hu, hv, height_perm s hc (word_add_perm _ _), height_perm s hc (word_add_perm _ _), height_append,
    height_append, hP, zero_add, liftHeight]
  ring

/-- The height along the one-letter word of a basis vector is the step. -/
theorem height_word_single (hc : ProperAlong s c) (a : A) (j : Fin m) :
    height s c a (word (Pi.single j 1)) = step s c a j := by
  have hperm : (word (Pi.single j 1 : Fin m → ℕ)).Perm [j] := by
    rw [List.perm_iff_count]; intro i
    rw [count_word, List.count_singleton]
    by_cases h : i = j
    · subst h; simp
    · simp [h, Ne.symm h]
  rw [height_perm s hc hperm]
  simp [height]

theorem liftHeight_add_single (hc : ProperAlong s c) (x : Fin m → ℤ) (j : Fin m) :
    liftHeight s c (x + Pi.single j 1) = liftHeight s c x + step s c (relMap s x) j := by
  have hrep : liftHeight s c (x + Pi.single j 1) =
      height s c 0 (word (ThreeColour.posPart x + Pi.single j 1)) - height s c (relMap s (x + Pi.single j 1)) (word (ThreeColour.negPart x)) :=
    liftHeight_eq_of_sub hc _ _ fun i => by
      simp only [Pi.add_apply, ThreeColour.posPart, ThreeColour.negPart, Pi.single_apply]
      split_ifs <;> push_cast <;> omega
  have hP : relMap s x + wsum s (word (ThreeColour.negPart x)) = wsum s (word (ThreeColour.posPart x)) := by
    rw [relMap_eq_wsum]; abel
  rw [hrep, height_perm s hc (word_add_perm _ _), height_append, height_word_single hc, map_add, relMap_single,
    height_add_gen s hc, hP, zero_add, liftHeight]
  ring

theorem liftHeight_cast (hc : ProperAlong s c) (x : Fin m → ℤ) :
    ((liftHeight s c x : ℤ) : ZMod 3) = c (relMap s x) - c 0 := by
  have hP : relMap s x + wsum s (word (ThreeColour.negPart x)) = wsum s (word (ThreeColour.posPart x)) := by
    rw [relMap_eq_wsum]; abel
  rw [liftHeight, Int.cast_sub, height_cast s hc, height_cast s hc, hP, zero_add]
  ring

theorem pmHeight_add_single (hc : ProperAlong s c) (x : Fin m → ℤ) (j : Fin m) :
    pmHeight s c (x + Pi.single j 1) = pmHeight s c x + (3 - 2 * step s c (relMap s x) j) := by
  have hsum : ∑ i, (x + Pi.single j 1 : Fin m → ℤ) i = ∑ i, x i + 1 := by
    simp [Pi.add_apply, Finset.sum_add_distrib]
  rw [pmHeight, pmHeight, hsum, liftHeight_add_single hc]
  ring

theorem pmHeight_cast (hc : ProperAlong s c) (x : Fin m → ℤ) :
    ((pmHeight s c x : ℤ) : ZMod 3) = c (relMap s x) - c 0 := by
  have h3 : (3 : ZMod 3) = 0 := rfl
  rw [pmHeight, Int.cast_sub, Int.cast_mul, Int.cast_mul, liftHeight_cast hc]
  push_cast
  linear_combination ((∑ j, ((x j : ℤ) : ZMod 3)) - (c (relMap s x) - c 0)) * h3

/-- The `±1` height is `1`-Lipschitz for the grid distance. -/
theorem abs_pmHeight_sub_le (hc : ProperAlong s c) (x y : Fin m → ℤ) :
    |pmHeight s c x - pmHeight s c y| ≤ l1 (x - y) := by
  classical
  -- one step changes the height by `±1`
  have hstep : ∀ z : Fin m → ℤ, ∀ j, |pmHeight s c (z + Pi.single j 1) - pmHeight s c z| = 1 := fun z j => by
    rw [pmHeight_add_single hc]
    have := step_mem s c (relMap s z) j
    rcases (show step s c (relMap s z) j = 1 ∨ step s c (relMap s z) j = 2 by omega) with h | h <;>
      rw [h] <;> norm_num
  -- along one coordinate, by induction on the distance
  have hline : ∀ z : Fin m → ℤ, ∀ j, ∀ k : ℤ, |pmHeight s c (z + Pi.single j k) - pmHeight s c z| ≤ |k| := by
    intro z j k
    induction k using Int.induction_on with
    | zero => simp
    | succ i ih =>
      have e : z + Pi.single j ((i : ℤ) + 1) = (z + Pi.single j (i : ℤ)) + Pi.single j 1 := by
        rw [Pi.single_add, add_assoc]
      rw [e]
      have h1 := hstep (z + Pi.single j (i : ℤ)) j
      have h2 := abs_sub_le (pmHeight s c (z + Pi.single j (i : ℤ) + Pi.single j 1))
        (pmHeight s c (z + Pi.single j (i : ℤ))) (pmHeight s c z)
      have h3 : |((i : ℤ) + 1)| = |(i : ℤ)| + 1 := by
        rw [abs_of_nonneg (by positivity), abs_of_nonneg (by positivity)]
      linarith
    | pred i ih =>
      have e : z + Pi.single j (-(i : ℤ)) = (z + Pi.single j (-(i : ℤ) - 1)) + Pi.single j 1 := by
        rw [add_assoc, ← Pi.single_add, sub_add_cancel]
      have h1 := hstep (z + Pi.single j (-(i : ℤ) - 1)) j
      rw [e] at ih
      have h2 := abs_sub_le (pmHeight s c (z + Pi.single j (-(i : ℤ) - 1)))
        (pmHeight s c (z + Pi.single j (-(i : ℤ) - 1) + Pi.single j 1)) (pmHeight s c z)
      rw [abs_sub_comm] at h1
      have h3 : |(-(i : ℤ) - 1)| = |(-(i : ℤ))| + 1 := by
        rw [abs_of_nonpos (by omega), abs_of_nonpos (by omega)]; ring
      linarith
  -- coordinate by coordinate, along a finite set of coordinates
  have hset : ∀ T : Finset (Fin m),
      |pmHeight s c (y + ∑ j ∈ T, Pi.single j ((x - y) j)) - pmHeight s c y| ≤ ∑ j ∈ T, |(x - y) j| := by
    intro T
    induction T using Finset.induction_on with
    | empty => simp
    | insert j T hj ih =>
      rw [Finset.sum_insert hj, Finset.sum_insert hj, show y + (Pi.single j ((x - y) j) +
        ∑ i ∈ T, Pi.single i ((x - y) i)) = (y + ∑ i ∈ T, Pi.single i ((x - y) i)) + Pi.single j ((x - y) j) by abel]
      have h1 := hline (y + ∑ j ∈ T, Pi.single j ((x - y) j)) j ((x - y) j)
      have h2 := abs_sub_le (pmHeight s c (y + ∑ j ∈ T, Pi.single j ((x - y) j) + Pi.single j ((x - y) j)))
        (pmHeight s c (y + ∑ j ∈ T, Pi.single j ((x - y) j))) (pmHeight s c y)
      linarith
  have h := hset Finset.univ
  rwa [Finset.univ_sum_single, add_sub_cancel] at h

/-- The `±1` height has the parity of `Σ_j x_j`. -/
theorem even_pmHeight_sub_sum (hc : ProperAlong s c) (x : Fin m → ℤ) : Even (pmHeight s c x - ∑ j, x j) := by
  -- `hc` is not needed: `pmHeight x − Σ x = 2 (Σ x − liftHeight x)` for every colouring (the skeleton's statement
  -- carries it; recorded in `plans/FS131-ICT1-three-colour.md`)
  have _ := hc
  exact ⟨∑ j, x j - liftHeight s c x, by rw [pmHeight]; ring⟩

/-- On a relation the height is the held winding of its two parts read from `0`. -/
theorem liftHeight_of_relMap_eq_zero {r : Fin m → ℤ} (hr : relMap s r = 0) :
    liftHeight s c r = wind s c 0 (ThreeColour.posPart r) (ThreeColour.negPart r) := by
  rw [liftHeight, hr, wind]

/-- On a relation the height is divisible by `3`. -/
theorem three_dvd_liftHeight (hc : ProperAlong s c) {r : Fin m → ℤ} (hr : relMap s r = 0) : 3 ∣ liftHeight s c r := by
  rw [liftHeight_of_relMap_eq_zero hr]
  exact (ZMod.intCast_zmod_eq_zero_iff_dvd _ 3).mp (wind_cast s hc (wsum_word_posPart s hr) 0)

/-- **The height is additive along relations**: `liftHeight (x + r) = liftHeight x + liftHeight r`. -/
theorem liftHeight_add_of_relMap_eq_zero (hc : ProperAlong s c) (x : Fin m → ℤ) {r : Fin m → ℤ}
    (hr : relMap s r = 0) : liftHeight s c (x + r) = liftHeight s c x + liftHeight s c r := by
  have hrep : liftHeight s c (x + r) = height s c 0 (word (ThreeColour.posPart x + ThreeColour.posPart r)) -
      height s c (relMap s (x + r)) (word (ThreeColour.negPart x + ThreeColour.negPart r)) :=
    liftHeight_eq_of_sub hc _ _ fun i => by
      simp only [Pi.add_apply, ThreeColour.posPart, ThreeColour.negPart]; push_cast; omega
  have hP : relMap s x + wsum s (word (ThreeColour.negPart x)) = wsum s (word (ThreeColour.posPart x)) := by
    rw [relMap_eq_wsum]; abel
  have hw := wind_shift s hc (wsum_word_posPart s hr) 0 (word (ThreeColour.posPart x))
  rw [zero_add] at hw
  rw [hrep, map_add, hr, add_zero, height_perm s hc (word_add_perm _ _), height_perm s hc (word_add_perm _ _),
    height_append, height_append, hP, zero_add, liftHeight_of_relMap_eq_zero hr, ← hw, wind, liftHeight]
  ring

/-- **The colouring's own winding** (FS73-T21's `w`, the library's `W`): `W r = liftHeight r / 3` on the relation lattice. -/
noncomputable def heightWinding (hc : ProperAlong s c) : Winding s where
  toHom :=
    { toFun := fun r => liftHeight s c (r : Fin m → ℤ) / 3
      map_zero' := by
        have h := liftHeight_add_of_relMap_eq_zero hc (0 : Fin m → ℤ) (r := 0) (map_zero _)
        simp only [add_zero] at h
        change liftHeight s c 0 / 3 = 0
        omega
      map_add' := fun r r' => by
        have h := liftHeight_add_of_relMap_eq_zero hc (r : Fin m → ℤ) r'.2
        have h1 := three_dvd_liftHeight hc r.2
        have h2 := three_dvd_liftHeight hc r'.2
        change liftHeight s c ((r : Fin m → ℤ) + r') / 3 = liftHeight s c r / 3 + liftHeight s c r' / 3
        omega }
  minRise_le := fun r => by
    change minRise (r : Fin m → ℤ) ≤ 3 * (liftHeight s c r / 3)
    rw [Int.mul_ediv_cancel' (three_dvd_liftHeight hc r.2), liftHeight_of_relMap_eq_zero r.2]
    exact minRise_le_wind s c _ 0

theorem heightWinding_apply (hc : ProperAlong s c) (r : (relMap s).ker) :
    (heightWinding hc).toHom r = liftHeight s c (r : Fin m → ℤ) / 3 := rfl

/-- **The winding is global** (FS73-T21, Lemma 2): `liftHeight (x + r) = liftHeight x + 3·W r` for every relation `r`. -/
theorem liftHeight_add_ker (hc : ProperAlong s c) (x : Fin m → ℤ) (r : (relMap s).ker) :
    liftHeight s c (x + r) = liftHeight s c x + 3 * (heightWinding hc).toHom r := by
  rw [heightWinding_apply, Int.mul_ediv_cancel' (three_dvd_liftHeight hc r.2)]
  exact liftHeight_add_of_relMap_eq_zero hc x r.2

/-- **The `±1` height's winding**: `pmHeight (x + r) = pmHeight x + (3·Σ_j r_j − 6·W r)` — the seam between the
library's normalization (steps in `{1, 2}`, the fibre in `[1/3, 2/3]^m`) and the McShane extension's (steps `±1`,
slopes `a = 3 − 6x` in `[−1, 1]^m`). -/
theorem pmHeight_add_ker (hc : ProperAlong s c) (x : Fin m → ℤ) (r : (relMap s).ker) :
    pmHeight s c (x + r) = pmHeight s c x + (3 * ∑ j, (r : Fin m → ℤ) j - 6 * (heightWinding hc).toHom r) := by
  rw [pmHeight, pmHeight, liftHeight_add_ker hc, Pi.add_def, Finset.sum_add_distrib]
  ring

end Height

/-! ## §2 Tight relations freeze their directions -/

/-- **Generation, in the family's words**: the relation map is onto iff the family generates `A`. -/
theorem surjective_relMap_iff (s : Fin m → A) :
    Function.Surjective (relMap s) ↔ AddSubgroup.closure (Set.range s) = ⊤ := by
  constructor
  · intro h
    rw [eq_top_iff]
    intro a _
    obtain ⟨r, rfl⟩ := h a
    change ∑ j, r j • s j ∈ _
    exact AddSubgroup.sum_mem _ fun j _ =>
      AddSubgroup.zsmul_mem _ (AddSubgroup.subset_closure (Set.mem_range_self j)) _
  · intro h a
    have hle : AddSubgroup.closure (Set.range s) ≤ (relMap s).range := by
      rw [AddSubgroup.closure_le]
      rintro _ ⟨j, rfl⟩
      exact AddMonoidHom.mem_range.mpr ⟨Pi.single j 1, relMap_single j⟩
    exact AddMonoidHom.mem_range.mp (hle (h ▸ AddSubgroup.mem_top a))

/-- Generation makes the winding of a balanced pair independent of its base point. -/
private theorem wind_eq_of_surjective {s : Fin m → A} {c : A → ZMod 3} (hc : ProperAlong s c)
    (hgen : Function.Surjective (relMap s)) {u v : Fin m → ℕ} (huv : wsum s (word u) = wsum s (word v)) (a : A) :
    wind s c a u v = wind s c 0 u v := by
  obtain ⟨r, rfl⟩ := hgen a
  have h1 := wind_shift s hc huv (relMap s r) (word (ThreeColour.negPart r))
  have h2 := wind_shift s hc huv 0 (word (ThreeColour.posPart r))
  have e : relMap s r + wsum s (word (ThreeColour.negPart r)) = 0 + wsum s (word (ThreeColour.posPart r)) := by
    rw [relMap_eq_wsum, zero_add]; abel
  rw [← h1, e, h2]

/-- The least rise through the two parts of a vector. -/
private theorem minRise_eq_parts (r : Fin m → ℤ) :
    minRise r = ∑ j, ((ThreeColour.posPart r j : ℕ) : ℤ) - 2 * ∑ j, ((ThreeColour.negPart r j : ℕ) : ℤ) := by
  -- `minRise` read by unfolding (a `simp [minRise]` would mint a second `minRise.eq_1`: `ThetaCert` holds one)
  change ∑ j, min (r j) (2 * r j) = _
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  simp only [ThreeColour.posPart, ThreeColour.negPart]
  omega


/-- **A tight relation** for a winding: the least rise is attained, `minRise σ = 3·W σ`. -/
def IsTight {s : Fin m → A} (W : Winding s) (σ : (relMap s).ker) : Prop := minRise (σ : Fin m → ℤ) = 3 * W.toHom σ

/-- **The tight directions** of a winding: those some tight relation moves. -/
def tightSet {s : Fin m → A} (W : Winding s) : Set (Fin m) := {j | ∃ σ : (relMap s).ker, (σ : Fin m → ℤ) j ≠ 0 ∧ IsTight W σ}

/-- A tight relation of the colouring's own winding, under generation, rises as little as it can from every base point:
the word of its positive part has every step `1`, that of its negative part every step `2`. -/
private theorem height_eq_of_isTight {s : Fin m → A} {c : A → ZMod 3} (hc : ProperAlong s c)
    (hgen : Function.Surjective (relMap s)) {σ : (relMap s).ker} (hσ : IsTight (heightWinding hc) σ) (a : A) :
    height s c a (word (ThreeColour.posPart (σ : Fin m → ℤ))) = (word (ThreeColour.posPart (σ : Fin m → ℤ))).length ∧
      height s c a (word (ThreeColour.negPart (σ : Fin m → ℤ))) =
        2 * (word (ThreeColour.negPart (σ : Fin m → ℤ))).length := by
  have hbal := wsum_word_posPart s σ.2
  have hw : wind s c a (ThreeColour.posPart (σ : Fin m → ℤ)) (ThreeColour.negPart (σ : Fin m → ℤ)) =
      minRise (σ : Fin m → ℤ) := by
    rw [wind_eq_of_surjective hc hgen hbal a]
    unfold IsTight at hσ
    rw [heightWinding_apply, Int.mul_ediv_cancel' (three_dvd_liftHeight hc σ.2),
      liftHeight_of_relMap_eq_zero σ.2] at hσ
    exact hσ.symm
  have e := minRise_eq_parts (σ : Fin m → ℤ)
  have h1 := (height_bounds s c a (word (ThreeColour.posPart (σ : Fin m → ℤ)))).1
  have h2 := (height_bounds s c a (word (ThreeColour.negPart (σ : Fin m → ℤ)))).2
  have h3 := (height_bounds s c a (word (ThreeColour.posPart (σ : Fin m → ℤ)))).2
  have h4 := (height_bounds s c a (word (ThreeColour.negPart (σ : Fin m → ℤ)))).1
  simp only [length_word] at h1 h2 h3 h4 ⊢
  unfold wind at hw
  push_cast at h1 h2 h3 h4 ⊢
  constructor <;> linarith

/-- **The fibre of a winding**: the points of the box `[1/3, 2/3]^m` realizing it on every relation. -/
def fibre {s : Fin m → A} (W : Winding s) : Set (Fin m → ℝ) :=
  {x | (∀ j, x j ∈ Set.Icc (1 / 3 : ℝ) (2 / 3)) ∧ ∀ r : (relMap s).ker, ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * x j = W.toHom r}

theorem fibre_nonempty {s : Fin m → A} (W : Winding s) : (fibre W).Nonempty := by
  obtain ⟨x, hx1, hx2⟩ := W.exists_box_point
  exact ⟨x, hx1, hx2⟩

theorem convex_fibre {s : Fin m → A} (W : Winding s) : Convex ℝ (fibre W) := by
  intro x hx y hy a b ha hb hab
  refine ⟨fun j => ?_, fun r => ?_⟩
  · simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
    exact (convex_Icc _ _) (hx.1 j) (hy.1 j) ha hb hab
  · simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul, mul_add, Finset.sum_add_distrib]
    have e1 : ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * (a * x j) = a * ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * x j := by
      rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun j _ => by ring
    have e2 : ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * (b * y j) = b * ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * y j := by
      rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun j _ => by ring
    rw [e1, e2, hx.2 r, hy.2 r, ← add_mul, hab, one_mul]

/-- **H-ii, the combinatorial half (positive side)**: along a tight relation of the colouring's winding, every step in a
direction the relation moves forward is lifted to `1`, from every base point. Generation moves the base point. -/
theorem step_eq_one_of_isTight {s : Fin m → A} {c : A → ZMod 3} (hc : ProperAlong s c)
    (hgen : Function.Surjective (relMap s)) {σ : (relMap s).ker} (hσ : IsTight (heightWinding hc) σ) {j : Fin m}
    (hj : 0 < (σ : Fin m → ℤ) j) (a : A) : step s c a j = 1 := by
  obtain ⟨h1, -⟩ := height_eq_of_isTight hc hgen hσ a
  have hmem : j ∈ word (ThreeColour.posPart (σ : Fin m → ℤ)) := List.count_pos_iff.mp (by
    rw [count_word]; simp only [ThreeColour.posPart]; omega)
  rw [height_perm s hc (List.perm_cons_erase hmem)] at h1
  change step s c a j + height s c (a + s j) _ = _ at h1
  have hl := List.length_erase_of_mem hmem
  have hb := (height_bounds s c (a + s j) ((word (ThreeColour.posPart (σ : Fin m → ℤ))).erase j)).1
  have hs := step_mem s c a j
  have hpos : 0 < (word (ThreeColour.posPart (σ : Fin m → ℤ))).length := List.length_pos_of_mem hmem
  rw [hl] at hb
  push_cast [Nat.cast_sub hpos] at hb
  omega

/-- **H-ii, the combinatorial half (negative side).** -/
theorem step_eq_two_of_isTight {s : Fin m → A} {c : A → ZMod 3} (hc : ProperAlong s c)
    (hgen : Function.Surjective (relMap s)) {σ : (relMap s).ker} (hσ : IsTight (heightWinding hc) σ) {j : Fin m}
    (hj : (σ : Fin m → ℤ) j < 0) (a : A) : step s c a j = 2 := by
  obtain ⟨-, h1⟩ := height_eq_of_isTight hc hgen hσ a
  have hmem : j ∈ word (ThreeColour.negPart (σ : Fin m → ℤ)) := List.count_pos_iff.mp (by
    rw [count_word]; simp only [ThreeColour.negPart]; omega)
  rw [height_perm s hc (List.perm_cons_erase hmem)] at h1
  change step s c a j + height s c (a + s j) _ = _ at h1
  have hl := List.length_erase_of_mem hmem
  have hb := (height_bounds s c (a + s j) ((word (ThreeColour.negPart (σ : Fin m → ℤ))).erase j)).2
  have hs := step_mem s c a j
  have hpos : 0 < (word (ThreeColour.negPart (σ : Fin m → ℤ))).length := List.length_pos_of_mem hmem
  rw [hl] at hb
  push_cast [Nat.cast_sub hpos] at hb
  omega

/-- A box coordinate bounds a relation's term below by its share of the least rise. -/
private theorem term_le (t : ℤ) {y : ℝ} (hy : y ∈ Set.Icc (1 / 3 : ℝ) (2 / 3)) :
    ((min t (2 * t) : ℤ) : ℝ) / 3 ≤ (t : ℝ) * y := by
  obtain ⟨hy1, hy2⟩ := hy
  rcases le_or_gt 0 t with ht | ht
  · rw [min_eq_left (by omega)]
    have ht' : (0 : ℝ) ≤ t := by exact_mod_cast ht
    nlinarith
  · rw [min_eq_right (by omega)]
    have ht' : (t : ℝ) < 0 := by exact_mod_cast ht
    push_cast
    nlinarith

/-- A tight relation pins the fibre: `x_j = 1/3` where it moves forward, `2/3` where it moves back. -/
theorem fibre_coord_of_isTight {s : Fin m → A} {W : Winding s} {σ : (relMap s).ker} (hσ : IsTight W σ) {x : Fin m → ℝ}
    (hx : x ∈ fibre W) (j : Fin m) :
    (0 < (σ : Fin m → ℤ) j → x j = 1 / 3) ∧ ((σ : Fin m → ℤ) j < 0 → x j = 2 / 3) := by
  obtain ⟨hbox, heq⟩ := hx
  have hmin : ((minRise (σ : Fin m → ℤ) : ℤ) : ℝ) = 3 * ((W.toHom σ : ℤ) : ℝ) := by
    rw [hσ]; push_cast; ring
  have hmr : ((minRise (σ : Fin m → ℤ) : ℤ) : ℝ) =
      ∑ i, ((min ((σ : Fin m → ℤ) i) (2 * (σ : Fin m → ℤ) i) : ℤ) : ℝ) := by
    change ((∑ i, min ((σ : Fin m → ℤ) i) (2 * (σ : Fin m → ℤ) i) : ℤ) : ℝ) = _
    push_cast; rfl
  -- termwise, `σ_i x_i ≥ min(σ_i, 2σ_i)/3`, and the sums agree
  let f : Fin m → ℝ := fun i => (((σ : Fin m → ℤ) i : ℤ) : ℝ) * x i -
    ((min ((σ : Fin m → ℤ) i) (2 * (σ : Fin m → ℤ) i) : ℤ) : ℝ) / 3
  have hf0 : ∀ i, 0 ≤ f i := fun i => sub_nonneg.mpr (term_le _ (hbox i))
  have hsum : ∑ i, f i = 0 := by
    simp only [f, Finset.sum_sub_distrib, ← Finset.sum_div]
    rw [heq σ, ← hmr, hmin]; ring
  have hz := (Finset.sum_eq_zero_iff_of_nonneg fun i _ => hf0 i).mp hsum j (Finset.mem_univ j)
  simp only [f] at hz
  constructor
  · intro hj
    have hm : min ((σ : Fin m → ℤ) j) (2 * (σ : Fin m → ℤ) j) = (σ : Fin m → ℤ) j := min_eq_left (by omega)
    rw [hm] at hz
    have hj' : (0 : ℝ) < (((σ : Fin m → ℤ) j : ℤ) : ℝ) := by exact_mod_cast hj
    have : (((σ : Fin m → ℤ) j : ℤ) : ℝ) * (x j - 1 / 3) = 0 := by linarith
    rcases mul_eq_zero.mp this with h | h
    · linarith
    · linarith
  · intro hj
    have hm : min ((σ : Fin m → ℤ) j) (2 * (σ : Fin m → ℤ) j) = 2 * (σ : Fin m → ℤ) j := min_eq_right (by omega)
    rw [hm] at hz
    have hj' : (((σ : Fin m → ℤ) j : ℤ) : ℝ) < 0 := by exact_mod_cast hj
    have : (((σ : Fin m → ℤ) j : ℤ) : ℝ) * (x j - 2 / 3) = 0 := by push_cast at hz; linarith
    rcases mul_eq_zero.mp this with h | h
    · linarith
    · linarith

/-! ## §3 Dickson in place of LP duality -/

/-- **A Gordan bound by Dickson's lemma.** On a set `M ⊆ ℕ^ι` closed under sums and under differences of comparable
elements, two functions additive on `M` with `g x = 0 → t x = 0` satisfy `t ≤ κ·g` for one `κ`. (The minimal nonzero
elements of `M` are an antichain, finite by `WellQuasiOrderedLE.finite_of_isAntichain`; `κ` is the largest `t` among them.) -/
theorem exists_le_mul_of_imp_eq_zero {ι : Type*} [Finite ι] (M : Set (ι → ℕ))
    (hadd : ∀ x ∈ M, ∀ y ∈ M, x + y ∈ M) (hsub : ∀ x ∈ M, ∀ y ∈ M, y ≤ x → x - y ∈ M) (g t : (ι → ℕ) → ℕ)
    (hg : ∀ x ∈ M, ∀ y ∈ M, g (x + y) = g x + g y) (ht : ∀ x ∈ M, ∀ y ∈ M, t (x + y) = t x + t y)
    (h0 : ∀ x ∈ M, g x = 0 → t x = 0) : ∃ κ : ℕ, ∀ x ∈ M, t x ≤ κ * g x := by
  classical
  -- `hadd` is not needed: the decomposition into minimal elements uses only `hsub` and additivity (the skeleton's
  -- statement carries it; recorded in `plans/FS131-ICT1-three-colour.md`)
  have _ := hadd
  -- the minimal nonzero elements of `M` are an antichain, finite by Dickson's lemma
  let Mn : Set (ι → ℕ) := {μ | μ ∈ M ∧ μ ≠ 0 ∧ ∀ ν ∈ M, ν ≠ 0 → ν ≤ μ → ν = μ}
  have hanti : IsAntichain (· ≤ ·) Mn := fun μ hμ ν hν hne hle => hne (hν.2.2 μ hμ.1 hμ.2.1 hle)
  have hfin : Mn.Finite := WellQuasiOrderedLE.finite_of_isAntichain hanti
  refine ⟨hfin.toFinset.sup t, fun x hx => ?_⟩
  set κ := hfin.toFinset.sup t with hκ
  have hmin : ∀ μ ∈ Mn, t μ ≤ κ * g μ := fun μ hμ => by
    by_cases hg0 : g μ = 0
    · rw [h0 μ hμ.1 hg0]; exact Nat.zero_le _
    · calc t μ ≤ κ := Finset.le_sup (f := t) (hfin.mem_toFinset.mpr hμ)
        _ ≤ κ * g μ := Nat.le_mul_of_pos_right _ (Nat.pos_of_ne_zero hg0)
  -- every element is a sum of minimal ones: well-founded induction
  induction x using WellFoundedLT.induction with
  | _ x ih =>
    by_cases hx0 : x = 0
    · subst hx0
      have h2 := ht 0 hx 0 hx
      simp only [add_zero] at h2
      have : t 0 = 0 := by omega
      rw [this]; exact Nat.zero_le _
    · obtain ⟨μ, ⟨hμM, hμ0, hμx⟩, hμmin⟩ :=
        WellFounded.has_min wellFounded_lt {ν | ν ∈ M ∧ ν ≠ 0 ∧ ν ≤ x} ⟨x, hx, hx0, le_rfl⟩
      have hμMn : μ ∈ Mn := ⟨hμM, hμ0, fun ν hνM hν0 hνμ => by
        by_contra hne
        exact hμmin ν ⟨hνM, hν0, hνμ.trans hμx⟩ (lt_of_le_of_ne hνμ hne)⟩
      have hd : x - μ ∈ M := hsub x hx μ hμM hμx
      have hlt : x - μ < x := by
        refine lt_of_le_of_ne (fun i => Nat.sub_le _ _) fun h => hμ0 (funext fun i => ?_)
        have h1 : x i - μ i = x i := congrFun h i
        have h2 : μ i ≤ x i := hμx i
        show μ i = 0
        omega
      have hxe : x = μ + (x - μ) := funext fun i => by
        have h2 : μ i ≤ x i := hμx i
        show x i = μ i + (x i - μ i)
        omega
      have h1 := ih (x - μ) hlt hd
      rw [hxe, ht μ hμM _ hd, hg μ hμM _ hd, mul_add]
      exact add_le_add (hmin μ hμMn) h1

/-- **The uniform slack**: with no tight relation moving `j` forward, `σ_j ≤ κ·(3·W σ − minRise σ)` on every relation
moving `j` forward (`exists_le_mul_of_imp_eq_zero` on each orthant of `R`). -/
theorem exists_slack_bound {s : Fin m → A} (W : Winding s) (j : Fin m)
    (hj : ∀ σ : (relMap s).ker, 0 < (σ : Fin m → ℤ) j → ¬ IsTight W σ) :
    ∃ κ : ℕ, 0 < κ ∧ ∀ σ : (relMap s).ker, 0 < (σ : Fin m → ℤ) j →
      (σ : Fin m → ℤ) j ≤ κ * (3 * W.toHom σ - minRise (σ : Fin m → ℤ)) := by
  classical
  -- one orthant at a time: `p i` says the relation is non-negative at `i`
  have hp : ∀ p : Fin m → Bool, ∃ κ : ℕ, ∀ σ : (relMap s).ker, (∀ i, (p i = true ↔ 0 ≤ (σ : Fin m → ℤ) i)) →
      0 < (σ : Fin m → ℤ) j → (σ : Fin m → ℤ) j ≤ κ * (3 * W.toHom σ - minRise (σ : Fin m → ℤ)) := by
    intro p
    by_cases hpj : p j = true
    swap
    · exact ⟨0, fun σ hσp hσj => absurd ((hσp j).mpr hσj.le) hpj⟩
    -- the orthant's relations by their absolute values
    let sg : (Fin m → ℕ) → Fin m → ℤ := fun v i => if p i then (v i : ℤ) else -(v i : ℤ)
    have sg_add : ∀ v w, sg (v + w) = sg v + sg w := fun v w => funext fun i => by
      simp only [sg, Pi.add_apply]; split_ifs <;> push_cast <;> ring
    have sg_sub : ∀ v w : Fin m → ℕ, w ≤ v → sg (v - w) = sg v - sg w := fun v w hwv => funext fun i => by
      have hi := hwv i
      simp only [sg, Pi.sub_apply]; split_ifs <;> push_cast [Nat.cast_sub hi] <;> ring
    have mr_add : ∀ v w, minRise (sg (v + w)) = minRise (sg v) + minRise (sg w) := fun v w => by
      rw [sg_add]
      change ∑ i, min ((sg v + sg w) i) (2 * (sg v + sg w) i) =
        ∑ i, min (sg v i) (2 * sg v i) + ∑ i, min (sg w i) (2 * sg w i)
      rw [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun i _ => ?_
      simp only [Pi.add_apply, sg]; split_ifs <;> omega
    let M : Set (Fin m → ℕ) := {v | relMap s (sg v) = 0}
    let slack : (Fin m → ℕ) → ℕ := fun v =>
      if h : relMap s (sg v) = 0 then (3 * W.toHom ⟨sg v, h⟩ - minRise (sg v)).toNat else 0
    have slack_eq : ∀ v (h : v ∈ M), (slack v : ℤ) = 3 * W.toHom ⟨sg v, h⟩ - minRise (sg v) := fun v h => by
      rw [show slack v = (3 * W.toHom ⟨sg v, h⟩ - minRise (sg v)).toNat from dif_pos h]
      exact Int.toNat_of_nonneg (by linarith [W.minRise_le ⟨sg v, h⟩])
    have hMadd : ∀ v ∈ M, ∀ w ∈ M, v + w ∈ M := fun v hv w hw => by
      change relMap s (sg (v + w)) = 0
      rw [sg_add, map_add, hv, hw, add_zero]
    have hMsub : ∀ v ∈ M, ∀ w ∈ M, w ≤ v → v - w ∈ M := fun v hv w hw hwv => by
      change relMap s (sg (v - w)) = 0
      rw [sg_sub v w hwv, map_sub, hv, hw, sub_zero]
    have hslack : ∀ v ∈ M, ∀ w ∈ M, slack (v + w) = slack v + slack w := fun v hv w hw => by
      have e : (⟨sg (v + w), hMadd v hv w hw⟩ : (relMap s).ker) = ⟨sg v, hv⟩ + ⟨sg w, hw⟩ :=
        Subtype.ext (sg_add v w)
      have h1 := slack_eq (v + w) (hMadd v hv w hw)
      have h2 := slack_eq v hv
      have h3 := slack_eq w hw
      rw [e, map_add, mr_add] at h1
      omega
    obtain ⟨κ, hκ⟩ := exists_le_mul_of_imp_eq_zero M hMadd hMsub slack (fun v => v j) hslack
      (fun v _ w _ => rfl) fun v hv h0 => by
        by_contra hvj
        have hσ : IsTight W ⟨sg v, hv⟩ := by
          have := slack_eq v hv
          rw [h0] at this
          unfold IsTight
          change minRise (sg v) = 3 * W.toHom ⟨sg v, hv⟩
          omega
        refine hj ⟨sg v, hv⟩ ?_ hσ
        change 0 < sg v j
        simp only [sg, if_pos hpj]
        omega
    refine ⟨κ, fun σ hσp hσj => ?_⟩
    let v : Fin m → ℕ := fun i => ((σ : Fin m → ℤ) i).natAbs
    have hsg : sg v = σ := funext fun i => by
      have := hσp i
      simp only [sg, v]
      split_ifs with h
      · have := this.mp h; omega
      · have : (σ : Fin m → ℤ) i < 0 := by
          by_contra h'; exact h (this.mpr (by omega))
        omega
    have hv : v ∈ M := by change relMap s (sg v) = 0; rw [hsg]; exact σ.2
    have hσv : (⟨sg v, hv⟩ : (relMap s).ker) = σ := Subtype.ext hsg
    have h1 := hκ v hv
    have h2 := slack_eq v hv
    rw [hσv, hsg] at h2
    have h3 : ((v j : ℕ) : ℤ) = (σ : Fin m → ℤ) j := by simp only [v]; omega
    have h4 : ((v j : ℕ) : ℤ) ≤ (κ : ℤ) * (slack v : ℤ) := by exact_mod_cast h1
    rw [h3, h2] at h4
    exact h4
  choose κp hκp using hp
  refine ⟨1 + ∑ p, κp p, by omega, fun σ hσj => ?_⟩
  let p : Fin m → Bool := fun i => decide (0 ≤ (σ : Fin m → ℤ) i)
  have h1 := hκp p σ (fun i => by simp [p]) hσj
  have hslack : 0 ≤ 3 * W.toHom σ - minRise (σ : Fin m → ℤ) := by linarith [W.minRise_le σ]
  have hle : (κp p : ℤ) ≤ ((1 + ∑ p, κp p : ℕ) : ℤ) := by
    have := Finset.single_le_sum (f := κp) (fun _ _ => Nat.zero_le _) (Finset.mem_univ p)
    exact_mod_cast (by omega : κp p ≤ 1 + ∑ p, κp p)
  exact h1.trans (mul_le_mul_of_nonneg_right hle hslack)

/-- **Separation for a general box** (the held `Winding.exists_box_point`'s real-linear half, for `∏_j [lo_j, hi_j]`): if
every integer combination of the equations is non-negative at some vertex, a point of the box solves them. -/
theorem exists_mem_pi_Icc_of_forall_int {n : ℕ} (lo hi : Fin m → ℝ) (hlh : ∀ j, lo j ≤ hi j) (g : Fin n → Fin m → ℝ)
    (w : Fin n → ℝ)
    (h : ∀ N : Fin n → ℤ, ∃ b : Fin m → Bool,
      0 ≤ ∑ i, (N i : ℝ) * (∑ j, g i j * (if b j then hi j else lo j) - w i)) :
    ∃ x : Fin m → ℝ, (∀ j, x j ∈ Set.Icc (lo j) (hi j)) ∧ ∀ i, ∑ j, g i j * x j = w i := by
  sorry

/-- **Farkas, one side**: with no tight relation moving `j` forward, some fibre point has `x_j > 1/3`. -/
theorem exists_mem_fibre_gt {s : Fin m → A} (W : Winding s) (j : Fin m)
    (hj : ∀ σ : (relMap s).ker, 0 < (σ : Fin m → ℤ) j → ¬ IsTight W σ) : ∃ x ∈ fibre W, 1 / 3 < x j := by
  sorry

/-- **The reversed winding** `r ↦ Σ_j r_j − W r`: the winding of the colouring `−c`. -/
def _root_.HadwigerNelson.ThreeColour.Winding.flip {s : Fin m → A} (W : Winding s) : Winding s where
  toHom :=
    { toFun := fun r => ∑ j, (r : Fin m → ℤ) j - W.toHom r
      map_zero' := by sorry
      map_add' := by sorry }
  minRise_le := by sorry

theorem mem_fibre_flip_iff {s : Fin m → A} (W : Winding s) (x : Fin m → ℝ) :
    x ∈ fibre W.flip ↔ (fun j => 1 - x j) ∈ fibre W := by
  sorry

theorem isTight_flip_iff {s : Fin m → A} (W : Winding s) (σ : (relMap s).ker) : IsTight W.flip σ ↔ IsTight W (-σ) := by
  sorry

/-- **Farkas, the other side**: with no tight relation moving `j` back, some fibre point has `x_j < 2/3`. -/
theorem exists_mem_fibre_lt {s : Fin m → A} (W : Winding s) (j : Fin m)
    (hj : ∀ σ : (relMap s).ker, (σ : Fin m → ℤ) j < 0 → ¬ IsTight W σ) : ∃ x ∈ fibre W, x j < 2 / 3 := by
  sorry

/-! ## §4 The rational slope strict off the tight directions -/

/-- **A rational fibre point in the relative interior** (H-iii's `a*`, as `a* = 3 − 6x`): strict inside the box at every
direction no tight relation moves. Route: average the points of §3 (one per side and direction), then
`exists_rat_solution_near` on the affine hull with the tight coordinates held. -/
theorem exists_rat_mem_fibre_relint {s : Fin m → A} (W : Winding s) :
    ∃ x : Fin m → ℚ, (fun j => (x j : ℝ)) ∈ fibre W ∧ ∀ j ∉ tightSet W, 1 / 3 < x j ∧ x j < 2 / 3 := by
  sorry

/-! ## §5 Rigidity: band characters of order 3 make every colouring affine -/

/-- **FS73-T23, the rigidity clause of row 79**: if every band character has order 3, every 3-colouring proper along a
generating family is affine, `c = c 0 + φ` with `φ : A → ZMod 3` additive. -/
theorem exists_affine_of_forall_three_nsmul {s : Fin m → A} (hgen : Function.Surjective (relMap s)) {c : A → ZMod 3}
    (hc : ProperAlong s c) (h3 : ∀ θ ∈ bandSet (Set.range s) (band 3), 3 • θ = 0) :
    ∃ φ : A →+ ZMod 3, ∀ x, c x = c 0 + φ x := by
  sorry

/-! ## Spec: the model `ℤ` along `(1, 2)`, `x ↦ x mod 3` -/

example : l1 ![(2 : ℤ), -1] = 3 := by decide
example : liftHeight ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) ![2, -1] = 0 := by decide
example : pmHeight ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) ![1, 0] = 1 := by decide
example : pmHeight ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) ![0, 1] = -1 := by decide

/-- The model of `IsTight`: the relation `(2, −1)` of `(1, 2)` is tight for the winding of `x ↦ x mod 3`. -/
theorem isTight_one_two :
    IsTight (heightWinding properAlong_one_two) ⟨![2, -1], by decide⟩ := by
  sorry

end HadwigerNelson.CayleyThree
