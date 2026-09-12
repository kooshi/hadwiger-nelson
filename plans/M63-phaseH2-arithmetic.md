# Phase H2, arithmetic side: the shell ceiling, computed two ways, and the two blocked questions

*Work order: the product owner, 2026-09-12, after `pari`/`gp` 2.17.4 was installed. This file is the
instrument, its controls, the ceiling table, and the answers to the two questions that were blocked on a
computer-algebra system. Nothing here is committed by me and nothing is staged; the paths are
listed in §9.*

---

## §1 — The ruling, in one paragraph

The quantity asked for — an arithmetic ceiling on the circle count of any denominator-`d` module in
`K = ℚ(√3,√11)` — exists, is **sharp**, and is computed here two independent ways. They agree at **every**
value tested in the region that matters (every `m` divisible by 4, which includes every `m = d²n` with
`12 | d`); outside it the formula route over-counts, and §2b says exactly where and why.

But the ceiling as stated is **not the useful screen**, and the reason is the phase's result rather than a
caveat: imposing `[Parts2020a]`'s **shape** constraint on it — `p₁ ∈ ℚ(√33)` and
`p₂ ∈ √3·ℚ ⊕ √11·ℚ` — turns the ceiling into a function that **reproduces all six measured counts exactly,
with no lattice built and no radius argued**, and that function has a **closed divisor formula** over a
different field. The shape constraint is therefore the whole story: it is worth a factor **2 to 6** at every
`n` where the circle is non-empty, and it is what makes the circle **empty** at `n = 2`. The unconstrained
ceiling at `n = 2` is **60**, not 0 — so `n = 2`, the cheapest wall-breaking and 6-open member of the
family, is **not** arithmetically poor. It is poor **for Parts's shape**, and a denominator-12 module that
drops that shape can have sixty points there and sixty unit vectors to hang on them, against Parts's
**zero** and **thirty**. Counted over the whole family: the phase's own target list of **two** 6-open
members with a non-empty circle is correct for Parts's shape and becomes **seven** for the denominator
(§4a). And on the phase's *original* target circle `|p|² = (7+√33)/3`, where the brief asks for **~30**
points: the ceiling is **36** at denominator 12 (and 108 at denominator 15), while under Parts's shape it
is **0 at every denominator** — and that zero is *derived*, from `(7+√33) = 𝔮₁𝔮₂³` having both exponents
odd at the two primes above 2 in `ℚ(√33)` (§3c).

**Three claims of my own were wrong, and none was caught by re-reading — each was caught by a control or by
extending the computation.** A characterisation of the formula's validity that I wrote from a dozen
hand-checks and attributed to a run I had not read (§2b, §8); a denominator-saturation law verified only on
**even** denominators and stated for all of them (§3b); and a ceiling value on the target circle verified
only at denominators with **odd part 3** and stated for all (§3c). All three have the same shape — a
pattern checked on one sub-family and asserted for the whole family. All three corrections are in place and
recorded where they happened rather than quietly fixed.

---

## §2 — The instrument

`O_K` has integral basis `⟨1, √3, (√3+√11)/2, (−1+√33)/2⟩` (pari `nfinit(x⁴−28x²+64)`), `h(K) = 1`,
`disc K = 17,424`. For a module point `p` with `|p|² = n` and denominator dividing `d`, the pair
`(a,b) = d·p` lies in `O_K²` with `a² + b² = d²n`. So every such module's shell injects into

```
Sh(m) = #{ (a,b) ∈ O_K² : a² + b² = m } ,      m = d²n
```

and `Sh(d²n)` bounds what **any** denominator-`d` point set in this field can put on the circle `|p|² = n`.
The bound is **attained**, by the full module `(1/d)·O_K²` — so "ceiling" is exact, not merely an upper
bound. It is finite for the reason established earlier in this phase: `n` is a rational integer, so all four
Galois conjugates of the radius are equal and no radius cut has to be argued.

### §2a — Route 1: enumeration

`a² + b² = m` forces `σ(a)² ≤ m` at all four real embeddings, hence `Tr(a²) ≤ 4m`. So `a` lies in a finite
ellipsoid of the rank-4 lattice `O_K` under the trace form, whose Gram matrix is

```
[  4   0   0  -2 ]
[  0  12   6   0 ]        det = 17,424 = disc K      <-- the enumerator's own control
[  0   6  14   0 ]
[ -2   0   0  34 ]
```

Enumerate that ellipsoid (Fincke–Pohst, exact integer filter), cut to the **box** `σ_k(a)² ≤ m`, square
every survivor through the multiplication tensor, and count pairs by lexicographic lookup. Both `a` and `b`
lie in the same box, so one enumeration suffices and the count is exact. Cost is `Θ(m²)`; measured
**8.7 s at m = 4,608** on the desktop, single-threaded.

### §2b — Route 2: the divisor formula

Two formulas, for two different quantities, and **only one of them is the ceiling**.

**(i) The shape-constrained count — the one that matters.** Parts's shape says `p₁ = a/d` with
`a ∈ O_F`, `F = ℚ(√33)`, and `p₂ = b/d` with `b ∈ √3·ℤ ⊕ ((√3+√11)/2)·ℤ`. Writing `b = √3·v`, the equation
`a² + b² = m` becomes

```
a² + 3v² = m
```

— a relative norm from `L = F(√−3) = ℚ(√−3, √−11)`. **So the shape constraint replaces the form `x²+y²` over
the quartic field `K` by the form `x²+3y²` over the quadratic field `ℚ(√33)`.** That is the whole content of
the constraint, and everything follows from it. pari: `h(L) = 1`, `μ(L)` has order **6**, and
`disc L = 1089 = 33² = disc(F)²`, so `L/F` is **unramified at every finite prime**. The classical count
therefore applies with no class-group and no unit correction:

```
Shape(m) = 6 · ∏_{𝔮 of F} local( v_𝔮(m) ),
   local(e) = e + 1                          if 𝔮 splits in L/F
            = 1 if e even, 0 if e odd        if 𝔮 is inert in L/F
```

**Scope of this formula, stated exactly.** The constant `6` was **identified** as `|μ(L)|` and the whole
formula then **verified against the enumeration**, not derived from first principles. Two loose ends I did
not close: (i) `b` ranges over `√3·ℤ ⊕ ((√3+√11)/2)·ℤ`, which is strictly larger than Parts's own
`√3·ℤ ⊕ √11·ℤ` — the two give identical counts at every `m` tested (the "integral" column of §4's
decomposition never differs from the "shape" column), but that is a measurement, not a proof; and
(ii) writing `b = √3 v` puts `v` in a lattice with denominator 6, so which **order** of `L` is being counted
is not spelled out, and the clean agreement suggests it is the maximal one without demonstrating it. What is
established is that this closed form reproduces the enumeration at **60 consecutive values** (`n = 1..60`,
`m = 144..8640`) with **zero disagreements on either count**, of which `n = 33..60` were computed *after*
the formula was fixed and played no part in fitting it; plus `d ∈ {1,2,3,4,6,12}` at five values of `n`,
and the seven `α`-circle denominators of §3c.

The splitting rule, every case checked against pari:

| `𝔮` | behaviour in `L/F` | why |
|---|---|---|
| `𝔮 \| 2` | **INERT**, residue field `𝔽₄` | 2 splits in `F` (33 ≡ 1 mod 8) so `F_𝔮 = ℚ₂`, and `ℚ₂(√−3)` is the **unramified** quadratic extension |
| `𝔮 \| 3` | SPLIT | |
| `𝔮` odd, `f(𝔮/p)` even | SPLIT | every element of `𝔽_p` is a square in `𝔽_{p²}` |
| `𝔮` odd, `f(𝔮/p) = 1` | SPLIT iff `p ≡ 1 (mod 3)` | `−3` is a quadratic residue mod `p` iff `p ≡ 1 (mod 3)` |

**(ii) The unconstrained ceiling.** `Sh(m)` counts elements of `O_K[i] = O_K ⊕ O_K·i`, which is **not** the
maximal order of `K(i)` — `ζ₁₂ = (√3+i)/2` is an algebraic integer of `K(i)` and is not in it. The
maximal-order count does have the clean formula (`h(K(i)) = 1`, `μ` of order 12, `K(i)/K` unramified at
every finite prime — the primes above 2 are inert, §5):

```
Max(m) = 12 · ∏_{𝔮 of K} local( v_𝔮(m) )        [same local rule, for K(i)/K]
```

and, measured over `m = 1..400`:

> **`Max(m) = Sh(m)` whenever `4 | m`** (all 100 multiples of 4, no exceptions). For `m` not divisible by 4
> the formula strictly **over**-counts whenever it is non-zero; it is **never** an under-count. The only
> other agreements are the 16 degenerate ones where both sides are **0**
> (`m = 83, 107, 131, 166, 167, 214, 227, 239, 249, 262, 263, 321, 334, 347, 359, 393`).

So the clean statement is *"`4 | m` is sufficient, and for `Max(m) > 0` it is also necessary"* — **not**
"exactly when `4 | m`", which is what I first wrote into this file from hand-checking a dozen values before
the run that was supposed to establish it had produced anything. The run, when it finally ran, printed
`every agreeing m divisible by 4 ? False`. See §8.

Every `m = d²n` in this phase has `144 | m`, so the formula is valid throughout the region of interest —
but the boundary is stated rather than glossed, because `Sh(1) = 4` while `Max(1) = 12`, and the gap is
the suborder index at 2. Largest gap seen: `m = 315`, where `Sh = 96` and `Max = 960`.

**Was the formula worth building?** Yes, and not for speed — the enumeration answers every question anyone
will ask in this phase in seconds. It was worth building because it **derives** the 2-adic emptiness law
that had been measured 30 times and asserted as a law (§6), and because it **corrects** that law's converse.

---

## §3 — The ceiling table

`d = 12`. `ceiling = Sh(144n)`, the sharp maximum for any point set with `12p ∈ O_K²`. `shape = ` the same
under Parts's shape constraint. `wall`/`11`/`6-open` are the existing gates, recomputed here from the
squarefree part `r` of the radicand `4n−1`: wall broken iff `r` odd and `r ≡ 5, 7 (mod 8)`; `11` inert iff
`r` is a non-residue mod 11; 6-open iff both.

| `n` | `4n−1` | sqfree | `v₂(n)` | wall | 11 | 6-open | ceiling `Sh(144n)` | shape | ratio | measured |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 3 | 3 | 0 | – | sp | – | 60 | 30 | 2× | |
| **2** | **7** | **7** | **1** | **BRK** | **in** | **YES** | **60** | **0** | – | **0** |
| 3 | 11 | 11 | 0 | – | sp | – | 84 | 42 | 2× | |
| **4** | 15 | 15 | 2 | BRK | sp | – | 60 | **30** | 2× | **30** |
| 5 | 19 | 19 | 0 | – | in | – | 240 | 60 | 4× | |
| 6 | 23 | 23 | 1 | BRK | sp | – | 84 | 0 | – | |
| 7 | 27 | 3 | 0 | – | sp | – | 240 | 60 | 4× | |
| 8 | 31 | 31 | 3 | BRK | sp | – | 60 | 0 | – | |
| **9** | 35 | 35 | 0 | – | in | – | 108 | **54** | 2× | **54** |
| 10 | 39 | 39 | 1 | BRK | in | YES | 240 | 0 | – | |
| 11 | 43 | 43 | 0 | – | in | – | 60 | 30 | 2× | |
| **12** | 47 | 47 | 2 | BRK | sp | – | 84 | **42** | 2× | **42** |
| 13 | 51 | 51 | 0 | – | in | – | 240 | 60 | 4× | |
| 14 | 55 | 55 | 1 | BRK | sp | – | 240 | 0 | – | |
| 15 | 59 | 59 | 0 | – | sp | – | 336 | 84 | 4× | |
| **16** | **63** | **7** | **4** | **BRK** | **in** | **YES** | 60 | **30** | 2× | **30** |
| 17 | 67 | 67 | 0 | – | sp | – | 240 | **0** | – | |
| 18 | 71 | 71 | 1 | BRK | sp | – | 108 | 0 | – | |
| 19 | 75 | 3 | 0 | – | sp | – | 240 | 60 | 4× | |
| **20** | **79** | **79** | **2** | **BRK** | **in** | **YES** | 240 | **60** | 4× | **60** |
| 21 | 83 | 83 | 0 | – | in | – | 336 | 84 | 4× | |
| 22 | 87 | 87 | 1 | BRK | in | YES | 60 | 0 | – | |
| 23 | 91 | 91 | 0 | – | sp | – | 240 | 60 | 4× | |
| 24 | 95 | 95 | 3 | BRK | in | YES | 84 | 0 | – | |
| 25 | 99 | 11 | 0 | – | sp | – | 540 | 90 | 6× | |
| 26 | 103 | 103 | 1 | BRK | sp | – | 240 | 0 | – | |
| 27 | 107 | 107 | 0 | – | in | – | 132 | 66 | 2× | |
| 28 | 111 | 111 | 2 | BRK | sp | – | 240 | 60 | 4× | |
| 29 | 115 | 115 | 0 | – | sp | – | 240 | **0** | – | |
| 30 | 119 | 119 | 1 | BRK | sp | – | 336 | 0 | – | |
| 31 | 123 | 123 | 0 | – | in | – | 240 | 120 | 2× | |
| **32** | 127 | 127 | 5 | BRK | in | YES | 60 | 0 | – | |

### §3a — A free tightening of gate A: wall-breaking is exactly `n` even

The `wall` column of the table is **precisely the even `n`**, with no exceptions, and that is a one-line
theorem rather than an observation. `4n − 1` is odd, so its squarefree part `r` satisfies `r·k² = 4n−1`
with `k` odd, hence `k² ≡ 1 (mod 8)` and `r ≡ 4n − 1 (mod 8)`. Since `4n` is `0` or `4 mod 8`:

```
n odd   ->  4n-1 = 3 (mod 8)  ->  r = 3 (mod 8)  ->  wall STANDS, always
n even  ->  4n-1 = 7 (mod 8)  ->  r = 7 (mod 8)  ->  wall BREAKS, always
```

So **the family's odd members can never break the 2-adic wall and its even members always do** — the check
per member is unnecessary. This also disposes of a small inconsistency in the standing notes: `CLAUDE.md`
G35 states the wall-breaking classes as `≡ 7 (mod 8)` and G37 as `≡ 5, 7 (mod 8)`. For **this** family the
question is moot, because `r ≡ 5 (mod 8)` would force `4n ≡ 6 (mod 8)`, which is impossible; every member's
squarefree radicand is `3` or `7 mod 8` and never `5`. The discrepancy still wants settling for other
families, but it cannot affect any row of the table above.

Combining with §6, the family's gates collapse to arithmetic on `n` alone:

| requirement | condition on `n` |
|---|---|
| wall-breaking | `n` even |
| 6-open | `n` even **and** the squarefree part of `4n−1` a non-residue mod 11 |
| non-empty circle **under Parts's shape** | no prime of `ℚ(√33)` inert in `ℚ(√−3,√−11)` divides `144n` to odd order — at 2 this is `v₂(n)` even |
| non-empty circle **for some denominator-12 module** | `Sh(144n) > 0`, which holds at every `n ≤ 32` |

The last two rows are the phase's finding: the third forces `4 | n` and leaves `{16, 20}` at `n ≤ 32`
(reproducing §6c of the family file), while the fourth imposes **nothing** in that range.

### §3b — Denominator dependence, and two facts that surprised me

`Sh(d²n)`, enumerated (and cross-checked against the formula at every `m` with `4 | m`):

| `n` | `d=1` | `d=2` | `d=3` | `d=4` | `d=6` | `d=12` |
|---|---|---|---|---|---|---|
| 1 | 4 | 12 | 4 | 12 | **60** | **60** |
| 2 | 4 | 12 | 4 | 12 | **60** | **60** |
| 4 | 12 | 12 | 60 | 12 | 60 | 60 |
| 9 | 4 | 60 | 12 | 60 | **108** | **108** |
| 16 | 12 | 12 | 60 | 12 | 60 | 60 |

and the shape-constrained version of the same table:

| `n` | `d=1` | `d=2` | `d=3` | `d=4` | `d=6` | `d=12` |
|---|---|---|---|---|---|---|
| 1 | 2 | 6 | 2 | 6 | 30 | 30 |
| **2** | **0** | **0** | **0** | **0** | **0** | **0** |
| 4 | 6 | 6 | 30 | 6 | 30 | 30 |
| 9 | 2 | 30 | 6 | 30 | 54 | 54 |
| 16 | 6 | 6 | 30 | 6 | 30 | 30 |

**Fact 1 — for EVEN `d`, the ceiling saturates in the 2-part of the denominator.** `d = 6` and `d = 12`
give identical ceilings, and so do `d = 24, 48, 96`: among **even** `d`, `Sh(d²n)` depends only on the
**odd part** of `d`. Verified: `d = 4, 8, 16, 32, 64` all give 12 at `n = 1, 2, 4, 16`; `d = 6, 12, 24` all
give 60; `d = 18, 36, 72` all give 108. The reason is the ramification parity of §6a — **2 is ramified in
`K`, so `v_𝔭(d²n)` at a prime above 2 is `2·(…)`, always even, and the local factor is 1 however much 2 the
denominator carries.**

*Correction, and it is mine.* I first wrote this as "`Sh(d²n)` depends on `d` only through its odd part",
full stop, having verified it on `d = 4, 8, 16, 32, 64 / 6, 12, 24 / 18, 36, 72` — **every one of which is
even.** It is **false for odd `d`**: at `n = 1`, `d = 3` gives **4** where `d = 6` gives **60**, and `d = 9`
gives **12** where `d = 18` gives **108**, though 3 and 6 share an odd part and so do 9 and 18. The reason
is §2b's boundary: for odd `d` and odd `n`, `4 ∤ d²n`, so the ideal formula no longer equals the count and
the suborder index at 2 bites. **The saturation is a fact about the formula's regime, and I had verified it
only inside that regime while stating it outside.** Found while computing §3c, not by re-reading.

Design consequence, which survives the correction: **there is nothing to gain from denominator 24 over 12,
or 48 over 24.** To raise the ceiling you must raise the **odd** part — `d = 36` buys 108 where `d = 12`
buys 60, because `v₃` rises.

**Fact 2 — under Parts's shape, `n = 2` is empty at EVERY denominator, not just 12.** `v₂(d²n) = 2v₂(d) +
v₂(n)` has the **same parity as `v₂(n)` for every `d`**, so the inert-prime-at-odd-exponent obstruction of
§6 is a **denominator-independent invariant**. Checked: no `d ≤ 199` gives a non-empty shape circle at
`n = 2`, and no `(n, d)` with `v₂(n)` odd does either, over `n < 60` and `d ∈ {1,…,7,12,24,36,60}`.

This is strictly stronger than §6c of the family file, which said the emptiness was beyond *"any refinement
of this lattice"*. The correct statement in both directions: **Parts's shape forbids `v₂(n)` odd at every
denominator; the shape is the only thing forbidding it, and `O_K²` itself — denominator 1 — already has
four points at `|p|² = 2`,** namely `(±1, ±1)`.

### §3c — The phase's ORIGINAL target circle, `|p|² = (7+√33)/3`

Not part of the one-integer family — this is the circle the "find a new base" brief aims at, with a stated
target of **~30 module points**, because that count *is* the usable cross-edge count. `α = (7+√33)/3` is
not a rational integer, so the finiteness argument of §2 does not apply directly; but `d²α ∈ O_K` whenever
`3 | d`, and `d²α` is **totally positive** (embeddings `4.248` and `0.418`), so the generalised enumerator
`Sh_elt` handles it. Its control: the same code path reproduces `Sh(m)` exactly at `m = 288, 576, 1296`.

| `d` | `d²α` | candidates | **ceiling** | under Parts's shape |
|---|---|---|---|---|
| 3 | `3(7+√33)` | 23 | **12** | 0 |
| 6 | `12(7+√33)` | 281 | **36** | 0 |
| 9 | `27(7+√33)` | 1,417 | **28** | 0 |
| 12 | `48(7+√33)` | 4,481 | **36** | 0 |
| 15 | `75(7+√33)` | 10,921 | **108** | 0 |
| 18 | `108(7+√33)` | 22,615 | **84** | 0 |
| 24 | `192(7+√33)` | 71,501 | **36** | 0 |

**So the brief's target of ~30 points on that circle is arithmetically reachable — 36 already at `d = 12`,
and 108 at `d = 15` — and it is unreachable under Parts's shape, where it is 0.** Two things to read off
carefully:

**The zero under Parts's shape is a theorem here, not an observation.** In `F = ℚ(√33)`,
`N(7+√33) = 16` and pari gives the ideal factorisation `(7+√33) = 𝔮₁ · 𝔮₂³` at the two primes above 2 —
**both exponents odd.** Multiplying by `d²` adds `2v₂(d)` to each and cannot change a parity, so an inert
prime sits at odd exponent for **every** `d`, and §6's obstruction fires every time. Confirmed at
`d = 3, 6, 9, 12, 15, 18, 24`; derived for all `d`.

**The ceiling does NOT saturate at 36** — I wrote that it did, on the strength of `d = 6, 12, 24`, all of
which have odd part 3. Extending to `d = 9, 15, 18` gives **28, 108, 84**. The Fact 1 pattern still holds
(`6, 12, 24` agree because they share an odd part; `9` is odd and `18` is even with odd part 9, and they
differ), but "36 is the ceiling on this circle" is only true at denominators with odd part 3. **This is the
third claim of mine in this file that was right inside the range I checked and wrong outside it**, and all
three had the same shape: a pattern verified on one sub-family and stated for all.

This agrees with §4 of the family file, which measured 0 points there on Parts's lattice and attributed it
to `α` not being a square in `K`. The sharper reading: `α` not being a square is what removes the
free-circle theorem (so the circle is not `k·S` and carries no automatic unit degree), while what makes the
count **0 rather than merely small** is the 2-adic parity of `(7+√33)` against Parts's shape.

---

## §4 — The `n = 2` discriminator, which is the phase-relevant result

`n = 2` is the **cheapest member of the family that is both wall-breaking and 6-open** (`4n−1 = 7`, and
`7 ≡ 7 mod 8` breaks the 2-adic wall while `7` is a non-residue mod 11, so 11 is inert — confirmed
independently in §5(b), where the primes above 11 in `ℚ(√3,√7,√11)` are computed to have residue field
`𝔽₁₂₁`). Parts's lattice scores **0** there. The ceiling is **60**, and all sixty are listed in the
artifact. Printed **from the artifact**, they fall into exactly five coordinate patterns — and this is the
whole proof that the shape is what excludes them:

```
count   p1                                        p2
   32   -1/4 + 1/12 V3 - 1/4 V11 - 1/12 V33       -1/4 - 1/12 V3 + 1/4 V11 - 1/12 V33
    8   -1/6 V3 - 1/6 V33                          1/6 V3 - 1/6 V33
    8   -5/6 - 1/6 V11                             5/6 - 1/6 V11
    8   -1/2 - 1/2 V3                             -1/2 + 1/2 V3
    4   -1                                        -1
  ---
   60                                             (V3, V11, V33 are the three square roots)
```

Each `|p|²` is recomputed exactly and equals `2` with all three radical parts zero. Parts's shape needs
`p₁` supported on `{1, √33}` and `p₂` on `{√3, √11}`; **not one of the five patterns satisfies that**, which
is why his count is 0 rather than merely low. Note the last row: `p = (±1, ±1)` has denominator **1** — it
lies in `O_K²` itself — and is excluded from Parts's lattice for the single reason that `1` is not in
`√3·ℚ ⊕ √11·ℚ`.

Of those sixty, **thirty have distinct `a`-coordinates and each admits exactly two `b`** — the classical
`±b` structure, and a check that nothing is double-counted (list length 60, distinct pairs 60, distinct
`a`-values 30; printed from the artifact, not from memory).

**What this says, stated at exactly its own scope.** §6c of the family file concluded that the members with
an odd power of 2 are *"empty for a 2-adic reason no radius and no refinement of this lattice can fix."*
That is **correct for refinements** — a sublattice only loses points — and **wrong for the denominator**. The
obstruction is not the denominator 12 and not the radius; it is the **shape**. Specifically:

| what is constrained | `n = 2` circle | unit shell (`n = 1`) |
|---|---|---|
| Parts's lattice (shape + integrality + his two congruences) | **0** | **30** |
| any denominator-12 point set with `12p ∈ O_K²` | **60** | **60** |

and the unit shell matters because `(1/12)O_K²` is a module, so every circle point `q` has all sixty
norm-one vectors available as unit neighbours, `q + s ∈ (1/12)O_K²` by closure. The free-circle theorem of
§4 of the family file does **not** apply at `n = 2` (2 is not a perfect square, so the circle is not `k·S`),
so the degree has to be argued this way instead — and it comes out to sixty available rather than one.

### §4a — The target list, and the number that changes

Over `n ≤ 32` the family has **seven** 6-open members. Parts's shape leaves **two** of them with a
non-empty circle. The arithmetic ceiling leaves **all seven**.

| | `n` values | count |
|---|---|---|
| 6-open members (`n` even, squarefree part of `4n−1` a non-residue mod 11) | 2, 10, 16, 20, 22, 24, 32 | **7** |
| …of those, non-empty circle **under Parts's shape** | 16, 20 | **2** |
| …of those, non-empty circle **for some denominator-12 module** | 2, 10, 16, 20, 22, 24, 32 | **7** |

The middle row reproduces §6c of the family file exactly, including its conclusion that *"the search space
for this phase is two objects."* The bottom row is the correction: **the search space is two objects for
Parts's shape and seven for the denominator.** The five that the shape excludes — `n = 2, 10, 22, 24, 32` —
have ceilings `60, 240, 60, 84, 60` respectively, so none of them is arithmetically thin; `n = 10` has the
**largest** ceiling of the seven.

I want to be exact about what this is and is not. It is **not** five new candidate objects: it is five
values of `n` at which the field arithmetic permits a denominator-12 circle and Parts's coordinate shape
forbids one. Whether any of the five admits a finite, group-closed arena under a four-conjugate disk cut is
untested, and is item 1 of §10.

**Both outcomes were reachable and were stated before the run.** A small gap would have said `n = 2` is
arithmetically poor; a large one says Parts's lattice leaves everything on the table. The apparatus can
return zero, and the reachability has to be stated **per instrument** because the two differ:
the **shape** count is 0 at **13 of the 32** table rows (`n = 2, 6, 8, 10, 14, 17, 18, 22, 24, 26, 29, 30,
32`), while the **ceiling** is 0 at **none** of them — its first zeros are outside the table, at
`m ∈ {83, 107, 131, 166, 167}` for `Sh(m)` directly and at `n ∈ {83, 107, 131, 166, 167, 214, 227, 239}`
for `Sh(144n)`. So a zero at `n = 2` was available to the ceiling and was not what came out.

---

## §5 — The two questions that were blocked

### (a) Is `101 − 11√33` a sum of two squares in `K`? — **YES**

`K(i)/K` is a quadratic extension, so the **Hasse norm theorem** applies and the question is local
everywhere; `nfhilbert` settles it with no class-field computation (the `rnfisnorm` route needs
`rnfisnormtinit` on a degree-8 field and did not finish in two minutes; this one is instant).

- `101 − 11√33 = 90 − 22·(−1+√33)/2` is in `O_K`; all four real embeddings positive (`37.81`, `164.19`
  twice each), so no archimedean obstruction.
- `N_{K/ℚ} = 38,539,264 = 2¹² · 97²`; ideal factorisation `𝔭₁¹⁰ 𝔭₂² 𝔮 𝔮'` with `𝔭ᵢ` above 2
  (`e=2, f=1`) and `𝔮, 𝔮'` above 97 (`e=f=1`, and `97 ≡ 1 mod 4`).
- **Global Hilbert symbol `(101−11√33, −1)_K = 1`**, and every local symbol is `+1` — at both primes above
  2 and both above 97.

**Explicit witnesses** (16 ordered representations, 8 unordered; found by the enumerator generalised to
totally non-negative elements of `O_K`, then re-verified in a **second, independent** exact-arithmetic
routine written in the `(1, √3, √11, √33)` basis rather than the integral basis — with a negative control
confirming that a deliberately wrong pair fails):

```
( (11 − 4√3 − √33)/2 )² + ( (11 + 4√3 − √33)/2 )² = 101 − 11√33
( (5 − 3√33)/2 )²     + ( (7 − √33)/2 )²          = 101 − 11√33
```

The second one lies **entirely in the subfield `F = ℚ(√33)`** — so `101 − 11√33` is a sum of two squares
already in `ℚ(√33)`, not merely in `K`. **So the antipodal family of connecting edges is not excluded by
this obstruction**, and a witness is available in the smaller field.

*Controls on the instrument, all four behaved:* `(2,−1) = +1` and `(3,−1) = +1` (both are sums of two
squares in `K`, `2 = 1²+1²` and `3 = (√3)²+0²`); `(−1,−1) = −1` and `(−(101−11√33), −1) = −1` (negative at
a real place, so not a sum of two squares in any real field).

### (b) Residue degrees — both **`f = 2`**, and both load-bearing claims confirmed

| prime | field | primes above it | `e` | `f` | residue field |
|---|---|---|---|---|---|
| **2** | `K(i) = ℚ(√3,√11,i)`, degree 8 | **2** | 2 | **2** | **`𝔽₄`** |
| **11** | `ℚ(√3,√7,√11)`, degree 8 | **2** | 2 | **2** | **`𝔽₁₂₁`** |

`Σ e·f = 8` in both cases, which is the computation's own arithmetic check.

- **Theorem B's hypothesis is confirmed independently of our Lean proof.** Theorem B
  (`χ(K²) = 4`, kernel-checked here) rests on the primes above 2 in `K(i)` having residue field `𝔽₄`. They
  do. The relative reading: `K` has two primes above 2 with `e=2, f=1` (residue field `𝔽₂`), and `f` jumps
  `1 → 2` in `K(i)`, so each is **inert** in `K(i)/K`. `K(i)/K` is therefore unramified at 2 — and, since
  the relative discriminant divides `(2)`, unramified at **every** finite prime.
- **`ℚ(√3,√7,√11)` being 6-open is confirmed.** 11 has residue degree 2 there, so the residue field is
  `𝔽₁₂₁`, and **`−1` is a square in `𝔽₁₂₁` but not in `𝔽₁₁`** (checked both ways in pari; `|𝔽₁₂₁*| = 120`
  and `4 | 120`). So the prime of that field's `i`-extension **splits** and delivers no bound, which is
  exactly what 6-open means. Note this is the field `K(√7)` reached by the family at **`n = 2`** and at
  **`n = 16`** — the two members whose radicand has squarefree part 7.

*Hand control, computed independently before pari was asked, and it agrees at every step:* **3 is a
quadratic residue mod 11** (`5² = 25 ≡ 3`), so 11 **splits** in `ℚ(√3)` with `f=1`; **7 is a non-residue
mod 11** (the residues are `{1,3,4,5,9}`), so 11 is **inert** in `ℚ(√7)` with `f=2`; and 11 **ramifies** in
`ℚ(√11)` with `e=2`. Hence `e=2, f=2, g=2` in the compositum, which is what pari returned. *Instrument
controls:* 2 ramifies in `ℚ(i)`, 5 splits, 3 is inert — all three classical facts returned correctly.

---

## §6 — The 2-adic emptiness law, derived — and its converse is FALSE

§6c of the family file recorded, from 30 measured values, that *"every `n` whose power of 2 is odd has an
empty circle over Parts's lattice."* The formula derives it, and the mechanism is one line:

> `(144n) = 𝔮₂^{4+v₂(n)} · 𝔮₂'^{4+v₂(n)} · (odd part)` in `F = ℚ(√33)`, and **both primes above 2 are
> inert in `L = ℚ(√−3,√−11)` with residue field `𝔽₄`**, so an **odd** exponent contributes a factor **0**.
> `4 + v₂(n)` is odd exactly when `v₂(n)` is odd. ∎

**But the converse fails, at `n = 17` and `n = 29`** — both odd, both with a non-empty circle under the
"odd power of 2" reading, and both measured **0** here. The reason is a **second inert prime**: 17 and 29
each split in `ℚ(√33)` into primes that are **inert in `ℚ(√−3,√−11)`** (equivalently `17 ≢ 1` and
`29 ≢ 1 mod 3`), and they divide `144n` to exponent 1. So the correct law is:

> **The Parts-shape circle at `|p|² = n` is empty iff some prime `𝔮` of `ℚ(√33)` that is inert in
> `ℚ(√−3,√−11)` divides `(144n)` to odd order.** At `𝔮 | 2` that is `v₂(n)` odd; at odd `𝔮` it is a prime
> `p ≢ 1 (mod 3)` with `f(𝔮/p) = 1` dividing `n` to odd order.

### §6a — The mechanism, in one sentence: 2 is ramified in `K` and split in `ℚ(√33)`

This is the whole finding, and it is a statement about **ramification parity**.

| | `K = ℚ(√3,√11)` | `F = ℚ(√33)` |
|---|---|---|
| behaviour of 2 | **ramified**, `e = 2` (two primes, `f = 1`) | **splits**, `e = 1` (two primes, `f = 1`) |
| `v_𝔭(144n)` at a prime above 2 | `2·(4 + v₂(n))` — **always even** | `4 + v₂(n)` — **parity of `v₂(n)`** |
| relevant CM extension | `K(i)`, primes above 2 **inert**, residue `𝔽₄` | `ℚ(√−3,√−11)`, primes above 2 **inert**, residue `𝔽₄` |
| consequence | inert-at-odd-exponent **can never fire** at 2 | it fires exactly when `v₂(n)` is odd |

So: **Parts's shape constraint moves the counting problem from a field where 2 ramifies to a field where 2
splits, and that single change hands the 2-adic parity obstruction its foothold.** In `K` the ramification
index 2 doubles every exponent above 2, so the parity test at the inert prime is passed automatically and
no power of 2 in `n` can empty the circle — which is why `Sh(144n) > 0` at every `n ≤ 32`. In `ℚ(√33)` the
exponent is `4 + v₂(n)` on the nose, and an odd `v₂(n)` kills it.

**Measured over `n = 1..2000` with the formula (seconds, no lattice).** Of those 2,000 values:

| | count | first few |
|---|---|---|
| ceiling `Sh(144n) = 0` — **no** denominator-12 module can reach the circle | **149** | `n = 83, 107, 131, 166, 167, 214, 227, 239` |
| …and **not one of them is a power of 2** | 0 | — |
| shape count `= 0` — Parts's shape cannot reach it | **998** | includes every `n` with `v₂(n)` odd (666 of them) |
| every `n` with `v₂(n)` odd is empty under the shape | 666 of 666 | law holds |

So the shape constraint is **6.7× more often fatal** than the field arithmetic is, and its failures are
concentrated exactly where the ramification parity says they must be. (Both outcomes reachable for both
instruments: the ceiling returns 0 at 149 values and positive at 1,851; the shape count 0 at 998 and
positive at 1,002.)

Both fields have an inert prime above 2 with residue field `𝔽₄`, so the *obstruction* is the same one in
both places. The difference is purely whether the exponent can be odd — and that is decided by `e`, not by
the design, not by the radius, and not by the denominator.

This was found by the control, not by looking for it: the emptiness law was asserted as an equivalence in
the run script, and the run printed two counterexamples. **The law's measured direction was right and its
stated direction was wider than its evidence** — 30 values all had `v₂` odd *or* a non-empty circle, and
none of the 30 was 17 or 29.

---

## §7 — Is the ceiling the right quantity? — partly, and here is the right one

**No, if "ceiling" means the unconstrained `Sh(d²n)`.** It is sharp, and it is attained by `(1/d)O_K²`,
which is a legitimate module with a finite shell at every rational-integer `n`. But as a **screen** it
almost never bites: it is a factor 2–6 above anything Parts's shape can reach, so a candidate that passes
it has learned little.

**Yes, in one specific and decisive way:** a ceiling of **60 at `n = 2`** against a measured **0** says the
emptiness is a property of the *design*, not of the *arithmetic* — and that is a statement only the
unconstrained ceiling can make. An instrument that only ever computed Parts's shape would have reported 0
and reinforced the wrong conclusion.

**The right quantity for screening is the shape-constrained count**, `Shape(d²n)`, because it
(i) reproduces every measured number exactly, (ii) has a closed formula, and (iii) localises the obstruction
to a named prime in a named field. And the right quantity for **design** is the pair
`(Shape, ceiling)` — the second says what a different shape would buy.

**One caveat I cannot discharge and will not hide.** The ceiling counts points on the circle. It does not
know whether a point set attaining it can simultaneously be (i) closed under the order-24 group that makes
orbit-level selection sound, (ii) finite under an exact disk cut, and (iii) actually joined by the
cross-edge law. Dropping the shape constraint changes (ii) concretely: Parts's `|p|²` always lies in
`ℚ(√33)`, which is why his exact disk cut has **two** conjugate conditions; a shape-free module has four,
so the arena is a rank-8 Minkowski region rather than a rank-4 one. That is a different object to build,
not a blocked one — **but nobody has built one, and the sixty points at `n = 2` are an arithmetic
possibility, not a constructed base.** Calling them a base would be exactly the overclaim this project
catalogues.

---

## §8 — Controls, each with what it caught or would have caught

| control | what it guards | verdict |
|---|---|---|
| trace-form Gram determinant `= disc K = 17,424` | the transcribed field data | passed before anything was believed |
| multiplication tensor vs the four real embeddings, 200 random pairs | the transcribed multiplication table | passed |
| Gram matrix vs `Σ_k σ_k(x)σ_k(y)`, 200 random pairs | the trace form | passed |
| **independent naive enumerator** (rectangular coordinate box, pure-Python integers, no Cholesky, no key encoding) vs the fast one, `m = 1..40` | the whole enumeration | **CAUGHT A REAL DEFECT** — see below |
| key-collision assertion: key-based distinct count `==` `np.unique(axis=0)` | the lookup layer | now guards the defect the naive enumerator found |
| `cnt.max() ≤ 2` — no element of a field has three square roots | the same | passed |
| ellipsoid-only vs box-filtered count, 7 values | the box filter drops nothing | passed |
| **two-sided plant** `0 < (guarded − planted) < guarded` on the ellipsoid radius | that the plant fires at all | **FIRED ITS LOWER BOUND** — see below |
| **two-sided plant** on the box (the binding constraint), `m = 288, 576, 1296, 1728` | the enumeration's necessary condition | passed both bounds at all four `m` (diffs 32, 44, 76, 60 against guarded 60, 60, 108, 84) |
| plant: corrupt the square-test target | the pairing step | count changes, as required |
| half-integer assertion on standard-basis coordinates | `int(Fraction(5,2)) == 2` in Python | **latent hazard, now asserted**; zero occurrences at every `m` tested |
| vectorised shape filter vs the slow pair-list version, `n ∈ {1,2,4,9,12}` | the rewrite | exact agreement on all four nested counts |
| **six measured counts** | the ceiling must dominate | all six dominated, **and the shape column equals all six exactly** |
| zero is reachable, **checked separately for each instrument** | the apparatus can return the uninformative answer | shape count 0 at **13 of 32** table rows; ceiling 0 at **none** of them, first zeros at `m = 83, 107, 131, 166, 167` and `n = 83, 107, …` |
| hand derivation of (b) before pari was asked | the residue-degree computation | agrees at every step |
| four Hilbert-symbol controls, two positive and two negative | the (a) instrument | all four behaved |
| `Σ e·f = 8` in both degree-8 fields | the prime decompositions | passed |
| the denominator-saturation claim re-tested on **odd** `d` | that a claim verified inside a regime was stated outside it | **CAUGHT MY SECOND WRONG CLAIM** — saturation holds for even `d` only; see §3b |
| the α-circle ceiling extended from `d ∈ {3,6,12,24}` to `d ∈ {9,15,18}` | that a constant seen on one odd-part family was stated for all `d` | **CAUGHT MY THIRD WRONG CLAIM** — 36 is not the ceiling there; 28, 84, 108 also occur; see §3c |
| `(7+√33)`'s ideal factorisation in `ℚ(√33)` (pari) | whether the α-circle zero is a measurement or a theorem | **theorem** — `𝔮₁𝔮₂³`, both exponents odd, so zero at every `d` |
| `Sh_elt` (arbitrary totally-positive `μ`) vs `Sh` on rational integers, `m = 288, 576, 1296` | the generalised code path used for §3c and §5(a) | exact agreement |
| `Max(m)` vs `Sh(m)` on `m = 1..400` | the formula's domain of validity | **CAUGHT MY OWN WRONG CLAIM** — see below. Correct result: equality whenever `4 \| m`; over-count otherwise; never an under-count |
| **out-of-table stress**: both formulas vs enumeration at `n = 33..60`, none of which was used to build either formula | that the formulas were fitted rather than derived | **28 of 28 agree on the ceiling AND 28 of 28 on the shape count** — so 60 independent values in total (`n = 1..60`), including all 13 + 12 zeros |

**The defect the naive enumerator caught.** The first version of the fast enumerator packed four integer
coordinates into a single `int64` with base `2²²`. That is `2⁸⁸` — a **silent overflow**, which collapsed
every square to one key and made every pair match. It reported `Sh(1) = 9` where the answer is 4, and
`Sh(m)` **monotone increasing** in `m`, which is not a property the true function has. It was caught on the
first line of the first comparison. Two things are worth recording: the defect made the counts **too large**,
which for a *ceiling* reads as a safely conservative bound and would have passed a domination check against
all six measured counts; and the guard that now catches it directly is not a smarter encoding but an
assertion comparing the key-based distinct count against an independently computed one.

**A claim I put in this file before the run that was meant to establish it had produced anything.** The
first version of §2b asserted that the formula equals the ceiling *"exactly when `4 | m`"*, citing a run
over `m = 1..300`. I had hand-checked about a dozen values (`m = 1,2,3,4,5,6,8,12,16,20,24,28`), all
consistent, and wrote the general claim while the run was still going. The run then had to be killed — it
was enumerating an ellipsoid at `n ≈ 139`, holding **7.9 GB** and climbing, on a machine I had been told to
keep light — and because its output was sitting in a pipe buffer, **the kill destroyed the very numbers the
claim cited.** Re-run bounded, it printed `every agreeing m divisible by 4 ? False`: there are 16 further
agreements in `1..400`, all of them the degenerate case where both sides are 0. The claim as written was
**false**, and the corrected form is in §2b.

Three separate things went wrong and each has a fix worth keeping:
1. **I wrote a general claim from a dozen instances and attributed it to a run I had not read.** The
   attribution is what makes it bad rather than merely premature — a later reader would have seen a cited
   measurement, not a guess.
2. **The kill destroyed the evidence.** `python3` buffers stdout when it is not a tty, so everything the
   run had computed was lost with it. Every subsequent run here writes to a file with `-u` and explicit
   `flush=True`. The one after *that* still lost its output, because I piped it through `tail`, which
   re-buffers and defeats `-u` entirely.
3. **I stopped a job with `pkill -f`**, whose pattern matched the wrapper's own command line, so it killed
   the shell issuing it (exit 144) instead — the failure mode the standing notes describe in exactly those
   words. Every other kill in this session was by PID with a full re-scan of the process table afterwards,
   because `kill` reporting success means a signal was sent and not that anything stopped.

**The plant that reported it had gone blind.** The first two-sided plant shrank the trace-ellipsoid radius
by 10% and asserted `0 < (guarded − planted) < guarded`. At `m = 288` the difference was **0**: the lower
bound failed, and it failed for the right reason — the ellipsoid is only a **superset device**, and the
binding constraint is the box `σ_k(a)² ≤ m`. At `m = 288` no solution sits near the trace boundary (288 is
not a square in `O_K`, so no solution has `Tr(a²) = 4m`), so the plant could not fire and its survival would
have taught nothing. The plant was moved to the box, where it fires at every `m` tested. Had the assertion
been the natural one-sided `planted < guarded`, it would have passed in silence.

---

## §9 — Artifacts

Nothing is committed and nothing is staged.

| path | what it is |
|---|---|
| `/tmp/claude-1000/arith-h2/okfield.py` | `O_K` arithmetic, the ellipsoid enumerator, `Sh(m)`, `Sh_elt(μ)` for totally non-negative `μ ∈ O_K`, and the plant knobs |
| `/tmp/claude-1000/arith-h2/naive.py` | the independent enumerator whose only job is to disagree |
| `/tmp/claude-1000/arith-h2/shell.py` | vectorised ceiling / shape / integral / Parts-exact counts |
| `/tmp/claude-1000/arith-h2/formula.py` | the two divisor formulas and their splitting rules |
| `/tmp/claude-1000/arith-h2/{setup,qa1,qb2,local}.gp` | the pari scripts: field data, question (a), question (b), splitting tables |
| `/tmp/claude-1000/arith-h2/boundary.py` + `boundary.log` | the formula-validity boundary and the out-of-table stress run (`n = 33..60`) |
| `/tmp/claude-1000/arith-h2/{decompose2,table2}.py` | the shape decomposition and the §3 table generator |
| `/tmp/claude-1000/arith-h2/ceiling_table.json` | the table of §3, machine-readable |
| `plans/M63-phaseH2-arithmetic.md` | this file — the only thing here worth committing |

**On `tools/`:** I am not proposing a `tools/` module. The value is the numbers and their controls, and the
two formulas are four lines of arithmetic each that a reader can re-derive from §2b without running
anything. If a later phase wants the shape count as a screen inside a search loop, `formula.py`'s
`shape_formula` is the thing to lift — it needs only `sympy.factorint` and no lattice.

---

## §10 — What I would do next, ranked

1. **Build the shape-free denominator-12 arena at `n = 2` and count what survives the disk cut.** The
   arithmetic says 60 circle points and 60 unit vectors are available. The open question is entirely
   geometric-combinatorial: does a finite, group-closed arena under a four-conjugate disk cut retain them?
   This is the direct continuation of the "find a new base" mission, and `n = 2` is cheaper than `n = 16`
   in every respect: same field `K(√7)`, same 6-openness, and a **7.1× smaller arena**. The family's own
   endpoint bound `2n/√(4n−1)` gives radius **1.512** at `n = 2` against **4.032** at `n = 16` — a radius
   ratio of 2.67 and an area ratio of 7.11. (At `n = 4` the same formula returns **2.0656**, which is
   exactly the bound already recorded for the 509-vertex record — a free positive control.)
2. **Check whether the order-24 group closure is compatible with dropping the shape constraint.** What I
   measured is that Parts's two congruences (mod 2 and mod 4) cost **nothing** on any shell here — the
   "integral" and "congruence" columns of §4's decomposition never differ from the "shape" column, at any
   `n` or `d` tested. What I did **not** verify is *why*: `tools/typem.py`'s own docstring says the lattice
   is "group-closed under the order-24 group by construction", which would make those congruences the
   `ζ₆`-closure conditions rather than a restriction on the count — but that is **the code's claim, not my
   measurement**. If it holds, the group and the shape are independent constraints and only the shape has
   to be given up, which is the cheap version of item 1. Worth one hour to confirm before building
   anything.
3. **Retire the "odd power of 2" law in favour of §6's corrected form** wherever the family file states it,
   and record `n = 17, 29` as the counterexamples to the converse.
4. **`n = 25` is the outlier worth one hour.** Its shape ratio is `6×`, the largest in the table, and its
   ceiling of 540 is the largest at `n ≤ 32`. It is not 6-open (radicand 99, squarefree 11), so it is not a
   target — but a `6×` gap is the largest signal in the table that the shape constraint is a design choice
   with a measurable price.
