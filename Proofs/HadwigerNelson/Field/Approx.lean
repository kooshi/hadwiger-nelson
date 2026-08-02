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
theorem mem_ofInt (m : ℤ) : (ofInt m).Mem 1 (m : ℝ) := sorry

/-- Rescaling is sound: same real, denominator multiplied by `c`. -/
theorem Mem.scaleUp {I : Ival} {s : ℕ} {x : ℝ} (h : I.Mem s x) (c : ℕ) :
    (I.scaleUp c).Mem (s * c) x := sorry

/-- Interval addition is sound at a shared denominator. -/
theorem Mem.add {I J : Ival} {s : ℕ} {x y : ℝ} (hx : I.Mem s x) (hy : J.Mem s y) :
    (I.add J).Mem s (x + y) := sorry

/-- Interval multiplication is sound — a bilinear function on a rectangle attains its extrema at
the corners — and the denominators multiply. -/
theorem Mem.mul {I J : Ival} {s t : ℕ} {x y : ℝ} (hx : I.Mem s x) (hy : J.Mem t y) :
    (I.mul J).Mem (s * t) (x * y) := sorry

end Ival

/-- **`l/s ≤ √d ≤ h/s`, as the kernel can check it**: both endpoints nonnegative, `l² ≤ d·s²`,
`d·s² ≤ h²`. -/
def sqrtOk (d : ℕ) (I : Ival) (s : ℕ) : Bool :=
  decide (0 ≤ I.lo) && decide (0 ≤ I.hi) &&
  decide (I.lo * I.lo ≤ (d : ℤ) * s * s) && decide ((d : ℤ) * s * s ≤ I.hi * I.hi)

/-- A checked square-root bound brackets the square root. -/
theorem mem_sqrt {d : ℕ} {I : Ival} {s : ℕ} (h : sqrtOk d I s = true) :
    I.Mem s (Real.sqrt d) := sorry

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

/-- One tower level is sound: if `f` brackets `evalBase` at denominator `t` and `Id` brackets `r`
at denominator `s`, the level brackets `Adjoin.eval evalBase r hr` at denominator `t·s`. -/
theorem Adjoin.mem_approx {K : Type*} [CommRing K] [NatScalar K] {d : ℕ} {evalBase : K →+* ℝ}
    {r : ℝ} {hr : r ^ 2 = (d : ℝ)} {f : K → Ival} {t : ℕ}
    (hf : ∀ y : K, (f y).Mem t (evalBase y)) {Id : Ival} {s : ℕ} (hd : Id.Mem s r)
    (x : Adjoin d K) : (Adjoin.approx f Id s x).Mem (t * s) (Adjoin.eval evalBase r hr x) := sorry

/-- Interval evaluation of a `Q4` literal — the four levels of `Q4.eval` mirrored, each level
multiplying the denominator by `B.scale`, landing at `B.scale⁴`. -/
def Q4.approx (B : SqrtBounds) : Q4 → Ival :=
  Adjoin.approx (Adjoin.approx (Adjoin.approx (Adjoin.approx
    Ival.ofInt B.s3 B.scale) B.s5 B.scale) B.s7 B.scale) B.s11 B.scale

/-- **The instrument's soundness**: checked bounds make `Q4.approx` bracket `Q4.eval` at
denominator `B.scale⁴`. -/
theorem Q4.mem_approx {B : SqrtBounds} (hB : B.Ok = true) (x : Q4) :
    (Q4.approx B x).Mem (B.scale ^ 4) (Q4.eval x) := sorry

/-- Adjacent intervals are strictly disjoint, in order. -/
def sepIvals : List Ival → Bool
  | [] => true
  | [_] => true
  | a :: b :: t => decide (a.hi < b.lo) && sepIvals (b :: t)

/-- **The separation check**: the values' intervals, in the order given, are pairwise disjoint —
so the emitter's claim "sorted by real value, all distinct" is verified rather than believed. -/
def sepChain (B : SqrtBounds) (l : List Q4) : Bool :=
  sepIvals (l.map (Q4.approx B))

/-- A separated list evaluates strictly increasingly at adjacent positions. -/
theorem chain_lt_of_sepChain {B : SqrtBounds} (hB : B.Ok = true) {l : List Q4}
    (h : sepChain B l = true) : l.IsChain (fun a b => Q4.eval a < Q4.eval b) := sorry

/-- A separated list has pairwise-distinct real values. -/
theorem pairwise_ne_of_sepChain {B : SqrtBounds} (hB : B.Ok = true) {l : List Q4}
    (h : sepChain B l = true) : l.Pairwise (fun a b => Q4.eval a ≠ Q4.eval b) := sorry

/-- **The consumer's form**: in a separated list, equal evaluations force equal positions. This is
the exact step that merges "same real distance" into "same class" in M16's certificate. -/
theorem index_eq_of_eval_eq {B : SqrtBounds} (hB : B.Ok = true) {l : List Q4}
    (h : sepChain B l = true) {i j : ℕ} {a b : Q4} (ha : l[i]? = some a) (hb : l[j]? = some b)
    (he : Q4.eval a = Q4.eval b) : i = j := sorry

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
