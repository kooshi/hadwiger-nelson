import OAI.Geometry.PlaneColoring.Five
#print axioms OAI.EuclideanFiveColor.no_proper_five_coloring
#check @OAI.EuclideanFiveColor.no_proper_five_coloring
-- the coordinator's own wording of the claim, closed by their theorem: it elaborates only if their statement is this one
example : ¬ ∃ c : ℂ → Fin 5, ∀ x y : ℂ, ‖x - y‖ = 1 → c x ≠ c y := OAI.EuclideanFiveColor.no_proper_five_coloring
-- a control that must fail: the same with distance 2 is not what they proved
example : ¬ ∃ c : ℂ → Fin 5, ∀ x y : ℂ, ‖x - y‖ = 2 → c x ≠ c y := OAI.EuclideanFiveColor.no_proper_five_coloring
