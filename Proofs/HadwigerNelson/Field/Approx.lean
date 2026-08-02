import Proofs.HadwigerNelson.Field.Quadratic

/-! # Integer interval bounds for `Q4.eval` — exact field values compared as reals

`Q4.eval` is deliberately not known injective (`Field/Quadratic.lean` makes never needing
injectivity a design point), yet M16's headline quantifies over **real** distances: two `Q4`-distinct
squared distances that secretly evaluated to the same real would merge two distance classes, and a
certificate separating each part with different colourings would not separate the union.

This module is the repair, and it is an *instrument*, not a theory: interval arithmetic sound for
`Q4.eval` on **literals**, from bounds on the four generators whose correctness is the decidable
integer fact `l² ≤ d·s² ≤ h²`. Distinctness of any concrete family of values is then the kernel
checking that their intervals are pairwise disjoint — no linear independence of radicals, no
irrationality, nothing about `eval` beyond its `RingHom` API.

## The carrier, measured

Endpoints are **integers over an ambient denominator** (`Ival.Mem I s x` reads `lo ≤ x·s ≤ hi`),
not rationals. Measured at M16 scale — 1,340 approximations through 2⁴⁰-denominator bounds — the
ℚ version costs **107 s per pivot**, all of it `Rat` normalization through the kernel-unaccelerated
`Nat.gcd` (M02's finding, paid again); the integer form is pure GMP-backed `Int` arithmetic. The
scale rides in the `Mem` *relation* as an argument, never in the type: `ofInt` speaks at scale 1,
`add` at a shared scale, `mul` multiplies scales, and the four-level tower comes out at `scale⁴`
with no division and no rounding anywhere.

The consumer shape is `sepChain`: a list of `Q4` values the emitter claims is sorted by real value,
checked by adjacent-interval disjointness, yielding pairwise-distinct evaluations. Precision is the
emitter's problem — it picks the scale and the generator bounds, and the kernel only ever says yes
or no.
-/

namespace HadwigerNelson

/-- A closed interval with integer endpoints, read against an ambient denominator supplied by
`Mem`: the certificate's claim about where a real value lies.

`lo ≤ hi` is *not* an invariant: an inverted interval has no members, every `Mem` fact about it is
false, and `sepChain` on data containing one simply fails — fail-loud totality with no smart
constructor to maintain. -/
structure Ival where
  /-- Lower endpoint, a numerator over the ambient denominator. -/
  lo : ℤ
  /-- Upper endpoint, a numerator over the ambient denominator. -/
  hi : ℤ
  deriving Repr, DecidableEq

namespace Ival

/-- `I` brackets the real `x` at denominator `s`: `lo ≤ x·s ≤ hi`. -/
def Mem (I : Ival) (s : ℕ) (x : ℝ) : Prop := (I.lo : ℝ) ≤ x * s ∧ x * s ≤ (I.hi : ℝ)

/-- The exact interval of an integer, at denominator 1. -/
def ofInt (m : ℤ) : Ival := ⟨m, m⟩

/-- Rescale to a larger denominator: multiply both endpoints by `c`. -/
def scaleUp (I : Ival) (c : ℕ) : Ival := ⟨I.lo * c, I.hi * c⟩

/-- Endpoint-wise sum — denominators must already agree; `Mem.add` says so. -/
def add (I J : Ival) : Ival := ⟨I.lo + J.lo, I.hi + J.hi⟩

/-- Product: the four endpoint products bracket every product of members, whatever the signs.
Denominators multiply. -/
def mul (I J : Ival) : Ival :=
  ⟨min (min (I.lo * J.lo) (I.lo * J.hi)) (min (I.hi * J.lo) (I.hi * J.hi)),
   max (max (I.lo * J.lo) (I.lo * J.hi)) (max (I.hi * J.lo) (I.hi * J.hi))⟩

/-- An integer is in its own exact interval at denominator 1. -/
theorem mem_ofInt (m : ℤ) : (ofInt m).Mem 1 (m : ℝ) := by
  simp [Mem, ofInt]

/-- Rescaling is sound: same real, denominator multiplied by `c`. -/
theorem Mem.scaleUp {I : Ival} {s : ℕ} {x : ℝ} (h : I.Mem s x) (c : ℕ) :
    (I.scaleUp c).Mem (s * c) x := by
  obtain ⟨h1, h2⟩ := h
  have hc : (0 : ℝ) ≤ (c : ℕ) := Nat.cast_nonneg c
  constructor
  · calc ((I.lo * c : ℤ) : ℝ) = (I.lo : ℝ) * c := by push_cast; ring
      _ ≤ x * s * c := mul_le_mul_of_nonneg_right h1 hc
      _ = x * (s * c : ℕ) := by push_cast; ring
  · calc x * ((s * c : ℕ) : ℝ) = x * s * c := by push_cast; ring
      _ ≤ (I.hi : ℝ) * c := mul_le_mul_of_nonneg_right h2 hc
      _ = ((I.hi * c : ℤ) : ℝ) := by push_cast; ring

/-- Interval addition is sound at a shared denominator. -/
theorem Mem.add {I J : Ival} {s : ℕ} {x y : ℝ} (hx : I.Mem s x) (hy : J.Mem s y) :
    (I.add J).Mem s (x + y) := by
  obtain ⟨hx1, hx2⟩ := hx
  obtain ⟨hy1, hy2⟩ := hy
  constructor
  · calc ((I.lo + J.lo : ℤ) : ℝ) = (I.lo : ℝ) + J.lo := by push_cast; ring
      _ ≤ x * s + y * s := add_le_add hx1 hy1
      _ = (x + y) * s := by ring
  · calc (x + y) * (s : ℝ) = x * s + y * s := by ring
      _ ≤ (I.hi : ℝ) + J.hi := add_le_add hx2 hy2
      _ = ((I.hi + J.hi : ℤ) : ℝ) := by push_cast; ring

/-- The corner bash over ℝ, once: a product of bracketed values is bracketed by the four corner
products. A bilinear function on a rectangle attains its extrema at the corners; Mathlib was
grepped for an `Icc`-product lemma to cite and has none in this shape. -/
private theorem corner_bounds {a b A B C D : ℝ} (hA : A ≤ a) (hB : a ≤ B) (hC : C ≤ b)
    (hD : b ≤ D) :
    min (min (A * C) (A * D)) (min (B * C) (B * D)) ≤ a * b ∧
      a * b ≤ max (max (A * C) (A * D)) (max (B * C) (B * D)) := by
  constructor
  · rcases le_total 0 b with hb | hb
    · rcases le_total 0 A with hA0 | hA0
      · exact ((min_le_left _ _).trans (min_le_left _ _)).trans
          ((mul_le_mul_of_nonneg_left hC hA0).trans (mul_le_mul_of_nonneg_right hA hb))
      · exact ((min_le_left _ _).trans (min_le_right _ _)).trans
          ((mul_le_mul_of_nonpos_left hD hA0).trans (mul_le_mul_of_nonneg_right hA hb))
    · rcases le_total 0 B with hB0 | hB0
      · exact ((min_le_right _ _).trans (min_le_left _ _)).trans
          ((mul_le_mul_of_nonneg_left hC hB0).trans (mul_le_mul_of_nonpos_right hB hb))
      · exact ((min_le_right _ _).trans (min_le_right _ _)).trans
          ((mul_le_mul_of_nonpos_left hD hB0).trans (mul_le_mul_of_nonpos_right hB hb))
  · rcases le_total 0 b with hb | hb
    · rcases le_total 0 B with hB0 | hB0
      · exact ((mul_le_mul_of_nonneg_right hB hb).trans
          (mul_le_mul_of_nonneg_left hD hB0)).trans ((le_max_right _ _).trans (le_max_right _ _))
      · exact ((mul_le_mul_of_nonneg_right hB hb).trans
          (mul_le_mul_of_nonpos_left hC hB0)).trans ((le_max_left _ _).trans (le_max_right _ _))
    · rcases le_total 0 A with hA0 | hA0
      · exact ((mul_le_mul_of_nonpos_right hA hb).trans
          (mul_le_mul_of_nonneg_left hD hA0)).trans ((le_max_right _ _).trans (le_max_left _ _))
      · exact ((mul_le_mul_of_nonpos_right hA hb).trans
          (mul_le_mul_of_nonpos_left hC hA0)).trans ((le_max_left _ _).trans (le_max_left _ _))

/-- Interval multiplication is sound — a bilinear function on a rectangle attains its extrema at
the corners — and the denominators multiply. -/
theorem Mem.mul {I J : Ival} {s t : ℕ} {x y : ℝ} (hx : I.Mem s x) (hy : J.Mem t y) :
    (I.mul J).Mem (s * t) (x * y) := by
  have h := corner_bounds hx.1 hx.2 hy.1 hy.2
  have hxy : x * s * (y * t) = x * y * ((s * t : ℕ) : ℝ) := by push_cast; ring
  constructor
  · calc ((Ival.mul I J).lo : ℝ)
        = min (min ((I.lo : ℝ) * J.lo) ((I.lo : ℝ) * J.hi))
            (min ((I.hi : ℝ) * J.lo) ((I.hi : ℝ) * J.hi)) := by
          simp only [Ival.mul]; push_cast [Int.cast_min, Int.cast_max]; rfl
      _ ≤ x * s * (y * t) := h.1
      _ = x * y * ((s * t : ℕ) : ℝ) := hxy
  · calc x * y * ((s * t : ℕ) : ℝ) = x * s * (y * t) := hxy.symm
      _ ≤ max (max ((I.lo : ℝ) * J.lo) ((I.lo : ℝ) * J.hi))
            (max ((I.hi : ℝ) * J.lo) ((I.hi : ℝ) * J.hi)) := h.2
      _ = ((Ival.mul I J).hi : ℝ) := by
          simp only [Ival.mul]; push_cast [Int.cast_min, Int.cast_max]; rfl

end Ival

/-- **`l/s ≤ √d ≤ h/s`, as the kernel can check it**: both endpoints nonnegative, `l² ≤ d·s²`,
`d·s² ≤ h²`. -/
def sqrtOk (d : ℕ) (I : Ival) (s : ℕ) : Bool :=
  decide (0 ≤ I.lo) && decide (0 ≤ I.hi) &&
  decide (I.lo * I.lo ≤ (d : ℤ) * s * s) && decide ((d : ℤ) * s * s ≤ I.hi * I.hi)

/-- A checked square-root bound brackets the square root. -/
theorem mem_sqrt {d : ℕ} {I : Ival} {s : ℕ} (h : sqrtOk d I s = true) :
    I.Mem s (Real.sqrt d) := by
  simp only [sqrtOk, Bool.and_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨⟨hlo, hhi⟩, hlosq⟩, hhisq⟩ := h
  have hds : Real.sqrt d * s = Real.sqrt ((d : ℝ) * s ^ 2) := by
    rw [Real.sqrt_mul' _ (by positivity : (0 : ℝ) ≤ ((s : ℕ) : ℝ) ^ 2),
      Real.sqrt_sq (Nat.cast_nonneg s)]
  have hlosq' : ((I.lo : ℝ)) * I.lo ≤ (d : ℝ) * s * s := by exact_mod_cast hlosq
  have hhisq' : ((d : ℝ)) * s * s ≤ (I.hi : ℝ) * I.hi := by exact_mod_cast hhisq
  constructor
  · rw [hds]
    refine (Real.le_sqrt (by exact_mod_cast hlo) (by positivity)).mpr ?_
    nlinarith [hlosq']
  · rw [hds]
    refine Real.sqrt_le_iff.mpr ⟨by exact_mod_cast hhi, ?_⟩
    nlinarith [hhisq']

/-- One integer interval per generator of `ℚ(√3,√5,√7,√11)`, all over one `scale`. Emitter-chosen
data; `Ok` below is the only thing believed about it, and precision is a tuning parameter the
theorems hold for every value of. -/
structure SqrtBounds where
  /-- The shared denominator of the four bounds. -/
  scale : ℕ
  /-- Interval for `√3`, over `scale`. -/
  s3 : Ival
  /-- Interval for `√5`, over `scale`. -/
  s5 : Ival
  /-- Interval for `√7`, over `scale`. -/
  s7 : Ival
  /-- Interval for `√11`, over `scale`. -/
  s11 : Ival
  deriving Repr, DecidableEq

/-- All four bounds check at the shared denominator. -/
def SqrtBounds.Ok (B : SqrtBounds) : Bool :=
  sqrtOk 3 B.s3 B.scale && sqrtOk 5 B.s5 B.scale &&
  sqrtOk 7 B.s7 B.scale && sqrtOk 11 B.s11 B.scale

/-- One tower level of interval evaluation, mirroring `Adjoin.eval`:
`⟨a, b⟩ ↦ (f a)·s + (f b) · I_d`, where `I_d` brackets `√d` at denominator `s` — so one level
multiplies the ambient denominator by `s`. -/
def Adjoin.approx {K : Type*} {d : ℕ} (f : K → Ival) (Id : Ival) (s : ℕ) (x : Adjoin d K) :
    Ival :=
  ((f x.re).scaleUp s).add ((f x.im).mul Id)

/-- `Adjoin.eval` on a pair, as its definition computes it. Stated once so no proof below unfolds
the sealed `eval` at its use sites; this module owns the interval mirror of that computation. -/
private theorem eval_mk {K : Type*} [CommRing K] [NatScalar K] {d : ℕ} (evalBase : K →+* ℝ)
    (r : ℝ) (hr : r ^ 2 = (d : ℝ)) (x : Adjoin d K) :
    Adjoin.eval evalBase r hr x = evalBase x.re + evalBase x.im * r := rfl

/-- One tower level is sound: if `f` brackets `evalBase` at denominator `t` and `Id` brackets `r`
at denominator `s`, the level brackets `Adjoin.eval evalBase r hr` at denominator `t·s`. -/
theorem Adjoin.mem_approx {K : Type*} [CommRing K] [NatScalar K] {d : ℕ} {evalBase : K →+* ℝ}
    {r : ℝ} {hr : r ^ 2 = (d : ℝ)} {f : K → Ival} {t : ℕ}
    (hf : ∀ y : K, (f y).Mem t (evalBase y)) {Id : Ival} {s : ℕ} (hd : Id.Mem s r)
    (x : Adjoin d K) : (Adjoin.approx f Id s x).Mem (t * s) (Adjoin.eval evalBase r hr x) := by
  rw [eval_mk]
  exact ((hf x.re).scaleUp s).add ((hf x.im).mul hd)

/-- Interval evaluation of a `Q4` literal — the four levels of `Q4.eval` mirrored, each level
multiplying the denominator by `B.scale`, landing at `B.scale⁴`. -/
def Q4.approx (B : SqrtBounds) : Q4 → Ival :=
  Adjoin.approx (Adjoin.approx (Adjoin.approx (Adjoin.approx
    Ival.ofInt B.s3 B.scale) B.s5 B.scale) B.s7 B.scale) B.s11 B.scale

/-- **The instrument's soundness**: checked bounds make `Q4.approx` bracket `Q4.eval` at
denominator `B.scale⁴`. -/
theorem Q4.mem_approx {B : SqrtBounds} (hB : B.Ok = true) (x : Q4) :
    (Q4.approx B x).Mem (B.scale ^ 4) (Q4.eval x) := by
  simp only [SqrtBounds.Ok, Bool.and_eq_true] at hB
  obtain ⟨⟨⟨h3, h5⟩, h7⟩, h11⟩ := hB
  have hbase : ∀ y : ℤ, (Ival.ofInt y).Mem 1 ((Int.castRingHom ℝ) y) := fun y =>
    Ival.mem_ofInt y
  have hs : 1 * B.scale * B.scale * B.scale * B.scale = B.scale ^ 4 := by ring
  rw [← hs]
  exact Adjoin.mem_approx
    (fun y => Adjoin.mem_approx
      (fun y => Adjoin.mem_approx
        (fun y => Adjoin.mem_approx hbase (mem_sqrt h3) y)
        (mem_sqrt h5) y)
      (mem_sqrt h7) y)
    (mem_sqrt h11) x

/-- Adjacent intervals are strictly disjoint, in order. -/
def sepIvals : List Ival → Bool
  | [] => true
  | [_] => true
  | a :: b :: t => decide (a.hi < b.lo) && sepIvals (b :: t)

/-- **The separation check**: the values' intervals, in the order given, are pairwise disjoint —
so the emitter's claim "sorted by real value, all distinct" is verified rather than believed. -/
def sepChain (B : SqrtBounds) (l : List Q4) : Bool :=
  sepIvals (l.map (Q4.approx B))

/-- **The per-pair bridge**: disjoint intervals order the evaluations. The one place the interval
data touches `ℝ`'s order; everything below is list plumbing over it. At denominator 0 the two
membership facts already contradict the disjointness, so no positivity hypothesis is carried. -/
theorem eval_lt_of_hi_lt_lo {B : SqrtBounds} (hB : B.Ok = true) {a b : Q4}
    (h : (Q4.approx B a).hi < (Q4.approx B b).lo) : Q4.eval a < Q4.eval b := by
  have ha := Q4.mem_approx hB a
  have hb := Q4.mem_approx hB b
  have hcast : ((Q4.approx B a).hi : ℝ) < ((Q4.approx B b).lo : ℝ) := by exact_mod_cast h
  rcases Nat.eq_zero_or_pos (B.scale ^ 4) with h0 | hpos
  · rw [h0] at ha hb
    have h1 : (0 : ℝ) ≤ ((Q4.approx B a).hi : ℝ) := by simpa using ha.2
    have h2 : ((Q4.approx B b).lo : ℝ) ≤ 0 := by simpa using hb.1
    linarith
  · have hm : (0 : ℝ) ≤ ((B.scale ^ 4 : ℕ) : ℝ) := by positivity
    exact lt_of_mul_lt_mul_right (lt_of_le_of_lt ha.2 (lt_of_lt_of_le hcast hb.1)) hm

/-- A separated list evaluates strictly increasingly — at *all* pairs of positions, transitivity
folded in once here rather than at every consumer. -/
theorem pairwise_lt_of_sepChain {B : SqrtBounds} (hB : B.Ok = true) {l : List Q4}
    (h : sepChain B l = true) : l.Pairwise (fun a b => Q4.eval a < Q4.eval b) := by
  haveI : Trans (fun a b : Q4 => Q4.eval a < Q4.eval b) (fun a b : Q4 => Q4.eval a < Q4.eval b)
      (fun a b : Q4 => Q4.eval a < Q4.eval b) := ⟨fun h1 h2 => lt_trans h1 h2⟩
  rw [← List.isChain_iff_pairwise]
  induction l with
  | nil => simp
  | cons a t ih =>
    cases t with
    | nil => simp
    | cons b t' =>
      rw [List.isChain_cons_cons]
      simp only [sepChain, List.map, sepIvals, Bool.and_eq_true, decide_eq_true_eq] at h
      exact ⟨eval_lt_of_hi_lt_lo hB h.1, ih h.2⟩

/-- A separated list has pairwise-distinct real values. -/
theorem pairwise_ne_of_sepChain {B : SqrtBounds} (hB : B.Ok = true) {l : List Q4}
    (h : sepChain B l = true) : l.Pairwise (fun a b => Q4.eval a ≠ Q4.eval b) :=
  (pairwise_lt_of_sepChain hB h).imp ne_of_lt

/-- **The consumer's form**: in a separated list, equal evaluations force equal positions. This is
the exact step that merges "same real distance" into "same class" in M16's certificate. -/
theorem index_eq_of_eval_eq {B : SqrtBounds} (hB : B.Ok = true) {l : List Q4}
    (h : sepChain B l = true) {i j : ℕ} {a b : Q4} (ha : l[i]? = some a) (hb : l[j]? = some b)
    (he : Q4.eval a = Q4.eval b) : i = j := by
  by_contra hne
  have hp := List.pairwise_iff_getElem.mp (pairwise_lt_of_sepChain hB h)
  obtain ⟨hi, hgi⟩ := List.getElem?_eq_some_iff.mp ha
  obtain ⟨hj, hgj⟩ := List.getElem?_eq_some_iff.mp hb
  rcases Nat.lt_or_ge i j with hij | hij
  · exact absurd he (hgi ▸ hgj ▸ ne_of_lt (hp i j hi hj hij))
  · exact absurd he.symm
      (hgj ▸ hgi ▸ ne_of_lt (hp j i hj hi (lt_of_le_of_ne hij (Ne.symm hne))))

/-! ## Specification

Bounds any reader checks by squaring in their head, and the checks that discriminate. -/

/-- At denominator 10: `√3 ∈ [1.7, 1.8]`, `√5 ∈ [2.2, 2.3]`, `√7 ∈ [2.6, 2.7]`,
`√11 ∈ [3.3, 3.4]` — i.e. `17² = 289 ≤ 300 ≤ 324 = 18²` and so on. -/
def SqrtBounds.coarse : SqrtBounds := ⟨10, ⟨17, 18⟩, ⟨22, 23⟩, ⟨26, 27⟩, ⟨33, 34⟩⟩

/-- The same bounds one decimal digit tighter, at denominator 100 — the spec's demonstration that
precision is a knob and not a redesign. -/
def SqrtBounds.fine : SqrtBounds := ⟨100, ⟨173, 174⟩, ⟨223, 224⟩, ⟨264, 265⟩, ⟨331, 332⟩⟩

#guard SqrtBounds.coarse.Ok
#guard SqrtBounds.fine.Ok
#guard sqrtOk 3 ⟨17, 18⟩ 10
-- A wrong lower bound is refused: `2 ≤ √3` fails on `20² ≤ 300`.
#guard !(sqrtOk 3 ⟨20, 30⟩ 10)
-- ...and so is an upper bound that is too small: `√3 ≤ 1.7` fails on `300 ≤ 17²`.
#guard !(sqrtOk 3 ⟨10, 17⟩ 10)
-- ...and a negative upper endpoint, whose square is large for the wrong reason.
#guard !(sqrtOk 3 ⟨0, -18⟩ 10)

private def r3 : Q4 := ⟨⟨⟨⟨0, 1⟩, 0⟩, 0⟩, 0⟩

-- The generator √3 sits strictly between 1 and 2, and the chain sees it.
#guard sepChain SqrtBounds.coarse [1, r3, 2]
-- Out of order is refused...
#guard !(sepChain SqrtBounds.coarse [r3, 1])
-- ...and so is a repeated value, which no interval can separate from itself.
#guard !(sepChain SqrtBounds.coarse [r3, r3])

private def twelveSubSixR3 : Q4 := ⟨⟨⟨⟨12, -6⟩, 0⟩, 0⟩, 0⟩

-- `12 − 6√3 ≈ 1.608` and `√3 ≈ 1.732` are 0.12 apart: at coarse bounds their intervals overlap and
-- the check refuses — "not separated at this precision", never a guess...
#guard !(sepChain SqrtBounds.coarse [twelveSubSixR3, r3])
-- ...and the emitter's remedy is one more digit of precision, under which the same pair separates.
#guard sepChain SqrtBounds.fine [twelveSubSixR3, r3]

end HadwigerNelson
