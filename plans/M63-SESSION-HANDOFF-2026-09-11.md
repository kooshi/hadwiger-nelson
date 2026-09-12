# M63 — handoff from the product-owner session, 2026-09-11

*Written by the main session to its own post-compaction successor, and to anyone who picks this up cold.
Everything here is either a quote, a decision with its reason, or an address. No agent IDs: recover live
agents with `ListAgents` and ask each for a one-paragraph status before doing anything else.*

---

## §0 — State at the moment this was written (22:21)

- **Phase C's two joint reductions are alive and close**: 4h25m in, lower bounds **503 and 499** of a ceiling
  of 508 atoms (= 509 vertices). Checkpointed. Their verdicts are the last thing phase C needs.
- **Phase D's second implementer has finished and committed**; twelve commits, tree clean of its work. The
  advisor's record is final at 2,082 lines, committed at `95a88ef`.
- **Still running**: the 374-point enumeration, an enumeration of his own move's solution set, phase C's two
  joint runs, the small-half probe, and a diagnostic. All checkpointed and resumable.
- **The certification was cancelled mid-flight** (§4). Before stopping it had established things worth
  keeping for the next certificate — the one we will want for an object we found ourselves:
  - the geometry of the refuted formula reconstructs exactly over the existing ℚ(√3,√5,√7,√11) tower, and a
    regenerated unpinned formula is **byte-identical** to the one that was refuted, so the certified object
    would provably be the refuted object;
  - **pinning buys 31× on this object** (442M hint entries unpinned against 14.3M pinned); racing solver
    configurations does **not** reproduce here (39 runs, 16 triangles × 4 configurations, best only 4.6%
    under the emitted proof), so pinning is the whole lever;
  - after backward trimming: 173,684 additions, 9.1M hint entries, a 183,311-clause table, **468 modules and
    81.3 MB of generated source**, with a projection of ~3.4 CPU hours that is optimistic because this
    repository measures 2.36–2.93 ms per hint at that table size against the 1.35 ms the projection assumed.
  - **A process-management incident with no damage:** its first two attempts to stop its own background jobs
    failed silently, because `setsid cmd &` double-forks and the recorded PID was not the group's. Five of
    its solvers survived two kill attempts and held the box at load 19. It then killed them by explicit PID;
    **all twelve were its own, and every other agent's run was verified alive afterwards.**

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

**Phase C — the joint test and the instruments.** Plan `plans/M63-phaseC-joint-stage.md`, approved §A.
Built and committed: `tools/parts_run.py` (the driver), exact resume, the bounded ask (conflict slices, not
`interrupt()`, which this CaDiCaL does not implement), `tools/parts_audit.py`, `typem.CrossLaw`, the repaired
freeze. **Open: the two joint reductions**, both frames of `A412 ∪ ρ·g⁻¹(A166)`, last at lower bounds 494 and
493 against a ceiling of 508 atoms (= 509 vertices). §R2 and §S.3's C rows wait on those verdicts.

**Phase D — the loop.** Plan `plans/M63-phaseD-the-loop.md`, approved §A, handoff §H2.
- **The 89-candidate outcome map is complete: 0 improve, 1 grows the level, 0 undecided.** Single-orbit
  growth from the 412-point accumulator does not reach 373 vertices — complete over a closed menu.
- **The threshold question is symmetric**: the 26 shoulder candidates below Parts's admission cut are as
  inert as the 62 above. His cut is neither vindicated nor convicted, and the comparison has no power.
- **His state 1 reproduces four-for-four** (376 vertices, 96 minima, `A` = his `v451e2400` literally, edge
  range 1890–1947) once the companion was identified.
- **The 2,279-edge object** (§4 below).
- **Open: acceptance clause 2(b)** — the frozen rule reaching 374 from the 403-point accumulator. Running,
  escalating to his set-valued strategy after three unchanged iterations.

**The small-half probe.** Plan `plans/M63-probe-S-expansion.md`. **13 of 14 single-orbit candidates decided,
every one at 136 vertices with a bit-for-bit identical level and an unchanged accumulator** — including the
√5 orbit outside Parts's own search disk and the advisor's nominated best pick. Pair menu measured under
three readings of his admission rule: **91 / 112 / 350**; the authorised 112 run next, **21 promoted pairs
first**, then the 91; the 350 is a separate decision afterwards.

---

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

---

## §6 — Outstanding, in order

1. **Close phase C**: collect the two joint verdicts, score P-C4.0–P-C4.4, write §R2's verdict rows and
   headline, update §S.3's C rows, commit the advisor's record, report. A fresh closer may be needed — that
   implementer is at ~830k tokens.
2. **Close phase D**: clause 2(b)'s outcome, §R3, §S.3's D rows. **Then apply its §X.4–X.7 replacement texts
   to `plans/M63-parts-reproduction.md` §S — those are the product owner's to apply, not the implementer's.**
3. **The probe**: last verdict, then the 112 pairs (21 promoted first), then a decision on the 350.
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
