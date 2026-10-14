import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Group.Subgroup.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Linarith

/-!
# Independence ratios of Cayley graphs on finite abelian groups, and of their products (FS-131, job FS131-K12A; module M12, block Z; skeleton)

**Read aloud, against the derivation** (J28D § 3.2 C5, "the stationary Zhang count", and NH-Y′; X25B-PZ;
`[Zhang2012]` Thm 1.8's counting). A connection set `S` of a finite additive group `G` defines the Cayley graph
`x ~ y ⟺ y − x ∈ S`. Independence is read **in the connection set**: `SIndep S I` says `y − x ∉ S` for all `x, y ∈ I`,
`x = y` included — so a connection set holding `0` has no non-empty independent set, which is the right reading for the
product's factors (a factor with one point and the loop `0` multiplies nothing away: `ratioLe_pi` at an empty index).
`RatioLe S c` says every independent set holds at most the fraction `c` of `G`.

* `card_le_mul_card_closedNbhd` — **the neighbourhood ratio** (NH-Y′ in finite form): in a symmetric Cayley graph of ratio
  at most `c`, every independent `I` has `|I| ≤ c |N[I]|`. Route: for a maximum independent `J` and every `t`,
  `((J + t) \ N[I]) ∪ I` is independent; average `|(J + t) ∩ N[I]| = |J| |N[I]| / |G|` over `t`.
* `ratioLe_prod` — **Zhang's product bound**: the connection set `S₁ ×ˢ S₂` of `G₁ × G₂` has ratio at most `c` when each
  factor has. Route: the social and lonely points of each row (`[Zhang2012]`'s count), with the neighbourhood ratio on both
  factors.
* `ratioLe_pi` — the same over a finite product, by induction.
* `ratioLe_subgroup` — **a subgroup holding the connection set** has the ratio of the group: an independent set of the
  subgroup, translated to every coset, is independent in the group.

The count (module `Rigidity/CountDescent`) reads `ratioLe_pi` and `ratioLe_subgroup` at the residue levels of the stable
primes, and `card_le_mul_card_closedNbhd` in the plane-by-finite count (`Rigidity/PlaneZhang`).

**Models.** `RatioLe S 1` holds for every `S` (an independent set is a subset); `RatioLe {1} (1/2)` on `ZMod 2` (a single
point is the largest independent set).
-/

namespace HadwigerNelson.Rigidity

open Finset

variable {G : Type*} [AddCommGroup G] [Finite G]

/-- `I` is independent in the Cayley graph of `S`: no difference of two of its points (equal points included) lies in
`S`. -/
def SIndep (S : Set G) (I : Finset G) : Prop := ∀ x ∈ I, ∀ y ∈ I, y - x ∉ S

/-- **The independence ratio of the Cayley graph of `S` is at most `c`.** -/
def RatioLe (S : Set G) (c : ℝ) : Prop := ∀ I : Finset G, SIndep S I → (I.card : ℝ) ≤ c * Nat.card G

/-- The closed neighbourhood `N[I] = I ∪ (I + S)`. -/
noncomputable def closedNbhd (S : Set G) (I : Finset G) : Finset G :=
  (Set.toFinite {y : G | y ∈ I ∨ ∃ x ∈ I, y - x ∈ S}).toFinset

/-- **The neighbourhood ratio** (NH-Y′, finite form). -/
theorem card_le_mul_card_closedNbhd {S : Set G} {c : ℝ} (hS : ∀ s ∈ S, -s ∈ S) (h : RatioLe S c) {I : Finset G}
    (hI : SIndep S I) : (I.card : ℝ) ≤ c * (closedNbhd S I).card := by
  sorry

/-- **Zhang's product bound**, two finite factors. -/
theorem ratioLe_prod {G₁ G₂ : Type*} [AddCommGroup G₁] [Finite G₁] [AddCommGroup G₂] [Finite G₂] {S₁ : Set G₁} {S₂ : Set G₂} {c : ℝ} (hS₁ : ∀ s ∈ S₁, -s ∈ S₁) (hS₂ : ∀ s ∈ S₂, -s ∈ S₂)
    (h₁ : RatioLe S₁ c) (h₂ : RatioLe S₂ c) : RatioLe (S₁ ×ˢ S₂) c := by
  sorry

/-- **Zhang's product bound**, a finite product. -/
theorem ratioLe_pi {ι : Type*} [Finite ι] {H : ι → Type*} [∀ i, AddCommGroup (H i)] [∀ i, Finite (H i)] {S : ∀ i, Set (H i)} {c : ℝ} (hc : 0 ≤ c)
    (hS : ∀ i, ∀ s ∈ S i, -s ∈ S i) (h : ∀ i, RatioLe (S i) c) :
    RatioLe {d : ∀ i, H i | ∀ i, d i ∈ S i} c := by
  sorry

/-- **A subgroup holding the connection set has the group's ratio.** -/
theorem ratioLe_subgroup (A : AddSubgroup G) {S : Set G} (hSA : S ⊆ A) {c : ℝ}
    (h : RatioLe S c) : RatioLe {d : A | (d : G) ∈ S} c := by
  sorry

theorem ratioLe_one (S : Set G) : RatioLe S 1 := fun I _ => by
  haveI := Fintype.ofFinite G
  rw [one_mul, Nat.card_eq_fintype_card]
  exact_mod_cast card_le_univ I

/-! ## Spec examples -/

/-- On `ZMod 2` with the connection set `{1}`, a single point is independent. -/
example : SIndep ({1} : Set (ZMod 2)) {0} := by
  intro x hx y hy
  simp only [Finset.mem_singleton] at hx hy
  subst hx; subst hy
  decide

end HadwigerNelson.Rigidity
