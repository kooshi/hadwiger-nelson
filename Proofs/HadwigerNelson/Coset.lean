import Mathlib.Analysis.Complex.Basic
import Mathlib.Tactic.IntervalCases

/-!
# The coset bound: every lattice colouring of the plane needs seven colours (M37)

Colour each point of the plane by which class its **nearest lattice point** falls into. That
is what the classical hexagonal seven-colouring is, and what every "Voronoi + coset" scheme
in the literature is. **No such colouring uses six colours or fewer** — at any scale, for
any sublattice, under any tie-breaking. That is this module.

The lattice is the triangular one, `Λ_p = {p·(a + b·ζ₆)}`, and the whole proof runs on its
integral norm form `hexQ (a,b) = a² + ab + b²`: distances are `p²·hexQ` of address
differences, so every quantity below is polynomial and no square root appears outside the
embedding's own definition.

The four geometric steps, each producing a same-coloured pair at distance exactly 1:

* the **inscribed disc** — a point within `p/2` of a lattice point rounds to it, whatever
  the tie-breaking (`nearestUnique_of_lt_quarter`);
* the **deep hole** `h = p(1+ζ₆)/3`, whose ray rounds to the origin out to `‖h‖ = p/√3`,
  giving a same-coloured pair of diameter `2p/√3` and hence `p ≤ √3/2`
  (`scale_le`);
* the **collinear sweep** along a kernel vector, which kills every kernel norm below 4;
* the **corner sweep** along a deep hole, which closes the seams the collinear sweep leaves
  at norm exactly 4 (there its windows only *touch*, and the unit distance can hide between
  them at `1/p = 3, 5, 7, …`).

What remains is arithmetic: a kernel vector's norm is a Loeschian number, 2, 5 and 6 are
not Loeschian, so every nonzero kernel vector has norm ≥ 7; and the seven addresses of the
closed first shell differ pairwise by norms in `{1, 3, 4}`, so they take seven distinct
colours. That shell is the same seven-point object as `Instances/HexShell.lean`'s K₇, met
from the other side.

**The homomorphism hypothesis is load-bearing, and the theorem is false without it.** An
arbitrary (non-coset) colouring of the lattice addresses is a colouring of an annulus graph
on the lattice, whose chromatic number at fine scales is the plane's own open question — so
this module bounds *coset* colourings, and the gap between coset and arbitrary is exactly
where a six-colouring would have to live.

**Attribution.** That the hexagonal colouring is optimal among lattice colourings is
folklore-adjacent; no novelty is claimed for the construction it bounds. Ours is the proof
shape, the formalization, and the packaging as a limitation theorem for the upper-bound
hunt. Sharpness — that seven IS attained in this family, by the norm-7 ideal at any scale
`p ∈ (0.671, 0.866]` — is confirmed in `build/m37-design.py` and is not formalized here;
see the module's final section for what that means for reading the theorem.
-/

namespace HadwigerNelson

namespace Coset

/-! ## The address space and its form -/

/-- The hexagonal norm form: `‖p·(x + y·ζ₆)‖² = p²·hexQ (x,y)`. -/
def hexQ (w : ℝ × ℝ) : ℝ := w.1 ^ 2 + w.1 * w.2 + w.2 ^ 2

/-- Twice the polarization of `hexQ` — twice, so that it stays integral on the lattice. -/
def hexIP (u v : ℝ × ℝ) : ℝ := 2 * u.1 * v.1 + u.1 * v.2 + u.2 * v.1 + 2 * u.2 * v.2

@[simp] theorem hexQ_zero : hexQ 0 = 0 := by simp [hexQ]

theorem hexQ_sub (u v : ℝ × ℝ) : hexQ (u - v) = hexQ u - hexIP u v + hexQ v := by
  simp only [hexQ, hexIP, Prod.fst_sub, Prod.snd_sub]; ring

theorem hexQ_add (u v : ℝ × ℝ) : hexQ (u + v) = hexQ u + hexIP u v + hexQ v := by
  simp only [hexQ, hexIP, Prod.fst_add, Prod.snd_add]; ring

theorem hexQ_smul (c : ℝ) (w : ℝ × ℝ) : hexQ (c • w) = c ^ 2 * hexQ w := by
  simp only [hexQ, Prod.smul_fst, Prod.smul_snd, smul_eq_mul]; ring

theorem hexIP_smul_left (c : ℝ) (u v : ℝ × ℝ) : hexIP (c • u) v = c * hexIP u v := by
  simp only [hexIP, Prod.smul_fst, Prod.smul_snd, smul_eq_mul]; ring

/-- The Gram identity: the form's discriminant is `3/4`, so Cauchy–Schwarz is an equation
with a square left over. This is what makes the form positive definite, and it is the only
inequality tool the rounding arguments need. -/
theorem hexIP_sq_add (u v : ℝ × ℝ) :
    hexIP u v ^ 2 + 3 * (u.1 * v.2 - u.2 * v.1) ^ 2 = 4 * hexQ u * hexQ v := by
  simp only [hexQ, hexIP]; ring

theorem hexQ_nonneg (w : ℝ × ℝ) : 0 ≤ hexQ w := by
  simp only [hexQ]
  nlinarith [sq_nonneg (2 * w.1 + w.2), sq_nonneg w.2]

/-- Cauchy–Schwarz for the form, in the squared shape the sweeps use. -/
theorem hexIP_sq_le (u v : ℝ × ℝ) : hexIP u v ^ 2 ≤ 4 * hexQ u * hexQ v := by
  have h := hexIP_sq_add u v
  nlinarith [sq_nonneg (u.1 * v.2 - u.2 * v.1)]

/-! ## Integer addresses -/

/-- A lattice address, as a point of the address space. -/
def addr (v : ℤ × ℤ) : ℝ × ℝ := ((v.1 : ℝ), (v.2 : ℝ))

/-- The integral norm form on addresses. -/
def hexQi (v : ℤ × ℤ) : ℤ := v.1 ^ 2 + v.1 * v.2 + v.2 ^ 2

theorem hexQ_addr (v : ℤ × ℤ) : hexQ (addr v) = (hexQi v : ℝ) := by
  simp only [hexQ, hexQi, addr]; push_cast; ring

@[simp] theorem addr_zero : addr 0 = 0 := by simp [addr]

theorem addr_sub (u v : ℤ × ℤ) : addr (u - v) = addr u - addr v := by
  simp [addr]

theorem addr_zsmul (j : ℤ) (d : ℤ × ℤ) : addr (j • d) = (j : ℝ) • addr d := by
  simp only [addr, Prod.ext_iff, Prod.smul_fst, Prod.smul_snd, smul_eq_mul]
  constructor <;> push_cast <;> ring

theorem hexQi_zsmul (j : ℤ) (d : ℤ × ℤ) : hexQi (j • d) = j ^ 2 * hexQi d := by
  simp only [hexQi, Prod.smul_fst, Prod.smul_snd, smul_eq_mul]; ring

/-- Every nonzero address has norm at least one: the form is positive definite over `ℤ`. -/
theorem one_le_hexQi {v : ℤ × ℤ} (hv : v ≠ 0) : 1 ≤ hexQi v := by
  obtain ⟨a, b⟩ := v
  have h0 : ¬(a = 0 ∧ b = 0) := by rintro ⟨rfl, rfl⟩; exact hv rfl
  simp only [hexQi]
  have h4 : 4 * (a ^ 2 + a * b + b ^ 2) = (2 * a + b) ^ 2 + 3 * b ^ 2 := by ring
  by_cases hb : b = 0
  · subst hb
    have ha : a ≠ 0 := fun h => h0 ⟨h, rfl⟩
    have : 1 ≤ a ^ 2 := by rcases lt_or_gt_of_ne ha with h | h <;> nlinarith
    nlinarith
  · have : 1 ≤ b ^ 2 := by rcases lt_or_gt_of_ne hb with h | h <;> nlinarith
    have := sq_nonneg (2 * a + b)
    omega

/-- **The Loeschian gap.** A nonzero address of norm at most six has norm 1, 3 or 4 —
because 2, 5 and 6 are not of the form `a² + ab + b²`. Hence a nonzero address whose norm
avoids `{1,3,4}` has norm at least seven. -/
theorem hexQi_eq_of_le_six {v : ℤ × ℤ} (hv : v ≠ 0) (h : hexQi v ≤ 6) :
    hexQi v = 1 ∨ hexQi v = 3 ∨ hexQi v = 4 := by
  obtain ⟨a, b⟩ := v
  simp only [hexQi] at h ⊢
  have hb1 : -2 ≤ b := by nlinarith [sq_nonneg (2 * a + b)]
  have hb2 : b ≤ 2 := by nlinarith [sq_nonneg (2 * a + b)]
  have ha1 : -2 ≤ a := by nlinarith [sq_nonneg (a + 2 * b)]
  have ha2 : a ≤ 2 := by nlinarith [sq_nonneg (a + 2 * b)]
  have h0 : ¬(a = 0 ∧ b = 0) := by
    rintro ⟨rfl, rfl⟩; exact hv rfl
  interval_cases a <;> interval_cases b <;> omega


/-! ## The plane, and rounding to the lattice -/

/-- The address space embedded in the plane at scale `p`: `(x, y) ↦ p·(x + y·ζ₆)`. The only
place a square root appears in this module. -/
noncomputable def emb (p : ℝ) (w : ℝ × ℝ) : ℂ :=
  ⟨p * (w.1 + w.2 / 2), p * (w.2 * Real.sqrt 3 / 2)⟩

/-- The lattice point at an integer address. -/
noncomputable def latt (p : ℝ) (v : ℤ × ℤ) : ℂ := emb p (addr v)

/-- **The bridge.** The embedding is a similarity of ratio `p` for the form — the single
link between the address space and the plane's metric. -/
theorem dist_emb_sq (p : ℝ) (u v : ℝ × ℝ) :
    dist (emb p u) (emb p v) ^ 2 = p ^ 2 * hexQ (u - v) := by
  rw [Complex.dist_eq_re_im, Real.sq_sqrt (by positivity)]
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  simp only [emb, hexQ, Prod.fst_sub, Prod.snd_sub]
  nlinarith [h3, sq_nonneg (u.2 - v.2)]

/-- `v` is the *unique* nearest address to `w`. Stated strictly, so that it pins the value
of ANY nearest-point rounding — this is where "ties broken arbitrarily" is discharged. -/
def NearestUnique (w : ℝ × ℝ) (v : ℤ × ℤ) : Prop :=
  ∀ u : ℤ × ℤ, u ≠ v → hexQ (w - addr v) < hexQ (w - addr u)

/-- A unique nearest address is the value of every nearest-point rounding. -/
theorem rnd_eq {p : ℝ} (hp : 0 < p) {rnd : ℂ → ℤ × ℤ}
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    {w : ℝ × ℝ} {v : ℤ × ℤ} (h : NearestUnique w v) : rnd (emb p w) = v := by
  by_contra hne
  have h1 := hrnd (emb p w) v
  have h2 : dist (emb p w) (latt p (rnd (emb p w))) ^ 2 ≤ dist (emb p w) (latt p v) ^ 2 := by
    have := dist_nonneg (x := emb p w) (y := latt p (rnd (emb p w)))
    nlinarith [dist_nonneg (x := emb p w) (y := latt p v)]
  rw [latt, latt, dist_emb_sq, dist_emb_sq] at h2
  have := h _ hne
  have hp2 : 0 < p ^ 2 := by positivity
  nlinarith

/-- Uniqueness is translation-equivariant, so no equivariance hypothesis is needed of the
rounding itself. -/
theorem nearestUnique_add (z : ℤ × ℤ) {w : ℝ × ℝ} {u : ℤ × ℤ} (h : NearestUnique w u) :
    NearestUnique (addr z + w) (z + u) := by
  intro t ht
  have h1 : addr z + w - addr (z + u) = w - addr u := by
    simp only [addr, Prod.ext_iff, Prod.fst_add, Prod.snd_add, Prod.fst_sub, Prod.snd_sub,
      ]
    push_cast
    constructor <;> ring
  have h2 : addr z + w - addr t = w - addr (t - z) := by
    simp only [addr, Prod.ext_iff, Prod.fst_add, Prod.snd_add, Prod.fst_sub, Prod.snd_sub,
      ]
    push_cast
    constructor <;> ring
  rw [h1, h2]
  exact h _ (fun hc => ht (by rw [← hc]; abel))

/-- **The inscribed disc.** A point strictly inside the ball of radius `p/2` about a lattice
point rounds to it — one Cauchy–Schwarz, and the only fact three of the four sweeps need. -/
theorem nearestUnique_zero {w : ℝ × ℝ} (h : 4 * hexQ w < 1) : NearestUnique w 0 := by
  intro u hu
  rw [addr_zero, sub_zero]
  have hQu : (1 : ℝ) ≤ hexQ (addr u) := by
    rw [hexQ_addr]; exact_mod_cast one_le_hexQi hu
  have hcs := hexIP_sq_le w (addr u)
  have hw : 0 ≤ hexQ w := hexQ_nonneg w
  have hlt : hexIP w (addr u) < hexQ (addr u) := by nlinarith
  rw [hexQ_sub]
  linarith

/-! ## The deep holes -/

/-- The six deep holes (the Voronoi vertices) in address coordinates. -/
noncomputable def hole : Fin 6 → ℝ × ℝ
  | 0 => (1/3, 1/3)
  | 1 => (-1/3, 2/3)
  | 2 => (-2/3, 1/3)
  | 3 => (-1/3, -1/3)
  | 4 => (1/3, -2/3)
  | 5 => (2/3, -1/3)

/-- The functional a hole induces on addresses: the six are `±a`, `±b`, `±(a+b)`. -/
def holeF : Fin 6 → ℤ × ℤ → ℤ
  | 0, v => v.1 + v.2
  | 1, v => v.2
  | 2, v => -v.1
  | 3, v => -(v.1 + v.2)
  | 4, v => -v.2
  | 5, v => v.1

theorem hexQ_hole (i : Fin 6) : hexQ (hole i) = 1 / 3 := by
  fin_cases i <;> norm_num [hexQ, hole]

theorem hexIP_hole (i : Fin 6) (v : ℤ × ℤ) :
    hexIP (hole i) (addr v) = (holeF i v : ℝ) := by
  fin_cases i <;> simp only [hexIP, hole, holeF, addr] <;> push_cast <;> ring

/-- **The functional bound**: every hole functional is dominated in absolute value by the
norm form. Each case is a sum-of-squares identity closed over `ℤ` by parity. -/
theorem abs_holeF_le (i : Fin 6) (v : ℤ × ℤ) : |holeF i v| ≤ hexQi v := by
  obtain ⟨a, b⟩ := v
  have e1 : 2 * (a ^ 2 + a * b + b ^ 2 - (a + b)) = (a + b) ^ 2 + (a - 1) ^ 2 + (b - 1) ^ 2 - 2 := by
    ring
  have e2 : 2 * (a ^ 2 + a * b + b ^ 2 + (a + b)) = (a + b) ^ 2 + (a + 1) ^ 2 + (b + 1) ^ 2 - 2 := by
    ring
  have e3 : 2 * (a ^ 2 + a * b + b ^ 2 - b) = (a + b) ^ 2 + a ^ 2 + (b - 1) ^ 2 - 1 := by ring
  have e4 : 2 * (a ^ 2 + a * b + b ^ 2 + b) = (a + b) ^ 2 + a ^ 2 + (b + 1) ^ 2 - 1 := by ring
  have e5 : 2 * (a ^ 2 + a * b + b ^ 2 - a) = (a + b) ^ 2 + (a - 1) ^ 2 + b ^ 2 - 1 := by ring
  have e6 : 2 * (a ^ 2 + a * b + b ^ 2 + a) = (a + b) ^ 2 + (a + 1) ^ 2 + b ^ 2 - 1 := by ring
  have s1 := sq_nonneg (a + b)
  have s2 := sq_nonneg (a - 1)
  have s3 := sq_nonneg (b - 1)
  have s4 := sq_nonneg (a + 1)
  have s5 := sq_nonneg (b + 1)
  have s6 := sq_nonneg a
  have s7 := sq_nonneg b
  have hab : (a + b) ^ 2 + (a - 1) ^ 2 + (b - 1) ^ 2 ≥ 2 := by nlinarith [sq_nonneg (a - b)]
  have hab' : (a + b) ^ 2 + (a + 1) ^ 2 + (b + 1) ^ 2 ≥ 2 := by nlinarith [sq_nonneg (a - b)]
  simp only [hexQi, abs_le]
  fin_cases i <;> simp only [holeF] <;> constructor <;> omega

/-- **The hole ray rounds to the origin.** For `|s| < 1` the point `s · hole i` has the
origin as its unique nearest lattice address — this is the cell reaching out to its corner,
and it is the only place the inscribed disc is not enough. -/
theorem nearestUnique_hole {i : Fin 6} {s : ℝ} (hs : |s| < 1) :
    NearestUnique (s • hole i) 0 := by
  intro u hu
  rw [addr_zero, sub_zero]
  have hQu : (1 : ℝ) ≤ hexQ (addr u) := by
    rw [hexQ_addr]; exact_mod_cast one_le_hexQi hu
  have hbound : |hexIP (hole i) (addr u)| ≤ hexQ (addr u) := by
    rw [hexIP_hole, hexQ_addr]
    exact_mod_cast abs_holeF_le i u
  have hQpos : (0 : ℝ) < hexQ (addr u) := lt_of_lt_of_le one_pos hQu
  have hkey : hexIP (s • hole i) (addr u) < hexQ (addr u) := by
    rw [hexIP_smul_left]
    calc s * hexIP (hole i) (addr u)
        ≤ |s * hexIP (hole i) (addr u)| := le_abs_self _
      _ = |s| * |hexIP (hole i) (addr u)| := abs_mul _ _
      _ ≤ |s| * hexQ (addr u) := by
          exact mul_le_mul_of_nonneg_left hbound (abs_nonneg s)
      _ < 1 * hexQ (addr u) := by exact mul_lt_mul_of_pos_right hs hQpos
      _ = hexQ (addr u) := one_mul _
  rw [hexQ_sub, hexQ_smul, hexQ_hole]
  nlinarith [sq_nonneg s]


/-! ## The sweeps

Every step of the argument produces a pair of same-coloured points at distance exactly 1,
by moving two points apart along a fixed direction from two same-coloured lattice points.
`sweep_exact` is the move; `sweep_ivt` finds the parameter by continuity when the exact
solution is inconvenient. -/

theorem hexQ_neg (w : ℝ × ℝ) : hexQ (-w) = hexQ w := by
  simp only [hexQ, Prod.fst_neg, Prod.snd_neg]; ring

theorem hexIP_comm (u v : ℝ × ℝ) : hexIP u v = hexIP v u := by simp only [hexIP]; ring

theorem hexIP_smul_right (c : ℝ) (u v : ℝ × ℝ) : hexIP u (c • v) = c * hexIP u v := by
  rw [hexIP_comm, hexIP_smul_left, hexIP_comm]

theorem continuous_hexQ : Continuous hexQ := by unfold hexQ; fun_prop

section Colouring

variable {A : Type*} [AddCommGroup A] {p : ℝ} {φ : (ℤ × ℤ) →+ A} {rnd : ℂ → ℤ × ℤ}

/-- **The sweep.** Two same-coloured lattice addresses, two points pushed off them along a
common direction, landing at distance exactly 1: properness cannot hold. -/
theorem sweep_exact (hp : 0 < p)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (hproper : ∀ x y : ℂ, dist x y = 1 → φ (rnd x) ≠ φ (rnd y))
    {v : ℤ × ℤ} (hv : φ v = 0) {e : ℝ × ℝ} {s : ℝ}
    (h₀ : NearestUnique ((-s) • e) 0) (h₁ : NearestUnique (s • e) 0)
    (hd : p ^ 2 * hexQ (addr v + (2 * s) • e) = 1) : False := by
  have hx : rnd (emb p ((-s) • e)) = 0 := rnd_eq hp hrnd h₀
  have hy : rnd (emb p (addr v + s • e)) = v := by
    have h := rnd_eq hp hrnd (nearestUnique_add v h₁)
    simpa using h
  have hgeo : ((-s) • e) - (addr v + s • e) = -(addr v + (2 * s) • e) := by
    simp only [Prod.ext_iff, Prod.smul_fst, Prod.smul_snd, Prod.fst_add, Prod.snd_add,
      Prod.fst_sub, Prod.snd_sub, Prod.fst_neg, Prod.snd_neg, smul_eq_mul]
    constructor <;> ring
  have hdist : dist (emb p ((-s) • e)) (emb p (addr v + s • e)) = 1 := by
    have hsq : dist (emb p ((-s) • e)) (emb p (addr v + s • e)) ^ 2 = 1 := by
      rw [dist_emb_sq, hgeo, hexQ_neg]; exact hd
    nlinarith [dist_nonneg (x := emb p ((-s) • e)) (y := emb p (addr v + s • e))]
  exact hproper _ _ hdist (by rw [hx, hy, hv, map_zero])

/-- The same move with the parameter found by continuity, for the sweeps whose exact
solution is a root of a quadratic. -/
theorem sweep_ivt (hp : 0 < p)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (hproper : ∀ x y : ℂ, dist x y = 1 → φ (rnd x) ≠ φ (rnd y))
    {v : ℤ × ℤ} (hv : φ v = 0) {e : ℝ × ℝ} {s₀ s₁ : ℝ} (hs : s₀ ≤ s₁)
    (hray : ∀ s ∈ Set.Ioo s₀ s₁, NearestUnique ((-s) • e) 0 ∧ NearestUnique (s • e) 0)
    (h0 : p ^ 2 * hexQ (addr v + (2 * s₀) • e) < 1)
    (h1 : 1 < p ^ 2 * hexQ (addr v + (2 * s₁) • e)) : False := by
  have hcont : ContinuousOn (fun s : ℝ => p ^ 2 * hexQ (addr v + (2 * s) • e))
      (Set.Icc s₀ s₁) := by
    apply Continuous.continuousOn
    exact continuous_const.mul (continuous_hexQ.comp (by fun_prop))
  obtain ⟨s, hsmem, hFs⟩ := intermediate_value_Ioo hs hcont ⟨h0, h1⟩
  exact sweep_exact hp hrnd hproper hv (hray s hsmem).1 (hray s hsmem).2 hFs

/-- **The scale bound.** The deep hole's own diameter is a same-coloured pair, so the cells
cannot be too big: `2p/√3 ≤ 1`, stated squarely as `4p² ≤ 3`. -/
theorem scale_sq_le (hp : 0 < p)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (hproper : ∀ x y : ℂ, dist x y = 1 → φ (rnd x) ≠ φ (rnd y)) : 4 * p ^ 2 ≤ 3 := by
  by_contra hcon
  push Not at hcon
  refine sweep_ivt hp hrnd hproper (v := 0) (map_zero φ) (e := hole 0) (s₀ := 0) (s₁ := 1)
    zero_le_one (fun s hs => ?_) ?_ ?_
  · have h : |s| < 1 := abs_lt.mpr ⟨by linarith [hs.1], hs.2⟩
    exact ⟨nearestUnique_hole (by rwa [abs_neg]), nearestUnique_hole h⟩
  · norm_num
  · rw [addr_zero, zero_add, hexQ_smul, hexQ_hole]
    nlinarith

/-- **The collinear sweep.** Two points pushed apart along a kernel direction, from the
origin and from `j` times the kernel vector. -/
theorem collinear_sweep (hp : 0 < p)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (hproper : ∀ x y : ℂ, dist x y = 1 → φ (rnd x) ≠ φ (rnd y))
    {d : ℤ × ℤ} (hφ : φ d = 0) (j : ℤ) {σ : ℝ}
    (hsmall : 4 * σ ^ 2 * (hexQi d : ℝ) < 1)
    (hone : p ^ 2 * (((j : ℝ) + 2 * σ) ^ 2 * (hexQi d : ℝ)) = 1) : False := by
  have hray : ∀ t : ℝ, 4 * t ^ 2 * (hexQi d : ℝ) < 1 → NearestUnique (t • addr d) 0 := by
    intro t ht
    refine nearestUnique_zero ?_
    rw [hexQ_smul, hexQ_addr]
    linarith [ht]
  have hgeo : addr (j • d) + (2 * σ) • addr d = ((j : ℝ) + 2 * σ) • addr d := by
    rw [addr_zsmul, add_smul]
  refine sweep_exact hp hrnd hproper (v := j • d) (by rw [map_zsmul, hφ, smul_zero])
    (e := addr d) (s := σ) (hray (-σ) (by rw [neg_pow]; simpa using hsmall)) (hray σ hsmall) ?_
  rw [hgeo, hexQ_smul, hexQ_addr]
  exact hone

/-- **The corner sweep.** Along a deep hole instead of the kernel direction: it reaches
further, which is what closes the seams the collinear sweep leaves at kernel norm 4. -/
theorem corner_sweep (hp : 0 < p)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (hproper : ∀ x y : ℂ, dist x y = 1 → φ (rnd x) ≠ φ (rnd y))
    {d : ℤ × ℤ} (hφ : φ d = 0) {i : Fin 6} {j : ℤ} (hF : holeF i d = 2)
    (h0 : p ^ 2 * (hexQi (j • d) : ℝ) < 1)
    (h1 : 1 < p ^ 2 * ((hexQi (j • d) : ℝ) + 4 * (j : ℝ) + 4 / 3)) : False := by
  have hIP : hexIP (addr (j • d)) (hole i) = 2 * (j : ℝ) := by
    rw [addr_zsmul, hexIP_smul_left, hexIP_comm, hexIP_hole, hF]
    push_cast; ring
  have hF' : ∀ s : ℝ, hexQ (addr (j • d) + (2 * s) • hole i)
      = (hexQi (j • d) : ℝ) + 4 * s * (j : ℝ) + 4 * s ^ 2 / 3 := by
    intro s
    rw [hexQ_add, hexIP_smul_right, hIP, hexQ_smul, hexQ_hole, hexQ_addr]
    ring
  refine sweep_ivt hp hrnd hproper (v := j • d) (by rw [map_zsmul, hφ, smul_zero])
    (e := hole i) (s₀ := 0) (s₁ := 1) zero_le_one (fun s hs => ?_) ?_ ?_
  · have h : |s| < 1 := abs_lt.mpr ⟨by linarith [hs.1], hs.2⟩
    exact ⟨nearestUnique_hole (by rwa [abs_neg]), nearestUnique_hole h⟩
  · rw [hF']; simpa using h0
  · rw [hF']; simpa using h1

end Colouring


/-! ## The witnesses -/

/-- **The gap lemma.** A step shorter than the window hits every window of width two: some
positive multiple of `g` lands within 1 of `T`. This is what kills every kernel norm below
four, where the step `√N` is shorter than the diameter of reach. -/
theorem exists_step_near {g T : ℝ} (hg : 0 < g) (hg2 : g < 2) (hT : 1 ≤ T) :
    ∃ j : ℤ, 1 ≤ j ∧ |(j : ℝ) * g - T| < 1 := by
  rcases le_or_gt g T with hgT | hgT
  · have hk0 : (1 : ℝ) ≤ T / g := (one_le_div hg).mpr hgT
    have hkle : ((⌊T / g⌋ : ℤ) : ℝ) * g ≤ T := by
      have := Int.floor_le (T / g)
      calc ((⌊T / g⌋ : ℤ) : ℝ) * g ≤ (T / g) * g := by nlinarith
        _ = T := by field_simp
    have hklt : T < (((⌊T / g⌋ : ℤ) : ℝ) + 1) * g := by
      have := Int.lt_floor_add_one (T / g)
      calc T = (T / g) * g := by field_simp
        _ < (((⌊T / g⌋ : ℤ) : ℝ) + 1) * g := by nlinarith
    have hk1 : 1 ≤ ⌊T / g⌋ := by
      have : (1 : ℤ) ≤ ⌊T / g⌋ := Int.le_floor.mpr (by exact_mod_cast hk0)
      exact this
    rcases lt_or_ge (T - ((⌊T / g⌋ : ℤ) : ℝ) * g) 1 with h | h
    · exact ⟨⌊T / g⌋, hk1, by rw [abs_lt]; constructor <;> linarith⟩
    · refine ⟨⌊T / g⌋ + 1, by omega, ?_⟩
      rw [abs_lt]
      push_cast
      constructor <;> nlinarith
  · exact ⟨1, le_refl 1, by rw [abs_lt]; push_cast; constructor <;> linarith⟩

/-- Every address of norm four carries a hole functional of value exactly two — the reach
the corner sweep needs. The six such addresses are `2 ×` the six units. -/
theorem exists_hole_two {d : ℤ × ℤ} (h : hexQi d = 4) : ∃ i : Fin 6, holeF i d = 2 := by
  obtain ⟨a, b⟩ := d
  simp only [hexQi] at h
  have hb1 : -2 ≤ b := by nlinarith [sq_nonneg (2 * a + b)]
  have hb2 : b ≤ 2 := by nlinarith [sq_nonneg (2 * a + b)]
  have ha1 : -2 ≤ a := by nlinarith [sq_nonneg (a + 2 * b)]
  have ha2 : a ≤ 2 := by nlinarith [sq_nonneg (a + 2 * b)]
  interval_cases a <;> interval_cases b <;> revert h <;> decide

section Colouring

variable {A : Type*} [AddCommGroup A] {p : ℝ} {φ : (ℤ × ℤ) →+ A} {rnd : ℂ → ℤ × ℤ}

/-- **The kernel gap.** Every nonzero same-coloured lattice offset has norm at least seven:
norms 1 and 3 die to the collinear sweep, norm 4 to the corner sweep, and 2, 5, 6 are not
norms at all. -/
theorem seven_le_hexQi (hp : 0 < p)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (hproper : ∀ x y : ℂ, dist x y = 1 → φ (rnd x) ≠ φ (rnd y))
    {d : ℤ × ℤ} (hd0 : d ≠ 0) (hφ : φ d = 0) : 7 ≤ hexQi d := by
  by_contra hcon
  push Not at hcon
  have hscale := scale_sq_le hp hrnd hproper
  set T : ℝ := 1 / p with hTdef
  have hTp : p * T = 1 := by rw [hTdef]; field_simp
  have hT1 : 1 < T := by
    rw [hTdef, lt_div_iff₀ hp]; nlinarith
  -- the collinear kill, available whenever a multiple of the step lands near the unit
  have collinear : ∀ (N : ℤ) (g : ℝ), hexQi d = N → g ^ 2 = (N : ℝ) → 0 < g →
      (∃ j : ℤ, 1 ≤ j ∧ |(j : ℝ) * g - T| < 1) → False := by
    rintro N g hN hg2 hg ⟨j, _, hj⟩
    refine collinear_sweep hp hrnd hproper hφ j (σ := (T / g - (j : ℝ)) / 2) ?_ ?_
    · rw [hN, ← hg2]
      have : (4 : ℝ) * ((T / g - (j : ℝ)) / 2) ^ 2 * g ^ 2 = (T - (j : ℝ) * g) ^ 2 := by
        field_simp; ring
      rw [this]
      rcases abs_lt.mp hj with ⟨hl, hr⟩
      nlinarith
    · rw [hN, ← hg2]
      have hgne : g ≠ 0 := ne_of_gt hg
      have : ((j : ℝ) + 2 * ((T / g - (j : ℝ)) / 2)) ^ 2 * g ^ 2 = T ^ 2 := by
        field_simp
        ring
      rw [this]
      nlinarith
  rcases hexQi_eq_of_le_six hd0 (by omega) with h1 | h3 | h4
  · exact collinear 1 1 h1 (by norm_num) one_pos
      (exists_step_near one_pos (by norm_num) hT1.le)
  · refine collinear 3 (Real.sqrt 3) h3 (Real.sq_sqrt (by norm_num)) (Real.sqrt_pos.mpr (by norm_num))
      (exists_step_near (Real.sqrt_pos.mpr (by norm_num)) ?_ hT1.le)
    nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ 3 by norm_num), Real.sqrt_nonneg 3]
  · -- norm four: the collinear windows only touch, and the seam is `T` an odd integer
    set j : ℤ := ⌊(T + 1) / 2⌋ with hjdef
    have hj2 : ((j : ℝ)) * 2 ≤ T + 1 := by
      have := Int.floor_le ((T + 1) / 2); rw [← hjdef] at this; linarith
    have hj1 : T - 1 < (j : ℝ) * 2 := by
      have := Int.lt_floor_add_one ((T + 1) / 2); rw [← hjdef] at this; linarith
    have hjpos : 1 ≤ j := by
      have h0 : (0 : ℝ) < (j : ℝ) := by linarith
      have : (0 : ℤ) < j := by exact_mod_cast h0
      omega
    rcases lt_or_eq_of_le hj2 with hlt | heq
    · exact collinear 4 2 h4 (by norm_num) two_pos ⟨j, hjpos, by rw [abs_lt]; constructor <;> linarith⟩
    · -- the seam: `T = 2(j-1) + 1`
      obtain ⟨i, hi⟩ := exists_hole_two h4
      have hTj : T = 2 * ((j : ℝ) - 1) + 1 := by linarith
      have hp1 : p < 1 := by nlinarith
      have hj' : ((j : ℝ) - 1) = (T - 1) / 2 := by linarith
      refine corner_sweep hp hrnd hproper hφ (i := i) (j := j - 1) hi ?_ ?_
      · rw [hexQi_zsmul, h4]
        push_cast
        rw [hj']
        have e : p ^ 2 * ((T - 1) / 2) ^ 2 * 4 = (p * (T - 1)) ^ 2 := by ring
        have hkey : p * (T - 1) = 1 - p := by rw [mul_sub, hTp]; ring
        calc p ^ 2 * (((T - 1) / 2) ^ 2 * 4) = (p * (T - 1)) ^ 2 := by ring
          _ = (1 - p) ^ 2 := by rw [hkey]
          _ < 1 := by nlinarith
      · rw [hexQi_zsmul, h4]
        push_cast
        rw [hj']
        calc (1 : ℝ) < p ^ 2 * T ^ 2 + p ^ 2 / 3 := by nlinarith
          _ = p ^ 2 * (((T - 1) / 2) ^ 2 * 4 + 4 * ((T - 1) / 2) + 4 / 3) := by ring

end Colouring


/-! ## The closed first shell, and the theorem -/

/-- The seven addresses of the closed first shell: the origin and the six units. This is the
same seven-point object as `Instances/HexShell.lean`'s K₇ of the `{1, √3, 2}`-distance
graph, met from the other side. -/
def shell : Fin 7 → ℤ × ℤ
  | 0 => (0, 0)
  | 1 => (1, 0)
  | 2 => (0, 1)
  | 3 => (-1, 1)
  | 4 => (-1, 0)
  | 5 => (0, -1)
  | 6 => (1, -1)

/-- Distinct shell addresses differ by a nonzero vector of norm at most four — a unit, a
`√3`-vector, or a diameter. All are below the kernel gap of seven. -/
theorem shell_diff {i j : Fin 7} (h : i ≠ j) :
    shell i - shell j ≠ 0 ∧ hexQi (shell i - shell j) ≤ 4 := by
  revert h; fin_cases i <;> fin_cases j <;> decide

theorem nearestUnique_self (v : ℤ × ℤ) : NearestUnique (addr v) v := by
  have h := nearestUnique_add v (nearestUnique_zero (w := (0 : ℝ × ℝ)) (by simp))
  simpa using h

section Colouring

variable {A : Type*} [AddCommGroup A] {p : ℝ} {φ : (ℤ × ℤ) →+ A} {rnd : ℂ → ℤ × ℤ}

/-- **The coset bound, on addresses.** In a proper coset colouring the seven closed-shell
addresses take seven pairwise distinct colours. -/
theorem shell_rainbow (hp : 0 < p)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (hproper : ∀ x y : ℂ, dist x y = 1 → φ (rnd x) ≠ φ (rnd y))
    {i j : Fin 7} (hij : i ≠ j) : φ (shell i) ≠ φ (shell j) := by
  intro hc
  obtain ⟨hne, hle⟩ := shell_diff hij
  have h0 : φ (shell i - shell j) = 0 := by rw [map_sub, hc, sub_self]
  have := seven_le_hexQi hp hrnd hproper hne h0
  omega

/-- **The coset bound, on the plane.** The colouring takes seven distinct values on seven
explicit points — the lattice points of the closed first shell. So a nearest-point coset
colouring of the plane with no monochromatic unit pair uses at least seven colours. -/
theorem seven_values (hp : 0 < p)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (hproper : ∀ x y : ℂ, dist x y = 1 → φ (rnd x) ≠ φ (rnd y))
    {i j : Fin 7} (hij : i ≠ j) :
    φ (rnd (latt p (shell i))) ≠ φ (rnd (latt p (shell j))) := by
  have h : ∀ k : Fin 7, rnd (latt p (shell k)) = shell k := fun k =>
    rnd_eq hp hrnd (nearestUnique_self (shell k))
  rw [h i, h j]
  exact shell_rainbow hp hrnd hproper hij

/-- **The count.** A proper coset colouring has at least seven colours available to it. -/
theorem seven_le_card [Fintype A] (hp : 0 < p)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (hproper : ∀ x y : ℂ, dist x y = 1 → φ (rnd x) ≠ φ (rnd y)) : 7 ≤ Fintype.card A := by
  have hinj : Function.Injective (fun i : Fin 7 => φ (shell i)) := by
    intro i j hij
    by_contra hne
    exact shell_rainbow hp hrnd hproper hne hij
  simpa using Fintype.card_le_of_injective _ hinj

end Colouring

/-! ### Controls — compiled, every build

The theorem's CONSEQUENT is achievable: the norm-7 coset map `(a, b) ↦ (a + 3b) mod 7`
really does give the seven shell addresses seven distinct colours. Its hypotheses' full
satisfiability — that a proper coset colouring exists at all — is the sharpness half,
confirmed in `build/m37-design.py` (the admissible scale window is `p ∈ (0.671, 0.866]`)
and not formalized here; the contrapositive reading, *a coset colouring with six or fewer
colours always has two points one unit apart sharing a colour*, is manifestly non-vacuous. -/

-- the seven shell addresses are distinct, and the norm-7 coset map separates them
#guard (List.finRange 7).map (fun i => ((shell i).1 + 3 * (shell i).2) % 7)
  |>.Nodup

-- the deep holes really are at squared distance 1/3, and their functionals are ±a, ±b, ±(a+b)
#guard (List.finRange 6).map (fun i => holeF i (3, 5)) = [8, 5, -3, -8, -5, 3]

-- every norm-4 address carries a functional of value 2, and the norm-4 addresses are 2 × units
#guard ([(2,0), (0,2), (-2,2), (-2,0), (0,-2), (2,-2)] : List (ℤ × ℤ)).all
  (fun d => hexQi d = 4 && (List.finRange 6).any (fun i => holeF i d == 2))

-- PROPERNESS is load-bearing: the zero map is a perfectly good coset colouring and gives
-- the whole shell one colour, so the conclusion is not a fact about the shell alone
example : (0 : (ℤ × ℤ) →+ ZMod 7) (shell 0) = (0 : (ℤ × ℤ) →+ ZMod 7) (shell 1) := rfl

-- and the shell's own difference norms are exactly {1, 3, 4} — all below the gap of seven
#guard (((List.finRange 7).flatMap fun i => (List.finRange 7).map fun j =>
  hexQi (shell i - shell j)).filter (· != 0)).eraseDups.mergeSort (· ≤ ·) = [1, 3, 4]

end Coset


end HadwigerNelson
