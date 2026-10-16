import Proofs.HadwigerNelson.Rigidity.UnitRingEq
import Proofs.HadwigerNelson.Rigidity.PlaneComponents
import Proofs.HadwigerNelson.Instances.SqrtFortySevenFive
import Proofs.HadwigerNelson.PadicPlane.Tower

/-!
# Models for Lemma C′ and the components clause (FS-131; planned by FS131-KRU1, proved by FS131-IRU1)

Plan: `plans/FS131-KRU1-ring-plan.md` § 3 (module 5).

* **The scope `NoRamifiedStableDyadic` is inhabited at `ℚ(√47)`**: no stable prime of `ℚ(√47, i)` holds `2`
  (`Rigidity.two_notMem_of_isSquare` at `47 ≡ 7 (mod 8)`), so none is dyadic (`noRamifiedStableDyadic_sqrt47`); Lemma C′ holds
  there (`unitRing_eq_stableIntegers_sqrt47`), and **not trivially**: a stable prime above `11` exists
  (`SqrtFortySeven.exists_stablePrime_eleven`), so `O′ ≠ F(i)` (`stableIntegers_sqrt47_ne_top`).
* **The local hypotheses `¬ IsRamified P` are inhabited at `ℚ`**: the prime `(3)` of `ℚ(i)` is stable and not ramified
  (`PadicPlane.exists_stablePrime_above` at `p = 3`: it does not hold `2`), `exists_stablePrime_three_not_isRamified`.
* **The plane over `ℚ(√47)` has infinitely many components** — an instance of the general theorem, kept as a spec check of its
  statement at a named field.
-/

namespace HadwigerNelson.UnitRingModels

open SpectralChain NumberField Rigidity

/-- **The scope holds at `ℚ(√47)`**: no stable prime of `ℚ(√47, i)` is dyadic. -/
theorem noRamifiedStableDyadic_sqrt47 : NoRamifiedStableDyadic SqrtFortySeven.F47 := fun P hP _ =>
  Rigidity.two_notMem_of_isSquare P SqrtFortySeven.isSquare_fortySeven (by norm_num) hP

/-- **Lemma C′ at `ℚ(√47)`.** -/
theorem unitRing_eq_stableIntegers_sqrt47 :
    UnitRing.unitRing (conjOn (fieldI_conj SqrtFortySeven.F47)) = stableIntegers SqrtFortySeven.F47 :=
  unitRing_eq_stableIntegers noRamifiedStableDyadic_sqrt47

/-- **`O′ ≠ F(i)` at `ℚ(√47)`**: the head statement there is not `F(i) = F(i)`. -/
theorem stableIntegers_sqrt47_ne_top : stableIntegers SqrtFortySeven.F47 ≠ ⊤ := by
  obtain ⟨P, -⟩ := SqrtFortySeven.exists_stablePrime_eleven
  intro h
  refine UpperHalf.localRing_ne_top P (eq_top_iff.2 fun y _ => ?_)
  have hy : y ∈ stableIntegers SqrtFortySeven.F47 := by rw [h]; exact Subring.mem_top y
  exact (mem_stableIntegers _).1 hy P

/-- **An unramified stable prime of `ℚ(i)`, above `3`** — the model of the local hypotheses. -/
theorem exists_stablePrime_three_not_isRamified :
    ∃ P : StablePrime (⊥ : Subfield ℝ), ((3 : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P ∧ ¬ IsRamified P := by
  obtain ⟨P, h3, h2, -⟩ := PadicPlane.exists_stablePrime_above 3 (by norm_num)
  exact ⟨P, h3, fun hr => h2 hr.isDyadic⟩

/-- **The plane over `ℚ(√47)` has infinitely many components.** -/
example : Infinite ((unitDistance ℂ).induce (planeOver SqrtFortySeven.F47)).ConnectedComponent :=
  infinite_connectedComponent_planeOver SqrtFortySeven.F47

end HadwigerNelson.UnitRingModels
