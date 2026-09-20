# FS-61 phase A — derive before scanning: the phase record

*Plan: `plans/FS61-quadratic-census.md` §6 phase A, §5 rule 16. Implementer: de Bruijn (Opus 5), 2026-09-20.
Machine for every number below: **the desktop, 16 physical cores / 32 threads, 128 GB**, idle.
No SAT solver was used on any census object; the only solver calls are on quotient graphs of at most 20,736 vertices
(A.5, A.7). Every command is pasteable from the repository root after `source scripts/dev-env.sh`.*

**Verdict: 9 of 9 items done. 8 green, and A.7 landed on its third branch — no rule found, with the table.**
A.4, the item that could have come back "not derived", instead came back **proved**, and did not need the paper the
plan told me to read first. Nothing halted (plan §5 rule 15); A.5, the halt in this phase, passed on all seven witnesses.

---

## The gate

| # | item | command (pasteable) | artifact | the line that shows the pass | exit |
|---|---|---|---|---|---|
| A.1 | the frame | `python3 tools/fs61_census.py frame` | `data/fs61/frame.jsonl` | `DONE frame: 1214 fields, 0 rows where the two routes disagree` | 0 |
| A.2 | the atlas | `python3 tools/fs61_census.py atlas` then `atlas --check` | `data/fs61/atlas.jsonl` | `DONE atlas: 155 fields, 154 with a non-rational class at N <= 420`; `DONE atlas --check: 17 fields + the O6 sets; 0 failures` | 0 |
| A.3 | D-H.2's laws | `python3 tools/fs61_census.py atlas --laws` | `data/fs61/atlas-laws.json` | `DONE atlas --laws: 3107 non-rational (field, denominator) pairs, 0 violations` | 0 |
| A.4 | the dyadic law's other half | §R-A of the plan (a hand proof); machine-checked by `python3 tools/fs61_census.py selftest --section atlas` and the residue exhaustion quoted below | `plans/FS61-quadratic-census.md` §R-A | **proved**, 0 surviving residues mod 8 against 256 in the control | 0 |
| A.5 | the witnesses' own lattices | `python3 tools/fs61_census.py witness-lattices` | `data/fs61/witness-lattices.jsonl` | `DONE witness-lattices: 7 witnesses, 0 halts` | 0 |
| A.6 | the killing-quotient table | `python3 tools/fs61_census.py dead-quotients` | `data/fs61/dead-quotients.md`, `.jsonl`, `-reconcile.json` | `reconcile d= 167: … 33 pools compared, 0 disagreements` | 0 |
| A.7 | the rule behind the non-affine colourings | `python3 tools/fs61_census.py minimal-quotient` | `data/fs61/minimal-quotients.jsonl` | `most common order 108: 2 of 7 lattices (29%) -- the gate asks for 90%` — **no rule; third branch** | 0 |
| A.8 | the size-law inputs | the script in §A.8 below, over every recorded ball | `data/fs61/fields/*/balls.jsonl` | worst error **2.24 %** on the six the gate names; over 588 balls of ≥ 1000 points, **0** above 15 % | 0 |
| A.9 | predictions registered first | `git log` | — | §8 first in `8c4b4fb` (2026-09-19), first ball record in `5fb9984` (2026-09-20): **PASS** | 0 |

---

## §A.1 — the frame, by two routes that share nothing

1,214 squarefree `d` in [2, 2000). **Route A**: congruences and Legendre symbols. **Route B**: PARI/GP's own prime
decomposition of 2, 3, 7, 11, 19, 23, 31, 43, 47 in `F = ℚ(√d)` **and** in `K = ℚ(√d, i)`, comparing the number of
primes above `p` in each (`K/ℚ` is biquadratic, so all primes of `F` above `p` behave alike) and reading inert against
ramified from the residue degrees. **They agree on every one of the 1,214 rows.**

Pass conditions, each checked: §1's 40-field list reproduced exactly; the twenty `d ≡ 3 (mod 8)` fields at `L = 4` by
the dyadic prime; the twelve `d ≡ 7 (mod 8)` at `L = 4` by the prime 7; the seven at `L = 5` by 11 or 19; `L(167) ≥ 6`
with first usable primes **23, 43, 59**; and the named controls `χ = 2` at `d = 2, 5, 13`, `χ = 3` at `d = 3, 7, 19`.

**Finding — `L` had to become a bracket, and "L ≥ 6" would have been wrong for three fields.** `L(F)` is the minimum
over the stable primes of the target graph's chromatic number, and four of those chromatic numbers are themselves
undecided (23, 31, 43, 47 are FS-53's open window). So each row carries `L_lower`, `L_upper` and an exact `L` only when
the two meet. Below 2000 exactly five fields have an undecided `L`:

| d | L | first usable primes |
|---|---|---|
| **167** | [6, 8] | 23, 43, 59 |
| 887 | **[5, 8]** | 23, 31, 67 |
| 1055 | **[5, 8]** | 31, 43, 47 |
| **1319** | [6, 8] | 23, 47, 59 |
| 1823 | **[5, 8]** | 23, 31, 43 |

Three of the five have **31** usable, where `χ(UD(𝔽₃₁,2))` is open at 5 (G59: "only at 31 is five still open"). So a
five-colouring at 31 would hand `ℚ(√887)`, `ℚ(√1055)` and `ℚ(√1823)` an `L` of 5, and an `α < 161` certificate at 31
would push all three to [6, 8]. **FS-57's "side digit five refused at 31" has three named consumers it did not know it
had.** `ℚ(√1319)`'s pair (23, 47) is G56's own reading of that field, reproduced here independently.

## §A.2 — the atlas: the parameter enumerated first

`data/fs61/atlas.jsonl`, 155 squarefree `d ≡ 11 (mod 12)` below 2000, denominators `N ≤ 420`. For each `N` the
equations are **solved for `d`**, out of `units_d`'s own parametrisation: with `g = gcd(b, e)` and
`base = (b² + e²)/g²`, a non-rational unit vector is `(k(−e)/g, b, kb/g, e)` with `k²·base = N² − d(b² + e²)`, so

```
d = (N² − k²·base) / (g²·base)     for every integer k with k²·base < N².
```

Every field therefore has a row whether or not anything was found at it — 154 of the 155 carry a non-rational class at
`N ≤ 420`, and **`d = 1523` carries none**, which a per-field scan at a fixed depth would have recorded as an absence
of the same shape as a field that was never looked at.

**Cross-check (the pass condition):** the (denominator, orbit count) list agrees **exactly** with FS-58's frozen
`classes(D, 180)` on all 17 fields asked — its fourteen plus 119, 155, 299. And O6's sets come out right, with their
quantifiers made visible, because they are not the same quantifier:

```
  D( 6) = [2, 11, 14, 17, 35]                 within the family: [11, 35]
  D(12) = [23, 47, 71, 95, 119, 143]          within the family: the same six
  D(18) = [2, 11, 35, 41, 62, 113, 137, 146, 155, 158, 161, 203, 299, 323]
                                              within the family: [11, 35, 155, 203, 299, 323]
  D(24) = [23, 47, 119, 167, 215, 239, 263, 287, 407, 455, 527, 551]   (all of them in the family)
  D(6), D(18) within the family: every member is 3 mod 8     PASS
  D(12), D(24) within the family: every member is 7 mod 8    PASS
```

`D(12)` and `D(24)` need no restriction at all: **every** squarefree `d` with a class of denominator exactly 12 or 24
is already `≡ 11 (mod 12)`.

**Plant:** a third, independent computation of `D(12)` — brute force over the defining equations, using neither
`units_d` nor the inversion — reproduces the six fields, and **dropping the orthogonality condition `ab + ce = 0` takes
`D(12)` from 6 fields to 36**, the thirty intruders listed in the selftest output. Orthogonality is load-bearing.

## §A.3 — D-H.2's four laws

```
python3 tools/fs61_census.py atlas --laws
```

```
  L1 height floor N >= sqrt(d)                                  [proved]: 0 violations
  L2 odd p = 3 (mod 4) divides N only if (d/p) = -1             [proved]: 0 violations
  L3 v_2(N) <= 1 at d = 3 (mod 8)                               [proved]: 0 violations
  L4 v_2(N) != 1 at d = 7 (mod 8)                               [OBSERVED, P1]: 0 violations
  v_2 of the non-rational denominators at d = 3 (mod 8): {0: 470, 1: 817}
  v_2 of the non-rational denominators at d = 7 (mod 8): {0: 482, 2: 682, 3: 330, 4: 167, 5: 77, 6: 46, 7: 27, 8: 9}
```

3,107 non-rational (field, denominator) pairs out of an atlas of 11,518, zero violations. The distributions say more
than the zeros: at `d ≡ 3 (mod 8)` the 2-adic valuation is 0 or 1 **and nothing else**, which is exactly L3's bound
attained; at `d ≡ 7 (mod 8)` it takes every value from 0 and 2 up to 8 and **never 1**.

**Prediction P1 is won**, and on a population 200× the one it was registered against: O6 had nine denominators, this is
1,820 non-rational denominators at `d ≡ 7 (mod 8)`.

## §A.4 — L4 is proved, and it did not need the paper

The plan asked me to read `[ZanardoZannier1991]` Theorem 3 first. I did (the held PDF,
`library/pdf/zanardo-zannier-1991-…pdf`; the scanned text layer is degraded but Prop. 2 and Thm 3 are legible). **It is
not what settles this.** Theorem 3 gives a basis of the free part of the norm-one group indexed by the *split* primes,
with the obstruction living in `Cl(S)/M` — it says *which* valuation vectors at the split primes are realised, and the
dyadic prime at `d ≡ 7 (mod 8)` is split, so it explains why powers of 2 occur in denominators **at all**. It says
nothing about the parity. Its read-status in `BIBLIOGRAPHY.md` should move to *Theorem 3 and Prop. 2 read, 2026-09-20*.

The proof is elementary and is written out in the plan's §R-A. In one paragraph: if `N ≡ 2 (mod 4)` then `N² ≡ 4
(mod 8)`, and `d ≡ −1 (mod 8)` turns the norm equation into `a² + c² − (b² + e²) ≡ 4 (mod 8)`. Since squares are
0, 1, 4 mod 8, that leaves exactly four residue patterns. Two make all of `a, b, c, e` even, against
`gcd(a, b, c, e, N) = 1` with `N` even. In the other two, **exactly one of `a, c` and exactly one of `b, e` is odd** —
and then the *second* equation decides it: if the odd ones are aligned, `ab + ce` is odd + even = odd; if crossed, one
of `ab, ce` is `≡ 2 (mod 4)` and the other `≡ 0 (mod 4)`, so `ab + ce ≡ 2 (mod 4)`. Either way `ab + ce ≠ 0`. ∎

The plan's remark that *"a mod-8 count does not settle it"* is correct **about the norm equation alone**; what settles
it is the orthogonality relation read mod 4. Machine-checked by exhausting residues mod 8:

```
residue solutions mod 8 surviving norm + orthogonality + primitivity: 0
the same exhaustion at d = 3 (mod 8): 256 residue solutions -> the argument is specific to 7 (mod 8)
  d=11 (3 mod 8): denominators N = 2 (mod 4) carrying a primitive unit vector, N < 200: [6, 10, 18, 30, 46, 50, …]
```

The control matters: the same exhaustion at `d ≡ 3 (mod 8)` leaves 256 residue patterns, and denominators `≡ 2 (mod 4)`
really do occur there, so the exhaustion is not vacuous and the argument is exactly as sharp as the phenomenon.

**So L4 moves from `[measured]` to `[hand]`**, D-H.2 is fully proved, and the atlas's four laws are now three theorems
and a theorem instead of three theorems and an observation.

## §A.5 — the witnesses' own lattices (a halt, not triggered)

```
python3 tools/fs61_census.py witness-lattices
```

The ℤ-span of the points of each certified witness, canonicalised, saturated, and put through the quotient filter
(FS-58's frozen `quotient_graph`, driven from the lattice rather than from a class spec; every quotient model verified
on every quotient edge). **All seven are `Open`** — 0 of 9 to 22 quotients 3-colourable — so no non-3-colourable finite
graph sits inside a lattice this instrument would call colourable.

| d | points | lattice | M | generators | covolume | quotients tried | state |
|---|---|---|---|---|---|---|---|
| 11 | 204 | `L8449fb78` | 150 | 108 | 2.17e-4 | 16 | Open |
| 23 | 475 | `Lb0a7206c` | 60 | 36 | 1.14e-4 | 22 | Open |
| 47 | 169 | `L7dfcb5f5` | 60 | 28 | 5.80e-3 | 20 | Open |
| 71 | 148 | `L856deb32` | 120 | 20 | 7.73e-2 | 22 | Open |
| 95 | 1068 | `L8a8b1603` | 60 | 28 | 2.93e-3 | 9 | Open |
| 191 | 483 | `Lb0a7206c` | 60 | 36 | 9.43e-4 | 20 | Open |
| 119 | 456 | `L8a8b1603` | 60 | 28 | 3.67e-3 | 14 | Open |

The 11-witness's lattice, which phase D starts from, is `M = 150`, rank 4, **108 generators**, covolume `2.17e-4`.

**Finding — a canonical key names a lattice within a field, not across fields, and two witness pairs collide.** Read the
table again: `d = 95` and `d = 119` share the key `L8a8b1603`, and `d = 23` and `d = 191` share `Lb0a7206c`. The key is
`(M, Hermite form)` and carries no `d`, because the ℤ-module does not depend on the field — only the quadratic form
`(1, d, 1, d)` does. Across the 15 fields on disk, **154 of 817 integral shapes are shared by more than one field.**

*For the instrument:* every table and every lookup must key on `(D, key)`. Nothing built so far is wrong — the records
all carry `D` and every command is per-field — but a phase-E analysis grouping by `id` alone would silently merge
lattices from different fields, which is the shape of defect this project keeps finding.

*For phase E, route (β):* on a shared shape the generator sets **differ** (only the rational unit vectors coincide: 12
of 36 at 23/191, 4 of 28 at 95/119) while their **counts agree exactly**. `d = 23, 95, 119, 143` are the `N = 12`
family `d = N² − c²` that E.5's parametric-witness route names. A shared integral shape with equal generator counts is
precisely the precondition for one abstract graph drawn over several fields — and it is a **cheap pre-screen over the
whole census**, computable from the lattice records alone, where E.5 currently proposes graph isomorphism.

## §A.6 — the killing-quotient table

```
python3 tools/fs61_census.py dead-quotients
```

508 lattices screened over `d = 11, 23, 47, 167` from FS-58's own `qscreen.jsonl`, **no new solving**; 256 dead. Table
at `data/fs61/dead-quotients.md`, records at `data/fs61/dead-quotients.jsonl`.

**Reconciliation, which is the pass condition, and it is exact:**

```
reconcile d= 167: FS-58 records 29 dead of 33 pools = 29 dead of 32 DISTINCT lattices;
                  33 pools compared, 0 disagreements
```

FS-61 recomputes every verdict from the raw quotient records and **disagrees with FS-58 on none of the 33 pools**.
The README's headline is *28 dead of 31 distinct lattices*, counted over the 32 non-bipartite lines of
`saturate-2520.out`; FS-58's own verdict file holds one pool more — `q1+q5+132`, screened separately and named in the
README's own `colour-scan` row as dead — which accounts for the difference exactly: 28 + 1 = 29 dead, 31 + 1 = 32
distinct. Both numbers are right; they count different populations.

Least killing order, over the 256 dead lattices:
`{16: 21, 81: 73, 528: 7, 625: 7, 792: 9, 800: 2, 1296: 7, 1584: 10, 1872: 3, 2160: 5, 2520: 2, 2808: 7, 3120: 1,
4096: 10, 5616: 1, 6561: 39, 10000: 2, 11583: 1, 14641: 49}` — prime support `{2: 87, 3: 165, 5: 19, 7: 2, 11: 76,
13: 13}` of 256.

## §A.7 — the rule behind the non-affine colourings: **not found** (timebox spent, third branch)

```
python3 tools/fs61_census.py minimal-quotient       # 13.1 s
```

**The instrument, which is new and is the part worth keeping.** A solver's 3-colouring of `Λ/mΛ` is one of many and
hides the group that is really doing the work. Instead of searching sublattices, take a verified colouring `c` and
compute its **period group** `P = {t : c(x + t) = c(x) for all x}` — exact, and a few seconds. Then `A = (Λ/mΛ)/P` is
the smallest quotient *that colouring* factors through, `ρ` is the projection, `T = ρ(S)`, and `c` descends to a proper
3-colouring of `Cay(A, T)`. That is Theorem A's shape (row 57) with the group exposed.

**The result, over 11 dead lattices × six moduli:**

| d | pool | smallest A found | order | 3-part | \|T\| |
|---|---|---|---|---|---|
| 59 | `q1+q5+30.1+30.2` | ℤ/3 × ℤ/9 | **27** | 27 | 6 |
| 35 | `q1+q5+6+30` | ℤ/3 × ℤ/6 × ℤ/6 | 108 | 27 | 12 |
| 11 | `q1+6+30.2` | ℤ/3 × ℤ/6 × ℤ/6 | 108 | 27 | 12 |
| 167 | `q1+132` | ℤ/3 × ℤ/9 × ℤ/9 | 243 | 243 | 8 |
| 167 | `q1+108` | ℤ/12 × ℤ/12 × ℤ/12 | 1728 | 27 | 8 |
| 167 | `q1+1128` | ℤ/3 × (ℤ/9)³ | 2187 | 2187 | 10 |
| 167 | `q1+1008.1` | (ℤ/8)⁴ | **4096** | **1** | 9 |

```
smallest quotient found per lattice: [27, 108, 108, 243, 1728, 2187, 4096]
their 3-parts: [1, 27, 243, 2187]
most common order 108: 2 of 7 lattices (29%) -- the gate asks for 90%
```

**No small `A` is shared by ≥ 90 % of dead lattices, and no sub-family rule either.** The gate's third branch.

Two things were learned, and one natural conjecture is dead:

1. **The hidden group need not be a 3-group.** `167 q1+1008.1`'s colouring factors through `(ℤ/8)⁴`, whose order has
   **no factor of 3 at all** — a periodic 3-colouring of a 3-non-integral lattice through a pure 2-group. That kills
   the most natural candidate rule, that `ρ` is always "a form mod 3 after a change of group", i.e. that the kernel
   barrier's shape (`A = 𝔽₃`, `T = 𝔽₃ˣ`) survives with a bigger 3-group in place of `𝔽₃`.
2. **A sub-family pattern that is not yet a rule:** the three coarse `d ≡ 3 (mod 8)` lattices — O5's, one per field at
   11, 35, 59 — all have **3-part exactly 27** and `|A| ≤ 108`. That is three data points and is registered as nothing
   more.

**What is and is not measured (G21), stated because the reading depends on it.** Each row takes **one** solver colouring
per `(lattice, m)`. The true `A_min`, over all colourings and all moduli, is **at most** what is tabulated. So every
order above is an *upper* bound: a small reading establishes that `A_min` is small, and a large reading does **not**
establish that `A_min` is large. The honest form of the conclusion is therefore: *the colourings the solver produced
factor through groups that vary in order from 27 to 4,096 and in type from `ℤ/3 × ℤ/9` to `(ℤ/8)⁴`, and no common
group was found* — not *`A_min` varies*. Four of the eleven lattices (all of them over `d = 23`) produced no colouring
at any modulus `m ≤ 12` at all, so their killing quotients are not of the form `Λ/mΛ` for small `m`; they are absent
from the table rather than counted as anything.

**Any rule remains a `[reading]` until its local obligation is proved** — `ρ(s) ∈ T` for *every* unit vector of the
class, a congruence on `(a, b, c, e, N)`. Nothing here reaches that bar.

## §A.8 — the size-law inputs

The bidisc law `π²R⁴ / covolume`, against **622 recorded ball point counts** (615 of FS-61's, 7 of FS-58's) rather than
the six the gate names:

| ball | actual | predicted | error |
|---|---|---|---|
| 23 `q1+q5+12.1+60.2` R=1.5 | 440,077 | 439,908 | 0.04 % |
| 143 `q1+q5+12+60` R=1.5 | 283,485 | 283,017 | 0.16 % |
| 47 `q1+12+60` R=1.5 | 8,629 | 8,610 | 0.21 % |
| 191 `q1+q5+20+60.1` R=1.5 | 53,177 | 52,973 | 0.38 % |
| 71 `q1+q5+60.2+120.2` R=1.5 | 47,597 | 46,532 | 2.24 % |
| 119 `q1+12+60.1` R=1.5 | 13,605 | 13,605 | 0.00 % |

All six within 15 %, worst **2.24 %**. Over the whole population: median error 2.93 %, six balls above 15 % — and
**every one of those six has fewer than 150 points**, where the count is dominated by lattice-point discreteness, not
by the law. Restricted to the 588 balls of at least 1,000 points: worst **10.89 %**, median 2.91 %, **none** above 15 %.
The census's balls are all far above that regime, so the law is safe as a scheduling and prediction input, and the one
caveat to carry is that it should not be quoted below a few hundred points.

## §A.9 — the predictions were registered before any census solver call

```
section 8 (the registered predictions) first appears in  8c4b4fb 2026-09-19
the first balls.jsonl record appears in                  5fb9984 2026-09-20
section 8 precedes the first ball record: PASS
```

## Plants and controls

| plant | fired as | which clause |
|---|---|---|
| drop the orthogonality condition `ab + ce = 0` from a brute-force enumeration of the defining equations | `D(12)` grows from 6 fields to 36, intruders listed | A.2's enumeration |
| the residue exhaustion for A.4 run at `d ≡ 3 (mod 8)` instead of 7 | 256 residue patterns survive instead of 0, and denominators `≡ 2 (mod 4)` really occur there | A.4's proof is not vacuous |
| (carried from phase 0, re-run green) the twelve of `data/fs61/records/phase-0.md` | — | — |

## Cost

| step | wall |
|---|---|
| `frame` (1,214 fields, both routes, PARI included) | 6.3 s |
| `atlas` (N ≤ 420, d < 2000) | 19.1 s |
| `atlas --check` (17 fields + the O6 sets) | 5.4 s |
| `atlas --laws` | 0.1 s |
| `witness-lattices` (7 witnesses, quotient screens) | 13.9 s |
| `dead-quotients` (508 lattices, no new solving) | 36.9 s |
| `minimal-quotient` (11 lattices × 6 moduli) | 13.1 s |
| **phase A total** | **under two minutes of machine time** |

Phase A is a derivation phase and it cost less than one ball of phase 0's control scan. That is the plan's point about
deriving before scanning, measured.

## What I would change in the plan

1. **A.1's `L` must be a bracket, not an integer** (§A.1). Three fields below 2000 would be mislabelled `L ≥ 6` by the
   plan's wording when their first usable prime is 31 and five is still open there.
2. **A.2's O6 sets carry two different quantifiers** and the plan states them without distinguishing: `D(6)` and
   `D(18)` are within the family, `D(12)` and `D(24)` over every squarefree `d`. The check now prints both forms.
3. **A.4's parenthetical "a mod-8 count does not settle it" should be narrowed** to "a count on the norm equation
   alone"; the second equation settles it.
4. **§7's canonical key needs a sentence** saying it identifies a lattice *within a field* (§A.5). Cheap fix, real
   risk in phase E.
5. **A.6's pass condition should name which population** the README's 28/31 counts; FS-58's verdict file holds 29/32
   and both are right.
