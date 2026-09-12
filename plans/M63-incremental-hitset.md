# M63 — the per-iteration hitting-set solve: where the cost is, and what removes it

*Written 2026-09-11. Nothing under `tools/` was edited: the work ships as one new module,
`tools/parts_hitset.py`, wired into nothing. Two five-hour reductions were executing
`tools/parts_reduce.py` throughout and were not touched. Advisor: Poros
(`plans/POROS-2026-09-11-m63-hitset.md`), whose card 1 corrected the mechanism in §2 and whose card 3
supplied the transitivity argument in §7.*

## 1. The attribution, measured directly — and it splits by PHASE and by SIZE

`plans/M63-phaseC-joint-stage.md` §R2.3 put the SAT oracle at 27% of the joint runs and attributed the
other 73% to the hitting-set solve **by elimination**. Measured here, never by subtraction:

A reduction has two phases, and they behave oppositely.

| stage / phase | atoms | \|Y\| | level | SAT oracle | hitting set |
|---|---|---|---|---|---|
| S166 order-3 rung, whole run | 55 | 129 | 21 | **99.6%** | **0.2%** (0.1 s of 77 s) |
| D1b, **finding** the optimum (it 1–294) | 411 | 473 | — | **~95%** | **~2%** (0.008 s per solve) |
| D1b, **enumerating** the level (it 294–19,788) | 411 | 528, frozen | 19,572 | **~1%** | **~99%** (0.79 s per solve) |
| C4a joint stage, **finding** the optimum | 576 | 1,989 | none yet | ~27% | **~73%** (18.1 s per solve) |

**So the 73% is real, and it is not one phenomenon.** The hitting set is the wall when *either* the
correction-set family is large (C4a: 1,989 sets, 18.1 s per solve) *or* a level is being enumerated
(D1b: 19,572 blocking clauses, 0.79 s per solve). It is **not** the wall when neither holds — at 55
atoms it is 0.2%, and D1b's own climb to its optimum is 95% oracle. Every earlier cost argument in this
milestone was calibrated on stages of the third kind.

**And the incumbent has already refuted itself, on disk, unread.** `build/m63d/D1b.log`'s launch
header carries a pre-registered forecast: *"the L451 level at 450 atoms took 605 s over 16,683 asks, so
20-90 min ASSUMING those ask means hold here."* The assumption **held** -- the refusing mean came in at
0.0093 s, better than L451's implied 0.036 s per ask -- and the forecast is wrong by **2.5x the upper
end and climbing**: 3.77 h at 20,027 iterations, 0.546 s per ask against L451's 0.036 s, at *fewer*
atoms with *faster* asks. A forecast that named its assumption, had the assumption confirmed, and missed
anyway, because it counted **asks**. That is the same error as the 27/73 by elimination, and it is
stronger evidence than any replay of mine: it is the incumbent's own launch note failing against the
incumbent's own log. (Found by Poros, card 4.)

**The direct method, since the point was that nobody had measured it.** The S166 row is a whole fresh
run of the real, unmodified `reduce_stage`, with the MaxSAT class wrapped in a timer that adds no
behaviour — chosen over instrumenting a live job precisely because a resumed run would execute edited
code while its checkpoint hashes cover only the problem. The other rows time the solve at prefixes
replayed out of the runs' own checkpoints, cross-checked against the bounds those runs printed live.

## 2. The mechanism — and it is a DIFFERENT one in each phase

**Finding the optimum (C4a).** `RC2` is core-guided: it climbs from cost 0, one unsatisfiable core at a
time, so a solve whose optimum is `w` costs about `w + 1` SAT calls. Here the optimum is nearly the whole
graph — 503 of 576 atoms — so **every iteration pays 504 SAT calls to re-derive the bound it already
knew**. Measured: 504 calls, 18.11 s total, of which **18.10 s is inside the oracle**. The climb is the
cost.

**Enumerating the level (D1b).** Here the same story is **false**, and assuming it was the error Poros
caught. `Y` is frozen (473 sets at the optimum, 528 at iteration 19,602 — 55 new sets across 19,300
iterations); what grows is the level `E`. The rebuild constructs one blocking clause per minimum, each
373 literals — **7.3 million Python list elements per iteration**. Timed at a 19,572-minima prefix:

| | build the `WCNF` | `RC2` init | actually solve | total |
|---|---|---|---|---|
| cost | **0.637 s (81%)** | 0.094 s (12%) | **0.061 s (8%)** | 0.791 s |

and the SAT calls are a constant 374 at every iteration. **Four fifths of the enumeration wall is Python
formula construction that never reaches a SAT call.** The consequence matters for what to build: in this
regime *any* engine that stops rebuilding wins, and the core reuse is beside the point.

**The law this implies, which forecasts where a ratio cannot.** Both mechanisms are O(|E|) per
iteration, so the enumeration phase is quadratic in the size of the level:

    enumeration wall-clock  ~  c . w* . |E|^2 / 2

Fitting `elapsed = a + b.i^2` to two D1b ticks (i = 294 and i = 19,602) gives b = 3.36e-5, and the
**held-out** points land within about 1%: i = 8,998 predicts 2,845 s against 2,861 observed (-0.6%),
i = 12,177 predicts 5,108 against 5,171 (-1.2%), i = 17,308 predicts 10,194 against 10,312 (-1.1%). A
linear fit is off by 56% and 108% at the same points. *Range of validity, stated:* below about i = 5,000
the quadratic over-predicts by 13-16%, where the constant term and the oracle still matter -- the law
describes the hitting-set component, and total runtime is oracle + component, which is exactly why §1's
table splits by size. The completed levels on disk that calibrate it: |E| = 48, 82, 96, 360, 3,264, and
D1b at 19,853 and rising.

Adding each blocking clause **once** is precisely what turns |E|^2 into |E|, which is why the fix's
0.1-0.2 ms per iteration is flat in |E| rather than merely smaller. (Law: Poros, card 5.)

## 3. Three engines, and the honest verdict is regime-dependent

All in `tools/parts_hitset.py`; `batch` reproduces today's clause list in today's order, so a disagreement
with it is a defect in my transcription and the replay would show it.

| engine | what it does | D1b enumeration (19,789 iterations) | C4a optimisation (600 iterations) |
|---|---|---|---|
| `batch` | today: fresh `WCNF` + fresh `RC2` per solve | 51.6 s per 1,500 → **hours** at full length | 245.9 s |
| `incremental` | one `RC2`, cores and relaxations carried | **3.5 s total, 186×**, 0.22 GB | 282.5 s at it 400 — **0.4×, it LOSES** |
| `incumbent` | decision: "is there a hitting set ≤ the incumbent?", one cardinality constraint, ~1 SAT call per iteration | **2.7 s total**, 19,823 calls | slower early (32.1 s by it 200); see §8 |

**Incrementality is not a uniform win, and saying so was the point of measuring.** In the
optimum-finding phase the accumulated relaxation machinery makes each of its few calls enormously more
expensive: over C4a's first 600 iterations it used **257× fewer SAT calls and 2.5× more CPU**. That is
the same lesson as §6's presolve negative — the calls are not the cost, the difficulty of each call is.

**Soundness of the incremental engine.** A core is an implicate of the hard clauses present when it was
extracted; adding hard clauses only strengthens the formula, so an earlier core stays a core and the
accumulated cost stays a valid lower bound. The loop then raises it until the oracle returns SAT, which
certifies optimality for the current formula. Exact at every step. The decision engine is sound for the
matching reason: the previous optimum is a lower bound because the family only grows, so SAT at that
bound means the optimum is exactly it.

## 4. Equivalence — identical, and watched failing, including on a bug of my own

`tools/parts_hitset.py --self-test`: **17 controls, all fire.**

- **Positive control** — batch and incremental agree, **identical over 120 iterations**, on a weighted
  instance whose bounds actually move (32 distinct values); a constant sequence would agree trivially.
- **D1b** — batch against incremental, **identical over 1,500 iterations**.
- **C4a** — batch against incremental, **identical over 600 iterations**, and both agree with the live
  run's own logged bounds at every tick inside the window (44 of them).
- The decision engine agrees with batch iteration for iteration, and **refuses a weighted instance**
  rather than counting orbits as vertices.

**The planted faults, and the one that did not fire.** The first dropped-constraint control skipped a
random correction set and read `identical` — **correctly**: the clause it dropped was implied by the
others. A dropped constraint moves a bound only when it *binds*. Both halves are now controls:
`skip-corr:30` drops a clause that binds by construction and the check goes **red**, with every later
bound differing by **exactly** the weight that clause forced; `skip-corr:61` drops a redundant duplicate
and the check reads `identical`, recorded as the **stated blind spot** — this check sees faults that move
a bound and no others. A `stale` answer and `unit-weights` both go red. `compare([], [])` and a truncated
sequence read **`not-compared`, which is a failure and never a pass**.

**And it caught a real one.** The decision engine, minutes after I wrote it, reported bounds 3–6 **too
high** at all 618 live-log ticks — the direction that would overstate a lower bound and make an
optimality claim unsound. Cause: an attribute-name collision. `_Engine.add_correction` increments
`self.n_added` to count correction sets, and I reused that name for the totalizer's clause counter, so
the engine skipped the first *k* totalizer clauses and the cardinality constraint was never enforced;
it was returning the size of an arbitrary model. Renamed, re-measured, now identical. **The check was
not ornamental: it caught an unsound engine written by the person who also wrote the check.**

Input guards, watched failing on real files: a **real rung-3 checkpoint is refused** rather than having
unit weights guessed for it, and a checkpoint whose iteration count cannot be reconciled with its harvest
is refused rather than reconstructed — the second caught a **genuine** case unprompted, a checkpoint
whose `require_any` change had reset the iteration counter while keeping the harvest.

## 5. What this does NOT establish

1. **Component, not end-to-end.** Every number is the hitting-set solve on a *recorded* clause sequence.
   No loop was run with a new engine.
2. **Same bound, different minimum.** The optimum weight is unique; the argmin is not. Over C4a's first
   151 iterations the weight agreed **151/151** and the argmin **6/151**. Swapping the engine in keeps
   every bound and changes which candidate is asked next at nearly every iteration.
3. **D1b's replay order is canonical, not the trajectory** — the stored state holds `Y` and the minima
   but not their interleaving. C4a's order *is* exact, and the module checks the identity rather than
   assuming it.
4. **Wall-clock on a box running six heavy jobs**, including the two live reductions.

**Why (2) does not sink the enumeration forecast** (Poros, card 3). In the enumeration phase the
iteration count is essentially the size of the level, which is a property of the problem and not of the
engine: at D1b, 19,447 of ~19,300 iterations ended in a new minimum and only ~55 in a new correction set.
A different argmin changes *which* minimum is found when, not *how many there are*. So the component
measurement does carry to the phase — to within the 0.3% of iterations that harvest instead. In the
optimum-finding phase no such argument is available, and none is claimed.

## 6. What is NOT the lever — measured and rejected

On C4a's recorded family, same instance, optimum 503 every time:

| formulation | SAT calls | CPU |
|---|---|---|
| as posed today | 504 | 15.77 s |
| `exhaust=True` | 579 | 29.63 s — **worse** |
| forced atoms eliminated (423 forced, **153 free**) | 81 | **15.18 s — no win** |
| `adapt=True` (AtMost1 detection) | **26** | **6.26 s** |

**Presolve is not the lever, and it is the interesting negative.** Eliminating the 423 atoms that
singleton correction sets force cuts the calls 6× and the time not at all: 187 ms per call against 31 ms.
This also answers the natural objection that *153 binary variables is small for any exact solver* — it
is, and the 153-variable core is still where the time goes. `adapt` is real but is a property of the
**cold** solve, so it ships as `batch-adapt` / `incremental-adapt` and the incremental engine switches it
off after the first solve. The path it helps is a **resume**, which pays exactly one cold solve.

## 7. Recommendation

- **Level enumeration — adopt, large win, either non-rebuilding engine.** 186× (`incremental`) or
  ~19,000 iterations in 2.7 s (`incumbent`) against hours. Since §2 shows four fifths of that regime is
  formula construction, the win does not depend on which of the two is chosen.
- **Optimum-finding at large `Y` (C4a-scale) — do NOT adopt plain incremental**: measured 2.5× slower.
  Use `batch-adapt` (2.5× on the cold solve) until §8 settles the decision engine there.
- **Phase G's dominant cost is exactly this regime, and the law above prices it.**
  `plans/M63-phaseG-bases-and-rotations.md` says the accumulator a new base or rotation needs is *"the
  complete level, ~10^4 s with no known ceiling"*, that *"the census is not the expensive part and never
  was — the expense is P-G7"*, and that P-G7 is **"unpriced until phase F's ladder lands; do not start it
  on a guess."** So: **manufacturing a first accumulator is quadratic in the level size under the
  incumbent engine and linear under this one.** At D1b's current level that is 3.8 h against roughly two
  minutes of oracle; at |E| = 10^5 it is about **four days against about eleven minutes**. A targeted run
  that *refutes* exits cheaply anyway, and one that *succeeds* still enumerates the level at `w*` — so the
  success branch, the one that yields a record candidate, pays the quadratic too. (I had hedged that
  targeted runs might gain nothing; Poros checked the phase-G plan and the hedge was wrong.)

## 8. Not done, and what each would take

- **The decision engine on C4a's full family** was still running when this was written; it is slower than
  batch over the first 200 iterations (32.1 s against 2.6 s), because the totalizer over 576 literals to
  a bound near 450 is expensive to build. Whether it wins over the full 1,566 — where batch reaches ~20 s
  per iteration — is unsettled. Result to be appended here.
- **Integration into `reduce_stage`** — deliberately not done: two live runs were executing that file. A
  ten-line change at a configuration freeze, plus the decision in §5.2. Two details that will bite
  whoever does it: (a) there are **three** append sites, not two — `state.blocked` is a *property* unioning
  `minima` **and** `undecided`, so the undecided branch must also reach `block()`, and it does not look
  like a blocking site; (b) a resumed run rebuilds the engine from its checkpoint and pays one cold solve,
  which is the path the `adapt` flag exists for, and P-G7 runs are long enough to be killed. (Both from
  Poros.)
- **Registering the self-test** in `scripts/regen-check.sh` beside the other twelve — one line, left
  alone because that gate is shared and other writers are active.
- **Weights above rung 1** cannot be read from a checkpoint; the module refuses rather than guessing.
