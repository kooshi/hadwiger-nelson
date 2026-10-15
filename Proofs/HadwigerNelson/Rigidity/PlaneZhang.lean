import Proofs.HadwigerNelson.Plane.WindowDensity
import Proofs.HadwigerNelson.Rigidity.FiniteZhang

/-!
# Zhang's count on the plane times a finite Cayley graph, in a window (FS-131, job FS131-K12A; module M12, block C)

**Read aloud, against the derivation** (J28D § 3.2 C5: "social and lonely points, essential neighbourhoods,
`p_j ≤ ¼(1 − β_j) + r_X β_j`"; R88-TC-count; `[Zhang2012]` Thm 1.8's counting). A finite additive group `Q` with a symmetric
connection set `S` of ratio at most `r`, and a measurable set of `ℂ × Q` given by its rows `Y q ⊆ ℂ`, whose edges are null:
for every `q` and `s ∈ S`, the pairs `(z, θ)` with `z ∈ Y q` and `z + e^{iθ} ∈ Y (q + s)` form a null set — the edge set of
`UD(ℝ²) ⊗ Cay(Q, S)` met in measure zero. Then in every large square window the rows hold at most the fraction
`max(m₁, r)` of `|Q|·s²`, up to `ε`:

* `lonely Y b` — the points of row `b` whose unit circle meets row `b` in length zero (J28D's `X^{j*}_b`); it has null unit
  pairs (`unitPairsNull_lonely`).
* `social Y z` — the rows `q` with `z ∈ Y q` and positive length of row `q` on the unit circle about `z` (`A^j_x`); for
  almost every `z` it is independent in `Cay(Q, S)` (`ae_sIndep_social`, J28D (i)).
* `touched Y z` — the rows `b` with `z` in the essential neighbourhood of `lonely Y b` (`B^j(x)`); for almost every `z` it
  misses `N[social Y z]` (`ae_disjoint_touched`, J28D (ii′)).
* `sum_volume_inter_sq_le` — **the count**: `|social| ≤ r (|Q| − |touched|)` (finite neighbourhood ratio,
  `card_le_mul_card_closedNbhd`) and `Σ_b |lonely ∩ Q| ≤ m₁ ∫_Q |touched| + ε |Q| s²` (`Plane.NRWindow`, whose scale is
  uniform in the set: `Plane.exists_nrWindow`).

**Models.** Every row empty; or `Q` a single point with `S = ∅` and one row the disc of radius `1/3`.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory Set Plane

noncomputable section

variable {Q : Type*} [AddCommGroup Q] [Fintype Q] [DecidableEq Q]

/-- The lonely points of row `b`: in `Y b`, with unit circle meeting `Y b` in length zero. -/
def lonely (Y : Q → Set ℂ) (b : Q) : Set ℂ := {z | z ∈ Y b ∧ phi (Y b) z = 0}

/-- The rows in which `z` is social. -/
def social (Y : Q → Set ℂ) (z : ℂ) : Finset Q := by
  classical exact Finset.univ.filter fun q => z ∈ Y q ∧ phi (Y q) z ≠ 0

/-- The rows `b` with `z` in the essential neighbourhood of `lonely Y b`. -/
def touched (Y : Q → Set ℂ) (z : ℂ) : Finset Q := by
  classical exact Finset.univ.filter fun b => z ∈ essNbhd (lonely Y b)

/-- The edges of `UD(ℝ²) ⊗ Cay(Q, S)` inside the rows are null. -/
def RowsEdgeNull (S : Set Q) (Y : Q → Set ℂ) : Prop :=
  ∀ q, ∀ s ∈ S, (volume.prod arcLength) (pairSet (Y q) (Y (q + s))) = 0

-- FS131-ICL1: the proofs. Every null set is a finite union of sets `{z ∈ Y x : phi (Y y) z ≠ 0}`, `y − x ∈ S` (an edge
-- slice, `null_edge`), or `{z ∈ Y b : phi (lonely Y b) z ≠ 0}` (the lonely slice swapped, `null_lonely_swap`).

omit [AddCommGroup Q] [Fintype Q] [DecidableEq Q] in
theorem measurableSet_lonely {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q)) (b : Q) : MeasurableSet (lonely Y b) :=
  (hY b).inter ((measurable_phi (hY b)) (measurableSet_singleton 0))

omit [AddCommGroup Q] [Fintype Q] [DecidableEq Q] in
/-- The pairs from the lonely points of a row into the row are null: a lonely point sees its row in length zero. -/
private theorem pairSet_lonely_null {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q)) (b : Q) :
    (volume.prod arcLength) (pairSet (lonely Y b) (Y b)) = 0 := by
  rw [pairSet_measure_eq_lintegral (measurableSet_lonely hY b) (hY b)]
  refine (setLIntegral_congr_fun (measurableSet_lonely hY b) (fun p hp => ?_)).trans lintegral_zero
  exact hp.2

omit [AddCommGroup Q] [Fintype Q] [DecidableEq Q] in
theorem unitPairsNull_lonely {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q)) (b : Q) : UnitPairsNull (lonely Y b) :=
  measure_mono_null (show unitPairSet (lonely Y b) ⊆ pairSet (lonely Y b) (Y b) from fun _ hq => ⟨hq.1, hq.2.1⟩)
    (pairSet_lonely_null hY b)

/-- Null pairs from `A` into `B` are null pairs from `B` into `A` (the slices at `θ` and `θ + π`, swapped). -/
private theorem pairSet_null_swap {A B : Set ℂ} (hA : MeasurableSet A) (hB : MeasurableSet B)
    (h : (volume.prod arcLength) (pairSet A B) = 0) : (volume.prod arcLength) (pairSet B A) = 0 := by
  rw [pairSet_null_iff_ae_slice hB hA]
  have h1 := (pairSet_null_iff_ae_slice hA hB).mp h
  have h2 := ae_arcLength_shift_pi (fun θ => volume {x : ℂ | x ∈ A ∧ x + e θ ∈ B})
    (fun θ => by simp [e_add_two_pi]) h1
  filter_upwards [h2] with θ hθ
  rw [volume_slice_swap]
  exact hθ

/-- Null pairs from `A` into `B`: almost no point of `A` sees `B` in positive length. -/
private theorem null_of_pairSet_null {A B : Set ℂ} (hA : MeasurableSet A) (hB : MeasurableSet B)
    (h : (volume.prod arcLength) (pairSet A B) = 0) : volume {z | z ∈ A ∧ phi B z ≠ 0} = 0 := by
  rw [pairSet_measure_eq_lintegral hA hB] at h
  have h' : (fun p => phi B p) =ᵐ[volume.restrict A] 0 := (lintegral_eq_zero_iff (measurable_phi hB)).mp h
  rw [Filter.EventuallyEq, ae_restrict_iff' hA] at h'
  rw [measure_eq_zero_iff_ae_notMem]
  filter_upwards [h'] with z hz hzA
  exact hzA.2 (hz hzA.1)

omit [Fintype Q] [DecidableEq Q] in
/-- **An edge slice is null**: almost no point of row `x` sees row `y` in positive length when `y − x ∈ S`. -/
private theorem null_edge {S : Set Q} {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q)) (h : RowsEdgeNull S Y)
    {x y : Q} (hxy : y - x ∈ S) : volume {z | z ∈ Y x ∧ phi (Y y) z ≠ 0} = 0 := by
  have h1 := h x (y - x) hxy
  have e : x + (y - x) = y := by abel
  rw [e] at h1
  exact null_of_pairSet_null (hY x) (hY y) h1

omit [AddCommGroup Q] [Fintype Q] [DecidableEq Q] in
/-- **The lonely slice, swapped**: almost no point of row `b` sees the lonely points of row `b` in positive length. -/
private theorem null_lonely_swap {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q)) (b : Q) :
    volume {z | z ∈ Y b ∧ phi (lonely Y b) z ≠ 0} = 0 :=
  null_of_pairSet_null (hY b) (measurableSet_lonely hY b)
    (pairSet_null_swap (measurableSet_lonely hY b) (hY b) (pairSet_lonely_null hY b))

omit [AddCommGroup Q] [DecidableEq Q] in
private theorem mem_social {Y : Q → Set ℂ} {z : ℂ} {q : Q} : q ∈ social Y z ↔ z ∈ Y q ∧ phi (Y q) z ≠ 0 := by
  unfold social; simp

omit [AddCommGroup Q] [DecidableEq Q] in
private theorem mem_touched {Y : Q → Set ℂ} {z : ℂ} {b : Q} : b ∈ touched Y z ↔ z ∈ essNbhd (lonely Y b) := by
  unfold touched; simp

omit [DecidableEq Q] in
/-- J28D (i): for almost every `z`, the rows in which `z` is social are independent. -/
theorem ae_sIndep_social {S : Set Q} (hS : ∀ s ∈ S, -s ∈ S) {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q))
    (h : RowsEdgeNull S Y) : ∀ᵐ z ∂volume, SIndep S (social Y z) := by
  have hnull : volume (⋃ x : Q, ⋃ y : Q, ⋃ (_ : y - x ∈ S), {z | z ∈ Y y ∧ phi (Y x) z ≠ 0}) = 0 := by
    refine measure_iUnion_null fun x => measure_iUnion_null fun y => measure_iUnion_null fun hxy => ?_
    exact null_edge hY h (by simpa [neg_sub] using hS _ hxy)
  rw [measure_eq_zero_iff_ae_notMem] at hnull
  filter_upwards [hnull] with z hz
  intro x hx y hy hxy
  apply hz
  simp only [mem_iUnion, mem_setOf_eq]
  exact ⟨x, y, hxy, (mem_social.1 hy).1, (mem_social.1 hx).2⟩

omit [DecidableEq Q] in
/-- J28D (ii′): for almost every `z`, no touched row lies in the closed neighbourhood of the social rows. -/
theorem ae_disjoint_touched {S : Set Q} (hS : ∀ s ∈ S, -s ∈ S) {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q))
    (h : RowsEdgeNull S Y) : ∀ᵐ z ∂volume, Disjoint (closedNbhd S (social Y z)) (touched Y z) := by
  have h1 : volume (⋃ b : Q, {z | z ∈ Y b ∧ phi (lonely Y b) z ≠ 0}) = 0 :=
    measure_iUnion_null fun b => null_lonely_swap hY b
  have h2 : volume (⋃ a : Q, ⋃ b : Q, ⋃ (_ : b - a ∈ S), {z | z ∈ Y b ∧ phi (Y a) z ≠ 0}) = 0 := by
    refine measure_iUnion_null fun a => measure_iUnion_null fun b => measure_iUnion_null fun hab => ?_
    exact null_edge hY h (by simpa [neg_sub] using hS _ hab)
  have h3 : volume (⋃ a : Q, ⋃ b : Q, ⋃ (_ : b - a ∈ S), {z | z ∈ Y a ∧ phi (Y b) z ≠ 0}) = 0 := by
    refine measure_iUnion_null fun a => measure_iUnion_null fun b => measure_iUnion_null fun hab => ?_
    exact null_edge hY h hab
  rw [measure_eq_zero_iff_ae_notMem] at h1 h2 h3
  filter_upwards [h1, h2, h3] with z hz1 hz2 hz3
  simp only [mem_iUnion, mem_setOf_eq, not_exists, not_and] at hz1 hz2 hz3
  rw [Finset.disjoint_left]
  intro b hbN hbT
  rw [mem_touched, essNbhd, mem_union, mem_setOf_eq] at hbT
  rw [closedNbhd, Set.Finite.mem_toFinset, mem_setOf_eq] at hbN
  rcases hbN with hb | ⟨a, ha, hab⟩
  · obtain ⟨hzb, hphi⟩ := mem_social.1 hb
    rcases hbT with hl | hl
    · exact hphi hl.2
    · exact hz1 b hzb hl
  · obtain ⟨hza, hphi⟩ := mem_social.1 ha
    rcases hbT with hl | hl
    · exact hz2 a b hab hl.1 hphi
    · refine hz3 a b hab hza fun h0 => hl ?_
      refine le_antisymm (le_trans (measure_mono fun θ hθ => ?_) h0.le) zero_le
      exact hθ.1

/-- A window of side `s` has area at most `s²` (none at all when `s < 0`). -/
private theorem volume_squareWin_le (a : ℂ) (s : ℝ) : volume (squareWin a s) ≤ ENNReal.ofReal (s ^ 2) := by
  by_cases hs : 0 ≤ s
  · rw [volume_squareWin a hs]
  · have : squareWin a s = ∅ := by
      ext w
      simp only [squareWin, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
      intro h1 h2
      linarith
    rw [this, measure_empty]
    exact zero_le

omit [AddCommGroup Q] [DecidableEq Q] in
/-- Summing the indicators of a family of sets at a point counts the members holding it. -/
private theorem sum_indicator_eq_card (A : Q → Set ℂ) (z : ℂ) (T : Finset Q) (hT : ∀ q, q ∈ T ↔ z ∈ A q) :
    ∑ q, (A q).indicator (1 : ℂ → ℝ) z = (T.card : ℝ) := by
  classical
  simp only [Set.indicator_apply, Pi.one_apply]
  rw [Finset.sum_boole]
  norm_cast
  congr 1
  ext q
  simp [hT q]

/-- **Zhang's count on `UD(ℝ²) ⊗ Cay(Q, S)`, in a window**, at the scale `s₀` of the plane's neighbourhood ratio — so
uniform in `Q`, `S` and the rows. -/
theorem sum_volume_inter_sq_le {S : Set Q} (hS : ∀ s ∈ S, -s ∈ S) {r : ℝ} (hr : RatioLe S r) (hr0 : 0 ≤ r)
    {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q)) (h : RowsEdgeNull S Y) {ε s₀ : ℝ} (hN : NRWindow ε s₀) (a : ℂ)
    {s : ℝ} (hs : s₀ ≤ s) : ∑ q, volume.real (Y q ∩ squareWin a s) ≤ (max mOne.toReal r + ε) * Nat.card Q * s ^ 2 := by
  classical
  set W := squareWin a s with hW
  set m := mOne.toReal with hm
  have hWm : MeasurableSet W := measurableSet_squareWin a s
  have hWfin : volume W ≠ ⊤ := ne_top_of_le_ne_top ENNReal.ofReal_ne_top (volume_squareWin_le a s)
  have hWs : volume.real W ≤ s ^ 2 := by
    rw [measureReal_def]
    exact ENNReal.toReal_le_of_le_ofReal (sq_nonneg s) (volume_squareWin_le a s)
  set soc : Q → Set ℂ := fun q => {z | z ∈ Y q ∧ phi (Y q) z ≠ 0} with hsoc
  set N : Q → Set ℂ := fun q => essNbhd (lonely Y q) with hNdef
  have hsocm : ∀ q, MeasurableSet (soc q) := fun q =>
    (hY q).inter ((measurable_phi (hY q)) (measurableSet_singleton 0)).compl
  have hNm : ∀ q, MeasurableSet (N q) := fun q => measurableSet_essNbhd (measurableSet_lonely hY q)
  -- each row: its social part, and its lonely part bounded by the plane's neighbourhood ratio
  have hrow : ∀ q, volume.real (Y q ∩ W) ≤ volume.real (soc q ∩ W) + (m * volume.real (N q ∩ W) + ε * s ^ 2) := by
    intro q
    have hsplit : Y q ∩ W = (soc q ∩ W) ∪ (lonely Y q ∩ W) := by
      ext z
      simp only [hsoc, lonely, mem_inter_iff, mem_union, mem_setOf_eq]
      tauto
    have hdisj : Disjoint (soc q ∩ W) (lonely Y q ∩ W) := by
      rw [Set.disjoint_left]
      rintro z ⟨⟨-, h1⟩, -⟩ ⟨⟨-, h2⟩, -⟩
      exact h1 h2
    have hl := hN (lonely Y q) (measurableSet_lonely hY q) (unitPairsNull_lonely hY q) a s hs
    rw [hsplit, measureReal_union hdisj ((measurableSet_lonely hY q).inter hWm)
      (ne_top_of_le_ne_top hWfin (measure_mono inter_subset_right))
      (ne_top_of_le_ne_top hWfin (measure_mono inter_subset_right))]
    linarith
  have hsum : ∑ q, volume.real (Y q ∩ W) ≤
      (∑ q, volume.real (soc q ∩ W) + m * ∑ q, volume.real (N q ∩ W)) + Fintype.card Q * (ε * s ^ 2) := by
    refine (Finset.sum_le_sum fun q _ => hrow q).trans (le_of_eq ?_)
    rw [Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ, nsmul_eq_mul,
      Finset.mul_sum]
    ring
  -- the social and touched rows, integrated over the window
  haveI : IsFiniteMeasure (volume.restrict W) := isFiniteMeasure_restrict.mpr hWfin
  have hind : ∀ A : Set ℂ, MeasurableSet A → Integrable (A.indicator (1 : ℂ → ℝ)) (volume.restrict W) :=
    fun A hA => (integrable_const (1 : ℝ)).indicator hA
  set f : ℂ → ℝ := fun z => ∑ q, (soc q).indicator 1 z + m * ∑ q, (N q).indicator 1 z with hf
  have hfi1 : Integrable (fun z => ∑ q, (soc q).indicator (1 : ℂ → ℝ) z) (volume.restrict W) :=
    integrable_finsetSum _ fun q _ => hind _ (hsocm q)
  have hfi2 : Integrable (fun z => ∑ q, (N q).indicator (1 : ℂ → ℝ) z) (volume.restrict W) :=
    integrable_finsetSum _ fun q _ => hind _ (hNm q)
  have hfi : Integrable f (volume.restrict W) := hfi1.add (hfi2.const_mul m)
  have hcalc : ∫ z in W, f z = ∑ q, volume.real (soc q ∩ W) + m * ∑ q, volume.real (N q ∩ W) := by
    rw [hf, integral_add hfi1 (hfi2.const_mul m), integral_const_mul, integral_finsetSum _ fun q _ => hind _ (hsocm q),
      integral_finsetSum _ fun q _ => hind _ (hNm q)]
    congr 1
    · exact Finset.sum_congr rfl fun q _ => by rw [integral_indicator_one (hsocm q), measureReal_restrict_apply (hsocm q)]
    · congr 1
      exact Finset.sum_congr rfl fun q _ => by rw [integral_indicator_one (hNm q), measureReal_restrict_apply (hNm q)]
  have hle : f ≤ᵐ[volume.restrict W] fun _ => max m r * Fintype.card Q := by
    refine ae_restrict_of_ae ?_
    filter_upwards [ae_sIndep_social hS hY h, ae_disjoint_touched hS hY h] with z h1 h2
    have hc1 : ∑ q, (soc q).indicator (1 : ℂ → ℝ) z = ((social Y z).card : ℝ) :=
      sum_indicator_eq_card soc z _ fun q => mem_social
    have hc2 : ∑ q, (N q).indicator (1 : ℂ → ℝ) z = ((touched Y z).card : ℝ) :=
      sum_indicator_eq_card N z _ fun q => mem_touched
    have hk := card_le_mul_card_closedNbhd hS hr h1
    have hu : (closedNbhd S (social Y z)).card + (touched Y z).card ≤ Fintype.card Q := by
      rw [← Finset.card_union_of_disjoint h2]
      exact Finset.card_le_univ _
    have hu' : ((closedNbhd S (social Y z)).card : ℝ) + (touched Y z).card ≤ Fintype.card Q := by
      exact_mod_cast hu
    have ht0 : (0 : ℝ) ≤ (touched Y z).card := Nat.cast_nonneg _
    have hA : r * (closedNbhd S (social Y z)).card ≤ max m r * (Fintype.card Q - (touched Y z).card) := by
      calc r * (closedNbhd S (social Y z)).card ≤ r * (Fintype.card Q - (touched Y z).card) :=
            mul_le_mul_of_nonneg_left (by linarith) hr0
        _ ≤ max m r * (Fintype.card Q - (touched Y z).card) :=
            mul_le_mul_of_nonneg_right (le_max_right _ _) (by linarith)
    have hB : m * (touched Y z).card ≤ max m r * (touched Y z).card :=
      mul_le_mul_of_nonneg_right (le_max_left _ _) ht0
    show f z ≤ max m r * Fintype.card Q
    rw [hf]
    simp only
    rw [hc1, hc2]
    nlinarith
  have hmono := integral_mono_ae hfi (integrable_const _) hle
  rw [hcalc, integral_const, smul_eq_mul, measureReal_restrict_apply_univ] at hmono
  have hmax0 : 0 ≤ max m r * Fintype.card Q := mul_nonneg (le_trans hr0 (le_max_right _ _)) (Nat.cast_nonneg _)
  have hW2 : volume.real W * (max m r * Fintype.card Q) ≤ s ^ 2 * (max m r * Fintype.card Q) :=
    mul_le_mul_of_nonneg_right hWs hmax0
  rw [Nat.card_eq_fintype_card]
  nlinarith

/-! ## Spec examples -/

/-- Empty rows have null edges. -/
example (S : Set Q) : RowsEdgeNull S (fun _ : Q => (∅ : Set ℂ)) := by
  intro q s _
  simp [pairSet]

end

end HadwigerNelson.Rigidity
