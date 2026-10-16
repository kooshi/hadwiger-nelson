import sys
p=sys.argv[1]
s=open(p).read()
def rep(old,new):
    global s
    assert s.count(old)==1, old[:100]
    s=s.replace(old,new)
rep("""    ((unitDistance ℂ).induce (planeOver F)).Reachable y ⟨(y : ℂ) + ∑ j, u j, hy⟩ := by
  sorry""","""    ((unitDistance ℂ).induce (planeOver F)).Reachable y ⟨(y : ℂ) + ∑ j, u j, hy⟩ := by
  induction m generalizing y with
  | zero =>
    have e : (⟨(y : ℂ) + ∑ j : Fin 0, u j, hy⟩ : planeOver F) = y := Subtype.ext (by simp)
    rw [e]
  | succ m ih =>
    have hz : (y : ℂ) + ∑ j : Fin m, u (Fin.castSucc j) ∈ planeOver F :=
      (planeOverSubring F).add_mem y.2 ((planeOverSubring F).sum_mem fun j _ => hF _)
    have h1 := ih (fun j => u (Fin.castSucc j)) (fun j => hu _) (fun j => hF _) y hz
    have hsum : (y : ℂ) + ∑ j, u j = ((y : ℂ) + ∑ j : Fin m, u (Fin.castSucc j)) + u (Fin.last m) := by
      rw [Fin.sum_univ_castSucc, add_assoc]
    have hadj : ((unitDistance ℂ).induce (planeOver F)).Adj ⟨_, hz⟩ ⟨(y : ℂ) + ∑ j, u j, hy⟩ := by
      show (unitDistance ℂ).Adj _ _
      rw [unitDistance_adj, dist_comm, dist_eq_norm, hsum, add_sub_cancel_left]
      exact hu _
    exact h1.trans hadj.reachable""")
rep("""    ((unitDistance ℂ).induce (planeOver F)).Reachable x y ↔ (x : ℂ) - y ∈ UnitRing.unitRingOver F := by
  sorry""","""    ((unitDistance ℂ).induce (planeOver F)).Reachable x y ↔ (x : ℂ) - y ∈ UnitRing.unitRingOver F := by
  constructor
  · rintro ⟨p⟩
    induction p with
    | nil => simp
    | @cons a b c hab _ ih =>
      have hab' : dist (a : ℂ) (b : ℂ) = 1 := hab
      have hu : (a : ℂ) - b ∈ UnitRing.unitRingOver F :=
        UnitRing.unit_mem_unitRingOver ((planeOverSubring F).sub_mem a.2 b.2) (by rw [← dist_eq_norm]; exact hab')
      have e : (a : ℂ) - c = ((a : ℂ) - b) + ((b : ℂ) - c) := by ring
      rw [e]
      exact add_mem hu ih
  · intro h
    obtain ⟨m, u, hu, hF, hs⟩ := UnitRing.exists_sum_eq_of_mem_unitRingOver h
    have hy : (y : ℂ) + ∑ j, u j ∈ planeOver F := by rw [hs, add_sub_cancel]; exact x.2
    have e : (⟨(y : ℂ) + ∑ j, u j, hy⟩ : planeOver F) = x := Subtype.ext (by simp only [hs]; ring)
    have h1 := reachable_add_sum u hu hF y hy
    rw [e] at h1
    exact h1.symm""")
rep("""    ((unitDistance ℂ).induce (planeOver F)).Connected ↔ planeOver F ⊆ UnitRing.unitRingOver F := by
  sorry""","""    ((unitDistance ℂ).induce (planeOver F)).Connected ↔ planeOver F ⊆ UnitRing.unitRingOver F := by
  have h0 : (0 : ℂ) ∈ planeOver F := (planeOverSubring F).zero_mem
  rw [SimpleGraph.connected_iff]
  constructor
  · rintro ⟨hc, -⟩ z hz
    have h := (reachable_iff_sub_mem_unitRingOver ⟨z, hz⟩ ⟨0, h0⟩).1 (hc _ _)
    simpa using h
  · intro h
    exact ⟨fun x y => (reachable_iff_sub_mem_unitRingOver x y).2 (sub_mem (h x.2) (h y.2)), ⟨⟨0, h0⟩⟩⟩""")
rep("""    Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  sorry

/-- **The dichotomy**""","""    Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  classical
  by_contra hinf
  rw [not_infinite_iff_finite] at hinf
  letI := Fintype.ofFinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent
  set d := Fintype.card ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent with hd
  have hfac : ((d.factorial : ℕ) : ℂ) ≠ 0 := Nat.cast_ne_zero.2 (Nat.factorial_ne_zero d)
  set w : ℂ := z / (d.factorial : ℂ) with hw
  have hinv : ((d.factorial : ℂ))⁻¹ ∈ planeOver F := by
    have e : ((d.factorial : ℂ))⁻¹ = (((d.factorial : ℝ)⁻¹ : ℝ) : ℂ) := by push_cast; rfl
    rw [e]
    exact ⟨by simpa using F.inv_mem (natCast_mem F d.factorial), by simp [F.zero_mem]⟩
  have hwF : w ∈ planeOver F := by
    rw [hw, div_eq_mul_inv]
    exact (planeOverSubring F).mul_mem hz hinv
  have hjF : ∀ j : ℕ, (j : ℂ) * w ∈ planeOver F := fun j =>
    (planeOverSubring F).mul_mem (natCast_mem (planeOverSubring F) j) hwF
  let f : Fin (d + 1) → ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent :=
    fun j => ((unitDistance ℂ).induce (planeOver F)).connectedComponentMk ⟨((j : ℕ) : ℂ) * w, hjF j⟩
  obtain ⟨i, j, hij, hf⟩ := Fintype.exists_ne_map_eq_of_card_lt f (by rw [Fintype.card_fin]; omega)
  have hreach := SimpleGraph.ConnectedComponent.exact hf
  have hmem := (reachable_iff_sub_mem_unitRingOver _ _).1 hreach
  set δ : ℤ := ((i : ℕ) : ℤ) - ((j : ℕ) : ℤ) with hδ
  have hδw : ((δ : ℤ) : ℂ) * w ∈ UnitRing.unitRingOver F := by
    have e : ((δ : ℤ) : ℂ) * w = ((i : ℕ) : ℂ) * w - ((j : ℕ) : ℂ) * w := by rw [hδ]; push_cast; ring
    rw [e]
    exact hmem
  have hδ0 : 0 < δ.natAbs := by
    have : (i : ℕ) ≠ (j : ℕ) := fun h => hij (Fin.ext h)
    omega
  have hδd : δ.natAbs ≤ d := by
    have hi := i.2
    have hj := j.2
    omega
  obtain ⟨c, hc⟩ : δ ∣ (d.factorial : ℤ) :=
    Int.natAbs_dvd.mp (Int.natCast_dvd_natCast.mpr (Nat.dvd_factorial hδ0 hδd))
  have hz' : z = c • (((δ : ℤ) : ℂ) * w) := by
    rw [zsmul_eq_mul, hw]
    have hc' : ((d.factorial : ℕ) : ℂ) = (δ : ℂ) * (c : ℂ) := by exact_mod_cast hc
    field_simp
    rw [hc']
    ring
  exact hzR (hz' ▸ zsmul_mem hδw c)

/-- **The dichotomy**""")
rep("""      Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  sorry

/-- **A stable prime gives infinitely many components**""","""      Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  by_cases h : planeOver F ⊆ UnitRing.unitRingOver F
  · exact Or.inl (connected_planeOver_iff_subset.2 h)
  · obtain ⟨z, hz, hzR⟩ := Set.not_subset.1 h
    exact Or.inr (infinite_connectedComponent_planeOver_of_not_mem hz hzR)

/-- **A stable prime gives infinitely many components**""")
rep("""theorem infinite_connectedComponent_planeOver_of_stablePrime [NumberField F] (P : StablePrime F) :
    Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  sorry""","""theorem infinite_connectedComponent_planeOver_of_stablePrime [NumberField F] (P : StablePrime F) :
    Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  obtain ⟨y, hy⟩ : ∃ y : fieldI F, y ∉ P.localRing := by
    by_contra h
    push Not at h
    exact UpperHalf.localRing_ne_top P (eq_top_iff.2 fun y _ => h y)
  have hyR : y ∉ UnitRing.unitRing (conjOn (fieldI_conj F)) := fun hyR =>
    hy ((mem_stableIntegers F).1 (unitRing_le_stableIntegers F hyR) P)
  exact infinite_connectedComponent_planeOver_of_not_mem y.2 fun h => hyR ((UnitRing.coe_mem_unitRingOver_iff y).1 h)""")
rep("""    ((unitDistance ℂ).induce (planeOver F)).Connected ↔ IsEmpty (StablePrime F) := by
  sorry""","""    ((unitDistance ℂ).induce (planeOver F)).Connected ↔ IsEmpty (StablePrime F) := by
  constructor
  · intro hc
    refine ⟨fun P => ?_⟩
    haveI := infinite_connectedComponent_planeOver_of_stablePrime P
    haveI := hc.preconnected.subsingleton_connectedComponent
    exact not_finite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent
  · intro hempty
    refine connected_planeOver_iff_subset.2 fun z hz => ?_
    obtain ⟨c, hc, hcO⟩ := exists_mul_stableIntegers_le (F := F)
    set x : fieldI F := ⟨z, hz⟩ with hx
    have hO : x / (c : fieldI F) ∈ stableIntegers F := (mem_stableIntegers F).2 fun P => isEmptyElim P
    have hxR : x ∈ UnitRing.unitRing (conjOn (fieldI_conj F)) := by
      have h := hcO _ hO
      rwa [mul_div_cancel₀ _ (Nat.cast_ne_zero.2 hc)] at h
    exact (UnitRing.coe_mem_unitRingOver_iff x).2 hxR""")
rep("""theorem infinite_connectedComponent_planeOver [NumberField F] :
    Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  sorry""","""theorem infinite_connectedComponent_planeOver [NumberField F] :
    Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent :=
  let ⟨P⟩ := nonempty_stablePrime F
  infinite_connectedComponent_planeOver_of_stablePrime P""")
rep("""theorem not_connected_planeOver [NumberField F] : ¬ ((unitDistance ℂ).induce (planeOver F)).Connected := by
  sorry""","""theorem not_connected_planeOver [NumberField F] : ¬ ((unitDistance ℂ).induce (planeOver F)).Connected := fun hc =>
  (connected_planeOver_iff_isEmpty_stablePrime.1 hc).false (nonempty_stablePrime F).some""")
open(p,'w').write(s)
