namespace HadwigerNelson
/-- plant: x ≠ y over the provably empty AeColouring 1 -/
theorem t2_plant_ne_one (_c : Plane.AeColouring 1) (x y : ℂ) : x + 1 ≠ y := fun _ => sorry
/-- plant: ¬ P over AeColouring 1 -/
theorem t2_plant_not_one (_c : Plane.AeColouring 1) (x : ℂ) : ¬ (x = x + 1) := fun _ => sorry
/-- plant: variable k, ≠ -/
theorem t2_plant_ne_k {k : ℕ} (_c : Plane.AeColouring k) (x y : ℂ) : x + 1 ≠ y := fun _ => sorry
/-- plant: variable k, ¬ -/
theorem t2_plant_not_k {k : ℕ} (_c : Plane.AeColouring k) (x : ℂ) : ¬ (x = x + 1) := fun _ => sorry
/-- plant: explicit P → False over AeColouring 1: a refutation -/
theorem t2_plant_arrow_false (_c : Plane.AeColouring 1) (x : ℂ) (_h : x = x + 1) : False := sorry
end HadwigerNelson
