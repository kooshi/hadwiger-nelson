import Mathlib.Topology.Homotopy.Lifting
import Mathlib.Analysis.Complex.CoveringMap
import Mathlib.Topology.Connected.LocallyConnected
import Mathlib.Topology.UrysohnsLemma
import Mathlib.Topology.Homotopy.Contractible
import Mathlib.Analysis.Convex.Contractible
import Proofs.HadwigerNelson.Plane.Basic

/-!
# Plane topology: unicoherence, the frontier of a complementary component, and the crossing of continua in a disc

The plane topology wave 5's planar leaves read (job FS131-KP, `plans/FS131-planar-kernel-plan.md` § 3), none of it in Mathlib at the pin
(grep, 2026-10-04: no unicoherence, Janiszewski, Jordan curve or frontier-of-component lemma). Pure topology of `ℂ`; no map.

* `isPreconnected_inter_of_union_eq_univ` — **the plane is unicoherent**: two closed preconnected sets covering `ℂ` meet in a preconnected
  set. Proved (FS131-IP1) through Mathlib's lifting theorem for the covering `Complex.exp : ℂ → ℂ ∖ {0}` over the simply connected `ℂ`
  (`IsCoveringMap.existsUnique_continuousMap_lifts`, `Complex.isCoveringMap_exp`), not imported.
* `isPreconnected_frontier_connectedComponentIn` — **the frontier of a component of the complement of a closed preconnected set is
  preconnected** (the home theorem of FS131-E4's E4-RIM and E4-OUTERMOST: "the frontier of the unbounded complementary component of a plane
  continuum is connected"), from unicoherence with `A = cl C`, `B = Cᶜ`.
* `exists_inter_of_finite_closed_cover` — a preconnected set covered by finitely many closed sets, two of which meet it, has a point in two of
  them (E4-RIM step 4).
* `isPreconnected_compl_closedBall` — the complement of a closed disc is preconnected (one unbounded complementary component).
* `inter_nonempty_of_interleaved` — **two continua in a closed disc joining interleaved points of its circle meet** (`retArcs_nested`).
  Proved (FS131-IX1) from the crossing for paths, `exists_eq_of_interleaved_paths` (a lift through `exp` over the parameter square),
  and an approximation of each continuum by a path in its thickening, pushed into the disc by `discRetract`.
  `inter_nonempty_of_interleaved_of_isClosed_left`: the same with only one of the two continua closed.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Topology Metric

/-- A continuous real function taking integer values on a preconnected set is constant there (an intermediate value `n + 1/2`
would be an integer). Unicoherence's counting step. -/
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

/-- **The plane is unicoherent**: if two closed preconnected sets cover `ℂ`, their intersection is preconnected. Proof (plan
§ 3.2's, through `ℂ ∖ {0}` in place of `Circle`): were `A ∩ B = P ∪ Q` with `P`, `Q` disjoint, closed, nonempty, a Urysohn function
`φ : ℂ → [0, 1]` (`0` on `P`, `1` on `Q`, `exists_continuous_zero_one_of_isClosed`) gives a continuous `g : ℂ → ℂ ∖ {0}`, `g = exp(2πiφ)` on
`A` and `1` on `B` (they agree on `A ∩ B`, where `φ ∈ {0, 1}`); `ℂ` is simply connected, so `g` lifts through `exp`
(`IsCoveringMap.existsUnique_continuousMap_lifts`) to `G : ℂ → ℂ`; `ψ = Im G / 2π` is integer-valued on the preconnected `B`, hence constant
there, and `ψ − φ` integer-valued on the preconnected `A`, hence constant; at a point of `P` and one of `Q`, `0 = 1`. Formalized here; no
`axiom`. -/
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

/-- A preconnected set meeting `t` and its complement meets `t`'s frontier (else `interior t` and `(closure t)ᶜ` cut it). -/
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

/-- The frontier of a component of an open set lies off the set: a frontier point inside `U` has its own component, open, meeting the
first, hence equal to it, so the point would be interior. -/
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

/-- The complement of a component of the complement of a closed preconnected set is preconnected: it is `K` with every other component
added, and each other component's closure meets `K` (its frontier lies in `K` and is nonempty, `ℂ` being connected). -/
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

/-- **The frontier of a complementary component is preconnected** (unicoherence; Janiszewski's form for one continuum): for `K` closed and
preconnected and `C` a component of `Kᶜ`, `frontier C = cl C ∩ Cᶜ` is the intersection of two closed preconnected sets covering `ℂ`
(`C` is open, `ℂ` locally connected). FS131-E4's home theorem, read there and proved here. -/
theorem isPreconnected_frontier_connectedComponentIn {K : Set ℂ} (hK : IsClosed K) (hK' : IsPreconnected K) (z : ℂ) :
    IsPreconnected (frontier (connectedComponentIn Kᶜ z)) := by
  have hCo : IsOpen (connectedComponentIn Kᶜ z) := hK.isOpen_compl.connectedComponentIn
  rw [hCo.frontier_eq, sdiff_eq]
  exact isPreconnected_inter_of_union_eq_univ isClosed_closure hCo.isClosed_compl
    isPreconnected_connectedComponentIn.closure (isPreconnected_compl_connectedComponentIn hK hK' z)
    (by rw [eq_univ_iff_forall]; intro x; by_cases hx : x ∈ connectedComponentIn Kᶜ z
        · exact Or.inl (subset_closure hx)
        · exact Or.inr hx)

/-- **Two of finitely many closed sets meet on a preconnected set they cover** (E4-RIM step 4): if `S` is preconnected, covered by the
closed sets `C i`, `i ∈ s` finite, and two distinct indices meet `S`, then two distinct indices meet at a point of `S` (else `C i ∩ S` and
the union of the others cut `S`). -/
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

/-- The complement of a closed disc in `ℂ` is preconnected (the image of `(R, ∞) × ℝ` under polar coordinates, as
`isPreconnected_holedAnnulus`). So a bounded set has exactly one unbounded complementary component. -/
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

/-- An unbounded component of the complement of a set inside `B̄(0, R)` holds the whole complement of `B̄(0, R)` (which is preconnected
and which the component meets). -/
theorem compl_closedBall_subset_connectedComponentIn {K : Set ℂ} {R : ℝ} (hKR : K ⊆ closedBall 0 R) {z : ℂ}
    (hz : ¬ Bornology.IsBounded (connectedComponentIn Kᶜ z)) : (closedBall (0 : ℂ) R)ᶜ ⊆ connectedComponentIn Kᶜ z := by
  have hsub : (closedBall (0 : ℂ) R)ᶜ ⊆ Kᶜ := compl_subset_compl.mpr hKR
  obtain ⟨y, hyC, hyR⟩ : ∃ y ∈ connectedComponentIn Kᶜ z, y ∉ closedBall (0 : ℂ) R := by
    by_contra h
    push Not at h
    exact hz (isBounded_closedBall.subset h)
  have h1 := (isPreconnected_compl_closedBall 0 R).subset_connectedComponentIn hyR hsub
  rwa [← connectedComponentIn_eq hyC] at h1

/-- **The last exit** (E4-RIM step 3, E4-OUTERMOST steps 3 and 5): if the frontier of an unbounded component `W` of `Kᶜ` (`K` closed and
bounded) lies in a closed set `R`, every point off `W` and off `R` lies in a bounded component of `Rᶜ` — an unbounded one would meet `W` (far
away) and its complement, hence `frontier W ⊆ R` (`IsPreconnected.inter_frontier_nonempty`). -/
theorem isBounded_connectedComponentIn_of_frontier_subset {K R : Set ℂ} (_hK : IsClosed K) (hKb : Bornology.IsBounded K)
    (_hR : IsClosed R) {z : ℂ} (hW : ¬ Bornology.IsBounded (connectedComponentIn Kᶜ z))
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

/-- For a bounded set, two unbounded complementary components coincide (each meets the preconnected complement of a large closed disc). -/
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

/-! ### The crossing lemma (FS131-IX1)

Paths first, then continua. Two paths in `B̄(u, 1)` joining interleaved circle points meet (`exists_eq_of_interleaved_paths`): were they
disjoint, `x + iy ↦ γ(x) − γ'(y)` would lift through `exp` over the simply connected `ℂ`, and the change of its argument around the unit
square, computed edge by edge from principal arguments, is `−2π`, not `0`. Two disjoint continua would have disjoint `δ`-thickenings, and
paths in the `δ/2`-thickenings pushed into the disc by the radial retraction `discRetract` would be disjoint paths of that kind. -/

/-- `e θ · e (−θ) = 1`. -/
theorem e_mul_e_neg (θ : ℝ) : e θ * e (-θ) = 1 := by
  rw [← e_add, add_neg_cancel]; simp [e]

/-- The principal argument of `1 − e x` for `0 < x < 2π` is `(x − π)/2`: `1 − e x = 2 cos θ · e θ` with `θ = (x − π)/2 ∈ (−π/2, π/2)`. -/
theorem arg_one_sub_e {x : ℝ} (h0 : 0 < x) (h1 : x < 2 * π) : arg (1 - e x) = (x - π) / 2 := by
  set θ := (x - π) / 2 with hθ
  have hx : x = 2 * θ + π := by rw [hθ]; ring
  have hc : 0 < Real.cos θ := Real.cos_pos_of_mem_Ioo ⟨by rw [hθ]; linarith, by rw [hθ]; linarith⟩
  have key : 1 - e x = ((2 * Real.cos θ : ℝ) : ℂ) * (Complex.cos θ + Complex.sin θ * I) := by
    rw [hx, e_eq, Real.cos_add_pi, Real.sin_add_pi, Real.cos_two_mul, Real.sin_two_mul]
    push_cast; ring
  rw [key, Complex.arg_mul_cos_add_sin_mul_I (by linarith)
    ⟨by rw [hθ]; linarith [Real.pi_pos], by rw [hθ]; linarith⟩]

/-- The principal argument of `1 − e x` for `−2π < x < 0` is `(x + π)/2` (`arg_one_sub_e` at `x + 2π`). -/
theorem arg_one_sub_e_of_neg {x : ℝ} (h0 : -(2 * π) < x) (h1 : x < 0) : arg (1 - e x) = (x + π) / 2 := by
  rw [← e_add_two_pi, arg_one_sub_e (by linarith) (by linarith)]; ring

/-- **A point of the closed disc other than `r(θ)` sees `r(θ)` in an open half-plane**: `(r(θ) − z) · e(−θ)` has positive real part,
since it is `1 − w` with `‖w‖ ≤ 1`, and `Re w = 1` forces `w = 1`, i.e. `z = r(θ)`. -/
theorem re_pos_of_mem_closedBall {u z : ℂ} (hz : z ∈ closedBall u 1) {θ : ℝ} (hne : z ≠ ringPt u θ) :
    0 < ((ringPt u θ - z) * e (-θ)).re := by
  set w := (z - u) * e (-θ) with hw
  have hwn : ‖w‖ ≤ 1 := by
    rw [hw, norm_mul, norm_e, mul_one, ← dist_eq_norm]; exact hz
  have heq : (ringPt u θ - z) * e (-θ) = 1 - w := by
    rw [hw, ringPt, ← e_mul_e_neg θ]; ring
  rw [heq, sub_re, one_re, sub_pos]
  by_contra hge
  push Not at hge
  have hre : w.re = ‖w‖ := le_antisymm (re_le_norm w) (by linarith)
  have him : w.im = 0 := by
    by_contra h
    have := Complex.abs_re_lt_norm.mpr h
    rw [abs_of_nonneg (by linarith)] at this
    linarith
  have hw1 : w = 1 := Complex.ext (by simp; linarith [re_le_norm w]) (by simp [him])
  apply hne
  have : z - u = e θ := by
    have h2 : (z - u) * e (-θ) * e θ = e θ := by rw [← hw, hw1, one_mul]
    rwa [mul_assoc, mul_comm (e (-θ)), e_mul_e_neg, mul_one] at h2
  rw [ringPt, ← this]; ring

/-- `(r(a) − r(b)) · e(−a) = 1 − e(b − a)`. -/
theorem ringPt_sub_ringPt_mul_e_neg (u : ℂ) (a b : ℝ) : (ringPt u a - ringPt u b) * e (-a) = 1 - e (b - a) := by
  rw [ringPt, ringPt, sub_eq_add_neg b a, e_add, ← e_mul_e_neg a]; ring

/-- **The argument along an edge**: if `exp ∘ f = κ · v` on `[0, 1]`, with `f`, `v` continuous there and `Re v > 0`, the imaginary part of `f`
changes by `arg (v 1) − arg (v 0)` (`Im f − arg v − Im (log κ)` is a continuous integer multiple of `2π` on `[0, 1]`, hence constant). -/
theorem im_sub_eq_arg_sub {f v : ℝ → ℂ} (hf : ContinuousOn f (Icc 0 1)) (hv : ContinuousOn v (Icc 0 1))
    (hpos : ∀ x ∈ Icc (0 : ℝ) 1, 0 < (v x).re) {κ : ℂ} (hexp : ∀ x ∈ Icc (0 : ℝ) 1, Complex.exp (f x) = κ * v x) :
    (f 1 - f 0).im = arg (v 1) - arg (v 0) := by
  have h0 : (0 : ℝ) ∈ Icc (0 : ℝ) 1 := ⟨le_rfl, zero_le_one⟩
  have h1 : (1 : ℝ) ∈ Icc (0 : ℝ) 1 := ⟨zero_le_one, le_rfl⟩
  have hκ : κ ≠ 0 := by
    rintro rfl
    exact Complex.exp_ne_zero (f 0) (by rw [hexp 0 h0, zero_mul])
  have hv0 : ∀ x ∈ Icc (0 : ℝ) 1, v x ≠ 0 := fun x hx h => by
    have := hpos x hx; rw [h, zero_re] at this; exact lt_irrefl 0 this
  have hslit : ∀ x ∈ Icc (0 : ℝ) 1, v x ∈ slitPlane := fun x hx => mem_slitPlane_iff.mpr (Or.inl (hpos x hx))
  set g : ℝ → ℝ := fun x => (f x - Complex.log (v x) - Complex.log κ).im / (2 * π) with hg
  have hgc : ContinuousOn g (Icc 0 1) := by
    refine ContinuousOn.div_const ?_ _
    exact (Complex.continuous_im.comp_continuousOn ((hf.sub (hv.clog hslit)).sub continuousOn_const))
  have hgint : ∀ x ∈ Icc (0 : ℝ) 1, ∃ n : ℤ, g x = n := by
    intro x hx
    have he : Complex.exp (f x) = Complex.exp (Complex.log κ + Complex.log (v x)) := by
      rw [hexp x hx, Complex.exp_add, Complex.exp_log hκ, Complex.exp_log (hv0 x hx)]
    obtain ⟨n, hn⟩ := Complex.exp_eq_exp_iff_exists_int.mp he
    refine ⟨n, ?_⟩
    simp only [hg, hn]
    have : (Complex.log κ + Complex.log (v x) + ↑n * (2 * ↑π * I) - Complex.log (v x) - Complex.log κ).im
        = n * (2 * π) := by simp; ring
    rw [this]; field_simp
  have := eq_of_intValued_of_isPreconnected isPreconnected_Icc hgc hgint h1 h0
  simp only [hg] at this
  have hπ : (2 * π) ≠ 0 := by positivity
  rw [div_left_inj' hπ] at this
  simp only [sub_im, Complex.log_im] at this
  rw [sub_im]
  linarith

/-- **Two paths in a closed disc joining interleaved points of its circle meet** (the crossing lemma for paths). Were they disjoint,
`Ψ(x + iy) = γ(x) − γ'(y)` (the paths extended by clamping) would be a continuous map `ℂ → ℂ ∖ {0}`, lifting through `exp` to `F` over the
simply connected `ℂ` (`Complex.isCoveringMap_exp.existsUnique_continuousMap_lifts`). On each edge of the unit square one path sits at a
circle point `r(θ)` and the other in `B̄(u, 1) ∖ {r(θ)}`, so `Im F` changes there by a difference of principal arguments
(`re_pos_of_mem_closedBall`, `im_sub_eq_arg_sub`, `arg_one_sub_e`): `(t − s)/2 − π`, `(t' − s')/2 − π`, `(t − s)/2`, `(t' − s')/2`. Around
the square these sum to `−2π`, while the corner values of `F` telescope to `0`. -/
theorem exists_eq_of_interleaved_paths {u : ℂ} {s s' t t' : ℝ} (h₁ : s < s') (h₂ : s' < t) (h₃ : t < t')
    (h₄ : t' < s + 2 * π) (γ : Path (ringPt u s) (ringPt u t)) (γ' : Path (ringPt u s') (ringPt u t'))
    (hγ : ∀ x, γ x ∈ closedBall u 1) (hγ' : ∀ y, γ' y ∈ closedBall u 1) : ∃ x y, γ x = γ' y := by
  by_contra hne
  push Not at hne
  have hext : ∀ r : ℝ, ∃ x, γ x = γ.extend r := fun r => by
    have h : γ.extend r ∈ range γ := γ.extend_range ▸ mem_range_self r
    exact h
  have hext' : ∀ r : ℝ, ∃ y, γ' y = γ'.extend r := fun r => by
    have h : γ'.extend r ∈ range γ' := γ'.extend_range ▸ mem_range_self r
    exact h
  have hD : ∀ r, γ.extend r ∈ closedBall u 1 := fun r => by obtain ⟨x, hx⟩ := hext r; rw [← hx]; exact hγ x
  have hD' : ∀ r, γ'.extend r ∈ closedBall u 1 := fun r => by
    obtain ⟨y, hy⟩ := hext' r; rw [← hy]; exact hγ' y
  have hne' : ∀ r r', γ.extend r ≠ γ'.extend r' := fun r r' => by
    obtain ⟨x, hx⟩ := hext r; obtain ⟨y, hy⟩ := hext' r'; rw [← hx, ← hy]; exact hne x y
  set Ψ : ℂ → ℂ := fun z => γ.extend z.re - γ'.extend z.im with hΨ
  have hΨc : Continuous Ψ :=
    (γ.extend.continuous.comp Complex.continuous_re).sub (γ'.extend.continuous.comp Complex.continuous_im)
  have hΨ0 : ∀ z, Ψ z ≠ 0 := fun z => sub_ne_zero.mpr (hne' _ _)
  let f : C(ℂ, {z : ℂ // z ≠ 0}) := ⟨fun z => ⟨Ψ z, hΨ0 z⟩, hΨc.subtype_mk _⟩
  obtain ⟨F, ⟨-, hF⟩, -⟩ := Complex.isCoveringMap_exp.existsUnique_continuousMap_lifts f 0 (Complex.log (Ψ 0))
    (by ext; simp [f, Complex.exp_log (hΨ0 0)])
  have hFexp : ∀ z, Complex.exp (F z) = Ψ z := by
    intro z
    have := congrArg Subtype.val (congrFun hF z)
    simpa [f] using this
  have hΨpt : ∀ x y : ℝ, Ψ (↑x + ↑y * I) = γ.extend x - γ'.extend y := fun x y => by simp [hΨ]
  -- edge 1: `y = 0`, `x` from `0` to `1`
  have e1 := im_sub_eq_arg_sub (f := fun x : ℝ => F (↑x + ↑(0 : ℝ) * I))
    (v := fun x => (ringPt u s' - γ.extend x) * e (-s')) (κ := -e s')
    (F.continuous.comp (by fun_prop)).continuousOn
    ((continuous_const.sub γ.extend.continuous).mul continuous_const).continuousOn
    (fun x _ => re_pos_of_mem_closedBall (hD x) (by rw [← γ'.extend_zero]; exact hne' x 0))
    (fun x _ => by
      rw [hFexp, hΨpt, γ'.extend_zero,
        show -e s' * ((ringPt u s' - γ.extend x) * e (-s')) = -(ringPt u s' - γ.extend x) * (e s' * e (-s')) by ring,
        e_mul_e_neg]; ring)
  -- edge 2: `x = 1`, `y` from `0` to `1`
  have e2 := im_sub_eq_arg_sub (f := fun y : ℝ => F (↑(1 : ℝ) + ↑y * I))
    (v := fun y => (ringPt u t - γ'.extend y) * e (-t)) (κ := e t)
    (F.continuous.comp (by fun_prop)).continuousOn
    ((continuous_const.sub γ'.extend.continuous).mul continuous_const).continuousOn
    (fun y _ => re_pos_of_mem_closedBall (hD' y) (by rw [← γ.extend_one]; exact (hne' 1 y).symm))
    (fun y _ => by
      rw [hFexp, hΨpt, γ.extend_one,
        show e t * ((ringPt u t - γ'.extend y) * e (-t)) = (ringPt u t - γ'.extend y) * (e t * e (-t)) by ring,
        e_mul_e_neg]; ring)
  -- edge 3: `y = 1`, `x` from `0` to `1`
  have e3 := im_sub_eq_arg_sub (f := fun x : ℝ => F (↑x + ↑(1 : ℝ) * I))
    (v := fun x => (ringPt u t' - γ.extend x) * e (-t')) (κ := -e t')
    (F.continuous.comp (by fun_prop)).continuousOn
    ((continuous_const.sub γ.extend.continuous).mul continuous_const).continuousOn
    (fun x _ => re_pos_of_mem_closedBall (hD x) (by rw [← γ'.extend_one]; exact hne' x 1))
    (fun x _ => by
      rw [hFexp, hΨpt, γ'.extend_one,
        show -e t' * ((ringPt u t' - γ.extend x) * e (-t')) = -(ringPt u t' - γ.extend x) * (e t' * e (-t')) by ring,
        e_mul_e_neg]; ring)
  -- edge 4: `x = 0`, `y` from `0` to `1`
  have e4 := im_sub_eq_arg_sub (f := fun y : ℝ => F (↑(0 : ℝ) + ↑y * I))
    (v := fun y => (ringPt u s - γ'.extend y) * e (-s)) (κ := e s)
    (F.continuous.comp (by fun_prop)).continuousOn
    ((continuous_const.sub γ'.extend.continuous).mul continuous_const).continuousOn
    (fun y _ => re_pos_of_mem_closedBall (hD' y) (by rw [← γ.extend_zero]; exact (hne' 0 y).symm))
    (fun y _ => by
      rw [hFexp, hΨpt, γ.extend_zero,
        show e s * ((ringPt u s - γ'.extend y) * e (-s)) = (ringPt u s - γ'.extend y) * (e s * e (-s)) by ring,
        e_mul_e_neg]; ring)
  simp only [γ.extend_zero, γ.extend_one, γ'.extend_zero, γ'.extend_one, ringPt_sub_ringPt_mul_e_neg] at e1 e2 e3 e4
  rw [arg_one_sub_e (by linarith) (by linarith), arg_one_sub_e_of_neg (by linarith) (by linarith)] at e1
  rw [arg_one_sub_e (by linarith) (by linarith), arg_one_sub_e_of_neg (by linarith) (by linarith)] at e2
  rw [arg_one_sub_e_of_neg (by linarith) (by linarith), arg_one_sub_e_of_neg (by linarith) (by linarith)] at e3
  rw [arg_one_sub_e (by linarith) (by linarith), arg_one_sub_e (by linarith) (by linarith)] at e4
  simp only [sub_im] at e1 e2 e3 e4
  linarith [Real.pi_pos]

/-- The radial retraction of `ℂ` onto `B̄(u, 1)`: `z ↦ u + (z − u)/max(1, ‖z − u‖)`. -/
noncomputable def discRetract (u z : ℂ) : ℂ := u + (((max 1 ‖z - u‖)⁻¹ : ℝ) : ℂ) * (z - u)

/-- The radial retraction is continuous. -/
theorem continuous_discRetract (u : ℂ) : Continuous (discRetract u) := by
  have hm : ∀ z : ℂ, max 1 ‖z - u‖ ≠ 0 := fun z => (lt_of_lt_of_le one_pos (le_max_left _ _)).ne'
  exact continuous_const.add ((Complex.continuous_ofReal.comp
    ((continuous_const.max (continuous_norm.comp (continuous_id.sub continuous_const))).inv₀ hm)).mul
    (continuous_id.sub continuous_const))

/-- The radial retraction lands in `B̄(u, 1)`. -/
theorem discRetract_mem (u z : ℂ) : discRetract u z ∈ closedBall u 1 := by
  have hm : 0 < max 1 ‖z - u‖ := lt_of_lt_of_le one_pos (le_max_left _ _)
  rw [mem_closedBall, dist_eq_norm, discRetract, add_sub_cancel_left, norm_mul, Complex.norm_real,
    Real.norm_of_nonneg (inv_nonneg.mpr hm.le), inv_mul_le_iff₀ hm, mul_one]
  exact le_max_right _ _

/-- The radial retraction fixes `B̄(u, 1)`. -/
theorem discRetract_of_mem {u z : ℂ} (hz : z ∈ closedBall u 1) : discRetract u z = z := by
  rw [mem_closedBall, dist_eq_norm] at hz
  rw [discRetract, max_eq_left hz]; simp

/-- The radial retraction moves a point at most its distance to any point `k` of the disc, so `dist (ρ z) k ≤ 2 dist z k`. -/
theorem dist_discRetract_le {u k : ℂ} (hk : k ∈ closedBall u 1) (z : ℂ) :
    dist (discRetract u z) k ≤ 2 * dist z k := by
  by_cases h : ‖z - u‖ ≤ 1
  · rw [discRetract_of_mem (by rwa [mem_closedBall, dist_eq_norm])]
    linarith [dist_nonneg (x := z) (y := k)]
  · push Not at h
    set n := ‖z - u‖ with hn
    have hn0 : 0 < n := by linarith
    have hdz : dist (discRetract u z) z = n - 1 := by
      have : discRetract u z - z = (((n⁻¹ - 1 : ℝ)) : ℂ) * (z - u) := by
        rw [discRetract, max_eq_right h.le]; push_cast; ring
      rw [dist_eq_norm, this, norm_mul, Complex.norm_real, ← hn, Real.norm_eq_abs,
        abs_of_nonpos (by rw [sub_nonpos]; exact inv_le_one_of_one_le₀ h.le)]
      field_simp
      ring
    have hku : ‖k - u‖ ≤ 1 := by rwa [mem_closedBall, dist_eq_norm] at hk
    have htri : n ≤ dist z k + ‖k - u‖ := by
      rw [hn, dist_eq_norm]
      calc ‖z - u‖ = ‖(z - k) + (k - u)‖ := by ring_nf
        _ ≤ ‖z - k‖ + ‖k - u‖ := norm_add_le _ _
    calc dist (discRetract u z) k ≤ dist (discRetract u z) z + dist z k := dist_triangle _ _ _
      _ ≤ 2 * dist z k := by rw [hdz]; linarith

/-- A thickening of a preconnected set in a real normed space is preconnected (each point lies in a ball about a point of the set, and
the set with that ball is preconnected). -/
theorem isPreconnected_thickening {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] {K : Set E}
    (hK : IsPreconnected K) {δ : ℝ} (hδ : 0 < δ) : IsPreconnected (thickening δ K) := by
  rcases K.eq_empty_or_nonempty with rfl | ⟨x₀, hx₀⟩
  · rw [thickening_empty]; exact isPreconnected_empty
  refine isPreconnected_of_forall x₀ fun y hy => ?_
  obtain ⟨k, hk, hyk⟩ := mem_thickening_iff.mp hy
  refine ⟨K ∪ ball k δ, union_subset (self_subset_thickening hδ K) (ball_subset_thickening hk δ), Or.inl hx₀,
    Or.inr (mem_ball.mpr hyk), ?_⟩
  exact hK.union k hk (mem_ball_self hδ) (convex_ball k δ).isPreconnected

/-- **Two continua in a closed disc joining interleaved points of its circle meet** (the crossing lemma; `retArcs_nested`): `K` holds
`r(s)`, `r(t)` and `K'` holds `r(s')`, `r(t')` with `s < s' < t < t' < s + 2π`. Classical (Newman's θ-curve form of Janiszewski's
theorem). Proved (FS131-IX1) without a separation theorem: disjoint `K`, `K'` (compact) would have disjoint `δ`-thickenings
(`Disjoint.exists_thickenings`); the `δ/2`-thickenings are open and connected (`isPreconnected_thickening`), hence path-connected, so they
hold paths `r(s) ⇝ r(t)` and `r(s') ⇝ r(t')`, which the radial retraction `discRetract` pushes into `B̄(u, 1)` within `δ` of `K` and `K'`
(`dist_discRetract_le`); those paths meet (`exists_eq_of_interleaved_paths`), at a point of both `δ`-thickenings. The planned route through
the Phragmén–Brouwer property was not taken (unicoherence alone gives no separation: FS131-IP1's record § 2.3). -/
theorem inter_nonempty_of_interleaved {u : ℂ} {K K' : Set ℂ} (hK : IsClosed K) (hK' : IsClosed K') (hKc : IsPreconnected K)
    (hK'c : IsPreconnected K') (hKd : K ⊆ closedBall u 1) (hK'd : K' ⊆ closedBall u 1) {s s' t t' : ℝ} (h₁ : s < s') (h₂ : s' < t)
    (h₃ : t < t') (h₄ : t' < s + 2 * π) (hs : ringPt u s ∈ K) (ht : ringPt u t ∈ K) (hs' : ringPt u s' ∈ K')
    (ht' : ringPt u t' ∈ K') : (K ∩ K').Nonempty := by
  by_contra hne
  have hdisj : Disjoint K K' := Set.disjoint_iff_inter_eq_empty.mpr (not_nonempty_iff_eq_empty.mp hne)
  have hKcpt : IsCompact K := isCompact_of_isClosed_isBounded hK (isBounded_closedBall.subset hKd)
  obtain ⟨δ, hδ, hδd⟩ := hdisj.exists_thickenings hKcpt hK'
  have path_of : ∀ {L : Set ℂ}, IsPreconnected L → L ⊆ closedBall u 1 → ∀ {a b : ℝ}, ringPt u a ∈ L →
      ringPt u b ∈ L → ∃ γ : Path (ringPt u a) (ringPt u b), ∀ x, γ x ∈ closedBall u 1 ∧ γ x ∈ thickening δ L := by
    intro L hL hLd a b ha hb
    have hδ2 : 0 < δ / 2 := by linarith
    have hU : IsPathConnected (thickening (δ / 2) L) :=
      (isOpen_thickening.isConnected_iff_isPathConnected).mp
        ⟨⟨_, self_subset_thickening hδ2 L ha⟩, isPreconnected_thickening hL hδ2⟩
    have hj := hU.joinedIn _ (self_subset_thickening hδ2 L ha) _ (self_subset_thickening hδ2 L hb)
    refine ⟨(hj.somePath.map (continuous_discRetract u)).cast (discRetract_of_mem (hLd ha)).symm
      (discRetract_of_mem (hLd hb)).symm, fun x => ⟨discRetract_mem u _, ?_⟩⟩
    obtain ⟨k, hk, hk'⟩ := mem_thickening_iff.mp (hj.somePath_mem x)
    exact mem_thickening_iff.mpr ⟨k, hk, lt_of_le_of_lt (dist_discRetract_le (hLd hk) _) (by linarith)⟩
  obtain ⟨γ, hγ⟩ := path_of hKc hKd hs ht
  obtain ⟨γ', hγ'⟩ := path_of hK'c hK'd hs' ht'
  obtain ⟨x, y, hxy⟩ := exists_eq_of_interleaved_paths h₁ h₂ h₃ h₄ γ γ' (fun x => (hγ x).1) (fun y => (hγ' y).1)
  exact Set.disjoint_left.mp hδd (hγ x).2 (hxy ▸ (hγ' y).2)

/-- **The crossing lemma with only one continuum closed** (a generalization found by FS131-IX1): `K` closed and preconnected, `K'` merely
preconnected, both in `B̄(u, 1)`, joining interleaved circle points, meet. Were they disjoint, `K'` would lie in one path component of
`B̄(u, 1) ∖ K` (relatively open in the locally path-connected disc: a point of it sees the convex `ball z (infDist z K) ∩ B̄(u, 1)`), so a
path in `B̄(u, 1) ∖ K` would join `r(s')` to `r(t')`; its range is a closed preconnected set disjoint from `K`, against
`inter_nonempty_of_interleaved`. -/
theorem inter_nonempty_of_interleaved_of_isClosed_left {u : ℂ} {K K' : Set ℂ} (hK : IsClosed K) (hKc : IsPreconnected K)
    (hK'c : IsPreconnected K') (hKd : K ⊆ closedBall u 1) (hK'd : K' ⊆ closedBall u 1) {s s' t t' : ℝ} (h₁ : s < s') (h₂ : s' < t)
    (h₃ : t < t') (h₄ : t' < s + 2 * π) (hs : ringPt u s ∈ K) (ht : ringPt u t ∈ K) (hs' : ringPt u s' ∈ K')
    (ht' : ringPt u t' ∈ K') : (K ∩ K').Nonempty := by
  by_contra hne
  have hK'K : ∀ w ∈ K', w ∉ K := fun w hw hwK => hne ⟨w, hwK, hw⟩
  set V := closedBall u 1 ∩ Kᶜ with hV
  have hKne : K.Nonempty := ⟨_, hs⟩
  -- a point of `V` is joined in `V` to every point of the disc near it
  have near : ∀ z ∈ V, ∀ w ∈ closedBall u 1, dist w z < infDist z K → JoinedIn V z w := by
    intro z hz w hw hwz
    have hsub : ball z (infDist z K) ∩ closedBall u 1 ⊆ V := fun y hy =>
      ⟨hy.2, fun hyK => (not_lt.mpr (infDist_le_dist_of_mem hyK)) (by rw [dist_comm]; exact hy.1)⟩
    have hz' : z ∈ ball z (infDist z K) ∩ closedBall u 1 :=
      ⟨mem_ball_self ((hK.notMem_iff_infDist_pos hKne).mp hz.2), hz.1⟩
    exact (((convex_ball z _).inter (convex_closedBall u 1)).isPathConnected ⟨z, hz'⟩).joinedIn z hz' w
      ⟨hwz, hw⟩ |>.mono hsub
  set P := {z | JoinedIn V (ringPt u s') z} with hP
  set U₁ := ⋃ z ∈ P, ball z (infDist z K) with hU₁
  set U₂ := ⋃ z ∈ V \ P, ball z (infDist z K) with hU₂
  have hV' : ∀ w ∈ K', w ∈ V := fun w hw => ⟨hK'd hw, hK'K w hw⟩
  have hpos : ∀ z ∈ V, 0 < infDist z K := fun z hz => (hK.notMem_iff_infDist_pos hKne).mp hz.2
  have hcov : K' ⊆ U₁ ∪ U₂ := by
    intro w hw
    by_cases hwP : w ∈ P
    · exact Or.inl (mem_iUnion₂.mpr ⟨w, hwP, mem_ball_self (hpos w (hV' w hw))⟩)
    · exact Or.inr (mem_iUnion₂.mpr ⟨w, ⟨hV' w hw, hwP⟩, mem_ball_self (hpos w (hV' w hw))⟩)
  have hinP : ∀ w ∈ K', w ∈ U₁ → w ∈ P := by
    intro w hw hwU
    obtain ⟨z, hzP, hwz⟩ := mem_iUnion₂.mp hwU
    exact JoinedIn.trans hzP (near z hzP.target_mem w (hK'd hw) hwz)
  have hU₂ : ∀ w ∈ K', w ∈ U₁ → w ∉ U₂ := by
    intro w hw hw1 hw2
    obtain ⟨z, ⟨hzV, hzP⟩, hwz⟩ := mem_iUnion₂.mp hw2
    exact hzP (JoinedIn.trans (hinP w hw hw1) (near z hzV w (hK'd hw) hwz).symm)
  have hsub : K' ⊆ U₁ := by
    have h := hK'c U₁ U₂ (isOpen_biUnion fun _ _ => isOpen_ball) (isOpen_biUnion fun _ _ => isOpen_ball) hcov
    by_contra hnot
    obtain ⟨w, hw, hwU⟩ := not_subset.mp hnot
    obtain ⟨y, hy, hy1, hy2⟩ := h ⟨_, hs', mem_iUnion₂.mpr ⟨_, JoinedIn.refl (hV' _ hs'), mem_ball_self (hpos _ (hV' _ hs'))⟩⟩
      ⟨w, hw, (hcov hw).resolve_left hwU⟩
    exact hU₂ y hy hy1 hy2
  have hj : JoinedIn V (ringPt u s') (ringPt u t') := hinP _ ht' (hsub ht')
  set γ' := hj.somePath
  obtain ⟨z, hzK, hzγ⟩ := inter_nonempty_of_interleaved hK (isCompact_range γ'.continuous).isClosed hKc
    (isPreconnected_range γ'.continuous) hKd (by rintro _ ⟨x, rfl⟩; exact (hj.somePath_mem x).1) h₁ h₂ h₃ h₄ hs ht
    ⟨0, γ'.source⟩ ⟨1, γ'.target⟩
  obtain ⟨x, rfl⟩ := hzγ
  exact (hj.somePath_mem x).2 hzK

/-! ### Spec examples -/

/-- A spec example for `exists_inter_of_finite_closed_cover`: `[0, 2]` covered by `[0, 1]` and `[1, 2]` has a point in both. -/
example : ∃ i' ∈ ({0, 1} : Set ℕ), ∃ j' ∈ ({0, 1} : Set ℕ), i' ≠ j' ∧
    (Icc (0 : ℝ) 2 ∩ (fun i : ℕ => Icc (i : ℝ) (i + 1)) i' ∩ (fun i : ℕ => Icc (i : ℝ) (i + 1)) j').Nonempty :=
  exists_inter_of_finite_closed_cover isPreconnected_Icc (Set.toFinite _) _ (fun _ _ => isClosed_Icc)
    (fun x hx => by
      simp only [mem_insert_iff, mem_singleton_iff, mem_iUnion, exists_prop, exists_eq_or_imp, exists_eq_left]
      rcases le_total x 1 with h | h
      · left; exact ⟨by simpa using hx.1, by simpa using h⟩
      · right; exact ⟨by simpa using h, by have := hx.2; push_cast; linarith⟩)
    (i := 0) (j := 1) (by simp) (by simp) (by norm_num) ⟨0, by simp⟩ ⟨2, by norm_num⟩


/-- A spec example for `discRetract`: the point `2` is pulled onto the unit circle at `1`. -/
example : discRetract 0 2 = 1 := by
  norm_num [discRetract]

/-- A spec example for `arg_one_sub_e`: `1 − e π = 2`, whose argument is `0`. -/
example : arg (1 - e π) = 0 := by
  rw [arg_one_sub_e Real.pi_pos (by linarith [Real.pi_pos])]; ring

/-- **The model of the crossing lemma's hypotheses** (plan § 4.3: two crossing diameters), every hypothesis exercised at once: the diameters
`[r(0), r(π)]` and `[r(π/2), r(3π/2)]` of the unit disc about `0` are closed, preconnected, inside the disc, and join interleaved circle points
`0 < π/2 < π < 3π/2 < 0 + 2π`. -/
example : (segment ℝ (ringPt 0 0) (ringPt 0 π) ∩ segment ℝ (ringPt 0 (π / 2)) (ringPt 0 (3 * π / 2))).Nonempty := by
  have hc : ∀ x y : ℂ, IsClosed (segment ℝ x y) := fun x y => by
    rw [segment_eq_image' ℝ x y]; exact (isCompact_Icc.image (by fun_prop)).isClosed
  exact inter_nonempty_of_interleaved (hc _ _) (hc _ _) (convex_segment _ _).isPreconnected
    (convex_segment _ _).isPreconnected
    ((convex_closedBall 0 1).segment_subset (sphere_subset_closedBall (ringPt_mem_sphere 0 0))
      (sphere_subset_closedBall (ringPt_mem_sphere 0 π)))
    ((convex_closedBall 0 1).segment_subset (sphere_subset_closedBall (ringPt_mem_sphere 0 _))
      (sphere_subset_closedBall (ringPt_mem_sphere 0 _)))
    (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos])
    (left_mem_segment _ _ _) (right_mem_segment _ _ _) (left_mem_segment _ _ _) (right_mem_segment _ _ _)


/-- The model for `inter_nonempty_of_interleaved_of_isClosed_left`: the two crossing diameters again (every hypothesis holds). -/
example : (segment ℝ (ringPt 0 0) (ringPt 0 π) ∩ segment ℝ (ringPt 0 (π / 2)) (ringPt 0 (3 * π / 2))).Nonempty := by
  have hc : IsClosed (segment ℝ (ringPt 0 0) (ringPt 0 π)) := by
    rw [segment_eq_image' ℝ]; exact (isCompact_Icc.image (by fun_prop)).isClosed
  exact inter_nonempty_of_interleaved_of_isClosed_left hc (convex_segment _ _).isPreconnected (convex_segment _ _).isPreconnected
    ((convex_closedBall 0 1).segment_subset (sphere_subset_closedBall (ringPt_mem_sphere 0 _))
      (sphere_subset_closedBall (ringPt_mem_sphere 0 _)))
    ((convex_closedBall 0 1).segment_subset (sphere_subset_closedBall (ringPt_mem_sphere 0 _))
      (sphere_subset_closedBall (ringPt_mem_sphere 0 _)))
    (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos])
    (left_mem_segment _ _ _) (right_mem_segment _ _ _) (left_mem_segment _ _ _) (right_mem_segment _ _ _)

end HadwigerNelson.Plane
