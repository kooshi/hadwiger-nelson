import Proofs.HadwigerNelson.Certificate

/-!
# Rigid motions of the plane, exactly

A rotation of the plane by a *rational* angle has a denominator — de Grey's is `1/32` — and the
coordinate tower has no division, so a rotation is stated here **cleared of its denominator**:

```
M · (image − centre) = ⎡ a  −b ⎤ · (point − centre)          with  a² + b² = M²
                       ⎣ b   a ⎦
```

which is the rotation by `(cos, sin) = (a/M, b/M)` multiplied through by `M`. The condition
`a² + b² = M²` is what makes it a rotation rather than an arbitrary linear map, and it is the only
hypothesis the distance lemma consumes.

## Why the scale factor cannot simply be cancelled

Clearing the denominator multiplies every squared distance by `M²`, so the conclusion arrives as
`M² · d(q, q') = M² · d(p, p')` and the factor has to come off. **`Q4` is not known here to be an
integral domain**, and proving it is exactly the number-theoretic burden `ARCHITECTURE.md` § 2.1
deletes on purpose: nothing in this project needs the embedding `Q4 → ℝ` to be injective.

So the factor is cancelled as a **natural number** instead, which is true of the tower for a reason
that costs nothing: its leaves are `ℤ`, integer multiplication cancels there, and every operation up
the tower is componentwise. `NatCancel` below is that fact, one instance per level.

## What this is for

Two things, and the second is the point. It lets de Grey's second copy be *derived* from his first
rather than listed (`Instances/DeGrey/Rotation.lean`). And it is the operation a gadget search is
made of: a gadget placed somewhere else in the plane by a proved isometry keeps its geometry, so
placing a copy costs no distance checks at all.
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

/-! ## The motion -/

/-- **A rotation about `o`, cleared of its denominator**: `q` is the image of `p` under the rotation
with `(cos, sin) = (a/M, b/M)`.

A `Bool` because this is checked against emitted coordinates by the kernel, one instance per vertex.
Read it through `distSq_eq_of_rotOk`; the two rows are an implementation detail. -/
def RotOk (a b M : Q4) (o p q : Pt) : Bool :=
  (M * (q.x - o.x) == a * (p.x - o.x) - b * (p.y - o.y)) &&
  (M * (q.y - o.y) == b * (p.x - o.x) + a * (p.y - o.y))

/-- **A rotation preserves squared distance, up to the scale it was cleared by.** The centre `o`
cancels: a squared distance depends only on differences, so the translation plays no part and the
hypothesis `a² + b² = M²` does all the work. -/
theorem distSq_of_rotOk {a b M : Q4} {o p p' q q' : Pt} (hab : a * a + b * b = M * M)
    (h : RotOk a b M o p q = true) (h' : RotOk a b M o p' q' = true) :
    M * M * q.distSq q' = M * M * p.distSq p' := sorry

/-- **The consumer's form.** Two points and their rotated images are the same distance apart —
the scale factor cancelled, so this can be chained straight into a certificate's `Valid` check. -/
theorem distSq_eq_of_rotOk {a b M : Q4} {c : ℕ} {o p p' q q' : Pt} (hc : c ≠ 0)
    (hM : M * M = (c : Q4)) (hab : a * a + b * b = M * M)
    (h : RotOk a b M o p q = true) (h' : RotOk a b M o p' q' = true) :
    q.distSq q' = p.distSq p' := sorry

/-! ## Spec

`RotOk` would be satisfied by a great many maps that are not rotations, and `distSq_eq_of_rotOk`
would be vacuous if no triple `(a, b, M)` ever satisfied `a² + b² = M²`. Both need exhibiting. -/

section Spec

/-- **A model of the hypotheses**, at the smallest interesting size: the `3–4–5` rotation about the
origin, `(cos, sin) = (3/5, 4/5)`, carrying `(5, 0)` to `(3, 4)`. -/
example : RotOk 3 4 5 ⟨0, 0⟩ ⟨5, 0⟩ ⟨3, 4⟩ = true := by decide

example : (3 : Q4) * 3 + 4 * 4 = 5 * 5 := by decide

/-- **The negative control on the rotation condition.** Drop `a² + b² = M²` and the conclusion is
false: the map `(x, y) ↦ (2x, 2y)` satisfies `RotOk 2 0 1 ⟨0,0⟩` and doubles every distance. A build
failure could not establish this; only a countermodel can. -/
example : ¬ ∀ (a b M : Q4) (o p p' q q' : Pt),
    RotOk a b M o p q = true → RotOk a b M o p' q' = true → q.distSq q' = p.distSq p' := sorry

end Spec

end HadwigerNelson
