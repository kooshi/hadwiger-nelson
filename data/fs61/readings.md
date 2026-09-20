# FS-61 — the readings, scored (phase E items E.2, E.3, E.6, E.7)

*Derived from the committed records by `python3 tools/fs61_readings.py readings`; regenerating it cannot change a verdict without a record moving. Machine: desktop (16 physical cores / 32 threads, 128 GB). Every table names the population it counts, and every reading is scored in the plan's three words — **won**, **lost**, **not decided** — with the measurement that decided it.*

## What a reading is, and what scoring one does not do

A *reading* is a guess about what makes a field's plane refuse three colours, written down before the census ran together with the measurement that could contradict it. Scoring one says whether this census's records contradict it. **None of these is a theorem, and a reading that wins is still a reading**: it won against 40 fields and one search depth, not against the family.

---

## E.2 — R-cycle: does a short odd cycle predict refusal?

**The claim.** A live lattice whose shortest odd cycle is short refuses three colours; one whose odd cycles are all long does not. (FS-58 stated it about *coarse* lattices; `d = 59` contradicted that form at the opening — coarse, short odd cycle, and provably 3-colourable — so the plan restated it on **live** lattices, which is what is scored here.)

**Population: the 78 rank-4 lattices across the forty census fields whose state is `Open` or `Refused` — no certificate closes them — and for which at least one ball came back decided** (refused, or coloured with a colouring verified edge by edge). Lattices closed by a certificate are excluded because the reading is about which live lattices refuse; balls that ran out of time are not a verdict and are excluded too.

| shortest odd cycle | refused | 3-colourable | refusal rate |
|---|---|---|---|
| **at most 9** | **22** | 25 | 47 % |
| **more than 9** | **0** | 31 | 0 % |

Fisher exact, two-sided: **p = 1.2e-06**. Rows the odd-girth search could not place on either side of the cut: **0** (a lattice whose search found no odd cycle *up to a cap below 9* is not evidence of a long odd cycle — that is FS-58's O1 trap, and such a row is counted nowhere).

### Verdict: **won**

Every refusing lattice in the census has an odd cycle of length at most 9, and no lattice with a longer one refuses. The one-directional reading is the strong half: **a short odd cycle is necessary here and nowhere near sufficient** — half the lattices with one are 3-colourable.

**What this does not say.** It is a statement about the lattices this census could decide, and those are the small ones. A long-odd-girth lattice with a huge ball would sit in the `>9` row only if its ball was decided, and the balls that were not decided are the large, dense ones. The confound is named and not removed.

---

## E.2 — the degree phase diagram: what actually decides whether a solver answers

**Not a registered reading — a finding of this phase**, and the one that re-aimed its own last ask. Every earlier tier of this census chose which ball to put to a solver by its **size**, under a point cap. That was the wrong quantity. What separates a ball the solver decides from one it does not is its **average degree**, `2·edges / points`.

**Population: all 765 asked ball records on disk that carry both a point count and an edge count** — the forty census fields *and* the seven control fields, because the question is about the instrument and not about the family.

| average degree | 3-colourable | undecided at the wall | refused |
|---|---|---|---|
| **< 4** | 87 | 0 | 0 |
| **4–6** | 183 | 39 | 0 |
| **6–8** | 106 | 14 | 3 |
| **8–10** | 114 | 15 | 6 |
| **10–14** | 85 | 8 | 15 |
| **14–20** | 46 | 1 | 16 |
| **≥ 20** | 20 | 0 | 7 |

**No ball below average degree 6.595 has ever refused** (`d = 119`, `L8a8b1603`, R = 1.2), over 47 refusing balls. The 77 undecided balls have median degree **5.56** and lie in 4.70–14.00.

**Restricted to balls of at least 200,000 points** (n = 264), which is where the census's hard cases live: 47 are at degree ≥ 14 and **every one of them decided** — 30 coloured, 16 refused, **1 undecided** — the slowest in 1800 s. Below degree 6 in the same population: 49 coloured, 31 undecided, **0 refused**.

### The law that makes it actionable

A ball of radius `R` on a lattice holding `g` unit vectors has predicted average degree **`g·φ(R)²`**, where `φ(R) = [2R²·arccos(1/(2R)) − √(4R²−1)/2] / (πR²)` is the fraction of a radius-`R` disc's area that its unit translate covers — **squared**, because a ball here is a *bidisc*, one disc per real embedding of the field. Each point has `g` candidate neighbours and each lands inside the ball with probability `φ(R)²`.

**Control, on the same 765 balls: observed / predicted has median 1.0000 and range 0.715–1.184, with 0 outside ±30 %.** The plant: dropping the bidisc square — `g·φ(R)` in place of `g·φ(R)²` — reads a median of 0.584 on a 60-ball sample, so the square is what makes the law fit and the control is able to fail.

### What it cost, and what it bought

**The undecided balls are not "nearly refused".** They are the classic hardness peak of sparse graphs, and on the colourable side wherever anything decided them. Phase B′'s radius ladder walked 1.5 → 1.2 → 1.0, which steps **down** in degree — into that peak, or below the floor at which anything refuses. Its 24 undecided asks measure that choice of radius, not the fields.

**Going up in radius makes a refusal faster, not slower**, which is the opposite of the size intuition: `d = 47` refuses in 104 s at R = 1.2 (degree 6.7) and in **0 s** at R = 1.5 (degree 9.5); `d = 119` goes 114 s → 1 s; `d = 95` 32 s → 1 s.

**And the tier built on it decided a 1.8-million-point ball in 5.6 seconds**, where balls a tenth that size at degree ≈ 5.5 had run to a 600-second wall.

---

## E.2 — R-mod8: is the direct route blind to half the family?

**The claim, in two strengths.** (a) *about balls*: no ball over a field with `d ≡ 3 (mod 8)` refuses, so those twenty fields need the other route (a forcer plus a chain, as at `d = 11` in FS-58). (b) *about lattices*: every lattice over those fields is closed by a certificate.

**Population: the 21 live rank-4 lattices over the twenty `d ≡ 3 (mod 8)` fields** (11, 35, 59, 83, 107, 131, 155, 179, 203, 227, 251, 299, 323, 347, 371, 395, 419, 443, 467, 491).

### (a) Verdict: **lost**

| d | lattice | generators | smallest refusing ball |
|---|---|---|---|
| **11** | `Ld65c8ee8` | 108 | 45,521 points |
| **59** | `Ldb4246f8` | 60 | 1,396,469 points |

The refusal at `d = 11` is **not** inheritance from FS-58's certified witness — that witness lives on a different lattice (`M = 150`, and 150 does not divide 30). It is the direct route landing in the half of the family the reading said it could not reach, and phase C certified a 189-point witness from it.

**What survives is the plan's own refinement, not its claim.** The refusing lattice at `d = 11` draws on **ten** classes of unit vectors — it is rich in classes, not coarse — exactly as the note about FS-58's witness predicted. Coarseness, not the congruence, is what the direct route cannot work with.

### (b) Verdict: **lost** — 16 lattices over those fields are still `Open` (d=11, d=35, d=59, d=83, d=131, d=155, d=179, d=203, d=251, d=323)

---

## E.2 — R-L: does the local bound decide landing?

**The claim.** Landing depends on `L(F)`, the best bound the field's finite residue planes give. A field with `L = 4` is "tighter" and should land more readily than one with `L ≥ 5`.

**Population: the 20 fields with `d ≡ 7 (mod 8)`** — the half where the direct route works — split by whether their local bound is exactly 4.

| local bound | landed | not landed | landing rate |
|---|---|---|---|
| **L = 4** | 6 | 6 | 50 % |
| **L ≥ 5** | 2 | 6 | 25 % |

Fisher exact, two-sided: **p = 0.373**.

### Verdict: **lost**

The two fields with `L = 5` that landed — `d = 47` and `d = 143` — land exactly like their `L = 4` neighbours, which is what the plan flagged as already suggestive. With these margins the table cannot separate the two groups, and that is the honest statement: **not that `L` is irrelevant, but that this census cannot see an effect of it.**

---

## E.2 — R-size: does the refusing ball grow with `d`?

**The claim.** At matched relative height the least refusing ball grows like a power of `d` between 0.5 and 2 — so `ℚ(√167)` is not arithmetically special, only large.

**Population: the 8 landed fields with `d ≡ 7 (mod 8)`, each contributing the smallest ball that was actually SEEN to refuse.** That is the bracket's upper end and not the least refusing ball, which is not observable: verdicts are monotone in the radius and the band just under the threshold is where solvers stall.

| d | smallest refusing ball (points) |
|---|---|
| 23 | 248,213 |
| 47 | 3,565 |
| 71 | 47,597 |
| 95 | 6,997 |
| 119 | 5,605 |
| 143 | 283,485 |
| 191 | 21,845 |
| 359 | 46,421 |

**slope -0.14 (95 % interval -1.71 to 1.42, R^2 0.01) over the 8 landed d = 7 (mod 8) fields.**

### Verdict: **not decided**

**The confound, named.** Relative height is *not* matched across these eight fields; the fit is over whatever lattice happened to refuse first at each one, and the lattice's covolume — not `d` — is what sets a ball's size directly (a ball holds about `π²R⁴/covolume` points). A slope in the band is consistent with the reading and is not a measurement of it.

---

## E.3 — R-C: the character-mean reading

**The claim.** G60's ratio reading, used as a decider of finite landing: a refusing lattice has least character mean above `−1/2`. One reading below `−1/2` contradicts it.

**Population: the 22 refusing live lattices, one least character mean each**, computed through the frozen `tools/fs58_search.py` (`min_character_mean`: a grid over the dual torus followed by BFGS refinement). **These are floating-point readings, not exact**, and they are labelled so in every record.

| d | lattice | generators | least character mean |
|---|---|---|---|
| 143 | `L54356af8` | 36 | -0.8223 |
| 47 | `L9a74471f` | 36 | -0.8145 |
| 47 | `L7dfcb5f5` | 28 | -0.7878 |
| 119 | `L8a8b1603` | 28 | -0.7655 |
| 191 | `Lb0a7206c` | 36 | -0.7512 |
| 359 | `L54356af8` | 44 | -0.7290 |
| 23 | `Lb0a7206c` | 36 | -0.7286 |
| 95 | `L8a8b1603` | 28 | -0.7282 |
| 71 | `L9a15a47c` | 28 | -0.7071 |
| 95 | `L9a74471f` | 44 | -0.7049 |
| 119 | `Lac2ac6d0` | 36 | -0.7022 |
| 119 | `L54356af8` | 60 | -0.6989 |
| 311 | `Lc223387a` | 52 | -0.6712 |
| 95 | `L54356af8` | 52 | -0.6649 |
| 239 | `L3e1c94c6` | 52 | -0.6622 |
| 71 | `Lb0a7206c` | 52 | -0.6503 |
| 359 | `L3e1c94c6` | 52 | -0.6230 |
| 59 | `Ldb4246f8` | 60 | -0.6128 |
| 191 | `L54356af8` | 52 | -0.6097 |
| 71 | `L54356af8` | 76 | -0.5880 |
| 11 | `Ld65c8ee8` | 108 | -0.5712 |
| 23 | `L1510e5aa` | 60 | -0.5380 |

Range **-0.8223 to -0.5380**; 22 below `−1/2`.

### Verdict: **lost**

---

## E.6 — the registered predictions, scored

*Registered in the committed plan before the first census solver call (`8c4b4fb`, 2026-09-19, which precedes the first ball record in `5fb9984`).*

| id | prediction | registered probability | outcome | what decided it |
|---|---|---|---|---|
| **P1** | the observed half of the dyadic law (v2(N) != 1 for d = 7 mod 8) holds on every atlas row to N = 420 | 0.85 | **won** | phase A item A.3: 0 violations over 1,820 non-rational denominators at d = 7 (mod 8), against the nine O6 had registered it on; and A.4 proved it, so it is a theorem and not a prediction any more |
| **P2** | R-mod8 (a): tier 1 yields no refusing ball at any of the twenty d = 3 (mod 8) fields | 0.7 | **lost** | phase B: d = 11 refused on its own lattice (not by inheritance) -- 2 refusing lattice(s) at d = 3 (mod 8) now, d=11 Ld65c8ee8 (108 generators, smallest refusing ball 45,521 points), d=59 Ldb4246f8 (60 generators, smallest refusing ball 1,396,469 points) |
| **P3** | among the twenty d = 7 (mod 8) fields, tier 1 yields a Refused ball at ten or more | 0.6 | **lost** | 8 of 20 d = 7 (mod 8) fields have a refusing ball, against the ten predicted; and neither tier 1b nor tier 1c nor tier 2l added one |
| **P4** | every tier-1 refusal certifies | 0.9 | **won** | phase C: 9 of 9, by the frozen checker, each with its twelve planted faults and its wrong-radicand refusal; no extraction stalled and no refusal failed exact re-derivation |
| **P5** | R-size: the log-log slope of least refusing ball size against d lies in [0.5, 2] | 0.5 | **not decided** | slope -0.14 (95 % interval -1.71 to 1.42, R^2 0.01) over the 8 landed d = 7 (mod 8) fields |
| **P6** | R-L loses: landing rates for L = 4 and L >= 5 among d = 7 (mod 8) do not differ by more than chance at matched relative height | 0.65 | **won** | 6 of 12 fields with L = 4 landed against 2 of 8 with L >= 5; Fisher exact p = 0.373 |
| **P7** | R-C loses: some refusing lattice has least character mean below -1/2 | 0.75 | **won** | 22 refusing lattices, least character means from -0.8223 to -0.5380; 22 below -1/2 |
| **P8** | A.7 finds a rule reproducing the non-affine quotient colourings on at least 90 % of dead lattices | 0.35 | **lost** | phase A item A.7: no rule. The smallest hidden groups found are 27, 108, 108, 243, 1728, 2187, 4096 and the most common order covers 29 % against the gate's 90 %; and one of them has no factor of 3 at all, which kills the natural candidate |
| **P9** | phase D lands a second d = 3 (mod 8) field by the chain | 0.25 | **not measured** | phase D was NOT RUN: it was conditional on R-mod8 surviving phase B (decision G) and R-mod8 lost at its first askable field, so the owner replaced it (re-plan after phase B, ruling 3). What survives of its question is D.0, the recipe-transfer table, which phase E answers from certificates |
| **P10** | a statement about infinitely many fields is proved (E.5) | 0.1 | **lost** | no statement about infinitely many fields is proved. E.5 produced the two tables it was asked for and they point the other way: see `data/fs61/shapes.md` |

**4 won, 4 lost, 2 not measured, of 10.**

---

## E.7 — the unreachability audit

*Plan item E.7: any prediction whose informative outcome turned out to be unreachable is named as mis-specified, and the evidence for that must predate the result.*

**P9 — `not measured`, and the cause predates the result.** Its informative outcome (a certified
second field over `d ≡ 3 (mod 8)` by the chain route) needed phase D to run, and phase D was conditional on R-mod8
surviving phase B (decision G, written 2026-09-19). R-mod8 lost at `d = 11` in phase B, and the owner then replaced
phase D (re-plan after phase B, ruling 3, 2026-09-20). **The condition was in the committed plan before the
prediction was scored**, so this is a prediction whose gate closed, not one that was mis-specified: at registration
both outcomes were reachable, and what removed one of them was a recorded decision with its own reason.

**P5 — reachable, and its band is doing less work than it looks.** A log–log slope is a one-number summary of eight
points, and any of `not decided`, `won` and `lost` was attainable from those eight: the fit was not forced by the
population. What it cannot separate is `d` from covolume, and that is stated beside the verdict rather than folded
into it.

**P7 — reachable both ways by construction**, because it is scored on a quantity computed per lattice with no
reference to the verdict: the instrument that would produce a reading below `−1/2` is the same one that produced
every reading above it.

**No prediction in this milestone is found to have had an unreachable informative outcome.** The near miss is P9,
and it is a closed gate rather than a bad specification. Recorded for the ledger of this project's own recurring
error: the audit was run by asking, of each prediction, *what population would have produced the other answer, and
did it exist when the prediction was written* — not by asking whether the answer was surprising.

