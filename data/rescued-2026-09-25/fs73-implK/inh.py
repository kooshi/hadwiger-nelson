p='Proofs/HadwigerNelson/Kempe.lean'
s=open(p).read()
def rep(old,new):
    global s
    assert s.count(old)==1, old[:80]
    s=s.replace(old,new)
rep('''theorem mem_forcedSubgroup {δ : A} : δ ∈ forcedSubgroup S k ↔ Forces (addCayley S) k 0 δ := by
  sorry''','''theorem mem_forcedSubgroup {δ : A} : δ ∈ forcedSubgroup S k ↔ Forces (addCayley S) k 0 δ := by
  rw [forcedSubgroup, AddSubgroup.mem_iInf]
  refine ⟨fun h C => ?_, fun h C => ?_⟩
  · have h0 := h C 0
    rw [zero_add] at h0
    exact h0.symm
  · by_contra hC
    exact not_forces_zero_of_not_periodic C hC h''')
rep('''    δ ∈ periodicForcedSubgroup S k ↔ ∀ C : (addCayley S).Coloring (Fin k), IsPeriodic C → C 0 = C δ := by
  sorry''','''    δ ∈ periodicForcedSubgroup S k ↔ ∀ C : (addCayley S).Coloring (Fin k), IsPeriodic C → C 0 = C δ := by
  simp only [periodicForcedSubgroup, AddSubgroup.mem_iInf, mem_periods]
  refine ⟨fun h C hC => ?_, fun h C hC x => ?_⟩
  · have h0 := h C hC 0
    rw [zero_add] at h0
    exact h0.symm
  · -- translate `x` to the origin: the translate is periodic with at least the same periods
    haveI : (periods C).FiniteIndex := hC
    have hT : IsPeriodic (C.comap (addCayleyTranslate S x)) :=
      AddSubgroup.finiteIndex_of_le (periods_le_periods_comap_translate C x)
    have h0 := h _ hT
    change C (x + 0) = C (x + δ) at h0
    rw [add_zero] at h0
    exact h0.symm''')
rep('''    periods C ≤ periods (C.comap (addCayleyTranslate S x)) := by
  sorry''','''    periods C ≤ periods (C.comap (addCayleyTranslate S x)) := by
  intro d hd y
  change C (x + (y + d)) = C (x + y)
  rw [← add_assoc]
  exact hd (x + y)''')
rep('''    π.ker ≤ periods ((addCayleyColoring tab h).comap (addCayleyMap π hS hD)) := by
  sorry''','''    π.ker ≤ periods ((addCayleyColoring tab h).comap (addCayleyMap π hS hD)) := by
  intro w hw x
  change tab (π (x + w)) = tab (π x)
  rw [map_add, AddMonoidHom.mem_ker.mp hw, add_zero]''')
rep('''    Function.Periodic (kempeSwap C a b K hK) w := by
  sorry''','''    Function.Periodic (kempeSwap C a b K hK) w := by
  intro x
  by_cases hx : x ∈ K
  · rw [kempeSwap_apply_of_mem C hK ((hKw x).mpr hx), kempeSwap_apply_of_mem C hK hx, hC x]
  · rw [kempeSwap_apply_of_notMem C hK (mt (hKw x).mp hx), kempeSwap_apply_of_notMem C hK hx, hC x]''')
open(p,'w').write(s)
