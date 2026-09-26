import Proofs.HadwigerNelson.UnitRing
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

**Not here:** the SP-Cor composition (node L6) and the headline wait on two leaves in the skeleton
`data/fs100/x11k/skeleton/Sqrt47.lean` (`plans/FS100-K-kernel-47.md` §X11K3). **Inhabitants:** `Interface.trivial`
inhabits `Interface`; `InvariantColouring F` is inhabited whenever `X₄(F) ≠ ∅` by L1 (Markov–Kakutani, a skeleton leaf), and
`X₄(ℚ) ≠ ∅` since `ℚ²` is two-colourable — so no theorem here quantifies over a provably empty domain for every `F`.
-/

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
measure on the dual group" (Rudin, *Fourier Analysis on Groups* 1.4.3; not quoted from a held copy); uniqueness is the injectivity
of the Fourier–Stieltjes transform (Rudin 1.3.6). Mathlib lacks both for groups (it has `Measure.ext_of_charFun` on
inner-product spaces). -/
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
`E_S ∖ (T + A)` measure 0, for every finite `S`"; here in its union form, `τ(E ∖ (T + A)) = 0` (§4.1, "`E` is a countable union"). -/
def Interface.RU (I : Interface F) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ → τ (I.E \ I.TA) = 0

/-- **A⁺ at `S = ∅`, remark (ii)** (§3, J45; blind X05V): for every rotation-invariant random proper four-colouring,
"`u ↦ ∫_{R̂∖E_S} χ(u) dσ_μ` is constant on `U`: strict at every `u`, in particular at `u = 1`". Rests on SI-3, SI-4, N2 and
R88-TCA at `S = ∅` (row 113). VACUITY NOTE: this `Prop` quantifies over `InvariantColouring`, which is empty exactly when the
headline's conclusion holds; its content is its derivation from R88-TCA, which never assumes that emptiness. -/
def Interface.APlus0 (I : Interface F) : Prop :=
  ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ →
    ∫ χ in I.TAᶜ, (χ 1 : ℂ).re ∂σ < 0

/-- **PE-2**, in the consequence form the chain uses (queue §2 list X02; X02D, X02V blind; over EL2021 Thm 1.2): "every
`U`-invariant finite positive measure `τ` on `R̂`: `τ = a·m + τ′` with `a ≥ 0`, `τ′` a `U`-invariant finite positive measure,
and `h_{τ′}(u) = 0` for every `u ∈ U`." The Haar part `a·m` is recorded by the two properties used: it is `E`-null (N1) and its
Fourier coefficients vanish off `0`. -/
def Interface.PE2 (I : Interface F) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ →
    ∃ τH τ' : Measure (Dual F), τ = τH + τ' ∧ RotInv F τ' ∧ τH I.E = 0 ∧
      (∀ r : unitRing F, r ≠ 0 → ∫ χ, (χ r : ℂ) ∂τH = 0) ∧ ∀ u, I.h τ' u = 0

/-- **EF_F⁺**, weakened to the form the chain uses (zero entropy at every `u`, where EF_F⁺ needs one non-torsion `u*`):
"every `U`-invariant finite positive Borel measure `μ` on `R̂` such that `h_μ(u*) = 0` for **one** non-torsion `u* ∈ U`
satisfies `μ(R̂ ∖ (T + A)) = 0`" (`plans/FS100-X01D-derivation.md` line 194; second derivation X12B). -/
def Interface.EFPlus (I : Interface F) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ → (∀ u, I.h τ u = 0) → τ I.TAᶜ = 0

/-- **MR**, Fourier form: every rotation-invariant `E`-null finite measure has vanishing Fourier coefficients off `0` (for
`a·m` they vanish; the converse is Fourier uniqueness on `R̂`). -/
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

/-- **A⁺ at `S = ∅` from R88-TCA** (J45: SI-3, SI-4, N2, then T-C(A) as a black box; field-free, X23V §2.3 "(lit)"). -/
def Interface.APlusOfR88 (I : Interface F) : Prop := I.R88TCA → I.APlus0

/-- **The count**: in the class, R88-TCA at `S = ∅` holds (X23D-TCA; J28D's route: the extension to `G_∅`, C14.2 (a) with ratio
`m₁` at each archimedean factor, C14.3 over a finite product, Hoffman on the tail). [hand, X23D and X23V §2.3] **for totally real
`F`**; at a complex place of `F` its archimedean factor needs Lemma X23V-CX / X23D-CX (restriction to a real form); X29C ruled it (two derivations) against
X25B-G1: an upper bound on a factor's independence ratio survives removing edges, so `r(Cay(ℂ², {(a, a⁻¹)})) ≤ m₁ < 1/4`. -/
def Interface.Count (I : Interface F) : Prop := TCA F → I.R88TCA

end Every

-- Spec for Part G.
example : Complex.I ∈ fieldI (⊥ : Subfield ℝ) := ⟨by simp [zero_mem], by simp [one_mem]⟩
example : ((1 : ℂ) + Complex.I) ∈ fieldI (⊥ : Subfield ℝ) := ⟨by simp [one_mem], by simp [one_mem]⟩

/-! ## Spec -/

example : tetra 0 0 = 1 := by simp [tetra]
example : tetra 0 1 = -1 / 3 := by simp [tetra]
example : (Interface.trivial (⊥ : Subfield ℝ)).E = ∅ := rfl

end HadwigerNelson.SpectralChain
