import Proofs.HadwigerNelson.Rigidity.UsablePrime
import Proofs.HadwigerNelson.Rigidity.RingScope
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected

/-!
# The components of the plane over a real number field (FS-131; planned by FS131-KRU1, proved by FS131-IRU1)

Plan: `plans/FS131-KRU1-ring-plan.md` § 3 (module 4). The asking lane's C8 (`plans/POROS-2026-10-13-number-field-findings.md`
§ 3.3): "in every case the unit-distance graph on `F²` has infinitely many components".

**Read aloud, against the informal claim.** The graph is `(unitDistance ℂ).induce (planeOver F)`: the points of `ℂ` with both
coordinates in `F`, two of them adjacent at distance exactly `1` — `F²` with its unit-distance graph, as in every `χ(F²)` of
the library. `ConnectedComponent` is Mathlib's.

* `reachable_iff_sub_mem_unitRingOver` — **the component lemma** (`[Fischer1990b]` §§ 2–3, "stated in passing"): two points are
  joined by a path exactly when their difference lies in `ℤ[U] = UnitRing.unitRingOver F`, the additive group the unit
  vectors generate. Every subfield `F ⊆ ℝ`.
* `connected_or_infinite_planeOver` — **the dichotomy, every subfield `F ⊆ ℝ`**: the plane is connected or has infinitely many
  components (`F²` is a `ℚ`-vector space, and a subgroup of finite index `d` holds `d·F² = F²`).
* `connected_planeOver_iff_isEmpty_stablePrime` — over a real number field the plane is connected exactly when `F(i)` has no stable
  prime (no stable prime: `O′ = F(i)` and `c·O′ ⊆ ℤ[U]`; a stable prime `P`: `ℤ[U] ⊆ 𝓞_P ≠ F(i)`).
* `infinite_connectedComponent_planeOver` — **C8: at every real number field the plane has infinitely many components**,
  from `Rigidity.nonempty_stablePrime` (`Rigidity/UsablePrime`, no outside theorem).

**Not claimed:** anything about the components' shape beyond being cosets of `ℤ[U]`; anything at a subfield of `ℝ` that is not
a number field beyond the dichotomy (`ℝ` itself is connected).

**Models.** The hypotheses are `NumberField F` or none; `F = ℚ` (`UpperHalf.numberField_bot`) inhabits them.
-/

namespace HadwigerNelson.Rigidity

open SimpleGraph SpectralChain NumberField

variable {F : Subfield ℝ}

/-- **A walk along a sum of unit vectors** (the component lemma's `⟸`, its base point generalized): from any `y ∈ F²`, the
partial sums `y + u₀ + ⋯ + u_j` of unit vectors of `F²` are a path of unit steps. -/
theorem reachable_add_sum {m : ℕ} (u : Fin m → ℂ) (hu : ∀ j, ‖u j‖ = 1) (hF : ∀ j, u j ∈ planeOver F)
    (y : planeOver F) (hy : (y : ℂ) + ∑ j, u j ∈ planeOver F) :
    ((unitDistance ℂ).induce (planeOver F)).Reachable y ⟨(y : ℂ) + ∑ j, u j, hy⟩ := by
  induction m generalizing y with
  | zero =>
    have e : (⟨(y : ℂ) + ∑ j : Fin 0, u j, hy⟩ : planeOver F) = y := Subtype.ext (by simp)
    rw [e]
  | succ m ih =>
    have hz : (y : ℂ) + ∑ j : Fin m, u (Fin.castSucc j) ∈ planeOver F :=
      (Chain.planeOverSubring F).add_mem y.2 ((Chain.planeOverSubring F).sum_mem fun j _ => hF _)
    have h1 := ih (fun j => u (Fin.castSucc j)) (fun j => hu _) (fun j => hF _) y hz
    have hsum : (y : ℂ) + ∑ j, u j = ((y : ℂ) + ∑ j : Fin m, u (Fin.castSucc j)) + u (Fin.last m) := by
      rw [Fin.sum_univ_castSucc, add_assoc]
    have hadj : ((unitDistance ℂ).induce (planeOver F)).Adj ⟨_, hz⟩ ⟨(y : ℂ) + ∑ j, u j, hy⟩ := by
      show dist ((y : ℂ) + ∑ j : Fin m, u (Fin.castSucc j)) ((y : ℂ) + ∑ j, u j) = 1
      rw [_root_.dist_comm, dist_eq_norm, hsum, add_sub_cancel_left]
      exact hu _
    exact h1.trans hadj.reachable

/-- **The component lemma**: two points of `F²` are joined by a path of unit steps exactly when their difference is a
finite sum of unit vectors. -/
theorem reachable_iff_sub_mem_unitRingOver (x y : planeOver F) :
    ((unitDistance ℂ).induce (planeOver F)).Reachable x y ↔ (x : ℂ) - y ∈ UnitRing.unitRingOver F := by
  constructor
  · rintro ⟨p⟩
    induction p with
    | nil => simp
    | @cons a b c hab _ ih =>
      have hab' : dist (a : ℂ) (b : ℂ) = 1 := hab
      have hu : (a : ℂ) - b ∈ UnitRing.unitRingOver F :=
        UnitRing.unit_mem_unitRingOver ((Chain.planeOverSubring F).sub_mem a.2 b.2) (by rw [← dist_eq_norm]; exact hab')
      have e : (a : ℂ) - c = ((a : ℂ) - b) + ((b : ℂ) - c) := by ring
      rw [e]
      exact add_mem hu ih
  · intro h
    obtain ⟨m, u, hu, hF, hs⟩ := UnitRing.exists_sum_eq_of_mem_unitRingOver h
    have hy : (y : ℂ) + ∑ j, u j ∈ planeOver F := by rw [hs, add_sub_cancel]; exact x.2
    have e : (⟨(y : ℂ) + ∑ j, u j, hy⟩ : planeOver F) = x := Subtype.ext (by simp only [hs]; ring)
    have h1 := reachable_add_sum u hu hF y hy
    rw [e] at h1
    exact h1.symm

/-- **Connected exactly when every point of `F²` is a finite sum of unit vectors.** -/
theorem connected_planeOver_iff_subset :
    ((unitDistance ℂ).induce (planeOver F)).Connected ↔ planeOver F ⊆ UnitRing.unitRingOver F := by
  have h0 : (0 : ℂ) ∈ planeOver F := (Chain.planeOverSubring F).zero_mem
  rw [SimpleGraph.connected_iff]
  constructor
  · rintro ⟨hc, -⟩ z hz
    have h := (reachable_iff_sub_mem_unitRingOver ⟨z, hz⟩ ⟨0, h0⟩).1 (hc _ _)
    rwa [sub_zero] at h
  · intro h
    exact ⟨fun x y => (reachable_iff_sub_mem_unitRingOver x y).2 (sub_mem (h x.2) (h y.2)), ⟨⟨0, h0⟩⟩⟩

/-- **A point outside `ℤ[U]` gives infinitely many components**: were there finitely many, `d` of them, the classes of
`z/d` modulo `ℤ[U]` would have order dividing `d`, so `z = d·(z/d) ∈ ℤ[U]`. -/
theorem infinite_connectedComponent_planeOver_of_not_mem {z : ℂ} (hz : z ∈ planeOver F) (hzR : z ∉ UnitRing.unitRingOver F) :
    Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
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
    exact ⟨by simp, by simp [F.zero_mem]⟩
  have hwF : w ∈ planeOver F := by
    rw [hw, div_eq_mul_inv]
    exact (Chain.planeOverSubring F).mul_mem hz hinv
  have hjF : ∀ j : ℕ, (j : ℂ) * w ∈ planeOver F := fun j =>
    (Chain.planeOverSubring F).mul_mem (natCast_mem (Chain.planeOverSubring F) j) hwF
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

/-- **The dichotomy**, every subfield of `ℝ`: the plane over `F` is connected or has infinitely many components. -/
theorem connected_or_infinite_planeOver (F : Subfield ℝ) :
    ((unitDistance ℂ).induce (planeOver F)).Connected ∨
      Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  by_cases h : planeOver F ⊆ UnitRing.unitRingOver F
  · exact Or.inl (connected_planeOver_iff_subset.2 h)
  · obtain ⟨z, hz, hzR⟩ := Set.not_subset.1 h
    exact Or.inr (infinite_connectedComponent_planeOver_of_not_mem hz hzR)

/-- **A stable prime gives infinitely many components**: `ℤ[U] ⊆ 𝓞_P ≠ F(i)` (`UpperHalf.localRing_ne_top`). -/
theorem infinite_connectedComponent_planeOver_of_stablePrime [NumberField F] (P : StablePrime F) :
    Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  obtain ⟨y, hy⟩ : ∃ y : fieldI F, y ∉ P.localRing := by
    by_contra h
    push Not at h
    exact UpperHalf.localRing_ne_top P (eq_top_iff.2 fun y _ => h y)
  have hyR : y ∉ UnitRing.unitRing (conjOn (fieldI_conj F)) := fun hyR =>
    hy ((mem_stableIntegers F).1 (unitRing_le_stableIntegers F hyR) P)
  exact infinite_connectedComponent_planeOver_of_not_mem y.2 fun h => hyR ((UnitRing.coe_mem_unitRingOver_iff y).1 h)

/-- **Connected exactly when `F(i)` has no stable prime** (with no stable prime, `O′ = F(i)` and `c·O′ ⊆ ℤ[U]`,
`Rigidity.exists_mul_stableIntegers_le`, give `ℤ[U] = F(i)`). -/
theorem connected_planeOver_iff_isEmpty_stablePrime [NumberField F] :
    ((unitDistance ℂ).induce (planeOver F)).Connected ↔ IsEmpty (StablePrime F) := by
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
    exact (UnitRing.coe_mem_unitRingOver_iff x).2 hxR

variable (F) in
/-- **The plane over every real number field has infinitely many components** (C8). -/
theorem infinite_connectedComponent_planeOver [NumberField F] :
    Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent :=
  let ⟨P⟩ := nonempty_stablePrime F
  infinite_connectedComponent_planeOver_of_stablePrime P

variable (F) in
/-- **The plane over a real number field is never connected.** -/
theorem not_connected_planeOver [NumberField F] : ¬ ((unitDistance ℂ).induce (planeOver F)).Connected := fun hc =>
  (connected_planeOver_iff_isEmpty_stablePrime.1 hc).false (nonempty_stablePrime F).some

end HadwigerNelson.Rigidity
