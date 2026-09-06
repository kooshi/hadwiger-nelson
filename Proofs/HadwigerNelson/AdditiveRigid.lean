import Mathlib.Algebra.Group.Subgroup.Basic
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

The additivity used here is the weakest that suffices: a colouring is *additive* when, on the
chunk's vertex set `S`, it is constant on the cosets of a subgroup containing `k • V`. Every
colouring induced by a homomorphism into a group of order `k` (Fischer's notion, the instrument's
`additive-test` verdict) is additive in this sense (`isAdditive_of_addMonoidHom`); the converse
is not needed. The vertex set `S` is explicit because the ambient type is the lattice and the
chunk is a finite subset of it — points outside `S` carry no edges and are coloured freely.

Skeleton (WORKFLOW step 3): every leaf is `sorry` until phase A.
-/

namespace HadwigerNelson

open SimpleGraph

variable {V G : Type*} [AddCommGroup V] [AddCommGroup G]

/-- A `k`-colouring is *additive on `S`* when it is constant, on `S`, on the cosets of some
subgroup containing `k • V`. Weaker than "induced by a homomorphism into a group of order `k`",
and exactly what the reduction consumes. -/
def IsAdditiveOn (Γ : SimpleGraph V) (S : Set V) {k : ℕ} (C : Γ.Coloring (Fin k)) : Prop :=
  ∃ H : AddSubgroup V, (∀ v, k • v ∈ H) ∧ ∀ a ∈ S, ∀ b ∈ S, a - b ∈ H → C a = C b

/-- `Γ` is *additively `k`-rigid on `S`*: every proper `k`-colouring is additive on `S`. -/
def AdditivelyRigidOn (Γ : SimpleGraph V) (S : Set V) (k : ℕ) : Prop :=
  ∀ C : Γ.Coloring (Fin k), IsAdditiveOn Γ S C

/-- **The bridge from `Additive.lean`'s vocabulary.** A colouring that factors through a
homomorphism into a group killed by `k` is additive on any `S` (take `H = ker φ`). -/
theorem isAdditiveOn_of_addMonoidHom (Γ : SimpleGraph V) (S : Set V) {k : ℕ}
    (C : Γ.Coloring (Fin k)) (φ : V →+ G) (hk : ∀ g : G, k • g = 0) (π : G → Fin k)
    (hC : ∀ v, C v = π (φ v)) : IsAdditiveOn Γ S C := sorry

/-- An additive colouring identifies every pair of `S` differing by `k • w` (L1). -/
theorem IsAdditiveOn.apply_eq {Γ : SimpleGraph V} {S : Set V} {k : ℕ} {C : Γ.Coloring (Fin k)}
    (h : IsAdditiveOn Γ S C) {p q w : V} (hp : p ∈ S) (hq : q ∈ S) (hpq : p - q = k • w) :
    C p = C q := sorry

/-- **The reduction theorem (D1).** On an additively `k`-rigid chunk every pair at a `k·Λ`
difference is forced equal. -/
theorem forces_of_additivelyRigidOn {Γ : SimpleGraph V} {S : Set V} {k : ℕ}
    (h : AdditivelyRigidOn Γ S k) {p q w : V} (hp : p ∈ S) (hq : q ∈ S)
    (hpq : p - q = k • w) : Forces Γ k p q := sorry

/-- **The plane corollary.** An additively `k`-rigid chunk drawn with unit edges, holding a
`k·Λ`-pair at distance `d ≥ 1/2`, gives `χ(ℝ²) ≥ k + 1` — the spindle theorem composed with
the reduction. -/
theorem add_one_le_chromaticNumber_unitDistance_of_additivelyRigidOn {Γ : SimpleGraph V}
    {S : Set V} {k : ℕ} (h : AdditivelyRigidOn Γ S k) {p q w : V} (hp : p ∈ S) (hq : q ∈ S)
    (hpq : p - q = k • w) (dr : V → ℂ) (hdr : ∀ i j, Γ.Adj i j → dist (dr i) (dr j) = 1)
    {d : ℝ} (hd : dist (dr p) (dr q) = d) (hhalf : 1 / 2 ≤ d) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := sorry

/-- **The target at five colours.** An additively 5-rigid unit-distance chunk with a `5Λ`-pair at
distance `≥ 1/2` proves `χ(ℝ²) ≥ 6`. The hypotheses are the milestone's design specification. -/
theorem six_le_chromaticNumber_unitDistance_of_additivelyRigidOn {Γ : SimpleGraph V} {S : Set V}
    (h : AdditivelyRigidOn Γ S 5) {p q w : V} (hp : p ∈ S) (hq : q ∈ S) (hpq : p - q = 5 • w)
    (dr : V → ℂ) (hdr : ∀ i j, Γ.Adj i j → dist (dr i) (dr j) = 1) {d : ℝ}
    (hd : dist (dr p) (dr q) = d) (hhalf : 1 / 2 ≤ d) :
    (6 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := sorry

/-! ## Spec: the unit path of length two, and a planted red

The path `(0,0) — (1,0) — (2,0)` in `ℤ × ℤ` is additively 2-rigid on its three points (its only
2-colourings are the parity colouring up to palette), its endpoints differ by `2 • (1, 0)`, and
drawn at unit spacing they are 2 apart — so the reduction says `χ(ℝ²) ≥ 3`. Nothing new, but a
model of every hypothesis, which is what makes the theorem non-vacuous. The red: the hexagon
`ℤ/6` at three colours has a proper colouring (`0 1 0 1 0 2`) not constant on the cosets of any
subgroup containing `3 • ℤ/6` — so it is NOT additively 3-rigid, and the definition can fail. -/

/-- The path `(0,0) — (1,0) — (2,0)`; every other point of `ℤ × ℤ` is isolated. -/
def path2 : SimpleGraph (ℤ × ℤ) :=
  SimpleGraph.fromRel fun a b => (a = (0, 0) ∧ b = (1, 0)) ∨ (a = (1, 0) ∧ b = (2, 0))

/-- The path's vertex set. -/
def path2Set : Set (ℤ × ℤ) := {(0, 0), (1, 0), (2, 0)}

theorem path2_additivelyRigidOn : AdditivelyRigidOn path2 path2Set 2 := sorry

/-- The endpoints are forced equal at two colours — by the reduction, not by looking. -/
example : Forces path2 2 (0, 0) (2, 0) :=
  forces_of_additivelyRigidOn path2_additivelyRigidOn (by simp [path2Set]) (by simp [path2Set])
    (w := (-1, 0)) (by decide)

/-- The model of every hypothesis: `χ(ℝ²) ≥ 3` from the path drawn at unit spacing. -/
theorem three_le_chromaticNumber_unitDistance_of_path2 :
    (3 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := sorry

/-- The hexagon `ℤ/6`: neighbours differ by `±1`. -/
def hexagon : SimpleGraph (ZMod 6) := SimpleGraph.fromRel fun a b => a - b = 1

/-- The planted red: the hexagon is NOT additively 3-rigid — the colouring `0 1 0 1 0 2` is proper
and identifies no subgroup containing `3 • ℤ/6 = {0, 3}` (it separates `0` and `3`). -/
theorem hexagon_not_additivelyRigidOn : ¬ AdditivelyRigidOn hexagon Set.univ 3 := sorry

end HadwigerNelson
