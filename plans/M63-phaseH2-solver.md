# M63 phase H2 — the four-colourability verdict on the ρ₆₃ arena

**Job.** Decide whether the 51,133-vertex arena built from the rotation ρ₆₃ = (31 + 3i√7)/32 can be
coloured with four colours, using the 32-core desktop rather than the single core a monolithic solver
run was using. Machine: **desktop, 32 cores, 125 GB** (112 GB available). All timings below are on that
machine. Nothing here is staged; commit by path.

**Both answers were wanted.** Not-four-colourable would be this project's first five-colour object in a
field that is not sealed at five colours; four-colourable retires the recipe "dense lattice + a full
circle of connecting edges + an unsealed field". The report below states which half of the object
produced the verdict, because the two halves fail in opposite directions.

---

## 1. The instance is the object it claims to be

Before any solving. Three independent checks, all green:

| check | result |
|---|---|
| My own rebuild of the arena edge set vs. the screening agent's CNF decoded back to edges | **544,530 distinct edges, 0 in mine-not-theirs, 0 in theirs-not-mine** |
| Unit clauses in the CNF | **0** (a stray unit would make the instance trivially unsatisfiable) |
| Pair clauses joining *different* colour slots | **0** (a tautology would silently weaken an edge) |
| Vacuous clauses on the free centre-copy variable | **30**, exactly as documented |
| All 126 cross edges re-derived from raw coordinates by my own exact identity in K | **126/126 pass, 0 fail** |
| Negative control: lattice-perturbed cross pairs must be refused | **26/26 correctly refused** |

The cross-edge re-derivation is independent of the generator's implementation: for a claimed edge
(u, v) I check, in exact ℚ(√3,√11) arithmetic with no √7 ever evaluated, that
`u_x v_y − u_y v_x = 0` and `cos·(u_x v_x + u_y v_y) = (|u|² + |v|² − 1)/2`. This is the two-component
split of `|u − ρv|² = 1` over the K-basis {1, √D}, so it is also a *completeness* argument: no cross
edge can be missing either.

Structure confirmed independently of the generator: base lattice **n = 25,567** points, centre index
**12783**, **272,232** unit edges, unit shell **30** vectors, so the base is a Cayley graph on the exact
norm-1 shell. **30 is the interior degree and the maximum, not the typical one:** measured on the shipped
edge list, **8,239 of 25,567 vertices (32.2%)** reach it, the mean is **21.2956**, and the **30 circle points
have degree 5, 6 or 7** — they sit at 99.2% of the cut radius, so the cut takes most of their
neighbourhood.

## 2. The decomposition, and the measurement that made it obvious

The arena is two isometric copies of one 25,567-vertex lattice graph sharing the centre, joined by 126
cross edges. Of those 126:

- **30** have the centre as base endpoint. These are not couplings: they are exactly what makes the
  copy's own centre properly coloured, which any proper colouring of the copy satisfies anyway.
- **30** have the centre as copy endpoint. These collapse onto base unit edges and are **redundant
  duplicates**.
- **66** are the genuine coupling: **30 diagonal** (base vertex v to the copy of the *same* v, all at
  radius exactly **4.0**) and **36 off-diagonal** in six groups of six, at radius pairs
  1.7812↔2.6227, **2.6667↔3.3333 (= 8/3 ↔ 10/3, rational)** and 3.7282↔3.9923.

So the genuine coupling is **66 constraints, not 96**. The 66 interface vertices are an **independent
set** in the lattice (0 induced unit edges).

> **The question restated.** The arena is four-colourable **iff** there exist two proper four-colourings
> f, g of the *same* 25,567-vertex lattice with f(centre) = g(centre), differing at all 30 radius-4
> circle points, and satisfying the 36 off-diagonal disequalities.

**The calibration that justifies this route: one half alone four-colours in 0.35 seconds**, while the
monolithic run on the whole arena spent **766 seconds and 2.02 M conflicts and finished nothing**
(killed by process group; state captured first). A ~2,000× gap produced by a decomposition rather than
by a faster solver. 100% of the difficulty is in the 66 couplings.

The diagonal radius is the spindle identification: the circle sits at |v|² = 16, so d = 4 and the
spindle radicand is √(4·16 − 1) = √63 = 3√7 — precisely this rotation's radicand. Reached here from
the measured cross-edge radii, and independently from the family's algebra by the product owner.

## 3. Two cheap refutation routes, both closed — and one wrong number of mine

**A one-vertex refutation was available in principle and is not available in fact.** A circle point
pinned to the centre's colour in *every* colouring would be a pair forced equal at four colours at
distance 4, which `not_colorable_of_forced_equal` (ledger row 44) refutes outright. All 30 circle
points were tested individually: **all 30 can take a colour other than the centre's** (0.15–1.9 s each).
No `Forces` pair exists here.

**A number I reported and then destroyed with a control.** I first measured "exactly 10 of the 30 circle
points share the centre's colour" across 12 differently-seeded colourings — 12 out of 12 — and read it
as an invariant. It is not. **Reseeding a solver does not give you a different colouring**; it walks to
the same basin, so twelve readings were one colouring sampled twelve times. Re-run with
**pattern-blocking** — each round forbids the exact 30-point pattern just seen, so the next colouring
differs *structurally* rather than hopefully — the "invariant" broke on the second round.

The surviving statement is a one-sided floor, and it is re-verified on a **standalone** solver with no
incremental solving and no Python bindings, two-sidedly so that both outcomes were reachable:

| query | verdict | time |
|---|---|---|
| at most **8** circle points at the centre's colour | UNSAT | 24.0 s |
| at most **9** | UNSAT | 41.4 s |
| at most **10** | **SAT** | 0.7 s |
| at most **11** | SAT | 0.7 s |

So **L = 10 exactly**: every proper four-colouring of the lattice puts at least 10 of the 30 circle
points at the centre's colour, and 10 is attained. The `≤10 → SAT` row is the control: had it also come
back UNSAT, the cardinality encoding rather than the lattice would have been the story.

**The general criterion this floor feeds, and why it fails here.** For any proper colouring C of the
arena, f(v) = C(v) and g(v) = C(Rv) are both proper colourings of the base; R0 = 0 gives
f(centre) = g(centre); and each diagonal cross edge gives f(v) ≠ g(v). So with
B(h) = {circle v : h(v) = h(centre)}, any v in B(f) ∩ B(g) is a contradiction — hence B(f) and B(g) are
disjoint and **2L > (circle count) ⟹ not four-colourable**, a criterion on the base alone. Here
2·10 = 20 ≤ 30: it fails by a factor of 1.5. **L/count = 1/3 where > 1/2 is needed** — a quantitative
objective for future family members, and the one number in this phase a free construction cannot hand over.

## 4. The rigidity that made a complete enumeration possible

Pattern-blocking to exhaustion, centre pinned to one colour:

> **The 30 circle points admit exactly 19 distinct colour patterns across ALL proper four-colourings of
> the lattice.**

Nineteen, on an independent set of thirty vertices. The census is algebraic: **every pattern uses at most
two colours on the whole circle** — the centre's colour plus at most one other — as
`{centre} × 1`, `{centre, a} × 6`, `{centre, b} × 6`, `{centre, c} × 6`; eighteen have exactly 10 points
at the centre's colour and the nineteenth has all 30. The 1 + 6 + 6 + 6 shape is an orbit structure
under the lattice's six-fold rotation.

This makes the diagonal obstruction exactly computable rather than merely bounded: with f using
{centre, a} and g using {centre, b}, full discordance holds **iff a ≠ b and the two 10-sets are
disjoint**. Six ordered colour pairs × 36 pattern pairs = 216 candidates, of which **72** have disjoint
10-sets. So the diagonal constraints alone do **not** refute, and they fail by explicit witnesses rather
than by a counting near-miss.

**Controls on the enumeration, which is load-bearing.** Every one of the 19 models was read back and
verified a proper colouring against my own 272,262-edge base list, not against the CNF. *Completeness:*
dropping any single blocking clause returns **exactly** the dropped pattern (tested at indices 0, 7, 18 —
SAT and identical each time), and all 19 blocks together leave **UNSAT**, re-confirmed by a **fresh**
solver rebuilt from the file with the same clauses. *Discrimination, as a pair:* a **planted** pattern
built by shifting two entries of a real one is **refused**, while the **faithful** real pattern is
**accepted** — so the refusal came from unrealisability and not from the scaffolding.

### 4a. The group-theoretic reason for 19

ζ₆ (rotation by (1 + i√3)/2, acting on lattice coordinates as
(a,b,c,d) ↦ ((a−3c)/2, (b−d)/2, (a+c)/2, (3b+d)/2)) is verified an automorphism of the base graph from
scratch: norm preserved on all 25,567 points, disk mapped **bijectively** onto itself, **order 6**,
**fixes the centre**, and **permutes the 30 circle points**. It therefore permutes the achievable pattern
set, and it does:

> **The 19 patterns fall into 1 + six orbits of size 3.**

Orbit size 3 rather than 6 means each of the 18 two-colour patterns has a stabiliser of order 2, and the
stabilising element is ζ₆³ = −1: **every one of these patterns is invariant under the half-turn.** So 19 is
`1 + 6·3` with a reason — centrally symmetric patterns — rather than a solver output.

The arithmetic then closes from three independent directions, which is the reason to believe the
structure and not merely the count:

- **6** distinct centre-coloured 10-sets, each carrying **3** patterns (one per second colour) → 6 × 3 = **18**,
  plus the all-one-colour pattern = **19**.
- Of the 15 unordered pairs of 10-sets, **6 are disjoint** → 12 ordered × 6 admissible colour choices = **72**.
- **72** is exactly the discordant-pair count measured by brute force *before* any of this structure was known.

The **sharp diagonal criterion** (product owner's, sharpened from his `2L >` count): refutation by the
diagonal edges alone requires **the centre-coloured 10-sets to form an intersecting family**, which is
decidable on any candidate base in seconds without building an arena. **On ρ₆₃ it fails**: 6 of the 15
pairs are disjoint. The six sets, for the record:

```
0: [    0, 3231, 3277, 6654, 6678, 18888, 18912, 22289, 22335, 25566]
1: [    0, 3513, 3559, 6316, 6332, 19234, 19250, 22007, 22053, 25566]
2: [  107, 2211, 3559, 6316, 12506, 13060, 19250, 22007, 23355, 25459]
3: [  107, 2289, 3231, 6678, 12506, 13060, 18888, 22335, 23277, 25459]
4: [  111, 2211, 3277, 6654, 12496, 13070, 18912, 22289, 23355, 25455]
5: [  111, 2289, 3513, 6332, 12496, 13070, 19234, 22053, 23277, 25455]
```

Sets 0 and 1 share two elements, 2 and 3 share four, 4 and 5 share four — a pairing structure worth
understanding on a future base.

The two-colour restriction is the **colouring-side face** of the fact that makes the residue certificate's
defeat automatic here: every circle point carries the centre's residue. Two mechanisms that arrived
independently in this phase — one from the residue map, one from pattern enumeration — are one fact seen
from two sides, and the next member of the family will present the same pair.

## 5. The complete interface pattern space

For each of the 19 circle patterns, every achievable pattern on the 36 off-diagonal interface vertices was
enumerated to exhaustion by the same blocking method:

| circle pattern | off-diagonal patterns |
|---|---|
| the all-one-colour pattern (index 1) | 264 |
| each of the other 18 | **16** |

> **552 achievable interface patterns in total** — the complete set of colour patterns that any proper
> four-colouring of the lattice can present on the 66 coupling vertices, up to the global colour
> permutation that pins the centre.

## 6. A hazard found in my own instrumentation

My working directory contained a file named `struct.py`, and `import struct` inside that directory
resolved to **my file rather than Python's standard-library module** — `CLAUDE.md`'s "a check that loads
two versions of something and identifies them BY NAME" trap, sitting underneath every measurement in this
phase. Nothing crashed, and the SAT answers here are self-certifying, but *"it probably did not matter"*
is not a check. The file was renamed and the verification re-derives the lattice and the **entire unit-edge
set** from scratch in a clean directory and compares set-wise against the original.

### 6a. The void-check result

Re-derived from scratch in a clean directory (`import struct` resolving to
`/usr/lib/python3.14/struct.py`): **25,567 lattice points** and **272,232 unit edges**, compared
**element-wise and identical** to what was built earlier. The hazard changed nothing; nothing in this
phase is void. Recorded as a finding, not a formality — a clean match is what licences the rest.

## 7. Is the refusal inherited or produced?

The question a reviewer hits first: no type-M arena has previously been shown to *produce*
five-chromaticity rather than to *contain* it — the 509-vertex record's refusal is inherited from a graph
certified five-chromatic before the construction was applied. So: **does a known five-chromatic witness
embed in this arena?**

**No, and by a proof rather than a search.** The naive field argument fails because an isometry can rotate
coordinates between basis slots. The **isometry-invariant** form does not: pairwise squared distances are
unchanged by any rotation or translation, and every squared distance between arena points lies in
ℚ(√3,√7,√11) because every arena point does.

| witness | field it needs | pairwise squared distances leaving ℚ(√3,√7,√11) | embeds? |
|---|---|---|---|
| Heule-510 | ℚ(√3,√5,√11) | **49,727 of 129,795** (√5 and √165 components) | **no** |
| Heule-553 | ℚ(√3,√5,√11) | **54,990 of 152,628** (√5 and √165) | **no** |
| de Grey 1581 | ℚ(√3,√5,√11) — *cited* (row 52, G43), not measured here | — | no, by the same argument |
| M53 witnesses | ℚ(√3,√11,√247), ℚ(√3,√11,√23) — *cited* | — | no, 247 and 23 are not in the field |

First explicit witness for Heule-510: its points 1 and 375, whose squared distance carries √5 with
coefficient 1152. The de Grey row is a **citation, not a measurement** — its stored file holds a
halves/shared decomposition rather than coordinates in the 16-slot form.

**And a stronger statement that needs no witness list at all:** the base half alone is four-colourable —
measured at 0.35 s, and guaranteed by Theorem B since it lies in ℚ(√3,√11). So **any** five-chromatic
subgraph of this arena must use the rotated copy. The five-chromaticity cannot come from the base.

**This is not a size record and must not be written as one.** 51,133 vertices against 509 is not the
claim; reduction is another milestone's machinery. **The result is the field.** ρ₆₃'s field
ℚ(√3,√7,√11) = K(√7) is named **6-open** by G43, where every five-chromatic witness this project holds
is 5-sealed (de Grey and the record at K(√15); the M53 witnesses at K(√247) and K(√23), since
247 ≡ 5 and 23 ≡ 1 mod 11 are squares).

## 8. A wrong call of mine, and the measurement that corrected it

This machine has **16 physical cores, 32 threads**, 64 MB L3. `CLAUDE.md` describes the
desktop as "32 cores", which will mis-size somebody's job later — worth correcting there.

I killed the 32-way cube job and relaunched at 16-way, reasoning that 32 memory-hungry solvers on 16
physical cores explained an 11× slowdown against an 11.28 s baseline. **The 16-way median came back at
122.8 s against 32-way's 120.6 s — statistically identical.** There is essentially **no contention
penalty**, and I had halved my own throughput.

The error is the one `CLAUDE.md` names under *"carry what the number MEASURES, never just its value"*: the
11.28 s was **one sample**, and it was a cube built from a **solver-found** interface pattern rather than an
**enumerated** one, so it was measuring a different and easier population. The real per-cube cost is
~120 s regardless of width. 32-way was restored with completed cubes preserved by their checkpoint files.

**Checkpoint and resume** (outside `build/`, per the standing rule):
- checkpoints: `/tmp/claude-1000/solver-h2/results/NNNN.json`, one per cube
- **resume command:** `cd /tmp/claude-1000/solver-h2 && xargs -a cubelist.txt -n 2 -P 32 python3 cube_worker.py`
  — skips any cube whose result file already exists.

## 8a. Correction: 272,232 versus 272,262

Two figures in an earlier draft of this file differed by exactly 30 — the circle count, the diagonal-edge
count and the norm-1 shell size — which is the last coincidence to wave through in this object. Resolved
from the artifacts:

- `edges.txt` holds **544,590 edge lines**: 272,232 base + 272,232 copy + 126 cross.
- **30** cross lines are the redundant ones (copy endpoint = the shared centre), written `(i, centre)`.
  Those `i` are exactly the 30 norm-1 points, so `{i, centre}` is already a base unit edge. The 30 **is**
  the shell.
- The properness check filtered "both endpoints below n", so it collected the 272,232 base lines **plus**
  those 30 → **272,262 entries**. Of the 30, **15 have i < centre** (ordered tuple identical to the base
  line) and **15 have i > centre** (ordered tuple reversed).
- Compared as **unordered pairs**, the list's distinct set is **exactly 272,232 and identical to the base
  unit-edge set**, verified in both inclusion directions: nothing missing, nothing spurious.

**So 272,232 is the edge count; 272,262 was a list length.** The phrase "272,262-edge base list" is
withdrawn: it is a 272,262-**entry** list covering 272,232 distinct edges plus 30 redundant repeats. The
properness verification is unaffected and marginally stronger than advertised, since `colour[a] ==
colour[b]` is order-independent and every base edge is covered at least once.

## 9. The non-embedding theorem, stated on its own

*Promotable independently of the verdict, and checkable by hand at the witness pair.*

> **Claim.** No point set whose coordinates lie in ℚ(√3,√7,√11)² contains an isometric copy of Heule-510
> or Heule-553.
>
> **Proof.** Squared distances between points are invariant under every isometry of the plane. If all
> points of a set lie in F² for a field F ⊆ ℝ, every pairwise squared distance lies in F. Here
> F = ℚ(√3,√7,√11), whose ℚ-basis is {1, √3, √7, √21, √11, √33, √77, √231} — it contains no √5. But
> Heule-510 has 49,727 of its 129,795 pairwise squared distances carrying a nonzero √5 or √165
> component, and Heule-553 has 54,990 of 152,628. A squared distance outside F cannot occur in a subset
> of F², at any position or orientation. ∎
>
> **Witness, checkable by hand.** Heule-510's points 1 and 375: their squared distance carries √5 with
> coefficient 1152 (coordinates scaled by the file's denominator 96).

The **witness-list-free** companion, which cannot be outflanked by a witness nobody has found yet: the
base half alone is four-colourable — measured at 0.35 s, and *guaranteed* by Theorem B since it lies in
ℚ(√3,√11) — so **any** five-chromatic subgraph of this arena must use the rotated copy.

## 8b. Correction to 8: the contention comparison was population-contaminated too

The figures quoted in §8 — 32-way at a 120.6 s median against 16-way at 122.8 s, "statistically
identical" — **were not comparing like with like.** The 32-way sample covered cubes 0–58, which includes
the 16 *easy* cubes of circle pattern 0; the 16-way sample covered cubes 59–90, which are all the harder
circle pattern 1. A mixed population against a pure one: the same error as the 11.28 s baseline, with the
bias running the other way.

Corrected, restricted to circle pattern 1 so the population is fixed:

| run | cubes | n | median |
|---|---|---|---|
| 32-way, first run | 16–58 | 43 | **105.1 s** |
| 16-way | 59–90 | 32 | **126.6 s** |
| 32-way, relaunch | 91+ | 117 | **129.2 s** |

**What survives:** per-cube cost is ~105–130 s at either width, so there is no large contention penalty,
and restoring 32-way was right — measured throughput 12.6 cubes/min against roughly 8/min at 16 workers.
**What does not:** the two 32-way runs differ from *each other* (105 s vs 129 s) by as much as the width
effect being claimed, so the honest statement is **"the width effect is not distinguishable from
run-to-run variation in this data"**, not "statistically identical at 120.6 versus 122.8". Those two
figures are struck.

**Unaffected:** the hardware fact. 16 physical cores / 32 threads came from `lscpu`, not from the timing
comparison.

**The reproducible lesson, which is not "be careful about populations".** This file's rule that *a number
carries what it measures* was already known to me and freshly cited when I broke it again — in the act of
correcting the first break. What actually caught it was **a cost model failing an arithmetic check**: 32
workers at ~125 s should deliver ~15 cubes/min and the observed rate was far lower, which forced a look.
So the mechanism that reproduces is **keeping a predicted throughput beside the measured one and
reconciling them whenever they disagree** — not vigilance.

## 10. The certificate, and what a reviewer actually has to trust

`certificate.json` (150 KB, in the scratch directory; regenerable) holds the whole object in reviewable
form: the arena's parameters, the coupling decomposition, the 30 circle points and 36 off-diagonal
vertices, the 66 coupling pairs, the 19 circle patterns with their ζ₆ orbit sizes, the six centre-coloured
10-sets and their disjoint pairs, all 552 interface patterns, and the pair-check census.

**Building it surfaced a simplification worth stating, because it shrinks the trust core.** The refutation
does **not** require the 552 listed patterns to be *achievable* — only that they are a **superset** of the
achievable ones. A spurious extra pattern can only make the pair check *harder* to pass. So the argument is:

1. Every proper four-colouring C of the arena yields f(v) = C(v) and g(v) = C(Rv), both proper
   four-colourings of the base, with f(centre) = g(centre) and the 66 disequalities. (R0 = 0, and the copy
   carries the base's internal edge list.)
2. By **C1** and **C2** below, after the colour permutation that pins the centre, the interface patterns of
   f and of g both lie in the listed 552.
3. By **C4**, no ordered pair of the 552 satisfies all 66 disequalities.
4. Therefore the arena has no proper four-colouring.

| claim | what it is | how many | trust |
|---|---|---|---|
| **C1** | centre pinned + all 19 circle patterns blocked ⟹ base half UNSAT (so the 19 are all of them) | **1 UNSAT** | solver |
| **C2** | per circle pattern, that pattern pinned + its listed off-diagonal patterns blocked ⟹ UNSAT | **19 UNSATs** | solver |
| **C4** | no ordered pair of the 552 satisfies all 66 disequalities | finite table scan | **no solver** |
| ~~C3~~ | each listed pattern is achievable | 552 SATs | **not load-bearing** (superset suffices) |

**So the entire solver-dependent core is 20 UNSAT claims**, each on a 25,567-vertex / 1,267,897-clause
half instance — not on the 51,133-vertex arena, and not a multi-gigabyte proof log. C3 was nevertheless
verified for the 19 circle patterns, each exhibited by a proper colouring checked edge-by-edge against the
272,232-edge base list.

## 11. Process failures in this phase, recorded because two of them are documented traps that recurred

**Over-subscription.** At one point this phase had the 32-way cube split, a six-solver verification, an
independent re-check job and a proof-logging run all live: **35 heavy processes on 16 physical cores**,
~2.2× over-subscribed, everything ~2× slower. `CLAUDE.md`'s "one heavy job at a time" is the rule, and a
32-way cube split is *one* job only if nothing else runs beside it. Pruned to two jobs on priority grounds
(the second verdict route, and the 20-UNSAT trust core).

**Twice I launched a job whose first step was its least valuable one**, so the checks that mattered sat
behind slow ones — the positive control I put first was a *repeat* of evidence already held, and the DRAT
step I put first proved slow under load. **Order a verification script by marginal evidential value, not
by narrative order.**

**The wrapper-versus-child process group, which this project's notes already record after five incidents
in one night — and which recurred here anyway.** A job launched as `cd … && setsid nohup python3 x.py &`
puts the python in a **new** process group; the wrapper shell is in a different one. Killing the wrapper's
group leaves the child running, which is what happened: `independent.py` survived its kill and kept a core
for many minutes. A second stray — an accidental O(n²) scan — was simply forgotten.

> **The transferable form:** take the pgid from the **live process table after the launch**, never from the
> shell that launched it; and **verify a kill by re-scanning the whole table**, never by the kill's exit
> status. The exit status of `kill` reports that a signal was sent, not that the work stopped.

A related self-match: matching `xargs -a cubelist.txt` against `ps` output also matched **my own tool
shell**, whose command line contained the whole script text, and `head -1` picked that pgid — the
documented `pkill -f` self-kill hazard wearing a different costume. Match on `comm` (the executable name),
not on the command line.

## 12. The honest ceiling on this result

**This phase decides one object.** Everything structural here — the 19 patterns, the ζ₆ orbit decomposition,
the six centre-coloured 10-sets, their 6 disjoint pairs — is a fact about **this base at this radius**. The
*criterion* it produces (refutation by the diagonal edges alone requires the centre-coloured 10-sets to form
an intersecting family) is a criterion for **every** base and is checkable on a candidate in seconds. But:

> **Nothing here shows that a base satisfying that criterion exists.** The criterion is a target, not a
> theorem about the family, and *"un-eliminated is not alive"* applies to **the family**, not merely to this
> member.

And the cost census's reading is deflationary, as predicted **before** the numbers arrived: difficulty
tracks **one pattern's degeneracy**, not the rotation — 264 of the 552 cubes belong to the all-one-colour
circle pattern at ~126 s each against ~82 s for the rest. Nothing in the cost distribution is evidence about
ρ₆₃ specifically.

## 13. Independent verification of the trust core

Every load-bearing UNSAT re-checked on solver codebases independent of the one that produced it.

**C1 — the 19 circle patterns are all of them** (base half + centre pinned + all 19 patterns blocked ⟹ UNSAT):

| solver | verdict | time |
|---|---|---|
| CaDiCaL 1.5.3 (original) | UNSAT | 36.5 s (uncontended) |
| CaDiCaL 1.9.5 | UNSAT | 340.3 s (under load) |
| **Glucose 4.2** | **UNSAT** | 87.6 s |
| **Minisat 2.2** | **UNSAT** | 90.9 s |

Three independent codebases beyond the original. Lingeling, MapleCM and Mergesat3 were **forfeited** in the
prune (§11) as redundancy on a claim three codebases already agreed on.

*Positive control on this code path:* with **18** of the 19 blocks, the instance must be satisfiable and the
recovered pattern must be the dropped one — confirmed with CaDiCaL at drop indices 0, 7 and 18 (SAT, and
identical each time).

**C2 — each circle pattern's listed off-diagonal patterns are all of them** (19 separate UNSATs):

> **Glucose 4.2 confirms exhaustion for 19 of 19. Disagreements: none.** Per-pattern times 3.5 s–~300 s.

*Positive control on this code path, the paired form:* circle pattern 0 with **15** of its 16 off-diagonal
blocks came back **SAT in 2.7 s**, and **the recovered pattern was exactly the dropped one**. So the refusals
above come from exhaustion and not from the scaffolding — a refusal and a matching acceptance from the same
code path.

**C4 — the finite pair check.** 552 interface patterns → 304,704 ordered pairs; **18,432** pass the 30
diagonal constraints; **0** pass all 66. Discrimination ladder (§ repaired control): 0 constraints → 18,432
survive, 1 → 6,144, 2 → 4,224, 3 → 2,688, 6 → 768, **12 → 0**. Arithmetic cross-check: predicted
72 × 16 × 16 = 18,432 equals the counted 18,432.

**The proof-log question, for the product owner's decision.** The abandoned 23 MB log was of the *arena*
solve, which the superset argument retired as the load-bearing object. The 20 half-instance UNSATs are now
the load-bearing objects, and a proof log for each is a different and far more valuable artifact — it would
make this the first refutation in this project whose entire solver-dependent core ships as re-checkable
proof. **Cost to be measured on one instance when the machine is quiet, not estimated**, and reported as a
number.

## 14. THE VERDICT

> ## The ρ₆₃ arena is NOT four-colourable.
>
> χ(arena) ≥ 5, on 51,133 vertices and 544,530 edges, in the field ℚ(√3,√7,√11).

Reached **twice, by two routes**, which agree:

| route | method | result |
|---|---|---|
| **A — enumeration** | complete the 552 achievable interface patterns; check all 304,704 ordered pairs against the 66 coupling constraints | **0 pairs pass** ⟹ not four-colourable |
| **B — cube-and-conquer** | hand each of the 552 interface patterns to the solver as 67 unit clauses and ask whether the other complete 25,567-vertex half can dodge it | **552 of 552 UNSAT**, no missing results, 20.03 core-hours |

Route B replaces route A's second-half enumeration *and* the pair comparison with direct solver calls on
complete half instances. The two share only the completeness of the 552 — which is exactly the dependency
that four independent solver codebases were pointed at (§13).

**Per-cube census** (route B): min 30.9 s, p25 118.8 s, median 131.2 s, p75 146.4 s, max 276.2 s.

**A refusal is the suspect verdict here, and this is its audit.** The arena's edges come from two sources
with opposite error modes: the base's unit edges are *measured* (a Cayley graph on the exactly computed
norm-1 shell — complete by identity, no float anywhere, and a missed edge would only make colouring
*easier*), while the 126 cross edges are *derived from a rotation law at a new parameter*, where an
**invented** edge makes a refutation arrive faster and cheaper and looks exactly like success. So:

- All 126 cross edges were re-derived from raw coordinates by **two independent implementations** — the
  screening agent's and mine, mine using the exact K-identity `u_x v_y − u_y v_x = 0` and
  `cos·(u_x v_x + u_y v_y) = (|u|²+|v|²−1)/2` with √7 never evaluated. **126/126 both times, 0 invented**,
  with 26/26 lattice-perturbed negative controls correctly refused.
- The whole arena edge set matched the independently generated CNF **exactly** (§1).
- **The refutation genuinely needs the law-derived edges** — the 30 diagonal constraints alone leave 18,432
  pattern pairs alive — so this exposure is real and not rhetorical. But it is **bounded**:

| robustness measurement | result |
|---|---|
| off-diagonal constraints actually needed (greedy) | **4 of 36** |
| does dropping any *single* one of the 36 break the refutation? | **no — 0 of 36 drops break it** |

So even if one of the 36 law-derived off-diagonal edges were spurious, the verdict stands. That does not
cover a *systematic* fault in the law, which is why two independent re-derivations of all 126 carry the rest.

**Proof artifact — kept.** Measured on the quiet machine: the complete proof set for the 20 load-bearing
refutations costs **~4.8 minutes and ~0.37 GB**. Generated and retained under
`/tmp/claude-1000/solver-h2/proofs/` as 20 self-contained `.cnf` files each with its `.drat` refutation,
plus `manifest.json` (verdict, time, sizes, and a sentence saying what each one asserts). Any DRAT checker
re-checks them without this project's code. **This is the first refutation in this project whose entire
solver-dependent core ships as re-checkable proof** — possible only because the superset argument (§10)
moved the load from one 51,133-vertex refutation onto twenty 25,567-vertex ones.

## 15. A pre-registered prediction of mine that FAILED

I predicted — **before** the full numbers, and flagged it as a prediction precisely so it could be scored —
that the cube cost would concentrate on the degenerate all-one-colour circle pattern, so that "hardness
tracks that pattern's degeneracy, not the rotation". **The complete census refutes it:**

| population | n | median |
|---|---|---|
| degenerate all-one-colour pattern | 264 | **127.3 s** |
| the other 18 patterns | 288 | **136.5 s** |

The degenerate pattern is **slightly easier than average**, not harder. Per-pattern medians run 82.1 s
(pattern 0) to 171.2 s (pattern 3), with no structure that singles out the degenerate one. My reading came
from a **partial sample** — at the time, only patterns 0 and 1 had completed, and pattern 0 happens to be
the *easiest* of all nineteen, which manufactured the contrast I then explained. **Third instance in this
phase of the same error: a statistic computed on an unrepresentative subpopulation and read as a property
of the whole.** The deflationary *conclusion* survives in a weaker form — nothing in the cost distribution
is evidence about ρ₆₃ specifically — but the mechanism I offered for it was wrong.

### 14a. Two honest qualifications on the proof artifact

**The proofs were generated here but NOT checked here.** No DRAT checker (`drat-trim` or equivalent) is
installed on this machine, and `cadical`'s own proof options do not constitute an independent check. So the
correct claim is *"20 DRAT refutations exist and are re-checkable by any standard checker"*, **not** *"20
refutations have been verified"*. Checking them is a separate step and should be done on a machine with a
checker before the result is claimed externally. **A proof I produced and did not check is not a checked
proof.**

**The bundle is 807 MB, not 0.35 GB.** The DRAT logs total 0.35 GB; the 20 self-contained CNF files add
~0.39 GB because each repeats the same 1,267,897-clause base half (19.4 MB each). A leaner bundle ships the
base half **once** plus 20 small delta files of pinned/blocked clauses — about 20 MB plus the DRAT — and is
what a reviewer should be handed.

## 16. Artifact locations

Scratch (regenerable, outside `build/`): `/tmp/claude-1000/solver-h2/`

| file | what it is |
|---|---|
| `certificate.json` | the whole combinatorial certificate, 150 KB — coupling, 19 patterns, orbits, 10-sets, 552 interface patterns, census, the argument, the claims to verify |
| `graph.json`, `edges.txt` | my independent rebuild: lattice, 126 cross edges, all 544,530 arena edges in arena vertex ids |
| `patterns.json`, `offpats.json`, `orbit.json` | the 19 circle patterns, the 552 interface patterns, the ζ₆ orbit decomposition and the six 10-sets |
| `results/NNNN.json` | 552 cube verdicts with timings — also the resume checkpoints |
| `proofs/` + `proofs/manifest.json` | 20 CNF + DRAT pairs for the trust core, with what each asserts |
| `verify/independent.log`, `verify/recheck.log` | the independent-codebase confirmations |
| `mine.cnf`, `half.cnf` | my own arena CNF (verified identical to the screening agent's) and the base half |

**Resume command** for the cube route: `cd /tmp/claude-1000/solver-h2 && xargs -a cubelist.txt -n 2 -P 32
python3 cube_worker.py` — skips any cube whose `results/NNNN.json` exists.

## 17. The proof set regenerated as LRAT, and one correction to why

The 20 refutations were regenerated in **text LRAT** using the flags this repository already uses in
`scripts/regen-check.sh` — `cadical -q --lrat --no-binary --unsat --seed=0` — so the artifact matches the
house pipeline exactly rather than approximating it.

| | DRAT (binary) | **LRAT (text)** |
|---|---|---|
| total size | 358 MB | **1,001.2 MB** |
| total lines | — | **11,821,459** |
| per refutation | 16–24 MB | 40–119 MB, **585,000–614,000 lines** |
| solver time, all 20 | 3.3 min | **406 s (6.8 min)**, 2 min wall at 16-way |
| gzipped, for transport | — | ~**260 MB** (3.9× on a sample) |

All 20 verdicts UNSAT, exit code 20 each.

**The correction.** It is not quite right that LRAT is *"the one format this repository can check inside the
Lean kernel"*. Two steps sit in between, and `Sat/Lrat.lean` is emphatic about the first:

1. **Lean core's own LRAT checker does not kernel-reduce** — structurally, not by scale.
   `DefaultClause.ofArray` builds every clause through the only `Std.HashMap` in the LRAT tree; hash-bucket
   indexing computes on `USize`; its width is `System.Platform.numBits`, which bottoms out in an
   `@[extern] opaque`, so the kernel has no delta rule and every `USize` operation is permanently stuck.
   Core's checker therefore buys a **native-evaluation axiom**, for every certificate including a
   two-clause one.
2. **The kernel-reducible checker M05 built consumes a packed `Nat` encoding**, not LRAT —
   `Sat/MaskCheck.lean`, whose docstring says it is "smaller than the format core's `LRAT.check`
   consumes". LRAT is the **upstream** format that encoding is derived from.

So generating LRAT **is** the right cheap half — it is exactly what the house pipeline ingests, and the
instances had to be on disk to do it — but the honest claim is *"in the format this project's conversion
pipeline takes as input"*, **not** *"in the format the kernel consumes"*. The proofs remain
**generated, not checked**: no LRAT or DRAT checker is installed here.

**The number that prices the step nobody should take yet.** Each refutation is **585,000–614,000 LRAT
lines**. `CLAUDE.md` ledger row 40 priced kernel promotion at roughly **800,000 LRAT lines per cube** on a
different object, and this project **declined** it. So **one** of these is ~0.75× that declined unit, and
**all twenty together are ~15× it**. Generating the format is cheap; kernel-checking it is not, and the
decision is deliberately left open for a later milestone.

### 17a. The bundle, 807 MB → 19.5 MB

The duplication is fixed: `bundle/` ships the 1,267,897-clause base half **once** as
`base_half_body.cnf` (19.4 MB, no header) plus 20 small `delta_<name>.cnf` files — **19.5 MB total**
excluding the LRAT, against 807 MB when each CNF repeated the base half.

Reassembly is guarded rather than trusted. `bundle/reconstitute.sh <name>` rebuilds an instance from the
base body plus its delta and **verifies it against a SHA-256 recorded in `meta_<name>.json`**, so a
reviewer who reassembles wrongly is told so instead of checking the wrong formula. Proven to discriminate,
as a pair: with one extra clause planted in a delta the guard **refused** and printed both hashes; with the
delta restored the faithful partner **passed**. `bundle/manifest.json` carries the verdict, the argument,
what is *not* needed (achievability), the format and flags, the per-refutation sizes and line counts, and
the kernel-cost note above.

The earlier DRAT set under `proofs/` is superseded but left in place; its 20 CNFs are byte-identical to what
`reconstitute.sh` rebuilds.
