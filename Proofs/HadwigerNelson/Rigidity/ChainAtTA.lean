import Proofs.HadwigerNelson.Arith.SpectralInputs
import Proofs.HadwigerNelson.Arith.UpperHalf
import Proofs.HadwigerNelson.Rigidity.Entropy

/-!
# The chain to five, run at `T + A`: its hypotheses as closed statements about a field (FS-131, jobs FS131-KN3 and FS131-KN6; skeleton)

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

**Leaves (`sorry`), each a module of the architecture in `plans/FS131-KN3-chain-plan.md`:** `measurableSet_TA`,
`rot_preimage_TA`, `exists_nonTorsion_unitVector` (module C0); `entropySplit` (PE-2 at one non-torsion rotation: modules
M5–M7); `zeroEntropyCarried` (EF_F⁺: module M8). **Stated and off the headline's path:** `noRamifiedStableDyadic_of_tca`
(FS100-EXC in its own words, module M9), which the hand record under `LEDGER.md` row 121 cites and no theorem of this module
reads; and `EntropySplitEvery`, PE-2 at every rotation (its proof's extra layer — Lemma W for every vector and the torsion
case — is in module M7's draft claim list, marked off the path).

**Inhabitants.** `one_mem_TA`. `MRPlus`, `EntropySplit` and `ZeroEntropyCarried` quantify over measures, of which the zero
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

/-- **`T + A` is measurable** for the cylinder σ-algebra (J45 Lemma N1 at `S = ∅`, `plans/FS84-SI-D-derivation.md` ll.
105–109). Route: `T + A = ⋃_N {χ | χ^N ∈ A}` and `A` is a countable union of continuous images of compact balls of the
finite-dimensional real space `Hom(R, ℝ)`. -/
theorem measurableSet_TA [NumberField F] : MeasurableSet (TA F) := by
  sorry

/-- **`T + A` is stable under every rotation** (J45 Lemma N1 at `S = ∅`): `rot u` preserves the order of a character and
carries the lift `ψ` to `ψ ∘ (u ·)`; its inverse is `rot ū`. -/
theorem rot_preimage_TA (u : unitVectors F) : rot u ⁻¹' TA F = TA F := by
  sorry

/-- **A unit vector of `F²` that is not a root of unity**: `(3 + 4i)/5`, whose powers' numerators are `≡ 3 + 4i (mod 5)`. -/
theorem exists_nonTorsion_unitVector : ∃ u : unitVectors F, ∀ n : ℕ, n ≠ 0 → (u : ℂ) ^ n ≠ 1 := by
  sorry

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
