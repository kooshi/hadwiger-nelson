import Mathlib

/-!
# K3 option A skeleton (J04 → J16, if chosen): FS-87 target 1, the stripe lemma (FS85-V2-T5)

"under NT₀ every proper four-colouring of the triangular lattice is striped" (`plans/STUB-de-grey-chain-kernel.md`
target 1; proof `plans/FS85-V2-verification.md` §W5 item 3). The lattice is `ℤ[ζ₆]` in the basis `1, ζ₆`, i.e. `ℤ × ℤ`
with the six unit steps `±(1,0), ±(0,1), ±(−1,1)`.
-/

set_option autoImplicit false

namespace HadwigerNelson
namespace Stripe

/-- The six unit steps in cyclic order (angles 0°, 60°, …, 300°). -/
def rim : Fin 6 → ℤ × ℤ := ![(1, 0), (0, 1), (-1, 1), (-1, 0), (0, -1), (1, -1)]

/-- Proper: a point and each of its six neighbours differ. -/
def Proper (c : ℤ × ℤ → Fin 4) : Prop := ∀ x (i : Fin 6), c x ≠ c (x + rim i)

/-- NT₀: no monochromatic √3-triangle — every such triangle is the alternate triple of the wheel at its centre. -/
def NT0 (c : ℤ × ℤ → Fin 4) : Prop :=
  ∀ x, ¬ (c (x + rim 0) = c (x + rim 2) ∧ c (x + rim 2) = c (x + rim 4)) ∧
       ¬ (c (x + rim 1) = c (x + rim 3) ∧ c (x + rim 3) = c (x + rim 5))

/-- Striped: a pairing of the four colours whose pair index is affine on the lattice. -/
def Striped (c : ℤ × ℤ → Fin 4) : Prop :=
  ∃ (π : Fin 4 → ZMod 2) (β : ℤ × ℤ →+ ZMod 2),
    (∀ e : ZMod 2, (Finset.univ.filter fun i => π i = e).card = 2) ∧ ∀ x, π (c x) = π (c 0) + β x

/-! ## Leaf S1 (priced by J04): the wheel classification, a finite check

A wheel is the centre and its rim `r₀ … r₅`. Proper and NT₀ at the centre leave exactly two rim shapes: **type O**
(all three diagonals `rᵢ = r_{i+3}` monochromatic) and **type P** (exactly one). Checked on all `4⁷` wheels. -/

/-- The wheel check on one colour pattern (`w 0` the centre, `w (i+1)` the rim point `i`). -/
def wheelOK (w : Fin 7 → Fin 4) : Bool :=
  let r := fun i : Fin 6 => w i.succ
  let proper := (List.finRange 6).all (fun i => w 0 != r i) &&
    (List.finRange 6).all (fun i => r i != r (i + 1))
  let nt := !(r 0 == r 2 && r 2 == r 4) && !(r 1 == r 3 && r 3 == r 5)
  let diag := ([0, 1, 2] : List (Fin 6)).countP (fun i => r i == r (i + 3))
  !(proper && nt) || diag == 3 || diag == 1

/-- Every wheel, by nested `List.all` over `Fin 4` (recursion depth 28, not `4⁷`). -/
theorem wheel_all :
    (List.finRange 4).all (fun a => (List.finRange 4).all fun b => (List.finRange 4).all fun c =>
      (List.finRange 4).all fun d => (List.finRange 4).all fun e => (List.finRange 4).all fun f =>
      (List.finRange 4).all fun g => wheelOK ![a, b, c, d, e, f, g]) = true := by
  decide +kernel

/-! ## The remaining leaves (J16, if chosen) -/

/-- S2, propagation: a type-P point along `v` makes its neighbour at `+v` type P along `v`, colours `(a, c)` swapped. -/
theorem typeP_propagates : True := trivial -- statement to be written by J16 from §W5 item 3

/-- **The stripe lemma** (FS85-V2-T5). -/
theorem striped_of_proper_nt0 (c : ℤ × ℤ → Fin 4) (hc : Proper c) (hnt : NT0 c) : Striped c := by
  sorry

end Stripe
end HadwigerNelson
