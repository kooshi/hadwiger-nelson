import Proofs.HadwigerNelson.Plane.CircleColouring
import Proofs.HadwigerNelson.Plane.RingGerm

/-!
# FS129-SR1-RINGBAND: the band of a three-colouring of the circle proper at `60°`, its hexagon height and winding

The row (carrying FS110-N2-RING, FS110-Y3-GP, and — caution C137 — FS129-OA1-RINGWIND's periodicity clauses as clause (vi))
over `CircleColouring` (`Plane/CircleColouring`): `C` a `ℤ/3`-colouring of the circle proper at `60°`, locally constant off a
finite change set `S`; `L` a lift; for `θ` whose hexagon `θ + 60°j` avoids `S` (`C.Good θ`), `L.D j θ`, `L.m j θ`, `L.n₂ θ`, the
hexagon height `C.h θ` and the winding `L.W θ`.

* (i) `3h = hSum = 6 − 2n₂`, and `h ∈ {−2, 0, 2}`;
* (ii) `W = Σ_{j<6} m_j + 3 − h/2`; `W` is the same at every `θ` off `S`;
* (iii) `h` is locally constant at `θ₀` unless `S` holds two points `θ₀ + 60°j`, `θ₀ + 60°(j + 1)`;
* (iv) with no swap point, all `m_j(θ)` equal one integer `M`, `W ∈ {6M + 2, 6M + 3, 6M + 4}`, and `W = 6M + 3` unless `S` is
  invariant under the rotation by `60°`;
* (v) with no two points of `S` `60°` apart, `h = 0` and `W = 6M + 3`;
* (vi) (FS129-OA1-RINGWIND) `h` has period `60°`, and a hexagon position that is the only one in its period with two change
  points `60°` apart carries no jump of `h`.

Corollaries: FS110-N2-RING (`|W| ≤ 1` forces a swap point) and FS110-Y3-GP (no `60°` pair gives `W ≡ 3 (mod 6)`, so `|W| ≤ 2`
needs a `60°` pair), each on the circle and, through the map bridge `ringCircleColouring` (the ring of a vertex whose ring
carries no arc of `Γ`, coloured through any `g : Fin k → ZMod 3` injective on the colours absent at the vertex), on the map.

**Inhabitants.** `hexColouring` (`W = 2`, `h = 2`), `nineColouring` (`W = 3`, `h = 0`), each with its lift (`arcsLift`);
`exists_lift` gives a lift of every circle colouring.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace CircleColouring

variable (C : CircleColouring)

/-- Every circle colouring has a lift (integrate the steps `±1` across the finitely many change points of a period). -/
theorem exists_lift : Nonempty C.Lift := by
  sorry

/-- The positions carrying two change points `60°` apart: `θ` with `θ + 60°j, θ + 60°(j + 1) ∈ S` for some `j < 6`. -/
def PairPos (θ : ℝ) : Prop := ∃ j : ℕ, j < 6 ∧ θ + j * (π / 3) ∈ C.S ∧ θ + (j + 1) * (π / 3) ∈ C.S

variable {C} (L : C.Lift)

/-- **FS129-SR1-RINGBAND** (i): `3h(θ) = hSum(θ) = 6 − 2n₂(θ)`, and `h(θ) ∈ {−2, 0, 2}`. -/
theorem ringband_i {θ : ℝ} (hθ : C.Good θ) :
    3 * C.h θ = C.hSum θ ∧ C.hSum θ = 6 - 2 * (L.n₂ θ : ℤ) ∧ C.h θ ∈ ({-2, 0, 2} : Set ℤ) := by
  sorry

/-- **FS129-SR1-RINGBAND** (ii): `W = m₀ + … + m₅ + 3 − h/2` at every good `θ` (and `3` divides `f(θ + 2π) − f(θ)`). -/
theorem ringband_ii {θ : ℝ} (hθ : C.Good θ) :
    3 ∣ L.f (θ + 2 * π) - L.f θ ∧ L.W θ = ∑ j ∈ Finset.range 6, L.m j θ + 3 - C.h θ / 2 := by
  sorry

/-- **FS129-SR1-RINGBAND**, the row's "put `W = (c̃(θ + 360°) − c̃(θ))/3`": the winding is the same at every `θ` off `S`. -/
theorem W_eq {θ θ' : ℝ} (hθ : θ ∉ C.S) (hθ' : θ' ∉ C.S) : L.W θ = L.W θ' := by
  sorry

/-- **FS129-SR1-RINGBAND** (iii): `h` changes across `θ₀` only if `S` holds two points `θ₀ + 60°j` and `θ₀ + 60°(j + 1)`. -/
theorem ringband_iii {θ₀ : ℝ} (h0 : ¬ C.PairPos θ₀) :
    ∃ ε > 0, ∀ θ θ', |θ - θ₀| < ε → |θ' - θ₀| < ε → C.Good θ → C.Good θ' → C.h θ = C.h θ' := by
  sorry

/-- **FS129-SR1-RINGBAND** (iv): with no swap point, all `m_j(θ)` equal one integer `M`, `W` is `6M + 2`, `6M + 3` or `6M + 4`,
and `W = 6M + 3` unless `S` is invariant under the rotation by `60°`. -/
theorem ringband_iv (hns : ∀ x, ¬ C.IsSwap x) :
    ∃ M : ℤ, (∀ θ, C.Good θ → ∀ j < 6, L.m j θ = M) ∧
      ∀ θ, C.Good θ → (L.W θ = 6 * M + 2 ∨ L.W θ = 6 * M + 3 ∨ L.W θ = 6 * M + 4) ∧
        ((¬ ∀ x, x ∈ C.S ↔ x + π / 3 ∈ C.S) → L.W θ = 6 * M + 3) := by
  sorry

/-- **FS129-SR1-RINGBAND** (v): with no two points of `S` `60°` apart, `h = 0` at every good `θ` and `W = 6M + 3` (`M` the
common value of the `m_j`). -/
theorem ringband_v (hno : ∀ x ∈ C.S, x + π / 3 ∉ C.S) :
    ∃ M : ℤ, (∀ θ, C.Good θ → ∀ j < 6, L.m j θ = M) ∧ ∀ θ, C.Good θ → C.h θ = 0 ∧ L.W θ = 6 * M + 3 := by
  sorry

/-- **FS129-SR1-RINGBAND** (vi), from FS129-OA1-RINGWIND (caution C137), first clause: `h` has period `60°`. -/
theorem ringband_vi_periodic {θ : ℝ} (hθ : C.Good θ) : C.h (θ + π / 3) = C.h θ := by
  sorry

/-- **FS129-SR1-RINGBAND** (vi), second clause: a hexagon position that is the only one in its period with two change points
`60°` apart carries no jump of `h` (the jumps over one period sum to zero). -/
theorem ringband_vi_noJump {θ₀ : ℝ} (honly : ∀ x, C.PairPos x → ∃ m : ℤ, x = θ₀ + m * (π / 3)) :
    ∃ ε > 0, ∀ θ θ', |θ - θ₀| < ε → |θ' - θ₀| < ε → C.Good θ → C.Good θ' → C.h θ = C.h θ' := by
  sorry

/-- **FS110-N2-RING**, on the circle: `|W| ≤ 1` forces a swap point. -/
theorem exists_swap_of_abs_W_le_one {θ : ℝ} (hθ : θ ∉ C.S) (hW : |L.W θ| ≤ 1) : ∃ x, C.IsSwap x := by
  sorry

/-- **FS110-Y3-GP**, on the circle: with no two change points `60°` apart, `W ≡ 3 (mod 6)`. -/
theorem W_mod_six (hno : ∀ x ∈ C.S, x + π / 3 ∉ C.S) {θ : ℝ} (hθ : θ ∉ C.S) : L.W θ % 6 = 3 := by
  sorry

/-- **FS110-Y3-GP**, on the circle: `|W| ≤ 2` needs two change points `60°` apart. -/
theorem exists_pair_of_abs_W_le_two {θ : ℝ} (hθ : θ ∉ C.S) (hW : |L.W θ| ≤ 2) : ∃ x ∈ C.S, x + π / 3 ∈ C.S := by
  sorry

end CircleColouring

/-! ## The map bridge: the ring of a vertex whose ring carries no arc of `Γ` -/

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- `e` is injective on `[0, 2π)`. -/
theorem e_injOn_Ico : InjOn e (Ico 0 (2 * π)) := by
  intro a ha b hb hab
  have hπ := Real.pi_pos
  have h := Complex.exp_eq_exp_iff_exists_int.mp hab
  obtain ⟨n, hn⟩ := h
  have hn' : (a : ℂ) = b + n * (2 * π) := by
    have := congrArg (fun z => z / I) hn
    simp only [mul_div_cancel_right₀ _ Complex.I_ne_zero] at this
    rw [this]; field_simp
  have hn'' : a = b + n * (2 * π) := by exact_mod_cast hn'
  have h1 : (n : ℝ) < 1 := by nlinarith [ha.1, ha.2, hb.1, hb.2]
  have h2 : (-1 : ℝ) < n := by nlinarith [ha.1, ha.2, hb.1, hb.2]
  have h1' : n < 1 := by exact_mod_cast h1
  have h2' : -1 < n := by exact_mod_cast h2
  have : n = 0 := by omega
  rw [hn'', this]; simp

/-- The change set of the ring: `S = {θ | r(θ) ∈ Γ}`, finite per period on a covered ring carrying no arc of `Γ`
(`finite_ringΓ_off_ringArc`). -/
theorem ring_finite_S {p : ℂ} (hp : F.Covers p 1) (hno : ∀ x, ¬ F.OnRingArc p x) :
    ({θ | ringPt p θ ∈ F.Γ} ∩ Ico 0 (2 * π)).Finite := by
  have hfin : (F.Γ ∩ sphere p 1).Finite := by
    refine ((F.finite_ringΓ_off_ringArc hp).union (Set.toFinite ∅)).subset ?_
    intro x hx
    by_cases h : F.OnRingArc p x
    · exact absurd h (hno x)
    · exact Or.inl ⟨hx, h⟩
  have hinj : InjOn (ringPt p) (Ico 0 (2 * π)) := fun a ha b hb hab =>
    e_injOn_Ico ha hb (add_left_cancel hab)
  refine Set.Finite.of_finite_image (f := ringPt p) (hfin.subset ?_) (hinj.mono inter_subset_right)
  rintro _ ⟨θ, ⟨hθ, -⟩, rfl⟩
  exact ⟨hθ, ringPt_mem_sphere p θ⟩

/-- The ring colouring is locally constant off `S`: a ring point off `Γ` on a covered ring is an interior point. -/
theorem ring_locallyConstant {p : ℂ} (hp : F.Covers p 1) (g : Fin k → ZMod 3) :
    ∀ θ ∉ {θ | ringPt p θ ∈ F.Γ}, ∀ᶠ θ' in 𝓝 θ, g (F.col (ringPt p θ')) = g (F.col (ringPt p θ)) := by
  intro θ hθ
  have hxd : ringPt p θ ∈ F.dom := hp (sphere_subset_closedBall (ringPt_mem_sphere p θ))
  have hloc := F.locallyConstant _ hxd (fun h => hθ ⟨hxd, h⟩)
  have hcont : Continuous (ringPt p) := by unfold ringPt e; fun_prop
  filter_upwards [hcont.continuousAt.eventually hloc] with θ' h
  rw [h]

/-- The ring colouring is proper at `60°`: two ring points off `Γ` `60°` apart are at distance `1`, so have different colours
(validity), both absent at `p` (FS116-V4-TWIST), which `g` keeps apart. -/
theorem ring_proper (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) {g : Fin k → ZMod 3}
    (hg : Set.InjOn g (F.coloursAt p)ᶜ) :
    ∀ θ, θ ∉ {θ | ringPt p θ ∈ F.Γ} → θ + π / 3 ∉ {θ | ringPt p θ ∈ F.Γ} →
      g (F.col (ringPt p θ)) ≠ g (F.col (ringPt p (θ + π / 3))) := by
  intro θ h0 h1 hgg
  have hd0 : ringPt p θ ∈ F.dom := hp (sphere_subset_closedBall (ringPt_mem_sphere p θ))
  have hd1 : ringPt p (θ + π / 3) ∈ F.dom := hp (sphere_subset_closedBall (ringPt_mem_sphere p _))
  have hi0 := F.mem_interiorPts_of_notMem_Γ hd0 h0
  have hi1 := F.mem_interiorPts_of_notMem_Γ hd1 h1
  have hdist : dist (ringPt p θ) (ringPt p (θ + π / 3)) = 1 := by
    have hπ := Real.pi_pos
    refine ((dist_ringPt_ringPt_cmp_one p (α := θ) (β := θ + π / 3) ?_).1).mpr ?_
    · rw [show θ - (θ + π / 3) = -(π / 3) by ring, abs_neg, abs_of_pos (by positivity)]; linarith
    · rw [show θ - (θ + π / 3) = -(π / 3) by ring, abs_neg, abs_of_pos (by positivity)]
  have hne := hF _ hi0 _ hi1 hdist
  have a0 : F.col (ringPt p θ) ∈ (F.coloursAt p)ᶜ :=
    not_mem_coloursAt_of_mem_sphere hF (ringPt_mem_sphere p θ) ⟨hi0, rfl⟩
  have a1 : F.col (ringPt p (θ + π / 3)) ∈ (F.coloursAt p)ᶜ :=
    not_mem_coloursAt_of_mem_sphere hF (ringPt_mem_sphere p _) ⟨hi1, rfl⟩
  exact hne (hg a0 a1 hgg)

/-- **The map bridge** (FS110-N2-RING's setting): the ring of a point `p` of a valid map covering `B̄(p, 1)`, whose ring carries
no arc of `Γ`, coloured through `g : Fin k → ZMod 3` injective on the colours absent at `p`, is a circle colouring with change
set `{θ | r(θ) ∈ Γ}`. (At a three-colour vertex of a six-coloured map, `g` is any bijection of the three absent colours onto
`ℤ/3`.) -/
noncomputable def ringCircleColouring (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (hno : ∀ x, ¬ F.OnRingArc p x)
    (g : Fin k → ZMod 3) (hg : Set.InjOn g (F.coloursAt p)ᶜ) : CircleColouring where
  c θ := g (F.col (ringPt p θ))
  S := {θ | ringPt p θ ∈ F.Γ}
  periodic θ := by simp only [ringPt, e_add_two_pi]
  periodic_S θ := by simp only [mem_setOf_eq, ringPt, e_add_two_pi]
  finite_S := ring_finite_S hp hno
  locallyConstant := ring_locallyConstant hp g
  proper := ring_proper hF hp hg

/-- **FS110-N2-RING**, on the map: at a point whose ring carries no arc of `Γ`, the ring colouring's winding satisfies
`|W| ≤ 1` only if the ring has a swap point. -/
theorem exists_swap_of_ring (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (hno : ∀ x, ¬ F.OnRingArc p x)
    (g : Fin k → ZMod 3) (hg : Set.InjOn g (F.coloursAt p)ᶜ) (L : (ringCircleColouring hF hp hno g hg).Lift)
    {θ : ℝ} (hθ : ringPt p θ ∉ F.Γ) (hW : |L.W θ| ≤ 1) : ∃ x, (ringCircleColouring hF hp hno g hg).IsSwap x :=
  CircleColouring.exists_swap_of_abs_W_le_one L hθ hW

end ArcMap

end HadwigerNelson.Plane
