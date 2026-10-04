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


/-! ## Infrastructure: the change set is locally finite; one-sided constants; constancy from local agreement -/

/-- The change set is invariant under every integer multiple of the period. -/
theorem mem_S_add_int (n : ℤ) (θ : ℝ) : θ + n * (2 * π) ∈ C.S ↔ θ ∈ C.S := by
  induction n using Int.induction_on with
  | zero => simp
  | succ n ih =>
    rw [show θ + (((n : ℤ) + 1 : ℤ) : ℝ) * (2 * π) = (θ + ((n : ℤ) : ℝ) * (2 * π)) + 2 * π by push_cast; ring, C.periodic_S, ih]
  | pred n ih =>
    rw [← C.periodic_S, show θ + ((-(n : ℤ) - 1 : ℤ) : ℝ) * (2 * π) + 2 * π = θ + ((-(n : ℤ) : ℤ) : ℝ) * (2 * π) by
      push_cast; ring, ih]

/-- The change set meets every compact interval in a finite set. -/
theorem S_inter_Icc_finite (a b : ℝ) : (C.S ∩ Icc a b).Finite := by
  have hπ := Real.pi_pos
  have hfin := ((Finset.Icc ⌊a / (2 * π)⌋ ⌊b / (2 * π)⌋ ×ˢ C.finite_S.toFinset : Finset (ℤ × ℝ)).image
    (fun q : ℤ × ℝ => q.2 + q.1 * (2 * π))).finite_toSet
  refine hfin.subset ?_
  rintro s ⟨hs, has, hsb⟩
  set n := ⌊s / (2 * π)⌋ with hn
  have h1 : (n : ℝ) ≤ s / (2 * π) := Int.floor_le _
  have h2 : s / (2 * π) < n + 1 := Int.lt_floor_add_one _
  have h1' : n * (2 * π) ≤ s := by rwa [le_div_iff₀ (by positivity)] at h1
  have h2' : s < (n + 1) * (2 * π) := by rwa [div_lt_iff₀ (by positivity)] at h2
  have hmem : s - n * (2 * π) ∈ C.S := by
    have := (C.mem_S_add_int (-n) s).mpr hs
    simpa [sub_eq_add_neg] using this
  simp only [Finset.coe_image, Finset.coe_product, Finset.coe_Icc, mem_image, mem_prod, mem_Icc,
    Set.Finite.coe_toFinset, Prod.exists]
  refine ⟨n, s - n * (2 * π), ⟨⟨?_, ?_⟩, hmem, ?_, ?_⟩, by ring⟩
  · exact Int.floor_mono (div_le_div_of_nonneg_right has (by positivity))
  · exact Int.floor_mono (div_le_div_of_nonneg_right hsb (by positivity))
  · linarith
  · linarith

/-- Off the point itself, the change set is eventually avoided. -/
theorem eventually_notMem_S (x : ℝ) : ∀ᶠ y in 𝓝[≠] x, y ∉ C.S := by
  have hfin : ((C.S ∩ Icc (x - 1) (x + 1)) \ {x}).Finite := (C.S_inter_Icc_finite _ _).sdiff
  have h1 : ((C.S ∩ Icc (x - 1) (x + 1)) \ {x})ᶜ ∈ 𝓝 x := hfin.isClosed.isOpen_compl.mem_nhds (by simp)
  have h2 : Icc (x - 1) (x + 1) ∈ 𝓝 x := Icc_mem_nhds (by linarith) (by linarith)
  filter_upwards [mem_nhdsWithin_of_mem_nhds h1, mem_nhdsWithin_of_mem_nhds h2, self_mem_nhdsWithin] with y a b c d
  exact a ⟨⟨d, b⟩, c⟩

/-- Left of a point the change set is eventually avoided. -/
theorem eventually_notMem_S_lt (x : ℝ) : ∀ᶠ y in 𝓝[<] x, y ∉ C.S :=
  (C.eventually_notMem_S x).filter_mono (nhdsWithin_mono x fun y (hy : y < x) => ne_of_lt hy)

/-- Right of a point the change set is eventually avoided. -/
theorem eventually_notMem_S_gt (x : ℝ) : ∀ᶠ y in 𝓝[>] x, y ∉ C.S :=
  (C.eventually_notMem_S x).filter_mono (nhdsWithin_mono x fun y (hy : x < y) => ne_of_gt hy)

/-- A function locally constant at every point of an open interval is constant on it. -/
theorem const_on_Ioo {β : Type*} {g : ℝ → β} {a b : ℝ} (h : ∀ y ∈ Ioo a b, ∀ᶠ y' in 𝓝 y, g y' = g y) :
    ∀ y ∈ Ioo a b, ∀ y' ∈ Ioo a b, g y = g y' := by
  letI : TopologicalSpace β := ⊥
  haveI : DiscreteTopology β := ⟨rfl⟩
  intro y hy y' hy'
  have hc : ContinuousOn g (Ioo a b) := fun z hz =>
    (continuousAt_const.congr ((h z hz).mono fun _ e => e.symm)).continuousWithinAt
  exact isPreconnected_Ioo.constant hc hy hy'

/-- Constancy from local agreement: on a preconnected `I`, a function whose values on a set `T` dense in `I` agree
near every point of `I` is constant on `T ∩ I`. -/
theorem const_of_local {β : Type*} {I T : Set ℝ} (hI : IsPreconnected I)
    (hT : ∀ y ∈ I, ∀ ε > 0, ∃ z ∈ T, |z - y| < ε) {g : ℝ → β}
    (hg : ∀ y ∈ I, ∃ ε > 0, ∀ z ∈ T, |z - y| < ε → ∀ z' ∈ T, |z' - y| < ε → g z = g z') :
    ∀ z ∈ T ∩ I, ∀ z' ∈ T ∩ I, g z = g z' := by
  rintro z ⟨hzT, hzI⟩ z' ⟨hz'T, hz'I⟩
  by_contra hne
  set v := g z with hv
  let U : Set ℝ := {y | ∃ ε > 0, ∀ w ∈ T, |w - y| < ε → g w = v}
  let V : Set ℝ := {y | ∃ ε > 0, ∀ w ∈ T, |w - y| < ε → g w ≠ v}
  have hshrink : ∀ y y' ε : ℝ, |y' - y| < ε / 2 → ∀ w, |w - y'| < ε / 2 → |w - y| < ε := by
    intro y y' ε h1 w h2
    rw [abs_lt] at *; constructor <;> linarith
  have hUo : IsOpen U := by
    rw [Metric.isOpen_iff]
    rintro y ⟨ε, hε, h⟩
    refine ⟨ε / 2, by positivity, fun y' hy' => ⟨ε / 2, by positivity, fun w hw hwy => h w hw ?_⟩⟩
    rw [Metric.mem_ball, Real.dist_eq] at hy'
    exact hshrink y y' ε hy' w hwy
  have hVo : IsOpen V := by
    rw [Metric.isOpen_iff]
    rintro y ⟨ε, hε, h⟩
    refine ⟨ε / 2, by positivity, fun y' hy' => ⟨ε / 2, by positivity, fun w hw hwy => h w hw ?_⟩⟩
    rw [Metric.mem_ball, Real.dist_eq] at hy'
    exact hshrink y y' ε hy' w hwy
  have hcover : I ⊆ U ∪ V := by
    intro y hy
    obtain ⟨ε, hε, hgy⟩ := hg y hy
    obtain ⟨w₀, hw₀T, hw₀⟩ := hT y hy ε hε
    by_cases hw : g w₀ = v
    · exact Or.inl ⟨ε, hε, fun w hwT hwy => (hgy w hwT hwy w₀ hw₀T hw₀).trans hw⟩
    · exact Or.inr ⟨ε, hε, fun w hwT hwy => by rw [hgy w hwT hwy w₀ hw₀T hw₀]; exact hw⟩
  have hzU : z ∈ U := by
    obtain ⟨ε, hε, hgy⟩ := hg z hzI
    exact ⟨ε, hε, fun w hwT hwy => (hgy w hwT hwy z hzT (by simpa using hε)).trans rfl⟩
  have hz'V : z' ∈ V := by
    obtain ⟨ε, hε, hgy⟩ := hg z' hz'I
    exact ⟨ε, hε, fun w hwT hwy => by rw [hgy w hwT hwy z' hz'T (by simpa using hε)]; exact fun h => hne h.symm⟩
  obtain ⟨y, hyI, ⟨ε₁, hε₁, h₁⟩, ⟨ε₂, hε₂, h₂⟩⟩ := hI U V hUo hVo hcover ⟨z, hzI, hzU⟩ ⟨z', hz'I, hz'V⟩
  obtain ⟨w, hwT, hw⟩ := hT y hyI (min ε₁ ε₂) (lt_min hε₁ hε₂)
  exact h₂ w hwT (lt_of_lt_of_le hw (min_le_right _ _)) (h₁ w hwT (lt_of_lt_of_le hw (min_le_left _ _)))

/-- The complement of the change set is dense: every interval contains a point off it. -/
theorem exists_good_near (y ε : ℝ) (hε : 0 < ε) : ∃ z, |z - y| < ε ∧ C.Good z := by
  have hπ := Real.pi_pos
  have hK : (⋃ j ∈ Finset.range 6, (fun s : ℝ => s - j * (π / 3)) '' (C.S ∩ Icc (y - ε) (y + ε + 2 * π))).Finite :=
    Set.Finite.biUnion (Finset.finite_toSet _) fun j _ => (C.S_inter_Icc_finite _ _).image _
  obtain ⟨z, hz, hzK⟩ := (Ioo_infinite (show y - ε < y + ε by linarith)).exists_notMem_finset hK.toFinset
  refine ⟨z, by rw [abs_lt]; constructor <;> linarith [hz.1, hz.2], fun j hj hzS => hzK ?_⟩
  rw [Set.Finite.mem_toFinset]
  simp only [mem_iUnion, mem_image, Finset.mem_range]
  have hj' : (j : ℝ) ≤ 6 := by exact_mod_cast hj.le
  refine ⟨j, hj, z + j * (π / 3), ⟨hzS, ?_, ?_⟩, by ring⟩
  · have : (0 : ℝ) ≤ j * (π / 3) := by positivity
    linarith [hz.1]
  · have : (j : ℝ) * (π / 3) ≤ 6 * (π / 3) := by gcongr
    linarith [hz.2]

/-- A good angle is off the change set. -/
theorem Good.notMem {C : CircleColouring} {θ : ℝ} (h : C.Good θ) : θ ∉ C.S := by simpa using h 0 (by norm_num)

/-- The hexagon points `θ + i·60°`, `i ≤ 6`, of a good angle are off the change set. -/
theorem Good.hex_notMem {C : CircleColouring} {θ : ℝ} (h : C.Good θ) {i : ℕ} (hi : i ≤ 6) : θ + i * (π / 3) ∉ C.S := by
  rcases Nat.lt_or_ge i 6 with h6 | h6
  · exact h i h6
  · have : i = 6 := le_antisymm hi h6
    subst this
    rw [show θ + ((6 : ℕ) : ℝ) * (π / 3) = θ + 2 * π by push_cast; ring, C.periodic_S]
    exact h.notMem

variable {C}

/-- One-sided constants of a function locally constant off the change set. -/
theorem exists_left_const {β : Type*} {g : ℝ → β} (hg : ∀ y ∉ C.S, ∀ᶠ y' in 𝓝 y, g y' = g y) (x : ℝ) :
    ∃ v, ∀ᶠ y in 𝓝[<] x, g y = v := by
  obtain ⟨l, hl, hsub⟩ := mem_nhdsLT_iff_exists_Ioo_subset.mp (C.eventually_notMem_S_lt x)
  have hc := const_on_Ioo (g := g) (a := l) (b := x) (fun y hy => hg y (hsub hy))
  have hm : (l + x) / 2 ∈ Ioo l x := ⟨by linarith [mem_Iio.mp hl], by linarith [mem_Iio.mp hl]⟩
  exact ⟨g ((l + x) / 2), by filter_upwards [Ioo_mem_nhdsLT (mem_Iio.mp hl)] with y hy using hc y hy _ hm⟩

/-- One-sided constants of a function locally constant off the change set. -/
theorem exists_right_const {β : Type*} {g : ℝ → β} (hg : ∀ y ∉ C.S, ∀ᶠ y' in 𝓝 y, g y' = g y) (x : ℝ) :
    ∃ v, ∀ᶠ y in 𝓝[>] x, g y = v := by
  obtain ⟨u, hu, hsub⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp (C.eventually_notMem_S_gt x)
  have hc := const_on_Ioo (g := g) (a := x) (b := u) (fun y hy => hg y (hsub hy))
  have hm : (x + u) / 2 ∈ Ioo x u := ⟨by linarith [mem_Ioi.mp hu], by linarith [mem_Ioi.mp hu]⟩
  exact ⟨g ((x + u) / 2), by filter_upwards [Ioo_mem_nhdsGT (mem_Ioi.mp hu)] with y hy using hc y hy _ hm⟩

namespace Lift

variable (L : C.Lift)

/-- `l` and `r` are the values of the lift just left and just right of `x` (equal to `f x` when `x ∉ S`). -/
def Sides (x : ℝ) (l r : ℤ) : Prop :=
  (∀ᶠ y in 𝓝[<] x, L.f y = l) ∧ (∀ᶠ y in 𝓝[>] x, L.f y = r) ∧ (x ∉ C.S → l = L.f x ∧ r = L.f x)

/-- Every point has sides, which differ by at most one. -/
theorem exists_sides (x : ℝ) : ∃ l r, L.Sides x l r ∧ |r - l| ≤ 1 := by
  obtain ⟨l, hl⟩ := exists_left_const L.locallyConstant x
  obtain ⟨r, hr⟩ := exists_right_const L.locallyConstant x
  have hsd : x ∉ C.S → l = L.f x ∧ r = L.f x := by
    intro hx
    have h := L.locallyConstant x hx
    constructor
    · obtain ⟨y, h1, h2⟩ := (hl.and (nhdsWithin_le_nhds h)).exists
      rw [← h1, h2]
    · obtain ⟨y, h1, h2⟩ := (hr.and (nhdsWithin_le_nhds h)).exists
      rw [← h1, h2]
  refine ⟨l, r, ⟨hl, hr, hsd⟩, ?_⟩
  obtain ⟨a, ha, hal⟩ := ((L.jump x).and hl).exists
  obtain ⟨b, hb, hbr⟩ := (ha.and hr).exists
  rw [← hal, ← hbr]; exact hb

variable {L}

/-- The sides are unique. -/
theorem Sides.unique {x : ℝ} {l r l' r' : ℤ} (h : L.Sides x l r) (h' : L.Sides x l' r') : l = l' ∧ r = r' :=
  ⟨by obtain ⟨y, h1, h2⟩ := (h.1.and h'.1).exists; rw [← h1, ← h2],
   by obtain ⟨y, h1, h2⟩ := (h.2.1.and h'.2.1).exists; rw [← h1, ← h2]⟩

/-- The colour just left of `x` is the cast of the left side of the lift, and likewise on the right. -/
theorem Sides.vals {x : ℝ} {l r : ℤ} (h : L.Sides x l r) :
    C.LeftVal x (l : ZMod 3) ∧ C.RightVal x (r : ZMod 3) := by
  constructor
  · filter_upwards [h.1, C.eventually_notMem_S_lt x] with y h1 h2
    rw [← L.cast_eq y h2, h1]
  · filter_upwards [h.2.1, C.eventually_notMem_S_gt x] with y h1 h2
    rw [← L.cast_eq y h2, h1]

end Lift

/-- A value just left of `x` is unique. -/
theorem LeftVal.unique {x : ℝ} {a b : ZMod 3} (h : C.LeftVal x a) (h' : C.LeftVal x b) : a = b := by
  obtain ⟨y, h1, h2⟩ := (h.and h').exists; rw [← h1, ← h2]

/-- A value just right of `x` is unique. -/
theorem RightVal.unique {x : ℝ} {a b : ZMod 3} (h : C.RightVal x a) (h' : C.RightVal x b) : a = b := by
  obtain ⟨y, h1, h2⟩ := (h.and h').exists; rw [← h1, ← h2]

/-- Shifting a left-neighbourhood statement. -/
theorem eventually_lt_add {x a : ℝ} {p : ℝ → Prop} (h : ∀ᶠ y in 𝓝[<] (x + a), p y) :
    ∀ᶠ θ in 𝓝[<] x, p (θ + a) := by
  have : Tendsto (fun θ : ℝ => θ + a) (𝓝[<] x) (𝓝[<] (x + a)) :=
    tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within _ ((continuous_add_const a).tendsto' x _ rfl |>.mono_left
      nhdsWithin_le_nhds) (eventually_nhdsWithin_of_forall fun y (hy : y < x) => by
        show y + a < x + a; linarith)
  exact this.eventually h

/-- Shifting a right-neighbourhood statement. -/
theorem eventually_gt_add {x a : ℝ} {p : ℝ → Prop} (h : ∀ᶠ y in 𝓝[>] (x + a), p y) :
    ∀ᶠ θ in 𝓝[>] x, p (θ + a) := by
  have : Tendsto (fun θ : ℝ => θ + a) (𝓝[>] x) (𝓝[>] (x + a)) :=
    tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within _ ((continuous_add_const a).tendsto' x _ rfl |>.mono_left
      nhdsWithin_le_nhds) (eventually_nhdsWithin_of_forall fun y (hy : x < y) => by
        show x + a < y + a; linarith)
  exact this.eventually h


variable (C)


variable {C}

namespace Lift

variable {L : C.Lift}

/-- The jump of the lift across `x` and across `x + 2π` agree (both lift the same change of colour, by at most one). -/
theorem Sides.periodic {x : ℝ} {l r l' r' : ℤ} (h : L.Sides x l r) (h' : L.Sides (x + 2 * π) l' r')
    (hb : |r - l| ≤ 1) (hb' : |r' - l'| ≤ 1) : r' - l' = r - l := by
  have hL : (l' : ZMod 3) = (l : ZMod 3) := by
    obtain ⟨y, ⟨a, b⟩, d⟩ := ((h.1.and (eventually_lt_add h'.1)).and (C.eventually_notMem_S_lt x)).exists
    have hy2 : y + 2 * π ∉ C.S := fun hh => d ((C.periodic_S y).mp hh)
    calc (l' : ZMod 3) = (L.f (y + 2 * π) : ZMod 3) := by rw [b]
      _ = C.c (y + 2 * π) := L.cast_eq _ hy2
      _ = C.c y := C.periodic y
      _ = (L.f y : ZMod 3) := (L.cast_eq y d).symm
      _ = l := by rw [a]
  have hR : (r' : ZMod 3) = (r : ZMod 3) := by
    obtain ⟨y, ⟨a, b⟩, d⟩ := ((h.2.1.and (eventually_gt_add h'.2.1)).and (C.eventually_notMem_S_gt x)).exists
    have hy2 : y + 2 * π ∉ C.S := fun hh => d ((C.periodic_S y).mp hh)
    calc (r' : ZMod 3) = (L.f (y + 2 * π) : ZMod 3) := by rw [b]
      _ = C.c (y + 2 * π) := L.cast_eq _ hy2
      _ = C.c y := C.periodic y
      _ = (L.f y : ZMod 3) := (L.cast_eq y d).symm
      _ = r := by rw [a]
  have h1 := (ZMod.intCast_eq_intCast_iff' _ _ 3).mp hL
  have h2 := (ZMod.intCast_eq_intCast_iff' _ _ 3).mp hR
  rw [abs_le] at hb hb'
  simp only [Nat.cast_ofNat] at h1 h2
  omega

/-- The winding is the same at every `θ` off `S` (`W_eq` with the lift implicit). -/
theorem W_eq_aux {θ θ' : ℝ} (hθ : θ ∉ C.S) (hθ' : θ' ∉ C.S) : L.W θ = L.W θ' := by
  have hT : ∀ y ∈ (univ : Set ℝ), ∀ ε > 0, ∃ z ∈ {z : ℝ | z ∉ C.S}, |z - y| < ε := fun y _ ε hε => by
    obtain ⟨z, hz, hg⟩ := C.exists_good_near y ε hε
    exact ⟨z, hg.notMem, hz⟩
  have hg : ∀ y ∈ (univ : Set ℝ), ∃ ε > 0, ∀ z ∈ {z : ℝ | z ∉ C.S}, |z - y| < ε → ∀ z' ∈ {z : ℝ | z ∉ C.S},
      |z' - y| < ε → (fun z => L.f (z + 2 * π) - L.f z) z = (fun z => L.f (z + 2 * π) - L.f z) z' := by
    intro y _
    obtain ⟨l, r, h, hb⟩ := L.exists_sides y
    obtain ⟨l', r', h', hb'⟩ := L.exists_sides (y + 2 * π)
    have hp := h.periodic h' hb hb'
    have hP : ∀ᶠ z in 𝓝 y, (z < y → L.f z = l ∧ L.f (z + 2 * π) = l') ∧
        (y < z → L.f z = r ∧ L.f (z + 2 * π) = r') := by
      have a := eventually_nhdsWithin_iff.mp (h.1.and (eventually_lt_add h'.1))
      have b := eventually_nhdsWithin_iff.mp (h.2.1.and (eventually_gt_add h'.2.1))
      filter_upwards [a, b] with z hz1 hz2
      exact ⟨fun hlt => hz1 hlt, fun hgt => hz2 hgt⟩
    obtain ⟨ε, hε, hεP⟩ := Metric.eventually_nhds_iff.mp hP
    have hval : ∀ z ∈ {z : ℝ | z ∉ C.S}, |z - y| < ε → L.f (z + 2 * π) - L.f z = r' - r := by
      intro z hz hzy
      have hzy' : dist z y < ε := by rwa [Real.dist_eq]
      obtain ⟨hlt, hgt⟩ := hεP hzy'
      rcases lt_trichotomy z y with h1 | h1 | h1
      · obtain ⟨a, b⟩ := hlt h1; rw [a, b]; omega
      · subst h1
        have hy2 : z + 2 * π ∉ C.S := fun hh => hz ((C.periodic_S z).mp hh)
        obtain ⟨a1, a2⟩ := h.2.2 hz
        obtain ⟨b1, b2⟩ := h'.2.2 hy2
        rw [← a2, ← b2]
      · obtain ⟨a, b⟩ := hgt h1; rw [a, b]
    exact ⟨ε, hε, fun z hz hzy z' hz' hzy' => by simp only; rw [hval z hz hzy, hval z' hz' hzy']⟩
  have := const_of_local isPreconnected_univ hT hg θ ⟨hθ, mem_univ _⟩ θ' ⟨hθ', mem_univ _⟩
  unfold Lift.W
  rw [this]

/-- The hexagon difference vanishes mod 3 nowhere: `c(z) ≠ c(z + 60°)` lifts to `D₀(z) ≢ 0 (mod 3)`. -/
theorem D0_mod_ne {z : ℝ} (hz : z ∉ C.S) (hz' : z + π / 3 ∉ C.S) : L.D 0 z % 3 ≠ 0 := by
  intro h
  have hd : ((L.D 0 z : ℤ) : ZMod 3) = 0 :=
    (ZMod.intCast_zmod_eq_zero_iff_dvd _ 3).mpr (Int.dvd_of_emod_eq_zero h)
  unfold Lift.D at hd
  push_cast at hd
  simp only [zero_add, one_mul, zero_mul, add_zero] at hd
  have e1 := L.cast_eq _ hz'
  have e0 := L.cast_eq _ hz
  have : C.c (z + π / 3) = C.c z := by rw [← e1, ← e0]; exact sub_eq_zero.mp hd
  exact C.proper z hz hz' this.symm

end Lift


/-- `D j θ` is `D 0` at the `j`-th hexagon point. -/
theorem Lift.D_eq_D0 (L : C.Lift) (j : ℕ) (θ : ℝ) : L.D j θ = L.D 0 (θ + j * (π / 3)) := by
  unfold Lift.D
  congr 2 <;> push_cast <;> ring_nf

/-- `step` of two casts, from the residue of the difference. -/
theorem step_cast (a b : ℤ) (h : (b - a) % 3 ≠ 0) :
    step (a : ZMod 3) (b : ZMod 3) = if (b - a) % 3 = 2 then -1 else 1 := by
  have hb : (b : ZMod 3) = a + ((b - a : ℤ) : ZMod 3) := by push_cast; ring
  rcases (by omega : (b - a) % 3 = 1 ∨ (b - a) % 3 = 2) with h1 | h2
  · have : ((b - a : ℤ) : ZMod 3) = ((1 : ℤ) : ZMod 3) :=
      (ZMod.intCast_eq_intCast_iff' _ _ 3).mpr (by simp only [Nat.cast_ofNat]; omega)
    rw [this] at hb
    rw [h1, if_neg (by norm_num)]
    unfold step
    rw [hb]; simp
  · have : ((b - a : ℤ) : ZMod 3) = ((2 : ℤ) : ZMod 3) :=
      (ZMod.intCast_eq_intCast_iff' _ _ 3).mpr (by simp only [Nat.cast_ofNat]; omega)
    rw [this] at hb
    rw [h2, if_pos rfl]
    unfold step
    have h21 : ((2 : ℤ) : ZMod 3) = -1 := by decide
    rw [hb, h21]
    have : (a : ZMod 3) + -1 ≠ a + 1 := by
      intro h; have := add_left_cancel h; revert this; decide
    simp [this, sub_eq_add_neg]

namespace Lift

variable {L : C.Lift}

/-- At a good angle every hexagon step is nonzero mod 3. -/
theorem D_mod_ne_good {θ : ℝ} (hθ : C.Good θ) {j : ℕ} (hj : j < 6) : L.D j θ % 3 ≠ 0 := by
  rw [L.D_eq_D0]
  refine D0_mod_ne ?_ ?_
  · exact hθ j hj
  · have := hθ.hex_notMem (i := j + 1) (by omega)
    rwa [show θ + ((j + 1 : ℕ) : ℝ) * (π / 3) = θ + j * (π / 3) + π / 3 by push_cast; ring] at this

/-- The summary of a good hexagon: `n₂ ≡ 0 (mod 3)`, `3h = 6 − 2n₂`, `3W = 3Σm + 6 + n₂`. -/
theorem hex_summary {θ : ℝ} (hθ : C.Good θ) :
    ∃ n : ℕ, L.n₂ θ = n ∧ n % 3 = 0 ∧ n ≤ 6 ∧ C.hSum θ = 6 - 2 * (n : ℤ) ∧
      L.W θ = ∑ j ∈ Finset.range 6, L.m j θ + 2 + n / 3 := by
  have hmod : ∀ j ∈ Finset.range 6, L.D j θ % 3 ≠ 0 := fun j hj => D_mod_ne_good hθ (Finset.mem_range.mp hj)
  have hn : L.n₂ θ ≤ 6 := by
    unfold Lift.n₂
    calc _ ≤ (Finset.range 6).card := Finset.card_filter_le _ _
      _ = 6 := by simp
  have hsumD : ∑ j ∈ Finset.range 6, L.D j θ = L.f (θ + 2 * π) - L.f θ := by
    have := Finset.sum_range_sub (fun j : ℕ => L.f (θ + j * (π / 3))) 6
    rw [show θ + ((6 : ℕ) : ℝ) * (π / 3) = θ + 2 * π by push_cast; ring] at this
    simp only [Nat.cast_zero, zero_mul, add_zero] at this
    rw [← this]
    refine Finset.sum_congr rfl fun j _ => ?_
    unfold Lift.D
    congr 2; push_cast; ring_nf
  have hdvd : (3 : ℤ) ∣ L.f (θ + 2 * π) - L.f θ := by
    have h1 := L.cast_eq _ (show θ + 2 * π ∉ C.S by rw [C.periodic_S]; exact hθ.notMem)
    have h0 := L.cast_eq _ hθ.notMem
    have := (ZMod.intCast_zmod_eq_zero_iff_dvd (L.f (θ + 2 * π) - L.f θ) 3).mp
      (by push_cast; rw [h1, h0, C.periodic]; simp)
    exact_mod_cast this
  have hsum3 : ∑ j ∈ Finset.range 6, L.D j θ =
      3 * ∑ j ∈ Finset.range 6, L.m j θ + ∑ j ∈ Finset.range 6, (if L.D j θ % 3 = 2 then (2 : ℤ) else 1) := by
    rw [Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j hj => ?_
    have := hmod j hj
    unfold Lift.m
    split_ifs <;> omega
  have hite2 : ∑ j ∈ Finset.range 6, (if L.D j θ % 3 = 2 then (2 : ℤ) else 1) = 6 + (L.n₂ θ : ℤ) := by
    have : ∀ j ∈ Finset.range 6, (if L.D j θ % 3 = 2 then (2 : ℤ) else 1) = 1 + (if L.D j θ % 3 = 2 then 1 else 0) := by
      intro j _; split_ifs <;> norm_num
    rw [Finset.sum_congr rfl this, Finset.sum_add_distrib]
    unfold Lift.n₂
    rw [Finset.card_filter]; push_cast; simp
  have hite1 : ∑ j ∈ Finset.range 6, (if L.D j θ % 3 = 2 then (-1 : ℤ) else 1) = 6 - 2 * (L.n₂ θ : ℤ) := by
    have : ∀ j ∈ Finset.range 6, (if L.D j θ % 3 = 2 then (-1 : ℤ) else 1) = 1 - 2 * (if L.D j θ % 3 = 2 then 1 else 0) := by
      intro j _; split_ifs <;> norm_num
    rw [Finset.sum_congr rfl this, Finset.sum_sub_distrib, ← Finset.mul_sum]
    unfold Lift.n₂
    rw [Finset.card_filter]; push_cast; simp
  have hhSum : C.hSum θ = 6 - 2 * (L.n₂ θ : ℤ) := by
    rw [← hite1]
    unfold CircleColouring.hSum
    refine Finset.sum_congr rfl fun j hj => ?_
    have hj' := Finset.mem_range.mp hj
    have e0 := L.cast_eq _ (hθ j hj')
    have e1 := L.cast_eq _ (hθ.hex_notMem (i := j + 1) (by omega))
    rw [← e0, show θ + ((j : ℝ) + 1) * (π / 3) = θ + ((j + 1 : ℕ) : ℝ) * (π / 3) by push_cast; ring, ← e1,
      step_cast _ _ (by have := hmod j hj; unfold Lift.D at this; rw [show θ + ((j : ℝ) + 1) * (π / 3) = θ + ((j + 1 : ℕ) : ℝ) * (π / 3) by push_cast; ring] at this; exact this)]
    unfold Lift.D
    push_cast
    rfl
  refine ⟨L.n₂ θ, rfl, ?_, hn, hhSum, ?_⟩
  · have : (3 : ℤ) ∣ (L.n₂ θ : ℤ) := by
      have h3 : (3 : ℤ) ∣ 3 * ∑ j ∈ Finset.range 6, L.m j θ + (6 + (L.n₂ θ : ℤ)) := by
        rw [← hite2, ← hsum3, hsumD]; exact hdvd
      omega
    omega
  · unfold Lift.W
    rw [← hsumD, hsum3, hite2]
    have : (3 : ℤ) ∣ (L.n₂ θ : ℤ) := by
      have h3 : (3 : ℤ) ∣ 3 * ∑ j ∈ Finset.range 6, L.m j θ + (6 + (L.n₂ θ : ℤ)) := by
        rw [← hite2, ← hsum3, hsumD]; exact hdvd
      omega
    omega

end Lift

variable (C)


/-! ## The lift of a circle colouring -/

/-- The integer step of the lift at `x`: the left and right colours' representatives `0, 1, 2` differ by at most two, and a
difference of `±2` is replaced by the step `∓1` that is congruent to it mod 3. -/
private noncomputable def liftStep (cl cr : ℝ → ZMod 3) (x : ℝ) : ℤ :=
  if ((cr x).val : ℤ) - (cl x).val = 2 then -1 else if ((cr x).val : ℤ) - (cl x).val = -2 then 1 else 0

/-- The sum of the steps over the change points in `(a, b]`. -/
private noncomputable def liftB (C : CircleColouring) (cl cr : ℝ → ZMod 3) (a b : ℝ) : ℤ :=
  ∑ᶠ s ∈ C.S ∩ Ioc a b, liftStep cl cr s

/-- The cumulative step function. -/
private noncomputable def liftA (C : CircleColouring) (cl cr : ℝ → ZMod 3) (θ : ℝ) : ℤ :=
  liftB C cl cr 0 θ - liftB C cl cr θ 0

private theorem liftB_fin (C : CircleColouring) (a b : ℝ) : (C.S ∩ Ioc a b).Finite :=
  (C.S_inter_Icc_finite a b).subset (inter_subset_inter_right _ Ioc_subset_Icc_self)

private theorem liftB_add (C : CircleColouring) (cl cr : ℝ → ZMod 3) {a b c : ℝ} (hab : a ≤ b) (hbc : b ≤ c) :
    liftB C cl cr a c = liftB C cl cr a b + liftB C cl cr b c := by
  unfold liftB
  rw [← finsum_mem_union _ (liftB_fin C a b) (liftB_fin C b c)]
  · rw [← inter_union_distrib_left, Ioc_union_Ioc_eq_Ioc hab hbc]
  · exact Set.disjoint_of_subset (inter_subset_right) (inter_subset_right) (Ioc_disjoint_Ioc_of_le le_rfl)

private theorem liftB_of_le (C : CircleColouring) (cl cr : ℝ → ZMod 3) {a b : ℝ} (h : b ≤ a) :
    liftB C cl cr a b = 0 := by
  unfold liftB; rw [Ioc_eq_empty (not_lt.mpr h)]; simp

private theorem liftA_sub (C : CircleColouring) (cl cr : ℝ → ZMod 3) {a b : ℝ} (hab : a ≤ b) :
    liftA C cl cr b - liftA C cl cr a = liftB C cl cr a b := by
  unfold liftA
  rcases le_total 0 a with h0 | h0
  · have := liftB_add C cl cr h0 hab
    have e1 := liftB_of_le C cl cr (a := b) (b := 0) (h0.trans hab)
    have e2 := liftB_of_le C cl cr (a := a) (b := 0) h0
    linarith
  · rcases le_total 0 b with h1 | h1
    · have := liftB_add C cl cr h0 h1
      have e1 := liftB_of_le C cl cr (a := b) (b := 0) h1
      have e2 := liftB_of_le C cl cr (a := 0) (b := a) h0
      linarith
    · have := liftB_add C cl cr hab h1
      have e1 := liftB_of_le C cl cr (a := 0) (b := b) h1
      have e2 := liftB_of_le C cl cr (a := 0) (b := a) h0
      linarith

private theorem liftB_empty (C : CircleColouring) (cl cr : ℝ → ZMod 3) {a b : ℝ} (h : C.S ∩ Ioc a b = ∅) :
    liftB C cl cr a b = 0 := by
  unfold liftB; rw [h]; simp

private theorem liftB_single (C : CircleColouring) (cl cr : ℝ → ZMod 3) {a b x : ℝ} (h : C.S ∩ Ioc a b = {x}) :
    liftB C cl cr a b = liftStep cl cr x := by
  unfold liftB; rw [h]; simp

/-- Every circle colouring has a lift (integrate the steps `±1` across the finitely many change points of a period). -/
theorem exists_lift : Nonempty C.Lift := by
  choose cl hcl using fun x : ℝ => exists_left_const C.locallyConstant x
  choose cr hcr using fun x : ℝ => exists_right_const C.locallyConstant x
  have hfree : ∀ x : ℝ, ∃ δ > 0, ∀ y, |y - x| < δ → y ≠ x → y ∉ C.S := by
    intro x
    obtain ⟨δ, hδ, h⟩ := Metric.eventually_nhds_iff.mp (eventually_nhdsWithin_iff.mp (C.eventually_notMem_S x))
    exact ⟨δ, hδ, fun y hy hne => h (by rwa [Real.dist_eq]) hne⟩
  have hAconst : ∀ θ ∉ C.S, ∃ δ > 0, ∀ y, |y - θ| < δ → liftA C cl cr y = liftA C cl cr θ := by
    intro θ hθ
    obtain ⟨δ, hδ, hδ'⟩ := hfree θ
    refine ⟨δ, hδ, fun y hy => ?_⟩
    have hempty : ∀ u v : ℝ, |u - θ| < δ → |v - θ| < δ → u ≤ v → (θ ≤ u ∨ v ≤ θ) → C.S ∩ Ioc u v = ∅ := by
      intro u v hu hv huv hside
      refine eq_empty_iff_forall_notMem.mpr fun s ⟨hs, h1, h2⟩ => ?_
      have hsθ : |s - θ| < δ := by
        rw [abs_lt] at hu hv ⊢; constructor <;> linarith
      by_cases hsθ' : s = θ
      · exact hθ (hsθ' ▸ hs)
      · exact hδ' s hsθ hsθ' hs
    rcases le_total y θ with h | h
    · have := liftA_sub C cl cr h
      rw [liftB_empty C cl cr (hempty y θ hy (by simp [hδ]) h (Or.inr le_rfl))] at this
      linarith
    · have := liftA_sub C cl cr h
      rw [liftB_empty C cl cr (hempty θ y (by simp [hδ]) hy h (Or.inl le_rfl))] at this
      linarith
  refine ⟨{ f := fun θ => ((C.c θ).val : ℤ) + 3 * liftA C cl cr θ, cast_eq := ?_, locallyConstant := ?_, jump := ?_ }⟩
  · intro θ _
    push_cast
    rw [ZMod.natCast_zmod_val]
    rw [show (3 : ZMod 3) = 0 from rfl]; simp
  · intro θ hθ
    obtain ⟨δ, hδ, hδ'⟩ := hAconst θ hθ
    filter_upwards [Metric.ball_mem_nhds θ hδ, C.locallyConstant θ hθ] with y hy hc
    rw [hc, hδ' y (by rwa [Metric.mem_ball, Real.dist_eq] at hy)]
  · intro x
    obtain ⟨δ, hδ, hδ'⟩ := hfree x
    have hsub : ∀ a b : ℝ, x - δ < a → b < x + δ → ∀ s ∈ C.S ∩ Ioc a b, s = x := by
      intro a b ha hb s ⟨hs, h1, h2⟩
      by_contra hne
      exact hδ' s (by rw [abs_lt]; constructor <;> linarith) hne hs
    have hL := Ioo_mem_nhdsLT (show x - δ < x by linarith)
    have hR := Ioo_mem_nhdsGT (show x < x + δ by linarith)
    by_cases hx : x ∈ C.S
    · filter_upwards [hL, hcl x] with a ha hca
      filter_upwards [hR, hcr x] with b hb hcb
      have hsingle : C.S ∩ Ioc a b = {x} :=
        Set.eq_singleton_iff_unique_mem.mpr ⟨⟨hx, ha.2, hb.1.le⟩, fun s hs => hsub a b ha.1 hb.2 s hs⟩
      have := liftA_sub C cl cr (show a ≤ b by linarith [ha.2, hb.1])
      rw [liftB_single C cl cr hsingle] at this
      have h3a := ZMod.val_lt (cl x)
      have h3b := ZMod.val_lt (cr x)
      rw [hca, hcb, abs_le]
      unfold liftStep at this
      split_ifs at this <;> omega
    · filter_upwards [hL, nhdsWithin_le_nhds (C.locallyConstant x hx)] with a ha hca
      filter_upwards [hR, nhdsWithin_le_nhds (C.locallyConstant x hx)] with b hb hcb
      have hempty : C.S ∩ Ioc a b = ∅ := eq_empty_iff_forall_notMem.mpr fun s hs => by
        have := hsub a b ha.1 hb.2 s hs
        exact hx (this ▸ hs.1)
      have := liftA_sub C cl cr (show a ≤ b by linarith [ha.2, hb.1])
      rw [liftB_empty C cl cr hempty] at this
      rw [hca, hcb]
      have : liftA C cl cr b = liftA C cl cr a := by linarith
      rw [this]; simp

/-- The positions carrying two change points `60°` apart: `θ` with `θ + 60°j, θ + 60°(j + 1) ∈ S` for some `j < 6`. -/
def PairPos (θ : ℝ) : Prop := ∃ j : ℕ, j < 6 ∧ θ + j * (π / 3) ∈ C.S ∧ θ + (j + 1) * (π / 3) ∈ C.S

variable {C} (L : C.Lift)

/-- **FS129-SR1-RINGBAND** (i): `3h(θ) = hSum(θ) = 6 − 2n₂(θ)`, and `h(θ) ∈ {−2, 0, 2}`. -/
theorem ringband_i {θ : ℝ} (hθ : C.Good θ) :
    3 * C.h θ = C.hSum θ ∧ C.hSum θ = 6 - 2 * (L.n₂ θ : ℤ) ∧ C.h θ ∈ ({-2, 0, 2} : Set ℤ) := by
  obtain ⟨n, hn, h3, h6, hS, -⟩ := Lift.hex_summary (L := L) hθ
  rw [hn] at *
  unfold CircleColouring.h
  rw [hS]
  refine ⟨by omega, rfl, ?_⟩
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
  omega

/-- **FS129-SR1-RINGBAND** (ii): `W = m₀ + … + m₅ + 3 − h/2` at every good `θ` (and `3` divides `f(θ + 2π) − f(θ)`). -/
theorem ringband_ii {θ : ℝ} (hθ : C.Good θ) :
    3 ∣ L.f (θ + 2 * π) - L.f θ ∧ L.W θ = ∑ j ∈ Finset.range 6, L.m j θ + 3 - C.h θ / 2 := by
  obtain ⟨n, hn, h3, h6, hS, hW⟩ := Lift.hex_summary (L := L) hθ
  refine ⟨?_, ?_⟩
  · have h1 := L.cast_eq _ (show θ + 2 * π ∉ C.S by rw [C.periodic_S]; exact hθ.notMem)
    have h0 := L.cast_eq _ hθ.notMem
    have := (ZMod.intCast_zmod_eq_zero_iff_dvd (L.f (θ + 2 * π) - L.f θ) 3).mp
      (by push_cast; rw [h1, h0, C.periodic]; simp)
    exact_mod_cast this
  · rw [hW]
    unfold CircleColouring.h
    rw [hS]
    omega

/-- **FS129-SR1-RINGBAND**, the row's "put `W = (c̃(θ + 360°) − c̃(θ))/3`": the winding is the same at every `θ` off `S`. -/
theorem W_eq {θ θ' : ℝ} (hθ : θ ∉ C.S) (hθ' : θ' ∉ C.S) : L.W θ = L.W θ' :=
  Lift.W_eq_aux hθ hθ'


/-- `D j θ` as a difference of two hexagon values. -/
theorem D_eq_sub (j : ℕ) (θ : ℝ) :
    L.D j θ = L.f (θ + ((j + 1 : ℕ) : ℝ) * (π / 3)) - L.f (θ + (j : ℝ) * (π / 3)) := by
  unfold Lift.D; push_cast; rfl

/-- Near `θ₀`, the hexagon values of a good angle are the sides of the lift at the hexagon points of `θ₀`. -/
theorem hex_near (θ₀ : ℝ) : ∃ l r : ℕ → ℤ, (∀ i : ℕ, |r i - l i| ≤ 1) ∧
    (∀ i : ℕ, θ₀ + (i : ℝ) * (π / 3) ∉ C.S → l i = r i) ∧ (r 6 - l 6 = r 0 - l 0) ∧
    ∃ ε > 0, ∀ θ, |θ - θ₀| < ε → C.Good θ → ∀ i : ℕ, i ≤ 6 → L.f (θ + (i : ℝ) * (π / 3)) = if θ ≤ θ₀ then l i else r i := by
  choose l r hlr using fun i : ℕ => L.exists_sides (θ₀ + (i : ℝ) * (π / 3))
  refine ⟨l, r, fun i => (hlr i).2, fun i hi => ?_, ?_, ?_⟩
  · have := (hlr i).1.2.2 hi; rw [this.1, this.2]
  · have h6 : θ₀ + ((6 : ℕ) : ℝ) * (π / 3) = (θ₀ + ((0 : ℕ) : ℝ) * (π / 3)) + 2 * π := by push_cast; ring
    have h6' := (hlr 6).1
    rw [h6] at h6'
    exact Lift.Sides.periodic (L := L) (hlr 0).1 h6' (hlr 0).2 (hlr 6).2
  · have hA : ∀ᶠ θ in 𝓝[<] θ₀, ∀ i ∈ Finset.range 7, L.f (θ + (i : ℝ) * (π / 3)) = l i := by
      rw [eventually_all_finset]
      intro i _
      exact eventually_lt_add (x := θ₀) (a := (i : ℝ) * (π / 3)) (p := fun y => L.f y = l i) (hlr i).1.1
    have hB : ∀ᶠ θ in 𝓝[>] θ₀, ∀ i ∈ Finset.range 7, L.f (θ + (i : ℝ) * (π / 3)) = r i := by
      rw [eventually_all_finset]
      intro i _
      exact eventually_gt_add (x := θ₀) (a := (i : ℝ) * (π / 3)) (p := fun y => L.f y = r i) (hlr i).1.2.1
    have hP := (eventually_nhdsWithin_iff.mp hA).and (eventually_nhdsWithin_iff.mp hB)
    obtain ⟨ε, hε, h⟩ := Metric.eventually_nhds_iff.mp hP
    refine ⟨ε, hε, fun θ hθ hg i hi => ?_⟩
    have hθ' : dist θ θ₀ < ε := by rwa [Real.dist_eq]
    obtain ⟨h1, h2⟩ := h hθ'
    have hi' : i ∈ Finset.range 7 := Finset.mem_range.mpr (by omega)
    rcases lt_trichotomy θ θ₀ with hlt | heq | hgt
    · rw [if_pos hlt.le]; exact h1 hlt i hi'
    · subst heq
      rw [if_pos le_rfl]
      exact ((hlr i).1.2.2 (hg.hex_notMem hi)).1.symm
    · rw [if_neg (not_le.mpr hgt)]; exact h2 hgt i hi'

/-- Away from pairs, the thirds `m_j` agree across `θ₀`. -/
theorem m_eq_near {θ₀ : ℝ} (h0 : ¬ C.PairPos θ₀) : ∃ ε > 0, ∀ θ θ', |θ - θ₀| < ε → |θ' - θ₀| < ε →
    C.Good θ → C.Good θ' → ∀ j < 6, L.m j θ = L.m j θ' := by
  obtain ⟨l, r, hb, hlr, hper, ε, hε, hnear⟩ := hex_near L θ₀
  refine ⟨ε, hε, fun θ θ' hθ hθ' hg hg' j hj => ?_⟩
  have hD := fun (x : ℝ) (hx : C.Good x) => Lift.D_mod_ne_good (L := L) hx hj
  have eθ := hnear θ hθ hg
  have eθ' := hnear θ' hθ' hg'
  have dθ := D_eq_sub L j θ
  have dθ' := D_eq_sub L j θ'
  have hj1 : j + 1 ≤ 6 := by omega
  rw [eθ j hj.le, eθ (j + 1) hj1] at dθ
  rw [eθ' j hj.le, eθ' (j + 1) hj1] at dθ'
  have mθ := hD θ hg
  have mθ' := hD θ' hg'
  -- nonadjacent jumps
  have hnonadj : r j - l j = 0 ∨ r (j + 1) - l (j + 1) = 0 := by
    by_contra hcon
    push Not at hcon
    apply h0
    refine ⟨j, hj, ?_, ?_⟩
    · by_contra hx; exact hcon.1 (by have := hlr j hx; omega)
    · by_contra hx
      apply hcon.2
      have := hlr (j + 1) (by rwa [show θ₀ + ((j + 1 : ℕ) : ℝ) * (π / 3) = θ₀ + ((j : ℝ) + 1) * (π / 3) by push_cast; ring])
      omega
  have hb1 := hb j
  have hb2 := hb (j + 1)
  rw [abs_le] at hb1 hb2
  unfold Lift.m
  by_cases c1 : θ ≤ θ₀ <;> by_cases c2 : θ' ≤ θ₀ <;> simp only [c1, c2, if_true, if_false] at dθ dθ' mθ mθ' ⊢ <;> omega


/-- `h` is determined by the `m_j` and the winding. -/
theorem h_eq_of_m_eq {θ θ' : ℝ} (hθ : C.Good θ) (hθ' : C.Good θ') (hm : ∀ j < 6, L.m j θ = L.m j θ') :
    C.h θ = C.h θ' := by
  have i1 := (ringband_ii L hθ).2
  have i2 := (ringband_ii L hθ').2
  have w := W_eq L hθ.notMem hθ'.notMem
  have hs : ∑ j ∈ Finset.range 6, L.m j θ = ∑ j ∈ Finset.range 6, L.m j θ' :=
    Finset.sum_congr rfl fun j hj => hm j (Finset.mem_range.mp hj)
  have a1 := (ringband_i L hθ).2.2
  have a2 := (ringband_i L hθ').2.2
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at a1 a2
  omega

/-- `m_j(θ) = m_0(θ + 60°j)`. -/
theorem m_eq_m0 (j : ℕ) (θ : ℝ) : L.m j θ = L.m 0 (θ + j * (π / 3)) := by
  unfold Lift.m; rw [Lift.D_eq_D0]

/-- The set where `D₀` is read: `z` and `z + 60°` off the change set. -/
def T0 (C : CircleColouring) : Set ℝ := {z | z ∉ C.S ∧ z + π / 3 ∉ C.S}

/-- Near any `y`, `D₀` at a point of `T0` is the left difference, the right difference, or both. -/
theorem D0_near (y : ℝ) {l₀ r₀ l₁ r₁ : ℤ} (h0 : L.Sides y l₀ r₀) (h1 : L.Sides (y + π / 3) l₁ r₁) :
    ∃ ε > 0, ∀ z ∈ T0 C, |z - y| < ε →
      (z < y ∧ L.D 0 z = l₁ - l₀) ∨ (y < z ∧ L.D 0 z = r₁ - r₀) ∨
        (z = y ∧ L.D 0 z = l₁ - l₀ ∧ L.D 0 z = r₁ - r₀) := by
  have hP : ∀ᶠ z in 𝓝 y, (z < y → L.f z = l₀ ∧ L.f (z + π / 3) = l₁) ∧
      (y < z → L.f z = r₀ ∧ L.f (z + π / 3) = r₁) := by
    have a := eventually_nhdsWithin_iff.mp (h0.1.and (eventually_lt_add (a := π / 3) h1.1))
    have b := eventually_nhdsWithin_iff.mp (h0.2.1.and (eventually_gt_add (a := π / 3) h1.2.1))
    filter_upwards [a, b] with z hz1 hz2
    exact ⟨fun hlt => hz1 hlt, fun hgt => hz2 hgt⟩
  obtain ⟨ε, hε, hεP⟩ := Metric.eventually_nhds_iff.mp hP
  refine ⟨ε, hε, fun z hz hzy => ?_⟩
  have hzy' : dist z y < ε := by rwa [Real.dist_eq]
  obtain ⟨hlt, hgt⟩ := hεP hzy'
  have hD : L.D 0 z = L.f (z + π / 3) - L.f z := by
    unfold Lift.D; simp only [Nat.cast_zero, zero_add, one_mul, zero_mul, add_zero]
  rcases lt_trichotomy z y with a | a | a
  · obtain ⟨u, v⟩ := hlt a; exact Or.inl ⟨a, by rw [hD, u, v]⟩
  · subst a
    obtain ⟨a1, a2⟩ := h0.2.2 hz.1
    obtain ⟨b1, b2⟩ := h1.2.2 hz.2
    exact Or.inr (Or.inr ⟨rfl, by rw [hD, ← a1, ← b1], by rw [hD, ← a2, ← b2]⟩)
  · obtain ⟨u, v⟩ := hgt a; exact Or.inr (Or.inl ⟨a, by rw [hD, u, v]⟩)

/-- `m₀` is constant on `T0` once no step jumps by two. -/
theorem m0_const (hbig : ∀ x : ℝ, ∀ l₀ r₀ l₁ r₁ : ℤ, L.Sides x l₀ r₀ → L.Sides (x + π / 3) l₁ r₁ →
      |r₀ - l₀| ≤ 1 → |r₁ - l₁| ≤ 1 → |(r₁ - l₁) - (r₀ - l₀)| ≤ 1) :
    ∀ z ∈ T0 C, ∀ z' ∈ T0 C, L.m 0 z = L.m 0 z' := by
  have hT : ∀ y ∈ (univ : Set ℝ), ∀ ε > 0, ∃ z ∈ T0 C, |z - y| < ε := fun y _ ε hε => by
    obtain ⟨z, hz, hg⟩ := C.exists_good_near y ε hε
    refine ⟨z, ⟨hg.notMem, ?_⟩, hz⟩
    have := hg.hex_notMem (i := 1) (by norm_num)
    simpa using this
  have hg : ∀ y ∈ (univ : Set ℝ), ∃ ε > 0, ∀ z ∈ T0 C, |z - y| < ε → ∀ z' ∈ T0 C,
      |z' - y| < ε → L.m 0 z = L.m 0 z' := by
    intro y _
    obtain ⟨l₀, r₀, h0, b0⟩ := L.exists_sides y
    obtain ⟨l₁, r₁, h1, b1⟩ := L.exists_sides (y + π / 3)
    have hb := hbig y l₀ r₀ l₁ r₁ h0 h1 b0 b1
    obtain ⟨ε, hε, hnear⟩ := D0_near L y h0 h1
    refine ⟨ε, hε, fun z hz hzy z' hz' hzy' => ?_⟩
    have mz := Lift.D0_mod_ne (L := L) hz.1 hz.2
    have mz' := Lift.D0_mod_ne (L := L) hz'.1 hz'.2
    rw [abs_le] at hb b0 b1
    unfold Lift.m
    rcases hnear z hz hzy with a | a | a <;> rcases hnear z' hz' hzy' with b | b | b <;> omega
  exact fun z hz z' hz' => const_of_local isPreconnected_univ hT hg z ⟨hz, mem_univ _⟩ z' ⟨hz', mem_univ _⟩

/-- All `m_j` are one integer once `m₀` is constant on `T0`. -/
theorem exists_M (hconst : ∀ z ∈ T0 C, ∀ z' ∈ T0 C, L.m 0 z = L.m 0 z') :
    ∃ M : ℤ, ∀ θ, C.Good θ → ∀ j < 6, L.m j θ = M := by
  obtain ⟨θ₁, -, hg₁⟩ := C.exists_good_near 0 1 one_pos
  have hT : ∀ θ, C.Good θ → ∀ j : ℕ, j < 6 → θ + j * (π / 3) ∈ T0 C := fun θ hθ j hj => by
    refine ⟨hθ j hj, ?_⟩
    have := hθ.hex_notMem (i := j + 1) (by omega)
    rwa [show θ + ((j + 1 : ℕ) : ℝ) * (π / 3) = θ + j * (π / 3) + π / 3 by push_cast; ring] at this
  refine ⟨L.m 0 θ₁, fun θ hθ j hj => ?_⟩
  rw [m_eq_m0]
  exact hconst _ (hT θ hθ j hj) θ₁ (by simpa using hT θ₁ hg₁ 0 (by norm_num))


/-- `D₀` as a plain difference. -/
theorem D0_eq (z : ℝ) : L.D 0 z = L.f (z + π / 3) - L.f z := by
  unfold Lift.D; simp only [Nat.cast_zero, zero_add, one_mul, zero_mul, add_zero]

/-- Just left of `x` there are points of `T0` where `D₀` is the left difference. -/
theorem exists_T0_left {x : ℝ} {l₀ r₀ l₁ r₁ : ℤ} (h0 : L.Sides x l₀ r₀) (h1 : L.Sides (x + π / 3) l₁ r₁) :
    ∃ z ∈ T0 C, L.D 0 z = l₁ - l₀ := by
  obtain ⟨z, ⟨⟨hz0, hz1⟩, hz2⟩, hz3⟩ := (((h0.1.and (eventually_lt_add (a := π / 3) h1.1)).and
    (C.eventually_notMem_S_lt x)).and (eventually_lt_add (a := π / 3) (C.eventually_notMem_S_lt (x + π / 3)))).exists
  exact ⟨z, ⟨hz2, hz3⟩, by rw [D0_eq, hz0, hz1]⟩

/-- Just right of `x` there are points of `T0` where `D₀` is the right difference. -/
theorem exists_T0_right {x : ℝ} {l₀ r₀ l₁ r₁ : ℤ} (h0 : L.Sides x l₀ r₀) (h1 : L.Sides (x + π / 3) l₁ r₁) :
    ∃ z ∈ T0 C, L.D 0 z = r₁ - r₀ := by
  obtain ⟨z, ⟨⟨hz0, hz1⟩, hz2⟩, hz3⟩ := (((h0.2.1.and (eventually_gt_add (a := π / 3) h1.2.1)).and
    (C.eventually_notMem_S_gt x)).and (eventually_gt_add (a := π / 3) (C.eventually_notMem_S_gt (x + π / 3)))).exists
  exact ⟨z, ⟨hz2, hz3⟩, by rw [D0_eq, hz0, hz1]⟩

/-- No two change points `60°` apart: no step jumps by two. -/
theorem hbig_of_noPair (hno : ∀ x ∈ C.S, x + π / 3 ∉ C.S) : ∀ x : ℝ, ∀ l₀ r₀ l₁ r₁ : ℤ,
    L.Sides x l₀ r₀ → L.Sides (x + π / 3) l₁ r₁ → |r₀ - l₀| ≤ 1 → |r₁ - l₁| ≤ 1 →
      |(r₁ - l₁) - (r₀ - l₀)| ≤ 1 := by
  intro x l₀ r₀ l₁ r₁ h0 h1 b0 b1
  rw [abs_le] at b0 b1 ⊢
  by_cases hx : x ∈ C.S
  · have := h1.2.2 (hno x hx); omega
  · have := h0.2.2 hx; omega

/-- No swap point: no step jumps by two. -/
theorem hbig_of_noSwap (hns : ∀ x, ¬ C.IsSwap x) : ∀ x : ℝ, ∀ l₀ r₀ l₁ r₁ : ℤ,
    L.Sides x l₀ r₀ → L.Sides (x + π / 3) l₁ r₁ → |r₀ - l₀| ≤ 1 → |r₁ - l₁| ≤ 1 →
      |(r₁ - l₁) - (r₀ - l₀)| ≤ 1 := by
  intro x l₀ r₀ l₁ r₁ h0 h1 b0 b1
  by_contra hbig
  rw [not_le] at hbig
  rw [abs_le] at b0 b1
  obtain ⟨zl, hzl, hzl'⟩ := exists_T0_left L h0 h1
  obtain ⟨zr, hzr, hzr'⟩ := exists_T0_right L h0 h1
  have m1 := Lift.D0_mod_ne (L := L) hzl.1 hzl.2
  have m2 := Lift.D0_mod_ne (L := L) hzr.1 hzr.2
  rw [hzl'] at m1
  rw [hzr'] at m2
  have hx : x ∈ C.S := by
    by_contra hx
    have := h0.2.2 hx
    rcases lt_abs.mp hbig with h | h <;> omega
  refine hns x ⟨hx, (l₀ : ZMod 3), (r₀ : ZMod 3), h0.vals.1, h0.vals.2, ?_⟩
  have e1 : ((l₁ : ℤ) : ZMod 3) = (r₀ : ZMod 3) := (ZMod.intCast_eq_intCast_iff' _ _ 3).mpr (by
    simp only [Nat.cast_ofNat]; rcases lt_abs.mp hbig with h | h <;> omega)
  have e2 : ((r₁ : ℤ) : ZMod 3) = (l₀ : ZMod 3) := (ZMod.intCast_eq_intCast_iff' _ _ 3).mpr (by
    simp only [Nat.cast_ofNat]; rcases lt_abs.mp hbig with h | h <;> omega)
  left
  exact ⟨e1 ▸ h1.vals.1, e2 ▸ h1.vals.2⟩

/-- If every `D₀` on `T0` has one residue `ρ` mod 3, the jumps at `x` and `x + 60°` agree. -/
theorem J_eq_of_rho {ρ : ℤ} (hρ : ∀ z ∈ T0 C, L.D 0 z % 3 = ρ) : ∀ x : ℝ, ∀ l₀ r₀ l₁ r₁ : ℤ,
    L.Sides x l₀ r₀ → L.Sides (x + π / 3) l₁ r₁ → |r₀ - l₀| ≤ 1 → |r₁ - l₁| ≤ 1 → r₁ - l₁ = r₀ - l₀ := by
  intro x l₀ r₀ l₁ r₁ h0 h1 b0 b1
  obtain ⟨zl, hzl, hzl'⟩ := exists_T0_left L h0 h1
  obtain ⟨zr, hzr, hzr'⟩ := exists_T0_right L h0 h1
  have m1 := hρ zl hzl
  have m2 := hρ zr hzr
  rw [hzl'] at m1
  rw [hzr'] at m2
  rw [abs_le] at b0 b1
  omega

/-- All `D₀` on `T0` have the residue forced by a nonzero common `h`. -/
theorem rho_const {H : ℤ} (hh : ∀ θ, C.Good θ → C.h θ = H) (hH : H ≠ 0) :
    ∀ z ∈ T0 C, L.D 0 z % 3 = (if H = 2 then 1 else 2) := by
  intro z hz
  have hloc : ∀ᶠ y in 𝓝 z, L.D 0 y = L.D 0 z := by
    have a := L.locallyConstant z hz.1
    have b := ((continuous_add_const (π / 3)).tendsto z).eventually (L.locallyConstant _ hz.2)
    filter_upwards [a, b] with y h1 h2
    rw [D0_eq, D0_eq, h1, h2]
  obtain ⟨ε, hε, hε'⟩ := Metric.eventually_nhds_iff.mp hloc
  obtain ⟨θ, hθ, hg⟩ := C.exists_good_near z ε hε
  have hD : L.D 0 θ = L.D 0 z := hε' (by rwa [Real.dist_eq])
  obtain ⟨n, hn, h3, h6, hS, -⟩ := Lift.hex_summary (L := L) hg
  have hhθ := hh θ hg
  unfold CircleColouring.h at hhθ
  rw [hS] at hhθ
  have hm0 := Lift.D_mod_ne_good (L := L) hg (j := 0) (by norm_num)
  have hcard : (∑ j ∈ Finset.range 6, if L.D j θ % 3 = 2 then 1 else 0) = n := by
    rw [← hn]; unfold Lift.n₂; rw [Finset.card_filter]
  simp only [Finset.sum_range_succ, Finset.sum_range_zero] at hcard
  rw [← hD]
  have hn' : n = 0 ∨ n = 6 := by
    have : (n : ℤ) = 0 ∨ (n : ℤ) = 3 ∨ (n : ℤ) = 6 := by omega
    rcases this with h | h | h
    · left; omega
    · exfalso; omega
    · right; omega
  rcases hn' with rfl | rfl
  · split_ifs at hcard; omega
  · split_ifs at hcard <;> omega

/-- A genuine change point has a nonzero jump. -/
theorem jump_ne_of_mem (hgen : ∀ x ∈ C.S, ¬ ∃ v, C.LeftVal x v ∧ C.RightVal x v) {x : ℝ} (hx : x ∈ C.S)
    {l r : ℤ} (h : L.Sides x l r) : r - l ≠ 0 := by
  intro h0
  have hr : r = l := by omega
  subst hr
  exact hgen x hx ⟨(r : ZMod 3), h.vals.1, h.vals.2⟩

/-- A nonzero jump sits at a point of the change set. -/
theorem mem_of_jump_ne {x : ℝ} {l r : ℤ} (h : L.Sides x l r) (hne : r - l ≠ 0) : x ∈ C.S := by
  by_contra hx
  have := h.2.2 hx
  omega

/-- Equal jumps at `x` and `x + 60°` and genuine change points: `S` is `60°`-invariant. -/
theorem inv_of_J_eq (hgen : ∀ x ∈ C.S, ¬ ∃ v, C.LeftVal x v ∧ C.RightVal x v)
    (hJ : ∀ x : ℝ, ∀ l₀ r₀ l₁ r₁ : ℤ, L.Sides x l₀ r₀ → L.Sides (x + π / 3) l₁ r₁ → |r₀ - l₀| ≤ 1 →
      |r₁ - l₁| ≤ 1 → r₁ - l₁ = r₀ - l₀) : ∀ x, x ∈ C.S ↔ x + π / 3 ∈ C.S := by
  intro x
  obtain ⟨l₀, r₀, h0, b0⟩ := L.exists_sides x
  obtain ⟨l₁, r₁, h1, b1⟩ := L.exists_sides (x + π / 3)
  have := hJ x l₀ r₀ l₁ r₁ h0 h1 b0 b1
  constructor
  · intro hx
    exact mem_of_jump_ne L h1 (by have := jump_ne_of_mem L hgen hx h0; omega)
  · intro hx
    exact mem_of_jump_ne L h0 (by have := jump_ne_of_mem L hgen hx h1; omega)

/-- The hexagon sum is unchanged by rotating the hexagon by `60°` (periodicity of `c`). -/
theorem hSum_shift (θ : ℝ) : C.hSum (θ + π / 3) = C.hSum θ := by
  unfold CircleColouring.hSum
  set u : ℕ → ℤ := fun j => step (C.c (θ + (j : ℝ) * (π / 3))) (C.c (θ + ((j : ℝ) + 1) * (π / 3))) with hu
  have h1 : ∀ j : ℕ, step (C.c (θ + π / 3 + (j : ℝ) * (π / 3))) (C.c (θ + π / 3 + ((j : ℝ) + 1) * (π / 3))) =
      u (j + 1) := by
    intro j
    simp only [hu]
    rw [show θ + π / 3 + (j : ℝ) * (π / 3) = θ + ((j + 1 : ℕ) : ℝ) * (π / 3) by push_cast; ring,
      show θ + π / 3 + ((j : ℝ) + 1) * (π / 3) = θ + (((j + 1 : ℕ) : ℝ) + 1) * (π / 3) by push_cast; ring]
  have h6 : u 6 = u 0 := by
    simp only [hu]
    have a : C.c (θ + ((6 : ℕ) : ℝ) * (π / 3)) = C.c (θ + ((0 : ℕ) : ℝ) * (π / 3)) := by
      rw [show θ + ((6 : ℕ) : ℝ) * (π / 3) = θ + ((0 : ℕ) : ℝ) * (π / 3) + 2 * π by push_cast; ring]
      exact C.periodic _
    have b : C.c (θ + (((6 : ℕ) : ℝ) + 1) * (π / 3)) = C.c (θ + (((0 : ℕ) : ℝ) + 1) * (π / 3)) := by
      rw [show θ + (((6 : ℕ) : ℝ) + 1) * (π / 3) = θ + (((0 : ℕ) : ℝ) + 1) * (π / 3) + 2 * π by push_cast; ring]
      exact C.periodic _
    rw [a, b]
  simp_rw [h1]
  have e1 := Finset.sum_range_succ u 6
  have e2 := Finset.sum_range_succ' u 6
  linarith

include L in
/-- (iii) of the row. -/
theorem ringband_iii' {θ₀ : ℝ} (h0 : ¬ C.PairPos θ₀) :
    ∃ ε > 0, ∀ θ θ', |θ - θ₀| < ε → |θ' - θ₀| < ε → C.Good θ → C.Good θ' → C.h θ = C.h θ' := by
  obtain ⟨ε, hε, h⟩ := m_eq_near L h0
  exact ⟨ε, hε, fun θ θ' a b ga gb => h_eq_of_m_eq L ga gb (h θ θ' a b ga gb)⟩

/-- **FS129-SR1-RINGBAND** (iii): `h` changes across `θ₀` only if `S` holds two points `θ₀ + 60°j` and `θ₀ + 60°(j + 1)`. -/
theorem ringband_iii {θ₀ : ℝ} (h0 : ¬ C.PairPos θ₀) :
    ∃ ε > 0, ∀ θ θ', |θ - θ₀| < ε → |θ' - θ₀| < ε → C.Good θ → C.Good θ' → C.h θ = C.h θ' := by
  obtain ⟨L⟩ := exists_lift C
  exact ringband_iii' L h0

/-- **FS129-SR1-RINGBAND** (iv): with no swap point, all `m_j(θ)` equal one integer `M`, `W` is `6M + 2`, `6M + 3` or `6M + 4`,
and `W = 6M + 3` unless `S` is invariant under the rotation by `60°`. -/
theorem ringband_iv (hns : ∀ x, ¬ C.IsSwap x) :
    ∃ M : ℤ, (∀ θ, C.Good θ → ∀ j < 6, L.m j θ = M) ∧
      ∀ θ, C.Good θ → (L.W θ = 6 * M + 2 ∨ L.W θ = 6 * M + 3 ∨ L.W θ = 6 * M + 4) ∧
        ((∀ x ∈ C.S, ¬ ∃ v, C.LeftVal x v ∧ C.RightVal x v) →
          (¬ ∀ x, x ∈ C.S ↔ x + π / 3 ∈ C.S) → L.W θ = 6 * M + 3) := by
  obtain ⟨M, hM⟩ := exists_M L (m0_const L (hbig_of_noSwap L hns))
  have hW : ∀ θ, C.Good θ → L.W θ = 6 * M + 3 - C.h θ / 2 := by
    intro θ hθ
    rw [(ringband_ii L hθ).2, Finset.sum_congr rfl (fun j hj => hM θ hθ j (Finset.mem_range.mp hj))]
    simp
  refine ⟨M, hM, fun θ hθ => ⟨?_, fun hgen hninv => ?_⟩⟩
  · have := (ringband_i L hθ).2.2
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at this
    rw [hW θ hθ]; omega
  · by_contra hW'
    have hne : C.h θ ≠ 0 := fun h0 => hW' (by rw [hW θ hθ, h0]; simp)
    have hall : ∀ θ', C.Good θ' → C.h θ' = C.h θ := fun θ' hθ' =>
      h_eq_of_m_eq L hθ' hθ (fun j hj => by rw [hM θ' hθ' j hj, hM θ hθ j hj])
    have hρ := rho_const L hall hne
    exact hninv (inv_of_J_eq L hgen (J_eq_of_rho L hρ))

/-- **FS129-SR1-RINGBAND** (v): with no two points of `S` `60°` apart, `h = 0` at every good `θ` and `W = 6M + 3` (`M` the
common value of the `m_j`). -/
theorem ringband_v (hno : ∀ x ∈ C.S, x + π / 3 ∉ C.S) :
    ∃ M : ℤ, (∀ θ, C.Good θ → ∀ j < 6, L.m j θ = M) ∧ ∀ θ, C.Good θ → C.h θ = 0 ∧ L.W θ = 6 * M + 3 := by
  obtain ⟨M, hM⟩ := exists_M L (m0_const L (hbig_of_noPair L hno))
  refine ⟨M, hM, fun θ hθ => ?_⟩
  have hh0 : C.h θ = 0 := by
    by_contra hne
    have hall : ∀ θ', C.Good θ' → C.h θ' = C.h θ := fun θ' hθ' =>
      h_eq_of_m_eq L hθ' hθ (fun j hj => by rw [hM θ' hθ' j hj, hM θ hθ j hj])
    have hJ := J_eq_of_rho L (rho_const L hall hne)
    -- every jump vanishes
    have hz : ∀ x : ℝ, ∀ l r : ℤ, L.Sides x l r → |r - l| ≤ 1 → r = l := by
      intro x l r h b
      by_cases hx : x ∈ C.S
      · obtain ⟨l₁, r₁, h1, b1⟩ := L.exists_sides (x + π / 3)
        have := hJ x l r l₁ r₁ h h1 b b1
        have := (h1.2.2 (hno x hx))
        omega
      · have := h.2.2 hx; omega
    -- so the lift is constant off the change set
    have hT : ∀ y ∈ (univ : Set ℝ), ∀ ε > 0, ∃ z ∈ {z : ℝ | z ∉ C.S}, |z - y| < ε := fun y _ ε hε => by
      obtain ⟨z, hz, hg⟩ := C.exists_good_near y ε hε
      exact ⟨z, hg.notMem, hz⟩
    have hg : ∀ y ∈ (univ : Set ℝ), ∃ ε > 0, ∀ z ∈ {z : ℝ | z ∉ C.S}, |z - y| < ε → ∀ z' ∈ {z : ℝ | z ∉ C.S},
        |z' - y| < ε → L.f z = L.f z' := by
      intro y _
      obtain ⟨l, r, h, b⟩ := L.exists_sides y
      have hr := hz y l r h b
      have hP : ∀ᶠ z in 𝓝 y, (z < y → L.f z = l) ∧ (y < z → L.f z = r) := by
        have a := eventually_nhdsWithin_iff.mp h.1
        have b := eventually_nhdsWithin_iff.mp h.2.1
        filter_upwards [a, b] with z hz1 hz2
        exact ⟨fun hlt => hz1 hlt, fun hgt => hz2 hgt⟩
      obtain ⟨ε, hε, hεP⟩ := Metric.eventually_nhds_iff.mp hP
      have hval : ∀ z ∈ {z : ℝ | z ∉ C.S}, |z - y| < ε → L.f z = l := by
        intro z hzS hzy
        have hzy' : dist z y < ε := by rwa [Real.dist_eq]
        obtain ⟨hlt, hgt⟩ := hεP hzy'
        rcases lt_trichotomy z y with a | a | a
        · exact hlt a
        · subst a; exact (h.2.2 hzS).1.symm
        · rw [hgt a, hr]
      exact ⟨ε, hε, fun z hzS hzy z' hz' hzy' => by rw [hval z hzS hzy, hval z' hz' hzy']⟩
    obtain ⟨θ₁, -, hg₁⟩ := C.exists_good_near 0 1 one_pos
    have h1 : θ₁ + π / 3 ∉ C.S := by simpa using hg₁.hex_notMem (i := 1) (by norm_num)
    have := const_of_local isPreconnected_univ hT hg θ₁ ⟨hg₁.notMem, mem_univ _⟩ (θ₁ + π / 3) ⟨h1, mem_univ _⟩
    exact Lift.D0_mod_ne (L := L) hg₁.notMem h1 (by rw [D0_eq, this]; simp)
  refine ⟨hh0, ?_⟩
  rw [(ringband_ii L hθ).2, Finset.sum_congr rfl (fun j hj => hM θ hθ j (Finset.mem_range.mp hj)), hh0]
  simp

/-- **FS129-SR1-RINGBAND** (vi), from FS129-OA1-RINGWIND (caution C137), first clause: `h` has period `60°`. -/
theorem ringband_vi_periodic {θ : ℝ} (_hθ : C.Good θ) : C.h (θ + π / 3) = C.h θ := by
  unfold CircleColouring.h; rw [hSum_shift]

/-- **FS129-SR1-RINGBAND** (vi), second clause: a hexagon position that is the only one in its period with two change points
`60°` apart carries no jump of `h` (the jumps over one period sum to zero). -/
theorem ringband_vi_noJump {θ₀ : ℝ} (honly : ∀ x, C.PairPos x → ∃ m : ℤ, x = θ₀ + m * (π / 3)) :
    ∃ ε > 0, ∀ θ θ', |θ - θ₀| < ε → |θ' - θ₀| < ε → C.Good θ → C.Good θ' → C.h θ = C.h θ' := by
  by_cases hp : C.PairPos θ₀
  swap
  · exact ringband_iii hp
  have hπ := Real.pi_pos
  have hgood_shift : ∀ θ, C.Good θ → C.Good (θ + π / 3) := fun θ hθ j hj => by
    have := hθ.hex_notMem (i := j + 1) (by omega)
    rwa [show θ + ((j + 1 : ℕ) : ℝ) * (π / 3) = θ + π / 3 + (j : ℝ) * (π / 3) by push_cast; ring] at this
  have hnotgood : ¬ C.Good θ₀ := by
    obtain ⟨j, hj, h1, -⟩ := hp
    exact fun hg => hg j hj h1
  -- `h` is constant on the good angles of the open interval `(θ₀, θ₀ + 60°)`
  have hconst : ∀ z ∈ {z : ℝ | C.Good z} ∩ Ioo θ₀ (θ₀ + π / 3), ∀ z' ∈ {z : ℝ | C.Good z} ∩ Ioo θ₀ (θ₀ + π / 3),
      C.h z = C.h z' := by
    refine const_of_local isPreconnected_Ioo (fun y _ ε hε => ?_) (fun y hy => ?_)
    · obtain ⟨z, hz, hg⟩ := C.exists_good_near y ε hε
      exact ⟨z, hg, hz⟩
    · have hnp : ¬ C.PairPos y := by
        intro hpy
        obtain ⟨m, hm⟩ := honly y hpy
        have h1 : (0 : ℝ) < m := by
          have h0 : θ₀ < θ₀ + m * (π / 3) := by rw [← hm]; exact hy.1
          by_contra hc
          push Not at hc
          have : (m : ℝ) * (π / 3) ≤ 0 := mul_nonpos_of_nonpos_of_nonneg hc (by positivity)
          linarith
        have h2 : (m : ℝ) < 1 := by
          have : θ₀ + m * (π / 3) < θ₀ + π / 3 := by rw [← hm]; exact hy.2
          have : (m : ℝ) * (π / 3) < 1 * (π / 3) := by linarith
          exact lt_of_mul_lt_mul_right this (by positivity)
        have h1' : 0 < m := by exact_mod_cast h1
        have h2' : m < 1 := by exact_mod_cast h2
        omega
      obtain ⟨ε, hε, h⟩ := ringband_iii hnp
      exact ⟨ε, hε, fun z hz hzy z' hz' hzy' => h z z' hzy hzy' hz hz'⟩
  refine ⟨π / 6, by positivity, fun θ θ' hθ hθ' hg hg' => ?_⟩
  have key : ∀ θ, |θ - θ₀| < π / 6 → C.Good θ → ∃ z, C.Good z ∧ z ∈ Ioo θ₀ (θ₀ + π / 3) ∧ C.h z = C.h θ := by
    intro θ hθ hg
    rw [abs_lt] at hθ
    rcases lt_trichotomy θ θ₀ with a | a | a
    · exact ⟨θ + π / 3, hgood_shift θ hg, ⟨by linarith, by linarith⟩, ringband_vi_periodic hg⟩
    · exact absurd (a ▸ hg) hnotgood
    · exact ⟨θ, hg, ⟨a, by linarith⟩, rfl⟩
  obtain ⟨z, hzg, hzI, hzh⟩ := key θ hθ hg
  obtain ⟨z', hzg', hzI', hzh'⟩ := key θ' hθ' hg'
  rw [← hzh, ← hzh']
  exact hconst z ⟨hzg, hzI⟩ z' ⟨hzg', hzI'⟩

/-- **FS110-N2-RING**, on the circle: `|W| ≤ 1` forces a swap point. -/
theorem exists_swap_of_abs_W_le_one {θ : ℝ} (hθ : θ ∉ C.S) (hW : |L.W θ| ≤ 1) : ∃ x, C.IsSwap x := by
  by_contra hns
  push Not at hns
  obtain ⟨M, -, hWM⟩ := ringband_iv L hns
  obtain ⟨θ₁, -, hg⟩ := C.exists_good_near 0 1 one_pos
  have := (hWM θ₁ hg).1
  rw [← W_eq L hθ hg.notMem] at this
  rw [abs_le] at hW
  omega

/-- **FS110-Y3-GP**, on the circle: with no two change points `60°` apart, `W ≡ 3 (mod 6)`. -/
theorem W_mod_six (hno : ∀ x ∈ C.S, x + π / 3 ∉ C.S) {θ : ℝ} (hθ : θ ∉ C.S) : L.W θ % 6 = 3 := by
  obtain ⟨M, -, hWM⟩ := ringband_v L hno
  obtain ⟨θ₁, -, hg⟩ := C.exists_good_near 0 1 one_pos
  have := (hWM θ₁ hg).2
  rw [← W_eq L hθ hg.notMem] at this
  omega

/-- **FS110-Y3-GP**, on the circle: `|W| ≤ 2` needs two change points `60°` apart. -/
theorem exists_pair_of_abs_W_le_two {θ : ℝ} (hθ : θ ∉ C.S) (hW : |L.W θ| ≤ 2) : ∃ x ∈ C.S, x + π / 3 ∈ C.S := by
  by_contra hno
  push Not at hno
  have := W_mod_six L hno hθ
  rw [abs_le] at hW
  omega

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
