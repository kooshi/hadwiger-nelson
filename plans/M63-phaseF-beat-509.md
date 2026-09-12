# M63 phase F — beat 509

*Planned 2026-09-11 by the phase F planner, with Poros as advisor (`plans/POROS-2026-09-11-m63-phaseF.md`,
five cards, all adopted or corrected in §P). **Nothing in this plan was run.** Every number below is either
read off a committed artifact, quoted from a plan, or arithmetic on those; where a number is a forecast it
says so. The plan is written for a fresh engineer with no memory of this session.*

---

## §0 — Purpose, and the shape in nine lines

0. **RE-AIMED 2026-09-11, by the product owner, after this plan's first draft.** The target is **not**
   Parts's specific object. *Shrinks are context-dependent, so the goal is to reproduce his method well
   enough that it finds smaller graphs he never reached.* His accumulators, his rotation and his base are
   **his starting point, not ours**; squeezing them harder is a footnote however it comes out. **Phase F's
   product is therefore our reproduced loop, run from inputs he did not use** — and the object it finds, if
   it finds one. §2.0 records what that changed and what carried.
1. **A 5-chromatic unit-distance graph smaller than 509 vertices, found by us and certified by the Lean
   kernel, is still the prize** (§1.1's acceptance is unchanged). Thinning his graph is not the product.
2. Single-orbit expansion is **closed on both halves** — 89 of 89 inert on the large half, 11 of 14 decided
   and inert on the small — and phase D §H2.8 upgrades that from *"insufficient"* to **"the added material
   is essentially never in any optimum"**. **Sharper, and measured for this plan:** *two of the four orbits
   of Parts's own successful move — `(0,0,0,4)` and `(0,0,6,6)`, live partial-fill candidates at `A412`
   adding 3 and 6 vertices — were each offered singly and are **inert**, neither improving nor growing the
   level.* That is direct evidence for the combination reading, on the only material with a known positive
   behind it (§2.4; the map's own summary field says otherwise and is wrong — §X.2).
3. So the only live lever inside phase F is **more than one orbit at a time**, which is also what
   `[Parts2020a]`'s one recorded successful expansion was: **four orbits at once**.
4. **The instrument is not a pair sweep.** Expansion is monotone (phase D §O2), so one reduction over a
   *union* of orbits, asked at a target, decides **every subset of that union at once** — 2^k questions per
   run instead of one.
5. So the programme is a **ladder on union size** (k = 2, 4, 8, 16, 32, 62 orbits), each rung one run, with
   a **covering design** at the largest affordable size as the fallback if the ladder bends (§2, F1–F2).
6. The cost model that makes this affordable is measured, not assumed: on this stage, **run cost is flat in
   how much material the candidate adds** — 214 s at 3 added vertices, 246 s at 12, 221 s at 24 (§1.4).
7. **The joint route is closed and its runs are stopped** (product owner, 2026-09-11): freezing one half
   already yields a vertex-critical object, joint reduction is far slower, and **nobody can prove joint
   beats frozen-companion** — absent that proof, slower is worse. What it leaves behind is a finding worth
   keeping, not a route: **504 ≤ |M| ≤ 509** over his two accumulators, from a hitting set over 153 free
   atoms of which 80 of the record's 85 are provably necessary (§2.2).
8. **The handoff into new bases and new rotations is a first-class deliverable of this plan** (§2.6): not
   the census itself — a separate planner owns that — but **the interface the loop needs in order to accept
   a new base or rotation as input**, which is what makes the census worth running.
8. **Nothing launches before the calibration run lands** (`hismove`, still running at the time of writing):
   every instrument in this milestone has returned zeros, so the set-valued apparatus must first reproduce
   the one known positive (§5.1).

---

## §PA — The prior-art gate (WORKFLOW step 3a)

*Run 2026-09-11, before the programme in §2 was ordered. Two questions: **is 509 still the number**, and
**who owns the method** — searched in the disciplines' words, never in this project's (`G49`). Bibliography
rows added the same day are listed at the end of this section; `tools/bib_audit.py` is green (153 keyed
rows; 0 unresolved keys).*

### PA.1 — Is 509 still the record? Yes, and it is stated three times independently

| source | what it says | date |
|---|---|---|
| `[Haugland2026]` arXiv:2608.04542**v3** introduction | *"the current record is 509 vertices by Parts"* | Aug 2026 |
| Wolfram MathWorld, *Hadwiger–Nelson problem* / *Parts graphs* | the smallest known 5-chromatic unit-distance graph is the 509-vertex Parts graph | current |
| two independent web searches under different phrasings | no improvement announced through 2026 | 2026-09-11 |

Searched and found nothing smaller: *smallest 5-chromatic unit-distance graph 509 improvement 2024 2025*;
*minimal non-4-colorable vertices record Parts de Grey*; *unit distance graph vertex minimization local
search / simulated annealing / genetic algorithm*. **Outside arXiv:** the *Geombinatorics* author index for
Jaan Parts (`geombina.uccs.edu/author-index/jaan-parts`) lists every paper of his through 2023 — forbidden
distance intervals (2023), hexagon tilings and the lower-bound paper with de Grey (2022), odd-distance and
multi-fold colourings (2021–22) — and **nothing after 2020 on minimization or on a smaller graph**. The
Polymath16 wiki page did not resolve at the address recorded in `[Polymath16]` (HTTP 404, 2026-09-11); the
threads' text is held locally at `library/notes/polymath16-threads-1-18-text.txt` and was searched in full
in an earlier milestone. **Verdict: phase F is aimed at the right number.**

### PA.2 — How much room is below it, in print

`[deGreyParts2023]` (held, read in full) proves **`v5 ≥ 28`** and **`e5 ≥ 99`**. So **nothing published
obstructs any vertex count between 28 and 509**, and the interval phase F is hunting in is not known to be
empty by anybody. The same paper's footnote 2 is why our secondary bar is 2,406 rather than 2,442.

### PA.3 — Who owns the method, under two disciplines' names

The recognition sentence (`G46`) for phase F's instrument is: *we are identifying the minimal true points of
a **monotone Boolean predicate** over subsets of a candidate set, using an expensive **membership oracle**,
and we may batch the queries.* Searched under that vocabulary and one more:

| discipline, in its words | what it owns | what it gives us | status |
|---|---|---|---|
| **monotone Boolean function identification / combinatorial group testing** (`[MonotoneIdentification]`) | identifying an unknown monotone function from membership queries; minimal true points; adaptive vs non-adaptive query schedules | the formal warrant that a **negative on a union closes every subset**, and the observation that our schedule is adaptive group testing over a monotone predicate | named, **not read** |
| **covering designs** (`[CoveringDesigns]`) | `C(v,k,t)`: the fewest `k`-blocks covering every `t`-subset of a `v`-set; the La Jolla repository holds the blocks | the **fallback schedule** at §2's F2 — the number of runs needed to close every pair when the ladder bends | named, **not read** |
| **iterated local search / large neighbourhood search** (`[IteratedLocalSearch]`) | perturbation strength: *"too weak and the local search undoes it; too strong and it is random restart"*; ruin-and-recreate | the discipline that owns *"how many orbits at once"* — Parts's expansion is a perturbation and his escape (*"increase the number of new vertices"*) is its standard knob | named, **not read** |
| **MUS/MCS enumeration and the backbone** (`[LiffitonEtAl2016]`, `[IgnatievEtAl2015]`) | hitting-set duality, MARCO, smallest-MUS with `forqes`, the backbone of an MUS family | already in the bibliography from M63/M64; it owns the **reduction** half, which is reproduced and is not what F changes | named, **not read** |
| **symmetric integer programming** (`[HerrRehnSchurmann2013]`) | core points, orbitopes, orbital branching | owns overcompression; **the reason F stays at rung 1** (§2.1, item (f)) | named, **not read** |

**What is and is not ours.** The monotone-union argument is a completely standard fact about monotone
predicates; **this plan claims no novelty for it** and cites the discipline. What is not in any of the
literature found is its application here — that a *reduction over a union of symmetry orbits of a
unit-distance lattice, asked at a target*, is a complete certificate over an exponential family of
expansions. Heule's clausal-proof trimming (`[Heule2019]`) and Parts's own loop (`[Parts2020a]`) remain the
only two published minimization methods aimed at this object, and **neither does set-valued expansion with a
completeness claim**.

**A negative recorded as a finding:** nobody has published a smaller graph, and nobody has published an
*exhaustive* statement about expansion of either half. The small half has never been expanded at all by
anyone (`plans/M63-probe-S-expansion.md` §2, first established there).

**Bibliography rows added 2026-09-11** (all marked *named only, not read*): `[MonotoneIdentification]`,
`[CoveringDesigns]`, `[IteratedLocalSearch]`. Re-run `python3 tools/bib_audit.py` after any edit; it fails
on a citation key that resolves to nothing.

---

## §1 — What the implementer must know before writing a line

### 1.1 — The object, and the arithmetic of "beat"

The record is `G = L ∪ ρ₁₅·S`, a large half and a small half **sharing one vertex** (the centre):
`509 = 374 + 136 − 1`, 2,442 edges. The published edge state is **2,406** (`[deGreyParts2023]` fn. 2
discards 36 without an exhaustive search).

**Acceptance (`plans/M63-parts-reproduction.md` §S.1 #4, the product owner's, not reopenable here):**

- **headline** — fewer than 509 vertices; or
- **secondary** — 509 vertices with fewer than 2,406 edges;
- **either is a record only once certified in the Lean kernel** (exact geometry + the LRAT chain).

**And the ruling that bounds it** (Kooshi, 2026-09-11): *"cancel the certification, just record it. It's not
really worth much to just thin his graph."* We already hold his 509 with 163 edges dropped (2,279, six-leg
verified); that is **a measurement, never a record**. Phase F aims at a graph **we found**.

**The three-way identity that must be got right, because one off-by-one makes every run ask the wrong
question.** On the L stage the shared centre is *fixed* and is never a deletable atom, so

```
|M| vertices  =  w* atoms + 1
incumbent          373 atoms  =  374 vertices   (the record's L half)
the target         372 atoms  =  373 vertices   → assembled 373 + 136 − 1 = 508   ← what F asks for
```

`data/m62/m63-map-A412.json`'s entries read `incumbent: 373`, `asked_at_target: 372`. **Every phase F run
asks at 372.** (Poros's card 1 says 373 three times; corrected and acknowledged — §P.)

### 1.2 — The lemma the whole programme rests on, with its real hypotheses

**Phase D §O2** (`plans/M63-phaseD-the-loop.md:1223`), proved there:

> Let `W' = W ∪ Δ` with **the same companion `C`, the same rung `H`, and the same cross-law**. Then
> `w*(W') ≤ w*(W)`, and every minimum of `W` is still feasible in `W'`.

The proof is one line of set algebra: `Δ`'s vertices are not in a selection `S`, so `W'[S] ∪ C = W[S] ∪ C`
as graphs; the feasible set only grows. The same statement is derived independently as D1 in
`plans/M63-probe-S-expansion.md` §5 and as the `monotonicity_note` in `data/m62/m63-trim-test.json`:
*"adding vertices can never raise `w*` … over-proposing can cost only time, never correctness."*

**What that buys, and it is the plan's whole design.** For `X ⊆ U`, `w*(A ∪ U) ≤ w*(A ∪ X)`. So a single
run over `A ∪ U` that closes at **lower bound 373 atoms** proves that **no subset of `U` whatsoever**
reaches 372 — every pair, triple, quad and the whole of `U` together, in one run.

**The three hypotheses are load-bearing, and one of them constrains phase F directly.** *Same rung* is
essential (the L side reads 375 at rung 1 and 376 at three of its involutions), and **a rung is a subgroup
of `Aut(A)`, which moves when `A` grows** — so only **rung 1 is immune to expansion**. Every phase F run is
at rung 1. This is also why symmetric seeds are struck (§2.1 item (f)).

**Corollary inherited from §O2, and it has already bitten once:** *anything chosen by a rule that reads `A`
changes meaning when `A` grows.* Pin every `A`-dependent choice **by value at the baseline** — the
companion's frame, the image of any reference object in a control, and the rung as an explicit element list.

### 1.3 — Asking at a target, not for a level (phase D §O3)

`reduce_stage(target=t)` is sound both ways: on success it returns `w* ≤ t` **with the level at `w*`
complete**; on failure the MaxSAT lower bound over the harvested correction sets exceeds `t`, which proves
`w* > t` **and nothing else** — no level, no `A`, no upper bound.

**Two rules that travel with it.** A failure is a failure **only if no ask came back `unknown`**; with an
undecided ask the verdict is `unknown-at-target`, and *"no improvement exists"* may not be said. And a
record produced under a target **must never render with the word *minimum***.

This is what makes the ladder affordable: no phase F run enumerates a level until one succeeds.

### 1.4 — The measured cost model (the number that chose the instrument)

From `data/m62/m63-map-A412.json`, all 89 finished entries, **nothing re-run for this plan**:

| vertices the candidate adds | entries | stage atoms | median CPU s | max CPU s | correction sets | asks |
|---|---|---|---|---|---|---|
| 0 (the identity control) | 1 | 411 | 138 | 138 | 461 | 3,016 |
| 3 | 1 | 414 | 214 | 214 | 454 | 2,829 |
| 6 | 7 | 417 | 223 | 253 | 465 | 3,105 |
| 12 | 24 | 423 | 246 | 418 | 467 | 3,268 |
| 24 | 56 | 435 | 221 | 371 | 464 | 3,245 |

**Run cost is flat in perturbation size over the whole measured range**, and so are the correction-set and
ask counts. The expense is the lower-bound climb to 373, which is paid whether the candidate adds three
vertices or twenty-four. Total for all 89: **5.91 CPU hours**, zero undecided asks.

**Three more cost facts, all from stored records** (Poros's inventory, re-checked against the artifacts):

- **Stage size does not predict cost.** The 166-vertex S stage cost 713 CPU s; the 403-vertex L stage cost
  87. Cost is *asks × per-ask cost*, and the small stage's refusing asks are ~6× dearer.
- **What explodes cost is both halves being deletable, not size.** The joint stage (577 vertices, 576
  atoms, both halves free) has run **>17,000 CPU s each in two frames** and is still open, with near-optimal
  asks at 1.758 s against the L stage's 0.138 s — a 13× per-ask penalty.
- **A median is not a budget: a block pays its worst member.** Over the map's 266 timed entries the
  distribution is **p50 185 s, p90 269 s, max 418 s** — max/median 2.26. And hardness is
  **candidate-specific, not gap-determined**: on the small half two of fourteen singles are past **250 CPU
  minutes** while twelve siblings finished in 30–70 minutes, five of those at the *same* gap. So every
  staircase rung reports **max and the full distribution**, never the median, and every block carries a
  wall (§2.4).

**The heavy tail is two phenomena, and only one of them can reach a phase F run.** The two small-half
stragglers are in different states, which is what separates them:

| | what is happening | can it occur in a ladder run? |
|---|---|---|
| **tail A** — candidate `(0,0,6,6)` | the minimum is already known (135 atoms + the centre = 136 vertices, the inert answer); the run is **enumerating its level** | **No.** Target mode never enumerates a level (§O3), and every phase F run passes `--no-secondary` |
| **tail B** — candidate `(12,0,2,6)` | **no minimum found**; the bound is still climbing | **Yes**, and nothing eliminates it. This *is* the `unknown-at-target` case |

**Two consequences, both binding.** First, **price the staircase from target-mode runs only** — the numbers
above mix a primary decision with a secondary that sometimes enumerates, so they overstate what a ladder
rung costs. The target-mode figure is the *primary* alone: **211 s median** on the certify-no branch
(against the 238 s mean of primary + secondary), so the ladder is ~12% cheaper than the table suggests.
Second, tail A is **designed out** by a choice already made for other reasons, which leaves the
wall-and-three-state discipline (§2.4) carrying the *whole* tail risk by itself — so it is a **soundness
requirement, not reporting hygiene**.

### 1.4b — The subsystem that actually scales, and it is not the solver

**Phase C §R2 measured the split, and it overturns every cost argument made from ask counts:** the SAT
oracle is **27%** of a joint run; the **per-iteration minimum-hitting-set solve is the rest**, and it grew
**25–40×** while the correction-set family grew only **4×**.

**So a union run's budget cannot be forecast by counting colouring asks.** The gap drives the size of the
correction-set family, the family drives the hitting-set solve, and that step is superlinear in a way
nothing here has characterised. Two consequences, both binding on this plan:

1. **The ladder's per-rung cost is UNPRICED, and the ladder is the instrument that prices it.** Any figure
   in §2.3 above the measured range is a forecast carrying this caveat, not a budget.
2. **Every phase F run records the subsystem split** — CPU in the oracle against CPU in the hitting-set
   solve, and the correction-set count at close. Without that column the next planner repeats this mistake.

**One real data point above the map's range**, and it is encouraging: the `A451` stage at **gap 76** closed
in **638 CPU s** — and that figure *includes* enumerating a 3,264-member level, which target mode skips. So
it **overestimates** the target-mode cost at that gap.

**The honest limit of the extrapolation:** flatness is measured only to 24 added vertices, at gaps up to 62,
and all 89 runs had the *same* answer. The top of the ladder is a ~1,786-vertex stage at a gap near 1,400.
The ladder is written as **the measurement of where it bends**, not as a route that assumes it does not.

### 1.5 — The four jobs running now, and what each decides for phase F

**Do not kill, signal, or tidy any of them** (§8). An idle owning agent beside a running job is healthy.

| job | state at planning time | what it decides for F |
|---|---|---|
| `parts_diag.py hismove` (PID 2935375) | 53 min in, `data/m62/m63-his-move.json` not yet written | **the gate.** Runs his own four orbits as *one* set-valued candidate through the same `sweep_candidate`. `reduced` calibrates the whole ladder at the one known positive; anything else means our apparatus does not reproduce his step and **every negative on this half, the 89-map included, becomes a fact about our pipeline** |
| the two joint reductions (PIDs 2668916, 2672557) | **STOPPED by the product owner, 2026-09-11**, after bracketing C4a at **504 ≤ \|M\| ≤ 509** and C4b at 500 ≤ \|M\| ≤ 577 (phase C §R2, commit `b683821`) | the route is closed (§2.2). Its finding survives: the 576 atoms split **423 forced / 153 free**, every non-singleton correction set lies in the free part, the record keeps **85** of the 153, and **≥ 80 are provably needed**. Two cores returned to the pool |
| the 374-level enumeration (`m63-D1b`, PID 2787457) | past its optimum, `w* = 373`, **17,215 minima** and still enumerating, 0 undecided | needed only *after* a success (for the level and for FS35-1); **no F run needs it** |
| two small-half single-orbit probes | 11 of 14 records on disk, 2 running, all inert at 136 | completes the small-half singles census |

### 1.6 — Five rules that cost phase D real time

1. **Take edges from the assembled stage, never from a relation on the base** (three agents, three faults,
   one afternoon).
2. **The shared centre is in every published minimum and is never an atom** — drop it when mapping a
   published vertex list to atoms, and check that what you dropped is exactly the fixed set.
3. **The transfer lattice:** a decided ask travels both ways; a refusing selection and non-criticality
   travel **up**; criticality and correction sets travel **down only**.
4. **Anything chosen by a rule that reads `A` changes meaning when `A` grows** (§1.2).
5. **An optimisation correct about *cost* can be silently wrong about *meaning*** — five instances in phase
   D, three of them checks printing confident, benign answers while measuring nothing.

---

## §2 — The programme, ordered and costed

### 2.1 — Disposition of `§S.4`'s phase F menu, item by item

*The menu was written at phase C planning time and amended once. **No item on it is a multi-orbit move** —
the one move with a demonstrated positive behind it. That is the gap this programme fills.*

| item | disposition | reason |
|---|---|---|
| **(a)** the rule-driven loop on the joint level set | **DROPPED with the joint route** (§2.2), runs stopped | freezing one half already yields a vertex-critical object, joint reduction is far slower, and nobody can prove joint beats frozen-companion; absent that proof, slower is worse. Independently it would have needed an *exhausted* joint level — a capped level's union is a sample, not a state variable |
| **(b)** larger joint accumulators (all three subtypes) | **STRUCK, on two independent grounds** | its `A166` part is dominated by the joint runs and bounded below by their 504 floor; and the rest of it names **`A172 = v172e804` (S M6B) and `A167 = v167e772` (S M6C), which are phase E's held-out rows** (§8). *The part that is not dominated is the part that is not allowed.* Independently, both-halves-free is the cost explosion, so a bigger joint is the worst cost profile on the menu |
| **(c)** S against one L minimum per profile class; L against the 8 S classes | **STRUCK — and now by a proved floor, not only by domination** | every `(L-minimum, S-selection)` pairing it would try is a selection of the joint stage (the 374-minima are subsets of `A412`, `S136 ⊆ g⁻¹(A166)`, and at most two relative frames exist, both running). C4a has now **proved `\|M\| ≥ 504`** there, so **no (c) outcome can beat 504** — the item's entire upside is five vertices, and it is five vertices the running jobs are already searching for. *No derivation kills it on its merits* — different 374-minima do present different cross-edge structure to the small half — but a proved floor plus domination is more than enough |
| **(d)** other connection orbits at `ρ₁₅` | **MERGED into F1**, after a solver-free containment check (F0.3) | adding edges at a fixed vertex set can only preserve refusal, so a stage carrying **all five** of M62 §R20's connection orbits dominates every subtype including his (he uses 2 of 5, 24 off-centre cross edges of a possible 66). If the other three bring new *vertices*, that is exactly what the union ladder adds anyway |
| **(e)** the loop continued past his stopping point from a larger reserve | **SUBSUMED by F1** | "propose as much as you can afford to reduce" **is** the union ladder; the ladder is its systematic form with a completeness claim attached |
| **(f)** symmetric seeds from the rung lattice | **DROPPED** | two reasons: a rung is a subgroup of `Aut(A)` and `Aut(A)` moves when `A` grows, so **only rung 1 is safe under expansion** (§O2); and the closure gap says the symmetric minimum is strictly worse (624 / 576 / 558 at symmetry 24 / 6 / 3 against 509). Now that rung 1 is directly enumerable, a symmetric seed is a speed device for a search we no longer run that way |
| **(g)** his negative on the disk radius | **radius half already struck**; **base-graph half → milestone G** | zero orbits outside his `r = 2` disk are admissible under any reading, and all 26 shoulder candidates were inert, so the question is closed at the object level as well as by the filter argument. `⊕ⁿHᵐ` variants are milestone G by ruling |

### 2.2 — The joint route: closed, with its finding kept

**The runs are stopped and the route is dropped** (product owner, 2026-09-11). The argument is short and it
is about method, not about the bracket: **freezing one half already produces a vertex-critical object**,
joint reduction is **far slower**, and **nobody can prove that joint reduction beats frozen-companion
reduction**. Absent that proof, slower is simply worse. So menu items (a) and (c) are gone along with
everything downstream of *"if C4 read 509"*.

**What survives as a finding, and it is worth keeping.** Over his two accumulators the joint question is a
minimum hitting set over **153 free atoms** (the other 423 of 576 are forced — present in every refusing
selection by downward closure — and every non-singleton correction set lies inside the free part). The
record keeps **85** of those 153, and C4a proved **at least 80 are needed**. So:

> **504 ≤ |M| ≤ 509 over Parts's own two accumulators** — re-selecting from his material is worth at most
> five vertices, and possibly none.

**And one durable rule, worth more than the bracket** (the product owner's, generalised from this case):
*whether an object is ours is not decided by whose inputs produced it, but by whether it is **contained in
his answer**.* His 509 is **vertex-critical** — 508 critical atoms, 0 droppable, every single-vertex
deletion colourable — so a 504-vertex refusing selection **cannot be a subgraph of it** and would have been
a record. The 2,279-edge object was the opposite case: his exact vertex set with his edges removed, against
a gap he and de Grey had announced in print. **Apply that test to the next case rather than re-litigating
provenance.**

**What the bracket does not license:** 504 is a floor for that stage in that frame only. It says nothing
about expansions, other frames, other rungs, the small half — or any other base.

### 2.3 — The ordered programme

*Ordered by expected value per compute hour. One heavy job at a time; **nothing launches without the product
owner's go-ahead** (§8). Costs are forecasts from §1.4's measured rates unless marked measured.*

| # | experiment | what it asks | cost forecast | rank rationale |
|---|---|---|---|---|
| **F0** | the gate: four zero-compute items | — | minutes, no solver | must precede everything |
| **F1** | **the union ladder** on the large half | is there *any* expansion of `A412` by admissible orbits reaching 373 vertices? | 6 rungs; 4–20 min each while flat, unknown once it bends; **1–8 CPU h** | the spine: O(log) runs against O(n²), and each rung is a complete answer over 2^k subsets |
| **F2** | **the covering design**, only if F1 bends below k = 62 | close every *pair* (and every subset inside a block) at the largest affordable block size | 5–68 runs at the F1 rate: **0.4–5 CPU h** | restores completeness for pairs when the top of the ladder is unaffordable |
| **F3** | the small half's **union run** | same question on the S side, one run instead of the 112 queued pair runs | **~15 min**, plus a committed producer | dominates 112 runs; strictly stronger; see §2.4 |
| **F4** | the **maximal-connection stage** | does a stage carrying all five connection orbits reach 373? | 1 run, **~10 min** | merges (d); answers his published open question about subtypes at the object level |
| **F5** | **the input interface** (§2.6) | what must the loop be given before it can accept a **new base or a new rotation** as input? | 1–2 engineer-days; minutes of compute | **the phase's handoff**, and what makes the rotation/base census worth running |
| ~~F6, F7~~ | ~~the joint finish, the joint expansion (a), larger joint accumulators (b)~~ | — | — | **dropped with the joint route** (§2.2) |

**Total for F0–F4: about 2–14 CPU hours** — carrying §1.4b's caveat that rungs above gap 76 are unpriced —
against 126 CPU hours for the pair sweep those four replace.

### 2.3b — Why the ladder is method rather than a squeeze on his object

*This subsection used to rank the joint finish against multi-orbit expansion. The product owner closed the
joint route (§2.2) and re-aimed the phase (§2.0), so the ranking is moot; what replaces it is the reason
the ladder survives the re-aim unchanged.*

**A new base has no accumulator.** Parts's loop has one state variable, `A = ⋃{M}`, the union of every
minimum at the current size — and on a base nobody has reduced, there is no `A` to start from and no
published minimum to seed one. So the first thing the loop needs on *any* new input is a **first
accumulator**, and the only way to get one is to reduce a large arena at once.

**That is a big-Δ run, which is exactly what the ladder measures.** The union ladder is not only the
instrument that closes multi-orbit expansion on his object; **its cost curve is the admission ticket for
every new base and every new rotation** — it answers *"how large an arena can this reducer close?"*, which
is the question that decides whether a candidate rotation is workable at all. Run on his object because
that is where the answers are known; used everywhere afterwards.

**So the re-aim promotes the ladder rather than disturbing it**, and F1–F4 are unchanged from the draft
that preceded the re-aim. What the re-aim deletes is everything whose only output was a better number on
his 509.

### 2.3c — The honesty condition on anything built from his inputs

*The ranking that stood here — joint finish against multi-orbit expansion — is deleted rather than
archived: this file holds current state only, and a superseded ranking left in place is read as a live one.
§2.2 keeps the part that outlives it. What follows applies to **F1–F4 as well**, since they still run on
his base and his accumulator.*

**Binding on any write-up.** The base lattice, the rotation `ρ₁₅`, the accumulators and the reduction
algorithm are **his**. Ours is the reproduction, the completeness the union instrument buys, and whatever
new input the loop is eventually run from. **State that plainly**; the work is a real contribution and it
does not need inflating.

**The honesty condition on any write-up of a joint result** (binding): the accumulators, the rotation, the
base lattice and the reduction algorithm are all **his**. Ours is the **joint reduction** — deleting from
both halves at once where he alternated with one side frozen. That is a real improvement and it does not
need inflating.

### 2.4 — F1 in detail: the union ladder

**The ladder.** Let `U` be the admissible menu on `A412` — **62 orbits holding 1,107 absent vertices** —
and `U⁺ = U ∪ shoulder` — **88 orbits, 1,677 vertices** (computed from the map's own entries). Take the
orbits in **his decreasing admission-degree order** (a published order, so we invent nothing) and run:

```
k =  2,  4,  8, 16, 32, 62 orbits      (then k = 88 with the shoulder, if 62 closed)
```

Each rung is **one** `reduce_stage` over `A412 ∪ (first k orbits)`, at **target 372**, rung 1, pinned,
companion `S136` in the record's frame, checkpointed, with a wall.

**What each rung returns.**

- `no-selection-at-target`, 0 undecided → **every subset of those k orbits is closed.** Climb.
- `reduced` → a selection of ≤ 373 vertices exists → **an assembled 508 or better.** Stop the ladder, go to
  §5.2's escalation and then §6–§7. Then binary-search inside the block to name a minimal expansion.
- `unknown-at-target` (any undecided ask) or wall → **the ladder has bent here.** Record the rung, and go to
  F2 with `m` = the largest k that closed.

**Why the order does not weaken a negative.** A rung's negative is a complete statement about the union it
names, whatever order built it; the order decides only *which* material is closed first. Stated so a later
reader does not mistake the order for a ranking with a claim attached.

**The fallback, F2, and why it is needed.** A negative at k = 16 closes every subset *of that block*, but
says nothing about a pair whose two orbits sit in different blocks. Covering all `C(62,2) = 1,891` pairs
with blocks of size `m` needs about `62·61/(m(m−1))` runs — **68 blocks at m = 8, 16 at m = 16, 5 at
m = 32** — and each block additionally closes every triple and quad inside it. Greedy blocks are within a
few percent of optimal and the schedule is not the bottleneck; `[CoveringDesigns]`'s repository has better
ones if ever wanted.

**Why this is not a ranked search.** Nothing is sampled, so there is no ranking to score, no predictor to
grade against itself, and no random control block. That also retires the look-ahead question that phase D
left open: **freed-atom scores are not additive across orbits, and under the ladder no ranking is needed at
all.**

**Three constraints on the schedule, each from a measurement rather than a preference.**

1. **A block pays its worst member — so every block carries a wall, and an unknown block is never counted.**
   This is a **soundness requirement, not reporting hygiene**, and since tail A is designed out (§1.4) it
   now carries the entire tail risk. A walled block returns `unknown-at-target`, which under §O3 **has
   refuted nothing** — so *a covering design with an unknown block has a hole in it*, and a cover with a
   hole reported as a cover is this repository's own fail-open shape. **Any unknown block is re-covered —
   re-run split in two — or the cover is reported as incomplete with the hole named.** Every rung reports
   max and the full distribution, never the median.
2. **Before walling a slow block, read which tail it is in.** A slow run whose checkpoint already carries a
   `w_star` has found its minimum and is doing work a target-mode run does not do (tail A — it should not
   happen here, and if it does, the run is misconfigured). A slow run with `w_star` still `None` is tail B:
   the bound is climbing, and walling it produces an `unknown` that must be re-covered. **The field to read
   is `w_star` in the run's checkpoint**; the distinction costs one file read and decides whether a wall is
   harmless or leaves a hole.
3. **The cover is strength 2, and his own move was a 4-set.** A `C(62,m,2)` design guarantees every *pair*
   lies in some block and guarantees nothing about 4-subsets spanning blocks — leaving untested exactly the
   rung where the only demonstrated positive lives. Two responses, both taken: **stratify** the blocks by
   what the record already knows — keep the 17 partially-occupied orbits (5 of them invisible to a
   degree-built menu) together with the top reserve, so that material analogous to his move sits inside one
   block rather than being scattered by a design that treats the 62 orbits as exchangeable; and **say so in
   the acceptance** — the cover is complete for pairs and *silent at rung four except within blocks*.
   *(A subtlety, corrected by measurement after it was first written the other way: at `A412` **two** of
   his four orbits are complete and therefore absent from the candidate set — `(0,0,2,2)` and `(0,0,2,6)`,
   exactly as §S.2 #9 describes — while **`(0,0,0,4)` and `(0,0,6,6)` are live partial-fill candidates**,
   and both were tested singly and are inert. So the stratification is realisable over half of his own move
   here, and the other half is tested at `A403` by the `hismove` gate. The map's
   `his_move_absent_by_construction` field says all four are absent; it is wrong, and §X.2 gives the
   correction.)*

### 2.5 — F3: the small half, and the 112 pair runs that should not be run

The same argument applies to the S half, where the pair sweep is **already registered and emitted**: 112
pair candidates, `data/m62/m63-probe-pair-menu.json`. **One union run over the S half's 14 admissible
orbits dominates all 112** and additionally closes every triple and quad among them.

**A precondition, not a preference, and it is worse than "I could not find the producer."** `tools/parts_probe.py`
**is** committed and contains **zero occurrences of "pair"** — it offers only `menu`, `emit`, `emit-menu`
and `control`, so the instrument the probe plan names **demonstrably cannot have produced** the pair files.
Meanwhile **112 `m63-probe-P*.vtx` files and three pair JSONs are tracked in git**, which means the §7c
menu counts (91 / 112 / 350) are **unreproducible from committed code**.

So: either a committed producer is written **and shown to regenerate the files and the counts identically**
— the `regenerated-identical` discipline `parts_run.py` already applies — or the union run replaces them.
**The union run is cheaper than writing the producer**, which is the tidier of the two answers; but the
unreproducible counts are a defect to record either way, independently of what phase F does.

---

### 2.6 — The input interface: what the loop needs before it can accept a new base or rotation

*Promoted to a first-class deliverable by the re-aim (§2.0). **The census of rotations and bases is not
mine** — a separate planner owns it. This section is the **interface**: the thing that makes the census
worth running, because a census of inputs the loop cannot accept is a list.*

**The bootstrap problem, stated first because it is the one nobody has hit yet.** His loop's state variable
is `A = ⋃{M}` — the union of *every* minimum at the current size. On his base that came from his own
earlier iterations, and on Heule's it came from a published object. **On a new base there is neither.** So
before any expansion loop can turn over, a new input needs a **first accumulator**, and the only way to
manufacture one is to reduce a large arena at once and take the union of its level. That is a big-Δ run,
which is precisely what the ladder (F1) prices — so **F1's cost curve is the admission ticket for every new
input**, and the largest arena the reducer can close is the real gate on whether a rotation is workable.

**What a base must supply** (today `typem.Base(r)` supplies all of it for his §5.6 lattice, hard-wired):

| # | what | why the loop needs it | status for a new base |
|---|---|---|---|
| 1 | a point set with **exact** coordinates in a field where unit distance is decidable exactly | `typem.unit_edges_fast` lets floats *propose* and decides every proposal in exact arithmetic; no float may reach a verdict | the tower is `ℚ(√3,√5,√7,√11)`; a base needing a fifth radicand needs the tower extended |
| 2 | an **orbit decomposition** under a unit-distance-preserving group, with stable labels | atoms, rungs, menus and every artifact key are orbit labels | his are `(a,b,c,d)/12` tuples, **hard-wired into every M63 tool and into the pin triangle** |
| 3 | the **group action** itself, as explicit elements | rungs are subgroups; frames are group elements; `O2`'s *same rung* hypothesis is checkable only if the rung is an element list | order 24 for him; a new base has its own, possibly of different order |
| 4 | a **cross-edge law** for the rotation | which pairs `(u, ρv)` are at unit distance | `typem.CrossLaw` is already a parameter (phase C's C5); `collinear(cos θ)` is derived **only for `cos θ ∈ K`, `sin θ ∉ K`** — outside that class it is an open derivation |
| 5 | a **pin triangle** — three mutually adjacent vertices — in the base's own coordinates | the symmetry break, worth 62× on a cold ask and 31× on a logged proof | written in his coordinates today; must be found per base (a unit-distance graph always has triangles, never a `K₄`) |
| 6 | an **endpoint-radius bound** from the rotation | sizes the arena so the base is provably large enough | `8/√15` at `ρ₁₅` (M62 §R22); per-law, and meaningless until the law exists |
| 7 | a **companion**, or the admission that there is none | every cheap reduction here freezes one side; a new base may have no natural second half | the frozen-companion regime is the cheapest configuration we hold, and losing it costs ~13× per ask |

**What a rotation must supply:** items 4 and 6, plus its place in the ranking FS-30 fixes — **by radius
families, wall-breaking radicand and 6-openness, never by cross-edge count**, because maximal coupling
keeps a rotation inside `ℚ(√3,√11)` where Theorem B four-colours it.

**The controls that transfer, and the one that does not.** Transferring: the restriction identity; the pin
soundness check at rung 1; the three-state verdict with `unknown` never folded into a negative; exact
geometry on every edge; regenerated-identical artifacts. **Not transferring, and this is a fail-open risk
worth naming:** `contains-a-known-minimum` — the anchor control that fired free on all 89 map entries —
**has no known minimum on a new base**, so it silently degrades to checking nothing. Its replacements, both
required before a new input is accepted:

1. **a non-vacuity ask** — the arena, whole, refuses four colours (one ask, per rotation, on a base sized
   by item 6); without it every later negative is about an empty question;
2. **an end-of-run criticality check** — every single-vertex deletion of the returned object is
   four-colourable, which is what makes the returned object minimal in fact rather than by assertion.

**Acceptance for a new input, as a checklist:** items 1–7 supplied and fingerprinted; the cross-edge law
reproducing a known edge set on a known object (c5.1's pattern) and *differing* on a deliberately wrong
cosine (c5.3's); the non-vacuity ask passing; the first accumulator manufactured by a closed reduction, not
by a capped one (a capped level's union is a sample and may not seed a loop); and the whole run reported in
the vocabulary the milestone already fixed.

**What this section does not do:** choose the rotations or the bases. That is the census planner's, and
`data/m62/rotations-moser-r2.05.json` (412 classes, sieved on the wrong lattice's radius spectrum — audit
row H-4) is its input, not ours.

---

## §3 — The skeleton: commands, the one code change, artifacts

### 3.1 — The one piece of code phase F needs

`tools/parts_loop.py` can already *evaluate* an arbitrary candidate — `sweep_candidate` takes a `Candidate`
holding any vertex set, and `run_map` takes a candidate list — but `main()` only ever builds
`menu_candidates(...)`, one orbit per candidate. Phase F needs:

1. a **`--union k`** mode (and `--blocks <json>` for F2) building one `Candidate` from the first `k` orbits
   of the stated order, and
2. one new value in `Candidate.PROVENANCE` — `"union"` — beside the existing five.

Both are small and local. **`Candidate`'s empty-candidate guard must stay**: only the `identity` provenance
may add nothing.

**This touches no frozen artifact.** `data/m62/m63-freeze.json` freezes *the expansion rule phase E is
judged under*; `§6` of the milestone plan states that record-hunting runs *"may use any configuration"* on
one condition — **nothing F learns may edit the frozen configuration before phase E has run** (§8).

### 3.2 — The runs, as commands

```bash
# F0.1  the gate: hismove must have landed and read `reduced` (§5.1) -- no command, a read
python3 -c "import json;print(json.load(open('data/m62/m63-his-move.json'))['verdict'])"

# F0.3  (d)'s containment check, solver-free, minutes
#       are (20,0,0,4), (24,0,0,0), (16,0,6,2) already inside A412 u rho*g^-1(A166)?

# F1    one rung of the ladder (k = 2 shown); one heavy job at a time, checkpointed, announced
python3 -u tools/parts_loop.py map --A v412e2106.vtx --companion v136e564.vtx \
        --anchor v374e1860.vtx --incumbent 373 --union 2 --scoring-role record-hunt \
        --no-secondary --wall-ask 600 --jobs 1 \
        --out data/m62/m63-F1-union-k2.json \
        --prediction "P-F3: this rung closes at lower bound 373 with zero undecided asks"
```

- **`--no-secondary`**: the secondary question (*did `{M}` grow?*) is phase D's clause 2(c) instrument and
  has no bearing on a record. Skipping it saves ~12% and removes a level enumeration that a union stage
  cannot afford.
- **`--dry-run` first, always**, and send its text as the announcement.
- Every job over a minute is a process group with its **pgid taken from the live process table after
  launch**, never from the launching shell (`setsid` forks again).

### 3.3 — Artifacts, and what each must carry

One record per rung: the stage identity and fingerprint, the candidate's orbit labels, `asked_at_target`,
the bound **rendered without the word *minimum***, both ask populations with their means, the undecided
count, the correction-set census, the registered prediction, and provenance (git commit, machine, dirty
flag). Schema 2 of `parts_run.finish_record` already does all of this.

---

## §4 — Registered predictions

*Committed with this plan, before any phase F run. Each is scored in §R as **met / not met / not decided**.
Confidences are the planner's; where Poros differs, both are given.*

| id | prediction | confidence | falsifier |
|---|---|---|---|
| **P-F1** | `hismove` returns `reduced` — his own four orbits reach 374 through our `sweep_candidate` | 0.85 | any other verdict, which reclassifies every negative on this half as a fact about our pipeline |
| **P-F2** | The ladder's per-rung cost stays under 30 CPU minutes up to k = 8 | 0.60 | a k ≤ 8 rung exceeding 30 min |
| **P-F3** | The largest k that closes at target 372 lies in [4, 32] | 0.55 (Poros: [8, 32]) | k = 62 closing, or k = 2 failing |
| **P-F4** | Every rung that closes returns lower bound exactly 373 — no expansion improves | 0.75 | any `reduced` |
| **P-F5** | F1 and F2 together close the large half for expansion over the admissible menu, at this companion, frame, rung and reading | 0.65 | an improvement, or a bend so low that F2's blocks cannot cover the pairs |
| ~~**P-F6**~~ | ~~C4a closes at 508 atoms (509 vertices)~~ — **WITHDRAWN, never scored**: the runs were stopped by the product owner before either closed (§2.2), so nothing phase F does can decide it. Kept visible rather than deleted, because a prediction made unanswerable by a decision is not a prediction that failed | — | — |
| **P-F11** | **The hitting-set bottleneck is a replaceable subsystem**, not intrinsic cost: an exact minimum hitting set over 153 binaries should not need 13–18 s per iteration. *Rescoped by the re-aim — it no longer ranks the joint route, which is closed, but it governs **every large-gap run**, including the first accumulator on any new base (§2.6)* | 0.70 | the attribution finding the cost irreducible at that instance size |
| **P-F12** | Cost per ladder rung is dominated by the **hitting-set solve**, not the SAT oracle, at every rung above the measured range — so ask counts mispredict it | 0.75 | a rung whose oracle share stays near the L stage's current majority |
| **P-F13** | At least one block in any covering design at m ≥ 8 hits **tail B** — `unknown-at-target`, no minimum found — and must be re-covered | 0.50 | every block closing first time |
| **P-F14** | **Manufacturing a first accumulator on a new base costs at least as much as the largest ladder rung that closed on his** — so F1's bend point, not his published costs, is what prices a new input (§2.6) | 0.70 | a new base's first closed reduction landing materially cheaper than that rung |
| **P-F7** | The three unused connection orbits bring **new vertices**, so (d) merges into F1 rather than standing as a one-run edge-only experiment | 0.70 | a connection orbit wholly inside the two accumulators |
| **P-F8** | The S-half union run returns 136 vertices with the level unchanged, closing singles *and* pairs *and* triples on that half at once | 0.80 | anything below 136 (which is an assembled 508 — escalate) |
| **P-F9** | **Phase F produces no object below 509**; its product is a closed negative over a named enumeration plus the certification path | 0.55 | an object below 509, which is the point of the phase |
| **P-F10** | Cost per rung tracks **ask count**, not stage vertex count — a rung with more vertices but similar asks costs the same | 0.70 | a rung whose cost tracks its vertex count |

**P-F9 is stated at 0.55 deliberately.** The product owner's position is that the record is beatable and it
is a matter of implementation; the measured position is that every instrument pointed at this half has
returned zero, over complete enumerations. Both belong in the record, and the number that separates them is
where the ladder bends.

---

## §5 — Controls, and what halts a run

### 5.1 — The gate control: no ladder before `hismove` lands

Every instrument in this milestone has returned zeros, so **the set-valued apparatus must first reproduce
the one known positive.** `tools/parts_diag.py hismove` runs his own four orbits (30 vertices, from `A403`)
as a single set-valued candidate at the same incumbent through the same `sweep_candidate`:

- **`reduced` (`w* = 373`)** → the apparatus reproduces his recorded step; the ladder's design is calibrated
  and its negatives mean what they say.
- **anything else** → the apparatus does **not** reproduce his step, and every negative on this half — the
  89-candidate map included — is a fact about our pipeline. **Stop and report; do not run the ladder.**

*(It is already running; waiting costs nothing. Related evidence already on disk: `m63-trim-test.json`
records `trim-preserves-his-move`, 30 of 30, so the trim is not what defeated the frozen rule.)*

### 5.2 — Controls that must fire on every run

| control | what it plants or checks | must read |
|---|---|---|
| `contains-a-known-minimum` | the anchor `v374e1860` is inside the stage, refuses, and minus one vertex is colourable | fires free on every rung; it fired on all 89 map entries |
| `restriction-identity-holds` | the expanded stage restricted to the old material is the old stage, edge for edge | held on all 89; it is the control that once **failed on exactly this class** (1,515 edges against 2,442) |
| **`|M|` above 374** | — | **a bug by §O2, never a finding.** Halt |
| **any undecided ask under a target** | — | `unknown-at-target`; *"no improvement exists"* may not be said |
| the pin | `Stage.pin_is_sound` | at rung 1 it reads `pin-agrees-everywhere (12 checks)`. **Note the known defect:** above rung 1 it identifies pin atoms by lowest set bit and silently checks nothing. Phase F is rung 1 throughout, so it is live — but if any run ever moves off rung 1, apply §R3.9's one-line fix *and its planted control* first |
| a monitoring check | kill something on purpose and confirm the check notices | a monitoring check owes the same negative control as a correctness check |

### 5.3 — The escalation, rehearsed before it is needed

Anything reading below the incumbent gets, **within the hour**: exact-arithmetic geometry on every edge with
cross edges re-derived from the **stated** rotation law; an independent CaDiCaL refutation from a fresh
process; the negative control (the object minus one vertex must be **colourable**); and a report to the
product owner. This path was driven end to end on the record itself as a calibrated bed
(`plans/M63-probe-S-expansion.md` §6b) — refuted in 4.6 s, negative control colourable in 0.0 s.

---

## §6 — The record gate: the six legs, restated as phase F's

*Binding for any record claim (the product owner's ruling, `plans/M63-SESSION-HANDOFF-2026-09-11.md` §5).
All six held for the 2,279-edge measurement; none may be skipped because they held there.*

1. **An unpinned refutation** — plain formula, no selector variables, no symmetry breaking. *(The pin is
   sound and therefore invisible: "fresh solver" and "unpinned" are different claims, and the 62× price is
   109 seconds, once.)*
2. **A fresh process and a different solver** from the one the search used, sharing no state.
3. **Exact-arithmetic geometry**, with cross edges re-derived from the **stated rotation law**, never from
   the search's own output.
4. **A forced degree floor treated as a halt, not a finding** — every vertex critical in the 509 has degree
   ≥ 4, so `e_min ≥ 1016`; an object with a degree-3 vertex reads `edge-sweep-impossible` and stops the run.
5. **Never the word "minimum" for a greedy count.** A greedy edge pass gives an upper bound from one order;
   a critical census gives a floor. Neither is the minimum.
6. **An LRAT proof replayed by our own independently written checker, with deliberately planted faults that
   must all fire** — five plants last time, including a proof checked against a *different instance*, all
   caught.

**Plus the two derived checks from the certification route, both free:** recover the graph from the
**refuted DIMACS**, not from the search; and regenerate the formula and confirm it is **byte-identical** to
the one the solver refuted. Together they convert *"the generator says so"* into an identity the kernel
re-checks.

---

## §7 — The certification path, priced and mostly rehearsed

*`plans/M63-kernel-certification-route.md` is the measured route; it was driven on a real 509-vertex object
before the certification was cancelled, so **F's first acceptance bullet is largely discharged already** —
do not re-spend a day rehearsing it.*

**The five rules, in order of how much they save.**

1. **Pin a triangle before logging any proof you intend to keep.** Measured **31×** on this object:
   442,007,385 hint entries unpinned against 14,251,921 pinned; 3.7 GB and 1,250 solver seconds against
   112 MB and 11 seconds. A unit-distance graph always has triangles and never a `K₄`, so three pinned
   vertices is the ceiling.
2. **Census the proof before emitting.** Hint entries are the kernel's bill, not file size or step count.
3. **Do not hunt for a solver configuration.** 39 runs over 16 triangles × 4 configurations spanned 13.9×,
   but the best was only **4.6%** under the first triangle tried. Pin first, race briefly, expect nothing.
4. **Price the table, not just the hints** — 2.12 ms per hint at a 183k-clause table here, against the
   emitter's hardcoded 1.35 ms, so its projection reads **1.6× optimistic**.
5. **Expect the geometry to be minutes and the refutation to be hours.**

**The shape, mirroring `Proofs/HadwigerNelson/Instances/Heule510.lean`:**

```
Instances/<Name>.lean            hand-written: guards, negative control, geometry claims
Instances/<Name>/Table,Edges     tools/emit_cert.py   --chunk <n> --per-module 2
Instances/<Name>/Diffs,Valid     tools/emit_diffs.py  (the packed difference witness)
Instances/<Name>/Cnf/            tools/emit_mask.py   --segments <n> --table-modules <n>
Instances/<Name>/Bound.lean      hand-written: the pinned-triangle gadget, χ(ℝ²) ≥ 5
```

**Measured on a 509-vertex object at 2,279 edges:** 9,113,753 hint entries, 468 modules, 81.3 MB of
generated source, **5.36 CPU hours** of kernel time, and **one segment genuinely kernel-checked** (39.6 CPU
s, 8.90 GB peak). **Memory sets the build width, not time:** at 8.9 GB per segment the width is 4–8 on the
125 GB desktop, so the wall clock is 40–80 minutes. Build **only** through `./scripts/build.sh`.

**The geometry is free.** The object sits in the existing `ℚ(√3,√5,√7,√11)` tower with the `√7` slots
identically zero; at denominator 96 all sixteen leaves are integers, and the L/S coordinate formulas are
recorded in closed form in the route file. 36 distinct edge differences for 2,279 edges.

**The gate at the end:** `#print axioms` reads exactly `[propext, Classical.choice, Quot.sound]` — **no
`native_decide`** — `./scripts/vacuity.sh` green, and the final statement read aloud against the informal
claim.

---

## §8 — What phase F must NOT do

- **Never kill, signal, or clean up any process on this machine**, whatever it looks like. Six heavy jobs
  are running; some have idle owning agents, which is the normal healthy state, and killing the owner can
  take the job down. If a job looks stuck or in the way, **tell the product owner and let him decide**.
- **Launch nothing without the product owner's go-ahead.** The box is already over the house limit of one
  heavy job. Worker counts in §2 are forecasts, not authorisations.
- **Do not touch phase E's held-out list.** `plans/M63-parts-reproduction.md` §S.4 phase E holds: L M6B 374
  at rung 2, L M6C 374, S M6B, S M6C, the 8/3 mono-pair, the √3 triple. **Menu items (b) and part of (d)
  would reduce his M6B and M6C accumulators and thereby spend those rows**, the way phase C spent the M6B
  375 row. **F touches no object on E's held-out list without the product owner re-authorising it in
  writing**, and any row so spent is marked SPENT in the audit.
- **Do not edit the frozen configuration.** `data/m62/m63-freeze.json` is what phase E is judged under;
  F may use any configuration it likes but may not write back into that file before E has run.
- **Do not run at any rung but 1** without re-deriving §O2's *same rung* hypothesis and fixing the
  `pin_is_sound` defect first.
- **Do not spend compute thinning his 509.** Ruled: a measurement, not a product. If a *new* object of ours
  reaches 509 vertices, its edge minimisation is then part of *its* record claim.
- **Do not call a capped or walled run a negative**, and never render a targeted bound with the word
  *minimum*.
- **Do not report "no smaller object exists."** See §9's acceptance sentence.

---

## §9 — Decisions, each in four parts

| # | the choice | the alternative weighed | why this one won | confidence |
|---|---|---|---|---|
| 1 | **A ladder on union size** — one run per rung, each closing every subset of the union it names | The ranked pair sweep: 1,891 runs, 126 CPU hours, ordered by a look-ahead score | Monotonicity (§O2) makes the union run *strictly stronger* — it closes triples and quads too — at O(log) runs against O(n²). The pair sweep would also need a ranking, and freed-atom scores are not additive across orbits, so the ranking would have been unsound as well as unnecessary | **high** — the lemma is proved in three places; what is uncertain is cost, not soundness |
| 2 | **A covering design as the fallback**, at the largest block size that closed | Stop at the ladder's last closing rung and report that | A ladder negative at k leaves cross-block pairs unanswered; a covering design closes every pair for 5–68 runs. Without it the phase's negative has a hole exactly where his own four-orbit move lives | **medium** — if the ladder closes at k = 62 the fallback is never needed |
| 3 | **Strike the companion sweep (c)** | Run it as 8–20 cheap reductions | It is *already being computed*: every pairing it would try is a selection of the joint stage, both relative frames are running, and the joint minimum is ≤ every outcome it could produce | **high** on domination; **medium** that the joint runs will close |
| 4 | **Ask at a target, never for a level** | Full reductions returning `{M}` | §O3 gives a sound one-sided bound with no level; a union stage's level at 374 could be astronomically large and is never needed until a run succeeds | **high** |
| 5 | **Rung 1 throughout** | Use the rung lattice to shrink the search | A rung is a subgroup of `Aut(A)` and `Aut(A)` moves when `A` grows, so §O2's monotonicity — the plan's foundation — holds only at rung 1 under expansion. The known `pin_is_sound` defect is also inert only at rung 1 | **high** |
| 6 | **Replace the S half's 112 pair runs with one union run** | Run the 112 as registered | One run dominates all 112 and closes triples besides; and the 112 emitted files have no committed producer, so running them puts an uncommitted generator on the record path | **high** on the mathematics; **medium** on the process — the product owner may prefer the registered sweep to complete as registered |
| 7 | **No ladder run before `hismove` lands** | Start the ladder now; the calibration is a nicety | Every instrument here has returned zeros; a negative from an uncalibrated set-valued apparatus is worth nothing, and the calibration is already running. Waiting costs zero | **high** |
| 8 | **Target = 372 atoms**, spelled out as atoms/vertices/assembled everywhere | Inherit "373" from the advisory note | Off-by-one here silently asks a question we already know the answer to. The map's own entries fix the convention | **high** — checked against the artifact |
| 9 | **Phase F's menu uses the same admission reading as the freeze** | Recompute under the cross-edge reading | Phase D §R3.3's census shows readings (b) and (c) give **identical** menus on `A412` — 57 reserve, 62 menu, 26 shoulder each. The distinction is a small-half phenomenon; recomputing buys nothing here | **medium-high** — read off a table in the phase D record, not re-derived |
| 10 | **The phase is re-aimed: its product is the reproduced loop run from inputs he did not use, and the input interface (§2.6) is a deliverable rather than someone else's later problem** | Keep optimising his specific object — the draft this plan replaced ranked a joint finish worth at most five vertices against multi-orbit expansion | **The product owner's, 2026-09-11, and it is his correction to make**: shrinks are context-dependent, so the goal is to reproduce the *method* well enough to find graphs he never reached. Squeezing his accumulators harder is a footnote however it comes out. The joint route is dropped outright — freezing one half already yields a vertex-critical object, joint is far slower, and nobody can prove joint beats frozen-companion | **high** as a direction; **medium** that §2.6's seven interface items are complete — the first new base will find what item 2 (hard-wired orbit labels) really costs |
| 10b | **The union ladder survives the re-aim unchanged and becomes the spine** | Re-plan the phase from scratch around new inputs | The ladder is *method*: it closes multi-orbit expansion on his object **and** its cost curve is what prices manufacturing a first accumulator on any new base, where no accumulator exists (§2.3b). One instrument, both jobs | **high** |
| 11 | **A 504-vertex minimum over his accumulators would be a record**, with no provenance condition | Treat it as a measurement, like the 2,279-edge object | **Settled by the product owner, 2026-09-11**, on a test worth carrying: the question is not whose inputs were used but whether the object is *contained in his answer*. His 509 is vertex-critical, so a 504 cannot be a subgraph of it; the 2,279-edge object was his exact vertex set against a gap he had announced. The write-up states plainly that the accumulators, rotation, lattice and algorithm are his and the joint reduction is ours | **high** — a ruling, with its reasoning recorded so the next case can be judged the same way |

---

## §10 — What I could not settle, and what it would take

| # | open item | why it is open | what settles it | default if nobody acts |
|---|---|---|---|---|
| 1 | **Where the ladder bends** | flatness is measured only to 24 added vertices; the top rung is a ~1,786-vertex stage with a gap near 1,400 atoms, far outside anything priced | F1 itself — the ladder *is* the measurement | the engineer climbs until a rung fails and reports the rung |
| 2 | **Whether the hitting-set solve is a replaceable subsystem** | it is 73% of runtime over only 153 binaries; a dedicated agent is measuring the attribution | that measurement | it no longer ranks anything (the joint route is closed), but it **prices every new base** (§2.6, P-F14). I expect *replaceable*, 0.70 |
| 2b | ~~Phase C's verdict~~ | **closed as an open item**: the runs were stopped, the bracket 504 ≤ \|M\| ≤ 509 is final as a *finding* (§2.2) | — | nothing waits on it |
| 3 | **`hismove`'s verdict** | still running | the run | **the ladder does not start** |
| 4 | **Whether the product owner wants the S half's 112 pair runs completed as registered** | it is a process question about a registered experiment, not a mathematical one | his call | F3's union run supersedes them |
| 5 | **Whether F may ever spend one of phase E's held-out rows** | no longer live for the menu — (b) is struck and the joint route is closed — but it binds any *new* experiment that would reduce `v172e804`, `v167e772`, `v406e2076`, `v400e2034`, `v375e1862` or `v238e1131` | his call, in writing, with the row marked SPENT in the audit as phase C did for the M6B 375 row | **no F run touches them** |
| 6 | **Worker counts and launch cadence** | six heavy jobs already run against a house limit of one | his call | nothing launches |
| 7 | **Whether a bent ladder should be pushed with a stronger reducer** | if the union stage dies at k = 8, the interesting question becomes *why*, and that is a reducer-engineering question (his §5.11 kept `|W|` near 1,000 for the same reason) | a separate scoped decision after F1 | report the bend and stop |

---

## §A — The acceptance sentence, written before the runs

*Poros's card 5: a union negative is bounded by four parameters at once, so the sentence it licenses is
written now, not after the result is in hand.*

> **What a completed F1 + F2 negative licenses, verbatim:** *For the large half at **rung 1**, against the
> frozen companion **`S136` in the record's frame**, over the admission menu computed on **`A412`** under
> reading (b) (= reading (c) on this half) together with its degree-3 shoulder: no expansion by any subset
> of those orbits yields a refusing selection of 373 vertices or fewer. Hence no object of 508 vertices or
> fewer arises from this accumulator, this companion, this frame, this rung and this menu.*

**What it does not license:** *"the large half is at its floor"*, *"no smaller 5-chromatic unit-distance
graph exists"*, or any statement about other rotations, other bases, other subtypes, or the small half.
A negative measures its enumeration (`G21`), and this one's enumeration is named in the sentence.

---

## §X — Proposed replacement text for `plans/M63-parts-reproduction.md` §S.4, phase F block

*The planner may not edit that file. This is the exact text, ready to paste, replacing the phase F block
(*"**Phase F — beat 509.**" through its *Cost:* line). Requested by the product owner.*

> **Phase F — beat 509.** Purpose: S.1 #4. *Subplan: `plans/M63-phaseF-beat-509.md`.*
> Acceptance:
> - [ ] The certification path, rehearsed on the first candidate: exact unit distances over the
>   `ℚ(√3,√5,√7,√11)` tower, an LRAT proof checked, and a Lean kernel certificate on the pattern of
>   `Proofs/HadwigerNelson/Instances/Heule510.lean`, `#print axioms` exactly the standard three; the
>   construction stated so a reader can rebuild it. **Largely discharged already**: the route is measured
>   end to end and one segment was genuinely kernel-checked
>   (`plans/M63-kernel-certification-route.md`) — pin a triangle before logging any proof (31×).
> - [ ] Headline or secondary record certified — or the menu below exhausted and reported with its
>   enumerations, under the acceptance sentence of the subplan's §A.
> - [ ] **The instrument is a union ladder, not a pair sweep.** Expansion is monotone (phase D §O2), so one
>   reduction over a union of admissible orbits at target 372 atoms decides every subset of that union at
>   once. Ladder on k = 2, 4, 8, 16, 32, 62 orbits; a covering design at the largest affordable block size
>   closes the cross-block pairs if the ladder bends. **No ladder run launches before the `hismove`
>   calibration lands `reduced`.**
> - [ ] Each experiment's prediction and cost committed before it runs (subplan §4). Menu disposition:
>   **(a) and (c) DROPPED with the joint route** — its runs were stopped 2026-09-11, because freezing one
>   half already yields a vertex-critical object, joint reduction is far slower, and nobody can prove joint
>   beats frozen-companion; **(b) STRUCK** — where it is not dominated it names `v172e804` and `v167e772`,
>   which are phase E's held-out rows; **(d)** merged into the ladder after a solver-free containment
>   check; **(e)** subsumed by the ladder, which is its systematic form; **(f) dropped** — only rung 1 is
>   immune to `Aut(A)` moving under expansion, and the closure gap says the symmetric minimum is strictly
>   worse; **(g)** radius half already struck, base-graph half is milestone G.
> - [ ] **The input interface** (subplan §2.6) — what the loop must be given before it can accept a new
>   base or a new rotation: exact coordinates in a decidable field, an orbit decomposition with stable
>   labels, the group as explicit elements, a cross-edge law, a pin triangle, an endpoint-radius bound, and
>   a companion or the admission that there is none. **Plus the bootstrap:** a new base has no accumulator,
>   so its first `A` must be manufactured by a closed reduction of a large arena — which is what the
>   ladder's cost curve prices. **And the control that does not transfer:** `contains-a-known-minimum` has
>   no known minimum on a new base and silently checks nothing; its replacements are a non-vacuity ask and
>   an end-of-run criticality check.
> - [ ] **Recorded, not pursued:** over Parts's own two accumulators the joint question is a hitting set
>   over 153 free atoms of which 80 of his 85 are provably necessary, giving **504 ≤ \|M\| ≤ 509**. Had it
>   landed below 509 it would have been a record — his 509 is vertex-critical, so such an object is not a
>   subgraph of his — which is the test to apply to the next case.
> - [ ] The small half: one union run over its admissible orbits, which dominates the 112 registered pair
>   runs and closes triples besides; a committed producer is a precondition for consuming the emitted pair
>   files.
> - [ ] The six-leg verification chain (subplan §6) on any record claim, with the two derived checks —
>   recover the graph from the refuted DIMACS, and regenerate the formula byte-identically.
>
> *Cost:* F0–F4 about 2–14 CPU hours, one heavy job at a time; a certificate about a day, memory-bound at
> 8.9 GB per segment. Open-ended only if the ladder bends early.

---

## §X.2 — A correction owed to `data/m62/m63-map-A412.json` (a one-line field, not a re-run)

The map carries a field `his_move_absent_by_construction` reading *"this accumulator already CONTAINS his
own recorded expansion, so the four orbits his move used are not in the candidate set at all."*

**Two of the four are in the candidate set**, and the map's own entries prove it: `(0,0,0,4):3` and
`(0,0,6,6):6`, both provenance `partial-fill`, adding 3 and 6 vertices, both with verdict `no` and no level
growth. Only `(0,0,2,2)` and `(0,0,2,6)` are genuinely absent, being complete in `A412` — which is exactly
what `§S.2` #9 says: `A412` adds *"the other half of `(0,0,2,2)`"* and *"the other half of the auxiliary
orbit `(0,0,2,6)`"*, and claims nothing about the other pair. **The measurement and the milestone's own
record agree; only the map's summary sentence overstates.**

**Why it matters enough to fix:** a reader following that field concludes his move's material is untestable
at `A412`, when two-thirds of it sits in the candidate set and **was tested singly and came back inert** —
which is a sharper statement than the map's headline and is evidence for the combination reading.

**Proposed replacement text for the field:**

> `"A412 already contains the other halves of (0,0,2,2) and (0,0,2,6), so those two of the four orbits his
> recorded move used are complete here and are not candidates. The other two, (0,0,0,4) and (0,0,6,6), ARE
> live partial-fill candidates in this map (adding 3 and 6 vertices) and both are inert. His move as a SET
> is tested at A403, not here."`

*(Found by the advisor, verified independently here against the entries. A method note worth keeping: the
first check for these labels returned zero because the orbit keys carry spaces — `'(0, 0, 0, 4)'` — while
entry names do not. A zero from a string-keyed lookup deserves one confirming probe before it is believed.)*

---

## §P — Poros's cards, and their fates

*Advisory record: `plans/POROS-2026-09-11-m63-phaseF.md`, committed by path alongside this plan.*

| card | substance | fate |
|---|---|---|
| **1** | the union dominates the pair ladder; ladder on union size, not subset size | **ADOPTED as the plan's spine** (§2.4), with two changes: the target is **372**, not 373 (its card says 373 three times — an off-by-one that would have asked a question we already know the answer to); and a **covering design fallback** is added for cross-block pairs, which its ladder alone leaves open |
| **2** | the companion sweep is already inside the two joint runs | **ADOPTED, and then superseded in the same direction** — item (c) was struck by domination and by C4a's 504 floor, and is now dropped outright with the joint route (§2.2). Zero cores spent on it either way |
| **3** | the frozen admission reading is blind to cross-edge material, so F should recompute the menu | **CORRECTED, and scored as answered by existing measurement.** Phase D §R3.3's census gives *identical* menus under readings (b) and (c) on `A412` — 57 / 62 / 26 each. The promotion effect it cites is real but is a **small-half** phenomenon. Its own falsifier (*"the two readings return the same menu on A412"*) is met on disk, so no run is needed; the plan records the fact instead |
| **4** | (d) is not a menu; the maximal-connection stage dominates every subtype | **ADOPTED**, with the containment check as F0.3; merged into F1 if the connection orbits bring new vertices (P-F7, 0.70) |
| **5** | fix the acceptance wording before the runs | **ADOPTED** — §A, written before anything runs, naming all four parameters |
| its `hismove` gate | no union ladder before the calibration lands | **ADOPTED as a hard precondition**, not a courtesy (§5.1) |
| its two red-capable controls | `|M|` above 374 is a bug; a target failure with an undecided ask is `unknown-at-target` | **ADOPTED** (§5.2) |
| its cost inventory | cost is asks × per-ask cost, not stage size; both-halves-free is the explosion | **ADOPTED** (§1.4), and independently corroborated by the flat curve extracted from the 89 map entries |

| **red pen 1** | the cost basis is a median, and a block pays its worst member (p50 185 / p90 269 / max 418 s; two small-half stragglers past 250 CPU minutes) | **ADOPTED** (§1.4, §2.4 constraint 1): every rung reports max and distribution, every block carries a wall, and an `unknown` block is a **hole in the cover**, re-run split |
| **red pen 2** | a strength-2 cover is silent at rung four, where the only demonstrated positive lives | **ADOPTED** (§2.4 constraint 3): blocks stratified by the partially-occupied orbits plus the top reserve, and the acceptance says the cover is complete for pairs and silent at rung four except within blocks. *With one correction:* on `A412` his own four orbits are already present, so the stratification concerns analogous material; his move is tested at `A403` by the `hismove` gate |
| **red pen 3** | the joint bracket changes what the joint route is *for*; profile the hitting-set step before conceding it is expensive | **ADOPTED, then overtaken — and it is the card that mattered most.** It first became the plan's ordering rule; its provenance question, put to the product owner, returned the **containment test** (a 504 would have been a record, because his 509 is vertex-critical); and that exchange surfaced the deeper problem, after which the owner **closed the joint route and re-aimed the phase** (§2.0, §2.2). The hitting-set profiling survives, rescoped to every large-gap run (P-F11) |
| its held-out reading | (b) names `v172e804` and `v167e772`, both on E's list; those are E's *reduction* rows, not its required *loop* row | **ADOPTED** — (b) struck outright (§2.1) |
| its producer finding | `parts_probe.py` is committed and contains zero occurrences of "pair"; 112 files and three JSONs are tracked; the §7c counts are unreproducible | **ADOPTED and strengthened** (§2.5): a producer must regenerate files *and counts* identically |
| **its tail split** | the heavy tail is two phenomena: tail A (level enumeration after the minimum is known) **cannot occur in target mode**, tail B (no minimum found) is untouched and is exactly the `unknown-at-target` case | **ADOPTED** (§1.4, §2.4): the staircase is priced from **target-mode runs only** (211 s median, not 238), and since tail A is designed out, the wall-and-re-cover rule now carries the whole tail risk and is stated as a **soundness requirement** |
| **its map-field correction** | two of his four move-orbits are live candidates at `A412` and were tested singly | **ADOPTED after independent verification** (§0 item 2, §2.4, §X.2). It **overturned my own parenthetical** and upgraded the claim: *two of the four orbits of his own successful move are individually inert* |

**Where the planner and the advisor still differ:** it puts the largest closing k in [8, 32] and I put it in
[4, 32]; it treats the covering design as unnecessary and I treat it as the fallback that keeps the negative
whole. Both are registered in §4 as P-F3 and decision 2, and the ladder settles the first.

**Corrections that ran the other way.** The advisor's card 1 stated the target as 373 three times (it is
372, §1.1) and its card 3 was killed by the very table it cited (§R3.3's readings (b) and (c) are identical
on this half). Both were accepted by the advisor without defence. *A record of who corrected whom is worth
keeping precisely because it was mutual.*
