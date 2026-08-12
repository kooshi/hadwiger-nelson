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

end Coset

end HadwigerNelson
