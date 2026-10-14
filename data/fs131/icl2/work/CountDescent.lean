import Proofs.HadwigerNelson.Rigidity.CountExtension
import Proofs.HadwigerNelson.Rigidity.PlaneZhang

/-!
# The count: from the slice `Δ × K` down to the finite levels, and `TCA F → R88TCA` (FS-131, job FS131-K12A; module M12, block D; skeleton)

**Read aloud, against the derivation** (R88-TCA; J28D § 3.3: "the count reads `1 = Σ_j p_j ≤ 4 max(α(Y′), r_X) < 1` — no
such `μ`"; FS100-TCA). The headline's hypothesis `hCount : (chainInterface F).Count` is `TCA F → R88TCA`, and this module
proves it over the named outside hypothesis `Plane.OneAvoidingDensityBound` (`[AmbrusEtAl2023]` Thm 1):

* `levelRows φ j k q` — **the descent**: for a colouring `φ` of `ℂ × K`, a colour `j` and a level `k`, the points `z` at
  which colour `j` fills more than three quarters of the level-`k` coset `q` of the fibre `{x : φ(z, x) = j}`. Indexed by the
  finite group `(levR F k).range`, whose connection set is the image of `U` (`[S9]`, `image_levR_unitVectors`).
* `rowsEdgeNull_levelRows` — the level rows have null edges in `UD(ℝ²) ⊗ Cay(level k, U)`: two rows `q`, `q + s` over
  points at distance one share more than half of a coset of `K` after the translation `ιK u` (`u ↦ s`), so a positive
  measure of them would give the slice a positive measure of monochromatic edges.
* `volume_colour_le` — the window measure of colour `j` is at most the level rows' (each coset has measure `1/|level k|`)
  plus the points that fill their coset to at most three quarters, which tend to `0` (`tendsto_haarK_bad`).
* `false_of_slice` — **the contradiction**: four colours fill a window of `ℂ × K`; each holds at most
  `max(m₁, c) + ε` of it (`sum_volume_inter_sq_le` with `ratioLe_levR_range`); `m₁ < 1/4` and `c < 1/4`.
* `count_of_oneAvoidingDensityBound` — **the count**: `(chainInterface F).Count`, for every real number field, over
  `Plane.OneAvoidingDensityBound`. It reads `TCA F` through `Rigidity.tca_uniform` (module M13, over Weil's bound) and the
  scope through `noRamifiedStableDyadic_of_tca` — no hypothesis of the count is unread.

**Models.** `false_of_slice` is a step inside a proof by contradiction: its hypotheses are refuted by itself. At `ℚ(√11)`,
where `TCA` fails (the stable prime above `7` has all-levels ratio at least `2/7`, J28D § 3.4), the derivation's control
`⌊4(θ + s)⌋` is an invariant colouring with spectrum on `T + A` — the count's conclusion fails there, as it must.
-/

namespace HadwigerNelson.Rigidity.Counting

open SpectralChain NumberField MeasureTheory Filter Topology Plane

noncomputable section

variable {F : Subfield ℝ} [NumberField F]

/-- The finite group of level `k`, the image of `R`, as a `Fintype` for the descent's sums. -/
noncomputable instance (k : ℕ) : Fintype (levR F k).range.toAddSubgroup := Fintype.ofFinite _

/-- **The level-`k` rows of colour `j`.** -/
def levelRows (φ : ℂ × K F → Fin 4) (j : Fin 4) (k : ℕ) (q : (levR F k).range.toAddSubgroup) : Set ℂ :=
  {z | 3 / 4 * haarK F (proj F k ⁻¹' {(q : Lev F k)}) <
      haarK F ({x | φ (z, x) = j} ∩ proj F k ⁻¹' {(q : Lev F k)})}

-- FS131-ICL2: the proofs. Two measurability helpers, then the leaves in order.

/-- A level coset of `K` is open (the levels are discrete), so measurable. -/
private theorem measurableSet_proj_preimage (k : ℕ) (a : Lev F k) : MeasurableSet (proj F k ⁻¹' {a}) :=
  ((isOpen_discrete {a}).preimage (continuous_proj F k)).measurableSet

/-- The fibre measure `z ↦ haarK ({x : φ(z, x) = j} ∩ T)` is measurable (`measurable_measure_prodMk_left`). -/
private theorem measurable_haarK_fibre {φ : ℂ × K F → Fin 4} (hφ : Measurable φ) (j : Fin 4) {T : Set (K F)}
    (hT : MeasurableSet T) : Measurable fun z => haarK F ({x | φ (z, x) = j} ∩ T) := by
  have hS : MeasurableSet ({p : ℂ × K F | φ p = j} ∩ Set.univ ×ˢ T) :=
    (hφ (measurableSet_singleton j)).inter (MeasurableSet.univ.prod hT)
  have e : (fun z => haarK F ({x | φ (z, x) = j} ∩ T)) =
      fun z => haarK F (Prod.mk z ⁻¹' ({p : ℂ × K F | φ p = j} ∩ Set.univ ×ˢ T)) := by
    funext z
    congr 1
    ext x
    simp
  rw [e]
  exact measurable_measure_prodMk_left hS

/-- A window has finite area. -/
private theorem volume_squareWin_ne_top (a : ℂ) (s : ℝ) : volume (squareWin a s) ≠ ⊤ := by
  rcases le_or_gt 0 s with hs | hs
  · rw [volume_squareWin a hs]
    exact ENNReal.ofReal_ne_top
  · have h : squareWin a s = ∅ := by
      ext w
      simp only [squareWin, Set.mem_setOf_eq, Set.mem_empty_iff_false, iff_false]
      intro h
      linarith [h.1, h.2.1]
    rw [h, measure_empty]
    exact ENNReal.zero_ne_top

theorem measurableSet_levelRows {φ : ℂ × K F → Fin 4} (hφ : Measurable φ) (j : Fin 4) (k : ℕ)
    (q : (levR F k).range.toAddSubgroup) : MeasurableSet (levelRows φ j k q) :=
  measurableSet_lt measurable_const (measurable_haarK_fibre hφ j (measurableSet_proj_preimage k _))

/-- Two subsets of a set of finite measure, each filling more than three quarters of it, cannot be almost disjoint. -/
private theorem false_of_three_quarters {a b c : ENNReal} (hc : c ≠ ⊤) (ha : 3 / 4 * c < a) (hb : 3 / 4 * c < b)
    (hab : a + b ≤ c) : False := by
  have hac : a ≤ c := le_trans le_self_add hab
  have hbc : b ≤ c := le_trans le_add_self hab
  have ha' : a ≠ ⊤ := ne_top_of_le_ne_top hc hac
  have hb' : b ≠ ⊤ := ne_top_of_le_ne_top hc hbc
  have h34 : (3 / 4 : ENNReal) ≠ ⊤ := ENNReal.div_ne_top (by norm_num) (by norm_num)
  have e34 : ((3 / 4 : ENNReal) * c).toReal = 3 / 4 * c.toReal := by
    rw [ENNReal.toReal_mul, ENNReal.toReal_div]
    norm_num
  have h1 := (ENNReal.toReal_lt_toReal (ENNReal.mul_ne_top h34 hc) ha').2 ha
  have h2 := (ENNReal.toReal_lt_toReal (ENNReal.mul_ne_top h34 hc) hb').2 hb
  have h3 := (ENNReal.toReal_le_toReal (ENNReal.add_ne_top.2 ⟨ha', hb'⟩) hc).2 hab
  rw [ENNReal.toReal_add ha' hb'] at h3
  rw [e34] at h1 h2
  have h0 : 0 ≤ c.toReal := ENNReal.toReal_nonneg
  linarith

/-- **The level rows have null edges.** -/
theorem rowsEdgeNull_levelRows (hT : TCA F) {φ : ℂ × K F → Fin 4} (hφ : Measurable φ) (h : SliceEdgeNull φ) (j : Fin 4)
    (k : ℕ) :
    RowsEdgeNull {d : (levR F k).range.toAddSubgroup | (d : Lev F k) ∈ normOneLev F k} (levelRows φ j k) := by
  -- Route: `s = levR k u` for a unit vector `u` (`image_levR_unitVectors`, under `TCA F`); translation by `ιK u` carries the
  -- coset `q` onto `q + s` preserving Haar measure, so at a row pair `(z, z + e θ)` the two colour-`j` fills of the coset
  -- `q` share positive measure, all of it monochromatic slice edges at `u`; Tonelli in the order `((z, θ), x)`.
  intro q s hs
  obtain ⟨u, hu, hus⟩ : ∃ u : unitRing F, (u : ℂ) ∈ unitVectors F ∧ levR F k u = (s : Lev F k) := by
    have hs' : (s : Lev F k) ∈ levR F k '' {r | (r : ℂ) ∈ unitVectors F} := by
      rw [image_levR_unitVectors F hT k]
      exact hs
    obtain ⟨u, hu, e⟩ := hs'
    exact ⟨u, hu, e⟩
  set C : Set (K F) := proj F k ⁻¹' {(q : Lev F k)} with hC
  set C' : Set (K F) := proj F k ⁻¹' {((q + s : (levR F k).range.toAddSubgroup) : Lev F k)} with hC'
  set g : K F := ιK F u with hg
  -- translation by `g` carries `C` onto `C'`
  have hshift : ∀ x : K F, x + g ∈ C' ↔ x ∈ C := by
    intro x
    simp only [hC, hC', Set.mem_preimage, Set.mem_singleton_iff, map_add, hg, proj_ιK, hus,
      AddSubgroup.coe_add]
    exact add_left_inj _
  have hpre : ∀ T : Set (K F), haarK F ((fun x => x + g) ⁻¹' T) = haarK F T := by
    intro T
    have e : (fun x : K F => x + g) = fun x => g + x := funext fun x => add_comm x g
    rw [e]
    exact measure_preimage_add (haarK F) g T
  have hCC' : haarK F C = haarK F C' := by
    rw [← hpre C']
    congr 1
    ext x
    exact (hshift x).symm
  -- the monochromatic slice edges at `u`, reordered to `((z, θ), x)`
  set M : Set ((ℂ × K F) × ℝ) := {p | φ p.1 = φ (p.1.1 + e p.2, p.1.2 + ιK F u)} with hM
  have hM0 : ((volume.prod (haarK F)).prod arcLength) M = 0 := h u hu
  have hgp : MeasurePreserving (fun p : (ℂ × ℝ) × K F => ((p.1.1, p.2), p.1.2))
      (((volume : Measure ℂ).prod arcLength).prod (haarK F)) (((volume : Measure ℂ).prod (haarK F)).prod arcLength) := by
    have h1 := measurePreserving_prodAssoc (volume : Measure ℂ) arcLength (haarK F)
    have h2 := (MeasurePreserving.id (volume : Measure ℂ)).prod
      (Measure.measurePreserving_swap (μ := arcLength) (ν := haarK F))
    have h3 := (measurePreserving_prodAssoc (volume : Measure ℂ) (haarK F) arcLength).symm
    exact (h3.comp h2).comp h1
  set N : Set ((ℂ × ℝ) × K F) := (fun p : (ℂ × ℝ) × K F => ((p.1.1, p.2), p.1.2)) ⁻¹' M with hN
  have hN0 : (((volume : Measure ℂ).prod arcLength).prod (haarK F)) N = 0 :=
    hgp.quasiMeasurePreserving.preimage_null hM0
  have hae := Measure.measure_ae_null_of_prod_null hN0
  -- every row pair has a section of positive measure
  have hsub : pairSet (levelRows φ j k q) (levelRows φ j k (q + s)) ⊆
      {p | ¬ (haarK F (Prod.mk p ⁻¹' N) = (0 : ℂ × ℝ → ENNReal) p)} := by
    rintro ⟨z, θ⟩ ⟨hz, hz'⟩ hnull
    set A : Set (K F) := {x | φ (z, x) = j} ∩ C with hA
    set B : Set (K F) := (fun x => x + g) ⁻¹' ({y | φ (z + e θ, y) = j} ∩ C') with hB
    have hAm : MeasurableSet A :=
      (hφ.comp measurable_prodMk_left (measurableSet_singleton j)).inter (measurableSet_proj_preimage k _)
    have hBm : MeasurableSet B :=
      ((hφ.comp measurable_prodMk_left (measurableSet_singleton j)).inter
        (measurableSet_proj_preimage k _)).preimage (measurable_add_const g)
    have hAC : A ⊆ C := Set.inter_subset_right
    have hBC : B ⊆ C := fun x hx => (hshift x).1 hx.2
    have hAB : A ∩ B ⊆ Prod.mk (z, θ) ⁻¹' N := by
      rintro x ⟨hxA, hxB⟩
      show φ (z, x) = φ (z + e θ, x + ιK F u)
      exact hxA.1.trans hxB.1.symm
    have hAB0 : haarK F (A ∩ B) = 0 := measure_mono_null hAB hnull
    have hsum : haarK F A + haarK F B ≤ haarK F C := by
      rw [← measure_union_add_inter A hBm, hAB0, add_zero]
      exact measure_mono (Set.union_subset hAC hBC)
    have hB' : haarK F B = haarK F ({y | φ (z + e θ, y) = j} ∩ C') := hpre _
    have hzB : 3 / 4 * haarK F C < haarK F B := by
      rw [hB', hCC']
      exact hz'
    exact false_of_three_quarters (measure_ne_top (haarK F) C) hz hzB hsum
  exact measure_mono_null hsub (ae_iff.1 hae)

/-- **The descent's measure comparison**: colour `j` in the window `squareWin a s × K` is the level rows plus the badly filled
points. -/
theorem volume_colour_le {φ : ℂ × K F → Fin 4} (hφ : Measurable φ) (j : Fin 4) (k : ℕ) (a : ℂ) (s : ℝ) :
    (volume.prod (haarK F)).real ({p | φ p = j} ∩ squareWin a s ×ˢ Set.univ) ≤
      (Nat.card (levR F k).range.toAddSubgroup : ℝ)⁻¹ * ∑ q, volume.real (levelRows φ j k q ∩ squareWin a s) +
        (volume.prod (haarK F)).real {p | p.1 ∈ squareWin a s ∧ φ p = j ∧
          haarK F ({x | φ (p.1, x) = j} ∩ proj F k ⁻¹' {proj F k p.2}) ≤
            3 / 4 * haarK F (proj F k ⁻¹' {proj F k p.2})} := by
  -- Route: each point of colour `j` in the window lies over its coset `q = proj x`: either the coset is filled above three
  -- quarters at `z` (then `z` is in the row `q`), or the point is bad; each row times its coset has measure `|row| / n`.
  -- The bound is one of outer measure: the measurability of `φ` is not read (`hφ` is kept as stated).
  have _ := hφ
  classical
  set W := squareWin a s with hWdef
  set n := Nat.card (levR F k).range.toAddSubgroup with hn
  set Bad : Set (ℂ × K F) := {p | p.1 ∈ W ∧ φ p = j ∧
    haarK F ({x | φ (p.1, x) = j} ∩ proj F k ⁻¹' {proj F k p.2}) ≤ 3 / 4 * haarK F (proj F k ⁻¹' {proj F k p.2})}
    with hBad
  have hW : volume W ≠ ⊤ := volume_squareWin_ne_top a s
  have hcard : Nat.card (Set.range (proj F k)) = n := by
    rw [range_proj F k]
    exact Nat.card_congr (Equiv.subtypeEquivRight fun x => Set.mem_range.trans RingHom.mem_range.symm)
  have hcosets : ∀ q : (levR F k).range.toAddSubgroup, haarK F (proj F k ⁻¹' {(q : Lev F k)}) = (n : ENNReal)⁻¹ := by
    intro q
    rw [haarK_proj_preimage F k (by rw [range_proj F k]; exact RingHom.mem_range.1 q.2), hcard]
  have hcover : {p | φ p = j} ∩ W ×ˢ Set.univ ⊆
      (⋃ q : (levR F k).range.toAddSubgroup, (levelRows φ j k q ∩ W) ×ˢ (proj F k ⁻¹' {(q : Lev F k)})) ∪ Bad := by
    rintro ⟨z, x⟩ ⟨hj, hzW, -⟩
    have hx : proj F k x ∈ Set.range (levR F k) := by
      rw [← range_proj F k]
      exact ⟨x, rfl⟩
    by_cases hfill : 3 / 4 * haarK F (proj F k ⁻¹' {proj F k x}) <
        haarK F ({x' | φ (z, x') = j} ∩ proj F k ⁻¹' {proj F k x})
    · left
      refine Set.mem_iUnion.2 ⟨⟨proj F k x, RingHom.mem_range.2 hx⟩, ⟨hfill, hzW⟩, ?_⟩
      show proj F k x ∈ ({proj F k x} : Set (Lev F k))
      exact Set.mem_singleton _
    · right
      exact ⟨hzW, hj, not_lt.1 hfill⟩
  have hfin : ∀ q, volume (levelRows φ j k q ∩ W) ≠ ⊤ := fun q =>
    ne_top_of_le_ne_top hW (measure_mono Set.inter_subset_right)
  have hBad : ((volume : Measure ℂ).prod (haarK F)) Bad ≠ ⊤ := by
    refine ne_top_of_le_ne_top ?_ (measure_mono (t := W ×ˢ Set.univ) fun p hp => ⟨hp.1, trivial⟩)
    rw [Measure.prod_prod, measure_univ, mul_one]
    exact hW
  have hn0 : (n : ENNReal)⁻¹ ≠ ⊤ := ENNReal.inv_ne_top.2 (by exact_mod_cast (Nat.card_pos).ne')
  have hterm : ∀ q ∈ (Finset.univ : Finset (levR F k).range.toAddSubgroup),
      volume (levelRows φ j k q ∩ W) * (n : ENNReal)⁻¹ ≠ ⊤ := fun q _ => ENNReal.mul_ne_top (hfin q) hn0
  have hle : ((volume : Measure ℂ).prod (haarK F)) ({p | φ p = j} ∩ W ×ˢ Set.univ) ≤
      ∑ q, volume (levelRows φ j k q ∩ W) * (n : ENNReal)⁻¹ + ((volume : Measure ℂ).prod (haarK F)) Bad := by
    calc _ ≤ ((volume : Measure ℂ).prod (haarK F))
          ((⋃ q : (levR F k).range.toAddSubgroup, (levelRows φ j k q ∩ W) ×ˢ (proj F k ⁻¹' {(q : Lev F k)})) ∪ Bad) :=
          measure_mono hcover
      _ ≤ ((volume : Measure ℂ).prod (haarK F))
            (⋃ q : (levR F k).range.toAddSubgroup, (levelRows φ j k q ∩ W) ×ˢ (proj F k ⁻¹' {(q : Lev F k)})) +
          ((volume : Measure ℂ).prod (haarK F)) Bad := measure_union_le _ _
      _ ≤ ∑ q : (levR F k).range.toAddSubgroup, ((volume : Measure ℂ).prod (haarK F))
            ((levelRows φ j k q ∩ W) ×ˢ (proj F k ⁻¹' {(q : Lev F k)})) +
          ((volume : Measure ℂ).prod (haarK F)) Bad := by
        gcongr
        exact measure_iUnion_fintype_le _ _
      _ = _ := by
        congr 1
        refine Finset.sum_congr rfl fun q _ => ?_
        rw [Measure.prod_prod, hcosets]
  rw [measureReal_def, measureReal_def]
  calc (((volume : Measure ℂ).prod (haarK F)) ({p | φ p = j} ∩ W ×ˢ Set.univ)).toReal
      ≤ (∑ q, volume (levelRows φ j k q ∩ W) * (n : ENNReal)⁻¹ + ((volume : Measure ℂ).prod (haarK F)) Bad).toReal :=
        ENNReal.toReal_mono (ENNReal.add_ne_top.2 ⟨ENNReal.sum_ne_top.2 hterm, hBad⟩) hle
    _ = _ := by
      rw [ENNReal.toReal_add (ENNReal.sum_ne_top.2 hterm) hBad, ENNReal.toReal_sum hterm, Finset.mul_sum]
      congr 1
      refine Finset.sum_congr rfl fun q _ => ?_
      rw [ENNReal.toReal_mul, ENNReal.toReal_inv, ENNReal.toReal_natCast, measureReal_def, mul_comm]

/-- The badly filled points of a window tend to `0` with the level. -/
theorem tendsto_bad {φ : ℂ × K F → Fin 4} (hφ : Measurable φ) (j : Fin 4) (a : ℂ) (s : ℝ) :
    Tendsto (fun k => (volume.prod (haarK F)).real {p | p.1 ∈ squareWin a s ∧ φ p = j ∧
        haarK F ({x | φ (p.1, x) = j} ∩ proj F k ⁻¹' {proj F k p.2}) ≤
          3 / 4 * haarK F (proj F k ⁻¹' {proj F k p.2})}) atTop (𝓝 0) := by
  -- Route: Tonelli turns each bad set into the window integral of its fibres; each fibre is the badly filled part of a
  -- measurable subset of `K` at level `k` (`tendsto_haarK_bad` at `κ = 1/4`); dominated convergence, bound `1` on the window.
  classical
  set W := squareWin a s with hWdef
  set Bad : ℕ → Set (ℂ × K F) := fun k => {p | p.1 ∈ W ∧ φ p = j ∧
    haarK F ({x | φ (p.1, x) = j} ∩ proj F k ⁻¹' {proj F k p.2}) ≤ 3 / 4 * haarK F (proj F k ⁻¹' {proj F k p.2})}
    with hBad
  have hW : volume W ≠ ⊤ := volume_squareWin_ne_top a s
  have hWm : MeasurableSet W := measurableSet_squareWin a s
  have hY : ∀ z, MeasurableSet {x : K F | φ (z, x) = j} := fun z =>
    hφ.comp measurable_prodMk_left (measurableSet_singleton j)
  have h34 : (1 : ENNReal) - 1 / 4 = 3 / 4 := by
    refine ENNReal.sub_eq_of_eq_add (ENNReal.div_ne_top (by norm_num) (by norm_num)) ?_
    rw [ENNReal.div_add_div_same]
    norm_num
    exact (ENNReal.div_self (by norm_num) (by norm_num)).symm
  -- each bad set is measurable: a finite union over the level-`k` residues
  have hmeas : ∀ k, MeasurableSet (Bad k) := by
    intro k
    have e : Bad k = ⋃ d : Lev F k, (W ×ˢ Set.univ) ∩ {p | φ p = j} ∩ (Set.univ ×ˢ (proj F k ⁻¹' {d})) ∩
        (Prod.fst ⁻¹' {z | haarK F ({x | φ (z, x) = j} ∩ proj F k ⁻¹' {d}) ≤ 3 / 4 * haarK F (proj F k ⁻¹' {d})}) := by
      ext ⟨z, x⟩
      simp only [hBad, Set.mem_setOf_eq, Set.mem_iUnion, Set.mem_inter_iff, Set.mem_prod, Set.mem_univ, and_true,
        true_and, Set.mem_preimage, Set.mem_singleton_iff]
      constructor
      · rintro ⟨hz, hj, hb⟩
        exact ⟨proj F k x, ⟨⟨hz, hj⟩, rfl⟩, hb⟩
      · rintro ⟨d, ⟨⟨hz, hj⟩, hd⟩, hb⟩
        subst hd
        exact ⟨hz, hj, hb⟩
    rw [e]
    refine MeasurableSet.iUnion fun d => ?_
    refine (((hWm.prod MeasurableSet.univ).inter (hφ (measurableSet_singleton j))).inter
      (MeasurableSet.univ.prod (measurableSet_proj_preimage k d))).inter ?_
    exact measurable_fst (measurableSet_le (measurable_haarK_fibre hφ j (measurableSet_proj_preimage k d))
      measurable_const)
  -- the fibres
  have hsec : ∀ k z, Prod.mk z ⁻¹' Bad k = if z ∈ W then {x | x ∈ {x' : K F | φ (z, x') = j} ∧
      haarK F ({x' : K F | φ (z, x') = j} ∩ proj F k ⁻¹' {proj F k x}) ≤
        (1 - 1 / 4) * haarK F (proj F k ⁻¹' {proj F k x})} else ∅ := by
    intro k z
    by_cases hz : z ∈ W
    · rw [if_pos hz, h34]
      ext x
      simp [hBad, hz]
    · rw [if_neg hz]
      ext x
      simp [hBad, hz]
  set G : ℕ → ℂ → ENNReal := fun k z => haarK F (Prod.mk z ⁻¹' Bad k) with hG
  have hGm : ∀ k, Measurable (G k) := fun k => measurable_measure_prodMk_left (hmeas k)
  have hGb : ∀ k, G k ≤ᵐ[volume] W.indicator fun _ => 1 := by
    intro k
    refine Filter.Eventually.of_forall fun z => ?_
    by_cases hz : z ∈ W
    · rw [Set.indicator_of_mem hz]
      exact prob_le_one
    · simp only [hG, hsec k z, if_neg hz, measure_empty, Set.indicator_of_notMem hz, le_refl]
  have hGl : ∀ᵐ z ∂volume, Tendsto (fun k => G k z) atTop (𝓝 0) := by
    refine Filter.Eventually.of_forall fun z => ?_
    by_cases hz : z ∈ W
    · simp only [hG, hsec _ z, if_pos hz]
      exact tendsto_haarK_bad F (hY z) (by norm_num)
    · simp only [hG, hsec _ z, if_neg hz, measure_empty]
      exact tendsto_const_nhds
  have hlim := tendsto_lintegral_of_dominated_convergence (μ := volume) (f := fun _ => 0) _ hGm hGb
    (by rw [lintegral_indicator_const hWm]; exact ENNReal.mul_ne_top ENNReal.one_ne_top hW) hGl
  rw [lintegral_zero] at hlim
  have hprod : ∀ k, ((volume : Measure ℂ).prod (haarK F)) (Bad k) = ∫⁻ z, G k z := fun k =>
    Measure.prod_apply (hmeas k)
  show Tendsto (fun k => ((volume : Measure ℂ).prod (haarK F)).real (Bad k)) atTop (𝓝 0)
  simp_rw [measureReal_def, hprod]
  rw [← ENNReal.toReal_zero]
  exact (ENNReal.tendsto_toReal ENNReal.zero_ne_top).comp hlim

/-- **The contradiction**: no measurable four-colouring of the slice has null monochromatic edges, under `TCA F` and
`m₁ < 1/4`. -/
theorem false_of_slice (hT : TCA F) (hm : mOne < ENNReal.ofReal (1 / 4)) {φ : ℂ × K F → Fin 4} (hφ : Measurable φ)
    (h : SliceEdgeNull φ) : False := by
  -- Route: `c < 1/4` from `tca_uniform`, `ε` with `4 (max (m₁, c) + 2ε) < 1`, the window scale `s₀` of `exists_nrWindow`;
  -- at a level `k ≥ 1` where every colour's bad points cost at most `ε s₀²`, each colour holds at most
  -- `(max (m₁, c) + 2ε) s₀²` of `squareWin 0 s₀ × K` (`volume_colour_le`, `sum_volume_inter_sq_le`), and four colours fill it.
  classical
  obtain ⟨c₀, hc₀, hc₀P⟩ := tca_uniform F hT
  set c := max c₀ 0 with hcdef
  have hc0 : 0 ≤ c := le_max_right _ _
  have hc14 : c < 1 / 4 := max_lt hc₀ (by norm_num)
  have hcP : ∀ P : StablePrime F, RatioAtMost P c := by
    intro P m hm s hs
    refine le_trans (hc₀P P m hm s hs) ?_
    exact mul_le_mul_of_nonneg_right (le_max_left _ _) (Nat.cast_nonneg _)
  have hm1 : mOne.toReal < 1 / 4 := ENNReal.toReal_lt_of_lt_ofReal hm
  set M := max mOne.toReal c with hMdef
  have hM : M < 1 / 4 := max_lt hm1 hc14
  set ε := (1 - 4 * M) / 16 with hεdef
  have hε : 0 < ε := by rw [hεdef]; linarith
  obtain ⟨s₀, hs₀, hN⟩ := Plane.exists_nrWindow hε
  set W := squareWin 0 s₀ with hWdef
  set μ := (volume : Measure ℂ).prod (haarK F) with hμ
  set bad : Fin 4 → ℕ → ℝ := fun j k => μ.real {p | p.1 ∈ W ∧ φ p = j ∧
    haarK F ({x | φ (p.1, x) = j} ∩ proj F k ⁻¹' {proj F k p.2}) ≤ 3 / 4 * haarK F (proj F k ⁻¹' {proj F k p.2})}
    with hbad
  have hev : ∀ᶠ k in atTop, 1 ≤ k ∧ ∀ j, bad j k < ε * s₀ ^ 2 := by
    refine (eventually_ge_atTop 1).and (eventually_all.2 fun j => ?_)
    exact (tendsto_bad hφ j 0 s₀).eventually (gt_mem_nhds (by positivity))
  obtain ⟨k, hk, hkbad⟩ := hev.exists
  -- one colour, at level `k`
  have hcol : ∀ j : Fin 4, μ.real ({p | φ p = j} ∩ W ×ˢ Set.univ) ≤ (M + 2 * ε) * s₀ ^ 2 := by
    intro j
    have h1 := volume_colour_le hφ j k 0 s₀
    have hS : ∀ s ∈ {d : (levR F k).range.toAddSubgroup | (d : Lev F k) ∈ normOneLev F k},
        -s ∈ {d : (levR F k).range.toAddSubgroup | (d : Lev F k) ∈ normOneLev F k} :=
      fun s hs P => neg_mem_normOneQ P.1 k (hs P)
    have h2 := sum_volume_inter_sq_le hS (ratioLe_levR_range F hT hc0 hcP hk) hc0
      (measurableSet_levelRows hφ j k) (rowsEdgeNull_levelRows hT hφ h j k) hN 0 (le_refl s₀)
    have hn : (0 : ℝ) < Nat.card (levR F k).range.toAddSubgroup := by exact_mod_cast Nat.card_pos
    have h3 : (Nat.card (levR F k).range.toAddSubgroup : ℝ)⁻¹ *
        ∑ q, volume.real (levelRows φ j k q ∩ squareWin 0 s₀) ≤ (M + ε) * s₀ ^ 2 := by
      rw [inv_mul_le_iff₀ hn]
      calc _ ≤ (M + ε) * (Nat.card (levR F k).range.toAddSubgroup : ℝ) * s₀ ^ 2 := h2
        _ = _ := by ring
    have h4 := hkbad j
    simp only [hbad] at h4
    linarith
  -- four colours fill the window
  have hdisj : (↑(Finset.univ : Finset (Fin 4)) : Set (Fin 4)).PairwiseDisjoint
      fun j => {p : ℂ × K F | φ p = j} ∩ W ×ˢ Set.univ :=
    fun i _ i' _ hii' => Set.disjoint_left.2 fun p hi hi' => hii' (hi.1.symm.trans hi'.1)
  have hmeasj : ∀ j ∈ (Finset.univ : Finset (Fin 4)), MeasurableSet ({p : ℂ × K F | φ p = j} ∩ W ×ˢ Set.univ) :=
    fun j _ => (hφ (measurableSet_singleton j)).inter ((measurableSet_squareWin 0 s₀).prod MeasurableSet.univ)
  have hunion : (⋃ j ∈ (Finset.univ : Finset (Fin 4)), {p : ℂ × K F | φ p = j} ∩ W ×ˢ Set.univ) = W ×ˢ Set.univ := by
    ext p
    simp
  have hWμ : μ (W ×ˢ Set.univ) = ENNReal.ofReal (s₀ ^ 2) := by
    rw [hμ, Measure.prod_prod, measure_univ, mul_one, hWdef, volume_squareWin 0 hs₀.le]
  have htot : ∑ j : Fin 4, μ.real ({p | φ p = j} ∩ W ×ˢ Set.univ) = s₀ ^ 2 := by
    have hfin : ∀ j ∈ (Finset.univ : Finset (Fin 4)), μ ({p : ℂ × K F | φ p = j} ∩ W ×ˢ Set.univ) ≠ ⊤ := fun j _ =>
      ne_top_of_le_ne_top (by rw [hWμ]; exact ENNReal.ofReal_ne_top) (measure_mono Set.inter_subset_right)
    simp_rw [measureReal_def]
    rw [← ENNReal.toReal_sum hfin, ← measure_biUnion_finset hdisj hmeasj, hunion, hWμ,
      ENNReal.toReal_ofReal (sq_nonneg s₀)]
  have hsum : ∑ j : Fin 4, μ.real ({p | φ p = j} ∩ W ×ˢ Set.univ) ≤ ∑ _j : Fin 4, (M + 2 * ε) * s₀ ^ 2 :=
    Finset.sum_le_sum fun j _ => hcol j
  rw [htot, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, Nat.cast_ofNat] at hsum
  have hs2 : 0 < s₀ ^ 2 := by positivity
  have h4 : 4 * (M + 2 * ε) < 1 := by rw [hεdef]; linarith
  have h5 := mul_lt_mul_of_pos_right h4 hs2
  linarith

/-- **The count** (R88-TCA at `S = ∅`, class form), over the outside theorem `[AmbrusEtAl2023]` Thm 1. -/
theorem count_of_oneAvoidingDensityBound (hOA : Plane.OneAvoidingDensityBound) : (chainInterface F).Count := by
  intro hT μ σ hσ hTA
  obtain ⟨φ, hφ, hnull⟩ := exists_slice μ hσ hTA
  exact false_of_slice hT (Plane.mOne_lt_quarter hOA) hφ hnull

end

end HadwigerNelson.Rigidity.Counting
