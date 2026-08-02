import Proofs.HadwigerNelson.Field.Quadratic

/-! # Rational interval bounds for `Q4.eval` — exact field values compared as reals

`Q4.eval` is deliberately not known injective (`Field/Quadratic.lean` makes never needing
injectivity a design point), yet M16's headline quantifies over **real** distances: two `Q4`-distinct
squared distances that secretly evaluated to the same real would merge two distance classes, and a
certificate separating each part with different colourings would not separate the union.

This module is the repair, and it is an *instrument*, not a theory: rational interval arithmetic
sound for `Q4.eval` on **literals**, from bounds on the four generators whose correctness is the
decidable integer fact `l² ≤ d ≤ h²`. Distinctness of any concrete family of values is then the
kernel checking that their intervals are pairwise disjoint — no linear independence of radicals,
no irrationality, nothing about `eval` beyond its `RingHom` API.

The consumer shape is `sepChain`: a list of `Q4` values the emitter claims is sorted by real value,
checked by adjacent-interval disjointness, yielding pairwise-distinct evaluations. Precision is the
emitter's problem — it picks generator bounds tight enough for its data and the kernel only ever
says yes or no.
-/

namespace HadwigerNelson

/-- A closed rational interval, the certificate's claim about where a real value lies.

`lo ≤ hi` is *not* an invariant: an inverted interval has no members, every `Mem` fact about it is
false, and `sepChain` on data containing one simply fails — fail-loud totality with no smart
constructor to maintain. -/
structure Ival where
  /-- Lower endpoint. -/
  lo : ℚ
  /-- Upper endpoint. -/
  hi : ℚ
  deriving Repr, DecidableEq

namespace Ival

/-- The interval brackets the real number `x`. -/
def Mem (I : Ival) (x : ℝ) : Prop := (I.lo : ℝ) ≤ x ∧ x ≤ (I.hi : ℝ)

/-- The exact interval of an integer. -/
def ofInt (m : ℤ) : Ival := ⟨(m : ℚ), (m : ℚ)⟩

/-- Endpoint-wise sum. -/
def add (I J : Ival) : Ival := ⟨I.lo + J.lo, I.hi + J.hi⟩

/-- Product: the four endpoint products bracket every product of members, whatever the signs. -/
def mul (I J : Ival) : Ival :=
  ⟨min (min (I.lo * J.lo) (I.lo * J.hi)) (min (I.hi * J.lo) (I.hi * J.hi)),
   max (max (I.lo * J.lo) (I.lo * J.hi)) (max (I.hi * J.lo) (I.hi * J.hi))⟩

/-- An integer is in its own exact interval. -/
theorem mem_ofInt (m : ℤ) : (ofInt m).Mem (m : ℝ) := sorry

/-- Interval addition is sound. -/
theorem Mem.add {I J : Ival} {x y : ℝ} (hx : I.Mem x) (hy : J.Mem y) :
    (I.add J).Mem (x + y) := sorry

/-- Interval multiplication is sound: a bilinear function on a rectangle attains its extrema at
the corners. -/
theorem Mem.mul {I J : Ival} {x y : ℝ} (hx : I.Mem x) (hy : J.Mem y) :
    (I.mul J).Mem (x * y) := sorry

end Ival

/-- **`l ≤ √d ≤ h`, as the kernel can check it**: `l` nonnegative, `l² ≤ d`, `d ≤ h²`. -/
def sqrtOk (d : ℕ) (I : Ival) : Bool :=
  decide (0 ≤ I.lo) && decide (I.lo * I.lo ≤ (d : ℚ)) && decide ((d : ℚ) ≤ I.hi * I.hi)

/-- A checked square-root bound brackets the square root. -/
theorem mem_sqrt {d : ℕ} {I : Ival} (h : sqrtOk d I = true) : I.Mem (Real.sqrt d) := sorry

/-- One rational interval per generator of `ℚ(√3,√5,√7,√11)`. Emitter-chosen data; `Ok` below is
the only thing believed about it, and precision is a tuning parameter the theorems hold for every
value of. -/
structure SqrtBounds where
  /-- Interval for `√3`. -/
  s3 : Ival
  /-- Interval for `√5`. -/
  s5 : Ival
  /-- Interval for `√7`. -/
  s7 : Ival
  /-- Interval for `√11`. -/
  s11 : Ival
  deriving Repr, DecidableEq

/-- All four bounds check. -/
def SqrtBounds.Ok (B : SqrtBounds) : Bool :=
  sqrtOk 3 B.s3 && sqrtOk 5 B.s5 && sqrtOk 7 B.s7 && sqrtOk 11 B.s11

/-- One tower level of interval evaluation, mirroring `Adjoin.eval`:
`⟨a, b⟩ ↦ f a + (f b) · I_d` where `I_d` brackets `√d`. -/
def Adjoin.approx {K : Type*} {d : ℕ} (f : K → Ival) (Id : Ival) (x : Adjoin d K) : Ival :=
  (f x.re).add ((f x.im).mul Id)

/-- One tower level is sound: if `f` brackets `evalBase` everywhere and `Id` brackets `r`, the
level brackets `Adjoin.eval evalBase r hr`. -/
theorem Adjoin.mem_approx {K : Type*} [CommRing K] [NatScalar K] {d : ℕ} {evalBase : K →+* ℝ}
    {r : ℝ}
    {hr : r ^ 2 = (d : ℝ)}
    {f : K → Ival} (hf : ∀ y : K, (f y).Mem (evalBase y)) {Id : Ival} (hd : Id.Mem r)
    (x : Adjoin d K) : (Adjoin.approx f Id x).Mem (Adjoin.eval evalBase r hr x) := sorry

/-- Interval evaluation of a `Q4` literal, the four levels of `Q4.eval` mirrored. -/
def Q4.approx (B : SqrtBounds) : Q4 → Ival :=
  Adjoin.approx (Adjoin.approx (Adjoin.approx (Adjoin.approx Ival.ofInt B.s3) B.s5) B.s7) B.s11

/-- **The instrument's soundness**: checked bounds make `Q4.approx` bracket `Q4.eval`. -/
theorem Q4.mem_approx {B : SqrtBounds} (hB : B.Ok = true) (x : Q4) :
    (Q4.approx B x).Mem (Q4.eval x) := sorry

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

Loose bounds that any reader can check by squaring, and the checks that discriminate. -/

/-- Bounds any reader verifies by squaring: `√3 ∈ [1.7, 1.8]`, `√5 ∈ [2.2, 2.3]`,
`√7 ∈ [2.6, 2.7]`, `√11 ∈ [3.3, 3.4]`. -/
def SqrtBounds.coarse : SqrtBounds :=
  ⟨⟨17/10, 9/5⟩, ⟨11/5, 23/10⟩, ⟨13/5, 27/10⟩, ⟨33/10, 17/5⟩⟩

#guard SqrtBounds.coarse.Ok
#guard sqrtOk 3 ⟨17/10, 9/5⟩
-- A wrong bound is refused: `2 ≤ √3` fails on `2² ≤ 3`.
#guard !(sqrtOk 3 ⟨2, 3⟩)
-- ...and so is an upper bound that is too small: `√3 ≤ 1.7` fails on `3 ≤ 1.7²`.
#guard !(sqrtOk 3 ⟨1, 17/10⟩)

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
-- ...and the emitter's remedy is tighter bounds, under which the same pair separates.
#guard sepChain { SqrtBounds.coarse with s3 := ⟨173/100, 174/100⟩ } [twelveSubSixR3, r3]

end HadwigerNelson
