import Proofs.HadwigerNelson.Lift

/-!
# The second obstruction instance: the 5-critical core of `UD(𝔽₁₁, 2)` is not a shadow

M59 (`plans/M59-finite-plane-lift.md` §R3). The sphere-then-vertex shrink (`tools/fplift.py cores --p 11 --k 4`) finds a
5-critical subgraph of the finite plane at 11 with 63 vertices and 246 edges, 1-minimal with a verified colouring of every
single-vertex deletion (`data/fplane/core-p11-k4-spheres.json`; its refusal of four colours is the solver's claim). Its residue
framework is rigid and 98 of its 123 stress conditions fail the level-`11²` test; the minimal-support witness is a
9-vertex, 12-edge sub-framework whose stress pairs with the defect to `33 ≠ 0` in `ZMod 121`. So the core — and hence any
subgraph of the plane containing these 9 residues with these 12 edges — has no lift modulo `11²`: no configuration with one
point per residue class and every edge unit, in `ℤ₁₁²` or in any number field with an unramified degree-one prime above 11.
The finite plane's own 5-forcing at 11 is carried by edges that are unit modulo 11 and not modulo 121 — the registered
expectation for the 6-critical cores of the larger planes, measured one level down.
-/

namespace HadwigerNelson

open SimpleGraph

/-- The 9 residues of the witness sub-framework of the 5-critical core of `UD(𝔽₁₁, 2)`, as points of `(ℤ/121)²`. -/
def core11x : Fin 9 → ZMod (11 ^ 2) × ZMod (11 ^ 2) :=
  ![(3, 4), (5, 0), (8, 4), (8, 7), (0, 2), (0, 9), (5, 1), (5, 10), (6, 10)]

/-- Its 12 weighted edges: a self-stress modulo 11. -/
def core11 : List (StressedEdge (Fin 9) (ZMod (11 ^ 2))) :=
  [⟨0, 8, 8⟩, ⟨0, 5, 8⟩, ⟨1, 6, 5⟩, ⟨1, 7, 5⟩, ⟨2, 5, 5⟩, ⟨2, 7, 5⟩, ⟨3, 4, 8⟩, ⟨3, 6, 8⟩, ⟨4, 7, 1⟩, ⟨4, 8, 5⟩, ⟨5, 6, 7⟩, ⟨7, 8, 1⟩]

/-- Every listed edge is unit modulo 11. -/
theorem core11_unit_mod_p :
    ∀ e ∈ core11, (11 : ZMod (11 ^ 2)) * (quad (core11x e.src - core11x e.dst) - 1) = 0 := by
  decide +kernel

/-- The weights are a self-stress modulo 11 (decided). -/
theorem core11_isStress : IsStress (11 : ZMod (11 ^ 2)) core11x core11 := by
  decide +kernel

/-- The stress pairing, decided: `33 = 11 · 3`, nonzero in `ZMod 121`. -/
theorem core11_pairing : stressPairing core11x core11 = 33 := by
  decide +kernel

/-- **The headline**: the witness sub-framework of the plane's 5-critical core at 11 has no lift modulo `121`. -/
theorem core11_no_lift :
    ¬ ∃ y : Fin 9 → ZMod (11 ^ 2) × ZMod (11 ^ 2), IsLift (11 : ZMod (11 ^ 2)) core11x y core11 :=
  not_exists_lift_of_stressPairing_ne_zero (ZMod.natCast_sq_eq_zero 11) core11_isStress
    (by rw [core11_pairing]; decide)

end HadwigerNelson
