import Proofs.HadwigerNelson.Rigidity.UnitCircle
import Proofs.HadwigerNelson.Rigidity.PositiveEntropy
import Proofs.HadwigerNelson.Rigidity.Duality
import Proofs.HadwigerNelson.Rigidity.DualConnected

/-!
# The pieces `M̂` and Lemma Γ (FS-131, job FS131-KN8; module M6 of `plans/FS131-KN3-chain-plan.md`; skeleton)

**Read aloud, against the informal claim** (FS100-X02D § 2.2, PE-1′, and § 3.1, Lemma Γ). `R̂` is compact, but no subgroup
`Γ ≅ ℤ²` of the unit vectors acts on it totally irreducibly: `R` is not finitely generated over `ℤ[Γ]`. The derivation reads
the printed rigidity theorem on **pieces** instead — the duals `M̂` of the finitely generated `ℤ[Γ]`-submodules `M ⊆ R` with
`ℚM = F(i)` — and passes to `R̂` by restriction `π_M : R̂ → M̂`. This module types:

* **`PieceDual M`**, the dual of a discrete abelian group `M` as the **additive** compact group the declared theorem takes
  (`Additive (AddChar M Circle)`, with the pointwise topology of `Rigidity/DualGroup` and the cylinder σ-algebra; Polish
  and Borel for countable `M`);
* **`toPiece M : Dual F → PieceDual M`**, restriction to `M`;
* for an admissible pair `p` (`Rigidity/UnitCircle`): **`IsPiece p M`** — `M` is generated over `ℤ[Γ]` by a finite set, and
  `R/M` is torsion (`ℚM = ℚR = F(i)`); multiplication by `u^{n₀} w^{n₁}` restricted to `M` (`pieceMul`) and its dual,
  **`pieceAction : ZdAction 2 (PieceDual M)`**, the action of `Γ ≅ ℤ²` on `M̂`;
* **PE-1′** (X02D l. 146): `M̂` is a solenoid (`isSolenoid_pieceDual`), and the action is totally irreducible
  (`isTotallyIrreducible_pieceAction`) and not virtually cyclic (`not_isVirtuallyCyclic_pieceAction`);
* the chain `M₀ ⊆ M₁ ⊆ …` of pieces exhausting `R` (`exists_pieceChain`), and the three steps of Lemma Γ: the image of a
  `Γ`-ergodic measure on each piece is ergodic (`isErgodicOn_map_toPiece`, step 1), the entropy on `R̂` is the supremum of
  the entropies on the pieces (`ksEntropy_rot_eq_iSup`, step 3, over T2 and `ksEntropy_map`), and Haar on a piece kills the
  Fourier coefficients there (`integral_eq_zero_of_isAddHaarMeasure`, step 4);
* **Lemma Γ** (`isHaarFourier_or_ksEntropy_eq_zero`): a `Γ`-ergodic probability on `R̂` is Haar (in Fourier form) or has
  entropy zero under every rotation in `Γ`.

**`[NumberField F]` where finite rank is read** (FS131-KN8's obligation pass): `M̂` is a solenoid only if `M` has finite
rank, and `ℤ[Γ]` has infinite rank when `u`, `w` are transcendental; the full rank of `ℤ[Γ]·1` reads `ℚ[Γ] = ℚ(Γ)`, which
needs `Γ` algebraic; total irreducibility reads Lemma F, which needs finite rank. Every use is at a number field.

**Lemma Γ reads `Rigidity.haar_or_zero_entropy`** (the printed Theorem 1.2, ours to prove from the declared Theorem 1.3) at
each piece, with `[PolishSpace (PieceDual M)]` from `Rigidity.polishSpace_dual`.

**Models.** `PieceDual M` and `toPiece` are defined for every `M`. `IsPiece p` is inhabited by `ℤ[Γ]·1`, the first piece
(`isPiece_closure_one`), given admissibility. The hypothesis of Lemma Γ — a `Γ`-invariant `Γ`-ergodic probability on
`Dual F` — is met by Haar measure (whose ergodicity is not proved here) and, for the entropy side, by the point mass at the
trivial character, which is invariant under every rotation and ergodic since every set has measure `0` or `1`.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs

noncomputable section

/-! ## The dual of a discrete group, additively -/

/-- **The dual of a discrete abelian group as an additive group**, the carrier the declared rigidity theorem takes: the
characters `AddChar M Circle`, written additively, with the pointwise topology and the cylinder σ-algebra. -/
def PieceDual (M : Type*) [AddCommGroup M] : Type _ := Additive (AddChar M Circle)

namespace PieceDual

variable (M : Type*) [AddCommGroup M]

instance : AddCommGroup (PieceDual M) := inferInstanceAs (AddCommGroup (Additive (AddChar M Circle)))

instance : TopologicalSpace (PieceDual M) := inferInstanceAs (TopologicalSpace (Additive (AddChar M Circle)))

instance : IsTopologicalAddGroup (PieceDual M) := inferInstanceAs (IsTopologicalAddGroup (Additive (AddChar M Circle)))

instance : MeasurableSpace (PieceDual M) := inferInstanceAs (MeasurableSpace (AddChar M Circle))

instance [Countable M] : BorelSpace (PieceDual M) := inferInstanceAs (BorelSpace (AddChar M Circle))

instance [Countable M] : PolishSpace (PieceDual M) := inferInstanceAs (PolishSpace (AddChar M Circle))

/-- A character of `M` as a point of `PieceDual M`. -/
def ofChar : AddChar M Circle ≃ PieceDual M := Additive.ofMul

variable {M}

/-- **The dual of an endomorphism**, `χ ↦ χ ∘ φ`, an additive endomorphism of `PieceDual M`. -/
def dualMap (φ : M →+ M) : PieceDual M →+ PieceDual M where
  toFun χ := ofChar M (((ofChar M).symm χ).compAddMonoidHom φ)
  map_zero' := rfl
  map_add' _ _ := rfl

theorem dualMap_apply (φ : M →+ M) (χ : PieceDual M) (x : M) :
    (ofChar M).symm (dualMap φ χ) x = (ofChar M).symm χ (φ x) := rfl

theorem dualMap_id : dualMap (AddMonoidHom.id M) = AddMonoidHom.id (PieceDual M) := rfl

theorem dualMap_comp (φ ψ : M →+ M) : dualMap (φ.comp ψ) = (dualMap ψ).comp (dualMap φ) := rfl

/-- The dual of an endomorphism is continuous (pointwise: `χ ↦ χ (φ x)` is an evaluation). -/
theorem continuous_dualMap (φ : M →+ M) : Continuous (dualMap φ) := by
  sorry

end PieceDual

open PieceDual

variable {F : Subfield ℝ}

/-- **Restriction of a character of `R` to `M`**, `π_M : R̂ → M̂`. -/
def toPiece (M : AddSubgroup (unitRing F)) (χ : Dual F) : PieceDual M :=
  ofChar M (χ.compAddMonoidHom M.subtype)

theorem measurable_toPiece (M : AddSubgroup (unitRing F)) : Measurable (toPiece M) := by
  sorry

/-! ## Pieces of an admissible pair -/

namespace AdmissiblePair

variable (p : AdmissiblePair F)

/-- Multiplication on `R` by the unit vector `u^{n₀} w^{n₁}`. -/
def mulR (n : Fin 2 → ℤ) : unitRing F →+ unitRing F :=
  AddMonoidHom.mulLeft (uvRing (toUnitVector (zpowHom p.u p.w (Multiplicative.ofAdd n))))

end AdmissiblePair

variable (p : AdmissiblePair F)

/-- **A piece** (FS100-X02D § 3, "Setting"): an additive subgroup `M ⊆ R` generated over `ℤ[Γ]` by a finite set, with `R/M`
torsion — equivalently `ℚM = F(i)`, since `ℚR = F(i)`. -/
structure IsPiece (M : AddSubgroup (unitRing F)) : Prop where
  /-- Finitely generated over `ℤ[Γ]`. -/
  fg : ∃ s : Finset (unitRing F), M = AddSubgroup.closure {y | ∃ (n : Fin 2 → ℤ) (x : unitRing F), x ∈ s ∧ y = p.mulR n x}
  /-- `R/M` is torsion. -/
  fullRank : ∀ r : unitRing F, ∃ k : ℕ, 0 < k ∧ k • r ∈ M

variable {p}

/-- A piece is stable under `Γ`: the generating set is. -/
theorem IsPiece.mulR_mem {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) (n : Fin 2 → ℤ) {x : unitRing F}
    (hx : x ∈ M) : p.mulR n x ∈ M := by
  sorry

/-- Multiplication by `u^{n₀} w^{n₁}` on a piece. -/
def pieceMul {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) (n : Fin 2 → ℤ) : M →+ M :=
  AddMonoidHom.codRestrict ((p.mulR n).comp M.subtype) M fun x => hM.mulR_mem n x.2

theorem pieceMul_zero {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) : pieceMul hM 0 = AddMonoidHom.id M := by
  sorry

/-- `ℤ²` acts: multiplication by `u^{(m+n)₀} w^{(m+n)₁}` is the composite, in either order (`R` is commutative). -/
theorem pieceMul_add {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) (m n : Fin 2 → ℤ) :
    pieceMul hM (m + n) = (pieceMul hM n).comp (pieceMul hM m) := by
  sorry

/-- **The action of `Γ ≅ ℤ²` on the piece `M̂`**: `α^n = ` the dual of multiplication by `u^{n₀} w^{n₁}`. -/
def pieceAction {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) : ZdAction 2 (PieceDual M) where
  toFun n := dualMap (pieceMul hM n)
  map_zero' := by rw [pieceMul_zero]; rfl
  map_add' m n := by rw [pieceMul_add, dualMap_comp]
  continuous' n := continuous_dualMap _

/-- **Restriction intertwines the rotations by `Γ` with the action on the piece.** -/
theorem toPiece_rot {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) (n : Fin 2 → ℤ) (χ : Dual F) :
    toPiece M (rot (toUnitVector (zpowHom p.u p.w (Multiplicative.ofAdd n))) χ) = pieceAction hM n (toPiece M χ) := by
  sorry

/-! ## PE-1′: the pieces meet the printed hypotheses (FS100-X02D l. 146) -/

/-- **`M̂` is a solenoid** (PE-1′, first bullet): compact (`Rigidity/DualGroup`), Hausdorff, connected because `M` is
torsion-free (`Rigidity.connectedSpace_dual`), and its dual embeds in `F(i) ≅ ℚⁿ` because the continuous characters of `M̂`
are the evaluations at `M` (`Rigidity.additiveDualDualEquiv`, D1). -/
theorem isSolenoid_pieceDual [NumberField F] {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) : IsSolenoid (PieceDual M) := by
  sorry

/-- **The action on a piece is totally irreducible** (PE-1′, the criterion's (⇐)): for a closed `α_Λ`-invariant subgroup `Y`
of `M̂` put `N := Y^⊥ ⊆ M`, which is `Λ`-stable. If `N = 0`, `Y` is everything
(`Rigidity.eq_top_of_isClosed_of_dualCoannihilator_eq_bot'`, D2's case). If `N ≠ 0` then `ℚN = F(i)` (admissibility at `Λ`),
so `M/N` is finite (Lemma F's consequence), and `Y ⊆ N^⊥` is finite (`Rigidity.finite_dualAnnihilator`). -/
theorem isTotallyIrreducible_pieceAction [NumberField F] {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) :
    (pieceAction hM).IsTotallyIrreducible := by
  sorry

/-- **The action on a piece is not virtually cyclic** (PE-1′, third bullet): `α^m = α^{kn}` on `M̂` forces equal
multipliers on `M ≠ 0`, so a finite-index `Λ ⊆ ℤ²` would lie in the cyclic `ℤn`. -/
theorem not_isVirtuallyCyclic_pieceAction {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) :
    ¬ (pieceAction hM).IsVirtuallyCyclic := by
  sorry

/-! ## The chain of pieces, and the three steps of Lemma Γ -/

/-- **The first piece**, `ℤ[Γ]·1`: generated by `{1}`, and of full rank because `ℚ(Γ) = F(i)` (admissibility at `Λ = ℤ²`). -/
theorem isPiece_closure_one [NumberField F] :
    IsPiece p (AddSubgroup.closure {y | ∃ (n : Fin 2 → ℤ) (x : unitRing F), x ∈ ({1} : Finset (unitRing F)) ∧
      y = p.mulR n x}) := by
  sorry

/-- **A chain of pieces exhausting `R`** (X02D § 3, "Setting"): `M_k` generated over `ℤ[Γ]` by `1, r₁, …, r_k` for an
enumeration of the countable `R`. -/
theorem exists_pieceChain [NumberField F] :
    ∃ M : ℕ → AddSubgroup (unitRing F), Monotone M ∧ ∃ hM : ∀ k, IsPiece p (M k), ∀ r, ∃ k, r ∈ M k := by
  sorry

/-- **Lemma Γ, step 1**: the image on a piece of a `Γ`-invariant `Γ`-ergodic probability is invariant and ergodic for the
action of `ℤ²` (a strictly invariant measurable set of `M̂` pulls back to a `Γ`-invariant set of `R̂`). -/
theorem isErgodicOn_map_toPiece {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) {ρ : Measure (Dual F)}
    [IsProbabilityMeasure ρ] (hρ : ErgodicSMul p.subgroup (Dual F) ρ) :
    (pieceAction hM).IsErgodicOn ⊤ (ρ.map (toPiece M)) := by
  sorry

/-- **Lemma Γ, step 3**: along a chain of pieces exhausting `R`, the entropy of a rotation in `Γ` on `R̂` is the supremum of
the entropies of the action on the pieces — T2 (`Rigidity.ksEntropy_eq_iSup_ksEntropyOn`) for the σ-algebras pulled back
from the pieces, which increase and generate, each read by `Rigidity.ksEntropy_map` through `toPiece_rot`. -/
theorem ksEntropy_rot_eq_iSup {M : ℕ → AddSubgroup (unitRing F)} (hmono : Monotone M) (hM : ∀ k, IsPiece p (M k))
    (hex : ∀ r, ∃ k, r ∈ M k) {ρ : Measure (Dual F)} [IsProbabilityMeasure ρ]
    (hρ : ErgodicSMul p.subgroup (Dual F) ρ) (n : Fin 2 → ℤ) :
    ksEntropy ρ (rot (toUnitVector (zpowHom p.u p.w (Multiplicative.ofAdd n)))) =
      ⨆ k, ksEntropy (ρ.map (toPiece (M k))) (pieceAction (hM k) n) := by
  sorry

/-- **Lemma Γ, step 4**: if the image of `ρ` on a piece is Haar, the Fourier coefficients of `ρ` vanish at every nonzero
`r ∈ M` (a character of `M̂` not `1` at the evaluation `r`, and translation invariance). -/
theorem integral_eq_zero_of_isAddHaarMeasure {M : AddSubgroup (unitRing F)} {ρ : Measure (Dual F)}
    [IsProbabilityMeasure ρ] (hH : (ρ.map (toPiece M)).IsAddHaarMeasure) {r : unitRing F} (hr : r ∈ M) (hr0 : r ≠ 0) :
    ∫ χ, (χ r : ℂ) ∂ρ = 0 := by
  sorry

/-- **Lemma Γ** (FS100-X02D § 3.1, l. 183): "For admissible `Γ` and a `Γ`-invariant, `Γ`-ergodic probability measure `ρ` on
`R̂`: `ρ = m`, or `h_ρ(γ) = 0` for every `γ ∈ Γ`." Here `ρ = m` is `IsHaarFourier ρ` (equivalently `ρ = dualHaar`,
`Rigidity.isHaarFourier_iff`). Route: steps 1–4 above with `Rigidity.haar_or_zero_entropy` at each piece; if some rotation in
`Γ` has positive entropy, the supremum makes it positive on every late piece, where the image is then Haar, and every
coefficient off `0` is computed on a late piece. -/
theorem isHaarFourier_or_ksEntropy_eq_zero [NumberField F] (p : AdmissiblePair F) (ρ : Measure (Dual F))
    [IsProbabilityMeasure ρ] (hρ : ErgodicSMul p.subgroup (Dual F) ρ) :
    IsHaarFourier ρ ∨ ∀ g ∈ p.subgroup, ksEntropy ρ (rot (toUnitVector g)) = 0 := by
  sorry

end

end HadwigerNelson.Rigidity
