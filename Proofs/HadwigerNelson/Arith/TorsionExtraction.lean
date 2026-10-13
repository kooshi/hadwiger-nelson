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

**Whose this is** (`LEDGER.md` § The claim list, row 82; `plans/FS81-derivation.md` T4, T5). The obstruction
"`1/k ∈ ℤ[U]` ⟹ no **additive** `k`-colouring" is `[Fischer1990]` §1 and Thm 10(ii); the unit vector `v` and `1/3 ∈ ℤ[U]`
at `N ≡ −1 (mod 24)` are `[Fischer1990]` Thm 10(ii) and Ex. 4, and `[Johnson2000]` p. 176 poses the family as open. The
passage from additive to **all** three-colourings — the lower bound at four — is this project's `[hand, two independent
derivations]`; not found in print. The route through `layer_step` (no computed cell list) is the kernel planner's.

**Inhabitants.** `F = ℚ(√11)`: `√11 ∈ F`, `1/3 = 2 − v − v̄` with `v = (5 + i√11)/6`, and the plane is not two-colourable;
every hypothesis of the headlines holds there (`four_le_chromaticNumber_planeOver_fieldOfRadicands` at `d = 11`, the value
row 73 holds by a 204-point witness). `Θ₃(R_F) ≠ ∅` is inhabited at `F = ℚ(√3)` (`[Fischer1990]` Thm 9), which no
declaration here exhibits; `Θ₂` at `F = ℚ` by `colorable_two_iff_fieldBandSet_two_nonempty` and Woodall's two-colouring.
-/

namespace HadwigerNelson.TorsionExtraction

open HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain HadwigerNelson.SquareClass SimpleGraph

/-! ## §1 The rational layer: two integer relations on the box (FS81-T3, without the cell list) -/

/-- **One step of a layer.** Four reals in `[−1/6, 1/6]` whose two relation forms are integers: either the step is the
rotation by `w̄ = (3 − 4i)/5`, or all four are at absolute value `1/6`. (Each form is bounded by `6·(1/6) = 1`.) -/
theorem layer_step {a b a' b' : ℝ} (ha : |a| ≤ 1 / 6) (hb : |b| ≤ 1 / 6) (ha' : |a'| ≤ 1 / 6) (hb' : |b'| ≤ 1 / 6)
    (h1 : ∃ n : ℤ, 2 * a' - b' - 2 * a - b = n) (h2 : ∃ n : ℤ, a' + 2 * b' + a - 2 * b = n) :
    (a' = (3 * a + 4 * b) / 5 ∧ b' = (-4 * a + 3 * b) / 5) ∨
      (|a| = 1 / 6 ∧ |b| = 1 / 6 ∧ |a'| = 1 / 6 ∧ |b'| = 1 / 6) := by
  sorry

/-- **The layer dichotomy** (FS81-T3 in sequence form): a two-sided sequence in the box whose consecutive terms satisfy
the two relations is a rotation orbit, or sits at corners throughout. -/
theorem layer_dichotomy {a b : ℤ → ℝ} (ha : ∀ m, |a m| ≤ 1 / 6) (hb : ∀ m, |b m| ≤ 1 / 6)
    (h1 : ∀ m, ∃ n : ℤ, 2 * a (m + 1) - b (m + 1) - 2 * a m - b m = n)
    (h2 : ∀ m, ∃ n : ℤ, a (m + 1) + 2 * b (m + 1) + a m - 2 * b m = n) :
    (∀ m, a (m + 1) = (3 * a m + 4 * b m) / 5 ∧ b (m + 1) = (-4 * a m + 3 * b m) / 5) ∨
      (∀ m, |a m| = 1 / 6 ∧ |b m| = 1 / 6) := by
  sorry

/-! ## §2 The limit along `25⁻ⁿ`, and the torsion character (FS81-T4, FS91-J02-L1) -/

variable {F : Subfield ℝ}

/-- `1/5 = w + w⁻¹ − 1` as an element of `ℤ[U_F]`. -/
noncomputable def inv5 (F : Subfield ℝ) : unitRing F := ⟨(5 : ℂ)⁻¹, unitRing_mono bot_le inv_five_mem_Qring⟩

@[simp] theorem coe_inv5 (F : Subfield ℝ) : ((inv5 F : unitRing F) : ℂ) = (5 : ℂ)⁻¹ := rfl

/-- **The limit on one layer.** For `θ ∈ Θ₃(R_F)` and a unit vector `b`, `θ(25⁻ⁿ b)` converges, to `1/2` (a parity-type
layer) or to `1/3` or `2/3` (an order-3 layer, on which the sequence is constant). -/
theorem tendsto_layer {θ : unitRing F →+ UnitAddCircle} (hθ : θ ∈ fieldBandSet F (band 3)) {b : unitRing F}
    (hb : b ∈ unitSet F) :
    ∃ t : UnitAddCircle, (t = ((1 / 2 : ℝ) : UnitAddCircle) ∨ t = ((1 / 3 : ℝ) : UnitAddCircle) ∨
        t = ((2 / 3 : ℝ) : UnitAddCircle)) ∧
      Filter.Tendsto (fun n : ℕ => θ (inv5 F ^ (2 * n) * b)) Filter.atTop (nhds t) := by
  sorry

/-- **NF4-S7, torsion extraction (FS91-J02-L1), every subfield `F ⊆ ℝ`**: `Θ₃(R_F) ≠ ∅ ⟹ Θ₃(R_F) ∩ T₆ ≠ ∅`. -/
theorem exists_torsion_mem_fieldBandSet (F : Subfield ℝ) (h : (fieldBandSet F (band 3)).Nonempty) :
    ∃ τ ∈ fieldBandSet F (band 3), τ ∈ torsionBy (unitRing F) 6 := by
  sorry

/-! ## §3 Two colours are a character with value `1/2` -/

/-- **A character killed by `N` is a `ZMod N`-valued functional** followed by `ZMod N ↪ ℝ/ℤ`, `1 ↦ 1/N`. (Stated once:
the two-colour criterion below reads it at 2, and the criterion module at 2 and at 3.) -/
theorem exists_zmod_hom_of_mem_torsionBy {M : Type*} [AddCommGroup M] {N : ℕ} [NeZero N] {θ : M →+ UnitAddCircle}
    (h : θ ∈ torsionBy M N) : ∃ l : M →+ ZMod N, ∀ x, θ x = ZMod.toAddCircle (l x) := by
  sorry

/-- **Two-colourings are the points of `Θ₂(R_F)`**: the plane over `F` is two-colourable iff some character of `ℤ[U_F]`
is `1/2` on every unit vector (`band 2 = {1/2}`). (`⟹`: on the component of `0` a two-colouring is `x ↦ c(x) − c(0)`,
additive because every step changes it. `⟸`: colour each coset of `ℤ[U_F]` in `F(i)` by the character.) -/
theorem colorable_two_iff_fieldBandSet_two_nonempty (F : Subfield ℝ) :
    ((unitDistance ℂ).induce (planeOver F)).Colorable 2 ↔ (fieldBandSet F (band 2)).Nonempty := by
  sorry

/-- A point of `Θ₃ ∩ T₆` is in `Θ₂` once `1/3 ∈ ℤ[U_F]`: `τ(u) = 3·τ(u/3)` is killed by 2 and lies in `[1/3, 2/3]`. -/
theorem mem_fieldBandSet_two_of_inv_three_mem (h3 : (3 : ℂ)⁻¹ ∈ unitRing F) {τ : unitRing F →+ UnitAddCircle}
    (hτ : τ ∈ fieldBandSet F (band 3)) (h6 : τ ∈ torsionBy (unitRing F) 6) : τ ∈ fieldBandSet F (band 2) := by
  sorry

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

/-- **`1/n = 2 − v − v̄`** for `d + 1 = 4n` and `v = ((2n − 1) + i√d)/(2n)`, a unit vector of every `F ∋ √d`
(`[Fischer1990]` Thm 10(ii)'s vector). -/
theorem inv_natCast_mem_unitRing_of_sqrt_mem {d n : ℕ} (hd : d + 1 = 4 * n) (hF : Real.sqrt d ∈ F) :
    (n : ℂ)⁻¹ ∈ unitRing F := by
  sorry

/-- `1/3 ∈ ℤ[U_F]` for `F ∋ √d`, `d ≡ 11 (mod 12)`: `3 ∣ n = (d + 1)/4`. -/
theorem inv_three_mem_unitRing_of_sqrt_mem {d : ℕ} (hd : d % 12 = 11) (hF : Real.sqrt d ∈ F) :
    (3 : ℂ)⁻¹ ∈ unitRing F := by
  sorry

/-- **No two-colouring for `F ∋ √d`, `d ≡ 3 (mod 4)`**: `1 = 2n − nv − nv̄` is a sum of `4n` unit vectors, so a character
equal to `1/2` on unit vectors would be `0` at the unit vector `1`. (The values 2 and 3 of the table are `[Fischer1990]`'s
and `[Johnson2000]`'s; this is their lower end at 3.) -/
theorem not_colorable_two_of_sqrt_mem {d : ℕ} (hd : d % 4 = 3) (hF : Real.sqrt d ∈ F) :
    ¬ ((unitDistance ℂ).induce (planeOver F)).Colorable 2 := by
  sorry

/-- `χ(F²) ≥ 3` for every subfield `F ∋ √d`, `d ≡ 3 (mod 4)`. -/
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
`1/3 ∈ ℤ[U]` are `[Fischer1990]` Thm 10(ii) and Ex. 4, and `[Johnson2000]` p. 176 poses the family as open. -/
theorem four_le_chromaticNumber_planeOver_of_sqrt_mem {d : ℕ} (hd : d % 12 = 11) (hF : Real.sqrt d ∈ F) :
    4 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  four_le_chromaticNumber_planeOver_of_inv_three_mem (inv_three_mem_unitRing_of_sqrt_mem hd hF)
    (not_colorable_two_of_sqrt_mem (by omega) hF)

/-- **Clause (a), as claimed**: `χ(ℚ(√d)²) ≥ 4` for `d ≡ 11 (mod 12)` (the claim's "squarefree" is not used). This
project's lower bound; every upper bound for these fields is prior art (`[Fischer1990]`, `[Johnson2000]`). -/
theorem four_le_chromaticNumber_planeOver_fieldOfRadicands {d : ℕ} (hd : d % 12 = 11) :
    4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {d}))).chromaticNumber :=
  four_le_chromaticNumber_planeOver_of_sqrt_mem hd (sqrt_mem_fieldOfRadicands (Set.mem_singleton d))

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
