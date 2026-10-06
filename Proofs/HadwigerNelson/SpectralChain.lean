import Proofs.HadwigerNelson.UnitRing
import Mathlib.LinearAlgebra.Countable
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Set
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap
import Mathlib.MeasureTheory.Integral.IntegrableOn
import Mathlib.MeasureTheory.Constructions.Pi
import Mathlib.Analysis.SpecialFunctions.Complex.Circle
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.NumberTheory.NumberField.InfinitePlace.TotallyRealComplex
import Mathlib.RingTheory.Ideal.Quotient.Operations

/-!
# The spectral chain over a real field: SP-Cor's interface, node M, and the local bound `L(F)` (FS-100, X11K–X11K3)

**Read aloud, against the informal claim.** For a real field `F`, let `U` be the unit vectors of `F²`, `R = ℤ[U]` the ring
they generate, and `R̂` its characters. The five-colour lower bound of FS-100 (`χ(F²) ≥ min(L(F), 5)` for every real number
field, given MR; X23D-COR) runs through a spectral argument (SP-Cor, `plans/FS84-SI-D-derivation.md` §4.2): a proper
four-colouring of `F²` gives a translation- and rotation-invariant random four-colouring of `Cay(R, U)`, whose correlation
has a spectral measure on `R̂`, and measure rigidity forbids that measure. This module holds the part of that argument that
is proved with no leaf left open, over an **interface**: a set `E` of characters (meant: `⋃_S (T + A + Fin_S)`), its part
`TA` (meant: `T + A`) and an entropy-like `h` (meant: Kolmogorov–Sinai entropy) are data, and the project's [hand] lemmas
are named `Prop`s about that data — R-U (`Interface.RU`), A⁺ at `S = ∅` (`Interface.APlus0`), PE-2 (`Interface.PE2`),
EF_F⁺ (`Interface.EFPlus`), R88-TCA (`Interface.R88TCA`) and the count (`Interface.Count`). That the arithmetic `E`, `T + A`
and entropy satisfy them is the content of those lemmas, which this file does not see; the theorems here certify the
compositions, valid for every choice (M2's `Bridge.RealAlgebraicDescent` precedent: a true, unformalized input enters as a
named hypothesis).

**Proved here:** node M, PE-2 and EF_F⁺ give MR in Fourier form (`Interface.mr_of_pe2_efPlus`); node L0, a proper
four-colouring of `F²` restricts to `X₄(F)` (`x4_nonempty_of_colorable`); evaluation and rotation are measurable on `R̂`
(`measurable_eval`, `measurable_rot`); `F(i)` is a number field when `F` is.

**Defined here, with Mathlib's number-field API:** a stable prime (`StablePrime`: a maximal ideal of `𝓞 (F(i))` fixed by
conjugation), its level-`m` residue target `Cay(𝓞 ⧸ P^m, {x : x·x̄ = 1})` (`levelTarget`), the local bound
`L(F) = ⨅_P χ(target at level 1)` (`localBound`) and T-C(A) at `S = ∅` in class form (`TCA`). **Caveat:** the derivation's
level-`m` circle is the image of `U` mod `P^m`; `levelTarget` uses every norm-one element of the quotient. They agree by
smoothness of the norm-one torus (X23D §2.3) — [hand], not in the kernel. If `F` had no stable prime, `localBound F = ⊤`;
every real number field has one (Chebotarev in `F(i)/F`), not proved here.

**The composition, proved here over the interface and three named hypotheses** — Herglotz–Bochner (`BochnerHerglotz`),
L1 in the classical theorem's own terms (`InvariantMeasureOnClosed`: amenability of `ℤ[U] ⋊ U`; true for every `F`), and the
project lemmas above: `posDef_corr` (the tetrahedral Gram identity), node L3 (`rotInv_of_isTraceSpectral`), node L6, SP-Cor
(`Interface.x4_eq_empty`), `Interface.five_le_chromaticNumber`, and **the headline for every real number field,
`min_localBound_five_le_chromaticNumber`**: `min(L(F), 5) ≤ χ(F²)` (with its totally real form and `χ(F²) = L(F)` for `L ≤ 5`
given the upper half). Countability of `ℤ[U]` is proved over a number field (`countable_unitRing`) and is needed: over a field
with uncountable `ℤ[U]` no invariant random colouring exists on the product σ-algebra (`plans/FS100-K-kernel-47.md` §X11K3
Stage 2), which is why L1 carries `MeasurableSet K`. **Inhabitants:** `Interface.trivial` inhabits `Interface`;
`InvariantColouring F` is inhabited, given L1, whenever `X₄(F) ≠ ∅` and `ℤ[U]` is countable (`exists_invariantColouring`), e.g.
over `ℚ`, whose plane is two-colourable. -/

namespace HadwigerNelson.SpectralChain

open SimpleGraph

open MeasureTheory

noncomputable section Chain

variable (F : Subfield ℝ)

/-- `U_F`: the unit vectors of `F²`, as points of `ℂ`. -/
def unitVectors : Set ℂ := {u | u ∈ planeOver F ∧ ‖u‖ = 1}

/-- `R = ℤ[U]`, the subring of `ℂ` the unit vectors generate: `UnitRing.unitRingOver`, FS-47's ring. -/
abbrev unitRing : Subring ℂ := UnitRing.unitRingOver F

theorem unitVectors_subset_unitRing : unitVectors F ⊆ unitRing F := fun _ hu => UnitRing.unit_mem_unitRingOver hu.1 hu.2

/-- The unit vector `u`, as an element of `R`. -/
def uvRing {F : Subfield ℝ} (u : unitVectors F) : unitRing F := ⟨u, unitVectors_subset_unitRing F u.2⟩

/-- `X₄(F)`: the proper four-colourings of `Cay(R, U)`. -/
def X4 : Set (unitRing F → Fin 4) := {c | ∀ x y : unitRing F, (y : ℂ) - x ∈ unitVectors F → c x ≠ c y}

/-- The cylinder σ-algebra on the characters of an abelian group (the Borel one when the group is countable). -/
instance dualMeasurableSpace (G : Type*) [AddCommGroup G] : MeasurableSpace (AddChar G Circle) :=
  MeasurableSpace.comap (fun χ : AddChar G Circle => fun g : G => (χ g : ℂ)) MeasurableSpace.pi

/-- `R̂`, the characters of `R`. -/
abbrev Dual := AddChar (unitRing F) Circle

/-- The rotation `(u·χ)(r) = χ(ur)`. -/
def rot {F : Subfield ℝ} (u : unitVectors F) (χ : Dual F) : Dual F :=
  χ.compAddMonoidHom (AddMonoidHom.mulLeft (uvRing u))

/-- A measure on `R̂` invariant under every rotation. -/
def RotInv (τ : Measure (Dual F)) : Prop := ∀ u : unitVectors F, τ.map (rot u) = τ

/-- **A translation- and rotation-invariant random proper four-colouring** of `Cay(R, U)` — SP-Cor's `μ`. -/
structure InvariantColouring where
  /-- The law of the random colouring. -/
  μ : Measure (unitRing F → Fin 4)
  /-- It is a probability measure. -/
  isProb : IsProbabilityMeasure μ
  /-- It is carried by the proper four-colourings `X₄(F)`. -/
  carried : μ (X4 F)ᶜ = 0
  /-- Invariant under every translation `c ↦ c(· + y)`. -/
  shift_inv : ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ
  /-- Invariant under every rotation `c ↦ c(u ·)`. -/
  rot_inv : ∀ u : unitVectors F, μ.map (fun c x => c (uvRing u * x)) = μ

/-- `⟨e_i, e_j⟩` for the vertices of a regular tetrahedron: `1` on the diagonal, `−1/3` off it. -/
def tetra (i j : Fin 4) : ℝ := if i = j then 1 else -1 / 3

/-- `C(y) = E_μ⟨g(0), g(y)⟩`. -/
noncomputable def corr (μ : Measure (unitRing F → Fin 4)) (y : unitRing F) : ℝ := ∫ c, tetra (c 0) (c y) ∂μ

/-- **The trace spectral measure** (`plans/FS84-SI-D-derivation.md` §1.2): a finite measure `σ` on `R̂` with
`∫ χ(y) dσ = C(y)` for every `y`. -/
def IsTraceSpectral (μ : Measure (unitRing F → Fin 4)) (σ : Measure (Dual F)) : Prop :=
  IsFiniteMeasure σ ∧ ∀ y : unitRing F, ∫ χ, (χ y : ℂ) ∂σ = (corr F μ y : ℂ)

/-- Positive-definite functions on an abelian group. -/
def PosDef {G : Type*} [AddCommGroup G] (C : G → ℂ) : Prop :=
  ∀ (s : Finset G) (z : G → ℂ),
    (∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * C (x - y)).im = 0 ∧
      0 ≤ (∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * C (x - y)).re

/-- **X-BH, external: Herglotz–Bochner on a discrete abelian group, with uniqueness.** "Bochner's theorem … as generalised by
Weil: any positive definite function on a locally compact abelian group `G` is the Fourier–Stieltjes transform of a positive
measure on the dual group" (Rudin, *Fourier Analysis on Groups*, `[Rudin1962]`, 1.4.3; not quoted from a held copy);
uniqueness is the injectivity of the Fourier–Stieltjes transform (Rudin 1.3.6). Mathlib lacks both for groups (it has
`Measure.ext_of_charFun` on inner-product spaces). -/
def BochnerHerglotz (G : Type*) [AddCommGroup G] : Prop :=
  ∀ C : G → ℂ, PosDef C → ∃ σ : Measure (AddChar G Circle), IsFiniteMeasure σ ∧ (∀ y, ∫ χ, (χ y : ℂ) ∂σ = C y) ∧
    ∀ σ' : Measure (AddChar G Circle), IsFiniteMeasure σ' → (∀ y, ∫ χ, (χ y : ℂ) ∂σ' = C y) → σ' = σ

/-- **The interface.** `E` (meant: `⋃_S (T + A + Fin_S)`), `TA` (meant: `T + A`, which is `E_∅`) and `h` (meant:
Kolmogorov–Sinai entropy, `h τ u = h_τ(u)`) are data; the properties below are the definitional ones the chain uses. -/
structure Interface where
  /-- The set of characters `E` (meant: `⋃_S (T + A + Fin_S)`). -/
  E : Set (Dual F)
  /-- Its part `TA` (meant: `T + A = E_∅`). -/
  TA : Set (Dual F)
  /-- `E` is measurable. -/
  measurableSet_E : MeasurableSet E
  /-- `TA` is measurable. -/
  measurableSet_TA : MeasurableSet TA
  /-- `TA ⊆ E`. -/
  TA_subset_E : TA ⊆ E
  /-- `E` is stable under every rotation. -/
  rot_preimage_E : ∀ u : unitVectors F, rot u ⁻¹' E = E
  /-- The entropy-like function (meant: `h τ u = h_τ(u)`, Kolmogorov–Sinai entropy). -/
  h : Measure (Dual F) → unitVectors F → ENNReal

/-- The interface's model: everything empty or zero (the structure is inhabited; its content is in the `Prop`s below). -/
def Interface.trivial : Interface F where
  E := ∅
  TA := ∅
  measurableSet_E := MeasurableSet.empty
  measurableSet_TA := MeasurableSet.empty
  TA_subset_E := subset_refl _
  rot_preimage_E _ := Set.preimage_empty
  h _ _ := 0

variable {F}

/-- **R-U** (`plans/FS84-SI-D-derivation.md` §5.4, J45; blind J46): "every finite `U`-invariant measure on `R̂` gives
`E_S ∖ (T + A)` measure 0, for every finite `S`"; here in its union form, `τ(E ∖ (T + A)) = 0` (§4.1, "`E` is a countable union").
A hand result of ours ([hand], J45-RU), taken as a hypothesis: not in the kernel. -/
def Interface.RU (I : Interface F) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ → τ (I.E \ I.TA) = 0

/-- **A⁺ at `S = ∅`, remark (ii)** (§3, J45; blind X05V): for every rotation-invariant random proper four-colouring,
"`u ↦ ∫_{R̂∖E_S} χ(u) dσ_μ` is constant on `U`: strict at every `u`, in particular at `u = 1`". Rests on SI-3, SI-4, N2 and
R88-TCA at `S = ∅` (row 113). VACUITY NOTE: this `Prop` quantifies over `InvariantColouring`, which is empty exactly when the
headline's conclusion holds; its content is its derivation from R88-TCA, which never assumes that emptiness. A hand result of
ours ([hand], J45-A⁺), taken as a hypothesis: not in the kernel. -/
def Interface.APlus0 (I : Interface F) : Prop :=
  ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ →
    ∫ χ in I.TAᶜ, (χ 1 : ℂ).re ∂σ < 0

/-- **PE-2**, in the consequence form the chain uses (queue §2 list X02; X02D, X02V blind; over EL2021 Thm 1.2): "every
`U`-invariant finite positive measure `τ` on `R̂`: `τ = a·m + τ′` with `a ≥ 0`, `τ′` a `U`-invariant finite positive measure,
and `h_{τ′}(u) = 0` for every `u ∈ U`." The Haar part `a·m` is recorded by the two properties used: it is `E`-null (N1) and its
Fourier coefficients vanish off `0`. A hand result of ours ([hand]; X02D, X02V), taken as a hypothesis: not in the kernel. -/
def Interface.PE2 (I : Interface F) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ →
    ∃ τH τ' : Measure (Dual F), τ = τH + τ' ∧ RotInv F τ' ∧ τH I.E = 0 ∧
      (∀ r : unitRing F, r ≠ 0 → ∫ χ, (χ r : ℂ) ∂τH = 0) ∧ ∀ u, I.h τ' u = 0

/-- **EF_F⁺**, weakened to the form the chain uses (zero entropy at every `u`, where EF_F⁺ needs one non-torsion `u*`):
"every `U`-invariant finite positive Borel measure `μ` on `R̂` such that `h_μ(u*) = 0` for **one** non-torsion `u* ∈ U`
satisfies `μ(R̂ ∖ (T + A)) = 0`" (`plans/FS100-X01D-derivation.md` line 194; second derivation X12B). A hand result of ours
([hand]), taken as a hypothesis: not in the kernel. -/
def Interface.EFPlus (I : Interface F) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ → (∀ u, I.h τ u = 0) → τ I.TAᶜ = 0

/-- **MR**, Fourier form: every rotation-invariant `E`-null finite measure has vanishing Fourier coefficients off `0` (for
`a·m` they vanish; the converse is Fourier uniqueness on `R̂`). A hand result of ours ([hand], `LEDGER.md` row 120; from PE-2
and EF_F⁺ by `mr_of_pe2_efPlus`), taken as a hypothesis: not in the kernel. -/
def Interface.MR (I : Interface F) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ → τ I.E = 0 → ∀ r : unitRing F, r ≠ 0 → ∫ χ, (χ r : ℂ) ∂τ = 0

/-- **Node M** (`plans/FS100-X01D-derivation.md` §4.1): PE-2 and EF_F⁺ give MR. -/
theorem Interface.mr_of_pe2_efPlus (I : Interface F) (hPE : I.PE2) (hEF : I.EFPlus) : I.MR := by
  intro τ hfin hrot hE r hr
  obtain ⟨τH, τ', rfl, hrot', hHE, hHF, hh⟩ := hPE τ hfin hrot
  have hfin' : IsFiniteMeasure τ' := isFiniteMeasure_of_le (τH + τ') (Measure.le_add_left le_rfl)
  have hTAc : τ' I.TAᶜ = 0 := hEF τ' hfin' hrot' hh
  have hE' : τ' I.E = 0 := by
    rw [Measure.add_apply] at hE
    exact (add_eq_zero.mp hE).2
  have hTA : τ' I.TA = 0 := measure_mono_null I.TA_subset_E hE'
  have hzero : τ' = 0 := by
    rw [← Measure.measure_univ_eq_zero, ← Set.union_compl_self I.TA]
    exact measure_union_null hTA hTAc
  rw [hzero, add_zero]
  exact hHF r hr

/-- **Node L0**: a proper four-colouring of the plane restricts to `X₄(F)`. -/
theorem x4_nonempty_of_colorable (h : ((unitDistance ℂ).induce (planeOver F)).Colorable 4) : (X4 F).Nonempty := by
  obtain ⟨C⟩ := h
  have hsub : ∀ x : unitRing F, (x : ℂ) ∈ planeOver F := fun x =>
    UnitRing.unitRingOver_le_planeOverSubring F x.2
  refine ⟨fun x => C ⟨x, hsub x⟩, fun x y hxy => C.valid ?_⟩
  show dist (x : ℂ) (y : ℂ) = 1
  rw [dist_comm, Complex.dist_eq]
  exact hxy.2

/-- Evaluation at `y` is measurable on `R̂`. -/
theorem measurable_eval (y : unitRing F) : Measurable (fun χ : Dual F => (χ y : ℂ)) :=
  (measurable_pi_apply y).comp (comap_measurable (fun χ : Dual F => fun g : unitRing F => (χ g : ℂ)))

/-- Rotation is measurable on `R̂`. -/
theorem measurable_rot (u : unitVectors F) : Measurable (rot u) := by
  intro s ⟨t, ht, hts⟩
  have hΦ : Measurable (fun f : unitRing F → ℂ => fun r : unitRing F => f (uvRing u * r)) :=
    measurable_pi_lambda _ fun r => measurable_pi_apply _
  refine ⟨_, hΦ ht, ?_⟩
  rw [← hts]
  rfl

end Chain

/-! ## Part G: every real number field (X11K2's re-aim; X23D-COR, X23V §2.3–§2.4)

The general claim: **given MR, `χ(F²) ≥ min(L(F), 5)` for every real number field `F`**, from SPC (J45's A⁺ and SP-Cor over every
real number field where T-C(A) holds at `S = ∅`), CLS (T-C(A) at `S = ∅` ⟸ `L(F) ≥ 5`) and row 99 (`χ(F²) = L(F)` at `L ≤ 4`);
and `χ(F²) = L(F)` for `L ≤ 5` where the upper half `χ(F²) ≤ L(F)` holds (row 52 at ring level; the field step is row 57's gap).

**`L(F)` is stated with Mathlib's number-field API, not replaced by a substitute:** `L = F(i)` is the plane over `F` as a subfield
of `ℂ` (`fieldI`); a *stable prime* is a maximal ideal of `𝓞 L` fixed by complex conjugation (a place of `F` not split in
`F(i)`); its level-`m` target is the Cayley graph of `𝓞 L ⧸ P^m` on the elements `x` with `x·x̄ = 1`, `x̄` the induced involution
(`levelTarget`; at `m = 1` it is `Γ_q`, `U_Q` or a bipartite graph as `P` is odd inert, dyadic inert or dyadic ramified); and
`L(F)` is the infimum over stable primes of the level-one targets' chromatic numbers (`localBound`). T-C(A) at `S = ∅` is
`TCA`: every stable prime's targets have independence ratio at most some `c < 1/4` at every level. -/

section Every

variable (F : Subfield ℝ)

/-- **`L = F(i)`**: the plane over `F` as a subfield of `ℂ`, `UnitRing.planeOverSubfield`. -/
abbrev fieldI : Subfield ℂ := UnitRing.planeOverSubfield F

theorem mem_fieldI {z : ℂ} : z ∈ fieldI F ↔ z.re ∈ F ∧ z.im ∈ F := Iff.rfl

theorem fieldI_conj : ∀ z ∈ fieldI F, (starRingEnd ℂ) z ∈ fieldI F := UnitRing.conj_mem_planeOverSubfield F

/-- The ℚ-linear surjection `F × F → F(i)`, `(a, b) ↦ a + bi`. -/
noncomputable def toFieldI : (F × F) →ₗ[ℚ] fieldI F where
  toFun p := ⟨⟨p.1, p.2⟩, by simp, by simp⟩
  map_add' _ _ := Subtype.ext (Complex.ext (by simp) (by simp))
  map_smul' q p := Subtype.ext (Complex.ext (by simp [Rat.smul_def]) (by simp [Rat.smul_def]))

theorem toFieldI_surjective : Function.Surjective (toFieldI F) := fun z =>
  ⟨(⟨(z : ℂ).re, z.2.1⟩, ⟨(z : ℂ).im, z.2.2⟩), Subtype.ext (Complex.ext rfl rfl)⟩

/-- `F(i)` is a number field when `F` is. -/
instance [NumberField F] : NumberField (fieldI F) where
  to_finiteDimensional := Module.Finite.of_surjective (toFieldI F) (toFieldI_surjective F)

open NumberField

/-- Complex conjugation on the ring of integers of `F(i)`. -/
noncomputable def conjO : 𝓞 (fieldI F) →+* 𝓞 (fieldI F) := RingOfIntegers.mapRingHom (conjOn (fieldI_conj F))

/-- **A stable prime of `F(i)`**: a maximal ideal of `𝓞 L` fixed by conjugation — a place of `F` that does not split in `F(i)`. -/
structure StablePrime where
  /-- The maximal ideal of `𝓞 (F(i))`. -/
  P : Ideal (𝓞 (fieldI F))
  /-- It is maximal. -/
  isMaximal : P.IsMaximal
  /-- Conjugation fixes it. -/
  comap_conj : P.comap (conjO F) = P

variable {F}

theorem StablePrime.le_comap (P : StablePrime F) (m : ℕ) : P.P ^ m ≤ (P.P ^ m).comap (conjO F) := by
  calc P.P ^ m = (P.P.comap (conjO F)) ^ m := by rw [P.comap_conj]
    _ ≤ _ := Ideal.le_comap_pow _ m

/-- **The level-`m` residue target** at a stable prime: `Cay(𝓞 L ⧸ P^m, {x : x·x̄ = 1})`. -/
def levelTarget (P : StablePrime F) (m : ℕ) : SimpleGraph (𝓞 (fieldI F) ⧸ P.P ^ m) :=
  SimpleGraph.fromRel fun x y => (x - y) * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) (x - y) = 1

variable (F)

/-- **`L(F)`, the local bound**: the least chromatic number among the level-one residue targets of the stable primes
(`CLAUDE.md` § Notation). -/
noncomputable def localBound : ℕ∞ := ⨅ P : StablePrime F, (levelTarget P 1).chromaticNumber

/-- **T-C(A) at `S = ∅`, class form** (X23D §1.3): every stable place has all-levels four-colour ratio `< 1/4` — some `c < 1/4`
bounds `|I| / |𝓞 ⧸ P^m|` for every independent set `I` of every level's target. -/
def TCA : Prop :=
  ∀ P : StablePrime F, ∃ c : ℝ, c < 1 / 4 ∧ ∀ m : ℕ, 1 ≤ m → ∀ s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m),
    (levelTarget P m).IsIndepSet (s : Set _) → (s.card : ℝ) ≤ c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m)

variable {F}

/-- **R88-TCA at `S = ∅`** (row 113; spectral form, X23D §1.3): "no translation-invariant Borel probability on `X₄(F)` has
spectral measure carried by `T + A`" — here for the rotation-invariant ones SP-Cor uses (implied by the source). VACUITY NOTE
(G30 item 7): like `APlus0`, it quantifies over `InvariantColouring`, empty exactly when `X₄(F) = ∅`; its content is its
derivation from the class form, which never assumes that emptiness. -/
def Interface.R88TCA (I : Interface F) : Prop :=
  ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ → σ I.TAᶜ ≠ 0

/-- **A⁺ at `S = ∅` from R88-TCA** (J45: SI-3, SI-4, N2, then T-C(A) as a black box; field-free, X23V §2.3 "(lit)"). A hand
result of ours ([hand], J45), taken as a hypothesis: not in the kernel. -/
def Interface.APlusOfR88 (I : Interface F) : Prop := I.R88TCA → I.APlus0

/-- **The count**: in the class, R88-TCA at `S = ∅` holds (X23D-TCA; J28D's route: the extension to `G_∅`, C14.2 (a) with ratio
`m₁` at each archimedean factor, C14.3 over a finite product, Hoffman on the tail). [hand, X23D and X23V §2.3] **for totally real
`F`**; at a complex place of `F` its archimedean factor needs Lemma X23V-CX / X23D-CX (restriction to a real form); X29C ruled it (two derivations) against
X25B-G1: an upper bound on a factor's independence ratio survives removing edges, so `r(Cay(ℂ², {(a, a⁻¹)})) ≤ m₁ < 1/4`. -/
def Interface.Count (I : Interface F) : Prop := TCA F → I.R88TCA

end Every

noncomputable section Composition

variable {F : Subfield ℝ}

/-- **L1, the classical theorem in its own terms — a named hypothesis, true for every `F`.** "Every nonempty closed set of
colourings of `ℤ[U]`, stable under the shifts and the rotations, carries a probability measure invariant under both": the group
`ℤ[U] ⋊ U` is solvable, hence amenable, and acts by homeomorphisms on the compact space `(Fin 4)^{ℤ[U]}`, so it fixes a regular
Borel probability measure on the compact invariant set (Markov–Kakutani — `[Kakutani1938]`, not read — for `ℤ[U]`, then for
`U` on the `ℤ[U]`-invariant measures, which `U` preserves because it normalizes `ℤ[U]`); on the product σ-algebra a measurable
`K` then has `μ(Kᶜ) = 0`.
Not in Mathlib (no Markov–Kakutani, no invariant measures for amenable actions); X11K priced it at 100–200k harness tokens.
**Why `MeasurableSet K` is a hypothesis:** without it the statement is false when `ℤ[U]` is uncountable — a product-measurable
set depends on countably many coordinates, so no probability measure gives `X₄(F)ᶜ` measure zero (`plans/FS100-K-kernel-47.md`
§X11K3 Stage 2). `X₄(F)` is measurable when `ℤ[U]` is countable (`measurableSet_X4`), e.g. over a number field
(`countable_unitRing`). -/
def InvariantMeasureOnClosed (F : Subfield ℝ) : Prop :=
  ∀ K : Set (unitRing F → Fin 4), K.Nonempty → IsClosed K → MeasurableSet K →
    (∀ y : unitRing F, ∀ c ∈ K, (fun x => c (x + y)) ∈ K) →
    (∀ u : unitVectors F, ∀ c ∈ K, (fun x => c (uvRing u * x)) ∈ K) →
    ∃ μ : Measure (unitRing F → Fin 4), IsProbabilityMeasure μ ∧ μ Kᶜ = 0 ∧
      (∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ) ∧
      ∀ u : unitVectors F, μ.map (fun c x => c (uvRing u * x)) = μ

/-- `X₄(F)` as an intersection of one condition per pair. -/
theorem X4_eq_iInter : X4 F = ⋂ x : unitRing F, ⋂ y : unitRing F,
    {c : unitRing F → Fin 4 | (y : ℂ) - x ∈ unitVectors F → c x ≠ c y} := by
  ext c
  simp [X4]

/-- One pair's condition is a preimage of a set of pairs of colours. -/
theorem setOf_pair_eq (x y : unitRing F) : {c : unitRing F → Fin 4 | (y : ℂ) - x ∈ unitVectors F → c x ≠ c y} =
    (fun c : unitRing F → Fin 4 => (c x, c y)) ⁻¹' {p | (y : ℂ) - x ∈ unitVectors F → p.1 ≠ p.2} := rfl

/-- `X₄(F)` is closed in `(Fin 4)^{ℤ[U]}`. -/
theorem isClosed_X4 : IsClosed (X4 F) := by
  rw [X4_eq_iInter]
  exact isClosed_iInter fun x => isClosed_iInter fun y => by
    rw [setOf_pair_eq]
    exact IsClosed.preimage ((continuous_apply x).prodMk (continuous_apply y)) (isClosed_discrete _)

/-- `X₄(F)` is measurable when `ℤ[U]` is countable. -/
theorem measurableSet_X4 [Countable (unitRing F)] : MeasurableSet (X4 F) := by
  rw [X4_eq_iInter]
  exact MeasurableSet.iInter fun x => MeasurableSet.iInter fun y => by
    rw [setOf_pair_eq]
    exact ((measurable_pi_apply x).prodMk (measurable_pi_apply y)) (Set.to_countable _).measurableSet

/-- Shifts keep `X₄(F)`. -/
theorem shift_mem_X4 (y : unitRing F) (c : unitRing F → Fin 4) (hc : c ∈ X4 F) : (fun x => c (x + y)) ∈ X4 F :=
  fun x' y' h => hc (x' + y) (y' + y) (by
    have e : ((y' + y : unitRing F) : ℂ) - ((x' + y : unitRing F) : ℂ) = (y' : ℂ) - x' := by push_cast; ring
    rw [e]; exact h)

/-- Rotations keep `X₄(F)`: a product of unit vectors is a unit vector. -/
theorem rot_mem_X4 (u : unitVectors F) (c : unitRing F → Fin 4) (hc : c ∈ X4 F) :
    (fun x => c (uvRing u * x)) ∈ X4 F :=
  fun x' y' h => hc (uvRing u * x') (uvRing u * y') (by
    have e : ((uvRing u * y' : unitRing F) : ℂ) - ((uvRing u * x' : unitRing F) : ℂ) = (u : ℂ) * ((y' : ℂ) - x') := by
      push_cast; simp only [uvRing]; ring
    rw [e]
    exact ⟨(Chain.planeOverSubring F).mul_mem u.2.1 h.1, by rw [norm_mul, u.2.2, h.2, one_mul]⟩)

/-- **Node L1, from the classical theorem**: when `ℤ[U]` is countable, `X₄(F) ≠ ∅` gives an invariant random colouring. -/
theorem exists_invariantColouring (hL1 : InvariantMeasureOnClosed F) [Countable (unitRing F)] (h : (X4 F).Nonempty) :
    Nonempty (InvariantColouring F) := by
  obtain ⟨μ, hp, hK, hs, hr⟩ := hL1 (X4 F) h isClosed_X4 measurableSet_X4 shift_mem_X4 rot_mem_X4
  exact ⟨⟨μ, hp, hK, hs, hr⟩⟩

/-- `ℤ[U]` is countable when `F` is: it lies in `F(i) ≅ F × F`. -/
theorem countable_unitRing [Countable F] : Countable (unitRing F) := by
  have hsub : ∀ x : unitRing F, (x : ℂ) ∈ planeOver F := fun x => UnitRing.unitRingOver_le_planeOverSubring F x.2
  refine Function.Injective.countable
    (f := fun x : unitRing F => ((⟨(x : ℂ).re, (hsub x).1⟩ : F), (⟨(x : ℂ).im, (hsub x).2⟩ : F))) ?_
  intro x y hxy
  simp only [Prod.mk.injEq, Subtype.mk.injEq] at hxy
  exact Subtype.ext (Complex.ext hxy.1 hxy.2)

/-- The tetrahedron's `±1` coordinates: vertex `i` is column `i` of `(1,1,−1,−1; 1,−1,1,−1; 1,−1,−1,1)`. -/
def tetW (k : Fin 3) (i : Fin 4) : ℝ := ![![1, 1, -1, -1], ![1, -1, 1, -1], ![1, -1, -1, 1]] k i

/-- **The tetrahedral Gram identity**: `⟨e_i, e_j⟩ = (1/3) Σ_k w_k(i) w_k(j)`. -/
theorem tetra_eq (i j : Fin 4) : tetra i j = 1 / 3 * ∑ k : Fin 3, tetW k i * tetW k j := by
  fin_cases i <;> fin_cases j <;> simp [tetra, tetW, Fin.sum_univ_three] <;> norm_num

theorem tetra_comm (i j : Fin 4) : tetra i j = tetra j i := by
  rw [tetra_eq, tetra_eq]
  simp only [mul_comm (tetW _ i)]

theorem abs_tetra_le (i j : Fin 4) : ‖tetra i j‖ ≤ 1 := by
  unfold tetra
  split_ifs <;> norm_num

/-- **Shift invariance of the correlation**: `C(x − y) = E_μ⟨g(x), g(y)⟩`. -/
theorem corr_sub (μ : InvariantColouring F) (x y : unitRing F) :
    corr F μ.μ (x - y) = ∫ c, tetra (c x) (c y) ∂μ.μ := by
  have hφ : Measurable (fun (c : unitRing F → Fin 4) (t : unitRing F) => c (t + y)) :=
    measurable_pi_lambda _ fun t => measurable_pi_apply _
  have hm : Measurable (fun c : unitRing F → Fin 4 => tetra (c 0) (c (x - y))) :=
    (measurable_of_countable (fun p : Fin 4 × Fin 4 => tetra p.1 p.2)).comp
      (f := fun c : unitRing F → Fin 4 => (c 0, c (x - y))) ((measurable_pi_apply 0).prodMk (measurable_pi_apply (x - y)))
  calc corr F μ.μ (x - y) = ∫ c, tetra (c 0) (c (x - y)) ∂(μ.μ.map (fun c t => c (t + y))) := by
        rw [μ.shift_inv y]; rfl
    _ = ∫ c, tetra (c (0 + y)) (c (x - y + y)) ∂μ.μ := integral_map hφ.aemeasurable hm.aestronglyMeasurable
    _ = ∫ c, tetra (c x) (c y) ∂μ.μ := by
        congr 1; funext c; rw [zero_add, sub_add_cancel, tetra_comm]

/-- **Node L2's input**: the correlation of an invariant random colouring is positive definite. -/
theorem posDef_corr (μ : InvariantColouring F) : PosDef (fun y => (corr F μ.μ y : ℂ)) := by
  intro s z
  haveI := μ.isProb
  have hmeas : ∀ x y : unitRing F, Measurable (fun c : unitRing F → Fin 4 => tetra (c x) (c y)) := fun x y =>
    (measurable_of_countable (fun p : Fin 4 × Fin 4 => tetra p.1 p.2)).comp
      (f := fun c : unitRing F → Fin 4 => (c x, c y)) ((measurable_pi_apply x).prodMk (measurable_pi_apply y))
  have hint : ∀ x y : unitRing F, Integrable (fun c : unitRing F → Fin 4 => z x * star (z y) * (tetra (c x) (c y) : ℂ)) μ.μ :=
    fun x y => ((Integrable.mono' (integrable_const (1 : ℝ)) (hmeas x y).aestronglyMeasurable
      (ae_of_all _ fun c => abs_tetra_le _ _)).ofReal).const_mul _
  -- the Gram identity, pointwise: `Σ_x Σ_y z_x z̄_y ⟨e_{c x}, e_{c y}⟩ = (1/3) Σ_k |Σ_x z_x w_k(c x)|²`
  set G : (unitRing F → Fin 4) → ℝ := fun c => ∑ k : Fin 3, 1 / 3 * Complex.normSq (∑ x ∈ s, z x * (tetW k (c x) : ℂ))
    with hG
  have hpt : ∀ c : unitRing F → Fin 4,
      ∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * (tetra (c x) (c y) : ℂ) = (G c : ℂ) := by
    intro c
    have e1 : ∀ x y, z x * star (z y) * (tetra (c x) (c y) : ℂ) =
        ∑ k : Fin 3, (1 / 3 : ℂ) * ((z x * (tetW k (c x) : ℂ)) * star (z y * (tetW k (c y) : ℂ))) := by
      intro x y
      rw [tetra_eq]
      push_cast
      rw [Finset.mul_sum, Finset.mul_sum]
      refine Finset.sum_congr rfl fun k _ => ?_
      simp only [star_mul', Complex.star_def, Complex.conj_ofReal]
      ring
    have e2 : (G c : ℂ) = ∑ k : Fin 3, ∑ x ∈ s, ∑ y ∈ s,
        (1 / 3 : ℂ) * ((z x * (tetW k (c x) : ℂ)) * star (z y * (tetW k (c y) : ℂ))) := by
      rw [hG]
      push_cast
      refine Finset.sum_congr rfl fun k _ => ?_
      rw [← Complex.mul_conj, ← Complex.star_def, star_sum, Finset.sum_mul_sum, Finset.mul_sum]
      refine Finset.sum_congr rfl fun x _ => ?_
      rw [Finset.mul_sum]
    rw [e2]
    conv_rhs => rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun x _ => ?_
    conv_rhs => rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun y _ => e1 x y
  -- move the sums inside the integral
  have key : ∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * (corr F μ.μ (x - y) : ℂ) = ((∫ c, G c ∂μ.μ : ℝ) : ℂ) := by
    have h1 : ∀ x y, z x * star (z y) * (corr F μ.μ (x - y) : ℂ) =
        ∫ c, z x * star (z y) * (tetra (c x) (c y) : ℂ) ∂μ.μ := by
      intro x y
      rw [corr_sub, integral_const_mul, integral_complex_ofReal]
    have h2 : ∀ x, ∑ y ∈ s, ∫ c, z x * star (z y) * (tetra (c x) (c y) : ℂ) ∂μ.μ =
        ∫ c, ∑ y ∈ s, z x * star (z y) * (tetra (c x) (c y) : ℂ) ∂μ.μ :=
      fun x => (integral_finsetSum s fun y _ => hint x y).symm
    simp only [h1, h2]
    rw [← integral_finsetSum s fun x _ => integrable_finsetSum s fun y _ => hint x y, ← integral_complex_ofReal]
    exact integral_congr_ae (ae_of_all _ hpt)
  have hG0 : 0 ≤ ∫ c, G c ∂μ.μ :=
    integral_nonneg fun c => Finset.sum_nonneg fun k _ => mul_nonneg (by norm_num) (Complex.normSq_nonneg _)
  rw [key]
  exact ⟨Complex.ofReal_im _, by rw [Complex.ofReal_re]; exact hG0⟩

/-- **Node L3**: the trace spectral measure is rotation-invariant (`C(uy) = C(y)`, and uniqueness). -/
theorem rotInv_of_isTraceSpectral (hBH : BochnerHerglotz (unitRing F)) (μ : InvariantColouring F) {σ : Measure (Dual F)}
    (hσ : IsTraceSpectral F μ.μ σ) : RotInv F σ := by
  intro u
  obtain ⟨σ₀, -, -, huniq⟩ := hBH _ (posDef_corr μ)
  have hρ : Measurable (fun (c : unitRing F → Fin 4) (x : unitRing F) => c (uvRing u * x)) :=
    measurable_pi_lambda _ fun x => measurable_pi_apply _
  have hcorr : ∀ y, corr F μ.μ (uvRing u * y) = corr F μ.μ y := by
    intro y
    have hm : Measurable (fun c : unitRing F → Fin 4 => tetra (c 0) (c y)) :=
      (measurable_of_countable (fun p : Fin 4 × Fin 4 => tetra p.1 p.2)).comp
        (f := fun c : unitRing F → Fin 4 => (c 0, c y)) ((measurable_pi_apply 0).prodMk (measurable_pi_apply y))
    calc corr F μ.μ (uvRing u * y)
        = ∫ c, (fun c' : unitRing F → Fin 4 => tetra (c' 0) (c' y)) (fun x => c (uvRing u * x)) ∂μ.μ := by
          unfold corr; congr 1; funext c; simp only [mul_zero]
      _ = ∫ c', tetra (c' 0) (c' y) ∂(μ.μ.map (fun c x => c (uvRing u * x))) :=
          (integral_map hρ.aemeasurable hm.aestronglyMeasurable).symm
      _ = corr F μ.μ y := by rw [μ.rot_inv u]; rfl
  have hmap : ∀ y, ∫ χ, (χ y : ℂ) ∂(σ.map (rot u)) = (corr F μ.μ y : ℂ) := by
    intro y
    rw [integral_map (measurable_rot u).aemeasurable (measurable_eval y).aestronglyMeasurable]
    show ∫ χ, (χ (uvRing u * y) : ℂ) ∂σ = _
    rw [hσ.2, hcorr]
  haveI := hσ.1
  rw [huniq _ inferInstance hmap, huniq σ hσ.1 hσ.2]

/-- **Node L6, SP-Cor** (`plans/FS84-SI-D-derivation.md` §4.2): given Herglotz–Bochner, R-U, A⁺ at `S = ∅` and MR, the
plane over `F` has no proper four-colouring of `Cay(R, U)`. -/
theorem Interface.x4_eq_empty (I : Interface F) (hBH : BochnerHerglotz (unitRing F)) (hL1 : InvariantMeasureOnClosed F)
    [Countable (unitRing F)] (hRU : I.RU) (hA : I.APlus0) (hMR : I.MR) : X4 F = ∅ := by
  by_contra hne
  obtain ⟨μ⟩ := exists_invariantColouring hL1 (Set.nonempty_iff_ne_empty.mpr hne)
  obtain ⟨σ, hσfin, hσ, -⟩ := hBH _ (posDef_corr μ)
  have hTS : IsTraceSpectral F μ.μ σ := ⟨hσfin, hσ⟩
  have hrot := rotInv_of_isTraceSpectral hBH μ hTS
  -- the evaluation `χ ↦ χ 1` is measurable, and bounded by `1`
  have hev := measurable_eval (F := F) 1
  have hint : ∀ ν : Measure (Dual F), IsFiniteMeasure ν → Integrable (fun χ : Dual F => (χ 1 : ℂ)) ν := by
    intro ν _
    refine Integrable.of_bound hev.aestronglyMeasurable 1 (Filter.Eventually.of_forall fun χ => ?_)
    simp
  -- `τ := σ|_{Eᶜ}`: rotation-invariant, finite, `E`-null
  have hmrot := measurable_rot (F := F)
  have hτrot : RotInv F (σ.restrict I.Eᶜ) := by
    intro u
    have hpre : rot u ⁻¹' I.Eᶜ = I.Eᶜ := by rw [Set.preimage_compl, I.rot_preimage_E u]
    conv_lhs => rw [← hpre]
    rw [← Measure.restrict_map (hmrot u) I.measurableSet_E.compl, hrot u]
  have hτE : (σ.restrict I.Eᶜ) I.E = 0 := by
    rw [Measure.restrict_apply I.measurableSet_E, Set.inter_compl_self, measure_empty]
  have hMRτ := hMR _ inferInstance hτrot hτE 1 one_ne_zero
  -- A⁺ and R-U: `∫_{TAᶜ} = ∫_{Eᶜ} + ∫_{E∖TA}`, the second over a null set
  have hAμ := hA μ σ hTS
  have hnull : σ (I.E \ I.TA) = 0 := hRU σ hσfin hrot
  have hsplit : I.TAᶜ = I.Eᶜ ∪ (I.E \ I.TA) := by
    ext χ
    simp only [Set.mem_compl_iff, Set.mem_union, Set.mem_sdiff]
    constructor
    · intro h
      by_cases h1 : χ ∈ I.E
      · exact Or.inr ⟨h1, h⟩
      · exact Or.inl h1
    · rintro (h | ⟨-, h⟩)
      · exact fun h' => h (I.TA_subset_E h')
      · exact h
  have hre : ∫ χ in I.Eᶜ, (χ 1 : ℂ).re ∂σ = 0 := by
    have h := integral_re (𝕜 := ℂ) (hint (σ.restrict I.Eᶜ) inferInstance)
    simp only [RCLike.re_to_complex] at h
    rw [h, hMRτ, Complex.zero_re]
  have hint' : Integrable (fun χ : Dual F => (χ 1 : ℂ).re) σ := by
    simpa only [RCLike.re_to_complex] using (hint σ hσfin).re
  rw [hsplit, setIntegral_union (disjoint_compl_left.mono_right Set.sdiff_subset)
    (I.measurableSet_E.diff I.measurableSet_TA) hint'.integrableOn hint'.integrableOn,
    hre, setIntegral_measure_zero _ hnull, add_zero] at hAμ
  exact lt_irrefl 0 hAμ

/-- **The lower half**: `χ(F²) ≥ 5` from the chain. -/
theorem Interface.five_le_chromaticNumber (I : Interface F) (hBH : BochnerHerglotz (unitRing F))
    (hL1 : InvariantMeasureOnClosed F) [Countable (unitRing F)] (hRU : I.RU)
    (hA : I.APlus0) (hPE : I.PE2) (hEF : I.EFPlus) :
    5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  have h := (add_one_le_chromaticNumber_iff_not_colorable
    (G := (unitDistance ℂ).induce (planeOver F)) (n := 4)).mpr fun hc => by
    have hne := x4_nonempty_of_colorable hc
    rw [I.x4_eq_empty hBH hL1 hRU hA (I.mr_of_pe2_efPlus hPE hEF)] at hne
    exact Set.not_nonempty_empty hne
  exact_mod_cast h

end Composition

section Headline

variable {F : Subfield ℝ}

/-- **THE HEADLINE (X11K2's re-aim, Kooshi's "every real" target): every real number field**, the complex-place step behind its
own hypothesis (X23D-COR, X23V §2.4, X29C's ruling):
`χ(F²) ≥ min(L(F), 5)` given
- `hTR` — **the count for totally real `F`** (X23D-TCA; X23V §2.3);
- `hCX` — **the count for `F` with a complex place** (Lemma X23V-CX; ruled by X29C: edge-removal monotonicity, formalizable, and
  `m₁` external);
- `hAP` — A⁺ from R88-TCA (J45, field-free); `hRU` — R-U (J45, every real number field);
- `hMR` — in the class, **MR(F)** as PE-2 and EF_F⁺ (scope: row 100's exception, which `TCA F` excludes — a ramified stable dyadic
  place has ratio `1/2`);
- `hCLS` — **CLS**'s `⟸`: `L(F) ≥ 5 ⟹ TCA F` (X23D-CLS, X23V §2.2); `hRow99` — **row 99** at `L ≤ 4`; `hBH` — Herglotz–Bochner. -/
theorem min_localBound_five_le_chromaticNumber [NumberField F] (hBH : BochnerHerglotz (unitRing F))
    (hL1 : InvariantMeasureOnClosed F) (I : Interface F) (hTR : NumberField.IsTotallyReal F → I.Count) (hCX : ¬ NumberField.IsTotallyReal F → I.Count)
    (hAP : I.APlusOfR88) (hRU : I.RU) (hMR : TCA F → I.PE2 ∧ I.EFPlus) (hCLS : 5 ≤ localBound F → TCA F)
    (hRow99 : localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber) :
    min (localBound F) 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  by_cases h5 : 5 ≤ localBound F
  · have hT := hCLS h5
    have hC : I.Count := by
      by_cases hr : NumberField.IsTotallyReal F
      · exact hTR hr
      · exact hCX hr
    obtain ⟨hPE, hEF⟩ := hMR hT
    exact min_le_of_right_le (I.five_le_chromaticNumber hBH hL1 hRU (hAP (hC hT)) hPE hEF)
  · have h4 : localBound F ≤ 4 := Order.le_of_lt_succ (not_le.mp h5)
    exact min_le_of_left_le (hRow99 h4)

/-- **The staging form: every totally real number field.** `χ(F²) ≥ min(L(F), 5)`, given the count (X23D-TCA),
A⁺ from R88-TCA and R-U (J45), MR(F) in the class (PE-2 over EL2021 Thm 1.2; EF_F⁺), CLS, row 99 at `L ≤ 4` and
Herglotz–Bochner. The complex-place hypothesis of `..._of_complexStep` is discharged vacuously by `IsTotallyReal`. -/
theorem min_localBound_five_le_chromaticNumber_of_totallyReal [NumberField F] [NumberField.IsTotallyReal F]
    (hBH : BochnerHerglotz (unitRing F)) (hL1 : InvariantMeasureOnClosed F) (I : Interface F) (hCount : I.Count) (hAP : I.APlusOfR88) (hRU : I.RU)
    (hMR : TCA F → I.PE2 ∧ I.EFPlus) (hCLS : 5 ≤ localBound F → TCA F)
    (hRow99 : localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber) :
    min (localBound F) 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  min_localBound_five_le_chromaticNumber hBH hL1 I (fun _ => hCount)
    (fun h => (h inferInstance).elim) hAP hRU hMR hCLS hRow99

/-- **`χ(F²) = L(F)` for `L(F) ≤ 5`, every totally real number field**, given the headline's inputs and the upper half
`χ(F²) ≤ L(F)` (row 52 at ring level; the field step is row 57's gap), named `hUpper`. -/
theorem chromaticNumber_eq_localBound [NumberField F] [NumberField.IsTotallyReal F]
    (hBH : BochnerHerglotz (unitRing F)) (hL1 : InvariantMeasureOnClosed F) (I : Interface F) (hCount : I.Count) (hAP : I.APlusOfR88) (hRU : I.RU)
    (hMR : TCA F → I.PE2 ∧ I.EFPlus) (hCLS : 5 ≤ localBound F → TCA F)
    (hRow99 : localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber)
    (hUpper : ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ localBound F) (hL : localBound F ≤ 5) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = localBound F :=
  le_antisymm hUpper (by
    have := min_localBound_five_le_chromaticNumber_of_totallyReal hBH hL1 I hCount hAP hRU hMR hCLS hRow99
    rwa [min_eq_left hL] at this)

end Headline

-- Spec for Part G.
example : Complex.I ∈ fieldI (⊥ : Subfield ℝ) := ⟨by simp [zero_mem], by simp [one_mem]⟩
example : ((1 : ℂ) + Complex.I) ∈ fieldI (⊥ : Subfield ℝ) := ⟨by simp [one_mem], by simp [one_mem]⟩

/-! ## Spec -/

example : tetra 0 0 = 1 := by simp [tetra]
example : tetra 0 1 = -1 / 3 := by simp [tetra]
example : (Interface.trivial (⊥ : Subfield ℝ)).E = ∅ := rfl

end HadwigerNelson.SpectralChain
