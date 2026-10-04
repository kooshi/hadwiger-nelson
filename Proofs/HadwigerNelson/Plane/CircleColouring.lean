import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.Order.Floor.Ring

/-!
# Three-colourings of a circle proper at `60°`, their lifts, windings and hexagon heights (RINGBAND's vocabulary)

Wave 3's foundation for **FS129-SR1-RINGBAND** (`plans/FS131-w3-kernel-plan.md` § 2). The row's input is "a colouring
`c` of the circle by `ℤ/3`, defined and locally constant off a finite set `Σ` of change points, with
`c(θ) ≠ c(θ + 60°)` wherever both are defined"; it is the ring of a three-colour vertex coloured by its three absent
colours (FS110-N2-RING's setting), but nothing here mentions a map.

The circle is `ℝ` with period `2π`, as everywhere in this library (angles are reals: `Plane/Basic`): `c : ℝ → ZMod 3` is
`2π`-periodic, `S ⊆ ℝ` is the `2π`-periodic change set with finitely many points in `[0, 2π)`. A **lift** is an integer
function agreeing with `c` mod 3 off `S`, locally constant off `S`, changing by at most one across each point (the row's
"changing by `+1` or `−1` at each change point": the change is `≡ ±1` where `c` changes and `≡ 0` where it does not, so
"at most one" says exactly that). For `θ` whose hexagon `θ + 60°j` avoids `S` (`Good θ`):

* `L.W θ = (f(θ + 2π) − f(θ))/3`, the winding;
* `L.D j θ = f(θ + 60°(j + 1)) − f(θ + 60°j)`, `L.m j θ = ⌊L.D j θ / 3⌋` (`Int` division by `3` is the floor),
  `L.n₂ θ = #{j < 6 : L.D j θ ≡ 2 (mod 3)}`;
* `C.hSum θ = Σ_{j<6} d(c(θ + 60°j), c(θ + 60°(j + 1)))` with `d(x, y) = ±1` as `y = x ± 1`, and `C.h θ = C.hSum θ / 3`
  (the row's `h`, which the row proves lies in `{−2, 0, 2}`).

A **swap point** is a change point `x` with `c(x + 60°−) = c(x+)` and `c(x + 60°+) = c(x−)`, or the same with `−60°`;
one-sided values are read through `LeftVal`, `RightVal`.

**Inhabitants** (the row's two models, `plans/FS129-derivation.md` FS129-SR1-RINGBAND's model line): `hexColouring`, the
six `60°` arcs coloured `0, 1, 2, 0, 1, 2` (winding `2`, `h = 2`), and `nineColouring`, nine `40°` arcs coloured
`0, 1, 2, …` (winding `3`, `h = 0`), each with its lift.
-/

namespace HadwigerNelson.Plane

open Real Set Filter Topology

/-- A colouring of the circle by `ℤ/3`, proper at `60°`: `c` has period `2π` and is locally constant off the
`2π`-periodic set `S`, which has finitely many points in each period, and `c θ ≠ c (θ + π/3)` wherever `θ` and
`θ + π/3` are both off `S`. -/
structure CircleColouring where
  /-- The colour at each angle (read only off `S`). -/
  c : ℝ → ZMod 3
  /-- The change set. -/
  S : Set ℝ
  /-- The colouring has period `2π`. -/
  periodic : Function.Periodic c (2 * π)
  /-- The change set has period `2π`. -/
  periodic_S : ∀ θ, θ + 2 * π ∈ S ↔ θ ∈ S
  /-- Finitely many change points per period. -/
  finite_S : (S ∩ Ico 0 (2 * π)).Finite
  /-- The colour is locally constant off `S`. -/
  locallyConstant : ∀ θ ∉ S, ∀ᶠ θ' in 𝓝 θ, c θ' = c θ
  /-- Proper at `60°`. -/
  proper : ∀ θ, θ ∉ S → θ + π / 3 ∉ S → c θ ≠ c (θ + π / 3)

namespace CircleColouring

variable (C : CircleColouring)

/-- A lift of the colouring to `ℤ`: agreeing with `c` mod 3 off `S`, locally constant off `S`, and changing by at
most one across every point. -/
structure Lift where
  /-- The lifted colour. -/
  f : ℝ → ℤ
  /-- It reduces to `c` mod 3. -/
  cast_eq : ∀ θ ∉ C.S, (f θ : ZMod 3) = C.c θ
  /-- It is locally constant off `S`. -/
  locallyConstant : ∀ θ ∉ C.S, ∀ᶠ θ' in 𝓝 θ, f θ' = f θ
  /-- Its values just left and just right of any point differ by at most one. -/
  jump : ∀ θ, ∀ᶠ a in 𝓝[<] θ, ∀ᶠ b in 𝓝[>] θ, |f b - f a| ≤ 1

/-- The hexagon `θ + 60°j`, `j < 6`, avoids the change set. -/
def Good (θ : ℝ) : Prop := ∀ j : ℕ, j < 6 → θ + j * (π / 3) ∉ C.S

/-- `d(x, y)`: `+1` if `y = x + 1`, `−1` if `y = x − 1`, `0` if `y = x`. -/
def step (x y : ZMod 3) : ℤ := if y = x + 1 then 1 else if y = x - 1 then -1 else 0

/-- `3h(θ) = Σ_{j<6} d(c(θ + 60°j), c(θ + 60°(j + 1)))`. -/
noncomputable def hSum (θ : ℝ) : ℤ :=
  ∑ j ∈ Finset.range 6, step (C.c (θ + j * (π / 3))) (C.c (θ + (j + 1) * (π / 3)))

/-- The hexagon height `h(θ)` (FS129-OA1-RINGWIND's `W`). -/
noncomputable def h (θ : ℝ) : ℤ := C.hSum θ / 3

/-- `c` takes the value `v` just left of `x`. -/
def LeftVal (x : ℝ) (v : ZMod 3) : Prop := ∀ᶠ θ in 𝓝[<] x, C.c θ = v

/-- `c` takes the value `v` just right of `x`. -/
def RightVal (x : ℝ) (v : ZMod 3) : Prop := ∀ᶠ θ in 𝓝[>] x, C.c θ = v

/-- A **swap point**: a change point `x` with `c(x + 60°−) = c(x+)` and `c(x + 60°+) = c(x−)`, or the same with
`−60°`. -/
def IsSwap (x : ℝ) : Prop :=
  x ∈ C.S ∧ ∃ a b, C.LeftVal x a ∧ C.RightVal x b ∧
    ((C.LeftVal (x + π / 3) b ∧ C.RightVal (x + π / 3) a) ∨
      (C.LeftVal (x - π / 3) b ∧ C.RightVal (x - π / 3) a))

namespace Lift

variable {C} (L : C.Lift)

/-- The winding `W = (f(θ + 2π) − f(θ))/3`. -/
noncomputable def W (θ : ℝ) : ℤ := (L.f (θ + 2 * π) - L.f θ) / 3

/-- `D_j(θ) = f(θ + 60°(j + 1)) − f(θ + 60°j)`. -/
noncomputable def D (j : ℕ) (θ : ℝ) : ℤ := L.f (θ + (j + 1) * (π / 3)) - L.f (θ + j * (π / 3))

/-- `m_j(θ) = ⌊D_j(θ)/3⌋`. -/
noncomputable def m (j : ℕ) (θ : ℝ) : ℤ := L.D j θ / 3

/-- `n₂(θ) = #{j < 6 : D_j(θ) ≡ 2 (mod 3)}`. -/
noncomputable def n₂ (θ : ℝ) : ℕ := ((Finset.range 6).filter fun j => L.D j θ % 3 = 2).card

end Lift

end CircleColouring

/-! ## The models: `n` equal arcs coloured `0, 1, 2, 0, 1, 2, …` for `n ∈ {6, 9}` -/

/-- The cell index `⌊θ/(2π/n)⌋` of an angle among `n` equal arcs. -/
noncomputable def cellIndex (n : ℕ) (θ : ℝ) : ℤ := ⌊θ / (2 * π / n)⌋

/-- Off the cell boundaries the cell index is locally constant. -/
theorem cellIndex_eventually_eq {n : ℕ} (hn : 0 < n) {θ : ℝ}
    (hθ : θ ∉ {θ | ∃ z : ℤ, θ = z * (2 * π / n)}) : ∀ᶠ θ' in 𝓝 θ, cellIndex n θ' = cellIndex n θ := by
  have hw : 0 < 2 * π / n := div_pos (by positivity) (by exact_mod_cast hn)
  set z := cellIndex n θ with hz
  have hlo : (z : ℝ) < θ / (2 * π / n) := by
    refine lt_of_le_of_ne (Int.floor_le _) fun h => hθ ⟨z, ?_⟩
    rw [h]; field_simp
  have hhi : θ / (2 * π / n) < z + 1 := Int.lt_floor_add_one _
  have hopen : IsOpen {θ' : ℝ | (z : ℝ) < θ' / (2 * π / n) ∧ θ' / (2 * π / n) < z + 1} :=
    (isOpen_lt (continuous_const (y := (z : ℝ))) (continuous_id.div_const (2 * π / n))).inter
      (isOpen_lt (continuous_id.div_const (2 * π / n)) (continuous_const (y := (z : ℝ) + 1)))
  filter_upwards [hopen.mem_nhds ⟨hlo, hhi⟩] with θ' h'
  rw [cellIndex, hz, cellIndex, Int.floor_eq_iff]
  exact ⟨h'.1.le, h'.2⟩

/-- Across any point the cell index changes by at most one. -/
theorem cellIndex_jump {n : ℕ} (hn : 0 < n) (θ : ℝ) :
    ∀ᶠ a in 𝓝[<] θ, ∀ᶠ b in 𝓝[>] θ, |cellIndex n b - cellIndex n a| ≤ 1 := by
  have hw : 0 < 2 * π / n := div_pos (by positivity) (by exact_mod_cast hn)
  have ha : ∀ᶠ a in 𝓝[<] θ, θ - π / n < a := by
    apply eventually_nhdsWithin_of_eventually_nhds
    exact (isOpen_lt continuous_const continuous_id).mem_nhds (by
      have : 0 < π / n := div_pos pi_pos (by exact_mod_cast hn)
      show θ - π / n < θ
      linarith)
  filter_upwards [ha, self_mem_nhdsWithin] with a ha1 ha2
  have hb : ∀ᶠ b in 𝓝[>] θ, b < θ + π / n := by
    apply eventually_nhdsWithin_of_eventually_nhds
    exact (isOpen_lt continuous_id continuous_const).mem_nhds (by
      have : 0 < π / n := div_pos pi_pos (by exact_mod_cast hn)
      show θ < θ + π / n
      linarith)
  filter_upwards [hb, self_mem_nhdsWithin] with b hb1 hb2
  have hab : a ≤ b := le_of_lt (lt_trans (ha2 : a < θ) (hb2 : θ < b))
  have hlt : b / (2 * π / n) - a / (2 * π / n) < 1 := by
    rw [← sub_div, div_lt_one hw]
    have : b - a < 2 * (π / n) := by linarith
    calc b - a < 2 * (π / n) := this
      _ = 2 * π / n := by ring
  have hmono : cellIndex n a ≤ cellIndex n b :=
    Int.floor_le_floor (div_le_div_of_nonneg_right hab hw.le)
  have hup : cellIndex n b - cellIndex n a < 2 := by
    have h1 := Int.floor_le (b / (2 * π / n))
    have h2 := Int.lt_floor_add_one (a / (2 * π / n))
    have : ((cellIndex n b - cellIndex n a : ℤ) : ℝ) < 2 := by
      push_cast [cellIndex]; linarith
    exact_mod_cast this
  rw [abs_le]; constructor <;> omega

/-- `n` equal arcs coloured `0, 1, 2, …` cyclically, for `n ∈ {6, 9}`: a colouring of the circle proper at `60°`. -/
noncomputable def arcsColouring (n : ℕ) (hn : n = 6 ∨ n = 9) : CircleColouring where
  c θ := (cellIndex n θ : ZMod 3)
  S := {θ | ∃ z : ℤ, θ = z * (2 * π / n)}
  periodic := by
    intro θ
    have hn0 : (n : ℝ) ≠ 0 := by rcases hn with rfl | rfl <;> norm_num
    have : (θ + 2 * π) / (2 * π / n) = θ / (2 * π / n) + (n : ℤ) := by
      push_cast; field_simp
    simp only [cellIndex, this, Int.floor_add_intCast, Int.cast_add]
    have h3 : ((n : ℤ) : ZMod 3) = 0 := by rcases hn with rfl | rfl <;> decide
    rw [h3, add_zero]
  periodic_S := by
    intro θ
    have hn0 : (n : ℝ) ≠ 0 := by rcases hn with rfl | rfl <;> norm_num
    constructor
    · rintro ⟨z, hz⟩
      refine ⟨z - n, ?_⟩
      push_cast
      have : θ = z * (2 * π / n) - 2 * π := by linarith
      rw [this]; field_simp
    · rintro ⟨z, rfl⟩
      refine ⟨z + n, ?_⟩
      push_cast; field_simp
  finite_S := by
    have hn0 : (0 : ℝ) < n := by rcases hn with rfl | rfl <;> norm_num
    refine ((Finset.range n).finite_toSet.image fun i : ℕ => (i : ℝ) * (2 * π / n)).subset ?_
    rintro θ ⟨⟨z, rfl⟩, h0, h1⟩
    have hw : 0 < 2 * π / n := div_pos (by positivity) hn0
    have hz0 : (0 : ℝ) ≤ z := by
      by_contra hneg; push Not at hneg; nlinarith
    have hz1 : (z : ℝ) < n := by
      by_contra hge; push Not at hge
      have : (n : ℝ) * (2 * π / n) ≤ z * (2 * π / n) := mul_le_mul_of_nonneg_right hge hw.le
      rw [mul_div_cancel₀ _ hn0.ne'] at this
      linarith
    have hz0' : 0 ≤ z := by exact_mod_cast hz0
    refine ⟨z.toNat, ?_, ?_⟩
    · simp only [Finset.coe_range, mem_Iio]
      have : (z.toNat : ℝ) = z := by exact_mod_cast Int.toNat_of_nonneg hz0'
      exact_mod_cast (show (z.toNat : ℝ) < n by rw [this]; exact hz1)
    · simp only
      rw [show ((z.toNat : ℕ) : ℝ) = (z : ℝ) by exact_mod_cast Int.toNat_of_nonneg hz0']
  locallyConstant := by
    intro θ hθ
    have hn' : 0 < n := by rcases hn with rfl | rfl <;> norm_num
    filter_upwards [cellIndex_eventually_eq hn' hθ] with θ' h
    rw [h]
  proper := by
    intro θ _ _
    have hn0 : (0 : ℝ) < n := by rcases hn with rfl | rfl <;> norm_num
    have hs : (θ + π / 3) / (2 * π / n) = θ / (2 * π / n) + n / 6 := by
      field_simp; ring
    have key : ∀ x : ℝ, ⌊x + (n : ℝ) / 6⌋ - ⌊x⌋ = 1 ∨ ⌊x + (n : ℝ) / 6⌋ - ⌊x⌋ = 2 := by
      intro x
      rcases hn with rfl | rfl
      · left
        rw [show x + ((6 : ℕ) : ℝ) / 6 = x + ((1 : ℤ) : ℝ) by norm_num, Int.floor_add_intCast]
        ring
      · have h1 := Int.floor_le x
        have h2 := Int.lt_floor_add_one x
        have h3 := Int.floor_le (x + ((9 : ℕ) : ℝ) / 6)
        have hlo : ⌊x⌋ + 1 ≤ ⌊x + ((9 : ℕ) : ℝ) / 6⌋ := by
          rw [Int.le_floor]; push_cast; linarith
        have hhi : ⌊x + ((9 : ℕ) : ℝ) / 6⌋ < ⌊x⌋ + 3 := by
          have : (⌊x + ((9 : ℕ) : ℝ) / 6⌋ : ℝ) < ⌊x⌋ + 3 := by push_cast at h3 ⊢; linarith
          exact_mod_cast this
        omega
    have hd := key (θ / (2 * π / n))
    rw [← hs] at hd
    intro heq
    have hcast : ((cellIndex n (θ + π / 3) - cellIndex n θ : ℤ) : ZMod 3) = 0 := by
      push_cast; rw [heq, sub_self]
    simp only [cellIndex] at hcast
    rcases hd with h | h <;> rw [h] at hcast <;> revert hcast <;> decide

/-- The lift of `arcsColouring`: the cell index itself. -/
noncomputable def arcsLift (n : ℕ) (hn : n = 6 ∨ n = 9) : (arcsColouring n hn).Lift where
  f := cellIndex n
  cast_eq := fun _ _ => rfl
  locallyConstant := fun θ hθ => cellIndex_eventually_eq (by rcases hn with rfl | rfl <;> norm_num) hθ
  jump := cellIndex_jump (by rcases hn with rfl | rfl <;> norm_num)

/-- **Model 1** of FS129-SR1-RINGBAND: six `60°` arcs coloured `0, 1, 2, 0, 1, 2`. -/
noncomputable def hexColouring : CircleColouring := arcsColouring 6 (Or.inl rfl)

/-- **Model 2** of FS129-SR1-RINGBAND: nine `40°` arcs coloured `0, 1, 2, 0, 1, 2, 0, 1, 2`. -/
noncomputable def nineColouring : CircleColouring := arcsColouring 9 (Or.inr rfl)

/-! ## Spec examples (each fails if a definition drifts) -/

/-- The cell index of `π/6 + jπ/3` among six arcs is `j`. -/
theorem cellIndex_six (j : ℕ) : cellIndex 6 (π / 6 + j * (π / 3)) = j := by
  rw [cellIndex, Int.floor_eq_iff]
  have hπ := pi_pos
  constructor
  · rw [le_div_iff₀ (by positivity)]; push_cast; nlinarith
  · rw [div_lt_iff₀ (by positivity)]; push_cast; nlinarith

/-- Model 1 winds twice: `W = (f(θ + 2π) − f(θ))/3 = 2`. -/
example : (arcsLift 6 (Or.inl rfl)).W (π / 6) = 2 := by
  simp only [CircleColouring.Lift.W, arcsLift]
  have h0 := cellIndex_six 0
  have h6 := cellIndex_six 6
  norm_num at h0 h6
  rw [show π / 6 + 2 * π = π / 6 + 6 * (π / 3) by ring, h6, h0]
  decide

/-- Model 1 has hexagon height `h = 2` (every step of the hexagon is `+1`). -/
example : hexColouring.h (π / 6) = 2 := by
  have hc : ∀ j : ℕ, hexColouring.c (π / 6 + j * (π / 3)) = (j : ZMod 3) := by
    intro j
    show ((cellIndex 6 (π / 6 + j * (π / 3)) : ℤ) : ZMod 3) = _
    rw [cellIndex_six]; push_cast; rfl
  have hc' : ∀ j : ℕ, hexColouring.c (π / 6 + (j + 1) * (π / 3)) = ((j + 1 : ℕ) : ZMod 3) := by
    intro j; rw [← hc]; push_cast; rfl
  simp only [CircleColouring.h, CircleColouring.hSum, hc, hc']
  decide

/-- Model 1's hexagon at `π/6` avoids its change points. -/
example : hexColouring.Good (π / 6) := by
  intro j _ ⟨z, hz⟩
  have hπ := pi_pos
  have : (1 : ℝ) / 2 + j = z := by
    have := congrArg (· / (π / 3)) hz
    field_simp at this ⊢
    push_cast at this ⊢
    linarith
  have hfl := congrArg Int.fract this
  rw [Int.fract_intCast, add_comm, Int.fract_natCast_add] at hfl
  norm_num [Int.fract_eq_self.mpr] at hfl

/-- The cell index of `π/45 + jπ/3` among nine arcs is `⌊1/10 + 3j/2⌋`. -/
theorem cellIndex_nine (j : ℕ) : cellIndex 9 (π / 45 + j * (π / 3)) = ⌊(1 : ℝ) / 10 + 3 * j / 2⌋ := by
  rw [cellIndex]
  congr 1
  field_simp
  ring

/-- Model 2 winds three times: `W = 3`. -/
example : (arcsLift 9 (Or.inr rfl)).W (π / 45) = 3 := by
  simp only [CircleColouring.Lift.W, arcsLift]
  have h0 := cellIndex_nine 0
  have h6 := cellIndex_nine 6
  norm_num at h0 h6
  rw [show π / 45 + 2 * π = π / 45 + 6 * (π / 3) by ring, h6, h0]
  norm_num [Int.floor_eq_iff]

/-- Model 2 has hexagon height `h = 0` (its hexagon reads `0, 1, 0, 1, 0, 1`: steps `+1, −1, …`). -/
example : nineColouring.h (π / 45) = 0 := by
  have hc : ∀ j : ℕ, nineColouring.c (π / 45 + j * (π / 3)) = ((⌊(1 : ℝ) / 10 + 3 * j / 2⌋ : ℤ) : ZMod 3) :=
    fun j => by
      show ((cellIndex 9 _ : ℤ) : ZMod 3) = _
      rw [cellIndex_nine]
  have hc' : ∀ j : ℕ, nineColouring.c (π / 45 + (j + 1) * (π / 3)) =
      ((⌊(1 : ℝ) / 10 + 3 * ((j + 1 : ℕ) : ℝ) / 2⌋ : ℤ) : ZMod 3) := fun j => by
    rw [← hc]; push_cast; rfl
  simp only [CircleColouring.h, CircleColouring.hSum, hc, hc', Finset.sum_range_succ, Finset.sum_range_zero]
  norm_num
  decide

end HadwigerNelson.Plane
