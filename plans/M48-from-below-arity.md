# M48 — The from-below arity question: what is compelled among THREE points at five colours?
#
# STUB, written 2026-08-13, CORRECTED and rewritten 2026-08-14 before any work began.
# SELF-CONTAINED: a fresh session with zero conversation memory should be able to subplan and run
# this from this file alone. Everything needed — the mission, the evidence both ways, the objects
# with their addresses, the instruments, the discipline, the failure clauses — is written out here
# rather than cited. Cross-references are given as *addresses to verify*, never as the carrier of
# meaning.
#
# READING RULE FOR THIS FILE. Three kinds of statement, never mixed:
#   [derived]     worked out on paper; true or false independent of us.
#   [measured]    an instrument produced it, with its address on disk.
#   [registered]  a prediction with a prior, to be committed before the campaign runs.

---

## §1. The project, for a reader who has never seen it

**The problem.** Colour every point of the infinite plane so that no two points exactly one unit
apart get the same colour. What is the fewest number of colours? This is the Hadwiger–Nelson
problem, open since 1950. The answer is known to be 5, 6, or 7.

**What this repository is.** A Lean 4 proof workspace. Lean is a proof assistant: you write
mathematical statements and proofs, and a small trusted program (the *kernel*) checks every step.
"Kernel-checked" below means the machine verified it from first principles, and the only things
taken on faith are three standard logical axioms everyone accepts.

**What is already kernel-checked here.** The classical interval, both ends: at least 5 colours are
needed (de Grey's 2018 result, re-verified here from a 1581-point graph) and 7 always suffice.

**The mission, and it is narrow.** This project exists *only* to find new mathematics — however
small — ratcheting toward a major finding. Formalizing known results is over as a goal. The
publication bar is exactly two events: possibly our own certified 5-chromatic object, and definitely
**χ(ℝ²) ≥ 6 or its refutation**. A rung that does not land is reported as not landed, never quietly
rescoped.

---

## §2. The target, stated exactly, and what is already built toward it

**Act One is kernel-checked.** `Instances/HexShell.lean` holds `hexShell_plane5` (verify it):

> Every proper 5-colouring of the plane has two points of the same colour at distance **√3 or 2**.

Its carrier is the closed first shell of the triangular lattice — a point and its six unit
neighbours, seven points. Six colours cannot be spread over seven points without a repeat, and the
repeated pair is never a unit edge, so it lies at √3 or at 2. **Counting, not search.**

**The pigeonhole names exactly nine pairs** — verify `hexShellPairs` in the same file:
`hexShellP3` = **six** pairs at √3 (the 120° ring gaps) and `hexShellP4` = **three** pairs at
distance 2 (the ring diameters). Nine, not one.

**Act Two is what is missing.** To turn Act One into `χ(ℝ²) ≥ 6` you must *refute every one of those
nine placements*: a finite unit-distance graph in which two points at that distance are forced to
receive **different** colours in every proper 5-colouring. Such a forced-different pair is called a
**virtual edge** — an edge the colouring theory already believes in, though no unit distance joins
the two points.

**[derived] — a correction to a loosely stated reduction, and it matters for scoping.** The
project's grokking G26 says a 6-forcer needs "one gadget at √3 **or** 2". Read against
`hexShellPairs` that is too weak: the pigeonhole is *disjunctive over both classes*, so killing all
six √3-pairs still leaves the three diameters, and vice versa. **You need a virtual edge at √3 AND
one at distance 2.** Both radicands are inside the 5-forcers' own field (a spindle at distance `d`
needs `4d² − 1` square: `11` at √3, `15` at 2 — verify against `FieldWall.lean` and the M31
quadrature law), so neither is out of reach in principle. *Finding one of the two would be a major
result and would halve the remaining problem; finding both closes it.*

---

## §3. What has actually been measured — and this section is the whole reason the milestone changed

A previous version of this stub asserted that the from-below pair question had only ever been asked
forty times. **That was wrong, and checking it before running anything is why this file was
rewritten.** The true state, verified on disk:

| object | size | arity-2 sweep at `k = 5` | result | address |
|---|---|---|---|---|
| de Grey's 1581 witness | 1,581 pts / 7,877 edges | **COMPLETE and SETTLED** — 37 models, `unsettled: []` both sides, 30.2 s | 0 forced pairs, 0 virtual edges | `build/m30-rigidity-1581-k5.json` |
| twelve composed objects (crystal unions, hetero-dimers, the four-witness family union) | up to 5,533 pts | **COMPLETE and SETTLED** — 38–110 models each | 0 and 0, every one | `build/m41-rigidity-*.json` |
| gen-1 closure | 24,065 pts / 123,134 chords | **never run** | — | — |
| gen-2 closure | 284,873 pts / 1,477,824 edges | **40 targeted asks only** — 20 at √3, 20 at distance 2, *all satisfiable* | no virtual edge among those 40 | `build/m41-gadget-asks.json` |

**How to read the word "settled".** The instrument (`tools/rigidity.py`, class `Rigidity`) does not
sample. It draws proper colourings until every pair has been *seen* both ways, and confirms the
survivors with a batch query whose UNSAT settles all of them at once; `unsettled: []` means the
candidate set emptied. So on the witnesses and the unions, **zero really means zero over every
pair** — 1,248,990 pairs on the 1581 alone. That is a strong, complete negative and it should be
respected as one.

**[measured, this stub, 2026-08-14, desktop]** The relevant populations on the 1581, from exact
addresses via `tools/gradient.py:build_addresses` (float census; the unit count reproduces the known
**7,877** exactly, which is the census's own control):

* pairs at **√3**: **3,216**
* pairs at **distance 2**: **1,092**
* all pairs: 1,248,990

All 4,308 of those were inside the settled sweep. **There is no unasked arity-2 question on the
witnesses.**

---

## §4. So what IS unasked — the two live phases

### Phase A (the informative one): **arity three, at five colours, from below**

Every from-below meter this project owns asks about a **pair**. In milestone M45 the same
observation, one field down, produced a correction — but the correction there was that the *sweep*
had been too narrow, and §3 shows that is **not** the situation here. What transfers instead is the
other half of M45, and it transfers exactly:

**[derived, kernel-checked at M45 — `Arity.lean`, verify]** A *compulsion* is a **partial colouring
that does not extend**: `m` distinct vertices, properly coloured among themselves, wearing a pattern
that no proper `k`-colouring induces. The **arity floor** is the least such `m`. And
`arityFloor_le_of_degree`: **a vertex with `k` distinct neighbours makes the all-different pattern
on them unrealizable, so the arity floor is at most `k` with no hypotheses at all.** De Grey's 1581
has vertices of degree up to **60**, far more than the five distinct neighbours the theorem asks
for. *(Read the hypothesis carefully: it needs SOME vertex with `k` distinct neighbours, not every
vertex. The 1581's minimum degree is 4 and is irrelevant — an earlier draft of this stub said
"minimum degree well above 5" and was wrong on the reason while right on the conclusion. Verify with
`tools/gradient.py:build_addresses` before repeating either.)* So **a compulsion of arity ≤ 5 is
guaranteed to exist on de Grey's graph, while its arity-2 floor is settled EMPTY.** The floor is
therefore in `{3, 4, 5}` **by theorem**, and nobody has ever asked which.

That is the calibrated-bed condition M45 required, and here it is met better than it was there: the
arity-2 answer is not merely certified, it is *complete*. **A zero at arity 3 on this object would
be a real statement about the mechanism; a hit would be the first nonzero structural reading the
from-below direction has ever produced.**

**[derived] Does an arity-3 hit help the target?** Not directly — the composition of §2 consumes a
forced-*distinct* pair, and an arity-3 compulsion is not one. What it would do: (a) tell us the
order the mechanism lives at, which four campaigns have assumed without testing; and (b) open the
generalized Act One question — *is there a configuration in which every 5-colouring forces a
monochromatic **triple** in one distance class?* That is a counting question about the triangular
lattice, registered as **a derivation to attempt, not a phase to measure**, and its answer decides
whether an arity-3 gadget is usable at all. State the honest answer either way before interpreting a
hit.

### Phase B: the closures, where the arity-2 question really is unswept

gen-1 (24,065 points) has **never** been swept, and gen-2 (284,873 points) received **40 targeted
asks**. These are the only places an arity-2 virtual edge could still be hiding. Restricted to the
two distances that matter the populations are large but finite; observe-then-confirm makes them
affordable (measured at M45: 400 harvested colourings cut 9,636 candidate pairs to 811 in 2.4 s).
Report the population size **in the headline of any negative**, which is the standing lesson below.

---

## §5. Instruments — verify each before use

* **`tools/arity.py`** (built at M45) — the arity meter. `realize(stage, k, tup, blocks, cap, enc)`
  is one pattern query; `enc ∈ {free-fwd, free-rev, pinned}` are three *sound* encodings, and
  `Arity.realizes_iff_extends` (kernel-checked) is the theorem that they ask the same question.
  `partitions(m, k)` enumerates one pattern per partition (2 at m=2, 5 at m=3, 15 at m=4).
  `harvest` is the observe pass. `arity_verdict` is the **one** place a verdict is computed and it
  structurally refuses to produce one without the evidence that would qualify it.
  **`python3 tools/arity.py --self-test` must be green before anything runs** — it carries three
  planted controls, including the explained-by-subtuple case (see §7).
* **`tools/rigidity.py`** — the arity-2 lattice whose observe-then-confirm design `arity.py`
  generalizes, plus `coverage_query`/`min_cover` (the k-set meter).
* **`tools/gradient.py`** — `build_addresses()` returns the committed 1581; also the union builder,
  the Galois conjugator, and the code that produced the 40 gen-2 asks. **Read how it chose them
  before repeating the choice.**
* **`tools/closure.py`** — the closure generations, with the M31 quadrature law enforced at find
  time (it aborts on a violating chord rather than recording one).
* **The symmetry-breaking fact that makes any of this affordable [measured, M45, desktop]:** pin a
  pattern *without naming colours* and the query stays palette-invariant, which makes
  first-occurrence palette-symmetry breaking sound on top of it — worth a factor above **8,000** at
  six colours (>162 s → 0.02 s on a 23-vertex refutation). Re-measure the factor at five colours;
  do not assume it.
* **A trap that cost a run at M45:** every function handed to a `ProcessPoolExecutor` must be
  defined at module level, or the workers cannot unpickle it.

---

## §6. Phases, in order

* **§0 — registration, committed before any instrument runs.** The exact objects with their
  fingerprints; the exact population per object, **counted and stated**; a prior per probe with the
  evidence both ways; and the sentence M43 omitted and M41 did not need: *what a flat result would
  and would not license*.
* **§1 — the census.** Per object, the number of √3 pairs, distance-2 pairs, and (Phase A) triples
  worth asking about. Exact arithmetic. This number is the denominator every negative must be
  reported against.
* **§2 — Phase A on the 1581**, then on the composed objects. Triples restricted by geometry (the
  vocabulary distances) and by the point group, observe-then-confirm, both directions per pattern,
  generous caps. Every `unknown` recorded as undecided with its cap and excluded from every summary.
* **§3 — Phase B on gen-1**, then gen-2 within a stated bounded radius. Say what was bounded.
* **§4 — controls.** A planted virtual edge (add an edge, confirm the meter fires); a planted
  innocent pair; the base-satisfiability guard on every object *before* any compulsion claim; and
  the M45 near-miss control — an arity-3 reading whose sub-pair explains it is **not** a find.
* **§5 — the verdict, written either way**, with the enumeration in the headline.

---

## §7. The discipline — non-negotiable, and why

**Registered predictions.** §0 is written and committed *before* any instrument runs. Sorted by how
they were reached, this project's a-priori derivations have survived without exception and its
post-hoc inductive readings have died without exception — roughly 7-for-7 against 0-for-10, several
of the latter refuted by our own later work.

**"Measurement generates; induction kills."** A measurement buys a candidate pattern, never a
conclusion; the conclusion is bought separately, by a derivation or by a pre-registered replication
on fresh objects. Two design consequences: prefer measurements that turn a **dial** (informative in
both directions) over hunts for a **positive** (whose null is uninterpretable — and which has come
back flat four times); and prefer **calibrated beds**, so a zero bounds the *instrument* rather than
being mistaken for a fact about the world. §4 Phase A is that principle applied: arity 2 there is
settled *complete*, so an arity-3 zero is interpretable.

**"A search run against a sufficient-but-not-necessary check measures the check, not the world" —
and its sharper second form: a sweep's negative is a statement about its ENUMERATION, and the
enumeration belongs in the same breath as the verdict.** At M43 a six-question sweep was written up
as "zero virtual edges at k = 6"; re-asked completely **on the identical stage** at M45, that object
had seven, at classes the six never reached, each decided in 7.5–15 seconds and each confirmed in
three independent encodings. The artifact's scope line had been honest; the summary sentence was
not, and the summary is what became a grokking. **This file's own first draft repeated the mistake
in the opposite direction** — it claimed M41 had asked only forty questions, when M41's sweeps were
complete and settled. Checking before asserting is the entire lesson, and it applies to the writer
of the stub as much as to the runner of the campaign.

**Failure clauses.**
* `unknown at cap` is **never** a verdict. Record it as undecided with its cap, exclude it from
  every summary, and *say so in the summary*.
* Every claim double-encoded or theorem-closed.
* Every meter run on a planted positive **and** a planted negative before its results are believed.
  A control that has not been seen to fail is not a control.
* An arity-`m` reading is **not** an arity-`m` finding until every lower-arity sub-tuple has been
  swept on the *same stage* and found free. `arity.py` withholds `minimal_arity` until then.

**HALT AND VERIFY.** If any pair at √3 or 2 comes back compelled at five colours on a genuine
unit-distance graph, **that is χ(ℝ²) ≥ 6 — the thing this project exists for.** Stop. Then, in
order: (1) confirm the stage is 5-colourable, or the reading is vacuous; (2) re-derive the object's
vertices and edges independently, from the construction rather than from a stored file — noting that
the M06-era `degrey_graph.json` and the standing loader use **different vertex orders**, which once
explained a wrong verdict; (3) confirm the two points are at distance exactly √3 or exactly 2 in
**exact field arithmetic**, never floating point; (4) re-run in all three encodings with generous
caps; (5) confirm the pair is realizable as *distinct*, or the reading is degenerate; (6) report to
Kooshi **before** attempting kernel promotion. Only then the composition, priced as an M06-scale
certificate effort before anything is promised.

---

## §8. The honest prior

**Lower than the first draft of this stub implied, and stated plainly.** The witnesses and the
composed unions are swept *complete* at arity 2 and are genuinely empty; that is a strong negative
built by a sound instrument, and M45's correction does not reach it. What remains is (a) an arity
nobody has asked at, on an object where the answer is guaranteed to be at most 5 and is known not to
be 2 — informative in both directions, which is why it is Phase A; and (b) two closure generations
that were never swept, which is ordinary unfinished work rather than a suspected error.

The one concrete reason for optimism is not an analogy but a theorem: **`arityFloor ≤ k` says a
compulsion of arity at most 5 exists on de Grey's graph, and the complete arity-2 sweep says it is
not at arity 2.** Something is there. Nobody has looked at the arity it lives at.

---

## §9. Practical notes

* **Machines.** Desktop (32 cores, 125 GB) and laptop (12 cores, 31 GB). This
  wants the desktop. `nproc` disagreeing with a number in a plan is the hardware moving, not an
  error. Record CPU seconds, minimum of three runs, with the machine named.
* **Building Lean.** *Always* `./scripts/build.sh`, never `lake build` — bare **or named**. Lake
  sizes its job pool from the machine and this project's data modules peak at ~9 GB each; an
  unrestricted build has taken the desktop down twice. `lake env lean <file>` is fine for iterating
  on one file (it builds nothing) but does **not** apply the project's options, so never conclude a
  module is green from it.
* **On any segfault, from any process: HALT and report to the user immediately.** Do not diagnose,
  do not retry. It is hardware and needs a reboot the user performs.
* **`pkill -f <pattern>` kills your own shell** — the wrapper's command line contains the pattern.
  Use a bracketed regex (`pgrep -f "m4[8]\.py"`) or resolve the PID first. The same trap silently
  disables any monitor whose command contains its own search pattern.
* **Artifacts.** One JSON per axis, schema-tagged, with the reading rule *in the schema string* and
  the bound direction *in the field name*. Different stages are different graphs: carry a
  **fingerprint** of the sorted edge list so "same object?" is a comparison rather than a judgement.
  And — the standing lesson — **put the enumeration size in the headline of every negative result.**
