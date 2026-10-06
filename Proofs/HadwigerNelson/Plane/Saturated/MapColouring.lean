import Proofs.HadwigerNelson.Plane.Saturated.Basic
import Proofs.HadwigerNelson.Plane.Closure
import Proofs.HadwigerNelson.Plane.Diameter
import Proofs.HadwigerNelson.Plane.Slack

/-!
# Map colourings whose edges lie on their own classes' unit parallels: the class `𝒫_k` (FS-131 wave 6)

FS-121's cover route (`data/fs121/claims.md` § 7). The rows read only the open classes of a map colouring and their
closures, so the objects are **families of open sets** `S : Fin k → Set ℂ` with null unit pairs (`F_j = closure (S j)`),
never a planar graph (`plans/FS131-w6-kernel-plan.md` §§ 2, 3.3):

* `x` is **`j`-bound** when `x ∈ unitShadow (closure (S j))` (the unit circle about `x` meets `F_j`; the claim list's
  "i.e." clause).
* `outerParallel K` (`{d_K = 1}`) and `farLevel K` (`{D_K = 1}`), written with explicit bounds so that an empty or
  unbounded `K` reads no junk value.
* `OnLevel F x` — `x` lies on the outer unit parallel or on the far level of a connected component of `F`.
* `SeparatesAt S i m x` — `x` is a point of the common boundary of the colours `i`, `m` near which no other colour has
  closure (a relative-interior point of an edge separating `i` and `m`); `InP S σ` — the class `𝒫_k` under the order
  `σ i < σ m`; `GrundyBound A`.

Rows: **FS121-C1-BOUND** (`bound_iff`, proved, for one open set with null unit pairs); **FS121-C1-GMAP** (i) (`gmap_i`,
proved) and (ii) (`gmap_ii`, proved, for every class `𝒞` of open families in place of "locally finite map colourings");
**FS121-C1-SAT** (`sat_inP`, `sat_noPar`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-! ## Levels of a set -/

/-- The **outer unit parallel** `{d_K = 1}` of `K`: every point of `K` is at distance at least `1`, and some point of
its closure at distance exactly `1`. -/
def outerParallel (K : Set ℂ) : Set ℂ := {x | (∀ p ∈ K, 1 ≤ dist x p) ∧ ∃ p ∈ closure K, dist x p = 1}

/-- The **far level** `{D_K = 1}` of `K`: every point of `K` is at distance at most `1`, and some point of its closure
at distance exactly `1`. -/
def farLevel (K : Set ℂ) : Set ℂ := {x | (∀ p ∈ K, dist x p ≤ 1) ∧ ∃ p ∈ closure K, dist x p = 1}

/-- `x` lies on the outer unit parallel or on the far level of a connected component of `F`. -/
def OnLevel (F : Set ℂ) (x : ℂ) : Prop :=
  ∃ y ∈ F, x ∈ outerParallel (connectedComponentIn F y) ∪ farLevel (connectedComponentIn F y)

/-- Spec: both levels of a point are its unit circle. -/
example (p : ℂ) : outerParallel {p} = sphere p 1 ∧ farLevel {p} = sphere p 1 := by
  constructor <;> ext x <;>
    simp only [outerParallel, farLevel, mem_setOf_eq, mem_singleton_iff, forall_eq, closure_singleton, exists_eq_left,
      mem_sphere_iff_norm, ← dist_eq_norm] <;>
    exact ⟨fun h => h.2, fun h => ⟨by rw [h], h⟩⟩

/-- Spec: no junk at the empty set. -/
example : outerParallel (∅ : Set ℂ) = ∅ ∧ farLevel (∅ : Set ℂ) = ∅ := by
  constructor <;> ext x <;> simp [outerParallel, farLevel]

/-- The support of an open set is its closure. -/
theorem essSupport_eq_closure_of_isOpen {U : Set ℂ} (hU : IsOpen U) : essSupport U = closure U := by
  apply subset_antisymm
  · intro x hx
    rw [Metric.mem_closure_iff]
    intro ε hε
    have h := hx ε hε
    by_contra hne
    push Not at hne
    have hempty : U ∩ ball x ε = ∅ := by
      ext b
      simp only [mem_inter_iff, mem_ball, mem_empty_iff_false, iff_false, not_and, not_lt]
      intro hb
      rw [dist_comm]
      exact hne b hb
    rw [hempty, measure_empty] at h
    exact lt_irrefl _ h
  · rw [essSupport_eq_closure_densitySet]
    exact closure_mono (subset_densitySet_of_isOpen hU)

/-! ## FS121-C1-BOUND -/

/-- **FS121-C1-BOUND**, at the class its argument reads: for an open set `S` with null unit pairs and a point `x` of
its closure, `x` is bound (its unit circle meets `closure S`) if and only if `x` lies on the outer unit parallel or on
the far level of a connected component of `closure S`. No map and no second colour is read; the row's `x ∈ F ∖ S` is
widened to `x ∈ F` (at `x ∈ S` both sides are false). -/
theorem bound_iff {S : Set ℂ} (hS : IsOpen S) (hnull : UnitPairsNull S) {x : ℂ} (hx : x ∈ closure S) :
    x ∈ unitShadow (closure S) ↔ OnLevel (closure S) x := by
  constructor
  · rintro ⟨y, hy, hxy⟩
    refine ⟨y, hy, ?_⟩
    set C := connectedComponentIn (closure S) y with hC
    have hyC : y ∈ C := mem_connectedComponentIn hy
    have hCpre : IsPreconnected C := isPreconnected_connectedComponentIn
    have hCF : C ⊆ closure S := connectedComponentIn_subset _ _
    by_cases hfar : ∀ p ∈ C, dist x p ≤ 1
    · exact Or.inr ⟨hfar, y, subset_closure hyC, hxy⟩
    · by_cases hnear : ∀ p ∈ C, 1 ≤ dist x p
      · exact Or.inl ⟨hnear, y, subset_closure hyC, hxy⟩
      · exfalso
        push Not at hfar hnear
        obtain ⟨p, hpC, hp⟩ := hfar
        obtain ⟨q, hqC, hq⟩ := hnear
        obtain ⟨x', hx', hxx'⟩ := Metric.mem_closure_iff.mp hx (min (dist x p - 1) (1 - dist x q))
          (lt_min (by linarith) (by linarith))
        have h1 : dist x x' < dist x p - 1 := lt_of_lt_of_le hxx' (min_le_left _ _)
        have h2 : dist x x' < 1 - dist x q := lt_of_lt_of_le hxx' (min_le_right _ _)
        have hq' : dist x' q < 1 := by
          have t := dist_triangle x' x q
          rw [dist_comm x' x] at t
          linarith
        have hne : ∀ s ∈ C, dist x' s ≠ 1 := fun s hs => dist_ne_one_of_mem_of_mem_closure hS hnull hx' (hCF hs)
        have hp' := dist_lt_one_of_isPreconnected hCpre hqC hq' hne p hpC
        have t := dist_triangle x x' p
        linarith
  · rintro ⟨y, hy, h⟩
    have hcl : closure (connectedComponentIn (closure S) y) ⊆ closure S :=
      closure_minimal (connectedComponentIn_subset _ _) isClosed_closure
    rcases h with ⟨-, p, hp, hxp⟩ | ⟨-, p, hp, hxp⟩
    · exact ⟨p, hcl hp, hxp⟩
    · exact ⟨p, hcl hp, hxp⟩

/-! ## The class `𝒫_k` -/

/-- `x` is a relative-interior point of the common boundary of the colours `i` and `m`: it lies in the closures of
both classes, and near it no other class has closure. -/
def SeparatesAt (S : Fin k → Set ℂ) (i m : Fin k) (x : ℂ) : Prop :=
  x ∈ closure (S i) ∩ closure (S m) ∧ ∃ r > 0, ball x r ⊆ closure (S i) ∪ closure (S m)

/-- The class **`𝒫_k`** under the order `σ i < σ m` of the colours: every point separating colours `i` before `m`
lies on the outer unit parallel or on the far level of a connected component of `F_i = closure (S i)`. -/
def InP (S : Fin k → Set ℂ) (σ : Equiv.Perm (Fin k)) : Prop :=
  ∀ i m, σ i < σ m → ∀ x, SeparatesAt S i m x → OnLevel (closure (S i)) x

/-- A **Grundy-bound** family: an admissible cover with almost disjoint classes in which every point of the support of
`A m` is at distance exactly `1` from the support of `A i`, for every `i < m`. -/
def GrundyBound (A : Fin k → Set ℂ) : Prop :=
  IsAeCover A ∧ (∀ i j, i ≠ j → volume (A i ∩ A j) = 0) ∧
    ∀ i m, i < m → essSupport (A m) ⊆ unitShadow (essSupport (A i))

/-- **`𝒫_k` is empty on a class `𝒞`** of families (C121-NOPAR is this at `k = 6` for the locally finite map
colourings). -/
def NoPar (𝒞 : (Fin k → Set ℂ) → Prop) : Prop := ∀ S, 𝒞 S → ∀ σ, ¬ InP S σ

/-- **G-FIN on a class `𝒞`** (G-FIN₆ is this at `k = 6` for the locally finite map colourings): if an a.e.-proper
measurable `k`-colouring exists, some Grundy-bound family is almost everywhere equal to a member of `𝒞`. -/
def GFin (𝒞 : (Fin k → Set ℂ) → Prop) : Prop :=
  Nonempty (AeColouring k) → ∃ A S, GrundyBound A ∧ 𝒞 S ∧ ∀ j, A j =ᵐ[volume] S j

/-- Spec for `SeparatesAt`: a point with a third colour's closure nearby does not separate — here no point separates
two empty classes. -/
example (x : ℂ) : ¬ SeparatesAt (fun _ : Fin 2 => (∅ : Set ℂ)) 0 1 x := by
  rintro ⟨⟨h, -⟩, -⟩
  simp at h

/-! ## FS121-C1-GMAP -/

/-- **FS121-C1-GMAP (i)**, at the class its argument reads: a Grundy-bound family almost everywhere equal to a family
of open sets with null unit pairs puts that family in `𝒫_k` under the order `1 < 2 < … < k`. (Read: every point of
`F_m` is `i`-bound for `i < m`, then `bound_iff`; of the map only the open classes.) -/
theorem gmap_i {S A : Fin k → Set ℂ} (hS : ∀ j, IsOpen (S j)) (hnull : ∀ j, UnitPairsNull (S j))
    (hAS : ∀ j, A j =ᵐ[volume] S j) (hA : GrundyBound A) : InP S (Equiv.refl _) := by
  intro i m him x hsep
  have hsupp : ∀ j, essSupport (A j) = closure (S j) := fun j => by
    rw [← essSupport_eq_closure_of_isOpen (hS j)]
    exact subset_antisymm (essSupport_mono_ae (hAS j).le) (essSupport_mono_ae (hAS j).symm.le)
  have hb : x ∈ unitShadow (closure (S i)) := by
    rw [← hsupp i]
    exact hA.2.2 i m him (by rw [hsupp m]; exact hsep.1.2)
  exact (bound_iff (hS i) (hnull i) hsep.1.1).1 hb

/-- **FS121-C1-GMAP (ii)**, for every class `𝒞` of families of open sets with null unit pairs: if `𝒫_6` is empty on
`𝒞`, then G-FIN on `𝒞` holds if and only if `χ_m⁰(ℝ²) ≥ 7`. With `𝒞` the locally finite map colourings this is the
row: C121-NOPAR and G-FIN₆ are the two named open statements, hypotheses here and proved nowhere. -/
theorem gmap_ii (𝒞 : (Fin 6 → Set ℂ) → Prop)
    (h𝒞 : ∀ S, 𝒞 S → (∀ j, IsOpen (S j)) ∧ ∀ j, UnitPairsNull (S j)) (hNoPar : NoPar 𝒞) :
    GFin 𝒞 ↔ (7 : ℕ∞) ≤ chiM0 := by
  constructor
  · intro hG
    by_contra hlt
    rw [not_le] at hlt
    have h6 : chiM0 ≤ ((6 : ℕ) : ℕ∞) := by
      have : chiM0 < ((6 : ℕ) : ℕ∞) + 1 := by norm_num; exact hlt
      exact Order.le_of_lt_add_one this
    obtain ⟨c, -⟩ := (exists_tight_iff_chiM0_le (k := 6)).2 h6
    obtain ⟨A, S, hA, hS, hAS⟩ := hG ⟨c⟩
    exact hNoPar S hS _ (gmap_i (h𝒞 S hS).1 (h𝒞 S hS).2 hAS hA)
  · intro h7 ⟨c⟩
    exact absurd (h7.trans (chiM0_le c)) (by norm_num)

/-! ## FS121-C1-SAT -/

/-- **FS121-C1-SAT**, first clause: a plane map bounded by segments and circular arcs (an `ArcMap`: locally finitely
many of them) whose classes `F.region j` are those of a saturated colouring `c` up to null sets is in `𝒫_k` under
every order of its colours. (Validity of the map is not a hypothesis: open classes almost everywhere equal to classes
with null unit pairs have none, `UnitPairsNull.congr_ae`.) -/
theorem sat_inP (F : ArcMap k) (hF : F.IsPlaneMap) (c : AeColouring k)
    (hc : ∀ j, c.cls j =ᵐ[volume] F.region j) (hsat : Saturated c.cls) (σ : Equiv.Perm (Fin k)) :
    InP F.region σ := by
  sorry

/-- **FS121-C1-SAT**, the "so" clause: if `𝒫_6` is empty on a class `𝒞` containing the classes of every valid plane
map bounded by segments and circular arcs (C121-NOPAR, a named open statement, for the locally finite map
colourings), no saturated six-colouring is almost everywhere equal to such a map. A refutation; its hypotheses without
`hNoPar` are `sat_inP`'s, whose satisfiability at `k = 6` is the open question (at `k = 7`: R7). -/
theorem sat_noPar (𝒞 : (Fin 6 → Set ℂ) → Prop) (hNoPar : NoPar 𝒞) (F : ArcMap 6) (hF : F.IsPlaneMap)
    (h𝒞 : 𝒞 F.region) (c : AeColouring 6) (hc : ∀ j, c.cls j =ᵐ[volume] F.region j) (hsat : Saturated c.cls) :
    False :=
  hNoPar _ h𝒞 (Equiv.refl _) (sat_inP F hF c hc hsat _)

end HadwigerNelson.Plane
