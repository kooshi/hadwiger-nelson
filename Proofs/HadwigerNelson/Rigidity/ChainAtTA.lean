import Proofs.HadwigerNelson.Arith.SpectralInputs
import Proofs.HadwigerNelson.Arith.UpperHalf
import Proofs.HadwigerNelson.Rigidity.Entropy

/-!
# The chain to five, run at `T + A`: its hypotheses as closed statements about a field (FS-131, jobs FS131-KN3 and FS131-KN6; lane C proved by FS131-IN1L; three leaves `sorry`)

**Read aloud, against the informal claim.** `SpectralChain` proves `χ(F²) ≥ min(L(F), 5)` over an *interface*: a set `E` of
characters of `R = ℤ[U_F]`, a part `TA` and an entropy-like function are free data, and the project's hand results are
`Prop`s about that data. This module names the data for a field, so that every hypothesis is a sentence about `F`:

* **`TA F`**, the smaller set: the torsion characters times the characters with an additive real lift
  (`torsionChars`, `archChars`), in the kernel's own model of a character, `AddChar (unitRing F) Circle`.
* **`chainInterface F`**: the interface at `E := TA := TA F`, with `h τ u :=` the Kolmogorov–Sinai entropy of the rotation
  `rot u` for `τ` (`Rigidity.ksEntropy`). At this instance R-U says `τ(∅) = 0` and leaves the path (FS131-EN1, EN1-SPCOR).
* **`MRPlus F`** — the one sentence the chain reads (EN1-MRPLUS): every finite rotation-invariant measure on the dual of
  `ℤ[U_F]` that gives `T + A` measure `0` has every Fourier coefficient off `0` equal to `0`. `Measure` is a positive
  measure in Lean, so the signed reading, which is false, cannot be typed. It is `(chainInterface F).MR`, by `Iff.rfl`.
* **`EntropySplit F`** — PE-2 (FS100-PE2) at the strength its one consumer reads: `τ = a·m + b·ρ` with `m` Haar
  (`IsHaarFourier`), `ρ` a rotation-invariant probability measure of entropy zero under **one non-torsion rotation**
  (FS131-KN7, Amendment 2 of its brief). PE-2 as derived — entropy zero under every rotation — is `EntropySplitEvery F`,
  which implies it (`entropySplit_of_every`) and is off the headline's path. **Stated beside `Interface.PE2`, not through
  it:** that `Prop` carries the clause "the Haar part is null on `E`", which at `E := T + A` is `m(T + A) = 0` — a hand result
  no proof on the path reads (FS131-EN1 § 4.1).
* **`ZeroEntropyCarried F`** — EF_F⁺ (FS100-EFP), at its own strength: zero entropy at *one* non-torsion unit vector puts a
  rotation-invariant probability measure on `T + A`.
* **`NoRamifiedStableDyadic F`** — the scope of EF_F⁺ (`R_F = O′`; `LEDGER.md` row 100): no conjugation-stable prime of `F(i)`
  above 2 on whose residue field conjugation acts trivially. `IsRamified P` is the hypothesis of
  `UpperHalf.two_mem_of_conj_trivial` and `UpperHalf.colorable_two_planeOver_of_ramified`, word for word; a ramified stable
  prime is dyadic (`IsRamified.isDyadic`), so the scope says that no stable prime is ramified (`noRamifiedStableDyadic_iff`).

**Proved here:** `mrPlus_of_split_of_carried` (EN1-FROM-TWO: PE-2 and EF_F⁺ give MR⁺, five lines, no R-U, no Haar-null
clause, and no leaf: the non-torsion rotation comes with the split); `entropySplit_of_every`; `five_le_chromaticNumber_of_mrPlus`; **the scope from the local bound**,
`noRamifiedStableDyadic_of_three_le_localBound` (at a ramified stable prime the level-one target is two-colourable,
`colorable_two_levelTarget_one_of_isRamified`, so `L(F) ≤ 2`); and **the headline with closed hypotheses**,
`min_localBound_five_le_chromaticNumber_of_closed` — eight of them: the scope is no longer one (FS131-KN6).

**Proved by FS131-IN1L** (module C0): `measurableSet_TA`, `rot_preimage_TA`, `exists_nonTorsion_unitVector`.
**Leaves (`sorry`), each a module of the architecture in `plans/FS131-KN3-chain-plan.md`:** `entropySplit` (PE-2 at one
non-torsion rotation: modules M5–M7); `zeroEntropyCarried` (EF_F⁺: module M8). **Stated and off the headline's path:** `noRamifiedStableDyadic_of_tca`
(FS100-EXC in its own words, module M9), which the hand record under `LEDGER.md` row 121 cites and no theorem of this module
reads; and `EntropySplitEvery`, PE-2 at every rotation (its proof's extra layer — Lemma W for every vector and the torsion
case — is in module M7's draft claim list, marked off the path).

**Inhabitants.** `one_mem_TA`; `zeroEntropyCarried_model` (the point mass at the trivial character meets every
hypothesis of `ZeroEntropyCarried`'s clause, and its conclusion, at every non-torsion vector). `MRPlus`, `EntropySplit` and `ZeroEntropyCarried` quantify over measures, of which the zero
measure and (given Herglotz–Bochner) Haar measure are instances. `NoRamifiedStableDyadic` **fails at `F = ℚ`** (the prime
`(1 + i)` is stable, dyadic and ramified); its model is `ℚ(√47)`, which has no stable dyadic prime — the instances' module.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SimpleGraph SpectralChain SpectralInputs NumberField

open scoped Pointwise ENNReal

noncomputable section

/-- **`T`**: the torsion characters of `G`, those of finite order. -/
def torsionChars (G : Type*) [AddCommGroup G] : Set (AddChar G Circle) := {χ | ∃ N : ℕ, N ≠ 0 ∧ χ ^ N = 1}

/-- **`A`**: the archimedean characters of `G`, those with an additive real lift, `χ = exp ∘ ψ` for an additive
`ψ : G → ℝ`. (`Circle.exp t = e^{it}`; the factor `2π` of other conventions is absorbed by `ψ`.) -/
def archChars (G : Type*) [AddCommGroup G] : Set (AddChar G Circle) := {χ | ∃ ψ : G →+ ℝ, ∀ r, χ r = Circle.exp (ψ r)}

variable (F : Subfield ℝ)

/-- **`T + A`** for the field `F`: the characters of `R = ℤ[U_F]` that are a torsion character times an archimedean one. -/
def TA : Set (Dual F) := torsionChars (unitRing F) * archChars (unitRing F)

theorem one_mem_TA : (1 : Dual F) ∈ TA F :=
  Set.mem_mul.mpr ⟨1, ⟨1, one_ne_zero, pow_one 1⟩, 1, ⟨0, fun r => by simp⟩, mul_one 1⟩

section ArchMeasurable

variable {G : Type*} [AddCommGroup G]

/-- (i) of `measurableSet_TA`'s route: a character is a torsion character times an archimedean one exactly when one of
its non-zero powers is archimedean (`⇐`: divide the lift by the power). -/
private theorem mem_torsion_mul_arch_iff (χ : AddChar G Circle) :
    χ ∈ torsionChars G * archChars G ↔ ∃ N : ℕ, N ≠ 0 ∧ χ ^ N ∈ archChars G := by
  constructor
  · rintro ⟨t, ⟨N, hN, ht⟩, a, ⟨ψ, hψ⟩, rfl⟩
    refine ⟨N, hN, N • ψ, fun r => ?_⟩
    rw [mul_pow, ht, one_mul, AddChar.pow_apply, hψ, AddMonoidHom.nsmul_apply, Circle.exp_nsmul]
  · rintro ⟨N, hN, ψ, hψ⟩
    have hN' : (N : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hN
    let ψ' : G →+ ℝ := AddMonoidHom.mk' (fun r => ψ r / N) fun x y => by rw [map_add, add_div]
    let a : AddChar G Circle :=
      { toFun := fun r => Circle.exp (ψ' r)
        map_zero_eq_one' := by rw [map_zero, Circle.exp_zero]
        map_add_eq_mul' := fun x y => by rw [map_add, Circle.exp_add] }
    have ha : ∀ r, a r ^ N = χ r ^ N := by
      intro r
      have h1 : (χ ^ N) r = Circle.exp (ψ r) := hψ r
      rw [AddChar.pow_apply] at h1
      rw [h1]
      show Circle.exp (ψ r / N) ^ N = Circle.exp (ψ r)
      rw [← Circle.exp_nsmul, nsmul_eq_mul, mul_div_cancel₀ _ hN']
    refine Set.mem_mul.mpr ⟨χ * a⁻¹, ⟨N, hN, ?_⟩, a, ⟨ψ', fun r => rfl⟩, inv_mul_cancel_right χ a⟩
    refine AddChar.ext _ _ fun r => ?_
    rw [AddChar.pow_apply, AddChar.mul_apply, AddChar.inv_apply', mul_pow, inv_pow, ha r, mul_inv_cancel,
      AddChar.one_apply]

/-- An additive map to `ℝ` that vanishes on `s` vanishes at every `g` whose image lies in the `ℚ`-span of the image of
`s` (a multiple of `g` lies in the subgroup `s` generates, and `ℝ` has no torsion). -/
private theorem eq_zero_of_mem_span {W : Type*} [AddCommGroup W] [Module ℚ W] (ι : G →+ W) (hι : Function.Injective ι)
    (Δ : G →+ ℝ) {s : Set G} (hs : ∀ g ∈ s, Δ g = 0) {g : G}
    (hg : ι g ∈ Submodule.span ℚ (ι '' s)) : Δ g = 0 := by
  have key : ∀ x ∈ Submodule.span ℚ (ι '' s),
      ∃ m : ℕ, m ≠ 0 ∧ ∃ y ∈ AddSubgroup.closure s, ι y = m • x := by
    intro x hx
    induction hx using Submodule.span_induction with
    | mem x hx =>
      obtain ⟨g', hg', rfl⟩ := hx
      exact ⟨1, one_ne_zero, g', AddSubgroup.subset_closure hg', (one_nsmul _).symm⟩
    | zero => exact ⟨1, one_ne_zero, 0, zero_mem _, by simp⟩
    | add x₁ x₂ _ _ h₁ h₂ =>
      obtain ⟨m₁, hm₁, y₁, hy₁, e₁⟩ := h₁
      obtain ⟨m₂, hm₂, y₂, hy₂, e₂⟩ := h₂
      refine ⟨m₁ * m₂, mul_ne_zero hm₁ hm₂, m₂ • y₁ + m₁ • y₂,
        add_mem (nsmul_mem hy₁ _) (nsmul_mem hy₂ _), ?_⟩
      rw [map_add, map_nsmul, map_nsmul, e₁, e₂, smul_add, ← mul_nsmul, ← mul_nsmul, mul_comm m₂ m₁]
    | smul c x _ h =>
      obtain ⟨m, hm, y, hy, e⟩ := h
      refine ⟨c.den * m, mul_ne_zero c.den_nz hm, c.num • y, zsmul_mem hy _, ?_⟩
      rw [map_zsmul, e, ← Int.cast_smul_eq_zsmul ℚ, ← Nat.cast_smul_eq_nsmul ℚ, ← Nat.cast_smul_eq_nsmul ℚ,
        smul_smul, smul_smul]
      congr 1
      rw [← Rat.den_mul_eq_num c]
      push_cast
      ring
  have hcl : ∀ y ∈ AddSubgroup.closure s, Δ y = 0 := by
    intro y hy
    induction hy using AddSubgroup.closure_induction with
    | mem x hx => exact hs x hx
    | zero => exact map_zero Δ
    | add x y _ _ hx hy => rw [map_add, hx, hy, add_zero]
    | neg x _ hx => rw [map_neg, hx, neg_zero]
  obtain ⟨m, hm, y, hy, e⟩ := key _ hg
  rw [← map_nsmul] at e
  have hy0 := hcl y hy
  rw [hι e, map_nsmul, nsmul_eq_mul] at hy0
  exact (mul_eq_zero.mp hy0).resolve_left (Nat.cast_ne_zero.mpr hm)

/-- **Rational coordinates for an additive map to `ℝ`**: if `G` embeds additively in a finite-dimensional `ℚ`-vector
space, there are finitely many additive coordinates `q j : G →+ ℚ` such that every additive `ψ : G → ℝ` is
`∑ j, q j · t j` for some real `t` — `t j` is `ψ` at the `j`-th member of a `ℚ`-basis of the span of `G` chosen inside
`G`. -/
private theorem exists_rat_coords.{u} {W : Type u} [AddCommGroup W] [Module ℚ W] [FiniteDimensional ℚ W] (ι : G →+ W)
    (hι : Function.Injective ι) :
    ∃ (κ : Type u) (_ : Fintype κ) (q : κ → G →+ ℚ),
      ∀ ψ : G →+ ℝ, ∃ t : κ → ℝ, ∀ g, ψ g = ∑ j, (q j g : ℝ) * t j := by
  classical
  obtain ⟨b, hbS, hspan, hli⟩ := exists_linearIndependent ℚ (Set.range ι)
  haveI : Finite b := hli.finite
  letI : Fintype b := Fintype.ofFinite b
  set V := Submodule.span ℚ (Set.range ((↑) : b → W)) with hV
  have hrange : Set.range ((↑) : b → W) = b := Subtype.range_coe
  have hmem : ∀ g, ι g ∈ V := fun g => by
    rw [hV, hrange, hspan]
    exact Submodule.subset_span ⟨g, rfl⟩
  let B : Module.Basis b ℚ V := Module.Basis.span hli
  let c : G →+ V :=
    { toFun := fun g => ⟨ι g, hmem g⟩
      map_zero' := by ext; simp
      map_add' := fun x y => by ext; simp }
  let q : b → G →+ ℚ := fun j => (B.coord j).toAddMonoidHom.comp c
  refine ⟨b, inferInstance, q, fun ψ => ?_⟩
  have hgen : ∀ i : b, ∃ g, ι g = i := fun i => hbS i.2
  choose gen hgen using hgen
  refine ⟨fun j => ψ (gen j), fun g => ?_⟩
  let Δ : G →+ ℝ := ψ - ∑ j, ψ (gen j) • ((Rat.castHom ℝ).toAddMonoidHom.comp (q j))
  have hΔ : ∀ g, Δ g = ψ g - ∑ j, (q j g : ℝ) * ψ (gen j) := by
    intro g
    simp only [Δ, AddMonoidHom.sub_apply, AddMonoidHom.finsetSum_apply, AddMonoidHom.smul_apply,
      AddMonoidHom.comp_apply, smul_eq_mul]
    congr 1
    refine Finset.sum_congr rfl fun j _ => ?_
    simp [mul_comm]
  have hcgen : ∀ i, c (gen i) = B i := by
    intro i
    apply Subtype.ext
    change ι (gen i) = ((Module.Basis.span hli i : V) : W)
    rw [Module.Basis.coe_span_apply, hgen i]
  have hs : ∀ g ∈ Set.range gen, Δ g = 0 := by
    rintro _ ⟨i, rfl⟩
    rw [hΔ, sub_eq_zero]
    have hq : ∀ j, q j (gen i) = if i = j then 1 else 0 := by
      intro j
      simp only [q, AddMonoidHom.comp_apply, LinearMap.toAddMonoidHom_coe, hcgen, Module.Basis.coord_apply,
        Module.Basis.repr_self, Finsupp.single_apply]
    have hq' : ∀ j, ((q j (gen i) : ℚ) : ℝ) = if i = j then 1 else 0 := by
      intro j
      rw [hq j]
      split_ifs <;> simp
    simp only [hq', ite_mul, one_mul, zero_mul, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  have himage : ι '' Set.range gen = b := by
    ext w
    constructor
    · rintro ⟨_, ⟨i, rfl⟩, rfl⟩
      rw [hgen i]
      exact i.2
    · intro hw
      exact ⟨gen ⟨w, hw⟩, ⟨⟨w, hw⟩, rfl⟩, hgen ⟨w, hw⟩⟩
  have hg : ι g ∈ Submodule.span ℚ (ι '' Set.range gen) := by
    rw [himage, hspan]
    exact Submodule.subset_span ⟨g, rfl⟩
  have := eq_zero_of_mem_span ι hι Δ hs hg
  rw [hΔ, sub_eq_zero] at this
  exact this

/-- **The archimedean values form a measurable set** of `G → ℂ` (product σ-algebra, `G` countable), given rational
coordinates: the set is the image of `ℝ^κ` under a continuous map, a countable union of compact images of closed
balls, each closed. -/
private theorem measurableSet_archFun [Countable G] {κ : Type*} [Fintype κ] (q : κ → G →+ ℚ)
    (hq : ∀ ψ : G →+ ℝ, ∃ t : κ → ℝ, ∀ g, ψ g = ∑ j, (q j g : ℝ) * t j) :
    MeasurableSet {f : G → ℂ | ∃ ψ : G →+ ℝ, ∀ g, f g = Circle.exp (ψ g)} := by
  let L : (κ → ℝ) → G →+ ℝ := fun t =>
    AddMonoidHom.mk' (fun g => ∑ j, (q j g : ℝ) * t j) fun g h => by
      simp only [map_add, Rat.cast_add, add_mul, Finset.sum_add_distrib]
  let Φ : (κ → ℝ) → G → ℂ := fun t g => (Circle.exp (L t g) : ℂ)
  have hΦ : Continuous Φ :=
    continuous_pi fun g => continuous_subtype_val.comp (Circle.exp.continuous.comp
      (continuous_finsetSum _ fun j _ => continuous_const.mul (continuous_apply j)))
  have hset : {f : G → ℂ | ∃ ψ : G →+ ℝ, ∀ g, f g = Circle.exp (ψ g)} =
      ⋃ k : ℕ, Φ '' Metric.closedBall 0 k := by
    ext f
    simp only [Set.mem_setOf_eq, Set.mem_iUnion, Set.mem_image]
    constructor
    · rintro ⟨ψ, hψ⟩
      obtain ⟨t, ht⟩ := hq ψ
      obtain ⟨k, hk⟩ := exists_nat_ge ‖t‖
      refine ⟨k, t, mem_closedBall_zero_iff.mpr hk, funext fun g => ?_⟩
      rw [hψ g, ht g]
      rfl
    · rintro ⟨k, t, -, rfl⟩
      exact ⟨L t, fun g => rfl⟩
  rw [hset]
  exact MeasurableSet.iUnion fun k => ((isCompact_closedBall _ _).image hΦ).isClosed.measurableSet

end ArchMeasurable

/-- **`T + A` is measurable** for the cylinder σ-algebra (J45 Lemma N1 at `S = ∅`, `plans/FS84-SI-D-derivation.md` ll.
105–109). Route: `T + A = ⋃_N {χ | χ^N ∈ A}` and `A` is a countable union of continuous images of compact balls of the
finite-dimensional real space `Hom(R, ℝ)`. -/
theorem measurableSet_TA [NumberField F] : MeasurableSet (TA F) := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  let ι : unitRing F →+ fieldI F :=
    { toFun := fun g => ⟨g, UnitRing.unitRingOver_le_planeOverSubring F g.2⟩
      map_zero' := rfl
      map_add' := fun _ _ => rfl }
  have hι : Function.Injective ι := fun x y h => by
    have h' := congrArg Subtype.val h
    exact Subtype.ext h'
  obtain ⟨κ, _, q, hq⟩ := exists_rat_coords ι hι
  have hA := measurableSet_archFun q hq
  let S : Set (unitRing F → ℂ) := ⋃ N : ℕ, ⋃ (_ : N ≠ 0),
    (fun f g => f g ^ N) ⁻¹' {f | ∃ ψ : unitRing F →+ ℝ, ∀ g, f g = Circle.exp (ψ g)}
  have hS : MeasurableSet S := MeasurableSet.iUnion fun N => MeasurableSet.iUnion fun _ =>
    (measurable_pi_lambda _ fun g => (measurable_pi_apply g).pow_const N) hA
  have hTA : TA F = (fun χ : Dual F => fun g => (χ g : ℂ)) ⁻¹' S := by
    ext χ
    rw [TA, mem_torsion_mul_arch_iff]
    simp only [S, Set.mem_preimage, Set.mem_iUnion, Set.mem_setOf_eq, archChars, exists_prop]
    refine exists_congr fun N => and_congr_right fun _ => exists_congr fun ψ => forall_congr' fun g => ?_
    rw [AddChar.pow_apply, ← Circle.coe_pow]  -- may need adjusting
    exact Circle.coe_inj.symm
  rw [hTA]
  exact ⟨S, hS, rfl⟩

/-- A rotation carries `T + A` into itself: it keeps the order of a torsion character and carries a lift `ψ` to
`ψ ∘ (u ·)`. -/
private theorem rot_mem_TA {u : unitVectors F} {χ : Dual F} (h : χ ∈ TA F) : rot u χ ∈ TA F := by
  obtain ⟨t, ⟨N, hN, ht⟩, a, ⟨ψ, hψ⟩, rfl⟩ := Set.mem_mul.mp h
  refine Set.mem_mul.mpr ⟨rot u t, ⟨N, hN, ?_⟩, rot u a,
    ⟨ψ.comp (AddMonoidHom.mulLeft (uvRing u)), fun r => ?_⟩, ?_⟩
  · refine AddChar.ext _ _ fun r => ?_
    have h1 := congrArg (fun φ : Dual F => φ (uvRing u * r)) ht
    simpa [rot] using h1
  · simp [rot, hψ]
  · ext r
    simp [rot]

/-- The conjugate of a unit vector is a unit vector. -/
private theorem conj_mem_unitVectors {u : ℂ} (hu : u ∈ unitVectors F) : starRingEnd ℂ u ∈ unitVectors F :=
  ⟨UnitRing.conj_mem_planeOver hu.1, by rw [Complex.norm_conj]; exact hu.2⟩

/-- Rotating by `u` and then by `ū` is the identity: `u ū = |u|² = 1`. -/
private theorem rot_conj_rot (u : unitVectors F) (χ : Dual F) :
    rot ⟨starRingEnd ℂ u, conj_mem_unitVectors F u.2⟩ (rot u χ) = χ := by
  have h1 : (u : ℂ) * starRingEnd ℂ u = 1 := by
    rw [Complex.mul_conj', u.2.2]
    simp
  refine AddChar.ext _ _ fun r => ?_
  have h2 : uvRing u * (uvRing ⟨starRingEnd ℂ u, conj_mem_unitVectors F u.2⟩ * r) = r := by
    apply Subtype.ext
    change (u : ℂ) * (starRingEnd ℂ u * r) = r
    rw [← mul_assoc, h1, one_mul]
  show χ (uvRing u * (uvRing ⟨starRingEnd ℂ u, conj_mem_unitVectors F u.2⟩ * r)) = χ r
  rw [h2]

/-- **`T + A` is stable under every rotation** (J45 Lemma N1 at `S = ∅`): `rot u` preserves the order of a character and
carries the lift `ψ` to `ψ ∘ (u ·)`; its inverse is `rot ū`. -/
theorem rot_preimage_TA (u : unitVectors F) : rot u ⁻¹' TA F = TA F := by
  ext χ
  refine ⟨fun h => ?_, rot_mem_TA F⟩
  rw [← rot_conj_rot F u χ]
  exact rot_mem_TA F h

/-- The powers of `3 + 4i`: `(3 + 4i)^(n + 1) = a + b i` with `a ≡ 3` and `b ≡ 4 (mod 5)`. -/
private theorem pow_three_add_four_I (n : ℕ) :
    ∃ a b : ℤ, ((3 : ℂ) + 4 * Complex.I) ^ (n + 1) = a + b * Complex.I ∧ a % 5 = 3 ∧ b % 5 = 4 := by
  induction n with
  | zero => exact ⟨3, 4, by push_cast; ring, rfl, rfl⟩
  | succ n ih =>
    obtain ⟨a, b, h, ha, hb⟩ := ih
    refine ⟨3 * a - 4 * b, 4 * a + 3 * b, ?_, by omega, by omega⟩
    rw [pow_succ, h]
    push_cast
    linear_combination (4 * (b : ℂ)) * Complex.I_sq

/-- **A unit vector of `F²` that is not a root of unity**: `(3 + 4i)/5`, whose powers' numerators are `≡ 3 + 4i (mod 5)`. -/
theorem exists_nonTorsion_unitVector : ∃ u : unitVectors F, ∀ n : ℕ, n ≠ 0 → (u : ℂ) ^ n ≠ 1 := by
  have hq : ∀ q : ℚ, ((q : ℝ)) ∈ F := fun q => SubfieldClass.ratCast_mem F q
  have h3 : (3 / 5 : ℝ) ∈ F := by simpa using hq (3 / 5)
  have h4 : (4 / 5 : ℝ) ∈ F := by simpa using hq (4 / 5)
  have hnorm : ‖(⟨3 / 5, 4 / 5⟩ : ℂ)‖ = 1 := by
    rw [Complex.norm_def, Complex.normSq_mk]
    norm_num
  refine ⟨⟨⟨3 / 5, 4 / 5⟩, ⟨h3, h4⟩, hnorm⟩, fun n hn h => ?_⟩
  change (⟨3 / 5, 4 / 5⟩ : ℂ) ^ n = 1 at h
  obtain ⟨m, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hn
  obtain ⟨a, b, hab, -, hb⟩ := pow_three_add_four_I m
  have hu : (⟨3 / 5, 4 / 5⟩ : ℂ) = (3 + 4 * Complex.I) / 5 := by
    apply Complex.ext <;> simp
  have h5 : (5 : ℂ) ^ (m + 1) = (((5 : ℝ) ^ (m + 1) : ℝ) : ℂ) := by push_cast; rfl
  rw [hu, div_pow, div_eq_one_iff_eq (pow_ne_zero _ (by norm_num)), hab, h5] at h
  have him := congrArg Complex.im h
  rw [Complex.ofReal_im] at him
  simp at him
  omega

/-- **The point mass at the trivial character is rotation-invariant**: `rot u 1 = 1` (lane C's fourth leaf, by the
coordinator's ruling of 2026-10-14; `plans/FS131-KN6-chain-first-layer.md` § 3a.3). -/
theorem rotInv_dirac_one : RotInv F (Measure.dirac (1 : Dual F)) := fun u => by
  rw [Measure.map_dirac' (measurable_rot u)]
  congr 1

/-- **The interface at `T + A`**, with Kolmogorov–Sinai entropy: the instance at which every hypothesis of the chain is a
closed statement about `F`. -/
def chainInterface [NumberField F] : Interface F where
  E := TA F
  TA := TA F
  measurableSet_E := measurableSet_TA F
  measurableSet_TA := measurableSet_TA F
  TA_subset_E := subset_rfl
  rot_preimage_E := rot_preimage_TA F
  h τ u := ksEntropy τ (rot u)

/-- **MR⁺(F)** (FS131-EN1, EN1-MRPLUS): every finite rotation-invariant measure on the dual of `ℤ[U_F]` that gives `T + A`
measure `0` has every Fourier coefficient off `0` equal to `0`. A hand result of ours ([hand], one mind), derived for the
fields with no ramified stable dyadic place; here a definition, proved from PE-2 and EF_F⁺ by `mrPlus_of_split_of_carried`. -/
def MRPlus : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ → τ (TA F) = 0 →
    ∀ r : unitRing F, r ≠ 0 → ∫ χ, (χ r : ℂ) ∂τ = 0

/-- MR⁺ is the interface's `MR` at `E := T + A`, word for word. -/
theorem interface_mr_iff [NumberField F] : (chainInterface F).MR ↔ MRPlus F := Iff.rfl

/-- **PE-2, the entropy split, at the strength the chain reads** (FS100-PE2, `plans/FS100-derivation.md` l. 191; X02D;
FS131-KN7, Amendment 2): every rotation-invariant finite measure `τ` on `R̂` is `a·m + b·ρ` with `m` Haar and `ρ` a
rotation-invariant probability measure (`b = 0` when `τ − a·m = 0`) of entropy zero under **one** rotation by a
non-torsion unit vector. Its one consumer, `mrPlus_of_split_of_carried`, reads the entropy at one non-torsion rotation and
no other. PE-2 as derived says "`h_{τ′}(u) = 0` for every `u ∈ U`": `EntropySplitEvery`, which implies this
(`entropySplit_of_every`). -/
def EntropySplit : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ →
    ∃ (a b : ℝ≥0∞) (m ρ : Measure (Dual F)), IsHaarFourier m ∧ IsProbabilityMeasure ρ ∧ RotInv F ρ ∧
      (∃ u : unitVectors F, (∀ n : ℕ, n ≠ 0 → (u : ℂ) ^ n ≠ 1) ∧ ksEntropy ρ (rot u) = 0) ∧ τ = a • m + b • ρ

/-- **PE-2 as derived** (FS100-PE2, `plans/FS100-derivation.md` l. 191; X02D): "every `U`-invariant finite positive measure `τ`
on `R̂`: `τ = a·m + τ′` with `a ≥ 0`, `τ′` a `U`-invariant finite positive measure, and `h_{τ′}(u) = 0` for every `u ∈ U`" —
with `τ′ = b·ρ` for a probability measure `ρ`. **Off the headline's path** since FS131-KN7: the headline reads
`EntropySplit`, which this implies. -/
def EntropySplitEvery : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ →
    ∃ (a b : ℝ≥0∞) (m ρ : Measure (Dual F)), IsHaarFourier m ∧ IsProbabilityMeasure ρ ∧ RotInv F ρ ∧
      (∀ u : unitVectors F, ksEntropy ρ (rot u) = 0) ∧ τ = a • m + b • ρ

/-- PE-2 at every rotation gives it at one: the rotation is `(3 + 4i)/5`'s (`exists_nonTorsion_unitVector`). -/
theorem entropySplit_of_every (h : EntropySplitEvery F) : EntropySplit F := by
  intro τ hfin hrot
  obtain ⟨a, b, m, ρ, hm, hρ, hρrot, hρh, hτ⟩ := h τ hfin hrot
  obtain ⟨u, hu⟩ := exists_nonTorsion_unitVector F
  exact ⟨a, b, m, ρ, hm, hρ, hρrot, ⟨u, hu, hρh u⟩, hτ⟩

/-- **EF_F⁺, zero entropy is carried by `T + A`** (FS100-EFP, `plans/FS100-derivation.md` l. 162; X01D l. 194): "every
`U`-invariant finite positive Borel measure `μ` on `R̂` such that `h_μ(u*) = 0` for **one** non-torsion `u* ∈ U` satisfies
`μ(R̂ ∖ (T + A)) = 0`" — for a probability measure, which is the general case after scaling. -/
def ZeroEntropyCarried : Prop :=
  ∀ ρ : Measure (Dual F), IsProbabilityMeasure ρ → RotInv F ρ →
    ∀ u : unitVectors F, (∀ n : ℕ, n ≠ 0 → (u : ℂ) ^ n ≠ 1) → ksEntropy ρ (rot u) = 0 → ρ (TA F)ᶜ = 0

/-- **A model of `ZeroEntropyCarried`'s clause** (`plans/FS131-KN6-chain-first-layer.md` § 3a.3; added by the
coordinator's ruling of 2026-10-14): the point mass at the trivial character is a rotation-invariant probability measure
of entropy zero under the rotation by **every** non-torsion unit vector, of which there is one
(`exists_nonTorsion_unitVector`), and it gives the complement of `T + A` measure `0` (`1 ∈ TA F`). Every clause of the
hypothesis is exercised and the conclusion holds; degenerate in that the measure is one atom. -/
theorem zeroEntropyCarried_model [NumberField F] :
    IsProbabilityMeasure (Measure.dirac (1 : Dual F)) ∧ RotInv F (Measure.dirac (1 : Dual F)) ∧
      (∃ u : unitVectors F, ∀ n : ℕ, n ≠ 0 → (u : ℂ) ^ n ≠ 1) ∧
      (∀ u : unitVectors F, (∀ n : ℕ, n ≠ 0 → (u : ℂ) ^ n ≠ 1) →
        ksEntropy (Measure.dirac (1 : Dual F)) (rot u) = 0) ∧
      Measure.dirac (1 : Dual F) (TA F)ᶜ = 0 := by
  refine ⟨inferInstance, rotInv_dirac_one F, exists_nonTorsion_unitVector F,
    fun u _ => ksEntropy_dirac (measurable_rot u) 1, ?_⟩
  rw [Measure.dirac_apply' _ (measurableSet_TA F).compl]
  simp [one_mem_TA F]

variable {F} in
/-- A stable prime of `F(i)` above 2. -/
def IsDyadic (P : StablePrime F) : Prop := (2 : 𝓞 (fieldI F)) ∈ P.P

variable {F} in
/-- A stable prime of `F(i)` that is ramified over `F`: conjugation acts trivially on its residue field (for a prime fixed
by the non-trivial automorphism of a quadratic extension, the inertia group is then the whole group). -/
def IsRamified (P : StablePrime F) : Prop := ∀ x : 𝓞 (fieldI F), conjO F x - x ∈ P.P

/-- **The scope of EF_F⁺ and of MR⁺**: no stable dyadic place of `F(i)` is ramified over `F` — the class in which
`R_F = O′` (`LEDGER.md` row 100, Lemma C′). -/
def NoRamifiedStableDyadic : Prop := ∀ P : StablePrime F, IsDyadic P → ¬ IsRamified P

variable {F} in
/-- A ramified stable prime is dyadic: `ī − i = −2i` lies in it and `i` is a unit (`UpperHalf.two_mem_of_conj_trivial`). -/
theorem IsRamified.isDyadic {P : StablePrime F} (h : IsRamified P) : IsDyadic P :=
  UpperHalf.two_mem_of_conj_trivial P h

/-- The word "dyadic" in the scope is free: the scope says that no stable prime is ramified. -/
theorem noRamifiedStableDyadic_iff : NoRamifiedStableDyadic F ↔ ∀ P : StablePrime F, ¬ IsRamified P :=
  ⟨fun h P hP => h P hP.isDyadic hP, fun h P _ => h P⟩

variable {F} in
/-- **At a ramified stable prime the level-one target is two-colourable** (FS100-EXC's matching): conjugation is the
identity on the field `𝓞 ⧸ P` of characteristic two, so `x` and `y` are adjacent exactly when `(x − y)² = 1`, that is
`x − y = 1`, and an additive functional to `ZMod 2` that does not vanish at `1` is a proper colouring. -/
theorem colorable_two_levelTarget_one_of_isRamified {P : StablePrime F} (h : IsRamified P) :
    (levelTarget P 1).Colorable 2 := by
  have e : P.P ^ 1 = P.P := pow_one _
  haveI : (P.P ^ 1).IsPrime := by rw [e]; exact P.isMaximal.isPrime
  haveI : CharP (𝓞 (fieldI F) ⧸ P.P ^ 1) 2 := by
    refine CharTwo.of_one_ne_zero_of_two_eq_zero one_ne_zero ?_
    have h2 : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) = Ideal.Quotient.mk (P.P ^ 1) 2 := (map_ofNat _ 2).symm
    rw [h2, Ideal.Quotient.eq_zero_iff_mem, e]
    exact h.isDyadic
  have hid : ∀ t, Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) t = t := by
    intro t
    obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective t
    rw [Ideal.quotientMap_mk, Ideal.Quotient.eq, e]
    exact h a
  have hone : ∀ t : 𝓞 (fieldI F) ⧸ P.P ^ 1, t * Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) t = 1 → t = 1 := by
    intro t ht
    rw [hid] at ht
    exact frobenius_inj _ 2 (by rw [frobenius_def, frobenius_def, one_pow, sq, ht])
  obtain ⟨l, hl⟩ := exists_addMonoidHom_zmod_two_apply_one_ne_zero (𝓞 (fieldI F) ⧸ P.P ^ 1)
  have hcol : (levelTarget P 1).Coloring (ZMod 2) :=
    SimpleGraph.Coloring.mk (fun x => l x) fun {x y} hxy hc => by
      rcases ((SimpleGraph.fromRel_adj _ x y).mp hxy).2 with hr | hr
      · have h1 := hone _ hr
        exact hl (by rw [← h1, map_sub, hc, sub_self])
      · have h1 := hone _ hr
        exact hl (by rw [← h1, map_sub, hc, sub_self])
  simpa using hcol.colorable

/-- **The scope from the local bound** (FS100-EXC, in the form the headline reads): a field whose local bound is at least
`3` has no ramified stable prime — at one the level-one target is two-colourable, so `L(F) ≤ 2`. -/
theorem noRamifiedStableDyadic_of_three_le_localBound (h : 3 ≤ localBound F) : NoRamifiedStableDyadic F := by
  intro P _ hram
  have h2 : localBound F ≤ 2 :=
    (iInf_le _ P).trans (colorable_two_levelTarget_one_of_isRamified hram).chromaticNumber_le
  exact absurd (h.trans h2) (by decide)

/-- **MR⁺ from PE-2 and EF_F⁺** (FS131-EN1, EN1-FROM-TWO): for an invariant `τ` null on `T + A`, write `τ = a·m + b·ρ`; if
`b ≠ 0` then `ρ` is null on `T + A` and, having entropy zero at a non-torsion unit vector, null off it — impossible for a
probability measure; so `τ = a·m`. Reads no R-U, no `E`, no Haar-null clause, and the entropy at one rotation only. -/
theorem mrPlus_of_split_of_carried (hPE : EntropySplit F) (hEF : ZeroEntropyCarried F) : MRPlus F := by
  intro τ hfin hrot hTA r hr
  obtain ⟨a, b, m, ρ, hm, hρ, hρrot, ⟨u, hu, hρu⟩, rfl⟩ := hPE τ hfin hrot
  have hb : b = 0 := by
    by_contra hb
    have h1 : ρ (TA F) = 0 := by
      rw [Measure.add_apply, Measure.smul_apply, Measure.smul_apply, smul_eq_mul, smul_eq_mul] at hTA
      exact (mul_eq_zero.mp (add_eq_zero.mp hTA).2).resolve_left hb
    have h2 : ρ (TA F)ᶜ = 0 := hEF ρ hρ hρrot u hu hρu
    have h3 : ρ Set.univ = 0 := by
      rw [← Set.union_compl_self (TA F)]
      exact measure_union_null h1 h2
    haveI := hρ
    exact (IsProbabilityMeasure.ne_zero ρ) (Measure.measure_univ_eq_zero.mp h3)
  rw [hb, zero_smul, add_zero, integral_smul_measure, hm.2 r hr, smul_zero]

/-- **The lower half from MR⁺**: `χ(F²) ≥ 5` given Herglotz–Bochner, the invariant measure on closed sets, A⁺ at `S = ∅`
and MR⁺ — SP-Cor run at `T + A` (FS131-EN1, EN1-SPCOR), where R-U is `τ(∅) = 0`. -/
theorem five_le_chromaticNumber_of_mrPlus [NumberField F] (hBH : BochnerHerglotz (unitRing F))
    (hL1 : InvariantMeasureOnClosed F) (hA : (chainInterface F).APlus0) (hMR : MRPlus F) :
    5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  have hRU : (chainInterface F).RU := fun τ _ _ => by
    show τ (TA F \ TA F) = 0
    simp
  have h := (add_one_le_chromaticNumber_iff_not_colorable
    (G := (unitDistance ℂ).induce (planeOver F)) (n := 4)).mpr fun hc => by
    have hne := x4_nonempty_of_colorable hc
    rw [(chainInterface F).x4_eq_empty hBH hL1 hRU hA hMR] at hne
    exact Set.not_nonempty_empty hne
  exact_mod_cast h

/-- **THE HEADLINE, WITH CLOSED HYPOTHESES**: for a real number field `F`, `χ(F²) ≥ min(L(F), 5)` given
- `hBH`, `hL1` — Herglotz–Bochner and the invariant measure on closed sets (classical; to be formalized);
- `hCount` — the count: T-C(A) at `S = ∅` in class form gives no colouring measure with spectrum on `T + A` (R88-TCA);
- `hAP` — A⁺ at `S = ∅` from it (J45);
- `hPE` — PE-2, the entropy split; `hEF` — EF_F⁺ in its scope;
- `hCLS` — CLS; `hRow99` — row 99 at `L ≤ 4`.
Every hypothesis is a sentence about `F`; none mentions a free set, a free function or R-U. That the class lies in the
scope is not a hypothesis: `5 ≤ L(F)` excludes a ramified stable prime (`noRamifiedStableDyadic_of_three_le_localBound`).
The model of the hypotheses is `ℚ(√47)` (the instances' module, `data/fs131/kn3/claims-M15-instances.md`); none is in the
library yet. -/
theorem min_localBound_five_le_chromaticNumber_of_closed [NumberField F] (hBH : BochnerHerglotz (unitRing F))
    (hL1 : InvariantMeasureOnClosed F) (hCount : (chainInterface F).Count) (hAP : (chainInterface F).APlusOfR88)
    (hPE : EntropySplit F) (hEF : NoRamifiedStableDyadic F → ZeroEntropyCarried F)
    (hCLS : 5 ≤ localBound F → TCA F)
    (hRow99 : localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber) :
    min (localBound F) 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  by_cases h5 : 5 ≤ localBound F
  · have hT := hCLS h5
    exact min_le_of_right_le (five_le_chromaticNumber_of_mrPlus F hBH hL1 (hAP (hCount hT))
      (mrPlus_of_split_of_carried F hPE
        (hEF (noRamifiedStableDyadic_of_three_le_localBound F (le_trans (by decide) h5)))))
  · have h4 : localBound F ≤ 4 := Order.le_of_lt_succ (not_le.mp h5)
    exact min_le_of_left_le (hRow99 h4)

/-! ## The two deductions and the scope, as closed statements — the leaves under MR⁺ -/

/-- **PE-2 at one non-torsion rotation** (FS100-PE2; [hand], X02D and X02V; the variant EN2-PE2-MAX of
`plans/FS131-EN2-derivation.md` § 5.2): the entropy split holds over every real number field, with the entropy zero at a
rotation of one admissible `Γ`. Rests on `Rigidity.positive_entropy_rigidity` through `Rigidity.haar_or_zero_entropy` on
the pieces `M̂`; needs no Lemma W for every vector and no torsion case (FS131-KN7). -/
theorem entropySplit [NumberField F] : EntropySplit F := by
  sorry

/-- **EF_F⁺** (FS100-EFP; [hand], X01D, X12B, FS105-B): zero entropy is carried by `T + A`, over every real number field
with no ramified stable dyadic place. -/
theorem zeroEntropyCarried [NumberField F] (h : NoRamifiedStableDyadic F) : ZeroEntropyCarried F := by
  sorry

/-- **The class lies in the scope** (FS100-EXC, in its own words): at a ramified stable dyadic prime the level-one target
is a perfect matching, of independence ratio `1/2`, so T-C(A) fails. **Off the headline's path** since FS131-KN6: the
headline reads `noRamifiedStableDyadic_of_three_le_localBound`. Route: a colour class of the two-colouring
`colorable_two_levelTarget_one_of_isRamified` is independent and holds at least half of `𝓞 ⧸ P`. -/
theorem noRamifiedStableDyadic_of_tca [NumberField F] (h : TCA F) : NoRamifiedStableDyadic F := by
  sorry

/-- **MR⁺(F)**, for a real number field with no ramified stable dyadic place. -/
theorem mrPlus [NumberField F] (h : NoRamifiedStableDyadic F) : MRPlus F :=
  mrPlus_of_split_of_carried F (entropySplit F) (zeroEntropyCarried F h)

/-- **The headline over the two classical theorems and the chain's four other hand results**: PE-2 and EF_F⁺ are the
theorems above. -/
theorem min_localBound_five_le_chromaticNumber_closed [NumberField F] (hBH : BochnerHerglotz (unitRing F))
    (hL1 : InvariantMeasureOnClosed F) (hCount : (chainInterface F).Count) (hAP : (chainInterface F).APlusOfR88)
    (hCLS : 5 ≤ localBound F → TCA F)
    (hRow99 : localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber) :
    min (localBound F) 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  min_localBound_five_le_chromaticNumber_of_closed F hBH hL1 hCount hAP (entropySplit F) (zeroEntropyCarried F)
    hCLS hRow99

end

end HadwigerNelson.Rigidity
