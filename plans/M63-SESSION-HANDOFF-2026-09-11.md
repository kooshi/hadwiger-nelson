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
- **The forfeited out-of-sample test has a stronger replacement, not a weaker one.** Its partial scores
  +1.0% inside the 5% falsifier but is an extrapolation beyond the fitted range and is *not* the registered
  test. What replaces it: the law's **derivative** is measurable from a checkpoint at as many points as
  wanted, on a quiet box — six prefixes give cost linear in level size, so **the integral is quadratic by
  construction rather than by curve-fitting.**
- **NEW, and the general form is worth more than the instance: removing the quadratic exposed a second one
  of identical shape.** About 0.09 s per iteration was unexplained; it is the **progress log**, which unions
  every minimum found so far every 5 minima — 557 ms at 20,733 minima, 111 ms per iteration amortised,
  linear in level size and hence cumulatively quadratic. It is now the dominant non-oracle cost and removing
  it should give roughly another **4×**. Not fixed because two runs are executing that file. **The rule: a
  cost that grows with the level need not live in the solver, and removing the dominant one merely promotes
  the next of the same shape — this one was hiding in a diagnostic nobody profiles.**
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
