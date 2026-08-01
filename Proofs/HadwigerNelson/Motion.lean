import Proofs.HadwigerNelson.Certificate

/-!
# Rigid motions of the plane, exactly

A rotation by a *rational* angle has a denominator — de Grey's is `1/32` — and the coordinate tower
has no division. So a rotation is represented here **cleared of its denominator**: the rotation about
`centre` by `(cos, sin) = (a/M, b/M)`, stored as the integer-scaled data `a`, `b`, `M` with

```
a² + b² = M² = scale
```

`scale` is a *natural number*, and that is load-bearing — see below. A motion carries its own proof
that it is one, because the data and the proof are no use apart: `Motion.rot` is the only hypothesis
`Motion.distSq_eq` consumes, and a would-be motion without it doubles distances instead of
preserving them (the negative control at the foot of this file exhibits exactly that).

## Why the scale factor is a natural number

Clearing the denominator multiplies every squared distance by `M²`, so the distance lemma arrives at
`M²·d(q,q') = M²·d(p,p')` and the factor has to come off. **`Q4` is not known here to be an integral
domain**, and proving it is exactly the number-theoretic burden `ARCHITECTURE.md` § 2.1 deletes on
purpose: nothing in this project needs the embedding `Q4 → ℝ` to be injective.

So the factor is cancelled as a **natural number** instead, which is true of the tower for a reason
that costs nothing: its leaves are `ℤ`, integer multiplication cancels there, and every operation up
the tower is componentwise. `NatCancel` is that fact, one instance per level.

`M : Q4` and `scale : ℕ` are both stored, with `Motion.sq` tying them. That redundancy is
deliberate and it is the house pattern — `NatScalar` and `FastSq` in `Field/Quadratic.lean` do the
same thing for the same reason: the field the kernel *reduces* and the field the proofs *rewrite
with* are different, and a law in the structure is what stops them drifting. Here `M` is what the
791 per-vertex checks multiply by, and re-deriving it from `scale` at each one would cast a natural
number into the tower six thousand times.

## What this is for

Two things, and the second is the point. It lets de Grey's second copy be *derived* from his first
rather than listed (`Instances/DeGrey/Rotation.lean`). And it is the operation a gadget search is
made of: a gadget placed elsewhere in the plane by a motion keeps its geometry, so placing a copy
costs no distance checks at all.
-/

namespace HadwigerNelson

/-! ## Cancelling an integer scale factor -/

/-- **Multiplication by a nonzero natural number is injective.** True of the whole tower because its
leaves are `ℤ` and every level is componentwise — and *not* an instance of `mul_left_cancel₀`, which
would need `Q4` to have no zero divisors.

A class rather than a theorem about `Q4` because the proof is one induction step per tower level, and
a class is how that induction is written. -/
class NatCancel (K : Type*) [CommRing K] : Prop where
  /-- Cancel a nonzero natural factor from both sides. -/
  cancel : ∀ {c : ℕ}, c ≠ 0 → ∀ {x y : K}, (c : K) * x = (c : K) * y → x = y

/-- The leaf: `ℤ` cancels because it is an integral domain. -/
instance : NatCancel ℤ := sorry

/-- The induction step: a level cancels componentwise. -/
instance {d : ℕ} {K : Type*} [CommRing K] [NatScalar K] [NatCancel K] :
    NatCancel (Adjoin d K) := sorry

/-! ## Motions -/

/-- **A rotation of the plane, cleared of its denominator.** The rotation about `centre` by
`(cos, sin) = (a/M, b/M)`, with the fact that makes it a rotation carried as a field.

Bundled rather than passed as six arguments because the six never travel apart: `Motion.Maps` needs
four of them, `Motion.distSq_eq` needs all six, and every call site would otherwise repeat the same
four names. The role has a name — it is *the motion carrying one copy onto another* — and naming it
is what lets a search speak about placements at all. -/
structure Motion where
  /-- `M · cos θ`. -/
  a : Q4
  /-- `M · sin θ`. -/
  b : Q4
  /-- The denominator the rotation was cleared by. -/
  M : Q4
  /-- The fixed point. -/
  centre : Pt
  /-- `M²`, as a natural number — the only form in which the scale factor can be cancelled. -/
  scale : ℕ
  /-- A degenerate motion would cancel nothing and prove everything. -/
  scale_ne : scale ≠ 0
  /-- The stored `M` really is the square root of `scale`. -/
  sq : M * M = (scale : Q4)
  /-- **It really is a rotation.** The one hypothesis every distance claim consumes. -/
  rot : a * a + b * b = (scale : Q4)

namespace Motion

variable (μ : Motion)

/-- **`q` is the image of `p`.** A `Bool`, because this is what the kernel checks against emitted
coordinates — one instance per vertex of the copy being placed.

Read it through `distSq_eq`; the two rows are an implementation detail and no consumer should unfold
them. -/
def Maps (p q : Pt) : Bool :=
  (μ.M * (q.x - μ.centre.x) == μ.a * (p.x - μ.centre.x) - μ.b * (p.y - μ.centre.y)) &&
  (μ.M * (q.y - μ.centre.y) == μ.b * (p.x - μ.centre.x) + μ.a * (p.y - μ.centre.y))

/-- **A motion preserves squared distance.** The centre cancels — a squared distance depends only on
differences — so the translation plays no part and `Motion.rot` does all the work.

This is the whole consumer surface of this file: two points, their images, and the conclusion that
the distance is unchanged. It chains straight into a certificate's `Valid` check. -/
theorem distSq_eq {p p' q q' : Pt} (h : μ.Maps p q = true) (h' : μ.Maps p' q' = true) :
    q.distSq q' = p.distSq p' := sorry

end Motion

/-! ## Spec

`Motion.rot` would be satisfied by nothing at all if no integer triple met it, and `distSq_eq` would
be vacuous. Both need exhibiting, and the hypothesis needs a countermodel. -/

section Spec

/-- **A model of the hypotheses**, at the smallest interesting size: the `3–4–5` rotation about the
origin, `(cos, sin) = (3/5, 4/5)`. Nothing above it is vacuous. -/
def pythagorean : Motion where
  a := 3; b := 4; M := 5; centre := ⟨0, 0⟩; scale := 25
  scale_ne := by decide
  sq := by decide
  rot := by decide

-- …and it carries `(5, 0)` to `(3, 4)`, and the origin to itself.
#guard pythagorean.Maps ⟨5, 0⟩ ⟨3, 4⟩
#guard pythagorean.Maps ⟨0, 0⟩ ⟨0, 0⟩

-- The two images are the distance apart the two sources were: `5² = 25`, both ways.
example : (⟨3, 4⟩ : Pt).distSq ⟨0, 0⟩ = (⟨5, 0⟩ : Pt).distSq ⟨0, 0⟩ := by decide

/-- **The negative control on the rotation condition.** Delete `Motion.rot` — keep only the two rows
of `Maps` — and the conclusion is false: `(x, y) ↦ (2x, 2y)` fits the rows with `a = 2, b = 0, M = 1`
and doubles every distance. A build failure could not establish this; only a countermodel can. -/
example : ¬ ∀ (a b M : Q4) (o p p' q q' : Pt),
    (M * (q.x - o.x) == a * (p.x - o.x) - b * (p.y - o.y)) = true →
    (M * (q.y - o.y) == b * (p.x - o.x) + a * (p.y - o.y)) = true →
    (M * (q'.x - o.x) == a * (p'.x - o.x) - b * (p'.y - o.y)) = true →
    (M * (q'.y - o.y) == b * (p'.x - o.x) + a * (p'.y - o.y)) = true →
    q.distSq q' = p.distSq p' := sorry

end Spec

end HadwigerNelson
