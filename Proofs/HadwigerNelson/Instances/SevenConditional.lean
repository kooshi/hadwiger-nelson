import Proofs.HadwigerNelson.Chain

/-!
# `χ(K(√7)²) ≥ 5`, conditional on the `8/3` forcer (FS-45 D3)

GPT Astra's eight-copy witness (`plans/ASTRA-2026-09-14-derivation.md` T9). With `w = (−3 + i√7)/4` (`|w| = 1`), the
eight unit vectors `w³, w̄³, −w², −w², −w², −w̄², −w̄², −w̄²` sum to `w³ + w̄³ − 3w² − 3w̄² = 3/8`, so eight copies of a
four-colour forcer at `δ = 8/3`, chained along them, close on the unit edge `0—1`: the plane over `ℚ(√3, √7, √11)` needs
five colours.

**The input is not in the kernel.** `G4` — a unit-distance graph drawn in `ℚ(√3, √11)²` forcing two points `8/3` apart
equal at four colours — is a measurement (M56's 588-vertex core, one solver refusal with no proof log; prior art Jannis
Harder, Polymath16, 2018). Its certificate is a solver run, and none runs before 2026-10-01. So the theorem here is the
implication, and it is proved; the five-level itself waits on `G4`.
-/

namespace HadwigerNelson
namespace SevenConditional

open SimpleGraph Chain SquareClass

/-- **`G₄`**, named: a finite unit-distance graph drawn in `ℚ(√3, √11)²` whose marked points differ by exactly `8/3`
and are forced equal at four colours. Any drawing of Harder's pair reaches the difference `8/3` by a rotation through a
unit of `ℚ(√3, √11)(i)`, so fixing it costs no generality.

`Forces` at four colours cannot hold vacuously here: every graph drawn in `ℚ(√3, √11)²` is four-colourable (Theorem B,
`LEDGER.md` row 57), so a witness is a genuine compulsion, and by the spare-colour lemma (row 45) its forcer is not
three-colourable.

**Not in the kernel**: a measurement of ours, graded [tools] / [measured] — one CaDiCaL refusal with no proof log (`LEDGER.md`
rows 103 and 47) — taken as a hypothesis by `five_le_chromaticNumber_planeOver_seven_of_G4`. -/
def G4 : Prop :=
  ∃ (n : ℕ) (E : List (Fin n × Fin n)) (q : Fin n → ℂ) (a b : Fin n),
    (∀ x y, (edgeGraph n E).Adj x y → dist (q x) (q y) = 1) ∧
    (∀ z, q z ∈ planeOver (fieldOfRadicands {3, 11})) ∧ q b - q a = 8 / 3 ∧ Forces (edgeGraph n E) 4 a b

/-- `w = (−3 + i√7)/4`. -/
noncomputable def w : ℂ := ⟨-(3 / 4), Real.sqrt 7 / 4⟩

/-- The eight multipliers of T9: `w³, w̄³, −w², −w², −w², −w̄², −w̄², −w̄²`. -/
noncomputable def eightUnits : Fin 8 → ℂ :=
  ![w ^ 3, (starRingEnd ℂ) w ^ 3, -w ^ 2, -w ^ 2, -w ^ 2,
    -(starRingEnd ℂ) w ^ 2, -(starRingEnd ℂ) w ^ 2, -(starRingEnd ℂ) w ^ 2]

theorem sqrt7_sq : Real.sqrt 7 * Real.sqrt 7 = 7 := Real.mul_self_sqrt (by norm_num)

theorem norm_w : ‖w‖ = 1 :=
  norm_eq_one_of_sq (by simp only [w]; linear_combination (1 / 16 : ℝ) * sqrt7_sq)

theorem eightUnits_norm (j : Fin 8) : ‖eightUnits j‖ = 1 := by
  fin_cases j <;> simp [eightUnits, norm_w]

/-- `w̄ = −3/2 − w`: the trace of `w` is `−3/2`. -/
theorem conj_w : (starRingEnd ℂ) w = -3 / 2 - w := by
  apply Complex.ext <;> simp [w]
  ring

/-- `w² = −(3/2)w − 1`: `w` is a root of `X² + (3/2)X + 1`. -/
theorem w_sq : w ^ 2 = -3 / 2 * w - 1 := by
  apply Complex.ext <;> simp [w, pow_two]
  · linear_combination (-1 / 16 : ℝ) * sqrt7_sq
  · ring

/-- **T9's identity**: `w³ + w̄³ − 3w² − 3w̄² = 3/8`, from the trace and the minimal polynomial —
the difference is `−(21/2)(w² + (3/2)w + 1)`. -/
theorem sum_eightUnits : ∑ j, eightUnits j = 3 / 8 := by
  rw [Fin.sum_univ_eight]
  simp only [eightUnits, Matrix.cons_val]
  rw [conj_w]
  linear_combination (-21 / 2 : ℂ) * w_sq

/-- `K(√7) = ℚ(√3, √7, √11)`. -/
noncomputable abbrev F7 : Subfield ℝ := fieldOfRadicands {3, 7, 11}

theorem w_mem : w ∈ planeOver F7 :=
  ⟨F7.neg_mem (F7.div_mem (ofNat_mem F7 3) (ofNat_mem F7 4)),
    F7.div_mem (by simpa using sqrt_mem_fieldOfRadicands (D := {3, 7, 11}) (d := 7) (by simp)) (ofNat_mem F7 4)⟩

theorem conj_w_mem : (starRingEnd ℂ) w ∈ planeOver F7 :=
  ⟨by simpa using w_mem.1, by simpa using F7.neg_mem w_mem.2⟩

theorem eightUnits_mem (j : Fin 8) : eightUnits j ∈ planeOver F7 := by
  have hw := w_mem; have hc := conj_w_mem
  fin_cases j <;> simp only [eightUnits, Fin.reduceFinMk, Matrix.cons_val] <;>
    first
    | exact (planeOverSubring F7).pow_mem hw 3
    | exact (planeOverSubring F7).pow_mem hc 3
    | exact (planeOverSubring F7).neg_mem ((planeOverSubring F7).pow_mem hw 2)
    | exact (planeOverSubring F7).neg_mem ((planeOverSubring F7).pow_mem hc 2)

/-- The plane over `ℚ(√3, √11)` lies in the plane over `ℚ(√3, √7, √11)`. -/
theorem planeOver_seam_subset : planeOver (fieldOfRadicands {3, 11}) ⊆ planeOver F7 := fun _ hz =>
  have h : fieldOfRadicands {3, 11} ≤ F7 := fieldOfRadicands_mono (by intro d; simp; omega)
  ⟨h hz.1, h hz.2⟩

/-- **`χ(K(√7)²) ≥ 5`, given `G₄`**: eight chained copies of the `8/3` forcer along `w³, w̄³, −w², −w², −w², −w̄², −w̄²,
−w̄²`, which sum to `3/8`, close on the unit edge `0—1`.

**Conditional, and not vacuous.** `G4` is unproved, not empty: the theorem is the implication, which the kernel checks;
the five-level waits on `G4`'s certificate (a solver run, none before 2026-10-01). The gate's `VACUITY DECLARED:` marker
is withheld on purpose — it asserts that a hypothesis's domain is *provably empty*, which is false of `G4`. -/
theorem five_le_chromaticNumber_planeOver_seven_of_G4 (h : G4) :
    5 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {3, 7, 11}))).chromaticNumber := by
  obtain ⟨n, E, q, a, b, hq, hqF, hδ, hf⟩ := h
  have hsum : (q b - q a) * ∑ j, eightUnits j = 1 := by rw [hδ, sum_eightUnits]; norm_num
  simpa using add_one_le_chromaticNumber_planeOver_of_chain (F := F7) q hq
    (fun z => planeOver_seam_subset (hqF z)) hf eightUnits eightUnits_norm eightUnits_mem hsum

/-! ## Spec -/

-- The identity is not symmetric by accident: swapping one `w³` for `w̄²` (a conjugate-swapped control, as T9's checkers
-- used) changes the sum, so `sum_eightUnits` is about these eight multipliers.
example : w ^ 3 + (starRingEnd ℂ) w ^ 3 - 3 * w ^ 2 - 3 * (starRingEnd ℂ) w ^ 2 = 3 / 8 := by
  rw [conj_w]; linear_combination (-21 / 2 : ℂ) * w_sq

example : w ^ 3 + w ^ 3 - 3 * w ^ 2 - 3 * (starRingEnd ℂ) w ^ 2 ≠ 3 / 8 := by
  have hred : w ^ 3 + w ^ 3 - 3 * w ^ 2 - 3 * (starRingEnd ℂ) w ^ 2 = 5 / 2 * w + 9 / 4 := by
    rw [conj_w]; linear_combination (2 * w - 9) * w_sq
  rw [hred]
  intro h
  have him := congrArg Complex.im h
  simp [w] at him

end SevenConditional
end HadwigerNelson
