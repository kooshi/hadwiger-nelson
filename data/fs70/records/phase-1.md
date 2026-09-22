# FS-70 phase 1 — the asks: what landed

*Written 2026-09-22 by the phase-1 implementer (Opus 5), against `plans/FS70-five-over-sqrt3-sqrt5.md` §4 phase 1,
`data/fs70/records/phase-0.md`, and the owner's brief and review §4. Machine: the desktop (16
physical cores / 32 threads, 125 GB). Every number names the command that produced it.*

---

## 1. Headline

**(filled at the close)**

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

### 5.2 The structure of the colourings (the plan's §3.6 — a null is not typed without these)

On L2's control colouring at k=3 (`tools/fs70_structure.py screen`):

* **the quotient screen** — no `Λ/pΛ` has all its classes monochromatic at any `p ∈ {2,3,4,5,6,7}`
  (0 of 175 at `2Λ`, 936 of 1257 at `3Λ`, 1392 of 3436 at `4Λ`, 41248 of 55237 at `5Λ`, 936 of 5703 at `6Λ`,
  6832 of 29449 at `7Λ`), so **the colouring is a function of no residue at any of those primes**;
* **the period screen** — 247 candidate periods with at least 20 testable pairs, and the best agreement is
  **0.874**, not 1: **no period at all**, not even an approximate one.

So the four-colourings these lattices carry are not additive, not residue-local at any small prime and not
periodic — they are free colourings, and the fabric is simply far from forcing anything at this size.

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

**(filled at the close)**

---

## 7. Where the plan, phase 0 or the brief was wrong

**(filled at the close)**

---

## 8. WORKFLOW step 9's two sweeps over this phase's additions

**(filled at the close)**
