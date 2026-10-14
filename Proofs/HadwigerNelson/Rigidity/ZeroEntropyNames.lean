import Proofs.HadwigerNelson.Rigidity.Entropy
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecificLimits.Basic

/-!
# Names at entropy zero: few words with few bad starts, and no small name cells on a large set (FS-131, job FS131-KN7; skeleton)

**Read aloud, against the derivation** (`plans/FS131-EN2-derivation.md` § 3.5, entries EN2-CNT and EN2-ZE; module M8a
of the chain, `data/fs131/kn3/claims-M8-zero-entropy-carried.md`).

* **EN2-CNT** (`card_words_badStarts_le`): over an alphabet `α` of `a ≥ 1` letters, with `k ≥ 1`, a set `𝒢` of words of
  length `k`, a real `g ≥ 2` with `#𝒢 ≤ g`, `θ ≥ 0` and `n ≥ k`, the words `w` of length `n` with at most `θ n` *bad starts*
  — positions `0 ≤ j ≤ n − k` whose block `w[j, j + k)` is not in `𝒢` (`badStarts`, over `wordBlock`) — number at most
  `(2a)^{θn + k} · g^{2n/k}`. Pure combinatorics; no measure.
* **EN2-ZE** (`exists_forall_exp_le_measureReal_nameCell`): for a probability measure `μ`, a map `T` preserving it, a
  measurable `P : X → Fin a` with `partitionEntropy μ T P = 0` (the infimum form, `inf_{n ≥ 1} H_n / n = 0`, the entry's
  hypothesis word for word), and `β, η > 0`, there are `N₀` and a measurable `X′` with `μ(X′) ≥ 1 − η` such that the cell
  of the name of every `x ∈ X′` through every time `n ≥ N₀` has mass at least `e^{−βn}`. No ergodicity, no limit theorem;
  its one classical input is the maximal ergodic inequality for an indicator (`measure_frequentVisits_le`).

**The name** of `x` through time `n` is `nameOf T P n x`; `nameCell T P n w` is its fibre over `w`
(`mem_nameCell_iff_nameOf`), and the block of a name at `j` is the name of `T^[j] x` (`wordBlock_nameOf`) — the identity
where the dynamics meets the count, the deriver's first place to attack (EN2 § 3.7).

**EN2-ZE's proof, in its children** (EN2 § 3.5 steps 1–6): (2) one block length `k` from `exists_blockEntropy_le_mul`
(`Rigidity/Entropy`, a leaf there), the heavy names of length `k` (`heavyNames`) few by `mul_card_heavyNames_le` and
Markov on the terms of `H_k` (`mul_measureReal_light_le_blockEntropy`); (3) the maximal inequality,
`measure_frequentVisits_le`; (4) off its exceptional set the bad starts of every name are visits to the light points
(`badStarts_nameOf_le_visits`) and EN2-CNT counts them, with the arithmetic in `rpow_mul_exp_le_exp`; (5) the light
cells of few names have small mass (`measureReal_lightCells_le`); (6) a geometric series.

**`measure_frequentVisits_le` is the release's `DukePrimeDegree.excessiveOccupation_measure_bound`**
(`[OAIMath2026]` family 015, `DukePrimeDegree/Dynamics/MaximalOccupation.lean`) with its two definitions unfolded
(`excessiveOccupation T A δ = {x | ∃ n, δ n < visitCount T A n x}`, `visitCount` = this module's `visits`). It is stated
here under a name of this library because lane P's port (`Outside/OAI015Maximal`, on another branch) is not yet joined;
at the join its proof is that theorem, and the statement is not changed (FS131-KN7, § Stage 5).

**Inhabitants.** `card_words_badStarts_le`: the entry's model (`a = 2`, `k = 3`, `𝒢 = {000}`, `g = 2`, `θ = 9/10`,
`n = 13`), its hypotheses checked in an `example`. EN2-ZE: `zeroEntropyNames_model`, the point mass on one point with the
identity and the one-label partition — degenerate; the entry's non-degenerate model is an irrational rotation with the
indicator of an arc, and its counter-model to the conclusion without the hypothesis is the fair-coin shift (both in
words only; neither is in the library).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory Filter

open scoped ENNReal

/-! ## Words, their blocks and their bad starts -/

section Words

variable {α : Type*}

/-- **The block of length `k` of the word `w` at position `j`**: `(w j, w (j + 1), …, w (j + k − 1))`, for `j + k ≤ n`. -/
def wordBlock {n : ℕ} (w : Fin n → α) (k j : ℕ) (h : j + k ≤ n) : Fin k → α :=
  fun i => w ⟨j + i, by omega⟩

/-- **A bad start of `w` for the good blocks `𝒢`**: a position `j` with `j + k ≤ n` whose block of length `k` is not in
`𝒢`. -/
def IsBadStart {n k : ℕ} (𝒢 : Finset (Fin k → α)) (w : Fin n → α) (j : ℕ) : Prop :=
  ∃ h : j + k ≤ n, wordBlock w k j h ∉ 𝒢

/-- Being a bad start is decidable when letters can be compared. -/
instance [DecidableEq α] {n k : ℕ} (𝒢 : Finset (Fin k → α)) (w : Fin n → α) :
    DecidablePred (IsBadStart 𝒢 w) := fun j => by
  unfold IsBadStart
  infer_instance

/-- **The number of bad starts of `w`**: the positions `0 ≤ j ≤ n − k` whose block of length `k` is not in `𝒢`. -/
def badStarts [DecidableEq α] {n k : ℕ} (𝒢 : Finset (Fin k → α)) (w : Fin n → α) : ℕ :=
  ((Finset.range (n + 1)).filter (IsBadStart 𝒢 w)).card

-- Spec: with `𝒢 = {000}` the word `00001` has one bad start (at `j = 2`; the blocks at `0` and `1` are `000`).
#guard badStarts ({![0, 0, 0]} : Finset (Fin 3 → Fin 2)) (![0, 0, 0, 0, 1] : Fin 5 → Fin 2) = 1
-- Spec: a word shorter than the block has no start at all.
#guard badStarts (∅ : Finset (Fin 3 → Fin 2)) (![1, 1] : Fin 2 → Fin 2) = 0
-- Spec: with no good block every start is bad: `n − k + 1` of them.
#guard badStarts (∅ : Finset (Fin 2 → Fin 2)) (![0, 1, 0, 1] : Fin 4 → Fin 2) = 3

/-- **EN2-CNT, the count** (`plans/FS131-EN2-derivation.md` § 3.5, the entry at l. 458; [hand], one mind, checked by
enumeration on 228 cases): over an alphabet of `a ≥ 1` letters, with `k ≥ 1`, a set `𝒢` of words of length `k`, a real
`g ≥ 2` with `#𝒢 ≤ g`, `θ ≥ 0` and `n ≥ k`, at most `(2a)^{θn + k} · g^{2n/k}` words of length `n` have at most `θ n` bad
starts. -/
theorem card_words_badStarts_le [Fintype α] [DecidableEq α] [Nonempty α] {k : ℕ} (hk : 1 ≤ k)
    (𝒢 : Finset (Fin k → α)) {g : ℝ} (hg : 2 ≤ g) (h𝒢 : (𝒢.card : ℝ) ≤ g) {θ : ℝ} (hθ : 0 ≤ θ) {n : ℕ}
    (hn : k ≤ n) :
    (((Finset.univ : Finset (Fin n → α)).filter fun w => (badStarts 𝒢 w : ℝ) ≤ θ * n).card : ℝ) ≤
      (2 * (Fintype.card α : ℝ)) ^ (θ * n + k) * g ^ (2 * n / k : ℝ) := by
  sorry

/-- **A model of the hypotheses of `card_words_badStarts_le`**: the entry's (`a = 2`, `k = 3`, `𝒢 = {000}`, `g = 2`,
`θ = 9/10`, `n = 13`). -/
example : 1 ≤ 3 ∧ (2 : ℝ) ≤ 2 ∧ ((({![0, 0, 0]} : Finset (Fin 3 → Fin 2)).card : ℝ) ≤ 2) ∧ (0 : ℝ) ≤ 9 / 10 ∧ 3 ≤ 13 := by
  refine ⟨by norm_num, le_rfl, ?_, by norm_num, by norm_num⟩
  rw [Finset.card_singleton]
  norm_num

end Words

/-! ## Names along an orbit -/

section Names

variable {X : Type*}

/-- **The name of `x` through time `n`**: its labels along the orbit, `(P x, P (T x), …, P (T^[n − 1] x))`. The cells
`nameCell T P n w` are the fibres of this map. -/
def nameOf {a : ℕ} (T : X → X) (P : X → Fin a) (n : ℕ) (x : X) : Fin n → Fin a :=
  fun j => P (T^[j] x)

@[simp] theorem nameOf_apply {a : ℕ} (T : X → X) (P : X → Fin a) (n : ℕ) (x : X) (j : Fin n) :
    nameOf T P n x j = P (T^[j] x) := rfl

/-- The cell of a word is the fibre of the name over it. -/
theorem mem_nameCell_iff_nameOf {a : ℕ} {T : X → X} {P : X → Fin a} {n : ℕ} {w : Fin n → Fin a} {x : X} :
    x ∈ nameCell T P n w ↔ nameOf T P n x = w := by
  rw [mem_nameCell, funext_iff]
  rfl

/-- Every point lies in the cell of its own name. -/
theorem mem_nameCell_nameOf {a : ℕ} (T : X → X) (P : X → Fin a) (n : ℕ) (x : X) :
    x ∈ nameCell T P n (nameOf T P n x) :=
  mem_nameCell_iff_nameOf.mpr rfl

/-- The name is measurable when the map and the labels are. -/
theorem measurable_nameOf {m : MeasurableSpace X} {a : ℕ} {T : X → X} (hT : Measurable T) {P : X → Fin a}
    (hP : Measurable P) (n : ℕ) : Measurable (nameOf T P n) :=
  measurable_pi_lambda _ fun j => hP.comp (hT.iterate j)

/-- **The block of a name at `j` is the name of `T^[j] x`** — where the orbit meets the count (EN2 § 3.5 step 4). -/
theorem wordBlock_nameOf {a : ℕ} (T : X → X) (P : X → Fin a) {n k j : ℕ} (h : j + k ≤ n) (x : X) :
    wordBlock (nameOf T P n x) k j h = nameOf T P k (T^[j] x) := by
  funext i
  simp only [wordBlock, nameOf_apply]
  rw [add_comm, Function.iterate_add_apply]

/-- **The heavy names of length `n`**: the words whose cell has mass at least `c`. -/
noncomputable def heavyNames {m : MeasurableSpace X} (μ : Measure X) {a : ℕ} (T : X → X) (P : X → Fin a) (n : ℕ)
    (c : ℝ) : Finset (Fin n → Fin a) := by
  classical
  exact Finset.univ.filter fun w => c ≤ μ.real (nameCell T P n w)

theorem mem_heavyNames {m : MeasurableSpace X} {μ : Measure X} {a : ℕ} {T : X → X} {P : X → Fin a} {n : ℕ} {c : ℝ}
    {w : Fin n → Fin a} : w ∈ heavyNames μ T P n c ↔ c ≤ μ.real (nameCell T P n w) := by
  classical
  simp [heavyNames]

/-- **Few heavy names** (EN2 § 3.5 step 2, `#𝒢 ≤ e^{γk}`): the cells are disjoint and measurable, so at most `1/c` of them
have mass `≥ c`. -/
theorem mul_card_heavyNames_le {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ] {T : X → X}
    (hT : Measurable T) {a : ℕ} {P : X → Fin a} (hP : Measurable P) (n : ℕ) {c : ℝ} (hc : 0 < c) :
    c * (heavyNames μ T P n c).card ≤ 1 := by
  sorry

/-- **Markov on the terms of `H_n`** (EN2 § 3.5 step 2, `H_k ≥ γk · μ(B)`): the points whose name's cell is lighter than
`e^{−γn}` have mass at most `H_n / (γ n)`. Each light cell's term `−p log p` is at least `γ n · p`, and every term is
non-negative. -/
theorem mul_measureReal_light_le_blockEntropy {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ]
    {T : X → X} (hT : Measurable T) {a : ℕ} {P : X → Fin a} (hP : Measurable P) (n : ℕ) {γ : ℝ} (hγ : 0 ≤ γ) :
    γ * n * μ.real {x | nameOf T P n x ∉ heavyNames μ T P n (Real.exp (-(γ * n)))} ≤ blockEntropy μ T P n := by
  sorry

/-- **The visits of the orbit of `x` to `B` before time `n`**: the number of `0 ≤ j < n` with `T^[j] x ∈ B` (the
release's `visitCount`, `PrimePackets/InverseEntropy.lean` l. 247, with the same decidability instance). -/
noncomputable def visits (T : X → X) (B : Set X) (n : ℕ) (x : X) : ℕ := by
  classical
  exact ((Finset.range n).filter fun j => T^[j] x ∈ B).card

/-- **The maximal ergodic inequality for an indicator** (Hopf; EN2 § 3.5 step 3, `θ μ(E) ≤ μ(B)`): the points whose orbit
visits `B` more than `θ n` times before some time `n` have mass at most `μ(B)/θ`. **The release's
`DukePrimeDegree.excessiveOccupation_measure_bound`** with its definitions unfolded, stated under this library's name
until lane P's port is joined; its proof is then that theorem (module docstring). -/
theorem measure_frequentVisits_le {m : MeasurableSpace X} (μ : Measure X) [IsFiniteMeasure μ] {T : X → X}
    (hT : MeasurePreserving T μ μ) {B : Set X} (hB : MeasurableSet B) {θ : ℝ} (hθ : 0 < θ) :
    ENNReal.ofReal θ * μ {x | ∃ n : ℕ, θ * n < (visits T B n x : ℝ)} ≤ μ B := by
  sorry

/-- **The bad starts of a name are visits to the light points** (EN2 § 3.5 step 4): with the heavy names of length
`k ≥ 1` as the good blocks, a bad start `j` of the name of `x` is a time `j < n` at which `T^[j] x` has a light name of
length `k` (`wordBlock_nameOf`). -/
theorem badStarts_nameOf_le_visits {m : MeasurableSpace X} (μ : Measure X) {T : X → X} {a : ℕ} {P : X → Fin a}
    {k : ℕ} (hk : 1 ≤ k) (c : ℝ) (n : ℕ) (x : X) :
    badStarts (heavyNames μ T P k c) (nameOf T P n x) ≤
      visits T {y | nameOf T P k y ∉ heavyNames μ T P k c} n x := by
  sorry

/-- **The arithmetic of step 4** (EN2 § 3.5): with `γ = β/8` and `θ log(2a) ≤ β/8`, once `k ≤ θ n` the count's bound
`(2a)^{θn + k} · e^{2γn}` is at most `e^{βn/2}`. A real-variable lemma (`LEAN.md`: one inequality, its own hypotheses). -/
theorem rpow_mul_exp_le_exp {a β θ n k : ℝ} (ha : 1 ≤ a) (hθ : 0 ≤ θ) (hθβ : θ * Real.log (2 * a) ≤ β / 8)
    (hn : 0 ≤ n) (hkn : k ≤ θ * n) :
    (2 * a) ^ (θ * n + k) * Real.exp (2 * (β / 8) * n) ≤ Real.exp (β * n / 2) := by
  sorry

/-- **The light cells of few names are light in total** (EN2 § 3.5 step 5): the points whose name lies in `W` and whose
cell has mass below `c ≥ 0` have mass at most `#W · c`. -/
theorem measureReal_lightCells_le {m : MeasurableSpace X} (μ : Measure X) [IsFiniteMeasure μ] {T : X → X}
    (hT : Measurable T) {a : ℕ} {P : X → Fin a} (hP : Measurable P) (n : ℕ) (W : Finset (Fin n → Fin a)) {c : ℝ}
    (hc : 0 ≤ c) :
    μ.real {x | nameOf T P n x ∈ W ∧ μ.real (nameCell T P n (nameOf T P n x)) < c} ≤ W.card * c := by
  sorry

/-- **EN2-ZE, entropy zero puts no small name cell on a large set** (`plans/FS131-EN2-derivation.md` § 3.5, the entry at
l. 506; [hand], one mind): for a probability measure that `T` preserves and a measurable partition `P` with
`partitionEntropy μ T P = 0` (`inf_{n ≥ 1} H_n / n = 0`), for every `β > 0` and `η > 0` there are `N₀` and a measurable
`X′` with `μ(X′) ≥ 1 − η` such that the cell of the name of each `x ∈ X′` through each time `n ≥ N₀` has mass at least
`e^{−βn}`. In place of Shannon–McMillan–Breiman for Lemma 3.1′ (EN2-L31). -/
theorem exists_forall_exp_le_measureReal_nameCell {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ]
    {T : X → X} (hT : MeasurePreserving T μ μ) {a : ℕ} {P : X → Fin a} (hP : Measurable P)
    (h0 : partitionEntropy μ T P = 0) {β η : ℝ} (hβ : 0 < β) (hη : 0 < η) :
    ∃ (N₀ : ℕ) (X' : Set X), MeasurableSet X' ∧ 1 - η ≤ μ.real X' ∧
      ∀ x ∈ X', ∀ n : ℕ, N₀ ≤ n → Real.exp (-(β * n)) ≤ μ.real (nameCell T P n (nameOf T P n x)) := by
  sorry

/-- **A model of the hypotheses of `exists_forall_exp_le_measureReal_nameCell`**: the point mass on one point, the
identity, the one-label partition — every cell is the whole space, every `H_n` is `0`. Degenerate (one atom); the entry's
model with infinitely many names is an irrational rotation, not in the library. -/
theorem zeroEntropyNames_model :
    IsProbabilityMeasure (Measure.dirac ()) ∧ MeasurePreserving (id : Unit → Unit) (Measure.dirac ()) (Measure.dirac ()) ∧
      Measurable (fun _ : Unit => (0 : Fin 1)) ∧
      partitionEntropy (Measure.dirac ()) (id : Unit → Unit) (fun _ : Unit => (0 : Fin 1)) = 0 := by
  refine ⟨inferInstance, MeasurePreserving.id _, measurable_const, ?_⟩
  have hcell : ∀ (n : ℕ) (w : Fin n → Fin 1),
      nameCell (id : Unit → Unit) (fun _ : Unit => (0 : Fin 1)) n w = Set.univ :=
    fun n w => Set.eq_univ_of_forall fun _ j => Subsingleton.elim _ _
  simp [partitionEntropy, blockEntropy, hcell]

end Names

end HadwigerNelson.Rigidity
