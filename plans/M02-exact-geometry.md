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

### Scale: the geometry must be checked in chunks (measured)

| edges | kernel `decide` | peak RSS (incremental) |
|---|---|---|
| 99 | 13.8 s | small |
| 514 | 87 s | ~0.85 GB |
| 7877 (all of de Grey) | **aborted** — still running at 5 min, 8.5 GB and climbing | — |

Cost is ~0.17 s/edge and memory is roughly linear in the chunk size, because a single
`List.all` over the whole edge list builds one enormous kernel term. So **M04 must split the
geometry check into chunks** — ~16–32 slices of 250–500 edges, each its own `decide`. Each slice is
under a minute and under a gigabyte; slices are independent, so they parallelise across cores
(≈12–16 at once fits this box's memory) for a few minutes of wall clock.

This is the same shape as the colour-cube split on the SAT side, and it arrives for the same reason:
one monolithic certified computation is infeasible, many small ones are routine. It costs nothing in
trust — `Valid` over a chunk is the same theorem, and the chunks' conjunction is the whole.

M02 itself is unaffected: the Moser spindle is 11 edges.

### The open risk this pass surfaced

The measurements above used **bare core `Int` with granular instances**. The real M02 file has
Mathlib's `CommRing` in scope, and kernel reduction through Mathlib's algebraic hierarchy
(`CommRing.toRing.toMul…`) may be materially slower than through a bare `Mul` instance. The
two-layer design is the mitigation — `distSq` calls `Adjoin.mul` directly — but **the cost must be
re-measured on the real file** before M04 commits. Tracked as M02's first implementation task.

## Obligation-modeling pass — findings (step 6, applied)

Fresh `debruijn-obligation-modeling` pass. It caught a **false theorem** in the skeleton, which is
the whole reason the pass exists.

### The scaling bug — the skeleton stated something unprovable

`Pt.toPlane p = ⟨eval p.x, eval p.y⟩` with `dist (toPlane p) (toPlane q) = 1` **cannot be proved**.
Stored coordinates are multiplied by `denom` so they are integers, so `eval` of a stored coordinate
is `denom` times the real one, and two endpoints of a listed edge sit at distance `denom`, not `1`.
Checked against the spindle data: `distSq(A,B) = 144 = 12²` with `denom = 12`.

The fix is not a weaker statement but the right one: the scale belongs to the **certificate**, so
the plane point is `Pt.scaled p D = ⟨eval p.x / D, eval p.y / D⟩` and `UDCert.point` uses `c.denom`.
The conclusion `dist = 1` then holds exactly.

This also **locates `denom ≠ 0`**: it is consumed by the division, and nowhere else. A hypothesis
whose use site you cannot name is either dead weight or a bug not yet found — here it was the
second.

The payoff is immediate and is the convergence signal the pass drives at:
`add_one_le_chromaticNumber_of_valid` went from a `sorry` to a **one-line composition** of
`add_one_le_chromaticNumber_unitDistance_edgeList` with `valid_sound`, because the statement finally
matched what M01 consumes.

### `eval`'s `hr` is load-bearing — the underscore was lying

`map_mul'` is where `r ^ 2 = d` is consumed: expanding both sides leaves
`d · eb(x.im) · eb(y.im)` against `eb(x.im) · eb(y.im) · r²`, equal exactly when `r² = d`. Renamed
`_hr → hr`; an underscore claims a hypothesis is unused, and this one carries multiplicativity.

### The decomposition

| Obligation | Shape | Derives from |
|---|---|---|
| `NatScalar.smul_eq` (tower) | `ext <;> simp [NatScalar.smul_eq]` | the leaf's own `smul_eq`; the `0` components kill the cross terms |
| `mul_re` | one `rw` | `NatScalar.smul_eq` — the *only* place the scalar action is traded for the cast |
| `AddCommGroup`, `CommRing` | Zsqrtd's `refine { … with proofs := ?_ } <;> intros <;> ext <;> simp <;> ring` | pin `nsmul`/`zsmul`/`npow` to the `…Rec` forms and `natCast`/`intCast` to our instances, or the diamond returns |
| `eval.map_zero'/map_one'/map_add'` | `simp` / `ring` | componentwise |
| `eval.map_mul'` | `ring_nf` then `rw [hr]` | the one genuinely mathematical step |
| `eval_distSq` | `map_sub`/`map_mul`/`map_add` | ring-hom-commutes-with-polynomial |
| `dist_scaled_eq_one` | `Complex.dist_eq` → `norm_def` → `eval_distSq` → `√1 = 1` | needs `map_intCast` for `eval (D*D : ℤ) = (D:ℝ)²` |
| `valid_sound` | `List.all_eq_true` + `of_decide_eq_true` | membership from the `Bool` fold |
| `add_one_le_chromaticNumber_of_valid` | **closed** | direct composition |

### Mutation audit for the M02 gate

Each must **fail**: dropping `hD` from `dist_scaled_eq_one`; replacing `target` by `denom` (unscaled)
so `Valid` becomes false on the spindle; perturbing one spindle coordinate by 1 and re-running
`decide`.

## Experience-modeling pass — findings (step 7, applied)

Fresh `debruijn-experience-modeling` pass over the surface M03/M04/M05, the `tools/` emitters, and
the automation consume.

**(1) The simp destination is components, and the one asymmetry is safe.** `add_re`, `sub_im`, … are
`rfl` and drive goals out of the tower into `K`, where `ring` closes them. `mul_re` is the only
lemma that *changes* the term — it trades the fast `NatScalar.smul` for `(d : K) * _`. That is safe
because **the computational path never consults `simp`**: `Valid` is discharged by `decide`, i.e.
kernel reduction of the definitions. So the simp set normalises toward *provability* while the
kernel reduces toward *speed*, and the two never meet. Stated in the module docs, because a simp set
with no declared destination makes every user infer their own.

**(2) The chunking API — `ValidOn` is the unit of work.** M04 cannot put 7877 edges through one
`decide`, so the surface must make chunking natural rather than a workaround:

- `ValidOn c es` — the check restricted to a sublist. One `decide` per chunk, and (the point) one
  chunk per *module*, so they elaborate in parallel.
- `Valid c = c.ValidOn c.edges`, by `rfl`.
- `valid_of_chunks c chunks hjoin h` — glue. `hjoin : chunks.flatten = c.edges` is cheap for the
  kernel: list equality of index pairs, no tower arithmetic.

Chunking is a *proof strategy*, not a property of the object, so the certificate stays flat and only
the proof splits. The alternative — chunked `edges` in the structure — would push a `flatten` into
every downstream use, including M01's reduction.

**(3) Names that were lying.**

- `Pt.scaled` → **`Pt.toPlane p D`**. It *divides* by `D`; calling it `scaled` names the opposite
  operation and would plant a false belief at every read. `toPlane` names the destination and keeps
  M01's vocabulary.
- `UDCert.target` → **`denomSq`**. `target` forces a jump to learn what it is; `denomSq` reads at
  the use site.
- `Valid` stays `Bool` with `= true` at call sites (Mathlib convention), but now has its bridge:
  `validOn_iff : c.ValidOn es = true ↔ ∀ e ∈ es, …`, so downstream proofs never destructure a
  `List.all`.

**(4) The breakdown surface — `badEdges`.** When a certificate is wrong, `decide` says only "no",
and at de Grey's scale its failure term is unreadable. `c.badEdges` returns the offending edges
*with the squared distance actually found*, runs compiled (instant at any size), and is named in the
module docstring as the first thing to run. This is the candidates-computed-while-failing move: the
information exists at the moment of failure and dies unserialised unless the API emits it. It also
distinguishes the two likely faults — a transcription error gives a wild value, a scale error gives
a value off by a square factor.

**(5) Docstring contracts.** `Mul (Adjoin d K)`: reason via `mul_re`/`mul_im`, never unfold — the
scalar action is a computational detail the API does not promise. `Q4.eval`: reason via the `RingHom`
API, and note explicitly that it is **not** injective as far as this development is concerned, so no
proof may assume it is. That last sentence is load-bearing: injectivity is the assumption a reader
would most naturally and wrongly reach for, and the whole cheapness of the design rests on never
needing it.

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
