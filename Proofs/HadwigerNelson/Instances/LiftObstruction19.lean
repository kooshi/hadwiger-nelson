import Proofs.HadwigerNelson.Lift

/-!
# The third obstruction instance: the 5-critical core of `UD(𝔽₁₉, 2)` is not a shadow

M59 (`plans/M59-finite-plane-lift.md` §R3). At 19 — a prime where the finite plane is triangle-free and still 5-chromatic
(M58) — the sphere-then-vertex shrink finds a 5-critical subgraph with 138 vertices and 619 edges, 1-minimal with a verified
colouring of every single-vertex deletion (`data/fplane/core-p19-k4-spheres.json`; its refusal of four colours is the solver's
claim). Its residue framework is rigid and 330 of its 346 stress conditions fail the level-`19²` test; the minimal-support
witness is a 17-vertex, 29-edge sub-framework whose stress pairs with the defect to `342 ≠ 0` in `ZMod 361`. So the core has
no lift modulo `19²` — the same verdict as at 11 (`Instances/LiftObstruction11.lean`), at a second prime and on a
triangle-free plane.
-/

namespace HadwigerNelson

open SimpleGraph

set_option maxRecDepth 100000

/-- The 17 residues of the witness sub-framework of the 5-critical core of `UD(𝔽₁₉, 2)`, as points of `(ℤ/361)²`. -/
def core19x : Fin 17 → ZMod (19 ^ 2) × ZMod (19 ^ 2) :=
  ![(3, 4), (3, 15), (5, 0), (9, 1), (9, 18), (10, 18), (16, 4), (16, 15), (0, 3), (0, 16), (7, 6), (9, 2), (12, 6), (12, 13), (5, 10), (12, 0), (9, 12)]

/-- Its 29 weighted edges: a self-stress modulo 19. -/
def core19 : List (StressedEdge (Fin 17) (ZMod (19 ^ 2))) :=
  [⟨0, 2, 2⟩, ⟨0, 10, 8⟩, ⟨0, 9, 12⟩, ⟨1, 2, 16⟩, ⟨1, 5, 2⟩, ⟨1, 8, 9⟩, ⟨2, 11, 9⟩, ⟨3, 11, 5⟩, ⟨3, 13, 16⟩, ⟨3, 6, 4⟩, ⟨4, 5, 16⟩, ⟨4, 12, 9⟩, ⟨4, 7, 2⟩, ⟨5, 10, 9⟩, ⟨6, 9, 16⟩, ⟨6, 12, 5⟩, ⟨7, 8, 7⟩, ⟨7, 16, 11⟩, ⟨7, 13, 11⟩, ⟨8, 10, 16⟩, ⟨8, 12, 1⟩, ⟨8, 15, 5⟩, ⟨9, 15, 9⟩, ⟨9, 13, 11⟩, ⟨10, 11, 1⟩, ⟨10, 14, 9⟩, ⟨13, 14, 5⟩, ⟨14, 16, 1⟩, ⟨15, 16, 1⟩]

/-- Every listed edge is unit modulo 19. -/
theorem core19_unit_mod_p :
    ∀ e ∈ core19, (19 : ZMod (19 ^ 2)) * (quad (core19x e.src - core19x e.dst) - 1) = 0 := by
  decide +kernel

/-- The weights are a self-stress modulo 19 (decided). -/
theorem core19_isStress : IsStress (19 : ZMod (19 ^ 2)) core19x core19 := by
  decide +kernel

/-- The stress pairing, decided: `342 = 19 · 18`, nonzero in `ZMod 361`. -/
theorem core19_pairing : stressPairing core19x core19 = 342 := by
  decide +kernel

/-- **The headline**: the witness sub-framework of the plane's 5-critical core at 19 has no lift modulo `361`. -/
theorem core19_no_lift :
    ¬ ∃ y : Fin 17 → ZMod (19 ^ 2) × ZMod (19 ^ 2), IsLift (19 : ZMod (19 ^ 2)) core19x y core19 :=
  not_exists_lift_of_stressPairing_ne_zero (ZMod.natCast_sq_eq_zero 19) core19_isStress
    (by rw [core19_pairing]; decide)

end HadwigerNelson
