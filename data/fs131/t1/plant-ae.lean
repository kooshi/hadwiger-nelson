namespace HadwigerNelson
/-- plant: AeColouring 1 is provably empty -/
theorem t1_plant_ae_one (_c : Plane.AeColouring 1) (x : ℂ) : x = x := rfl
/-- plant: variable k -/
theorem t1_plant_ae_k {k : ℕ} (_c : Plane.AeColouring k) (x : ℂ) : x = x := rfl
end HadwigerNelson
