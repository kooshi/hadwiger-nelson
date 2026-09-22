# FS-70 phase 1 — the asks: what landed

*Written 2026-09-22 by the phase-1 implementer (Opus 5), against `plans/FS70-five-over-sqrt3-sqrt5.md` §4 phase 1,
`data/fs70/records/phase-0.md`, and the owner's brief and review §4. Machine: the desktop (16
physical cores / 32 threads, 125 GB). Every number names the command that produced it.*

---

## 1. Headline

**No refusal. The null is typed, and most of it is a theorem rather than a budget.**

1. **A correction had to be made before any ask.** The brief describes the `eq` pin as the *contracted* encoding;
   that is `sep`'s encoding, and following it would have inverted every verdict in the phase (§2). The plan, the
   fabric tool's own CNF names and the mathematics all agree the other way, and `fs70_ask.py` now prints
   *"UNSAT would mean: …"* before every ask and writes the conclusion into the row.
2. **The 2-unit route is dead at every radius, by derivation.** A **Kempe swap** of an additive four-colouring is
   still proper but is no longer additive, so it sees past the additive screen; and the Kempe component of the
   origin is a **sublattice**, so membership of a target in it is an exact finite computation. Five lattices —
   including **L1, the plan's own P2 bet** (Harder's fabric transposed) and **L1′, which carries the field's
   cheapest closer `δ = 4/7` at chain 2** — have **every chainable target killed at every radius, by no finite
   subgraph, ever** (§4). The whole screen reduces to one rank: the escape lives only at the colour class
   `{0, 2}`, and exists exactly when a lattice's unit vectors of `φ`-value 2 fail to span it (§4.2a).
3. **What the screen leaves alive, the solver colours at every affordable size.** L2 and L3 (no additive
   colouring at all), L4a and L5 (additive but Kempe-rigid): **14 asks**, all SAT, each model read back and
   verified proper on every edge of the fabric and on the pin (§5). The slowest was 17.7 s.
4. **The null is typed by the structure instruments** (§5.2–5.3). L4a and L5 carry **periodic four-colouring
   rules** — `2Λ`- and `4Λ`-periodic colourings, lifted and verified on every edge — which is a theorem-shaped
   null in the plan's own words. L2 and L3 carry **no periodic rule at `2Λ`, `3Λ` or `4Λ`**, and the colouring
   L2's control produced is a function of no residue at any prime ≤ 7 and has no period (best agreement 0.874 of
   247 candidates). And the periodic and additive instruments are **structurally blind** on exactly these
   targets: a chainable `δ` is chainable because `1/δ` is a short sum of unit vectors, which puts `δ` deep inside
   `4Λ`, where every function of `Λ/4Λ` is silent. The Kempe swap is the first instrument that is not one.
5. **The shape ceiling over a biquadratic field was reached and measured.** G65 says step up in degree; here the
   step has an end. The k=4 word ball gives average degree **15.4–15.8 at ~1.86 M points**, there is **no denser
   subgraph inside it** (L5's 14-core is empty; the 12-core is 1,377,541 points at degree 16.08), and a
   Minkowski ball is unaffordable at any useful degree — with covolumes of 2·10⁻⁸ to 2·10⁻⁵ and **four** real
   embeddings, degree 12 costs 10⁵–10¹⁰ million points. FS-61's `R⁴` is this field's `R⁸`.

**So the conjecture's prediction at ℚ(√3,√5) stays unmet, and the reason is now specific rather than general:**
it is not that the field resists, it is that the fabric this milestone was designed around — 2-unit fabric, the
transposition of Harder's recipe — provably cannot carry the pair, and the fabric that is not ruled out costs
`R⁸` to make dense.

---

## 2. The correction that had to be made before any ask: `eq` and `sep` are named by their CONCLUSION

The owner's brief says: *"`eq (A, B)` — the pair **contracted** into one vertex …; `sep (A, B)` — `A = 0, B = 1`."*
That is the wrong way round, and the brief itself names the reason it matters (*"they differ by one literal and a
wrong one reads as a jackpot"*). The plan's §1.2 — *"forced-equal ask at `(A, B)`: `A = 0, B = 1`; virtual-edge ask:
`A = B = 0`"* — and `fs70_fabric.write_shape`, whose `eq_*` CNF pins `[(i0, 0), (jt, 1)]` and whose `sep_*` CNF pins
`[(i0, 0), (jt, 0)]`, both name a pin by what its **refutation** proves, not by the constraint it carries:

| pin | the formula imposes | UNSAT means | SAT means |
|---|---|---|---|
| `control` | a unit triangle pinned 0, 1, 2 | the fabric itself is 5-chromatic — **halt and verify** | a 4-colouring exists |
| **`forces δ`** (`eq`) | `c(0) ≠ c(δ)`: the pair joined by an edge, a common neighbour pinned to a third colour | **Forces**: every proper 4-colouring gives `0` and `δ` one colour — the milestone's target | some 4-colouring separates them |
| **`separated δ`** (`sep`) | `c(0) = c(δ)`: the pair **contracted** | **Separated**: a virtual edge at `δ` (Haugland's shape) | some 4-colouring joins them |

The mathematics decides it: the chain theorem (G55) consumes a **forced-equal** pair, and `Λ_forced` — the screen
that says which targets are worth asking — is by construction the set of `δ` that *every* additive colouring makes
monochromatic, which is the screen for `forces`. Contracting the pair asks the opposite question. The brief's
target list (`eq 4/3` chain 3, `eq 4/7` chain 2, `sep √3`) is consistent with this reading throughout; only its one
sentence about the encoding is inverted, and the likeliest cause is that phase 0's positive control — Haugland's
`A = B` ask — really is a *contracted* encoding, because his object carries a **virtual edge**, not a forced pair.

`tools/fs70_ask.py` prints `UNSAT would mean: …` before every ask and writes the conclusion into the row, so no
verdict in `asks.jsonl` can be read the wrong way round.

---

## 3. The instrument

`tools/fs70_ask.py run DIR PIN` — one ask, appended to `data/fs70/asks.jsonl` at its verdict, with an in-flight
file carrying the pid, the process group and the resume command while it runs.

**The calibration** (`python3 tools/fs70_ask.py selftest`), whose answer is known by hand both ways: **K₅ minus an
edge** — `A` and `B` non-adjacent, both joined to a triangle. Every proper 4-colouring gives the triangle three
colours and `A`, `B` the fourth, so the pair is forced equal; `forces` must refuse it and `separated` must colour
it, and the faithful twin (one triangle edge dropped) must colour both. The geometry is deliberately not
unit-distance — two plane points have at most two common unit-distance neighbours, so no unit-distance graph
contains K₅ minus an edge at all — because this calibrates the encoder and the solvers, not the fabric.

**Three plants, each refused for its named reason:**

| plant | what it breaks | how it was seen to refuse |
|---|---|---|
| `pin_swapped` | `forces` pins the pair to the *same* colour (the `separated` constraint under the `forces` name) | *"twin under forces:4/3 read UNSAT, and by hand it is SAT"* — the false-jackpot direction |
| `edges_dropped` | one edge lost from the graph | *"forced under forces:4/3 read SAT, and by hand it is UNSAT"* — a lost edge makes colouring easier, so a refusal vanishes and a null looks real |
| `sha_unchecked` | the graph asked need not be the graph recorded | *"a point moved after the file was written was accepted"* |

**A fourth plant was written and removed because it fired on nothing**, which is worth recording: under `forces`
the edge joining the pair is **redundant** — pinning `c(A) = 0` and `c(B) = 1` already says `c(A) ≠ c(B)`, and the
edge only strengthens propagation. What is not redundant is the third pin, which is sound only because `A`, `B`
and `w` really do form a triangle once the edge is added.

**Two cube engines, because the obvious one is unusable in two different ways.** PySAT's Kissat **ignores
assumptions** (it warns and carries on), so every cube would silently be solved as the whole instance — refused by
name. PySAT's CaDiCaL takes assumptions but supports neither `incr=True` nor `solve_limited`, so it can carry no
per-cube budget — reported in the row (`per_cube_budget: null`), not worked around. The default `auto` uses phase
0's proven file-based kissat pass below four million clauses and in-process CaDiCaL above it. The engine is now
constructed **in the parent**, where an error is visible: an exception inside a `multiprocessing` pool initializer
makes the pool retry it for ever with no output at all, which is how the first version of this cost twenty minutes
and looked like a hung solver.

---

## 4. The Kempe screen: the 2-unit route is dead by derivation, not at a budget

### 4.1 What it says

Phase 0's additive screen kills a target `δ` when some proper additive colouring `φ` of the lattice has
`φ(δ) ≠ 0`: that colouring separates the pair, so no graph in the lattice forces it. When *every* `φ` makes the
pair monochromatic — when `δ ∈ Λ_forced` — the additive family is silent and the plan sends the target to a
solver. **One step further is free.** A Kempe swap of an additive colouring is still proper but is no longer
additive, so it reaches outside the family:

> **The Kempe escape.** Let `φ : Λ → G` be a proper additive four-colouring of a lattice `Λ` of unit vectors
> (`φ(z) ≠ 0` for every unit vector `z ∈ Λ`), and let `δ ∈ Λ` with `φ(δ) = 0`. If the `(0, b)`-Kempe component of
> the origin in the whole lattice's unit-distance graph does not contain `δ`, then **no finite subgraph of `Λ`
> forces `0` and `δ` equal at four colours, at any radius.**
>
> *Proof.* Let `H ⊆ Λ` be finite. `φ|_H` is proper. The `(0, b)`-Kempe component of `0` inside `H` is a subset of
> the one in `Λ`, so it misses `δ`. Swapping it is a proper four-colouring of `H` (a Kempe swap always is) with
> `c(0) = b` and `c(δ) = φ(δ) = 0`, so `H` does not force the pair. ∎

**The component is a sublattice**, which is what makes the test exact and cheap. A walk inside the class
`{p : φ(p) ∈ {0, b}}` alternates the two colours, because a unit vector never has `φ = 0`; a step `0 → b` carries
`φ`-value `b` and a step `b → 0` carries `−b`; and the unit vectors are closed under negation. So the colour-`0`
points the origin reaches are exactly the additive span of `{z + w : z, w ∈ Λ ∩ U, φ(z) = b, φ(w) = −b}` — one
formula for every colour count and for the Klein group, where `−b = b`. Membership of `δ` is then a Hermite
normal form and a back-substitution.

**It was written as a search first, and the search could not work**: a subgroup is infinite whenever it is
non-trivial, so a breadth-first Kempe component never terminates. All four of L1's targets came back *"no escape
found"* at a cap of 200,000 points in 59 s each — which is exactly what a search for an infinite object looks
like, and reads like a null. The algebraic form answers the same four in **0.8 s**.

### 4.2 The controls: both outcomes reachable, both seen

* **A kill that would be FALSE must not be claimed.** At **three** colours on `ℤ[ζ₁₂]` (4 proper additive
  ℤ/3-colourings, so the screen has something to work with) the pair `(0, i√3)` **is** genuinely forced equal —
  `0, ζ₆, ζ₆²` is a unit triangle and `ζ₆ + ζ₆² = i√3` completes a second one on the edge `{ζ₆, ζ₆²}`, so the
  fourth vertex sees both of the shared edge's colours and must take the origin's. The screen reads **live**
  there. On the same lattice it kills `δ = 1` and `δ = 2` additively, so it is not simply silent.
* **The screen is not merely reporting the presence of an additive family.** In the field at four colours it
  kills every target on five lattices and leaves every target alive on two others that also have additive
  families (L4a: 144 colourings; L5: 144).
* **The kill is exhibited.** On L1's sums-of-at-most-4 ball — **478,333 points, 3,460,848 edges, average degree
  14.47** — the additive colouring is proper on all 3,460,848 edges with `c(0) = c(4/3) = 0`; its `(0,2)`-Kempe
  component of the origin is 8,385 points and does not contain `4/3`; and after the swap the colouring is
  **still proper on all 3,460,848 edges**, with `c(0) = 2` and `c(4/3) = 0`.
  (`build/fs70/L1-w4/kempe-colouring-4over3.json`.)
* **The control this phase could NOT run, named:** whether the same screen reads *live* on Harder's own lattice
  over `K = ℚ(√3,√11)` at `δ = 8/3`, where a four-colour forced pair is in print (`[Polymath2021]`; Harder,
  Polymath16 thread 1, 28 April 2018). The tool's field arithmetic is ℚ(√3,√5); that control needs ℚ(√3,√11)
  and is **owed**. It is the one test that would falsify the screen at the colour count the milestone uses.

### 4.2a The mechanism, sharper: the escape is a RANK, and it lives only at `b = 2`

Every kill the screen reports uses `b = 2` — the class `{0, 2}` of ℤ/4 — and the reason is visible in the reach
ranks (40 colourings × 3 values of `b` per lattice, `tools/fs70_ask.py`):

| lattice | reach rank at `b = 1` | at `b = 2` | at `b = 3` | escape? |
|---|---|---|---|---|
| L1 `group:u3:2` | 8 (40/40) | **4 once, 6 fourteen times**, 8 otherwise | 8 (40/40) | **yes** |
| L1′ `zeta12+u3+q7` | 8 (40/40) | **6 (40/40)** | 8 (40/40) | **yes** |
| L4b `zeta12+u3+q5+s5` | 8 (40/40) | **4 four times**, 8 otherwise | 8 (40/40) | **yes** |
| L4a `zeta12+u3+q7+s7` | 8 (40/40) | 8 (40/40) | 8 (40/40) | no |
| L5 `group:u3:2+d6` | 8 (40/40) | 8 (40/40) | 8 (40/40) | no |

At `b` odd the reach is spanned by the **pair sums** `z + w` with `φ(z) = 1`, `φ(w) = 3` — a product-sized set
that always spans. At `b = 2` it is spanned by `z + w` with both of `φ`-value 2, a far smaller set, and when
those vectors fail to span the lattice the origin is trapped in a proper sublattice and every target outside it
is free. **So the whole screen is one rank computation per additive colouring**, and the invariant that decides a
lattice is *whether its unit vectors of `φ`-value 2 span it*.

### 4.3 The verdict per lattice (`data/fs70/kempe-screen.json`)

| lattice | `g` | proper additive ℤ/4 | targets screened | live | verdict |
|---|---|---|---|---|---|
| **`group:u3:2`** (L1, Harder's shape transposed) | 60 | 1296 | 10 | **0** | **dead at every radius** |
| `zeta12+u3` | 36 | 1296 | 9 | **0** | dead at every radius |
| **`zeta12+u3+q7`** (L1′, holds `1/7`) | 60 | 1296 | 10 | **0** | dead at every radius — including `4/7`, the chain-2 target |
| **`zeta12+u3+q5+s5`** (L4b) | 180 | 336 | 14 | **0** | dead at every radius |
| `zeta12+d6` | 36 | 240 | 4 | **0** | dead at every radius |
| **`zeta12+u3+q7+s7`** (L4a) | 276 | 144 | 16 | **8** | **live** — `4/7` (chain 2), `4/3`, `4`, `8/3`, … |
| **`group:u3:2+d6`** (L5) | 108 | 144 | 10 | **8** | **live** — `4/3`, `4`, `4/9`, `8/3`, … |
| **`group:u3:2+v4`** (L2) | 540 | **0** | 120 | **120** | **live** — no additive colouring at all |
| **`group:u3:2+w4`** (L3) | 324 | **0** | 89 | **89** | **live** — no additive colouring at all |

**So the plan's P2 bet is lost by derivation, not at a budget.** P2 predicted that Harder's fabric `S₂` at sums of
≤ 4 forces `(0, 8/3)` or `(0, 4/3)`. It cannot — and neither can `S₃`, nor sums of ≤ 5, nor any other finite
subgraph of that lattice, at any radius. The same closes L1′ (where the cheapest closer in the field, `δ = 4/7`
at chain 2, lives), L4b, `zeta12+u3` and `zeta12+d6`. What survives is exactly the fabric the additive family
cannot four-colour for free: L2 and L3 (no additive colouring at all) and L4a and L5 (an additive family whose
Kempe classes reach every target).

---

## 5. The asks

Every row is in `data/fs70/asks.jsonl`, rendered by `python3 tools/fs70_ask.py status`. Every SAT model is read
back against the fabric — proper on every edge of the original graph, through the vertex map, and respecting the
pin — before its row is written; a model that fails that check is recorded as `DEFECT`, not as a verdict.

### 5.1 The four live lattices at sums of ≤ 3 (95k points, average degree 11.5)

| lattice | shape | points / edges / degree | pin | verdict | wall |
|---|---|---|---|---|---|
| **L2** `group:u3:2+v4` | word k=3 | 95,317 / 550,014 / 11.54 | control | SAT | 0.2 s |
| L2 | word k=3 | " | forces 2 | SAT | 1.0 s |
| L2 | word k=3 | " | forces 4/3 | SAT | 0.2 s |
| L2 | word k=3 | " | separated √3 | SAT | 0.2 s |
| **L3** `group:u3:2+w4` | word k=3 | 95,389 / 549,744 / 11.53 | control | SAT | 12.1 s |
| L3 | word k=3 | " | forces 2 | SAT | 3.5 s |
| L3 | word k=3 | " | forces 4/3 | SAT | 3.8 s |
| L3 | word k=3 | " | separated √3 | SAT | 3.4 s |
| **L4a** `zeta12+u3+q7+s7` | word k=3 | 94,849 / 559,536 / 11.80 | control | SAT | 3.1 s |
| L4a | word k=3 | " | **forces 4/7** (chain 2) | SAT | **17.7 s** |
| L4a | word k=3 | " | forces 4/3 | SAT | 1.9 s |
| **L5** `group:u3:2+d6` | word k=3 | 95,149 / 548,532 / 11.53 | control | SAT | 1.7 s |
| L5 | word k=3 | " | forces 4/3 | SAT | 1.8 s |

Three targets are **not in** the sums-of-≤-3 ball and the tool refused them by name with the point count rather
than skipping them silently: `2/3` on L2, `4` on L4a and L5, `4/9` on L5.

**One solver-effort signal, single-sample and recorded as such** (M41's precedent, G21): on L4a the `4/7` ask —
the cheapest closer the field has, two copies, one ρ₁₅ spindle — took **17.7 s** against 1.9 s for `4/3` and 3.1 s
for the control on the same fabric. That is a fact about one kissat run, not about the graph; it is here because
`4/7` is the target most worth a bigger shape if one is ever affordable.

### 5.1a Stepping up in degree: the k=4 word balls, and two of them answered with no solver at all

| lattice | shape | points / edges / degree | control | how |
|---|---|---|---|---|
| **L5** `group:u3:2+d6` | word k=4 | **1,864,417 / 14,424,204 / 15.47** | **SAT** | by **exhibition**: an additive colouring of the lattice, verified proper on **all 14,424,204 edges** |
| **L4a** `zeta12+u3+q7+s7` | word k=4 | **1,845,193 / 14,586,696 / 15.81** | **SAT** | by exhibition, proper on **all 14,586,696 edges** |
| **L3** `group:u3:2+w4` | word k=4 | 1,886,761 / 14,523,840 / 15.40 | — | **no additive colouring exists**, so the control is a genuine question and must go to a solver |
| **L2** `group:u3:2+v4` | word k=4 | (built; 84 generators, `g = 540`) | — | likewise |

`data/fs70/records/asks/w4-controls-by-exhibition.json`. **A theorem beats a solver here and it was reached by
noticing, not by waiting:** a kissat run on L5's 1.86 M-vertex instance had already spent 500 s without a verdict
when the argument became clear — L5 has 144 proper additive four-colourings of its *lattice*, so every subgraph
of it is four-colourable and the control is SAT before any solver is asked. The run was killed by pid and
verified by effect. *What the kill forfeits, named:* how long kissat needs on an instance of that size, which is
recorded here as ">500 s, no verdict" instead of measured.

### 5.2 The structure of the colourings (the plan's §3.6 — a null is not typed without these)

On L2's control colouring at k=3 (`tools/fs70_structure.py screen`):

* **the quotient screen** — no `Λ/pΛ` has all its classes monochromatic at any `p ∈ {2,3,4,5,6,7}`
  (0 of 175 at `2Λ`, 936 of 1257 at `3Λ`, 1392 of 3436 at `4Λ`, 41248 of 55237 at `5Λ`, 936 of 5703 at `6Λ`,
  6832 of 29449 at `7Λ`), so **the colouring is a function of no residue at any of those primes**;
* **the period screen** — 247 candidate periods with at least 20 testable pairs, and the best agreement is
  **0.874**, not 1: **no period at all**, not even an approximate one.

So the four-colourings these lattices carry are not additive, not residue-local at any small prime and not
periodic — they are free colourings, and the fabric is simply far from forcing anything at this size.

### 5.3 The periodic screen, at the lattice and at the fabric — and why it is silent where the Kempe screen is not

The imposed-quotient ask (the plan's instrument (iii)) asked on the 95k-point fabrics
(`tools/fs70_structure.py quotient`, `build/fs70/quotient-sweep.log`) splits the four live lattices in two:

| fabric | `2Λ` | `3Λ` | `4Λ` |
|---|---|---|---|
| **L2** `group:u3:2+v4` | none (a unit edge inside a class) | none (a unit edge inside a class) | **UNSAT**, 0.6 s |
| **L3** `group:u3:2+w4` | **UNSAT**, 0.03 s | none | **UNSAT**, 17.6 s |
| **L4a** `zeta12+u3+q7+s7` | **SAT** 0.002 s, lifted and verified on all 559,536 edges | none | **SAT** 0.10 s, verified |
| **L5** `group:u3:2+d6` | **SAT** 0.004 s, lifted and verified on all 548,532 edges | none | **SAT** 5.0 s, verified |

So **L4a and L5 carry periodic four-colouring rules** — a theorem-shaped null in the plan's own words — while
**L2 and L3 carry none at `2Λ`, `3Λ` or `4Λ`**: their four-colourings are genuinely free, which is the same fact
as their having no additive colouring, seen from the other side.

I also built the screen **at the lattice rather than at the fabric** (`periodic_escape` in `tools/fs70_ask.py`,
`data/fs70/periodic-screen*.json`), which is both cheaper and radius-free: the graph on `Λ/pΛ` whose edges are
`(class(x), class(x+z))` over the unit vectors has `p⁸` vertices (256 at `p = 2`), and a proper four-colouring of
it lifts to the whole lattice, so a lift that separates `0` from `δ` kills the target at every radius. **It is
silent on every target this milestone cares about, for a structural reason worth stating:** at `p = 2` and
`p = 4` every one of them — `4/3`, `4`, `4/9`, `8/3` on L5, `4/7`, `4/3`, `4`, `8/3` on L4a — lies **inside
`4Λ`**, so no `4Λ`-periodic colouring can separate it; and at `p = 3` a unit vector lies in `3Λ`, so no
`3Λ`-periodic colouring exists at all. Since every *additive* colouring is a function of `Λ/4Λ`, this is the
additive screen's own blind spot restated: **a chainable target is chainable because `1/δ` is a short sum of unit
vectors, which puts `δ` deep in `4Λ`, which is exactly where every periodic and every additive instrument goes
blind. The Kempe swap is the first instrument that is not a function of `Λ/4Λ`, and that is why it is the one
that kills five lattices.**

**An instrument limit, found the hard way and recorded so nobody else pays for it.** The *imposed-quotient* ask
(instrument (iii): quotient the fabric by `pΛ` and re-ask, so a SAT is a periodic colouring rule) is affordable at
`p = 2, 3, 4` on a 95,000-point rank-8 fabric and **is not at `p = 5`**: `tools/fs70_structure.py quotient
build/fs70/L2-w3 5` grew to **118 GB of anon memory and was OOM-killed by the kernel** (journal, 01:21:48, pid
189941). Nothing else was lost — the two jobs beside it survived and their artifacts are complete — but the sweep
that contained it was about to repeat the same ask on the next fabric, so it was killed at once by pid, verified
by effect (no process of that name in `ps`). *What the kill forfeits, named out loud:* the imposed-quotient
readings for L2 and L5, which were buffered behind a `tail -30` and had therefore never reached disk — **a
pipeline that writes nothing until it ends is not a checkpoint**, and that was my error, not the tool's. The
readings at `p ≤ 4` were re-run afterwards under a memory cap.

---

## 6. Decisions

| # | the choice | the alternative I weighed | why this one | confidence |
|---|---|---|---|---|
| 1 | **`forces`/`eq` pins `c(0) ≠ c(δ)` and `separated`/`sep` contracts** — the pin is named by its conclusion | Follow the owner's brief literally, which describes `eq` as the contracted encoding | The chain theorem consumes a **forced-equal** pair, and `Λ_forced` is by construction the screen for that pin; plan §1.2 and `fs70_fabric.write_shape`'s own CNF names agree with each other and with the mathematics. Following the brief's sentence would have inverted every verdict in the phase — which is the failure it warns about. | **high** — the mathematics and two independent artifacts agree |
| 2 | **The Kempe reach computed algebraically (a span and an HNF), not searched** | Breadth-first search of the component with a cap, which is what I wrote first | The component is a **subgroup**, so it is infinite whenever non-trivial and a search can never terminate: the first version returned four "no escape found" verdicts at a 200,000-point cap in 59 s each, which would have gone into the record as nulls. The algebraic form answers the same four in 0.8 s and is exact. | **high** — two-line proof, and the kill is exhibited on a 478,333-point graph |
| 3 | **The compute is aimed by the screen, not by the brief's lattice order** — L1 and L1′ were never put to a solver | Run the brief's order (L1 `eq 4/3`, `eq 8/3`; L1′ `eq 4/7`, …) | On a lattice the screen has killed, a solver ask can only return SAT, and it would measure the encoding rather than the field (G21). The same compute on L2, L3, L4a and L5 measures something. | **high** |
| 4 | **The largest affordable shape first, not the smallest** | The plan's ladder, small to large | `Forces` is monotone in the graph, so a SAT at a big shape subsumes every subgraph and answers the whole ladder in one verdict; a refusal, which is what a ladder is for, survives growth anyway. | **high** |
| 5 | **The cube pass is implemented, controlled — and was never needed** | Force a cube pass on every ask for uniformity | The owner's stop rule puts one single-solver attempt first and it answered every ask in seconds. Running cube passes anyway would have spent hours to reproduce verdicts already in hand. | **high** |
| 6 | **A streaming CNF writer above 400,000 vertices, which refuses an instance with fewer than three pinned colours** | The list writer used everywhere else | At 1.86 M vertices the clause list is ~54 million Python lists — gigabytes before a byte reaches disk. The streaming path emits no precedence break, so rather than silently asking an instance with its residual colour symmetry unbroken it **refuses by name**. | **high** — byte-identical to the list writer on a controlled instance, and the comparison was shown able to fail (one edge dropped ⇒ files differ) |
| 7 | **The k=4 word ball asked whole, not cored** | Take an `m`-core to densify | Measured: the L5 k=4 ball (1,864,417 points, degree 15.47) has **no 14-core at all** — the 12-core is 1,377,541 points at degree 16.08 and the 14-core is empty. There is no denser subgraph inside it, so coring buys nothing and loses the monotonicity a SAT gives. | **high** — measured, not assumed |

---

## 7. Where the plan, phase 0 or the brief was wrong

| where | what it says | what is the case |
|---|---|---|
| **the brief, §"Encoding"** | *"`eq (A, B)` — the pair **contracted** into one vertex …; `sep (A, B)` — `A = 0, B = 1`"* | **Inverted.** Contraction asks whether `c(A) = c(B)` is possible, whose refutation is a **virtual edge**; the milestone's target is the forced-equal pair, whose ask pins the two to *different* colours. Plan §1.2 and `fs70_fabric.write_shape` both name a pin by its conclusion, and so does `fs70_ask.py`. The likely cause is that phase 0's positive control — Haugland's `A = B` — really is a contracted encoding, because his object carries a virtual edge and not a forced pair. |
| **plan §7, P2** | *"The Harder-shape fabric `S₂`, sums of ≤ 4, **does** force `(0, 8/3)` or `(0, 4/3)` at four colours"* | **Lost, and by derivation rather than at a budget.** No finite subgraph of that lattice forces either pair, at any radius — nor `S₃`, nor sums of ≤ 5, nor anything else drawn in it (§4). |
| **plan §4.1, rows L1 and L1′** | the first asks of the milestone | Both lattices are dead at every radius, `4/7` (the field's cheapest closer, chain 2) included. No solver should be pointed at them. |
| **plan §1.3 / the owner's ruling 3** (budgets: 10 min single, then cube-and-conquer, 40 CPU-hours per ask, 240 for the phase) | the stop rule | **Never binding.** Every one of the 14 asks closed by a single solver, the slowest in 17.7 s. The phase spent well under one CPU-hour on asks; what it spent compute on was building shapes. |
| **phase 0 §0.5, the imposed-quotient ask** | one of the three structure instruments | **Does not scale to `p = 5`** on a 95,000-point rank-8 fabric: 118 GB of anon memory, OOM-killed by the kernel. Affordable at `p ≤ 4`. |
| **plan §2.4 and G65's "step up in degree"** | the ball law as the calibration, and step up when a ball is undecided | On this field the step up **has a ceiling and it was reached**: the k=4 word ball tops out at average degree 15.5–15.8 on ~1.86 M points, there is no denser subgraph inside it (the 14-core is empty), and a Minkowski ball is unaffordable at any useful degree — the live lattices' covolumes are 2·10⁻⁸ to 2·10⁻⁵, so degree 12 costs 10⁵–10¹⁰ **million** points. The four-embedding exponent (`R⁸`, not FS-61's `R⁴`) is what makes a biquadratic field a different instrument problem from a quadratic one. |

---

## 7a. What is on disk for whoever continues, and what a kill would have redone

**Built and ready, regenerable in minutes each** (`python3 tools/fs70_fabric.py word SPEC 4 --out DIR --no-cnf`):
the k=4 word balls `build/fs70/{L5,L4a,L3,L2}-w4`, each ~1.86 M points at average degree 15.4–15.8, and the k=3
balls beside them. Nothing in this phase held state only in a process: every ask writes its row at its verdict,
every shape is a `graph.json` written once, and `data/fs70/inflight/` carried the pid, the process group and the
resume command of each long job while it ran. The three kills this phase made each forfeited a timing datum and
no result, and each is named where it happened (§5.1a, §5.2, §5.3).

**The asks that are worth running next, in order:**

1. **L3 and L2 at k=4, control** — the only two fabrics whose four-colourability is not already a theorem (no
   additive colouring, no periodic rule at `2Λ`, `3Λ`, `4Λ`). A refusal is the milestone's whole deliverable, with
   no chain needed. These are 1.86–1.89 M-vertex instances and a single solver may not close one; the cube pass
   is built, calibrated and unused, and this is what it is for.
2. **L5 and L4a at k=4, `forces 4/3`** — the step up in degree at the target, on the two lattices whose additive
   families are Kempe-rigid. Their controls are SAT by theorem, so only the pin is in question.
3. **The out-of-field control of the Kempe screen** (§4.2): run it on Harder's lattice over `K = ℚ(√3,√11)` at
   `δ = 8/3`, where a four-colour forced pair is in print. It must read **live**. This needs ℚ(√3,√11) arithmetic,
   which `tools/fs70_field.py` does not have, and it is the one test that would falsify the screen at the colour
   count the milestone uses.
4. **The screen over FS-61's real-quadratic lattices** — G61(4) reads *"what decides a field is how many unit
   vectors its lattices hold"*; the Kempe reach rank may be the sharper form of that reading, and FS-61 has
   fourteen certified refusals and twenty-six typed nulls to test it against.

---

## 8. WORKFLOW step 9's two sweeps over this phase's additions

* **"conjecture"** — one, and it is the phase's own open question rather than a claim: **is the Kempe reach rank
  the invariant that decides whether a lattice can force?** Every lattice this phase killed has, at `b = 2`, a
  reach of rank 6 or 4 for some additive colouring; the two it could not kill have rank 8 for all 120 tested
  (colouring, `b`) pairs. The observation is exact where it was computed and is **not derived** — and the test
  that would settle it is the out-of-field control below. **Flagged to the owner as a stub candidate**, together
  with the second half: the same screen run over FS-61's real-quadratic lattices, where G61(4) says *"what
  decides a field is how many unit vectors its lattices hold"* and the reach rank may be the sharper form of
  that reading.
* **"not claimed"** — (i) that L2 or L3 is four-colourable **as a lattice**: what is measured is that the shapes
  asked (95k points at degree 11.5, and L5's 1.86 M-point k=4 ball) are; (ii) that anything holds at arity above
  2 — every ask here is a pair or the whole fabric; (iii) that the Kempe screen has been controlled at four
  colours against a *known* four-colour forced pair — the control that would do it is out of field and is
  **owed** (§4.2); (iv) the reach-rank table is 40 colourings per lattice, not the whole family.
