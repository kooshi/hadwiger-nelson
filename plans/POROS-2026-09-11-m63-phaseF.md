# Poros — the advisory record for M63 phase F (beat 509)

*Advisor to the phase F planner (`a404d57e6a1c6786c`), 2026-09-11. The engineer commits this file by
path. Three cards stand open; the resolved ones are kept below with their fates, and killed hunches
stay. I launched, signalled and killed no process.*

**Where this landed.** The engineer and I converged independently on the same inversion — expansion is
monotone, so one reduction over a *block* of orbits decides every subset of that block, and the ranked
pair ladder is a dominated instrument. They improved it (group testing over a monotone predicate,
covering designs) and corrected two errors of mine, one load-bearing. The live question is no longer
which experiment but **whether a five-vertex improvement over Parts's own accumulators is a record at
all** — a ruling, not a measurement, and card 1 asks for it.

## Evidence inventory

- `plans/M63-parts-reproduction.md` §S.1 clause 4 and §S.4's phase F menu — read against: the menu is current with phases C and D — surprised: yes; written at phase C planning time, amended only to strike (g)'s radius half, so it contains **no multi-orbit item** — the one move with a demonstrated positive
- `plans/M63-phaseD-the-loop.md` §R3.14 and §H2.8 — read against: the 89-candidate sweep samples a larger space — surprised: yes; complete over a closed menu (0/63, 0/26, one growth), and the weight argument upgrades "inert" to "never in any optimum"
- `data/m62/m63-trim-test.json` — read against: the trim drops part of his recorded move, explaining the stall — surprised: yes; `trim-preserves-his-move` 30/30, and its `monotonicity_note` carries the derivation this record turns on
- `plans/M63-phaseD-the-loop.md` §O2 lines 1223–1241 — read against: monotonicity holds unconditionally — surprised: yes; three load-bearing hypotheses, and only rung 1 is immune to `Aut(A)` moving under expansion
- `plans/M63-phaseD-the-loop.md` §O3 lines 1266–1287 — read against: a big stage must enumerate its level to say anything — surprised: yes; a target ask returns a sound one-sided bound with no level, gated on zero undecided asks
- `data/m62/m63-freeze.json` — read against: the admission reading is one of the three measured — surprised: yes; `b-literal-internal` counts no cross edge — but see the killed hunch, which this did not license
- `plans/M63-phaseD-the-loop.md` §R3.3 census table — read against: nothing, I cited this table and did not read its reading-(c) row — surprised: yes, against myself; (b) and (c) are identical on A412 at 57/62/26, which kills my hunch
- `data/m62/m63-loop-A403.json` — read against: the frozen rule improves or fails close — surprised: no; `stalled`, six iterations unchanged at 375
- the four stored reduction records' cost fields — read against: cost grows with stage size — surprised: yes; the 166-vertex stage cost 713 CPU s and the 403-vertex stage 87 CPU s, an 8× inversion; cost is asks × per-ask cost
- `data/m62/m63-map-A412.json`, the full time distribution — read against: the engineer's flat medians of 214–246 s describe the runs — surprised: yes; p50 185 s, p90 269 s, max 418 s, ratio 2.26, total 11.47 CPU h over 266 timed entries
- `data/m62/ckpt/m63-joint-A412-A166.ckpt.json` and `-coset2`, plus the process table — read against: closed or nearly — surprised: no; both in-progress at 4.9 h, matching the reported brackets
- `plans/M63-phaseC-joint-stage.md` §R2, commit `b683821` — read against: the joint route is an open-ended search — surprised: yes; 423 forced atoms and 153 free, Parts keeps 85 and ≥80 are needed, so the whole joint route is worth at most five vertices
- `tools/parts_reduce.py:190` on `stage_identity` — read against: the two joint frames might be one stage under two names — surprised: no; it identifies the graph and deletable set, and the two differ, so the frames are genuinely distinct objects
- `tools/parts_probe.py` against `data/m62/m63-probe-P*.vtx` — read against: the probe's named instrument produced its pair artifacts — surprised: yes; zero occurrences of "pair" and four subcommands, yet 112 pair `.vtx` files and three pair JSONs are tracked in git
- `plans/M63-kernel-certification-route.md` — read against: certification is an unpriced risk at the end of F — surprised: yes; measured end to end, one segment genuinely kernel-checked, so F's first acceptance bullet is largely discharged
- the two probe reductions still running, PIDs 2697934 and 2698381 at ~4h30m CPU — read against: probe prediction P7, every run closes under 30 minutes CPU — surprised: yes; 8× past that budget while twelve siblings, five at the same gap 54, finished in 30–70 minutes
- `data/m62/m63-his-move.json` — read against: `reduced`, calibrating the set-valued apparatus at the one known positive — surprised: unread; PID 2935375 still running, and this is the block ladder's gate
- `plans/POROS-2026-09-11-m63-phaseD.md` — sampled by its 30-card index, not read whole — read against: my cards do not duplicate the phase D advisor's — surprised: no; cards 2, 9, 16, 20, 25, 30 are cited rather than repeated

## The open cards

question: does-a-504-over-his-accumulators-count-as-our-own-finding
  evidence: `plans/M63-phaseC-joint-stage.md` §R2 (commit `b683821`) brackets the joint route at 504–509 vertices — 423 forced atoms, 153 free, Parts keeps 85 and ≥80 are needed; every atom comes from his `A412` and his `A166`, and the method is reduction, which we reproduce
  expected: any object under 509 vertices is the headline record by §S.1 clause 4
  ask: the 2,279-edge object was ruled a measurement because thinning his graph is not our own finding — does a minimum selection from his two accumulators fall under that same ruling?
  if it is a record: the joint finish is the cheapest bounded prize on the board and outranks everything, because it terminates in a definite answer for a knowable cost
  if it is the 2,279-edge ruling again: the joint route's value is the closure statement "509 is optimal over his accumulators", worth a bounded cost and not worth racing for, and multi-orbit expansion becomes the only route to the product
  answered by: human — the product owner; one sentence
  cost: none
  rank: 1
  fate: ANSWERED 2026-09-11 — it IS a record, on a criterion sharper than the one I offered: not whose inputs, but whether the object is CONTAINED IN HIS ANSWER. His 509 is vertex-critical (508 critical atoms, 0 droppable — phase C's own positive control), so a 504 refusing selection cannot be a subgraph of it and is an object his answer does not contain. The 2,279-edge object was his exact vertex set minus 163 of his edges, in a gap he and de Grey had announced in print as non-exhaustive. Vertex count is the headline; edges are his own secondary tie-break. Honesty condition on any write-up: accumulators, rotation, base lattice and algorithm are his, and the joint reduction is ours.

question: is-the-hitting-set-step-the-joint-routes-real-cost
  evidence: `plans/M63-phaseC-joint-stage.md` §R2 (commit `b683821`) — the SAT oracle is 27% of the joint run and the per-iteration hitting-set solve is the rest, grown 25–40× while the correction-set family grew 4×; phase 1 leaves a minimum hitting set over 153 free atoms
  expected: the joint route's cost is SAT, and therefore irreducible
  ask: 153 binary variables is small for any exact solver, so is the remaining joint cost an algorithmic mismatch in a replaceable subsystem rather than a property of the problem?
  if it is replaceable: the joint bracket closes in hours instead of days, and its answer deletes menu item (c) and part of (b) whichever way it falls
  if it is not: the joint route's remaining cost is unbounded and the expansion staircase should take the core first
  answered by: derivation — profile the per-iteration hitting-set solve and price an exact MHS or ILP over 153 binaries against it
  cost: minutes to profile
  hunch: a Python branch-and-bound is being asked to do an ILP's job
  falsifier: a profile showing the step is already an exact solver at its complexity floor
  rank: 2

question: does-a-block-inherit-its-worst-members-cost
  evidence: `data/m62/m63-map-A412.json`, 266 timed entries — p50 185 s, p90 269 s, max 418 s, ratio 2.26; and on the small half two of fourteen singles sit at ~250 CPU minutes against twelve siblings at 30–70 minutes, five of those at the same gap 54
  expected: the medians of 214–246 s predict a block's cost
  ask: a block's cost is set by its hardest member rather than its median, so does a schedule priced on medians underestimate, and by how much as block size grows?
  if the tail dominates: every staircase rung reports max and distribution, and every block carries a wall, or one hard orbit stalls a block silently and its `unknown-at-target` leaves a hole in the cover
  if it does not: medians are a fair basis and the block schedule can be priced as written
  answered by: run — record the full distribution at each staircase rung, not the median
  cost: none beyond reporting what the runs already produce
  rank: 3
  fate: REFINED 2026-09-11 by the product owner, who could see inside the two stragglers — they are in different states. Candidate (0,0,6,6) has its minimum already (135 atoms plus the shared centre = 136 vertices, the inert answer) and is enumerating its level set; candidate (12,0,2,6) has found no minimum at all. So the tail is TWO phenomena, and target mode separates them: a block run at target 372 never enumerates a level, so type A cannot arise, while type B is exactly the unknown-at-target risk that leaves a hole in a cover. Consequence for the staircase — its cost must be measured IN TARGET MODE, because level-enumerating runs overstate type A and say nothing at all about type B.

## Resolved, with fates — kept because the reasons travel

- **The block dominates the pair ladder.** Monotonicity (§O2 with the trim-test note) means one
  reduction over a block decides every subset inside it, so the C(62,2) = 1,891 pair sweep is
  dominated and no ranking, additivity or random control is needed — nothing is sampled. **ADOPTED as
  the plan's spine, with my target corrected from 373 to 372 atoms**: the incumbent is 373 atoms = 374
  vertices, so beating 509 needs 372 atoms = 373 vertices = an assembled 508, and a run at target 373
  asks a question already answered.
- **The companion sweep is already being computed.** Every (L-minimum, S-selection) pairing menu item
  (c) would try is a selection of the joint stage (§S.2 #8), so the joint verdict dominates it.
  **ADOPTED; the engineer reached the same domination independently and struck (c).**
- **Menu item (d) is one run, not a menu.** Adding edges at a fixed vertex set preserves refusal, so a
  stage carrying all five of M62 §R20's connection orbits dominates every connection subtype including
  his. **ADOPTED, merging into the block ladder after a solver-free containment check.**
- **The acceptance sentence is written before the runs.** A block negative is relative to four
  parameters at once — companion, frame, rung, admission reading. **ADOPTED.**
- **A strength-2 cover misses his own move's rung.** A block certifies only its own subsets, so a
  C(62,m,2) design leaves four-subsets spanning blocks untested — exactly where his one recorded
  success lives (fills `(0,0,2,2)`, `(0,0,2,6)` plus reserve ranks 6 and 7, `(0,0,0,4)`, `(0,0,6,6)`).
  **RAISED**: stratify blocks by the 17 partially-occupied orbits plus the top reserve, or state in
  the acceptance that the cover is silent at rung four.
  **MEASURED 2026-09-11, and it corrects both of us.** The engineer replied that at `A412` all four of
  his orbits are already present, so stratifying around them is meaningless there — citing the map's
  own field `his_move_absent_by_construction`, which reads *"the four orbits his move used are not in
  the candidate set at all."* **That field is wrong on two of the four.** In
  `data/m62/m63-map-A412.json`, `(0,0,0,4)` is entry `(0,0,0,4):3` and `(0,0,6,6)` is entry
  `(0,0,6,6):6`, both `provenance: partial-fill`, adding 3 and 6 vertices — they are live candidates.
  Only `(0,0,2,2)` and `(0,0,2,6)` are genuinely absorbed, which is exactly what §S.2 #9 says
  (`A412` adds "the other half" of those two and claims nothing about the other pair). So the plan's
  own record and this measurement agree; only the map's summary sentence overstates.
  Three consequences. The stratification **is** realisable at `A412`, over the two of his orbits that
  remain candidates. The map already carries a sharper fact than "singles are unused": **two of the
  four orbits of his own successful move, offered singly at `A412`, are inert** — neither improved,
  and neither is the single candidate that grew the level, which was `(6,2,8,0)`. And the map's field
  should be corrected in place, because a reader following it would conclude his move's material is
  untestable at `A412` when two-thirds of it is sitting in the candidate set.
- **The two joint frames are not two shots.** `stage_identity` covers the graph and deletable set and
  the two differ, so the frames are distinct objects and the "frame silently fell through" reading is
  dead. But C4b's upper bound is 577 against C4a's 509, so the record is not a selection of C4b's
  stage: it is unanchored, its lower bound of 500 is weak information, and F must not price the frame
  as two independent chances at the five vertices. **RAISED, with the cheap settle — compare the two
  correction-set hypergraphs on size distribution and degree sequence.**
- **The pair files have no producer.** `tools/parts_probe.py` is committed but contains zero
  occurrences of "pair" and offers only menu/emit/emit-menu/control, while 112 `m63-probe-P*.vtx`
  files and three pair JSONs are tracked — so the §7c counts 91/112/350 are unreproducible too.
  **CONFIRMED by measurement**; the test is that a committed producer regenerates files and counts
  identically, the `regenerated-identical` discipline `parts_run.py` already applies.

## Hunch ledger

hunch: the-block-dominates-the-pair-ladder
  claim: one reduction over a block of orbits at target 372 decides every subset expansion inside that block, so the pair sweep is dominated
  basis: derived
  falsifier: a block at size 8 that neither closes nor yields a usable lower bound within 30 minutes
  registered: 2026-09-11
  status: open

hunch: the-frozen-reading-is-blind-to-connection-material
  claim: the frozen b-literal-internal admission reading cannot rank the cross-edge-bearing material M62 §R20 proves essential, so phase F's menu should use the cross-edge reading
  basis: measured
  falsifier: the two readings return the same menu on A412
  registered: 2026-09-11
  status: killed (by: phase D §R3.3's census table, which I had already cited for another purpose and had not read across — readings (b) and (c) both give reserve 57, menu 62, shoulder 26 on A412. The promotion phenomenon is real and is a small-half phenomenon only. The mechanism of the miss was promoting a pattern seen on one half to a rule about both; the engineer caught it inside the hour from my own citation, and it cost nothing)

hunch: the-joint-routes-remaining-cost-is-a-replaceable-subsystem
  claim: the per-iteration hitting-set solve, 73% of the joint run and grown 25-40x against a 4x family growth, is an algorithmic mismatch on a 153-variable problem
  basis: read
  falsifier: a profile showing the step is already an exact solver at its complexity floor
  registered: 2026-09-11
  status: open

hunch: block-cost-is-set-by-the-tail
  claim: a block's cost tracks its hardest member, so a schedule priced on medians underestimates, and the gap widens with block size
  basis: measured
  falsifier: a staircase rung whose cost sits at the median of its members rather than near their max
  registered: 2026-09-11
  status: open

## What the engineer corrected in me, kept because the ledger is the calibration

1. **The target was off by one, and it was load-bearing.** I wrote "target 373" three times; it must be
   372 atoms. A ladder at 373 asks a question already answered and would have wasted its first rungs.
2. **A small-half pattern promoted to a rule**, refuted by a table I had already cited. Killed above
   with its mechanism named.

3. **I asserted the very thing my next card questions.** Card 1's "it is a record" branch said the
   joint finish "terminates in a definite answer for a knowable cost" — while card 2 asks whether that
   cost is knowable at all. The product owner caught it and branched the ordering on the cost
   attribution instead of assuming it. An inconsistency between two of my own adjacent cards is the
   failure I am here to catch in others.

4. **And one correction of mine was itself half wrong, in both directions.** The engineer's reply that
   `A412` already contains all four of his orbits is true of two and false of two: `(0,0,0,4)` and
   `(0,0,6,6)` are live partial-fill candidates in the map, adding 3 and 6 vertices. My original
   recommendation was therefore realisable at `A412` after all — but my *first* attempt to check it
   returned zero matches from a broken label comparison, and a zero from an instrument that cannot
   see is not evidence. I re-ran it against the file's real structure before believing either side.

Two were caught by the engineer, one by the product owner, and one of the engineer's corrections to me
turned out half wrong on measurement — all from sources I supplied, within the hour. Two of my
questions were adopted unchanged and one was answered by ruling. That is the ratio the ledger should
show, and the mechanism common to my three misses is worth naming: **each was a statement made about
the wrong object** — the small half read as both halves, `A403`'s state read as `A412`'s, and a cost
called knowable in one card while the next card asked whether it was.

## Standing constraints I confirmed rather than raised

- **Phase E's held-out rows.** Menu item (b) names `A172` = `v172e804` (S M6B) and `A167` = `v167e772`
  (S M6C), both on §S.4 phase E's held-out list, so (b) as written spends two of E's six rows. With the
  joint domination, **(b) is fully disposed of: the part that is not dominated is the part that is not
  allowed.** The damage is bounded — those are E's *reduction* rows, not E's required *loop* row, the
  8/3 mono-pair `v367e1822` — and phase C3 with the M6B 375 row is the precedent for spending one with
  recorded approval.
- **The hismove gate.** No block ladder launches before `data/m62/m63-his-move.json` lands. Every
  instrument in this milestone has returned zeros; `reduced` calibrates the set-valued apparatus at the
  one state whose answer is known, and `no-selection-at-target` would make every negative on this half,
  the 89-map included, a fact about our pipeline instead.
- **Rung 1 only, or the rung pinned as an explicit element list.** §O2's nesting needs
  `atoms(W ∪ D') ⊆ atoms(W ∪ D)`; above rung 1 the atoms are orbits of a group that moves when `A`
  grows, and §O2 names F's symmetric seeds as the unsafe case.
- **Pin by value.** The pin triangle must be identical in every block run — anything chosen by a rule
  that reads `A` changes meaning when `A` grows, and a re-chosen pin silently breaks the nesting.
- **A block returning `unknown-at-target` is not a covered block.** §O3: a target failure carrying any
  undecided ask has refuted nothing, and a cover with a hole reported as a cover is this repository's
  own fail-open shape.
- **Pin a triangle before logging any proof you intend to keep** — 31×, measured
  (`plans/M63-kernel-certification-route.md` §2).
