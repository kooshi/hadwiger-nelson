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

end HadwigerNelson.Plane
