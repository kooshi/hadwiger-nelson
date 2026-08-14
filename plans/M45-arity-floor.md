# M45 — The arity floor: what order does the colour compulsion actually live at?
#
# STUB, rewritten 2026-08-13 at the M44 close to be SELF-CONTAINED. A fresh session with zero
# conversation memory should be able to subplan and run this milestone from this file alone.
# Everything needed — the mission, the evidence both ways, the objects with their addresses on
# disk, the instruments, the discipline, the failure clauses — is written out here rather than
# cited. Cross-references are given as *addresses to verify*, never as the carrier of meaning.

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
supply *witnesses* for a 7-forcing argument, because its objects' "distance from being a genuine
unit-distance graph" is locked to the same parameter as their size, and the two pull opposite
ways. **The from-above family is closed in both directions.** It is not a route to anything
further.

**From below** (can we *prove* 6 is needed?). Four separate campaigns (M31, M32, M35, M41) asked
"is anything forced?" on every object this project holds, and every meter read **exactly zero**.
No pair of points is compelled to agree, none compelled to differ, on any witness, any closure,
any composed object, at four colours or five.

**M45 asks whether that zero was ever a fact about the world.** Every one of those meters asks a
question about a **pair** of points. If the mechanism lives among three or more points at once, a
pair meter reads zero on an object that provably forces — and would look exactly like the four
campaigns we ran. That is not speculation: at M43 we *found* such an object, and we have it on
disk.

---

## §3. The question, stated exactly

> **On an object we can certify forces `k+1` colours, at what arity does a compulsion first become
> visible?**

An *arity-2* question: "can these two vertices take the same colour in some proper colouring?" If
no, they are compelled to differ (a "virtual edge"); if they cannot differ, they are compelled to
agree (a "forced pair"). An *arity-3* question: "can these three vertices all take the same
colour? can they be rainbow?" And so on. Each is one satisfiability call with the pattern pinned.

The answer we are hunting is a number: the smallest arity at which *anything* is compelled. Today
we know it is **> 2** on at least one certified object. We do not know whether it is 3, 4, or only
the whole object.

---

## §4. The four independent strands that point above pair order

Stated in full, because they are the entire motivation and each was reached by a different route.

1. **Rigidity is empty above the forcing level (from de Grey's graph, M30).** The 1581-point
   5-chromatic witness, examined at five colours, has **zero** forced pairs and **zero** virtual
   edges, settled exactly — not capped, not sampled. The same for a certified 4-chromatic object
   at four colours. Yet one rung *below* the top, at four colours, a 791-point sub-object has
   exactly six forced pairs. Conclusion drawn at the time: a geometric argument for χ ≥ 5 "must
   live at triple order or higher".

2. **Coverage compulsion is a k-set property, structurally invisible to pair sweeps (M32/M33).**
   The mechanism that delivers each new colour is *confinement at a centre*: every proper
   colouring of the surrounding web puts all `k` colours on a vertex's neighbourhood, so that
   vertex needs the `(k+1)`-th. That is a statement about a whole `k`-element set of colours at
   once. It was measured true at the centre of a 510-point witness. A pair meter cannot see it —
   the two facts (zero forced pairs, confinement at every centre) are the same situation viewed at
   two different arities.

3. **The ladder below the top rung is made of small, nameable objects (M33).** Where the pair
   meters read zero globally, the *sub-rung* compulsions all have small carriers: a 49-vertex web
   forcing three colours onto a circle, a 122-vertex carrier for a distance-2 compulsion. The
   mechanism was never global; it was disjunctive, and living at an arity nobody was asking.

4. **The decisive one (M43, "G28").** At the finest scale examined, the graph `G(p)` for
   `p ≈ 1/7` **provably needs seven colours** — refuted outright at six on a 301-vertex ball, with
   a 160-vertex minimal core. Its compulsion was then hunted at pair order and **does not exist**:
   forcing any two vertices to share a colour remains satisfiable on 241 vertices — *more material
   than the 160-vertex core that refutes outright* — and the same at every small non-edge class
   (norms 1, 3, 4, 7, 9, 12, each decided in under a second). Equivalently: **zero virtual edges
   at six colours on the largest colourable stage.** The compulsion is not pair-mediated, on an
   object that certainly forces.

**The synthesis, and the reason this milestone exists:** finding #4 was written up as a fact about
the object ("the forcing does not factor; it is global over 160 vertices"). It may instead be a
fact about the instrument, because **only arity-2 questions were asked**. The distinction is the
whole content of M45.

---

## §5. The calibrated test bed — the property no previous campaign had

Every prior "is anything forced?" campaign ran on objects whose forcing status was unknown, or
whose forcing was the thing being hunted. A zero reading there is uninterpretable: no mechanism,
or no instrument? Here both objects have **certified** answers, so a zero is informative:

**Object A — the fine-tail core.** 160 vertices, 2,978 edges, 24 point-group orbits, centre
included, 1-minimal with every vertex's necessity witnessed, edges re-derived two independent
ways. It **refuses six colours**, and its pair meters are known to read exactly zero.
* On disk: `build/m43-finetail.json`, key `cores`, the entry with `"T": "48/7"` and `"k": 6`.
  The field `core` is the list of lattice addresses; `orbit_profile` and `n_orbits` are recorded.
* Band: `T² ∈ (139/3, 49)`. Edge norms `{36,37,39,43,48,49,52,57,61,63}`. Degree 114 in the
  ambient graph. Minimal refuting ball radius `R* = 9`, at 301 vertices (M44, measured by
  exhaustive scan, not chosen). Symmetry-breaking pin triangle `[(0,0), (0,6), (-6,6)]`.

**Object B — the gap-band core, kernel-certified.** 23 vertices, 143 edges, edge norms `{3,4,7,9}`,
clique number 4, **chromatic number exactly 7 — kernel-checked** (`Proofs/HadwigerNelson/
Instances/Core23/`, refutation by a replayed proof certificate; the red control is a verified
7-colouring). It is small enough that *every* question can be answered exhaustively, and it is the
programme's first certified object with chromatic number three above its clique number.
* On disk: `build/m40-chiomega.json`, `cores`, entry `"T": "13/6"`, `"k": 6`. `R* = 3` at 37
  vertices. It is known (M41) to **factor** as pigeonhole × kill, unlike Object A — so the two
  objects differ in exactly the property under study, which makes B the positive control.

**Three more cores are on disk and belong in the sweep if affordable:** `T = 353/120` (28
vertices), `T = 467/120` (66), `T = 299/50` (117), all `k = 6`, all in `build/m40-chiomega.json`.

---

## §6. The instruments that already exist (verify each before use)

* **`tools/rigidity.py`** — the meters.
  * `triple_query(n, edges, k, triple, mode)` with `mode ∈ {"mono", "rainbow"}`: pins three
    vertices to one colour, or to three distinct colours, and asks satisfiability. **`unsat` at
    `mono` = a compelled non-monochromatic triple** — a compulsion that may act through no edge.
    It exists and was exercised at M32 on **140 targeted triples at four colours**; it has never
    been run as a *systematic* sweep, and never on a known-forcing object.
  * The class-avoidance layer is **already arity-generic**: its input validator accepts tuples of
    any size ≥ 2. This is the piece that makes an arity-3 or arity-4 sweep a driver change rather
    than an instrument build.
  * `coverage_query` / `min_cover` — the k-set question of strand #2. Built at M32, never aimed at
    these objects.
* **`tools/mechanism.py`** — the class-avoidance campaign driver (the instrument that found the
  distance-2 compulsion nobody predicted).
* **`tools/celllat.py`** — the cell-family engine. `edge_set40(T)` (the exact edge offsets at a
  scale), `ball43(T, k, R, cap, pin, enc)` (a refutation probe; `enc="a1"` is a second, independent
  encoding), `shrink(...)` (1-minimal cores with necessity witnesses), `Q(v)` (the norm form),
  `rot6`/`refl`/`orbit`/`canon` (the point group), `bands`/`band_of`/`canonical_T`.
* **`tools/m44.py`** — `load_cores()` (every recorded `k = 6` core, deduplicated) and
  `core_edges(T, pts)` (edges re-derived **two independent ways** — exact interval criterion and
  norm filter — which must agree, and the function reports it if they do not). Reuse both.
* **`tools/embed.py` / `tools/verify_defect.py`** (new at M44) — not needed for arity, but they
  are the worked example of the pattern §10 recommends.

---

## §7. The phases

* **§0 — registration, committed before any instrument runs.** The exact objects; a prior per
  probe with the evidence *both ways*; acceptance criteria that are necessary as well as
  sufficient; and an explicit statement of what a zero at each arity does and does not license.
* **§1 — arity 3, systematically, on Object A.** Both directions per triple (compelled pattern,
  and impossible pattern). The point group cuts the triple space by roughly the group order before
  any solver runs — use `orbit`/`canon` to enumerate orbit representatives, not raw triples. Every
  query needs the base-satisfiability guard: an `unsat` on an object that is *already*
  uncolourable is vacuous, so the stage must be a colourable ball (for Object A the R = 8 ball,
  241 vertices, is known colourable and is *larger* than the refuting core).
* **§2 — arity 4, and coverage order.** If arity 3 is flat, push one further, and run the
  min-cover meter at six colours around the core's vertices — the k-set question of strand #2,
  which is a different shape of question rather than a bigger one.
* **§3 — the same ladder on Object B, exhaustively.** It is small enough for "every question,
  answered", and it is kernel-certified, so its answers are ground truth for what a forcing
  object's arity profile even looks like. Compare against Object A: B factors, A does not.
* **§4 — the verdict, written either way.** Either "the compulsion has arity ≥ N, measured, with N
  named", or "pair meters read zero and so do arity-3 meters, and the honest statement is that we
  have not found the order it lives at". **Both are results.** That property — that no outcome is
  uninformative — is why this milestone is at the front of the queue.

---

## §8. The second question, free on the same material

**The observation.** Every 1-minimal carrier this project has ever produced is *nearly* symmetric
with the symmetry deliberately incomplete: de Grey's 122-vertex carrier (12 *near*-six-fold
shells), the 23-vertex core (near-six-fold, broken), the 160-vertex core ("most orbits partial —
11-of-12, 5-of-6"). These live in **unrelated arithmetic** — the first in a field of nested square
roots with rotations detuned by fractions of a degree, the last in plain integer arithmetic with
no radical anywhere and no detuning parameter at all. Different fields, different colour counts,
different construction lineage, identical signature.

**The suspected cause, which is nearly an argument already.** A measured grokking of this project
("G7") says exact symmetry adds no colour constraint: a symmetric copy can reuse the base's
pattern. If that is right, a symmetric object is never *minimal* — whatever full orbit it contains
can be thinned — and **broken near-symmetry is not a design choice or a coincidence but what
minimality does to any forcer inside a symmetric ambient, in any field.**

**The check, on data already on disk, an afternoon.** `orbit_profile` and `n_orbits` are recorded
for every core in `build/m40-chiomega.json` and `build/m43-finetail.json`. Registered prediction:
*every* 1-minimal core has at least one incomplete orbit under the ambient point group, and
re-adding a missing orbit member never restores colourability. The first half is a read of the
files; the second is a direct solver ask. If it holds across all seven recorded cores in two
unrelated families it is a stateable law with a proof sketch attached. If a fully orbit-complete
1-minimal core exists, the reading dies on the spot.

---

## §9. The discipline — non-negotiable, and the reason it exists

**Registered predictions.** §0 is written and committed *before* any instrument runs, with priors
and the evidence both ways. This is not ceremony: sorted by how they were reached, this project's
a-priori derivations have survived without exception and its post-hoc inductive readings have died
without exception — roughly 7-for-7 against 0-for-10, several of the latter refuted by our own
later work.

**"Measurement generates; induction kills."** The rule is *not* "measure less" — every derivation
that survived began as a pattern someone noticed in a measurement. The rule is about what a
measurement **buys**: a candidate pattern, never a conclusion. The conclusion is bought separately,
by a derivation or by a pre-registered replication on fresh objects. Two design consequences,
both of which this milestone is built on:
* prefer measurements that turn a **dial** (a parameter whose behaviour is informative in both
  directions) over searches that hunt for a **positive** (whose null result is uninterpretable —
  and which has now come back flat four times);
* prefer **calibrated test beds**: ask the new question where the answer is already certified, so
  a zero bounds the *instrument* instead of being mistaken for a fact about the world. §5 is that
  principle made into a milestone.

**"A search run against a sufficient-but-not-necessary check measures the check, not the world."**
When a sweep refuses, the first question is never "what does this say about the objects" but "is
my acceptance test the exact condition, or merely a sufficient one?" A conservative test converts
a finding into a measurement of your own instrument, silently, with the registered-prediction
discipline fully satisfied. This has happened here: a whole milestone's negative result turned out
to be a measurement of one comparison operator. **M45 is the same suspicion applied to arity.**

**Failure clauses.**
* `unknown at cap` is **never** a verdict. Record it as undecided with its cap; exclude it from
  every summary; say so in the summary.
* Every claim is double-encoded or theorem-closed. `ball43` carries a second encoding (`enc="a1"`,
  the deleted-centre form) for exactly this.
* Every meter is run on a **planted positive and a planted negative** before its results are
  believed. A control that has not been seen to fail is not a control.
* **HALT AND VERIFY:** any compelled pattern found at any arity on any object is the first nonzero
  structural reading of the entire hunt. Re-derive the object independently, re-run in a second
  encoding, and report *before* interpreting. If it is ever a forced-*distinct* pair at √3 or 2 at
  five colours in a unit-distance graph, that is **χ(ℝ²) ≥ 6** — the result this project exists
  for — and everything stops until it is verified three ways.

---

## §10. What M44 just added, and it transfers

M44 built the project's **first continuous meter**. Every previous instrument answered yes/no, and
they all read flat. The new one measures a graph's *unit-distance defect* — the least, over
drawings in the plane, of the largest deviation of an edge from length 1 — which is zero exactly
when the graph is a unit-distance graph, and is otherwise a **number** saying how close it comes.

Four lessons, all of which apply here:
1. **A continuous meter can often be built where only a binary one existed.** Ask whether the
   arity question has a graded form (how *many* colourings realize a pattern; how much solver
   effort a pin costs; the fraction of the colouring space a constraint removes) rather than only
   the satisfiable/unsatisfiable bit. The one nonzero reading in four flat campaigns was a
   solver-**effort** signal, not a satisfiability bit.
2. **Seed the search with what you already hold.** M44's optimizer, from random starts alone,
   returned a *worse* answer than a drawing already in hand — and under the tool's own reading
   rule that row licensed nothing. The analogue here: warm-start every solver call from a known
   colouring rather than cold.
3. **Write the checker as independent code, and expect it to find something.** M44's independent
   verifier failed a *valid* row, and the diagnosis (comparing two upper bounds cannot decide
   whether either is valid) produced a better, exact test. Decorrelation pays.
4. **Use the whole machine.** The desktop has 32 cores and the campaigns are embarrassingly
   parallel — one independent solver call per query. M44's first scan was written as a sequential
   bisection and ran on **one** core of thirty-two; rewritten as a full parallel scan it finished
   in under a minute. Fan out at ~28–30 workers. The hazard here is wall-clock, not memory.

---

## §11. The honest prior

Low expectation of a hit at arity 3. Four campaigns of flatness is real evidence even if it is
evidence about instruments, and the objects in §5 are *finite lab specimens* from the from-above
family rather than plane witnesses — a compulsion found there does not transfer to the plane by
itself. What is high-confidence is that the **answer is worth having either way**, because it
converts the strongest negative in the record from an unexamined absence into a measured bound,
and because it either validates or retires the instrument class that four campaigns depended on.

This is the cheapest milestone on the board and the only one whose negative result is itself a
publication-grade sentence about mechanism: *the compulsion is not visible at arity ≤ N on an
object we can certify forces.*

If M45 also reads flat at every affordable arity, the honest next question — and it should be
asked out loud rather than absorbed — is whether the pair/triple/coverage vocabulary is the wrong
vocabulary entirely, which would point at `plans/M46-colouring-automaton.md` (compute a colouring
space and describe it, rather than interrogating it with yes/no questions).

---

## §12. Practical notes

* **Machines.** A desktop (32 cores, 125 GB) and a laptop (12 cores, 31 GB).
  Ask which one you are on; `nproc` disagreeing with a number in a plan is the hardware moving.
  Record timings in CPU seconds, minimum of three runs, with the machine named. This milestone
  wants the desktop.
* **Building Lean.** *Always* `./scripts/build.sh`, never `lake build` — bare **or named**. Lake
  sizes its job pool from the machine and this project's data modules peak at ~9 GB each; an
  unrestricted build has taken the desktop down twice. `lake env lean <file>` is fine for
  iterating on one file (it builds nothing) but does **not** apply the project's options, so never
  conclude a module is green from it.
* **On any segfault, from any process: HALT and report to the user immediately.** Do not diagnose,
  do not retry. It is hardware and needs a reboot the user performs.
* **`pkill -f <pattern>` kills your own shell** when the pattern appears in your own command line
  — which it does, because the shell wrapper contains the command text. This bit three times in
  one session. Use a bracketed regex so the literal differs from the match (`pgrep -f "m4[5]\.py"`),
  or resolve the PID first. The same trap applies to any monitor whose command contains its own
  search pattern: it will never see the process exit.
* **Artifacts.** Write one JSON per axis, schema-tagged, with the reading rule *in the schema
  string* and the bound direction *in the field name* — a reader cannot misread `defect_upper` as
  a minimum without typing a name that contradicts them. If two quantities sit on different axes,
  put them in **different files**: a field can be ignored, a second file must be opened
  deliberately.
