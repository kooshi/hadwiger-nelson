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

For the family `cos θ = (2n−1)/(2n)`, `sin θ = √(4n−1)/(2n)`, the sine leaves `K` (gate D of phase
H2 — if it did not, Theorem B four-colours the whole arena). So `p, q, c ∈ K` while `s ∈ √D·K`,
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

**40 of the first 300 members** carry a rational monochromatic off-diagonal kind:
`1, 3, 4, 6, 7, 12, 16, 24, 30, 39, 40, 48, 51, 52, 60, 70, 72, 84, 88, 96, 112, 115, 120, 126, 132,
135, 144, 160, 168, 180, 192, 198, 216, 220, 231, 232, 240, 259, 264, 286`.

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
