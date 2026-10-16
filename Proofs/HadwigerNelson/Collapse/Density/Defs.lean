import Proofs.HadwigerNelson.Collapse.Headline
import Proofs.HadwigerNelson.Plane.OneClass.Fractional
import Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw
import Proofs.HadwigerNelson.Plane.CoverExamples

/-!
# The density form of the collapse: the definitions and the lower half (FS-131, jobs FS131-KFR1 and FS131-IFR1; module D1)

**Read aloud, against the informal claim** (`LEDGER.md` row 129: "`α₁(F²) = α_loc(F)` with
`α_loc(F) = max(m₁(ℝ²), sup_v r_v)` (`r_v` a stable place's all-levels independence ratio)"; FS103-F-FRAC, FS103-B-AMEN).

* `stableRatio P` — `r_P`: the supremum over the levels `m ≥ 1` of `|I| / |𝓞 ⧸ P^m|`, `I` an independent set of the
  residue target `levelTarget P m = Cay(𝓞 ⧸ P^m, norm-one)`.
* `localRatio F` — `α_loc(F) = max(m₁(ℝ²), ⨆_P r_P)`.
* `IndepSets F`, `IndepLaw F`, `IndepLaw.density` — an `R ⋊ U`-invariant random independent set of `Cay(R, U)`,
  `R = ℤ[U_F]`, and its density `P(0 ∈ I)`: the one-class namesakes of `Collapse.Xk` and `Collapse.InvColouring`.
* `SetEdgeNull F W` — a set `W ⊆ ℂ × K` whose pairs `(z, x)`, `(z + e^{iθ}, x + ιK u)` both in `W` are null at every unit
  vector `u`: the one-class namesake of `Collapse.SliceEdgeNullK`.

**The lower half** (FRAC step 8; B-AMEN's pullbacks), with no outside theorem: `localRatio_le_finIndepRatio`.

**Models.** `IndepLaw F` is inhabited at every number field by the point mass at the empty set (`nonempty_indepLaw`); a
law of positive density is `Collapse.exists_indepLaw` (module D2). `stableRatio P ≥ 1/2` at a ramified stable prime
(`half_le_stableRatio_of_isRamified`; `F = ℚ`, the prime above `2`).
-/

namespace HadwigerNelson.Collapse

open SpectralChain NumberField MeasureTheory SimpleGraph Rigidity Rigidity.Counting Plane
open scoped ENNReal

noncomputable section

variable {F : Subfield ℝ}

/-! ## The ratios -/

/-- **The all-levels independence ratio of a stable prime**, `r_P`: the supremum, over the levels `m ≥ 1` and the
independent sets `s` of the level-`m` residue target, of `|s| / |𝓞 ⧸ P^m|`. -/
def stableRatio (P : StablePrime F) : ℝ≥0∞ :=
  ⨆ (m : ℕ) (_ : 1 ≤ m) (s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m))
    (_ : (levelTarget P m).IsIndepSet (s : Set (𝓞 (fieldI F) ⧸ P.P ^ m))),
    (s.card : ℝ≥0∞) / (Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ≥0∞)

variable (F) in
/-- **`α_loc(F)`, the local ratio**: the larger of `m₁(ℝ²)` and every stable prime's all-levels ratio. -/
def localRatio : ℝ≥0∞ := max mOne (⨆ P : StablePrime F, stableRatio P)

example (P : StablePrime F) : stableRatio P = ⨆ (m : ℕ) (_ : 1 ≤ m) (s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m))
    (_ : (levelTarget P m).IsIndepSet (s : Set (𝓞 (fieldI F) ⧸ P.P ^ m))),
    (s.card : ℝ≥0∞) / (Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ≥0∞) := rfl

example : localRatio F = max mOne (⨆ P : StablePrime F, stableRatio P) := rfl

/-- An independent set of a level's target holds at most `r_P` of it. -/
theorem card_div_le_stableRatio (P : StablePrime F) {m : ℕ} (hm : 1 ≤ m) (s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m))
    (hs : (levelTarget P m).IsIndepSet (s : Set (𝓞 (fieldI F) ⧸ P.P ^ m))) :
    (s.card : ℝ≥0∞) / (Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ≥0∞) ≤ stableRatio P :=
  le_iSup₂_of_le (f := fun (m : ℕ) (_ : 1 ≤ m) => ⨆ (s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m))
    (_ : (levelTarget P m).IsIndepSet (s : Set (𝓞 (fieldI F) ⧸ P.P ^ m))),
    (s.card : ℝ≥0∞) / (Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ≥0∞)) m hm (le_iSup₂_of_le s hs le_rfl)

/-- `m₁(ℝ²) ≤ α_loc(F)`. -/
theorem mOne_le_localRatio : mOne ≤ localRatio F := le_max_left _ _

/-- `r_P ≤ α_loc(F)`. -/
theorem stableRatio_le_localRatio (P : StablePrime F) : stableRatio P ≤ localRatio F :=
  (le_iSup (fun P : StablePrime F => stableRatio P) P).trans (le_max_right _ _)

/-- **What an upper bound on `α_loc` means**: one on `m₁` and on every `r_P`. -/
theorem localRatio_le_iff {r : ℝ≥0∞} : localRatio F ≤ r ↔ mOne ≤ r ∧ ∀ P : StablePrime F, stableRatio P ≤ r := by
  rw [localRatio, max_le_iff, iSup_le_iff]

-- FS131-IFR1: the residue rings of a stable prime are finite (as `Rigidity/ClassRatio`'s private `finite_quot_pow`).
private theorem finite_quot [NumberField F] (P : StablePrime F) (m : ℕ) : Finite (𝓞 (fieldI F) ⧸ P.P ^ m) :=
  Ideal.finiteQuotientOfFreeOfNeBot _ (pow_ne_zero m P.heightOne.ne_bot)

-- FS131-IFR1: the size of a residue ring, in `ℝ≥0∞`, is neither `0` nor `∞`.
private theorem card_quot_ne [NumberField F] (P : StablePrime F) (m : ℕ) :
    (Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ≥0∞) ≠ 0 ∧ (Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ≥0∞) ≠ ⊤ := by
  haveI := finite_quot P m
  exact ⟨by exact_mod_cast Nat.card_pos.ne', ENNReal.natCast_ne_top _⟩

/-- **From the count's `RatioAtMost` to `r_P`** (the converse of `ratioAtMost_of_stableRatio_le`). -/
theorem stableRatio_le_of_ratioAtMost {P : StablePrime F} {c : ℝ} (h : RatioAtMost P c) :
    stableRatio P ≤ ENNReal.ofReal c := by
  refine iSup₂_le fun m hm => iSup₂_le fun s hs => ENNReal.div_le_of_le_mul ?_
  calc (s.card : ℝ≥0∞) = ENNReal.ofReal s.card := (ENNReal.ofReal_natCast _).symm
    _ ≤ ENNReal.ofReal (c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m)) := ENNReal.ofReal_le_ofReal (h m hm s hs)
    _ = ENNReal.ofReal c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) := by
      rw [ENNReal.ofReal_mul' (Nat.cast_nonneg _), ENNReal.ofReal_natCast]

/-- **From `r_P` to the count's `RatioAtMost`**: a real bound on `r_P` bounds every level. -/
theorem ratioAtMost_of_stableRatio_le [NumberField F] (P : StablePrime F) {c : ℝ} (hc : 0 ≤ c)
    (h : stableRatio P ≤ ENNReal.ofReal c) : RatioAtMost P c := by
  intro m hm s hs
  have h1 := (card_div_le_stableRatio P hm s hs).trans h
  obtain ⟨h0, htop⟩ := card_quot_ne P m
  rw [ENNReal.div_le_iff h0 htop, ← ENNReal.ofReal_natCast s.card, ← ENNReal.ofReal_natCast (Nat.card _),
    ← ENNReal.ofReal_mul hc] at h1
  exact (ENNReal.ofReal_le_ofReal_iff (by positivity)).1 h1

/-- `r_P ≤ 1`. -/
theorem stableRatio_le_one [NumberField F] (P : StablePrime F) : stableRatio P ≤ 1 := by
  refine (stableRatio_le_of_ratioAtMost (c := 1) fun m _ s _ => ?_).trans ENNReal.ofReal_one.le
  haveI := finite_quot P m
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ m) := Fintype.ofFinite _
  rw [one_mul, Nat.card_eq_fintype_card]
  exact_mod_cast s.card_le_univ

/-- **At a ramified stable prime `r_P ≥ 1/2`**: the level-one target is two-colourable
(`Rigidity.colorable_two_levelTarget_one_of_isRamified`), and a colour class holds half of it. -/
theorem half_le_stableRatio_of_isRamified [NumberField F] {P : StablePrime F} (h : IsRamified P) :
    2⁻¹ ≤ stableRatio P := by
  classical
  obtain ⟨C⟩ := colorable_two_levelTarget_one_of_isRamified h
  haveI := finite_quot P 1
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  set s₀ := Finset.univ.filter fun x => C x = 0
  set s₁ := Finset.univ.filter fun x => ¬ C x = 0
  have hind : ∀ t : Finset (𝓞 (fieldI F) ⧸ P.P ^ 1), (∀ x ∈ t, ∀ y ∈ t, C x = C y) →
      (levelTarget P 1).IsIndepSet (t : Set _) := fun t ht x hx y hy _ hadj => C.valid hadj (ht x hx y hy)
  have h₀ : (levelTarget P 1).IsIndepSet (s₀ : Set _) := hind s₀ fun x hx y hy => by
    rw [(Finset.mem_filter.1 hx).2, (Finset.mem_filter.1 hy).2]
  have h₁ : (levelTarget P 1).IsIndepSet (s₁ : Set _) := hind s₁ fun x hx y hy => by
    have hx' := (Finset.mem_filter.1 hx).2
    have hy' := (Finset.mem_filter.1 hy).2
    have hfin : ∀ c : Fin 2, ¬ c = 0 → c = 1 := by decide
    rw [hfin _ hx', hfin _ hy']
  have hsum : s₀.card + s₁.card = Nat.card (𝓞 (fieldI F) ⧸ P.P ^ 1) := by
    rw [Finset.card_filter_add_card_filter_not, Finset.card_univ, Nat.card_eq_fintype_card]
  obtain ⟨h0, htop⟩ := card_quot_ne P 1
  have key : ∀ t : Finset (𝓞 (fieldI F) ⧸ P.P ^ 1), (levelTarget P 1).IsIndepSet (t : Set _) →
      Nat.card (𝓞 (fieldI F) ⧸ P.P ^ 1) ≤ 2 * t.card → 2⁻¹ ≤ stableRatio P := by
    intro t ht hle
    refine le_trans ?_ (card_div_le_stableRatio P (le_refl 1) t ht)
    rw [ENNReal.le_div_iff_mul_le (Or.inl h0) (Or.inl htop), ENNReal.inv_mul_le_iff (by norm_num) (by norm_num)]
    exact_mod_cast hle
  rcases le_total s₁.card s₀.card with hle | hle
  · exact key s₀ h₀ (by omega)
  · exact key s₁ h₁ (by omega)

/-- **Hoffman at every level from thickness**: a `c`-thick stable prime has all-levels ratio at most `c/(1 + c)` (a
modulus bound on the character sums bounds their real parts; `Rigidity/ClassRatio`'s `ratioAtMost_of_charBound`). -/
theorem ratioAtMost_of_thickAt [NumberField F] {P : StablePrime F} {c : ℝ} (hc : 0 ≤ c) (h : ThickAt P c) :
    RatioAtMost P (c / (1 + c)) :=
  ratioAtMost_of_charBound P hc fun m hm hfin ψ hψ =>
    (abs_le.1 ((Complex.abs_re_le_norm _).trans (h m hm hfin ψ hψ))).1

/-- `r_P ≤ c/(1 + c)` at a `c`-thick stable prime. -/
theorem stableRatio_le_of_thickAt [NumberField F] {P : StablePrime F} {c : ℝ} (hc : 0 ≤ c) (h : ThickAt P c) :
    stableRatio P ≤ ENNReal.ofReal (c / (1 + c)) :=
  stableRatio_le_of_ratioAtMost (ratioAtMost_of_thickAt hc h)

/-! ## The lower half -/

/-- **The averaging lemma for a Cayley target** (the No-Homomorphism lemma's density form): a graph with a homomorphism
into a translation-invariant graph on a finite abelian group has finitary ratio at least the target's independent sets'
proportion — the translates of an independent set pull back to independent sets, and on average they meet a finite set in
its proportion. -/
theorem card_div_le_finIndepRatio_of_hom {V A : Type*} [AddCommGroup A] [Finite A] {G : SimpleGraph V}
    {H : SimpleGraph A} (hH : ∀ a x y : A, H.Adj (x + a) (y + a) ↔ H.Adj x y) (φ : G →g H) (s : Finset A)
    (hs : H.IsIndepSet (s : Set A)) : (s.card : ℝ≥0∞) / (Nat.card A : ℝ≥0∞) ≤ G.finIndepRatio := by
  classical
  letI : Fintype A := Fintype.ofFinite A
  rw [le_finIndepRatio_iff]
  intro S _
  -- the pull-back to `S` of the translate `s − a`
  set I : A → Finset V := fun a => S.filter fun v => φ v + a ∈ s with hI
  have hIind : ∀ a, G.IsIndepSet (I a : Set V) := by
    intro a v hv w hw _ hadj
    have hv' := (Finset.mem_filter.1 hv).2
    have hw' := (Finset.mem_filter.1 hw).2
    have hH' : H.Adj (φ v + a) (φ w + a) := (hH a _ _).2 (φ.map_adj hadj)
    exact hs hv' hw' (H.ne_of_adj hH') hH'
  -- every point of `S` lies in exactly `|s|` of them
  have hpt : ∀ v : V, ∑ a : A, (if φ v + a ∈ s then 1 else 0) = s.card := by
    intro v
    refine (Fintype.sum_equiv (Equiv.addLeft (φ v)) (fun a => if φ v + a ∈ s then 1 else 0)
      (fun b => if b ∈ s then 1 else 0) fun a => rfl).trans ?_
    rw [Finset.sum_boole]
    simp
  have hcount : ∑ a : A, (I a).card = S.card * s.card := by
    simp only [hI, Finset.card_filter]
    rw [Finset.sum_comm]
    simp only [hpt, Finset.sum_const, smul_eq_mul]
  obtain ⟨a, -, ha⟩ := Finset.exists_le_of_sum_le (s := Finset.univ) Finset.univ_nonempty
    (f := fun _ => S.card * s.card) (g := fun a => Fintype.card A * (I a).card)
    (by rw [Finset.sum_const, Finset.card_univ, smul_eq_mul, ← Finset.mul_sum, hcount])
  refine ⟨I a, Finset.filter_subset _ _, hIind a, ?_⟩
  rw [Nat.card_eq_fintype_card, div_eq_mul_inv, mul_right_comm, ← div_eq_mul_inv]
  refine ENNReal.div_le_of_le_mul ?_
  have : s.card * S.card ≤ (I a).card * Fintype.card A := by
    rw [mul_comm, mul_comm (I a).card]; exact ha
  exact_mod_cast this

/-- The residue targets are translation-invariant (adjacency reads `x − y`). -/
theorem levelTarget_adj_add (P : StablePrime F) (m : ℕ) (a x y : 𝓞 (fieldI F) ⧸ P.P ^ m) :
    (levelTarget P m).Adj (x + a) (y + a) ↔ (levelTarget P m).Adj x y := by
  simp only [levelTarget, SimpleGraph.fromRel_adj, add_sub_add_right_eq_sub, ne_eq, add_left_inj]

/-- **`r_P ≤ α₁(F²)`** (the pullback at a stable place): `UpperHalf.exists_hom_levelTarget` and the averaging lemma. -/
theorem stableRatio_le_finIndepRatio [NumberField F] (P : StablePrime F) :
    stableRatio P ≤ ((unitDistance ℂ).induce (planeOver F)).finIndepRatio := by
  refine iSup₂_le fun m hm => iSup₂_le fun s hs => ?_
  obtain ⟨φ, -⟩ := UpperHalf.exists_hom_levelTarget P hm
  haveI := finite_quot P m
  exact card_div_le_finIndepRatio_of_hom (levelTarget_adj_add P m) φ s hs

/-- **`m₁(ℝ²) ≤ α₁(F²)`** (the pullback at the real place): `F²` is a subgraph of the plane, and
`OneClass.mOne_le_finIndepRatio` (C133-EASY, no outside theorem). -/
theorem mOne_le_finIndepRatio_planeOver (F : Subfield ℝ) :
    mOne ≤ ((unitDistance ℂ).induce (planeOver F)).finIndepRatio :=
  OneClass.mOne_le_finIndepRatio.trans (finIndepRatio_le_of_embedding (Embedding.induce _))

/-- **The lower half, `α_loc(F) ≤ α₁(F²)`**, at every real number field, with no outside theorem. -/
theorem localRatio_le_finIndepRatio [NumberField F] :
    localRatio F ≤ ((unitDistance ℂ).induce (planeOver F)).finIndepRatio :=
  max_le (mOne_le_finIndepRatio_planeOver F) (iSup_le stableRatio_le_finIndepRatio)

/-- `α₁(F²) ≤ 1/2`: `0` and `1` are at distance one. -/
theorem finIndepRatio_planeOver_le_half (F : Subfield ℝ) :
    ((unitDistance ℂ).induce (planeOver F)).finIndepRatio ≤ 2⁻¹ := by
  classical
  have h0 : (0 : ℂ) ∈ planeOver F := ⟨by simp, by simp⟩
  have h1 : (1 : ℂ) ∈ planeOver F := ⟨by simp, by simp⟩
  set a : planeOver F := ⟨0, h0⟩
  set b : planeOver F := ⟨1, h1⟩
  have hab : a ≠ b := fun h => zero_ne_one (congrArg Subtype.val h)
  have hadj : ((unitDistance ℂ).induce (planeOver F)).Adj a b := by
    show dist (0 : ℂ) 1 = 1
    simp
  have hS : ({a, b} : Finset (planeOver F)).Nonempty := ⟨a, by simp⟩
  have key := ((unitDistance ℂ).induce (planeOver F)).finIndepRatio_le_of_forall_card_le hS (a := 1) ?_
  · rw [Finset.card_pair hab] at key
    simpa using key
  · intro I hI hind
    by_contra hlt
    push Not at hlt
    have hIeq : I = {a, b} := Finset.eq_of_subset_of_card_le hI (by rw [Finset.card_pair hab]; omega)
    exact hind (by rw [hIeq]; simp) (by rw [hIeq]; simp) hab hadj

/-- **The one field where `α_loc` is not `m₁`** (the planner's owed spec example, `plans/FS131-KFR1-density-plan.md`
§ 3.7): at `ℚ` the prime above `2` is ramified (`UpperHalf.exists_stablePrime_rat`), so `r_P ≥ 1/2` there, and
`α_loc(ℚ) ≤ α₁(ℚ²) ≤ 1/2` — `α_loc(ℚ) = 1/2`, the plane over `ℚ` being bipartite. -/
example : localRatio (⊥ : Subfield ℝ) = 2⁻¹ := by
  obtain ⟨P, -, hP⟩ := UpperHalf.exists_stablePrime_rat
  exact le_antisymm (localRatio_le_finIndepRatio.trans (finIndepRatio_planeOver_le_half ⊥))
    ((half_le_stableRatio_of_isRamified hP).trans (stableRatio_le_localRatio P))

/-! ## `m₁(ℝ²) > 1/6`, from `disc7` -/

-- FS131-IFR1: a point on the boundary circle of a disc of the class `disc7 0` is not interior to the class: just outside
-- the disc no disc of the class reaches (two of one class are `√21/2 > 2` apart).
private theorem not_mem_interior_disc7 {x : ℂ} {m n : ℤ} (hc : disc7Col m n = 0)
    (hx : dist x (disc7Centre m n) = 1 / 2) : x ∉ interior (disc7 0) := by
  intro hint
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.1 isOpen_interior x hint
  set c := disc7Centre m n with hcdef
  set s : ℝ := min ε 1 with hs
  have hs0 : 0 < s := lt_min hε one_pos
  have hs1 : s ≤ 1 := min_le_right _ _
  have hsε : s ≤ ε := min_le_left _ _
  set w : ℂ := x + (s : ℂ) * (x - c) with hw
  have hwx : dist w x = s / 2 := by
    rw [dist_eq_norm, show w - x = (s : ℂ) * (x - c) by rw [hw]; ring, norm_mul, Complex.norm_real,
      Real.norm_eq_abs, abs_of_pos hs0, ← dist_eq_norm, hx]
    ring
  have hwc : dist w c = (1 + s) / 2 := by
    rw [dist_eq_norm, show w - c = ((1 + s : ℝ) : ℂ) * (x - c) by rw [hw]; push_cast; ring, norm_mul,
      Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith), ← dist_eq_norm, hx]
    ring
  have hwmem : w ∈ disc7 0 := interior_subset (hball (by rw [Metric.mem_ball, hwx]; linarith))
  simp only [disc7, Set.mem_iUnion, Metric.mem_closedBall] at hwmem
  obtain ⟨m', n', hc', hw'⟩ := hwmem
  by_cases h : (m', n') = (m, n)
  · obtain ⟨rfl, rfl⟩ := Prod.mk.inj h
    linarith
  · have hge := disc7Col_eq_dist_ge (hc'.trans hc.symm) h
    have h21 : (2 : ℝ) < √21 / 2 := by
      rw [lt_div_iff₀ (by norm_num), Real.lt_sqrt (by norm_num)]; norm_num
    have := dist_triangle (disc7Centre m' n') w c
    rw [_root_.dist_comm] at hw'
    linarith

/-- **`m₁(ℝ²) ≥ 2π/(21√3) = 0.1727…`**: the interior of one class of the seven-disc colouring (`Plane.disc7 0`, closed
discs of radius `1/2`) has no unit pair (`disc7_unitPair_mem_sphere`: a class's unit pairs lie on its spheres) and the class's
density (`disc7_upperDensity`, `volume_frontier_disc7`, `upperDensity_congr_ae`). -/
theorem disc7_le_mOne : ENNReal.ofReal (2 * Real.pi / (21 * Real.sqrt 3)) ≤ mOne := by
  have hint : (unitDistance ℂ).IsIndepSet (interior (disc7 0)) := by
    rw [isIndepSet_unitDistance_iff]
    intro x hx y hy hxy
    have hx' := interior_subset hx
    have hy' := interior_subset hy
    simp only [disc7, Set.mem_iUnion, Metric.mem_closedBall] at hx' hy'
    obtain ⟨m, n, hc, hxc⟩ := hx'
    obtain ⟨m', n', hc', hyc⟩ := hy'
    by_cases h : (m, n) = (m', n')
    · obtain ⟨rfl, rfl⟩ := Prod.mk.inj h
      refine not_mem_interior_disc7 hc (le_antisymm hxc ?_) hx
      have := dist_triangle x (disc7Centre m n) y
      rw [_root_.dist_comm (disc7Centre m n) y] at this
      linarith
    · have hge := disc7Col_eq_dist_ge (hc.trans hc'.symm) h
      have h21 : (2 : ℝ) < √21 / 2 := by
        rw [lt_div_iff₀ (by norm_num), Real.lt_sqrt (by norm_num)]; norm_num
      have := dist_triangle (disc7Centre m n) x (disc7Centre m' n')
      have := dist_triangle x y (disc7Centre m' n')
      rw [_root_.dist_comm] at hxc
      linarith
  have hd : upperDensity (interior (disc7 0)) = ENNReal.ofReal (2 * Real.pi / (21 * Real.sqrt 3)) := by
    rw [upperDensity_congr_ae (interior_ae_eq_of_null_frontier (volume_frontier_disc7 0)), disc7_upperDensity]
  rw [← hd]
  exact upperDensity_le_mOne isOpen_interior.measurableSet hint

/-- `1/6 < m₁(ℝ²)`: `2π/(21√3) > 1/6` (`π > 3.14`, `√3 < 1.733`). -/
theorem sixth_lt_mOne : (6 : ℝ≥0∞)⁻¹ < mOne := by
  refine lt_of_lt_of_le ?_ disc7_le_mOne
  have h3 : Real.sqrt 3 < 7 / 4 := (Real.sqrt_lt' (by norm_num)).2 (by norm_num)
  have h3p : 0 < Real.sqrt 3 := by positivity
  rw [show (6 : ℝ≥0∞)⁻¹ = ENNReal.ofReal 6⁻¹ by rw [ENNReal.ofReal_inv_of_pos (by norm_num)]; norm_num]
  rw [ENNReal.ofReal_lt_ofReal_iff (by positivity), lt_div_iff₀ (by positivity)]
  nlinarith [Real.pi_gt_d2]

/-! ## Random independent sets of `Cay(R, U)` -/

variable (F) in
/-- **The independent sets of `Cay(R, U)`**, as indicators `R → Bool`: no two points of the set differ by a unit vector. -/
def IndepSets : Set (unitRing F → Bool) :=
  {c | ∀ x y : unitRing F, (y : ℂ) - x ∈ unitVectors F → ¬ (c x = true ∧ c y = true)}

variable (F) in
/-- **An invariant random independent set** of `Cay(R, U)`: a probability on `R → Bool` carried by `IndepSets F`,
invariant under every translation and every rotation (the one-class `InvColouring`). -/
structure IndepLaw where
  /-- The law of the random set. -/
  μ : Measure (unitRing F → Bool)
  /-- It is a probability measure. -/
  isProb : IsProbabilityMeasure μ
  /-- It is carried by the independent sets. -/
  carried : μ (IndepSets F)ᶜ = 0
  /-- Invariant under every translation. -/
  shift_inv : ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ
  /-- Invariant under every rotation. -/
  rot_inv : ∀ u : unitVectors F, μ.map (fun c x => c (uvRing u * x)) = μ

/-- **The density** of an invariant random independent set: `P(0 ∈ I)`. -/
def IndepLaw.density (μ : IndepLaw F) : ℝ≥0∞ := μ.μ {c | c 0 = true}

example (μ : IndepLaw F) : μ.density = μ.μ {c | c 0 = true} := rfl

-- FS131-IFR1: `IndepSets F` as one condition per pair (`Collapse.Xk`'s, at `Bool`).
private theorem indepSets_eq_iInter : IndepSets F = ⋂ x : unitRing F, ⋂ y : unitRing F,
    (fun c : unitRing F → Bool => (c x, c y)) ⁻¹'
      {p : Bool × Bool | (y : ℂ) - x ∈ unitVectors F → ¬ (p.1 = true ∧ p.2 = true)} := by
  ext c
  simp [IndepSets]

/-- `IndepSets F` is closed (one clopen condition per pair). -/
theorem isClosed_indepSets : IsClosed (IndepSets F) := by
  rw [indepSets_eq_iInter]
  exact isClosed_iInter fun x => isClosed_iInter fun y =>
    IsClosed.preimage ((continuous_apply x).prodMk (continuous_apply y)) (isClosed_discrete _)

/-- `IndepSets F` is measurable when `R` is countable. -/
theorem measurableSet_indepSets [Countable (unitRing F)] : MeasurableSet (IndepSets F) := by
  rw [indepSets_eq_iInter]
  exact MeasurableSet.iInter fun x => MeasurableSet.iInter fun y =>
    ((measurable_pi_apply x).prodMk (measurable_pi_apply y)) (Set.to_countable _).measurableSet

/-- **A model**: the point mass at the empty set is an invariant random independent set (of density `0`). -/
theorem nonempty_indepLaw [NumberField F] : Nonempty (IndepLaw F) := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  have hmem : (fun _ => false : unitRing F → Bool) ∈ IndepSets F := fun x y _ h => by simp at h
  have hshift : ∀ y : unitRing F, Measurable (fun (c : unitRing F → Bool) x => c (x + y)) :=
    fun y => measurable_pi_lambda _ fun x => measurable_pi_apply _
  have hrot : ∀ u : unitVectors F, Measurable (fun (c : unitRing F → Bool) x => c (uvRing u * x)) :=
    fun u => measurable_pi_lambda _ fun x => measurable_pi_apply _
  refine ⟨⟨Measure.dirac fun _ => false, inferInstance, ?_, fun y => ?_, fun u => ?_⟩⟩
  · rw [Measure.dirac_apply' _ measurableSet_indepSets.compl, Set.indicator_of_notMem (by simpa using hmem)]
  · rw [Measure.map_dirac' (hshift y)]
  · rw [Measure.map_dirac' (hrot u)]

/-! ## Sets of the slice with null edges -/

variable (F) in
/-- **A set of the slice `ℂ × K` with null edges**: at every unit vector `u`, the pairs `(z, x) ∈ W` with
`(z + e^{iθ}, x + ιK u) ∈ W` are null for `vol ⊗ haar ⊗ arc length`. -/
def SetEdgeNull [NumberField F] (W : Set (ℂ × K F)) : Prop :=
  ∀ u ∈ unitVectorsR F, ((volume.prod (haarK F)).prod arcLength)
    {p : (ℂ × K F) × ℝ | p.1 ∈ W ∧ (p.1.1 + e p.2, p.1.2 + ιK F u) ∈ W} = 0

/-- The empty set has null edges (the model of `SetEdgeNull`; a positive-measure one is `exists_slice_set`'s). -/
theorem setEdgeNull_empty [NumberField F] : SetEdgeNull F ∅ := fun _ _ => by simp
/-! ## Spec -/

-- the independence condition, pair by pair
example (c : unitRing F → Bool) :
    c ∈ IndepSets F ↔ ∀ x y : unitRing F, (y : ℂ) - x ∈ unitVectors F → ¬ (c x = true ∧ c y = true) := Iff.rfl

-- the empty indicator is a point of `IndepSets F`
example : (fun _ => false : unitRing F → Bool) ∈ IndepSets F := fun _ _ _ h => by simp at h

-- the slice's null edges, unit vector by unit vector
example [NumberField F] (W : Set (ℂ × K F)) : SetEdgeNull F W ↔ ∀ u ∈ unitVectorsR F,
    ((volume.prod (haarK F)).prod arcLength) {p : (ℂ × K F) × ℝ | p.1 ∈ W ∧ (p.1.1 + e p.2, p.1.2 + ιK F u) ∈ W} = 0 :=
  Iff.rfl


end

end HadwigerNelson.Collapse
