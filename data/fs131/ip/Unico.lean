import Mathlib.Topology.Homotopy.Lifting
import Mathlib.Analysis.Complex.CoveringMap
import Mathlib.Topology.Connected.LocallyConnected
import Mathlib.Topology.UrysohnsLemma
import Mathlib.Topology.Homotopy.Contractible
import Mathlib.Analysis.Convex.Contractible
import Proofs.HadwigerNelson.Plane.Basic

namespace HadwigerNelson.Plane

open Complex Real Set Topology Metric

/-- A continuous real function taking integer values on a preconnected set is constant there (intermediate values). -/
theorem eq_of_intValued_of_isPreconnected {α : Type*} [TopologicalSpace α] {S : Set α} (hS : IsPreconnected S) {f : α → ℝ}
    (hf : ContinuousOn f S) (hint : ∀ z ∈ S, ∃ n : ℤ, f z = n) {x y : α} (hx : x ∈ S) (hy : y ∈ S) : f x = f y := by
  have key : ∀ {x y : α}, x ∈ S → y ∈ S → f x ≤ f y := by
    intro x y hx hy
    by_contra hlt
    push Not at hlt
    obtain ⟨n, hn⟩ := hint x hx
    obtain ⟨m, hm⟩ := hint y hy
    rw [hn, hm] at hlt
    have hmn : m + 1 ≤ n := by exact_mod_cast hlt
    have hmn' : (m : ℝ) + 1 ≤ n := by exact_mod_cast hmn
    obtain ⟨z, hz, hfz⟩ := hS.intermediate_value hy hx hf
      (show (m : ℝ) + 1 / 2 ∈ Icc (f y) (f x) by
        rw [hn, hm]; exact ⟨by linarith, by linarith⟩)
    obtain ⟨k, hk⟩ := hint z hz
    rw [hk] at hfz
    have h2 : ((2 * k : ℤ) : ℝ) = ((2 * m + 1 : ℤ) : ℝ) := by push_cast; linarith
    have := Int.cast_injective (α := ℝ) h2
    omega
  exact le_antisymm (key hx hy) (key hy hx)

/-- **The plane is unicoherent**. -/
theorem isPreconnected_inter_of_union_eq_univ {A B : Set ℂ} (hA : IsClosed A) (hB : IsClosed B) (hA' : IsPreconnected A)
    (hB' : IsPreconnected B) (hAB : A ∪ B = univ) : IsPreconnected (A ∩ B) := by
  classical
  rw [isPreconnected_closed_iff]
  intro t t' ht ht' hcov hP hQ
  by_contra hempty
  rw [not_nonempty_iff_eq_empty] at hempty
  set P := A ∩ B ∩ t with hPdef
  set Q := A ∩ B ∩ t' with hQdef
  have hPc : IsClosed P := (hA.inter hB).inter ht
  have hQc : IsClosed Q := (hA.inter hB).inter ht'
  have hPQ : Disjoint P Q := by
    rw [Set.disjoint_iff]
    rintro z ⟨⟨hzAB, hzt⟩, -, hzt'⟩
    have : z ∈ A ∩ B ∩ (t ∩ t') := ⟨hzAB, hzt, hzt'⟩
    rw [hempty] at this
    exact this
  obtain ⟨φ, hφP, hφQ, hφI⟩ := exists_continuous_zero_one_of_isClosed hPc hQc hPQ
  -- on `A ∩ B` the angle is `0` or `1`
  have hφAB : ∀ z ∈ A ∩ B, φ z = 0 ∨ φ z = 1 := by
    intro z hz
    rcases hcov hz with h | h
    · exact Or.inl (hφP ⟨hz, h⟩)
    · exact Or.inr (hφQ ⟨hz, h⟩)
  have hexp1 : ∀ z ∈ A ∩ B, Complex.exp (2 * π * I * (φ z : ℂ)) = 1 := by
    intro z hz
    rcases hφAB z hz with h | h
    · rw [h]; simp
    · rw [h]; simp
  -- the pasted map `g`
  set g : ℂ → ℂ := fun z => if z ∈ A then Complex.exp (2 * π * I * (φ z : ℂ)) else 1 with hgdef
  have hgc : Continuous g := by
    apply Continuous.if
    · intro z hz
      have hzA : z ∈ A := hA.frontier_subset hz
      have hzB : z ∈ B := by
        have h1 : z ∈ closure {x | x ∈ A}ᶜ := frontier_subset_closure (frontier_compl (s := {x | x ∈ A}) ▸ hz)
        have h2 : {x | x ∈ A}ᶜ ⊆ B := by
          intro x hx
          have : x ∈ A ∪ B := hAB ▸ mem_univ x
          rcases this with h | h
          · exact absurd h hx
          · exact h
        exact hB.closure_subset_iff.mpr h2 h1
      exact hexp1 z ⟨hzA, hzB⟩
    · fun_prop
    · fun_prop
  have hg0 : ∀ z, g z ≠ 0 := by
    intro z
    simp only [hgdef]
    split_ifs
    · exact Complex.exp_ne_zero _
    · exact one_ne_zero
  have hgB : ∀ z ∈ B, g z = 1 := by
    intro z hz
    simp only [hgdef]
    split_ifs with h
    · exact hexp1 z ⟨h, hz⟩
    · rfl
  have hgA : ∀ z ∈ A, g z = Complex.exp (2 * π * I * (φ z : ℂ)) := by
    intro z hz
    simp only [hgdef, if_pos hz]
  -- lift through `exp`
  obtain ⟨p, hpP⟩ : P.Nonempty := by simpa [hPdef] using hP
  obtain ⟨q, hqQ⟩ : Q.Nonempty := by simpa [hQdef] using hQ
  let f : C(ℂ, {z : ℂ // z ≠ 0}) := ⟨fun z => ⟨g z, hg0 z⟩, hgc.subtype_mk _⟩
  obtain ⟨F, ⟨-, hF⟩, -⟩ := Complex.isCoveringMap_exp.existsUnique_continuousMap_lifts f p 0
    (by ext; simp [f, hgB p hpP.1.2])
  have hFexp : ∀ z, Complex.exp (F z) = g z := by
    intro z
    have := congrArg Subtype.val (congrFun hF z)
    simpa [f] using this
  set ψ : ℂ → ℝ := fun z => (F z).im / (2 * π) with hψ
  have hψc : Continuous ψ := by fun_prop
  have hBc : ∀ x ∈ B, ∀ y ∈ B, ψ x = ψ y := by
    intro x hx y hy
    refine eq_of_intValued_of_isPreconnected hB' hψc.continuousOn ?_ hx hy
    intro z hz
    obtain ⟨n, hn⟩ := Complex.exp_eq_one_iff.mp ((hFexp z).trans (hgB z hz))
    refine ⟨n, ?_⟩
    simp only [hψ, hn]
    have : (↑n * (2 * ↑π * I) : ℂ).im = n * (2 * π) := by simp
    rw [this]; field_simp
  have hAc : ∀ x ∈ A, ∀ y ∈ A, ψ x - φ x = ψ y - φ y := by
    intro x hx y hy
    refine eq_of_intValued_of_isPreconnected hA' (hψc.sub φ.continuous).continuousOn ?_ hx hy
    intro z hz
    obtain ⟨n, hn⟩ := Complex.exp_eq_exp_iff_exists_int.mp ((hFexp z).trans (hgA z hz))
    refine ⟨n, ?_⟩
    show (F z).im / (2 * π) - φ z = n
    have : (2 * ↑π * I * ↑(φ z) + ↑n * (2 * ↑π * I) : ℂ).im = 2 * π * φ z + n * (2 * π) := by simp
    rw [hn, this]; field_simp; ring
  have h1 := hBc p hpP.1.2 q hqQ.1.2
  have h2 := hAc p hpP.1.1 q hqQ.1.1
  rw [hφP hpP, hφQ hqQ] at h2
  simp at h2
  linarith

/-- A preconnected set meeting `t` and its complement meets `t`'s frontier. -/
theorem inter_frontier_nonempty_of_isPreconnected {α : Type*} [TopologicalSpace α] {s t : Set α} (hs : IsPreconnected s)
    (hst : (s ∩ t).Nonempty) (hst' : (s ∩ tᶜ).Nonempty) : (s ∩ frontier t).Nonempty := by
  by_contra hne
  rw [not_nonempty_iff_eq_empty] at hne
  have hcov : s ⊆ interior t ∪ (closure t)ᶜ := by
    intro z hz
    by_cases hzi : z ∈ interior t
    · exact Or.inl hzi
    · right
      intro hzc
      have : z ∈ s ∩ frontier t := ⟨hz, hzc, hzi⟩
      rw [hne] at this
      exact this
  obtain ⟨z, hzs, hzt⟩ := hst
  obtain ⟨w, hws, hwt⟩ := hst'
  have hz : z ∈ interior t := by
    rcases hcov hzs with h | h
    · exact h
    · exact absurd (subset_closure hzt) h
  have hw : w ∈ (closure t)ᶜ := by
    rcases hcov hws with h | h
    · exact absurd (interior_subset h) hwt
    · exact h
  have hdisj : Disjoint (interior t) (closure t)ᶜ :=
    Set.disjoint_left.mpr fun x hx hx' => hx' (subset_closure (interior_subset hx))
  have := hs.subset_left_of_subset_union isOpen_interior isClosed_closure.isOpen_compl hdisj hcov ⟨z, hzs, hz⟩ hws
  exact Set.disjoint_left.mp hdisj this hw

/-- The complement of a closed disc in `ℂ` is preconnected. -/
theorem isPreconnected_compl_closedBall (c : ℂ) (R : ℝ) : IsPreconnected (closedBall c R)ᶜ := by
  rcases lt_or_ge R 0 with hR | hR
  · rw [closedBall_eq_empty.mpr hR, compl_empty]
    exact isPreconnected_univ
  have h : (closedBall c R)ᶜ = (fun p : ℝ × ℝ => c + (p.1 : ℂ) * e p.2) '' (Ioi R ×ˢ univ) := by
    ext z
    constructor
    · intro hz
      have hz' : R < ‖z - c‖ := by
        rw [mem_compl_iff, mem_closedBall, not_le, dist_eq_norm] at hz; exact hz
      refine ⟨(‖z - c‖, Complex.arg (z - c)), ⟨hz', mem_univ _⟩, ?_⟩
      simp only [e]
      rw [Complex.norm_mul_exp_arg_mul_I (z - c)]
      ring
    · rintro ⟨⟨r, θ⟩, ⟨hr, -⟩, rfl⟩
      have hr' : R < r := hr
      have : ‖(r : ℂ) * e θ‖ = r := by
        rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg (by linarith)]
      rw [mem_compl_iff, mem_closedBall, not_le, dist_eq_norm]
      simp only [add_sub_cancel_left, this]
      exact hr'
  rw [h]
  exact (isPreconnected_Ioi.prod isPreconnected_univ).image _ (by unfold e; fun_prop)

/-- An unbounded component of the complement of a set inside `B̄(0, R)` holds the whole complement of `B̄(0, R)`. -/
theorem compl_closedBall_subset_connectedComponentIn {K : Set ℂ} {R : ℝ} (hKR : K ⊆ closedBall 0 R) {z : ℂ}
    (hz : ¬ Bornology.IsBounded (connectedComponentIn Kᶜ z)) : (closedBall (0 : ℂ) R)ᶜ ⊆ connectedComponentIn Kᶜ z := by
  have hsub : (closedBall (0 : ℂ) R)ᶜ ⊆ Kᶜ := compl_subset_compl.mpr hKR
  obtain ⟨y, hyC, hyR⟩ : ∃ y ∈ connectedComponentIn Kᶜ z, y ∉ closedBall (0 : ℂ) R := by
    by_contra h
    push Not at h
    exact hz (isBounded_closedBall.subset h)
  have h1 := (isPreconnected_compl_closedBall 0 R).subset_connectedComponentIn hyR hsub
  rwa [← connectedComponentIn_eq hyC] at h1

/-- For a bounded set, two unbounded complementary components coincide. -/
theorem connectedComponentIn_eq_of_not_isBounded {K : Set ℂ} (hKb : Bornology.IsBounded K) {z w : ℂ}
    (hz : ¬ Bornology.IsBounded (connectedComponentIn Kᶜ z)) (hw : ¬ Bornology.IsBounded (connectedComponentIn Kᶜ w)) :
    connectedComponentIn Kᶜ z = connectedComponentIn Kᶜ w := by
  obtain ⟨R, hR⟩ := hKb.subset_closedBall 0
  have h1 := compl_closedBall_subset_connectedComponentIn hR hz
  have h2 := compl_closedBall_subset_connectedComponentIn hR hw
  obtain ⟨y, hy⟩ : ((closedBall (0 : ℂ) R)ᶜ).Nonempty := by
    refine ⟨((|R| + 1 : ℝ) : ℂ), ?_⟩
    rw [mem_compl_iff, mem_closedBall, not_le, dist_zero_right, Complex.norm_real, Real.norm_of_nonneg (by positivity)]
    linarith [le_abs_self R]
  rw [connectedComponentIn_eq (h1 hy), connectedComponentIn_eq (h2 hy)]

/-- **The last exit**. -/
theorem isBounded_connectedComponentIn_of_frontier_subset {K R : Set ℂ} (hK : IsClosed K) (hKb : Bornology.IsBounded K)
    (hR : IsClosed R) {z : ℂ} (hW : ¬ Bornology.IsBounded (connectedComponentIn Kᶜ z))
    (hfr : frontier (connectedComponentIn Kᶜ z) ⊆ R) {y : ℂ} (hyW : y ∉ connectedComponentIn Kᶜ z) (hyR : y ∉ R) :
    Bornology.IsBounded (connectedComponentIn Rᶜ y) := by
  by_contra hC
  obtain ⟨r, hr⟩ := hKb.subset_closedBall 0
  have hWr := compl_closedBall_subset_connectedComponentIn hr hW
  obtain ⟨x, hxC, hxr⟩ : ∃ x ∈ connectedComponentIn Rᶜ y, x ∉ closedBall (0 : ℂ) r := by
    by_contra h
    push Not at h
    exact hC (isBounded_closedBall.subset h)
  obtain ⟨p, hpC, hpfr⟩ := inter_frontier_nonempty_of_isPreconnected (isPreconnected_connectedComponentIn (F := Rᶜ) (x := y))
    (t := connectedComponentIn Kᶜ z) ⟨x, hxC, hWr hxr⟩ ⟨y, mem_connectedComponentIn hyR, hyW⟩
  exact connectedComponentIn_subset _ _ hpC (hfr hpfr)

/-- **Two of finitely many closed sets meet on a preconnected set they cover**. -/
theorem exists_inter_of_finite_closed_cover {α ι : Type*} [TopologicalSpace α] {S : Set α} (hS : IsPreconnected S) {s : Set ι}
    (hs : s.Finite) (C : ι → Set α) (hC : ∀ i ∈ s, IsClosed (C i)) (hcov : S ⊆ ⋃ i ∈ s, C i) {i j : ι} (hi : i ∈ s) (hj : j ∈ s)
    (hij : i ≠ j) (hiS : (S ∩ C i).Nonempty) (hjS : (S ∩ C j).Nonempty) :
    ∃ i' ∈ s, ∃ j' ∈ s, i' ≠ j' ∧ (S ∩ C i' ∩ C j').Nonempty := by
  have hclo : IsClosed (⋃ k ∈ {k | k ∈ s ∧ k ≠ i}, C k) :=
    (hs.subset fun k hk => hk.1).isClosed_biUnion fun k hk => hC k hk.1
  have hcov' : S ⊆ C i ∪ ⋃ k ∈ {k | k ∈ s ∧ k ≠ i}, C k := by
    intro x hx
    obtain ⟨k, hk, hxk⟩ := mem_iUnion₂.mp (hcov hx)
    by_cases hki : k = i
    · exact Or.inl (hki ▸ hxk)
    · exact Or.inr (mem_iUnion₂.mpr ⟨k, ⟨hk, hki⟩, hxk⟩)
  obtain ⟨x, hxj, hxj'⟩ := hjS
  obtain ⟨y, hyS, hyi, hyo⟩ := isPreconnected_closed_iff.mp hS _ _ (hC i hi) hclo hcov' hiS
    ⟨x, hxj, mem_iUnion₂.mpr ⟨j, ⟨hj, hij.symm⟩, hxj'⟩⟩
  obtain ⟨k, ⟨hk, hki⟩, hyk⟩ := mem_iUnion₂.mp hyo
  exact ⟨i, hi, k, hk, Ne.symm hki, y, ⟨hyS, hyi⟩, hyk⟩

/-- A component of an open set has its frontier off the set (in the set's complement). -/
theorem frontier_connectedComponentIn_subset {U : Set ℂ} (hU : IsOpen U) (z : ℂ) :
    frontier (connectedComponentIn U z) ⊆ Uᶜ := by
  intro x hx hxU
  have hxo : IsOpen (connectedComponentIn U x) := hU.connectedComponentIn
  obtain ⟨y, hyx, hyz⟩ := mem_closure_iff.mp hx.1 _ hxo (mem_connectedComponentIn hxU)
  have heq : connectedComponentIn U z = connectedComponentIn U x := by
    rw [connectedComponentIn_eq hyz, ← connectedComponentIn_eq hyx]
  apply hx.2
  rw [heq, hxo.interior_eq]
  exact mem_connectedComponentIn hxU

/-- The complement of a component of the complement of a closed preconnected set is preconnected. -/
theorem isPreconnected_compl_connectedComponentIn {K : Set ℂ} (hK : IsClosed K) (hK' : IsPreconnected K) (z : ℂ) :
    IsPreconnected (connectedComponentIn Kᶜ z)ᶜ := by
  rcases K.eq_empty_or_nonempty with rfl | ⟨x₀, hx₀⟩
  · simp only [compl_empty, connectedComponentIn_univ, PreconnectedSpace.connectedComponent_eq_univ]
    simpa using isPreconnected_empty
  set C := connectedComponentIn Kᶜ z with hCdef
  have hKC : K ⊆ Cᶜ := fun x hx hxC => connectedComponentIn_subset _ _ hxC hx
  refine isPreconnected_of_forall x₀ fun y hy => ?_
  by_cases hyK : y ∈ K
  · exact ⟨K, hKC, hx₀, hyK, hK'⟩
  · set D := connectedComponentIn Kᶜ y with hDdef
    have hDo : IsOpen D := hK.isOpen_compl.connectedComponentIn
    have hyD : y ∈ D := mem_connectedComponentIn hyK
    -- `D` is a proper nonempty open set, so it has a frontier point, which lies in `K`
    obtain ⟨p, hp⟩ : (frontier D).Nonempty := by
      rw [nonempty_frontier_iff]
      exact ⟨⟨y, hyD⟩, fun h => (connectedComponentIn_subset _ _ (h ▸ mem_univ x₀ : x₀ ∈ D)) hx₀⟩
    have hpK : p ∈ K := by simpa using frontier_connectedComponentIn_subset hK.isOpen_compl y hp
    have hDC : D ⊆ Cᶜ := by
      intro w hwD hwC
      apply hy
      rw [hCdef, connectedComponentIn_eq hwC, ← connectedComponentIn_eq hwD]
      exact hyD
    have hpre : IsPreconnected (insert p D) :=
      (isPreconnected_connectedComponentIn).subset_closure (subset_insert _ _)
        (insert_subset_iff.mpr ⟨hp.1, subset_closure⟩)
    refine ⟨insert p D ∪ K, union_subset (insert_subset_iff.mpr ⟨hKC hpK, hDC⟩) hKC, Or.inr hx₀,
      Or.inl (Or.inr hyD), ?_⟩
    have h1 : IsPreconnected (insert p D ∪ K) := hpre.union p (mem_insert _ _) hpK hK'
    exact h1

/-- **The frontier of a complementary component is preconnected**. -/
theorem isPreconnected_frontier_connectedComponentIn {K : Set ℂ} (hK : IsClosed K) (hK' : IsPreconnected K) (z : ℂ) :
    IsPreconnected (frontier (connectedComponentIn Kᶜ z)) := by
  have hCo : IsOpen (connectedComponentIn Kᶜ z) := hK.isOpen_compl.connectedComponentIn
  rw [hCo.frontier_eq, sdiff_eq]
  exact isPreconnected_inter_of_union_eq_univ isClosed_closure hCo.isClosed_compl
    isPreconnected_connectedComponentIn.closure (isPreconnected_compl_connectedComponentIn hK hK' z)
    (by rw [eq_univ_iff_forall]; intro x; by_cases hx : x ∈ connectedComponentIn Kᶜ z
        · exact Or.inl (subset_closure hx)
        · exact Or.inr hx)

end HadwigerNelson.Plane
