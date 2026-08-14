# M45 — The arity floor: what order does the colour compulsion actually live at?
#
# SUBPLAN, written 2026-08-13 (desktop, 32 cores, 125 GB) over the self-contained stub of
# the same date. §§1–5 are the stub's motivation, kept because they are the zero-context frame a
# fresh session needs. §§6 onward are the registered subplan.
#
# READING RULE FOR THIS FILE. Three kinds of statement, never mixed:
#   [derived]    worked out on paper before any instrument ran; true or false independent of us.
#   [measured]   an instrument produced it. Cost measurements taken DURING subplanning are marked
#                `[measured @subplan]` and are explicitly NOT registered predictions — you cannot
#                predict what you have already seen.
#   [registered] a prediction with a prior, committed before the campaign runs.

---

## §1. The project, for a reader who has never seen it

**The problem.** Colour every point of the infinite plane so that no two points exactly one unit
apart get the same colour. What is the fewest number of colours? This is the Hadwiger–Nelson
problem, open since 1950. The answer is known to be 5, 6, or 7.

**What this repository is.** A Lean 4 proof workspace. Lean is a proof assistant: you write
mathematical statements and proofs, and a small trusted program (the *kernel*) checks every step.
"Kernel-checked" below means the machine verified it from first principles, and the only things
taken on faith are three standard logical axioms that everyone accepts.

**What is already kernel-checked here.** The classical interval, both ends: at least 5 colours are
needed (de Grey's 2018 result, re-verified here from a 1581-point graph), and 7 always suffice
(the classical hexagonal colouring). Plus a large body of structure built while getting there.

**The mission, and it is narrow.** This project exists *only* to find new mathematics — however
small — ratcheting toward a major finding. Formalizing known results is over as a goal. The
publication bar is exactly two events: possibly our own certified 5-chromatic object if what it
reveals is interesting enough, and definitely χ(ℝ²) ≥ 6 or its refutation. Nothing below that gets
written up. A rung that does not land is reported as not landed, never quietly rescoped.

**The one target that would end the hunt.** A finite unit-distance graph forcing two points at
distance √3 or 2 to receive *different* colours in every proper 5-colouring. Nine copies of such a
gadget, placed on the closed first shell of the triangular lattice, close **χ(ℝ²) ≥ 6** — the rest
of that composition is already kernel-checked (`Instances/HexShell.lean`, `Pigeonhole.lean`). That
gadget is the whole remaining problem, and nobody has found one.

---

## §2. Where the hunt stands, and why M45 is next

Two directions have been worked, and one of them just closed completely.

**From above** (can we *build* a colouring with 6 colours?). A family of finite computable graphs
`G(p)`, one per grid scale `p`, whose colourings are exactly the plane colourings constant on the
cells of a triangular grid at that scale. Milestones M37–M44 established: every scale needs at
least 7 colours; no lattice-based colouring can ever beat 7; and — at M44 — the family cannot even
supply *witnesses* for a 7-forcing argument. **The from-above family is closed in both directions.**

**From below** (can we *prove* 6 is needed?). Four separate campaigns (M31, M32, M35, M41) asked
"is anything forced?" on every object this project holds, and every meter read **exactly zero**.
No pair of points is compelled to agree, none compelled to differ, on any witness, any closure,
any composed object, at four colours or five.

**M45 asks whether that zero was ever a fact about the world.** Every one of those meters asks a
question about a **pair** of points. If the mechanism lives among three or more points at once, a
pair meter reads zero on an object that provably forces — and would look exactly like the four
campaigns we ran.

---

## §3. The question, stated exactly

> **On an object we can certify forces `k+1` colours, at what arity does a compulsion first become
> visible?**

An *arity-2* question: "can these two vertices take the same colour in some proper colouring?" If
no, they are compelled to differ (a "virtual edge"); if they cannot differ, they are compelled to
agree (a "forced pair"). An *arity-3* question asks the same of the five ways three vertices can
share colours. Each is one satisfiability call with the pattern pinned.

---

## §4. The four independent strands that point above pair order

1. **Rigidity is empty above the forcing level (M30).** De Grey's 1581-point 5-chromatic witness,
   examined at five colours, has **zero** forced pairs and **zero** virtual edges, settled exactly.
   Yet one rung below, at four colours, a 791-point sub-object has exactly six forced pairs.

2. **Coverage compulsion is a k-set property, structurally invisible to pair sweeps (M32/M33).**
   The mechanism that delivers each new colour is *confinement at a centre*: every proper colouring
   of the surrounding web puts all `k` colours on a vertex's neighbourhood. That is a statement
   about a whole `k`-element set at once, and a pair meter cannot see it.

3. **The ladder below the top rung is made of small, nameable objects (M33).** A 49-vertex web
   forcing three colours onto a circle; a 122-vertex carrier for a distance-2 compulsion.

4. **The decisive one (M43, "G28").** The graph `G(p)` for `p ≈ 1/7` **provably needs seven
   colours** — refuted outright at six on a 301-vertex ball, with a 160-vertex minimal core. Its
   compulsion was hunted at pair order and **does not exist**: forcing any two vertices to share a
   colour remains satisfiable on 241 vertices, and the same at every small non-edge class.

**The synthesis:** finding #4 was written up as a fact about the object ("the forcing does not
factor; it is global over 160 vertices"). It may instead be a fact about the instrument, because
**only arity-2 questions were asked**.

---

## §5. The calibrated test bed

Both objects have **certified** answers, so a zero reading is informative rather than ambiguous.

**Object A — the fine-tail core.** 160 vertices, 2,978 edges, 24 point-group orbits, centre
included, 1-minimal. It **refuses six colours**, and its pair meters are known to read zero.
On disk: `build/m43-finetail.json`, key `cores`, entry `"T": "48/7"`, `"k": 6`. Band
`T² ∈ (139/3, 49)`; edge norms `{36,37,39,43,48,49,52,57,61,63}`; ambient degree 114;
`R* = 9` at 301 vertices; pin triangle `[(0,0), (0,6), (-6,6)]`.

**Object B — the gap-band core, kernel-certified.** 23 vertices, 143 edges, edge norms `{3,4,7,9}`,
clique number 4, **chromatic number exactly 7 — kernel-checked** (`Instances/Core23/`). Small
enough that *every* question can be answered exhaustively. On disk: `build/m40-chiomega.json`,
entry `"T": "13/6"`, `"k": 6`. `R* = 3` at 37 vertices. It is known (M41) to **factor** as
pigeonhole × kill, unlike Object A.

**Three more cores on disk**, all `k = 6`, in `build/m40-chiomega.json`: `T = 353/120` (28
vertices), `T = 467/120` (66), `T = 299/50` (117).

---

## §6. §0a — The object, derived before any instrument

*(Rewritten after the `debruijn-domain-modeling` pass; the pass's decisions and the two it
overturned are in §6b.)*

The milestone needs one definition, and the repository already owns half of it.

`Pattern.lean` defines **`SamePattern a b := ∀ i j, a i = a j ↔ b i = b j`** — two colour
assignments to `m` positions agree exactly when they induce the same partition — and
**`canonPatterns k m`**, a kernel-verified list containing exactly one representative of every
partition of `m` positions into at most `k` blocks (`exists_mem_canonPatterns`). That is precisely
the vocabulary this milestone needs, so the new notion is phrased *through* it and no parallel
development is created.

```
PartialColoring G   S p  :=  Function.Injective S ∧ ∀ i j, p i = p j → ¬ G.Adj (S i) (S j)
Realizes        G k S p  :=  ∃ C : G.Coloring (Fin k), SamePattern (fun i => C (S i)) p
Compels         G k S p  :=  PartialColoring G S p ∧ ¬ Realizes G k S p
arityFloor      G k      :=  ⨅ m ∈ {m | ∃ S p, Compels G k S p}, (m : ℕ∞)
```

**The reading that makes the notion inevitable rather than invented.** `PartialColoring` says
exactly *`S` lists `m` distinct vertices and `p` is a proper colouring of the subgraph they induce*.
So

> **a compulsion is a partial colouring that does not extend, and the arity floor is the least
> number of vertices you must look at before local properness stops implying global
> extendability.**

That is the standard extendability question of constraint satisfaction, asked about colourings, and
it is the honest name for what four campaigns were measuring at `m = 2`.

**Why `ℕ∞` and not `ℕ`.** Mirrors Mathlib's own `chromaticNumber : ℕ∞ := ⨅ n ∈ setOf G.Colorable,
(n : ℕ∞)` — the same shape, least-such-that with `⊤` for "never". `Nat.sInf ∅ = 0` would have
collided with a genuine `m = 0`, which is the next entry.

**The vacuity guard becomes a theorem instead of a side condition.** At `m = 0` the empty tuple is
injective and admissible vacuously, and `Realizes` reduces to `G.Colorable k`. So
**`arityFloor G k = 0 ↔ ¬ G.Colorable k`** — the definition *self-reports* vacuity in its own value,
and for a colourable graph `arityFloor ≥ 2` follows at once (`m = 1` is realizable whenever any
colouring exists). The base-SAT guard every instrument in this repository carries by hand is, here,
the number 0.

Five facts, all **[derived]**, all worked before any instrument ran:

* **D1 — arity 2 is exactly the existing API, both cases.** For `S : Fin 2 → V`,
  `Compels G k S p` is `¬ G.Adj (S 0) (S 1) ∧ Separated G k (S 0) (S 1)` when `p 0 = p 1`, and
  `Forces G k (S 0) (S 1)` otherwise. So the four flat campaigns measured `a* = 2` and nothing else,
  and the new notion **subsumes** `Forces`/`Separated` rather than sitting beside them.
* **D2 — compulsions extend, so "floor" is the right word.** A compulsion on `S` transports to any
  tuple containing it whose pattern restricts to it (restrict the realizing colouring). Hence the
  set of arities carrying a compulsion is upward closed under extension, and the least one is the
  invariant.
* **D3 — the fan bracket.** If every proper `k`-colouring puts all `k` colours on the image of `S`
  (`S` is *fanned* — `Coverage.fan_iff_coverage`'s right-hand side) and `p` is admissible and **not
  surjective**, then `Compels G k S p`. So a fanned set of size `m` whose induced subgraph is
  `(k−1)`-colourable carries a compulsion, and `a* ≤ m`.
* **D4 — and therefore the arity floor is at most `k`, with no hypotheses at all.** If `v` has `k`
  distinct neighbours `S : Fin k → V`, the rainbow pattern `p = id` is admissible and unrealizable:
  a realizing colouring makes `i ↦ C (S i)` injective, hence surjective, so `v`'s own colour is
  taken by a neighbour. **`a*(G, k) ≤ k` whenever `G` has a vertex of degree ≥ k.**
* **D5 — vacuity.** Every claim above needs `G.Colorable k`.

**D4 reframes the milestone before it runs, and corrects the stub's own premise.** The stub asked
whether the floor is "3, 4, or only the whole object". *The last branch is impossible.* Object A's
stage has minimum degree 23 against `k = 6`, so its floor is in `{3, 4, 5, 6}` **by theorem**, and
the campaign's job is to pin it, not to discover whether one exists. The same applies to every
plane witness with minimum degree ≥ `k`: **the four flat campaigns were asking an arity-2 question
on objects whose arity floor is provably at most `k`.** That sentence is the milestone's
transferable content and it is derived, not measured.

**What D4 does *not* say.** It gives a compulsion of arity `k` for free; it says nothing about
whether a *smaller* one exists, and nothing about whether a compulsion at any arity is *useful*
(the from-below reduction consumes a forced-distinct pair — see §12). Beating `k` from below is the
whole measurement.

---

## §6b. What the domain-modeling pass changed

Five questions were put to the draft; three answers overturned it.

**(1) The tuple: `Fin m ↪ V` was tried and rejected, on decidability.** Repeated vertices are an
*adversarial member* — `S = (v, v)` with `p = (0, 1)` is admissible and unrealizable, so without
distinctness **every graph would have arity floor 2** and the definition would be destroyed. An
embedding makes that unrepresentable, which is the better instinct — but
`Function.Embedding.fintype` is **`noncomputable`**, so `decide +kernel` cannot pass through it and
the planted control could not be checked. Distinctness therefore lives as a conjunct of
`PartialColoring`, where it also reads correctly ("`m` distinct vertices"). A `Finset` was never in
contention: D4's proof is "`i ↦ C (S i)` is injective on `Fin k`, hence surjective", which wants
`Fin k → Fin k` and nothing else.

**(2) The pattern stays `Fin m → Fin k`, and `SamePattern` does the quotient's work.** The honest
object is the partition, but what this milestone needs is a *section* — a list hitting every class
once, for the sweep and for `decide` — not a quotient with a respects-obligation on every
constructor. `Pattern.lean` already made that argument and already built the section. The content
of "a pattern is really a partition" is one lemma, `Realizes.congr`, and it is what makes
`canonPatterns` a **complete** enumeration for the campaign.

**(3) Admissibility is not a hypothesis and not droppable — it is half the definition.** Dropped, a
block containing an edge is unrealizable for a reason that has nothing to do with colouring, and
again every graph with an edge gets arity floor 2. Bundled with distinctness it stops being a side
condition and becomes the recognizable object `PartialColoring`.

**(4) `arityFloor` is worth minting** — it has three real uses (D4's `≤ k`, the vacuity theorem, and
the planted control's `= 3`), it is the milestone's headline, and in `ℕ∞` it carries no junk value.

**(5) Four notions do not become five.** `Separated` and `Forces` are *exactly* the two arity-2
compulsions (D1, one theorem covering both cases), so the new notion **contains** them. `Fan` is a
*disjunction* of compulsions — `Fan G k v Q` holds iff every admissible pattern on `(v, q₁ … qₙ)`
that isolates `v` is a compulsion — so it is **stratified**, not duplicated. And the repository
already holds an arity-3 compulsion it never named the genus of: `Compulsion.no_mono_outer_triple`
(M20 — an outer 120°-triple is never monochromatic in a proper 3-colouring) is
`Compels _ 3 ![a,b,c] (fun _ => 0)`. The definition names something already present three times.

**The find of the pass.** Because a global palette permutation is free, the palette-free definition
and the naive one coincide:

> **`realizes_iff_extends : Realizes G k S p ↔ ∃ C : G.Coloring (Fin k), ∀ i, C (S i) = p i`**

The campaign's primary encoding is colour-free (§8, the >8,000× symmetry-breaking win) and its
decorrelated second encoding is colour-pinned. This theorem says the two ask the same question —
so the decorrelation rests on a **theorem** rather than on an assumption that the two encodings
agree. Its proof is the one place the model is expected to resist: extending a bijection between
two subsets of `Fin k` to a permutation of `Fin k`. Flagged for the obligation pass.

---

## §7. §0b — The stage, derived, and a correction to how it was chosen before

A compulsion is a property of a **colourable** graph. So the arity question about an object that
*forces* must be asked on a colourable relative of it, and which relative is a real choice:

| stage | size | property |
|---|---|---|
| the largest colourable ball (`R = 8`) | 241 vertices | M43's choice. Bigger, but not critical. |
| **`C − v` for the 1-minimal core `C`** | 159 vertices | One vertex from refuting. **Guaranteed** by D3+A1 to carry a compulsion. |

**M43's stage was larger and less critical, and "more material than the core that refutes" reads
as strength when for this question it is weakness.** `C − v` is the stage where a compulsion is
guaranteed to exist; the ball is not. This is a methodological correction registered before the
campaign, and phase §10.3 tests it directly by running the identical sweep on both stages.

`C − v` is 6-colourable for **every** `v`, because `C` is 1-minimal with per-vertex necessity
witnesses recorded — so the base-SAT guard is met by construction and by re-measurement.

---

## §8. §0c — The encoding, measured before specifying

Two choices, both settled with numbers rather than plausibility.

**Colour-free pattern clauses.** A pattern is pinned without naming a colour: equality inside a
block as `¬x_{u,c} ∨ x_{w,c}` for every `c` (both ways), disequality between blocks as
`¬x_{u,c} ∨ ¬x_{w,c}`. The resulting property is palette-invariant, which is exactly what makes
first-occurrence palette-symmetry breaking sound on top of it. The colour-*pinned* alternative
(block `j` → colour `j`) is only a partial break.

**The measurement that decided it [measured @subplan, the machine]:** the 23-vertex kernel-certified
core, six colours, refutation —

| encoding | time |
|---|---|
| no symmetry breaking | **> 162 s** (killed) |
| colour-free + first-occurrence breaking | **0.02 s** |

A factor above 8,000. Every UNSAT-expected query in this campaign carries the break; the
colour-pinned form is kept **as the decorrelated second encoding**, never as the primary.

**Costs, all [measured @subplan, the machine, 28 workers]:**

| object | fact | time |
|---|---|---|
| Object B core (23 v) | `k = 6` refutation, broken | 0.02 s |
| Object B stage `C − v` (22 v) | `k = 6` colourable | 0.00 s |
| Object B stage | one pattern query | **0.005 s** |
| Object A core (160 v) | `k = 6` refutation, broken | **unknown at 600 s cap** |
| Object A stage `C − v` (159 v) | `k = 6` colourable | 0.04 s |
| Object A stage | one pattern query, median | **0.07 s** |
| Object A stage | one pattern query, observed UNSAT | 7 s – 118 s |

**The asymmetry is the budget.** On Object A misses are milliseconds and hits are minutes, so a
flat sweep is cheap and a rich one is not. Caps must be generous (≥ 900 s) and every `unknown` is
recorded as undecided, never folded into "clean".

---

## §9. §0d — The sweep design: observe, then confirm

Enumerating patterns tuple-by-tuple through the solver is the obvious design and it is wasteful:
Object A's stage has 657,359 triples. The `Rigidity` class already solves this at arity 2 and the
generalization is direct:

1. **Observe.** Harvest a few hundred genuinely proper colourings (validated in process — every
   edge checked bichromatic). Each colouring exhibits one realized pattern for *every* tuple at
   once, so one solver call teaches about all of them.
2. **Confirm.** Only patterns never observed are candidates. Each gets one solver call.
   `sat` teaches (and shrinks the candidate set); `unsat` **confirms a compulsion**; `unknown`
   is recorded as undecided with its cap.

Soundness is one line: a compulsion is only ever claimed on a solver `unsat`, never on an absence
in the sample. **[measured @subplan]** on Object A's stage: 400 colourings harvested in 2.4 s
reduced 9,636 non-adjacent pairs to 811 candidates on one side and **0** on the other.

Enumeration uses `canonPatterns k m` — one representative per partition, `Bell(3) = 5`,
`Bell(4) = 15`, `Bell(5) = 52` — and the point group (`celllat.orbit`/`canon`, order 12) to cut
tuple classes before any solver runs.

---

## §10. The phases

### §10.1 — the instrument, `tools/arity.py`, with its controls

`pattern_clauses` · `realize` (two encodings) · `profile` (a tuple's whole realizable-pattern set —
the *graded* meter M44 §10 asks for, a set rather than a bit) · `harvest` · `sweep` ·
`fan_shrink` · a self-test that must pass before any campaign row is written.

**The controls, and one of them is new and load-bearing.** A sweep that reads flat measures the
instrument unless the instrument has been *seen to fire*. Found during subplanning
**[measured @subplan]**, exhaustively over small graphs:

> **The planted arity-3 positive: 5 vertices, 5 edges, 3 colours.** Edges
> `(0,1), (0,4), (1,2), (2,3), (2,4)` — a 4-cycle `0–1–2–4–0` with a pendant `3` on `2`. Every pair
> is free (both patterns realized among its 36 proper 3-colourings), and the triple `(1,3,4)`
> **cannot be rainbow**: vertex `2` is adjacent to all three and would have no colour left. Arity
> floor exactly 3, verified by exhaustion over all `3⁵` assignments.

It is the smallest such graph found, it is `decide`-able in Lean, and it is D4's mechanism at its
minimum — which is itself a small structural point: *the first compulsion of a graph is a fan.*
Controls in full: this planted positive; a planted negative (`K₃` at `k = 3`, no compulsion at any
arity); the base-SAT guard on every stage; in-process validation of every `sat` model (proper
**and** realizing the claimed pattern); and the second encoding on every `unsat`.

### §10.2 — Object B, exhaustively (the calibration)

22-vertex stage, 0.005 s per query: **every** pair (231 × 2), **every** triple (1,540 × 5), and
every 4-tuple (7,315 × 15) if the timings hold — roughly 120,000 queries, minutes on 28 workers.
Produces the first complete arity profile of a **kernel-certified** forcing object, and therefore
the answer to "what does a forcing object's arity profile even look like".

**[measured @subplan]** on a 20-pair sample: 11 of 20 non-adjacent pairs are already compelled
(9 virtual edges, 2 forced pairs), and the centre's 16 neighbours are **fanned** (`min_cover`
`lo = hi = 6`). So `a*(B) = 2` and Object B is a strong positive control — the contrast with
Object A's zero at arity 2 is the milestone's whole axis.

### §10.3 — Object A, the subject

* **Complete arity 2** on the `C − v` stage — 9,636 non-adjacent pairs, both directions,
  observe-then-confirm. This decides whether the arity-3 readings below are genuinely arity 3 or
  consequences of a pair fact M43's stage could not see. **Running at subplan time.**
* **The same complete arity-2 sweep on M43's own stage** (the `R = 8`, 241-vertex ball), to
  separate "the object has no pair compulsion" from "that stage has none" — §7's correction, tested
  rather than asserted.
* **Arity 3**, by point-group orbit classes, observe-then-confirm, caps ≥ 900 s.
* **Arity 4** on the surviving structure if arity 3 is flat.
* All five recorded cores if the timings allow, so the answer is a profile across the family rather
  than one object.

### §10.4 — the fan bracket, measured on both objects

D3/D4 guarantee a compulsion on any fanned set. Shrinking a fanned set to a **1-minimal** one turns
the guarantee into a **number**: an upper bound on the arity floor, measured rather than assumed.
`min_cover` is the meter; the shrink is the same delta-debugging loop `celllat.shrink` already uses,
with necessity witnesses per member. Object B's fan starts at 16, Object A's at 53.

Deliverable: the bracket `[lower from §10.3, upper from §10.4]` on both objects. **No outcome is
uninformative**, which is why this milestone is at the front of the queue.

### §10.5 — orbit concentration, and the control that already inverted its reading

The stub predicted that 1-minimal cores are *near*-symmetric with the symmetry **broken**, and
proposed reading `orbit_profile` off disk to confirm it. Doing that during subplanning
**[measured @subplan]** confirmed the letter of it — all five cores have incomplete orbits — and
then the **matched control inverted the reading**:

| core | complete orbits | same-size random subset of the same ball (200 draws) |
|---|---|---|
| `T = 48/7` (160 v) | 7 / 24 = 29.2 % | 0.81 / 32.3 = **2.5 %** |
| `T = 299/50` (117 v) | 6 / 19 = 31.6 % | 0.67 / 26.3 = **2.5 %** |
| `T = 467/120` (66 v) | 5 / 10 = 50.0 % | 1.84 / 11.7 = **15.7 %** |
| `T = 353/120` (28 v) | 4 / 5 = 80.0 % | 0.28 / 10.5 = **2.7 %** |
| `T = 13/6` (23 v) | 3 / 5 = 60.0 % | 0.40 / 8.1 = **4.9 %** |

Cores are **3× to 30× more orbit-complete than chance**, and touch far fewer orbits. The honest
statement is the opposite of the stub's: minimality **concentrates** symmetry, it does not destroy
it — "broken near-symmetry" was reading the glass half empty against no base rate at all.

**And that reading is itself not yet safe, for a reason that is pure G21.** `celllat.shrink`
deletes **outside-in by norm, in batches** (`key=lambda w: (-Q(w), w)`), so a batch is essentially a
shell. The procedure may be manufacturing shell-completeness. The decisive control, and the phase's
actual deliverable: **re-shrink two cores with a randomized deletion order and batch size 1, and
compare.** If the enrichment survives a random order it is about the objects; if it collapses to the
base rate it is about the traversal, and that is a finding about every core this project has
recorded. **[registered]** prior: 60/40 that a substantial part of the enrichment is procedural.

### §10.6 — the kernel layer

`Proofs/HadwigerNelson/Arity.lean` and `Proofs/HadwigerNelson/Instances/AritySpec.lean`. Skeleton
in §11. Small and deliberately bounded: the definition plus D1–D4. It earns its place by naming
structure (the arity floor of a colour compulsion) and by making D4 — the statement that reframes
four campaigns — a theorem rather than an observation. It is elementary and the module will say so.

### §10.7 — verdict, Frontier, report

Written either way, per §13.

---

## §11. The Lean skeleton (WORKFLOW step 3: statements before proofs)

```lean
-- Proofs/HadwigerNelson/Arity.lean
import Proofs.HadwigerNelson.Coverage        -- Fan, fan_iff_coverage
import Proofs.HadwigerNelson.Pattern         -- SamePattern, canonPatterns

namespace HadwigerNelson
variable {V : Type*} {G : SimpleGraph V} {k m : ℕ} {S : Fin m → V} {p : Fin m → Fin k}

/-- `m` distinct vertices, properly coloured among themselves: the local data. -/
def PartialColoring (G : SimpleGraph V) {m k : ℕ} (S : Fin m → V) (p : Fin m → Fin k) : Prop :=
  Function.Injective S ∧ ∀ i j, p i = p j → ¬ G.Adj (S i) (S j)

/-- `p` is the pattern some proper `k`-colouring wears on `S`. Palette-free by construction. -/
def Realizes (G : SimpleGraph V) (k : ℕ) {m : ℕ} (S : Fin m → V) (p : Fin m → Fin k) : Prop :=
  ∃ C : G.Coloring (Fin k), SamePattern (fun i => C (S i)) p

/-- A partial colouring that does not extend. -/
def Compels (G : SimpleGraph V) (k : ℕ) {m : ℕ} (S : Fin m → V) (p : Fin m → Fin k) : Prop :=
  PartialColoring G S p ∧ ¬ Realizes G k S p

/-- How many vertices before local properness stops implying global extendability. -/
noncomputable def arityFloor (G : SimpleGraph V) (k : ℕ) : ℕ∞ :=
  ⨅ m ∈ {m | ∃ (S : Fin m → V) (p : Fin m → Fin k), Compels G k S p}, (m : ℕ∞)

-- the reasoning surface (nobody reasons by unfolding)
theorem Realizes.partialColoring (hS : Function.Injective S) :
    Realizes G k S p → PartialColoring G S p := sorry
theorem Realizes.congr {p' : Fin m → Fin k} (h : SamePattern p p') :
    Realizes G k S p ↔ Realizes G k S p' := sorry      -- "a pattern is really a partition"
theorem realizes_iff_extends :                          -- THE decorrelation theorem (§6b)
    Realizes G k S p ↔ ∃ C : G.Coloring (Fin k), ∀ i, C (S i) = p i := sorry
theorem realizes_iff_exists {n : ℕ} {G : SimpleGraph (Fin n)} {S : Fin m → Fin n}
    {p : Fin m → Fin k} : Realizes G k S p ↔
      ∃ f : Fin n → Fin k, (∀ i j, G.Adj i j → f i ≠ f j) ∧
        SamePattern (fun i => f (S i)) p := sorry       -- the `decide +kernel` bridge

-- the vacuity guard, as a value rather than a side condition
theorem arityFloor_eq_zero_iff : arityFloor G k = 0 ↔ ¬ G.Colorable k := sorry
theorem two_le_arityFloor (h : G.Colorable k) : 2 ≤ arityFloor G k := sorry
theorem arityFloor_le_of_compels (h : Compels G k S p) : (m : ℕ∞) ≤ arityFloor G k := sorry

-- D1: arity two IS Forces/Separated, both cases, one statement
theorem compels_two {S : Fin 2 → V} {p : Fin 2 → Fin k} (hS : Function.Injective S) :
    Compels G k S p ↔
      (if p 0 = p 1 then ¬ G.Adj (S 0) (S 1) ∧ Separated G k (S 0) (S 1)
       else Forces G k (S 0) (S 1)) := sorry

-- D2: compulsions extend, so "floor" is the right word
theorem Compels.extend {m' : ℕ} {S' : Fin m' → V} {p' : Fin m' → Fin k} (ι : Fin m → Fin m')
    (hS : S' ∘ ι = S) (hp : p' ∘ ι = p) (h : ¬ Realizes G k S p)
    (hpc : PartialColoring G S' p') : Compels G k S' p' := sorry

-- D3: the fan bracket
theorem compels_of_fan
    (hfan : ∀ C : G.Coloring (Fin k), ∀ c : Fin k, ∃ i, C (S i) = c)
    (hpc : PartialColoring G S p) (hp : ¬ Function.Surjective p) : Compels G k S p := sorry

-- D4: the arity floor is at most k, unconditionally
theorem compels_rainbow_of_neighbors {v : V} (S : Fin k → V)
    (hN : ∀ i, G.Adj v (S i)) (hinj : Function.Injective S) : Compels G k S id := sorry
theorem arityFloor_le_of_degree {v : V} (S : Fin k → V)
    (hN : ∀ i, G.Adj v (S i)) (hinj : Function.Injective S) : arityFloor G k ≤ k := sorry

-- the bridge to the existing Fan: a disjunction of compulsions, not a fifth notion
theorem fan_iff_forall_compels {v : V} {Q : List V} : Fan G k v Q ↔ sorry := sorry
```

```lean
-- Proofs/HadwigerNelson/Instances/AritySpec.lean — the models, because a ∀ over an empty domain
-- proves everything.  All through `realizes_iff_exists`, then `simp only [edgeGraph_adj]; decide`.
def p5 : List (Fin 5 × Fin 5) := [(0,1), (0,4), (1,2), (2,3), (2,4)]   -- C₄ + a pendant on 2

theorem p5_colorable_three : (edgeGraph 5 p5).Colorable 3 := sorry     -- non-vacuity, explicit
theorem p5_no_pair_compulsion :                                       -- arity 2 is FLAT …
    ∀ (S : Fin 2 → Fin 5) (q : Fin 2 → Fin 3), ¬ Compels (edgeGraph 5 p5) 3 S q := sorry
theorem p5_compels_rainbow :                                          -- … and arity 3 fires
    Compels (edgeGraph 5 p5) 3 ![1, 3, 4] ![0, 1, 2] := sorry
theorem p5_arityFloor : arityFloor (edgeGraph 5 p5) 3 = 3 := sorry    -- the number, both directions

theorem k3_arityFloor : arityFloor (edgeGraph 3 [(0,1),(0,2),(1,2)]) 3 = ⊤ := sorry  -- planted red
theorem k4_arityFloor_zero : arityFloor (edgeGraph 4 k4edges) 3 = 0 := sorry -- vacuity self-report
```

Spec obligations, before any proof effort: `#eval` `(canonPatterns 6 3).length` against `Bell(3) = 5`
and `canonPatterns 6 4` against `15`; exhibit the explicit 3-colouring of the planted graph; check
`Compulsion.no_mono_outer_triple` really is an instance of `Compels`; and read `compels_two` aloud
against "a virtual edge is exactly an arity-2 compulsion".

---

## §12. Does an arity-3 find even help the plane? — stated now, not after

**[derived]** The from-below reduction (G26) consumes a *forced-distinct pair* at √3 or 2 at five
colours; an arity-3 compulsion is not that, so it does **not** drop into the existing composition.
What it would do:

* **Retire or validate an instrument class.** Four campaigns concluded "nothing is forced" from
  arity-2 meters on objects whose floor is provably ≤ `k` (D4). If the floor is 3 on a certified
  forcer, those campaigns measured their instrument, and the from-below hunt has been using the
  wrong detector — that is the single most consequential sentence this milestone can produce.
* **Generalize Act One.** The kernel already holds `hexShell_pigeonhole` (7 shell cells, 6 colours
  ⟹ a mono pair at √3 or 2). The arity-3 analogue needs a configuration where any 5-colouring
  forces a mono *triple* in one distance class. Whether one exists in the triangular lattice is an
  open sub-question and is **registered as a derivation to attempt, not a phase to measure** —
  its answer decides whether an arity-3 gadget is usable at all.

This is written before the campaign so that a hit is not oversold and a miss is not undersold.

---

## §13. The discipline, and the failure clauses

**Registered predictions.** Sorted by how they were reached, this project's a-priori derivations
have survived without exception and its post-hoc inductive readings have died without exception —
roughly 7-for-7 against 0-for-10, several of the latter refuted by our own later work.

**"Measurement generates; induction kills."** A measurement buys a candidate pattern, never a
conclusion; the conclusion is bought separately by a derivation or a pre-registered replication.
Prefer **dials** over hunts for a positive; prefer **calibrated beds**, so a zero bounds the
instrument instead of being mistaken for a fact about the world. §10.5 above is a worked example
inside this very subplan: an observation, a matched control that inverted it, and a procedural
confound that may yet invert it again.

**"A search run against a sufficient-but-not-necessary check measures the check, not the world."**
M45 is that suspicion applied to arity.

**Registered predictions, with priors, committed before the campaign:**

| # | prediction | prior |
|---|---|---|
| P1 | Object B's arity floor is 2, and abundantly so | 0.9 — sampled, not exhausted |
| P2 | Object A's arity floor is > 2 on **both** stages (complete sweeps) | 0.6 |
| P3 | Object A's arity floor is exactly 3 | 0.5 — subplanning saw candidate arity-3 hits, unverified |
| P4 | Object A's minimal fanned set is strictly smaller than `\|N(v)\| = 53` | 0.85 |
| P5 | The orbit-completeness enrichment is at least half procedural | 0.6 |
| P6 | Every core in the family has arity floor < `k = 6` | 0.5 |

P3 is deliberately not stated as a discovery: subplanning's cost sample produced three candidate
arity-3 compulsions and one undecided row on Object A's stage, and **candidates seen during
subplanning are not predictions**. They are being verified under the halt clause below; whatever
they turn out to be is reported as a subplan-time measurement, with its verification, and never as
a fulfilled prediction.

**Failure clauses.**
* `unknown at cap` is **never** a verdict. Record it as undecided with its cap, exclude it from
  every summary, and say so in the summary.
* Every claim double-encoded or theorem-closed.
* Every meter run on a planted positive and a planted negative before its results are believed.
* **HALT AND VERIFY:** any compelled pattern found at any arity is the first nonzero structural
  reading of the hunt. Re-derive the object independently, re-run in a second encoding, confirm all
  lower-arity sub-tuples are free (or the reading is not what it looks like), and report *before*
  interpreting. If it is ever a forced-*distinct* pair at √3 or 2 at five colours in a
  unit-distance graph, that is **χ(ℝ²) ≥ 6** and everything stops until it is verified three ways.

---

## §14. Practical notes

* **Machines.** Desktop (32 cores, 125 GB) and laptop (12 cores, 31 GB). This milestone
  wants the desktop. Record CPU seconds with the machine named.
* **Building Lean.** *Always* `./scripts/build.sh`, never `lake build` — bare or named.
  `lake env lean <file>` is fine for iterating (builds nothing) but does not apply the project's
  options, so never conclude a module is green from it.
* **On any segfault, from any process: HALT and report to the user immediately.** It is hardware.
* **`pkill -f <pattern>` kills your own shell** — the wrapper's command line contains the pattern.
  Use a bracketed regex (`pgrep -f "m4[5]\.py"`) or resolve the PID. The same trap silently
  disables any monitor whose command contains its own search pattern.
* **Artifacts.** One JSON per axis, schema-tagged, reading rule *in the schema string*, bound
  direction *in the field name*. Arity rows and fan-bracket rows are the same axis and share a file;
  the orbit-concentration rows are a different axis and get their own.

---

## §R. Results

*(written at the close)*
