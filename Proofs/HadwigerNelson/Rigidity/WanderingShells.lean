import Proofs.HadwigerNelson.Rigidity.GlobalPoint
import Mathlib.Dynamics.Ergodic.Conservative

/-!
# Leaves and wandering shells: EF_F⁺ over the Tate model (FS-131, job FS131-K8B1; module M8b-4; skeleton)

Part 4 of M8b (`plans/FS131-K8B1-zero-entropy-second.md`; X01D §§ 3.7–3.8, `plans/FS100-X01D-derivation.md` ll. 289–308), over
`(D : TateModel F)`, and the composition of parts 2–4: **`zeroEntropyCarried_of_tateModel`**, `ZeroEntropyCarried F` from any
Tate model.

**Read aloud.**

* **Leaves** (X01D § 3.7 (i)): on a leaf `π(ι(t) + W_p)` the lift in `W_p` is unique — `π(ι t + a) = π(ι t′ + a′)` with
  `a, a′ ∈ W_p` forces `a = a′` (`TateModel.eq_of_π_add_eq`: `a − a′ ∈ ι(L) ∩ W_p = 0`).
* **Shells** (X01D § 3.8): for a split prime `w`, `t ∈ L` and `c > 0`, the shell `π(ι t + {a ∈ W_p : |a_w|_w = c})`
  (`TateModel.shell`), Borel (`measurableSet_shell`).
* **Shells wander** (`TateModel.iterate_rot_not_mem_shell`): for a unit vector `g` with `|g|_w < 1`
  (`exists_unitVector_absAt_lt_one`), no point of a shell returns to it under `(rot g)^m`, `m ≥ 1`:
  `(rot g)^m π(ι t + a) = π(ι(g^m t) + g^m a)` with `g^m a ∈ W_p` and `|g^m a|_w = |g|_w^m c ≠ c`, and the lift is unique.
  So **a finite `μ` invariant under `rot g` gives every shell measure `0`** (`measure_shell_eq_zero`: a measure-preserving map of
  a finite measure is conservative, `MeasurePreserving.conservative`).
* **The leaf set is in `T + A` up to shells** (`TateModel.leafSet_subset`): a point `π(ι t + a)`, `a ∈ W_p`, with every split
  component of `a` zero is `π(ι t + (a_∞, 0)) ∈ T + A` (`TateModel.mem_TA`); otherwise some `|a_w|_w = |y|_w > 0` for a `y ∈ L`
  (`exists_absAt_eq_norm`), and it lies in a shell. Countably many shells (`countable_splitPlace`, `countable_fieldI`), each
  null: **`μ` is carried by `T + A`** (`TateModel.measure_compl_TA_eq_zero`).
* **EF_F⁺ over the model** (`zeroEntropyCarried_of_tateModel`): Step 0 (`exists_one_lt_absAt`), the gap (`exists_isGap`), `ε`
  (`exists_eps_lt`), the leaf set carrying `μ` (`measure_leafSet_compl_eq_zero`, parts 2–3), and the shells (part 4).

**The route differs from X01D's § 3.7 (ii)–(iii) and § 3.8, and is shorter.** X01D fixes `t`, takes the stabiliser `U_t` of
finite index (finite `U`-orbits on `L/Λ`, by strong approximation or by `d·O′ ⊆ Λ` and `O′/nO′` finite), pulls `μ` back to
`ν_t` on `W_{v*}` along the Borel isomorphism `φ_t`, and runs the shells for `g^k ∈ U_t` with `g = γ/σ(γ)`, `(γ) = 𝔓_w^h`.
Here the shells are sets of `R̂` indexed by `(t, c)` and **wander** under `rot g` itself — the uniqueness of the lift does
what the stabiliser did — so no finite orbit, no stabiliser, no `ν_t`, no Borel isomorphism and no class number is read; `g`
is any `γ/γ̄` with `γ ∈ 𝔓_w ∖ σ𝔓_w`. **No step reads the scope `NoRamifiedStableDyadic F`**, nor `R = O′`: only
`R ⊆ O′` (`ofUnitRing_mem_stableIntegers`) and the interface.

**Inhabitants.** `zeroEntropyCarried_of_tateModel` is a theorem over `(D : TateModel F)`, inhabited by
`Rigidity.exists_tateModel`; its conclusion's model is `zeroEntropyCarried_model`. The shell lemmas' hypotheses (a finite
invariant measure, `c > 0`, `|g|_w < 1`) are met by the point mass at `1`, any `c > 0`, and `exists_unitVector_absAt_lt_one`.
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField MeasureTheory WPlace

noncomputable section

variable {F : Subfield ℝ} [NumberField F]

namespace TateModel

variable (D : TateModel F)

/-- **The lift on a leaf is unique** (X01D § 3.7 (i)): `ι(L) ∩ W_p = 0`. -/
theorem eq_of_π_add_eq {p : WPlace F} {t t' : fieldI F} {a a' : SAdeleRing F} (ha : a ∈ hyperplane p)
    (ha' : a' ∈ hyperplane p) (h : D.π (toSAdele F t + a) = D.π (toSAdele F t' + a')) : a = a' := by
  sorry

/-- **A shell** (X01D § 3.8): the points `π(ι t + a)` with `a ∈ W_p` and `|a_w|_w = c`. -/
def shell (p : WPlace F) (w : SplitPlace F) (t : fieldI F) (c : ℝ) : Set (Dual F) :=
  D.π '' ((toSAdele F t + ·) '' {a | a ∈ hyperplane p ∧ (WPlace.split w).size a = c})

example (p : WPlace F) (w : SplitPlace F) (t : fieldI F) (c : ℝ) :
    D.shell p w t c = D.π '' ((toSAdele F t + ·) '' {a | a ∈ hyperplane p ∧ (WPlace.split w).size a = c}) := rfl

/-- Shells are Borel: images under `π` of closed sets (`measurableSet_image`). -/
theorem measurableSet_shell (p : WPlace F) (w : SplitPlace F) (t : fieldI F) (c : ℝ) :
    MeasurableSet (D.shell p w t c) := by
  sorry

/-- **Shells wander** under the rotation by a unit vector contracting at `w`: no point of a shell returns to it. -/
theorem iterate_rot_not_mem_shell {p : WPlace F} {w : SplitPlace F} {t : fieldI F} {c : ℝ} (hc : 0 < c)
    {g : unitVectors F} (hg : (WPlace.split w).absAt (unitL g) < 1) {m : ℕ} (hm : m ≠ 0) {χ : Dual F}
    (hχ : χ ∈ D.shell p w t c) : (rot g)^[m] χ ∉ D.shell p w t c := by
  sorry

/-- **Every shell is null** for a finite rotation-invariant measure: `rot g` preserves `μ`, so it is conservative
(`MeasurePreserving.conservative`, `Conservative.exists_mem_iterate_mem`), and a shell has no returning point. -/
theorem measure_shell_eq_zero (μ : Measure (Dual F)) [IsFiniteMeasure μ] (hμ : RotInv F μ) (p : WPlace F)
    (w : SplitPlace F) (t : fieldI F) {c : ℝ} (hc : 0 < c) : μ (D.shell p w t c) = 0 := by
  sorry

end TateModel

/-- **The values of `‖·‖_w` on `L_w ∖ 0` are its values on `L ∖ 0`**: `L` is dense in its completion and the norm is
locally constant off `0` (`UniformSpace.Completion.denseRange_coe`, the ultrametric inequality). -/
theorem exists_absAt_eq_norm (w : SplitPlace F) {z : w.1.adicCompletion (fieldI F)} (hz : z ≠ 0) :
    ∃ y : fieldI F, y ≠ 0 ∧ (WPlace.split w).absAt y = ‖z‖ := by
  sorry

namespace TateModel

variable (D : TateModel F)

/-- **The leaf set lies in `T + A` and the shells** (X01D l. 306): a point `π(ι t + a)`, `a ∈ W_p`, is in `T + A` when every
split component of `a` is `0` (`mem_TA`), and in the shell of `(w, t, |a_w|_w)` when `a_w ≠ 0`. -/
theorem leafSet_subset (p : WPlace F) :
    D.leafSet p ⊆ TA F ∪ ⋃ (w : SplitPlace F) (t : fieldI F) (y : fieldI F) (_ : y ≠ 0),
      D.shell p w t ((WPlace.split w).absAt y) := by
  sorry

/-- **`μ` is carried by `T + A`** (X01D l. 306) once it is carried by a leaf set: the leaf set lies in `T + A` and countably
many null shells (`leafSet_subset`, `measure_shell_eq_zero`, `countable_splitPlace`, `countable_fieldI`). -/
theorem measure_compl_TA_eq_zero (μ : Measure (Dual F)) [IsFiniteMeasure μ] (hμ : RotInv F μ) (p : WPlace F)
    (hY : μ (D.leafSet p)ᶜ = 0) : μ (TA F)ᶜ = 0 := by
  sorry

end TateModel

/-- **EF_F⁺ over a Tate model** (X01D § 3, `plans/FS100-X01D-derivation.md` ll. 189–308; FS100-EFP; EN2-L31 for Lemma 3.1′): a
rotation-invariant probability measure on `R̂` of entropy zero under the rotation by one non-torsion unit vector is carried by
`T + A`. Over the interface alone, for every real number field: **no scope hypothesis** — the composition of parts 2–4. -/
theorem zeroEntropyCarried_of_tateModel (D : TateModel F) : ZeroEntropyCarried F := by
  intro ρ hρ hrot u hu h0
  obtain ⟨p, hp⟩ := exists_one_lt_absAt u hu
  obtain ⟨C, hC0, hC⟩ := D.exists_isGap
  obtain ⟨ε, hε, hε16, hεC⟩ := exists_eps_lt (unitL u) hC0
  exact D.measure_compl_TA_eq_zero ρ hrot p (D.measure_leafSet_compl_eq_zero ρ hrot h0 hp hC0 hC hε hε16 hεC)

end

end HadwigerNelson.Rigidity
