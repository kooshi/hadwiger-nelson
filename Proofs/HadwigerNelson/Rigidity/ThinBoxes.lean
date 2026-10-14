import Proofs.HadwigerNelson.Rigidity.PlaceSizes
import Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames

/-!
# Thin boxes are heavy: Lemma 3.1′ over the Tate model (FS-131, job FS131-K8B1; module M8b-2b)

Part 2 of M8b (`plans/FS131-K8B1-zero-entropy-second.md`; X01D § 3.3, `plans/FS100-X01D-derivation.md` ll. 221–241; EN2-L31,
`plans/FS131-EN2-derivation.md` § 3.6), over `(D : TateModel F)`.

**Read aloud.**

* **Boxes** (X01D l. 223): `Q(ε)` (`box F ε`) — archimedean components of ordinary modulus `< ε`, split components integral;
  open (`isOpen_box`). `Q_p(ε, δ)` (`thinBox p ε δ`) — its points of size `≤ δ` at `p`. Their closed forms, with `≤ ε`
  (`closedBox`, `closedThinBox`), are closed, and every image of a closed set under `π` is Borel
  (`TateModel.measurableSet_image`: `W` is σ-compact, `TateModel.sigmaCompactSpace`, from `W = K + O′` with `L` countable).
* **(i) The partition** (l. 230): finitely many translates `π(c_j + Q(ε))` cover `R̂`, and a measurable label `P : R̂ → Fin k`
  names one holding each point (`TateModel.exists_box_partition`).
* **(ii) Bowen atoms are thin at `p`** (ll. 231–236): if `x` and `y` have one name of length `n ≥ 1` under `rot u` and `P`,
  then for every lift `x̃` of `x`, `y = π(x̃ + a)` with `u^i a ∈ Q(2ε)` for every `i < n` (`TateModel.exists_orbit_box`: the
  induction on `i`, each step closed by the gap of Lemma PF), so `a ∈ Q_p(2ε, max(2ε, 1)·|u|_p^{−(n−1)})`
  (`TateModel.nameCell_subset`).
* **(iii′) Zero entropy gives heavy names** (EN2-L31's part (iii′)): EN2-ZE, `Rigidity.exists_forall_exp_le_measureReal_nameCell`,
  at `T = rot u` (`exists_heavy_nameCells`).
* **(iv) The scales** (ll. 239–241): `δ ↦ n`, the least length thinner than `δ` (`exists_delta_of_one_lt`).
* **Lemma 3.1′** (`TateModel.thinBox_heavy`), EN2-L31 word for word: "Fix `ε > 0` with `∏_{v|∞}(2ε(1 + |u*|_v^{1/2}))² ·
  ∏_{w split} max(1,|u*|_w) < 1/C_Λ` … For every `β > 0` and `η > 0` there are `δ₀ > 0` and a Borel `X′ ⊆ R̂` with
  `μ(X′) > μ(R̂) − η` such that `μ(π(x̃ + Q_{v*}(2ε, δ))) ≥ δ^β` for every `x ∈ X′`, every lift `x̃`, and every `0 < δ ≤ δ₀`."
  Here `μ` is a probability measure (`μ(R̂) = 1`; `ZeroEntropyCarried` is stated for probability measures), `|u*|_v^{1/2}` is
  the ordinary modulus `v u*` and the square is `^ v.mult`, `∏_{w split} max(1, |u*|_w)` is `splitHeight`, and `1/C_Λ` is any
  gap `C` of `Λ` (`TateModel.IsGap`; Lemma PF gives one). The hypotheses set above the lemma in X01D — `μ` invariant, `h_μ(u*) = 0`,
  `v*` expanding — are `hμ`, `h0`, `hp`.
* **The choice of `ε`** (`exists_eps_lt`): small enough for the gap and for `16ε ≤ 1` (Step 4's arithmetic, X01D l. 274).

**Inhabitants.** The boxes are sets; spec examples fix them. `thinBox_heavy`'s hypotheses are those of `ZeroEntropyCarried`
with a gap and an expanding place: the point mass at `1` is invariant of entropy zero (`zeroEntropyCarried_model`), every
non-torsion `u` has an expanding place (`exists_one_lt_absAt`), and every Tate model has a gap (`exists_isGap`); a Tate model
is `Rigidity.exists_tateModel`'s. EN2-L31's non-degenerate model is EF-X's circle measure (X01D § 2.2), not in the library.
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField IsDedekindDomain IsDedekindDomain.HeightOneSpectrum MeasureTheory WPlace

open scoped RestrictedProduct

noncomputable section

variable (F : Subfield ℝ) [NumberField F]

/-- **The box `Q(ε)`** (X01D l. 223): archimedean components of ordinary modulus `< ε`, split components integral. -/
def box (ε : ℝ) : Set (SAdeleRing F) :=
  {a | (∀ v : InfinitePlace (fieldI F), mixedEmbedding.normAtPlace v a.1 < ε) ∧
    ∀ w : SplitPlace F, a.2 w ∈ w.1.adicCompletionIntegers (fieldI F)}

/-- **The closed box `Q̄(ε)`**: archimedean components of ordinary modulus `≤ ε`, split components integral. -/
def closedBox (ε : ℝ) : Set (SAdeleRing F) :=
  {a | (∀ v : InfinitePlace (fieldI F), mixedEmbedding.normAtPlace v a.1 ≤ ε) ∧
    ∀ w : SplitPlace F, a.2 w ∈ w.1.adicCompletionIntegers (fieldI F)}

variable {F}

/-- **The thin box `Q_p(ε, δ)`** (X01D l. 224): the points of `Q(ε)` of size at most `δ` at `p`. -/
def thinBox (p : WPlace F) (ε δ : ℝ) : Set (SAdeleRing F) := {a | a ∈ box F ε ∧ p.size a ≤ δ}

/-- **The closed thin box**: the points of `Q̄(ε)` of size at most `δ` at `p`. -/
def closedThinBox (p : WPlace F) (ε δ : ℝ) : Set (SAdeleRing F) := {a | a ∈ closedBox F ε ∧ p.size a ≤ δ}

example (ε : ℝ) (a : SAdeleRing F) : a ∈ box F ε ↔ (∀ v : InfinitePlace (fieldI F),
    mixedEmbedding.normAtPlace v a.1 < ε) ∧ ∀ w : SplitPlace F, a.2 w ∈ w.1.adicCompletionIntegers (fieldI F) := Iff.rfl

example (p : WPlace F) (ε δ : ℝ) (a : SAdeleRing F) : a ∈ thinBox p ε δ ↔ a ∈ box F ε ∧ p.size a ≤ δ := Iff.rfl

example (p : WPlace F) (ε δ : ℝ) (a : SAdeleRing F) :
    a ∈ closedThinBox p ε δ ↔ a ∈ closedBox F ε ∧ p.size a ≤ δ := Iff.rfl

theorem isOpen_box (ε : ℝ) : IsOpen (box F ε) := by
  have h1 : IsOpen {b : mixedEmbedding.mixedSpace (fieldI F) |
      ∀ v : InfinitePlace (fieldI F), mixedEmbedding.normAtPlace v b < ε} := by
    simp only [Set.setOf_forall]
    exact isOpen_iInter_of_finite fun v => isOpen_lt (mixedEmbedding.continuous_normAtPlace v) continuous_const
  have h2 : IsOpen {f : SplitAdeleRing F | ∀ w : SplitPlace F, f w ∈ w.1.adicCompletionIntegers (fieldI F)} :=
    RestrictedProduct.isOpen_forall_mem fun w => Valued.isOpen_valuationSubring _
  exact h1.prod h2

theorem isClosed_closedThinBox (p : WPlace F) (ε δ : ℝ) : IsClosed (closedThinBox p ε δ) := by
  have h1 : IsClosed {a : SAdeleRing F | ∀ v : InfinitePlace (fieldI F), mixedEmbedding.normAtPlace v a.1 ≤ ε} := by
    simp only [Set.setOf_forall]
    exact isClosed_iInter fun v =>
      isClosed_le ((mixedEmbedding.continuous_normAtPlace v).comp continuous_fst) continuous_const
  have h2 : IsClosed {a : SAdeleRing F | ∀ w : SplitPlace F, a.2 w ∈ w.1.adicCompletionIntegers (fieldI F)} := by
    have he : {a : SAdeleRing F | ∀ w : SplitPlace F, a.2 w ∈ w.1.adicCompletionIntegers (fieldI F)} =
        ⋂ w : SplitPlace F, {a | (WPlace.split w).size a ≤ 1} := by
      ext a
      simp only [Set.mem_setOf_eq, Set.mem_iInter, size_le_one_iff]
    rw [he]
    exact isClosed_iInter fun w => isClosed_le (continuous_size _) continuous_const
  have h3 : IsClosed {a : SAdeleRing F | p.size a ≤ δ} := isClosed_le (continuous_size p) continuous_const
  have he : closedThinBox p ε δ =
      ({a : SAdeleRing F | ∀ v : InfinitePlace (fieldI F), mixedEmbedding.normAtPlace v a.1 ≤ ε} ∩
        {a : SAdeleRing F | ∀ w : SplitPlace F, a.2 w ∈ w.1.adicCompletionIntegers (fieldI F)}) ∩
        {a : SAdeleRing F | p.size a ≤ δ} := by
    ext a; exact Iff.rfl
  rw [he]
  exact (h1.inter h2).inter h3

theorem thinBox_subset_closedThinBox (p : WPlace F) (ε δ : ℝ) : thinBox p ε δ ⊆ closedThinBox p ε δ :=
  fun _ ha => ⟨⟨fun v => (ha.1.1 v).le, ha.1.2⟩, ha.2⟩

theorem thinBox_mono (p : WPlace F) (ε : ℝ) {δ δ' : ℝ} (h : δ ≤ δ') : thinBox p ε δ ⊆ thinBox p ε δ' :=
  fun _ ha => ⟨ha.1, ha.2.trans h⟩

theorem zero_mem_box {ε : ℝ} (hε : 0 < ε) : (0 : SAdeleRing F) ∈ box F ε := by
  refine ⟨fun v => ?_, fun w => zero_mem _⟩
  rw [show (0 : SAdeleRing F).1 = 0 from rfl, map_zero]
  exact hε

/-- `Q(ε) − Q(ε) ⊆ Q(2ε)` (X01D l. 232: "`a₀ := ỹ − x̃ ∈ Q′ := Q(ε) − Q(ε)`"). -/
theorem sub_mem_box {ε : ℝ} {a b : SAdeleRing F} (ha : a ∈ box F ε) (hb : b ∈ box F ε) : b - a ∈ box F (2 * ε) := by
  refine ⟨fun v => ?_, fun w => sub_mem (hb.2 w) (ha.2 w)⟩
  have h := size_add_le (WPlace.arch v) b (-a)
  rw [size_neg, ← sub_eq_add_neg] at h
  have hb' : (WPlace.arch v).size b < ε := hb.1 v
  have ha' : (WPlace.arch v).size a < ε := ha.1 v
  have hlt : (WPlace.arch v).size (b - a) < 2 * ε := by linarith
  exact hlt

/-- A point of `Q(ε)` has size at most `max ε 1` at every place (`< ε` at an archimedean one, `≤ 1` at a split one). -/
theorem size_le_of_mem_box {ε : ℝ} {a : SAdeleRing F} (ha : a ∈ box F ε) (p : WPlace F) : p.size a ≤ max ε 1 := by
  cases p with
  | arch v => exact (ha.1 v).le.trans (le_max_left _ _)
  | split w => exact ((size_le_one_iff w a).2 (ha.2 w)).trans (le_max_right _ _)

/-- `|x^n|_p = |x|_p^n`. -/
private theorem absAt_pow (p : WPlace F) (x : fieldI F) (n : ℕ) : p.absAt (x ^ n) = p.absAt x ^ n := by
  induction n with
  | zero =>
    rw [pow_zero, pow_zero, ← size_toSAdele, map_one]
    cases p with
    | arch v => exact (mixedEmbedding.normAtPlace v).map_one
    | split w => exact norm_one
  | succ n ih => rw [pow_succ, absAt_mul, ih, pow_succ]

namespace TateModel

variable (D : TateModel F)

/-- **The image of a closed set under `π` is Borel**: σ-compact (`sigmaCompactSpace`, `continuous_π`), and compact sets are
closed in the Hausdorff `R̂`. -/
theorem measurableSet_image {s : Set (SAdeleRing F)} (hs : IsClosed s) : MeasurableSet (D.π '' s) := by
  haveI : Countable (unitRing F) := @countable_unitRing F (Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F))
  haveI : SigmaCompactSpace (SAdeleRing F) := TateModel.sigmaCompactSpace
  obtain ⟨K, hK, hKs⟩ := (isSigmaCompact_univ.of_isClosed_subset hs (Set.subset_univ s)).image D.continuous_π
  rw [← hKs]
  exact MeasurableSet.iUnion fun n => (hK n).measurableSet

/-- The orbit of a lift: `(rot u)^[n] (π a) = π(u^n·a)` (`π_unit_mul`, by induction on `n`). -/
theorem iterate_rot_π (u : unitVectors F) (n : ℕ) (a : SAdeleRing F) :
    (rot u)^[n] (D.π a) = D.π (toSAdele F (unitL u ^ n) * a) := by
  induction n with
  | zero => rw [Function.iterate_zero, id, pow_zero, map_one, one_mul]
  | succ n ih =>
    rw [Function.iterate_succ_apply', ih, ← D.π_unit_mul, ← mul_assoc, ← map_mul, pow_succ']

/-- **(i) The partition** (X01D l. 230): `π(Q(ε))` is open and `R̂` compact, so finitely many translates `π(c_j + Q(ε))`
cover it; `P x` is the first `j` whose translate holds `x`. -/
theorem exists_box_partition {ε : ℝ} (hε : 0 < ε) :
    ∃ (k : ℕ) (c : Fin k → SAdeleRing F) (P : Dual F → Fin k), Measurable P ∧
      ∀ x : Dual F, ∃ q ∈ box F ε, x = D.π (c (P x) + q) := by
  classical
  haveI : Countable (unitRing F) := @countable_unitRing F (Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F))
  -- the translates `π(c + Q(ε))` are open and cover the compact `R̂`
  let U : SAdeleRing F → Set (Dual F) := fun c => D.π '' ((c + ·) '' box F ε)
  have hUo : ∀ c, IsOpen (U c) := fun c =>
    D.isOpenMap _ ((Homeomorph.addLeft c).isOpenMap _ (isOpen_box ε))
  have hUc : Set.univ ⊆ ⋃ c, U c := fun x _ => by
    obtain ⟨c, rfl⟩ := D.surjective_π x
    exact Set.mem_iUnion.2 ⟨c, c, ⟨0, zero_mem_box hε, add_zero c⟩, rfl⟩
  obtain ⟨t, ht⟩ := isCompact_univ.elim_finite_subcover U hUo hUc
  -- enumerate the finite subcover, and extend to `ℕ`
  let k := t.card
  let c : Fin k → SAdeleRing F := fun j => (t.equivFin.symm j : SAdeleRing F)
  let c' : ℕ → SAdeleRing F := fun m => if hm : m < k then c ⟨m, hm⟩ else 0
  have hcov : ∀ x : Dual F, ∃ m : ℕ, m < k ∧ x ∈ U (c' m) := fun x => by
    obtain ⟨c₀, hc₀, hx⟩ := Set.mem_iUnion₂.1 (ht (Set.mem_univ x))
    refine ⟨t.equivFin ⟨c₀, hc₀⟩, (t.equivFin ⟨c₀, hc₀⟩).2, ?_⟩
    have hc : c' (t.equivFin ⟨c₀, hc₀⟩) = c₀ := by
      simp only [c']
      rw [dif_pos (t.equivFin ⟨c₀, hc₀⟩).2]
      simp [c]
    rw [hc]; exact hx
  -- `P x` is the first index whose translate holds `x`
  let N : Dual F → ℕ := fun x => Nat.find (hcov x)
  have hNk : ∀ x, N x < k := fun x => (Nat.find_spec (hcov x)).1
  have hNx : ∀ x, x ∈ U (c' (N x)) := fun x => (Nat.find_spec (hcov x)).2
  let P : Dual F → Fin k := fun x => ⟨N x, hNk x⟩
  have hcP : ∀ x, c (P x) = c' (N x) := fun x => by
    show c (P x) = (if hm : N x < k then c ⟨N x, hm⟩ else 0)
    rw [dif_pos (hNk x)]
  refine ⟨k, c, P, measurable_to_countable' fun j => ?_, fun x => ?_⟩
  · have hset : P ⁻¹' {j} = U (c' j) ∩ ⋂ m ∈ Finset.range j, (U (c' m))ᶜ := by
      ext y
      simp only [Set.mem_preimage, Set.mem_singleton_iff, Set.mem_inter_iff, Set.mem_iInter, Set.mem_compl_iff,
        Finset.mem_range]
      constructor
      · intro h
        have hNy : N y = j := congrArg Fin.val h
        refine ⟨hNy ▸ hNx y, fun m hm hmy => ?_⟩
        exact Nat.find_min (hcov y) (hNy ▸ hm : m < N y) ⟨hm.trans j.2, hmy⟩
      · rintro ⟨h1, h2⟩
        refine Fin.ext (le_antisymm (Nat.find_min' (hcov y) ⟨j.2, h1⟩) (not_lt.1 fun hlt => h2 _ hlt (hNx y)))
    rw [hset]
    exact (hUo _).measurableSet.inter
      (MeasurableSet.biInter (Finset.range j).countable_toSet fun m _ => (hUo _).measurableSet.compl)
  · obtain ⟨_, ⟨q, hq, rfl⟩, hxq⟩ := hNx x
    exact ⟨q, hq, by rw [hcP]; exact hxq.symm⟩

/-- **The orbit step**: a lattice point `y′` with `ι y′ = ι(u)·a′ − b`, `a′, b ∈ Q(2ε)`, is `0` (the gap of Lemma PF:
its archimedean sizes are `≤ 2ε(1 + v u)`, its split sizes `≤ max(1, |u|_w)`). -/
private theorem orbit_step {C : ℝ} (hC : D.IsGap C) {u : unitVectors F} {ε : ℝ}
    (hεC : (∏ v : InfinitePlace (fieldI F), (2 * ε * (1 + v (unitL u))) ^ v.mult) * splitHeight (unitL u) < C)
    {a b : SAdeleRing F} (ha : a ∈ box F (2 * ε)) (hb : b ∈ box F (2 * ε)) {y : fieldI F} (hy : y ∈ D.Λ)
    (he : toSAdele F y = toSAdele F (unitL u) * a - b) : y = 0 := by
  obtain ⟨T, hT⟩ := exists_finset_absAt_le_one (unitL u)
  have harch : ∀ v : InfinitePlace (fieldI F), v y ≤ 2 * ε * (1 + v (unitL u)) := fun v => by
    have h := size_add_le (WPlace.arch v) (toSAdele F (unitL u) * a) (-b)
    rw [size_neg, size_toSAdele_mul, ← sub_eq_add_neg, ← he, size_toSAdele] at h
    have h1 : (WPlace.arch v).size a < 2 * ε := ha.1 v
    have h2 : (WPlace.arch v).size b < 2 * ε := hb.1 v
    have h0 : 0 ≤ (WPlace.arch v).absAt (unitL u) := absAt_nonneg _ _
    have h3 := mul_le_mul_of_nonneg_left h1.le h0
    have hle : (WPlace.arch v).absAt y ≤ 2 * ε * (1 + (WPlace.arch v).absAt (unitL u)) := by linarith
    exact hle
  have hsplit : ∀ w : SplitPlace F,
      (WPlace.split w).absAt y ≤ max 1 ((WPlace.split w).absAt (unitL u)) := fun w => by
    have h := size_add_le_max w (toSAdele F (unitL u) * a) (-b)
    rw [size_neg, size_toSAdele_mul, ← sub_eq_add_neg, ← he, size_toSAdele] at h
    have h1 : (WPlace.split w).size a ≤ 1 := (size_le_one_iff w a).2 (ha.2 w)
    have h2 : (WPlace.split w).size b ≤ 1 := (size_le_one_iff w b).2 (hb.2 w)
    refine h.trans (max_le ?_ (h2.trans (le_max_left _ _)))
    exact (mul_le_of_le_one_right (absAt_nonneg _ _) h1).trans (le_max_right _ _)
  refine hC y hy T (fun w hw => (hsplit w).trans (max_le le_rfl (hT w hw))) ?_
  calc (∏ v : InfinitePlace (fieldI F), v y ^ v.mult) * ∏ w ∈ T, (WPlace.split w).absAt y
      ≤ (∏ v : InfinitePlace (fieldI F), (2 * ε * (1 + v (unitL u))) ^ v.mult) *
          ∏ w ∈ T, max 1 ((WPlace.split w).absAt (unitL u)) :=
        mul_le_mul
          (Finset.prod_le_prod (fun v _ => pow_nonneg (apply_nonneg v y) _) fun v _ =>
            pow_le_pow_left₀ (apply_nonneg v y) (harch v) _)
          (Finset.prod_le_prod (fun w _ => absAt_nonneg _ _) fun w _ => hsplit w)
          (Finset.prod_nonneg fun w _ => absAt_nonneg _ _)
          (Finset.prod_nonneg fun v _ => pow_nonneg ((apply_nonneg v y).trans (harch v)) _)
    _ = (∏ v : InfinitePlace (fieldI F), (2 * ε * (1 + v (unitL u))) ^ v.mult) * splitHeight (unitL u) := by
        rw [splitHeight_eq_prod _ T hT]
    _ < C := hεC

/-- **(ii) Local injectivity** (X01D ll. 231–236): two points with one name of length `n ≥ 1` differ, from every lift of the
first, by a point `a` whose first `n` images under `u` all lie in `Q(2ε)`. The induction on `i < n − 1`: if `u^i a ∈ Q(2ε)`,
the common cell at time `i + 1` gives `b ∈ Q(2ε)` with `y′ := u·u^i a − b ∈ Λ`, of archimedean modulus `< 2ε(1 + v u)` and
split size `≤ max(1, |u|_w)`; by the choice of `ε` and the gap, `y′ = 0`. -/
theorem exists_orbit_box {C : ℝ} (hC : D.IsGap C) {u : unitVectors F} {ε : ℝ}
    (hεC : (∏ v : InfinitePlace (fieldI F), (2 * ε * (1 + v (unitL u))) ^ v.mult) * splitHeight (unitL u) < C)
    {k : ℕ} {c : Fin k → SAdeleRing F} {P : Dual F → Fin k} (hP : ∀ x : Dual F, ∃ q ∈ box F ε, x = D.π (c (P x) + q))
    {n : ℕ} (hn : 0 < n) {x y : Dual F} (hxy : nameOf (rot u) P n x = nameOf (rot u) P n y)
    {xw : SAdeleRing F} (hxw : D.π xw = x) :
    ∃ a ∈ box F (2 * ε), (∀ i < n, toSAdele F (unitL u ^ i) * a ∈ box F (2 * ε)) ∧ y = D.π (xw + a) := by
  -- the labels agree at every time `j < n`
  have hlab : ∀ j < n, P ((rot u)^[j] x) = P ((rot u)^[j] y) := fun j hj => by
    have := congrFun hxy ⟨j, hj⟩
    simpa only [nameOf_apply] using this
  -- time `0`: `x = π(c₀ + q₁)`, `y = π(c₀ + q₂)`, and the lift `xw = c₀ + q₁ + ι l`
  obtain ⟨q₁, hq₁, hx⟩ := hP x
  obtain ⟨q₂, hq₂, hy⟩ := hP y
  have h0 := hlab 0 hn
  simp only [Function.iterate_zero, id] at h0
  rw [← h0] at hy
  obtain ⟨l, hl, hxl⟩ := (D.π_eq_π_iff xw (c (P x) + q₁)).1 (hxw.trans hx)
  have hya : y = D.π (xw + (q₂ - q₁)) := by
    rw [hy, hxl, show c (P x) + q₁ + toSAdele F l + (q₂ - q₁) = (c (P x) + q₂) + toSAdele F l by abel,
      AddChar.map_add_eq_mul D.π (c (P x) + q₂) (toSAdele F l), (D.mem_Λ).1 hl, mul_one]
  refine ⟨q₂ - q₁, sub_mem_box hq₁ hq₂, fun i => ?_, hya⟩
  -- the orbit, by induction on `i`: each step is closed by the gap (`orbit_step`)
  induction i with
  | zero =>
    intro _
    rw [pow_zero, map_one, one_mul]
    exact sub_mem_box hq₁ hq₂
  | succ i ih =>
    intro hi
    have hai := ih (by omega)
    obtain ⟨r₁, hr₁, hX⟩ := hP ((rot u)^[i + 1] x)
    obtain ⟨r₂, hr₂, hY⟩ := hP ((rot u)^[i + 1] y)
    rw [← hlab (i + 1) hi] at hY
    have hX' : D.π (toSAdele F (unitL u ^ (i + 1)) * xw) = D.π (c (P ((rot u)^[i + 1] x)) + r₁) := by
      rw [← D.iterate_rot_π, hxw]; exact hX
    have hY' : D.π (toSAdele F (unitL u ^ (i + 1)) * (xw + (q₂ - q₁))) =
        D.π (c (P ((rot u)^[i + 1] x)) + r₂) := by
      rw [← D.iterate_rot_π, ← hya]; exact hY
    obtain ⟨l₁, hl₁, e1⟩ := (D.π_eq_π_iff _ _).1 hX'
    obtain ⟨l₂, hl₂, e2⟩ := (D.π_eq_π_iff _ _).1 hY'
    have he : toSAdele F (l₂ - l₁) =
        toSAdele F (unitL u) * (toSAdele F (unitL u ^ i) * (q₂ - q₁)) - (r₂ - r₁) := by
      rw [map_sub, ← mul_assoc, ← map_mul, ← pow_succ']
      linear_combination e1 - e2
    have hl0 := D.orbit_step hC hεC hai (sub_mem_box hr₁ hr₂) (D.Λ.sub_mem hl₂ hl₁) he
    rw [hl0, map_zero, eq_comm, sub_eq_zero, ← mul_assoc, ← map_mul, ← pow_succ'] at he
    rw [he]
    exact sub_mem_box hr₁ hr₂

/-- **Bowen atoms are thin at an expanding place** (X01D l. 236): the name cell of `x` lies in
`π(x̃ + Q_p(2ε, max(2ε, 1)·|u|_p^{−(n−1)}))`, for every lift `x̃`. From `exists_orbit_box` and `size_toSAdele_mul`. -/
theorem nameCell_subset {C : ℝ} (hC : D.IsGap C) {u : unitVectors F} {p : WPlace F} (hp : 1 < p.absAt (unitL u))
    {ε : ℝ}
    (hεC : (∏ v : InfinitePlace (fieldI F), (2 * ε * (1 + v (unitL u))) ^ v.mult) * splitHeight (unitL u) < C)
    {k : ℕ} {c : Fin k → SAdeleRing F} {P : Dual F → Fin k} (hP : ∀ x : Dual F, ∃ q ∈ box F ε, x = D.π (c (P x) + q))
    {n : ℕ} (hn : 0 < n) {x : Dual F} {xw : SAdeleRing F} (hxw : D.π xw = x) :
    nameCell (rot u) P n (nameOf (rot u) P n x) ⊆
      D.π '' ((xw + ·) '' thinBox p (2 * ε) (max (2 * ε) 1 * (p.absAt (unitL u))⁻¹ ^ (n - 1))) := by
  intro z hz
  obtain ⟨a, ha, horb, hza⟩ := D.exists_orbit_box hC hεC hP hn (mem_nameCell_iff_nameOf.1 hz).symm hxw
  have hs : 0 < p.absAt (unitL u) := one_pos.trans hp
  -- at time `n − 1`: `|u|_p^{n−1}·|a|_p ≤ max(2ε, 1)`
  have h1 := size_le_of_mem_box (horb (n - 1) (by omega)) p
  rw [size_toSAdele_mul, absAt_pow] at h1
  have hsn : 0 < p.absAt (unitL u) ^ (n - 1) := pow_pos hs _
  have hthin : p.size a ≤ max (2 * ε) 1 * (p.absAt (unitL u))⁻¹ ^ (n - 1) := by
    rw [inv_pow, ← div_eq_mul_inv, le_div_iff₀ hsn, mul_comm]
    exact h1
  exact ⟨xw + a, ⟨a, ⟨ha, hthin⟩, rfl⟩, hza.symm⟩

end TateModel

omit [NumberField F] in
/-- **(iii′) Zero entropy gives heavy names** (EN2-L31, part (iii′)): EN2-ZE at `T = rot u`, which preserves `μ`, and the
rate of the partition `P` is at most the entropy (`partitionEntropy_le_ksEntropy`), which is `0`. -/
theorem exists_heavy_nameCells (μ : Measure (Dual F)) [IsProbabilityMeasure μ] (hμ : RotInv F μ) {u : unitVectors F}
    (h0 : ksEntropy μ (rot u) = 0) {k : ℕ} {P : Dual F → Fin k} (hP : Measurable P) {β η : ℝ} (hβ : 0 < β)
    (hη : 0 < η) :
    ∃ (N₀ : ℕ) (X' : Set (Dual F)), MeasurableSet X' ∧ 1 - η ≤ μ.real X' ∧
      ∀ x ∈ X', ∀ n : ℕ, N₀ ≤ n → Real.exp (-(β * n)) ≤ μ.real (nameCell (rot u) P n (nameOf (rot u) P n x)) := by
  have hT : MeasurePreserving (rot u) μ μ := ⟨measurable_rot u, hμ u⟩
  have hP0 : partitionEntropy μ (rot u) P = 0 :=
    le_antisymm ((partitionEntropy_le_ksEntropy μ (rot u) hP).trans h0.le) zero_le
  exact exists_forall_exp_le_measureReal_nameCell μ hT hP hP0 hβ hη

/-- **(iv) The scales** (X01D ll. 239–241): for `s > 1`, `c > 0`, `β > 0` and every `N₀`, there is `δ₀ > 0` such that each
`0 < δ ≤ δ₀` has a length `n ≥ N₀`, `n ≥ 1`, with `c·s^{−(n−1)} ≤ δ` and `δ^β ≤ e^{−(β log s / 2)·n}` — the least such `n`
(EN2-L31 (iv) with `β₁ = β log s / 2`). -/
theorem exists_delta_of_one_lt {s c β : ℝ} (hs : 1 < s) (hc : 0 < c) (hβ : 0 < β) (N₀ : ℕ) :
    ∃ δ₀ : ℝ, 0 < δ₀ ∧ ∀ δ : ℝ, 0 < δ → δ ≤ δ₀ → ∃ n : ℕ, N₀ ≤ n ∧ 0 < n ∧
      c * s⁻¹ ^ (n - 1) ≤ δ ∧ δ ^ β ≤ Real.exp (-(β * Real.log s / 2 * n)) := by
  have hs0 : 0 < s := one_pos.trans hs
  have hL0 : 0 < Real.log s := Real.log_pos hs
  set L := Real.log s with hL
  -- `δ₀ := c·e^{−KL}` forces the least length `n` past `N₀` and past `2 log c / L + 3`
  set K : ℝ := max (N₀ : ℝ) (2 * Real.log c / L + 3) with hK
  have hK0 : 0 ≤ K := (Nat.cast_nonneg N₀).trans (le_max_left _ _)
  refine ⟨c * Real.exp (-(K * L)), by positivity, fun δ hδ hδ₀ => ?_⟩
  have hcδ : 0 < c / δ := div_pos hc hδ
  set y := Real.log (c / δ) / L with hy
  have hyL : y * L = Real.log (c / δ) := div_mul_cancel₀ _ hL0.ne'
  have hKy : K ≤ y := by
    have h1 : Real.exp (K * L) ≤ c / δ := by
      rw [le_div_iff₀ hδ]
      calc Real.exp (K * L) * δ ≤ Real.exp (K * L) * (c * Real.exp (-(K * L))) :=
            mul_le_mul_of_nonneg_left hδ₀ (Real.exp_pos _).le
        _ = c := by rw [mul_left_comm, ← Real.exp_add, add_neg_cancel, Real.exp_zero, mul_one]
    have h2 : K * L ≤ Real.log (c / δ) := (Real.le_log_iff_exp_le hcδ).2 h1
    rw [hy, le_div_iff₀ hL0]
    exact h2
  -- `n := ⌈log(c/δ)/L⌉ + 1`
  have hm1 : y ≤ (⌈y⌉₊ : ℝ) := Nat.le_ceil y
  have hm2 : (⌈y⌉₊ : ℝ) < y + 1 := Nat.ceil_lt_add_one (hK0.trans hKy)
  refine ⟨⌈y⌉₊ + 1, ?_, Nat.succ_pos _, ?_, ?_⟩
  · have h1 : (N₀ : ℝ) ≤ ⌈y⌉₊ := (le_max_left _ _).trans (hKy.trans hm1)
    have h2 : N₀ ≤ ⌈y⌉₊ := by exact_mod_cast h1
    omega
  · rw [Nat.add_sub_cancel]
    have hsm : s⁻¹ ^ ⌈y⌉₊ = Real.exp (-((⌈y⌉₊ : ℝ) * L)) := by
      rw [show -((⌈y⌉₊ : ℝ) * L) = (⌈y⌉₊ : ℝ) * (-L) by ring, Real.exp_nat_mul, Real.exp_neg, hL,
        Real.exp_log hs0]
    have hexp : Real.exp (-((⌈y⌉₊ : ℝ) * L)) ≤ Real.exp (-(y * L)) :=
      Real.exp_le_exp.2 (neg_le_neg (mul_le_mul_of_nonneg_right hm1 hL0.le))
    have hyδ : Real.exp (-(y * L)) = δ / c := by
      rw [hyL, Real.exp_neg, Real.exp_log hcδ, inv_div]
    rw [hsm]
    calc c * Real.exp (-((⌈y⌉₊ : ℝ) * L)) ≤ c * (δ / c) := mul_le_mul_of_nonneg_left (hexp.trans hyδ.le) hc.le
      _ = δ := mul_div_cancel₀ δ hc.ne'
  · have hlogdiv : Real.log (c / δ) = Real.log c - Real.log δ := Real.log_div hc.ne' hδ.ne'
    have hmK : 2 * Real.log c / L + 3 ≤ (⌈y⌉₊ : ℝ) := (le_max_right _ _).trans (hKy.trans hm1)
    have hm3 : 2 * Real.log c ≤ ((⌈y⌉₊ : ℝ) - 3) * L := by
      have h1 : 2 * Real.log c / L ≤ (⌈y⌉₊ : ℝ) - 3 := by linarith
      exact (div_le_iff₀ hL0).1 h1
    have hlt : ((⌈y⌉₊ : ℝ) - 1) * L < y * L := mul_lt_mul_of_pos_right (by linarith) hL0
    have hlog : Real.log δ ≤ -(L / 2 * ((⌈y⌉₊ : ℝ) + 1)) := by linarith
    rw [Real.rpow_def_of_pos hδ]
    refine Real.exp_le_exp.2 ?_
    have h4 := mul_le_mul_of_nonneg_left hlog hβ.le
    push_cast
    linarith

/-- **Lemma 3.1′: zero entropy makes thin boxes heavy** (X01D ll. 226–241; EN2-L31, word for word, at a probability measure
and with any gap `C` for `1/C_Λ`). Route: (i) gives `P`; (iii′) at `β₁ := β log s / 2` and `η/2` gives `N₀` and `X′`; (iv)
gives `δ₀`; for `δ ≤ δ₀` and its `n`, the name cell of `x` lies in the image of the thin box at `c·s^{−(n−1)} ≤ δ`
(`nameCell_subset`, `thinBox_mono`), so its mass `≥ e^{−β₁ n} ≥ δ^β`. -/
theorem TateModel.thinBox_heavy (D : TateModel F) (μ : Measure (Dual F)) [IsProbabilityMeasure μ] (hμ : RotInv F μ)
    {u : unitVectors F} (h0 : ksEntropy μ (rot u) = 0) {p : WPlace F} (hp : 1 < p.absAt (unitL u))
    {C : ℝ} (hC : D.IsGap C) {ε : ℝ} (hε : 0 < ε)
    (hεC : (∏ v : InfinitePlace (fieldI F), (2 * ε * (1 + v (unitL u))) ^ v.mult) * splitHeight (unitL u) < C)
    {β η : ℝ} (hβ : 0 < β) (hη : 0 < η) :
    ∃ δ₀ : ℝ, 0 < δ₀ ∧ ∃ X' : Set (Dual F), MeasurableSet X' ∧ 1 - η < μ.real X' ∧
      ∀ x ∈ X', ∀ xw : SAdeleRing F, D.π xw = x → ∀ δ : ℝ, 0 < δ → δ ≤ δ₀ →
        δ ^ β ≤ μ.real (D.π '' ((xw + ·) '' thinBox p (2 * ε) δ)) := by
  -- (i) the partition
  obtain ⟨k, c, P, hPm, hP⟩ := D.exists_box_partition hε
  have hL0 : 0 < Real.log (p.absAt (unitL u)) := Real.log_pos hp
  have hβ₁ : 0 < β * Real.log (p.absAt (unitL u)) / 2 := by positivity
  -- (iii′) heavy names at the rate `β₁ = β log s / 2`, on `X′` of measure `≥ 1 − η/2`
  obtain ⟨N₀, X', hX'm, hX', hheavy⟩ := exists_heavy_nameCells μ hμ h0 hPm hβ₁ (half_pos hη)
  -- (iv) the scales
  obtain ⟨δ₀, hδ₀, hδ⟩ := exists_delta_of_one_lt hp (lt_of_lt_of_le one_pos (le_max_right (2 * ε) 1)) hβ N₀
  refine ⟨δ₀, hδ₀, X', hX'm, by linarith, fun x hx xw hxw δ hδpos hδle => ?_⟩
  obtain ⟨n, hn, hn0, hcn, hδn⟩ := hδ δ hδpos hδle
  -- (ii) the name cell lies in the image of the thin box at `max(2ε,1)·s^{−(n−1)} ≤ δ`
  have hsub := D.nameCell_subset hC hp hεC hP hn0 hxw
  have hmono : D.π '' ((xw + ·) '' thinBox p (2 * ε) (max (2 * ε) 1 * (p.absAt (unitL u))⁻¹ ^ (n - 1))) ⊆
      D.π '' ((xw + ·) '' thinBox p (2 * ε) δ) :=
    Set.image_mono (Set.image_mono (thinBox_mono p (2 * ε) hcn))
  calc δ ^ β ≤ Real.exp (-(β * Real.log (p.absAt (unitL u)) / 2 * n)) := hδn
    _ ≤ μ.real (nameCell (rot u) P n (nameOf (rot u) P n x)) := hheavy x hx n hn
    _ ≤ μ.real (D.π '' ((xw + ·) '' thinBox p (2 * ε) δ)) := measureReal_mono (hsub.trans hmono)

/-- **The choice of `ε`** (X01D l. 226 and l. 274): for every `x ∈ L` and every `C > 0` some `ε > 0` has `16ε ≤ 1` and
`∏_{v|∞}(2ε(1 + v x))^{mult} · splitHeight x < C` — the product tends to `0` with `ε`. -/
theorem exists_eps_lt (x : fieldI F) {C : ℝ} (hC : 0 < C) :
    ∃ ε : ℝ, 0 < ε ∧ 16 * ε ≤ 1 ∧
      (∏ v : InfinitePlace (fieldI F), (2 * ε * (1 + v x)) ^ v.mult) * splitHeight x < C := by
  set Q := ∏ v : InfinitePlace (fieldI F), (1 + v x) ^ v.mult with hQdef
  set H := splitHeight x with hHdef
  have hQ : 0 < Q := Finset.prod_pos fun v _ => pow_pos (by linarith [apply_nonneg v x]) _
  have hH : 0 < H := lt_of_lt_of_le one_pos (one_le_splitHeight x)
  set ε := min (1 / 16) (C / (4 * Q * H)) with hεdef
  have hε : 0 < ε := lt_min (by norm_num) (by positivity)
  have hε16 : 16 * ε ≤ 1 := by
    have := min_le_left (1 / 16 : ℝ) (C / (4 * Q * H)); linarith
  have hεC : ε ≤ C / (4 * Q * H) := min_le_right _ _
  refine ⟨ε, hε, hε16, ?_⟩
  have hn : Module.finrank ℚ (fieldI F) ≠ 0 := Module.finrank_pos.ne'
  have hprod : (∏ v : InfinitePlace (fieldI F), (2 * ε * (1 + v x)) ^ v.mult) =
      (2 * ε) ^ Module.finrank ℚ (fieldI F) * Q := by
    rw [Finset.prod_congr rfl fun v _ => mul_pow (2 * ε) (1 + v x) v.mult, Finset.prod_mul_distrib,
      Finset.prod_pow_eq_pow_sum, InfinitePlace.sum_mult_eq]
  have h2ε : (2 * ε) ^ Module.finrank ℚ (fieldI F) ≤ 2 * ε := pow_le_of_le_one (by positivity) (by linarith) hn
  rw [hprod]
  calc (2 * ε) ^ Module.finrank ℚ (fieldI F) * Q * H ≤ 2 * ε * Q * H := by gcongr
    _ ≤ 2 * (C / (4 * Q * H)) * Q * H := by gcongr
    _ = C / 2 := by field_simp; ring
    _ < C := by linarith

end

end HadwigerNelson.Rigidity
