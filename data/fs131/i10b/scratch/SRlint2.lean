import Mathlib.MeasureTheory.Measure.Prod
import Mathlib.MeasureTheory.Group.Convolution
import Mathlib.MeasureTheory.Measure.Haar.Basic
import Mathlib.Topology.Algebra.OpenSubgroup
import Mathlib.Dynamics.Ergodic.MeasurePreserving
import Mathlib.MeasureTheory.Measure.ContinuousPreimage
import Mathlib.MeasureTheory.Integral.Lebesgue.DominatedConvergence
import Mathlib.Tactic.Linter.Lint
import Batteries.Tactic.Lint

/-!
# The stationary ratio of a Cayley graph on a measurable group (FS-131 wave 10; X25B-PZ, X25B-L1)

**Read aloud, against the informal claim.** `plans/FS100-X25B-derivation.md` § Stage 2: for a group `G` with a symmetric
measure `ν` (the connection set and its measure), a measurable `W ⊆ G` is *a.e.-independent* if almost no pair `(x, x + t)`,
`t` drawn from `ν`, lies in `W`; the *stationary ratio* `r(G, ν)` is the supremum of `P(0 ∈ W)` over stationary random
a.e.-independent sets `W`.

**The model.** A stationary random set is a probability space with a measure-preserving, jointly measurable action of `G`
and an event `B`: the random set is `W_ω = {x : T_x ω ∈ B}`, and `P(0 ∈ W) = P(B)` (`StationarySet`). Its being a.e.-independent
almost surely is, by stationarity and Tonelli, one equation at the origin: `(ν × P){(t, ω) : ω ∈ B, T_t ω ∈ B} = 0`
(`StationarySet.AEIndependent`) — no Haar measure on `G` enters the definition, so the rows are stated for measurable groups
and σ-finite symmetric `ν`, a wider class than the entry's "LCA Cayley graphs".

**The rows.**
* **X25B-PZ** (`ratio_prod_le`): `r(G × H, ν_G × ν_H) ≤ max(r(G, ν_G), r(H, ν_H))` — Zhang's count at the origin; its child
  `prob_le_ratio_mul` is X25B-P (Zhang's Prop. 1.7, stationary form), a lemma of the same job and not a backlog row.
* **X25B-L1** (`ratio_prod_le_iSup_levels`): for a compact `Y` with open subgroups `K_k` shrinking to `0`,
  `r(X × Y, ν_X × ν_Y) ≤ sup_k r(X × Y, ν_X × (ν_Y ∗ m_{K_k}))`. The level-`k` graph `X × Y/K_k` is stated **pulled back to
  `X × Y`** — connection measure `ν_Y` smoothed by the Haar probability of `K_k` — so no quotient system is needed: a
  stationary set independent for the smoothed measure is `K_k`-invariant up to a larger independent one.

**Inhabitant.** `StationarySet.empty` (one point, the empty event) is a.e.-independent for every `ν`
(`StationarySet.empty_aeIndependent`); a model with `P(B) = 1/2` is `ZMod 2` acting on itself with `B = {0}`, `ν = δ₁`.
-/

namespace HadwigerNelson.StationaryRatio

open MeasureTheory

open scoped symmDiff

/-- **A stationary random set in `G`**: a probability space with a jointly measurable measure-preserving action of `G` and an
event `B`; the random set is `W_ω = {x | T x ω ∈ B}`. -/
structure StationarySet (G : Type*) [AddCommGroup G] [MeasurableSpace G] where
  /-- The sample space. -/
  Ω : Type
  /-- Its σ-algebra. -/
  [mΩ : MeasurableSpace Ω]
  /-- The probability. -/
  P : Measure Ω
  /-- It is a probability measure. -/
  isProb : IsProbabilityMeasure P
  /-- The action of `G`. -/
  T : G → Ω → Ω
  /-- It is jointly measurable. -/
  measurable_T : Measurable fun p : G × Ω => T p.1 p.2
  /-- Each `T x` preserves `P`. -/
  preserving : ∀ x, MeasurePreserving (T x) P P
  /-- `T 0 = id`. -/
  T_zero : T 0 = id
  /-- `T (x + y) = T x ∘ T y`. -/
  T_add : ∀ x y, T (x + y) = T x ∘ T y
  /-- The event "the origin is in the set". -/
  B : Set Ω
  /-- It is measurable. -/
  measurableSet_B : MeasurableSet B

attribute [instance] StationarySet.mΩ StationarySet.isProb

variable {G : Type*} [AddCommGroup G] [MeasurableSpace G]

/-- **Almost surely a.e.-independent**, read at the origin: almost no `(t, ω)` has both `0` and `t` in the set. -/
def StationarySet.AEIndependent (W : StationarySet G) (ν : Measure G) : Prop :=
  (ν.prod W.P) {p | p.2 ∈ W.B ∧ W.T p.1 p.2 ∈ W.B} = 0

/-- `N(W)` at the origin: the origin has a `ν`-positive set of neighbours in the set. -/
def StationarySet.nbhd (W : StationarySet G) (ν : Measure G) : Set W.Ω := {ω | 0 < ν {t | W.T (-t) ω ∈ W.B}}

/-- **The stationary ratio** `r(G, ν)`: the supremum of `P(0 ∈ W)` over stationary random a.e.-independent sets. -/
noncomputable def ratio (ν : Measure G) : ENNReal := ⨆ (W : StationarySet G) (_ : W.AEIndependent ν), W.P W.B

/-- The trivial stationary set: one point, the empty event. -/
noncomputable def StationarySet.empty (G : Type*) [AddCommGroup G] [MeasurableSpace G] : StationarySet G where
  Ω := Unit
  P := Measure.dirac ()
  isProb := Measure.dirac.isProbabilityMeasure
  T _ := id
  measurable_T := measurable_snd
  preserving _ := MeasurePreserving.id _
  T_zero := rfl
  T_add _ _ := rfl
  B := ∅
  measurableSet_B := MeasurableSet.empty

theorem StationarySet.empty_aeIndependent (ν : Measure G) : (StationarySet.empty G).AEIndependent ν := by
  show (ν.prod (Measure.dirac ())) {p : G × Unit | p.2 ∈ (∅ : Set Unit) ∧ id p.2 ∈ (∅ : Set Unit)} = 0
  simp

/-- A stationary a.e.-independent set has probability at most the ratio. -/
theorem StationarySet.prob_le_ratio (W : StationarySet G) {ν : Measure G} (hW : W.AEIndependent ν) : W.P W.B ≤ ratio ν :=
  le_iSup₂ (f := fun (W : StationarySet G) (_ : W.AEIndependent ν) => W.P W.B) W hW

/-! ## The toolkit (FS131-I10B): shifts, the event "positively many shifts land in `D`", and Tonelli

Every step of the three rows is one of four moves on almost-sure statements: shift the sample point (`ae_T_iff`), reflect the
connection measure (`ae_neg_iff`), exchange "for almost every shift" with "almost surely" (`ae_nb_iff`, Tonelli), and pass to a
system with the same action and another event (`pull`, `couple`). -/

/-- A symmetric measure sees a property and its reflection alike. -/
theorem ae_neg_iff [MeasurableNeg G] {ν : Measure G} (hsymm : ν.map Neg.neg = ν) {p : G → Prop} :
    (∀ᵐ t ∂ν, p (-t)) ↔ ∀ᵐ t ∂ν, p t := by
  have hmp : MeasurePreserving (Neg.neg : G → G) ν ν := ⟨measurable_neg, hsymm⟩
  refine ⟨fun h => ?_, fun h => hmp.quasiMeasurePreserving.ae h⟩
  have h' := hmp.quasiMeasurePreserving.ae h
  simpa only [neg_neg] using h'

/-- The ratio is at most `1`. -/
theorem ratio_le_one (ν : Measure G) : ratio ν ≤ 1 := iSup₂_le fun _ _ => prob_le_one

/-- A bound on every competitor's share, scaled, bounds the ratio, scaled. -/
theorem ratio_mul_le {ν : Measure G} {c b : ENNReal}
    (h : ∀ S : StationarySet G, S.AEIndependent ν → S.P S.B * c ≤ b) : ratio ν * c ≤ b := by
  unfold ratio
  simp only [ENNReal.iSup_mul]
  exact iSup₂_le h

namespace StationarySet

variable (W : StationarySet G)

theorem T_add_apply (x y : G) (ω : W.Ω) : W.T (x + y) ω = W.T x (W.T y ω) := congrFun (W.T_add x y) ω

theorem T_zero_apply (ω : W.Ω) : W.T 0 ω = ω := congrFun W.T_zero ω

theorem T_neg_T (x : G) (ω : W.Ω) : W.T (-x) (W.T x ω) = ω := by
  rw [← W.T_add_apply, neg_add_cancel, W.T_zero_apply]

theorem T_T_neg (x : G) (ω : W.Ω) : W.T x (W.T (-x) ω) = ω := by
  rw [← W.T_add_apply, add_neg_cancel, W.T_zero_apply]

theorem measurable_T_apply (x : G) : Measurable (W.T x) := (W.preserving x).measurable

section Param

variable {Z : Type*} [MeasurableSpace Z] (κ : Measure Z) {e : Z → G} {C D : Set W.Ω}

theorem measurable_T_comp (he : Measurable e) : Measurable fun p : Z × W.Ω => W.T (e p.1) p.2 :=
  W.measurable_T.comp ((he.comp measurable_fst).prodMk measurable_snd)

theorem measurable_T_left (he : Measurable e) (ω : W.Ω) : Measurable fun z : Z => W.T (e z) ω :=
  W.measurable_T.comp (he.prodMk measurable_const)

/-- A property holds almost surely after a shift iff it holds almost surely. -/
theorem ae_T_iff (x : G) {p : W.Ω → Prop} : (∀ᵐ ω ∂W.P, p (W.T x ω)) ↔ ∀ᵐ ω ∂W.P, p ω := by
  refine ⟨fun h => ?_, fun h => (W.preserving x).quasiMeasurePreserving.ae h⟩
  have h' := (W.preserving (-x)).quasiMeasurePreserving.ae h
  simpa only [W.T_T_neg] using h'

/-- The event "a `κ`-positive set of parameters `z` shifts the sample point into `D`": `nbhd` is the case `e = Neg.neg`. -/
def nb (W : StationarySet G) {Z : Type*} [MeasurableSpace Z] (κ : Measure Z) (e : Z → G) (D : Set W.Ω) : Set W.Ω :=
  {ω | 0 < κ {z | W.T (e z) ω ∈ D}}

theorem notMem_nb_iff {ω : W.Ω} : ω ∉ W.nb κ e D ↔ ∀ᵐ z ∂κ, W.T (e z) ω ∉ D := by
  rw [ae_iff]
  simp only [nb, Set.mem_setOf_eq, not_lt, nonpos_iff_eq_zero, not_not]

theorem nb_mono {D D' : Set W.Ω} (h : D ⊆ D') : W.nb κ e D ⊆ W.nb κ e D' :=
  fun ω (hω : 0 < κ {z | W.T (e z) ω ∈ D}) =>
    show 0 < κ {z | W.T (e z) ω ∈ D'} from lt_of_lt_of_le hω (measure_mono fun _ hz => h hz)

theorem measurableSet_nb [SFinite κ] (he : Measurable e) (hD : MeasurableSet D) : MeasurableSet (W.nb κ e D) :=
  measurableSet_lt measurable_const (measurable_measure_prodMk_right (W.measurable_T_comp he hD))

/-- **Tonelli for a stationary system**: "almost surely, a point of `C` has almost no shift into `D`" is "for almost every
shift, almost no point of `C` is shifted into `D`". -/
theorem ae_nb_iff [SFinite κ] (he : Measurable e) (hC : MeasurableSet C) (hD : MeasurableSet D) :
    (∀ᵐ ω ∂W.P, ω ∈ C → ω ∉ W.nb κ e D) ↔ ∀ᵐ z ∂κ, ∀ᵐ ω ∂W.P, ω ∈ C → W.T (e z) ω ∉ D := by
  have hE : MeasurableSet {p : Z × W.Ω | p.2 ∈ C → W.T (e p.1) p.2 ∉ D} := by
    have : {p : Z × W.Ω | p.2 ∈ C → W.T (e p.1) p.2 ∉ D}
        = (Prod.snd ⁻¹' C)ᶜ ∪ ((fun p : Z × W.Ω => W.T (e p.1) p.2) ⁻¹' D)ᶜ := by
      ext p
      simp only [Set.mem_setOf_eq, Set.mem_union, Set.mem_compl_iff, Set.mem_preimage]
      tauto
    rw [this]
    exact (measurable_snd hC).compl.union (W.measurable_T_comp he hD).compl
  rw [Measure.ae_ae_comm hE]
  simp only [notMem_nb_iff, Filter.eventually_imp_distrib_left]

/-- A null set of edges, read as an almost-sure statement for almost every shift. -/
theorem prod_null_iff (he : Measurable e) (hC : MeasurableSet C) (hD : MeasurableSet D) :
    (κ.prod W.P) {p | p.2 ∈ C ∧ W.T (e p.1) p.2 ∈ D} = 0 ↔ ∀ᵐ z ∂κ, ∀ᵐ ω ∂W.P, ω ∈ C → W.T (e z) ω ∉ D := by
  have hS : MeasurableSet {p : Z × W.Ω | p.2 ∈ C ∧ W.T (e p.1) p.2 ∈ D} :=
    (measurable_snd hC).inter (W.measurable_T_comp he hD)
  rw [Measure.measure_prod_null hS]
  refine Filter.eventually_congr (Filter.Eventually.of_forall fun z => ?_)
  rw [Pi.zero_apply, ae_iff]
  refine Eq.congr_left (congrArg _ ?_)
  ext ω
  simp only [Set.mem_preimage, Set.mem_setOf_eq, Classical.not_imp, not_not]

/-- The mass of the edges from `C` to `D` along `κ`, as an integral over the shifts. -/
theorem prod_apply_corr (he : Measurable e) (hC : MeasurableSet C) (hD : MeasurableSet D) :
    (κ.prod W.P) {p | p.2 ∈ C ∧ W.T (e p.1) p.2 ∈ D} = ∫⁻ z, W.P (C ∩ W.T (e z) ⁻¹' D) ∂κ :=
  Measure.prod_apply ((measurable_snd hC).inter (W.measurable_T_comp he hD))

theorem measurable_corr (he : Measurable e) (hC : MeasurableSet C) (hD : MeasurableSet D) :
    Measurable fun z : Z => W.P (C ∩ W.T (e z) ⁻¹' D) :=
  measurable_measure_prodMk_left ((measurable_snd hC).inter (W.measurable_T_comp he hD))

end Param

/-- A.e.-independence, as an almost-sure statement for almost every edge. -/
theorem aeIndependent_iff (ν : Measure G) :
    W.AEIndependent ν ↔ ∀ᵐ t ∂ν, ∀ᵐ ω ∂W.P, ω ∈ W.B → W.T t ω ∉ W.B :=
  W.prod_null_iff ν measurable_id W.measurableSet_B W.measurableSet_B

/-- **The same sample space, the action restricted along a homomorphism, and another event.** -/
def pull (W : StationarySet G) {G' : Type*} [AddCommGroup G'] [MeasurableSpace G'] (f : G' →+ G) (hf : Measurable f)
    (C : Set W.Ω) (hC : MeasurableSet C) : StationarySet G' where
  Ω := W.Ω
  mΩ := W.mΩ
  P := W.P
  isProb := W.isProb
  T x := W.T (f x)
  measurable_T := W.measurable_T_comp hf
  preserving x := W.preserving (f x)
  T_zero := by rw [map_zero]; exact W.T_zero
  T_add x y := by rw [map_add]; exact W.T_add _ _
  B := C
  measurableSet_B := hC

/-- **The independent coupling of two stationary systems**, with an event of the product. -/
noncomputable def couple (S W : StationarySet G) (C : Set (S.Ω × W.Ω)) (hC : MeasurableSet C) : StationarySet G where
  Ω := S.Ω × W.Ω
  P := S.P.prod W.P
  isProb := inferInstance
  T x := Prod.map (S.T x) (W.T x)
  measurable_T :=
    (S.measurable_T.comp (measurable_fst.prodMk (measurable_fst.comp measurable_snd))).prodMk
      (W.measurable_T.comp (measurable_fst.prodMk (measurable_snd.comp measurable_snd)))
  preserving x := (S.preserving x).prod (W.preserving x)
  T_zero := by rw [S.T_zero, W.T_zero]; exact Prod.map_id
  T_add x y := by rw [S.T_add, W.T_add]; exact Prod.map_comp_map _ _ _ _
  B := C
  measurableSet_B := hC

end StationarySet

/-- **X25B-P** (Zhang's Prop. 1.7, stationary form; a child of X25B-PZ, not a backlog row): "If `A` is a `G`-stationary random
a.e.-independent set, `P(0 ∈ A) ≤ r(G,T)·P(0 ∈ N[A])`." -/
theorem StationarySet.prob_le_ratio_mul [MeasurableAdd₂ G] [MeasurableNeg G] (W : StationarySet G) {ν : Measure G}
    [SigmaFinite ν] (hsymm : ν.map Neg.neg = ν) (hW : W.AEIndependent ν) :
    W.P W.B ≤ ratio ν * W.P (W.B ∪ W.nbhd ν) := by
  -- `MeasurableAdd₂ G` is not read by the proof (FS131-I10B, a finding): consumed here for the unused-arguments linter.
  have hA : MeasurableSet W.B := W.measurableSet_B
  have hM : MeasurableSet (W.nbhd ν) := W.measurableSet_nb ν measurable_neg hA
  have hN : MeasurableSet (W.B ∪ W.nbhd ν) := hA.union hM
  have hW' := (W.aeIndependent_iff ν).mp hW
  -- off `N(A)`, almost no reflected shift lands in `A` (the definition of `N(A)`, by Tonelli) …
  have F1 : ∀ᵐ t ∂ν, ∀ᵐ ω ∂W.P, ω ∈ (W.nbhd ν)ᶜ → W.T (-t) ω ∉ W.B :=
    (W.ae_nb_iff ν measurable_neg hM.compl hA).mp (Filter.Eventually.of_forall fun ω hω => hω)
  -- … nor, `ν` being symmetric, any shift;
  have F2 : ∀ᵐ t ∂ν, ∀ᵐ ω ∂W.P, ω ∈ (W.nbhd ν)ᶜ → W.T t ω ∉ W.B :=
    (ae_neg_iff hsymm (p := fun t => ∀ᵐ ω ∂W.P, ω ∈ (W.nbhd ν)ᶜ → W.T t ω ∉ W.B)).mp F1
  -- and a point of `A` is shifted into `N(A)`.
  have F3 : ∀ᵐ t ∂ν, ∀ᵐ ω ∂W.P, ω ∈ W.B → W.T t ω ∈ W.nbhd ν := by
    filter_upwards [F1] with t ht
    have h := (W.ae_T_iff t (p := fun ω => ω ∈ (W.nbhd ν)ᶜ → W.T (-t) ω ∉ W.B)).mpr ht
    filter_upwards [h] with ω hω hωA
    by_contra hM'
    exact hω hM' (by rwa [W.T_neg_T])
  -- every competitor `S`, coupled independently: `(S ∖ N[A]) ∪ A` is a.e.-independent.
  have key : ∀ S : StationarySet G, S.AEIndependent ν → S.P S.B * W.P (W.B ∪ W.nbhd ν)ᶜ + W.P W.B ≤ ratio ν := by
    intro S hS
    have hS' := (S.aeIndependent_iff ν).mp hS
    have hC : MeasurableSet ((S.B ×ˢ (W.B ∪ W.nbhd ν)ᶜ) ∪ ((Set.univ : Set S.Ω) ×ˢ W.B)) :=
      (S.measurableSet_B.prod hN.compl).union (MeasurableSet.univ.prod hA)
    have hind : (S.couple W _ hC).AEIndependent ν := by
      rw [StationarySet.aeIndependent_iff]
      show ∀ᵐ t ∂ν, ∀ᵐ p ∂(S.P.prod W.P), p ∈ (S.B ×ˢ (W.B ∪ W.nbhd ν)ᶜ) ∪ ((Set.univ : Set S.Ω) ×ˢ W.B) →
        Prod.map (S.T t) (W.T t) p ∉ (S.B ×ˢ (W.B ∪ W.nbhd ν)ᶜ) ∪ ((Set.univ : Set S.Ω) ×ˢ W.B)
      filter_upwards [hW', hS', F2, F3] with t h1 h2 h3 h4
      have h1' : ∀ᵐ p ∂(S.P.prod W.P), p.2 ∈ W.B → W.T t p.2 ∉ W.B := Measure.quasiMeasurePreserving_snd.ae h1
      have h2' : ∀ᵐ p ∂(S.P.prod W.P), p.1 ∈ S.B → S.T t p.1 ∉ S.B := Measure.quasiMeasurePreserving_fst.ae h2
      have h3' : ∀ᵐ p ∂(S.P.prod W.P), p.2 ∈ (W.nbhd ν)ᶜ → W.T t p.2 ∉ W.B :=
        Measure.quasiMeasurePreserving_snd.ae h3
      have h4' : ∀ᵐ p ∂(S.P.prod W.P), p.2 ∈ W.B → W.T t p.2 ∈ W.nbhd ν := Measure.quasiMeasurePreserving_snd.ae h4
      filter_upwards [h1', h2', h3', h4'] with p g1 g2 g3 g4
      simp only [Set.mem_union, Set.mem_prod, Set.mem_univ, true_and, Set.mem_compl_iff, Prod.map_fst, Prod.map_snd,
        not_or] at g3 ⊢
      tauto
    have hle := (S.couple W _ hC).prob_le_ratio hind
    have hval : (S.P.prod W.P) ((S.B ×ˢ (W.B ∪ W.nbhd ν)ᶜ) ∪ ((Set.univ : Set S.Ω) ×ˢ W.B))
        = S.P S.B * W.P (W.B ∪ W.nbhd ν)ᶜ + W.P W.B := by
      rw [measure_union _ (MeasurableSet.univ.prod hA), Measure.prod_prod, Measure.prod_prod, measure_univ, one_mul]
      rw [Set.disjoint_left]
      rintro ⟨a, b⟩ ⟨-, hb⟩ ⟨-, hb'⟩
      exact hb (Or.inl hb')
    exact hval ▸ hle
  -- the supremum over `S`, in `ℝ≥0∞`.
  have ha_le : W.P W.B ≤ ratio ν := W.prob_le_ratio hW
  have h1 : ratio ν * W.P (W.B ∪ W.nbhd ν)ᶜ ≤ ratio ν - W.P W.B :=
    ratio_mul_le fun S hS => ENNReal.le_sub_of_add_le_right (measure_ne_top _ _) (key S hS)
  have h2 : ratio ν * W.P (W.B ∪ W.nbhd ν)ᶜ + W.P W.B ≤ ratio ν :=
    calc ratio ν * W.P (W.B ∪ W.nbhd ν)ᶜ + W.P W.B ≤ (ratio ν - W.P W.B) + W.P W.B := by gcongr
      _ = ratio ν := tsub_add_cancel_of_le ha_le
  have h3 : ratio ν = ratio ν * W.P (W.B ∪ W.nbhd ν)ᶜ + ratio ν * W.P (W.B ∪ W.nbhd ν) := by
    rw [← mul_add, add_comm, prob_add_prob_compl hN, mul_one]
  have hfin : ratio ν * W.P (W.B ∪ W.nbhd ν)ᶜ ≠ ⊤ :=
    ENNReal.mul_ne_top (ne_top_of_le_ne_top ENNReal.one_ne_top (ratio_le_one ν)) (measure_ne_top _ _)
  exact (ENNReal.add_le_add_iff_left hfin).mp (h2.trans_eq h3)

/-- X25B-PZ at one stationary set: Zhang's count at the origin. -/
theorem StationarySet.prob_le_max_ratio {H : Type*} [AddCommGroup H] [MeasurableSpace H] [MeasurableAdd₂ G]
    [MeasurableNeg G] [MeasurableAdd₂ H] [MeasurableNeg H] (νG : Measure G) (νH : Measure H) [SigmaFinite νG]
    [SigmaFinite νH] (hG : νG.map Neg.neg = νG) (hH : νH.map Neg.neg = νH) (W : StationarySet (G × H))
    (hW : W.AEIndependent (νG.prod νH)) : W.P W.B ≤ max (ratio νG) (ratio νH) := by
  have hB := W.measurableSet_B
  have hW' := (W.aeIndependent_iff _).mp hW
  -- for almost every `s`, almost every `t`: almost surely no edge `(s, t)` from the origin inside the set.
  have hq : ∀ᵐ s ∂νG, ∀ᵐ t ∂νH, ∀ᵐ ω ∂W.P, ω ∈ W.B → W.T (s, t) ω ∉ W.B := Measure.ae_ae_of_ae_prod hW'
  have heH : Measurable fun t : H => ((0 : G), -t) := measurable_const.prodMk measurable_neg
  have heG : Measurable fun s : G => (-s, (0 : H)) := measurable_neg.prodMk measurable_const
  have hinr : Measurable (AddMonoidHom.inr G H) := by
    show Measurable fun t : H => ((0 : G), t)
    exact measurable_const.prodMk measurable_id
  have hinl : Measurable (AddMonoidHom.inl G H) := by
    show Measurable fun s : G => (s, (0 : H))
    exact measurable_id.prodMk measurable_const
  -- `N`: the origin has `ν_H`-positively many `H`-neighbours in the set; `Y = B ∖ N`, `A = B ∩ N`.
  have hN : MeasurableSet (W.nb νH (fun t : H => ((0 : G), -t)) W.B) := W.measurableSet_nb νH heH hB
  have hY : MeasurableSet (W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B) := hB.diff hN
  have hA : MeasurableSet (W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B) := hB.inter hN
  -- off `N`, almost no `H`-shift lands in the set (Tonelli, then the symmetry of `ν_H`).
  have G1 : ∀ᵐ t ∂νH, ∀ᵐ ω ∂W.P, ω ∈ (W.nb νH (fun t : H => ((0 : G), -t)) W.B)ᶜ → W.T (0, -t) ω ∉ W.B :=
    (W.ae_nb_iff νH heH hN.compl hB).mp (Filter.Eventually.of_forall fun ω hω => hω)
  have G2 : ∀ᵐ t ∂νH, ∀ᵐ ω ∂W.P, ω ∈ (W.nb νH (fun t : H => ((0 : G), -t)) W.B)ᶜ → W.T (0, t) ω ∉ W.B :=
    (ae_neg_iff hH (p := fun t => ∀ᵐ ω ∂W.P,
      ω ∈ (W.nb νH (fun t : H => ((0 : G), -t)) W.B)ᶜ → W.T (0, t) ω ∉ W.B)).mp G1
  -- a point whose `G`-shift by `s` is in the set is not in `N`: an `H`-neighbour of it would be joined to the shift
  -- by the edge `(s, t)`.
  have G3 : ∀ᵐ s ∂νG, ∀ᵐ ω ∂W.P, W.T (s, 0) ω ∈ W.B → ω ∉ W.nb νH (fun t : H => ((0 : G), -t)) W.B := by
    filter_upwards [hq] with s hs
    refine (W.ae_nb_iff νH heH (W.measurable_T_apply (s, 0) hB) hB).mpr ?_
    filter_upwards [hs] with t ht
    have h := (W.ae_T_iff (0, -t) (p := fun ω => ω ∈ W.B → W.T (s, t) ω ∉ W.B)).mpr ht
    filter_upwards [h] with ω hω h1 h2
    refine hω h2 ?_
    rw [← W.T_add_apply]
    simpa using h1
  -- (2) `Y` is `H`-independent and `A` is `G`-independent.
  have hWH : (W.pull (AddMonoidHom.inr G H) hinr _ hY).AEIndependent νH := by
    rw [StationarySet.aeIndependent_iff]
    show ∀ᵐ t ∂νH, ∀ᵐ ω ∂W.P, ω ∈ W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B →
      W.T (0, t) ω ∉ W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B
    filter_upwards [G2] with t ht
    filter_upwards [ht] with ω hω h1 h2
    exact hω h1.2 h2.1
  have hWG : (W.pull (AddMonoidHom.inl G H) hinl _ hA).AEIndependent νG := by
    rw [StationarySet.aeIndependent_iff]
    show ∀ᵐ s ∂νG, ∀ᵐ ω ∂W.P, ω ∈ W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B →
      W.T (s, 0) ω ∉ W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B
    filter_upwards [G3] with s hs
    filter_upwards [hs] with ω hω h1 h2
    exact hω h2.1 h1.2
  -- X25B-P in each factor.
  have hPY := (W.pull (AddMonoidHom.inr G H) hinr _ hY).prob_le_ratio_mul hH hWH
  have hPA := (W.pull (AddMonoidHom.inl G H) hinl _ hA).prob_le_ratio_mul hG hWG
  change W.P (W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B) ≤ ratio νH *
    W.P ((W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B) ∪
      W.nb νH (fun t : H => ((0 : G), -t)) (W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B)) at hPY
  change W.P (W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B) ≤ ratio νG *
    W.P ((W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B) ∪
      W.nb νG (fun s : G => (-s, (0 : H))) (W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B)) at hPA
  have hNY : MeasurableSet (W.nb νH (fun t : H => ((0 : G), -t)) (W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B)) :=
    W.measurableSet_nb νH heH hY
  have hNA : MeasurableSet (W.nb νG (fun s : G => (-s, (0 : H))) (W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B)) :=
    W.measurableSet_nb νG heG hA
  -- (3) the two closed neighbourhoods meet in a null event: the three cases with a neighbour.
  have C2 : ∀ᵐ ω ∂W.P, ω ∈ W.B →
      ω ∉ W.nb νH (fun t : H => ((0 : G), -t)) (W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B) := by
    refine (W.ae_nb_iff νH heH hB hY).mpr ?_
    filter_upwards [G2] with t ht
    have h := (W.ae_T_iff (0, -t) (p := fun ω =>
      ω ∈ (W.nb νH (fun t : H => ((0 : G), -t)) W.B)ᶜ → W.T (0, t) ω ∉ W.B)).mpr ht
    filter_upwards [h] with ω hω hωB hωY
    refine hω hωY.2 ?_
    rw [← W.T_add_apply, show ((0 : G), t) + (0, -t) = 0 by simp, W.T_zero_apply]
    exact hωB
  have C3 : ∀ᵐ ω ∂W.P, ω ∈ W.B →
      ω ∉ W.nb νG (fun s : G => (-s, (0 : H))) (W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B) := by
    refine (W.ae_nb_iff νG heG hB hA).mpr ?_
    filter_upwards [G3] with s hs
    have h := (W.ae_T_iff (-s, 0) (p := fun ω =>
      W.T (s, 0) ω ∈ W.B → ω ∉ W.nb νH (fun t : H => ((0 : G), -t)) W.B)).mpr hs
    filter_upwards [h] with ω hω hωB hωA
    refine hω ?_ hωA.2
    rw [← W.T_add_apply, show (s, (0 : H)) + (-s, 0) = 0 by simp, W.T_zero_apply]
    exact hωB
  have C4 : ∀ᵐ ω ∂W.P, ω ∈ W.nb νH (fun t : H => ((0 : G), -t)) W.B →
      ω ∉ W.nb νG (fun s : G => (-s, (0 : H))) W.B := by
    refine (W.ae_nb_iff νG heG hN hB).mpr ?_
    have h : ∀ᵐ s ∂νG, ∀ᵐ ω ∂W.P, ω ∈ W.nb νH (fun t : H => ((0 : G), -t)) W.B → W.T (s, 0) ω ∉ W.B := by
      filter_upwards [G3] with s hs
      filter_upwards [hs] with ω hω hωN hωB
      exact hω hωB hωN
    exact (ae_neg_iff hG (p := fun s => ∀ᵐ ω ∂W.P,
      ω ∈ W.nb νH (fun t : H => ((0 : G), -t)) W.B → W.T (s, 0) ω ∉ W.B)).mpr h
  have hdisj : AEDisjoint W.P
      ((W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B) ∪
        W.nb νH (fun t : H => ((0 : G), -t)) (W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B))
      ((W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B) ∪
        W.nb νG (fun s : G => (-s, (0 : H))) (W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B)) := by
    rw [AEDisjoint, measure_eq_zero_iff_ae_notMem]
    filter_upwards [C2, C3, C4] with ω h2 h3 h4
    rintro ⟨hy | hy, ha | ha⟩
    · exact hy.2 ha.2
    · exact h3 hy.1 ha
    · exact h2 ha.1 hy
    · exact h4 (W.nb_mono νH Set.sdiff_subset hy) (W.nb_mono νG Set.inter_subset_left ha)
  have hsum : W.P ((W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B) ∪
        W.nb νH (fun t : H => ((0 : G), -t)) (W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B))
      + W.P ((W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B) ∪
        W.nb νG (fun s : G => (-s, (0 : H))) (W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B)) ≤ 1 := by
    rw [← measure_union₀ (hA.union hNA).nullMeasurableSet hdisj]
    exact prob_le_one
  -- (1) and (4): the partition and the sum.
  calc W.P W.B
      = W.P (W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B)
        + W.P (W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B) := (measure_sdiff_add_inter W.B hN).symm
    _ ≤ max (ratio νG) (ratio νH) * W.P ((W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B) ∪
          W.nb νH (fun t : H => ((0 : G), -t)) (W.B \ W.nb νH (fun t : H => ((0 : G), -t)) W.B))
        + max (ratio νG) (ratio νH) * W.P ((W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B) ∪
          W.nb νG (fun s : G => (-s, (0 : H))) (W.B ∩ W.nb νH (fun t : H => ((0 : G), -t)) W.B)) :=
        add_le_add (hPY.trans (mul_le_mul_left (le_max_right _ _) _))
          (hPA.trans (mul_le_mul_left (le_max_left _ _) _))
    _ ≤ max (ratio νG) (ratio νH) * 1 := by
        rw [← mul_add]
        exact mul_le_mul_right hsum _
    _ = max (ratio νG) (ratio νH) := mul_one _

/-- **X25B-PZ**: "the stationary ratio of a categorical product of two LCA Cayley graphs is at most the larger factor's"
(Zhang 2012 §2's argument, measure form) — for measurable groups and σ-finite symmetric connection measures. -/
theorem ratio_prod_le {H : Type*} [AddCommGroup H] [MeasurableSpace H] [MeasurableAdd₂ G] [MeasurableNeg G]
    [MeasurableAdd₂ H] [MeasurableNeg H] (νG : Measure G) (νH : Measure H) [SigmaFinite νG] [SigmaFinite νH]
    (hG : νG.map Neg.neg = νG) (hH : νH.map Neg.neg = νH) :
    ratio (νG.prod νH) ≤ max (ratio νG) (ratio νH) :=
  iSup₂_le fun W hW => W.prob_le_max_ratio νG νH hG hH hW

/-- The Haar probability of a compact open subgroup `K` of `Y`, as a measure on `Y`. -/
noncomputable def cosetAverage {Y : Type*} [AddCommGroup Y] [TopologicalSpace Y] [IsTopologicalAddGroup Y]
    [LocallyCompactSpace Y] [MeasurableSpace Y] [BorelSpace Y] (K : OpenAddSubgroup Y) : Measure Y :=
  (Measure.addHaar (K : Set Y))⁻¹ • (Measure.addHaar : Measure Y).restrict (K : Set Y)

/-! ## The majority event and the level average (FS131-I10B) -/

namespace StationarySet

variable (W : StationarySet G) {Z : Type*} [MeasurableSpace Z] (κ : Measure Z) {e : Z → G} {D : Set W.Ω}

/-- The event "more than half of the shifts `T (e z)`, `z` drawn from `κ`, land in `D`": for `κ` the Haar probability of a
subgroup, the fibre share above `1/2`. -/
def majority (W : StationarySet G) {Z : Type*} [MeasurableSpace Z] (κ : Measure Z) (e : Z → G) (D : Set W.Ω) :
    Set W.Ω :=
  {ω | 2⁻¹ < κ {z | W.T (e z) ω ∈ D}}

theorem measurableSet_majority [SFinite κ] (he : Measurable e) (hD : MeasurableSet D) :
    MeasurableSet (W.majority κ e D) :=
  measurableSet_lt measurable_const (measurable_measure_prodMk_right (W.measurable_T_comp he hD))

/-- **The pigeonhole**: if almost surely the shift by `g` joins no two points of `D`, it joins no two points of the
majority event — two majorities under one probability meet, and a common parameter gives an edge inside `D`. -/
theorem ae_majority [IsProbabilityMeasure κ] (he : Measurable e) (hD : MeasurableSet D) {g : G}
    (h : ∀ᵐ ω ∂W.P, ω ∈ D → W.T g ω ∉ D) :
    ∀ᵐ ω ∂W.P, ω ∈ W.majority κ e D → W.T g ω ∉ W.majority κ e D := by
  have hD' : MeasurableSet (D ∩ W.T g ⁻¹' D) := hD.inter (W.measurable_T_apply g hD)
  have h0 : ∀ᵐ ω ∂W.P, ω ∈ (Set.univ : Set W.Ω) → ω ∉ W.nb κ e (D ∩ W.T g ⁻¹' D) := by
    refine (W.ae_nb_iff κ he MeasurableSet.univ hD').mpr (Filter.Eventually.of_forall fun z => ?_)
    have h1 : ∀ᵐ ω ∂W.P, ω ∉ D ∩ W.T g ⁻¹' D := by
      filter_upwards [h] with ω hω hω'
      exact hω hω'.1 hω'.2
    have h2 := (W.ae_T_iff (e z) (p := fun ω => ω ∉ D ∩ W.T g ⁻¹' D)).mpr h1
    filter_upwards [h2] with ω hω _
    exact hω
  filter_upwards [h0] with ω hω hmaj hmaj'
  have hnull : κ ({z | W.T (e z) ω ∈ D} ∩ {z | W.T (e z) (W.T g ω) ∈ D}) = 0 := by
    have h3 := (W.notMem_nb_iff κ).mp (hω (Set.mem_univ ω))
    refine measure_mono_null ?_ (ae_iff.mp h3)
    rintro z ⟨hz1, hz2⟩
    simp only [Set.mem_setOf_eq, not_not]
    refine ⟨hz1, ?_⟩
    show W.T g (W.T (e z) ω) ∈ D
    rw [← W.T_add_apply, add_comm, W.T_add_apply]
    exact hz2
  have hS2 : MeasurableSet {z | W.T (e z) (W.T g ω) ∈ D} := W.measurable_T_left he _ hD
  have hsum := measure_union_add_inter (μ := κ) {z | W.T (e z) ω ∈ D} hS2
  rw [hnull, add_zero] at hsum
  have hle : κ ({z | W.T (e z) ω ∈ D} ∪ {z | W.T (e z) (W.T g ω) ∈ D}) ≤ 1 := prob_le_one
  rw [hsum] at hle
  have hlt : (1 : ENNReal) < 1 :=
    calc (1 : ENNReal) = 2⁻¹ + 2⁻¹ := ENNReal.inv_two_add_inv_two.symm
      _ < κ {z | W.T (e z) ω ∈ D} + κ {z | W.T (e z) (W.T g ω) ∈ D} := ENNReal.add_lt_add hmaj hmaj'
      _ ≤ 1 := hle
  exact lt_irrefl _ hlt

/-- **The mass of the majority event**: `P(D) ≤ P(majority) + ∫ P(T_{e z}⁻¹ D ∆ D) dκ(z)` — where at most half of the
shifts land in `D`, the share is at most the share of shifts that disagree with the origin. -/
theorem measure_le_majority_add [IsProbabilityMeasure κ] (he : Measurable e) (hD : MeasurableSet D) :
    W.P D ≤ W.P (W.majority κ e D) + ∫⁻ z, W.P ((W.T (e z) ⁻¹' D) ∆ D) ∂κ := by
  have hE1 : MeasurableSet {p : Z × W.Ω | W.T (e p.1) p.2 ∈ D} := W.measurable_T_comp he hD
  have hE2 : MeasurableSet {p : Z × W.Ω | p.2 ∈ (W.T (e p.1) ⁻¹' D) ∆ D} := by
    have : {p : Z × W.Ω | p.2 ∈ (W.T (e p.1) ⁻¹' D) ∆ D}
        = {p : Z × W.Ω | W.T (e p.1) p.2 ∈ D} ∆ (Prod.snd ⁻¹' D) := by
      ext p
      simp only [Set.mem_setOf_eq, Set.mem_symmDiff, Set.mem_preimage]
    rw [this]
    exact hE1.symmDiff (measurable_snd hD)
  have hJ := W.measurableSet_majority κ he hD
  have e1 : W.P D = ∫⁻ ω, κ {z | W.T (e z) ω ∈ D} ∂W.P :=
    calc W.P D = ∫⁻ _, W.P D ∂κ := by rw [lintegral_const, measure_univ, mul_one]
      _ = ∫⁻ z, W.P (Prod.mk z ⁻¹' {p : Z × W.Ω | W.T (e p.1) p.2 ∈ D}) ∂κ :=
          lintegral_congr fun z => ((W.preserving (e z)).measure_preimage hD.nullMeasurableSet).symm
      _ = (κ.prod W.P) {p : Z × W.Ω | W.T (e p.1) p.2 ∈ D} := (Measure.prod_apply hE1).symm
      _ = ∫⁻ ω, κ {z | W.T (e z) ω ∈ D} ∂W.P := Measure.prod_apply_symm hE1
  have e2 : ∫⁻ z, W.P ((W.T (e z) ⁻¹' D) ∆ D) ∂κ = ∫⁻ ω, κ {z | ω ∈ (W.T (e z) ⁻¹' D) ∆ D} ∂W.P :=
    calc ∫⁻ z, W.P ((W.T (e z) ⁻¹' D) ∆ D) ∂κ
        = (κ.prod W.P) {p : Z × W.Ω | p.2 ∈ (W.T (e p.1) ⁻¹' D) ∆ D} := (Measure.prod_apply hE2).symm
      _ = ∫⁻ ω, κ {z | ω ∈ (W.T (e z) ⁻¹' D) ∆ D} ∂W.P := Measure.prod_apply_symm hE2
  rw [e1, e2, ← lintegral_indicator_one hJ, ← lintegral_add_left (measurable_one.indicator hJ)]
  refine lintegral_mono fun ω => ?_
  by_cases hω : ω ∈ W.majority κ e D
  · rw [Set.indicator_of_mem hω]
    exact le_add_right prob_le_one
  · rw [Set.indicator_of_notMem hω, zero_add]
    have hhalf : κ {z | W.T (e z) ω ∈ D} ≤ 2⁻¹ := not_lt.mp hω
    by_cases hωD : ω ∈ D
    · have hS : MeasurableSet {z | W.T (e z) ω ∈ D} := W.measurable_T_left he ω hD
      calc κ {z | W.T (e z) ω ∈ D} ≤ 2⁻¹ := hhalf
        _ = 1 - 2⁻¹ := ENNReal.one_sub_inv_two.symm
        _ ≤ 1 - κ {z | W.T (e z) ω ∈ D} := tsub_le_tsub_left hhalf 1
        _ = κ {z | W.T (e z) ω ∈ D}ᶜ := (prob_compl_eq_one_sub hS).symm
        _ ≤ κ {z | ω ∈ (W.T (e z) ⁻¹' D) ∆ D} :=
            measure_mono fun z hz => Set.mem_symmDiff.mpr (Or.inr ⟨hωD, hz⟩)
    · exact measure_mono fun z hz => Set.mem_symmDiff.mpr (Or.inl ⟨hz, hωD⟩)

end StationarySet

section CosetAverage

variable {Y : Type*} [AddCommGroup Y] [TopologicalSpace Y] [IsTopologicalAddGroup Y] [LocallyCompactSpace Y]
  [MeasurableSpace Y] [BorelSpace Y] (K : OpenAddSubgroup Y)

theorem cosetAverage_apply {S : Set Y} (hS : MeasurableSet S) :
    cosetAverage K S = (Measure.addHaar (K : Set Y))⁻¹ * Measure.addHaar (S ∩ (K : Set Y)) := by
  rw [cosetAverage, Measure.smul_apply, Measure.restrict_apply hS, smul_eq_mul]

/-- The level average is a probability measure (`Y` compact: Haar measure is finite, and positive on the open `K`). -/
instance cosetAverage.instIsProbabilityMeasure [CompactSpace Y] : IsProbabilityMeasure (cosetAverage K) := by
  refine ⟨?_⟩
  rw [cosetAverage_apply K MeasurableSet.univ, Set.univ_inter]
  exact ENNReal.inv_mul_cancel (K.isOpen.measure_pos _ ⟨0, K.zero_mem⟩).ne' (measure_ne_top _ _)

/-- It is carried by `K`. -/
theorem cosetAverage_compl : cosetAverage K ((K : Set Y)ᶜ) = 0 := by
  rw [cosetAverage_apply K K.isOpen.measurableSet.compl, Set.compl_inter_self, measure_empty, mul_zero]

theorem ae_mem_cosetAverage : ∀ᵐ u ∂cosetAverage K, u ∈ (K : Set Y) := by
  rw [ae_iff]
  exact cosetAverage_compl K

/-- It is invariant under translation by an element of `K`. -/
theorem cosetAverage_preimage_add {u : Y} (hu : u ∈ K) {S : Set Y} (hS : MeasurableSet S) :
    cosetAverage K ((fun v => u + v) ⁻¹' S) = cosetAverage K S := by
  rw [cosetAverage_apply K (measurable_const_add u hS), cosetAverage_apply K hS]
  have h : (fun v => u + v) ⁻¹' S ∩ (K : Set Y) = (fun v => u + v) ⁻¹' (S ∩ (K : Set Y)) := by
    ext v
    have hcancel : u + v ∈ (K : AddSubgroup Y) ↔ v ∈ (K : AddSubgroup Y) :=
      (K : AddSubgroup Y).add_mem_cancel_left hu
    exact and_congr_right fun _ => hcancel.symm
  rw [h, measure_preimage_add]

/-- **Smoothing by the level average** does not change the integral of a function invariant under `K` in the second
coordinate. -/
theorem lintegral_prod_conv_cosetAverage [CompactSpace Y] [SecondCountableTopology Y] {X : Type*} [MeasurableSpace X]
    (νX : Measure X) (νY : Measure Y) [SFinite νY] {q : X × Y → ENNReal} (hq : Measurable q)
    (hinv : ∀ s y, ∀ u ∈ K, q (s, y + u) = q (s, y)) :
    ∫⁻ p, q p ∂(νX.prod (Measure.conv νY (cosetAverage K))) = ∫⁻ p, q p ∂(νX.prod νY) := by
  rw [lintegral_prod _ hq.aemeasurable, lintegral_prod _ hq.aemeasurable]
  refine lintegral_congr fun s => ?_
  have hqs : Measurable fun y => q (s, y) := hq.comp measurable_prodMk_left
  rw [Measure.lintegral_conv hqs]
  refine lintegral_congr fun y => ?_
  have hae : ∀ᵐ u ∂cosetAverage K, q (s, y + u) = q (s, y) := by
    filter_upwards [ae_mem_cosetAverage K] with u hu using hinv s y u hu
  rw [lintegral_congr_ae hae, lintegral_const, measure_univ, mul_one]

/-- **A jointly measurable measure-preserving action of a compact second-countable group is `L¹`-continuous at `0`** on
events: by stationarity `P(T_u⁻¹ C ∆ C)` is the mean over `ω` of the Haar measure of `(u + A_ω) ∆ A_ω`,
`A_ω = {v | T_v ω ∈ C}`, and each of these tends to `0` (translation is continuous in measure), boundedly. -/
theorem tendsto_measure_symmDiff_shift [CompactSpace Y] [SecondCountableTopology Y] (V : StationarySet Y)
    {C : Set V.Ω} (hC : MeasurableSet C) :
    Filter.Tendsto (fun u => V.P ((V.T u ⁻¹' C) ∆ C)) (nhds 0) (nhds 0) := by
  -- translation by `u`, as a continuous map, continuous in `u`
  let f : Y → C(Y, Y) := fun u => ⟨fun v => u + v, continuous_const.add continuous_id⟩
  have hf : Continuous f := (ContinuousMap.curry ⟨fun p : Y × Y => p.1 + p.2, continuous_add⟩).continuous
  have hf0 : f 0 = ContinuousMap.id Y := by
    ext v
    simp [f]
  have hpt : ∀ S : Set Y, MeasurableSet S →
      Filter.Tendsto (fun u => (Measure.addHaar : Measure Y) (((fun v => u + v) ⁻¹' S) ∆ S)) (nhds 0) (nhds 0) := by
    intro S hS
    have h := tendsto_measure_symmDiff_preimage_nhds_zero (μ := (Measure.addHaar : Measure Y))
      (ν := (Measure.addHaar : Measure Y)) (f := f) (g := ContinuousMap.id Y) (l := nhds 0) (s := S)
      (by rw [← hf0]; exact hf.tendsto 0)
      (Filter.Eventually.of_forall fun u => measurePreserving_add_left _ u) (MeasurePreserving.id _)
      hS.nullMeasurableSet (measure_ne_top _ _)
    simpa [f] using h
  have hE : ∀ u, MeasurableSet {p : Y × V.Ω | V.T p.1 p.2 ∈ (V.T u ⁻¹' C) ∆ C} := fun u =>
    V.measurable_T ((V.measurable_T_apply u hC).symmDiff hC)
  have hsec : ∀ u ω, (fun v => (v, ω)) ⁻¹' {p : Y × V.Ω | V.T p.1 p.2 ∈ (V.T u ⁻¹' C) ∆ C}
      = ((fun v => u + v) ⁻¹' {v | V.T v ω ∈ C}) ∆ {v | V.T v ω ∈ C} := by
    intro u ω
    ext v
    simp only [Set.mem_preimage, Set.mem_setOf_eq, Set.mem_symmDiff, V.T_add_apply]
  have hint : ∀ u, ∫⁻ ω, (Measure.addHaar : Measure Y)
        ((fun v => (v, ω)) ⁻¹' {p : Y × V.Ω | V.T p.1 p.2 ∈ (V.T u ⁻¹' C) ∆ C}) ∂V.P
      = (Measure.addHaar : Measure Y) Set.univ * V.P ((V.T u ⁻¹' C) ∆ C) := by
    intro u
    calc ∫⁻ ω, (Measure.addHaar : Measure Y)
          ((fun v => (v, ω)) ⁻¹' {p : Y × V.Ω | V.T p.1 p.2 ∈ (V.T u ⁻¹' C) ∆ C}) ∂V.P
        = ((Measure.addHaar : Measure Y).prod V.P) {p : Y × V.Ω | V.T p.1 p.2 ∈ (V.T u ⁻¹' C) ∆ C} :=
          (Measure.prod_apply_symm (hE u)).symm
      _ = ∫⁻ v, V.P (Prod.mk v ⁻¹' {p : Y × V.Ω | V.T p.1 p.2 ∈ (V.T u ⁻¹' C) ∆ C}) ∂Measure.addHaar :=
          Measure.prod_apply (hE u)
      _ = ∫⁻ _, V.P ((V.T u ⁻¹' C) ∆ C) ∂(Measure.addHaar : Measure Y) :=
          lintegral_congr fun v => (V.preserving v).measure_preimage
            ((V.measurable_T_apply u hC).symmDiff hC).nullMeasurableSet
      _ = (Measure.addHaar : Measure Y) Set.univ * V.P ((V.T u ⁻¹' C) ∆ C) := by
          rw [lintegral_const, mul_comm]
  have hlim : Filter.Tendsto (fun u => ∫⁻ ω, (Measure.addHaar : Measure Y)
      ((fun v => (v, ω)) ⁻¹' {p : Y × V.Ω | V.T p.1 p.2 ∈ (V.T u ⁻¹' C) ∆ C}) ∂V.P) (nhds 0)
      (nhds (∫⁻ _, 0 ∂V.P)) := by
    refine tendsto_lintegral_filter_of_dominated_convergence (fun _ => (Measure.addHaar : Measure Y) Set.univ)
      (Filter.Eventually.of_forall fun u => measurable_measure_prodMk_right (hE u))
      (Filter.Eventually.of_forall fun u => Filter.Eventually.of_forall fun ω => measure_mono (Set.subset_univ _))
      ?_ (Filter.Eventually.of_forall fun ω => ?_)
    · rw [lintegral_const, measure_univ (μ := V.P), mul_one]
      exact measure_ne_top _ _
    · simp only [hsec]
      exact hpt _ (V.measurable_T_left measurable_id ω hC)
  simp only [hint, lintegral_zero] at hlim
  have hm0 : (Measure.addHaar : Measure Y) Set.univ ≠ 0 :=
    (isOpen_univ.measure_pos (Measure.addHaar : Measure Y) ⟨0, trivial⟩).ne'
  have hmt : (Measure.addHaar : Measure Y) Set.univ ≠ ⊤ := measure_ne_top _ _
  have h := ENNReal.Tendsto.const_mul (a := ((Measure.addHaar : Measure Y) Set.univ)⁻¹) hlim
    (Or.inr (ENNReal.inv_ne_top.mpr hm0))
  simpa only [← mul_assoc, ENNReal.inv_mul_cancel hm0 hmt, one_mul, mul_zero] using h

end CosetAverage

/-- X25B-L1 at one stationary set and one level: the majority event of the level is a.e.-independent for the smoothed
measure, and carries all of `P(B)` but the mean displacement over the level. -/
theorem StationarySet.prob_le_ratio_level_add {X Y : Type*} [AddCommGroup X] [MeasurableSpace X] [AddCommGroup Y]
    [TopologicalSpace Y] [IsTopologicalAddGroup Y] [CompactSpace Y] [LocallyCompactSpace Y]
    [SecondCountableTopology Y] [MeasurableSpace Y] [BorelSpace Y] (νX : Measure X) (νY : Measure Y)
    [IsFiniteMeasure νY] (K : OpenAddSubgroup Y) (W : StationarySet (X × Y)) (hW : W.AEIndependent (νX.prod νY)) :
    W.P W.B ≤ ratio (νX.prod (Measure.conv νY (cosetAverage K)))
      + ∫⁻ u, W.P ((W.T (0, u) ⁻¹' W.B) ∆ W.B) ∂cosetAverage K := by
  have hB := W.measurableSet_B
  have he : Measurable fun u : Y => ((0 : X), u) := measurable_const.prodMk measurable_id
  -- `J`: the fibre share over `K` exceeds `1/2`.
  obtain ⟨J, hJdef⟩ : ∃ J, J = W.majority (cosetAverage K) (fun u : Y => ((0 : X), u)) W.B := ⟨_, rfl⟩
  have hJ : MeasurableSet J := hJdef ▸ W.measurableSet_majority _ he hB
  have hW' := (W.aeIndependent_iff _).mp hW
  -- (1) `J` is a.e.-independent for `ν_X × ν_Y` (the pigeonhole) …
  have hJ1 : ∀ᵐ p ∂(νX.prod νY), ∀ᵐ ω ∂W.P, ω ∈ J → W.T p ω ∉ J := by
    filter_upwards [hW'] with p hp
    rw [hJdef]
    exact W.ae_majority _ he hB hp
  -- (2) … and invariant under `K` …
  have hinv : ∀ u ∈ K, ∀ ω, W.T (0, u) ω ∈ J ↔ ω ∈ J := by
    intro u hu ω
    rw [hJdef]
    show 2⁻¹ < cosetAverage K {v | W.T ((0 : X), v) (W.T (0, u) ω) ∈ W.B} ↔
      2⁻¹ < cosetAverage K {v | W.T ((0 : X), v) ω ∈ W.B}
    have h : {v : Y | W.T ((0 : X), v) (W.T (0, u) ω) ∈ W.B}
        = (fun v => u + v) ⁻¹' {v | W.T ((0 : X), v) ω ∈ W.B} := by
      ext v
      simp only [Set.mem_setOf_eq, Set.mem_preimage]
      rw [← W.T_add_apply, show ((0 : X), v) + (0, u) = (0, u + v) by simp [add_comm]]
    have h' := cosetAverage_preimage_add K hu (S := {v | W.T ((0 : X), v) ω ∈ W.B}) (W.measurable_T_left he ω hB)
    rw [h, h']
  -- (3) … so it is a.e.-independent for the smoothed measure.
  have hqinv : ∀ s y, ∀ u ∈ K, W.P (J ∩ W.T (s, y + u) ⁻¹' J) = W.P (J ∩ W.T (s, y) ⁻¹' J) := by
    intro s y u hu
    congr 1
    ext ω
    have h : W.T (s, y + u) ω = W.T (0, u) (W.T (s, y) ω) := by
      rw [← W.T_add_apply, show ((0 : X), u) + (s, y) = (s, y + u) by simp [add_comm]]
    simp only [Set.mem_inter_iff, Set.mem_preimage, h, hinv u hu]
  have hJ2 : (W.pull (AddMonoidHom.id (X × Y)) measurable_id J hJ).AEIndependent
      (νX.prod (Measure.conv νY (cosetAverage K))) := by
    show ((νX.prod (Measure.conv νY (cosetAverage K))).prod W.P) {p : (X × Y) × W.Ω | p.2 ∈ J ∧ W.T p.1 p.2 ∈ J} = 0
    calc ((νX.prod (Measure.conv νY (cosetAverage K))).prod W.P) {p : (X × Y) × W.Ω | p.2 ∈ J ∧ W.T p.1 p.2 ∈ J}
        = ∫⁻ p, W.P (J ∩ W.T p ⁻¹' J) ∂(νX.prod (Measure.conv νY (cosetAverage K))) :=
          W.prod_apply_corr _ measurable_id hJ hJ
      _ = ∫⁻ p, W.P (J ∩ W.T p ⁻¹' J) ∂(νX.prod νY) :=
          lintegral_prod_conv_cosetAverage K νX νY (W.measurable_corr measurable_id hJ hJ) hqinv
      _ = ((νX.prod νY).prod W.P) {p : (X × Y) × W.Ω | p.2 ∈ J ∧ W.T p.1 p.2 ∈ J} :=
          (W.prod_apply_corr _ measurable_id hJ hJ).symm
      _ = 0 := (W.prod_null_iff (νX.prod νY) measurable_id hJ hJ).mpr hJ1
  -- the mass.
  have hPJ : W.P J ≤ ratio (νX.prod (Measure.conv νY (cosetAverage K))) :=
    (W.pull (AddMonoidHom.id (X × Y)) measurable_id J hJ).prob_le_ratio hJ2
  have hmass := W.measure_le_majority_add (cosetAverage K) he hB
  rw [← hJdef] at hmass
  exact hmass.trans (add_le_add_left hPJ _)

/-- **X25B-L1**: "a profinite factor's stationary ratio in a product is at most the supremum over its finite levels (fibre
shares above `1/2` form an a.e.-independent set)". `Y` compact with open subgroups `K k` shrinking to `0`; the level-`k` graph is
`X × Y` with `ν_Y` smoothed by the Haar probability of `K k` (the pull-back of `X × Y/K_k`). -/
theorem ratio_prod_le_iSup_levels {X Y : Type*} [AddCommGroup X] [MeasurableSpace X] [MeasurableAdd₂ X]
    [AddCommGroup Y] [TopologicalSpace Y] [IsTopologicalAddGroup Y] [CompactSpace Y] [LocallyCompactSpace Y] [T2Space Y]
    [SecondCountableTopology Y] [MeasurableSpace Y] [BorelSpace Y] (νX : Measure X) [SigmaFinite νX] (νY : Measure Y)
    [IsFiniteMeasure νY] (K : ℕ → OpenAddSubgroup Y) (hK : Antitone K)
    (hK0 : ∀ V ∈ nhds (0 : Y), ∃ k, (K k : Set Y) ⊆ V) :
    ratio (νX.prod νY) ≤ ⨆ k, ratio (νX.prod (Measure.conv νY (cosetAverage (K k)))) := by
  -- Not read by the proof (FS131-I10B, findings): `MeasurableAdd₂ X`, `SigmaFinite νX`, `T2Space Y`, and that `K` is
  -- antitone — one level inside a small neighbourhood of `0` is enough. Consumed here for the unused-arguments linters.
  refine iSup₂_le fun W hW => ?_
  refine ENNReal.le_of_forall_pos_le_add fun ε hε _ => ?_
  have hB := W.measurableSet_B
  have hinr : Measurable (AddMonoidHom.inr X Y) := by
    show Measurable fun u : Y => ((0 : X), u)
    exact measurable_const.prodMk measurable_id
  -- the `Y`-action is continuous at `0` on the event: a level `k` inside the `ε`-neighbourhood.
  have hcont : Filter.Tendsto (fun u : Y => W.P ((W.T (0, u) ⁻¹' W.B) ∆ W.B)) (nhds 0) (nhds 0) :=
    tendsto_measure_symmDiff_shift (W.pull (AddMonoidHom.inr X Y) hinr W.B hB) hB
  have hU : {u : Y | W.P ((W.T (0, u) ⁻¹' W.B) ∆ W.B) < ε} ∈ nhds (0 : Y) :=
    hcont (Iio_mem_nhds (ENNReal.coe_pos.mpr hε))
  obtain ⟨k, hk⟩ := hK0 _ hU
  have hint : ∫⁻ u, W.P ((W.T (0, u) ⁻¹' W.B) ∆ W.B) ∂cosetAverage (K k) ≤ ε :=
    calc ∫⁻ u, W.P ((W.T (0, u) ⁻¹' W.B) ∆ W.B) ∂cosetAverage (K k)
        ≤ ∫⁻ _, (ε : ENNReal) ∂cosetAverage (K k) := by
          refine lintegral_mono_ae ?_
          filter_upwards [ae_mem_cosetAverage (K k)] with u hu using (hk hu).le
      _ = ε := by rw [lintegral_const, measure_univ, mul_one]
  exact (W.prob_le_ratio_level_add νX νY (K k) hW).trans
    (add_le_add (le_iSup (fun k => ratio (νX.prod (Measure.conv νY (cosetAverage (K k))))) k) hint)

end HadwigerNelson.StationaryRatio

open HadwigerNelson.StationaryRatio in
#print axioms StationarySet.prob_le_ratio_mul
open HadwigerNelson.StationaryRatio in
#print axioms ratio_prod_le
open HadwigerNelson.StationaryRatio in
#print axioms ratio_prod_le_iSup_levels
#lint
