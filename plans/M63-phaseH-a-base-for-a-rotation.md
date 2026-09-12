# M63 phase H — building a base FOR a rotation, instead of inheriting one

*Written 2026-09-12 at the close of phase G by the agent that screened the new rotation, as a handoff
to a fresh session with **zero conversation memory**. Everything needed is here or named by path.
Phase G's own record is `plans/M63-phaseG-bases-and-rotations.md` §§12.1–12.6; the advisor's is
`plans/POROS-2026-09-12-m63-rotation-screen.md`.*

---

## §0 — The two sentences that must not be lost

**1. The new rotation is UN-ELIMINATED, not alive.** Nothing in phase G shows it produces anything. It
shows that the argument which four-coloured its arena on one lattice **cannot be made** on a base
containing one particular point. That is the removal of an obstruction, not a result.

**2. The filter is one-sided, so SILENCE IS NOT EVIDENCE.** The residue certificate fires ⟹ the arena
is four-colourable. It stays silent ⟹ *nothing whatever*. A builder who stops at the first ambiguous
answer will mistake "the certificate said nothing" for "we found something", and a builder who forgets
sentence 1 will oversell. Both errors have the same fix: the only positive result is a finite arena
that a solver refuses to four-colour **and** a kernel certificate afterwards.

---

## §1 — The problem, for someone who has never seen this project

How many colours does the plane need so that no two points exactly 1 apart share a colour? The answer
is 5, 6 or 7. The lower bound 5 is proved by exhibiting a finite set of plane points, edges between
pairs exactly 1 apart, that cannot be four-coloured. The smallest known has **509 points**
(`[Parts2020a]`). His construction — *type M* — takes a lattice of candidate points (the **base**),
makes a second copy **rotated** about a shared centre, and keeps the cross edges the rotation creates.
He writes in print: *"Working constructions of type M with other rotations are not known yet."*

Phase G enumerated, exactly, every rotation with `cos θ` in the coordinate field that can carry a cross
edge on his lattice: **26 angles, 11 rotation classes up to the lattice's symmetries, 2 that survive
the arithmetic filters** — his own, and one new one. The new one was then **eliminated on his lattice
at every radius**, by an explicit four-colouring checked edge by edge. Phase G then found *why*, and
the why is the reason this phase exists.

**The coordinate field throughout is `K = ℚ(√3, √11)`.** A point is a pair of `K` elements. In code an
element of `K` is a 4-tuple of fractions `(a, b, c, d)` meaning `a + b√3 + c√11 + d√33`.

---

## §2 — What phase G proved, in the order it matters here

### 2.1 The cross-edge law, and the single parameter everything reduces to

For a rotation `ρ = cos θ + i·sin θ` with `cos θ ∈ K` and `sin θ ∉ K`, a cross edge between `u` in the
fixed copy and `ρv` in the rotated copy forces **`u` and `v` collinear with the centre** — this is a
**theorem**, not a measurement: writing `conj(u)v = p + iq`, the condition `Re(ρ·conj(u)v) = k` splits
over the `K`-basis `{1, sin θ}` and *forces* `q = 0`, because `sin θ ∉ K`. So `v = λu` with `λ ∈ K`, and

```
a = |u|² = 1/(λ² − 2 cos θ · λ + 1) ,      d² = |u − v|² = (1 − λ)² a ,
σ = a + |v|² = a(1 + λ²) .
```

`λ = 1` is the **equal-radius family** (`d² = 0`); `λ = 0` is the centre family (`a = 1`). Read from a
point instead: **a ray through a `K`-point of squared norm `n` carries a cross edge iff `1/n − sin²θ`
is a square in `K`**, and then `λ = cos θ ± √(1/n − sin²θ)`.

### 2.2 The certificate that kills a rotation, and the criterion that keeps one alive

Let `φ` be Theorem B's residue colouring of `K²` — the project's kernel-checked four-colouring of every
unit-distance graph drawn in `K²` (`Proofs/HadwigerNelson/FieldWall4.lean`, `chromaticNumber_seamPlane`;
implemented in `tools/residue_colouring.py`). Colour the fixed copy by `φ(p)` and the rotated copy by
`φ(p) + δ` for a constant `δ ∈ 𝔽₄`. Both interior blocks stay proper (they are the same edge set, and
adding a constant relabels). A cross edge `(i, j)` is proper iff `φ(p_i) − φ(p_j) ≠ δ`. So:

> **the arena is four-colourable as soon as some `δ` lies outside `Δ = { φ(p_i) − φ(p_j) }`.**

`φ` colours all of `K²`, so this never mentions the radius. Its contrapositive is the design criterion:

> **A base keeps a rotation un-eliminated only if it realises a radius sum `σ` with
> `v_𝔭(σ − (σ−1)/cos θ) > 0` at BOTH primes above 2** — both, because one free prime is enough to kill.

Call such a `σ` **live**. Verified against every family of every rotation class on his lattice, **zero
mismatches**. Spot checks: his equal-radius family `σ = 8 → d² = 0`; his auxiliary family
`σ = 17/3 → d² = 1/3` (a unit, not live); the centre family `σ = 1 → d² = 1` for every rotation.

### 2.3 Why the new rotation died on his lattice

Its equal-radius family needs a base point at squared norm `1/(2 − 2cos θ) = (7 + √33)/3`. In his
lattice's own integers that is `S = a² + 33b² + 3c² + 11d² = 336` with `P = ab + cd = 24` under his
congruences — **and that system has no solution.** Verified directly, with a positive control: the
identical search returns **30** solutions at his own angle (`S = 576, P = 0`, exactly the 30 points his
census reports) and **0** here. The instrument finds solutions when they exist.

So the death was **his lattice's**, not the angle's.

---

## §3 — The witness, exactly (handoff item 1)

**Re-derive this before trusting it. Do not lift the numbers on faith.**

```
u  =  ( 1/3 − √3/2 − √11/6 ,  1/3 + √3/2 + √11/6 )       ≈ (−1.08546, 1.75213)

as 4-tuples:   x = (1/3, −1/2, −1/6, 0)      y = (1/3, 1/2, 1/6, 0)

|u|²  =  7/3 + (1/3)√33   =   (7 + √33)/3   =   1/(2 − 2 cos θ)      EXACTLY
radius 2.061113        cos θ = 11/32 + (3/32)√33 ≈ 0.882303
```

**Which check verified it, and why that one.** The unit-distance check is **not** the cross-edge law
that generated the census — a wrong law *invents* edges, which makes an arena denser and a refusal
cheaper, so the law must never verify itself. It is the independent expansion of `|u − ρu|²` in
`K[x]/(x² − D)` with `D = sin²θ = 1 − cos²θ` and `x` a formal square root:

```
u − ρv = ( uₓ − c·vₓ + v_y·x ,  u_y − c·v_y − vₓ·x )
rational part = (uₓ − c vₓ)² + (u_y − c v_y)² + D(vₓ² + v_y²)      must equal 1
radical part  = 2[ (uₓ − c vₓ)v_y − (u_y − c v_y)vₓ ] = 2[uₓv_y − u_yvₓ]   must equal 0
```

For this witness the run returns **rational part 1, radical part 0**, exactly. Note the second line:
**`cos θ` cancels from the radical coefficient**, so "the radical part vanishes" *is* collinearity with
the centre, for every rotation at once — derived, not assumed.

The pair's own difference is `0`, so it is `φ`-monochromatic at both primes: `σ = 2(7+√33)/3` is live.
All four Galois conjugates of the radius are positive (`(7 ± √33)/3 = 4.2482, 0.4185`), so a
totally-real disk cut admits the point.

---

## §4 — What a candidate base must satisfy (handoff item 2)

**The distinction that carries the whole risk: which of these is proved necessary, and which is
inherited from how `[Parts2020a]`'s lattice happens to be built.** Building a base for the first time
means the inherited ones are assumptions, and an assumption treated as a requirement will throw away
the base that works.

| # | requirement | status | how to check it |
|---|---|---|---|
| **H1** | **realises at least one live `σ`** (§2.2) | **PROVED NECESSARY.** Without it the residue certificate fires and the arena is four-colourable at every radius, by a colouring anyone can re-check edge by edge | one exact 2-adic test per radius sum; microseconds |
| **H2** | **drawn in `K²`** | **setting, not a requirement.** A base leaving `K` escapes this certificate trivially, but also leaves every instrument phase G built, and the arithmetic wall results (`CLAUDE.md` G1, G35) then apply instead | — |
| **H3** | **cross-edge endpoints within radius `1/\|sin θ\| = 2.124575`** | **PROVED.** The ellipse `1 = t² + s² − 2ts·cos θ` bounds both endpoints. Everything beyond that radius is padding that can only tighten the colouring problem, never add a cross edge | exact: `sin²θ · \|u\|² ≤ 1` |
| **H4** | **carries ≥ 2 kinds at this angle** | **INHERITED.** `[Parts2020a]` §4 says *"the existence of triangles of the second kind is essential"*, and M62 §R20 measured on **one** arena (his, at his angle) that one-kind subsets are all four-colourable and both-kinds subsets refuse. That is a measurement on one object, not a theorem. **Do not discard a one-kind base without asking it** | `tools/typem_exact.py census --base <spec>`, seconds |
| **H5** | **closed under negation, `√3 ↦ −√3`, `√11 ↦ −√11`, and both** | **INHERITED, and it is a TOOLING requirement rather than a mathematical one.** The census collapses four angles into one rotation using these symmetries (§11.6); on a base lacking them the key **over-merges**, tests one representative and silently eliminates an untested sibling. The screen therefore REFUSES such a base. A builder may legitimately work asymmetrically — but must then screen every angle separately and turn the gate off deliberately | `phaseg_screen.py`'s C1 gate: apply each map to the point set, require zero images outside |
| **H6** | **enough unit-distance structure to have any chance of refusing four colours** | **INHERITED and unquantified.** His lattice is rich because it is a Minkowski sum of hexagonal wheels. No theorem says how much is enough. The honest proxy is his own number: 3,433 points carry 28,566 unit edges at radius 2.44 | `typem.unit_edges_fast`, then the solver |

**An enabling fact worth having before you worry about discreteness.** `K²` is dense in the plane, so a
`ℤ`-module in it is generally dense too — but the **totally-real disk cut** (admit a point only when
*every* Galois conjugate of its squared norm is `≤ r²`) always yields a **finite** set, because
`|p|² = x² + y²` is totally positive for `p ≠ 0` and the trace form is therefore positive definite on
`K² ≅ ℚ⁸`. So **any** finitely generated `ℤ`-module in `K²`, cut that way, is a legitimate finite base.
Discreteness is not the obstacle; `typem.parts_lattice`'s own cut (`tools/typem.py`, the `S`/`P` test)
is this cut written out for one module, and it is exact integer arithmetic with no radical evaluated.

**The obvious first candidate, stated so it can be refuted quickly:** the `ℤ`-module generated by
`parts_lattice`'s four generators **together with `u`**, closed under the three Galois maps and
negation (finitely many images, so closure terminates), cut by the totally-real disk at radius ≥ 2.0612.
It satisfies H1 and H3 by construction. **H4 and H6 are the live questions**, and H4 is seconds away.

---

## §5 — What is already on disk (handoff item 3)

*Nothing under `tools/` is trusted; the Lean kernel re-derives anything that matters. But do not
rebuild these.*

| what | where | note |
|---|---|---|
| the angle census, exact | `tools/typem_exact.py`, `census --base parts:2.44` | every rotation with `cos θ ∈ K` carrying a cross edge, grouped into classes up to verified base symmetries, with the wall and 11-inertness. `build_base` is where a new base spec is added |
| the exact sign predicate | `typem.ksign`, `typem.kcmp` | **a float may propose; it may never decide.** `kfloat` is for display and sort keys only |
| squareness in `K` | `typem.k_is_square` | tests; does **not** return the root — see §5.1 |
| **the cross-edge law as a parameter** | `typem.CrossLaw.collinear(cos)` | takes any `cos ∈ K`; refuses structurally when `1 − cos²` is `≤ 0` or a square in `K` (then the rotation lies in `K(i)` and Theorem B four-colours everything) |
| the arena and the ask | `typem.Arena`, `typem.refuses_four` | `Arena` puts the whole interior edge set into both blocks and merges only the centre |
| the residue colouring | `tools/residue_colouring.py`: `sqrt33_2adic(17)`, `sqrt33_2adic(239)`, `residue_of_coords(x, y, S)` | the two primes above 2. Returns an `𝔽₄` element as a bit pair, or `None` when not 2-integral |
| **the whole phase-G screen** | `tools/phaseg_screen.py` | symmetry gate · wide-proposal edge control **and its self-test** · calibration against the census · the interior-block check · variant isomorphism as an explicit permutation · the independent `K[x]/(x²−D)` recount · the residue certificate · `σ` and `d²` per kind |
| the census artifacts | `data/m62/rotations-exact-parts-r{2.0,2.44}.json`, `…-moser-r2.05.json` | |
| **the screen artifact, with the `σ` spectrum per class** | `data/m62/m63-phaseG-screen-r2.44.json` | `results[].cross.kinds[]` carries `radii`, `sigma`, `d_squared`, `equal_radii`, `ordered_pairs` — this is what makes the criterion **re-usable on a new base instead of re-run on it** |

### 5.1 — The one function you will need that does not exist

`typem` tests squareness but never returns the root. Phase G used this; lift it:

```python
def ksqrt(x):                      # the square root of x in K, or None
    a, b, c, d = x; A, B = (a, b), (c, d)
    if B == (0, 0):
        r = T.f3_sqrt(*A)
        if r is not None: return (r[0], r[1], Fr(0), Fr(0))
        r = T.f3_sqrt(A[0]/11, A[1]/11)
        return (Fr(0), Fr(0), r[0], r[1]) if r is not None else None
    A2 = (A[0]*A[0] + 3*A[1]*A[1], 2*A[0]*A[1])
    B2 = (B[0]*B[0] + 3*B[1]*B[1], 2*B[0]*B[1])
    n = T.f3_sqrt(A2[0] - 11*B2[0], A2[1] - 11*B2[1])
    if n is None: return None
    for sg in (+1, -1):
        p = T.f3_sqrt((A[0] + sg*n[0])/2, (A[1] + sg*n[1])/2)
        if p is not None and p != (Fr(0), Fr(0)):
            pk = (p[0], p[1], Fr(0), Fr(0))
            root = T.kadd(pk, T.kmul(T.kdiv((B[0], B[1], Fr(0), Fr(0)), T.kscale(pk, 2)),
                                     (Fr(0), Fr(0), Fr(1), Fr(0))))
            if T.kmul(root, root) == x: return root     # always verify; never trust the branch
    return None
```

### 5.2 — The criterion in the form that takes a base's radius-sum list

```python
ZERO4 = (Fr(0),)*4
PRIMES = [RC.sqrt33_2adic(17), RC.sqrt33_2adic(239)]

def d_squared(sigma, cos):          # sigma - (sigma - 1)/cos, all exact in K
    return T.ksub(sigma, T.kdiv(T.ksub(sigma, ONE), cos))

def is_live(sigma, cos):            # positive valuation at BOTH primes, or the rotation dies
    d2 = d_squared(sigma, cos)
    return all(RC.residue_of_coords(d2, ZERO4, S) == (0, 0) for S in PRIMES)
```

`residue_of_coords(...) == (0,0)` is `v_𝔭 > 0`; `None` means not 2-integral, hence valuation `< 0`,
hence not live — and `None != (0,0)` handles it, but **assert on it rather than letting it pass
silently.**

---

## §6 — My instrument failure, in full (handoff item 4)

**This is the most useful thing in this document, because it is the error that will recur the moment
anyone enumerates candidate lattices, and its output looks exactly like success.**

I asked: *is any live radius sum realisable as an actual `K`-point?* I swept **781,284 distinct squared
norms** of points I described to myself as "general-shape `K`-points", tested each for a live kind, and
got:

```
NEW rotation :  10 norms carry a cross edge,  0 give a LIVE kind
rho15        :  22 norms carry a cross edge,  9 give a LIVE kind
```

That reads as a decisive negative **with a working positive control attached** — the sweep found the
record's own live families, so the instrument evidently worked. **It was wrong.** The generator built
the first coordinate from all four components of `K` but the **second coordinate only from `ℚ + ℚ√3`**.
The witness in §3 needs a `√11` component in its second coordinate. **The sweep could not represent the
object it was searching for**, so its zero was structural, not empirical — and the positive control
could not detect that, because the record's own witness (`u = (−√3, 1)`) *is* expressible in the
restricted shape.

**The rule this gives you, and it is the one to carry into lattice enumeration:** a positive control
proves the instrument finds *things of the shape it can represent*. It says nothing about shapes the
generator excludes. So before believing any zero over a family, **write down the generator's image and
check the target is inside it** — and prefer a constructed witness to any sweep, because a witness
cannot be an artefact of a generator. The focused test that found `u` took 30 seconds; the sweep that
denied it took longer and was wrong.

The same failure shape has now occurred three times in this milestone: a ray key that could not compare
a point with its antipode, a prefix recount that only reached the centre family because points are
sorted by radius, and this. All three produced confident, flattering silence.

---

## §7 — What would falsify the direction, cheaply (handoff item 5)

*Run these before building anything large. Each is minutes.*

| # | falsifier | cost | what a failure means |
|---|---|---|---|
| **F1** | **The base containing `u` carries only ONE kind at this angle.** Build the closure, run `typem_exact.py census` on it, read the kind count at `cos θ = 11/32 + 3/32√33` | seconds | H4 says type M needs two. It is an inherited assumption (§4), so this **demotes** rather than kills — but it makes the direction much weaker, and it should be known on day one |
| **F2** | **The closure has no unit edges, or far too few.** `typem.unit_edges_fast` on the cut base | a minute | H6. His lattice runs ~8.3 unit edges per point at radius 2.44. An order of magnitude below that and the arena cannot plausibly refuse |
| **F3** | **Closing under the three symmetries destroys the live `σ`** — i.e. the symmetry images of `u` re-introduce a family that lets the certificate fire again anyway | seconds: rebuild `Δ` and test all four `δ` | this would be the sharpest possible kill, and it is **the first thing I would check**. The certificate is about `Δ` over the *whole* cross-edge set, so a base that adds points can only add differences to `Δ`, never remove them — **so this cannot fire against you.** Adding material can only make the certificate *less* able to fire. State this explicitly to yourself before spending an hour on it |
| **F4** | **The arena is four-colourable anyway.** The certificate is one of many colourings; the additive family (`CLAUDE.md` row 50) and anything else may still colour it | one SAT call, ~10 s for a SAT verdict | **the expected outcome**, and not a refutation of the method — only of that base. Iterate on the base |
| **F5** | **No `ℤ`-module in `K²` closed under the three symmetries contains `u`** | it does not: closure under a finite group of a finitely generated module is finitely generated, and §4's enabling fact makes the cut finite | listed only so nobody spends a week on it |

**F3 deserves its sentence spelled out because it inverts the usual intuition.** Growing a base can
only *add* elements to `Δ`, and the certificate needs *some* `δ` outside `Δ`. So growth can only make
the certificate harder to fire, never easier. Once a base contains `u`, no amount of further material
restores the elimination. **The elimination is not recoverable by enlarging the base** — which is the
exact opposite of the usual monotonicity in this project, where adding material only tightens.

---

## §8 — Discipline (non-negotiable, and it caught two errors in phase G)

1. **Register predictions before the run**, in the plan and on the command line, and score them
   afterwards as met / not met / not decided — never "partly".
2. **Point every instrument at a known positive before believing any zero.** The calibration is the
   record's own rotation on his own lattice: `126` cross edges decomposing `60 centre + 36
   off-diagonal + 30 equal-radius` at `cos = 7/8`, and `60 + 66 + 0` at `cos = −7/8` under the
   census's own convention. **If that does not reproduce, stop and report.**
3. **The census's `diag` column counts pairs `(i,i)` and is NOT invariant under the base's symmetries.**
   Negating the second copy turns `(u,u)` into `(u,−u)` — same radii, same kind, different label. Count
   kinds by radii, never by that column.
4. **Count rotations up to base symmetry, never angles.** Four angles that are one rotation reported as
   four negatives is a false count.
5. **A verdict names its radius, every time**, and an elimination carries an exact quantifier or it is
   not an elimination.
6. **Every check needs a positive signal for the thing that did not happen** — assert a count, never
   wait for an event. `CLAUDE.md` § "Make the gate fail, and watch it fail" has the nine instruments
   that failed by silence inside one phase.
7. **Never edit a running script; never `lake build` (use `./scripts/build.sh`); report any unexplained
   process crash immediately** — your own `timeout` firing is not one, and say so explicitly.

---

## §9 — What phase G actually delivered, so this phase is aimed and not repeated

1. **The census**, exact and exhaustive: 26 angles → 11 rotation classes → 2 past the arithmetic
   filters on his lattice, his own being one. Answers `[Parts2020a]` §4's sentence *for that lattice*.
2. **The residue certificate**: a radius-free, one-sided, proof-grade filter that four-colours a type-M
   arena from the base's own residues, killing **5 of the 11 classes outright**.
3. **The live-`σ` criterion**, base-free: `d² = σ − (σ−1)/cos θ`, live iff `v_𝔭(d²) > 0` at both primes
   — which **inverts into a design target**, naming from the cosine alone the radius sums a base must
   contain, with the two radii as roots of `x² − σx + ((σ−1)/(2cos θ))²`. This replaces *"rich on rays"*
   with a necessary condition that has a proof behind it.
4. **The mechanism for a gap this project carried unnamed** (to become grokking **G52**): breaking the
   2-adic wall is a property of the field the **rotated** copy lives in, while the arena is coloured by
   the residues of the **base** points, which never leave `K`. So a wall-breaking rotation escapes the
   base's own four-colouring **only if its seam actually uses the wall-breaking — and it uses it
   through a `φ`-monochromatic kind.** Wall-breaking is necessary and visibly **not** sufficient.
5. **The witness of §3**, and with it the first evidence that the fifty-year monoculture at one rotation
   may be an artefact of one lattice rather than a fact about the plane. **Evidence, not a result** —
   re-read §0.
