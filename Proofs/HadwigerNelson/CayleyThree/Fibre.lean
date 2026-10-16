import Proofs.HadwigerNelson.CayleyThree.Circular
import Mathlib.Order.WellQuasiOrder

/-!
# Three colours on abelian Cayley graphs: heights, the fibre, tight relations (FS-131; planner FS131-KTC1, implementers FS131-ICT1 and FS131-ICT2)

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
theorem even_pmHeight_sub_sum (x : Fin m → ℤ) : Even (pmHeight s c x - ∑ j, x j) :=
  ⟨∑ j, x j - liftHeight s c x, by rw [pmHeight]; ring⟩

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

/-- **A Gordan bound by Dickson's lemma.** On a set `M ⊆ ℕ^ι` closed under differences of comparable elements, two
functions additive on `M` with `g x = 0 → t x = 0` satisfy `t ≤ κ·g` for one `κ`. (The minimal nonzero
elements of `M` are an antichain, finite by `WellQuasiOrderedLE.finite_of_isAntichain`; `κ` is the largest `t` among them.) -/
theorem exists_le_mul_of_imp_eq_zero {ι : Type*} [Finite ι] (M : Set (ι → ℕ))
    (hsub : ∀ x ∈ M, ∀ y ∈ M, y ≤ x → x - y ∈ M) (g t : (ι → ℕ) → ℕ)
    (hg : ∀ x ∈ M, ∀ y ∈ M, g (x + y) = g x + g y) (ht : ∀ x ∈ M, ∀ y ∈ M, t (x + y) = t x + t y)
    (h0 : ∀ x ∈ M, g x = 0 → t x = 0) : ∃ κ : ℕ, ∀ x ∈ M, t x ≤ κ * g x := by
  classical
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
    obtain ⟨κ, hκ⟩ := exists_le_mul_of_imp_eq_zero M hMsub slack (fun v => v j) hslack
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
  -- the held `ThreeColourCharacter.exists_mem_box_of_forall_int`'s proof, with `lo`, `hi` in place of `1/3`, `2/3`
  classical
  by_contra hno
  -- the matrix as a linear map, and the box
  let L : (Fin m → ℝ) →ₗ[ℝ] (Fin n → ℝ) := Matrix.mulVecLin (Matrix.of g)
  have hL : ∀ x i, L x i = ∑ j, g i j * x j := fun x i => by
    simp [L, Matrix.mulVec, dotProduct]
  let B : Set (Fin m → ℝ) := Set.univ.pi fun j => Set.Icc (lo j) (hi j)
  have hBc : IsCompact B := isCompact_univ_pi fun _ => isCompact_Icc
  have hBconv : Convex ℝ B := convex_pi fun _ _ => convex_Icc _ _
  have hw : w ∉ L '' B := by
    rintro ⟨x, hx, rfl⟩
    exact hno ⟨x, fun j => hx j (Set.mem_univ j), fun i => (hL x i).symm⟩
  -- a functional separating the image of the box from `w`, in coordinates
  obtain ⟨f, u, hfu, huw⟩ := geometric_hahn_banach_closed_point (hBconv.linear_image L)
    (hBc.image L.continuous_of_finiteDimensional).isClosed hw
  let c : Fin n → ℝ := fun i => f (fun k => if i = k then 1 else 0)
  have hf : ∀ y : Fin n → ℝ, f y = ∑ i, y i * c i := fun y => by
    simpa [smul_eq_mul] using LinearMap.pi_apply_eq_sum_univ (f : (Fin n → ℝ) →ₗ[ℝ] ℝ) y
  -- it is negative at every vertex
  let v : (Fin m → Bool) → Fin m → ℝ := fun b j => if b j then hi j else lo j
  have hv : ∀ b, v b ∈ B := fun b j _ => by
    show (if b j then hi j else lo j) ∈ Set.Icc (lo j) (hi j)
    split_ifs
    · exact ⟨hlh j, le_rfl⟩
    · exact ⟨le_rfl, hlh j⟩
  let d : (Fin m → Bool) → Fin n → ℝ := fun b i => ∑ j, g i j * v b j - w i
  have hneg : ∀ b, ∑ i, d b i * c i < 0 := fun b => by
    have h1 : f (L (v b)) < f w := (hfu _ ⟨v b, hv b, rfl⟩).trans huw
    rw [hf, hf] at h1
    have h2 : ∑ i, d b i * c i = ∑ i, L (v b) i * c i - ∑ i, w i * c i := by
      rw [← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun i _ => by rw [hL]; ring
    linarith
  -- so some integer combination is negative at every vertex
  obtain ⟨N, hN⟩ := exists_int_vector_of_forall_neg
    (fun b : Fin m → Bool => ∑ i, d b i • (LinearMap.proj i : (Fin n → ℝ) →ₗ[ℝ] ℝ)) (c := c)
    (fun b => by simpa [LinearMap.sum_apply] using hneg b)
  obtain ⟨b, hb⟩ := h N
  have hNb := hN b
  simp only [LinearMap.sum_apply, LinearMap.smul_apply, LinearMap.proj_apply, smul_eq_mul] at hNb
  have h3 : ∑ i, (N i : ℝ) * (∑ j, g i j * (if b j then hi j else lo j) - w i) = ∑ i, d b i * (N i : ℝ) :=
    Finset.sum_congr rfl fun i _ => mul_comm _ _
  linarith

/-- **A box point for a general box** (the held `Winding.exists_box_point`, with the box `∏_j [lo_j, hi_j]`): if the winding
is at most the relation form's maximum over the box at every relation, a point of the box realizes it. -/
private theorem exists_mem_box_of_le_vertex {s : Fin m → A} (W : Winding s) (lo hi : Fin m → ℝ)
    (hlh : ∀ j, lo j ≤ hi j)
    (h : ∀ r : (relMap s).ker, ((W.toHom r : ℤ) : ℝ) ≤
      ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * (if 0 ≤ (r : Fin m → ℤ) j then hi j else lo j)) :
    ∃ x : Fin m → ℝ, (∀ j, x j ∈ Set.Icc (lo j) (hi j)) ∧
      ∀ r : (relMap s).ker, ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * x j = ((W.toHom r : ℤ) : ℝ) := by
  -- finitely many generators `g i` of the relation lattice, and every relation an integer combination of them
  obtain ⟨n, g, hg⟩ := Submodule.fg_iff_exists_fin_generating_family.mp
    (IsNoetherian.noetherian (AddSubgroup.toIntSubmodule (relMap s).ker))
  have hgK : ∀ i, g i ∈ (relMap s).ker := fun i =>
    show g i ∈ AddSubgroup.toIntSubmodule (relMap s).ker from hg ▸ Submodule.subset_span ⟨i, rfl⟩
  let gK : Fin n → (relMap s).ker := fun i => ⟨g i, hgK i⟩
  have hcoe : ∀ (N : Fin n → ℤ) (j : Fin m),
      ((∑ i, N i • gK i : (relMap s).ker) : Fin m → ℤ) j = ∑ i, N i * g i j := fun N j => by
    simp [gK]
  have hrep : ∀ r : (relMap s).ker, ∃ N : Fin n → ℤ, r = ∑ i, N i • gK i := fun r => by
    have hr : (r : Fin m → ℤ) ∈ Submodule.span ℤ (Set.range g) := hg ▸ r.2
    obtain ⟨N, hN⟩ := (Submodule.mem_span_range_iff_exists_fun ℤ).mp hr
    refine ⟨N, Subtype.ext (funext fun j => ?_)⟩
    rw [hcoe, ← hN]
    simp
  -- both sides of the equation are additive in the relation
  have hkey : ∀ (N : Fin n → ℤ) (x : Fin m → ℝ),
      ∑ j, ((((∑ i, N i • gK i : (relMap s).ker) : Fin m → ℤ) j : ℤ) : ℝ) * x j
          - ((W.toHom (∑ i, N i • gK i) : ℤ) : ℝ)
        = ∑ i, (N i : ℝ) * (∑ j, ((g i j : ℤ) : ℝ) * x j - ((W.toHom (gK i) : ℤ) : ℝ)) := fun N x => by
    simp only [hcoe, map_sum, map_zsmul, smul_eq_mul, Int.cast_sum, Int.cast_mul, mul_sub, Finset.sum_sub_distrib,
      Finset.sum_mul, Finset.mul_sum]
    rw [Finset.sum_comm]
    congr 1
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  obtain ⟨x, hxB, hx⟩ := exists_mem_pi_Icc_of_forall_int lo hi hlh (fun i j => ((g i j : ℤ) : ℝ))
    (fun i => ((W.toHom (gK i) : ℤ) : ℝ)) fun N => by
      refine ⟨fun j => decide (0 ≤ ((∑ i, N i • gK i : (relMap s).ker) : Fin m → ℤ) j), ?_⟩
      have h1 := h (∑ i, N i • gK i)
      have h2 := hkey N fun j => if 0 ≤ ((∑ i, N i • gK i : (relMap s).ker) : Fin m → ℤ) j then hi j else lo j
      simp only [decide_eq_true_eq]
      linarith
  refine ⟨x, hxB, fun r => ?_⟩
  obtain ⟨N, rfl⟩ := hrep r
  have h2 := hkey N x
  have h0 : ∑ i, (N i : ℝ) * (∑ j, ((g i j : ℤ) : ℝ) * x j - ((W.toHom (gK i) : ℤ) : ℝ)) = 0 :=
    Finset.sum_eq_zero fun i _ => by rw [hx i, sub_self, mul_zero]
  linarith

/-- `−minRise (−r)` is the box maximum of the relation form, times three, at the vertex `2/3` where `r ≥ 0`. -/
private theorem neg_minRise_neg (r : Fin m → ℤ) :
    -minRise (-r) = ∑ i, (if 0 ≤ r i then 2 * r i else r i) := by
  change -(∑ i, min ((-r) i) (2 * (-r) i)) = _
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  simp only [Pi.neg_apply]; split_ifs <;> omega

/-- The least rise of `−r`. -/
private theorem minRise_neg (r : Fin m → ℤ) : minRise (-r) = minRise r - 3 * ∑ i, r i := by
  change ∑ i, min ((-r) i) (2 * (-r) i) = ∑ i, min (r i) (2 * r i) - 3 * ∑ i, r i
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  simp only [Pi.neg_apply]; omega

/-- **Farkas, one side**: with no tight relation moving `j` forward, some fibre point has `x_j > 1/3`. -/
theorem exists_mem_fibre_gt {s : Fin m → A} (W : Winding s) (j : Fin m)
    (hj : ∀ σ : (relMap s).ker, 0 < (σ : Fin m → ℤ) j → ¬ IsTight W σ) : ∃ x ∈ fibre W, 1 / 3 < x j := by
  classical
  obtain ⟨κ, hκ, hκσ⟩ := exists_slack_bound W j hj
  have hκ' : (1 : ℝ) ≤ κ := by exact_mod_cast hκ
  set ε : ℝ := 1 / (3 * κ) with hεdef
  have hε : 0 < ε := by positivity
  have hε3 : ε ≤ 1 / 3 := by
    rw [hεdef]; exact one_div_le_one_div_of_le (by norm_num) (by linarith)
  let lo : Fin m → ℝ := fun i => if i = j then 1 / 3 + ε else 1 / 3
  -- the vertex bound, with the slack paying for the raised face at `j`
  have hvert : ∀ r : (relMap s).ker, ((W.toHom r : ℤ) : ℝ) ≤
      ∑ i, (((r : Fin m → ℤ) i : ℤ) : ℝ) * (if 0 ≤ (r : Fin m → ℤ) i then 2 / 3 else lo i) := by
    intro r
    have hV := neg_minRise_neg (r : Fin m → ℤ)
    have hneg := W.minRise_le (-r)
    rw [map_neg, AddSubgroup.coe_neg] at hneg
    have hsplit : ∀ i, (((r : Fin m → ℤ) i : ℤ) : ℝ) * (if 0 ≤ (r : Fin m → ℤ) i then 2 / 3 else lo i) =
        ((if 0 ≤ (r : Fin m → ℤ) i then 2 * (r : Fin m → ℤ) i else (r : Fin m → ℤ) i : ℤ) : ℝ) / 3 +
          (if i = j then (if 0 ≤ (r : Fin m → ℤ) i then 0 else (((r : Fin m → ℤ) i : ℤ) : ℝ) * ε) else 0) := by
      intro i
      simp only [lo]
      split_ifs <;> push_cast <;> ring
    rw [Finset.sum_congr rfl fun i _ => hsplit i, Finset.sum_add_distrib, ← Finset.sum_div, ← Int.cast_sum, ← hV,
      Finset.sum_ite_eq' Finset.univ j, if_pos (Finset.mem_univ j)]
    by_cases hrj : 0 ≤ (r : Fin m → ℤ) j
    · rw [if_pos hrj]
      have : (3 : ℝ) * ((W.toHom r : ℤ) : ℝ) ≤ ((-minRise (-(r : Fin m → ℤ)) : ℤ) : ℝ) := by
        exact_mod_cast (by linarith : 3 * W.toHom r ≤ -minRise (-(r : Fin m → ℤ)))
      linarith
    · rw [if_neg hrj]
      have h1 := hκσ (-r) (by rw [AddSubgroup.coe_neg, Pi.neg_apply]; omega)
      rw [AddSubgroup.coe_neg, Pi.neg_apply, map_neg] at h1
      -- `−r_j ≤ κ (3 W(−r) − minRise (−r))`, i.e. `3 W r ≤ −minRise (−r) + r_j / κ`
      have h2 : ((-(r : Fin m → ℤ) j : ℤ) : ℝ) ≤ (κ : ℝ) * ((3 * -W.toHom r - minRise (-(r : Fin m → ℤ)) : ℤ) : ℝ) := by
        exact_mod_cast h1
      push_cast at h2 ⊢
      have hκpos : (0 : ℝ) < κ := by linarith
      have h3 : ((r : Fin m → ℤ) j : ℝ) * ε = ((r : Fin m → ℤ) j : ℝ) / (3 * κ) := by rw [hεdef]; ring
      rw [h3]
      rw [div_add_div _ _ (by norm_num : (3 : ℝ) ≠ 0) (by positivity), le_div_iff₀ (by positivity)]
      nlinarith
  obtain ⟨x, hxb, hxe⟩ := exists_mem_box_of_le_vertex W lo (fun _ => 2 / 3)
    (fun i => by simp only [lo]; split_ifs <;> linarith) hvert
  refine ⟨x, ⟨fun i => ?_, hxe⟩, ?_⟩
  · have h := hxb i
    simp only [lo] at h
    split_ifs at h
    · exact ⟨by linarith [h.1], h.2⟩
    · exact h
  · have h := hxb j
    simp only [lo, if_pos rfl] at h
    linarith [h.1]

/-- **The reversed winding** `r ↦ Σ_j r_j − W r`: the winding of the colouring `−c`. -/
def _root_.HadwigerNelson.ThreeColour.Winding.flip {s : Fin m → A} (W : Winding s) : Winding s where
  toHom :=
    { toFun := fun r => ∑ j, (r : Fin m → ℤ) j - W.toHom r
      map_zero' := by simp
      map_add' := fun r r' => by
        simp only [AddSubgroup.coe_add, Pi.add_apply, Finset.sum_add_distrib, map_add]
        ring }
  minRise_le := fun r => by
    have h := W.minRise_le (-r)
    rw [map_neg, AddSubgroup.coe_neg, minRise_neg] at h
    change minRise (r : Fin m → ℤ) ≤ 3 * (∑ j, (r : Fin m → ℤ) j - W.toHom r)
    linarith

theorem mem_fibre_flip_iff {s : Fin m → A} (W : Winding s) (x : Fin m → ℝ) :
    x ∈ fibre W.flip ↔ (fun j => 1 - x j) ∈ fibre W := by
  simp only [fibre, Set.mem_setOf_eq, Set.mem_Icc]
  refine and_congr ⟨fun h j => ⟨by linarith [(h j).2], by linarith [(h j).1]⟩,
    fun h j => ⟨by linarith [(h j).2], by linarith [(h j).1]⟩⟩ (forall_congr' fun r => ?_)
  have hflip : ((W.flip.toHom r : ℤ) : ℝ) = ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) - ((W.toHom r : ℤ) : ℝ) := by
    change ((∑ j, (r : Fin m → ℤ) j - W.toHom r : ℤ) : ℝ) = _
    push_cast; ring
  have e : ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * (1 - x j) =
      ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) - ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * x j := by
    rw [← Finset.sum_sub_distrib]; exact Finset.sum_congr rfl fun j _ => by ring
  rw [hflip, e]
  constructor <;> intro h <;> linarith

theorem isTight_flip_iff {s : Fin m → A} (W : Winding s) (σ : (relMap s).ker) : IsTight W.flip σ ↔ IsTight W (-σ) := by
  unfold IsTight
  rw [map_neg, AddSubgroup.coe_neg, minRise_neg]
  change minRise (σ : Fin m → ℤ) = 3 * (∑ j, (σ : Fin m → ℤ) j - W.toHom σ) ↔ _
  constructor <;> intro h <;> linarith

/-- **Farkas, the other side**: with no tight relation moving `j` back, some fibre point has `x_j < 2/3`. -/
theorem exists_mem_fibre_lt {s : Fin m → A} (W : Winding s) (j : Fin m)
    (hj : ∀ σ : (relMap s).ker, (σ : Fin m → ℤ) j < 0 → ¬ IsTight W σ) : ∃ x ∈ fibre W, x j < 2 / 3 := by
  obtain ⟨y, hy, hyj⟩ := exists_mem_fibre_gt W.flip j fun σ hσ ht =>
    hj (-σ) (by rw [AddSubgroup.coe_neg, Pi.neg_apply]; omega) ((isTight_flip_iff W σ).mp ht)
  exact ⟨fun i => 1 - y i, (mem_fibre_flip_iff W y).mp hy, by simp only; linarith⟩

/-! ## §4 The rational slope strict off the tight directions -/

/-- Finitely many positive reals have a positive common lower bound. -/
private theorem exists_pos_le_of_finite {ι : Type*} [Finite ι] (δ : ι → ℝ) (h : ∀ i, 0 < δ i) :
    ∃ ε > 0, ∀ i, ε ≤ δ i := by
  rcases isEmpty_or_nonempty ι with hι | hι
  · exact ⟨1, one_pos, fun i => isEmptyElim i⟩
  · obtain ⟨i₀, hi₀⟩ := Finite.exists_min δ
    exact ⟨δ i₀, h i₀, hi₀⟩

/-- **A rational solution in the box, strict where the real one is**: a rational system with a real solution in
`[1/3, 2/3]^ι` has a rational solution in the box, strictly inside it at every coordinate where the real one is (the faces
the real solution lies on held fixed, then `exists_rat_solution_near`). -/
private theorem exists_rat_near_of_box {ι κ : Type*} [Fintype ι] [Finite κ] (G : κ → ι → ℚ) (b : κ → ℚ)
    {x : ι → ℝ} (hx : ∀ k, ∑ i, ((G k i : ℚ) : ℝ) * x i = ((b k : ℚ) : ℝ))
    (hbox : ∀ i, x i ∈ Set.Icc (1 / 3 : ℝ) (2 / 3)) :
    ∃ q : ι → ℚ, (∀ k, ∑ i, G k i * q i = b k) ∧ (∀ i, ((q i : ℚ) : ℝ) ∈ Set.Icc (1 / 3 : ℝ) (2 / 3)) ∧
      ∀ i, 1 / 3 < x i → x i < 2 / 3 → 1 / 3 < ((q i : ℚ) : ℝ) ∧ ((q i : ℚ) : ℝ) < 2 / 3 := by
  classical
  let face : ι → Prop := fun i => x i = 1 / 3 ∨ x i = 2 / 3
  let vq : {i // face i} → ℚ := fun i => if x i.1 = 1 / 3 then 1 / 3 else 2 / 3
  have hvq : ∀ i : {i // face i}, ((vq i : ℚ) : ℝ) = x i.1 := by
    rintro ⟨i, hi | hi⟩
    · simp [vq, hi]
    · have : x i ≠ 1 / 3 := by rw [hi]; norm_num
      simp only [vq]
      rw [if_neg this, hi]
      norm_num
  let Gs : κ ⊕ {i // face i} → ι → ℚ := Sum.elim G (fun i' i => if i = i'.1 then 1 else 0)
  let bs : κ ⊕ {i // face i} → ℚ := Sum.elim b vq
  have hsys : ∀ k, ∑ i, ((Gs k i : ℚ) : ℝ) * x i = ((bs k : ℚ) : ℝ) := by
    rintro (k | i')
    · exact hx k
    · simp only [Gs, bs, Sum.elim_inr]
      rw [Finset.sum_eq_single i'.1 (fun i _ hi => by rw [if_neg hi, Rat.cast_zero, zero_mul]) (by simp),
        if_pos rfl, Rat.cast_one, one_mul, hvq]
  -- the margin off the faces
  obtain ⟨ε, hε, hεx⟩ : ∃ ε : ℝ, 0 < ε ∧ ∀ i, ¬ face i → ε ≤ x i - 1 / 3 ∧ ε ≤ 2 / 3 - x i := by
    let δ : ι → ℝ := fun i => if face i then 1 else min (x i - 1 / 3) (2 / 3 - x i)
    have hδ : ∀ i, 0 < δ i := fun i => by
      by_cases hi : face i
      · simp only [δ, if_pos hi]; exact one_pos
      · have h2 : x i ≠ 1 / 3 := fun he => hi (Or.inl he)
        have h3 : x i ≠ 2 / 3 := fun he => hi (Or.inr he)
        simp only [δ, if_neg hi]
        exact lt_min (by linarith [lt_of_le_of_ne (hbox i).1 (Ne.symm h2)])
          (by linarith [lt_of_le_of_ne (hbox i).2 h3])
    obtain ⟨ε, hε, hεδ⟩ := exists_pos_le_of_finite δ hδ
    refine ⟨ε, hε, fun i hi => ?_⟩
    have := hεδ i
    simp only [δ, if_neg hi] at this
    exact ⟨this.trans (min_le_left _ _), this.trans (min_le_right _ _)⟩
  obtain ⟨q, hq, hqx⟩ := exists_rat_solution_near Gs bs hsys hε
  have hqface : ∀ i, face i → ((q i : ℚ) : ℝ) = x i := fun i hi => by
    have h := hq (Sum.inr ⟨i, hi⟩)
    simp only [Gs, bs, Sum.elim_inr, ite_mul, one_mul, zero_mul, Finset.sum_ite_eq', Finset.mem_univ,
      if_true] at h
    rw [h, hvq ⟨i, hi⟩]
  refine ⟨q, fun k => hq (Sum.inl k), fun i => ?_, fun i h1 h2 => ?_⟩
  · by_cases hi : face i
    · rw [hqface i hi]; exact hbox i
    · obtain ⟨h1, h2⟩ := hεx i hi
      have h3 := abs_lt.mp (hqx i)
      exact ⟨by linarith [h3.1], by linarith [h3.2]⟩
  · have hi : ¬ face i := by rintro (h | h) <;> linarith
    obtain ⟨h3, h4⟩ := hεx i hi
    have h5 := abs_lt.mp (hqx i)
    exact ⟨by linarith [h5.1], by linarith [h5.2]⟩

/-- **A rational fibre point in the relative interior** (H-iii's `a*`, as `a* = 3 − 6x`): strict inside the box at every
direction no tight relation moves. Route: average the points of §3 (one per side and direction), then
`exists_rat_solution_near` on the affine hull with the tight coordinates held. -/
theorem exists_rat_mem_fibre_relint {s : Fin m → A} (W : Winding s) :
    ∃ x : Fin m → ℚ, (fun j => (x j : ℝ)) ∈ fibre W ∧ ∀ j ∉ tightSet W, 1 / 3 < x j ∧ x j < 2 / 3 := by
  classical
  -- a real fibre point strict off the tight directions: the average of one point per side and direction
  obtain ⟨x₀, hx₀⟩ := fibre_nonempty W
  have hgt : ∀ j, j ∉ tightSet W → ∃ x ∈ fibre W, 1 / 3 < x j := fun j hj =>
    exists_mem_fibre_gt W j fun σ hσ ht => hj ⟨σ, hσ.ne', ht⟩
  have hlt : ∀ j, j ∉ tightSet W → ∃ x ∈ fibre W, x j < 2 / 3 := fun j hj =>
    exists_mem_fibre_lt W j fun σ hσ ht => hj ⟨σ, hσ.ne, ht⟩
  choose yp hyp hypj using hgt
  choose ym hym hymj using hlt
  let pt : Option (Fin m × Bool) → Fin m → ℝ := fun o =>
    o.elim x₀ fun p => if h : p.1 ∈ tightSet W then x₀ else if p.2 then yp p.1 h else ym p.1 h
  have hpt : ∀ o, pt o ∈ fibre W := by
    rintro (_ | ⟨j, b⟩)
    · exact hx₀
    · show (if h : j ∈ tightSet W then x₀ else if b then yp j h else ym j h) ∈ fibre W
      split_ifs with h hb
      · exact hx₀
      · exact hyp j h
      · exact hym j h
  set N : ℕ := Fintype.card (Option (Fin m × Bool)) with hNdef
  have hN : (0 : ℝ) < N := by exact_mod_cast Fintype.card_pos
  let xb : Fin m → ℝ := ∑ o, (1 / (N : ℝ)) • pt o
  have hxb : xb ∈ fibre W := (convex_fibre W).sum_mem (fun _ _ => by positivity)
    (by rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, ← hNdef]; field_simp) fun o _ => hpt o
  have hxbj : ∀ j, xb j = (∑ o, pt o j) / N := fun j => by
    simp only [xb, Finset.sum_apply, Pi.smul_apply, smul_eq_mul, Finset.sum_div]
    exact Finset.sum_congr rfl fun o _ => by ring
  have hstrict : ∀ j, j ∉ tightSet W → 1 / 3 < xb j ∧ xb j < 2 / 3 := by
    intro j hj
    have hbox : ∀ o, pt o j ∈ Set.Icc (1 / 3 : ℝ) (2 / 3) := fun o => (hpt o).1 j
    have hp : 1 / 3 < pt (some (j, true)) j := by
      show 1 / 3 < (if h : j ∈ tightSet W then x₀ else if true then yp j h else ym j h) j
      rw [dif_neg hj, if_pos rfl]
      exact hypj j hj
    have hm : pt (some (j, false)) j < 2 / 3 := by
      show (if h : j ∈ tightSet W then x₀ else if false then yp j h else ym j h) j < 2 / 3
      rw [dif_neg hj, if_neg (by decide)]
      exact hymj j hj
    have hlow : ∑ _o : Option (Fin m × Bool), (1 / 3 : ℝ) < ∑ o, pt o j :=
      Finset.sum_lt_sum (fun o _ => (hbox o).1) ⟨some (j, true), Finset.mem_univ _, hp⟩
    have hhigh : ∑ o, pt o j < ∑ _o : Option (Fin m × Bool), (2 / 3 : ℝ) :=
      Finset.sum_lt_sum (fun o _ => (hbox o).2) ⟨some (j, false), Finset.mem_univ _, hm⟩
    rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, ← hNdef] at hlow hhigh
    rw [hxbj, lt_div_iff₀ hN, div_lt_iff₀ hN]
    constructor <;> linarith
  -- rational, through the generators of the relations
  obtain ⟨n, g, hg⟩ := Submodule.fg_iff_exists_fin_generating_family.mp
    (IsNoetherian.noetherian (AddSubgroup.toIntSubmodule (relMap s).ker))
  have hgK : ∀ i, g i ∈ (relMap s).ker := fun i =>
    show g i ∈ AddSubgroup.toIntSubmodule (relMap s).ker from hg ▸ Submodule.subset_span ⟨i, rfl⟩
  let gK : Fin n → (relMap s).ker := fun i => ⟨g i, hgK i⟩
  obtain ⟨q, hq, hqbox, hqstrict⟩ := exists_rat_near_of_box (fun i j => ((g i j : ℤ) : ℚ))
    (fun i => ((W.toHom (gK i) : ℤ) : ℚ)) (x := xb) (fun i => by
      have := hxb.2 (gK i)
      push_cast
      exact this) hxb.1
  refine ⟨q, ⟨hqbox, fun r => ?_⟩, fun j hj => ?_⟩
  · have hr : (r : Fin m → ℤ) ∈ Submodule.span ℤ (Set.range g) := hg ▸ r.2
    obtain ⟨Nc, hNc⟩ := (Submodule.mem_span_range_iff_exists_fun ℤ).mp hr
    have hrK : r = ∑ i, Nc i • gK i := Subtype.ext (by rw [← hNc]; simp [gK])
    have hqi : ∀ i, ∑ j, ((g i j : ℤ) : ℝ) * ((q j : ℚ) : ℝ) = ((W.toHom (gK i) : ℤ) : ℝ) := fun i => by
      have := hq i
      exact_mod_cast this
    have hcoe : ∀ j, ((∑ i, Nc i • gK i : (relMap s).ker) : Fin m → ℤ) j = ∑ i, Nc i * g i j := fun j => by
      simp [gK]
    rw [hrK, map_sum]
    simp only [map_zsmul, smul_eq_mul, Int.cast_sum, Int.cast_mul, hcoe, Finset.sum_mul]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [← hqi i, Finset.mul_sum]
    exact Finset.sum_congr rfl fun j _ => by ring
  · have h := hqstrict j (hstrict j hj).1 (hstrict j hj).2
    have e1 : (1 / 3 : ℝ) = ((1 / 3 : ℚ) : ℝ) := by push_cast; ring
    have e2 : (2 / 3 : ℝ) = ((2 / 3 : ℚ) : ℝ) := by push_cast; ring
    rw [e1, e2] at h
    exact ⟨Rat.cast_lt.mp h.1, Rat.cast_lt.mp h.2⟩

/-! ## §5 Rigidity: band characters of order 3 make every colouring affine -/

/-- **FS73-T23, the rigidity clause of row 79**: if every band character has order 3, every 3-colouring proper along a
generating family is affine, `c = c 0 + φ` with `φ : A → ZMod 3` additive. -/
theorem exists_affine_of_forall_three_nsmul {s : Fin m → A} (hgen : Function.Surjective (relMap s)) {c : A → ZMod 3}
    (hc : ProperAlong s c) (h3 : ∀ θ ∈ bandSet (Set.range s) (band 3), 3 • θ = 0) :
    ∃ φ : A →+ ZMod 3, ∀ x, c x = c 0 + φ x := by
  classical
  set W := heightWinding hc with hW
  -- every fibre point has its coordinates in `(1/3) ℤ`: its character is a band character, of order 3
  have hthird : ∀ x ∈ fibre W, ∀ j, ∃ n : ℤ, 3 * x j = n := by
    intro x hx j
    obtain ⟨θ, hθ⟩ := exists_character_of_box_point s (x := x) fun r => ⟨W.toHom r, hx.2 r⟩
    have hθb : θ ∈ bandSet (Set.range s) (band 3) := by
      rintro _ ⟨i, rfl⟩
      rw [hθ i]
      exact ⟨x i, by rw [Nat.cast_ofNat]; exact ⟨(hx.1 i).1, by linarith [(hx.1 i).2]⟩, rfl⟩
    have h := DFunLike.congr_fun (h3 θ hθb) (s j)
    rw [AddMonoidHom.nsmul_apply, hθ j, AddMonoidHom.zero_apply, ← AddCircle.coe_nsmul,
      AddCircle.coe_eq_zero_iff] at h
    obtain ⟨n, hn⟩ := h
    refine ⟨n, ?_⟩
    rw [zsmul_eq_mul, mul_one, nsmul_eq_mul] at hn
    rw [hn]
    push_cast
    ring
  -- so every direction is moved by a tight relation: otherwise two fibre points differ there by `1/3`, and their
  -- midpoint has a coordinate `1/2`
  have htight : ∀ j, j ∈ tightSet W := by
    intro j
    by_contra hj
    obtain ⟨x, hx, hxj⟩ := exists_mem_fibre_gt W j fun σ hσ ht => hj ⟨σ, hσ.ne', ht⟩
    obtain ⟨y, hy, hyj⟩ := exists_mem_fibre_lt W j fun σ hσ ht => hj ⟨σ, hσ.ne, ht⟩
    have hmid : (1 / 2 : ℝ) • x + (1 / 2 : ℝ) • y ∈ fibre W :=
      convex_fibre W hx hy (by norm_num) (by norm_num) (by norm_num)
    obtain ⟨n, hn⟩ := hthird x hx j
    obtain ⟨n', hn'⟩ := hthird y hy j
    obtain ⟨k, hk⟩ := hthird _ hmid j
    simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul] at hk
    have hx2 := (hx.1 j).2
    have hy1 := (hy.1 j).1
    have a1 : (1 : ℝ) < n := by rw [← hn]; linarith
    have a2 : (n : ℝ) ≤ 2 := by rw [← hn]; linarith
    have a3 : (1 : ℝ) ≤ n' := by rw [← hn']; linarith
    have a4 : (n' : ℝ) < 2 := by rw [← hn']; linarith
    have a5 : (2 * k : ℝ) = n + n' := by rw [← hk, ← hn, ← hn']; ring
    have b1 : 1 < n := by exact_mod_cast a1
    have b2 : n ≤ 2 := by exact_mod_cast a2
    have b3 : 1 ≤ n' := by exact_mod_cast a3
    have b4 : n' < 2 := by exact_mod_cast a4
    have b5 : 2 * k = n + n' := by exact_mod_cast a5
    omega
  -- every step is constant along its direction
  have hconst : ∀ j a, step s c a j = step s c 0 j := by
    intro j a
    obtain ⟨σ, hσj, hσt⟩ := htight j
    rcases lt_or_gt_of_ne hσj with h | h
    · rw [step_eq_two_of_isTight hc hgen hσt h a, step_eq_two_of_isTight hc hgen hσt h 0]
    · rw [step_eq_one_of_isTight hc hgen hσt h a, step_eq_one_of_isTight hc hgen hσt h 0]
  let d : Fin m → ZMod 3 := fun j => ((step s c 0 j : ℤ) : ZMod 3)
  have hd : ∀ a j, c (a + s j) = c a + d j := fun a j => by
    have h := step_cast s hc a j
    rw [hconst j a] at h
    simp only [d]
    rw [h]
    ring
  -- so the colouring moves by `ψ r = Σ_j r_j d_j` along every vector `r`
  let ψ : (Fin m → ℤ) →+ ZMod 3 :=
    { toFun := fun r => ∑ j, ((r j : ℤ) : ZMod 3) * d j
      map_zero' := by simp
      map_add' := fun r r' => by simp only [Pi.add_apply, Int.cast_add, add_mul, Finset.sum_add_distrib] }
  let H : AddSubgroup (Fin m → ℤ) :=
    { carrier := {r | ∀ a, c (a + relMap s r) = c a + ψ r}
      zero_mem' := fun a => by simp only [map_zero, add_zero]
      add_mem' := fun {r r'} hr hr' a => by
        change c (a + relMap s (r + r')) = c a + ψ (r + r')
        rw [map_add, map_add, ← add_assoc, hr' (a + relMap s r), hr a, add_assoc]
      neg_mem' := fun {r} hr a => by
        change c (a + relMap s (-r)) = c a + ψ (-r)
        have h := hr (a - relMap s r)
        rw [sub_add_cancel] at h
        rw [map_neg, map_neg, ← sub_eq_add_neg, h]
        ring }
  have hH : ∀ r, r ∈ H := by
    intro r
    rw [← Finset.univ_sum_single r]
    refine AddSubgroup.sum_mem _ fun j _ => ?_
    rw [show Pi.single j (r j) = r j • (Pi.single j (1 : ℤ) : Fin m → ℤ) by rw [← Pi.single_smul, smul_eq_mul, mul_one]]
    have hsingle : (Pi.single j (1 : ℤ) : Fin m → ℤ) ∈ H := by
      intro a
      rw [relMap_single, hd]
      congr 1
      change d j = ∑ i, (((Pi.single j (1 : ℤ) : Fin m → ℤ) i : ℤ) : ZMod 3) * d i
      rw [Finset.sum_eq_single j (fun i _ hi => by rw [Pi.single_eq_of_ne hi, Int.cast_zero, zero_mul])
        (by simp), Pi.single_eq_same, Int.cast_one, one_mul]
    exact AddSubgroup.zsmul_mem _ hsingle _
  -- the additive part
  refine ⟨{ toFun := fun a => c a - c 0, map_zero' := by simp, map_add' := fun a b => ?_ }, fun x => by simp⟩
  obtain ⟨r, rfl⟩ := hgen b
  have h1 := hH r a
  have h2 := hH r 0
  rw [zero_add] at h2
  change c (a + relMap s r) - c 0 = (c a - c 0) + (c (relMap s r) - c 0)
  rw [h1, h2]
  ring

/-! ## Spec: the model `ℤ` along `(1, 2)`, `x ↦ x mod 3` -/

example : l1 ![(2 : ℤ), -1] = 3 := by decide
example : liftHeight ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) ![2, -1] = 0 := by decide
example : pmHeight ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) ![1, 0] = 1 := by decide
example : pmHeight ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) ![0, 1] = -1 := by decide

/-- The model of `IsTight`: the relation `(2, −1)` of `(1, 2)` is tight for the winding of `x ↦ x mod 3`. -/
theorem isTight_one_two :
    IsTight (heightWinding properAlong_one_two) ⟨![2, -1], by decide⟩ := by
  unfold IsTight
  rw [heightWinding_apply]
  decide

end HadwigerNelson.CayleyThree
