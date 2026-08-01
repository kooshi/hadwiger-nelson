import Proofs.HadwigerNelson.Certificate

/-!
# Rigid motions of the plane, exactly

A rotation by a *rational* angle has a denominator — de Grey's is `1/32` — and the coordinate tower
has no division. So a motion is represented here **cleared of its denominator**: the affine map

```
M · image = A · source + t          A = [[a, c], [b, d]],  t = (e, f)
```

with `A` orthogonal up to the scale factor:

```
a² + b² = M² = scale        c² + d² = M² = scale        a·c + b·d = 0
```

Those are the three laws that make `A` a similarity, and together they are exactly "the columns are
orthogonal and equally long" — which is what a plane isometry, scaled, is. `scale` is a *natural
number*, and that is load-bearing — see below.

A motion carries its own proof that it is one, because the data and the proof are no use apart: the
three laws are the only hypotheses `Motion.distSq_eq` consumes, and a would-be motion without them
doubles distances or collapses the plane onto a line instead of preserving distances (the negative
controls at the foot of this file exhibit both).

## Why a matrix and not an angle about a point

The previous shape was `M·(image − centre) = [[a, −b], [b, a]]·(source − centre)`: a rotation about
a fixed point, and **nothing else**. That matrix has determinant `a² + b² = M² > 0`, so a reflection
cannot satisfy it; and the centre appears on both sides, so a pure translation would force the shift
to zero. Enough for de Grey, whose construction is rotations about points. Not enough for a search:
lattice constructions translate constantly, and a scan for sub-copies searches reflections as a
matter of course.

The general form costs two more fields and two more laws, and **shortens the distance proof** — the
sign that used to distinguish a rotation from a reflection now lives in the data, so there is no case
split. What a reader wants to write is still `Motion.rotAbout`; that is a smart constructor.

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
with* are different, and a law in the structure is what stops them drifting.

## What this is for

Three things, and the third is new. It lets de Grey's second copy be *derived* from his first rather
than listed (`Instances/DeGrey/Rotation.lean`). It is the operation a gadget search is made of: a
gadget placed elsewhere in the plane by a motion keeps its geometry. And with `Motion.image`, a copy
whose coordinates are *defined* as the image needs **no** per-vertex check at all — one lemma,
quantified over the point, replaces de Grey's 791 identities for any construction not frozen as data.
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
  cancel : ∀ {c : ℕ} {x y : K}, c ≠ 0 → (c : K) * x = (c : K) * y → x = y

/-- The leaf: `ℤ` cancels because it is an integral domain. -/
instance : NatCancel ℤ where
  cancel hc h := mul_left_cancel₀ (Int.natCast_ne_zero.mpr hc) h

/-- The induction step: a level cancels componentwise. The `NatScalar K` hypothesis is not
decoration — `Adjoin.mul_re` is stated with the scalar action already traded for the cast, and that
is the form the two projections below need. -/
instance {d : ℕ} {K : Type*} [CommRing K] [NatScalar K] [NatCancel K] :
    NatCancel (Adjoin d K) where
  cancel hc h := by
    have hre := congrArg Adjoin.re h
    have him := congrArg Adjoin.im h
    simp only [Adjoin.mul_re, Adjoin.mul_im, Adjoin.natCast_re, Adjoin.natCast_im,
      zero_mul, mul_zero, add_zero] at hre him
    exact Adjoin.ext (NatCancel.cancel hc hre) (NatCancel.cancel hc him)

/-! ## Motions -/

/-- **A rigid motion of the plane, cleared of its denominator.** The affine map
`M · image = A · source + t` with `A = [[a, c], [b, d]]` and `t = (e, f)`, carrying the three laws
that make `A` a similarity of scale `M`.

Bundled rather than passed as eight arguments because the eight never travel apart: `Motion.Maps`
needs seven of them and `Motion.distSq_eq` needs all of them. The role has a name — it is *the motion
carrying one copy onto another* — and naming it is what lets a search speak about placements at
all. -/
structure Motion where
  /-- Column one of the linear part, first entry — `M · cos θ` for a rotation. -/
  a : Q4
  /-- Column one of the linear part, second entry — `M · sin θ` for a rotation. -/
  b : Q4
  /-- Column two of the linear part, first entry — `−M · sin θ` for a rotation, `+M · sin θ` for a
  reflection. This entry is where the orientation lives. -/
  c : Q4
  /-- Column two of the linear part, second entry. -/
  d : Q4
  /-- The translation's first coordinate, cleared by `M`. -/
  e : Q4
  /-- The translation's second coordinate, cleared by `M`. -/
  f : Q4
  /-- The denominator the motion was cleared by. -/
  M : Q4
  /-- `M²`, as a natural number — the only form in which the scale factor can be cancelled. -/
  scale : ℕ
  /-- A degenerate motion would cancel nothing and prove everything. -/
  scale_ne : scale ≠ 0
  /-- The stored `M` really is the square root of `scale`. -/
  sq : M * M = (scale : Q4)
  /-- The first column has the right length. -/
  col₁ : a * a + b * b = (scale : Q4)
  /-- The second column has the right length — without it the plane collapses onto a line. -/
  col₂ : c * c + d * d = (scale : Q4)
  /-- The columns are orthogonal — without it the map is a shear and preserves nothing. -/
  orth : a * c + b * d = 0

namespace Motion

variable (μ : Motion)

/-- The similarity `[[a, c], [b, d]]` scales a squared norm by `scale`, given the three laws. Isolated
as six-variable algebra so the two scaling lemmas below are substitutions rather than polynomial
identities in ten. -/
private theorem sq_norm_sim {a b c d s u v : Q4} (h₁ : a * a + b * b = s) (h₂ : c * c + d * d = s)
    (h₃ : a * c + b * d = 0) :
    (a * u + c * v) * (a * u + c * v) + (b * u + d * v) * (b * u + d * v) = s * (u * u + v * v) := by
  linear_combination u * u * h₁ + 2 * u * v * h₃ + v * v * h₂

/-! ### The two halves of a placement

A motion sends a point at denominator `d` to a point at denominator `d·M`, and there is no division
in the tower, so the image cannot be written at `d`. The two operations below are that fact split in
half, and every statement in this file is one of them or a consequence:

* `image` is **the image**, at `M` times the source's denominator. It is a plain function, so a table
  can be *defined* as the image of another and no coordinate is ever checked.
* `rescale` is **re-denomination**: the same point, written at `M` times the denominator.

`Maps p q` — the frozen-data case, where the image happens to be writable at the source's own
denominator — is then exactly `rescale q = image p`, and that identity is `maps_iff`. -/

/-- **The image of a point**, at `M` times the source's denominator.

Reason about it through `distSq_image` — every squared distance scales by exactly `scale` — and
never by unfolding these two coordinates. -/
def image (p : Pt) : Pt := ⟨μ.a * p.x + μ.c * p.y + μ.e, μ.b * p.x + μ.d * p.y + μ.f⟩

/-- **The same point, at `M` times the denominator.**

Reason about it through `distSq_rescale`, which is the only thing it is for. -/
def rescale (q : Pt) : Pt := ⟨μ.M * q.x, μ.M * q.y⟩

/-- **`q` is the image of `p`, at the same denominator.** A `Bool`, because this is what the kernel
checks against emitted coordinates — one instance per vertex of a copy that arrived as frozen data
before the motion was known.

Read it through `maps_iff` and `distSq_eq`; the two rows are an implementation detail and no
consumer should unfold them. -/
def Maps (p q : Pt) : Bool :=
  (μ.M * q.x == μ.a * p.x + μ.c * p.y + μ.e) &&
  (μ.M * q.y == μ.b * p.x + μ.d * p.y + μ.f)

/-- **What `Maps` says, in the vocabulary of the two halves.** The rows are the two coordinates of
one equation between points. -/
theorem maps_iff {p q : Pt} : μ.Maps p q = true ↔ μ.rescale q = μ.image p := by
  simp [Maps, rescale, image, Pt.mk.injEq]

/-- **Re-denomination scales every squared distance by `scale`.** One of the two facts the whole
file rests on; this one uses `Motion.sq` and nothing else. -/
theorem distSq_rescale (q q' : Pt) : (μ.rescale q).distSq (μ.rescale q') = (μ.scale : Q4) * q.distSq q' := by
  simp only [Pt.distSq, rescale, FastSq.sq_eq]
  linear_combination ((q.x - q'.x) * (q.x - q'.x) + (q.y - q'.y) * (q.y - q'.y)) * μ.sq

/-- **The image scales every squared distance by `scale`.** The other fact, and the one the three
similarity laws exist for. The translation cancels — a squared distance depends only on differences —
so `e` and `f` play no part.

**This is what makes a placed copy free.** A table defined as `step ∘ T` has every distance scaled by
exactly `scale`, for a copy of any size, with no per-vertex and no per-edge check: see
`UDCert.validOn_map_of_scaling`. -/
theorem distSq_image (p p' : Pt) : (μ.image p).distSq (μ.image p') = (μ.scale : Q4) * p.distSq p' := by
  simp only [Pt.distSq, image, FastSq.sq_eq]
  linear_combination sq_norm_sim μ.col₁ μ.col₂ μ.orth (u := p.x - p'.x) (v := p.y - p'.y)

/-- **A motion preserves squared distance.**

The whole consumer surface for frozen data: two points, their images, and the conclusion that the
distance is unchanged. Both sides scale by `scale` and the factor cancels as a natural number — which
is the only form in which it can be cancelled, `Q4` not being known to be a domain. -/
theorem distSq_eq {p p' q q' : Pt} (h : μ.Maps p q = true) (h' : μ.Maps p' q' = true) :
    q.distSq q' = p.distSq p' := by
  refine NatCancel.cancel μ.scale_ne ?_
  rw [← μ.distSq_rescale, ← μ.distSq_image, μ.maps_iff.mp h, μ.maps_iff.mp h']

/-! ## Producing motions

What a reader writes. Each is the general form with its entries filled in, so nothing downstream
learns a second representation. -/

/-- **A rotation about a point**, by `(cos, sin) = (a/M, b/M)`: the second column is `(−b, a)`, and
the translation is what carries the centre to itself. -/
def rotAbout (a b M : Q4) (o : Pt) (scale : ℕ) (scale_ne : scale ≠ 0 := by decide)
    (sq : M * M = (scale : Q4) := by decide +kernel)
    (rot : a * a + b * b = (scale : Q4) := by decide +kernel) : Motion where
  a := a; b := b; c := -b; d := a
  e := M * o.x - (a * o.x + -b * o.y)
  f := M * o.y - (b * o.x + a * o.y)
  M := M; scale := scale; scale_ne := scale_ne; sq := sq
  col₁ := rot
  col₂ := by linear_combination rot
  orth := by ring

/-- **A reflection in a line through a point**, in the direction `(a/M, b/M)`: the second column is
`(b, −a)`, which is the sign the old shape could not express. -/
def reflectIn (a b M : Q4) (o : Pt) (scale : ℕ) (scale_ne : scale ≠ 0 := by decide)
    (sq : M * M = (scale : Q4) := by decide +kernel)
    (rot : a * a + b * b = (scale : Q4) := by decide +kernel) : Motion where
  a := a; b := b; c := b; d := -a
  e := M * o.x - (a * o.x + b * o.y)
  f := M * o.y - (b * o.x + -a * o.y)
  M := M; scale := scale; scale_ne := scale_ne; sq := sq
  col₁ := rot
  col₂ := by linear_combination rot
  orth := by ring

/-- **A translation** — the motion the old shape admitted at no scale at all, since it has no fixed
point. -/
def translate (v : Pt) : Motion where
  a := 1; b := 0; c := 0; d := 1; e := v.x; f := v.y; M := 1; scale := 1
  scale_ne := by decide
  sq := by norm_num
  col₁ := by norm_num
  col₂ := by norm_num
  orth := by ring

/-- The identity motion — `Motion.trans`'s unit, and the placement that does nothing. -/
def id : Motion := translate ⟨0, 0⟩

/-! ## Composing motions

A layered construction places a copy of a copy, and de Grey's own rotation was *derived* as one
rotation after another's inverse — by hand, in Python, outside Lean. -/

/-- **One motion after another**, in reading order: `μ₁.trans μ₂` does `μ₁` *first*.

Named `trans` and not `comp` deliberately. `Function.comp` runs right to left, so `μ₁.comp μ₂` would
have meant `μ₁ after μ₂` to anyone who knows it and `μ₁ then μ₂` to anyone reading left to right —
a name that means opposite things to two readers. `trans` is Mathlib's name for the left-to-right
order (`Equiv.trans`, `LE.le.trans`) and carries no such ambiguity.

The linear parts multiply, the scales multiply, and the translation is the first one's carried
through the second. Read it through `maps_trans`. -/
def trans (μ₁ μ₂ : Motion) : Motion where
  a := μ₂.a * μ₁.a + μ₂.c * μ₁.b
  b := μ₂.b * μ₁.a + μ₂.d * μ₁.b
  c := μ₂.a * μ₁.c + μ₂.c * μ₁.d
  d := μ₂.b * μ₁.c + μ₂.d * μ₁.d
  e := μ₂.a * μ₁.e + μ₂.c * μ₁.f + μ₁.M * μ₂.e
  f := μ₂.b * μ₁.e + μ₂.d * μ₁.f + μ₁.M * μ₂.f
  M := μ₁.M * μ₂.M
  scale := μ₁.scale * μ₂.scale
  scale_ne := Nat.mul_ne_zero μ₁.scale_ne μ₂.scale_ne
  sq := by
    push_cast
    linear_combination (μ₂.M * μ₂.M) * μ₁.sq + (μ₁.scale : Q4) * μ₂.sq
  col₁ := by
    push_cast
    linear_combination μ₁.a * μ₁.a * μ₂.col₁ + 2 * μ₁.a * μ₁.b * μ₂.orth
      + μ₁.b * μ₁.b * μ₂.col₂ + (μ₂.scale : Q4) * μ₁.col₁
  col₂ := by
    push_cast
    linear_combination μ₁.c * μ₁.c * μ₂.col₁ + 2 * μ₁.c * μ₁.d * μ₂.orth
      + μ₁.d * μ₁.d * μ₂.col₂ + (μ₂.scale : Q4) * μ₁.col₂
  orth := by
    linear_combination μ₁.a * μ₁.c * μ₂.col₁ + (μ₁.a * μ₁.d + μ₁.b * μ₁.c) * μ₂.orth
      + μ₁.b * μ₁.d * μ₂.col₂ + (μ₂.scale : Q4) * μ₁.orth

/-- **Composition does what its name says.** Two placements chained are one placement. -/
theorem maps_trans {μ₁ μ₂ : Motion} {p q r : Pt} (h : μ₁.Maps p q = true) (h' : μ₂.Maps q r = true) :
    (μ₁.trans μ₂).Maps p r = true := by
  simp only [Maps, trans, Bool.and_eq_true, beq_iff_eq] at h h' ⊢
  obtain ⟨h1, h2⟩ := h
  obtain ⟨h3, h4⟩ := h'
  constructor
  · linear_combination μ₁.M * h3 + μ₂.a * h1 + μ₂.c * h2
  · linear_combination μ₁.M * h4 + μ₂.b * h1 + μ₂.d * h2

end Motion

/-! ## What a motion does to a certificate

Two lemmas about `UDCert`, living here rather than in `Certificate.lean` for one reason: that module
sits upstream of 2,433 generated certificate modules, so adding a line to it costs 27.8 hours of
kernel time. Both are about geometry under a motion, which is this module's subject anyway. -/

/-- **A certificate valid on a list is valid on any sublist.** One line from `validOn_iff`, and the
reason a graph's edge list can be re-ordered or re-segmented without re-checking its geometry.

Named `of_subset` and not `mono`: it is *antitone* in the edge list, and a name that says otherwise
would mislead every reader who never opens the file. -/
theorem UDCert.validOn_of_subset {n : ℕ} {c : UDCert n} {es es' : List (Fin n × Fin n)} (h : es' ⊆ es)
    (hv : c.ValidOn es = true) : c.ValidOn es' = true :=
  (c.validOn_iff es').mpr fun _ he => (c.validOn_iff es).mp hv _ (h he)

/-- **`ValidOn` reads only the points and the scale**, never the edge list a certificate happens to
carry. So two certificates over the same table agree on any list of edges — which is what lets a
graph be re-presented with a differently written edge list at no cost.

Stated rather than left to `rfl`, and that is not fussiness: without it, `deGreyRot.ValidOn
deGrey.edges = true := deGrey_valid` sends the elaborator to unify two *different* certificates, and
the fallback is to evaluate 7,877 edges of tower arithmetic. Measured by running into it. -/
theorem UDCert.validOn_congr {n : ℕ} {c c' : UDCert n} (hv : c.verts = c'.verts)
    (hd : c.denom = c'.denom) (es : List (Fin n × Fin n)) : c.ValidOn es = c'.ValidOn es := by
  simp [UDCert.ValidOn, UDCert.denomSq, hv, hd]

/-- **Geometry transports along a motion.** If a vertex map moves both endpoints of every edge of
`es` by the same motion `μ`, then the images of those edges are exactly as long as the originals — so
a certificate valid on `es` is valid on the image, and *no distance is recomputed*.

This is the statement M09 exists to make, and the one de Grey's frozen table needs: placing a copy of
a subgraph somewhere else in the plane costs one `Maps` check per vertex, never one per edge. When
the copy's coordinates are *defined* as the image, `validOn_map_of_scaling` below costs nothing at all. -/
theorem UDCert.validOn_map_of_motion {n : ℕ} (c : UDCert n) (μ : Motion) (φ : Fin n → Fin n)
    (es : List (Fin n × Fin n))
    (hmap : ∀ e ∈ es, μ.Maps (c.verts e.1) (c.verts (φ e.1)) = true ∧
                      μ.Maps (c.verts e.2) (c.verts (φ e.2)) = true)
    (hv : c.ValidOn es = true) :
    c.ValidOn (es.map fun e => (φ e.1, φ e.2)) = true := by
  refine (c.validOn_iff _).mpr fun e' he' => ?_
  obtain ⟨e, he, rfl⟩ := List.mem_map.mp he'
  obtain ⟨h1, h2⟩ := hmap e he
  exact (μ.distSq_eq h1 h2).trans ((c.validOn_iff es).mp hv e he)

/-- **A copy defined as an image costs nothing to certify.**

The role this names is *a map that multiplies every squared distance by a constant*: `Motion.image`
is one with constant `scale`, `Motion.rescale` is another, and so is their composite. Given such a map,
a certificate whose table is defined as its image — at a denominator whose square is scaled to
match — is valid wherever the original was, and **not one distance is computed**: no `Maps` check
per vertex, no arithmetic per edge, nothing that grows with the size of the copy.

That is the difference between de Grey's second copy, which cost 791 coordinate identities and 95
seconds because his table was frozen before the rotation was known, and a copy a construction
places for itself.

Stated over a bare `g` and `s` rather than over a `Motion`, because that is where it is true and
because the two instances a caller wants — the image, and the image re-denominated so that the new
denominator is an integer for *any* scale — differ only in which pair they supply.

Stated over **two** index types for the same reason. Nothing in the proof relates the source's vertex
count to the target's, and an assembly places `n` vertices into a certificate of `copies * n` — so
`n' = n` was incidental structure, and `Assembly.validOn_copiedEdges` is the instance that found it. -/
theorem UDCert.validOn_map_of_scaling {n n' : ℕ} (c : UDCert n) (c' : UDCert n') (g : Pt → Pt)
    (s : Q4) (φ : Fin n → Fin n') (es : List (Fin n × Fin n))
    (hg : ∀ p p', (g p).distSq (g p') = s * p.distSq p')
    (hverts : ∀ v, c'.verts (φ v) = g (c.verts v))
    (hden : c'.denomSq = s * c.denomSq)
    (hv : c.ValidOn es = true) :
    c'.ValidOn (es.map fun e => (φ e.1, φ e.2)) = true := by
  refine (c'.validOn_iff _).mpr fun e' he' => ?_
  obtain ⟨e, he, rfl⟩ := List.mem_map.mp he'
  rw [hverts, hverts, hg, hden, (c.validOn_iff es).mp hv e he]

/-! ## Spec

The three similarity laws would be satisfied by nothing at all if no integer data met them, and
`distSq_eq` would be vacuous. Each producer needs exhibiting, and each law needs a countermodel. -/

section Spec

/-- **A model of the hypotheses**, at the smallest interesting size: the `3–4–5` rotation about the
origin, `(cos, sin) = (3/5, 4/5)`. Nothing above it is vacuous. -/
def pythagorean : Motion :=
  Motion.rotAbout 3 4 5 ⟨0, 0⟩ 25

-- …and it carries `(5, 0)` to `(3, 4)`, and the origin to itself.
#guard pythagorean.Maps ⟨5, 0⟩ ⟨3, 4⟩
#guard pythagorean.Maps ⟨0, 0⟩ ⟨0, 0⟩

/-- **A model of a reflection** — the motion the previous shape could not express at any scale:
reflection in the `x`-axis through the origin. -/
def flipX : Motion := Motion.reflectIn 1 0 1 ⟨0, 0⟩ 1

#guard flipX.Maps ⟨3, 4⟩ ⟨3, -4⟩
#guard flipX.Maps ⟨1, 0⟩ ⟨1, 0⟩

/-- **A model of a translation** — the other motion the previous shape could not express. -/
def shift : Motion := Motion.translate ⟨2, -1⟩

#guard shift.Maps ⟨0, 0⟩ ⟨2, -1⟩
#guard shift.Maps ⟨5, 5⟩ ⟨7, 4⟩

-- **A model of composition**: reflect, then shift.
#guard (flipX.trans shift).Maps ⟨3, 4⟩ ⟨5, -5⟩

-- The two images are the distance apart the two sources were: `5² = 25`, both ways.
example : (⟨3, 4⟩ : Pt).distSq ⟨0, 0⟩ = (⟨5, 0⟩ : Pt).distSq ⟨0, 0⟩ := by decide

/-! ### Placement, demonstrated

A two-point certificate and a copy of it placed by the `3–4–5` rotation. What matters is the third
declaration: the copy's coordinates are *defined* as the image, so `hverts` is `rfl` at every vertex
and the placed copy's geometry follows without one distance being computed. -/

/-- Two points a unit apart: stored `(0,0)` and `(3,4)` at denominator 5. -/
def demoCert : UDCert 2 := ⟨![⟨0, 0⟩, ⟨3, 4⟩], [(0, 1)], 5⟩

#guard demoCert.Valid

/-- The same pair placed by `pythagorean`, its coordinates **defined** as the image and its
denominator scaled to match — `5 · 5 = 25`, because the rotation's scale factor is `25`. -/
def demoPlaced : UDCert 2 := ⟨fun v => pythagorean.image (demoCert.verts v), [(0, 1)], 25⟩

/-- **And it is valid for free.** Every hypothesis is `rfl` or arithmetic on the denominator; the
distance `(-7, 24)` is `25` from the origin is never checked, because `distSq_step` already said
every distance scales by exactly `25`. -/
example : demoPlaced.ValidOn [(0, 1)] = true :=
  UDCert.validOn_map_of_scaling demoCert demoPlaced pythagorean.image 25 _root_.id [(0, 1)]
    pythagorean.distSq_image (fun _ => rfl) (by decide) (by decide)

/-! ### The negative controls — one per similarity law

`distSq_eq` has three hypotheses and each one has to earn its place. Each control below states the
theorem with **exactly one law deleted** and exhibits data satisfying everything that is left while
breaking the conclusion. A build failure could not establish any of this; only a countermodel can. -/

/-- **The control on `col₁`** — the first column may not be the wrong length. Keep the second
column's length and orthogonality; `[[2, 0], [0, 1]]` stretches the `x`-axis and leaves the `y`-axis
alone, so `(0,0)` and `(1,0)`, one apart, land two apart. -/
example : ¬ ∀ (a b c d e f M : Q4) (s : ℕ), c * c + d * d = (s : Q4) → a * c + b * d = 0 →
    M * M = (s : Q4) → s ≠ 0 → ∀ p p' q q' : Pt,
    (M * q.x == a * p.x + c * p.y + e) = true → (M * q.y == b * p.x + d * p.y + f) = true →
    (M * q'.x == a * p'.x + c * p'.y + e) = true → (M * q'.y == b * p'.x + d * p'.y + f) = true →
    q.distSq q' = p.distSq p' := by
  intro h
  exact absurd (h 2 0 0 1 0 0 1 1 (by decide) (by decide) (by decide) (by decide)
    ⟨0, 0⟩ ⟨1, 0⟩ ⟨0, 0⟩ ⟨2, 0⟩ (by decide) (by decide) (by decide) (by decide)) (by decide)

/-- **The control on `col₂`** — the second column may not be the wrong length either, and this is
the law the previous shape of this file never needed, because its second column was forced. Keep the
first column's length and orthogonality; `[[1, 0], [0, 0]]` projects the plane onto the `x`-axis, so
`(0,0)` and `(0,1)` land on top of each other. -/
example : ¬ ∀ (a b c d e f M : Q4) (s : ℕ), a * a + b * b = (s : Q4) → a * c + b * d = 0 →
    M * M = (s : Q4) → s ≠ 0 → ∀ p p' q q' : Pt,
    (M * q.x == a * p.x + c * p.y + e) = true → (M * q.y == b * p.x + d * p.y + f) = true →
    (M * q'.x == a * p'.x + c * p'.y + e) = true → (M * q'.y == b * p'.x + d * p'.y + f) = true →
    q.distSq q' = p.distSq p' := by
  intro h
  exact absurd (h 1 0 0 0 0 0 1 1 (by decide) (by decide) (by decide) (by decide)
    ⟨0, 0⟩ ⟨0, 1⟩ ⟨0, 0⟩ ⟨0, 0⟩ (by decide) (by decide) (by decide) (by decide)) (by decide)

/-- **The control on `orth`** — equal column lengths are not enough. `[[1, 1], [0, 0]]` has both
columns of length one and is a shear onto a line: `(0,0)` and `(1,−1)`, two apart squared, land on
top of each other. -/
example : ¬ ∀ (a b c d e f M : Q4) (s : ℕ), a * a + b * b = (s : Q4) → c * c + d * d = (s : Q4) →
    M * M = (s : Q4) → s ≠ 0 → ∀ p p' q q' : Pt,
    (M * q.x == a * p.x + c * p.y + e) = true → (M * q.y == b * p.x + d * p.y + f) = true →
    (M * q'.x == a * p'.x + c * p'.y + e) = true → (M * q'.y == b * p'.x + d * p'.y + f) = true →
    q.distSq q' = p.distSq p' := by
  intro h
  exact absurd (h 1 0 1 0 0 0 1 1 (by decide) (by decide) (by decide) (by decide)
    ⟨0, 0⟩ ⟨1, -1⟩ ⟨0, 0⟩ ⟨0, 0⟩ (by decide) (by decide) (by decide) (by decide)) (by decide)

end Spec

end HadwigerNelson
