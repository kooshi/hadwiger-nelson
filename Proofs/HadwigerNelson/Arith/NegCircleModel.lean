import Proofs.HadwigerNelson.Arith.SpectralInputs

/-!
# A model of `Interface.NegCircle`: the point mass at the parity character over `ℚ` (FS-131 wave 10, second planning pass)

**Read aloud, against the informal claim.** `SpectralInputs.sp_if` assumes `I.NegCircle`: a rotation-invariant probability
`λ` on the characters with `∫ Re χ(1) dλ < 0`, carried by a set translation by which does not leave `E`ᶜ. FS131-I10A found
it had no model in the kernel (so `sp_if` is an open item under the gate's inhabitant rule) and priced the derivation's own
`λ` — the archimedean circle, `J₀(j₁,₁) < 0` — at a job's stage. **The cheaper model, checked on paper here:** over
`F = ℚ` every unit vector `u = (a + bi)/c` reduces to `1` at the prime `1 + i` of `ℚ(i)` (`u·ū = 1` in a residue field of
two elements), so `r ↦ (−1)^(r mod (1 + i))` is a character `χ₀` of `R = ℤ[U_ℚ]` fixed by every rotation, with
`χ₀(1) = −1`: the point mass at `χ₀` is rotation-invariant with `∫ Re χ(1) = −1`, and at `Interface.trivial` (`E = ∅`) the
carrier clause holds with `S` everything. (`χ₀` is Woodall's two-colouring of `ℚ²`.)

Two leaves: `exists_parityHom` (the reduction map) and `negCircle_trivial_bot` (the model).

**Proved (FS131-I10F), by a route with no valuation subring.** The plan took the reduction map from
`UnitRing.normOne_subset_valuationSubring` at the `(1 + i)`-adic valuation subring of `ℚ(i)`, which the library does not
hold and would have had to be built with its residue field. Instead: every element of `ℤ[U_ℚ]` is `(a + bi)/c` with
`a, b, c` integers and `c` odd (`exists_odd_rep_of_mem_unitRing`, by induction on the ring's closure; for a unit
vector take the least common denominator — if it were even, `a² + b² = c²` would make `a` and `b` even,
`exists_odd_rep_of_unitVector`); `a + b mod 2` does not depend on the representation (`parity_rep_unique`), and is a
ring homomorphism because `(a + bi)(a′ + b′i)` has parity `(a + b)(a′ + b′) − 2bb′`; on a unit vector
`a + b ≡ a² + b² = c² ≡ 1`. The model is then the point mass at `ψ ∘ π`, `ψ` the character `1 ↦ −1` of `ZMod 2`
(`exists_signChar`).

**The inhabitant of `sp_if`.** `sp_if_hypotheses_trivial_bot`: given Herglotz–Bochner (the named classical hypothesis,
which has no kernel model), every other hypothesis of `sp_if` holds at once at `F = ℚ`, `I = Interface.trivial` —
`MulStable` (empty `E`), `NegCircle` (`negCircle_trivial_bot`), and `ν` the point mass at the trivial character, which is
finite, rotation-invariant, `E`-null and no multiple of Haar measure. The spec example applies `sp_if` to it.
-/

namespace HadwigerNelson.SpectralInputs

open MeasureTheory SpectralChain

/-! ## The parity map: every element of `ℤ[U_ℚ]` is `(a + bi)/c` with `c` odd -/

/-- A sum of two integer squares divisible by 4 has both terms even. -/
theorem two_dvd_of_sq_add_sq_eq_four_mul {a b n : ℤ} (h : a ^ 2 + b ^ 2 = 4 * n) : 2 ∣ a ∧ 2 ∣ b := by
  obtain ⟨k, rfl | rfl⟩ := Int.even_or_odd' a <;> obtain ⟨m, rfl | rfl⟩ := Int.even_or_odd' b
  · exact ⟨⟨k, rfl⟩, ⟨m, rfl⟩⟩
  · exfalso
    ring_nf at h
    omega
  · exfalso
    ring_nf at h
    omega
  · exfalso
    ring_nf at h
    omega

/-- The real and imaginary parts of a representation `z·c = a + bi`. -/
theorem re_im_of_mul_intCast_eq {z : ℂ} {a b c : ℤ} (h : z * (c : ℂ) = (a : ℂ) + (b : ℂ) * Complex.I) :
    z.re * c = a ∧ z.im * c = b := by
  have hre := congrArg Complex.re h
  have him := congrArg Complex.im h
  simp at hre him
  exact ⟨hre, him⟩

/-- **A rational unit vector is `(a + bi)/c` with `c` odd**: take the least common denominator; if it were even,
`a² + b² = c²` would make `a` and `b` even, and half of it would be a common denominator. -/
theorem exists_odd_rep_of_unitVector {z : ℂ} (hz : z ∈ planeOver (⊥ : Subfield ℝ)) (h1 : ‖z‖ = 1) :
    ∃ a b c : ℤ, Odd c ∧ z * (c : ℂ) = (a : ℂ) + (b : ℂ) * Complex.I := by
  classical
  obtain ⟨hre, him⟩ := hz
  rw [Subfield.bot_eq_of_charZero, RingHom.mem_fieldRange] at hre him
  obtain ⟨p, hp⟩ := hre
  obtain ⟨q, hq⟩ := him
  have hp' : (p : ℝ) = z.re := by rw [← hp]; simp
  have hq' : (q : ℝ) = z.im := by rw [← hq]; simp
  have hpq : p ^ 2 + q ^ 2 = 1 := by
    have h := Complex.sq_norm z
    rw [h1, Complex.normSq_apply, ← hp', ← hq'] at h
    have h' : ((p ^ 2 + q ^ 2 : ℚ) : ℝ) = 1 := by
      push_cast
      nlinarith [h]
    exact_mod_cast h'
  have hex : ∃ c : ℕ, 0 < c ∧ ∃ a b : ℤ, (c : ℚ) * p = a ∧ (c : ℚ) * q = b := by
    refine ⟨p.den * q.den, Nat.mul_pos p.den_pos q.den_pos, p.num * q.den, q.num * p.den, ?_, ?_⟩
    · push_cast
      rw [← Rat.mul_den_eq_num p]
      ring
    · push_cast
      rw [← Rat.mul_den_eq_num q]
      ring
  obtain ⟨hc0, a, b, ha, hb⟩ := Nat.find_spec hex
  have habc : a ^ 2 + b ^ 2 = ((Nat.find hex : ℕ) : ℤ) ^ 2 := by
    have h : ((a ^ 2 + b ^ 2 : ℤ) : ℚ) = ((((Nat.find hex : ℕ) : ℤ) ^ 2 : ℤ) : ℚ) := by
      push_cast
      rw [← ha, ← hb]
      linear_combination ((Nat.find hex : ℕ) : ℚ) ^ 2 * hpq
    exact_mod_cast h
  have hodd : Odd (Nat.find hex) := by
    by_contra hne
    rw [Nat.not_odd_iff_even] at hne
    obtain ⟨c₁, hc₁⟩ := hne
    have h4 : a ^ 2 + b ^ 2 = 4 * ((c₁ : ℤ) ^ 2) := by
      rw [habc, hc₁]
      push_cast
      ring
    obtain ⟨⟨a₀, rfl⟩, ⟨b₀, rfl⟩⟩ := two_dvd_of_sq_add_sq_eq_four_mul h4
    have hc₁pos : 0 < c₁ := by omega
    have hlt : c₁ < Nat.find hex := by omega
    refine Nat.find_min hex hlt ⟨hc₁pos, a₀, b₀, ?_, ?_⟩
    · have h := ha
      rw [hc₁] at h
      push_cast at h
      linarith
    · have h := hb
      rw [hc₁] at h
      push_cast at h
      linarith
  refine ⟨a, b, (Nat.find hex : ℕ), by exact_mod_cast hodd, ?_⟩
  have hreal_a : z.re * ((Nat.find hex : ℕ) : ℝ) = a := by
    rw [← hp']
    have h : (((Nat.find hex : ℕ) : ℚ) * p : ℝ) = ((a : ℚ) : ℝ) := by exact_mod_cast congrArg (Rat.cast : ℚ → ℝ) ha
    push_cast at h
    linarith
  have hreal_b : z.im * ((Nat.find hex : ℕ) : ℝ) = b := by
    rw [← hq']
    have h : (((Nat.find hex : ℕ) : ℚ) * q : ℝ) = ((b : ℚ) : ℝ) := by exact_mod_cast congrArg (Rat.cast : ℚ → ℝ) hb
    push_cast at h
    linarith
  apply Complex.ext
  · simpa using hreal_a
  · simpa using hreal_b

/-- **Every element of `ℤ[U_ℚ]` is `(a + bi)/c` with `c` odd.** -/
theorem exists_odd_rep_of_mem_unitRing {z : ℂ} (hz : z ∈ unitRing (⊥ : Subfield ℝ)) :
    ∃ a b c : ℤ, Odd c ∧ z * (c : ℂ) = (a : ℂ) + (b : ℂ) * Complex.I := by
  refine Subring.closure_induction (p := fun z _ => ∃ a b c : ℤ, Odd c ∧ z * (c : ℂ) = (a : ℂ) + (b : ℂ) * Complex.I)
    ?_ ?_ ?_ ?_ ?_ ?_ hz
  · exact fun z hz => exists_odd_rep_of_unitVector hz.1 hz.2
  · exact ⟨0, 0, 1, odd_one, by simp⟩
  · exact ⟨1, 0, 1, odd_one, by simp⟩
  · rintro x y _ _ ⟨a₁, b₁, c₁, hc₁, h₁⟩ ⟨a₂, b₂, c₂, hc₂, h₂⟩
    refine ⟨a₁ * c₂ + a₂ * c₁, b₁ * c₂ + b₂ * c₁, c₁ * c₂, hc₁.mul hc₂, ?_⟩
    push_cast
    linear_combination (c₂ : ℂ) * h₁ + (c₁ : ℂ) * h₂
  · rintro x _ ⟨a, b, c, hc, h⟩
    refine ⟨-a, -b, c, hc, ?_⟩
    push_cast
    linear_combination -h
  · rintro x y _ _ ⟨a₁, b₁, c₁, hc₁, h₁⟩ ⟨a₂, b₂, c₂, hc₂, h₂⟩
    refine ⟨a₁ * a₂ - b₁ * b₂, a₁ * b₂ + b₁ * a₂, c₁ * c₂, hc₁.mul hc₂, ?_⟩
    push_cast
    linear_combination (y * c₂) * h₁ + ((a₁ : ℂ) + b₁ * Complex.I) * h₂ + ((b₁ : ℂ) * b₂) * Complex.I_sq

theorem intCast_zmod_two_of_odd {c : ℤ} (hc : Odd c) : ((c : ℤ) : ZMod 2) = 1 := by
  obtain ⟨k, rfl⟩ := hc
  push_cast
  rw [show (2 : ZMod 2) = 0 from rfl]
  ring

/-- **The parity of a representation does not depend on the representation.** -/
theorem parity_rep_unique {z : ℂ} {a b c a' b' c' : ℤ} (hc : Odd c) (hc' : Odd c')
    (h : z * (c : ℂ) = (a : ℂ) + (b : ℂ) * Complex.I) (h' : z * (c' : ℂ) = (a' : ℂ) + (b' : ℂ) * Complex.I) :
    ((a + b : ℤ) : ZMod 2) = ((a' + b' : ℤ) : ZMod 2) := by
  obtain ⟨hre, him⟩ := re_im_of_mul_intCast_eq h
  obtain ⟨hre', him'⟩ := re_im_of_mul_intCast_eq h'
  have ha : a * c' = a' * c := by
    have h1 : ((a * c' : ℤ) : ℝ) = ((a' * c : ℤ) : ℝ) := by
      push_cast
      rw [← hre, ← hre']
      ring
    exact_mod_cast h1
  have hb : b * c' = b' * c := by
    have h1 : ((b * c' : ℤ) : ℝ) = ((b' * c : ℤ) : ℝ) := by
      push_cast
      rw [← him, ← him']
      ring
    exact_mod_cast h1
  have ha2 := congrArg (Int.cast : ℤ → ZMod 2) ha
  have hb2 := congrArg (Int.cast : ℤ → ZMod 2) hb
  push_cast at ha2 hb2 ⊢
  rw [intCast_zmod_two_of_odd hc, intCast_zmod_two_of_odd hc', mul_one, mul_one] at ha2 hb2
  rw [ha2, hb2]

/-- **The parity map of `ℤ[U_ℚ]`**: a ring homomorphism to `𝔽₂` sending every rational unit vector to `1` (reduction at
the prime `1 + i` of `ℚ(i)`). -/
theorem exists_parityHom :
    ∃ π : unitRing (⊥ : Subfield ℝ) →+* ZMod 2, ∀ u : unitVectors (⊥ : Subfield ℝ), π (uvRing u) = 1 := by
  classical
  have hrep : ∀ z : unitRing (⊥ : Subfield ℝ), ∃ a b c : ℤ, Odd c ∧ (z : ℂ) * (c : ℂ) = (a : ℂ) + (b : ℂ) * Complex.I :=
    fun z => exists_odd_rep_of_mem_unitRing z.2
  choose fa fb fc hodd hfz using hrep
  have hval : ∀ (z : unitRing (⊥ : Subfield ℝ)) (a b c : ℤ), Odd c → (z : ℂ) * (c : ℂ) = (a : ℂ) + (b : ℂ) * Complex.I →
      ((fa z + fb z : ℤ) : ZMod 2) = ((a + b : ℤ) : ZMod 2) := fun z a b c hc h =>
    parity_rep_unique (hodd z) hc (hfz z) h
  have h2 : (2 : ZMod 2) = 0 := rfl
  refine ⟨{ toFun := fun z => ((fa z + fb z : ℤ) : ZMod 2)
            map_one' := ?_
            map_mul' := ?_
            map_zero' := ?_
            map_add' := ?_ }, ?_⟩
  · simpa using hval 1 1 0 1 odd_one (by simp)
  · intro x y
    have h := hval (x * y) (fa x * fa y - fb x * fb y) (fa x * fb y + fb x * fa y) (fc x * fc y)
      ((hodd x).mul (hodd y)) (by
        push_cast
        linear_combination ((y : ℂ) * fc y) * hfz x + ((fa x : ℂ) + fb x * Complex.I) * hfz y +
          ((fb x : ℂ) * fb y) * Complex.I_sq)
    show ((fa (x * y) + fb (x * y) : ℤ) : ZMod 2) = ((fa x + fb x : ℤ) : ZMod 2) * ((fa y + fb y : ℤ) : ZMod 2)
    rw [h]
    push_cast
    linear_combination (-((fb x : ZMod 2) * fb y)) * h2
  · simpa using hval 0 0 0 1 odd_one (by simp)
  · intro x y
    have h := hval (x + y) (fa x * fc y + fa y * fc x) (fb x * fc y + fb y * fc x) (fc x * fc y)
      ((hodd x).mul (hodd y)) (by
        push_cast
        linear_combination (fc y : ℂ) * hfz x + (fc x : ℂ) * hfz y)
    show ((fa (x + y) + fb (x + y) : ℤ) : ZMod 2) = ((fa x + fb x : ℤ) : ZMod 2) + ((fa y + fb y : ℤ) : ZMod 2)
    rw [h]
    push_cast
    rw [intCast_zmod_two_of_odd (hodd x), intCast_zmod_two_of_odd (hodd y)]
    ring
  · intro u
    show ((fa (uvRing u) + fb (uvRing u) : ℤ) : ZMod 2) = 1
    obtain ⟨hre, him⟩ := re_im_of_mul_intCast_eq (hfz (uvRing u))
    have hnorm : (u : ℂ).re ^ 2 + (u : ℂ).im ^ 2 = 1 := by
      have h := Complex.sq_norm (u : ℂ)
      rw [u.2.2, Complex.normSq_apply] at h
      nlinarith [h]
    have hsq : fa (uvRing u) ^ 2 + fb (uvRing u) ^ 2 = fc (uvRing u) ^ 2 := by
      have h : ((fa (uvRing u) ^ 2 + fb (uvRing u) ^ 2 : ℤ) : ℝ) = ((fc (uvRing u) ^ 2 : ℤ) : ℝ) := by
        push_cast
        rw [← hre, ← him]
        have hu : ((uvRing u : unitRing (⊥ : Subfield ℝ)) : ℂ) = (u : ℂ) := rfl
        rw [hu]
        linear_combination ((fc (uvRing u) : ℝ) ^ 2) * hnorm
      exact_mod_cast h
    have hsq2 := congrArg (Int.cast : ℤ → ZMod 2) hsq
    push_cast at hsq2 ⊢
    have hx : ∀ x : ZMod 2, x ^ 2 = x := by decide
    rw [hx, hx, hx, intCast_zmod_two_of_odd (hodd (uvRing u))] at hsq2
    exact hsq2

/-- The non-trivial character of `ZMod 2` with values in the circle: `1 ↦ −1`. -/
theorem exists_signChar : ∃ ψ : AddChar (ZMod 2) Circle, ((ψ 1 : Circle) : ℂ) = -1 := by
  have h2 : Circle.exp Real.pi * Circle.exp Real.pi = 1 := by
    rw [← Circle.exp_add, ← two_mul, Circle.exp_two_pi]
  refine ⟨{ toFun := fun x => if x = 0 then 1 else Circle.exp Real.pi
            map_zero_eq_one' := if_pos rfl
            map_add_eq_mul' := ?_ }, ?_⟩
  · intro a b
    have h0 : ∀ x : ZMod 2, x = 0 ∨ x = 1 := by decide
    have h11 : (1 : ZMod 2) + 1 = 0 := by decide
    have h10 : (1 : ZMod 2) ≠ 0 := by decide
    rcases h0 a with rfl | rfl <;> rcases h0 b with rfl | rfl
    · simp
    · simp [h10]
    · simp [h10]
    · simp [h11, h10, h2]
  · show ((if (1 : ZMod 2) = 0 then (1 : Circle) else Circle.exp Real.pi : Circle) : ℂ) = -1
    rw [if_neg (by decide), Circle.coe_exp, Complex.exp_pi_mul_I]

/-- **`Interface.NegCircle` has a model**: at `F = ℚ` and the trivial interface, the point mass at the parity
character. -/
theorem negCircle_trivial_bot : (Interface.trivial (⊥ : Subfield ℝ)).NegCircle := by
  obtain ⟨π, hπ⟩ := exists_parityHom
  obtain ⟨ψ, hψ⟩ := exists_signChar
  have hrot : ∀ u : unitVectors (⊥ : Subfield ℝ),
      rot u (ψ.compAddMonoidHom π.toAddMonoidHom : Dual (⊥ : Subfield ℝ)) = ψ.compAddMonoidHom π.toAddMonoidHom := by
    intro u
    refine DFunLike.ext _ _ fun y => ?_
    show ψ (π (uvRing u * y)) = ψ (π y)
    rw [map_mul, hπ u, one_mul]
  refine ⟨Measure.dirac (ψ.compAddMonoidHom π.toAddMonoidHom), inferInstance, fun u => ?_,
    ⟨Set.univ, MeasurableSet.univ, by simp, fun a _ χ h => h⟩, ?_⟩
  · rw [Measure.map_dirac' (measurable_rot u), hrot u]
  · have hsm : StronglyMeasurable fun χ : Dual (⊥ : Subfield ℝ) => ((χ 1 : Circle) : ℂ).re :=
      (Complex.measurable_re.comp (measurable_eval 1)).stronglyMeasurable
    rw [integral_dirac' (fun χ : Dual (⊥ : Subfield ℝ) => ((χ 1 : Circle) : ℂ).re) _ hsm]
    show ((ψ (π 1) : Circle) : ℂ).re < 0
    rw [map_one, hψ]
    norm_num

/-! ## A model of all of `sp_if`'s hypotheses at once -/

/-- `ℚ`, as the bottom subfield of `ℝ`, is countable. -/
theorem countable_bot_subfield_real : Countable (⊥ : Subfield ℝ) := by
  have h : ((⊥ : Subfield ℝ) : Set ℝ) = Set.range (algebraMap ℚ ℝ) := by
    rw [Subfield.bot_eq_of_charZero]
    rfl
  have hc : ((⊥ : Subfield ℝ) : Set ℝ).Countable := h ▸ Set.countable_range _
  exact hc.to_subtype

/-- **`sp_if` has a model of all its hypotheses at once, given Herglotz–Bochner** (which is the named classical
hypothesis and has no kernel model): at `F = ℚ` and the trivial interface, `MulStable` (empty `E`), `NegCircle`
(`negCircle_trivial_bot`), `ν` the point mass at the trivial character — finite, rotation-invariant, `E`-null, and no
multiple of a Haar measure `m` (its Fourier coefficient at `1` is `1`, and `m`'s is `0`). -/
theorem sp_if_hypotheses_trivial_bot (hBH : BochnerHerglotz (unitRing (⊥ : Subfield ℝ))) :
    ∃ ν m : Measure (Dual (⊥ : Subfield ℝ)), (Interface.trivial (⊥ : Subfield ℝ)).MulStable ∧
      (Interface.trivial (⊥ : Subfield ℝ)).NegCircle ∧ IsFiniteMeasure ν ∧ RotInv (⊥ : Subfield ℝ) ν ∧
      ν (Interface.trivial (⊥ : Subfield ℝ)).E = 0 ∧ IsHaarFourier m ∧ ∀ a : ENNReal, ν ≠ a • m := by
  obtain ⟨m, hm⟩ := exists_isHaarFourier hBH
  have hsm : StronglyMeasurable fun χ : Dual (⊥ : Subfield ℝ) => ((χ 1 : Circle) : ℂ) :=
    (measurable_eval 1).stronglyMeasurable
  refine ⟨Measure.dirac 1, m, fun _ _ _ h => h, negCircle_trivial_bot, inferInstance, fun u => ?_, measure_empty,
    hm, fun a h => ?_⟩
  · rw [Measure.map_dirac' (measurable_rot u)]
    rfl
  · have h1 : ∫ χ, ((χ 1 : Circle) : ℂ) ∂(Measure.dirac (1 : Dual (⊥ : Subfield ℝ))) = 1 := by
      rw [integral_dirac' _ _ hsm]
      simp
    rw [h, integral_smul_measure, hm.2 1 one_ne_zero, smul_zero] at h1
    exact zero_ne_one h1

/-! ## Spec -/

-- `sp_if` applied to its model: over Herglotz–Bochner alone, the conclusion at `F = ℚ` and the trivial interface.
example (hBH : BochnerHerglotz (unitRing (⊥ : Subfield ℝ))) :
    ∃ τ : Measure (Dual (⊥ : Subfield ℝ)), IsFiniteMeasure τ ∧ RotInv (⊥ : Subfield ℝ) τ ∧
      τ (Interface.trivial (⊥ : Subfield ℝ)).E = 0 ∧ ∫ χ, (χ 1 : ℂ).re ∂τ < 0 := by
  obtain ⟨ν, m, hmul, hcirc, hfin, hrot, hE, hm, hnh⟩ := sp_if_hypotheses_trivial_bot hBH
  haveI : Countable (⊥ : Subfield ℝ) := countable_bot_subfield_real
  haveI : Countable (unitRing (⊥ : Subfield ℝ)) := countable_unitRing
  exact sp_if _ hBH hmul hcirc hfin hrot hE hm hnh

-- the parity map at two elements: `1 ↦ 1`, and the unit vector `(3 + 4i)/5 ↦ 1` (`3 + 4` is odd).
example : ∃ π : unitRing (⊥ : Subfield ℝ) →+* ZMod 2, π 1 = 1 ∧ π (1 + 1) = 0 := by
  obtain ⟨π, -⟩ := exists_parityHom
  exact ⟨π, map_one π, by rw [map_add, map_one]; decide⟩

-- a sum of two squares divisible by 4: both even (`2² + 0² = 4`); and the parity of a representation, at `z = 1`.
example : (2 : ℤ) ∣ 2 ∧ (2 : ℤ) ∣ 0 := two_dvd_of_sq_add_sq_eq_four_mul (n := 1) (by norm_num)
example : ((1 + 0 : ℤ) : ZMod 2) = ((3 + 0 : ℤ) : ZMod 2) :=
  parity_rep_unique (z := 1) (c := 1) (c' := 3) odd_one (by decide) (by simp) (by simp)

end HadwigerNelson.SpectralInputs
