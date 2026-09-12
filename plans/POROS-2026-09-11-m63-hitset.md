# Poros — M63, the incremental minimum-hitting-set solve (2026-09-11)

*Advisor's record. The engineer is at `a1c1cf3baa77a7b9b`; its artifacts are
`plans/M63-incremental-hitset.md` and `tools/parts_hitset.py`, neither of which I touch. I launched no
computation and inspected no process: every number below is read from files that already existed —
principally `build/m63d/D1b.log`, a live run's own log, and `data/m62/m63-*.json`. Kooshi named four things
to press on; they are cards 1, 2, 5 and 6 below.*

**Outcomes, so a reader need not reconstruct them.** Of seven cards, four changed the artifact: the
mechanism hunch in card 2 was measured and **confirmed** (formula construction 81%, `RC2` init 12%, search
8%); card 5 caught a component that was absent from the record because it was twenty minutes old, and it
turned out to be **unsound in the flattering direction**; card 7's argument was adopted as the thing that
converts a component measurement into a phase forecast; card 3's falsified forecast went into §1 above the
replays. **Two of my claims were wrong and are corrected in place**: I over-generalised the phase split
from D1b (card 1, corrected), and I raised a phases-F/G worry the record already answers (card 4,
withdrawn), and three more of mine were killed by their own falsifiers the same night (card 9). The ledger
closes at eight hunches, **four confirmed and four killed, none open**. The optimisation phase is reported
as **not landed** — four formulations, one measured reason — which is the honest result and the one this
project's standard asks for; card 9 states the scope of that negative, which is narrower and more useful
than "no engine wins".

---

## evidence inventory

- `plans/M63-incremental-hitset.md` (23:16) — read against: the four questions Kooshi named — surprised: yes; it answers three already, and omits an engine its own code ships
- `tools/parts_hitset.py` (23:21, being edited as I read) — read against: one incremental engine plus an equivalence check — surprised: yes; **three** engines, and the third is a different diagnosis, in neither document and in no control
- `tools/parts_reduce.py` `reduce_stage` lines 511–585 — read against: two phases, optimisation then enumeration — surprised: yes; **one** loop, `w_star` set at the first refusal, no separate enumeration code path
- `tools/parts_reduce.py` `_resume_control` lines 749–806 — read against: the project gates on trajectory identity — surprised: yes; it gates on the LEVEL only and says in terms that a fresh solver may return a different model, which de-fangs the plan's §7.1
- `build/m63d/D1b.log` — read against: the plan's D1b row, 2.1% oracle and 0.61 s per iteration — surprised: yes, twice; the split is sharper than claimed, and the log's own header carries a pre-registered forecast this run has already falsified
- `data/m62/m63-L451-reduction.json`, `m63-M6B403-reduction.json`, `m63-D1a-A451-rung3.json` — read against: level sizes comparable across stages — surprised: yes; 82, 360, 3,264, and D1b at 19,447 and still running — the level size is the free variable nobody tracks
- `tools/parts_hitset.py` `_self_test` lines 549–655 — read against: the controls discriminate — surprised: yes; they do, with one exception, and the exception is the regime the module exists for
- `plans/M63-phaseG-bases-and-rotations.md` lines 421, 432, 437, 625 — read against: nothing; I raised a question I should have read the answer to — surprised: yes; it names the complete level as the accumulator and P-G7 as the phase's dominant cost, explicitly unpriced
- `plans/M63-phaseC-joint-stage.md` §R2.3, where the 27/73 by-elimination attribution was minted — read against: nothing yet — surprised: unread

---

## card 1 — which phase the cost is in, measured on the incumbent, from a file that already existed

question: which-phase-carries-the-cost
  evidence: build/m63d/D1b.log tick lines. Optimum at iteration 127, t=120 s. At it 294 / t=126 s the
    running ask means give total oracle time 2954*0.0191 + 550*0.1145 = 119.4 s of 126 s elapsed.
    At it 19,637 / t=13,083 s they give 4392*0.014 + 20054*0.0093 = 248.0 s of 13,083 s.
  expected: the plan's §1 row for D1b — oracle 2.1% of wall, hitting set the residual — undifferentiated
    between the two phases
  ask: is the hitting-set cost in the phase that finds the optimum or the phase that enumerates the level?
  if enumeration: the incremental engine is aimed at the right phase, and a target-refuted run — which
    never reaches an optimum — gets ~5%, not 186x; say so in §1 and check which regime phases F and G run
  if optimisation: the engine fixes the cheap part and the wall stands
  answered by: the record — the log above, already on disk
  cost: zero
  rank: 1

**Answer, at D1b: enumeration, overwhelmingly, and the split is far sharper than 27/73.**

| phase | iterations | wall | oracle | oracle share |
|---|---|---|---|---|
| phase1 + climb to the optimum | 1 → 294 | 0 → 126 s | 119.4 s | **~95%** |
| level enumeration | 294 → 19,637 | 126 → 13,083 s | 128.6 s | **~1%** |

**CORRECTED, by the engineer, and the correction is right — "at D1b" is load-bearing.** I generalised from
one stage, and D1b is the stage where `Y` happens to be small.
The true statement is that the hitting set is the wall whenever **either** `|Y|` is large **or** a level is
being enumerated, and these are *two mechanisms*:

| stage / phase | \|Y\| | per solve | hitting-set share | mechanism |
|---|---|---|---|---|
| D1b, finding the optimum | 473 | 0.008 s | ~2% | — (oracle-bound) |
| C4a, finding the optimum | 1,989 | 18.1 s | **~73%** | the core-guided climb, genuinely in the optimisation phase |
| D1b, enumerating | 528 | 0.664 s | **~99%** | formula construction over 19,447 blocking clauses |

So "the cost is in enumeration" is false in general; "the cost is in enumeration *at D1b*" is what my
evidence supported. The engineer's two-mechanism statement is the correct one and is now in its §2, and it
leaves the optimisation regime genuinely open — card 8.

Two consequences follow, one standing and one withdrawn.

1. **For Kooshi's worry, the answer is the reassuring one.** He feared the cost lived in enumeration while
   the engine was aimed at optimisation. In fact the loop has no such split — `reduce_stage` is a single
   `while True` whose solve is the same code before and after `w_star` is set — and the cost is in
   enumeration, which is exactly where the engine's measured win is (the plan's D1b replay is the
   enumeration regime: 526 correction sets and 18.5k blocking clauses).
2. ~~**For the engineer's headline, the answer is a correction.** The engine buys nothing for a run that
   exits at `target_lb`, so if phases F and G are mostly targeted decisions the 186× is aimed at the wrong
   runs.~~ **WITHDRAWN — I raised a worry the record already answers, and should have read it first.**
   `plans/M63-phaseG-bases-and-rotations.md` line 625 names the accumulator a new base or rotation needs as
   **the complete level** ("~10⁴ s with no known ceiling"); line 421, *"the census contains no hitting-set
   solve and no level enumeration. Only P-G7 touches the reduction loop"*; line 437, *"The census is not
   the expensive part and never was. The expense is P-G7."* A targeted run that *refutes* exits cheap
   anyway, and one that *succeeds* still enumerates the level at `w*` (`data/m62/m63-map-A412/log-…` ends
   `next candidate weighs 374 > 373: the level is complete [187s]`) — and a success is the case that
   matters, since a success is a record candidate. The engine is aimed at phase G's dominant cost.

---

## card 2 — the cost law, which is better than the speedup ratio, and is confirmed to 1%

question: what-is-the-cost-law
  evidence: build/m63d/D1b.log, fitting elapsed(i) = a + b*i^2 to its tick lines at i=294 (126 s) and i=19,602 (13,041 s)
    gives b = 3.362e-5, a = 123 s. Held-out interior points: i=12,177 predicted 5,108 s, OBSERVED 5,171 s;
    i=17,308 predicted 10,194 s, OBSERVED 10,312 s. A linear model fitted to the same two endpoints
    predicts 8,072 s at i=12,177 against 5,171 observed.
  expected: nothing pre-registered; the plan reports a speedup ratio, not a law
  ask: is enumeration wall-clock quadratic in the number of minima?
  if quadratic: the fix is exactly the right SHAPE -- O(|E|^2) -> O(|E|) -- and any future stage can be
    forecast from its level size before it is launched
  if not: the 186x is an observation at one size and forecasts nothing
  answered by: the record -- the two held-out points above
  cost: zero
  hunch: quadratic, because the loop rebuilds every blocking clause every iteration
  falsifier: an interior point the quadratic misses by more than the linear model does
  rank: 2

**The quadratic model fits two held-out interior points to ~1%; the linear model is off by 56%.**

    enumeration wall-clock  ≈  c · w* · |E|² / 2,   c ≈ 1.8e-7 s per literal at D1b

This is worth more than "186×" for three reasons.

- **It forecasts.** The four completed stages on disk have level sizes 82, 360, 3,264 and D1b's ≥19,447
  (`data/m62/m63-D1a-A451-rung3.json`, `m63-M6B403-reduction.json`, `m63-L451-reduction.json`). A future
  stage with |E| ≈ 10⁵ costs the batch engine 13,083 × (10⁵/19,447)² ≈ **4 days**; the incremental engine,
  being linear, costs roughly the oracle alone — about **11 minutes**. That is the product argument, and
  it is stronger than the one the plan makes.

  **And it prices a stub the record calls unpriceable.** `plans/M63-phaseG-bases-and-rotations.md` row
  P-G7 — *manufacturing a first accumulator for a new base or rotation*, the phase's dominant cost —
  carries the note **"unpriced until phase F's ladder lands; do not start it on a guess."** An accumulator
  is a complete level enumeration, so the law prices it now, from data already on disk, without waiting
  for phase F. The headline I would put at the top of the plan in place of "186×":

  > *P-G7 is quadratic in the level size under the incumbent engine and linear under this one. At D1b's
  > current level size that is 3.6 hours against about two minutes of oracle; at |E| ≈ 10⁵ it is four days
  > against eleven minutes.*

  That reframes the work from "a 186× speedup on a component" to "the thing that made phase G
  unpriceable is removed, and here is the price" — in the phase stub's own words.
- **It explains the D1b header's own forecast miss** (card 3).
- **It is the right shape for the fix.** Adding each blocking clause once turns |E|² into |E|. The plan
  says "quadratic in the worst possible place" and then reports a ratio; the law is the sentence that
  makes the ratio inevitable rather than measured.

*What the law does **not** settle:* whether the per-iteration O(|E|) term is the Python-side rebuild
(`for b in state.blocked: w.append([-(a+1) for a in b])` — 19,447 clauses × 373 literals = 7.25 M list
elements per iteration) or `RC2`'s 374-call climb traversing a growing formula. Both are O(|E|) per
iteration and both give the quadratic. The fitted coefficient, 180 ns per literal, is the right order for
the rebuild and fast for 374 solver passes, which is why I lean to the rebuild — but that is a hunch.

hunch: the-cost-is-the-rebuild-not-the-climb
  claim: a majority of D1b's 0.664 s/iteration is spent constructing the WCNF and loading it into a fresh
    solver, before any SAT call runs
  basis: measured
  falsifier: timing WCNF construction alone at a recorded 19k-minima prefix and finding it well under 0.1 s
  registered: 2026-09-11
  status: confirmed (by replication — the engineer ran exactly the pre-registered falsifier on a fresh
    object, a 19,572-minima D1b prefix:
    build the WCNF 0.637 s = 81%, RC2 init 0.094 s = 12%, actual search 0.061 s = 8%, total 0.791 s, SAT
    calls a constant 374. The engineer's §2 had asserted the climb without excluding the rebuild and now
    carries two mechanisms, one per phase.)

The coefficient predicted this before the measurement: 180 ns per literal is a Python list comprehension
and a clause append, not 374 solver passes. It matters for the **story**, not the fix: the plan's §2 and the module docstring both tell the mechanism
as the core-guided climb over a growing `Y`, and at D1b **`Y` is frozen** — 473 correction sets at it 294,
528 at it 19,602, 55 new sets across 19,300 iterations — while `minima` goes 159 → 19,447. The family that
grows in the regime the engine is for is **E, not Y**. §2 currently asserts the climb without having
excluded the rebuild, and the D1b numbers point the other way.

---

## card 3 — the forecast this run already falsified, sitting unread in its own header

`build/m63d/D1b.log` line 4:

> `forecast   phase 1 ~ 8 s …; the level is UNMEASURED at this atom count -- the L451 level at 450 atoms
> took 605 s over 16,683 asks, so 20-90 min ASSUMING those ask means hold here, which is exactly what
> C4.0 measures and may refute`

That is a pre-registered prediction with its assumption named. The run is at **3 h 38 min** and climbing.
And the assumption **held** — the ask means came in *better* than assumed (0.0093 s refusing against L451's
implied 0.036 s/ask). So:

| | asks | seconds | s per ask |
|---|---|---|---|
| L451 (450 atoms, complete) | 16,683 | 605 | 0.036 |
| D1b (411 atoms, running) | 24,446 | 13,083 | **0.535** |

**15× worse per ask, at fewer atoms, with faster asks.** The forecast missed by ≥2.4× and rising, and it
missed for one reason: *it counted asks*. That is the same mistake as the 27/73-by-elimination attribution
and it is now falsified by a live run against its own written expectation — which is a far stronger receipt
than any replay, and it is free.

The mechanism the law supplies: L451's level had **3,264** minima and D1b's has **≥19,447**. Extrapolating
on atom count (450 → 411) when the cost is quadratic in level size (3,264 → 19,447) is a 35× error in the
quadratic term. **Forecast on |E|, never on atoms.**

*Recommendation to the engineer:* this belongs in §1 as the attribution's strongest evidence, above the
replays. A pre-registered forecast that failed, with its stated assumption confirmed and its real cause
identified, is the cleanest thing in this whole file.

---

## card 4 — the level may not be bounded, and speed does not bound it

D1b runs with `max_minima 0, phase2_wall 0.0` — no cap, no wall. It has produced 19,447 minima in 19,510
iterations: essentially every iteration yields one, with **no sign of slowing**. The union of the minima
froze at 388 atoms by the 60th minimum and `Y` froze at 528; 339 of 411 atoms are critical, so the level is
the set of ways to choose 34 further atoms from the 49 non-critical ones that appear, subject to 528
correction sets. There is nothing in the record that bounds how many that is.

The engine changes the arithmetic from |E|² to |E|, which is the difference between a run that cannot
finish and one that can — **that is the real product claim, and the plan does not make it**. But it does
not answer the prior question:

question: how-big-is-this-level
  evidence: build/m63d/D1b.log at 19,447 minima and rising linearly in iterations, against
    data/m62/m63-L451-reduction.json 3,264, m63-M6B403-reduction.json 360, m63-D1a-A451-rung3.json 82.
    No stage record carries a level-size forecast.
  expected: level sizes of the same order across stages of the same rung
  ask: does anything bound |E| for a rung-1 stage, or is a level enumeration an unbounded ask that has so
    far been bounded only by which stages happened to be small?
  if bounded: the engine converts every future stage from days to minutes and the wall is gone
  if unbounded: the engine buys one order of magnitude of stage size and the wall returns; the outer loop
    needs a rule for using a TRUNCATED level, and `max_minima` stops being a budget and becomes a design
    parameter
  answered by: the engineer / the M63 record -- does Parts's loop need all of E, or a sample of it?
  cost: a reading, not a run
  rank: 5

I flag rather than press this: it is outside the engineer's brief and belongs to whoever owns phases F
and G. But the quadratic law makes it answerable in advance for the first time, which is new.

---

## card 5 — `IncumbentHittingSet` is in the code, in neither document, and in no control

`tools/parts_hitset.py` registers three engines. The third:

> *"The two engines above both answer the question 'what is the optimum?' from scratch every time … both
> are bad for the same underlying reason: **the SAT calls are not the cost, the difficulty of each call
> is.**"*

That is a **different diagnosis** from the one `plans/M63-incremental-hitset.md` headlines, and it is
arguably the better formulation: one SAT solver, one incremental totalizer, one call per iteration that
does not move the bound. It appears nowhere in the plan, nowhere in the module's own headline docstring,
and `grep incumbent tools/parts_hitset.py` finds no hit inside `_self_test`.

So a reader of the plan learns that incremental RC2 is the fix, and does not learn that the author
apparently believes something better is already written. Either it is measured — in which case it is §6's
*positive* result and the section titled "What is NOT the lever" is mis-titled — or it is not, in which
case its docstring is a claim with no receipt. The file was last written at 23:21 and is still moving, so
this may simply be work in flight; it is a card because the plan was committed at 23:16 in a state that
understates the work.

This is Kooshi's second question — *did it actually test the alternative, or go straight to incrementality
because that was the brief?* — and the honest answer is: **it tested more alternatives than the plan
reports.** §6 rejects `exhaust`, presolve and `adapt`; the code holds a fourth. The failure here is the
record, not the search.

*Minor, but it will bite a later reader:* `BatchHittingSet`'s docstring opens "The incumbent:" meaning *the
existing implementation*, while `IncumbentHittingSet` means *the incumbent bound*. Two senses of one word,
forty lines apart. (Fixed.)

### OUTCOME, and the durable rule it yields

The engine was twenty minutes old when I read it **and it was wrong**: `self.n_added`, which
`_Engine.add_correction` already increments to count correction sets, had been reused as the totalizer's
clause counter, so it skipped the first *k* totalizer clauses, **never enforced the cardinality constraint
at all**, and returned the size of an arbitrary model — bounds 3–6 too high at all 618 live-log ticks.
Too high is the flattering direction: a lower bound that reads larger than the truth refutes targets it
has no right to refute. The engineer's own live-log cross-check caught it; it is now fixed and carries
four controls.

I did not detect the bug. I detected that **the record and the artifact disagreed**, and the disagreement
had the same cause as the bug — both are properties of the newest thing in the file. The rule generalises
past this module:

> **A component present in the artifact and absent from its record is disproportionately the one that has
> not been checked.** Both facts have one cause: it is the most recent thing there, written after the
> record was last brought level. Cost of the check: one `grep` of the code's dispatch table against the
> document's section headings. This is the cheapest instrument in this file and it found the only
> unsoundness in it.

---

## card 6 — the equivalence check discriminates everywhere except the regime that matters

Kooshi's fourth question. The self-test is genuinely good: 13 controls, a positive control guarded against
triviality (`distinct > 3`, 32 distinct values), faults planted on the **shipping code path** rather than a
mutant copy, `not-compared` treated as a failure rather than a pass, and — the part I would single out — a
control the author watched *fail to fire* and then fixed by making the dropped clause binding **by
construction**, keeping the non-firing version as a stated blind spot. That is exactly the discipline
`CLAUDE.md` asks for and it is better than most of what I have reviewed here.

One gap, and it is in the regime the whole module exists for.

question: does-the-blocking-control-discriminate
  evidence: tools/parts_hitset.py lines 643-653. `sa`/`sb` collect `o.weight` only, for 25 iterations,
    on a 40-atom / 120-set random instance; the chk asserts `cb["ok"] and cb["compared"] >= 20`. There is
    no `distinct > 3` guard, unlike the correction-set positive control 20 lines above.
  expected: a control on the enumeration regime that could go red if the engines disagreed there
  ask: during a level enumeration both engines report w* at every iteration by construction -- so what
    does comparing their weight sequences exclude?
  if nothing: the control is the "a constant sequence would agree trivially" failure the self-test's own
    docstring names, in the one regime that matters, and the real invariant is untested
  if something: say what, because I cannot see it
  answered by: human — the engineer who wrote the module
  cost: reading 10 lines
  rank: 4

The sharper point: the two engines **block different sets** (`ea2.block(oa.kept); eb2.block(ob.kept)`, and
the plan measures argmin agreement at 6/151), so after the first divergence they are enumerating different
subtrees — and the check asserts only that both keep saying `w*`. They will, until exhaustion, whatever
either does.

**The property that matters in this regime is the one `parts_reduce._resume_control` already gates on:**

```python
same_level = ({tuple(m) for m in a["minima"]} == {tuple(m) for m in b["minima"]} and ...)
```

Run both engines **to exhaustion** on the small instance and assert the two *sets* of minima are equal.
That is the completeness invariant, it is what a published level actually is, and it is cheap at n = 40.
Without it, §7.1's "closing on the same level by the completeness invariant" is an argument, not a check —
and this project's rule is that an argument in place of a check is the check failing open.

**A second gap, on the fault that will actually happen.** Every planted fault is a fault *in the engine*.
The fault integration will produce is a **desynchronisation**: `reduce_stage` has three append sites
(`state.corr.append` on sat, `state.minima.append` on unsat, `state.undecided.append` on unknown) feeding
two engine methods, because `state.blocked` is a *property* that unions minima and undecided. The
`undecided` branch does not look like a blocking site — it is in the `else`, logged as "blocked and
recorded" — and an integrator who wires the two obvious ones and misses it gets an engine that keeps
returning a candidate the loop has already asked. Cheap control: have the engine hold a rolling hash of
what it was told and assert it against `len(state.corr)` and `len(state.blocked)` each iteration. That is
the positive signal for the thing that did not happen.

*What I checked and found sound:* the soundness argument for reusing cores (adding hard clauses only
strengthens the formula); the monotonicity assertion, which **raises** rather than logs and is watched
raising; `compare` returning `not-compared` — a failure — on empty or length-mismatched input; and the
faults living on the shared `_Engine` path so a mutant cannot drift from the shipping code.

---

## card 7 — the forecast is not transitive, and there is a good argument that it is anyway

§4's headline — *"a level enumeration's hitting-set cost goes from hours to seconds"* — is a **component**
measurement on a **recorded** clause sequence. §7.3 concedes the D1b replay adds every correction set and
then the blocking clauses; and the blocking clauses it adds are the ones the *incumbent* found, not the
ones the new engine returns. So the replay measures the right cost curve and does not simulate the loop,
while §7.1 says the argmin differs at 145 of 151 iterations. A different trajectory is a different harvest
and a different wall clock, and a component ratio does not compose into an end-to-end one.

**But I think the engineer can close this, and should, because it also disarms §7.1.** In the enumeration
regime the iteration count is ≈ the number of minima, which is a property of the level and not of the
engine — D1b: 19,447 minima against ~55 correction-set events across 19,300 iterations. So a trajectory
change alters *which* minimum is found when, and cannot alter *how many* there are. Under that observation
the component ratio does compose, in this regime, and §7.1's alarm ("a different harvest") reduces to a
different *order*, which `parts_reduce._resume_control` already declines to gate on and says so in terms:
*"a fresh solver may return a different model for the same colourable ask, so demanding an identical Y
would assert something false about correct code."*

Two places the argument does **not** reach, which should be stated rather than left to the reader:

- **Truncated runs.** With `max_minima`, `phase2_wall`, or any `undecided` candidate, the harvest is
  order-dependent and the level is explicitly `bounded-below`. A different engine gives a different
  truncated level. D1b runs uncapped; a phase-G sweep under a wall would not.
- **The optimisation phase**, where the number of correction-set derivations *is* engine-dependent, since
  which candidate is asked decides whether it comes back colourable.

---

## card 8 — the optimisation phase: the question I asked, and the answer that killed my hunch

The engineer's own summary after cards 1–7: *"no engine I have wins the optimisation phase"* — plain
incremental RC2 is **0.4×–2.5× slower** over C4a's first 600 iterations despite 257× fewer SAT calls, and
presolving to the 153 free atoms cuts calls 6× and time not at all (81 calls, 15.18 s against 504,
15.77 s). Kooshi's instinct that 153 binaries in 15 s smells of an algorithmic mismatch was right, and the
presolve negative is its confirmation: the 153-variable bound proof is genuinely where the time goes.

question: does-the-decision-formulation-win-the-optimisation-phase
  evidence: plans/M63-incremental-hitset.md §6, C4a's optimisation phase, batch: ~504 iterations x ~504 SAT calls ~= 254,000 calls, 15.77 s
    per solve, of which the hard part is proving no hitting set weighs less than w (187 ms per call over
    the 153 free atoms, by the engineer's own presolve measurement). The SAME ladder from 0 to 503 is
    re-proved every iteration.
  expected: "no engine wins the optimisation phase" -- the engineer's current statement, made while its
    decision engine was unsound
  ask: timed on C4a's recorded optimisation prefix against batch's 15.77 s, does the FIXED
    IncumbentHittingSet win, and by how much?
  if it wins: the wall is removed in BOTH regimes and the plan's §6 "what is NOT the lever" is
    mis-titled -- the decision formulation IS the lever for optimisation, incrementality for enumeration
  if it loses: that is a surprising result worth its own paragraph, and the optimisation phase stays open
    as an honest not-landed
  answered by: a run -- one replay of a recorded family the module already loads
  cost: minutes
  hunch: it wins by roughly a factor of the optimum
  falsifier: a timed C4a replay in which the decision engine is not materially faster than 15.77 s
  rank: 3

**The mechanism, which is why I expect a win.** The expensive work is proving a *lower bound*, and
core-guided RC2 re-derives the whole ladder 0 → 503 on every iteration. The decision formulation proves
each weight level **once across the entire run**: ~504 + 503 ≈ 1,007 calls total, of which ~503 are the
hard UNSAT proofs, against batch doing those same 503 proofs 504 times over. That is ~500× less hard work,
and it is exactly what the engineer's two negatives jointly point at — *the difficulty of each call is the
cost, so stop repeating the call.* Plain incremental RC2 loses here for the reason it measured (carried
relaxation machinery makes its few calls heavy); the decision formulation carries none.

Three riders, in decreasing confidence:

1. **The optimum is load-bearing and cannot be approximated** — worth writing down because it is the
   shortcut the next reader will reach for. The completeness invariant holds because when the MaxSAT
   optimum over `Y` is `wh`, *every* selection lighter than `wh` fails to hit `Y` and is therefore
   colourable **without being asked**. An approximate hitting set destroys that. The decision formulation
   keeps it exactly: UNSAT at `b` proves optimum > `b`; SAT at `b`, with `b` already a proven lower bound,
   proves optimum = `b`.
2. **Count the dropped atoms, not the kept ones.** The engine builds
   `ITotalizer(lits=[a+1 …], ubound≈503)` over 576 literals, which is near a full sorting network. The
   optimum keeps 503 of 576 — it **drops 73** — and "keep at most `b`" is "drop at least `n − b`", so a
   totalizer over the *negated* literals never needs to count past 73. Same constraint, a fraction of the
   clauses. High confidence it is the right side to count; medium on the ratio.
3. **Unit weights.** The engine refuses weighted instances by design, so if C4a's joint stage sits above
   rung 1 the comparison must move to a rung-1 family. The refusal is loud rather than silent, which is
   the right behaviour and is one of the guards the engineer already watched failing on a real file.

---

## card 9 — where I was wrong, and the dispatch

**Card 8's hunch is refuted, and my rider 2 was wrong for a structural reason I should have known.**

*The hunch.* The fixed decision engine was timed on C4a's recorded family and is **losing badly**: 32.1 s
against batch's 2.6 s at iteration 200, and past 8 minutes of CPU before iteration 400, where batch needs
41 s. My call-count arithmetic was right — ~1 call per iteration, 231 calls by iteration 200 — and
irrelevant, for the third time in this session: **the cost is per-call difficulty, not call count.** Each
of those few calls drags a totalizer over 576 literals built out to a bound near 503, which is close to a
full sorting network, so "each weight level proven UNSAT once" is true and each such proof is now far
harder than RC2's core-guided equivalent.

*The rider.* I proposed counting the **dropped** atoms (73) rather than the kept (503), to shrink that
encoding. The engineer implemented it and the self-test went red in a minute. **A totalizer is one-sided:**
assuming `-rhs[k]` enforces `sum ≤ k`, but asserting `rhs[m-1]` does *not* force the sum up to `m` — the
implication runs one way only, so a *lower* bound on the dropped count cannot be asserted against that
encoding at all. It needs a two-sided cardinality encoding, which `ITotalizer` is not. I should have
checked the encoding's direction before proposing it; I reasoned about the *size* of the counter and never
about which way its implications point. The engineer reverted it and recorded the reason in the method's
docstring, on the correct grounds that the next reader will have the same idea.

**The pattern across all three failures is one sentence, and it is the finding of the optimisation half:**
every formulation tried — plain incremental (0.4×), presolve to the free atoms (1.0×), the decision
formulation (far worse) — cut the *number* of solver calls, by 257×, 6× and 500× respectively, and **none
cut the time**, because the 153-variable bound proof is irreducible and each formulation merely moved it.
Three independent attempts hitting one wall for one measured reason is a result, and a better one than a
fourth attempt would be.

**Dispatch.** My rule is that the engagement ends when the next move is obvious to the domain's own
discipline, and it is: report the asymmetry — *the enumeration phase is won two ways over and prices
P-G7; the optimisation phase resists three formulations for one measured reason* — and stop. Two heavy
jobs are on a contended box at midnight, and a fourth formulation tonight is depth on the nearest solid
ground while the frontier waits. I recommend the engineer stops hunting.

**The idea I left as a stub was run within the hour, and it lost too.** The engineer implemented exactly
the construction — the counter over the ~153 free atoms at `ubound ≈ 80`, with `kept_total ≤ w` rewritten
as `kept_free ≤ w − forced` — and measured it on C4a's 600-iteration window, where batch takes 245.9 s:
**2 min 24 s of CPU without reaching iteration 200**, where batch needs 2.6 s. The killer I named did not
bite (atoms forced later stay inside the counter, which only makes it larger than necessary and never
wrong); it died on its main claim. Self-test green through the change, 18 controls.

So the finding is **four** formulations, and stated as a table it is the whole optimisation half:

| formulation | what it cut | by | time |
|---|---|---|---|
| incremental RC2 | SAT calls | 257× | **0.4×** — slower |
| presolve to the free atoms | SAT calls | 6× | **1.0×** — unchanged |
| decision + incremental totalizer | SAT calls | ~500× | far worse |
| the same, counter shrunk to the free atoms | encoding size | ~40× | far worse |

**Four independent attempts cut a proxy and not one cut the time.** The 153-variable bound proof is
irreducible and every formulation so far has only moved it. That is a mechanism, measured four ways, and
it is a better artifact than a fifth attempt.

### The scope of the negative, which is the last thing I owe this record

`CLAUDE.md` G21: *a negative measures its enumeration*, and a verdict is a statement about what was
enumerated. What these four exclude is not "no engine wins the optimisation phase" but the sharper and
more useful claim:

> **No SAT-based formulation wins it.** All four prove the lower bound by the same proof system — a
> resolution/core argument extracted by a CDCL solver — and differ only in how the search through that
> system is arranged. They cut calls, relaxation machinery and encoding size; none of them changed the
> proof system, and the proof is the cost.

The room none of the four entered is the one that owns the object. **A minimum-weight hitting set over a
family of sets is a set-covering integer program**, its classical method is branch-and-bound over the LP
relaxation, and it certifies optimality by a *dual* object — an LP bound with cuts — rather than by
exhaustively extracting cores. That is a different proof system, not a fifth arrangement of this one, and
it is the move `CLAUDE.md` G46 prescribes: name the object in the discipline that owns it and let that
discipline decide the question's shape. Set covering's LP relaxation is often tight, and where it is, the
bound that costs a CDCL solver 187 ms per call is a single simplex solve.

I am **not** proposing this be run tonight, and I am not reopening the hunt: the enumeration phase is won,
which is what P-G7 needs. I am saying the negative should be reported with its enumeration named, because
"no engine wins" and "no SAT-based engine wins, and the integer-programming room was not entered" are
different claims, and only the second is what was measured. Whoever picks up the optimisation phase should
start in that room, not with a fifth MaxSAT arrangement.

## hunch ledger

hunch: the-cost-is-the-rebuild-not-the-climb
  claim: most of D1b's 0.664 s/iteration is WCNF construction and solver loading, not SAT search
  basis: measured
  falsifier: timing WCNF construction alone at a 19k-minima prefix and finding it well under 0.1 s
  registered: 2026-09-11
  status: confirmed (by replication of the pre-registered falsifier on a fresh 19,572-minima prefix, run
    by the engineer: WCNF build 0.637 s
    = 81%, RC2 init 0.094 s = 12%, search 0.061 s = 8%; SAT calls constant at 374)

hunch: the-decision-formulation-wins-the-optimisation-phase
  claim: the fixed IncumbentHittingSet beats batch's 15.77 s on C4a's recorded optimisation prefix by
    roughly a factor of the optimum, because each weight level is proven UNSAT once per RUN rather than
    once per ITERATION
  basis: derived
  falsifier: a timed C4a replay in which the decision engine is not materially faster than 15.77 s
  registered: 2026-09-11
  status: killed (by: the pre-registered falsifier, a timed C4a replay, the same night) -- 32.1 s
    against batch's 2.6 s at iteration 200, and
    past 8 min CPU before iteration 400 where batch needs 41 s. The call count behaved exactly as derived
    (231 calls by iteration 200, ~1 per iteration) and it did not matter. Mechanism of the miss: I costed
    the number of calls when the measured cost is the difficulty of each call -- the same error the
    engineer's own presolve negative had already demonstrated, which I had read and did not apply to my
    own proposal. Cost: one C4a replay of box time.

hunch: counting-dropped-atoms-shrinks-the-encoding
  claim: a totalizer over the negated literals capped near 73 encodes the same constraint as one over 576
    literals to 503, in a fraction of the clauses
  basis: derived
  falsifier: an implementation whose equivalence check goes red, or which is not materially smaller
  registered: 2026-09-11
  status: killed (by: the engineer's implementation, whose self-test went red within a minute) -- a
    totalizer is ONE-SIDED: assuming -rhs[k] enforces
    sum <= k, but asserting rhs[m-1] does not force the sum up to m, so a lower bound on the dropped count
    cannot be asserted against that encoding at all. Mechanism of the miss: I reasoned about the counter's
    SIZE and never about which way its implications point. The right side to count was right; the
    encoding cannot express it.

hunch: enumeration-cost-is-quadratic-in-level-size
  claim: enumeration wall-clock ~ c * w* * |E|^2 / 2
  basis: measured
  falsifier: an interior point of D1b that the quadratic misses by more than the linear fit does
  registered: 2026-09-11
  status: confirmed (by replication on two held-out interior points: i=12,177 predicted 5,108 s against
    5,171 observed; i=17,308 predicted 10,194 s against 10,312 observed; linear predicts 8,072 s at the
    first, an error of 56%)

hunch: shrinking-the-counter-to-the-free-atoms-wins-the-optimisation-phase
  claim: a cardinality constraint over the ~153 FREE atoms at ubound ~80, rather than 576 atoms to ~503,
    is ~40x smaller and makes the decision formulation beat batch on C4a
  basis: derived
  falsifier: a timed C4a replay in which the shrunk decision engine is not materially faster than batch
  registered: 2026-09-11
  status: killed (by: the pre-registered falsifier, a timed C4a 600-iteration replay run by the engineer
    within the hour) -- 2 min 24 s of CPU without reaching iteration 200, where batch needs 2.6 s and
    completes the window in 245.9 s. The caveat I named (the forced set growing, forcing a rebuild) did
    NOT bite: later-forced atoms stay inside the counter, which only makes it larger than necessary and
    never wrong. So the hunch died on its main claim, not its caveat. Mechanism of the miss: for the
    fourth time in one session I costed a proxy -- encoding size here, call count before -- when the
    measured cost is the difficulty of the bound proof itself, which none of the four formulations touched.

hunch: the-blocking-control-cannot-go-red
  claim: the self-test's blocking-clause control compares two sequences that are constant at w* by
    construction, so it excludes nothing
  basis: read
  falsifier: an argument, or a run, showing the two weight sequences can differ while both engines are
    correct -- which would also mean one of them is wrong
  registered: 2026-09-11
  status: confirmed (by: tools/parts_hitset.py _self_test lines 643-653, re-read by the engineer, which
    found it WORSE than claimed --
    each engine blocked its OWN optimum, so the two clause streams could diverge legitimately and the
    comparison tested nothing even in principle). It now feeds one stream to both engines and requires
    the bound to MOVE: 6 distinct values, 49 -> 54.

hunch: target-refuted-runs-get-nothing-from-this
  claim: a reduce_stage call with a `target` exits at `wh > target` before any optimum, so it lives in the
    95%-oracle phase and the incremental engine buys it single-digit percent
  basis: read
  falsifier: phases F and G turn out to run uncapped level enumerations rather than target decisions
  registered: 2026-09-11
  status: killed (by: plans/M63-phaseG-bases-and-rotations.md, read) -- line 625 names
    the accumulator as the complete level with no known ceiling, :421 and :437 make P-G7 the only
    reduction-loop consumer and the phase's dominant cost, and a targeted run that SUCCEEDS enumerates
    its level anyway (m63-map-A412 log: "the level is complete [187s]"). Cost of the miss: one message
    raising a worry the record answers. Mechanism of the miss: I put a question to a person when the
    cheapest addressee was the record -- my own <record_first> rule, missed on the axis where the frame
    had already been set by the brief.

---

## what I would say to Kooshi, in his four terms

1. **Is the attribution real?** Yes, and measuring it directly made it *sharper*, not softer. It is
   size-and-phase dependent: 99.6% oracle at 55 atoms, ~95% oracle while finding D1b's optimum, ~73%
   hitting set while finding C4a's (where the correction-set family is four times larger), and ~99%
   hitting set while enumerating D1b's level. The engineer reported the disagreement with 27/73 as the
   finding rather than retrying until it agreed — which was the thing to watch for, and it did not happen.
   I added the receipt it had not used: D1b's own launch header carries a 20–90 minute forecast whose
   stated assumption *held* and which the run has now missed by 2.4× and rising, because the forecast
   counted solver asks. Same error as the by-elimination attribution, caught live and pre-registered.
2. **Is "incremental" the right lever?** Partly, and the honest answer is now two levers for two regimes.
   Your instinct that 153 binaries in 15 seconds smells of an algorithmic mismatch was right, and the
   engineer's own measurement confirms it from the other side: eliminating the 423 forced atoms cuts the
   solver calls sixfold and the time not at all, so the 153-variable bound proof is irreducibly where the
   time goes. Incrementality wins the enumeration regime outright. It **loses** the optimisation regime
   (0.4×–2.5× slower). The engine that should win that one — a decision formulation asking *"is there a
   hitting set this light?"* once per iteration instead of re-deriving the whole bound ladder — exists in
   the code, was timed against the incumbent on my ask, and **lost badly** — 32.1 s against 2.6 s at
   iteration 200 — and so did the shrunk-counter version I left as a stub, which the engineer ran within
   the hour (cards 8 and 9). So the honest statement is: **the wall is down in one of two regimes.** Four
   formulations have now cut a proxy — solver calls by 257×, 6× and ~500×, encoding size by ~40× — and
   **not one cut the time**, for one measured reason: the 153-variable bound proof is irreducible and each
   formulation only moved it. That is a not-landed with a mechanism, which is the rarer and more useful
   kind. Its scope, which card 9 states and the report should: what is excluded is every *SAT-based*
   formulation, all four sharing one proof system; the integer-programming room that owns set covering was
   not entered, and that is where the next person should start.
3. **Which phase?** Both, by different mechanisms, and my first answer was too clean. The enumeration
   phase is ~99% hitting set and is what the engine fixes; the optimisation phase is oracle-bound when the
   correction-set family is small and hitting-set-bound when it is large. Your worry — that an engine
   aimed at optimisation would fix the cheap part — is answered: the code has no separate optimisation
   phase (one loop; the optimum is simply the first refusal), and phase G's dominant cost, P-G7, is a
   complete level enumeration, which is the regime that wins.
4. **Does the check discriminate?** It is the best-built self-test I have reviewed in this repository —
   faults planted on the shipping code path, `not-compared` treated as a failure, a positive control
   guarded against triviality, and one control the author **watched fail to fire** and then repaired by
   making its planted fault binding by construction, keeping the non-firing version as a stated blind
   spot. Two gaps remain, both in card 6: the blocking-clause control compares two sequences that are
   constant by construction and so may exclude nothing (the fix is to compare the two *sets of minima* at
   exhaustion — the invariant `parts_reduce`'s own resume control already gates on), and every planted
   fault is a fault in the *engine* while the fault integration will actually produce is a
   *desynchronisation* between the engine and `state`, for which there is no control.

**The thing I would carry out of this session past M63.** The only unsoundness in the work was found not
by reading code but by noticing that **the artifact shipped a component the record did not mention** — and
it was absent from the record for the same reason it was unchecked: it was the newest thing in the file.
That is a standing instrument, it costs one `grep` of the code's dispatch table against the document's
section headings, and I would add it to the gate.

**What I would not do:** re-run the attribution until it agrees with 27/73. It does not agree, and the
disagreement is the finding.
