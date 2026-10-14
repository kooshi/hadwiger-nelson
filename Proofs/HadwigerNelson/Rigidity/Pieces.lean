import Proofs.HadwigerNelson.Rigidity.UnitCircle
import Proofs.HadwigerNelson.Rigidity.PositiveEntropy
import Proofs.HadwigerNelson.Rigidity.Duality
import Proofs.HadwigerNelson.Rigidity.DualConnected
import Mathlib.Algebra.Group.Subgroup.Finsupp

/-!
# The pieces `M̂` and Lemma Γ (FS-131, job FS131-KN8; module M6 of `plans/FS131-KN3-chain-plan.md`)

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
each piece (it takes no `PolishSpace` since FS131-KN9).

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
theorem continuous_dualMap (φ : M →+ M) : Continuous (dualMap φ) :=
  continuous_induced_rng.2 (continuous_pi fun x => continuous_evalChar M (φ x))

/-- The dual of an endomorphism is measurable: each evaluation of `χ ∘ φ` is an evaluation of `χ`. -/
private theorem measurable_dualMap (φ : M →+ M) : Measurable (dualMap φ) :=
  measurable_of_evalChar (G := M) (g := fun χ => (ofChar M).symm (dualMap φ χ)) fun x =>
    measurable_evalChar (G := M) (φ x)

variable (M) in
/-- Translation on `M̂` is measurable (each evaluation of `c + ψ` is a constant times an evaluation of `ψ`): the
`MeasurableAdd` that integration against a Haar measure reads. -/
private theorem measurableAdd : MeasurableAdd (PieceDual M) where
  measurable_const_add c :=
    measurable_of_evalChar (G := M) (g := fun ψ : PieceDual M => (ofChar M).symm (c + ψ)) fun x =>
      (measurable_evalChar (G := M) x).const_mul (((ofChar M).symm c x : Circle) : ℂ)
  measurable_add_const c :=
    measurable_of_evalChar (G := M) (g := fun ψ : PieceDual M => (ofChar M).symm (ψ + c)) fun x =>
      (measurable_evalChar (G := M) x).mul_const (((ofChar M).symm c x : Circle) : ℂ)

end PieceDual

open PieceDual

variable {F : Subfield ℝ}

/-- **Restriction of a character of `R` to `M`**, `π_M : R̂ → M̂`. -/
def toPiece (M : AddSubgroup (unitRing F)) (χ : Dual F) : PieceDual M :=
  ofChar M (χ.compAddMonoidHom M.subtype)

theorem measurable_toPiece (M : AddSubgroup (unitRing F)) : Measurable (toPiece M) :=
  measurable_of_evalChar (G := M) (g := fun χ : Dual F => (ofChar M).symm (toPiece M χ)) fun x =>
    measurable_evalChar (G := unitRing F) (x : unitRing F)

/-- Restriction from a piece to a smaller one. -/
private def restrictPiece {M M' : AddSubgroup (unitRing F)} (h : M ≤ M') (ψ : PieceDual M') : PieceDual M :=
  ofChar M (((ofChar M').symm ψ).compAddMonoidHom (AddSubgroup.inclusion h))

private theorem measurable_restrictPiece {M M' : AddSubgroup (unitRing F)} (h : M ≤ M') :
    Measurable (restrictPiece h) :=
  measurable_of_evalChar (G := M) (g := fun ψ => (ofChar M).symm (restrictPiece h ψ)) fun x =>
    measurable_evalChar (G := M') (AddSubgroup.inclusion h x)

/-- **The σ-algebras pulled back from the pieces increase with the pieces**: restriction to a smaller piece factors
through restriction to a larger one. -/
private theorem comap_toPiece_mono {M M' : AddSubgroup (unitRing F)} (h : M ≤ M') :
    MeasurableSpace.comap (toPiece M) inferInstance ≤ MeasurableSpace.comap (toPiece M') inferInstance := by
  have e : toPiece M = restrictPiece h ∘ toPiece M' := rfl
  rw [e, ← MeasurableSpace.comap_comp]
  exact MeasurableSpace.comap_mono (measurable_restrictPiece h).comap_le

/-- A point of `R` is a point of `F(i)`. -/
private theorem coe_mem_fieldI (r : unitRing F) : (r : ℂ) ∈ fieldI F :=
  UnitRing.unitRingOver_le_planeOverSubring F r.2

/-- The inclusion of a subgroup of `R` into `F(i)`. -/
private def pieceToFieldI (M : AddSubgroup (unitRing F)) : M →+ fieldI F where
  toFun x := ⟨((x : unitRing F) : ℂ), coe_mem_fieldI (x : unitRing F)⟩
  map_zero' := rfl
  map_add' _ _ := rfl

private theorem pieceToFieldI_injective (M : AddSubgroup (unitRing F)) : Function.Injective (pieceToFieldI M) :=
  fun _ _ h => Subtype.ext (Subtype.ext (congrArg (fun z : fieldI F => (z : ℂ)) h))

/-! ## Pieces of an admissible pair -/

namespace AdmissiblePair

variable (p : AdmissiblePair F)

/-- Multiplication on `R` by the unit vector `u^{n₀} w^{n₁}`. -/
def mulR (n : Fin 2 → ℤ) : unitRing F →+ unitRing F :=
  AddMonoidHom.mulLeft (uvRing (toUnitVector (zpowHom p.u p.w (Multiplicative.ofAdd n))))

end AdmissiblePair

private theorem mulR_apply (p : AdmissiblePair F) (n : Fin 2 → ℤ) (x : unitRing F) :
    p.mulR n x = uvRing (toUnitVector (zpowHom p.u p.w (Multiplicative.ofAdd n))) * x := rfl

private theorem mulR_zero_apply (p : AdmissiblePair F) (x : unitRing F) : p.mulR 0 x = x := by
  rw [mulR_apply, ofAdd_zero, map_one, uvRing_toUnitVector_one, one_mul]

private theorem mulR_add_apply (p : AdmissiblePair F) (m n : Fin 2 → ℤ) (x : unitRing F) :
    p.mulR (m + n) x = p.mulR m (p.mulR n x) := by
  rw [mulR_apply, mulR_apply, mulR_apply, ofAdd_add, map_mul, uvRing_toUnitVector_mul, mul_assoc]

/-- `γ_n = u^{n₀} w^{n₁}` as a complex number. -/
private def γC (p : AdmissiblePair F) (n : Fin 2 → ℤ) : ℂ :=
  (((zpowHom p.u p.w (Multiplicative.ofAdd n) : unitCircle F) : Circle) : ℂ)

private theorem γC_add (p : AdmissiblePair F) (m n : Fin 2 → ℤ) : γC p (m + n) = γC p m * γC p n := by
  simp only [γC, ofAdd_add, map_mul, Subgroup.coe_mul, Circle.coe_mul]

private theorem γC_zero (p : AdmissiblePair F) : γC p 0 = 1 := by
  simp only [γC, ofAdd_zero, map_one, OneMemClass.coe_one, Circle.coe_one]

private theorem γC_mem (p : AdmissiblePair F) (n : Fin 2 → ℤ) : γC p n ∈ fieldI F :=
  (zpowHom p.u p.w (Multiplicative.ofAdd n)).2

/-- The image of `γ_n x` in `ℂ`. -/
private theorem coe_mulR (p : AdmissiblePair F) (n : Fin 2 → ℤ) (x : unitRing F) :
    ((p.mulR n x : unitRing F) : ℂ) = γC p n * (x : ℂ) := rfl

/-- An element of `F(i)` is algebraic over `ℚ` (`F(i)` is a number field). -/
private theorem isAlgebraic_of_mem_fieldI [NumberField F] {x : ℂ} (hx : x ∈ fieldI F) : IsAlgebraic ℚ x :=
  ((IsIntegral.of_finite ℚ (⟨x, hx⟩ : fieldI F)).map ((fieldI F).subtype.toRatAlgHom)).isAlgebraic

/-- **Clearing denominators**: a rational combination of points of `S` has a positive integer multiple in the group they
generate. -/
private theorem exists_nat_mul_mem_of_mem_span {S : Set ℂ} {z : ℂ} (hz : z ∈ Submodule.span ℚ S) :
    ∃ k : ℕ, 0 < k ∧ (k : ℂ) * z ∈ AddSubgroup.closure S := by
  induction hz using Submodule.span_induction with
  | mem x hx => exact ⟨1, one_pos, by rw [Nat.cast_one, one_mul]; exact AddSubgroup.subset_closure hx⟩
  | zero => exact ⟨1, one_pos, by rw [mul_zero]; exact AddSubgroup.zero_mem _⟩
  | add x y _ _ hx hy =>
    obtain ⟨a, ha, hax⟩ := hx
    obtain ⟨b, hb, hby⟩ := hy
    refine ⟨a * b, Nat.mul_pos ha hb, ?_⟩
    have e : ((a * b : ℕ) : ℂ) * (x + y) = b • ((a : ℂ) * x) + a • ((b : ℂ) * y) := by
      simp only [nsmul_eq_mul, Nat.cast_mul]
      ring
    rw [e]
    exact AddSubgroup.add_mem _ (AddSubgroup.nsmul_mem _ hax b) (AddSubgroup.nsmul_mem _ hby a)
  | smul q x _ hx =>
    obtain ⟨a, ha, hax⟩ := hx
    refine ⟨a * q.den, Nat.mul_pos ha q.den_pos, ?_⟩
    have hq : (q : ℂ) * (q.den : ℂ) = (q.num : ℂ) := by exact_mod_cast Rat.mul_den_eq_num q
    have e : ((a * q.den : ℕ) : ℂ) * (q • x) = q.num • ((a : ℂ) * x) := by
      rw [Rat.smul_def, zsmul_eq_mul]
      push_cast
      linear_combination ((a : ℂ) * x) * hq
    rw [e]
    exact AddSubgroup.zsmul_mem _ hax _

/-- **`ℚ[Γ_Λ] = ℚ(Γ_Λ) = F(i)`, with denominators cleared** (PE-1′'s full rank, and the criterion's (⇐)): for an admissible
pair and a finite-index `Λ ⊆ ℤ²`, every `z ∈ F(i)` has a positive integer multiple in the additive group generated by the
`γ_n`, `n ∈ Λ`. The `γ_n` are algebraic over `ℚ`, so the field they generate is the algebra they generate, which is the
`ℚ`-span of the monoid they form. -/
private theorem exists_nat_mul_mem_closure [NumberField F] (p : AdmissiblePair F) (Λ : AddSubgroup (Fin 2 → ℤ))
    (hΛ : Λ.FiniteIndex) {z : ℂ} (hz : z ∈ fieldI F) :
    ∃ k : ℕ, 0 < k ∧ (k : ℂ) * z ∈ AddSubgroup.closure (γC p '' Λ) := by
  let Sm : Submonoid ℂ :=
    { carrier := γC p '' Λ
      mul_mem' := by
        rintro _ _ ⟨a, ha, rfl⟩ ⟨b, hb, rfl⟩
        exact ⟨a + b, Λ.add_mem ha hb, γC_add p a b⟩
      one_mem' := ⟨0, Λ.zero_mem, γC_zero p⟩ }
  have hSm : (Sm : Set ℂ) = γC p '' Λ := rfl
  have halg : ∀ x ∈ γC p '' Λ, IsAlgebraic ℚ x := by
    rintro _ ⟨n, -, rfl⟩
    exact isAlgebraic_of_mem_fieldI (γC_mem p n)
  have hgen : Subfield.closure (γC p '' Λ) = fieldI F := p.generates Λ hΛ
  have hz' : z ∈ Subfield.closure (γC p '' Λ) := hgen ▸ hz
  have hle : Subfield.closure (γC p '' Λ) ≤ (IntermediateField.adjoin ℚ (γC p '' Λ)).toSubfield :=
    Subfield.closure_le.mpr (IntermediateField.subset_adjoin ℚ _)
  have h1 : z ∈ (IntermediateField.adjoin ℚ (γC p '' Λ)).toSubalgebra := hle hz'
  rw [IntermediateField.adjoin_toSubalgebra_of_isAlgebraic halg] at h1
  have h2 : z ∈ Subalgebra.toSubmodule (Algebra.adjoin ℚ (γC p '' Λ)) := h1
  rw [Algebra.adjoin_eq_span, ← hSm, Submonoid.closure_eq] at h2
  exact exists_nat_mul_mem_of_mem_span h2

/-- **Lemma F** (FS100-X02D l. 100, at a prime): a group with an injective additive map into the number field `F(i)` has
`G ⧸ qG` finite for a prime `q` — it is an `𝔽_q`-space of dimension at most `[F(i) : ℚ]`, since lifts of an `𝔽_q`-independent
family are `ℤ`-independent (an integer relation reduces to an `𝔽_q`-relation, so `q` divides every coefficient, and by
descent in the torsion-free `F(i)` every coefficient is `0`). -/
private theorem finiteIndex_range_nsmul_prime [NumberField F] {G : Type*} [AddCommGroup G] (ι : G →+ fieldI F)
    (hι : Function.Injective ι) {q : ℕ} (hq : q.Prime) : ((nsmulAddMonoidHom q : G →+ G).range).FiniteIndex := by
  classical
  haveI : Fact q.Prime := ⟨hq⟩
  have hqx : ∀ x : G ⧸ (nsmulAddMonoidHom q : G →+ G).range, q • x = 0 := fun x => by
    obtain ⟨x, rfl⟩ := QuotientAddGroup.mk_surjective x
    rw [← QuotientAddGroup.mk_nsmul, QuotientAddGroup.eq_zero_iff]
    exact ⟨x, rfl⟩
  -- `haveI`, not `letI` (`LEAN.md`, FS131-IN1's line)
  haveI : Module (ZMod q) (G ⧸ (nsmulAddMonoidHom q : G →+ G).range) := AddCommGroup.zmodModule hqx
  have hrank : Module.rank (ZMod q) (G ⧸ (nsmulAddMonoidHom q : G →+ G).range) ≤
      (Module.finrank ℚ (fieldI F) : ℕ) := by
    refine rank_le fun s hli => ?_
    choose r hr using fun x : G ⧸ (nsmulAddMonoidHom q : G →+ G).range => QuotientAddGroup.mk_surjective x
    let v : s → fieldI F := fun i => ι (r i)
    -- `q` divides every coefficient of an integer relation among the lifts
    have hrel : ∀ g : s → ℤ, ∑ i, g i • v i = 0 → ∀ i, (q : ℤ) ∣ g i := by
      intro g hg i
      have h1 : ∑ i : s, g i • r i = 0 := hι (by
        rw [map_sum, map_zero]
        simpa only [v, map_zsmul] using hg)
      have h2 := congrArg (QuotientAddGroup.mk (s := (nsmulAddMonoidHom q : G →+ G).range)) h1
      rw [QuotientAddGroup.mk_sum, QuotientAddGroup.mk_zero] at h2
      have h3 : ∑ i : s, ((g i : ℤ) : ZMod q) • (i : G ⧸ (nsmulAddMonoidHom q : G →+ G).range) = 0 := by
        refine (Finset.sum_congr rfl fun i _ => ?_).trans h2
        rw [Int.cast_smul_eq_zsmul, QuotientAddGroup.mk_zsmul, hr]
      exact (ZMod.intCast_zmod_eq_zero_iff_dvd (g i) q).mp (Fintype.linearIndependent_iff.mp hli _ h3 i)
    -- so `qⁿ` does, for every `n`
    have hpow : ∀ n : ℕ, ∀ g : s → ℤ, ∑ i, g i • v i = 0 → ∀ i, (q : ℤ) ^ n ∣ g i := by
      intro n
      induction n with
      | zero => intro g _ i; simp
      | succ n ih =>
        intro g hg i
        choose g' hg' using hrel g hg
        have hsmul : (q : ℤ) • ∑ i, g' i • v i = 0 := by
          rw [Finset.smul_sum, ← hg]
          exact Finset.sum_congr rfl fun i _ => by rw [hg' i, mul_smul]
        have hg'rel : ∑ i, g' i • v i = 0 :=
          (smul_eq_zero.mp hsmul).resolve_left (by exact_mod_cast hq.ne_zero)
        rw [hg' i, pow_succ']
        exact mul_dvd_mul_left _ (ih g' hg'rel i)
    have hliZ : LinearIndependent ℤ v := by
      rw [Fintype.linearIndependent_iff]
      intro g hg i
      refine Int.eq_zero_of_abs_lt_dvd (hpow (g i).natAbs g hg i) ?_
      rw [← Int.natCast_natAbs]
      exact_mod_cast Nat.lt_pow_self hq.one_lt
    have hcard := ((LinearIndependent.iff_fractionRing ℤ ℚ).mp hliZ).fintype_card_le_finrank
    rwa [Fintype.card_coe] at hcard
  have hlt : Module.rank (ZMod q) (G ⧸ (nsmulAddMonoidHom q : G →+ G).range) < Cardinal.aleph0 :=
    hrank.trans_lt (Cardinal.natCast_lt_aleph0)
  haveI : Module.Finite (ZMod q) (G ⧸ (nsmulAddMonoidHom q : G →+ G).range) := Module.rank_lt_aleph0_iff.mp hlt
  haveI : Finite (G ⧸ (nsmulAddMonoidHom q : G →+ G).range) := Module.finite_of_finite (ZMod q)
  exact ⟨AddSubgroup.index_ne_zero_of_finite⟩

/-- **Lemma F** (FS100-X02D l. 100): a group with an injective additive map into the number field `F(i)` has `G ⧸ mG`
finite for every `m ≠ 0` — at a prime above; at a product `[G : abG] = [bG : abG]·[G : bG]` and `[bG : abG] = [G : aG]`,
multiplication by `b` being injective (`G` is torsion-free). -/
private theorem finiteIndex_range_nsmul [NumberField F] {G : Type*} [AddCommGroup G] (ι : G →+ fieldI F)
    (hι : Function.Injective ι) {m : ℕ} (hm : m ≠ 0) : ((nsmulAddMonoidHom m : G →+ G).range).FiniteIndex := by
  haveI : IsAddTorsionFree (fieldI F) := IsAddTorsionFree.of_isCancelMulZero_charZero
  haveI : IsAddTorsionFree G := Function.Injective.isAddTorsionFree ι hι
  induction m using Nat.recOnMul with
  | zero => exact absurd rfl hm
  | one =>
    have : (nsmulAddMonoidHom 1 : G →+ G).range = ⊤ :=
      eq_top_iff.mpr fun x _ => AddMonoidHom.mem_range.mpr ⟨x, by rw [nsmulAddMonoidHom_apply, one_nsmul]⟩
    rw [this]
    infer_instance
  | prime q hq => exact finiteIndex_range_nsmul_prime ι hι hq
  | mul a b iha ihb =>
    have ha := iha (left_ne_zero_of_mul hm)
    have hb := ihb (right_ne_zero_of_mul hm)
    have hb0 : b ≠ 0 := right_ne_zero_of_mul hm
    have hle : (nsmulAddMonoidHom (a * b) : G →+ G).range ≤ (nsmulAddMonoidHom b : G →+ G).range := by
      intro z hz
      obtain ⟨x, rfl⟩ := AddMonoidHom.mem_range.mp hz
      exact AddMonoidHom.mem_range.mpr ⟨a • x, by
        rw [nsmulAddMonoidHom_apply, nsmulAddMonoidHom_apply, mul_comm, mul_nsmul']⟩
    let φ : G →+ (nsmulAddMonoidHom b : G →+ G).range := (nsmulAddMonoidHom b : G →+ G).rangeRestrict
    have hφ : Function.Surjective φ := AddMonoidHom.rangeRestrict_surjective _
    have hcomap : (((nsmulAddMonoidHom (a * b) : G →+ G).range).addSubgroupOf
        (nsmulAddMonoidHom b : G →+ G).range).comap φ = (nsmulAddMonoidHom a : G →+ G).range := by
      ext x
      rw [AddSubgroup.mem_comap, AddSubgroup.mem_addSubgroupOf, AddMonoidHom.coe_rangeRestrict,
        AddMonoidHom.mem_range, AddMonoidHom.mem_range]
      simp only [nsmulAddMonoidHom_apply]
      constructor
      · rintro ⟨y, hy⟩
        refine ⟨y, nsmul_right_injective hb0 ?_⟩
        simp only
        rw [← hy, mul_comm, mul_nsmul']
      · rintro ⟨y, rfl⟩
        exact ⟨y, by rw [mul_comm, mul_nsmul']⟩
    have hrel : ((nsmulAddMonoidHom (a * b) : G →+ G).range).relIndex (nsmulAddMonoidHom b : G →+ G).range =
        ((nsmulAddMonoidHom a : G →+ G).range).index := by
      rw [AddSubgroup.relIndex, ← hcomap, AddSubgroup.index_comap_of_surjective _ hφ]
    rw [AddSubgroup.finiteIndex_iff, ← AddSubgroup.relIndex_mul_index hle, hrel]
    exact mul_ne_zero (AddSubgroup.finiteIndex_iff.mp ha) (AddSubgroup.finiteIndex_iff.mp hb)

/-- A common multiple: finitely many elements, each with a positive multiple in `H`, have one multiple in common. -/
private theorem exists_common_nsmul_mem {G : Type*} [AddCommGroup G] (H : AddSubgroup G) (t : Finset G)
    (h : ∀ z ∈ t, ∃ k : ℕ, 0 < k ∧ k • z ∈ H) : ∃ m : ℕ, 0 < m ∧ ∀ z ∈ t, m • z ∈ H := by
  classical
  induction t using Finset.induction_on with
  | empty => exact ⟨1, one_pos, fun z hz => absurd hz (Finset.notMem_empty z)⟩
  | insert a t _ ih =>
    obtain ⟨m, hm, hmt⟩ := ih fun z hz => h z (Finset.mem_insert_of_mem hz)
    obtain ⟨k, hk, hka⟩ := h a (Finset.mem_insert_self a t)
    refine ⟨m * k, Nat.mul_pos hm hk, fun z hz => ?_⟩
    rcases Finset.mem_insert.mp hz with rfl | hz
    · rw [mul_nsmul']
      exact H.nsmul_mem hka m
    · rw [mul_comm, mul_nsmul']
      exact H.nsmul_mem (hmt z hz) k

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
  obtain ⟨s, hs⟩ := hM.fg
  rw [hs] at hx ⊢
  have key : AddSubgroup.closure {y | ∃ (n : Fin 2 → ℤ) (x : unitRing F), x ∈ s ∧ y = p.mulR n x} ≤
      (AddSubgroup.closure {y | ∃ (n : Fin 2 → ℤ) (x : unitRing F), x ∈ s ∧ y = p.mulR n x}).comap (p.mulR n) := by
    rw [AddSubgroup.closure_le]
    rintro _ ⟨n', x', hx', rfl⟩
    exact AddSubgroup.subset_closure ⟨n + n', x', hx', (mulR_add_apply p n n' x').symm⟩
  exact key hx

/-- Multiplication by `u^{n₀} w^{n₁}` on a piece. -/
def pieceMul {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) (n : Fin 2 → ℤ) : M →+ M :=
  AddMonoidHom.codRestrict ((p.mulR n).comp M.subtype) M fun x => hM.mulR_mem n x.2

theorem pieceMul_zero {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) : pieceMul hM 0 = AddMonoidHom.id M :=
  AddMonoidHom.ext fun x => Subtype.ext (mulR_zero_apply p x)

/-- `ℤ²` acts: multiplication by `u^{(m+n)₀} w^{(m+n)₁}` is the composite, in either order (`R` is commutative). -/
theorem pieceMul_add {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) (m n : Fin 2 → ℤ) :
    pieceMul hM (m + n) = (pieceMul hM n).comp (pieceMul hM m) := by
  refine AddMonoidHom.ext fun x => Subtype.ext ?_
  show p.mulR (m + n) x = p.mulR n (p.mulR m x)
  rw [add_comm]
  exact mulR_add_apply p n m x

/-- **The action of `Γ ≅ ℤ²` on the piece `M̂`**: `α^n = ` the dual of multiplication by `u^{n₀} w^{n₁}`. -/
def pieceAction {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) : ZdAction 2 (PieceDual M) where
  toFun n := dualMap (pieceMul hM n)
  map_zero' := by rw [pieceMul_zero]; rfl
  map_add' m n := by rw [pieceMul_add, dualMap_comp]
  continuous' n := continuous_dualMap _

/-- **Restriction intertwines the rotations by `Γ` with the action on the piece.** -/
theorem toPiece_rot {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) (n : Fin 2 → ℤ) (χ : Dual F) :
    toPiece M (rot (toUnitVector (zpowHom p.u p.w (Multiplicative.ofAdd n))) χ) = pieceAction hM n (toPiece M χ) :=
  rfl

/-- **A `Γ`-invariant measure is invariant under each rotation `γ_n`.** -/
private theorem map_rot_eq {ρ : Measure (Dual F)} (hρ : ErgodicSMul p.subgroup (Dual F) ρ) (n : Fin 2 → ℤ) :
    ρ.map (rot (toUnitVector (zpowHom p.u p.w (Multiplicative.ofAdd n)))) = ρ := by
  haveI := hρ.toSMulInvariantMeasure
  let g : p.subgroup := ⟨_, (p.mem_subgroup).2 ⟨n, rfl⟩⟩
  ext s hs
  rw [Measure.map_apply (measurable_rot _) hs]
  exact SMulInvariantMeasure.measure_preimage_smul g hs

/-- **A piece is countable**: it is generated by the countable set `{γ_n x : n ∈ ℤ², x ∈ s}`. -/
private theorem countable_of_isPiece {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) : Countable M := by
  obtain ⟨s, hs⟩ := hM.fg
  let f : (Fin 2 → ℤ) × s → unitRing F := fun nx => p.mulR nx.1 nx.2
  have hrange : {y | ∃ (n : Fin 2 → ℤ) (x : unitRing F), x ∈ s ∧ y = p.mulR n x} = Set.range f := by
    ext y
    constructor
    · rintro ⟨n, x, hx, rfl⟩
      exact ⟨(n, ⟨x, hx⟩), rfl⟩
    · rintro ⟨⟨n, x⟩, rfl⟩
      exact ⟨n, x, x.2, rfl⟩
  subst hs
  rw [hrange]
  refine Function.Surjective.countable (f := fun a : ((Fin 2 → ℤ) × s) →₀ ℤ =>
    (⟨a.sum fun i k => k • f i, AddSubgroup.mem_closure_range_iff.mpr ⟨a, rfl⟩⟩ :
      AddSubgroup.closure (Set.range f))) ?_
  rintro ⟨x, hx⟩
  obtain ⟨a, rfl⟩ := AddSubgroup.mem_closure_range_iff.mp hx
  exact ⟨a, rfl⟩

/-- **The entropy on a piece is the entropy on the σ-algebra pulled back from it** (`Rigidity.ksEntropy_map`, through
`toPiece_rot`). -/
private theorem ksEntropy_map_toPiece {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) (n : Fin 2 → ℤ)
    (ρ : Measure (Dual F)) :
    ksEntropy (ρ.map (toPiece M)) (pieceAction hM n) =
      ksEntropyOn (MeasurableSpace.comap (toPiece M) inferInstance) ρ
        (rot (toUnitVector (zpowHom p.u p.w (Multiplicative.ofAdd n)))) :=
  ksEntropy_map ρ (measurable_toPiece M) (measurable_dualMap _) fun χ => toPiece_rot hM n χ

/-! ## PE-1′: the pieces meet the printed hypotheses (FS100-X02D l. 146) -/

/-- **`M̂` is a solenoid** (PE-1′, first bullet): compact (`Rigidity/DualGroup`), Hausdorff, connected because `M` is
torsion-free (`Rigidity.connectedSpace_dual`), and its dual embeds in `F(i) ≅ ℚⁿ` because the continuous characters of `M̂`
are the evaluations at `M` (`Rigidity.additiveDualDualEquiv`, D1). -/
theorem isSolenoid_pieceDual [NumberField F] {M : AddSubgroup (unitRing F)} : IsSolenoid (PieceDual M) := by
  haveI : IsAddTorsionFree (fieldI F) := IsAddTorsionFree.of_isCancelMulZero_charZero
  haveI : IsAddTorsionFree M := Function.Injective.isAddTorsionFree (pieceToFieldI M) (pieceToFieldI_injective M)
  let e := (Module.finBasis ℚ (fieldI F)).equivFun
  let ι : M →+ (Fin (Module.finrank ℚ (fieldI F)) → ℚ) := e.toLinearMap.toAddMonoidHom.comp (pieceToFieldI M)
  have hι : Function.Injective ι := e.injective.comp (pieceToFieldI_injective M)
  have hιm : Function.Injective (AddMonoidHom.toMultiplicative ι) := fun a b h => hι h
  exact
    { isTopologicalAddGroup := inferInstance
      t2Space := inferInstanceAs (T2Space (AddChar M Circle))
      compactSpace := inferInstanceAs (CompactSpace (AddChar M Circle))
      connectedSpace := connectedSpace_dual
      dual_embeds := ⟨_, (AddMonoidHom.toMultiplicative ι).comp (additiveDualDualEquiv M).symm.toMonoidHom,
        hιm.comp (additiveDualDualEquiv M).symm.injective⟩ }

/-- **The action on a piece is totally irreducible** (PE-1′, the criterion's (⇐)): for a closed `α_Λ`-invariant subgroup `Y`
of `M̂` put `N := Y^⊥ ⊆ M`, which is `Λ`-stable. If `N = 0`, `Y` is everything
(`Rigidity.eq_top_of_isClosed_of_dualCoannihilator_eq_bot'`, D2's case). If `N ≠ 0` then `ℚN = F(i)` (admissibility at `Λ`),
so `M/N` is finite (Lemma F's consequence), and `Y ⊆ N^⊥` is finite (`Rigidity.finite_dualAnnihilator`). -/
theorem isTotallyIrreducible_pieceAction [NumberField F] {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) :
    (pieceAction hM).IsTotallyIrreducible := by
  intro Λ hΛ Y hY hinv
  by_cases hN0 : dualCoannihilator (AddSubgroup.toSubgroup' Y) = ⊥
  · exact Or.inr (eq_top_of_isClosed_of_dualCoannihilator_eq_bot' Y hY hN0)
  left
  generalize hNdef : dualCoannihilator (AddSubgroup.toSubgroup' Y) = N at hN0
  -- `N = Y^⊥` is stable under `γ_n`, `n ∈ Λ` (the dual of `α_Λ`-invariance)
  have hstabN : ∀ n ∈ Λ, ∀ w ∈ N, pieceMul hM n w ∈ N := by
    intro n hn w hw
    rw [← hNdef, mem_dualCoannihilator] at hw ⊢
    intro χ hχ
    have hmem : pieceAction hM n (ofChar M χ) ∈ Y := by
      rw [← hinv n hn]
      exact AddSubgroup.mem_map_of_mem _ ((AddSubgroup.mem_toSubgroup' Y χ).mp hχ)
    exact hw ((ofChar M).symm (pieceAction hM n (ofChar M χ))) ((AddSubgroup.mem_toSubgroup' Y _).mpr hmem)
  have memNR : ∀ w : M, (w : unitRing F) ∈ N.map M.subtype ↔ w ∈ N := fun w =>
    AddSubgroup.mem_map_iff_mem (f := M.subtype) Subtype.val_injective
  have hstab : ∀ n ∈ Λ, ∀ z ∈ N.map M.subtype, p.mulR n z ∈ N.map M.subtype := by
    intro n hn z hz
    obtain ⟨w, hw, rfl⟩ := AddSubgroup.mem_map.mp hz
    exact AddSubgroup.mem_map.mpr ⟨pieceMul hM n w, hstabN n hn w hw, rfl⟩
  -- `ℚN = F(i)`: every point of `M` has a positive multiple in `N`
  obtain ⟨⟨y, hyN⟩, hy0⟩ := AddSubgroup.ne_bot_iff_exists_ne_zero.mp hN0
  have hyC : ((y : unitRing F) : ℂ) ≠ 0 := fun h => hy0 (Subtype.ext (Subtype.ext (Subtype.ext h)))
  have hmulN : ∀ a ∈ AddSubgroup.closure (γC p '' Λ), ∃ w ∈ N.map M.subtype, (w : ℂ) = a * ((y : unitRing F) : ℂ) := by
    intro a ha
    induction ha using AddSubgroup.closure_induction with
    | mem x hx =>
      obtain ⟨n, hn, rfl⟩ := hx
      exact ⟨p.mulR n y, hstab n hn _ ((memNR y).mpr hyN), coe_mulR p n y⟩
    | zero => exact ⟨0, (N.map M.subtype).zero_mem, by rw [zero_mul]; rfl⟩
    | add x x' _ _ hx hx' =>
      obtain ⟨w, hw, hwx⟩ := hx
      obtain ⟨w', hw', hwx'⟩ := hx'
      refine ⟨w + w', (N.map M.subtype).add_mem hw hw', ?_⟩
      show (w : ℂ) + (w' : ℂ) = _
      rw [hwx, hwx', add_mul]
    | neg x _ hx =>
      obtain ⟨w, hw, hwx⟩ := hx
      refine ⟨-w, (N.map M.subtype).neg_mem hw, ?_⟩
      show -(w : ℂ) = _
      rw [hwx, neg_mul]
  have htors : ∀ x ∈ M, ∃ k : ℕ, 0 < k ∧ k • x ∈ N.map M.subtype := by
    intro x _
    have hz : (x : ℂ) / ((y : unitRing F) : ℂ) ∈ fieldI F :=
      div_mem (coe_mem_fieldI x) (coe_mem_fieldI (y : unitRing F))
    obtain ⟨k, hk, hkz⟩ := exists_nat_mul_mem_closure p Λ hΛ hz
    obtain ⟨w, hw, hwe⟩ := hmulN _ hkz
    refine ⟨k, hk, ?_⟩
    have hwk : w = k • x := Subtype.ext (by
      rw [hwe, AddSubmonoidClass.coe_nsmul, nsmul_eq_mul, mul_assoc, div_mul_cancel₀ _ hyC])
    rw [← hwk]
    exact hw
  -- `M` is generated over `ℤ[Γ_Λ]` by finitely many points: coset representatives of `ℤ² ⧸ Λ` lie in `[0, i)²`
  obtain ⟨s, hs⟩ := hM.fg
  have hi : 0 < Λ.index := Nat.pos_of_ne_zero hΛ.index_ne_zero
  let C : Finset (Fin 2 → ℤ) :=
    (Finset.range Λ.index ×ˢ Finset.range Λ.index).image fun ab : ℕ × ℕ => ![(ab.1 : ℤ), (ab.2 : ℤ)]
  have hrep : ∀ n : Fin 2 → ℤ, ∃ c ∈ C, n - c ∈ Λ := by
    intro n
    have hi' : (0 : ℤ) < (Λ.index : ℤ) := by exact_mod_cast hi
    have h0 := Int.emod_nonneg (n 0) hi'.ne'
    have h1 := Int.emod_nonneg (n 1) hi'.ne'
    have h0' := Int.emod_lt_of_pos (n 0) hi'
    have h1' := Int.emod_lt_of_pos (n 1) hi'
    refine ⟨fun j => n j % (Λ.index : ℤ), Finset.mem_image.mpr ⟨((n 0 % (Λ.index : ℤ)).toNat,
      (n 1 % (Λ.index : ℤ)).toNat), Finset.mem_product.mpr ⟨Finset.mem_range.mpr (by omega),
        Finset.mem_range.mpr (by omega)⟩, ?_⟩, ?_⟩
    · funext j
      fin_cases j
      · simp [Int.toNat_of_nonneg h0]
      · simp [Int.toNat_of_nonneg h1]
    · have e : n - (fun j => n j % (Λ.index : ℤ)) = Λ.index • fun j => n j / (Λ.index : ℤ) := by
        funext j
        simp only [Pi.sub_apply, Pi.smul_apply, nsmul_eq_mul]
        rw [Int.emod_def]
        ring
      rw [e]
      exact Λ.nsmul_index_mem _
  let t : Finset (unitRing F) := (C ×ˢ s).image fun cx => p.mulR cx.1 cx.2
  have hxM : ∀ x ∈ s, x ∈ M := fun x hx =>
    hs ▸ AddSubgroup.subset_closure ⟨0, x, hx, (mulR_zero_apply p x).symm⟩
  have ht : ∀ z ∈ t, ∃ k : ℕ, 0 < k ∧ k • z ∈ N.map M.subtype := by
    intro z hz
    obtain ⟨⟨c, x⟩, hcx, rfl⟩ := Finset.mem_image.mp hz
    exact htors _ (hM.mulR_mem c (hxM x (Finset.mem_product.mp hcx).2))
  obtain ⟨m, hm, hmt⟩ := exists_common_nsmul_mem (N.map M.subtype) t ht
  -- one integer kills `M ⧸ N`
  have hmM : ∀ x ∈ M, m • x ∈ N.map M.subtype := by
    intro x hx
    rw [hs] at hx
    have key : AddSubgroup.closure {y | ∃ (n : Fin 2 → ℤ) (x : unitRing F), x ∈ s ∧ y = p.mulR n x} ≤
        (N.map M.subtype).comap (nsmulAddMonoidHom m) := by
      rw [AddSubgroup.closure_le]
      rintro _ ⟨n, x, hxs, rfl⟩
      obtain ⟨c, hc, hnc⟩ := hrep n
      have e : m • p.mulR n x = p.mulR (n - c) (m • p.mulR c x) := by
        rw [map_nsmul, ← mulR_add_apply, sub_add_cancel]
      show m • p.mulR n x ∈ N.map M.subtype
      rw [e]
      exact hstab _ hnc _ (hmt _ (Finset.mem_image.mpr ⟨(c, x), Finset.mem_product.mpr ⟨hc, hxs⟩, rfl⟩))
    exact key hx
  have hrange : (nsmulAddMonoidHom m : M →+ M).range ≤ N := by
    intro w hw
    obtain ⟨w, rfl⟩ := AddMonoidHom.mem_range.mp hw
    rw [← memNR]
    exact hmM w w.2
  -- `M ⧸ N` is finite (Lemma F), so `Y ⊆ N^⊥` is finite
  haveI : ((nsmulAddMonoidHom m : M →+ M).range).FiniteIndex :=
    finiteIndex_range_nsmul (pieceToFieldI M) (pieceToFieldI_injective M) hm.ne'
  haveI : N.FiniteIndex := AddSubgroup.finiteIndex_of_le hrange
  haveI : Finite (M ⧸ N) := AddSubgroup.finite_quotient_of_finiteIndex
  refine (finite_dualAnnihilator N).subset fun χ hχ => ?_
  have h := le_dualAnnihilator_dualCoannihilator (AddSubgroup.toSubgroup' Y) ((AddSubgroup.mem_toSubgroup' Y χ).mpr hχ)
  rw [hNdef] at h
  exact h

/-- **The action on a piece is not virtually cyclic** (PE-1′, third bullet): `α^m = α^{kn}` on `M̂` forces equal
multipliers on `M ≠ 0`, so a finite-index `Λ ⊆ ℤ²` would lie in the cyclic `ℤn`. -/
theorem not_isVirtuallyCyclic_pieceAction {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) :
    ¬ (pieceAction hM).IsVirtuallyCyclic := by
  rintro ⟨n, Λ, hΛ, hcyc⟩
  -- a nonzero point of `M`
  obtain ⟨k₁, hk₁, hk₁m⟩ := hM.fullRank 1
  let x : M := ⟨k₁ • 1, hk₁m⟩
  have hx : (x : unitRing F) ≠ 0 := by
    intro h
    have h' := congrArg (fun z : unitRing F => (z : ℂ)) h
    change ((k₁ • (1 : unitRing F) : unitRing F) : ℂ) = ((0 : unitRing F) : ℂ) at h'
    rw [AddSubmonoidClass.coe_nsmul, ZeroMemClass.coe_zero, OneMemClass.coe_one, nsmul_eq_mul, mul_one,
      Nat.cast_eq_zero] at h'
    omega
  -- `α^m = α^{kn}` forces `m = kn`
  have hle : Λ ≤ AddSubgroup.zmultiples n := by
    intro m hm
    obtain ⟨k, hk⟩ := hcyc m hm
    have hψ : ∀ ψ : AddChar M Circle, ψ (pieceMul hM m x) = ψ (pieceMul hM (k • n) x) := fun ψ =>
      congrArg (fun f : PieceDual M →+ PieceDual M => (ofChar M).symm (f (ofChar M ψ)) x) hk
    have hmul : pieceMul hM m x = pieceMul hM (k • n) x := by
      by_contra hne
      obtain ⟨ψ, hψne⟩ := exists_apply_ne_one (sub_ne_zero.mpr hne)
      exact hψne (by rw [AddChar.map_sub_eq_div, hψ ψ, div_self'])
    have hR : p.mulR m x = p.mulR (k • n) x := congrArg Subtype.val hmul
    rw [mulR_apply, mulR_apply] at hR
    have hu := congrArg (fun z : unitRing F => (z : ℂ)) (mul_right_cancel₀ hx hR)
    have hg : zpowHom p.u p.w (Multiplicative.ofAdd m) = zpowHom p.u p.w (Multiplicative.ofAdd (k • n)) :=
      Subtype.ext (Circle.ext hu)
    exact AddSubgroup.mem_zmultiples_iff.mpr ⟨k, (Multiplicative.ofAdd.injective (p.injective hg)).symm⟩
  -- a cyclic subgroup of `ℤ²` has infinite index
  haveI := hΛ
  haveI : (AddSubgroup.zmultiples n).FiniteIndex := AddSubgroup.finiteIndex_of_le hle
  have hi : ((AddSubgroup.zmultiples n).index : ℤ) ≠ 0 := by exact_mod_cast AddSubgroup.FiniteIndex.index_ne_zero
  obtain ⟨a, ha⟩ := AddSubgroup.mem_zmultiples_iff.mp (AddSubgroup.nsmul_index_mem (AddSubgroup.zmultiples n) ![1, 0])
  obtain ⟨b, hb⟩ := AddSubgroup.mem_zmultiples_iff.mp (AddSubgroup.nsmul_index_mem (AddSubgroup.zmultiples n) ![0, 1])
  have h00 := congrFun ha 0
  have h01 := congrFun ha 1
  have h11 := congrFun hb 1
  simp only [Pi.smul_apply, smul_eq_mul, nsmul_eq_mul, Matrix.cons_val_zero, Matrix.cons_val_one,
    mul_one, mul_zero] at h00 h01 h11
  rcases mul_eq_zero.mp h01 with ha0 | hn1
  · rw [ha0, zero_mul] at h00
    exact hi h00.symm
  · rw [hn1, mul_zero] at h11
    exact hi h11.symm

/-! ## The chain of pieces, and the three steps of Lemma Γ -/

/-- **The first piece**, `ℤ[Γ]·1`: generated by `{1}`, and of full rank because `ℚ(Γ) = F(i)` (admissibility at `Λ = ℤ²`). -/
theorem isPiece_closure_one [NumberField F] :
    IsPiece p (AddSubgroup.closure {y | ∃ (n : Fin 2 → ℤ) (x : unitRing F), x ∈ ({1} : Finset (unitRing F)) ∧
      y = p.mulR n x}) := by
  refine ⟨⟨{1}, rfl⟩, fun r => ?_⟩
  obtain ⟨k, hk, hkr⟩ := exists_nat_mul_mem_closure p ⊤ inferInstance (coe_mem_fieldI r)
  have hmap : (AddSubgroup.closure {y | ∃ (n : Fin 2 → ℤ) (x : unitRing F), x ∈ ({1} : Finset (unitRing F)) ∧
      y = p.mulR n x}).map (unitRing F).toAddSubgroup.subtype =
        AddSubgroup.closure (γC p '' ((⊤ : AddSubgroup (Fin 2 → ℤ)) : Set (Fin 2 → ℤ))) := by
    rw [AddMonoidHom.map_closure]
    congr 1
    ext z
    constructor
    · rintro ⟨_, ⟨n, x, hx, rfl⟩, rfl⟩
      rw [Finset.mem_singleton] at hx
      subst hx
      exact ⟨n, AddSubgroup.mem_top n, by rw [AddSubgroup.coe_subtype, coe_mulR, OneMemClass.coe_one, mul_one]⟩
    · rintro ⟨n, -, rfl⟩
      exact ⟨p.mulR n 1, ⟨n, 1, Finset.mem_singleton_self _, rfl⟩,
        by rw [AddSubgroup.coe_subtype, coe_mulR, OneMemClass.coe_one, mul_one]⟩
  rw [← hmap] at hkr
  obtain ⟨a, ha, hae⟩ := AddSubgroup.mem_map.mp hkr
  refine ⟨k, hk, ?_⟩
  have hak : a = k • r := Subtype.ext (by
    rw [AddSubmonoidClass.coe_nsmul, nsmul_eq_mul]
    exact hae)
  rw [← hak]
  exact ha

/-- **A chain of pieces exhausting `R`** (X02D § 3, "Setting"): `M_k` generated over `ℤ[Γ]` by `1, r₁, …, r_k` for an
enumeration of the countable `R`. -/
theorem exists_pieceChain [NumberField F] :
    ∃ M : ℕ → AddSubgroup (unitRing F), Monotone M ∧ ∃ _hM : ∀ k, IsPiece p (M k), ∀ r, ∃ k, r ∈ M k := by
  classical
  obtain ⟨e, he⟩ := exists_surjective_nat (unitRing F)
  let s : ℕ → Finset (unitRing F) := fun k => insert 1 ((Finset.range k).image e)
  have hgens : ∀ {s s' : Finset (unitRing F)}, s ⊆ s' →
      {y | ∃ (n : Fin 2 → ℤ) (x : unitRing F), x ∈ s ∧ y = p.mulR n x} ⊆
        {y | ∃ (n : Fin 2 → ℤ) (x : unitRing F), x ∈ s' ∧ y = p.mulR n x} := by
    intro s s' h
    rintro _ ⟨n, x, hx, rfl⟩
    exact ⟨n, x, h hx, rfl⟩
  have hsmono : Monotone s := fun k k' h =>
    Finset.insert_subset_insert _ (Finset.image_subset_image (Finset.range_subset_range.mpr h))
  refine ⟨fun k => AddSubgroup.closure {y | ∃ (n : Fin 2 → ℤ) (x : unitRing F), x ∈ s k ∧ y = p.mulR n x},
    fun k k' h => AddSubgroup.closure_mono (hgens (hsmono h)), fun k => ⟨⟨s k, rfl⟩, fun r => ?_⟩, fun r => ?_⟩
  · obtain ⟨j, hj, hjr⟩ := (isPiece_closure_one (p := p)).fullRank r
    exact ⟨j, hj, AddSubgroup.closure_mono (hgens (Finset.singleton_subset_iff.mpr (Finset.mem_insert_self _ _))) hjr⟩
  · obtain ⟨j, rfl⟩ := he r
    refine ⟨j + 1, AddSubgroup.subset_closure ⟨0, e j, ?_, (mulR_zero_apply p (e j)).symm⟩⟩
    exact Finset.mem_insert_of_mem (Finset.mem_image.mpr ⟨j, Finset.mem_range.mpr (Nat.lt_succ_self j), rfl⟩)

/-- **Lemma Γ, step 1**: the image on a piece of a `Γ`-invariant `Γ`-ergodic probability is invariant and ergodic for the
action of `ℤ²` (a strictly invariant measurable set of `M̂` pulls back to a `Γ`-invariant set of `R̂`). -/
theorem isErgodicOn_map_toPiece {M : AddSubgroup (unitRing F)} (hM : IsPiece p M) {ρ : Measure (Dual F)}
    (hρ : ErgodicSMul p.subgroup (Dual F) ρ) :
    (pieceAction hM).IsErgodicOn ⊤ (ρ.map (toPiece M)) := by
  refine ⟨fun n _ => ⟨measurable_dualMap _, ?_⟩, fun s hs hinv => ?_⟩
  · have hα : Measurable (pieceAction hM n) := measurable_dualMap _
    rw [Measure.map_map hα (measurable_toPiece M)]
    have e : (pieceAction hM n) ∘ toPiece M = toPiece M ∘ rot (toUnitVector (zpowHom p.u p.w (Multiplicative.ofAdd n))) :=
      funext fun χ => (toPiece_rot hM n χ).symm
    rw [e, ← Measure.map_map (measurable_toPiece M) (measurable_rot _), map_rot_eq hρ n]
  · have hS : MeasurableSet (toPiece M ⁻¹' s) := measurable_toPiece M hs
    have hinvS : ∀ g : p.subgroup, (g • ·) ⁻¹' (toPiece M ⁻¹' s) =ᵐ[ρ] toPiece M ⁻¹' s := by
      rintro ⟨g, hg⟩
      obtain ⟨n, rfl⟩ := (p.mem_subgroup).1 hg
      refine Filter.EventuallyEq.of_eq (Set.ext fun χ => ?_)
      show toPiece M (rot (toUnitVector (zpowHom p.u p.w (Multiplicative.ofAdd n))) χ) ∈ s ↔ toPiece M χ ∈ s
      rw [toPiece_rot hM n χ]
      exact Set.ext_iff.mp (hinv n trivial) (toPiece M χ)
    have hc := aeconst_of_forall_preimage_smul_ae_eq p.subgroup hS.nullMeasurableSet hinvS
    rcases Filter.eventuallyConst_set'.mp hc with h | h
    · left
      rw [Measure.map_apply (measurable_toPiece M) hs]
      exact ae_eq_empty.mp h
    · right
      rw [Measure.map_apply (measurable_toPiece M) hs.compl, Set.preimage_compl]
      exact ae_eq_univ.mp h

/-- **Lemma Γ, step 3**: along a chain of pieces exhausting `R`, the entropy of a rotation in `Γ` on `R̂` is the supremum of
the entropies of the action on the pieces — T2 (`Rigidity.ksEntropy_eq_iSup_ksEntropyOn`) for the σ-algebras pulled back
from the pieces, which increase and generate, each read by `Rigidity.ksEntropy_map` through `toPiece_rot`. -/
theorem ksEntropy_rot_eq_iSup {M : ℕ → AddSubgroup (unitRing F)} (hmono : Monotone M) (hM : ∀ k, IsPiece p (M k))
    (hex : ∀ r, ∃ k, r ∈ M k) {ρ : Measure (Dual F)} [IsProbabilityMeasure ρ]
    (hρ : ErgodicSMul p.subgroup (Dual F) ρ) (n : Fin 2 → ℤ) :
    ksEntropy ρ (rot (toUnitVector (zpowHom p.u p.w (Multiplicative.ofAdd n)))) =
      ⨆ k, ksEntropy (ρ.map (toPiece (M k))) (pieceAction (hM k) n) := by
  have hT : MeasurePreserving (rot (toUnitVector (zpowHom p.u p.w (Multiplicative.ofAdd n)))) ρ ρ :=
    ⟨measurable_rot _, map_rot_eq hρ n⟩
  let 𝒜 : ℕ → MeasurableSpace (Dual F) := fun k => MeasurableSpace.comap (toPiece (M k)) inferInstance
  have h𝒜 : Monotone 𝒜 := fun k k' h => comap_toPiece_mono (hmono h)
  have hgen : ⨆ k, 𝒜 k = (inferInstance : MeasurableSpace (Dual F)) := by
    refine le_antisymm (iSup_le fun k => (measurable_toPiece (M k)).comap_le) ?_
    show MeasurableSpace.comap (fun χ : Dual F => fun g : unitRing F => (χ g : ℂ))
      (⨆ a, MeasurableSpace.comap (fun b : unitRing F → ℂ => b a) inferInstance) ≤ _
    rw [MeasurableSpace.comap_iSup]
    refine iSup_le fun r => ?_
    rw [MeasurableSpace.comap_comp]
    obtain ⟨k, hk⟩ := hex r
    refine le_iSup_of_le k (measurable_iff_comap_le.mp ?_)
    exact (measurable_evalChar (G := M k) ⟨r, hk⟩ :
      Measurable fun ψ : PieceDual (M k) => (((ofChar (M k)).symm ψ) ⟨r, hk⟩ : ℂ)).comp
        (comap_measurable (toPiece (M k)))
  have hcg : ∀ k, @MeasurableSpace.CountablyGenerated (Dual F) (𝒜 k) := fun k => by
    haveI : Countable (M k) := countable_of_isPiece (hM k)
    haveI : MeasurableSpace.CountablyGenerated (PieceDual (M k)) :=
      (BorelSpace.countablyGenerated : MeasurableSpace.CountablyGenerated (AddChar (M k) Circle))
    exact MeasurableSpace.CountablyGenerated.comap (toPiece (M k))
  rw [ksEntropy_eq_iSup_ksEntropyOn ρ hT 𝒜 h𝒜 hgen hcg]
  exact iSup_congr fun k => (ksEntropy_map_toPiece (hM k) n ρ).symm

/-- **Lemma Γ, step 4**: if the image of `ρ` on a piece is Haar, the Fourier coefficients of `ρ` vanish at every nonzero
`r ∈ M` (a character of `M̂` not `1` at the evaluation `r`, and translation invariance). -/
theorem integral_eq_zero_of_isAddHaarMeasure {M : AddSubgroup (unitRing F)} {ρ : Measure (Dual F)}
    (hH : (ρ.map (toPiece M)).IsAddHaarMeasure) {r : unitRing F} (hr : r ∈ M) (hr0 : r ≠ 0) :
    ∫ χ, (χ r : ℂ) ∂ρ = 0 := by
  haveI := hH
  haveI := PieceDual.measurableAdd M
  let r' : M := ⟨r, hr⟩
  have hr' : r' ≠ 0 := fun h => hr0 (congrArg Subtype.val h)
  obtain ⟨ψ₀, hψ₀⟩ := exists_apply_ne_one hr'
  let f : PieceDual M → ℂ := fun ψ => (((ofChar M).symm ψ) r' : ℂ)
  have hf : Measurable f := measurable_evalChar (G := M) r'
  have h1 : ∫ χ, (χ r : ℂ) ∂ρ = ∫ ψ, f ψ ∂(ρ.map (toPiece M)) := by
    rw [integral_map (measurable_toPiece M).aemeasurable hf.aestronglyMeasurable]
    rfl
  have h3 : ∀ ψ, f (ofChar M ψ₀ + ψ) = (ψ₀ r' : ℂ) * f ψ := fun ψ => rfl
  have h4 : ∫ ψ, f ψ ∂(ρ.map (toPiece M)) = (ψ₀ r' : ℂ) * ∫ ψ, f ψ ∂(ρ.map (toPiece M)) := by
    calc ∫ ψ, f ψ ∂(ρ.map (toPiece M)) = ∫ ψ, f (ofChar M ψ₀ + ψ) ∂(ρ.map (toPiece M)) :=
          (integral_add_left_eq_self f (ofChar M ψ₀)).symm
      _ = ∫ ψ, (ψ₀ r' : ℂ) * f ψ ∂(ρ.map (toPiece M)) :=
          integral_congr_ae (Filter.Eventually.of_forall fun ψ => h3 ψ)
      _ = _ := integral_const_mul _ _
  have hne : (ψ₀ r' : ℂ) ≠ 1 := fun h => hψ₀ (Circle.ext (by rw [h, Circle.coe_one]))
  rw [h1]
  have h5 : (1 - (ψ₀ r' : ℂ)) * ∫ ψ, f ψ ∂(ρ.map (toPiece M)) = 0 := by
    rw [sub_mul, one_mul, ← h4, sub_self]
  exact (mul_eq_zero.mp h5).resolve_left (sub_ne_zero.mpr (Ne.symm hne))

/-- **Lemma Γ** (FS100-X02D § 3.1, l. 183): "For admissible `Γ` and a `Γ`-invariant, `Γ`-ergodic probability measure `ρ` on
`R̂`: `ρ = m`, or `h_ρ(γ) = 0` for every `γ ∈ Γ`." Here `ρ = m` is `IsHaarFourier ρ` (equivalently `ρ = dualHaar`,
`Rigidity.isHaarFourier_iff`). Route: steps 1–4 above with `Rigidity.haar_or_zero_entropy` at each piece; if some rotation in
`Γ` has positive entropy, the supremum makes it positive on every late piece, where the image is then Haar, and every
coefficient off `0` is computed on a late piece. -/
theorem isHaarFourier_or_ksEntropy_eq_zero [NumberField F] (p : AdmissiblePair F) (ρ : Measure (Dual F))
    [IsProbabilityMeasure ρ] (hρ : ErgodicSMul p.subgroup (Dual F) ρ) :
    IsHaarFourier ρ ∨ ∀ g ∈ p.subgroup, ksEntropy ρ (rot (toUnitVector g)) = 0 := by
  by_cases hz : ∀ g ∈ p.subgroup, ksEntropy ρ (rot (toUnitVector g)) = 0
  · exact Or.inr hz
  left
  push Not at hz
  obtain ⟨g, hg, hpos⟩ := hz
  obtain ⟨n, rfl⟩ := (p.mem_subgroup).1 hg
  obtain ⟨M, hmono, hM, hex⟩ := exists_pieceChain (p := p)
  rw [ksEntropy_rot_eq_iSup hmono hM hex hρ n] at hpos
  obtain ⟨k₀, hk₀⟩ : ∃ k₀, ksEntropy (ρ.map (toPiece (M k₀))) (pieceAction (hM k₀) n) ≠ 0 := by
    by_contra h
    exact hpos (ENNReal.iSup_eq_zero.mpr fun k => not_not.mp fun hk => h ⟨k, hk⟩)
  -- on every later piece the entropy stays positive, so the image is Haar there
  have hlate : ∀ k, k₀ ≤ k → (ρ.map (toPiece (M k))).IsAddHaarMeasure := by
    intro k hk
    have hne : ksEntropy (ρ.map (toPiece (M k))) (pieceAction (hM k) n) ≠ 0 := by
      intro h0
      apply hk₀
      rw [ksEntropy_map_toPiece] at h0 ⊢
      exact le_antisymm ((ksEntropyOn_mono (comap_toPiece_mono (hmono hk)) ρ _).trans h0.le) bot_le
    rcases haar_or_zero_entropy (isSolenoid_pieceDual (M := M k)) (pieceAction (hM k))
        (isTotallyIrreducible_pieceAction (hM k)) (not_isVirtuallyCyclic_pieceAction (hM k))
        (ρ.map (toPiece (M k))) (Measure.isProbabilityMeasure_map (measurable_toPiece _).aemeasurable)
        (isErgodicOn_map_toPiece (hM k) hρ) with h | h
    · exact h
    · exact absurd (h n) hne
  -- every coefficient off `0` is computed on a late piece
  refine (show IsProbabilityMeasure ρ ∧ ∀ r : unitRing F, r ≠ 0 → ∫ χ, (χ r : ℂ) ∂ρ = 0 from ⟨inferInstance, ?_⟩)
  intro r hr0
  obtain ⟨k₁, hk₁⟩ := hex r
  exact integral_eq_zero_of_isAddHaarMeasure (hlate (max k₀ k₁) (le_max_left _ _)) (hmono (le_max_right _ _) hk₁) hr0

end

end HadwigerNelson.Rigidity
