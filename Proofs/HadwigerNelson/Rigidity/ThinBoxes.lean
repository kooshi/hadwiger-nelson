import Proofs.HadwigerNelson.Rigidity.PlaceSizes
import Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames

/-!
# Thin boxes are heavy: Lemma 3.1′ over the Tate model (FS-131, job FS131-K8B1; module M8b-2b; skeleton)

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
  sorry

theorem isClosed_closedThinBox (p : WPlace F) (ε δ : ℝ) : IsClosed (closedThinBox p ε δ) := by
  sorry

theorem thinBox_subset_closedThinBox (p : WPlace F) (ε δ : ℝ) : thinBox p ε δ ⊆ closedThinBox p ε δ :=
  fun _ ha => ⟨⟨fun v => (ha.1.1 v).le, ha.1.2⟩, ha.2⟩

theorem thinBox_mono (p : WPlace F) (ε : ℝ) {δ δ' : ℝ} (h : δ ≤ δ') : thinBox p ε δ ⊆ thinBox p ε δ' :=
  fun _ ha => ⟨ha.1, ha.2.trans h⟩

theorem zero_mem_box {ε : ℝ} (hε : 0 < ε) : (0 : SAdeleRing F) ∈ box F ε := by
  sorry

/-- `Q(ε) − Q(ε) ⊆ Q(2ε)` (X01D l. 232: "`a₀ := ỹ − x̃ ∈ Q′ := Q(ε) − Q(ε)`"). -/
theorem sub_mem_box {ε : ℝ} {a b : SAdeleRing F} (ha : a ∈ box F ε) (hb : b ∈ box F ε) : b - a ∈ box F (2 * ε) := by
  sorry

/-- A point of `Q(ε)` has size at most `max ε 1` at every place (`< ε` at an archimedean one, `≤ 1` at a split one). -/
theorem size_le_of_mem_box {ε : ℝ} {a : SAdeleRing F} (ha : a ∈ box F ε) (p : WPlace F) : p.size a ≤ max ε 1 := by
  sorry

namespace TateModel

variable (D : TateModel F)

/-- **`W` is σ-compact**: the countable union of the compact sets `K + ι(x)`, `x ∈ O′` (`exists_isCompact`; `L` countable). -/
theorem sigmaCompactSpace : SigmaCompactSpace (SAdeleRing F) := by
  sorry

/-- **The image of a closed set under `π` is Borel**: σ-compact (`sigmaCompactSpace`, `continuous_π`), and compact sets are
closed in the Hausdorff `R̂`. -/
theorem measurableSet_image {s : Set (SAdeleRing F)} (hs : IsClosed s) : MeasurableSet (D.π '' s) := by
  sorry

/-- The orbit of a lift: `(rot u)^[n] (π a) = π(u^n·a)` (`π_unit_mul`, by induction on `n`). -/
theorem iterate_rot_π (u : unitVectors F) (n : ℕ) (a : SAdeleRing F) :
    (rot u)^[n] (D.π a) = D.π (toSAdele F (unitL u ^ n) * a) := by
  sorry

/-- **(i) The partition** (X01D l. 230): `π(Q(ε))` is open and `R̂` compact, so finitely many translates `π(c_j + Q(ε))`
cover it; `P x` is the first `j` whose translate holds `x`. -/
theorem exists_box_partition {ε : ℝ} (hε : 0 < ε) :
    ∃ (k : ℕ) (c : Fin k → SAdeleRing F) (P : Dual F → Fin k), Measurable P ∧
      ∀ x : Dual F, ∃ q ∈ box F ε, x = D.π (c (P x) + q) := by
  sorry

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
  sorry

/-- **Bowen atoms are thin at an expanding place** (X01D l. 236): the name cell of `x` lies in
`π(x̃ + Q_p(2ε, max(2ε, 1)·|u|_p^{−(n−1)}))`, for every lift `x̃`. From `exists_orbit_box` and `size_toSAdele_mul`. -/
theorem nameCell_subset {C : ℝ} (hC : D.IsGap C) {u : unitVectors F} {p : WPlace F} (hp : 1 < p.absAt (unitL u))
    {ε : ℝ}
    (hεC : (∏ v : InfinitePlace (fieldI F), (2 * ε * (1 + v (unitL u))) ^ v.mult) * splitHeight (unitL u) < C)
    {k : ℕ} {c : Fin k → SAdeleRing F} {P : Dual F → Fin k} (hP : ∀ x : Dual F, ∃ q ∈ box F ε, x = D.π (c (P x) + q))
    {n : ℕ} (hn : 0 < n) {x : Dual F} {xw : SAdeleRing F} (hxw : D.π xw = x) :
    nameCell (rot u) P n (nameOf (rot u) P n x) ⊆
      D.π '' ((xw + ·) '' thinBox p (2 * ε) (max (2 * ε) 1 * (p.absAt (unitL u))⁻¹ ^ (n - 1))) := by
  sorry

end TateModel

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
  sorry

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
  sorry

/-- **The choice of `ε`** (X01D l. 226 and l. 274): for every `x ∈ L` and every `C > 0` some `ε > 0` has `16ε ≤ 1` and
`∏_{v|∞}(2ε(1 + v x))^{mult} · splitHeight x < C` — the product tends to `0` with `ε`. -/
theorem exists_eps_lt (x : fieldI F) {C : ℝ} (hC : 0 < C) :
    ∃ ε : ℝ, 0 < ε ∧ 16 * ε ≤ 1 ∧
      (∏ v : InfinitePlace (fieldI F), (2 * ε * (1 + v x)) ^ v.mult) * splitHeight x < C := by
  sorry

end

end HadwigerNelson.Rigidity
