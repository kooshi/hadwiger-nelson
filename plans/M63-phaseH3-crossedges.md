# M63 phase H3 — cross edges at `cos θ = 3/4`. The record.

*Cross-edge engineer, 2026-09-12. Answers the question the product owner moved ahead of the module
build (`plans/M63-phaseH3-plan.md` §2): **does `cos θ = 3/4` admit off-diagonal cross edges, and of
what kinds?** Working code and evidence: `build/m63-phaseH3-crossedge/`.*

---

## §0 — The answer

**YES.** Over the shape-free base — the ℤ-span of its own 60 unit vectors, 16,309 points inside the
endpoint bound `R = 4/√7` — `cos θ = 3/4` has

> **252 cross edges = 120 centre + 60 diagonal + 72 off-diagonal**, all 252 confirmed by a direct
> exact distance computation, **0 invented**, on **six** off-diagonal radius families.

Of those, **84 are monochromatic under the residue colouring: 60 diagonal + 24 off-diagonal.**

The two quantities the product owner asked to be kept apart, side by side and labelled:

| | raw cross edges (centre / diagonal / **off-diagonal**) | monochromatic (total / **off-diagonal**) |
|---|---|---|
| `n = 4`, the 509-vertex record, on Parts's lattice | 126 = 60 / 30 / **36** | 30 / **0** |
| `n = 16`, `ρ₆₃`, on Parts's lattice | 126 = 60 / 30 / **36** | 54 / **24** |
| `n = 2`, on **Parts's shaped** lattice | 60 = 60 / 0 / **0** | 0 / **0** |
| **`n = 2`, shape-free unit-span base** | **252 = 120 / 60 / 72** | **84 / 24** |

**`n = 2` shape-free delivers exactly as many monochromatic off-diagonal cross edges as `ρ₆₃` — 24 —
and twice its raw off-diagonal count, at 37.5% of the radius and 64% of the base size.** Its
*share* is lower (24/84 = 0.286 against 24/54 = 0.444) because its diagonal is twice as large.

### The phase's premise, confirmed at the record's OWN rotation

**At `n = 4` — `cos θ = 7/8`, the rotation every published type-M construction uses — dropping the
coordinate shape turns 36 raw off-diagonal cross edges into 312, and 0 monochromatic ones into 144.**
Same rotation, same endpoint bound, same denominator; the only change is that the base is the ℤ-span
of its 60 unit vectors (195,961 points, rank 8) instead of Parts's shaped lattice (3,433 points,
rank 4). **That is the cleanest available demonstration that the shape, and not the rotation, was the
obstruction** — the claim this phase was chartered to test, now measured at the one rotation where
a like-for-like comparison exists. Full result in §14.4.

**Un-eliminated is not alive.** 24 monochromatic off-diagonal constraints is not a refusal of four
colours, and nothing here says the arena is 5-chromatic. What died is the reading that dropping the
shape at `n = 2` buys only a circle: it buys an off-diagonal structure where Parts's lattice has none.

---

## §1 — The cross-edge law, derived rather than adopted

An arena is a base `B ⊂ K²`, `K = ℚ(√3,√11)`, plus its rotated copy `ρB` sharing the centre; a cross
edge is `|u − ρv| = 1` with `u, v ∈ B`. Reading `K²` as `K(i)` and writing `conj(u)v = p + iq` with
`p = u·v` and `q = det(u,v)` up to sign, `ρ = c + is`:

```
|u − ρv|² = |u|² + |v|² − 2(c·p + s·q).
```

For the family `cos θ = (2n−1)/(2n)`, `sin θ = √(4n−1)/(2n)`, the sine leaves `K` (**gate B** of
phase H2 §5 — if it did not, Theorem B four-colours the whole arena). So `p, q, c ∈ K` while `s ∈ √D·K`,
`D = 4n−1`, and the equation **splits over the basis `{1, √D}`**:

- **(i) `q = 0`** — `u` and `v` are collinear with the centre;
- **(ii) `2c·(u·v) = |u|² + |v|² − 1`.**

Setting `v = tu` (legitimate: both coordinates lie in `K`) and `r = |u|²`:

```
r·Q(t) = 1,      Q(t) = t² − 2ct + 1 = (t − c)² + s².
```

**So the entire cross-edge structure is a one-parameter family indexed by `t ∈ K`**: `t = 1` is the
diagonal (the circle `|p|² = n`), `t ∈ {0, ∞}` the centre star, everything else off-diagonal. The
radius sum and the base-point separation are

```
σ = (1 + t²)/Q(t) ,       d² = |u − v|² = (1 − t)²/Q(t) .
```

### §1a — G52's formula: **correct, and here is its scope**

Eliminating `t` gives exactly `CLAUDE.md` G52's `d² = σ − (σ−1)/cos θ`. Verified algebraically and
numerically. **Its scope, which G52 does not state:** it needs `sin θ ∉ K` and `u, v ∈ K²`. With
those it is exact and base-free; without the first it is false, because the split into (i) and (ii)
is what produces it. G52's companion description — *"each handing back the two radii a base must
contain as roots of a quadratic"* — is also exactly right: the radii are the roots of
`z² − σz + ((σ−1)/2c)² = 0`.

### §1b — The endpoint bound is a consequence, not an assumption

`Q(t) ≥ s²` with equality at `t = c`, so `r ≤ 1/s²` for **every** cross edge — and at every Galois
conjugate, because `s²` is rational. Hence `R = 1/|sin θ| = 2n/√(4n−1)`, reproducing `8/√15 =
2.0656` at `n = 4`, `32/√63 = 4.0316` at `n = 16`, `4/√7 = 1.5119` at `n = 2`. **Material outside
that disk carries no cross edge at all** — measured too: the record's 126 is unchanged when its base
grows from radius 2.0656 to 2.44 to 3.0.

### §1c — The module form: a new base-free counting law

For a module of denominator `d`, the points of `(1/d)O_K²` on the line through a primitive `x̂` are
exactly `{(g/d)·x̂ : g ∈ O_K}` (`O_K` is a PID). With `ν = |x̂|²`, `t = h/g` and `H = h − g`:

```
ν · V = n d² ,        V = n g² − (2n−1) gh + n h²  =  g² + gH + n H² ,
```

**the principal binary quadratic form of discriminant `1 − 4n` — the family's own radicand.** Hence

- a line carries a cross edge **only if its primitive norm `ν` divides `n d²`**;
- the cross edges of kind `t` biject with `{z ∈ O_K² : |z|² = m}`, `m = n d²/V`, via `u = gz/d`,
  `v = hz/d` — so **their count is `Sh(m)`, with no base and no radius.**

Known answers it reproduces with nothing else supplied: `t = 1` gives `m = n d²`, whose `Sh` is
phase H2's *unconstrained ceiling* (60 at `n = 2, 4, 16`); `t = 0` gives `m = d²`, the unit shell
(60 at denominator 12).

### §1d — The 2-adic criterion for a monochromatic cross edge, and why `n = 2` is the poorest member

`d² = (g−h)² m/d²`, so at the prime `𝔭` above 2 (where `v_𝔭(d²=144) = 8`, `v_𝔭(2) = 2`):

```
v_𝔭(d²) = 2·v_𝔭(g−h) + v_𝔭(n) − v_𝔭(V) ,
```

and a cross edge is monochromatic exactly when this is positive. **`v_𝔭(n) = 2·v₂(n)` is the
member's whole 2-adic budget: 2 at `n = 2`, 4 at `n = 4`, 8 at `n = 16`.** `n = 2` is the poorest
member of the live family on the quantity G52 says is the live one.

**Checked against `ρ₆₃`, family by family** — 4 of its 6 off-diagonal families have `v_𝔭(d²) = 4`
(6 edges each), 2 have `v_𝔭(d²) = 0`, total monochromatic **24**, which is phase H2's recorded
number reproduced from a base-free criterion. Note the shape of it: the two members of a **conjugate
pair split**, one monochromatic and one separated.

---

## §2 — Step 2 first: three known-answer gates, all passed

Nothing in §1 or §3 was believed before these. Every edge is produced by the derived law **and**
confirmed by an independent direct computation of `|u − ρv|²` in `K(√D)` — two derivations sharing
only the field arithmetic, which is itself checked against `tools/typem.py`.

| gate | recorded | returned |
|---|---|---|
| `n = 4` endpoint bound | `8/√15 = 2.0656` | `√(64/15) = 2.0656` ✅ |
| `n = 4` base (radius 2.44) | 3,433 points | 3,433, **point set identical to `typem.parts_lattice`** ✅ |
| `n = 4` cross edges | `126 = 60 + 30 + 36` | `126 = 60 + 30 + 36` ✅, **126/126 confirmed, 0 invented** |
| `n = 4` monochromatic | 30, of which 0 off-diagonal | 30 / 0, at **both** primes above 2 ✅ |
| `n = 4` off-diagonal kinds | "one conjugate radius pair" | `t = (17 ± √33)/16`, radii `(17 ± √33)/6`, **one conjugate pair** ✅ |
| `n = 16` endpoint bound | `32/√63 = 4.0316` | `√(1024/63) = 4.0316` ✅ |
| `n = 16` base | 25,567 points | 25,567, identical to `typem` ✅ |
| `n = 16` cross edges | `126 = 60 + 30 + 36` | `126 = 60 + 30 + 36` ✅, **126/126 confirmed, 0 invented** |
| `n = 16` monochromatic | 54, of which **24** off-diagonal | 54 / **24**, at both primes ✅ |
| `n = 16` off-diagonal structure | "three radius families … including a rational pair `100/9 ↔ 64/9`" | exactly three conjugate families; the rational one is `t = 5/4`, radii `64/9, 100/9` ✅ |
| **`n = 2` on Parts's SHAPED lattice** (the third gate, from `plans/M63-phaseH2-the-family.md`) | "60 cross edges, every one a CENTRE edge. Zero diagonal, zero off-diagonal — stable from 1.5119 to 2.0 (499 → 1,603 points)" | cut 1.5119: **499 points, 60 = 60 + 0 + 0**; cut 2.0: **1,603 points, 60 = 60 + 0 + 0** ✅ |

**The rational pair `100/9 ↔ 64/9` was predicted before it was looked up.** My base-free kind table
at `n = 16` lists `t = 5/4` with radii `64/9, 100/9`, `σ = 164/9`, `m = 64`, derived from the cosine
alone with no lattice; phase H2 measured it on the lattice. That is the law's strongest single
confirmation.

### §2a — The shell counter, gated against six recorded values

`Sh(m) = #{(a,b) ∈ O_K² : a² + b² = m}` is re-implemented here from scratch and returns phase H2's
*unconstrained ceilings* at every value on record: `Sh(144) = 60` (unit shell), `Sh(288) = 60`
(`n = 2`), `Sh(576) = 60` (`n = 4`), `Sh(1296) = 108` (`n = 9`), `Sh(1728) = 84` (`n = 12`),
`Sh(2304) = 60` (`n = 16`), `Sh(2880) = 240` (`n = 20`). **Seven for seven.**

---

## §3 — Step 1: the base-free classification at `cos θ = 3/4`

### §3a — The rational kinds, provably complete

The form `V = 2g² − 3gh + 2h²` has least eigenvalue `1/2`, so `V ≤ n d² = 288` forces
`g² + h² ≤ 576` — an explicit finite box, searched exhaustively. **Eight off-diagonal rational
kinds**, with their radius sums, stated so the criterion is inherited rather than re-derived:

| `t` | `V` | `m = 288/V` | radii | **σ** | `d²` | `v_𝔭(d²)` | count over the full `(1/12)O_K²` |
|---|---|---|---|---|---|---|---|
| `2`, `1/2` | 4 | 72 | `1/2, 2` | **5/2** | 1/2 | −2 separated | `Sh(72) = 60` each |
| `3/2`, `2/3` | 8 | 36 | `1, 9/4` | **13/4** | 1/4 | −4 separated | `Sh(36) = 60` each |
| `−2`, `−1/2` | 16 | 18 | `1/8, 1/2` | **5/8** | 9/8 | −6 separated | `Sh(18) = 4` each |
| `6/5`, `5/6` | 32 | 9 | `25/16, 9/4` | **61/16** | 1/16 | −8 separated | `Sh(9) = 4` each |

**A theorem falls out.** At `n = 2` a rational off-diagonal kind can never be monochromatic: by
§1d it would need `v_𝔭(gh) < 2 + 2v_𝔭(g−h)`, which for coprime rational `g,h` forces both odd,
whence `V` is odd and `V | 288` leaves only `V ∈ {1, 3, 9}` — and `V = 1` is the diagonal while
`V = 3, 9` have no coprime off-diagonal solution. So **every rational kind at `n = 2` is separated
by the residue colouring**, which the table confirms.

### §3b — And the rational kinds are the WRONG generator, which is the point

**None of those eight is what the shape-free base actually realises**, and at `n = 4` the record's
own off-diagonal edges are `t = (17 ± √33)/16` — **irrational**. A rational-only enumeration at
`n = 2` would have returned a confident answer about a family the objects do not use. This is the
third instance in this milestone of a generator whose image excludes the target, and it is why the
enumeration below is over the base, not over `ℚ`.

**The image check that licenses anything I say about kinds**, run before the `n = 2` result was
read: the `K`-box search `(g, H)` with integral-basis coordinates in `[−2,2]⁴` **finds 2 of 2** of
the measured `n = 4` kinds. The enumerator can represent what it is looking for.

### §3c — What the shape-free base realises: six families, two of them monochromatic

The base is the **ℤ-span of its own 60 unit vectors** — the product owner's working definition, and
the construction Parts's lattice is an instance of. Measured here independently:

- shape-free: 60 unit vectors, ℤ-span of **rank 8**, **index 4096 in `O_K²`**, **16,309 points**
  inside `R = 4/√7` — the coordinator's 16,309 reproduced exactly and independently;
- Parts's: 30 unit vectors, ℤ-span of **rank 4**. His whole radius-2 lattice is rank 4 as well.
  **The shape does not thin the module, it halves its RANK.** The "index 256" figure is relative to
  `(1/12)ℤ[√3,√11,√33]²`; relative to `(1/12)O_K²` — the module phase H2's `Sh` ceiling is taken
  over — the index is **4096**, because `[O_K : ℤ[√3,√11,√33]] = 4` and that squares for the pair.
  Both statements are right about different ambient modules; the point counts agree.

The six off-diagonal families, with their radius sums:

| `t` | radii | **σ** | `v_𝔭(d²)` | | edges |
|---|---|---|---|---|---|
| `−6 ∓ 2√11` | `10/9 ∓ √11/3`, `8/9` | `2 ∓ √11/3` | 0 | separated | 12 each |
| `3/4 ∓ √11/4` | `8/9`, `10/9 ∓ √11/3` | `2 ∓ √11/3` | 0 | separated | 12 each |
| **`6/5 ∓ √11/5`** | `4/3 ± 2√11/9`, `4/3 ∓ 2√11/9` | **`8/3`** | **4** | **MONOCHROMATIC** | **12 each** |

The kinds involve **`√11`**, where the record's and `ρ₆₃`'s involve `√33` — the coordinate-shape
difference showing up directly in the cross-edge structure. The monochromatic family is the one with
a **rational** radius sum `σ = 8/3` and conjugate radii `4/3 ± 2√11/9`; verified exactly,
`A = 192 + 32√11`, `B = 192 − 32√11`, `C = 160`, `A + B − (3/2)C = 144` and `C² = AB = 25600`.

---

## §4 — Controls, and what each was seen to do

**Every control below was seen RED before it was believed green**, and the plants are bounded on
both sides (`0 < guarded − planted < threshold`): the lower bound catches a plant that has stopped
firing, the upper bound one that reddens everything and localises nothing.

| control | what it did |
|---|---|
| trace-form Gram matrix of the integral basis | derived here as `[[4,0,0,−2],[0,12,6,0],[0,6,14,0],[−2,0,0,34]]`, determinant **17424 = disc K** ✅ |
| exact sign, vs `typem.ksign` (**different method**: rational intervals against a norm descent) | 1,006 elements × 4 embeddings, **0 disagreements**; the pool includes convergents of `√33` where the double difference is exactly `0.0` |
| `is_square` | TRUE on `{3,11,33,4,12,1,7+4√3}`, FALSE on `{2,5,6,7,15,13,7+5√3}` — **both outcomes exhibited**, so the predicate is not constant |
| **law A ⟺ law B** | the split identity holds `400/400` at `n = 2, 4, 16`; law B fires on **0 of 3,000** non-collinear random pairs, with the positive control that it *does* fire on a genuine centre edge |
| **centre-star control** (free, two-sided) | centre edges must equal `2 ×` unit vectors, diagonal must equal circle points. **This control CAUGHT A REAL BUG** — see §4a |
| brute-force completeness | 231,361 ordered pairs on a 481-point subset containing every edge endpoint, by **law B alone** (no collinearity anywhere): **252 edges, 0 missed, 0 invented, IDENTICAL** — with the positive control that the brute force found 252 > 0, so it was capable of firing |
| **image check on the `K`-box enumerator** | **PASSED at `n = 4` (2 of 2) and FAILED at `n = 16` (0 of 6)** — see §4c |
| five mutation plants in the arithmetic layer | `basis-constant` 3/12 red, `sign-float` 1/12, `mul-r33` 1/12, `fsqrt-drop-rational` 2/12, `tobasis-constant` 3/12 — each fired, none reddened everything, and the restore was verified |

### §4a — Two defects found, both in the direction that flatters

**(1) The harness broke itself, in exactly the way it exists to detect.** A mutation replacing
`2 * d` by `3 * d` preserves the file's byte length; written within one mtime second, Python's
bytecode cache — keyed on `(mtime seconds, size)` — served the **mutated** `.pyc` for the restored
source. The RESTORED run read 2/12 red while the file on disk was clean. Only the final restore
check caught it; without it I would have run a corrupted arithmetic layer for the rest of the
session while believing the plants had all passed. This is `CLAUDE.md`'s *"a check that loads two
versions of something and identifies them BY NAME"*, and the thing it loaded by name was a cache.
Fixed by deleting `__pycache__` and setting `PYTHONDONTWRITEBYTECODE` on every run.

**(2) The first shape-free run returned `total 0` — and the free control refused it.** The
enumerator returns scaled points `x = 12p`; I fed those to the law without dividing by 12, so no
pair was at distance 1 and the answer was a clean zero. **A zero is the flattering direction here**
— it reads as *"`n = 2` is dead"*, the conclusion the phase half-expected. What refused it was not
suspicion but arithmetic: the centre star exists for **every** rotation by construction, so `0`
centre edges is impossible, and the control that says `centre = 2 × (unit vectors)` is free and
two-sided. It is now asserted in the script rather than checked by eye.

### §4c — The image check passed at one parameter and FAILED at another, and that is the finding

The `K`-box search over `(g, H) ∈ [−2,2]⁴` **found 2 of 2** of the measured kinds at `n = 4` — and
**0 of 6** at `n = 16`. Its coprime representatives there are simply bigger than the box.

**This is the most useful methodological result of the task, and it is a warning about a control I
had already passed.** `CLAUDE.md` says a positive control proves an instrument finds things *of the
shape its generator can represent*; here the same instrument, on the same law, with the same box,
**passes at one member of the family and is blind at another.** Had I checked only `n = 4` — the
obvious choice, since it is the record — I would have held a passing positive control and a box
whose image excludes the target, which is the exact configuration that produced three false zeros
earlier in this milestone. **One passing image check licenses the instrument at that parameter and
nowhere else.**

**And widening the box is not the fix.** The exact reason it misses is now derived, not guessed: the
coprime representative of `t = 5/4` at `n = 16` is `(g, H) = (4, 1)`, whose integral-basis
coordinate `4` is outside `[−2,2]`; the irrational kinds there have denominators 64 and 88. A box on
`(g, H)` is a **floor**, not a census, at any `N` anyone would run. *(I killed the `N = 3` run rather
than spend a core confirming that. What that forfeits: a second value of `N` at which to report the
kind count, which `CLAUDE.md` asks for before believing a generator's output. I am therefore NOT
reporting a kind count from the box at all, only the floor, and the exact miss above stands in place
of the convergence check.)*

What it invalidates, stated so nothing rests on it by accident:

- **The box's counts are lower bounds and its zeros are void.** "39 off-diagonal kinds at `n = 2`,
  8 of them monochromatic" is a *floor*, not a census, and no absence may be inferred from it.
- **It invalidates nothing in §0 or §3c.** Those come from enumerating the base itself — all 16,309
  points, exactly — not from the box, and they are independently confirmed by the brute-force
  completeness control above. The box was only ever the route to the *unrealised* kinds.
- §3a's rational classification is unaffected: its completeness is an eigenvalue bound, not a box.

### §4b — Scope, stated plainly

- **One base.** 252/120/60/72 is the ℤ-span of the 60 unit vectors inside `R = 4/√7`. A different
  generating set gives different numbers. Over the **full** `(1/12)O_K²` the rational kinds alone
  contribute `2 × (60 + 60 + 4 + 4) = 256` off-diagonal edges, so the shape-free base is realising a
  small part of what the arithmetic permits.
- **A kind existing ≠ a base realising it.** At `n = 4` the `K`-box finds 56 off-diagonal kinds, 29
  of them monochromatic — and Parts's lattice realises exactly one conjugate pair, separated. The
  arithmetic ceiling is not a prediction about an object.
- **The `K`-box is a box, not a fundamental domain.** `[−2,2]⁴` on `(g,H)`. It is validated by
  finding the measured kinds, not by an argument that it is exhaustive. The **provably complete**
  statement here is the rational one (§3a) and the *measured* statement is §3c, which is complete
  for that base because it enumerates the base itself.
- **Nothing here is a colouring claim.** Whether the `n = 2` arena refuses four colours is untested.

---

## §5 — P-H3-5

**Not scored, and the reason is on record before the number:** the product owner **retracted** the
`24/54` threshold mid-task, having registered a prediction about *raw off-diagonal count per circle
point* against a number that measures the *monochromatic share*. Both quantities are reported above
and separately labelled. For whatever it is worth to the retracted form:

- **monochromatic off-diagonal share**: `n = 2` scores **24/84 = 0.286**, below `ρ₆₃`'s `24/54 =
  0.444` — which *would* have met the retracted prediction, but for a reason that has nothing to do
  with its stated grounds: `n = 2`'s share is lower because its **diagonal** is twice as large, not
  because its off-diagonal structure is poorer. Its monochromatic off-diagonal **count** is 24,
  **equal** to `ρ₆₃`'s.
- **"off-diagonal per circle point"** is not a well-defined quantity: off-diagonal cross edges do not
  touch circle points. None of `ρ₆₃`'s 36 has an endpoint on its circle, and none of `n = 2`'s 72
  does either.

---

## §6 — What I would most want checked by someone else

**That the ℤ-span of the 60 unit vectors is the right base.** Every number in §0 and §3c is a
property of that one lattice. It reproduces the coordinator's 16,309 exactly, and Parts's lattice is
the same construction on 30 vectors — but *he* also imposes two congruences and a shape, and I have
not checked whether the shape-free span needs an analogue of his congruences to be group-closed or
to avoid points at distances a construction would reject. If the intended base is a **sublattice**
of this one, the 72 off-diagonal edges can only fall, and the honest reading of §0 becomes an upper
bound rather than a count.

Second: the `K`-box's image check **failed at `n = 16`** (§4c). Nothing in §0 rests on the box, but
if anyone wants the census of *unrealised* kinds — the ones the arithmetic permits and this base does
not reach — that instrument is not yet fit for it and needs either a wider box or the ideal-theoretic
enumeration the form `V = g² + gH + nH²` invites (all primes dividing `n d²` split in
`K(√(1−4n))/K`, so the kinds correspond to ideals of bounded support; at `n = 2` there are at most
`21 × 21 × 9 = 3969` of them).


---

# Extension — the two laws taken to the family (commissioned 2026-09-12)

## §7 — The budget criterion, sharpened into a two-case theorem

`V = n(g−h)² + gh` (the same form, regrouped). The prime `𝔭` above 2 has residue field `𝔽₂`, so a
`𝔭`-unit is `≡ 1 (mod 𝔭)`. For coprime `g, h` there are exactly two cases:

> **CASE A — `g` and `h` are both `𝔭`-units.** Then `gh` is a `𝔭`-unit so `v_𝔭(V) = 0`, and
> `g ≡ h ≡ 1 (mod 𝔭)` forces `e = v_𝔭(g−h) ≥ 1`. So `v_𝔭(d²) = 2e + v_𝔭(n) > 0`:
> **case A is monochromatic for EVERY `n`, odd `n` included.**
>
> **CASE B — exactly one of `g, h` is divisible by `𝔭`.** Then `e = 0` and
> `v_𝔭(d²) = v_𝔭(n) − v_𝔭(V)`, so it is monochromatic iff `v_𝔭(gh) < v_𝔭(n)` —
> **which needs `n` even**, since `v_𝔭(n) = 2v₂(n) = 0` for odd `n`.

**So the answer to "do the even members separate from the odd ones sharply?" is NO, and the reason
is structural: the 2-adic budget governs case B only, and case A bypasses it entirely.** The budget
`v_𝔭(n)` is not the whole criterion — it is the criterion for one of two mechanisms.

## §8 — P-XE-1, registered BEFORE the measurement

`n = 3` is odd, so `v_𝔭(3) = 0` and **case B is unavailable**. Every monochromatic off-diagonal kind
there must therefore be case A, which forces `v_𝔭(V) = 0`, hence `v_𝔭(m) = v_𝔭(144·3/V) = 8`, hence
`v_𝔭(A) = v_𝔭(m g²) = 8` and likewise for `B`. Since `|u|² = A/144` and `v_𝔭(144) = 8`:

> **P-XE-1 — at `n = 3`, in the shape-free unit-span base inside `R = 6/√11 = 1.8091`, BOTH radii of
> every monochromatic off-diagonal cross edge have 2-adic valuation exactly ZERO.**

**Scoring.** *Met* if there is at least one monochromatic off-diagonal family and every one has
`v_𝔭(|u|²) = v_𝔭(|v|²) = 0`. *Not met* if any monochromatic off-diagonal family has a radius of
nonzero valuation. **Not decided** if `n = 3` has no monochromatic off-diagonal cross edge at all —
that is the uninformative outcome and it is named in advance.

**Both outcomes are reachable, and the check is that the predicted region is not forced by the
apparatus:** at the two even members already measured the monochromatic radii have *nonzero*
valuation — `n = 2`'s are `v_𝔭 = 2` (radii `4/3 ± 2√11/9`) and `n = 16`'s are `v_𝔭 = 4` and `12`
(radii `64/9, 100/9`). So "valuation 0" is a region the measurement demonstrably need not land in,
and the uninformative outcome (no monochromatic family) is reachable too — `n = 2` on Parts's shaped
lattice had no off-diagonal cross edge of any sort.


## §9 — The screen across the family, and the honest verdict on it

Run over `n = 1..300`, exhaustively for **rational** kinds (the eigenvalue bound `g² + h² ≤ 2nd²`
makes that a finite explicit box), classifying each by §7:

| `n` | rational off-diag kinds | monochromatic | case A | case B | first monochromatic |
|---|---|---|---|---|---|
| 1 | 3 | 1 | 1 | 0 | `t = −1`, `V = 3`, `m = 48` |
| **2** | 8 | **0** | 0 | 0 | — |
| **3** | 4 | **2** | **2** | 0 | `t = 5/3`, `V = 27`, `m = 16` |
| **4** | 10 | 2 | 0 | 2 | `t = 2`, `V = 6`, `m = 96` |
| 6 | 22 | 2 | 2 | 0 | `t = 3`, `V = 27`, `m = 32` |
| 7 | 6 | 2 | 2 | 0 | `t = 7/5`, `V = 63`, `m = 16` |
| 12 | 16 | 4 | 0 | 4 | `t = 3/2`, `V = 18`, `m = 96` |
| **16** | 14 | 6 | 0 | 6 | `t = 2`, `V = 18`, `m = 128` |
| 24 | 10 | 4 | 0 | 4 | `t = 4/3`, `V = 36`, `m = 96` |

**40 of the first 300 members** carry a rational monochromatic off-diagonal kind — **but this list
predates the gate-B filter and four entries are struck** (§13): `1, 3, 7, 135` all have
`√(4n−1) ∈ K`, so `ρ_n ∈ K(i)`, the arena lies in `K²`, and Theorem B four-colours it. **The 36
valid entries are**

`4, 6, 12, 16, 24, 30, 39, 40, 48, 51, 52, 60, 70, 72, 84, 88, 96, 112, 115, 120, 126, 132, 144,
160, 168, 180, 192, 198, 216, 220, 231, 232, 240, 259, 264, 286`.

Of the members where the screen found a **case-A** kind — `1, 3, 6, 7, 30, 39` — **gate B leaves only
`6, 30, 39`**; the other three are struck.

### §9a — **The screen does not work as a screen, and `n = 2` is the proof**

The commission asked for a screen: *which members cannot carry the quantity.* **It is neither an
upper nor a lower bound on what a base realises, and it fails in both directions on members we have
measured.**

- **It UNDER-reports.** The table gives `n = 2` **zero** rational monochromatic kinds — and the
  shape-free base realises **24 monochromatic off-diagonal cross edges** there, on an *irrational*
  case-A kind with `V = 9`. **A zero in that column is not an elimination**, and the standing
  counterexample is the very member this phase is about.
- **It OVER-reports.** At `n = 4` it lists two rational monochromatic kinds (`t = 2, 1/2`), and
  Parts's lattice realises **none of them** — its only off-diagonal family is the separated
  irrational pair `t = (17 ± √33)/16`.

So the 40-member list is **a floor on arithmetic availability, not a screen on members**, and no
member may be eliminated from it. What survives as a law is §7 — which classifies any *given* kind
correctly — not the rational enumeration of kinds, which is the same generator-image problem §4c
records, now firing on the family instead of on one member.

### §9b — What DOES retrodict: all twelve measured families, exactly

Sharpening §7: in case A, `g` and `h` are `𝔭`-units, so `v_𝔭(|u|²) = v_𝔭(|v|²) = v_𝔭(n)`.

| member / base | family | `v_𝔭(d²)` | `v_𝔭(|u|²)`, `v_𝔭(|v|²)` | case | verdict |
|---|---|---|---|---|---|
| `n = 2` shape-free | ×24 | 4 | 2, 2 `= v_𝔭(2)` | **A** | MONO ✅ |
| `n = 2` shape-free | ×24, ×24 | 0 | 0, 6 / 6, 0 | B | separated ✅ |
| `n = 16` Parts | ×12, ×12 | 4 | 4, 12 / 12, 4 | B (`v_𝔭(gh) = 4 < 8`) | MONO ✅ |
| `n = 16` Parts | ×6, ×6 | 0 | 0, 20 / 20, 0 | B (`v_𝔭(gh) = 10 ≥ 8`) | separated ✅ |
| `n = 4` Parts | ×18, ×18 | 0 | 12, 0 / 0, 12 | B (`v_𝔭(V) = v_𝔭(n)`) | separated ✅ |

**Twelve of twelve.** And the structural point the commission's question 2 was reaching for comes out
inverted: **`n = 2`'s 24 monochromatic edges are case A and `n = 16`'s are case B — two different
mechanisms delivering the same count.** The 2-adic budget explains `n = 16`; it explains nothing
about `n = 2`, which gets its monochromatic family from the mechanism the budget does not govern.


## §10 — The bytecode archetype: a check that identified two versions of itself BY NAME

*Written up at the product owner's request as an instance of a failure mode `CLAUDE.md` already
names, in a costume it has not yet recorded.*

`CLAUDE.md` states the archetype as **"a check that loads two versions of something and identifies
them BY NAME"** — module caches, class registries, singletons, environment lookups — and gives
archiving a checker as the example. **Here it wore a different costume: the name was not a module
path but the pair `(file size, mtime in whole seconds)`, and the thing doing the identifying was
CPython itself.**

**The mechanism, exactly.** The mutation harness writes a fault into `kf.py`, runs the controls in a
subprocess, then restores the original bytes. One plant replaced `a3 = 2 * d` with `a3 = 3 * d` —
**the same number of bytes**. Python validates a cached `.pyc` against the source's `(mtime seconds,
size)`; both writes landed inside one second and the size never changed, so the interpreter judged
the cache current and **executed the mutated bytecode against the restored source**. The restored
run read 2 of 12 controls red while `kf.py` on disk was byte-for-byte the original.

**What caught it.** Not the plants — every plant had already "passed". The harness ends by restoring
the file and **re-running the controls one more time, asserting the guarded state comes back**. That
final assertion is the only reason the session did not continue on a corrupted arithmetic layer
while believing its controls were green. It is the two-sided discipline applied to the harness
itself: the plants check that a fault *fires*, the restore check that the absence of a fault
*reverts* — and only the second can see a cache that has stopped tracking the file.

**The generalisation worth carrying:** *a mutation harness must verify its own restore, and a
same-size mutation is the case that defeats timestamp-based caching.* Fixed by removing
`__pycache__` and setting `PYTHONDONTWRITEBYTECODE=1` on every invocation — and the fix is itself
checked, because the restore assertion now passes.

**And the sibling catch, the third of the day.** The first shape-free run printed `total 0` cross
edges. A zero is the flattering direction — it reads as *"`n = 2` is dead"*, which is what the phase
half expected. What refused it was a **population printed beside the verdict**: the centre star
exists for every rotation by construction, so `centre = 2 × (unit vectors)` is free, two-sided, and
non-negotiable; `0 ≠ 120` stopped the run being believed. The cause was mundane — the lattice
enumerator returns scaled points `x = 12p` and the law was handed those directly — but the point is
that no amount of suspicion found it and one printed invariant did.


## §11 — P-XE-1 scored: **MET**, and it landed on the radii too

The shape-free unit-span base at `n = 3`, cut at `R = 6/√11 = 1.8091`: **67,909 points**, 60 unit
vectors, 84 circle points. Both free controls passed (centre `120 = 2 × 60`, diagonal `84 = 84`).

> **300 cross edges = 120 centre + 84 diagonal + 96 off-diagonal**, `300/300` confirmed by direct
> exact distance, **0 invented**; four off-diagonal families, **two of them monochromatic (24 edges)**.

| family | radii | `v_𝔭(d²)` | `v_𝔭(\|u\|²)`, `v_𝔭(\|v\|²)` | edges |
|---|---|---|---|---|
| `t = 5/3` | `1`, `25/9` | 4 | **0, 0** | 12 |
| `t = 3/5` | `25/9`, `1` | 4 | **0, 0** | 12 |
| `t = 3/2` | `4/3`, `3` | 0 | 4, 0 | 36 |
| `t = 2/3` | `3`, `4/3` | 0 | 0, 4 | 36 |

**`v_𝔭 = 0` on both radii of both monochromatic families — P-XE-1 MET.** And the prediction was
sharper than its own statement: §9's screen had listed `n = 3`'s monochromatic kind as `t = 5/3`,
`V = 27`, `m = 16`, radius sum `σ = 34/9` — **the measurement returns `t = 5/3` with radii `1` and
`25/9`, i.e. `σ = 34/9` exactly.** The law named the family, its rotation parameter and both its
radii before the base was built.

That is the second out-of-sample landing for these laws, after the counting law returned `ρ₆₃`'s
rational family `100/9 ↔ 64/9`.

### §11a — One observation registered as an observation, not a finding

**Three members now measured carry exactly 24 monochromatic off-diagonal cross edges** — `n = 2`
(case A, two families of 12), `n = 3` (case A, two families of 12), `n = 16` (case B, four families
of 6). **This is almost certainly small-number coincidence and is recorded so it cannot later be
mistaken for a law**: the family sizes differ (12 against 6), the mechanisms differ (A against B),
and 12 and 6 are the `ζ₆`-orbit sizes the base's symmetry group supplies anyway. It would take a
fourth member with a different orbit structure to make it interesting, and nothing here predicts it.

### §11b — Scope, restated because the numbers are getting attractive

`n = 3` is the **Moser twist**, `4n − 1 = 11`, so its radicand lies in `K` and the 2-adic wall is not
broken: by phase H2's gate C it can never reach five colours, whatever its cross-edge structure. Its
value here is exactly and only as a **test of the law** — a member with an odd `n` and therefore zero
2-adic budget, where case A had to carry any monochromatic edge or nothing would. It did.

**And un-eliminated is still not alive.** 24 monochromatic off-diagonal constraints at `n = 2` is not
a refusal of four colours, at `n = 3` it is provably not one, and nothing in §7–§11 is a colouring
claim.


---

# §12 — The mechanism, stated for the class

*Written at the product owner's request in the register a Lean formalisation could be built from,
because the programme says the milestone continues until the mechanism is stated and proved for a
class. Notation is fixed here and supersedes the working notation earlier in this file, where `d`
was used for both the denominator and the separation: **`D`** is the denominator, **`δ`** the
separation.*

## §12.1 Setting and hypotheses

- `K = ℚ(√3, √11)`, totally real of degree 4, `h(K) = 1`, `disc K = 17424`.
- `𝔭` a prime of `O_K` above 2. There are two; each has `e = 2`, `f = 1`, residue field `𝔽₂`.
  `v_𝔭` is the normalised valuation, so **`v_𝔭(2) = 2`** and `v_𝔭(n) = 2·v₂(n)` for `n ∈ ℤ`.
- `n ≥ 1` an integer. `ρ_n = cos θ + i·sin θ` with `cos θ = (2n−1)/(2n)`, `sin θ = √(4n−1)/(2n)`.
- `D ≥ 1` an integer; `M = (1/D)·O_K²`, the denominator-`D` module of the plane over `K`.
- An **arena** is a base `B ⊆ M` together with `ρ_n·B`, sharing the centre `0`. A **cross edge** is a
  pair `(u, ρ_n v)` with `u, v ∈ B` and `|u − ρ_n v| = 1` exactly.
- The **residue colouring** at `𝔭` identifies two `K`-points iff `v_𝔭(|u−v|²) > 0`
  (`ValuationLaw.lean`, ledger row 59). A cross edge is **monochromatic** when its two *base-side*
  points `u, v` are so identified.

> **(H1)** `√(4n−1) ∉ K`, equivalently `sin θ ∉ K`.

**(H1) is not a convenience.** If it fails, `ρ_n ∈ K(i)`, the whole arena lies in `K²`, and Theorem B
(`chromaticNumber_seamPlane`, kernel-checked) four-colours it; every statement below would then be
about a structure that can carry nothing. It is **gate B** of `plans/M63-phaseH2-the-family.md` §5
(gate C is the 2-adic wall, gate D is 11's residue degree).

## §12.2 Lemma (the split)

For `u, v ∈ K²` and `n` satisfying (H1):

> `|u − ρ_n v|² = 1`  ⟺  **(i)** `det(u,v) = 0`  **and**  **(ii)** `2cos θ·(u·v) = |u|² + |v|² − 1`.

*Proof.* `|u − ρ_n v|² = |u|² + |v|² − 2(cos θ·(u·v) + sin θ·q)` with `q = −det(u,v)`. All of
`|u|², |v|², u·v, q, cos θ` lie in `K`; by (H1), `{1, √(4n−1)}` is a `K`-basis of `K(√(4n−1))`, so
the two components vanish independently. ∎

## §12.3 Lemma (line structure) — uses `h(K) = 1`

Let `u, v ∈ M` be nonzero with `det(u,v) = 0`. Every nonzero `x ∈ O_K²` is `c·x̂` with `x̂`
**primitive** (the ideal `(x̂₁, x̂₂) = O_K`), because `h(K) = 1`. Then the points of `M` on the line
`K·x̂` are **exactly** `{(g/D)·x̂ : g ∈ O_K}`.

*Proof.* If `w ∈ O_K²` and `w = λx̂` with `λ ∈ K`, pick `a, b ∈ O_K` with `a x̂₁ + b x̂₂ = 1`; then
`λ = a w₁ + b w₂ ∈ O_K`. ∎

So `u = (g/D)x̂`, `v = (h/D)x̂` with `g, h ∈ O_K`, and the **kind** of the edge is `t = h/g ∈ K`.

## §12.4 Proposition (the form, and the closed form for every quantity)

Put `ν = |x̂|²` and

> **`V := n(g−h)² + gh`**   `= n g² − (2n−1)gh + n h²`   `= g² + gH + nH²` with `H = h − g`,

the **principal binary quadratic form of discriminant `1 − 4n`** — the family's own radicand. Then
condition (ii) is `ν·V = n D²`, and *(all four verified against the original law at 4,000 random
`(n, g, h)` with 0 disagreements, and against every measured family)*

> `|u|² = n g²/V` ,  `|v|² = n h²/V` ,  `σ = |u|² + |v|² = n(g²+h²)/V` ,  `δ² = |u−v|² = n(g−h)²/V`.

These four are **homogeneous of degree 0** in `(g,h)`, so they depend only on the kind `t` and not on
the scaling — coprimality is needed only for §12.5, never for the radii. Two consequences:

- **a line carries a cross edge only if `ν | n D²`**, so only if its primitive norm divides `nD²`;
- **the cross edges of kind `t` biject with `{z ∈ O_K² : |z|² = nD²/V}`**, via `u = gz/D`, `v = hz/D`
  — so their **count is `Sh(nD²/V)`**, computed with no base and no radius.

**Corollary (the endpoint bound).** With `τ = h/g`, `|u|² = n/(nτ² − (2n−1)τ + n)`; the denominator
is a quadratic in `τ` minimised at `τ = (2n−1)/(2n) = cos θ`, where it equals `(4n−1)/(4n)`. Hence
`|u|² ≤ 4n²/(4n−1) = 1/sin²θ`, and the same for `|v|²` by `τ ↦ 1/τ`. Because `sin²θ ∈ ℚ`, the bound
holds at **every** Galois conjugate simultaneously. **Material outside that disk carries no cross
edge at all** — so the endpoint bound is a theorem about the law, not a modelling choice, and the
record's 126 is indeed unchanged as its base grows from radius 2.0656 to 2.44 to 3.0.

## §12.5 **Theorem (the two-case criterion)**

Let `g, h ∈ O_K` be **coprime** (the ideal `(g,h) = O_K`), both nonzero, `g ≠ h`. Put
`e = v_𝔭(g−h)` and `V = n(g−h)² + gh`. Then

> `v_𝔭(δ²) = 2e + v_𝔭(n) − v_𝔭(V)`,

and the cross edges of kind `t = h/g` are monochromatic iff that is `> 0`. Exactly two cases arise,
since coprimality forbids `𝔭` dividing both:

> **CASE A — `v_𝔭(g) = v_𝔭(h) = 0`.** Then `e ≥ 1` and `v_𝔭(V) = 0`, so
> `v_𝔭(δ²) = 2e + v_𝔭(n) ≥ 2 > 0`: **monochromatic, for every `n`, odd `n` included.**
> Moreover `v_𝔭(|u|²) = v_𝔭(|v|²) = v_𝔭(n)`.
>
> **CASE B — exactly one of `g, h` is divisible by `𝔭`.** Then `e = 0`, and the edges are
> **monochromatic iff `v_𝔭(gh) < v_𝔭(n)`** — which requires **`n` even**, because
> `v_𝔭(n) = 2v₂(n) = 0` for odd `n`.

*Proof.* The displayed valuation is immediate from `δ² = n(g−h)²/V`.

**Case A.** `O_K/𝔭 = 𝔽₂`, so a `𝔭`-unit is `≡ 1 (mod 𝔭)`; hence `g ≡ h ≡ 1` and `𝔭 | g − h`, i.e.
`e ≥ 1`. Then `v_𝔭(n(g−h)²) = v_𝔭(n) + 2e ≥ 2 > 0 = v_𝔭(gh)`, so the valuation of the sum is the
strict minimum: `v_𝔭(V) = 0`. Substituting gives `v_𝔭(δ²) = 2e + v_𝔭(n) ≥ 2`. For the radii,
`v_𝔭(|u|²) = 2v_𝔭(g) + v_𝔭(n) − v_𝔭(V) = v_𝔭(n)`.

**Case B.** Say `v_𝔭(g) > 0 = v_𝔭(h)`. Then `g − h ≡ −h ≢ 0 (mod 𝔭)`, so `e = 0`, and
`v_𝔭(n(g−h)²) = v_𝔭(n)` while `v_𝔭(gh) = v_𝔭(g)`. If `v_𝔭(gh) < v_𝔭(n)` the minimum is strict and
`v_𝔭(V) = v_𝔭(gh) < v_𝔭(n) = 2e + v_𝔭(n)`: monochromatic. If `v_𝔭(gh) > v_𝔭(n)` then
`v_𝔭(V) = v_𝔭(n)` and `v_𝔭(δ²) = 0`: not monochromatic. If they are equal then `v_𝔭(V) ≥ v_𝔭(n)`
and `v_𝔭(δ²) ≤ 0`: not monochromatic. ∎

**The corollary that answers "do even and odd members separate?" — they do not.** The 2-adic budget
`v_𝔭(n)` governs **case B alone**. Case A bypasses it and is monochromatic at every `n`. Measured:
`n = 2`'s 24 monochromatic edges are **case A**, `n = 16`'s are **case B**.

## §12.6 What the theorem does **NOT** say

1. **It classifies a GIVEN kind. It does not say which kinds a base realises.** This is the gap that
   sank the screen (§9a), and it fails in both directions: at `n = 4` the arithmetic permits
   monochromatic kinds that Parts's lattice realises **none** of; at `n = 2` a rational enumeration of
   kinds finds **none** while the shape-free base realises 24 on an irrational one.
2. **It is not a colouring claim.** A monochromatic cross edge is one the *residue certificate* fails
   to separate. **24 monochromatic off-diagonal constraints is not a refusal of four colours** — and
   at `n = 3` it provably cannot be one, since `4n−1 = 11` leaves the 2-adic wall unbroken and
   Theorem B four-colours anything drawn over `K`.
3. **One prime at a time.** `𝔭` is one of the two primes above 2. Everything measured here agrees at
   both, but the theorem is stated per prime.
4. **The base must lie in `(1/D)O_K²` over this `K`.** Nothing is claimed for other fields, and
   `h(K) = 1` is used in §12.3.
5. **Coprimality is a normalisation.** `t` determines `(g,h)` up to a unit of `O_K`; `V` then changes
   by a unit square, leaving every valuation and every ratio in §12.4 invariant.

## §12.7 The evidence: two out-of-sample landings

Placed here rather than in a methods section, because out-of-sample prediction is the strongest
evidence this project recognises.

> **(1) The counting law returned `ρ₆₃`'s rational family before it was looked up.** The base-free
> table at `n = 16` lists `t = 5/4`, `V = 36`, `m = 64`, radii `64/9` and `100/9` — derived from the
> cosine alone, no lattice. `plans/M63-phaseH2-the-family.md` records `ρ₆₃`'s off-diagonal edges as
> sitting on three radius families *"including a rational pair (`100/9 ↔ 64/9`) the record has no
> analogue of"*. Same pair.
>
> **(2) The criterion named `n = 3`'s family, its rotation parameter AND both radii before the base
> existed — P-XE-1, registered in §8 and scored in §11.** `n = 3` is odd, so case B is unavailable and
> any monochromatic edge must be case A, forcing `v_𝔭(|u|²) = v_𝔭(|v|²) = v_𝔭(3) = 0`. The screen
> named the kind: `t = 5/3`, `V = 27`, radii `n g²/V = 1` and `n h²/V = 25/9`. The base was then built
> — 67,909 points — and returned `300 = 120 + 84 + 96`, `300/300` confirmed, 0 invented, with
> **two monochromatic families, `t = 5/3` and `t = 3/5`, radii `1` and `25/9`, both valuations 0.**

The second is the stronger: a law that names the rotation parameter *and* both radii in advance of
any construction is doing work no curve fit could do. Both landings are consistent with §12.6(1) —
they predicted what a base **would** realise and were right, which is evidence for the law and *not*
evidence that the realisation gap has closed.


---

# §13 — **CORRECTION: P-XE-1 is VOID. It was tested at `n = 3`, where (H1) fails.**

*Found while answering the follow-up, by reading my own §12.1 against my own §11.*

**`n = 3` has `4n − 1 = 11`, and `√11 ∈ K` by definition of `K = ℚ(√3,√11)`.** So `sin θ = √11/6 ∈ K`,
`ρ₃ ∈ K(i)`, and **(H1) — the hypothesis I had just finished arguing is load-bearing — fails at the
very member I chose to test the theorem on.**

**What that does to the computation.** With `ρ₃ ∈ K(i)`, `|u − ρ₃v|²` is a single equation over `K`
and **does not split**. My law A imposes two conditions (collinear *and* the `K`-part equation), so
it is **strictly stronger than the truth** and enumerates a *subset* of the cross edges. Law B failed
identically, because it evaluates `|u − ρv|²` in a formal `K(√D)` and demands the `√D`-part vanish —
which is meaningless when `√D ∈ K`. That is why the two "agreed 300/300": they were testing the same
wrong condition.

**Demonstrated, not inferred.** From the single point `u = (1,0)` at `n = 3`, four **non-collinear**
pairs with `|u − ρ₃v|² = 1` exactly:

```
v = (−1/6, −√11/6)        det(u,v) = −√11/6        law A says: False
v = (0, −√11/3)           det(u,v) = −√11/3        law A says: False
v = (5/6, −1 − √11/6)     det(u,v) = −1 − √11/6    law A says: False
v = (5/6,  1 − √11/6)     det(u,v) =  1 − √11/6    law A says: False
```

**Consequences, stated in full:**

1. **P-XE-1 is VOID — not met, not "not decided", but untested.** The `n = 3` numbers
   (`300 = 120 + 84 + 96`) are a *lower bound* on that arena's cross edges, computed under a
   hypothesis that fails. §11 stands only as a record of what was run.
2. **The follow-up's reframing loses its premise.** It rested on *"two members sharing a mechanism
   exactly"* — `n = 2` and `n = 3` both case A with two families of 12. **`n = 3` is void, so the
   case-A sample is ONE member.** `24` is not a two-member agreement; it is one measurement and one
   invalid one.
3. **§9's screen needs an (H1) filter it did not have.** (H1) fails exactly when `squarefree(4n−1) ∈
   {1, 3, 11, 33}`; over `n ≤ 300` that is
   **`n = 1, 3, 7, 19, 25, 37, 61, 69, 91, 127, 135, 169, 217, 223, 271`**. Four of them —
   **1, 3, 7, 135** — are in the 40-member list of §9, which therefore has **36** valid entries.
   Of the case-A members the screen found (`1, 3, 6, 7, 30, 39`), only **`6, 30, 39`** survive.
4. **Nothing else is affected.** `n = 2` (`√7 ∉ K`), `n = 4` (`√15 ∉ K`) and `n = 16` (`√63 = 3√7 ∉ K`)
   all satisfy (H1), verified by the same predicate with both outcomes exhibited. The three gates,
   §0's answer, §12's theorem and its two-case proof stand unchanged.

**Why I did not catch it earlier — and checking the gate letters made the account sharper, not
softer.** `n = 3` fails **two** of phase H2's four gates. It fails **gate C** (the 2-adic wall:
`4n−1 = 11`, square class `≡ 3 (mod 8)`), and it fails **gate B** (`sin θ ∉ K`). In §11b I wrote down
the radicand and attributed the consequence to gate C — **which is correct**, and which is exactly
the problem: it fully answered the question *"is anything wrong with `n = 3`?"* with *"yes, it can
never reach five colours"*, and that answer made the member look **safe to use as a test**, since a
member that is dead as an object costs nothing to compute on. Having a true and sufficient-sounding
reason, I never asked whether a **second** gate also failed — and the second one was not about the
member at all, it was about **my instrument**: gate B is the hypothesis my own law needs.

So the mechanism is not mis-filing. It is this: **a true explanation that fully accounts for the
observation will stop you looking for a second one, and the second one may be the one about your
own apparatus.** The rule that generalises, which is the one I would keep:
**a hypothesis is not checked by being mentioned** — and a member that fails one gate should be
checked against *all* of them before it is used as a test, precisely because the first failure makes
it feel already understood.


# §14 — The follow-up, with the sample corrected to ONE

## §14.1 Predictions, registered before the runs

**The honest starting point: the case-A sample is one member (`n = 2`), not two.** `n = 3` is void
(§13) and `n = 16` is case B. So question 1 — *is `24` a case-A constant?* — currently rests on a
**sample of one**, and I will not call anything a constant from that. What follows is an attempt to
decide whether the `12` is a property of the KIND or of the BASE, plus a second valid member.

**The only two members cheap enough to build and valid under (H1) are `n = 2` (done) and `n = 4`**
(base grows like `n⁴`; `n = 6` would be ~900,000 points). `n = 4`'s **shape-free** arena has never
been built — only Parts's shaped lattice at `n = 4` has been measured — so it is genuinely out of
sample.

> **P-XE-4 (the mechanism of the 12).** The count `12` at `n = 2`'s case-A family is a property of
> the **base** — the index-4096 unit-vector span — and not of the kind. Concretely: the kind has
> `m = 32`, and I predict **`Sh(32) > 12` over the full `(1/12)O_K²` module**, so that the base is
> realising only part of what the kind permits. *Met* if `Sh(32) > 12`; *not met* if `Sh(32) = 12`,
> which would make `12` a property of the kind and make a case-A constant plausible. Both reachable:
> `Sh` has returned 4, 12, 36, 60, 84, 108 and 240 at other arguments in this file.

> **P-XE-2 (question 2, on `n = 4` shape-free).** The `n = 4` shape-free base carries **at least one
> monochromatic off-diagonal family**. Grounds: §3a lists two rational monochromatic case-B kinds at
> `n = 4` (`t = 2, 1/2`, `V = 6`, `m = 96`, radii `2/3` and `8/3`), and `Sh(96) = 36 > 0`, so the full
> module realises them — the open part is whether the index-4096 span does. *Met* if ≥ 1; *not met* if
> 0. **Both reachable, and the zero is not hypothetical: Parts's shaped lattice at `n = 4` carries
> zero monochromatic off-diagonal edges**, measured in gate 1.

> **P-XE-3 (question 1, on `n = 4` shape-free).** If the `n = 4` shape-free base carries any **case-A**
> family, those families number exactly two (one unordered kind in its two orderings) and total
> **24** edges. *Met* if case A is present and totals 24; *not met* if present and ≠ 24; **not
> decided** if `n = 4` carries no case-A family at all — which the rational screen expects, since it
> finds only case-B kinds there, so the uninformative outcome is the likely one and is named in
> advance.

**On question 2's framing.** The follow-up reasons that odd members are dead anyway, so the
interesting population is the even ones. **That is now stronger than when it was written**: the odd
members with case-A kinds that §9 found — `1, 3, 7` — are *all three* excluded by (H1) outright, not
merely dead for refutation. Of the case-A members the screen can see, only `6, 30, 39` survive, and
**the screen cannot answer question 2 anyway**, because it under-reports: it scores `n = 2` at zero
case-A kinds while the base realises one. A sample of even members can only come from building them.


## §14.2 P-XE-4 scored **NOT MET** — and the coincidence half-dissolves into a derivation

`Sh(32) = 12` **exactly**, and the index-4096 base realises all 12. So the `12` is a property of the
**kind**, not of the base, and P-XE-4 is **not met** — the more informative outcome, because it
means the number is derivable.

**The derivation.** Phase H2's divisor formula gives `Sh(m) = 12 · ∏_𝔮 local(v_𝔮(m))` for `4 | m`,
where the leading `12 = |μ(K(i))|`, the two primes above 2 are **inert** in `K(i)/K` and contribute
`local(even) = 1`, and a prime `𝔮 | 3` **splits** and contributes `v_𝔮(m) + 1 > 1`. Hence

> **`Sh(m) = 12` exactly when `m` is a pure power of 2** (for `4 | m`).

Measured, six for six on powers of 2 and seven for seven against the alternative:
`Sh(16) = Sh(32) = Sh(64) = Sh(128) = Sh(256) = Sh(512) = 12`, while
`Sh(12) = Sh(48) = Sh(96) = Sh(192) = 36` and `Sh(144) = Sh(288) = Sh(576) = 60`.

**Now close the loop with case A.** Case A forces `v_𝔭(V) = 0`, i.e. `V` **odd**, so `V` divides the
odd part of `nD² = 144n`, which is `9·odd(n)`. And `m = nD²/V` is a pure power of 2 **iff `V` takes
that odd part in full**, `V = 9·odd(n)`. Therefore:

> **Sub-result.** For a case-A kind with `V = 9·odd(n)`, the count over the full module is
> `Sh(m) = 12` per ordering, i.e. **24 for the unordered kind** — *derived*, not observed.
> `n = 2` realises exactly this: `V = 9`, `m = 288/9 = 32 = 2⁵`, `Sh(32) = 12`, two orderings, **24**.

**What is NOT derived, and it is the whole remaining question:** *whether case A forces `V` to be the
full odd part.* A case-A kind with `V = 3` at `n = 2` would give `m = 96`, `Sh(96) = 36`, and **72**
edges — not 24. Nothing above excludes it; the `n = 2` measurement simply found no such kind, and
**the sample is one member.** So: **`24` is not a case-A constant. It is the case-A count when `V` is
maximal, and that is a theorem; whether `V` must be maximal is open.**

## §14.3 And the three-way `24` is now fully explained — as a coincidence, with both sides derived

- **`n = 2`:** one case-A kind, `V = 9` maximal, `m = 32`, `Sh(32) = 12`, **2 orderings × 12 = 24**,
  and the base realises all of it.
- **`n = 16`:** four case-**B** orderings on Parts's lattice at **6 each = 24**. Their `m = 64`, so the
  full-module count is `Sh(64) = 12` per ordering — **Parts's rank-4 lattice realises exactly half**.

So one 24 is `2 × 12` fully realised and the other is `4 × (12/2)` halved by a rank-4 base. **Same
number, different case, different family count, different realisation fraction.** The caution
registered in §11a was right and is now discharged with a reason rather than a hedge — and the third
instance that made the pattern look strong, `n = 3`, is void (§13).


## §14.4 `n = 4` shape-free: P-XE-2 **MET**, P-XE-3 **MET**

The `n = 4` shape-free unit-span base, cut at `R = 8/√15 = 2.0656`: **195,961 points**, 60 unit
vectors, **60 circle points** (Parts's shaped lattice has 30). Both free controls green.

> **492 cross edges = 120 centre + 60 diagonal + 312 off-diagonal**, `492/492` confirmed by direct
> exact distance, **0 invented**; **18 off-diagonal families, 8 of them monochromatic (144 edges)**.

**P-XE-2 MET** — 144 monochromatic off-diagonal edges, against the zero that Parts's shaped lattice
at the same `n` and the same rotation carries. **Dropping the shape at the record's own member turns
36 raw off-diagonal edges into 312, and 0 monochromatic ones into 144.**

**P-XE-3 MET, and it was derived rather than fitted.** The case-A families are
`t = 2 ± √3`, radii `8/9 ∓ 4√3/9`, with `v_𝔭(|u|²) = v_𝔭(|v|²) = 4 = v_𝔭(4)` — the case-A signature
of §12.5 — **two families, 12 edges each, 24 in total.** And §14.2's derivation named the 12 in
advance: case A forces `V` odd, here `V = 9 = 9·odd(4)`, so `m = 4·144/9 = 64`, a pure power of 2,
so `Sh(64) = 12` — a value computed while this base was still being enumerated.

*(The case-A/case-B split is read off a signature that is exactly equivalent, not merely suggestive:
`v_𝔭(|u|²) − v_𝔭(|v|²) = 2(v_𝔭(g) − v_𝔭(h))`, and in case B exactly one of `g, h` is divisible by
`𝔭`, so the two valuations are equal **iff** case A. Every case-B row in the run has an unequal pair
— `6,2`, `2,6`, `12,0`, `0,12`, `10,0`, `0,10` — and every case-A row reads `4,4`.)*

### §14.5 Answers to the two questions

**Q1 — is `24` a case-A constant?** **It now has two valid members and a derivation, and it is still
not a constant.** `n = 2`: `V = 9`, `m = 32`, `Sh = 12`, 24. `n = 4`: `V = 9`, `m = 64`, `Sh = 12`,
24. **What is proved** is §14.2: *when `V` is the full odd part of `nD²`, `m` is a pure power of 2,
`Sh(m) = 12`, and the unordered kind carries 24.* **What is observed, two for two, is that case A
takes `V` maximal** — and that is the step with no proof. A case-A kind with `V = 3` would give 72,
and nothing yet excludes one. **So: it derives conditionally, and the condition survives two
members. It is not yet a theorem, and I will not call it one.**

**Q2 — is `n = 2` unusual in being even with case-A edges? No, and the dichotomy dissolves.**
`n = 4` shape-free carries **both** mechanisms: 24 case-A edges *and* 120 case-B edges. So the
"two even members, two different mechanisms" reading was an artifact of **comparing incomparable
bases** — `n = 2` and `n = 4` are measured shape-free, while `n = 16`'s case-B-only reading is on
Parts's **rank-4** lattice, which realises a strict subset. `n = 16` shape-free would be ~30 million
points and was not built, so **nothing here says `n = 16` lacks case-A edges** — only that Parts's
lattice does not show them.

| member | base | case A | case B | mono off-diagonal |
|---|---|---|---|---|
| `n = 2` | shape-free, 16,309 | **24** | 0 | 24 |
| `n = 4` | shape-free, 195,961 | **24** | 120 | **144** |
| `n = 4` | Parts's, 3,433 | 0 | 0 | **0** |
| `n = 16` | Parts's, 25,567 | 0 | 24 | 24 |

**Scope, unchanged.** None of this is a colouring claim. 144 monochromatic off-diagonal constraints
at `n = 4` is not a refutation of four colours, and `n = 4`'s field `K(√15)` is 5-sealed (G43), so
that member cannot reach six whatever its cross-edge structure. Un-eliminated is not alive.


# §15 — Is `n = 2` still the right target? **Yes, and by a factor of 400.**

*Checked rather than trusted, as asked. Every step of the coordinator's reasoning verified, and the
one number it left open — the runner-up's cost — computed.*

**Step 1: the arena radius increases with `n`.** `R² = 4n²/(4n−1)`, and
`d(R²)/dn = 8n(2n−1)/(4n−1)² > 0` for `n ≥ 1`; verified strictly increasing over `n = 1..200`.
So a member's cost is monotone in `n` and there is no cheap large member hiding anywhere.

**Step 2: `n = 2` is the cheapest member of the family that exists at all.** `n = 1` has a *smaller*
radius (`R = 1.1547` against `1.5119`) — but `4n−1 = 3` and `√3 ∈ K`, so `n = 1` **fails gate B**
and its arena lies in `K²`. Among gate-B-valid members, **`n = 2` is the minimum, period.**

**Step 3: the cost law, calibrated on two measured points rather than assumed.** The shape-free base
grows like `(R²)⁴` (four conjugate disks, rank-8 module). Anchoring at the measured `n = 2` count of
16,309 predicts **198,013** at `n = 4` against the **195,961 measured** — **+1.0%**. That is a
calibrated instrument, not an estimate.

**Step 4: the 6-open members and what they cost.** Gates B (`sin θ ∉ K`), C (wall broken) and D (11
inert) give, for `n ≤ 200`, the 6-open list `2, 10, 16, 20, 22, 24, 32, 38, 42, 44, 46, 54, 60, …`:

| `n` | `R` | shape-free base | relative to `n = 2` |
|---|---|---|---|
| **2** | **1.512** | **16,309** (measured) | **1×** |
| 10 | 3.203 | ~6,610,000 | **405×** |
| 16 | 4.032 | ~41,700,000 | 2,557× |
| 20 | 4.500 | ~101,000,000 | 6,164× |
| 22 | 4.717 | ~147,000,000 | 8,984× |
| 24 | 4.925 | ~207,000,000 | 12,675× |

**Verdict: the claim holds, and `n = 16`'s ~41.7 million confirms the coordinator's "order of 40
million" independently.** One correction to the framing, and it is a mild one: **`n = 2` is not the
*only* affordable 6-open member, it is cheaper than the next one by 405×.** `n = 10` at ~6.6 million
points is out of reach of this Python enumeration (the `n = 4` build took 9 minutes for 196k points;
6.6 million would be days) but is **not** absurd for a compiled implementation. So the honest
statement is:

> **`n = 2` is the unique 6-open member affordable with the present tooling, and the only one within
> two orders of magnitude of affordability. The phase's target choice survives.**

**And `n = 4`'s 144 monochromatic off-diagonal edges do not make it a better target**, six times
richer though it is: `4n−1 = 15`, so its field is `K(√15) = K(√5)` — Heule's field, **5-sealed**
(G43, row 52). It fails gate D and can never reach six. Its value is exactly what §14.4 used it for:
the like-for-like demonstration that the shape was the obstruction.

# §16 — The struck reframing, in my words

The follow-up's *"two members sharing a mechanism exactly, and a third arriving by a different one"*
rested on `n = 2` and `n = 3` both being case A with two families of 12. **`n = 3` is void (§13), so
at the moment that was written the case-A sample was ONE member.** I am striking that reading, and
with it the "three members at 24" observation of §11a, whose third instance was the void one.

**What replaces it, by a valid route:** `n = 4` shape-free carries case A with exactly two families
of 12 — **24** — so the case-A sample is **two members again**, both gate-B-valid, both with `V` the
full odd part, both matching the derivation of §14.2. And `n = 4` carries **case B as well**, which
kills the dichotomy the follow-up was reaching for.

**One thing that must not be inherited from the old reading:** `n = 16` showing case B only is a fact
about **Parts's rank-4 lattice**, not about the member. **Nothing measured says `n = 16` lacks
case-A cross edges** — its shape-free arena is ~41.7 million points and was never built. Any future
sentence of the form *"`n = 16` is a case-B member"* is unsupported.
