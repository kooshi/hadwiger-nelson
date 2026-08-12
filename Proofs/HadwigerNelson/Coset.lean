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

And the bound is TIGHT: the classical hexagonal seven-colouring — the norm-7 ideal
`(−3 + ζ₆)` at scale `6/7` — is a proper coset colouring with seven colours
(`exists_proper_coset_colouring`). So **the coset chromatic number of the plane is exactly
seven** (`coset_chromatic_eq_seven`), and no lattice colouring can ever witness
`χ(ℝ²) ≤ 6`.

**And the homomorphism can go, in the coarse regime** (M38). With no algebra on the
labels the object is the *constraint graph* on the lattice — join two addresses when their
cells hold a unit-distance pair — and for `p ∈ (1/2, 1)` its constraint set is exactly the
first three shells `Q ∈ {1, 3, 4}`, so the closed first shell is a **7-clique** and seven
colours are forced with no arithmetic at all (`seven_le_card_of_cell_constant`,
`cell_chromatic_eq_seven`). Below `p = 1/2` the nearest-neighbour constraint lapses and the
argument stops — at fine scales the constraint graph is a thin annulus graph whose
chromatic number is the plane's own open question. That boundary is the content: **any
six-colouring of the plane has colour classes finer than half the unit distance, in every
lattice's cells.**

**Attribution.** That the hexagonal colouring is optimal among lattice colourings is
folklore-adjacent; no novelty is claimed for the construction it bounds. Ours is the proof
shape, the formalization, and the packaging as a limitation theorem for the upper-bound
hunt.
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

/-- **The sweep, in its honest form**: two lattice addresses and a direction produce an
actual pair of points at distance exactly 1, one in each address's cell. Nothing about
colour enters — this is pure geometry, and every use of it in this file is an instance. -/
theorem exists_unit_pair (hp : 0 < p)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    {u v : ℤ × ℤ} {e : ℝ × ℝ} {s : ℝ}
    (h₀ : NearestUnique ((-s) • e) 0) (h₁ : NearestUnique (s • e) 0)
    (hd : p ^ 2 * hexQ (addr v - addr u + (2 * s) • e) = 1) :
    ∃ x y : ℂ, dist x y = 1 ∧ rnd x = u ∧ rnd y = v := by
  refine ⟨emb p (addr u + (-s) • e), emb p (addr v + s • e), ?_, ?_, ?_⟩
  · have hgeo : (addr u + (-s) • e) - (addr v + s • e)
        = -(addr v - addr u + (2 * s) • e) := by
      simp only [Prod.ext_iff, Prod.smul_fst, Prod.smul_snd, Prod.fst_add, Prod.snd_add,
        Prod.fst_sub, Prod.snd_sub, Prod.fst_neg, Prod.snd_neg, smul_eq_mul]
      constructor <;> ring
    have hsq : dist (emb p (addr u + (-s) • e)) (emb p (addr v + s • e)) ^ 2 = 1 := by
      rw [dist_emb_sq, hgeo, hexQ_neg]; exact hd
    nlinarith [dist_nonneg (x := emb p (addr u + (-s) • e)) (y := emb p (addr v + s • e))]
  · have h := rnd_eq hp hrnd (nearestUnique_add u h₀); simpa using h
  · have h := rnd_eq hp hrnd (nearestUnique_add v h₁); simpa using h

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



/-! ## Sharpness: seven is attained

The bound is tight inside its own family. The witness is the classical hexagonal
seven-colouring: the norm-7 ideal `(−3 + ζ₆)` of `ℤ[ζ₆]`, read as the kernel of
`(a, b) ↦ a + 3b` in `ℤ/7`, with the cells the Voronoi cells of the lattice at scale
`p = 6/7`. Two ingredients: the lattice's covering radius (`p/√3`, so cells have diameter
under 1) and the ideal's minimum (`√7·p`, so same-coloured cells stay clear of 1). -/

theorem hexQ_ge_sq_fst (w : ℝ × ℝ) : 3 / 4 * w.1 ^ 2 ≤ hexQ w := by
  simp only [hexQ]; nlinarith [sq_nonneg (w.1 + 2 * w.2)]

theorem hexQ_ge_sq_snd (w : ℝ × ℝ) : 3 / 4 * w.2 ^ 2 ≤ hexQ w := by
  simp only [hexQ]; nlinarith [sq_nonneg (2 * w.1 + w.2)]

/-- **The covering radius.** Every point of the plane is within `p/√3` of a lattice point:
in address coordinates, some address is at form-distance at most `1/3`. -/
theorem exists_close (w : ℝ × ℝ) : ∃ v : ℤ × ℤ, hexQ (w - addr v) ≤ 1 / 3 := by
  obtain ⟨x, y⟩ := w
  set a : ℤ := ⌊x⌋ with ha
  set b : ℤ := ⌊y⌋ with hb
  have hx0 : 0 ≤ x - (a : ℝ) := by rw [ha]; linarith [Int.floor_le x]
  have hx1 : x - (a : ℝ) < 1 := by rw [ha]; linarith [Int.lt_floor_add_one x]
  have hy0 : 0 ≤ y - (b : ℝ) := by rw [hb]; linarith [Int.floor_le y]
  have hy1 : y - (b : ℝ) < 1 := by rw [hb]; linarith [Int.lt_floor_add_one y]
  set α : ℝ := x - (a : ℝ)
  set β : ℝ := y - (b : ℝ)
  have key : hexQ (α, β) ≤ 1 / 3 ∨ hexQ (α - 1, β) ≤ 1 / 3 ∨ hexQ (α, β - 1) ≤ 1 / 3 ∨
      hexQ (α - 1, β - 1) ≤ 1 / 3 := by
    rcases le_or_gt (α + β) 1 with hab | hab
    · rcases (by
        by_contra h
        push Not at h
        obtain ⟨h1, h2, h3⟩ := h
        simp only [hexQ] at h1 h2 h3
        nlinarith [sq_nonneg (α - β), sq_nonneg (α + β - 2/3), sq_nonneg (α - 1/3),
          sq_nonneg (β - 1/3)] :
        hexQ (α, β) ≤ 1/3 ∨ hexQ (α - 1, β) ≤ 1/3 ∨ hexQ (α, β - 1) ≤ 1/3) with h | h | h
      · exact Or.inl h
      · exact Or.inr (Or.inl h)
      · exact Or.inr (Or.inr (Or.inl h))
    · rcases (by
        by_contra h
        push Not at h
        obtain ⟨h1, h2, h3⟩ := h
        simp only [hexQ] at h1 h2 h3
        nlinarith [sq_nonneg (α - β), sq_nonneg (α + β - 4/3), sq_nonneg (α - 2/3),
          sq_nonneg (β - 2/3)] :
        hexQ (α - 1, β - 1) ≤ 1/3 ∨ hexQ (α - 1, β) ≤ 1/3 ∨ hexQ (α, β - 1) ≤ 1/3) with h | h | h
      · exact Or.inr (Or.inr (Or.inr h))
      · exact Or.inr (Or.inl h)
      · exact Or.inr (Or.inr (Or.inl h))
  have hsub : ∀ da db : ℤ, ((x, y) : ℝ × ℝ) - addr (a + da, b + db)
      = (α - (da : ℝ), β - (db : ℝ)) := by
    intro da db
    simp only [addr, Prod.ext_iff, Prod.fst_sub, Prod.snd_sub]
    push_cast
    constructor <;> ring
  rcases key with h | h | h | h
  · refine ⟨(a + 0, b + 0), ?_⟩; rw [hsub]; simpa using h
  · refine ⟨(a + 1, b + 0), ?_⟩; rw [hsub]; simpa using h
  · refine ⟨(a + 0, b + 1), ?_⟩; rw [hsub]; simpa using h
  · refine ⟨(a + 1, b + 1), ?_⟩; rw [hsub]; simpa using h

/-- Outside the four corners of its own cell an address is far — the form is at least `3/4`,
beyond the covering radius — so a nearest address always exists, and a nearest-point
rounding of the plane can be chosen. -/
theorem exists_nearest (w : ℝ × ℝ) :
    ∃ v : ℤ × ℤ, ∀ u : ℤ × ℤ, hexQ (w - addr v) ≤ hexQ (w - addr u) := by
  classical
  obtain ⟨v₀, hv₀⟩ := exists_close w
  set S : Finset (ℤ × ℤ) :=
    {v₀, (⌊w.1⌋, ⌊w.2⌋), (⌊w.1⌋ + 1, ⌊w.2⌋), (⌊w.1⌋, ⌊w.2⌋ + 1), (⌊w.1⌋ + 1, ⌊w.2⌋ + 1)} with hS
  have hne : S.Nonempty := ⟨v₀, by simp [hS]⟩
  obtain ⟨v, hvS, hvmin⟩ := S.exists_min_image (fun u => hexQ (w - addr u)) hne
  have hvle : hexQ (w - addr v) ≤ 1 / 3 := le_trans (hvmin v₀ (by simp [hS])) hv₀
  refine ⟨v, fun u => ?_⟩
  by_cases hu : u ∈ S
  · exact hvmin u hu
  · -- outside the window: one coordinate is at least a full step away
    have hco : 1 ≤ |w.1 - (u.1 : ℝ)| ∨ 1 ≤ |w.2 - (u.2 : ℝ)| := by
      by_contra hc
      push Not at hc
      obtain ⟨hc1, hc2⟩ := hc
      rw [abs_lt] at hc1 hc2
      have h1 : u.1 = ⌊w.1⌋ ∨ u.1 = ⌊w.1⌋ + 1 := by
        have hlo : (⌊w.1⌋ : ℝ) < (u.1 : ℝ) + 1 := by
          have := Int.floor_le w.1; linarith [hc1.2]
        have hhi : (u.1 : ℝ) < (⌊w.1⌋ : ℝ) + 2 := by
          have := Int.lt_floor_add_one w.1; linarith [hc1.1]
        have h1' : ⌊w.1⌋ < u.1 + 1 := by exact_mod_cast hlo
        have h2' : u.1 < ⌊w.1⌋ + 2 := by exact_mod_cast hhi
        omega
      have h2 : u.2 = ⌊w.2⌋ ∨ u.2 = ⌊w.2⌋ + 1 := by
        have hlo : (⌊w.2⌋ : ℝ) < (u.2 : ℝ) + 1 := by
          have := Int.floor_le w.2; linarith [hc2.2]
        have hhi : (u.2 : ℝ) < (⌊w.2⌋ : ℝ) + 2 := by
          have := Int.lt_floor_add_one w.2; linarith [hc2.1]
        have h1' : ⌊w.2⌋ < u.2 + 1 := by exact_mod_cast hlo
        have h2' : u.2 < ⌊w.2⌋ + 2 := by exact_mod_cast hhi
        omega
      obtain ⟨u1, u2⟩ := u
      rcases h1 with h1 | h1 <;> rcases h2 with h2 | h2 <;> subst h1 <;> subst h2 <;>
        simp [hS] at hu
    have hfar : (3 : ℝ) / 4 ≤ hexQ (w - addr u) := by
      rcases hco with h | h
      · have hq := hexQ_ge_sq_fst (w - addr u)
        have : (w - addr u).1 = w.1 - (u.1 : ℝ) := rfl
        rw [this] at hq
        nlinarith [sq_abs (w.1 - (u.1 : ℝ)), abs_nonneg (w.1 - (u.1 : ℝ))]
      · have hq := hexQ_ge_sq_snd (w - addr u)
        have : (w - addr u).2 = w.2 - (u.2 : ℝ) := rfl
        rw [this] at hq
        nlinarith [sq_abs (w.2 - (u.2 : ℝ)), abs_nonneg (w.2 - (u.2 : ℝ))]
    linarith





/-! ### The witness: the norm-7 ideal at scale 6/7 -/

/-- The classical seven-colouring's colour map: `(a, b) ↦ a + 3b` in `ℤ/7`. Its kernel is
the ideal generated by `−3 + ζ₆`, of norm 7 — which is why it separates colour classes by
`√7` rather than merely by index. -/
def ideal7 : (ℤ × ℤ) →+ ZMod 7 where
  toFun v := (v.1 : ZMod 7) + 3 * (v.2 : ZMod 7)
  map_zero' := by simp
  map_add' u v := by simp only [Prod.fst_add, Prod.snd_add]; push_cast; ring

/-- The ideal's minimum: every nonzero same-coloured offset has norm at least seven. -/
theorem ideal7_min {d : ℤ × ℤ} (hd : d ≠ 0) (h : ideal7 d = 0) : 7 ≤ hexQi d := by
  by_contra hcon
  push Not at hcon
  obtain ⟨a, b⟩ := d
  have hq : a ^ 2 + a * b + b ^ 2 ≤ 6 := by simpa [hexQi] using Int.lt_add_one_iff.mp hcon
  have hb1 : -2 ≤ b := by nlinarith [sq_nonneg (2 * a + b)]
  have hb2 : b ≤ 2 := by nlinarith [sq_nonneg (2 * a + b)]
  have ha1 : -2 ≤ a := by nlinarith [sq_nonneg (a + 2 * b)]
  have ha2 : a ≤ 2 := by nlinarith [sq_nonneg (a + 2 * b)]
  revert h hd hq
  simp only [ideal7, AddMonoidHom.coe_mk, ZeroHom.coe_mk, hexQi]
  interval_cases a <;> interval_cases b <;> decide

/-- The embedding is onto: every point of the plane has an address. -/
theorem emb_surjective {p : ℝ} (hp : 0 < p) (x : ℂ) : ∃ w : ℝ × ℝ, emb p w = x := by
  have h3 : (0 : ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  refine ⟨(x.re / p - x.im / (p * Real.sqrt 3), 2 * x.im / (p * Real.sqrt 3)), ?_⟩
  have hs : Real.sqrt 3 * Real.sqrt 3 = 3 := Real.mul_self_sqrt (by norm_num)
  apply Complex.ext <;> simp only [emb] <;> field_simp <;> ring

/-- **Sharpness: seven is attained.** The norm-7 coset colouring at scale `6/7` is a proper
nearest-point coset colouring of the plane using seven colours — so the bound of
`seven_le_card` is tight, and the coset chromatic number of the plane is exactly seven. -/
theorem exists_proper_coset_colouring :
    ∃ rnd : ℂ → ℤ × ℤ,
      (∀ (x : ℂ) (v : ℤ × ℤ),
        dist x (latt (6 / 7) (rnd x)) ≤ dist x (latt (6 / 7) v)) ∧
      (∀ x y : ℂ, dist x y = 1 → ideal7 (rnd x) ≠ ideal7 (rnd y)) := by
  classical
  set p : ℝ := 6 / 7 with hpdef
  have hp : (0 : ℝ) < p := by rw [hpdef]; norm_num
  -- an address for every point, and a nearest lattice address for every address
  choose adr hadr using emb_surjective hp
  choose nr hnr using exists_nearest
  refine ⟨fun x => nr (adr x), fun x v => ?_, fun x y hxy hc => ?_⟩
  · have h1 : dist x (latt p (nr (adr x))) ^ 2 = p ^ 2 * hexQ (adr x - addr (nr (adr x))) := by
      have h := dist_emb_sq p (adr x) (addr (nr (adr x)))
      rwa [hadr x] at h
    have h2 : dist x (latt p v) ^ 2 = p ^ 2 * hexQ (adr x - addr v) := by
      have h := dist_emb_sq p (adr x) (addr v)
      rwa [hadr x] at h
    have hle := hnr (adr x) v
    have hp2 : (0 : ℝ) < p ^ 2 := by positivity
    nlinarith [dist_nonneg (x := x) (y := latt p (nr (adr x))),
      dist_nonneg (x := x) (y := latt p v)]
  · -- the two cells are the same colour: either the same cell, or at least `√7 p` apart
    set u := nr (adr x) with hu
    set v := nr (adr y) with hv
    -- each point is within `p/√3` of its own lattice point, and `(p/√3)² < 1/4`
    have hclose : ∀ z : ℂ, dist z (latt p (nr (adr z))) < 1 / 2 := by
      intro z
      obtain ⟨c, hcle⟩ := exists_close (adr z)
      have h1 : dist z (latt p (nr (adr z))) ^ 2 = p ^ 2 * hexQ (adr z - addr (nr (adr z))) := by
        have h := dist_emb_sq p (adr z) (addr (nr (adr z)))
        rwa [hadr z] at h
      have h2 : hexQ (adr z - addr (nr (adr z))) ≤ 1 / 3 := le_trans (hnr (adr z) c) hcle
      have h3 : dist z (latt p (nr (adr z))) ^ 2 ≤ p ^ 2 / 3 := by
        rw [h1]; nlinarith [hexQ_nonneg (adr z - addr (nr (adr z)))]
      have h4 : p ^ 2 / 3 < 1 / 4 := by rw [hpdef]; norm_num
      nlinarith [dist_nonneg (x := z) (y := latt p (nr (adr z)))]
    by_cases huv : u = v
    · -- same cell: the two points are less than `1` apart
      have htri := dist_triangle x (latt p u) y
      rw [dist_comm (latt p u) y] at htri
      have h1 := hclose x
      have h2 := hclose y
      rw [← hu] at h1
      rw [← hv, ← huv] at h2
      rw [hxy] at htri
      linarith
    · -- different cells of one colour: their centres are at least `√7 p` apart
      have hne : u - v ≠ 0 := sub_ne_zero_of_ne huv
      have h0 : ideal7 (u - v) = 0 := by rw [map_sub, hc, sub_self]
      have hQ : 7 ≤ hexQi (u - v) := ideal7_min hne h0
      have hcent : dist (latt p u) (latt p v) ^ 2 = p ^ 2 * (hexQi (u - v) : ℝ) := by
        have h := dist_emb_sq p (addr u) (addr v)
        rw [← addr_sub, hexQ_addr] at h
        exact h
      have hbig : (36 : ℝ) / 7 ≤ dist (latt p u) (latt p v) ^ 2 := by
        rw [hcent, hpdef]
        have : (7 : ℝ) ≤ (hexQi (u - v) : ℝ) := by exact_mod_cast hQ
        nlinarith
      have htri := dist_triangle (latt p u) x (latt p v)
      rw [dist_comm (latt p u) x] at htri
      have h1 := hclose x
      have h2 := hclose y
      rw [← hu] at h1
      rw [← hv] at h2
      have hxy' : dist x (latt p v) ≤ 1 + dist y (latt p v) := by
        have := dist_triangle x y (latt p v)
        rw [hxy] at this; linarith
      have : dist (latt p u) (latt p v) ≤ 2 := by linarith
      nlinarith [dist_nonneg (x := latt p u) (y := latt p v)]

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
    shell i - shell j ≠ 0 ∧
      (hexQi (shell i - shell j) = 1 ∨ hexQi (shell i - shell j) = 3 ∨
        hexQi (shell i - shell j) = 4) := by
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
  rcases hle with h | h | h <;> omega

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

/-! ## The coarse-cell bound: dropping the homomorphism (M38)

M37's theorem needs the colour map to be a homomorphism. That hypothesis can be removed
entirely — in the coarse regime — and the reason is a change of viewpoint. With no algebra
on the colours, the object is the **constraint graph on the lattice**: join two addresses
when their cells contain a pair of points one unit apart. For `p ∈ (1/2, 1)` the first
three shells `Q ∈ {1, 3, 4}` are all constrained, so the closed first shell is a
**7-clique** of that graph and seven colours are forced with no arithmetic at all — the
Loeschian gap of M37 is replaced by the clique.

Below `p = 1/2` the nearest-neighbour constraint lapses and the argument stops: at fine
scales the constraint graph is a thin annulus graph whose chromatic number is the plane's
own open question. **That boundary is the content** — any six-colouring of the plane must
have colour classes finer than half the unit distance in every lattice's cells. -/

section CellConstant

variable {p : ℝ} {rnd : ℂ → ℤ × ℤ}

/-- **The constraint condition.** Two distinct addresses whose offset norm `N` satisfies
`(1−p)² < p²N < (1+p)²` have cells containing a pair of points at distance exactly 1. The
condition is exactly `|√N − 1/p| < 1`, radical-free. -/
theorem exists_unit_pair_of_window (hp : 0 < p) (hp1 : p < 1)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    {u v : ℤ × ℤ} (huv : u ≠ v)
    (hlo : (1 - p) ^ 2 < p ^ 2 * (hexQi (v - u) : ℝ))
    (hhi : p ^ 2 * (hexQi (v - u) : ℝ) < (1 + p) ^ 2) :
    ∃ x y : ℂ, dist x y = 1 ∧ rnd x = u ∧ rnd y = v := by
  set d : ℤ × ℤ := v - u with hd
  have hd0 : d ≠ 0 := sub_ne_zero_of_ne (Ne.symm huv)
  have hN1 : (1 : ℝ) ≤ (hexQi d : ℝ) := by exact_mod_cast one_le_hexQi hd0
  set g : ℝ := Real.sqrt (hexQi d : ℝ) with hgdef
  have hg2 : g ^ 2 = (hexQi d : ℝ) := Real.sq_sqrt (by linarith)
  have hg0 : 0 < g := Real.sqrt_pos.mpr (by linarith)
  -- the window condition says the sweep parameter stays inside the inscribed disc
  have hpgpos : 0 < p * g := mul_pos hp hg0
  have hpg2 : (p * g) ^ 2 = p ^ 2 * (hexQi d : ℝ) := by rw [mul_pow, hg2]
  have hpg : |p * g - 1| < p := by
    rw [abs_lt]
    refine ⟨?_, ?_⟩
    · nlinarith [hpg2, hlo, hpgpos]
    · nlinarith [hpg2, hhi, hpgpos]
  set σ : ℝ := (1 / (p * g) - 1) / 2 with hσ
  have hpgne : p * g ≠ 0 := ne_of_gt (mul_pos hp hg0)
  have hsmall : 4 * σ ^ 2 * (hexQi d : ℝ) < 1 := by
    rw [← hg2]
    have h1 : 4 * σ ^ 2 * g ^ 2 = (1 - p * g) ^ 2 / p ^ 2 := by
      rw [hσ]
      field_simp
      ring
    rw [h1, div_lt_one (by positivity)]
    have := abs_lt.mp hpg
    nlinarith [this.1, this.2]
  have hray : ∀ t : ℝ, 4 * t ^ 2 * (hexQi d : ℝ) < 1 → NearestUnique (t • addr d) 0 := by
    intro t ht
    refine nearestUnique_zero ?_
    rw [hexQ_smul, hexQ_addr]
    linarith
  refine exists_unit_pair hp hrnd (e := addr d) (s := σ)
    (hray (-σ) (by rw [neg_pow]; simpa using hsmall)) (hray σ hsmall) ?_
  have hgeo : addr v - addr u + (2 * σ) • addr d = (1 + 2 * σ) • addr d := by
    rw [← addr_sub, ← hd, ← one_smul ℝ (addr d), add_smul]
    simp
  rw [hgeo, hexQ_smul, hexQ_addr, ← hg2]
  have h1 : (1 + 2 * σ) = 1 / (p * g) := by rw [hσ]; ring
  rw [h1]
  field_simp

/-- **The coarse-cell bound.** For `1/2 < p < 1`, ANY colouring of the plane that is
constant on the nearest-point cells of the triangular lattice at scale `p` — with no
algebraic relation between the cells' labels — gives the seven closed-shell addresses seven
pairwise distinct labels. So it uses at least seven colours.

This is M37's theorem with the homomorphism hypothesis removed, at the price of a scale
window; the window's lower end `1/2` is exactly where the nearest-neighbour shell stops
being constrained. -/
theorem seven_labels_of_cell_constant {A : Type*} (hp : 1 / 2 < p) (hp1 : p < 1)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (col : (ℤ × ℤ) → A)
    (hproper : ∀ x y : ℂ, dist x y = 1 → col (rnd x) ≠ col (rnd y))
    {i j : Fin 7} (hij : i ≠ j) : col (shell i) ≠ col (shell j) := by
  intro hc
  have hp0 : (0 : ℝ) < p := by linarith
  obtain ⟨hne, hQ⟩ := shell_diff (Ne.symm hij)
  have hswap : shell j - shell i ≠ 0 := hne
  have huv : shell i ≠ shell j := by
    intro h; exact hne (by rw [h, sub_self])
  have hlo : (1 - p) ^ 2 < p ^ 2 * (hexQi (shell j - shell i) : ℝ) := by
    rcases hQ with h | h | h <;> rw [h] <;> push_cast <;> nlinarith
  have hhi : p ^ 2 * (hexQi (shell j - shell i) : ℝ) < (1 + p) ^ 2 := by
    rcases hQ with h | h | h <;> rw [h] <;> push_cast <;> nlinarith
  obtain ⟨x, y, hxy, hx, hy⟩ := exists_unit_pair_of_window hp0 hp1 hrnd huv hlo hhi
  exact hproper x y hxy (by rw [hx, hy]; exact hc)

/-- The count: a cell-constant colouring in the coarse regime has at least seven colours. -/
theorem seven_le_card_of_cell_constant {A : Type*} [Fintype A] (hp : 1 / 2 < p) (hp1 : p < 1)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (col : (ℤ × ℤ) → A)
    (hproper : ∀ x y : ℂ, dist x y = 1 → col (rnd x) ≠ col (rnd y)) : 7 ≤ Fintype.card A := by
  have hinj : Function.Injective (fun i : Fin 7 => col (shell i)) := by
    intro i j hij
    by_contra hne
    exact seven_labels_of_cell_constant hp hp1 hrnd col hproper hne hij
  simpa using Fintype.card_le_of_injective _ hinj

end CellConstant

/-! ### A second window, deep in the fine regime

The seven-point shell reappears at every scaled copy of the lattice. At the `√3`-scaled
copy — the index-3 sublattice — its pairwise norms are `3·{1,3,4} = {3,9,12}`, and those
are all constrained on a window far below the classical one. So the requirement returns to
seven there, which is the kernel's half of the oscillation M39 measured: seven, then eight,
then seven again. -/

/-- The `√3`-scaled shell: seven addresses with pairwise norms in `{3, 9, 12}`. -/
def shell3 : Fin 7 → ℤ × ℤ
  | 0 => (0, 0)
  | 1 => (1, -2)
  | 2 => (1, 1)
  | 3 => (2, -1)
  | 4 => (3, -3)
  | 5 => (3, 0)
  | 6 => (4, -2)

theorem shell3_diff {i j : Fin 7} (h : i ≠ j) :
    shell3 i - shell3 j ≠ 0 ∧
      (hexQi (shell3 i - shell3 j) = 3 ∨ hexQi (shell3 i - shell3 j) = 9 ∨
        hexQi (shell3 i - shell3 j) = 12) := by
  revert h; fin_cases i <;> fin_cases j <;> decide

section FineWindow

variable {p : ℝ} {rnd : ℂ → ℤ × ℤ}

/-- **Seven colours again, at a third of the classical scale.** For `3/8 < p < 2/5` any
cell-constant colouring gives the `√3`-scaled shell seven distinct labels. Together with
the coarse window (`1/2 < p < 1`, seven) and the band between them (`1/2 < p < 3/5`,
eight), this is the oscillation of the scale, kernel-checked at three points: **the
requirement is not monotone, and refining the cells is not a route downward.** -/
theorem seven_labels_fine {A : Type*} (hp : 3 / 8 < p) (hp1 : p < 2 / 5)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (col : (ℤ × ℤ) → A)
    (hproper : ∀ x y : ℂ, dist x y = 1 → col (rnd x) ≠ col (rnd y))
    {i j : Fin 7} (hij : i ≠ j) : col (shell3 i) ≠ col (shell3 j) := by
  intro hc
  have hp0 : (0 : ℝ) < p := by linarith
  have hp1' : p < 1 := by linarith
  obtain ⟨hne, hQ⟩ := shell3_diff (Ne.symm hij)
  have huv : shell3 i ≠ shell3 j := by
    intro h; exact hne (by rw [h, sub_self])
  have hlo : (1 - p) ^ 2 < p ^ 2 * (hexQi (shell3 j - shell3 i) : ℝ) := by
    rcases hQ with h | h | h <;> rw [h] <;> push_cast <;> nlinarith
  have hhi : p ^ 2 * (hexQi (shell3 j - shell3 i) : ℝ) < (1 + p) ^ 2 := by
    rcases hQ with h | h | h <;> rw [h] <;> push_cast <;> nlinarith
  obtain ⟨x, y, hxy, hx, hy⟩ := exists_unit_pair_of_window hp0 hp1' hrnd huv hlo hhi
  exact hproper x y hxy (by rw [hx, hy]; exact hc)

theorem seven_le_card_fine {A : Type*} [Fintype A] (hp : 3 / 8 < p) (hp1 : p < 2 / 5)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (col : (ℤ × ℤ) → A)
    (hproper : ∀ x y : ℂ, dist x y = 1 → col (rnd x) ≠ col (rnd y)) : 7 ≤ Fintype.card A := by
  have hinj : Function.Injective (fun i : Fin 7 => col (shell3 i)) := by
    intro i j hij
    by_contra hne
    exact seven_labels_fine hp hp1 hrnd col hproper hne hij
  simpa using Fintype.card_le_of_injective _ hinj

end FineWindow

/-! ### The bad band: eight colours just below the classical window

The cell-constant requirement is not monotone in the scale. Just below the window where
the classical seven-colouring lives, a FOURTH shell (`Q = 7`) becomes constrained while the
first three still are — and then the lattice carries an **8-clique**, so eight colours are
needed. Shrinking the cells slightly past the classical scale makes the family strictly
worse. -/

/-- Eight addresses forming a clique of the `{1,3,4,7}` constraint graph: the `3 × 3`
address block with one corner dropped. -/
def block : Fin 8 → ℤ × ℤ
  | 0 => (0, 0)
  | 1 => (0, 1)
  | 2 => (0, 2)
  | 3 => (1, 0)
  | 4 => (1, 1)
  | 5 => (1, 2)
  | 6 => (2, 0)
  | 7 => (2, 1)

theorem block_diff {i j : Fin 8} (h : i ≠ j) :
    block i - block j ≠ 0 ∧
      (hexQi (block i - block j) = 1 ∨ hexQi (block i - block j) = 3 ∨
        hexQi (block i - block j) = 4 ∨ hexQi (block i - block j) = 7) := by
  revert h; fin_cases i <;> fin_cases j <;> decide

section BadBand

variable {p : ℝ} {rnd : ℂ → ℤ × ℤ}

/-- **Eight colours, just below the classical window.** For `1/2 < p < 3/5`, any colouring
constant on the lattice's cells gives the eight block addresses eight pairwise distinct
labels. Since the classical seven-colouring lives at `p ∈ (0.671, 0.866]`, the family's
requirement RISES from seven to eight as the cells shrink past that window — the classical
scale is a local optimum, not a starting point to refine. -/
theorem eight_labels_of_cell_constant {A : Type*} (hp : 1 / 2 < p) (hp1 : p < 3 / 5)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (col : (ℤ × ℤ) → A)
    (hproper : ∀ x y : ℂ, dist x y = 1 → col (rnd x) ≠ col (rnd y))
    {i j : Fin 8} (hij : i ≠ j) : col (block i) ≠ col (block j) := by
  intro hc
  have hp0 : (0 : ℝ) < p := by linarith
  have hp1' : p < 1 := by linarith
  obtain ⟨hne, hQ⟩ := block_diff (Ne.symm hij)
  have huv : block i ≠ block j := by
    intro h; exact hne (by rw [h, sub_self])
  have hlo : (1 - p) ^ 2 < p ^ 2 * (hexQi (block j - block i) : ℝ) := by
    rcases hQ with h | h | h | h <;> rw [h] <;> push_cast <;> nlinarith
  have hhi : p ^ 2 * (hexQi (block j - block i) : ℝ) < (1 + p) ^ 2 := by
    rcases hQ with h | h | h | h <;> rw [h] <;> push_cast <;> nlinarith
  obtain ⟨x, y, hxy, hx, hy⟩ := exists_unit_pair_of_window hp0 hp1' hrnd huv hlo hhi
  exact hproper x y hxy (by rw [hx, hy]; exact hc)

/-- The count: eight colours are needed on that band. -/
theorem eight_le_card_of_cell_constant {A : Type*} [Fintype A] (hp : 1 / 2 < p)
    (hp1 : p < 3 / 5)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (col : (ℤ × ℤ) → A)
    (hproper : ∀ x y : ℂ, dist x y = 1 → col (rnd x) ≠ col (rnd y)) : 8 ≤ Fintype.card A := by
  have hinj : Function.Injective (fun i : Fin 8 => col (block i)) := by
    intro i j hij
    by_contra hne
    exact eight_labels_of_cell_constant hp hp1 hrnd col hproper hne hij
  simpa using Fintype.card_le_of_injective _ hinj

end BadBand

/-- **The coarse-cell chromatic number of the plane is exactly seven.** At `p = 6/7` —
inside the window `(1/2, 1)` — every colouring constant on the lattice's cells needs at
least seven colours, with NO algebraic hypothesis on the labels, and one with exactly
seven exists. So above half the unit distance the cell-constant family is closed: **any
six-colouring of the plane has colour classes finer than that, in every lattice.** -/
theorem cell_chromatic_eq_seven :
    (∀ {A : Type} [Fintype A] {rnd : ℂ → ℤ × ℤ} (col : (ℤ × ℤ) → A),
        (∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt (6 / 7) (rnd x)) ≤ dist x (latt (6 / 7) v)) →
        (∀ x y : ℂ, dist x y = 1 → col (rnd x) ≠ col (rnd y)) → 7 ≤ Fintype.card A) ∧
      (∃ rnd : ℂ → ℤ × ℤ,
        (∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt (6 / 7) (rnd x)) ≤ dist x (latt (6 / 7) v)) ∧
        (∀ x y : ℂ, dist x y = 1 → ideal7 (rnd x) ≠ ideal7 (rnd y))) :=
  ⟨fun col hrnd hproper =>
    seven_le_card_of_cell_constant (by norm_num) (by norm_num) hrnd col hproper,
   exists_proper_coset_colouring⟩

/-- **The coset chromatic number of the plane is exactly seven.** Every proper
nearest-point coset colouring has at least seven colours, and one with exactly seven
exists. In particular no colouring of this kind can ever witness `χ(ℝ²) ≤ 6`: a
six-colouring of the plane, if one exists at all, is not a lattice colouring. -/
theorem coset_chromatic_eq_seven :
    (∀ {A : Type} [AddCommGroup A] [Fintype A] {p : ℝ} {φ : (ℤ × ℤ) →+ A} {rnd : ℂ → ℤ × ℤ},
        0 < p →
        (∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v)) →
        (∀ x y : ℂ, dist x y = 1 → φ (rnd x) ≠ φ (rnd y)) → 7 ≤ Fintype.card A) ∧
      (∃ rnd : ℂ → ℤ × ℤ,
        (∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt (6 / 7) (rnd x)) ≤ dist x (latt (6 / 7) v)) ∧
        (∀ x y : ℂ, dist x y = 1 → ideal7 (rnd x) ≠ ideal7 (rnd y))) :=
  ⟨fun hp hrnd hproper => seven_le_card hp hrnd hproper, exists_proper_coset_colouring⟩

/-! ### Controls — compiled, every build

Both halves are theorems, so the statement is non-vacuous in both directions; these pin
the arithmetic the proofs run on. -/

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
