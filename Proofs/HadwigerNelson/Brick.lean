import Mathlib.Analysis.Complex.Basic
import Proofs.HadwigerNelson.UnitDistance

/-!
# Periodic brick colourings of the plane, and their finite certificates (M35 L3)

A **brick colouring**: axis-aligned `w × h` half-open rectangular cells in rows, each row
sheared by `s`, coloured by an `m × n` torus table. The colour of `z = (x, y)` is
`table[⌊(x − s·⌊y/h⌋)/w⌋ mod m, ⌊y/h⌋ mod n]` — a doubly periodic colouring of the whole
plane, well-defined everywhere because `Int.floor` is half-open.

The point of the module: **properness and distance-avoidance both reduce to one finite
rational check** (`Brick.check`). Two points in cells at unwrapped offset `(dc, dr)` have
squared distance inside the closed box interval `[lo, hi]` of that offset, so if every
offset within a computed window either has no same-coloured table pair or keeps every
guarded squared distance outside its interval, no two same-coloured points of the PLANE
realize a guarded distance. The window is computed inside `check` from the cell sizes and
the largest guard — soundness carries no window hypothesis. Guards are SQUARED distances
(`q : ℚ`), and a guard list must contain `1` for properness: `Brick.colorable` demands
`(1 : ℚ) ∈ guards` structurally, so a forgotten properness guard is unprovable rather than
silently certified.

**The certificate is boundary-tight, and that is load-bearing** (M36 §0a C1). Cells are
half-open, so the realizable difference vectors at an offset form the OPEN box around
`(s·dr + w·dc, h·dr)` of half-widths `(w, h)`: a realized squared distance is therefore
*strictly* below `hi`, and *strictly* above `lo` whenever `lo > 0`. So the check may accept
an offset whose interval merely TOUCHES a guard — `q ≤ loAt ∨ hiAt ≤ q`, not the strict
separation an earlier version demanded — provided the guard is positive, which `check`
itself now demands (`check_pos`). This is not a convenience: the classical seven-colouring
in this family has cell diagonal exactly `1` (`Instances/Seven.lean`), so under strict
separation NO brick seven-colouring is certifiable at all, and a sweep run against a strict
check reports the whole family as refusing — which is exactly what M35's did.

The relaxed condition is not merely *permitted*, it is *exact*: the open box's image under
`|·|²` is the interval from `loAt` to `hiAt`, so a positive guard strictly inside is
realized by an actual pair of points and no sound certificate could accept it. The strict
version was weaker than the truth; this one is the truth.

The colouring itself is noncomputable (`Int.floor` on `ℝ`); its computable twin
`Brick.colorQ` (same formula over `ℚ`) exists exactly so instances can be `#eval`-tested
against the search that proposed them — the search (`tools/periodic.py`) is trusted for
nothing.

An avoider certified here at `k` colours rules its class out as a pigeonhole AT `k` — for
the 6-hunt only a `k = 5` avoider closes a mechanism (and any such avoider would prove
`χ(ℝ²) ≤ 5` outright); a `k = 6` avoider bounds what SEVEN-forcers can use (M35 §0a C1).
-/

namespace HadwigerNelson

open SimpleGraph

/-! ## Index arithmetic -/

/-- Integer residue into `Fin m`. -/
def zmodIdx (m : ℕ) (hm : 0 < m) (x : ℤ) : Fin m :=
  ⟨(x % (m : ℤ)).toNat, by
    have hne : (m : ℤ) ≠ 0 := by exact_mod_cast hm.ne'
    have h0 : (0 : ℤ) ≤ x % (m : ℤ) := Int.emod_nonneg x hne
    have hlt : x % (m : ℤ) < (m : ℤ) := Int.emod_lt_of_pos x (by exact_mod_cast hm)
    omega⟩

/-- Shifting before or after reduction agrees — the lemma that lets a plane-level colour
equality instantiate the table clash at its offset. -/
theorem zmodIdx_add (m : ℕ) (hm : 0 < m) (x d : ℤ) :
    zmodIdx m hm (x + d) = zmodIdx m hm (((zmodIdx m hm x).1 : ℤ) + d) := by
  have hne : (m : ℤ) ≠ 0 := by exact_mod_cast hm.ne'
  apply Fin.ext
  show ((x + d) % (m : ℤ)).toNat = ((((x % (m : ℤ)).toNat : ℤ) + d) % (m : ℤ)).toNat
  rw [Int.toNat_of_nonneg (Int.emod_nonneg x hne)]
  congr 1
  have he : (m : ℤ) * (x / (m : ℤ)) + x % (m : ℤ) = x := Int.mul_ediv_add_emod x (m : ℤ)
  have hx : x + d = x % (m : ℤ) + d + (m : ℤ) * (x / (m : ℤ)) := by linarith
  rw [hx, Int.add_mul_emod_self_left]

/-! ## The structure and the colouring -/

/-- A brick colouring candidate: an `m × n` torus table of `w × h` cells with row-shear `s`.
Positivity is bundled — every consumer needs it, one `decide` per instance. -/
structure Brick (k : ℕ) where
  /-- Columns per torus period. -/
  m : ℕ
  /-- Rows per torus period. -/
  n : ℕ
  /-- Cell width. -/
  w : ℚ
  /-- Cell (row) height. -/
  h : ℚ
  /-- The horizontal shear applied per row. -/
  s : ℚ
  /-- The colour table on the `m × n` torus. -/
  table : Fin m → Fin n → Fin k
  /-- The torus has columns. -/
  m_pos : 0 < m
  /-- The torus has rows. -/
  n_pos : 0 < n
  /-- Cells have width. -/
  w_pos : 0 < w
  /-- Cells have height. -/
  h_pos : 0 < h

namespace Brick

variable {k : ℕ} (B : Brick k)

/-- The row index of a plane point: which height-`h` band it lies in. -/
noncomputable def row (z : ℂ) : ℤ := ⌊z.im / (B.h : ℝ)⌋

/-- The column index: which width-`w` cell of its (sheared) row. -/
noncomputable def col (z : ℂ) : ℤ := ⌊(z.re - (B.s : ℝ) * B.row z) / (B.w : ℝ)⌋

/-- The brick colouring of the plane. Noncomputable (floors on `ℝ`) — only existence
travels; `colorQ` is the computable twin for testing. -/
noncomputable def color (z : ℂ) : Fin k :=
  B.table (zmodIdx B.m B.m_pos (B.col z)) (zmodIdx B.n B.n_pos (B.row z))

/-! ## The certificate -/

/-- A rational upper bound on `√q`, mirrored exactly by `tools/periodic.py`. Coarse is
fine: it only widens the window. -/
def sqrtUB (q : ℚ) : ℚ := ((Nat.sqrt ⌈q⌉.toNat + 1 : ℕ) : ℚ)

theorem le_sq_sqrtUB {q : ℚ} (hq : 0 ≤ q) : q ≤ sqrtUB q ^ 2 := by
  have h1 : q ≤ (⌈q⌉ : ℚ) := Int.le_ceil q
  have h0 : (0 : ℤ) ≤ ⌈q⌉ := Int.ceil_nonneg hq
  have h3 : (⌈q⌉.toNat : ℕ) < (Nat.sqrt ⌈q⌉.toNat + 1) ^ 2 := by
    simpa [Nat.succ_eq_add_one] using Nat.lt_succ_sqrt' ⌈q⌉.toNat
  calc q ≤ (⌈q⌉ : ℚ) := h1
    _ = ((⌈q⌉.toNat : ℕ) : ℚ) := by exact_mod_cast (Int.toNat_of_nonneg h0).symm
    _ ≤ (((Nat.sqrt ⌈q⌉.toNat + 1) ^ 2 : ℕ) : ℚ) := by exact_mod_cast h3.le
    _ = sqrtUB q ^ 2 := by unfold sqrtUB; push_cast; ring

theorem sqrtUB_nonneg (q : ℚ) : 0 ≤ sqrtUB q := by
  unfold sqrtUB; exact_mod_cast Nat.zero_le _

/-- The largest guard (the `0` seed keeps it nonnegative on any list). -/
def qmax (guards : List ℚ) : ℚ := guards.foldr max 0

theorem le_qmax {guards : List ℚ} {q : ℚ} (hq : q ∈ guards) : q ≤ qmax guards := by
  unfold qmax
  induction guards with
  | nil => cases hq
  | cons a t ih =>
    rcases List.mem_cons.mp hq with h | hmem
    · subst h; exact le_max_left _ _
    · exact le_trans (ih hmem) (le_max_right _ _)

theorem qmax_nonneg (guards : List ℚ) : 0 ≤ qmax guards := by
  unfold qmax
  induction guards with
  | nil => exact le_refl 0
  | cons a t ih => exact le_trans ih (le_max_right _ _)

/-- The row window: `|dr|` never exceeds this for any pair within reach of a guard. -/
def rowBound (guards : List ℚ) : ℕ := ⌈sqrtUB (qmax guards) / B.h⌉.toNat

/-- The column window, with the shear over the whole row window accounted. -/
def colBound (guards : List ℚ) : ℕ :=
  ⌈(sqrtUB (qmax guards) + |B.s| * (B.rowBound guards : ℚ)) / B.w⌉.toNat

/-- The closed box interval's lower end for the offset with centre `(A, Bc)`. -/
def lo (A Bc w h : ℚ) : ℚ := max 0 (|A| - w) ^ 2 + max 0 (|Bc| - h) ^ 2

/-- Its upper end. -/
def hi (A Bc w h : ℚ) : ℚ := (|A| + w) ^ 2 + (|Bc| + h) ^ 2

/-- The shortest squared distance between the cells at index offset `(dc, dr)` —
approached along their facing boundaries and, by half-openness, never attained. -/
def loAt (dc dr : ℤ) : ℚ := lo (B.s * (dr : ℚ) + B.w * (dc : ℚ)) (B.h * (dr : ℚ)) B.w B.h

/-- The longest — likewise approached and never attained. -/
def hiAt (dc dr : ℤ) : ℚ := hi (B.s * (dr : ℚ) + B.w * (dc : ℚ)) (B.h * (dr : ℚ)) B.w B.h

/-- Do two cells at (unwrapped) offset `(dc, dr)` ever share a colour? Decidable table
scan; the same-cell offset `(0, 0)` always clashes, which is what forces the cell diagonal
below every guard. -/
def clash (dc dr : ℤ) : Bool :=
  decide (∃ i : Fin B.m, ∃ j : Fin B.n,
    B.table i j = B.table (zmodIdx B.m B.m_pos ((i.1 : ℤ) + dc))
                          (zmodIdx B.n B.n_pos ((j.1 : ℤ) + dr)))

/-- **The finite certificate.** Every guard is positive, and every offset in the window
either never shares a colour or keeps every guard outside its box interval — *outside* in
the boundary-tight sense the half-open cells license (`q ≤ loAt ∨ hiAt ≤ q`; see the module
docstring). Pure rational arithmetic; the window is computed here, never supplied.

The positivity conjunct is not decoration. A guard of `0` would otherwise be accepted —
`0 ≤ loAt 0 0` holds — and `sound` would then "prove" that a point differs in colour from
itself. Demanding it here rather than at every use makes the degenerate guard
unrepresentable by a passing certificate, and leaves the consumer surface with nothing
extra to discharge. -/
def check (guards : List ℚ) : Bool :=
  guards.all (fun q => decide (0 < q)) &&
  (List.range (2 * B.rowBound guards + 1)).all fun ir =>
    (List.range (2 * B.colBound guards + 1)).all fun ic =>
      let dr : ℤ := (ir : ℤ) - (B.rowBound guards : ℤ)
      let dc : ℤ := (ic : ℤ) - (B.colBound guards : ℤ)
      !B.clash dc dr ||
        guards.all fun q => decide (q ≤ B.loAt dc dr) || decide (B.hiAt dc dr ≤ q)

/-- A certified guard is positive — the invariant `check` parses in, so no consumer
carries it. -/
theorem check_pos {guards : List ℚ} (hchk : B.check guards = true) {q : ℚ}
    (hq : q ∈ guards) : 0 < q := by
  unfold check at hchk
  rw [Bool.and_eq_true] at hchk
  simp only [List.all_eq_true, decide_eq_true_eq] at hchk
  exact hchk.1 q hq

/-- The check unfolded at one in-window offset — the sole `Bool → Prop` bridge. -/
theorem check_spec {guards : List ℚ} (hchk : B.check guards = true)
    {dc dr : ℤ} (hdr : dr.natAbs ≤ B.rowBound guards) (hdc : dc.natAbs ≤ B.colBound guards)
    (hcl : B.clash dc dr = true) {q : ℚ} (hq : q ∈ guards) :
    q ≤ B.loAt dc dr ∨ B.hiAt dc dr ≤ q := by
  unfold check at hchk
  rw [Bool.and_eq_true] at hchk
  replace hchk := hchk.2
  simp only [List.all_eq_true, List.mem_range, Bool.or_eq_true, Bool.not_eq_true',
    decide_eq_true_eq] at hchk
  have hir : ((dr + B.rowBound guards).toNat) < 2 * B.rowBound guards + 1 := by omega
  have hic : ((dc + B.colBound guards).toNat) < 2 * B.colBound guards + 1 := by omega
  have h := hchk _ hir _ hic
  have hdr' : (((dr + B.rowBound guards).toNat : ℤ)) - (B.rowBound guards : ℤ) = dr := by
    omega
  have hdc' : (((dc + B.colBound guards).toNat : ℤ)) - (B.colBound guards : ℤ) = dc := by
    omega
  rw [hdr', hdc'] at h
  rcases h with hno | hall
  · exact absurd hcl (by simp [hno])
  · exact hall q hq

/-! ## The analytic workhorses -/

/-- Floors of nearby reals are nearby integers. -/
theorem abs_floor_sub_floor_le {a b c : ℝ} (h : |a - b| ≤ c) : |⌊a⌋ - ⌊b⌋| ≤ ⌈c⌉ := by
  rw [abs_le] at h
  rw [abs_le]
  have hfa := Int.floor_le a
  have hfb := Int.floor_le b
  have hfa' := Int.sub_one_lt_floor a
  have hfb' := Int.sub_one_lt_floor b
  have hc := Int.le_ceil c
  constructor
  · have hcast : ((⌊b⌋ - ⌊a⌋ : ℤ) : ℝ) < ((⌈c⌉ + 1 : ℤ) : ℝ) := by push_cast; linarith
    have := Int.lt_add_one_iff.mp (by exact_mod_cast hcast)
    omega
  · have hcast : ((⌊a⌋ - ⌊b⌋ : ℤ) : ℝ) < ((⌈c⌉ + 1 : ℤ) : ℝ) := by push_cast; linarith
    exact Int.lt_add_one_iff.mp (by exact_mod_cast hcast)

/-- The half-open box: a point sits within `[0, w)` of its cell's left edge. -/
theorem box_mem {x w : ℝ} (hw : 0 < w) : 0 ≤ x - w * ⌊x / w⌋ ∧ x - w * ⌊x / w⌋ < w := by
  have h1 : w * ((⌊x / w⌋ : ℤ) : ℝ) ≤ w * (x / w) :=
    mul_le_mul_of_nonneg_left (Int.floor_le (x / w)) hw.le
  have h2 : w * (x / w) < w * (((⌊x / w⌋ : ℤ) : ℝ) + 1) :=
    mul_lt_mul_of_pos_left (Int.lt_floor_add_one (x / w)) hw
  have h3 : w * (x / w) = x := by field_simp
  constructor <;> nlinarith

/-! ### The open box — where boundary-tightness comes from

A coordinate offset is `X + e` with `|e| < width` STRICTLY (the cell is half-open, so the
two internal offsets differ by strictly less than the cell's extent). These three lemmas
are the whole content of that strictness: the square lands strictly below the box's upper
end, and strictly above its lower end whenever that end is positive. -/

/-- Strictly below the upper end. -/
theorem sq_lt_of_abs_lt {X width t e : ℝ} (ht : t = X + e) (he : |e| < width) :
    t ^ 2 < (|X| + width) ^ 2 := by
  have h1 : |t| < |X| + width := by
    rw [ht]
    calc |X + e| ≤ |X| + |e| := abs_add_le _ _
      _ < |X| + width := by linarith
  calc t ^ 2 = |t| ^ 2 := (sq_abs t).symm
    _ < (|X| + width) ^ 2 := pow_lt_pow_left₀ h1 (abs_nonneg t) two_ne_zero

/-- Strictly above the lower end, when that end is positive. Stated through the same `max`
the interval is built from, so the assembly needs no rewriting between the two forms. -/
theorem lt_sq_of_abs_lt {X width t e : ℝ} (ht : t = X + e) (he : |e| < width)
    (hX : 0 < max 0 (|X| - width)) : max 0 (|X| - width) ^ 2 < t ^ 2 := by
  have hpos : 0 < |X| - width := by
    rcases lt_max_iff.mp hX with h | h
    · exact absurd h (lt_irrefl 0)
    · exact h
  rw [max_eq_right hpos.le]
  have h2 : |X| ≤ |t| + |e| := by
    calc |X| = |t + -e| := by rw [ht]; ring_nf
      _ ≤ |t| + |-e| := abs_add_le _ _
      _ = |t| + |e| := by rw [abs_neg]
  calc (|X| - width) ^ 2 < |t| ^ 2 :=
        pow_lt_pow_left₀ (by linarith) hpos.le two_ne_zero
    _ = t ^ 2 := sq_abs t

/-- Weakly above the lower end, always — including the branch where the box straddles its
axis and the lower end is `0`. -/
theorem le_sq_of_abs_lt {X width t e : ℝ} (ht : t = X + e) (he : |e| < width) :
    max 0 (|X| - width) ^ 2 ≤ t ^ 2 := by
  rcases (le_max_left 0 (|X| - width)).lt_or_eq with h | h
  · exact (lt_sq_of_abs_lt ht he h).le
  · rw [← h]; simpa using sq_nonneg t

/-! ## Soundness -/

/-- **The soundness theorem.** A passing certificate excludes every guarded squared
distance between same-coloured points — over the whole plane.

The check's lower branch (`q ≤ loAt`) is sound because a realized squared distance strictly
exceeds a positive `loAt`, and the guard's positivity — carried by the certificate itself,
`check_pos` — is exactly what forces `loAt > 0` in that branch. -/
theorem sound {guards : List ℚ} (hchk : B.check guards = true)
    {q : ℚ} (hq : q ∈ guards) {z z' : ℂ}
    (hd : dist z z' ^ 2 = (q : ℝ)) : B.color z ≠ B.color z' := by
  intro hcol
  have hq0 : 0 < q := B.check_pos hchk hq
  have hw : (0 : ℝ) < (B.w : ℝ) := by exact_mod_cast B.w_pos
  have hh : (0 : ℝ) < (B.h : ℝ) := by exact_mod_cast B.h_pos
  have hd2 : (z.re - z'.re) ^ 2 + (z.im - z'.im) ^ 2 = (q : ℝ) := by
    rw [← hd, Complex.dist_eq_re_im, Real.sq_sqrt (by positivity)]
  have hQle : (q : ℝ) ≤ ((sqrtUB (qmax guards) : ℚ) : ℝ) ^ 2 := by
    have := le_trans (le_qmax hq) (le_sq_sqrtUB (qmax_nonneg guards))
    exact_mod_cast this
  have hQ0 : (0 : ℝ) ≤ ((sqrtUB (qmax guards) : ℚ) : ℝ) := by
    exact_mod_cast sqrtUB_nonneg _
  have hQR : ∀ t : ℝ, t ^ 2 ≤ (q : ℝ) → |t| ≤ ((sqrtUB (qmax guards) : ℚ) : ℝ) := by
    intro t ht
    rw [abs_le]
    constructor <;> nlinarith
  have him : |z'.im - z.im| ≤ ((sqrtUB (qmax guards) : ℚ) : ℝ) :=
    hQR _ (by nlinarith [sq_nonneg (z.re - z'.re)])
  have hre : |z'.re - z.re| ≤ ((sqrtUB (qmax guards) : ℚ) : ℝ) :=
    hQR _ (by nlinarith [sq_nonneg (z.im - z'.im)])
  -- the row and column offsets land inside the window
  set dr : ℤ := B.row z' - B.row z with hdrdef
  set dc : ℤ := B.col z' - B.col z with hdcdef
  have hdrb : dr.natAbs ≤ B.rowBound guards := by
    have harg : |z'.im / (B.h : ℝ) - z.im / (B.h : ℝ)| ≤
        ((sqrtUB (qmax guards) / B.h : ℚ) : ℝ) := by
      rw [div_sub_div_same, abs_div, abs_of_pos hh]
      push_cast
      gcongr
    have hfl : |B.row z' - B.row z| ≤ ⌈((sqrtUB (qmax guards) / B.h : ℚ) : ℝ)⌉ :=
      abs_floor_sub_floor_le harg
    have hceil : (⌈((sqrtUB (qmax guards) / B.h : ℚ) : ℝ)⌉ : ℤ) =
        ⌈(sqrtUB (qmax guards) / B.h : ℚ)⌉ := Rat.ceil_cast _
    rw [hceil, ← hdrdef] at hfl
    have h1 : (dr.natAbs : ℤ) ≤ ⌈(sqrtUB (qmax guards) / B.h : ℚ)⌉ := by
      rw [Int.natCast_natAbs]; exact hfl
    unfold rowBound
    omega
  have hdrR : |(dr : ℝ)| ≤ ((B.rowBound guards : ℕ) : ℝ) := by
    rw [← Int.cast_abs, Int.abs_eq_natAbs]
    exact_mod_cast hdrb
  have hdcb : dc.natAbs ≤ B.colBound guards := by
    have harg : |(z'.re - (B.s : ℝ) * B.row z') / (B.w : ℝ) -
        (z.re - (B.s : ℝ) * B.row z) / (B.w : ℝ)| ≤
        (((sqrtUB (qmax guards) + |B.s| * (B.rowBound guards : ℚ)) / B.w : ℚ) : ℝ) := by
      rw [div_sub_div_same, abs_div, abs_of_pos hw]
      push_cast
      gcongr
      have expand : z'.re - (B.s : ℝ) * B.row z' - (z.re - (B.s : ℝ) * B.row z) =
          (z'.re - z.re) - (B.s : ℝ) * ((dr : ℤ) : ℝ) := by
        rw [hdrdef]; push_cast; ring
      rw [expand]
      calc |(z'.re - z.re) - (B.s : ℝ) * ((dr : ℤ) : ℝ)|
          ≤ |z'.re - z.re| + |(B.s : ℝ) * ((dr : ℤ) : ℝ)| := by
            rw [sub_eq_add_neg]
            exact (abs_add_le _ _).trans (by rw [abs_neg])
        _ ≤ ((sqrtUB (qmax guards) : ℚ) : ℝ) + |(B.s : ℝ)| * ((B.rowBound guards : ℕ) : ℝ) := by
            refine add_le_add hre ?_
            rw [abs_mul]
            exact mul_le_mul_of_nonneg_left hdrR (abs_nonneg _)
        _ = _ := by ring
    have hfl : |B.col z' - B.col z| ≤
        ⌈(((sqrtUB (qmax guards) + |B.s| * (B.rowBound guards : ℚ)) / B.w : ℚ) : ℝ)⌉ :=
      abs_floor_sub_floor_le harg
    have hceil : (⌈(((sqrtUB (qmax guards) + |B.s| * (B.rowBound guards : ℚ)) / B.w : ℚ) :
        ℝ)⌉ : ℤ) = ⌈((sqrtUB (qmax guards) + |B.s| * (B.rowBound guards : ℚ)) / B.w : ℚ)⌉ :=
      Rat.ceil_cast _
    rw [hceil, ← hdcdef] at hfl
    have h1 : (dc.natAbs : ℤ) ≤
        ⌈((sqrtUB (qmax guards) + |B.s| * (B.rowBound guards : ℚ)) / B.w : ℚ)⌉ := by
      rw [Int.natCast_natAbs]; exact hfl
    unfold colBound
    omega
  -- the boxes: each coordinate sits within its half-open cell
  have hv : 0 ≤ z.im - (B.h : ℝ) * B.row z ∧ z.im - (B.h : ℝ) * B.row z < (B.h : ℝ) :=
    box_mem hh
  have hv' : 0 ≤ z'.im - (B.h : ℝ) * B.row z' ∧ z'.im - (B.h : ℝ) * B.row z' < (B.h : ℝ) :=
    box_mem hh
  have hu : 0 ≤ (z.re - (B.s : ℝ) * B.row z) - (B.w : ℝ) * B.col z ∧
      (z.re - (B.s : ℝ) * B.row z) - (B.w : ℝ) * B.col z < (B.w : ℝ) := box_mem hw
  have hu' : 0 ≤ (z'.re - (B.s : ℝ) * B.row z') - (B.w : ℝ) * B.col z' ∧
      (z'.re - (B.s : ℝ) * B.row z') - (B.w : ℝ) * B.col z' < (B.w : ℝ) := box_mem hw
  -- the offset decomposition, and the internal offsets bounded STRICTLY: this is the
  -- half-open cell speaking, and it is the whole of the milestone's mathematics
  set ere : ℝ := ((z'.re - (B.s : ℝ) * B.row z') - (B.w : ℝ) * B.col z') -
      ((z.re - (B.s : ℝ) * B.row z) - (B.w : ℝ) * B.col z) with hereDef
  set eim : ℝ := (z'.im - (B.h : ℝ) * B.row z') - (z.im - (B.h : ℝ) * B.row z) with heimDef
  set A : ℚ := B.s * (dr : ℚ) + B.w * (dc : ℚ) with hADef
  set Bc : ℚ := B.h * (dr : ℚ) with hBcDef
  have hdre : z'.re - z.re = ((A : ℚ) : ℝ) + ere := by
    rw [hereDef, hADef, hdrdef, hdcdef]; push_cast; ring
  have hdim : z'.im - z.im = ((Bc : ℚ) : ℝ) + eim := by
    rw [heimDef, hBcDef, hdrdef]; push_cast; ring
  have hbre : |ere| < (B.w : ℝ) := by
    rw [hereDef, abs_lt]
    constructor <;> [linarith [hu.1, hu'.2]; linarith [hu'.1, hu.2]]
  have hbim : |eim| < (B.h : ℝ) := by
    rw [heimDef, abs_lt]
    constructor <;> [linarith [hv.1, hv'.2]; linarith [hv'.1, hv.2]]
  have hq2 : (z'.re - z.re) ^ 2 + (z'.im - z.im) ^ 2 = (q : ℝ) := by rw [← hd2]; ring
  -- strictly inside the box interval, both ends
  have hqlt : q < B.hiAt dc dr := by
    have hcast : ((B.hiAt dc dr : ℚ) : ℝ) =
        (|((A : ℚ) : ℝ)| + (B.w : ℝ)) ^ 2 + (|((Bc : ℚ) : ℝ)| + (B.h : ℝ)) ^ 2 := by
      rw [hiAt, hi, hADef, hBcDef]; push_cast; ring
    have h : ((q : ℚ) : ℝ) < ((B.hiAt dc dr : ℚ) : ℝ) := by
      rw [hcast, ← hq2]
      exact add_lt_add (sq_lt_of_abs_lt hdre hbre) (sq_lt_of_abs_lt hdim hbim)
    exact_mod_cast h
  have hqgt : 0 < B.loAt dc dr → B.loAt dc dr < q := by
    intro hlopos
    have hcast : ((B.loAt dc dr : ℚ) : ℝ) =
        max 0 (|((A : ℚ) : ℝ)| - (B.w : ℝ)) ^ 2 +
        max 0 (|((Bc : ℚ) : ℝ)| - (B.h : ℝ)) ^ 2 := by
      rw [loAt, lo, hADef, hBcDef]; push_cast; ring
    have hposR : (0 : ℝ) < max 0 (|((A : ℚ) : ℝ)| - (B.w : ℝ)) ^ 2 +
        max 0 (|((Bc : ℚ) : ℝ)| - (B.h : ℝ)) ^ 2 := by
      rw [← hcast]; exact_mod_cast hlopos
    have h : ((B.loAt dc dr : ℚ) : ℝ) < ((q : ℚ) : ℝ) := by
      rw [hcast, ← hq2]
      rcases (le_max_left (0 : ℝ) (|((A : ℚ) : ℝ)| - (B.w : ℝ))).lt_or_eq with hx | hx
      · exact add_lt_add_of_lt_of_le (lt_sq_of_abs_lt hdre hbre hx)
          (le_sq_of_abs_lt hdim hbim)
      · have hy : 0 < max 0 (|((Bc : ℚ) : ℝ)| - (B.h : ℝ)) := by
          rcases (le_max_left (0 : ℝ) (|((Bc : ℚ) : ℝ)| - (B.h : ℝ))).lt_or_eq with hy | hy
          · exact hy
          · rw [← hx, ← hy] at hposR; simp at hposR
        exact add_lt_add_of_le_of_lt (le_sq_of_abs_lt hdre hbre)
          (lt_sq_of_abs_lt hdim hbim hy)
    exact_mod_cast h
  -- the colour equality instantiates the clash at (dc, dr)
  have hclash : B.clash dc dr = true := by
    apply decide_eq_true
    refine ⟨zmodIdx B.m B.m_pos (B.col z), zmodIdx B.n B.n_pos (B.row z), ?_⟩
    rw [← zmodIdx_add, ← zmodIdx_add]
    rw [show B.col z + dc = B.col z' from by rw [hdcdef]; ring,
        show B.row z + dr = B.row z' from by rw [hdrdef]; ring]
    exact hcol
  -- and the check refuses
  rcases B.check_spec hchk hdrb hdcb hclash hq with hle | hge
  · exact absurd (hqgt (lt_of_lt_of_le hq0 hle)) (not_lt.mpr hle)
  · exact absurd hqlt (not_lt.mpr hge)

/-! ## The consumer surface -/

/-- **A passing certificate is a proper colouring of the plane** — the guard list must
carry `1` (properness is the `q = 1` instance), structurally: forget it and this theorem
is unprovable. -/
theorem colorable {guards : List ℚ} (h1 : (1 : ℚ) ∈ guards)
    (hchk : B.check guards = true) : (unitDistance ℂ).Colorable k :=
  ⟨Coloring.mk B.color fun hadj =>
    B.sound hchk h1 (by rw [unitDistance_adj.mp hadj]; norm_num)⟩

/-- **A passing certificate avoids every guarded distance**: same-coloured points are never
at distance `√q` for any listed guard. An avoider at `k` colours rules its class out as a
pigeonhole AT `k`; for the 6-hunt only `k = 5` closes a mechanism, and any `k = 5` avoider
would prove `χ(ℝ²) ≤ 5` outright — a `k = 6` avoider bounds SEVEN-forcers (M35 §0a C1).

The guard's nonnegativity is not a hypothesis: a certified guard is positive by
`check_pos`, so a caller supplies only membership. -/
theorem avoids {guards : List ℚ} {q : ℚ} (hq : q ∈ guards)
    (hchk : B.check guards = true) {z z' : ℂ}
    (hd : dist z z' = Real.sqrt (q : ℝ)) : B.color z ≠ B.color z' :=
  B.sound hchk hq
    (by rw [hd, Real.sq_sqrt (by exact_mod_cast (B.check_pos hchk hq).le)])

/-! ## The computable twin — the definition's test instrument -/

/-- `color` over `ℚ` coordinates, computable (`Rat.floor`). Exists so instances can be
`#eval`-tested against the search that proposed them; `colorQ_eq` pins the agreement. -/
def colorQ (x y : ℚ) : Fin k :=
  B.table (zmodIdx B.m B.m_pos ⌊(x - B.s * (⌊y / B.h⌋ : ℤ)) / B.w⌋)
          (zmodIdx B.n B.n_pos ⌊y / B.h⌋)

/-- The twin agrees with the plane colouring at every rational point. -/
theorem colorQ_eq (x y : ℚ) :
    B.colorQ x y = B.color ⟨(x : ℝ), (y : ℝ)⟩ := by
  have hr : B.row ⟨(x : ℝ), (y : ℝ)⟩ = ⌊y / B.h⌋ := by
    show ⌊((y : ℚ) : ℝ) / ((B.h : ℚ) : ℝ)⌋ = ⌊y / B.h⌋
    rw [← Rat.cast_div, Rat.floor_cast]
  have hc : B.col ⟨(x : ℝ), (y : ℝ)⟩ = ⌊(x - B.s * (⌊y / B.h⌋ : ℤ)) / B.w⌋ := by
    unfold col
    rw [hr]
    show ⌊(((x : ℚ) : ℝ) - ((B.s : ℚ) : ℝ) * ((⌊y / B.h⌋ : ℤ) : ℝ)) / ((B.w : ℚ) : ℝ)⌋ = _
    rw [show (((x : ℚ) : ℝ) - ((B.s : ℚ) : ℝ) * ((⌊y / B.h⌋ : ℤ) : ℝ)) / ((B.w : ℚ) : ℝ) =
        (((x - B.s * (⌊y / B.h⌋ : ℤ)) / B.w : ℚ) : ℝ) from by push_cast; ring,
      Rat.floor_cast]
  unfold colorQ color
  rw [hr, hc]

end Brick

end HadwigerNelson
