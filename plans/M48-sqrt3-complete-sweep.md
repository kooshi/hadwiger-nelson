# M48 — The complete √3/2 virtual-edge sweep at five colours
#
# STUB, written 2026-08-13 at M45's close. SELF-CONTAINED: a fresh session with zero conversation
# memory should be able to subplan and run this from this file alone. Cross-references are given as
# addresses to VERIFY, never as the carrier of meaning.

---

## §1. The project, for a reader who has never seen it

**The problem.** Colour every point of the infinite plane so that no two points exactly one unit
apart get the same colour. Fewest colours? Open since 1950; the answer is 5, 6, or 7.

**This repository.** A Lean 4 proof workspace. Lean is a proof assistant: a small trusted kernel
checks every step. "Kernel-checked" below means the machine verified it from first principles.
Already kernel-checked here: at least 5 colours are needed, and 7 always suffice.

**The mission is narrow.** This project exists *only* to find new mathematics. The publication bar
is two events: possibly our own certified 5-chromatic object, and definitely **χ(ℝ²) ≥ 6 or its
refutation**. A rung that does not land is reported as not landed.

---

## §2. Why this milestone is at the front, in one paragraph

**The target.** A single finite unit-distance graph in which some two points at distance exactly √3
or exactly 2 are forced to receive **different** colours in every proper 5-colouring. Nine copies of
such a gadget, placed on the closed first shell of the triangular lattice, close **χ(ℝ²) ≥ 6**. The
rest of that composition is *already kernel-checked* (`Instances/HexShell.lean`, `Pigeonhole.lean` —
verify both). Such a forced-different pair is called a **virtual edge**: an edge the colouring theory
already believes in, though no unit distance joins the two points.

**What was asked, and how little of it.** Milestone M41 asked exactly this question and recorded
**"0 virtual edges in 40 targeted asks"** at exact √3 and 2 pairs (verify: `build/m41-*.json`,
`plans/M41-k5-gradient.md` §R). *Forty questions.*

**Why forty is now known to be too few.** Milestone M43 ran the same shape of measurement one field
down — six questions, "force colour(0,0) = colour(d) at the six smallest non-edge classes" — and
wrote the answer as **"zero virtual edges at k = 6"**, a statement about the object, which became a
minted grokking (G28: "the forcing does not factor"). At M45 that stage was re-swept completely.
**M43's own six asks reproduced exactly** (6 realizable, 0 compelled) — *and the same stage carried
seven virtual edges*, at offset classes the six never reached, each decided in **7.5–15 seconds**,
each confirmed in three independent encodings with all controls green. The negative measured the
enumeration, not the object.

**So: the identical too-few-questions shape sits, unexamined, on the one question this project exists
to answer.** M48 asks it completely.

---

## §3. The question, stated exactly

> For every object we hold, and every pair of its vertices at plane distance exactly √3 or exactly 2:
> **is there a proper 5-colouring giving them the same colour?** If for some pair the answer is no,
> that pair is a virtual edge and **χ(ℝ²) ≥ 6 follows** by the composition above.

Two things make this tractable where a full pair sweep would not be:

* **The population is small.** Only pairs at those two distances matter. On a witness of ~1,600
  vertices the number of such pairs is thousands, not the ~1.25 million all pairs would give.
* **Observe-then-confirm.** Harvest a few hundred proper 5-colourings first; each one exhibits a
  realized pattern for *every* pair at once, so only never-observed pairs reach the solver. Measured
  at M45 on a comparable object: 400 harvested colourings in 2.4 s cut 9,636 pairs to 811 candidates.

---

## §4. The objects, with their addresses

Sweep all of them; they are different graphs and a result on one says nothing about another.

* **de Grey's 1581-vertex 5-chromatic witness** — the original, kernel-certified here. Locate it
  (`build/` and `Proofs/HadwigerNelson/Instances/DeGrey*`); note M34 recorded that the M06-era
  `degrey_graph.json` and the standing loader use **different vertex orders**, which once explained a
  wrong verdict — check the order before trusting any index.
* **The 791-vertex forcer** (`build/m30-forcer791.json`) — de Grey's sub-object, and the one place
  arity-2 rigidity was *ever* found nonzero (six forced pairs at four colours). Its minimum degree is
  4, so it is also the cheapest sanity target.
* **Heule's 510 and 553** — the other certified witnesses.
* **The three Galois-conjugate witnesses minted at M41** (W^[3], W^[5], W^[3,5]) and the
  hetero-dimers — new composed matter, and the only place any campaign ever read a nonzero signal
  (a 10× solver-effort excess, single-sample).
* **The closure generations** — gen-1 (24,065 points) and gen-2 (284,873 points, 1,477,824 edges).
  Gen-2 is large; sweep the √3/2 pairs *within a bounded radius* and say what was bounded.

---

## §5. Instruments that already exist — verify each before use

* **`tools/arity.py`** (new at M45) — the meter. `realize(stage, k, tup, blocks, cap, enc)` answers
  one pattern query; `enc` ∈ `free-fwd | free-rev | pinned` are three *sound* encodings, and
  `Arity.realizes_iff_extends` (kernel-checked) is the theorem that they ask the same question.
  `harvest` is the observe pass. `arity_verdict` is the ONE place a verdict is computed and it
  structurally refuses to produce one without the evidence that would qualify it.
  `python3 tools/arity.py --self-test` must be green before anything runs.
* **`tools/rigidity.py`** — the older pair meters, and the `Rigidity` lattice whose observe-then-
  confirm design `arity.py` generalizes.
* **`tools/gradient.py`** (M41) — the witness/closure/union builders and the Galois conjugator.
  It is what produced the 40 asks; read how it chose them before repeating the choice.
* **`tools/closure.py`** — closure generations, with the quadrature law enforced at find time.

**The symmetry-breaking fact that makes this affordable** (measured at M45, desktop): pinning a
pattern *without naming colours* keeps the query palette-invariant, which makes first-occurrence
palette-symmetry breaking sound on top of it — worth a factor above **8,000** at six colours
(>162 s → 0.02 s on a 23-vertex refutation). At five colours the factor will differ; measure it.

---

## §6. Phases

* **§0 — registration, committed before any instrument runs.** The exact objects and their
  fingerprints; the exact pair population per object, *counted and stated*; a prior per object; and
  the sentence that M43 and M41 both omitted: **what a flat result would and would not license**.
* **§1 — the population census.** For each object, enumerate every pair at exactly √3 and exactly 2,
  in exact arithmetic. Report the count. This number alone is worth having: it is the denominator
  the "40 asks" should have been reported against.
* **§2 — the sweep**, observe-then-confirm, both directions per pair, caps generous, every `unknown`
  recorded as undecided and excluded from every summary.
* **§3 — controls.** A planted virtual edge (add an edge and confirm the meter fires); a planted
  innocent pair; the base-satisfiability guard on every object; and the M45 near-miss control — a
  compulsion whose sub-structure explains it is not a find.
* **§4 — the verdict, written either way.** A hit is **χ(ℝ²) ≥ 6** and everything stops (see below).
  A *complete* flat sweep is a genuinely stronger statement than a flat sample of forty, and it is
  worth having: it would say the from-below gadget does not exist in any object we hold, which
  redirects the hunt to construction rather than search.

---

## §7. HALT AND VERIFY — read this before running anything

If any pair at √3 or 2 comes back compelled at five colours on a genuine unit-distance graph, **that
is χ(ℝ²) ≥ 6 — new mathematics, and the thing this project exists for.** Stop. Do not interpret, do
not extend, do not write it up. Then, in this order:

1. Confirm the stage is 5-colourable (a compulsion on an uncolourable graph is vacuous).
2. Re-derive the object's vertex set and edge list independently, from the construction rather than
   from a stored file.
3. Confirm the two points really are at distance exactly √3 or exactly 2, in **exact field
   arithmetic**, not floating point.
4. Re-run in all three encodings, with generous caps.
5. Confirm the pair is realizable as *distinct* (else the reading is degenerate).
6. Report to Kooshi **before** attempting the kernel promotion.

Then, and only then, the composition: `hexShell_pigeonhole` + nine copies + the M34 composition
genre. Budget it as an M06-scale certificate effort and price it before promising it.

---

## §8. The honest prior

Low-to-moderate. Four campaigns have read flat, and while M45 showed the *sampling* was far too
sparse to support the conclusions drawn, sparse sampling does not imply a hit exists. What is high
confidence is that the answer is worth having either way, and that the current state of the record —
a headline negative resting on forty questions — is not a state this project should stay in.

The one concrete reason for optimism: **the M45 correction found seven compulsions that cost eight
seconds each.** They were not hard to find. Nobody had asked.

---

## §9. Practical notes

* **Machines.** Desktop (32 cores, 125 GB) and laptop (12 cores, 31 GB). This wants the
  desktop. Record CPU seconds with the machine named.
* **Building Lean.** *Always* `./scripts/build.sh`, never `lake build` — bare or named.
  `lake env lean <file>` is fine for iterating but does not apply the project's options.
* **On any segfault, from any process: HALT and report to the user immediately.** It is hardware.
* **`pkill -f <pattern>` kills your own shell** — the wrapper's command line contains the pattern.
  Use a bracketed regex (`pgrep -f "m4[8]\.py"`) or resolve the PID first.
* **Multiprocessing:** every function handed to a `ProcessPoolExecutor` must be defined at module
  level, or the workers cannot unpickle it. This cost a run at M45.
* **Artifacts.** One JSON per axis, schema-tagged, reading rule *in the schema string*, bound
  direction *in the field name*, and — the M45 lesson — **the enumeration size in the headline of
  every negative result.**
