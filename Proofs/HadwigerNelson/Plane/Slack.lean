import Proofs.HadwigerNelson.Plane.Suprema
import Proofs.HadwigerNelson.Plane.CPColouring

/-!
# Rescaling, the suprema's limits, the equivalence, kept points, the face lemma (FS-131 wave 2)

Rows: **FS111-V0-RESCALE**, **FS129-SR2-SUPK** (carrying FS106-SUP), **FS106-EQ**, **FS106-COMP** (second clause),
**FS106-REM**, **FS121-D4-FACE** (with FS121-V5-FACE-SHARP's hypothesis), **FS121-V5-FACE-SHARP**.
Plan: `plans/FS131-w2-kernel-plan.md` § 4.

**Named hypothesis from outside the backlog** (`plans/FS131-kernel-plan.md` § 7.4): `Row130M1`, FS-103's M1 in its
hard direction (`χ_m⁰(ℝ²) ≤ k ⟹ χ_CP(ℝ²) ≤ k`, row 130's last equality; [hand, two minds]) — a stationary limit of
translates (Krylov–Bogolyubov) with the Rajchman step. It enters only FS106-EQ's `χ_CP` clause; its own path to the kernel is
a separate planner-and-implementer job (FS-103's M1 module). The easy direction is formalized here unconditionally.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-- **FS111-V0-RESCALE**: if an a.e.-proper measurable `k`-colouring exists, a tight one exists. -/
theorem AeColouring.exists_tight (c : AeColouring k) : ∃ c' : AeColouring k, c'.Tight := by
  sorry

/-- **FS111-V0-RESCALE**, second clause: a tight a.e.-proper `k`-colouring exists iff `χ_m⁰(ℝ²) ≤ k`. -/
theorem exists_tight_iff_chiM0_le : (∃ c : AeColouring k, c.Tight) ↔ chiM0 ≤ k := by
  constructor
  · rintro ⟨c, -⟩; exact chiM0_le c
  · intro h
    have hm : ∃ m ≤ k, Nonempty (AeColouring m) := by
      by_contra hcon
      push Not at hcon
      have : ((k + 1 : ℕ) : ℕ∞) ≤ chiM0 := by
        refine le_iInf₂ fun m ⟨c⟩ => ?_
        have : k < m := by
          by_contra hmk
          exact (hcon m (not_lt.1 hmk)).false c
        exact_mod_cast this
      have h2 := this.trans h
      have : k + 1 ≤ k := by exact_mod_cast h2
      omega
    obtain ⟨m, hmk, ⟨c⟩⟩ := hm
    obtain ⟨c', -⟩ : ∃ c' : AeColouring k, True := by
      refine ⟨⟨fun z => Fin.castLE hmk (c.col z), ?_, fun j => ?_⟩, trivial⟩
      · exact (measurable_of_finite (Fin.castLE hmk)).comp c.measurable
      · by_cases hj : ∃ j', Fin.castLE hmk j' = j
        · obtain ⟨j', rfl⟩ := hj
          have : (fun z => Fin.castLE hmk (c.col z)) ⁻¹' {Fin.castLE hmk j'} = c.col ⁻¹' {j'} := by
            ext z; simp [(Fin.castLE_injective hmk).eq_iff]
          rw [this]; exact c.unitPairsNull j'
        · have : (fun z => Fin.castLE hmk (c.col z)) ⁻¹' {j} = ∅ := by
            ext z; simp only [mem_preimage, mem_singleton_iff, mem_empty_iff_false, iff_false]
            exact fun h => hj ⟨_, h⟩
          rw [this]
          have : UnitPairsNull (∅ : Set ℂ) := by
            rw [UnitPairsNull, show unitPairSet (∅ : Set ℂ) = ∅ by ext q; simp [unitPairSet], measure_empty]
          exact this
    exact AeColouring.exists_tight c'

/-- **FS129-SR2-SUPK** (carrying FS106-SUP's first clause, at every `k`): `µ_k⁰ = lim_{ε→0} µ_k(ε)`. -/
theorem tendsto_mu (k : ℕ) : Tendsto (mu k) (𝓝[>] 0) (𝓝 (muZero k)) := by
  sorry

/-- **FS129-SR2-SUPK**: `µ_k⁰ = lim_{ε→0} µ_k^tile(ε)`. -/
theorem tendsto_muTile (k : ℕ) : Tendsto (muTile k) (𝓝[>] 0) (𝓝 (muZero k)) := by
  sorry

/-- **FS129-SR2-SUPK**: `µ_k⁰ = lim_{ε→0} µ_k^per(ε)`. -/
theorem tendsto_muPer (k : ℕ) : Tendsto (muPer k) (𝓝[>] 0) (𝓝 (muZero k)) := by
  sorry

/-- FS-103's M1, hard direction, as the named hypothesis FS106-EQ's `χ_CP` clause reads (outside the backlog). -/
def Row130M1 : Prop := ∀ k : ℕ, chiM0 ≤ k → chiCP ≤ k

/-- FS-103's M1, easy direction (TQ § 2.3, steps 1 and 3): a CP `k`-colouring has a jointly measurable modification whose
realisations are a.e.-proper, so `χ_m⁰(ℝ²) ≤ χ_CP(ℝ²)`. Formalized here; no hypothesis. -/
theorem chiM0_le_chiCP : chiM0 ≤ chiCP := by
  sorry

/-- **FS106-EQ**, (a) ⟺ (c), and FS106-COMP's first clause as (c) ⟹ (a) at every `k` (SR2 item 11):
`χ_m⁰(ℝ²) ≤ k ⟺ µ_k⁰ = 1`. -/
theorem chiM0_le_iff_muZero_eq_one (k : ℕ) : chiM0 ≤ k ↔ muZero k = 1 := by
  sorry

/-- **FS106-EQ**, (a) ⟺ (b), given FS-103's M1 (`Row130M1`, named): `χ_m⁰(ℝ²) ≤ k ⟺ χ_CP(ℝ²) ≤ k`. -/
theorem chiM0_le_iff_chiCP_le (hM1 : Row130M1) (k : ℕ) : chiM0 ≤ k ↔ chiCP ≤ k :=
  ⟨hM1 k, fun h => chiM0_le_chiCP.trans h⟩

/-- **FS106-EQ**, (c) ⟺ (d) (SUPK at the value `1`): `µ_k⁰ = 1 ⟺ lim_{ε→0} µ_k(ε) = 1`. -/
theorem muZero_eq_one_iff_tendsto (k : ℕ) : muZero k = 1 ↔ Tendsto (mu k) (𝓝[>] 0) (𝓝 1) := by
  constructor
  · intro h; rw [← h]; exact tendsto_mu k
  · intro h; exact tendsto_nhds_unique (tendsto_mu k) h |>.symm ▸ rfl

/-- A band-free class (no pair at a distance in `[1 − ε, 1 + ε]`, `ε ≥ 0`) has null unit pairs. -/
theorem unitPairsNull_of_bandFree {A : Set ℂ} {ε : ℝ} (hε : 0 ≤ ε) (h : BandFree A ε) : UnitPairsNull A := by
  rw [UnitPairsNull]
  have : unitPairSet A = ∅ := by
    ext q
    simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro hx hy
    have hd : dist q.1 (q.1 + e q.2) = 1 := by rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]
    rcases h _ hx _ hy with h1 | h1 <;> linarith
  rw [this, measure_empty]

/-- **FS106-EQ**, (a) ⟺ (e): `χ_m⁰(ℝ²) ≤ k` iff for every `δ > 0` there are `ε > 0` and a periodic partial `k`-colouring by
half-open grid squares with no monochromatic pair at any distance in `[1 − ε, 1 + ε]`, covering upper density at least
`1 − δ`. -/
theorem chiM0_le_iff_periodic (k : ℕ) :
    chiM0 ≤ k ↔ ∀ δ > 0, ∃ ε > 0, ∃ C : Fin k → Set ℂ, IsPartialColouring C ∧ IsTiled C ∧ IsPeriodic C ∧
      (∀ j, BandFree (C j) ε) ∧ 1 - ENNReal.ofReal δ ≤ upperDensity (⋃ j, C j) := by
  constructor
  · intro h δ hδ
    have hz : muZero k = 1 := (chiM0_le_iff_muZero_eq_one k).1 h
    have hlim := tendsto_muPer k
    rw [hz] at hlim
    have hlt : 1 - ENNReal.ofReal δ < 1 := ENNReal.sub_lt_self (by simp) one_ne_zero (by simpa using hδ)
    have hev := hlim.eventually (lt_mem_nhds hlt)
    obtain ⟨ε, hε, hεpos⟩ := (hev.and self_mem_nhdsWithin).exists
    obtain ⟨C, hC⟩ := lt_iSup_iff.1 hε
    obtain ⟨hCp, hdens⟩ := lt_iSup_iff.1 hC
    exact ⟨ε, hεpos, C, hCp.1, hCp.2.1, hCp.2.2.1, hCp.2.2.2, hdens.le⟩
  · intro h
    refine (chiM0_le_iff_muZero_eq_one k).2 (le_antisymm (muZero_le_one k) ?_)
    refine ENNReal.le_of_forall_pos_le_add fun r hr _ => ?_
    obtain ⟨ε, hε, C, hCp, hCt, hCper, hCb, hd⟩ := h (r : ℝ) (by exact_mod_cast hr)
    have hle : upperDensity (⋃ j, C j) ≤ muZero k :=
      le_iSup₂ (f := fun C (_ : IsPartialColouring C ∧ ∀ j, UnitPairsNull (C j)) => upperDensity (⋃ j, C j)) C
        ⟨hCp, fun j => unitPairsNull_of_bandFree hε.le (hCb j)⟩
    have h3 : 1 - ENNReal.ofReal (r : ℝ) ≤ muZero k := hd.trans hle
    rw [tsub_le_iff_right, ENNReal.ofReal_coe_nnreal] at h3
    exact h3

/-- **FS106-EQ**, at `k = 6`: `χ_m⁰(ℝ²) ≥ 7 ⟺ lim_{ε→0} µ₆(ε) < 1` (the limit is the supremum over `ε > 0`, `µ₆` being
antitone). -/
theorem seven_le_chiM0_iff : 7 ≤ chiM0 ↔ (⨆ ε > (0 : ℝ), mu 6 ε) < 1 := by
  have hlim : muZero 6 = ⨆ ε > (0 : ℝ), mu 6 ε := by
    have h1 := (antitone_mu 6).tendsto_nhdsGT 0
    rw [sSup_image] at h1
    exact tendsto_nhds_unique (tendsto_mu 6) h1
  have hle : (⨆ ε > (0 : ℝ), mu 6 ε) ≤ 1 := iSup₂_le fun ε _ => mu_le_one 6 ε
  have h7 : (7 : ℕ∞) ≤ chiM0 ↔ ¬ chiM0 ≤ 6 := by
    rw [not_le]
    have := ENat.add_one_le_iff (m := 6) (n := chiM0) (by decide)
    rwa [show (6 : ℕ∞) + 1 = 7 by norm_num] at this
  have h6 : chiM0 ≤ 6 ↔ muZero 6 = 1 := by exact_mod_cast chiM0_le_iff_muZero_eq_one 6
  rw [h7, h6, hlim]
  constructor
  · intro h; exact lt_of_le_of_ne hle h
  · intro h h1; exact h.ne h1

/-- `[Voronov2023]` Thm 1.1 (Euclidean norm, six colours), as a statement: for every `ε > 0` no six-colouring of the plane
is proper for the forbidden interval `[1 − ε, 1 + ε]` (D-VPROP). Named here, not imported (FS106-COMP's clause is an
equivalence, not a use). -/
def Voronov11 : Prop :=
  ∀ ε > 0, ¬ ∃ f : ℂ → Fin 6, ∀ x y, 1 - ε ≤ dist x y → dist x y ≤ 1 + ε → f x ≠ f y

/-- **FS106-SUP's attainment clause, at the value FS106-COMP reads** (carried content of FS129-SR2-SUPK's merged row, inventory
item 23): if `µ_k(ε) = 1`, some partial `k`-colouring whose classes are band-null at `ε` covers almost every point. QB § 2.7
reaches it through SUP's stationary attaining family (mean coverage `1`); FS106-QB § 2.4's compactness argument for (c) ⟹ (a)
gives it directly at every `k` — translates to windows of small hole measure, a weak-* limit, the band form continuous because
its kernel `1_{annulus}` is `L¹` (no Rajchman step, no Krylov–Bogolyubov), and support selection. -/
theorem exists_bandNull_aeCover_of_mu_eq_one {k : ℕ} {ε : ℝ} (hε : 0 < ε) (h : mu k ε = 1) :
    ∃ C : Fin k → Set ℂ, IsPartialColouring C ∧ (∀ j, BandNull (C j) ε) ∧ ∀ᵐ x ∂volume, ∃ j, x ∈ C j := by
  sorry

/-- A band-free class is band-null. -/
theorem bandNull_of_bandFree {A : Set ℂ} {ε : ℝ} (h : BandFree A ε) : BandNull A ε := by
  have : bandPairSet A ε = ∅ := by
    ext q
    simp only [bandPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro hx hy h1 h2
    rcases h _ hx _ hy with h3 | h3 <;> linarith
  rw [BandNull, this, measure_empty]

open Classical in
/-- COMP, `⟹`: if `µ₆(ε) < 1` for every `ε > 0`, no six-colouring is proper on a band (the closures of the colour
classes, made disjoint, are a band-free partial colouring covering everything, so `µ₆(ε/2) = 1`). -/
theorem voronov11_of_forall_mu_lt (H : ∀ ε > (0 : ℝ), mu 6 ε < 1) : Voronov11 := by
  intro ε hε ⟨f, hf⟩
  set cl : Fin 6 → Set ℂ := fun j => closure (f ⁻¹' {j}) with hcl
  have h1 : ∀ j, ∀ x ∈ cl j, ∀ y ∈ cl j, dist x y ≤ 1 - ε ∨ 1 + ε ≤ dist x y := by
    intro j x hx y hy
    by_contra hcon
    push Not at hcon
    have hxy : (x, y) ∈ closure ((f ⁻¹' {j}) ×ˢ (f ⁻¹' {j})) := by
      rw [closure_prod_eq]; exact ⟨hx, hy⟩
    have hopen : IsOpen {q : ℂ × ℂ | 1 - ε < dist q.1 q.2 ∧ dist q.1 q.2 < 1 + ε} :=
      (isOpen_lt continuous_const (continuous_fst.dist continuous_snd)).inter
        (isOpen_lt (continuous_fst.dist continuous_snd) continuous_const)
    have hmem : (x, y) ∈ {q : ℂ × ℂ | 1 - ε < dist q.1 q.2 ∧ dist q.1 q.2 < 1 + ε} := ⟨hcon.1, hcon.2⟩
    obtain ⟨q, hq1, hq2⟩ := mem_closure_iff.1 hxy _ hopen hmem
    exact hf q.1 q.2 hq1.1.le hq1.2.le (by rw [mem_prod] at hq2; exact (hq2.1.trans hq2.2.symm))
  set C : Fin 6 → Set ℂ := fun j => cl j \ ⋃ i < j, cl i with hC
  have hCm : ∀ j, MeasurableSet (C j) := fun j =>
    isClosed_closure.measurableSet.diff (MeasurableSet.biUnion (countable_univ.mono (subset_univ _))
      fun i _ => isClosed_closure.measurableSet)
  have hcov : ⋃ j, C j = univ := by
    refine eq_univ_of_forall fun x => ?_
    have hne : (Finset.univ.filter fun j => x ∈ cl j).Nonempty := ⟨f x, by simp [hcl]; exact subset_closure rfl⟩
    set j0 := (Finset.univ.filter fun j => x ∈ cl j).min' hne
    have hj0 : x ∈ cl j0 := by
      have := Finset.min'_mem _ hne; simpa using this
    refine mem_iUnion.2 ⟨j0, hj0, ?_⟩
    simp only [mem_iUnion, not_exists]
    intro i hi hxi
    have : j0 ≤ i := Finset.min'_le _ i (by simpa using hxi)
    exact absurd hi (not_lt.2 this)
  have hdis : Pairwise (Function.onFun Disjoint C) := by
    intro i j hij
    wlog h : i < j generalizing i j
    · exact (this hij.symm (lt_of_le_of_ne (not_lt.1 h) hij.symm)).symm
    refine disjoint_left.2 fun x hxi hxj => hxj.2 (mem_iUnion₂.2 ⟨i, h, hxi.1⟩)
  have hfree : ∀ j, BandFree (C j) (ε / 2) := by
    intro j x hx y hy
    rcases h1 j x hx.1 y hy.1 with h | h
    · left; linarith
    · right; linarith
  have hle : (1 : ENNReal) ≤ mu 6 (ε / 2) := by
    calc (1 : ENNReal) = upperDensity (⋃ j, C j) := by rw [hcov, upperDensity_univ]
      _ ≤ mu 6 (ε / 2) := le_iSup₂ (f := fun C (_ : IsPartialColouring C ∧ ∀ j, BandNull (C j) (ε / 2)) =>
          upperDensity (⋃ j, C j)) C ⟨⟨hCm, hdis⟩, fun j => bandNull_of_bandFree (hfree j)⟩
  exact absurd (H (ε / 2) (by linarith)) (not_lt.2 hle)


open Classical in
/-- COMP, `⟸`, through the attainment lemma: the supports of the classes of an a.e.-covering band-null partial colouring
cover the plane, and the least index of a support containing `x` is a six-colouring proper on `[1 − ε/2, 1 + ε/2]`. -/
theorem mu_lt_of_voronov11 (hV : Voronov11) {ε : ℝ} (hε : 0 < ε) : mu 6 ε < 1 := by
  by_contra hcon
  have h1 : mu 6 ε = 1 := le_antisymm (mu_le_one 6 ε) (not_lt.1 hcon)
  obtain ⟨C, hCp, hband, hae⟩ := exists_bandNull_aeCover_of_mu_eq_one hε h1
  -- the supports cover the plane
  have hcl : IsClosed (⋃ j, essSupport (C j)) := isClosed_iUnion_of_finite fun j => isClosed_essSupport _
  have hfull : ⋃ j, essSupport (C j) = univ := by
    by_contra hne
    have hopen : IsOpen (⋃ j, essSupport (C j))ᶜ := hcl.isOpen_compl
    have hnonempty : (⋃ j, essSupport (C j))ᶜ.Nonempty := by
      rwa [nonempty_iff_ne_empty, Ne, compl_empty_iff]
    have hpos := hopen.measure_pos volume hnonempty
    refine hpos.ne' (measure_mono_null (t := {x | ¬ ∃ j, x ∈ C j} ∪ ⋃ j, C j \ essSupport (C j)) ?_ ?_)
    · intro x hx
      by_cases hx' : ∃ j, x ∈ C j
      · obtain ⟨j, hj⟩ := hx'
        right
        refine mem_iUnion.2 ⟨j, hj, fun hs => hx (mem_iUnion.2 ⟨j, hs⟩)⟩
      · exact Or.inl hx'
    · exact measure_union_null (by simpa [ae_iff] using hae)
        (measure_iUnion_null fun j => volume_diff_essSupport (C j))
  set f : ℂ → Fin 6 := fun x => if h : ∃ j, x ∈ essSupport (C j) then Classical.choose h else 0 with hf
  have hfs : ∀ x, x ∈ essSupport (C (f x)) := by
    intro x
    have h : ∃ j, x ∈ essSupport (C j) := by
      have : x ∈ ⋃ j, essSupport (C j) := by rw [hfull]; trivial
      simpa using this
    simp only [hf, dif_pos h]
    exact Classical.choose_spec h
  refine hV (ε / 2) (by linarith) ⟨f, fun x y h1 h2 hxy => ?_⟩
  set j := f x
  have hy : y ∈ essSupport (C j) := by rw [hxy]; exact hfs y
  have hx : x ∈ essSupport (C j) := hfs x
  refine absurd (hband j) ?_
  unfold BandNull
  set r : ℝ := ε / 4 with hr4
  have hr : 0 < r := by positivity
  have hsub : (C j ∩ ball x r) ×ˢ (C j ∩ ball y r) ⊆ bandPairSet (C j) ε := by
    rintro ⟨a, b⟩ ⟨⟨ha, hax⟩, hb, hby⟩
    rw [mem_ball] at hax hby
    refine ⟨ha, hb, ?_, ?_⟩
    · show 1 - ε ≤ dist a b
      have t1 := dist_triangle4 x a b y
      rw [dist_comm x a] at t1
      simp only at hax hby
      linarith [hr4]
    · show dist a b ≤ 1 + ε
      have t1 := dist_triangle4 a x y b
      rw [dist_comm y b] at t1
      simp only at hax hby
      linarith [hr4]
  have hpos : 0 < (volume.prod volume) ((C j ∩ ball x r) ×ˢ (C j ∩ ball y r)) := by
    rw [Measure.prod_prod]
    exact ENNReal.mul_pos (hx r hr).ne' (hy r hr).ne'
  exact fun h0 => hpos.ne' (measure_mono_null hsub h0)

/-- **FS106-COMP**, second clause: "`µ₆(ε) < 1` for every `ε > 0`" is equivalent to `[Voronov2023]` Thm 1.1. -/
theorem forall_mu_six_lt_one_iff : (∀ ε > (0 : ℝ), mu 6 ε < 1) ↔ Voronov11 := by
  exact ⟨voronov11_of_forall_mu_lt, fun hV ε hε => mu_lt_of_voronov11 hV hε⟩

/-- `x` is **kept** at scale `ε` for the class `A` with threshold `η`: the balls of radii `ε/2` and `2ε` about `x` are at
least `1 − η` full of `Ã` (FS106-TQ § 2.2). -/
def KeptAt (A : Set ℂ) (η ε : ℝ) (x : ℂ) : Prop :=
  ∀ ρ ∈ ({ε / 2, 2 * ε} : Set ℝ), ENNReal.ofReal (1 - η) * volume (ball x ρ) ≤ volume (ball x ρ ∩ densitySet A)

/-- **FS106-REM**, first clause (one class, G92): for a measurable `A` with null unit pairs, any `η < 1/(1 + 4π)` and every
`ε > 0`, two points kept at scale `ε` are never at a distance in `[1 − ε, 1 + ε]`. (The row reads kept points of one
colour of a partial colouring; membership of the points in `A` is not used — a generalization.) -/
theorem keptAt_band {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {η : ℝ} (hη0 : 0 ≤ η)
    (hη : η < 1 / (1 + 4 * Real.pi)) {ε : ℝ} (hε : 0 < ε) {x y : ℂ} (hx : KeptAt A η ε x) (hy : KeptAt A η ε y) :
    dist x y < 1 - ε ∨ 1 + ε < dist x y := by
  sorry

/-- **FS106-REM**, second clause: for a CP colouring, `P(0 is not kept at scale ε) → 0`, "kept" read in a jointly
measurable modification `c̃` of the realisations. -/
theorem CPColouring.tendsto_not_kept (c : CPColouring k) {η : ℝ} (hη0 : 0 < η) :
    ∃ ct : (ℂ → Fin k) → ℂ → Fin k, Measurable (Function.uncurry ct) ∧ (∀ x, c.law {f | ct f x ≠ f x} = 0) ∧
      Tendsto (fun ε => c.law {f | ¬ KeptAt (ct f ⁻¹' {ct f 0}) η ε 0}) (𝓝[>] 0) (𝓝 0) := by
  sorry

/-- **FS106-REM**, third clause (ruling `plans/FS131-close-inventory.md` item 63: `η < 1` added, since at `η ≥ 1` every point
is kept): the uniform form is FALSE — some measurable colouring proper at every unit pair (the
zigzag colouring, FS106-TQ's control C2) has, at every `ε`, translates of the unit square holding non-kept points of
measure bounded below. -/
theorem exists_not_uniform_kept {η : ℝ} (hη0 : 0 < η) (hη : η < 1) :
    ∃ (k : ℕ) (f : ℂ → Fin k), Measurable f ∧ (∀ x y, dist x y = 1 → f x ≠ f y) ∧ ∃ m > (0 : ENNReal),
      ∀ ε > (0 : ℝ), ∃ z : ℂ, m ≤ volume {x | x - z ∈ {w : ℂ | 0 ≤ w.re ∧ w.re ≤ 1 ∧ 0 ≤ w.im ∧ w.im ≤ 1} ∧
        ¬ KeptAt (f ⁻¹' {f x}) η ε x} := by
  sorry

/-- The open half-box `{x − s e + t e⊥ : 0 < s < ε, |t| < ε}`, `e = e θ`, `e⊥ = i e θ`. -/
def halfBox (x : ℂ) (θ ε : ℝ) : Set ℂ :=
  {z | ∃ s t : ℝ, 0 < s ∧ s < ε ∧ |t| < ε ∧ z = x + e θ * (-s + t * I)}

/-- The open far box `{x + s e + t e⊥ : g < s < g + ε′, |t| < ρ}`. -/
def farBox (x : ℂ) (θ g ε' ρ : ℝ) : Set ℂ :=
  {z | ∃ s t : ℝ, g < s ∧ s < g + ε' ∧ |t| < ρ ∧ z = x + e θ * (s + t * I)}

/-- **FS121-D4-FACE** with **FS121-V5-FACE-SHARP**'s hypothesis `ρ² ≥ 2g − g²` (SR1 item 6), one class (G92: the argument
reads only `A`'s own unit pairs): if the half-box and the far box lie almost everywhere in `A`, no point of `supp A` is at
distance exactly `1` from `x`. The far box lies between `x` and `x + e` (`g < 1`; ruling, `plans/FS131-close-inventory.md` item
37: for `g > 2` the sharp hypothesis holds for every `ρ` and the clause is false — a far box beyond `x + 2e` meets no unit circle
about the points near `x + e`). -/
theorem face {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {x : ℂ} {θ ε ε' g ρ : ℝ} (hε : 0 < ε)
    (hε' : 0 < ε') (hg : 0 < g) (hg1 : g < 1) (hρ : 0 < ρ) (hsharp : 2 * g - g ^ 2 ≤ ρ ^ 2)
    (hhalf : volume (halfBox x θ ε \ A) = 0) (hfar : volume (farBox x θ g ε' ρ \ A) = 0) :
    ∀ y ∈ essSupport A, dist x y ≠ 1 := by
  sorry

/-- A set filling a half-box behind `x` almost everywhere has positive upper density at `x`. -/
theorem upperDensityAt_pos_of_halfBox {A : Set ℂ} {x : ℂ} {θ ε : ℝ} (hε : 0 < ε)
    (hhalf : volume (halfBox x θ ε \ A) = 0) : 0 < upperDensityAt A x := by
  have hev : ∀ᶠ r in 𝓝[>] (0 : ℝ), (1 / 16 : ENNReal) ≤ densityRatio A x r := by
    have : Ioo (0 : ℝ) ε ∈ 𝓝[>] (0 : ℝ) := Ioo_mem_nhdsGT hε
    filter_upwards [this] with r hr
    have hr0 : 0 < r := hr.1
    have hεr : r < ε := hr.2
    set c : ℂ := x - ((r / 2 : ℝ) : ℂ) * e θ with hc
    have hne : e θ ≠ 0 := by
      intro h; have := norm_e θ; rw [h, norm_zero] at this; exact zero_ne_one this
    have hsub : ball c (r / 4) ⊆ halfBox x θ ε := by
      intro w hw
      rw [mem_ball, dist_eq_norm] at hw
      set q : ℂ := (w - x) / e θ with hq
      have hqn : ‖q + ((r / 2 : ℝ) : ℂ)‖ < r / 4 := by
        have : q + ((r / 2 : ℝ) : ℂ) = (w - c) / e θ := by
          rw [hc, hq]; field_simp; ring
        rw [this, norm_div, norm_e, div_one]; exact hw
      have h1 : |q.re + r / 2| < r / 4 := by
        have := Complex.abs_re_le_norm (q + ((r / 2 : ℝ) : ℂ)); rw [Complex.add_re, Complex.ofReal_re] at this; linarith
      have h2 : |q.im| < r / 4 := by
        have := Complex.abs_im_le_norm (q + ((r / 2 : ℝ) : ℂ)); rw [Complex.add_im, Complex.ofReal_im, add_zero] at this; linarith
      rw [abs_lt] at h1 h2
      refine ⟨-q.re, q.im, by linarith [h1.1, h1.2], by linarith [h1.1, h1.2], ?_, ?_⟩
      · rw [abs_lt]; constructor <;> linarith [h2.1, h2.2]
      · have : (-((-q.re : ℝ) : ℂ) + (q.im : ℂ) * I) = q := by
          apply Complex.ext <;> simp
        rw [this, hq]; field_simp; ring
    have hcl : ball c (r / 4) ⊆ closedBall x r := by
      intro w hw
      rw [mem_ball] at hw
      rw [mem_closedBall]
      have h3 : dist c x = r / 2 := by
        rw [hc, dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_mul, norm_e, mul_one, Complex.norm_real,
          Real.norm_eq_abs, abs_of_pos (by linarith)]
      linarith [dist_triangle w c x]
    have hmeas : volume (ball c (r / 4)) ≤ volume (A ∩ closedBall x r) := by
      have h4 : volume (ball c (r / 4) \ A) = 0 :=
        measure_mono_null (t := halfBox x θ ε \ A) (fun w hw => ⟨hsub hw.1, hw.2⟩) hhalf
      calc volume (ball c (r / 4)) ≤ volume (ball c (r / 4) ∩ A) + volume (ball c (r / 4) \ A) :=
            measure_le_inter_add_sdiff _ _ _
        _ = volume (ball c (r / 4) ∩ A) := by rw [h4, add_zero]
        _ ≤ volume (A ∩ closedBall x r) := measure_mono fun w hw => ⟨hw.2, hcl hw.1⟩
    unfold densityRatio
    refine (ENNReal.le_div_iff_mul_le (Or.inl (measure_closedBall_pos volume x hr0).ne') (Or.inl measure_closedBall_lt_top.ne)).2 ?_
    refine le_trans ?_ hmeas
    rw [Complex.volume_ball, Complex.volume_closedBall]
    have h4 : ENNReal.ofReal (r / 4) = ENNReal.ofReal r / 4 := by
      rw [ENNReal.ofReal_div_of_pos (by norm_num)]; simp
    rw [h4, div_eq_mul_inv (ENNReal.ofReal r), mul_pow, ← ENNReal.inv_pow]
    have h16 : (4 : ENNReal) ^ 2 = 16 := by norm_num
    rw [h16, one_div]
    refine le_of_eq ?_
    ring
  exact lt_of_lt_of_le (by norm_num) (le_limsup_of_frequently_le hev.frequently)

/-- **FS121-D4-FACE**, last clause: so in a saturated colouring the colour has density `1` at `x` (`g < 1`, ruling item 37). -/
theorem face_densitySet {C : Fin k → Set ℂ} (hadm : IsAdmissible C) (hsat : Saturated C) {j : Fin k} {x : ℂ}
    {θ ε ε' g ρ : ℝ} (hε : 0 < ε) (hε' : 0 < ε') (hg : 0 < g) (hg1 : g < 1) (hρ : 0 < ρ)
    (hsharp : 2 * g - g ^ 2 ≤ ρ ^ 2)
    (hhalf : volume (halfBox x θ ε \ C j) = 0) (hfar : volume (farBox x θ g ε' ρ \ C j) = 0) :
    x ∈ densitySet (C j) := by
  have hA := hadm j
  have hpos := upperDensityAt_pos_of_halfBox hε hhalf
  by_contra hx
  obtain ⟨y, hy, hxy⟩ := hsat j x ⟨hpos, hx⟩
  rw [← essSupport_eq_closure_densitySet] at hy
  exact face hA.1 hA.2 hε hε' hg hg1 hρ hsharp hhalf hfar y hy hxy

/-- **FS121-V5-FACE-SHARP**, its failure half: whenever `ρ² < 2g − g²` the first clause fails for some a.e.-proper colouring
(V5 § 2.2's explicit colouring at `g = 1/10`, `ρ = 2/5`, generalized). -/
theorem exists_face_fails {g ρ : ℝ} (hg : 0 < g) (hρ : 0 < ρ) (hlt : ρ ^ 2 < 2 * g - g ^ 2) :
    ∃ (k : ℕ) (c : AeColouring k) (j : Fin k) (x : ℂ) (θ ε ε' : ℝ), 0 < ε ∧ 0 < ε' ∧
      volume (halfBox x θ ε \ c.cls j) = 0 ∧ volume (farBox x θ g ε' ρ \ c.cls j) = 0 ∧
      ∃ y ∈ essSupport (c.cls j), dist x y = 1 := by
  sorry

end HadwigerNelson.Plane
