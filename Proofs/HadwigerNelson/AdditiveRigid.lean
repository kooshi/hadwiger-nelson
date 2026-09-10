import Mathlib.Algebra.Group.Subgroup.Basic
import Mathlib.Combinatorics.SimpleGraph.Hasse
import Mathlib.Combinatorics.SimpleGraph.CycleGraph
import Proofs.HadwigerNelson.Additive
import Proofs.HadwigerNelson.OneDefect

/-!
# Additive rigidity: the reduction theorem (M57, D1)

A unit-distance chunk whose proper `k`-colourings are ALL additive forces every pair whose
difference lies in `k·Λ` (L1 applied to each colouring), and a forced pair at distance `≥ 1/2`
bounds the plane's chromatic number by the spindle theorem (`OneDefect.lean`). So a chunk that is
*additively 5-rigid* and holds a `5Λ`-pair at distance `≥ 1/2` proves `χ(ℝ²) ≥ 6` — with no search
for the forcing, only for the additivity. This file states that reduction in the least form that
carries it; its value is as the TARGET statement of the milestone, whose hypotheses are exactly
what the instrument (`tools/additive.py rigid`) must produce.

The carrier is an **address map** `q : ι → V` from the chunk's vertices into a free abelian group
(the lattice; the instrument's integer coordinate matrix is exactly this map) with the graph on
`ι` — no vertex set, no subtype, and the plane consumer already takes an arbitrary `ι`.
A colouring is *additive* when its same-colour relation is the trace, through `q`, of the coset
partition of a subgroup `H` containing `k • V`: Fischer's additive colouring minus his order
condition `|V/H| ∣ k`, which the reduction never reads (only the exponent condition `k • V ⊆ H`
enters, through L1). Every colouring induced by a homomorphism into a group of order `k` — the
instrument's `additive` verdict, and M56's `additiveColoring` — is additive in this sense
(`isAdditive_of_addMonoidHom`, `isAdditive_additiveColoring`). The implication-only form
("constant on `H`-cosets") is NOT the definition: it is equivalent to being `k • V`-periodic,
i.e. to the reduction's conclusion, and would make the theorem a tautology; the second red below
(`pathGraph_not_additivelyRigid_three`) is the example that separates the two.

What this file does NOT claim: "every colouring is additive" is a universal over all colourings,
supplied by an UNTRUSTED enumeration; the theorems here consume it as a hypothesis and certify
nothing about any chunk by themselves. At a jackpot the kernel certificate is the pair's forcing
by refutation (the M34 bridge), never the additivity census. Nothing in this file is search.
-/

namespace HadwigerNelson

open SimpleGraph

variable {ι V G : Type*} [AddCommGroup V] [AddCommGroup G]

/-- A `k`-colouring is *additive* along the addresses `q` — a coset colouring — when its
same-colour relation is the trace of the cosets of some subgroup containing `k • V`. The `↔` is
the content: the implication alone would be the reduction's conclusion in disguise. Sealed;
consumers reason through `IsAdditive.apply_eq` and build instances through
`isAdditive_of_addMonoidHom`. -/
def IsAdditive (q : ι → V) {Γ : SimpleGraph ι} {k : ℕ} (C : Γ.Coloring (Fin k)) : Prop :=
  ∃ H : AddSubgroup V, (∀ v, k • v ∈ H) ∧ ∀ a b, C a = C b ↔ q a - q b ∈ H

/-- `Γ` is *additively `k`-rigid* along `q`: every proper `k`-colouring is additive. This is the
hypothesis the reduction consumes; it is never established in the kernel — it is an untrusted
enumeration's claim about a finite chunk. -/
def AdditivelyRigid (q : ι → V) (Γ : SimpleGraph ι) (k : ℕ) : Prop :=
  ∀ C : Γ.Coloring (Fin k), IsAdditive q C

/-- **The bridge from `Additive.lean`'s vocabulary.** A colouring whose partition is that of a
homomorphism into a group killed by `k` is additive (take `H = ker φ`). This is the instrument's
`additive` verdict (partition equality with an admissible hom's colouring), as a theorem. -/
theorem isAdditive_of_addMonoidHom (q : ι → V) {Γ : SimpleGraph ι} {k : ℕ}
    (C : Γ.Coloring (Fin k)) (φ : V →+ G) (hk : ∀ g : G, k • g = 0)
    (hC : ∀ a b, C a = C b ↔ φ (q a) = φ (q b)) : IsAdditive q C :=
  ⟨φ.ker, fun v => by rw [AddMonoidHom.mem_ker, map_nsmul, hk],
    fun a b => by rw [hC, AddMonoidHom.mem_ker, map_sub, sub_eq_zero]⟩

/-- M56's additive colouring of a graph on the lattice itself (`q = id`) is additive here, for
any `k` that kills the target group — the two files describe one object. -/
theorem isAdditive_additiveColoring (Γ : SimpleGraph V) (φ : V →+ G)
    (h : ∀ a b, Γ.Adj a b → φ (a - b) ≠ 0) {k : ℕ} (hk : ∀ g : G, k • g = 0)
    (e : G ≃ Fin k) : IsAdditive id (recolorOfEquiv Γ e (additiveColoring Γ φ h)) :=
  isAdditive_of_addMonoidHom id _ φ hk fun a b => by
    simp [recolorOfEquiv, additiveColoring_apply, e.injective.eq_iff]

/-- An additive colouring identifies every pair whose addresses differ by `k • w` (L1). -/
theorem IsAdditive.apply_eq {q : ι → V} {Γ : SimpleGraph ι} {k : ℕ} {C : Γ.Coloring (Fin k)}
    (h : IsAdditive q C) {a b : ι} {w : V} (hab : q a - q b = k • w) : C a = C b :=
  let ⟨_, hk, hC⟩ := h
  (hC a b).mpr (hab ▸ hk w)

/-- **The reduction theorem (D1).** On an additively `k`-rigid chunk every pair at a `k·Λ`
difference is forced equal. The rigidity hypothesis is an untrusted enumeration's claim; the
theorem turns it into `Forces`, which the spindle theorem then consumes. -/
theorem forces_of_additivelyRigid {q : ι → V} {Γ : SimpleGraph ι} {k : ℕ}
    (h : AdditivelyRigid q Γ k) {a b : ι} {w : V} (hab : q a - q b = k • w) :
    Forces Γ k a b := fun C => (h C).apply_eq hab

/-- **The plane corollary.** An additively `k`-rigid chunk drawn with unit edges, holding a
`k·Λ`-pair at distance `d ≥ 1/2`, gives `χ(ℝ²) ≥ k + 1` — the spindle theorem composed with
the reduction. The drawing is any map with unit edges; affinity in `q` is never used. -/
theorem add_one_le_chromaticNumber_unitDistance_of_additivelyRigid {q : ι → V}
    {Γ : SimpleGraph ι} {k : ℕ} (h : AdditivelyRigid q Γ k) {a b : ι} {w : V}
    (hab : q a - q b = k • w) (dr : ι → ℂ) (hdr : ∀ i j, Γ.Adj i j → dist (dr i) (dr j) = 1)
    {d : ℝ} (hd : dist (dr a) (dr b) = d) (hhalf : 1 / 2 ≤ d) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber :=
  add_one_le_chromaticNumber_unitDistance_of_forces dr hdr hd hhalf (forces_of_additivelyRigid h hab)

/-- **The target at five colours.** An additively 5-rigid unit-distance chunk with a `5Λ`-pair at
distance `≥ 1/2` proves `χ(ℝ²) ≥ 6`. The hypotheses are the milestone's design specification;
the rigidity among them is never kernel-certified. -/
theorem six_le_chromaticNumber_plane_of_additivelyRigid {q : ι → V} {Γ : SimpleGraph ι}
    (h : AdditivelyRigid q Γ 5) {a b : ι} {w : V} (hab : q a - q b = 5 • w)
    (dr : ι → ℂ) (hdr : ∀ i j, Γ.Adj i j → dist (dr i) (dr j) = 1) {d : ℝ}
    (hd : dist (dr a) (dr b) = d) (hhalf : 1 / 2 ≤ d) :
    (6 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_unitDistance_of_additivelyRigid h hab dr hdr hd hhalf

/-! ## Spec: the unit path of length two, and two planted reds

`pathGraph 3` addressed at `i ↦ (i, 0)` in `ℤ × ℤ` is additively 2-rigid (its only 2-colourings
are the parity colouring up to palette), its endpoints differ by `2 • (1, 0)`, and drawn at unit
spacing they are 2 apart — so the reduction says `χ(ℝ²) ≥ 3`. Nothing new, but a model of every
hypothesis, which is what makes the theorem non-vacuous.

Two reds, one per clause of `IsAdditive`. `cycleGraph 6` addressed by the identity into `ZMod 6`
at three colours has the proper colouring `0 1 0 1 0 2`, which separates `0` from `3 = 3 • 1`;
refuting it uses `k • v ∈ H` and the `←` direction. And at THREE colours the path's addresses
never differ by an element of `3 • V`, so every colouring is `3 • V`-periodic and the
implication-only form would call the path additively 3-rigid — but `0 1 0` is no coset colouring:
refuting it needs the `→` direction, which is why the `↔` is the definition. -/

/-- The path's addresses: `i ↦ (i, 0)`. -/
def pathAddr : Fin 3 → ℤ × ℤ := fun i => ((i : ℕ), 0)

/-- **The non-vacuity witness for everything below about `pathGraph 3` at two colours.** The path
on three vertices is bipartite, so `0 1 0` is proper — and without this, `pathGraph_three_coloring_two`
and `pathGraph_additivelyRigid` would both quantify over a type nothing had shown inhabited
(`CLAUDE.md` `G30`, fifth failure mode; `scripts/vacuity.sh` reads it). -/
theorem pathGraph_three_colorable_two : (pathGraph 3).Colorable 2 :=
  ⟨Coloring.mk (![0, 1, 0] : Fin 3 → Fin 2) (fun {u v} h => by
    rw [pathGraph_adj] at h; revert h; revert u v; decide)⟩

/-- Every proper 2-colouring of the path on three vertices is the parity colouring: it identifies
exactly the pairs of indices with the same parity. -/
theorem pathGraph_three_coloring_two (C : (pathGraph 3).Coloring (Fin 2)) (a b : Fin 3) :
    C a = C b ↔ (a.val + b.val) % 2 = 0 := by
  have h01 : C 0 ≠ C 1 := C.valid (pathGraph_adj.mpr (Or.inl rfl))
  have h12 : C 1 ≠ C 2 := C.valid (pathGraph_adj.mpr (Or.inl rfl))
  have h02 : C 0 = C 2 := by
    revert h01 h12; generalize C 0 = x; generalize C 1 = y; generalize C 2 = z
    revert x y z; decide
  fin_cases a <;> fin_cases b <;> simp_all [eq_comm]

theorem pathGraph_additivelyRigid : AdditivelyRigid pathAddr (pathGraph 3) 2 := fun C =>
  ⟨parity.ker, fun v => by
      rw [AddMonoidHom.mem_ker, map_nsmul]; generalize parity v = x; revert x; decide,
    fun a b => by
      rw [pathGraph_three_coloring_two, AddMonoidHom.mem_ker, map_sub, sub_eq_zero]
      fin_cases a <;> fin_cases b <;> decide⟩

/-- The endpoints are forced equal at two colours — by the reduction, not by looking. -/
example : Forces (pathGraph 3) 2 0 2 :=
  forces_of_additivelyRigid pathGraph_additivelyRigid (w := (-1, 0)) (by decide)

/-- The model of every hypothesis: `χ(ℝ²) ≥ 3` from the path drawn at unit spacing. -/
theorem three_le_chromaticNumber_plane_of_pathGraph :
    (3 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := by
  have h := add_one_le_chromaticNumber_unitDistance_of_additivelyRigid pathGraph_additivelyRigid
    (a := 0) (b := 2) (w := (-1, 0)) (by decide) (fun i => ((i : ℕ) : ℂ))
    (fun i j hij => by
      rcases pathGraph_adj.mp hij with h | h <;> fin_cases i <;> fin_cases j <;>
        simp_all [Complex.dist_eq] <;> norm_num)
    (d := 2) (by norm_num [Complex.dist_eq]) (by norm_num)
  simpa using h

/-- The colouring `0 1 0 1 0 2` of the hexagon, proper by a 36-case decide. -/
def hexColoring : (cycleGraph 6).Coloring (Fin 3) :=
  Coloring.mk (![0, 1, 0, 1, 0, 2] : Fin 6 → Fin 3) (by decide)

/-- The first red, pinning `k • v ∈ H` and the `←` direction: the hexagon is NOT additively
3-rigid — `0 1 0 1 0 2` separates `0` from `3 = 3 • 1`, which every subgroup containing
`3 • ZMod 6` identifies. -/
theorem cycleGraph_six_not_additivelyRigid :
    ¬ AdditivelyRigid (id : ZMod 6 → ZMod 6) (cycleGraph 6) 3 := fun h => by
  obtain ⟨H, hk, hC⟩ := h hexColoring
  have h3 : (3 : ZMod 6) ∈ H := by simpa using hk 1
  have : hexColoring 0 = hexColoring 3 := (hC 0 3).mpr (by simpa using h3)
  exact absurd this (by decide)

/-- The colouring `0 1 0` of the path, proper at three colours. -/
def pathColoring3 : (pathGraph 3).Coloring (Fin 3) :=
  Coloring.mk (![0, 1, 0] : Fin 3 → Fin 3) (fun {u v} h => by
    rw [pathGraph_adj] at h; revert h; revert u v; decide)

/-- The second red, pinning the `→` direction of `IsAdditive`: at three colours the path's
addresses never differ by an element of `3 • V`, so EVERY colouring is `3 • V`-periodic (the
implication form would call the path additively 3-rigid), but `0 1 0` is no coset colouring —
`C 0 = C 2` puts `(-2, 0)` in `H`, `3 • (1, 0)` is in `H`, so `(1, 0)` is, and then `C 0 = C 1`. -/
theorem pathGraph_not_additivelyRigid_three : ¬ AdditivelyRigid pathAddr (pathGraph 3) 3 :=
  fun h => by
    obtain ⟨H, hk, hC⟩ := h pathColoring3
    have h2 : pathAddr 0 - pathAddr 2 ∈ H := (hC 0 2).mp rfl
    have h3 : (3 : ℕ) • ((1 : ℤ), (0 : ℤ)) ∈ H := hk _
    have h1 : pathAddr 0 - pathAddr 1 ∈ H := by
      have := H.neg_mem (H.add_mem h2 h3)
      convert this using 1
      decide
    exact absurd ((hC 0 1).mpr h1) (by decide)

end HadwigerNelson
