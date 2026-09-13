# Phase H4 — the free-deletion census on the `ρ₆₃` arena

**Job (reduction engineer, 2026-09-12).** Two numbers that pick a reduction target: **how much of the
51,133-vertex object comes out with no solver call at all**, and **what one incremental ask costs under
the interface formulation**. A measurement, not a build. No reduction loop was written.

Machine: the desktop (**16 physical cores / 32 threads**, 125 GB). Solver: `cadical` at
`$(lean --print-prefix)/bin/cadical`, single-threaded. Solver costs are **CPU seconds (user + sys of the
child)**; §7 records which were measured with another agent's job on the box and the factor that
converts between the two states.

---

## §0 — The two numbers

> **Number 1 — free deletions: ZERO of 51,133.** Not "few". Zero, under every certificate this
> repository holds, and the reason is one measured fact: **the arena's minimum degree is 6**, and the
> only absorption instance that applies at four colours cannot see a vertex of degree above 3.
>
> **Number 2 — one cold incremental ask: ~46 CPU-seconds** (16 single-vertex deletions, median 45.6 s
> deflated, all UNSAT), against **0.4–3 s** when the ask comes back SAT. Independently reproduced by the
> other measurement running this phase at **50.6 s** cold.

**The consequence that matters more than either number.** The coordinator's hoped-for split — a
superset-neutral phase needing no solver, then a smaller solver-bound phase — **has an empty first
phase on this object**. The derivation in §2 is sound and worth keeping for the family; it certifies
nothing here, because there is nothing free to certify. **Every one of the 25,500 non-interface base
vertices needs a solver call.**

---

## §1 — NUMBER 1: the free-deletion census. Zero.

| object | population | free by the 4-core peel | left |
|---|---|---|---|
| `ρ₆₃` arena | 51,133 | **0 (0.0%)** | 51,133 |
| …base side | 25,567 | **0** | 25,567 |
| …copy side | 25,566 | **0** | 25,566 |

Degrees, each with its population. Over the **51,133** arena vertices: minimum **6**, maximum **60**,
mean **21.2986**. Over the **25,567** base vertices in the base-induced subgraph: minimum **5**, maximum
**30**, mean **21.2956**, with **8,239 (32.2%)** at the full 30. The smallest `k` at which the peel
removes anything at all is **k = 7** (252 of 51,133); the degeneracy is **13** (the 14-core is empty,
the 13-core holds 26,353 of 51,133). Full table: `build/m63-phaseH4/freecensus.log`.

### Every certificate, checked against the Lean statements rather than against a summary

| certificate | what it requires | fires here? |
|---|---|---|
| **greedy absorption** — `Absorb.lean`, `extends_of_extensionOrder`, one-vertex form `extends_compl_singleton_of_degree_le` | a greedy order in which each vertex has **≤ 3** neighbours behind it, i.e. exactly the 4-core peel | **the only one that applies, and it removes 0** — minimum arena degree is 6 |
| **`extends_symCopy`** | two copies joined **only** by chords between corresponding vertices, **no fusion** | **cannot.** The centre is fused and 36 of the 66 couplings are off-diagonal. It *must not* fire: if it did the arena would be four-colourable, which phase H2 refuted |
| **`extends_of_matching`, `extends_of_hub_matching`, `extends_of_hubs`** | the piece (or piece + hub) **3-colourable**, and every piece vertex with **≤ 1** neighbour across the cut | **cannot, on the only named candidate.** Measured: the ball of graph-radius 2 about the shared centre — **451 vertices, 1,920 induced unit edges — is NOT 3-colourable**, and is 4-colourable. So the rotated copy, which contains it, is 4-chromatic |
| **non-adjacent domination** (folklore; an instance of `extends_of_repaint` with no clash at all: `u ≁ v` and `N(u) ⊆ N(v)` lets every colouring of `G − u` extend by `C(u) := C(v)`) | one vertex whose neighbourhood is contained in a non-neighbour's | **0 of 51,066 candidates** (the 67 interface vertices excluded). Controls: fires 2 of 5 on a path, 5 of 5 on `K₂,₃` |
| **`extends_of_repaint`** itself | a per-colouring choice of piece colouring with independent clashes | a **search**, not a certificate — it does not belong in a free census |

The hub/matching route is not merely unused, it is **structurally blocked at this density**: "≤ 1
neighbour across the cut" together with minimum degree 6 forces every piece vertex to keep **≥ 5**
neighbours inside the piece, so any qualifying piece would be a 3-colourable induced subgraph of
minimum degree ≥ 5 inside a lattice whose radius-2 ball is already 4-chromatic. Finding one is itself a
search, and nothing points at one.

### Both controls, seen working

**Control A — `[Parts2020a]`'s own 374-vertex base must peel to 374.** Built here from his published
vertex file (`data/m62/parts-vertex-lists.json`, his `(a,b,c,d)` convention) by an **exact integer**
unit-distance test in `K = ℚ(√3,√11)`: `Δa² + 33Δb² + 3Δc² + 11Δd² = 144` **and** `ΔaΔb + ΔcΔd = 0`.
No float anywhere.

| his file | V | edges rebuilt | edges named in the file | 4-core | 5-core | 6-core | 7-core |
|---|---|---|---|---|---|---|---|
| `v374e1860` | 374 | 1,860 | 1,860 ✓ | **374** | **350** | **340** | **265** |
| `v374e1864` | 374 | 1,864 | 1,864 ✓ | **374** | 352 | 342 | 265 |
| `v374e1868` | 374 | 1,868 | 1,868 ✓ | **374** | 356 | 346 | 265 |
| `v374e1872` | 374 | 1,872 | 1,872 ✓ | **374** | 352 | 344 | 289 |

**Must-not-fire: 374 → 374 on all four variants.** **Must-fire against registered values:**
`v374e1860`'s 5/6/7-cores are **350 / 340 / 265**, exactly the row in
`plans/POROS-2026-09-12-m63-phaseH3.md` (`374 | 374 | 350 | 340 | 265`). Three registered numbers hit
on the nose, from the same code path that refuses to remove anything at k = 4.

**Control B — phase H3's shape-free `n = 2` arena must peel 32,617 → 25,201.** Rebuilt here from phase
H3's own generator (`enum_base.py 16 7`, then `cross.py … 2`), with **every imported module asserted to
resolve to this working copy before use** (`CLAUDE.md`'s "a check that loads two versions of something
and identifies them BY NAME"). Independently reproduced along the way: 16,309 base points, 60,084 unit
edges, 264 isolated vertices, mean degree 7.3682, 252 cross edges of which 120 centre / 60 diagonal /
72 off-diagonal, all 252 confirmed by that file's second exact derivation.

| | V | 4-core | 5-core | 6-core | 7-core |
|---|---|---|---|---|---|
| H3 base alone | 16,309 | **12,601** | 9,913 | 7,237 | 793 |
| H3 arena | 32,617 | **25,201 — 22.7% removed** | **19,825** | **14,473** | **1,585** |

**Five registered values reproduced exactly** — 12,601 for the base and 25,201 / 19,825 / 14,473 / 1,585
for the arena. The registered arena figure was derived there as `2 × 12,601 − 1`; computing the arena's
own 4-core directly gives the same 25,201, so that shortcut was sound on that object.

**The strongest control is on the object itself.** The identical peeler removes **252** vertices from
the `ρ₆₃` arena at k = 7 and **24,780** at k = 13. It is not a peeler that cannot fire on `ρ₆₃`; it is a
peeler that finds nothing of degree ≤ 3 there. Its unit self-tests are two-sided: `K₅` survives whole at
k = 4 (guarded) and **`K₅` minus one edge peels to nothing** (planted), so
`0 < guarded − planted = 5 ≤ 5` — a lower bound that would break if the peel stopped firing at all.
The domination scan carries its own pair as well (2 of 5 on a path, 5 of 5 on `K₂,₃`, 0 on the arena).

---

## §2 — The superset-neutrality question, derived — and empty on this object

**The claim, and it is correct.** Let `I` be the interface, `S` a deleted set with `S ∩ I = ∅`, and
`A = V ∖ S`. Write `P(H)` for the set of patterns that proper four-colourings of `H` present on `I`.

> **If `Extends G A 4` holds, then `P(G) = P(G − S)` — the deletion cannot grow the pattern set at all.**

*Proof, both halves from statements in `Absorb.lean`.*
`P(G) ⊆ P(G − S)`: restriction. Any proper four-colouring `C` of `G` restricts to a proper
four-colouring of the induced subgraph `G[A] = G − S` (`restrictColoring`), and since `I ⊆ A` the
restriction agrees with `C` on all of `I`. **This half needs no hypothesis** — it is phase H3 §8's
monotonicity theorem.
`P(G − S) ⊆ P(G)`: this is exactly what `Extends` says. Unfolded,
`Extends G A 4 = ∀ c : (G.induce A).Coloring (Fin 4), ∃ C : G.Coloring (Fin 4), ∀ a : A, C a = c a`.
Given `c` proper on `G − S`, take the `C` it supplies; `C` agrees with `c` on `A ⊇ I`, so `c|I = C|I ∈
P(G)`. ∎

**The two qualifications the coordinator asked for.**

*Wholesale versus one at a time.* `Extends G A 4` is a statement about `S` **wholesale**, and the proof
above uses it that way. One-at-a-time is also fine, but the certificates must be taken **against the
current graph at each step**, not against the original: if `Extends G A 4` and
`Extends (G.induce A) B 4` with `B ⊆ A`, composing the two extensions gives `Extends G B 4`, so pattern
equality holds all the way down provided `I ⊆ B`. `Absorb.lean` already builds exactly this shape —
`ExtensionOrder`'s `cons` adds `b` with at most `k` neighbours in `insert b A`, i.e. in the set as it
then stands, which is why the iterated peel and not a one-shot degree test is the right instrument.
**The unsound shortcut to name**: certifying every vertex's degree in the *original* graph and then
deleting them all at once. For the degree-≤ 3 test that shortcut happens to be safe (a vertex of degree
≤ 3 in `G` has degree ≤ 3 in every subgraph), but it is not safe for certificates that can be destroyed
by a co-deleted vertex, and the peel's whole point is that it recomputes degrees as it goes.

*If `S` touches the interface.* Pattern equality becomes meaningless — the two pattern sets live on
different vertex sets — and the certificate loses the coupling constraints that vertex was an endpoint
of. Measured free of any solver: deleting one circle point costs **1** of the 66 constraints and one
off-diagonal interface vertex costs **2**, and **the pair check survives every one of the 66
single-vertex losses — 0 of 66 break it**, all still at 0 of 304,704 admissible ordered pairs. So no
single interface vertex is load-bearing *for the pair check*; whether the pattern set then grows is a
separate solver question, and the ask would have to be re-posed on the shrunken interface.

**And here is why all of this certifies nothing on `ρ₆₃`: the set it applies to is empty.** Every free
certificate returns 0 (§1). The superset-neutral phase the split was meant to buy does not exist here,
and the derivation is a theorem with no instances on this object.

**A caution for whoever applies it to a thinner member, measured rather than guessed.** The obvious next
thought is that phase H3's `n = 2` arena, which *does* give 22.7% to the peel, would hand that over
superset-neutrally. **It would not: that peel deletes the interface.** Measured here — of the 241 arena
interface vertices it removes **120**, including **all 60 circle points**, whose arena degree is ≤ 3
because they sit essentially on the rim (phase H3's own "circle degree 2 of 60 available"). A peel that
removes a circle point does not preserve the pattern set, it **destroys the coupling the certificate is
made of**. *This takes nothing away from phase H3's claim*, which was about deciding **four-colourability**
— for that question the 4-core is exactly right and the 23% is genuinely free. It is the
interface-pattern formulation that the peel breaks. **So the free certificate and the interface
formulation are compatible only where the peel misses the interface, and that has to be checked object
by object.**

---

## §3 — NUMBER 2: the ask, and what it costs

**The ask, stated exactly.** After deleting a vertex set `D`, one query on one 25,567-vertex half:

> Is there a proper four-colouring of `base − D`, with the shared centre pinned to colour 0, whose
> pattern on the 66 coupling vertices is **not** one of the listed 552?

**UNSAT** — the listed 552 is still a superset, phase H2's finite pair check transfers **verbatim**, and
the deletion is accepted. **SAT** — a new pattern exists and the certificate no longer covers. Sound for
a base-side deletion, a copy-side deletion, or both, because in every case each of the two
half-colourings presents a pattern drawn from a set contained in the 552. **This is the
superset-maintenance ask and the refutation-shaped ask at once**: that is precisely what phase H2's
superset argument bought, and it is why route (b) — 552 cube refutations — is never paid again.

| quantity | measured |
|---|---|
| **cold ask, UNSAT (deletion accepted)** | **median 45.6, mean 46.8, range 35.9–66.4 CPU-s** over 16 single-vertex deletions across four strata, deflated to the uncontended state by the factor in §7 |
| the same as raw readings | median 58.92, range 43.50–74.88 |
| **cold ask, SAT (deletion rejected)** | **0.43 – 2.83 CPU-s** on the batch rejections; 0.82–30.60 on the planted controls |
| guarded ask with no deletion, uncontended, 3 reps | **42.43 / 42.04 / 41.64** — spread 1.9% |
| **the finite pair check** (552 patterns, 304,704 ordered pairs, 66 constraints) | **0.016 s.** Not a per-deletion cost at all |
| the cheapest sufficient variant: block the 552 **projected** onto the 36 vertices the certificate actually reads (79 patterns, 36-literal clauses) | **39.96 s against 41.64 — a 4% saving.** Not worth building for |

**Independent agreement.** The other measurement running this phase reports a cold per-deletion answer
at **50.6 s**; my 16-ask population has median 45.6 (deflated) / 58.9 (raw). Two implementations, two
harnesses, the same number to within the contention factor.

**One number of theirs I cannot reproduce, flagged rather than adjudicated.** They report the base half
alone at **SAT in 0.025 s**. Running phase H2's own `half.cnf` unchanged, three times, I get
**0.35 / 0.33 / 0.33 CPU-s** — reproducing phase H2's recorded 0.35 s exactly and sitting 13× above
theirs. Nothing in this file depends on it, but two measurements of the same object that differ by an
order of magnitude are measuring different things, and whichever of us is quoting it next should know
which.

**An asymmetry that should drive any schedule: a rejection is 20–100× cheaper than an acceptance.**

**The ask certifies a SET, not a vertex.** Phase H3 §8's theorem, run backwards, says deletion can only
grow the pattern set, so one ask covers an arbitrary deletion set and there is no reason to step one
vertex at a time. Measured on the 25,500 non-interface base vertices:

| deletion set | verdict | CPU-s |
|---|---|---|
| 10 random | UNSAT — accepted | 72.88 |
| 100 random (an independent draw) | UNSAT — accepted | 62.37 |
| 1,000 / 5,000 / 12,750 random | SAT — rejected | 2.83 / 0.43 / 2.52 |

**The one thing I did not measure, and it is the largest unknown.** Every ask above rebuilds a
1,267,897-clause formula from scratch and throws its learned clauses away, while consecutive asks differ
by **one vertex in 25,567**. The other measurement's warm figures under presence assumptions — mean
10.87 s, median 0.001 s over 29 probes — are that saving, and they are ~4× on the mean and far more on
the median. Nothing here contradicts them; my numbers are the cold upper bound they should be compared
against.

---

## §4 — How fragile the superset is, and the one comparison I can already supply

The other measurement found that in **ascending index order** the instance flipped satisfiable at
**deletion 30** — twenty-nine deletions out of 25,567 added a twentieth achievable circle pattern — and
noted that ascending index order removes a **clump**, so it bounds fragility rather than measuring it.
**A scattered-order run is commissioned elsewhere. It does not need to be: I have it.**

| deletion order | largest set still certified | first set rejected |
|---|---|---|
| ascending index (clumped), one at a time | 29 | 30 |
| **random shuffle (scattered), nested prefixes** | **75 — UNSAT, 74.35 CPU-s** | **100 — SAT, 1.17 CPU-s** |
| independent random draws (not nested) | 100 accepted | 1,000 rejected |

**The two tests are not equally sensitive, and the direction favours the comparison.** Their flip is
reported as *"a twentieth achievable **circle** pattern"*, i.e. a test at the 30-vertex circle level;
mine blocks the 552 full **66-vertex** interface patterns. Since the 552's circle components are exactly
the 19, a new circle pattern forces a new full pattern but not conversely — **my test is at least as
sensitive as theirs, and flips no later.** So a scattered order surviving to 75 under the stricter test,
against a clumped order failing at 30 under the looser one, makes

**scattering worth at least 2.5–3.4× over clumping** — a lower bound, not a point estimate. The
threshold also depends on *which* vertices as much as on how many: one independently drawn 100-set was accepted while a different
100-prefix was not. Both numbers are about the **first** batch off a hugely redundant 25,567-vertex
base and neither extrapolates to the end of a reduction.

**And when the superset does break, it breaks big.** At the rejected 100-vertex scattered prefix I
enumerated the new patterns by blocking to exhaustion: **at least 79 new patterns, 576 CPU-seconds, and
the enumeration had NOT exhausted** when I stopped it (checkpointed; §8 has the resume command). The
per-pattern cost rose from 1.1 s to about 10–12 s as blocking clauses accumulated. **Growing the
superset is therefore not a cheap way to rescue a rejected batch** — the cheap move is to bisect the
batch down, which costs 0.4–3 s per rejection.

---

## §5 — Corrections the measurement forces

**1. The interface is 66 coupling vertices plus the shared centre — 67 — not 31.** Read out of
`build/m63-phaseH2-artifacts/solver-h2/coupling.json`: **30 circle points, disjoint from 36
off-diagonal coupling vertices**, and the off-diagonal base-endpoint set **equals** the copy-endpoint
set, so `f` and `g` present patterns on the same 66 vertices. A phase-H2 cube pins exactly 67 unit
clauses. The 552 patterns are patterns on 66 vertices and the blocking clauses are 66 literals long.
*(The coordinator has already withdrawn the 31, together with the counting criterion it came from,
which fails on this object anyway: `L = 10` against a circle count of 30, one third where more than one
half is needed.)*

**2. A phase H2 number is off by 31.** `plans/M63-phaseH2-solver.md` §1 reports "8,208 of 25,567
vertices (32.1%)" at full unit degree 30. Counting **distinct** base edges it is **8,239 (32.2%)**. The
8,208 comes from the 272,262-**entry** list, which repeats 30 edges: those 30 vertices then read degree
31 and the centre reads 60, moving exactly 31 vertices out of the degree-30 bucket. Same root cause as
that file's own §8a, one step further on. Nothing rests on it.

**3. "Every deletion that can matter touches the interface" (phase plan §4) does not follow from
Theorem B, and the truth is more interesting than either version.** The premise is right — the base
lies in `K²`, `χ(K²) = 4` (ledger row 57), the base half four-colours in 0.35 s and stays four-colourable
under any deletion. But the base half was never what carried the refutation. What carries it is a
rigidity statement about the *whole* base: that 25,567 vertices admit only **552** interface patterns.
Delete everything except the 67 interface vertices and you are left with an independent set plus the
centre's star, whose certificate is dead — so base deletions demonstrably can matter. Measured:

- **16 of 16** single non-interface deletions, sampled across four strata (maximum graph distance from
  the interface, distance 1, full degree 30, degree ≤ 8), were **accepted**. No individual base vertex
  is load-bearing.
- **100** non-interface vertices at once were **rejected**.

**No individual base vertex matters; the base collectively does.** That is `G10` — the forcing is
distributed — on a new object, and it is why a reduction here is a batching problem and not a
criticality problem. The geometry offers no shelter either: breadth-first search from the 67 interface
vertices puts **every one of the 25,567 base vertices within 4 unit steps** (67 at 0, 750 at 1, 6,654 at
2, 14,400 at 3, 3,696 at 4). In a mean-degree-21 lattice of radius 4.03 there is no far-from-the-
interface region.

**One caveat that must travel with every rejection in this file.** A SAT answer means **the certificate
stopped covering**, not that the object became four-colourable. The loop is conservative and can refuse
deletions that are in fact safe.

---

## §6 — Predictions scored

| id | prediction | outcome |
|---|---|---|
| **P-H4-1** | *"the no-solver certificates remove under 25% of the 51,133-vertex arena, and I expect 5–15%"* | **MET, at the extreme.** Measured **0%** — under the 25% threshold, and **outside the stated 5–15% expectation on the low side**. Both calibration points behaved as registered (Parts 0%, phase H3 22.7%) and this object landed at the Parts end rather than between them |
| **P-H4-2** | *"I expect most vertices to need an ask… no scoring, this is the measurement"* | **The measurement says all of them.** 25,500 of 25,500 non-interface base vertices need a solver call; the free population is empty |
| **P-H4-3** | *below ~1 core-second the engine is a convenience; above ~1 core-minute the engine is the whole project* | **NOT DECIDED as posed, and the question has moved.** A cold ask is **~46 core-seconds** — fifty times the first threshold and just under the second. But the phase plan's ~1-core-minute arm was reasoned from the 20.03 core-hour census, which the coordinator has withdrawn as never having been a per-deletion cost, and the other measurement's **warm** figure (mean 10.87 s, median 0.001 s) puts a full pass at ~77 core-hours ≈ 5 hours on this machine. **On the numbers now in hand the cost wall is gone**, and what stands in the way is §4's fragility, not the price of an ask |

---

## §7 — Conditions, and the controls ledger

**Contention.** Another agent's single-core job (`h2probe`) started at **20:12:47** on 2026-09-12; from
then on the box carried 2–3 heavy single-threaded processes against 16 physical cores. The factor was
measured on the same instances rather than assumed: the guarded 552-block ask reads **42.04 s** mean
uncontended against **53.19 s** contended, and the 79-block projected ask reads **39.96 s** against
**50.83 s** mean. **Both give 1.27×**, and that is the factor used to deflate §3's sample. No
unexplained process crash occurred; the one job I stopped (the pattern-growth enumeration) was stopped
deliberately, its pgid taken from the live process table, and the kill verified by re-scanning the whole
table rather than by the kill's exit status.

| control | what it must do | what it did |
|---|---|---|
| peeler unit test, `K₅` | survive whole at k = 4 | 5 of 5 survive |
| peeler unit test, `K₅` minus one edge (**planted**) | peel to nothing | 0 of 5 survive; `0 < 5 ≤ 5` two-sided |
| **Control A**, Parts's four 374-vertex bases | 374 → 374 at k = 4 | **0 removed, all four variants** |
| Control A, edge builder | rebuild each file's own named edge count | 1,860 / 1,864 / 1,868 / 1,872, all ✓ |
| Control A, **planted**: move one vertex by 1/12 | edge count must drop | 1,864 → 1,854; `0 < 10 < 1,864` |
| Control A, registered higher cores | 350 / 340 / 265 | reproduced exactly |
| **Control B**, phase H3's `n = 2` arena | 32,617 → 25,201 at k = 4 | **25,201, plus 19,825 / 14,473 / 1,585 and the base's 12,601 — five registered values exactly** |
| Control B, module provenance | `kk`, `build_base`, `enum_base` must resolve to this working copy | asserted before use, all three |
| domination scan, path on 5 / `K₂,₃` (**planted**) | must fire | 2 of 5 / 5 of 5 |
| **the instance my ask is posed on** | `half.cnf` decoded back to a graph must be the base half | 25,567 vertices, 272,232 edges, **0 in CNF not in list, 0 in list not in CNF** |
| **the paired acceptance control**, full ask: drop one of the 552 blocks | SAT, and the recovered pattern must be exactly the dropped one | 4 of 4 SAT, recovered exactly (indices 0, 17, 300, 551) |
| the same for the projected ask: drop one of the 79 | SAT with the dropped projected pattern | 3 of 3 (indices 0, 40, 78) |
| **C4 re-derivation** | 304,704 ordered pairs / 18,432 passing the 30 diagonal / 0 passing all 66 | reproduced exactly, and the full registered ladder 18,432 → 6,144 → 4,224 → 2,688 → … → 768 at six → 0 at twelve |
| greedy minimal constraint set | phase H2's 4 of 36 | 4 of 36 |
| projected certificate, **planted**: drop one of its 34 constraints | survivors must go from 0 to something below 6,241 | 12; `0 < 12 < 6,241` |

**One control caught its own scaffolding.** The first run of the paired acceptance control crashed
rather than passing: the harness asked `cadical` for a model while running it with `--no-witness`, so
there was no model to compare. Had I checked only the verdict it would have read SAT and passed while
proving nothing about the pattern indexing.

---

## §8 — Artifacts, checkpoints, resume

Evidence (do not clean): `build/m63-phaseH4/` — `freecensus.log` (the full census with both controls),
`guarded.json`, `paircheck.json`, `grow.json`, `dominated.json`.
Working copies, checkpoints and the harness live **outside `build/`**, at
`/home/kooshi/.claude/jobs/d4cccfde/tmp/`: `peel.py` (the one peeler every measurement shares),
`freecensus.py`, `ask.py` (the ask harness), `paircheck.py`, `protect.py`, `dominate.py`,
`ckpt/*.json` (one file per completed ask).

| run | resume command | state when stopped |
|---|---|---|
| the ask sample | `cd /home/kooshi/.claude/jobs/d4cccfde/tmp && python3 run_asks.py` | stages 1–3 complete; stage 4 (the projected-ask deletion sample) deliberately not run — it prices a 4% saving |
| the batch and prefix probes | `… && python3 batch.py` / `python3 batch2.py` | complete |
| **the pattern-growth enumeration** | `… && python3 grow.py 100` | **stopped deliberately at 79 new patterns / 576 CPU-s, NOT exhausted**; the state file `ckpt/grow-state.json` holds every pattern found and the run continues from it |

Each script skips any ask whose checkpoint file already exists, so a relaunch redoes at most the one ask
that was in flight.

---

## §9 — What I would most want a second pair of eyes on

**That Number 1 really is zero, and not zero because I looked for the wrong shape.** The census is a
statement about a *generator*: I enumerated the certificates this repository holds and asked which fire.
`CLAUDE.md`'s standing warning is that a decisive zero from a search whose generator cannot represent
its target passes its positive controls and is still wrong — three times in this milestone. Here the
positive controls do pass (the peeler fires at k = 7 and k = 13 on this very object, and reproduces
eight registered values on two others), which by that rule is **not** evidence that the zero is real.
The specific thing to check is whether some absorption instance exists that `Absorb.lean` does not
state and I therefore did not look for — the module's own docstring says every instance there is one
construction, the repaint lemma, and a cleverer choice of piece colouring is exactly the free parameter
I did not vary.

---

## §10 — The reducibility recognition: the prior art, and the pricing verdict

*Commissioned at the phase H4 close: `Absorb.lean`'s absorption is a private name for a classical
technique, and the question is whether the classical machinery reaches further on this object.*
**It does not, and the reason is arithmetic rather than effort. Recommendation: stop.**

### §10.1 — The prior-art gate (WORKFLOW step 3a)

Searched in the literature's vocabulary and never in ours — *D-reducible*, *C-reducible*, *reducible
configuration*, *ring colouring*, *Kempe chain reducibility*, *Birkhoff diamond* — and under a second
discipline's names for the same object: *degree-choosable*, *Gallai tree*, *precolouring extension*,
*graph-colouring preprocessing / reduction rules / dominated vertex removal*.

**The recognition is correct, and it is exact.** A configuration is a vertex set `S`; its **ring** is
the cycle `R` of vertices surrounding it; it is **D-reducible** when every proper four-colouring of the
ring extends into the configuration. Written on a general graph with `R = N(S)∖S`, that is
**`Extends G (V∖S) 4` verbatim** — so `extends_of_extensionOrder` and the 4-core peel are the
degeneracy corner of a machine built between 1913 and 1996 (`[Steinberger2010]`, now a bibliography row
with the quotations this section rests on).

**The second discipline gives the sharp boundary, and we did not have it.** Borodin (1977) and
Erdős–Rubin–Taylor (1979), independently: **a connected graph is degree-choosable iff it is not a
Gallai tree** — a graph each of whose blocks is a complete graph or an odd cycle. Applied to
absorption: given a colouring of `G − S`, each `v ∈ S` holds a list of size
`≥ 4 − |N(v)∖S|`, and the list colouring exists whenever `4 − d_out(v) ≥ deg_S(v)`, i.e.

> **every free-by-degree deletion at four colours needs a vertex of degree ≤ 4** — degree ≤ 3 by the
> greedy argument `Absorb.lean` states, and degree exactly 4 by Borodin/ERT provided the piece is not a
> Gallai tree. **That is the exact boundary; there is nothing past it that degree alone can buy.**

**`ρ₆₃`'s minimum degree is 6.** So the sharp classical theorem gives zero on this object too, with two
whole degrees of margin, and §1's zero is not an artefact of `Absorb.lean` stopping early.

**What the search did NOT find, recorded as a finding.** No application of reducibility off the plane.
Every hit — Appel–Haken, Robertson–Sanders–Seymour–Thomas, Steinberger, the 2024 gauge-theory
reformulation, the Kempe-locking literature — is planar throughout. This is not a gap we can walk into:
§10.3 says why.

### §10.2 — Would it fire on this object? Priced exactly, no solver

**(a) Singletons are dead by a two-line theorem, not by measurement.** `{v}` is D-reducible iff every
proper four-colouring of `G[N(v)]` uses at most three colours. But any graph on ≥ 4 vertices has a
surjective proper four-colouring — take any proper colouring and split a class with two vertices, which
is always proper, until four classes are non-empty. **So `{v}` is D-reducible iff `deg(v) ≤ 3`**, and
the 4-core peel is not an approximation to singleton D-reducibility, it *is* singleton D-reducibility.

**(b) Every member of a configuration must have at most 3 neighbours outside it.** If some `v ∈ S` has
`d_out(v) ≥ 4` and `G[R]` admits a proper four-colouring giving four of those neighbours four distinct
colours, `v` has no free colour and `S` is not D-reducible. *(Proviso, stated because it is the one soft
step: it assumes such a ring colouring exists. `G[R]` here is a small unit-distance graph, and the link
of any vertex in a plane unit-distance graph has maximum degree 2 — two neighbours of `v` are adjacent
only at 60° — so the local structure is a union of paths and cycles and is as flexible as a graph gets.)*

**(c) That necessary condition alone kills every configuration small enough to matter.** From (b),
`|N(v) ∩ S| ≥ deg(v) − 3` for every `v ∈ S`; if `|S| ≤ m` then `deg_S(v) ≤ m − 1`, so every member has
`deg(v) ≤ m + 2`. Peel the graph to the fixed point of *"delete `v` when `|N(v) ∩ C| < deg(v) − 3`"*
started from `C = {v : deg(v) ≤ m + 2}`; every admissible `S` survives the peel, so an empty fixed point
is a proof of non-existence. Measured exactly on the arena:

| `m` | candidates after the degree filter | after the closure |
|---|---|---|
| **14** (the classical ceiling) | 16,428 of 51,133 | **0 — no configuration of this size exists** |
| **20** | 29,376 | **0** |
| **27** | — | **0** |
| 28 | 51,132 | 51,132 |

> **No configuration of 27 or fewer vertices exists anywhere in the `ρ₆₃` arena.** Appel–Haken and
> Robertson–Sanders–Seymour–Thomas used rings of size **≤ 14**; Steinberger went to **16**.

**(d) And the rings are two orders of magnitude too big.** Measured directly:

| configuration | ring |
|---|---|
| a single vertex | 6 (minimum) to 60, median 20 — and singletons are dead by (a) |
| the closed neighbourhood `N[v]`, the most compact non-singleton available | **77 minimum** (at `\|S\| = 7`), median 249, maximum 840 |
| greedy ring-minimising growth to `\|S\| = 28`, the smallest size (c) permits, over 40 minimum-degree seeds | **161 best, 175 median, 196 worst** — and the best still has a member with `d_out = 11`, so it does not even satisfy (b) |
| the same growth at `\|S\|` = 7 / 14 / 21 / 28 | ring 42 / 82 / 128 / 165 |

**The cost, in the literature's own units.** `[Steinberger2010]`: *"the cost of testing a configuration
for reducibility increases roughly by four-fold with its ring-size"*, and a ring-16 configuration takes
*"a few minutes"*. A ring of size 14 has 199,291 colourings up to colour permutation; a ring of 77 has
about **2 × 10³⁵**. At four-fold per ring unit, the cheapest configuration this object can support costs
about **4⁶¹ ≈ 5 × 10³⁶** times a few minutes. **This is not an engineering gap.**

### §10.3 — C-reducibility does not rescue it, and the reason is the one thing that needs planarity

The brief's working assumption was that *"the reducibility half of that theory does not need
planarity"*. **Half of that is right and the half we would need is not.** D-reducibility is
planarity-free as a definition — it is our `Extends`. C-reducibility's extra power comes from the
*consistent set of colourings*: a Kempe-chain argument shows that if a ring colouring extends to the
exterior then one of finitely many sets of ring colourings, **independent of the exterior graph**, all
extend to it. That independence is bought in exactly one step, which `[Steinberger2010]` §2 writes out:

> *"Because `G` is planar, each `V_i` is a subset of the same component of `R∖V_j` for all `j ≠ i`."*

The Kempe classes cut out on the ring form a **non-crossing** family, and his *signed path arrangements*
are the bookkeeping of that fact. Off the plane the classes can interleave arbitrarily, so the
disjunction in the Kempe implication must be taken over **all** partitions rather than the laminar ones
— more universally-quantified cases, each needing its own good outcome. **Non-planar C-reducibility is
therefore strictly harder than planar C-reducibility, not merely more expensive**, and it is harder in
the direction that matters.

### §10.4 — Verdict, and what would revive it

**Retire the direction for `ρ₆₃`.** Not "expensive" — the smallest admissible configuration has ≥ 28
vertices and a ring of ~160 where the entire classical literature stops at 16, and the singleton case
is dead by theorem. Nothing here is worth building, and the reduction does not need it.

**What is kept, because it is cheap and reusable:**
1. The **exact boundary**, and a screen sharper than "minimum degree" — *which I got wrong first and
   the check caught*. Free-by-degree deletion at four colours needs a connected piece all of whose
   vertices have degree ≤ 4 **and which is not a Gallai tree**. `ρ₆₃`'s minimum degree is 6, so it fails
   at the first clause. I then wrote that `[Parts2020a]`'s base, whose minimum degree is 4, would
   therefore benefit — **and it does not**: measured, its 18–24 degree-≤ 4 vertices are **pairwise
   non-adjacent**, so every candidate piece is a single vertex, and a single vertex **is** a Gallai
   tree. *(Controls: the instrument calls `C₄` not a Gallai tree, and `K₃`, `P₃` and `K₁` Gallai trees.)*
   **So the screen is not "minimum degree ≤ 4" but "do the degree-≤ 4 vertices touch each other in a
   piece containing an even cycle?"** — a much rarer condition, and it is zero on both objects this
   project holds. That is the reusable line, and it is worth more than the version I first wrote.
2. The recognition itself, with its vocabulary: `Absorb.lean`'s `Extends` is D-reducibility, and the
   translation belongs in `BIBLIOGRAPHY.md` § E when the write-up comes.
3. **Do not describe reducibility as planarity-free again.** The D half is; the C half is not, and the
   quotation above is the citation.

**What would revive it:** an object whose degree-≤ 4 vertices form a connected piece that is not a
Gallai tree (where the degree-choosability theorem bites — and note that minimum degree ≤ 4 is *not*
enough, as Parts's base shows), or
one with genuine small separators — a ring of ≤ 16 cutting off more than one vertex. `ρ₆₃` has neither:
its smallest cut that isolates anything is the 6-neighbourhood of a minimum-degree vertex, and that
isolates exactly one vertex, which is the case (a) already settles.
