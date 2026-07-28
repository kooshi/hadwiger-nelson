# M02 — Exact geometry

> The multiquadratic field as a kernel-computable ℤ-tower, the ring hom down to ℝ, and the
> unit-distance certificate whose validity is a *decidable integer identity*. This is the
> instrument M04/M05 point at 7877 edges; M02 aims it at the Moser spindle's 11.

> **De-risk already done (2026-07-23, scratch prototype).** A minimal `Adjoin`-tower with granular
> instances certified all 11 spindle edges as scaled unit distances by **kernel `decide`**, total
> elaboration ~4 s, `#print axioms` = `[propext]` only — no `sorryAx`, no `Lean.ofReduceBool`. The
> central architectural bet (that exact geometry stays in the kernel, no native purchase) is
> **confirmed for the geometry half.** M02 turns that prototype into a sound, reusable library.

## Why now

M01 left the reduction wanting a hypothesis `∀ e ∈ E, dist (p e.1) (p e.2) = 1` — real unit
distances. Producing that at scale is the open problem M02 solves: `dist … = 1` over ℝ with
`Real.sqrt` is an `nlinarith`/`norm_num` obligation *per edge*, which will not survive 7877 edges.
M02 replaces it with an **exact algebraic** obligation — `distSq p q = denom²` as an equality in a
ℤ-algebra — that the kernel decides by integer reduction, and a **once-proved soundness theorem**
that turns the decidable identity back into the real `dist = 1` M01 consumes.

## The field, and the representation the de-risk validated

Coordinates live in **ℚ(√3,√5,√7,√11)**, represented as an iterated quadratic extension with an ℤ
leaf and a single global denominator per graph:

```lean
structure Adjoin (d : ℕ) (K : Type*) where   -- K[√d]
  re : K                                       -- the part with no √d
  im : K                                       -- coefficient of √d
abbrev Q4 := Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))
```

Multiplication is `(a + b√d)(c + e√d) = (ac + d·b·e) + (ae + bc)√d`. **ℤ leaf, not ℚ**: the kernel
accelerates `Int` via GMP but routes `Rat` through `Nat.gcd`, which it does not — so a rational
representation would make the check unreducible. Coordinates are cleared to integers by one
denominator (spindle: `denom = 12`), and a real unit distance becomes `distSq_scaled = denom²`.

**The load-bearing observation, restated for M02**: we never need `eval : Q4 → ℝ` injective, only a
**ring homomorphism**. `distSq` is a polynomial in the coordinates, so a ring hom commutes with it;
one `Real.sq_sqrt` per generator (`(√3)² = 3`, …) is the entire number-theoretic content. No basis
independence, no minimal polynomials.

## Scope

**In.**

1. `Adjoin d K` with its ring structure. The de-risk used granular per-op instances to dodge the
   `CommRing` proof; M02 owes the real thing — `CommClass`/`CommRing (Adjoin d K)` from
   `CommRing K` — because `eval` must be a `RingHom` (both sides rings) and `distSq`'s soundness
   rides on ring-hom-commutes-with-polynomial. This is M02's one genuine proof obligation; the rest
   is plumbing. (Discharge route to weigh in the obligation pass: `ext`-to-components then `ring`,
   versus an isomorphism to a Mathlib construction — `Zsqrtd`, `AdjoinRoot (X²-d)`, or
   `K[X]/(X²-C d)`. `Zsqrtd` only adjoins to ℤ, so it does not tower; the generic proof is likely
   unavoidable but should be *one* proof, reused at all four levels.)
2. `eval : Adjoin d K →+* ℝ` given `eval_base : K →+* ℝ` and a real `r` with `r² = d` (`r = √d`):
   `eval ⟨a,b⟩ = eval_base a + b·r`. The tower composes four of these; `Q4.eval : Q4 →+* ℝ`.
3. `Pt K := K × K` (or a `structure`), `toPlane : Pt Q4 → ℂ` via `eval`, and
   `distSq : Pt K → Pt K → K` the exact squared distance.
4. `UDCert` — vertices `Array (Pt Q4)` (or `List`), edges `List (Fin n × Fin n)`, a `denom`, and
   `Valid : Bool` = every listed edge has `distSq = denom² • 1`. Kernel-decidable.
5. **Soundness**: `Valid cert = true → ∀ e ∈ cert.edges, dist (toPlane vᵢ) (toPlane vⱼ) = 1` —
   the exact bridge into M01's `add_one_le_chromaticNumber_unitDistance_edgeList` hypothesis.

**Out** (carried forward). The colouring/SAT side and χ ≥ 4 → M03. De Grey's 1581 vertices → M04.
M02 stops at "the spindle's 11 edges are certified unit distances", proved by `decide`.

## Terminal test (the M02 gate)

- `Adjoin`/`Q4` build; `#eval Q4.eval ⟨…⟩` shows the right reals on a couple of generators.
- `moserSpindle : UDCert` with the 7 vertices / 11 edges from `tools/spindle.json`.
- `example : moserSpindle.Valid = true := by decide` — **kernel**, and `#print axioms` on it shows
  no `sorryAx`/`ofReduceBool` (the de-risk says this holds; the gate re-confirms on the real def).
- `moserSpindle_edges_unit : ∀ e ∈ moserSpindle.edges, dist (toPlane …) (toPlane …) = 1`, via
  soundness — the object M03 feeds to the reduction.
- Spec sanity: `#eval` a non-edge's `distSq` and confirm it is *not* `denom²` (the certificate is
  not vacuously all-true); a `#guard` on the vertex/edge counts (7 / 11).
- Mutation audit: perturb one vertex coordinate by 1 and confirm `Valid` flips to `false`.

## Domain-modeling pass — findings (step 5, applied)

Run as a fresh `debruijn-domain-modeling` pass. Three of the five questions were settled by
**measurement** rather than inspection, using `tools/emit_geometry.py` — a self-contained Lean
emitter (no Mathlib, granular instances) whose elapsed time is kernel reduction and nothing else.

**(1) `Adjoin` must be ours; Mathlib's candidates are disqualified — for a *computational* reason.**
`Zsqrtd d` has ℤ components and does not tower. `AdjoinRoot f` is `R[X] ⧸ span {f}` — a **quotient**,
and `decide` cannot reduce through `Quotient.mk`. The whole point of M02 is kernel computation, so
the right *mathematics* (a quotient of a polynomial ring) is the wrong *representation*. Define
`Adjoin` concretely and prove `CommRing` directly. This is the recurring shape of the milestone:
Mathlib is where the reasoning lives, a concrete structure is where the computing lives, and the
two are joined by a bridge lemma rather than by picking one.

**(2) `d : ℕ` stays a type index.** Intrinsic: `K[√3]` and `K[√5]` are genuinely different rings and
`Mul` must dispatch on `d`. A field would make multiplication ill-defined between mismatched
radicands — exactly the illegal state the index makes unrepresentable.

**(3) The radicand acts as a *scalar*, not a ring element — measured 1.67× .** Writing the
multiplication law as `x.re*y.re + (d : K) * (x.im*y.im)` treats `d` as a full tower element that
is zero in 15 of its 16 components, turning each level's 4 sub-multiplications into 5: leaf-mult
count per `Q4` product goes `4⁴ = 256` → `5⁴ = 625`. Measured at 60 vertices / 99 edges: kernel
`decide` **23.1 s → 13.8 s** by replacing the cast with a scalar action pushed to the ℤ leaves.
`Adjoin d K` is a free `K`-module of rank 2 whose multiplication uses `d` as a scalar; modelling it
as a ring element was incidental structure borrowed from how the formula is written on paper.

So M02 carries two layers, deliberately: a **computational** one (`Adjoin.mul`, `Adjoin.smulNat`,
… defined directly, kernel-fast) and an **algebraic** one (the `CommRing` instance, `eval` as a
`RingHom`), joined by `smulNat_eq : smulNat n x = (n : K) * x`. `distSq` is written with the bare
computational operations, *not* typeclass notation, so kernel reduction never projects through
Mathlib's algebraic hierarchy. Compute with the fast primitive, reason with the structure — the
same Bool/Prop discipline one level up.

**(4) `UDCert`'s dependent shape is wrong, but not for the reason expected.** Measured: the
`indexed` presentation (`verts` list + `ℕ` index pairs, `Valid` doing lookups) and the `resolved`
one (edges carrying their endpoint points, no lookup at all) cost **the same** — 24.7 s vs 26.1 s at
60/99. **Lookup is not the bottleneck; the tower arithmetic is.** That frees the choice to be made
on proof cleanliness and file size instead, where `indexed` wins outright: `resolved` duplicates
every point once per incident edge (~10× at de Grey's average degree), and the emitted file is 56 K
vs 20 K at 60 vertices.

What *is* wrong is `edges : List (Fin verts.length × Fin verts.length)` — a field's type depending
on another field's value, which will breed casts the moment M04 generates the data. Replace with a
non-dependent presentation carrying `n` as a parameter, matching M01's interface (`p : Fin n → V`,
`E : List (Fin n × Fin n)`) exactly.

**(5) `Pt` stays a structure.** Named projections `x`/`y` read better than `.1`/`.2` at every use
site and the `deriving DecidableEq` is the same either way.

### The open risk this pass surfaced

The measurements above used **bare core `Int` with granular instances**. The real M02 file has
Mathlib's `CommRing` in scope, and kernel reduction through Mathlib's algebraic hierarchy
(`CommRing.toRing.toMul…`) may be materially slower than through a bare `Mul` instance. The
two-layer design is the mitigation — `distSq` calls `Adjoin.mul` directly — but **the cost must be
re-measured on the real file** before M04 commits. Tracked as M02's first implementation task.

## Open questions for the modeling passes

- **Domain (step 5):** the `CommRing (Adjoin d K)` discharge route (above); whether `Pt` is `K × K`
  or a named `structure`; `Array` vs `List` for the vertex store given the kernel's O(n) `Array.get`
  (the de-risk used `List` pairs precisely to avoid indexing — likely the right call, revisited at
  M04 scale); whether `distSq = denom²` is checked as `Adjoin` equality (`DecidableEq`) or via a
  `Bool`-valued `distSqEq` with an `_iff` bridge.
- **Obligation (step 6):** the ring-axiom proof shape (one generic lemma vs four); how `eval`'s
  ring-hom laws are proved (`ext`/`simp`/`ring` vs `RingHom` combinators); the soundness proof —
  `eval (distSq p q) = (dist (toPlane p) (toPlane q))²` and the `Real.sqrt` inversion.
- **Experience (step 7):** `UDCert`'s field names and the `Valid`/`toPlane`/soundness API M04 will
  call 7877 times; the docstring contract that nobody unfolds `eval` or `Adjoin.mul`; whether
  `moserSpindle` and `deGrey` share a constructor from `tools`-emitted data.
