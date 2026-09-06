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
instrument's `additive` verdict — is additive in this sense (`isAdditive_of_addMonoidHom`).
The implication-only form ("constant on `H`-cosets") is NOT the definition: it is equivalent to
being `k • V`-periodic, i.e. to the reduction's conclusion, and would make the theorem a tautology.

What this file does NOT claim: "every colouring is additive" is a universal over all colourings,
supplied by an UNTRUSTED enumeration; at a jackpot the kernel certificate is the pair's forcing
by refutation (the M34 bridge), never the additivity census.

Skeleton (WORKFLOW step 3, reshaped by the domain pass §M1): every leaf is `sorry` until phase A.
-/

namespace HadwigerNelson

open SimpleGraph

variable {ι V G : Type*} [AddCommGroup V] [AddCommGroup G]

/-- A `k`-colouring is *additive* along the addresses `q` when its same-colour relation is the
trace of the cosets of some subgroup containing `k • V`. The `↔` is the content: the implication
alone would be the reduction's conclusion in disguise. -/
def IsAdditive (q : ι → V) {Γ : SimpleGraph ι} {k : ℕ} (C : Γ.Coloring (Fin k)) : Prop :=
  ∃ H : AddSubgroup V, (∀ v, k • v ∈ H) ∧ ∀ a b, C a = C b ↔ q a - q b ∈ H

/-- `Γ` is *additively `k`-rigid* along `q`: every proper `k`-colouring is additive. -/
def AdditivelyRigid (q : ι → V) (Γ : SimpleGraph ι) (k : ℕ) : Prop :=
  ∀ C : Γ.Coloring (Fin k), IsAdditive q C

/-- **The bridge from `Additive.lean`'s vocabulary.** A colouring whose partition is that of a
homomorphism into a group killed by `k` is additive (take `H = ker φ`). This is the instrument's
`additive` verdict (partition equality with an admissible hom's colouring), as a theorem. -/
theorem isAdditive_of_addMonoidHom (q : ι → V) {Γ : SimpleGraph ι} {k : ℕ}
    (C : Γ.Coloring (Fin k)) (φ : V →+ G) (hk : ∀ g : G, k • g = 0)
    (hC : ∀ a b, C a = C b ↔ φ (q a) = φ (q b)) : IsAdditive q C := sorry

/-- An additive colouring identifies every pair whose addresses differ by `k • w` (L1). -/
theorem IsAdditive.apply_eq {q : ι → V} {Γ : SimpleGraph ι} {k : ℕ} {C : Γ.Coloring (Fin k)}
    (h : IsAdditive q C) {a b : ι} {w : V} (hab : q a - q b = k • w) : C a = C b := sorry

/-- **The reduction theorem (D1).** On an additively `k`-rigid chunk every pair at a `k·Λ`
difference is forced equal. -/
theorem forces_of_additivelyRigid {q : ι → V} {Γ : SimpleGraph ι} {k : ℕ}
    (h : AdditivelyRigid q Γ k) {a b : ι} {w : V} (hab : q a - q b = k • w) :
    Forces Γ k a b := sorry

/-- **The plane corollary.** An additively `k`-rigid chunk drawn with unit edges, holding a
`k·Λ`-pair at distance `d ≥ 1/2`, gives `χ(ℝ²) ≥ k + 1` — the spindle theorem composed with
the reduction. The drawing is any map with unit edges; affinity in `q` is never used. -/
theorem add_one_le_chromaticNumber_unitDistance_of_additivelyRigid {q : ι → V}
    {Γ : SimpleGraph ι} {k : ℕ} (h : AdditivelyRigid q Γ k) {a b : ι} {w : V}
    (hab : q a - q b = k • w) (dr : ι → ℂ) (hdr : ∀ i j, Γ.Adj i j → dist (dr i) (dr j) = 1)
    {d : ℝ} (hd : dist (dr a) (dr b) = d) (hhalf : 1 / 2 ≤ d) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := sorry

/-- **The target at five colours.** An additively 5-rigid unit-distance chunk with a `5Λ`-pair at
distance `≥ 1/2` proves `χ(ℝ²) ≥ 6`. The hypotheses are the milestone's design specification. -/
theorem six_le_chromaticNumber_unitDistance_of_additivelyRigid {q : ι → V} {Γ : SimpleGraph ι}
    (h : AdditivelyRigid q Γ 5) {a b : ι} {w : V} (hab : q a - q b = 5 • w)
    (dr : ι → ℂ) (hdr : ∀ i j, Γ.Adj i j → dist (dr i) (dr j) = 1) {d : ℝ}
    (hd : dist (dr a) (dr b) = d) (hhalf : 1 / 2 ≤ d) :
    (6 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := sorry

/-! ## Spec: the unit path of length two, and a planted red

`pathGraph 3` addressed at `i ↦ (i, 0)` in `ℤ × ℤ` is additively 2-rigid (its only 2-colourings
are the parity colouring up to palette), its endpoints differ by `2 • (1, 0)`, and drawn at unit
spacing they are 2 apart — so the reduction says `χ(ℝ²) ≥ 3`. Nothing new, but a model of every
hypothesis, which is what makes the theorem non-vacuous. The red: `cycleGraph 6` addressed by the
identity into `ZMod 6` at three colours has the proper colouring `0 1 0 1 0 2`, which separates `0`
from `3 = 3 • 1` — so it is NOT additively 3-rigid, and the definition can fail. -/

/-- The path's addresses: `i ↦ (i, 0)`. -/
def pathAddr : Fin 3 → ℤ × ℤ := fun i => ((i : ℕ), 0)

theorem pathGraph_additivelyRigid : AdditivelyRigid pathAddr (pathGraph 3) 2 := sorry

/-- The endpoints are forced equal at two colours — by the reduction, not by looking. -/
example : Forces (pathGraph 3) 2 0 2 :=
  forces_of_additivelyRigid pathGraph_additivelyRigid (w := (-1, 0)) (by decide)

/-- The model of every hypothesis: `χ(ℝ²) ≥ 3` from the path drawn at unit spacing. -/
theorem three_le_chromaticNumber_unitDistance_of_pathGraph :
    (3 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := sorry

/-- The planted red: the hexagon is NOT additively 3-rigid — the colouring `0 1 0 1 0 2` is proper
and separates `0` from `3 = 3 • 1`, which every subgroup containing `3 • ZMod 6` identifies. -/
theorem cycleGraph_six_not_additivelyRigid :
    ¬ AdditivelyRigid (id : ZMod 6 → ZMod 6) (cycleGraph 6) 3 := sorry

end HadwigerNelson
