# M63 — handoff from the product-owner session, 2026-09-11

*Written by the main session to its own post-compaction successor, and to anyone who picks this up cold.
Everything here is either a quote, a decision with its reason, or an address. No agent IDs: recover live
agents with `ListAgents` and ask each for a one-paragraph status before doing anything else.*

---

## §0 — State at 23:20

*Rewritten in place; this file holds current state, and the story is in the commits.*

- **Phase C is CLOSED and the joint route ABANDONED** (§6.1). Both runs stopped at 5 h on Kooshi's ruling.
  The bracket **504 ≤ \|M\| ≤ 509** is the result and the route's epitaph: it was never worth more than five
  vertices. §R2 committed (`b683821`, `08b6681`, `20f7bb1`).
- **Phase D is CLOSED.** Clause 2(b) **not met** (`557aece`); clause 2(c) phenomenon observed, clause not
  met. The closing audit is written and its 24 rows plus `D-7` and `H-6` are applied to §S.3
  (`plans/M63-phaseD-close-audit.md`; `5c0a747`, `3e343e5`, `14da973`).
- **THE CALIBRATION GATE HAS PASSED** (§6.5) — the apparatus reproduces Parts's own recorded four-orbit
  expansion. This is the single most load-bearing fact in the milestone: it makes every negative on the large
  half a fact about **expansion** rather than about our pipeline.
- **Phase F is planned and re-aimed** (`plans/M63-phaseF-beat-509.md`, `66214e1`): a monotone union ladder
  replacing a 1,891-run pair sweep with six runs, plus the loop's interface to new inputs.
- **Phases E and G are being planned** by fresh agents, with a Poros advising G.
- **Running, both checkpointed:** the rung-1 374-level enumeration (D1b) and the calibration's own level
  enumeration.
- **Retired:** the small-half probe, both joint reductions, and the kernel certification of the 2,279-edge
  object — each with its reason recorded where it lived.

## §1 — Why, in Kooshi's words

> *"Resume M63 as the product owner, and spawn fresh subagents to subplan, then implement each phase. Also
> use a Poros sibling subagent (identity sourced from ../poros) and let the engineer know how to communicate
> with it. Restart Poros after each phase so its context doesn't get too full. The goal is to reproduce or
> beat Part's record. You are to review each phase, and give feedback, launch repair subagents, or accept
> each one. Don't let the agents lazily omit parts of the implementation. We can absolutely beat the record,
> it is just a matter of implementation. If an agent taps out on some specific part of the implementation,
> launch a fresh agent scoped specifically on that as a subphase."*

> *"After we match or beat it, the next high value tweaks are different base graphs, and the additional ~400
> rotation angles that were discovered previously, which should hopefully let us go even smaller."*

> *"It can be its own milestone, but as long as you are below 75% context usage, please continue driving this
> loop of subagents — through that milestone if possible, with the goal of the best record 5 chromatic unit
> graph we can get."*

**The product: the smallest 5-chromatic unit-distance graph we can certify in the Lean kernel.** Parts's
record is 509 vertices / 2,442 edges; fewest edges is his own secondary tie-break.

**And the judgement that bounds it** (Kooshi, 2026-09-11, on the 2,279-edge object): *"cancel the
certification, just record it. It's not really worth much to just thin his graph."* **Thinning his object is
a measurement, not a product.** A record means a smaller *graph* of our own finding.

---

## §2 — How this session is run

Product-owner mode. Per phase: a fresh planner → my review and approval recorded in the plan's §A → a fresh
implementer → my review. A **Poros advisor** (`~/source/poros/CLAUDE.md`) runs alongside each phase and is
restarted per phase; it writes `plans/POROS-2026-09-11-m63-phase<X>.md` and does not commit it. Agents reach
each other with `SendMessage` addressed by agent ID; messages arrive wrapped as `<agent-message from="…">`
and a reply copies that `from` value. Acceptance is a checklist scored item by item; **"not done" with a
reason is acceptable, a silent omission is not.**

---

## §3 — Where the milestone stands

**Phase C — the joint test. CLOSED as a bound, not a verdict.** Plan `plans/M63-phaseC-joint-stage.md`, §A
approved, §R2 written. Built and committed: `tools/parts_run.py`, exact resume, the bounded ask (conflict
slices — this CaDiCaL does not implement `interrupt()`), `tools/parts_audit.py`, `typem.CrossLaw`, the
repaired freeze. **The result:** phase 1 partitions the 576 atoms into **423 forced** (present in every
refusing selection, by downward closure) and **153 free**, with every non-singleton correction set inside the
free set — so the joint question is a minimum hitting set over 153 atoms, of which **Parts keeps 85 and at
least 80 are proved necessary.** Neither run found a single minimum in 4.9 h. **Nine instruments broke in
this one phase**; their shared defect is now a standing rule in `CLAUDE.md`.

**Phase D — the loop. CLOSED.** Plan `plans/M63-phaseD-the-loop.md`, §A approved, §H2 handoff, closing audit
in `plans/M63-phaseD-close-audit.md`.
- **The 89-candidate outcome map is complete: 0 improve, 1 grows the level, 0 undecided** — which closes
  **single-orbit** growth over a closed menu and **nothing more**. His own successful move added **four
  orbits at once**.
- **The map's `his_move_absent_by_construction` field was FALSE** and the truth is sharper: two of his four
  orbits *were* live candidates, were tested singly, and are **inert** — direct evidence that his expansion
  worked as a *combination*. Corrected at `3e343e5`; **the producer still emits the false sentence** (§6.4).
- **The threshold question is symmetric**: the 26 shoulder candidates are as inert as the 62 above the cut.
  His admission rule is neither vindicated nor convicted, and the comparison has no power.
- **His state 1 reproduces four-for-four** once the companion is identified as the S **accumulator**
  `v166e774` — the finding that the companion is a per-row parameter of his table (§S.1 clause 2(a)).
- **Clause 2(b) is not met**, scored as a ranking failure; the calibration (§6.5) is what proves it is a
  ranking failure and not an apparatus failure.

**The small-half probe — RETIRED** (§6.3). 13 of 14 singles inert at 136 vertices with bit-for-bit identical
levels, including the √5 orbit outside Parts's own search disk. The pair menus are struck: they probe *his*
inputs, and phase F's union ladder dominates them.

**Phase F — planned, aimed at the method** (`plans/M63-phaseF-beat-509.md`). Its spine: a reduction run costs
the same regardless of how much material it adds (214 / 246 / 221 CPU s at +3 / +12 / +24 points), so with
monotonicity **one run over a union settles every subset** — six runs in place of 1,891. Its §2.6 states the
**input interface** a new base or rotation must supply, and names **the bootstrap**: Parts's loop runs on an
accumulator his files hand us free, and **a new base has none**.

## §4 — The 2,279-edge object, and its status

**509 vertices, 2,279 edges, refuses four colours.** 163 of Parts's 2,442 edges dropped, against the 36
`[deGreyParts2023]` fn. 2 discards without an exhaustive search — so 127 below the published 2,406.
- object `data/m62/m63-edge-greedy-509.json`, kept-edge fingerprint `2e5c7fc54cdc261a1c40364af7c591b6`;
- verification `data/m62/m63-edge-verify-509.json`; proof `build/m63d2/greedy509.lrat` (3.7 GB, regenerable
  from the committed DIMACS in ~21 min).
- **All six verification legs hold**: unpinned refutation (plain CNF, no selector variables, no symmetry
  break; CaDiCaL 2.1.2, separate process, UNSAT in 1,250 s); exact-arithmetic geometry on all 2,279 edges
  with cross edges re-derived from the *stated* rotation law; minimum degree 4 and degree sum 4,558; the
  count never called the minimum; an LRAT replay by an independently written checker (7,699,212 RUP steps,
  zero unsupported) **whose five planted faults all fired**; and SAT controls in both directions.
- **Bracket: 1,831 ≤ e_min ≤ 2,279**, the floor from the complete critical-edge census (1,831 of 2,442
  individually critical).

**STATUS: recorded as a measurement. The kernel certification was CANCELLED by Kooshi.** It is not a record
and must never be called one. It belongs in the ledger as a bracket on a quantity nobody had bounded, with
the observation that his greedy discard of 36 was nowhere near optimal.

---

## §5 — Rulings already made, so they are not re-litigated

| ruling | substance |
|---|---|
| **acceptance (M63 §S.1)** | reproduce = our own `L374 ∪ ρS136` refusing; the algorithm = a rule registered before it runs finding the move unaided; **phase E is required**; beat = fewer than 509 vertices, or 509 with fewer edges, **certified** |
| **clause 2(c)** | `{M}` grows at fixed \|M\| **and fixed rung**, in an iteration where the rule **added vertices**; a rung relaxation does not count. Observed once, on a randomly chosen candidate — **phenomenon observed, clause not met** |
| **the edge bar** | 2,406, not 2,442 (`[deGreyParts2023]` fn. 2). Corrected in §S.1 |
| **the six conditional drops** | approved as conditional; the cost dial was measured and **did not fire** (like for like, the joint stage is ~2× the frozen-companion ones, not 16–88×); the rows return on **per-row** grounds |
| **the companion** | **is whatever his loop held at that moment, and it changes as the loop runs.** Across his table: vertex counts comparable; minima counts and `A` comparable only once that row's companion is identified |
| **the verification chain** | binding for any future record claim: unpinned refutation, fresh process and different solver, exact geometry, forced degree floor as a halt not a finding, never "the minimum" for a greedy count, LRAT replayed by our own checker with planted faults |
| **phase G** | its own milestone, numbered at M63's close |
| **order** | F before E, with the freeze commit preceding both |
| **a smaller minimum over HIS accumulators** | **is a record** (2026-09-11, asked by phase F's advisor). The test is not whose inputs were used but **whether the object is contained in his answer**. His 509 is vertex-critical — phase C's positive control, 508 critical atoms and 0 droppable, every single-vertex deletion colourable — so a 504-vertex refusing selection cannot be a subgraph of it and is a different object his answer does not contain. The 2,279-edge object was the opposite: his exact vertex set minus 163 of his edges, where `[deGreyParts2023]` fn. 2 had already said in print that their count was not optimal and not exhaustively searched. Vertex count is the headline record; edges are his own secondary tie-break. **Honesty condition, binding on any write-up:** the accumulators, the rotation, the base lattice and the reduction algorithm are his; ours is the joint reduction — both halves deletable at once where he alternated with one frozen. **This does not by itself rank the joint finish first**: it may terminate at 509 (a closure statement, not a record), and its cost is unpriced until the hitting-set attribution lands |

---

## §6 — Outstanding, in order

1. **Phase C is CLOSED, and the joint route is ABANDONED** (Kooshi, 2026-09-11, 22:58). §R2 is written and
   committed (`b683821`, `08b6681`) with the bracket as its result: C4a **504 ≤ \|M\| ≤ 509**, C4b
   **500 ≤ \|M\| ≤ 577**, no minimum found in 4.9 h each. **Both runs were then stopped by SIGTERM to their
   verified process groups** — they wrote no result record, since one is written only at `finish()`.
   **Kooshi's ruling, which I could not meet the condition of:** *"shrinking the two halves together are not
   worth the computational cost it incurs. Freezing one half appears to have produced a vertex critical
   graph, so unless you can prove shrinking both halves together can beat it, its slow speed seems
   objectively worse."* No such proof exists, so slower is simply worse. The bracket stands as the route's
   epitaph and is worth having: **the joint route was never worth more than five vertices.**
   **The same reasoning retired the two small-half probe stragglers** (candidates `(0,0,6,6)` and
   `(12,0,2,6)`): they probe *his* small half, thirteen of fourteen siblings are inert, and both were 8×
   past the probe's own registered budget, falsifying its P7. Kept running: the 374-level enumeration and
   the `hismove` calibration, because those are evidence about **the method**, not attempts to shrink his
   object.
2. **Close phase D** — mostly done. Clause 2(b) is scored **not met** (`557aece`) and §R3 is written;
   **§S.3's D rows remain.** The §X.4–X.7 texts are **applied, 2026-09-11, by the product owner**: §X.4 into
   §S.1 clause 2(a) and §X.5 into §S.4's phase D acceptance bullet (both the companion-per-row correction),
   and §X.6 into `CLAUDE.md` § Toolchain as a standing environment note — **re-measured here before it was
   written down** (Python 3.14.6, `get_start_method()` → `forkserver`), because an unverified environment
   fact in the project's standing instructions is exactly the kind of thing that gets believed later.
   **§X.7 is CLOSED — and my earlier ruling on it was wrong twice over** (corrected 2026-09-11 after phase
   D's closing auditor flagged that the handoff and the code disagreed). `pin_is_sound` in
   `tools/parts_stage.py` identified pin atoms by an atom's lowest set bit, which is right at rung 1 and
   vacuous above it, so it printed `pin-is-fixed` while checking nothing. **It was already fixed** at commit
   `13454c3` (21:32:37), with the control that fails on the shipped code planted beside it — 0 pin atoms by
   the old rule against 2 by the fixed one, on an order-3 stage where they differ. I had ruled "fix it at
   the freeze commit, not now", which was wrong on its premise (the fix predated the ruling) **and on its
   reasoning**: I argued a post-freeze repair would fall outside what phase E is judged under, but the
   freeze `6158162` (21:03:54) pins `data/m62/m63-freeze.json` and **never touched tool code at all**, so
   that concern never applied. Verified by reading HEAD and both commits rather than by accepting the
   correction. No number is retracted: the symmetry break itself is sound because the pin clause is
   conditional on the atom's presence; only the control was blind. **Standing lesson: a ruling made from a
   plan's prose about code is a ruling about the prose.**
3. **The probe is RETIRED** (2026-09-11, with the joint route — it expands *his* small half). 13 of 14
   singles inert; the last two were stopped 8× past the probe's own registered budget, falsifying its P7.
   The 112 pairs and the 350-pair menu are **not** to be run: they are the dominated instrument the phase F
   plan replaces with a monotone union ladder, and they probe his inputs either way. Checkpoints survive if
   this is ever reversed.
4. **BLOCKED ON THE CALIBRATION JOB — fix `tools/parts_loop.py` line 810 the moment it lands.** The line
   emits a field claiming all four orbits of Parts's recorded move were untestable; **two of them were
   tested singly and are inert**, which is stronger evidence than the claim it replaces (two orbits that
   work as a *set* do nothing alone). The artifact `data/m62/m63-map-A412.json` is corrected (`3e343e5`),
   **but the producer is not, so the artifact no longer regenerates from committed code** — which breaks
   this milestone's own rule. Not fixed yet because `tools/parts_diag.py hismove` imports that module and
   Python 3.14's `forkserver` re-imports it in any worker spawned after an edit; that job gates the next
   phase. **After the fix: regenerate and confirm the artifact matches.** `data/m62/m63-map-A412-first.json`
   needs its own adapted wording; `data/m62/m63-sweep-protocol.json` is a **frozen pre-registration and must
   NOT be edited** — a freeze records what was believed before the outcomes were read, and retro-editing one
   destroys its only property while leaving it looking intact.
5. **THE CALIBRATION GATE HAS PASSED** (2026-09-11 23:15, log-attested, record pending). `tools/parts_diag.py
   hismove` ran Parts's own recorded expansion — four orbits, 30 vertices at once — as a single candidate at
   his incumbent of 375, and returned **`OPTIMUM FOUND: weight 373 (kept 373 atoms) at iteration 209`** in
   **188 s**, zero undecided asks: **374 vertices against 375, so it reduces.** Both controls fired first
   (`pin-agrees-everywhere`, 12 checks; the stage passed *base keeps the property, companion alone does
   not*). **So the apparatus reproduces his recorded step**, the frozen rule's failure to choose his four
   orbits is a **ranking** failure and not an apparatus failure, and **every inertness result on the large
   half — the 89-candidate map included — stands as a fact about expansion rather than about our pipeline.**
   The formal record is written only at `finish()`, which is why the job is being left to complete its level
   enumeration rather than killed.
6. **The cost of a reduction at this scale is the ENUMERATION, not the optimisation** — the same run found
   its optimum in 188 s and has spent **79 minutes** enumerating the level, at 11,700 minima and climbing.
   Two orders of magnitude. **Consequence for the rotation census and for every future cost model:** a run
   that only needs to know *whether* a configuration admits a refusing selection can stop at the optimum; a
   run that needs the accumulator `A = ⋃{M}` — the loop's actual state variable, and the thing **a new base
   has none of** — must pay the whole enumeration. A census priced at optimum cost but needing accumulators
   is wrong by a factor of a hundred.

7. **CROSS-PHASE LINK NOBODY OWNS: P-G7 is no longer unpriced.** `plans/M63-phaseG-bases-and-rotations.md`
   says in **four** places that manufacturing a new base's first accumulator is *"unpriced until phase F's
   ladder lands"* — lines 440, 446, 502, 594. Meanwhile the hitting-set work derived a cost law from the
   incumbent's own log: **enumeration is quadratic in the level size**, fitting held-out points to ~1% where
   a linear fit is off by 56%. Manufacturing an accumulator **is** a complete level enumeration, so that law
   prices P-G7 — conditionally, since it was fitted on Parts's base and a new base is a different regime.
   **Neither agent could have made this connection: they were in different phases.** Reconcile when the
   hitting-set engineer's own report lands, and do not edit the phase G plan before then — its author has
   closed and the engineer may sharpen the law.
8. **And the enumeration regime is the one the new engine WINS.** The measured split is phase- and
   size-dependent, not a constant: ~99.6% oracle at 55 atoms, ~95% oracle finding D1b's optimum, ~73%
   hitting set finding C4a's, **~99% hitting set enumerating D1b's level**. Since a bootstrap is an
   enumeration, the cost work lands exactly where the rotation phase needs it. **The optimisation phase is
   NOT landed** — three formulations, one measured reason — and stopping there rather than trying a fourth
   at midnight on a contended box was the advisor's call and is the right one.

9. **THE KNOWN-MINIMUM GUARD IS OPT-IN WITH A SILENT DEFAULT-OFF, and it is off at two of three call sites**
   (verified 2026-09-11 23:42, from phase E's planner). `parts_loop.sweep_candidate` declares
   `anchor_tuples=None`; only `parts_loop.py:769` passes an anchor. **`parts_rule.py:387` and
   `parts_diag.py:196` pass nothing** — the second of those is the `hismove` calibration itself. So the
   repository-wide claim *"every reduction is guarded by a known-minimum control"* **is not true today.**
   - **What this does NOT overturn: the calibration result stands.** Its output *is* a known-answer check —
     it landed on **374 vertices, Parts's own recorded outcome**, which is the strongest form of the very
     assurance the anchor provides — and its pin control (`pin-agrees-everywhere`, 12 checks) and its
     stage property check (*base keeps the property, companion alone does not*) both fired and are in the
     log. What is true is that it ran with **one fewer control than anyone reading the code would assume.**
   - **What it does mean is worse than a missing check.** A guard that is opt-in and defaults to off is the
     same family as a guard that cannot run: it is silent exactly when absent. **Fix: make the anchor
     required at every call site, or make its absence a printed, recorded field in every run record** — so
     an anchorless run says so in its own artifact rather than looking identical to an anchored one.
   - **Blocked, and why:** `parts_diag` and `parts_rule` are both in the live jobs' import chain, and Python
     3.14's `forkserver` re-imports an edited module in any worker spawned after the edit. **Fix it when the
     two jobs land, before any new run.**
   - **And on new ground it cannot be supplied at all** — a new base has no known minimum. So phase E is the
     last place the anchor can be calibrated, which is the same one-way door as §X.2's geometry check.

10. **THE FREEZE PINS LESS THAN EVERY DOCUMENT CLAIMS, AND ITS RECEIPT CAN ASSERT A FALSEHOOD** (verified
    2026-09-11 23:55, from phase E's advisor). Two separate defects:
    - **A settled decision was never implemented.** `§S.5` records as a *decision* that the freeze pins
      `cross_law = collinear(7/8)` and `fp_base(Base(2.6))` inside the config hash. **`data/m62/m63-freeze.json`
      contains neither** — zero occurrences of each. And `require_frozen` has **one** caller
      (`tools/parts_rule.py:519`) behind `--require-frozen`, which is `action="store_true"`, i.e. **default
      off**. "Run under a frozen configuration" has been doing far less work than every document asserts.
    - **The worse half: the receipt can be false.** `held_out_state` ("our 375-level accumulator, 403
      vertices"), `incumbent_weight: 374` and `target` are inside the hash but are **descriptive** — the
      runtime incumbent is `ls.size` from the starting record (`parts_rule.py:329`). So a frozen run on any
      *other* row **passes `require_frozen` by hash equality while its own artifact asserts the wrong
      starting state.** A missing check leaves a reader with less than they thought; a receipt asserting a
      false starting state leaves them with something worse than nothing, and it is unrecoverable after the
      fact.
    - **Fix by per-row registration, NOT by re-freezing** — re-freezing now would silently change what the
      already-scored rows were judged under. Blocked on the live jobs like the other `tools/` fixes.
11. **A standing catcher worth building, and it applies retroactively.** A `no-selection-at-target` record
    already carries `target_lb`; `target_lb == target + 1` marks exactly the candidates a too-tight target
    misreports as `inert`. Re-asking only those at `target + 1` is a cheap standing check on every `inert`
    the loop emits — **and it would have applied to phase D's 89-candidate map**, which is the evidence
    behind "single-orbit expansion is closed". A check that can validate existing evidence retroactively is
    worth more than one that only guards future runs.

---

## §6a — WHEN THE TWO JOBS LAND: the ordered queue

*Five items are blocked on the same condition — `tools/` cannot be edited while `parts_run`/`parts_diag`
hold it open, because Python 3.14's `forkserver` re-imports an edited module in any worker spawned after
the edit. They are scattered above; this is the order to do them in, and the order matters.*

1. **DONE — both jobs were STOPPED at 23:50, not waited out** (Kooshi: *"Never keep an exponentially longer
   task running when you have something which will catch up in seconds."*). My earlier ruling to let them
   finish contained a circularity I argued past: **the jobs were blocking their own replacement**, since
   `tools/` cannot be edited while they hold it open, so "wait for them to finish" made the slow path
   self-perpetuating. Both checkpointed, so the cost of being wrong was re-running something now measured at
   186× faster. Final state captured before the signal: **D1b** iteration 20,922, 20,733 minima, `w* = 373`,
   4h06m, 14,656 CPU s; **hismove** iteration 14,360, 14,101 minima, `w* = 373`, 1h56m, 6,911 CPU s.
   - **Two re-runs are owed under the new engine, and both are wanted.** `hismove`'s verdict record was
     never written — it exists only at `finish()` — so **the calibration is log-attested only** until it is
     re-run, and several documents now cite it. D1b is phase E's replay row.
   - **The kill forfeited a registered instrument, recorded rather than glossed:** the out-of-sample test of
     the cost law at `0785bdc` (14,477 s predicted at iteration 20,663, 5% falsifier) will not be scored as
     registered. Score whatever partial the checkpoint permits and **say it is a partial.** Softening it: the
     quadratic branch is the *old* engine's curve and becomes historical at integration.
2. **Integrate the hitting-set engine — ENUMERATE ONLY** (approved, scoped, written at `bfe4ff9`). Leave
   optimum-finding on the existing code: nothing wins there, so there is no risk worth taking. The safety
   argument belongs in the integration commit — in the enumeration phase the iteration count is the size of
   the level, a property of the *problem* and not of the engine, which is what makes the differing-chosen-set
   caveat provably harmless there. **The engine goes in the launch budgets and NOT in the problem hash**: it
   invalidates nothing already checkpointed and only makes the future path different. Acceptance is
   pre-registered — re-run the M6B403 stage (360-member level, 375 vertices, 87 s) and require
   `regenerated-identical`.
3. **The anchor** (§9): make it required at every call site, or make its absence a printed, recorded field.
   Today `check_invariants` writes the anchor block only `if anchor is not None` and the verdict reads
   `restriction-identity-holds` either way, so off is indistinguishable from on.
4. **The freeze** (§10): per-row registration, **never a re-freeze** — re-freezing silently changes what the
   already-scored rows were judged under. And move the descriptive fields out of the hash, or the receipt
   keeps asserting a starting state that is false for every row but one.
5. **`tools/parts_loop.py` line 810** (§4): the producer still emits the his-move field its artifact no
   longer carries, so the artifact does not regenerate from committed code. Fix, regenerate, confirm match.
6. **`tools/typem.py`: FOUR call sites decide an outcome, and one of them is not a `kfloat` call at all** —
   so every audit that grepped `kfloat` missed it. They are line 184 (admissibility), line 1199
   (`CrossLaw.collinear` refusing a rotation), **`parts_lattice`'s float disk test** (base membership — the
   one no grep found), and `cross_edges_rho15_fast`'s `round(x/m, 9)` ray keys, **which is the only one that
   can miss edges outright**. Line 139 decides Moser-base membership and line 212 decides family *identity*
   (it can inflate a count); line 245 is display; 445/741/1009 are radius cuts in builders phase G does not
   use. **Priority note: the defect has NOT bitten.** An exact regeneration measured **zero** sign flips out
   to radius 3.5 (14,569 points, 804 radii, smallest margin 1.46 × 10⁻⁶ — nine orders above double
   precision), zero points gained or lost by the disk cuts, and zero edges missed or invented. **No standing
   count is an undercount from the float, including the 412.** So this is hygiene against a live hazard, not
   remediation of damaged results — do it, but it does not gate anything.
   The exact replacement already exists and is committed: `tools/typem_exact.py` (`273b2da`), whose `ksign`
   decides the sign by taking norms down the tower with no loop, no precision knob and no fallback path, and
   whose self-test shows the float test wrong on **74 of 122** engineered near-zero probes where the exact
   test is wrong on none.

**Then, and only then, the two things that actually chase the record:** screen the one new rotation (minutes),
and build the multi-orbit union ladder. Everything above is the cost of trusting what they return.

**UPDATE, 2026-09-12 00:05 — items 2 and part of 6 are DONE; a new one takes their place.**
- **The engine is integrated and in production**, enumerate-only, all three append sites, engine in the
  launch budgets and not in the problem hash. **~8× measured on D1b** (0.144 s/iteration against ~1.2 s) and
  still improving as the solver warms. Its cold solve on resume returned optimum **373, matching the
  checkpoint's stored value** — independent agreement with the incumbent's own recorded answer.
- **The pre-registered gate FIRED on the first run** (`regenerated-differs:bound`) and was right to: the
  level was identical as a set, `M_vertices` equal and the bound string character-identical, differing only
  by the *presence* of two fields phase D added to `Bound` after that record was stored. **The comparator was
  not relaxed to make the gate pass** — a schema-matching record was used instead and read
  `regenerated-identical`, and that second stage was the better target anyway: at rung 3 its atoms are
  orbits of weight 3, exercising the weighted path a unit-weight stage never touches.
- **The forfeited out-of-sample test was TRADED, not upgraded** — I first wrote "stronger replacement, not
  a weaker one" and that was wrong; the engineer corrected it against its own interest. Its partial scores
  +1.0% inside the 5% falsifier but is an extrapolation beyond the fitted range and is *not* the registered
  test. The replacement: the law's **derivative**, measurable from a checkpoint at as many points as wanted
  on a quiet box — six prefixes give cost linear in level size, so **the integral is quadratic by
  construction rather than by curve-fitting.** **The honest accounting:** that is stronger on *shape* and
  weaker on *coverage*. Every one of the six is a component measurement on a recorded family, so it **cannot
  see a cost living outside the hitting-set solve** — and the second quadratic is exactly such a cost, which
  the derivative method would never have found and the forfeited whole-run wall-clock test would have. A
  weak instrument that saw everything was traded for a strong one that sees one thing, and production
  surfaced the difference within minutes by luck rather than by design.
- **NEW, and the general form is worth more than the instance: removing the quadratic exposed a second one
  of identical shape.** About 0.09 s per iteration was unexplained; it is the **progress log**, which unions
  every minimum found so far every 5 minima — 557 ms at 20,733 minima, 111 ms per iteration amortised,
  linear in level size and hence cumulatively quadratic. It is now the dominant non-oracle cost and removing
  it should give roughly another **4×**. Not fixed because two runs are executing that file. **The rule: a
  cost that grows with the level need not live in the solver, and removing the dominant one merely promotes
  the next of the same shape — this one was hiding in a diagnostic nobody profiles.**
  **DO NOT READ THE CURRENT PRODUCTION TIMINGS AS THE ENGINE'S.** D1b at 0.154 s and `hismove` at 0.115 s
  per iteration are **end-to-end** figures in which the hitting-set solve is now **~0.2 ms** — the oracle is
  ~0.028 s and the progress-log union ~0.11 s amortised. **The runs currently spend more time in a log
  message than in the solver.** Take the queued fix before quoting any of these numbers as characterising
  the new engine, or the engine will be blamed for a diagnostic's cost.
  **And one figure was revised downward against its author's own interest:** the decision engine's headline
  is now **7.0× slower than batch** on C4a's completed 600-iteration window (1,710.2 s against 245.9 s, on
  639 solver calls against 273,216), replacing a mid-window snapshot that read **16×**. Batch's per-iteration
  cost accelerates across a window while the decision engine's is roughly flat, so **a mid-run snapshot
  flatters the conclusion and the completed window does not** — the same direction as the flattering-defect
  pattern, caught by its author and applied to itself. The finding is unchanged: four formulations, each
  cutting the work by a large factor, none cutting the time.

**CLOSED, 2026-09-12 — both records now exist, and the queue's first item is done.**
- **The progress-log fix landed**: `|A|` is maintained incrementally instead of re-unioning every minimum
  every five. **~5× demonstrated** (0.016–0.021 s/iteration against 0.089 immediately before) and that
  *understates* it, since the "before" window sat at ~15,000 minima and the "after" at ~24,000 where the old
  union would have cost more. **Cumulative against the original engine: ~65×.** The maintained aggregate is
  **checked, not trusted** — `finish()` compares it against full recomputation and raises on mismatch, with
  the drift planted for real and seen to fire. The reasoning is worth keeping: *a running aggregate that
  drifts makes every logged `|A|` wrong while the record stays right, which is the failure that hides
  longest, because the artifact keeps agreeing with itself.*
- **D1b is CLOSED**: `reduced`, minimum 373, **\|M\| = 374 vertices, level 26,724, `exhaustive-level`, 0
  undecided**, Y = 530. **Its final launch closed it in 43.9 s** — the same work that had run four hours
  without closing. This record had never been written before tonight.
- **`hismove` is CLOSED**: `HIS MOVE → yes`. **The calibration is no longer log-attested only**, so every
  document citing it now cites a record.
- Both carry `hitset_engine` in their launch budgets, and D1b's record shows it against the two new launches
  and `(none recorded)` against the original — a reader can see which solve produced which part.

**Two predictions scored, by the product owner:**
- **`P8-revised` (800–1600 correction sets; observed 530) is NOT SCORABLE AS REGISTERED** — not "not met".
  The closing run used a **different hitting-set engine** from the one the prediction was registered under,
  and the correction-set count is a property of **the search path, not of the problem**: the two engines
  agree on the bound at every iteration (151/151) but on the *chosen set* only 6 times in 151, so they ask
  different candidates and harvest different families. 530 against 800–1600 may say something about the
  engine and nothing about the graph. **Record the number with this reason; do not let it read as a
  falsified prediction about the mathematics.** Re-registering it against the new engine is cheap now that a
  close costs 44 s.
- **`P-D5` (does `\|{M}\|` equal 1,092 under the canonical conventions) is NOT DECIDED** — the record states
  its count is "as found", and canonical counts belong to the audit. **But it is now runnable, and it is a
  real attested-number check that has been pending all milestone:** the closed level is 26,724 raw, and its
  canonical count under the named convention is what compares against Parts's published 1,092 for this row.
  That is one audit pass on an existing record, no solver.

**`P-D5` is now MET — a prediction pending the whole milestone, closed with no solver.** The audit needed
only the closed level and `parts_audit.canonical_counts`, which already defined all three conventions.
**2,309 / 26,724 / 2,309 — none of them 1,092.** Registered at 0.50 as *"equals 1,092 under none of the
three"*; the falsifier did not fire. All three report `closed_under: True` with reading "orbits contained in
the level", so the function's own caveat (a count taken where closure fails counts orbits merely *meeting*
the level) does not apply.

**What that disagreement is and is not.** It is a **measured `Comparison` that reads not-matched with its
reason**, never a defect and never a reproduction failure:
- `\|M\| = 374` **matches his row exactly** — the vertex count is the convention-free quantity and it agrees.
- `\|{M}\|` does not, under any named convention. Two independent reasons already on record make that
  expected rather than alarming: **the companion is a per-row parameter of his table** (§S.1 clause 2(a)), so
  `\|{M}\|` is comparable only once that row's companion is identified; and **the counting convention itself
  was fitted** on the spent S M6A row, which is why phase E classifies `\|{M}\|` as *semi-held-out
  everywhere*. The live rival — `Aut(A)` against the full base group — has still been separated on no row.
- **So the honest three-part split stands and now has its hard instance:** vertex counts solid;
  accumulators solid and convention-free (set equality admits no counting group); **counts of minima
  convention-dependent, and here measurably not his.**

**NEW REGISTRATION, made by the product owner and deliberately NOT fitted to the observed 530.** Since
`P8-revised` cannot be scored across an engine change, its successor is a **ratio** prediction, which is
engine-comparable by construction:

> **`P-Y1`** — on any one stage run to closure under **both** engines, the incremental engine's harvested
> correction-set count will be **30–70%** of the batch engine's, with the level identical as a set and the
> bound identical at every iteration. **Confidence 0.6.** **Falsifier:** a ratio outside 20–90%, or any
> difference in the level or the bound sequence. Registered 2026-09-12 **before any such paired run exists**;
> a close now costs 44 s, so this is one cheap experiment. It is a claim about **the path**, which is the
> only thing an engine may legitimately change.

**`P-Y1` SCORED: FALSIFIED — and the falsification is the product owner's specification, not the engines.**
Observed ratio **100.0%** against a band of 30–70%, falsifier outside 20–90%.
- **Why it could not have come out otherwise:** the harvest happens overwhelmingly during
  *optimum-finding*, and the enumerate-only switch leaves that phase on **byte-identical code**. On D1b the
  harvest ran 473 sets at the optimum to 528 at close, so **~90% of any harvest predates the switch.** A
  ratio near 1 was forced by construction and the band was unreachable however the engines behave.
  **I registered a prediction whose informative outcome the apparatus could not enter** — two hours after
  writing the rule that says to check exactly that. `CLAUDE.md` now carries the rule's second half.
- **Why this is a diagnosis and not an escape**, which matters because "mis-specified" is the move a
  motivated person makes: **the 90% split is from D1b's own recorded numbers and predates `P-Y1`.** The test
  for any such claim is that its evidence must predate the result.
- **The surviving clauses came back STRONGER than registered, unasked:** not merely "level identical as a
  set" but **identical ask counts to the unit — 1,527 + 375 on both arms.** The two runs did the same work
  iteration for iteration — the strongest available evidence that the switch perturbs nothing.
- The stage was too small to show any speed-up (level 82, 59.3 s against 58.8 s), consistent with everything
  else tonight: **the win is a function of level size, and at 82 there is nothing to win.**

**`P-Y2`, registered to replace it — it predicts IDENTITY rather than a band**, which is both the strongest
form and the one that cannot be fitted to a number already seen:

> **`P-Y2`** — an **enumerate-only** engine switch changes **nothing but wall-clock**. On any stage run to
> closure under both arms: the level identical as a set, the bound identical at every iteration, the ask
> counts identical **to the unit**, and the harvested correction-set count identical. **Confidence 0.85**
> (one stage already shows ask counts matching to the unit). **Falsifier: any difference in any of the four,
> on any stage.** This makes the integration's own safety argument falsifiable, which is what it lacked.
> **Honest note on ratios:** a *ratio* prediction only discriminates under a **full-engine** integration,
> which does not exist. Under enumerate-only the discriminating quantity is the enumeration-phase harvest
> alone — `Y` at close minus `Y` at the optimum, 55 of 528 on D1b.

---

## §6b — THE CONTROL REPAIRS ARE DONE (2026-09-12)

**Queue items 3, 4 and 5 are closed.** 83 controls green across three modules, zero failures, and **each fix
was seen red on the old code before being called fixed.**
- **The anchor is three-valued**: present / `AnchorAbsent(reason)` printed and written into every entry with
  a reason of substance required / **missing is fatal**. `None` is refused by name. The declared-absent run
  ends at `restriction-identity-holds-anchor-declared-absent`, so **the two runs no longer share a string**,
  and `entry["M"]` renders as `">=N"` whenever the anchor is absent, with arithmetic on it raising.
- **The freeze**: the falsehood was **demonstrated against HEAD** — a run at `incumbent_weight = 373` was
  *accepted* while its receipt named the wrong row. Now hashes the **rule portion only**, requires the run's
  actual starting state (missing is fatal), refuses a contradicting row unless registered under
  `data/m62/m63-rows/`, and returns a receipt carrying the row. §S.5's `cross_law` and `fp_base` live in that
  registration; an unregistered row's receipt says **RECORDED, NOT PINNED** rather than implying a pin.
  `--declare-unfrozen "<why>"` exists and **saying nothing is fatal**. The freeze file itself is untouched.
- **The producer field is now COMPUTED, not restated**, so it stays true on a base where his orbits do not
  exist — and the computation independently reproduces the hand correction. Both A412 artifacts regenerate
  to themselves, every entry, count, density and `config_sha256` identical.

**Two more instances for the catalogue, both the night's theme:**
- **A refusal in `require_frozen` had never been reachable.** Its "not in git history" branch sits behind the
  dirty check, and an untracked file is *dirty* — so the control labelled *"present but never committed"* was
  firing the **edited** branch under another name. Passing for the wrong reason. Now distinguished, with a
  new control that reaches the history branch.
- **The fix was about to reintroduce its own falsehood one run-shape over**: on the truncated
  first-candidate artifact the computed field called two of his orbits inadmissible when they are in the
  menu and merely unreached. Caught by a fourth control **before either artifact shipped**.

**RULING (product owner, 2026-09-12): wire the available anchor into the loop and `hismove`.** The starting
level's `LevelSet.minima` are minima of the unexpanded stage, so an anchor **is** available on Parts's base
and is simply unused. **CORRECTED 2026-09-12: my 0.2 s was wrong by 30×** — it was the D0 probe's per-*ask solve* rate, and the
anchor's first ask is a full 374-atom UNSAT proof. **Measured: 6.46 s per candidate**, 6.2 of it that proof;
sharing a solver across the two asks saves 0.07 s, so the cost is the proof and not the setup. **The ruling
survives on the count, not the ask:** the loop evaluates at most `budget × max_iterations` = **18
candidates**, so the anchor costs about **116 s for an entire run** — 14% per candidate, under two minutes
per run, against a 44 s close. **Neither ask may be dropped**: the first alone passes on a stage that refuses
everything, the second alone on a stage that colours everything. If 14% ever matters on a much larger sweep,
**the lever is the candidate count, not the anchor.** The measured figure now lives in the docstring, the log
line and the artifact's `controls` block, so nobody re-derives the ruling from my bad number. **It cannot change an answer, only cost** — so it cannot invalidate a frozen comparison, and it must be
registered as a **control, never a rule parameter**, i.e. it does not enter the rule hash. Phase E
established that checks 1–3 are internal consistency and **this is the only one comparing against a truth
outside the pipeline**; leaving it off where it is available is the exact pattern this queue exists to end.
**Still open:** `parts_diag.py` has no `--self-test`, so its declaration has no control of its own.

---

## §6d — THE ROTATION SCREEN: four rulings, and my asymmetry was half wrong (2026-09-12)

1. **CORRECTED — "believe a refusal immediately" covers only the MEASURED half.** The base's unit edges are
   measured (float proposes, exact decides), so the only error is a missed edge and a refusal is robust.
   **The cross edges are derived from a law**, where the error is an *invented* edge — denser graph, faster
   refusal, looks like success. **The new rotation's whole novelty is in the derived half, and at the new
   cosine that law is tied to nothing.** So: **a refusal at the new rotation is not believable until the
   cross-edge law at that cosine is independently checked**, and that check goes on the critical path rather
   than after something survives. It is cheaper than §7.2 prices it — one formal square-root symbol, not the
   full field. **The plan's §4.3 has it backwards:** being built by the law is why the law needs checking.
2. **The residue screen runs FIRST**, ahead of any solver call — 18 exact tests, microseconds, and a hit
   ends the screen with a **radius-free** theorem (eliminated on every base in that field at every radius)
   rather than a radius-bounded verdict. One-sided: firing proves colourable, silence proves nothing. Needs
   its own positive signal — zero monochromatic unit edges over all 3,433 base points, plus a distance-2
   pair that *does* read monochromatic as the negative control — and both primes above 2 tried separately.
3. **`−7/8` is NOT a second rotation: it is Parts's arena relabelled.** The lattice is invariant under
   negation, so mapping the second copy to its negative is an exact graph isomorphism. **126 is therefore
   forced there and a check asserting only "126 edges" cannot fail.** Do not spend an ask on it; keep it as
   a decomposition check that *can* fail — assert the three components separately **and** that
   **33 = 18 + 15** (2·33 + 0 + 60 = 2·18 + 30 + 60). §3.3 row 2 calls it *"LIVE … no published construction
   uses it"* — **it is the published construction**, and screening it would risk reporting the record as a
   new finding. §11.6's sign-pairing argument applies to rows 1–2 as well as 3–6.
4. **No ask is needed for the base alone, ever.** Parts's lattice lies in ℚ(√3,√11) at every radius and our
   own kernel-checked **Theorem B four-colours that whole plane** — so the base is colourable at any radius
   for free, and **any refusal the screen returns is necessarily carried by the cross edges.** This also
   closes the worry that every arena might refuse for a reason unrelated to rotation.

**Two things to know.** Sixty of Parts's 126 cross edges join the centre to the 30 points at distance 1,
and **those exist at every rotation whatsoever** — nearly half the calibration's headline number is a
constant of the base. And **report the seam size beside the radius**, never the radius alone: at some
candidate angles the seam is 18 pairs inside radius 1.02, so the arena is two nearly-separate lattices
joined through a small core and a colourable verdict there is a weak elimination by construction.

**Correction owed elsewhere:** M62 §R22's *"§R20's exhaustive subtype law is therefore untouched by the
enlargement"* is sound for the 21 **refusing** rows and unsound for the 11 **colourable** ones — the same
asymmetry, written backwards, in a sentence a write-up would quote. Harmless today because Theorem B covers
the row that mattered.

## §6c — THE FLOAT VERDICTS ARE RETIRED (2026-09-12, `8b59db6`) — the queue is clear

**Six sites in `tools/typem.py` now decide exactly**, and `ksign` moved *into* `typem.py` beside `kfloat`
(one predicate, one place; `typem_exact.py` imports it). **Every number unchanged, demonstrated four ways**
— base-vs-patched in one process (every *ordered* point list identical, so stored `.vtx` indices are
untouched), the calibration edge-for-edge at both radii, all 43 reference files re-verifying, and **the
509-vertex record object rebuilding with CaDiCaL UNSAT and an LRAT replay of 1,472,347 steps, all four of
its planted faults firing.**

**The ray-key site was NOT a rounding bug, and this is the finding.** `cross_edges_rho15_fast` was a
**second copy of the edge law** whose keys were *signed* directions — so a point and its antipode land in
different buckets and **can never be compared at all.** A structural blind spot, not a precision margin;
the rational point `(31/61, −32/61)` is a case where the old code returns no edge and the exact line key
returns both orderings. **Fixed by deleting the duplicate**, not by tightening a tolerance. Two laws that
are supposed to agree, one of which nobody re-derives, is the shape to watch for.

**Why the defect hid, stated exactly:** `ksign` agrees with 200-digit arithmetic on 100,000 inputs where
`kfloat` fails 10 — and **on *uniformly random* inputs `kfloat` fails none.** A defect reachable only near a
boundary is invisible to any test that samples the space evenly.

**My triage was wrong twice, both in the dangerous direction:**
- I said lines 445/741 were "builders phase G does not use". **`build_c13_base` is scheduled as a phase-G
  base** (that plan's row 3). Fixed anyway; zero callers today, so no number could move.
- **A seventh site I never named:** `unit_edges_fast` (L545) picks which pairs get the exact test using a
  KD-tree at float radius `1.0 + 1e-7`. **Too tight a radius drops unit edges** — the elimination-flattering
  direction. Measured 0 missed and 0 invented at both radii (11,286 and 28,566 edges), safe by ~8 orders —
  **but no control anywhere checks it, so it is safe by luck rather than by test.**

**APPROVED (product owner): add the `unit_edges_fast` control** — compare it against the exact `unit_edges`
on each base, a few minutes of compute. "Correct but untested" on the one routine that can silently drop
edges is not a state this milestone may carry onto a new base.

**It broke a control and repaired it rather than letting it pass vacuously.** `parts_stage.py` c5.1 was *"the
only thing that says the exact-line rewrite changed no edge"*, and the change would have made it compare a
function to itself — **unable ever to fail.** The retired ray keying is reimplemented inside the control so
it has something real to compare against. Same for `typem_exact.py` §6, which no longer claimed to measure a
law that had been deleted.

**Left deliberately, with the measurement:** float *sort* keys in five builders fix vertex indices, and
changing them would renumber vertices and invalidate every stored `.vtx`. Ties measured: **zero** on every
base in use. **Cost accepted:** the exact cross-edge law is 2.9× slower and base building 1.35×; both are
one-off constructors, not loops.
4. **Record the edge object** in the ledger as a measurement with its bracket. No certificate.
5. **Phase E** (held-out problems, required for the close) and **phase F** (beat), per `§S.4`.
6. **Milestone G**: other base graphs and the ~412 admissible rotations (`plans/STUB-consume-rotation-list.md`,
   already bannered; `data/m62/rotations-moser-r2.05.json`). Its opening gate is one refusal ask per rotation
   on a base sized from that rotation's own endpoint bound; rank by radius families, the 2-adic wall and
   6-openness, **never** by cross-edge count.
7. **At the close**: `CLAUDE.md` § Frontier, the ledger row, and `plans/FRONTIER-STUBS.md`.

---

## §7 — Standing lessons from this session, worth more than the numbers

- **An optimisation correct about *cost* can be silently wrong about *meaning*.** Five instances tonight;
  three were checks printing confident, benign answers while measuring nothing.
- **A monitoring check owes the same negative control as a correctness check.** Kill something and watch it
  notice. A liveness check that could not see its own process nearly produced a false crash report.
- **Take edges from the assembled stage, never from a relation computed on the base.** The shared centre and
  the two-sided index space produced three independent faults in three agents in one afternoon.
- **Take a job's pgid from the live process table after launch**, never from the launching shell — `setsid`
  forks again.
- **`git add` and `git commit` must be one command, never two moments.** A failed commit left a file staged
  and the next agent's commit swept it up.
- **Before launching a probe, ask what is already on disk that would decide it.** Twice the deciding object
  was a file read away while cores were being aimed at the question.
- **Both parameters of Parts's loop are readable off his published files with no solver** — the companion by
  a refusal test over the 24 orientations, the rung by a stabiliser computation.
- **His admission rule has three readings** (strict / literal-internal / plus cross edges) and a fills
  exemption his degree test misses. Menus: large half **62 + 26 shoulder**; small half **14 singles**,
  **112 pairs**.
- **His own recorded successful expansion added FOUR orbits at once.** Every sweep run so far tests single
  moves, so an all-inert result closes single moves and nothing more. Multi-orbit is the open question.

---

## §8 — First moves after a compaction

1. `ListAgents`, then ask each live agent for a one-paragraph status. Do not assume anything about their
   state from this file.
2. Close phases C and D before starting anything new.
3. Do not re-open a ruling in §5 without a measurement that contradicts it.
