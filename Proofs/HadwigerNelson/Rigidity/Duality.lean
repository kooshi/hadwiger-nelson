import Proofs.HadwigerNelson.Rigidity.SubgroupHaar
import Mathlib.Topology.Algebra.PontryaginDual

/-!
# Pontryagin duality for a countable discrete abelian group (FS-131, job FS131-KPD1; proved by FS131-IDG1)

**Read aloud, against the informal claim.** For a countable abelian group `G` (discrete) and its dual `Ĝ = AddChar G Circle`
under the pointwise topology (`Rigidity/DualGroup`; compact, Polish, Borel = the cylinder σ-algebra):

* **D2, the duality of closed subgroups** (`dualAnnihilator_dualCoannihilator_of_isClosed`): a closed subgroup `Y ⊆ Ĝ` is the
  annihilator of its annihilator, `(Y^⊥)^⊥ = Y`; for every subgroup, `(Y^⊥)^⊥` is its closure
  (`dualAnnihilator_dualCoannihilator`). **The case the chain reads** (PE-1′'s total irreducibility, at `N = Y^⊥ = 0`): a closed
  subgroup with trivial annihilator is everything (`eq_top_of_isClosed_of_dualCoannihilator_eq_bot`, and its additive form on
  `Additive (AddChar G Circle)`, the carrier of `Rigidity.PieceDual`, `eq_top_of_isClosed_of_dualCoannihilator_eq_bot'`).
* **D1, the duality theorem** (`evalDualHom_surjective`): every continuous character of `Ĝ` is the evaluation at a point of `G`;
  with separation (`evalDualHom_injective`), `G ≅ (Ĝ)^` (`dualDualEquiv`, and its form on `Additive (AddChar G Circle)`,
  `additiveDualDualEquiv`, which `Rigidity.isSolenoid_pieceDual`'s `dual_embeds` reads).

**The route reads no Peter–Weyl, no `L²`, no tori** (FS131-KPD1's plan, `plans/FS131-KPD1-pontryagin.md`). The characters of
`Ĝ` that a discrete `G` supplies — the evaluations — already separate its points, so Fourier uniqueness on `Ĝ` is
Stone–Weierstrass (`Rigidity.measure_eq_of_fourier`), and:
* D2: put `Z := (Y^⊥)^⊥`; then `Z^⊥ = Y^⊥` with nothing to prove, so the Haar measures of `Y` and of `Z`, carried into `Ĝ`, have
  one Fourier transform (`Rigidity.integral_subgroupHaar_eq`) and are equal; the first lives on `Y` and the second charges every
  open set meeting `Z`, so `Z ⊆ Y`.
* D1, from D2 at `G × ℤ`: for a continuous character `ψ` of `Ĝ`, the characters `ξ` of `G × ℤ` with `ξ(0, 1) = ψ(ξ ∘ inl)` form a
  closed subgroup `graphSubgroup ψ`; by D2 and separation at `ℤ ⧸ P` some `(g, 1)` is in its annihilator
  (`exists_mem_dualCoannihilator_graphSubgroup`), and then `ψ χ = χ (−g)` for every `χ`.

**Countability** is read through Polishness (Fourier uniqueness on a compact metrizable group). D1 and D2 hold for every discrete
abelian group; the uncountable case would need Fourier uniqueness on a non-metrizable compact group, which no consumer asks.

**Models.** D2's hypothesis — a closed subgroup — at `Y = ⊤` (closed; `Y^⊥ = 0`, so the case applies) and `Y = ⊥` (closed, a point);
D1 at the trivial character (`evalDualHom 0`); `G = ℤ` in the spec examples.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory Topology

noncomputable section

variable {G : Type*} [AddCommGroup G]

/-! ## D2: closed subgroups of the dual -/

/-- **Pontryagin duality for closed subgroups of the dual of a countable discrete group** (D2): a closed `Y ⊆ Ĝ` is the
annihilator of its annihilator. The proof compares the Haar measures of `Y` and of `(Y^⊥)^⊥` by their Fourier coefficients. -/
theorem dualAnnihilator_dualCoannihilator_of_isClosed [Countable G] (Y : Subgroup (AddChar G Circle))
    (hY : IsClosed (Y : Set (AddChar G Circle))) : dualAnnihilator (dualCoannihilator Y) = Y := by
  set Z := dualAnnihilator (dualCoannihilator Y) with hZdef
  have hYZ : Y ≤ Z := le_dualAnnihilator_dualCoannihilator Y
  refine le_antisymm ?_ hYZ
  haveI : CompactSpace Y := isCompact_iff_compactSpace.mp hY.isCompact
  haveI : CompactSpace Z := isCompact_iff_compactSpace.mp (isClosed_dualAnnihilator _).isCompact
  have hann : dualCoannihilator Y = dualCoannihilator Z :=
    (dualCoannihilator_dualAnnihilator_dualCoannihilator Y).symm
  have hmeas : subgroupHaar Y = subgroupHaar Z :=
    measure_eq_of_fourier (integral_subgroupHaar_eq hann)
  intro z hz
  by_contra hzY
  have hpos : 0 < subgroupHaar Z (Y : Set (AddChar G Circle))ᶜ :=
    subgroupHaar_pos Z hY.isOpen_compl ⟨z, hzY, hz⟩
  rw [← hmeas, subgroupHaar_compl] at hpos
  exact lt_irrefl 0 hpos

/-- **D2 for every subgroup**: the annihilator of the annihilator is the closure. -/
theorem dualAnnihilator_dualCoannihilator [Countable G] (Y : Subgroup (AddChar G Circle)) :
    dualAnnihilator (dualCoannihilator Y) = Y.topologicalClosure := by
  rw [← dualCoannihilator_topologicalClosure Y]
  exact dualAnnihilator_dualCoannihilator_of_isClosed _ Y.isClosed_topologicalClosure

/-- **The case PE-1′ reads**: a closed subgroup of the dual whose annihilator is trivial is the whole dual. -/
theorem eq_top_of_isClosed_of_dualCoannihilator_eq_bot [Countable G] (Y : Subgroup (AddChar G Circle))
    (hY : IsClosed (Y : Set (AddChar G Circle))) (h : dualCoannihilator Y = ⊥) : Y = ⊤ := by
  rw [← dualAnnihilator_dualCoannihilator_of_isClosed Y hY, h, dualAnnihilator_bot]

/-- **The case, on the additive carrier** `Additive (AddChar G Circle)` (`Rigidity.PieceDual M` unfolds to it at `G = M`). -/
theorem eq_top_of_isClosed_of_dualCoannihilator_eq_bot' [Countable G] (Y : AddSubgroup (Additive (AddChar G Circle)))
    (hY : IsClosed (Y : Set (Additive (AddChar G Circle))))
    (h : dualCoannihilator (AddSubgroup.toSubgroup' Y) = ⊥) : Y = ⊤ := by
  have := eq_top_of_isClosed_of_dualCoannihilator_eq_bot (AddSubgroup.toSubgroup' Y) hY h
  exact AddSubgroup.toSubgroup'.injective (this.trans (OrderIso.map_top _).symm)

/-! ## D1: the continuous characters of the dual are the evaluations -/

variable (G) in
/-- **The evaluation map** `g ↦ (χ ↦ χ g)`, from `G` (written multiplicatively) to the continuous characters of `Ĝ`. -/
def evalDualHom : Multiplicative G →* PontryaginDual (AddChar G Circle) where
  toFun g :=
    { toFun := fun χ => χ (Multiplicative.toAdd g)
      map_one' := AddChar.one_apply _
      map_mul' := fun χ ψ => AddChar.mul_apply χ ψ _
      continuous_toFun := continuous_induced_rng.2 (continuous_evalChar G _) }
  map_one' := PontryaginDual.ext fun χ => AddChar.map_zero_eq_one χ
  map_mul' _ _ := PontryaginDual.ext fun χ => AddChar.map_add_eq_mul χ _ _

@[simp]
theorem evalDualHom_apply (g : G) (χ : AddChar G Circle) : evalDualHom G (Multiplicative.ofAdd g) χ = χ g :=
  rfl

/-- **The evaluation map is injective**: separation (`Rigidity.exists_apply_ne_one`). -/
theorem evalDualHom_injective : Function.Injective (evalDualHom G) := by
  refine (injective_iff_map_eq_one _).mpr fun g hg => ?_
  by_contra hne
  have hne' : Multiplicative.toAdd g ≠ 0 := hne
  obtain ⟨ψ, hψ⟩ := exists_apply_ne_one hne'
  exact hψ (congrArg (fun φ : PontryaginDual (AddChar G Circle) => φ ψ) hg)

namespace Duality

/-- The character `(g, n) ↦ χ g · zⁿ` of `G × ℤ`. -/
def extendByPow (χ : AddChar G Circle) (z : Circle) : AddChar (G × ℤ) Circle where
  toFun p := χ p.1 * z ^ p.2
  map_zero_eq_one' := by simp
  map_add_eq_mul' p q := by
    simp only [Prod.fst_add, Prod.snd_add, AddChar.map_add_eq_mul, zpow_add]
    exact mul_mul_mul_comm _ _ _ _

@[simp]
theorem extendByPow_apply (χ : AddChar G Circle) (z : Circle) (p : G × ℤ) : extendByPow χ z p = χ p.1 * z ^ p.2 :=
  rfl

/-- **The graph of a continuous character `ψ` of `Ĝ`**, as a subgroup of the dual of `G × ℤ`: the `ξ` with
`ξ (0, 1) = ψ (ξ ∘ inl)`. -/
def graphSubgroup (ψ : PontryaginDual (AddChar G Circle)) : Subgroup (AddChar (G × ℤ) Circle) where
  carrier := {ξ | ξ (0, 1) = ψ (ξ.compAddMonoidHom (AddMonoidHom.inl G ℤ))}
  one_mem' := by
    show (1 : AddChar (G × ℤ) Circle) (0, 1) =
      ψ ((1 : AddChar (G × ℤ) Circle).compAddMonoidHom (AddMonoidHom.inl G ℤ))
    have hc : (1 : AddChar (G × ℤ) Circle).compAddMonoidHom (AddMonoidHom.inl G ℤ) = 1 :=
      AddChar.ext _ _ fun _ => rfl
    rw [hc, map_one, AddChar.one_apply]
  mul_mem' := by
    intro ξ η hξ hη
    show (ξ * η) (0, 1) = ψ ((ξ * η).compAddMonoidHom (AddMonoidHom.inl G ℤ))
    have hc : (ξ * η).compAddMonoidHom (AddMonoidHom.inl G ℤ) =
        ξ.compAddMonoidHom (AddMonoidHom.inl G ℤ) * η.compAddMonoidHom (AddMonoidHom.inl G ℤ) :=
      AddChar.ext _ _ fun _ => rfl
    rw [hc, map_mul, AddChar.mul_apply, (hξ : ξ (0, 1) = _), (hη : η (0, 1) = _)]
  inv_mem' := by
    intro ξ hξ
    show ξ⁻¹ (0, 1) = ψ (ξ⁻¹.compAddMonoidHom (AddMonoidHom.inl G ℤ))
    have hc : ξ⁻¹.compAddMonoidHom (AddMonoidHom.inl G ℤ) = (ξ.compAddMonoidHom (AddMonoidHom.inl G ℤ))⁻¹ :=
      AddChar.ext _ _ fun _ => rfl
    rw [hc, map_inv, AddChar.inv_apply', (hξ : ξ (0, 1) = _)]

/-- The graph is closed: both sides of its equation are continuous in `ξ`. -/
theorem isClosed_graphSubgroup (ψ : PontryaginDual (AddChar G Circle)) :
    IsClosed (graphSubgroup ψ : Set (AddChar (G × ℤ) Circle)) := by
  have h1 : Continuous fun ξ : AddChar (G × ℤ) Circle => ξ (0, 1) :=
    continuous_induced_rng.2 (continuous_evalChar (G × ℤ) (0, 1))
  have h2 : Continuous fun ξ : AddChar (G × ℤ) Circle => ξ.compAddMonoidHom (AddMonoidHom.inl G ℤ) :=
    continuous_induced_rng.2 (continuous_pi fun g => continuous_evalChar (G × ℤ) (g, 0))
  exact isClosed_eq h1 (ψ.continuous.comp h2)

/-- **The step of D1**: some `(g, 1)` is killed by the graph. D2 at `G × ℤ`: the character `(g, n) ↦ zⁿ` is in the graph only at
`z = 1`, so for `z ≠ 1` the annihilator holds a `(g, n)` with `zⁿ ≠ 1`; if `1` were not among those `n`, a character of `ℤ ⧸ P`
not `1` at `1` (separation) would be such a `z`, with `zⁿ = 1` on all of them. -/
theorem exists_mem_dualCoannihilator_graphSubgroup [Countable G] (ψ : PontryaginDual (AddChar G Circle)) :
    ∃ g : G, (g, (1 : ℤ)) ∈ dualCoannihilator (graphSubgroup ψ) := by
  set Y := graphSubgroup ψ with hYdef
  set P : AddSubgroup ℤ := (dualCoannihilator Y).map (AddMonoidHom.snd G ℤ) with hP
  suffices h1 : (1 : ℤ) ∈ P by
    obtain ⟨p, hp, hp1⟩ := AddSubgroup.mem_map.mp h1
    refine ⟨p.1, ?_⟩
    have hp' : p = (p.1, 1) := Prod.ext rfl hp1
    rw [← hp']
    exact hp
  by_contra h1
  have hq : (QuotientAddGroup.mk 1 : ℤ ⧸ P) ≠ 0 := by
    rwa [Ne, QuotientAddGroup.eq_zero_iff]
  obtain ⟨θ, hθ⟩ := exists_apply_ne_one hq
  set z := θ (QuotientAddGroup.mk 1) with hz
  have ht : extendByPow (1 : AddChar G Circle) z ∉ Y := by
    intro hmem
    have he : extendByPow (1 : AddChar G Circle) z (0, 1) =
        ψ ((extendByPow (1 : AddChar G Circle) z).compAddMonoidHom (AddMonoidHom.inl G ℤ)) := hmem
    have hc : (extendByPow (1 : AddChar G Circle) z).compAddMonoidHom (AddMonoidHom.inl G ℤ) = 1 :=
      AddChar.ext _ _ fun g => by simp
    rw [hc, map_one, extendByPow_apply] at he
    simp only [AddChar.one_apply, one_mul, zpow_one] at he
    exact hθ he
  rw [← dualAnnihilator_dualCoannihilator_of_isClosed Y (isClosed_graphSubgroup ψ)] at ht
  simp only [mem_dualAnnihilator, not_forall] at ht
  obtain ⟨p, hp, hpz⟩ := ht
  apply hpz
  rw [extendByPow_apply, AddChar.one_apply, one_mul]
  have hp2 : (QuotientAddGroup.mk p.2 : ℤ ⧸ P) = 0 :=
    (QuotientAddGroup.eq_zero_iff _).mpr (AddSubgroup.mem_map.mpr ⟨p, hp, rfl⟩)
  rw [hz, ← AddChar.map_zsmul_eq_zpow, ← QuotientAddGroup.mk_zsmul, smul_eq_mul, mul_one, hp2,
    AddChar.map_zero_eq_one]

end Duality

/-- **D1, the duality theorem for a countable discrete group**: every continuous character of `Ĝ` is an evaluation. -/
theorem evalDualHom_surjective [Countable G] : Function.Surjective (evalDualHom G) := by
  intro ψ
  obtain ⟨g, hg⟩ := Duality.exists_mem_dualCoannihilator_graphSubgroup ψ
  refine ⟨Multiplicative.ofAdd (-g), PontryaginDual.ext fun χ => ?_⟩
  have hc : (Duality.extendByPow χ (ψ χ)).compAddMonoidHom (AddMonoidHom.inl G ℤ) = χ :=
    AddChar.ext _ _ fun x => by simp
  have hmem : Duality.extendByPow χ (ψ χ) ∈ Duality.graphSubgroup ψ := by
    show Duality.extendByPow χ (ψ χ) (0, 1) =
      ψ ((Duality.extendByPow χ (ψ χ)).compAddMonoidHom (AddMonoidHom.inl G ℤ))
    rw [hc, Duality.extendByPow_apply]
    simp
  have h1 := hg _ hmem
  rw [Duality.extendByPow_apply, zpow_one] at h1
  rw [evalDualHom_apply, AddChar.map_neg_eq_inv]
  exact (eq_inv_of_mul_eq_one_right h1).symm

variable (G) in
/-- **`G ≅ (Ĝ)^`**, by evaluation. -/
def dualDualEquiv [Countable G] : Multiplicative G ≃* PontryaginDual (AddChar G Circle) :=
  MulEquiv.ofBijective (evalDualHom G) ⟨evalDualHom_injective, evalDualHom_surjective⟩

@[simp]
theorem dualDualEquiv_apply [Countable G] (g : G) (χ : AddChar G Circle) : dualDualEquiv G (Multiplicative.ofAdd g) χ = χ g :=
  rfl

variable (G) in
/-- **`G ≅ (Ĝ)^` on the additive carrier**: the continuous characters of `Multiplicative (Additive (AddChar G Circle))` — the
type `Rigidity.IsSolenoid`'s `dual_embeds` reads at `X = Rigidity.PieceDual M` — are the evaluations. -/
def additiveDualDualEquiv [Countable G] : Multiplicative G ≃* PontryaginDual (Multiplicative (Additive (AddChar G Circle))) :=
  dualDualEquiv G

@[simp]
theorem additiveDualDualEquiv_apply [Countable G] (g : G) (χ : Multiplicative (Additive (AddChar G Circle))) :
    additiveDualDualEquiv G (Multiplicative.ofAdd g) χ = (Additive.toMul (Multiplicative.toAdd χ)) g :=
  rfl

/-! ## Models and spec -/

/-- The hypotheses of D2's case are inhabited: the whole dual is closed, with trivial annihilator (separation). -/
example : ∃ Y : Subgroup (AddChar ℤ Circle), IsClosed (Y : Set (AddChar ℤ Circle)) ∧ dualCoannihilator Y = ⊥ :=
  ⟨⊤, isClosed_univ, dualCoannihilator_top⟩

-- Spec: the evaluation at `0` is the trivial character of the dual.
example : evalDualHom ℤ (Multiplicative.ofAdd 0) = 1 := map_one (evalDualHom ℤ)

end

end HadwigerNelson.Rigidity
