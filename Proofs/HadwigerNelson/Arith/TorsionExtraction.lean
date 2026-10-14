import Proofs.HadwigerNelson.Arith.ThreeColourCharacter

/-!
# Four colours wherever `1/3` is a combination of unit vectors: the rational layer, the torsion extraction (FS-131, NF4)

**Read aloud, against the claim** (`data/fs131/claims-NF4.md`, NF4-THEOREM).
* (c) *"For any subfield `F` of `ℝ`: if `1/3` is an integer combination of unit vectors and `F²` has an odd cycle, then
  `χ(F²) ⩾ 4`."* — `four_le_chromaticNumber_planeOver_of_inv_three_mem`. Its strongest form is
  `colorable_two_of_inv_three_mem`: where `1/3 ∈ ℤ[U_F]`, a three-colourable plane is two-colourable, so `χ(F²) ≠ 3`
  (`chromaticNumber_planeOver_ne_three_of_inv_three_mem`).
* (a), the lower bound: *"For every squarefree `m ≡ 11 (mod 12)`, `χ(ℚ(√m)²) ⩾ 4`."* —
  `four_le_chromaticNumber_planeOver_fieldOfRadicands`, the case `F = ℚ(√d)` of
  `four_le_chromaticNumber_planeOver_of_sqrt_mem`: **every subfield of `ℝ` holding `√d`, `d ≡ 11 (mod 12)`; squarefreeness
  is the claim's and is not used.** The value `3` at `d ≡ 3 (mod 4)`, from below:
  `three_le_chromaticNumber_planeOver_of_sqrt_mem`.
* NF4-S7 (FS91-J02-L1, torsion extraction: *"`Θ₃(R_F) ≠ ∅ ⟹ Θ₃(R_F) ∩ T₆ ≠ ∅`, every `F ⊆ ℝ`"*) —
  `exists_torsion_mem_fieldBandSet`.

**The route.** A three-colouring gives `θ ∈ Θ₃(R_F)` (`ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable`).
For a unit vector `b` and `w = (3 + 4i)/5`, write `θ(b wᵐ) = 1/2 + aₘ`, `θ(i b wᵐ) = 1/2 + bₘ` with `|aₘ|, |bₘ| ≤ 1/6`.
The relation `(2 − i) w = 2 + i` and its multiple by `i` make `2a' − b' − 2a − b` and `a' + 2b' + a − 2b` integers; on the
box each is at most `6·(1/6) = 1` in absolute value, with equality only at corners (`layer_step`). So each step is a
rotation or joins two corners, and a rotation step from a corner leaves the box: a layer is all rotations or all corners
(`layer_dichotomy`). Along `25⁻ⁿ b` a rotation layer tends to `1/2` and a corner layer is constant at `1/3` or `2/3`
(`tendsto_layer`); the limit is additive, so it is a character `τ` with `6τ = 0` and `τ(U_F) ⊆ {1/3, 1/2, 2/3}`. If
`1/3 ∈ ℤ[U_F]` then `τ(u) = 3τ(u/3)` is killed by 2, so `τ = 1/2` on `U_F`: a two-colouring.

**Whose this is** (`LEDGER.md` § The claim list, row 82; `plans/FS81-derivation.md` T4, T5; the paper read against
these statements by FS131-KJ1). The obstruction "`1/k ∈ ℤ[U]` ⟹ no **additive** `k`-colouring" is `[Fischer1990]` §1
(p. 182) and Thm 10(ii) (pp. 193–194); the unit vector `v` and `1/3 ∈ ℤ[U]` at `N ≡ −1 (mod 24)` are its Thm 10(ii) and
Ex. 4 (p. 194), and `[Johnson2000]` p. 176 poses the family as open. **The two-colour criterion in character form**
(`colorable_two_iff_fieldBandSet_two_nonempty`) is `[Fischer1990]` Thm 1(ii) (p. 183), and **the lower bound three at
`d ≡ 3 (mod 4)`** (`not_colorable_two_of_sqrt_mem`) is the "only if" of its Thm 8 (pp. 189–190), by the same unit vector
and the same relation — his for squarefree `N` and the quadratic field, here for every subfield holding `√d`. The
passage from additive to **all** three-colourings — the lower bound at four — is this project's `[hand, two independent
derivations]`; not found in print. The route through `layer_step` (no computed cell list) is the kernel planner's.

**Inhabitants.** `F = ℚ(√11)`: `√11 ∈ F`, `1/3 = 2 − v − v̄` with `v = (5 + i√11)/6`, and the plane is not two-colourable;
every hypothesis of the headlines holds there (`four_le_chromaticNumber_planeOver_fieldOfRadicands` at `d = 11`, the value
row 73 holds by a 204-point witness). `Θ₃(R_F) ≠ ∅` is inhabited at `F = ℚ(√3)` (`[Fischer1990]` Thm 9), which no
declaration here exhibits — the joining module does (`ThreeFourColours.fieldBandSet_three_nonempty_sqrt_three`); `Θ₂` at `F = ℚ` by `colorable_two_iff_fieldBandSet_two_nonempty` and Woodall's two-colouring.
-/

namespace HadwigerNelson.TorsionExtraction

open HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain HadwigerNelson.SquareClass SimpleGraph

/-! ## §1 The rational layer: two integer relations on the box (FS81-T3, without the cell list) -/

/-- A form `2x + y + 2z + w` on the box `[−1/6, 1/6]⁴` of absolute value at least 1 sits at a corner. -/
private theorem abs_eq_of_one_le_abs_form {x y z w : ℝ} (hx : |x| ≤ 1 / 6) (hy : |y| ≤ 1 / 6) (hz : |z| ≤ 1 / 6)
    (hw : |w| ≤ 1 / 6) (h : 1 ≤ |2 * x + y + 2 * z + w|) :
    |x| = 1 / 6 ∧ |y| = 1 / 6 ∧ |z| = 1 / 6 ∧ |w| = 1 / 6 := by
  have hle : |2 * x + y + 2 * z + w| ≤ 2 * |x| + |y| + 2 * |z| + |w| :=
    abs_le.mpr ⟨by linarith [neg_abs_le x, neg_abs_le y, neg_abs_le z, neg_abs_le w],
      by linarith [le_abs_self x, le_abs_self y, le_abs_self z, le_abs_self w]⟩
  exact ⟨le_antisymm hx (by linarith), le_antisymm hy (by linarith), le_antisymm hz (by linarith),
    le_antisymm hw (by linarith)⟩

/-- **One step of a layer.** Four reals in `[−1/6, 1/6]` whose two relation forms are integers: either the step is the
rotation by `w̄ = (3 − 4i)/5`, or all four are at absolute value `1/6`. (Each form is bounded by `6·(1/6) = 1`.) -/
theorem layer_step {a b a' b' : ℝ} (ha : |a| ≤ 1 / 6) (hb : |b| ≤ 1 / 6) (ha' : |a'| ≤ 1 / 6) (hb' : |b'| ≤ 1 / 6)
    (h1 : ∃ n : ℤ, 2 * a' - b' - 2 * a - b = n) (h2 : ∃ n : ℤ, a' + 2 * b' + a - 2 * b = n) :
    (a' = (3 * a + 4 * b) / 5 ∧ b' = (-4 * a + 3 * b) / 5) ∨
      (|a| = 1 / 6 ∧ |b| = 1 / 6 ∧ |a'| = 1 / 6 ∧ |b'| = 1 / 6) := by
  obtain ⟨n1, hn1⟩ := h1
  obtain ⟨n2, hn2⟩ := h2
  have hint : ∀ n : ℤ, n ≠ 0 → (1 : ℝ) ≤ |(n : ℝ)| := fun n hn => by
    exact_mod_cast Int.one_le_abs hn
  by_cases h0 : n1 = 0 ∧ n2 = 0
  · left
    obtain ⟨rfl, rfl⟩ := h0
    rw [Int.cast_zero] at hn1 hn2
    constructor <;> linarith
  · right
    rcases not_and_or.mp h0 with h | h
    · -- the first form, `2a' + (−b') + 2(−a) + (−b)`, is `±1`
      have hf : 1 ≤ |2 * a' + -b' + 2 * -a + -b| := by
        rw [show 2 * a' + -b' + 2 * -a + -b = (n1 : ℝ) by rw [← hn1]; ring]
        exact hint n1 h
      have := abs_eq_of_one_le_abs_form ha' (by rwa [abs_neg]) (by rwa [abs_neg]) (by rwa [abs_neg]) hf
      simp only [abs_neg] at this
      exact ⟨this.2.2.1, this.2.2.2, this.1, this.2.1⟩
    · -- the second form, `2b' + a' + 2(−b) + a`, is `±1`
      have hf : 1 ≤ |2 * b' + a' + 2 * -b + a| := by
        rw [show 2 * b' + a' + 2 * -b + a = (n2 : ℝ) by rw [← hn2]; ring]
        exact hint n2 h
      have := abs_eq_of_one_le_abs_form hb' ha' (by rwa [abs_neg]) ha hf
      simp only [abs_neg] at this
      exact ⟨this.2.2.2, this.2.2.1, this.2.1, this.1⟩

/-- A rotation step by `(3 − 4i)/5` between two points of the box has neither end at a corner: the other end would
have a coordinate `7/30 > 1/6`. -/
private theorem no_rotation_at_corner {a b a' b' : ℝ} (ha : |a| ≤ 1 / 6) (hb : |b| ≤ 1 / 6) (ha' : |a'| ≤ 1 / 6)
    (hb' : |b'| ≤ 1 / 6) (h1 : a' = (3 * a + 4 * b) / 5) (h2 : b' = (-4 * a + 3 * b) / 5)
    (hc : (|a| = 1 / 6 ∧ |b| = 1 / 6) ∨ (|a'| = 1 / 6 ∧ |b'| = 1 / 6)) : False := by
  rw [abs_le] at ha hb ha' hb'
  have hcase : ∀ x : ℝ, |x| = 1 / 6 → x = 1 / 6 ∨ x = -(1 / 6) := fun x hx => by
    rcases abs_cases x with ⟨h, _⟩ | ⟨h, _⟩
    · left; linarith
    · right; linarith
  rcases hc with ⟨h, h'⟩ | ⟨h, h'⟩ <;> rcases hcase _ h with e | e <;> rcases hcase _ h' with e' | e' <;> linarith

/-- **The layer dichotomy** (FS81-T3 in sequence form): a two-sided sequence in the box whose consecutive terms satisfy
the two relations is a rotation orbit, or sits at corners throughout. -/
theorem layer_dichotomy {a b : ℤ → ℝ} (ha : ∀ m, |a m| ≤ 1 / 6) (hb : ∀ m, |b m| ≤ 1 / 6)
    (h1 : ∀ m, ∃ n : ℤ, 2 * a (m + 1) - b (m + 1) - 2 * a m - b m = n)
    (h2 : ∀ m, ∃ n : ℤ, a (m + 1) + 2 * b (m + 1) + a m - 2 * b m = n) :
    (∀ m, a (m + 1) = (3 * a m + 4 * b m) / 5 ∧ b (m + 1) = (-4 * a m + 3 * b m) / 5) ∨
      (∀ m, |a m| = 1 / 6 ∧ |b m| = 1 / 6) := by
  have step := fun m => layer_step (ha m) (hb m) (ha (m + 1)) (hb (m + 1)) (h1 m) (h2 m)
  by_cases hrot : ∀ m, a (m + 1) = (3 * a m + 4 * b m) / 5 ∧ b (m + 1) = (-4 * a m + 3 * b m) / 5
  · exact Or.inl hrot
  right
  obtain ⟨m₀, hm₀⟩ := not_forall.mp hrot
  -- the step at `m₀` is not a rotation, so `m₀` is at a corner
  have h0 : |a m₀| = 1 / 6 ∧ |b m₀| = 1 / 6 := by
    rcases step m₀ with h | h
    · exact absurd h hm₀
    · exact ⟨h.1, h.2.1⟩
  -- a corner propagates one step forward and one step back: the step is not a rotation
  have fwd : ∀ m, (|a m| = 1 / 6 ∧ |b m| = 1 / 6) → |a (m + 1)| = 1 / 6 ∧ |b (m + 1)| = 1 / 6 := by
    intro m hm
    rcases step m with h | h
    · exact (no_rotation_at_corner (ha m) (hb m) (ha (m + 1)) (hb (m + 1)) h.1 h.2 (Or.inl hm)).elim
    · exact ⟨h.2.2.1, h.2.2.2⟩
  have bwd : ∀ m, (|a (m + 1)| = 1 / 6 ∧ |b (m + 1)| = 1 / 6) → |a m| = 1 / 6 ∧ |b m| = 1 / 6 := by
    intro m hm
    rcases step m with h | h
    · exact (no_rotation_at_corner (ha m) (hb m) (ha (m + 1)) (hb (m + 1)) h.1 h.2 (Or.inr hm)).elim
    · exact ⟨h.1, h.2.1⟩
  intro m
  induction m using Int.inductionOn' (b := m₀) with
  | zero => exact h0
  | succ k _ ih => exact fwd k ih
  | pred k _ ih =>
    refine bwd (k - 1) ?_
    rwa [sub_add_cancel]

/-! ## §2 The limit along `25⁻ⁿ`, and the torsion character (FS81-T4, FS91-J02-L1) -/

variable {F : Subfield ℝ}

/-- `1/5 = w + w⁻¹ − 1` as an element of `ℤ[U_F]`. -/
noncomputable def inv5 (F : Subfield ℝ) : unitRing F := ⟨(5 : ℂ)⁻¹, unitRing_mono bot_le inv_five_mem_Qring⟩

@[simp] theorem coe_inv5 (F : Subfield ℝ) : ((inv5 F : unitRing F) : ℂ) = (5 : ℂ)⁻¹ := rfl

/-- **Induction on `ℤ[U_F]`**: it is the additive span of the unit vectors, so a property of `0` that passes to sums and
holds at every unit vector holds everywhere (`UnitRing.exists_sum_eq_of_mem_unitRingOver`). -/
private theorem unitRing_induction {p : unitRing F → Prop} (h0 : p 0) (hadd : ∀ x y, p x → p y → p (x + y))
    (hu : ∀ u ∈ unitSet F, p u) (x : unitRing F) : p x := by
  obtain ⟨x, hx⟩ := x
  obtain ⟨n, u, hu1, huF, rfl⟩ := UnitRing.exists_sum_eq_of_mem_unitRingOver hx
  have hsum : (⟨∑ j, u j, hx⟩ : unitRing F) =
      ∑ j, (⟨u j, UnitRing.unit_mem_unitRingOver (huF j) (hu1 j)⟩ : unitRing F) := by
    apply Subtype.ext
    simp
  rw [hsum]
  exact Finset.sum_induction _ p hadd h0 fun j _ => hu _ ⟨huF j, hu1 j⟩

/-- **The orbit of a unit vector under `w = (3 + 4i)/5`**, with the three relations the layer argument reads:
`g m = wᵐ b` and `J = i` in `ℤ[U_F]`; `(2 − i) w = 2 + i` at `g m`, its multiple by `i`, and
`g m / 5 = g (m + 1) + g (m − 1) − g m` (`1/5 = w + w⁻¹ − 1`). -/
private theorem exists_orbit {b : unitRing F} (hb : b ∈ unitSet F) :
    ∃ (g : ℤ → unitRing F) (J : unitRing F), g 0 = b ∧ (∀ m, g m ∈ unitSet F) ∧ (∀ m, J * g m ∈ unitSet F) ∧
      (∀ m, g (m + 1) + g (m + 1) - J * g (m + 1) - g m - g m - J * g m = 0) ∧
      (∀ m, g (m + 1) + J * g (m + 1) + J * g (m + 1) + g m - J * g m - J * g m = 0) ∧
      (∀ m, inv5 F * g m = g (m + 1) + g (m - 1) - g m) := by
  have hq : ∀ q : ℚ, (q : ℝ) ∈ F := fun q => SubfieldClass.ratCast_mem F q
  obtain ⟨w, hw⟩ : ∃ w : ℂ, w = ⟨3 / 5, 4 / 5⟩ := ⟨_, rfl⟩
  have hwF : w ∈ unitVectors F := by
    rw [hw]
    refine ⟨⟨by simpa using hq (3 / 5), by simpa using hq (4 / 5)⟩, ?_⟩
    rw [Complex.norm_eq_sqrt_sq_add_sq]
    norm_num
  have hw0 : w ≠ 0 := fun h => by
    have := hwF.2
    rw [h, norm_zero] at this
    exact zero_ne_one this
  have hI : Complex.I ∈ unitVectors F :=
    ⟨⟨by rw [Complex.I_re]; exact F.zero_mem, by rw [Complex.I_im]; exact F.one_mem⟩, Complex.norm_I⟩
  have hrel : (2 - Complex.I) * w = 2 + Complex.I := by
    rw [hw]
    apply Complex.ext
    · simp only [Complex.mul_re, Complex.sub_re, Complex.re_ofNat, Complex.I_re, sub_zero, Complex.sub_im,
        Complex.im_ofNat, Complex.I_im, zero_sub, neg_mul, one_mul, sub_neg_eq_add, Complex.add_re, add_zero]
      norm_num
    · simp only [Complex.mul_im, Complex.sub_re, Complex.re_ofNat, Complex.I_re, sub_zero, Complex.sub_im,
        Complex.im_ofNat, Complex.I_im, zero_sub, neg_mul, one_mul, Complex.add_im, zero_add]
      norm_num
  have hwinv : w⁻¹ = ⟨3 / 5, -(4 / 5)⟩ := by
    refine inv_eq_of_mul_eq_one_right ?_
    rw [hw]
    apply Complex.ext
    · simp only [Complex.mul_re, mul_neg, sub_neg_eq_add, Complex.one_re]
      norm_num
    · simp only [Complex.mul_im, mul_neg, Complex.one_im]
      norm_num
  have hinv : w + w⁻¹ - 1 = 5⁻¹ := by
    rw [hwinv, hw]
    apply Complex.ext
    · simp only [Complex.sub_re, Complex.add_re, Complex.one_re, Complex.inv_re, Complex.re_ofNat,
        Complex.normSq_ofNat, div_self_mul_self']
      norm_num
    · simp
  have hmem : ∀ m : ℤ, w ^ m * (b : ℂ) ∈ unitVectors F := fun m =>
    ⟨(UnitRing.planeOverSubfield F).mul_mem (zpow_mem (show w ∈ UnitRing.planeOverSubfield F from hwF.1) m) hb.1, by
      rw [norm_mul, norm_zpow, hwF.2, one_zpow, one_mul]
      exact hb.2⟩
  refine ⟨fun m => ⟨w ^ m * b, unitVectors_subset_unitRing F (hmem m)⟩, ⟨Complex.I, unitVectors_subset_unitRing F hI⟩,
    Subtype.ext (show w ^ (0 : ℤ) * (b : ℂ) = b by rw [zpow_zero, one_mul]), hmem, fun m => ?_, fun m => ?_, fun m => ?_,
    fun m => ?_⟩
  · exact ⟨(UnitRing.planeOverSubfield F).mul_mem hI.1 (hmem m).1, by
      show ‖Complex.I * (w ^ m * (b : ℂ))‖ = 1
      rw [norm_mul, Complex.norm_I, (hmem m).2, one_mul]⟩
  · apply Subtype.ext
    show w ^ (m + 1) * (b : ℂ) + w ^ (m + 1) * b - Complex.I * (w ^ (m + 1) * b) - w ^ m * b - w ^ m * b -
      Complex.I * (w ^ m * b) = 0
    rw [zpow_add_one₀ hw0]
    linear_combination (w ^ m * b) * hrel
  · apply Subtype.ext
    show w ^ (m + 1) * (b : ℂ) + Complex.I * (w ^ (m + 1) * b) + Complex.I * (w ^ (m + 1) * b) + w ^ m * b -
      Complex.I * (w ^ m * b) - Complex.I * (w ^ m * b) = 0
    rw [zpow_add_one₀ hw0]
    linear_combination (w ^ m * b * Complex.I) * hrel + (w ^ m * w * b + w ^ m * b) * Complex.I_sq
  · apply Subtype.ext
    show (5 : ℂ)⁻¹ * (w ^ m * (b : ℂ)) = w ^ (m + 1) * b + w ^ (m - 1) * b - w ^ m * b
    rw [zpow_add_one₀ hw0, zpow_sub_one₀ hw0]
    linear_combination (-(w ^ m * b)) * hinv

/-- A point of `band 3 = [1/3, 2/3]` is `1/2 + x` with `|x| ≤ 1/6`. -/
private theorem exists_lift_of_mem_band_three {t : UnitAddCircle} (h : t ∈ band 3) :
    ∃ x : ℝ, |x| ≤ 1 / 6 ∧ t = ((1 / 2 + x : ℝ) : UnitAddCircle) := by
  obtain ⟨y, ⟨hy1, hy2⟩, rfl⟩ := h
  push_cast at hy1 hy2
  refine ⟨y - 1 / 2, abs_le.mpr ⟨by linarith, by linarith⟩, ?_⟩
  show (y : UnitAddCircle) = ((1 / 2 + (y - 1 / 2) : ℝ) : UnitAddCircle)
  congr 1
  ring

/-- **A rotation layer along `5⁻ᵏ`**: `θ(5⁻ᵏ g_m) = 1/2 + a_m / 5ᵏ`. (Induction on the depth `k`, the layer index `m`
inside: the step reads `m ± 1`, and `a_{m+1} + a_{m−1} = (6/5) a_m` on a rotation orbit.) -/
private theorem rotation_layer {θ : unitRing F →+ UnitAddCircle} {g : ℤ → unitRing F} {a bb : ℤ → ℝ}
    (hg : ∀ m, inv5 F * g m = g (m + 1) + g (m - 1) - g m)
    (ha : ∀ m, θ (g m) = ((1 / 2 + a m : ℝ) : UnitAddCircle))
    (hrot : ∀ m, a (m + 1) = (3 * a m + 4 * bb m) / 5 ∧ bb (m + 1) = (-4 * a m + 3 * bb m) / 5) (k : ℕ) (m : ℤ) :
    θ (inv5 F ^ k * g m) = ((1 / 2 + a m / 5 ^ k : ℝ) : UnitAddCircle) := by
  induction k generalizing m with
  | zero => rw [pow_zero, one_mul, pow_zero, div_one]; exact ha m
  | succ k ih =>
    have hsum : a (m + 1) + a (m - 1) - a m = a m / 5 := by
      have h1 := hrot m
      have h2 := hrot (m - 1)
      rw [sub_add_cancel] at h2
      linarith [h1.1, h2.1, h2.2]
    have hreal : a m / 5 ^ (k + 1) = (a (m + 1) + a (m - 1) - a m) / 5 ^ k := by
      rw [hsum, pow_succ]
      field_simp
    rw [pow_succ, mul_assoc, hg m, mul_sub, mul_add, map_sub, map_add, ih, ih, ih, ← AddCircle.coe_add,
      ← AddCircle.coe_sub, hreal]
    congr 1
    ring

/-- **A corner layer along `5⁻ᵏ`**: `3 • θ(5⁻ᵏ g_m) = 0` at every depth, by the same induction. -/
private theorem corner_layer {θ : unitRing F →+ UnitAddCircle} {g : ℤ → unitRing F}
    (hg : ∀ m, inv5 F * g m = g (m + 1) + g (m - 1) - g m) (h3 : ∀ m, 3 • θ (g m) = 0) (k : ℕ) (m : ℤ) :
    3 • θ (inv5 F ^ k * g m) = 0 := by
  induction k generalizing m with
  | zero => rw [pow_zero, one_mul]; exact h3 m
  | succ k ih =>
    rw [pow_succ, mul_assoc, hg m, mul_sub, mul_add, map_sub, map_add, smul_sub, smul_add, ih, ih, ih, add_zero,
      sub_zero]

/-- **The limit on one layer.** For `θ ∈ Θ₃(R_F)` and a unit vector `b`, `θ(25⁻ⁿ b)` converges, to `1/2` (a parity-type
layer) or to `1/3` or `2/3` (an order-3 layer, on which the sequence is constant). -/
theorem tendsto_layer {θ : unitRing F →+ UnitAddCircle} (hθ : θ ∈ fieldBandSet F (band 3)) {b : unitRing F}
    (hb : b ∈ unitSet F) :
    ∃ t : UnitAddCircle, (t = ((1 / 2 : ℝ) : UnitAddCircle) ∨ t = ((1 / 3 : ℝ) : UnitAddCircle) ∨
        t = ((2 / 3 : ℝ) : UnitAddCircle)) ∧
      Filter.Tendsto (fun n : ℕ => θ (inv5 F ^ (2 * n) * b)) Filter.atTop (nhds t) := by
  obtain ⟨g, J, hg0, hgU, hJU, hr1, hr2, hg⟩ := exists_orbit hb
  -- lifts of `θ(g m) − 1/2` and `θ(i g m) − 1/2` to `[−1/6, 1/6]`
  choose a ha ha' using fun m => exists_lift_of_mem_band_three (hθ _ (hgU m))
  choose bb hbb hbb' using fun m => exists_lift_of_mem_band_three (hθ _ (hJU m))
  -- the two relations, read through `θ`
  have h1 : ∀ m, ∃ n : ℤ, 2 * a (m + 1) - bb (m + 1) - 2 * a m - bb m = n := by
    intro m
    have h := congrArg θ (hr1 m)
    simp only [map_sub, map_add, map_zero, ha', hbb', ← AddCircle.coe_add, ← AddCircle.coe_sub] at h
    obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp h
    rw [zsmul_one] at hn
    refine ⟨n + 1, ?_⟩
    push_cast
    linarith
  have h2 : ∀ m, ∃ n : ℤ, a (m + 1) + 2 * bb (m + 1) + a m - 2 * bb m = n := by
    intro m
    have h := congrArg θ (hr2 m)
    simp only [map_sub, map_add, map_zero, ha', hbb', ← AddCircle.coe_add, ← AddCircle.coe_sub] at h
    obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp h
    rw [zsmul_one] at hn
    refine ⟨n - 1, ?_⟩
    push_cast
    linarith
  rcases layer_dichotomy ha hbb h1 h2 with hrot | hcor
  · -- a rotation layer: `θ(25⁻ⁿ b) = 1/2 + a 0 / 25ⁿ → 1/2`
    refine ⟨((1 / 2 : ℝ) : UnitAddCircle), Or.inl rfl, ?_⟩
    have hval : ∀ n : ℕ, θ (inv5 F ^ (2 * n) * b) = ((1 / 2 + a 0 * (1 / 25) ^ n : ℝ) : UnitAddCircle) := by
      intro n
      rw [← hg0, rotation_layer hg ha' hrot (2 * n) 0]
      congr 2
      rw [pow_mul, div_eq_mul_inv, ← inv_pow]
      norm_num
    have hlim : Filter.Tendsto (fun n : ℕ => (1 / 2 + a 0 * (1 / 25 : ℝ) ^ n)) Filter.atTop (nhds (1 / 2 + a 0 * 0)) :=
      tendsto_const_nhds.add ((tendsto_pow_atTop_nhds_zero_of_lt_one (by norm_num) (by norm_num)).const_mul (a 0))
    rw [mul_zero, add_zero] at hlim
    simp only [hval]
    exact ((AddCircle.continuous_mk' (1 : ℝ)).tendsto _).comp hlim
  · -- a corner layer: `3 • θ(5⁻ᵏ b) = 0`, so `θ(25⁻ⁿ b)` is constant at `θ b = 1/2 ± 1/6`
    have h3 : ∀ m, 3 • θ (g m) = 0 := by
      intro m
      rw [ha', ← AddCircle.coe_nsmul, AddCircle.coe_eq_zero_iff]
      rcases (abs_eq (by norm_num : (0 : ℝ) ≤ 1 / 6)).mp (hcor m).1 with h | h
      · exact ⟨2, by rw [h]; norm_num⟩
      · exact ⟨1, by rw [h]; norm_num⟩
    have hconst : ∀ n : ℕ, θ (inv5 F ^ (2 * n) * b) = θ b := by
      intro n
      induction n with
      | zero => rw [mul_zero, pow_zero, one_mul]
      | succ n ih =>
        have h25 : inv5 F ^ (2 * n) * b = 25 • (inv5 F ^ (2 * (n + 1)) * b) := by
          apply Subtype.ext
          rw [nsmul_eq_mul, mul_add, mul_one, pow_add]
          simp only [Subring.coe_mul, Subring.coe_pow, coe_inv5, Subring.coe_natCast]
          push_cast
          ring
        have h3' := corner_layer hg h3 (2 * (n + 1)) 0
        rw [hg0] at h3'
        rw [← ih, h25, map_nsmul, show (25 : ℕ) = 1 + 8 * 3 by norm_num, add_smul, one_smul, mul_smul, h3', smul_zero,
          add_zero]
    have hb0 : θ b = ((1 / 2 + a 0 : ℝ) : UnitAddCircle) := by rw [← hg0, ha']
    simp only [hconst]
    rcases (abs_eq (by norm_num : (0 : ℝ) ≤ 1 / 6)).mp (hcor 0).1 with h | h
    · refine ⟨((2 / 3 : ℝ) : UnitAddCircle), Or.inr (Or.inr rfl), ?_⟩
      rw [hb0, h, show (1 / 2 + 1 / 6 : ℝ) = 2 / 3 by norm_num]
      exact tendsto_const_nhds
    · refine ⟨((1 / 3 : ℝ) : UnitAddCircle), Or.inr (Or.inl rfl), ?_⟩
      rw [hb0, h, show (1 / 2 + -(1 / 6) : ℝ) = 1 / 3 by norm_num]
      exact tendsto_const_nhds

/-- **NF4-S7, torsion extraction (FS91-J02-L1), every subfield `F ⊆ ℝ`**: `Θ₃(R_F) ≠ ∅ ⟹ Θ₃(R_F) ∩ T₆ ≠ ∅`. -/
theorem exists_torsion_mem_fieldBandSet (F : Subfield ℝ) (h : (fieldBandSet F (band 3)).Nonempty) :
    ∃ τ ∈ fieldBandSet F (band 3), τ ∈ torsionBy (unitRing F) 6 := by
  obtain ⟨θ, hθ⟩ := h
  -- the limit along `25⁻ⁿ` exists at every element: at unit vectors by `tendsto_layer`, and limits add
  have hconv : ∀ x : unitRing F, ∃ t : UnitAddCircle,
      Filter.Tendsto (fun n : ℕ => θ (inv5 F ^ (2 * n) * x)) Filter.atTop (nhds t) := by
    refine unitRing_induction
      (p := fun x => ∃ t : UnitAddCircle, Filter.Tendsto (fun n : ℕ => θ (inv5 F ^ (2 * n) * x)) Filter.atTop (nhds t))
      ?_ ?_ ?_
    · refine ⟨0, ?_⟩
      simp only [mul_zero, map_zero]
      exact tendsto_const_nhds
    · rintro x y ⟨s, hs⟩ ⟨t, ht⟩
      refine ⟨s + t, ?_⟩
      simp only [mul_add, map_add]
      exact hs.add ht
    · intro u hu
      obtain ⟨t, -, ht⟩ := tendsto_layer hθ hu
      exact ⟨t, ht⟩
  choose τ hτ using hconv
  -- the limit is additive
  have hadd : ∀ x y, τ (x + y) = τ x + τ y := by
    intro x y
    refine tendsto_nhds_unique (hτ (x + y)) ?_
    simp only [mul_add, map_add]
    exact (hτ x).add (hτ y)
  -- at a unit vector it is `1/2`, `1/3` or `2/3`
  have hval : ∀ u ∈ unitSet F, τ u = ((1 / 2 : ℝ) : UnitAddCircle) ∨ τ u = ((1 / 3 : ℝ) : UnitAddCircle) ∨
      τ u = ((2 / 3 : ℝ) : UnitAddCircle) := by
    intro u hu
    obtain ⟨t, ht, htend⟩ := tendsto_layer hθ hu
    rw [tendsto_nhds_unique (hτ u) htend]
    exact ht
  refine ⟨AddMonoidHom.mk' τ hadd, fun u hu => ?_, ?_⟩
  · show τ u ∈ band 3
    rcases hval u hu with h | h | h
    · exact ⟨1 / 2, ⟨by norm_num, by norm_num⟩, h.symm⟩
    · exact ⟨1 / 3, ⟨by norm_num, by norm_num⟩, h.symm⟩
    · exact ⟨2 / 3, ⟨by norm_num, by norm_num⟩, h.symm⟩
  · rw [mem_torsionBy]
    ext x
    show 6 • τ x = 0
    refine unitRing_induction (p := fun x => 6 • τ x = 0) ?_ ?_ ?_ x
    · rw [show τ 0 = 0 from (AddMonoidHom.mk' τ hadd).map_zero, smul_zero]
    · intro x y hx hy
      rw [hadd, smul_add, hx, hy, add_zero]
    · intro u hu
      rcases hval u hu with h | h | h <;> rw [h, ← AddCircle.coe_nsmul, AddCircle.coe_eq_zero_iff]
      · exact ⟨3, by norm_num⟩
      · exact ⟨2, by norm_num⟩
      · exact ⟨4, by norm_num⟩

/-! ## §3 Two colours are a character with value `1/2` -/

/-- **A character killed by `N` is a `ZMod N`-valued functional** followed by `ZMod N ↪ ℝ/ℤ`, `1 ↦ 1/N`. (Stated once:
the two-colour criterion below reads it at 2, and the criterion module at 2 and at 3.) -/
theorem exists_zmod_hom_of_mem_torsionBy {M : Type*} [AddCommGroup M] {N : ℕ} [NeZero N] {θ : M →+ UnitAddCircle}
    (h : θ ∈ torsionBy M N) : ∃ l : M →+ ZMod N, ∀ x, θ x = ZMod.toAddCircle (l x) := by
  have hN : (N : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr (NeZero.ne N)
  have hval : ∀ x, ∃ j : ZMod N, θ x = ZMod.toAddCircle j := by
    intro x
    have hx : N • θ x = 0 := by
      have := congrArg (fun f : M →+ UnitAddCircle => f x) (mem_torsionBy.mp h)
      simpa using this
    obtain ⟨t, ht⟩ := QuotientAddGroup.mk_surjective (θ x)
    rw [← ht, ← AddCircle.coe_nsmul, AddCircle.coe_eq_zero_iff] at hx
    obtain ⟨k, hk⟩ := hx
    refine ⟨(k : ZMod N), ?_⟩
    rw [ZMod.toAddCircle_intCast, ← ht]
    congr 1
    rw [zsmul_one, nsmul_eq_mul] at hk
    field_simp
    linarith
  choose l hl using hval
  refine ⟨AddMonoidHom.mk' l fun x y => ?_, hl⟩
  apply ZMod.toAddCircle_injective N
  rw [map_add, ← hl, ← hl, ← hl, map_add]

/-- `band 2` is the one point `1/2`. -/
private theorem eq_half_of_mem_band_two {t : UnitAddCircle} (h : t ∈ band 2) : t = ((1 / 2 : ℝ) : UnitAddCircle) := by
  obtain ⟨x, ⟨hx1, hx2⟩, rfl⟩ := h
  have hx : x = 1 / 2 := by
    push_cast at hx1 hx2
    linarith
  rw [hx]

/-- `1/2 ≠ 0` in `ℝ/ℤ`. -/
private theorem half_ne_zero : ((1 / 2 : ℝ) : UnitAddCircle) ≠ 0 := by
  intro h
  obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp h
  rw [zsmul_one] at hn
  have h2 : (2 * n : ℤ) = 1 := by
    have : (2 : ℝ) * n = 1 := by linarith
    exact_mod_cast this
  omega

/-- **Two-colourings are the points of `Θ₂(R_F)`**: the plane over `F` is two-colourable iff some character of `ℤ[U_F]`
is `1/2` on every unit vector (`band 2 = {1/2}`). (`⟹`: on the component of `0` a two-colouring is `x ↦ c(x) − c(0)`,
additive because every step changes it. `⟸`: colour each coset of `ℤ[U_F]` in `F(i)` by the character.) Prior art:
`[Fischer1990]` Thm 1(ii), p. 183 — "`F^d` can be 2-colored iff there exists an additive map `v : C₀(F^d) → ℤ/(2)` so that
`v(ξ) = [1]` if `‖ξ‖ = 1`" — read with `ℤ/2 ⊂ ℝ/ℤ`; the kernel form is what is here. -/
theorem colorable_two_iff_fieldBandSet_two_nonempty (F : Subfield ℝ) :
    ((unitDistance ℂ).induce (planeOver F)).Colorable 2 ↔ (fieldBandSet F (band 2)).Nonempty := by
  constructor
  · rintro ⟨C⟩
    -- the points of the ring are points of the plane; `f x = C x − C 0`, read in `ZMod 2`
    have hsub : ∀ x : unitRing F, (x : ℂ) ∈ planeOver F := fun x =>
      UnitRing.unitRingOver_le_planeOverSubring F x.2
    let c : unitRing F → ZMod 2 := fun x => C ⟨x, hsub x⟩
    let f : unitRing F → ZMod 2 := fun x => c x - c 0
    have hflip : ∀ p q : ZMod 2, p ≠ q → p = q + 1 := by decide
    -- a unit step changes the colour
    have hstep : ∀ x u : unitRing F, u ∈ unitSet F → f (x + u) = f x + 1 := by
      intro x u hu
      have hadj : ((unitDistance ℂ).induce (planeOver F)).Adj ⟨((x + u : unitRing F) : ℂ), hsub _⟩ ⟨x, hsub x⟩ := by
        show dist ((x + u : unitRing F) : ℂ) (x : ℂ) = 1
        rw [Subring.coe_add, dist_eq_norm, add_sub_cancel_left]
        exact hu.2
      have hc : c (x + u) = c x + 1 := hflip _ _ (C.valid hadj)
      show c (x + u) - c 0 = c x - c 0 + 1
      rw [hc]
      ring
    have hf0 : f 0 = 0 := sub_self _
    have hfu : ∀ u ∈ unitSet F, f u = 1 := fun u hu => by
      have := hstep 0 u hu
      rwa [zero_add, hf0, zero_add] at this
    -- the invariant `∀ x, f (x + y) = f x + f y` holds at unit vectors and passes to sums
    have hadd : ∀ y x : unitRing F, f (x + y) = f x + f y := by
      refine unitRing_induction (p := fun y => ∀ x, f (x + y) = f x + f y) ?_ ?_ ?_
      · intro x
        rw [add_zero, hf0, add_zero]
      · intro y z hy hz x
        rw [← add_assoc, hz (x + y), hy x, hz y, add_assoc]
      · intro u hu x
        rw [hstep x u hu, hfu u hu]
    let l : unitRing F →+ ZMod 2 := AddMonoidHom.mk' f fun x y => hadd y x
    refine ⟨ZMod.toAddCircle.comp l, fun u hu => ?_⟩
    show ZMod.toAddCircle (f u) ∈ band 2
    rw [hfu u hu]
    have h1 : ZMod.toAddCircle (1 : ZMod 2) = ((1 / 2 : ℝ) : UnitAddCircle) := by
      have := ZMod.toAddCircle_natCast (N := 2) 1
      simpa using this
    exact ⟨1 / 2, ⟨by norm_num, by norm_num⟩, h1.symm⟩
  · rintro ⟨θ, hθ⟩
    have hhalf : ∀ u ∈ unitSet F, θ u = ((1 / 2 : ℝ) : UnitAddCircle) := fun u hu =>
      eq_half_of_mem_band_two (hθ u hu)
    -- `θ` is killed by 2, so it is a `ZMod 2`-valued functional, non-zero at every unit vector
    have h2 : θ ∈ torsionBy (unitRing F) 2 := by
      rw [mem_torsionBy]
      ext x
      show 2 • θ x = 0
      refine unitRing_induction (p := fun x => 2 • θ x = 0) ?_ ?_ ?_ x
      · rw [map_zero, smul_zero]
      · intro x y hx hy
        rw [map_add, smul_add, hx, hy, add_zero]
      · intro u hu
        rw [hhalf u hu, ← AddCircle.coe_nsmul, show (2 • (1 / 2 : ℝ)) = 1 by norm_num]
        exact AddCircle.coe_period 1
    obtain ⟨l, hl⟩ := exists_zmod_hom_of_mem_torsionBy h2
    have hl1 : ∀ u ∈ unitSet F, l u ≠ 0 := fun u hu h0 =>
      half_ne_zero (by rw [← hhalf u hu, hl, h0, map_zero])
    -- the residue colouring of `ResidueColouring`, at `G = ZMod 2`
    let ψ : (unitRing F).toAddSubgroup →+ ZMod 2 := l
    have hmem : ∀ ⦃v w : planeOver F⦄, ((unitDistance ℂ).induce (planeOver F)).Adj v w →
        (v : ℂ) - w ∈ unitVectors F := fun v w hvw =>
      ⟨(UnitRing.planeOverSubfield F).sub_mem v.2 w.2, by rw [← dist_eq_norm]; exact hvw⟩
    have := colorable_of_residue (G := ZMod 2) ((unitDistance ℂ).induce (planeOver F)) (fun v => (v : ℂ)) ψ
      (fun v w hvw => unitVectors_subset_unitRing F (hmem hvw)) fun v w hvw => by
        rw [cosetResidue_apply_of_mem ψ (unitVectors_subset_unitRing F (hmem hvw))]
        exact hl1 ⟨_, unitVectors_subset_unitRing F (hmem hvw)⟩ (hmem hvw)
    rwa [ZMod.card] at this

/-- A point of `Θ₃ ∩ T₆` is in `Θ₂` once `1/3 ∈ ℤ[U_F]`: `τ(u) = 3·τ(u/3)` is killed by 2 and lies in `[1/3, 2/3]`. -/
theorem mem_fieldBandSet_two_of_inv_three_mem (h3 : (3 : ℂ)⁻¹ ∈ unitRing F) {τ : unitRing F →+ UnitAddCircle}
    (hτ : τ ∈ fieldBandSet F (band 3)) (h6 : τ ∈ torsionBy (unitRing F) 6) : τ ∈ fieldBandSet F (band 2) := by
  intro u hu
  -- `u = 3 • (3⁻¹ u)`, so `2 • τ u = 6 • τ (3⁻¹ u) = 0`
  have hu3 : u = 3 • ((⟨(3 : ℂ)⁻¹, h3⟩ : unitRing F) * u) := by
    apply Subtype.ext
    rw [nsmul_eq_mul, Subring.coe_mul, Subring.coe_mul, Subring.coe_natCast, Nat.cast_ofNat, ← mul_assoc,
      mul_inv_cancel₀ (by norm_num), one_mul]
  have h2 : 2 • τ u = 0 := by
    have h6' : 6 • τ ((⟨(3 : ℂ)⁻¹, h3⟩ : unitRing F) * u) = 0 := by
      have := congrArg (fun f : unitRing F →+ UnitAddCircle => f ((⟨(3 : ℂ)⁻¹, h3⟩ : unitRing F) * u))
        (mem_torsionBy.mp h6)
      simpa using this
    conv_lhs => rw [hu3]
    rw [map_nsmul, smul_smul]
    exact h6'
  -- `τ u = ↑t` with `t ∈ [1/3, 2/3]` and `2t ∈ ℤ`, so `t = 1/2`
  obtain ⟨t, ⟨ht1, ht2⟩, ht⟩ := hτ u hu
  have ht' : τ u = (t : UnitAddCircle) := ht.symm
  rw [ht', ← AddCircle.coe_nsmul, AddCircle.coe_eq_zero_iff] at h2
  obtain ⟨n, hn⟩ := h2
  rw [zsmul_one, nsmul_eq_mul] at hn
  push_cast at ht1 ht2 hn
  have hn1 : n = 1 := by
    have h0 : (0 : ℝ) < n := by linarith
    have h2 : (n : ℝ) < 2 := by linarith
    have h0' : 0 < n := by exact_mod_cast h0
    have h2' : n < 2 := by exact_mod_cast h2
    omega
  rw [hn1, Int.cast_one] at hn
  refine ⟨1 / 2, ⟨by norm_num, by norm_num⟩, ?_⟩
  show ((1 / 2 : ℝ) : UnitAddCircle) = τ u
  rw [ht']
  congr 1
  linarith

/-! ## §4 Clause (c) -/

/-- **Clause (c), strongest form (FS81-T4, T5).** If `1/3` is an integer combination of unit vectors of `F²`, every
three-colourable plane over `F` is two-colourable. -/
theorem colorable_two_of_inv_three_mem (h3 : (3 : ℂ)⁻¹ ∈ unitRing F)
    (h : ((unitDistance ℂ).induce (planeOver F)).Colorable 3) : ((unitDistance ℂ).induce (planeOver F)).Colorable 2 := by
  obtain ⟨τ, hτ, h6⟩ :=
    exists_torsion_mem_fieldBandSet F (ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable F h)
  exact (colorable_two_iff_fieldBandSet_two_nonempty F).mpr ⟨τ, mem_fieldBandSet_two_of_inv_three_mem h3 hτ h6⟩

/-- **Clause (c), as claimed**: `1/3 ∈ ℤ[U_F]` and `F²` not bipartite give `χ(F²) ≥ 4`. This project's (FS81-T5,
`[hand, two independent derivations]` before this module); not found in print. For **additive** colourings the
obstruction is `[Fischer1990]` §1 and Thm 10(ii). -/
theorem four_le_chromaticNumber_planeOver_of_inv_three_mem (h3 : (3 : ℂ)⁻¹ ∈ unitRing F)
    (hnb : ¬ ((unitDistance ℂ).induce (planeOver F)).Colorable 2) :
    4 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  have h : ((4 : ℕ) : ℕ∞) ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
    rw [SimpleGraph.le_chromaticNumber_iff_colorable]
    intro k hk
    by_contra hlt
    exact hnb (colorable_two_of_inv_three_mem h3 (hk.mono (by omega)))
  exact_mod_cast h

/-- Where `1/3 ∈ ℤ[U_F]` the chromatic number of the plane over `F` is never `3`. -/
theorem chromaticNumber_planeOver_ne_three_of_inv_three_mem (h3 : (3 : ℂ)⁻¹ ∈ unitRing F) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≠ 3 := by
  intro h
  have h3c : ((unitDistance ℂ).induce (planeOver F)).Colorable 3 :=
    SimpleGraph.chromaticNumber_le_iff_colorable.mp (by rw [h]; rfl)
  have h2 := (colorable_two_of_inv_three_mem h3 h3c).chromaticNumber_le
  rw [h] at h2
  exact absurd (by exact_mod_cast h2 : (3 : ℕ) ≤ 2) (by norm_num)

/-! ## §5 Clause (a): the fields holding `√d` -/

/-- **`1/n = 2 − v − v̄`** with `v`, `v̄` unit vectors of `F²`, for `d + 1 = 4n` and `F ∋ √d`:
`v = ((2n − 1) + i√d)/(2n)` (`[Fischer1990]`'s vector: Thm 8's proof, p. 190, and Thm 10(ii)'s, p. 194). -/
private theorem exists_unitVectors_inv_natCast {d n : ℕ} (hd : d + 1 = 4 * n) (hF : Real.sqrt d ∈ F) :
    ∃ v v' : ℂ, v ∈ unitVectors F ∧ v' ∈ unitVectors F ∧ (n : ℂ)⁻¹ = 2 - v - v' := by
  have hn : (n : ℝ) ≠ 0 := by
    have : n ≠ 0 := by omega
    exact_mod_cast this
  have hdR : (d : ℝ) = 4 * n - 1 := by
    have : ((d + 1 : ℕ) : ℝ) = ((4 * n : ℕ) : ℝ) := by rw [hd]
    push_cast at this
    linarith
  have h2n : (2 * n : ℝ) ∈ F := F.mul_mem (ofNat_mem F 2) (natCast_mem F n)
  have hxF : (2 * n - 1 : ℝ) / (2 * n) ∈ F := F.div_mem (F.sub_mem h2n F.one_mem) h2n
  have hyF : Real.sqrt d / (2 * n) ∈ F := F.div_mem hF h2n
  have hxy : ((2 * n - 1 : ℝ) / (2 * n)) ^ 2 + (Real.sqrt d / (2 * n)) ^ 2 = 1 := by
    rw [div_pow, div_pow, Real.sq_sqrt (Nat.cast_nonneg d), hdR]
    field_simp
    ring
  refine ⟨⟨(2 * n - 1 : ℝ) / (2 * n), Real.sqrt d / (2 * n)⟩, ⟨(2 * n - 1 : ℝ) / (2 * n), -(Real.sqrt d / (2 * n))⟩,
    ⟨⟨hxF, hyF⟩, ?_⟩, ⟨⟨hxF, F.neg_mem hyF⟩, ?_⟩, ?_⟩
  · rw [Complex.norm_eq_sqrt_sq_add_sq, hxy, Real.sqrt_one]
  · rw [Complex.norm_eq_sqrt_sq_add_sq]
    show Real.sqrt (((2 * n - 1 : ℝ) / (2 * n)) ^ 2 + (-(Real.sqrt d / (2 * n))) ^ 2) = 1
    rw [neg_sq, hxy, Real.sqrt_one]
  · apply Complex.ext
    · simp only [Complex.inv_re, Complex.natCast_re, Complex.normSq_natCast, div_self_mul_self', Complex.sub_re,
        Complex.re_ofNat]
      field_simp
      ring
    · simp

/-- **`1/n = 2 − v − v̄`** for `d + 1 = 4n` and `v = ((2n − 1) + i√d)/(2n)`, a unit vector of every `F ∋ √d`
(`[Fischer1990]`'s vector: Thm 8's proof, p. 190, and Thm 10(ii)'s, p. 194). -/
theorem inv_natCast_mem_unitRing_of_sqrt_mem {d n : ℕ} (hd : d + 1 = 4 * n) (hF : Real.sqrt d ∈ F) :
    (n : ℂ)⁻¹ ∈ unitRing F := by
  obtain ⟨v, v', hv, hv', h⟩ := exists_unitVectors_inv_natCast hd hF
  rw [h]
  exact sub_mem (sub_mem (ofNat_mem _ 2) (unitVectors_subset_unitRing F hv)) (unitVectors_subset_unitRing F hv')

/-- `1/3 ∈ ℤ[U_F]` for `F ∋ √d`, `d ≡ 11 (mod 12)`: `3 ∣ n = (d + 1)/4`. -/
theorem inv_three_mem_unitRing_of_sqrt_mem {d : ℕ} (hd : d % 12 = 11) (hF : Real.sqrt d ∈ F) :
    (3 : ℂ)⁻¹ ∈ unitRing F := by
  obtain ⟨k, hk0, hk⟩ : ∃ k : ℕ, k ≠ 0 ∧ d + 1 = 4 * (3 * k) := ⟨(d + 1) / 12, by omega, by omega⟩
  have h := inv_natCast_mem_unitRing_of_sqrt_mem hk hF
  have hk' : (k : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hk0
  have h3 : (3 : ℂ)⁻¹ = (k : ℂ) * ((3 * k : ℕ) : ℂ)⁻¹ := by
    push_cast
    field_simp
  rw [h3]
  exact mul_mem (natCast_mem _ k) h

/-- **No two-colouring for `F ∋ √d`, `d ≡ 3 (mod 4)`**: `1 = 2n − nv − nv̄` is a sum of `4n` unit vectors, so a character
equal to `1/2` on unit vectors would be `0` at the unit vector `1`. Prior art for squarefree `d` and the quadratic field:
the "only if" of `[Fischer1990]` Thm 8 (pp. 189–190), by this vector and this relation (there as a root of
`n·x² − (2n − 1)·x + n` with an odd coefficient sum, his Thm 7). What is added here is the class: every subfield of `ℝ`
holding `√d`, every natural `d ≡ 3 (mod 4)`. -/
theorem not_colorable_two_of_sqrt_mem {d : ℕ} (hd : d % 4 = 3) (hF : Real.sqrt d ∈ F) :
    ¬ ((unitDistance ℂ).induce (planeOver F)).Colorable 2 := by
  intro hcol
  obtain ⟨θ, hθ⟩ := (colorable_two_iff_fieldBandSet_two_nonempty F).mp hcol
  have hhalf : ∀ u ∈ unitSet F, θ u = ((1 / 2 : ℝ) : UnitAddCircle) := fun u hu =>
    eq_half_of_mem_band_two (hθ u hu)
  obtain ⟨n, hn0, hn⟩ : ∃ n : ℕ, n ≠ 0 ∧ d + 1 = 4 * n := ⟨(d + 1) / 4, by omega, by omega⟩
  obtain ⟨v, v', hv, hv', h⟩ := exists_unitVectors_inv_natCast hn hF
  have h1U : (1 : unitRing F) ∈ unitSet F := ⟨(UnitRing.planeOverSubfield F).one_mem, by simp⟩
  -- `1 = n • (1 + 1 − v − v̄)`, and `θ` of the bracket is `1/2 + 1/2 − 1/2 − 1/2 = 0`
  have hone : (1 : unitRing F) = n • (1 + 1 - (⟨v, unitVectors_subset_unitRing F hv⟩ : unitRing F) -
      (⟨v', unitVectors_subset_unitRing F hv'⟩ : unitRing F)) := by
    apply Subtype.ext
    have hn' : (n : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hn0
    have h2 : (1 : ℂ) + 1 - v - v' = (n : ℂ)⁻¹ := by rw [h]; ring
    simp [h2, hn']
  have h0 : θ 1 = 0 := by
    conv_lhs => rw [hone]
    rw [map_nsmul, map_sub, map_sub, map_add, hhalf 1 h1U, hhalf _ hv, hhalf _ hv', add_sub_cancel_right, sub_self,
      smul_zero]
  rw [hhalf 1 h1U] at h0
  exact half_ne_zero h0

/-- `χ(F²) ≥ 3` for every subfield `F ∋ √d`, `d ≡ 3 (mod 4)` (for `ℚ(√d)`, `d` squarefree: `[Fischer1990]` Thm 8,
p. 189). -/
theorem three_le_chromaticNumber_planeOver_of_sqrt_mem {d : ℕ} (hd : d % 4 = 3) (hF : Real.sqrt d ∈ F) :
    3 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  have h : ((3 : ℕ) : ℕ∞) ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
    rw [SimpleGraph.le_chromaticNumber_iff_colorable]
    intro k hk
    by_contra hlt
    exact not_colorable_two_of_sqrt_mem hd hF (hk.mono (by omega))
  exact_mod_cast h

/-- **Clause (a), at its proof's level**: every subfield of `ℝ` holding `√d` for a natural `d ≡ 11 (mod 12)` has a plane
needing four colours. No squarefreeness, no finite graph. The lower bound is this project's; the unit vector and
`1/3 ∈ ℤ[U]` are `[Fischer1990]` Thm 10(ii) and Ex. 4 (pp. 193–194; his at `N ≡ −1 (mod 24)`), and `[Johnson2000]`
p. 176 poses the family as open. -/
theorem four_le_chromaticNumber_planeOver_of_sqrt_mem {d : ℕ} (hd : d % 12 = 11) (hF : Real.sqrt d ∈ F) :
    4 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  four_le_chromaticNumber_planeOver_of_inv_three_mem (inv_three_mem_unitRing_of_sqrt_mem hd hF)
    (not_colorable_two_of_sqrt_mem (by omega) hF)

/-- **Clause (a), as claimed**: `χ(ℚ(√d)²) ≥ 4` for `d ≡ 11 (mod 12)` (the claim's "squarefree" is not used). This
project's lower bound; every upper bound for these fields is prior art (four colours at `d ≡ 3 (mod 8)`:
`[Fischer1990]` Thm 10(i), p. 193, restated in `[Johnson2000]` p. 176). -/
theorem four_le_chromaticNumber_planeOver_fieldOfRadicands {d : ℕ} (hd : d % 12 = 11) :
    4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {d}))).chromaticNumber :=
  four_le_chromaticNumber_planeOver_of_sqrt_mem hd (sqrt_mem_fieldOfRadicands (Set.mem_singleton d))

/-! ## The two statements in character form (named by FS131-IT1, stated by FS131-KJ1) -/

/-- **FS81-T4 in the ledger's own words** (`LEDGER.md` row 82: "`1/3 ∈ ℤ[U_F]` and `Θ₃(F) ≠ ∅` make `F²` bipartite"):
with `1/3 ∈ ℤ[U_F]`, a character of `ℤ[U_F]` with values in `[1/3, 2/3]` on the unit vectors gives a two-colouring of the
plane. It reads this module's leaves only — no colouring, so not `ThreeColourCharacter`'s headline —, and
`colorable_two_of_inv_three_mem` is this after that headline. Every subfield `F ⊆ ℝ`. -/
theorem colorable_two_of_fieldBandSet_three_nonempty (h3 : (3 : ℂ)⁻¹ ∈ unitRing F)
    (h : (fieldBandSet F (band 3)).Nonempty) : ((unitDistance ℂ).induce (planeOver F)).Colorable 2 := by
  obtain ⟨τ, hτ, h6⟩ := exists_torsion_mem_fieldBandSet F h
  exact (colorable_two_iff_fieldBandSet_two_nonempty F).mpr ⟨τ, mem_fieldBandSet_two_of_inv_three_mem h3 hτ h6⟩

/-- **Clause (a) in character form: `Θ₃(R_F) = ∅`** for every subfield `F ∋ √d`, `d ≡ 11 (mod 12)` — no additive map
`ℤ[U_F] → ℝ/ℤ` puts every unit vector in `[1/3, 2/3]`. Stronger in form than `four_le_chromaticNumber_planeOver_of_sqrt_mem`
(which is this with `ThreeColourCharacter`'s headline): it excludes the characters themselves, with no colouring named.
This project's; for additive three-colourings (the characters killed by 3) of `ℚ(√N)²`, `N ≡ −1 (mod 24)` squarefree,
it is `[Fischer1990]` Thm 10(ii). -/
theorem fieldBandSet_three_eq_empty_of_sqrt_mem {d : ℕ} (hd : d % 12 = 11) (hF : Real.sqrt d ∈ F) :
    fieldBandSet F (band 3) = ∅ :=
  Set.not_nonempty_iff_eq_empty.mp fun h =>
    not_colorable_two_of_sqrt_mem (by omega) hF
      (colorable_two_of_fieldBandSet_three_nonempty (inv_three_mem_unitRing_of_sqrt_mem hd hF) h)

/-! ## Spec -/

-- `band 2` is the single point `1/2`: the value of a two-colouring's character on a unit vector.
example : ((1 / 2 : ℝ) : UnitAddCircle) ∈ band 2 := ⟨1 / 2, ⟨by norm_num, by norm_num⟩, rfl⟩

-- `layer_step`'s hypotheses at the rotation of a point of the box, and at a corner step (`z' = i z`).
example : ∃ n : ℤ, 2 * ((3 * (1 / 12 : ℝ) + 4 * 0) / 5) - (-4 * (1 / 12) + 3 * 0) / 5 - 2 * (1 / 12) - 0 = n :=
  ⟨0, by norm_num⟩
example : ∃ n : ℤ, 2 * (1 / 6 : ℝ) - (-(1 / 6)) - 2 * (-(1 / 6)) - (-(1 / 6)) = n := ⟨1, by norm_num⟩

-- The headline at `d = 11`, `23`, `35` (the last not a prime: `35 = 5·7`), and the lower end `3` at `d = 3`, `7`.
example : 4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber :=
  four_le_chromaticNumber_planeOver_fieldOfRadicands (by norm_num)
example : 4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {35}))).chromaticNumber :=
  four_le_chromaticNumber_planeOver_fieldOfRadicands (by norm_num)
example : 3 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {7}))).chromaticNumber :=
  three_le_chromaticNumber_planeOver_of_sqrt_mem (d := 7) (by norm_num) (sqrt_mem_fieldOfRadicands (Set.mem_singleton 7))

end HadwigerNelson.TorsionExtraction
