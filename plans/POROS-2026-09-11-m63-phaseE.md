# Poros — M63 phase E, the held-out generalization phase

*Advisor's record, 2026-09-11. Written by Poros (`~/source/poros/CLAUDE.md`), uncommitted; the engineer
or the product owner commits it by path. Cards are numbered for citation and scoring. Constructions are
offered in the hypothetical mood; questions are in the indicative. Every card names the evidence that
begged it, with an address.*

**The engineer planning phase E is at `a6eae8d5f734adb68`.** All twenty cards were sent to it across five
messages, the last before its draft existed. Card 13 was corrected an hour after it was sent; the
killed half is kept in the ledger with what killed it.

---

## §0 — The frame, on the five axes

Written before any card, so it is reviewable.

| axis | what it is here | address |
|---|---|---|
| **the object** | the reduce-and-expand pipeline in `tools/parts_{stage,reduce,loop,rule,report}.py`, run on problems it was not tuned on | — |
| **the question** | does the apparatus still agree with Parts's published numbers when nobody aimed it at them? | `plans/M63-parts-reproduction.md` §S.4 "Phase E" |
| **the discipline** | held-out validation / pre-registration — the discipline is experimental design, not combinatorics | — |
| **the audience** | a reader who trusts none of the Python and reads none of it (`CLAUDE.md` § The standard of evidence above rung B) | — |
| **the product** | **the method, with a warranty** — corrected tonight; not a smaller version of Parts's object | product owner, 2026-09-11 |

**The product axis moved tonight and the plan predates the move.** §S.4's phase E was written when the
product was the object; it reads as a checklist of rows to tick. If the product is the method, E is the
document that says *what the method is warranted for and what it is not*, and the rows are its evidence.
Those are different artifacts. The most consequential thing E can get wrong is to produce the first when
the second was asked for.

---

## §1 — Evidence inventory

*An item is READ only when it was read against an expectation written first.*

- `plans/M63-parts-reproduction.md` §S.1–§S.4, the milestone plan — read against: E's acceptance should be a list of rows with attested targets — surprised: no; it is exactly that, and the rows are well chosen
- `data/m62/m63-freeze.json`, the freeze at commit `6158162` — read against: it should cover what E's seven rows are judged under — surprised: yes; it covers the expansion rule only, and six of the seven rows are reductions that nothing in the file touches (cards 1, 3)
- `tools/parts_report.py:require_frozen` and the `Comparison` type — read against: a gate that refuses an unregistered held-out run — surprised: yes, partly; the five refusals are real and planted, but the caller is opt-in and `Comparison` cannot record a companion (cards 2, 11)
- `tools/parts_rule.py:run_loop`, lines 321-323, 387 and 522 — read against: a loop parameterised by its problem — surprised: yes; the starting stage, the base and the anchor are all hard-coded (cards 4, 5)
- `tools/parts_loop.py:check_invariants`, lines 453-508 — read against: four checks, all live on every run — surprised: yes; check 4 is skipped in silence when no anchor is supplied and the verdict string is identical either way (cards 5, 6)
- `tools/parts_diag.py:hismove`, line 196, tonight's calibration gate — read against: the calibration ran with every control on — surprised: yes; `anchor_tuples=None`, and it calls `sweep_candidate` directly rather than `run_loop` (cards 5, 12)
- `plans/M63-parts-reproduction.md` §R1 lines 1145-1151 — read against: a reproduction of his count of minima — surprised: yes, and this is the sharpest thing in the record; the counting group was chosen because it made that row agree (card 13)
- `plans/M63-SESSION-HANDOFF-2026-09-11.md` §6.5 and §6.6 — read against: the two facts I was briefed on should be attested at an address — surprised: no; both confirmed, and the cost ratio is 188 s against 79 minutes and climbing
- `tools/parts_rule.py:_rank_ours` and the `RULES` table at line 202 — read against: a ranking with a live first sort key — surprised: yes; with the proxy flat it is provably `his_degree` (card 8)
- `data/m62/*.json`, 82 committed records — read against: there should be no record for any of E's six reduction rows — surprised: no; none exists, the rows are genuinely unrun, and `m63-M6B403-reduction.json` is the spent M6B 375 row
- `plans/M63-phaseE-held-out.md`, the plan this record advises, 1,083 lines — read against: cards 1-20 either adopted with a reason or refused with a reason, and no card silently absorbed — surprised: no on adoption (§P scores them and §6 gives thirteen four-part decisions), yes on two residual joints: the cost argument concedes correctly but reasons on the wrong quantity, and P-E18's attribution clause is inconsistent with P-E20 (cards 21, 22)

---

## §2 — The hunch ledger

hunch: the-freeze-covers-one-row-of-seven
  claim: `require_frozen` can only ever police the loop row; no reduction path calls it, and the
         hashed config contains no reduction parameter
  basis: read
  falsifier: a call to `require_frozen` from `parts_reduce`, or a reduction knob inside the frozen config
  registered: 2026-09-11
  status: confirmed (by: `grep -rn require_frozen tools/*.py` returns exactly `parts_rule.py:519-520`;
          `data/m62/m63-freeze.json` has no `wall_ask`, `max_minima`, `cross_law`, `fp_base`, `rung`)

hunch: the-anchor-is-already-off-where-E-will-run
  claim: the known-answer anchor is live only in `run_map`; `run_loop` and `hismove` both pass
         `anchor_tuples=None`, and nothing in the record says a run had no anchor
  basis: read
  falsifier: an artifact from `run_loop` or `hismove` carrying an `invariants.anchor` key
  registered: 2026-09-11
  status: confirmed (by: `tools/parts_rule.py:387`, `tools/parts_diag.py:196`, both literal `None`;
          `check_invariants` has `if anchor is not None:` with no else branch)

hunch: the-counting-group-is-a-fitted-parameter
  claim: `|{M}| up to Aut(A)` was selected because it reproduced his 8 on the S M6A row, and exactly
         one row has ever discriminated between the three candidate groups
  basis: read
  falsifier: a second row, run before E, on which the three groups give different counts and his number
             picks out `Aut(A)` again
  registered: 2026-09-11
  status: KILLED IN ITS SECOND HALF, 2026-09-11, by its own falsifier, an hour after registration.
          `data/m62/m63-audit-{L451,M6B403,S166}.json` each carry a `counts` dict keyed by group and
          labelled "Stab(reduced part), companion free -- HIS convention": 282 of 3,264 (order 12),
          66 of 360 (order 6), 8 of 48 (order 6). So the convention was fitted on S166 and then
          agreed on two further rows where the companion-fixed alternative would have given 3,264,
          360 and 48. The first half stands and is narrower: of those two confirmations one is the
          SPENT M6B 375 row, and at L451 the remaining rival (the whole order-24 group) also gives
          282, so the live ambiguity -- `Aut(A)` against the full base group -- has been separated
          on no row at all. Card 13 is rewritten to that claim and its ask survives at reduced cost

hunch: the-loop-rows-rule-degenerates-to-his-ordering
  claim: `_rank_ours` sorts by `(-freed_per_vertex, his_rank)`, so wherever the look-ahead proxy is
         flat the first key is constant and `rule="ours"` and `rule="his_degree"` produce the same
         order; §S.3 B-12 measured that proxy at 0 on every orbit tried, his own move's included
  basis: derived
  falsifier: a non-zero `look_ahead.freed` on any 8/3 mono-pair candidate — one cheap pre-run computation
  registered: 2026-09-11
  status: open -- falsifiable in minutes, before the row runs; card 8

---

## §3 — The cards

### Group A — is it actually held out? (the principal's #1)

question: what-is-the-freeze-actually-freezing
  evidence: `require_frozen` (tools/parts_report.py:251) compares an offered config against
    `data/m62/m63-freeze.json` by hash. That file's config holds `n_new_max`, `look_ahead_batch`,
    `stall_limit`, `escalation_schedule`, `many_then_trim`, `seed`, `bans` — the EXPANSION RULE. It holds
    no `wall_ask`, no `max_minima`, no `phase2_wall`, no `rung`, no `cross_law`, no `fp_base`.
    `grep -rn require_frozen tools/*.py` returns one caller: `parts_rule.py:519`.
  expected: a configuration covering what the seven E rows are judged under
  ask: six of E's seven rows are reductions and nothing freezes them — what registers a reduction
    row's parameters before it runs?
  if a second freeze: E writes a per-row registration (companion fingerprint, stage fingerprint,
    rung, counting group, wall, level cap, predicted values) and commits it before any run; that file
    is the warranty, and `6158162` covers the loop row alone
  if the current freeze is deemed enough: then the plan must say in writing that the reduction rows are
    unfrozen and what stops a wall or a cap being raised mid-row; a reader who trusts no Python
    cannot tell from the artifact
  answered by: the record (read the config; it is 36 lines) then the engineer
  cost: minutes
  hunch: a second registration is needed and is cheap — `parts_report.freeze` already writes one from
    any dict
  falsifier: a reduction parameter inside the committed frozen config
  rank: 1

**Card 1 — the freeze covers the rule, not the problem.** Note §S.5 recorded the *intent*: *"The freeze
pins `cross_law = collinear(7/8)` and `fp_base(Base(2.6))` inside the config hash."* Neither is in the
committed file. That is not a criticism of the freeze — it was a rule freeze and says so — it is a
statement that the plan's sentence "the configuration is frozen" is true of one row in seven.

**Card 2 — `--require-frozen` is opt-in.** `tools/parts_rule.py:506` defines it as a flag, default off.
A held-out run launched without it produces an artifact with `freeze_commit: None` and nothing objects.
The five refusals are well built and are planted and watched (`_freeze_control`) — *in a scratch git
repository*. §S.4's phase D acceptance asks for `require_frozen` "exercised red and green on the real
file", and I find no evidence it has been. **Suggested, hypothetically:** make the flag default ON for
any run whose record will carry a `frozen` `Comparison`, and exercise it red once on the real file by
offering a config with one knob changed. A trust receipt that has never been seen to fire on the real
artifact is this project's own named failure mode.

**Card 3 — the frozen config asserts A403, and will be false on every E row.** `held_out_state` reads
*"our 375-level accumulator, 403 vertices"*, `incumbent_weight: 374`, and `target` names 373. The
runtime incumbent is derived from the starting record (`parts_rule.py:329`, `incumbent = ls.size`), so
these fields do not drive the run — they only describe it. On the 8/3 row the starting state is 367
vertices and the incumbent 366, and `require_frozen` will pass those three false sentences by hash
equality. A later reader cannot recover which state a frozen run was on from the freeze. **Suggested:**
E's per-row registration carries the true starting state, and the plan notes that the freeze's own
state fields are A403's and are not to be read as the row's.

**Card 13 — the counting group is a fitted parameter, and the live ambiguity has never been tested.**
*Rewritten 2026-09-11, an hour after it was first sent, by its own falsifier. The version I sent the
engineer claimed "exactly one row has ever discriminated between the three candidate groups". That was
wrong, and the correction is below. The ask survives, smaller and better aimed.*

§R1, lines 1145–1151: *"Our 48 raw minima give **24** up to the stage's own input symmetry
`Aut(W ∪ C)` and **8** up to `Aut(A)` … **His number is 8, so that is his convention**."* That is a
parameter of the comparison apparatus chosen because it made one row agree, and it governs every
`|{M}|` row E will report.

**What I got wrong.** The fit has two independent confirmations, and the instruments carry them
properly. `data/m62/m63-audit-{L451,M6B403,S166}.json` each hold a `counts` dictionary keyed by group
and explicitly labelled `"Stab(reduced part), companion free -- HIS convention"`, with `closed_under`
and the stage fingerprint beside it:

| audit | his convention | raw | group order | rival (companion fixed) would give |
|---|---|---|---|---|
| S166 (the fit) | **8** | 48 | 6 | 48 |
| L451 | **282** | 3,264 | 12 | 3,264 |
| M6B403 | **66** | 360 | 6 | 360 |

So the convention is confirmed, twice, against the companion-fixed rival. My "exactly one row" was
false and the card was too strong. `parts_audit.py` is better built than I credited: it reports the
level under several named groups rather than one, which is the structure I was about to recommend.

**What survives, and it is narrower and sharper.** Of the two confirmations, **one is the SPENT M6B 375
row**. And at L451 the *remaining* rival is not the companion-fixed count but the **whole order-24
group**, which §S.2 #1 records as also giving **282** — so that row cannot separate them either.
Therefore:

> **The live ambiguity — `Aut(A)` against the full base group — has been separated on no row that has
> ever been run.** Every agreement so far is an agreement against a rival that was never the live one.

**The ask, at its correct size.** The group *orders* are computable before any solver (stabilisers of
his published `A` and `C`; the handoff §7 already records both loop parameters as solver-free). For each
of the six reduction rows, register before the run: the order of `Aut(A)`, of `Aut(A) ∩ Aut(C)`, and of
the full base group; **whether `Aut(A)` and the full group are distinct on that row**; and which number
his printed value is predicted to match. A row where they coincide cannot test the convention and its
prediction should say so in one clause. A row where they differ is the first row in this milestone that
can, and it should run first. Cost: seconds per row, no solver.

**And the reason it still matters even now that the fit has support.** If a held-out row disagrees,
"different group on this row" remains available as a post-hoc escape, and it is more available than
before, because the artifacts genuinely do carry several counts. Naming the predicted group per row
before the run is what forecloses it.

**Card 13b — the reduction record does not hold the number that gets compared.** Every reduction
record's `M_set.up_to` is an as-found label, not a group: `m63-S166-reduction.json` reads
`{"n": 48, "up_to": "as found (the companion fixed); canonical counts are the audit's"}` while the
number reported against his table is **8**, from `m63-audit-S166.json`. That is honest labelling and
the audit ties itself back by `stage_fingerprint` — but it means **a `Comparison` row's `ours` value
for `|{M}|` is sourced from a different artifact than the reduction**, and at S M6A the two differ by
6×. E's per-row registration should name the artifact and the group its predicted number will be read
from, so the row cannot later quote the raw count where the canonical was meant.

**Card 14 — two more rows whose answers are partly on disk.** Neither is a leak; both are priors that
should be declared so a hit is not read as blind.

| row | what is already known | the honest label |
|---|---|---|
| L M6B 374 at rung 2 — predicted 78 | phase D already reduced a 374-at-rung-2 problem (`A412` vs `S136`) and got **78**, with `A` = 402 and the two 78-member levels *incomparable* (§S.3 G-5, §R3.13) | the count 78 is transferred from a sibling subtype, not predicted cold |
| rung-1 374's `|{M}|` — assigned to E by G-1 | a run is **enumerating right now**, past 17,360 minima (`data/m62/ckpt/m63-D1b.ckpt.json`) | this is an *unfinished phase D row*, not a held-out problem; it should not sit in E's held-out table at all |

**Card 15 — is any S number still held out?** §S.4 demotes the 138-vertex S run to "mechanism control,
not the held-out run", on the ground that "the S reduction was spent as this milestone's calibration
(§R1), so no S number is held out any longer". The acceptance list then still names **S M6B
(`v172e804`) and S M6C (`v167e772`)** as held-out reduction rows. Those two things cannot both be read
plainly. My reading, offered to be corrected: the *code path* was calibrated on the S side and the
*convention* was fitted there (card 13), so S M6B and S M6C test generalization **across subtype** and
not **across apparatus**. That is still worth running and is still evidence — but it is a weaker claim
than the table's framing, and the difference should be one sentence in the plan rather than left for a
reader to infer.

### Group B — the control that is about to stop working, and its residue (the principal's #2)

**Card 5 — it is not about to stop working; on the path E will use, it is already off.**

`check_invariants` (`tools/parts_loop.py:453`) has four checks. The fourth — the known-answer anchor,
two asks — runs only when an anchor is supplied. Three call sites:

| caller | anchor | address |
|---|---|---|
| `run_map` (the 89-candidate A412 sweep) | supplied | `parts_loop.py:711`, `:769` |
| `run_loop` — **the loop E's required row runs** | **`None`, hard-coded** | `parts_rule.py:387` |
| `hismove` — **tonight's calibration gate** | **`None`, hard-coded** | `parts_diag.py:196` |

And the silence: with `anchor=None` the function returns `verdict: "restriction-identity-holds"` and
simply omits the `anchor` key. There is no `"anchor": "not-supplied"` row, no warning, no field a reader
can grep for. **An entry that checked the anchor and an entry that could not are distinguishable only by
the absence of a key** — the exact shape `CLAUDE.md` names as the milestone's signature failure ("every
check needs a positive signal for the thing that did not happen"). The fix is three lines and belongs in
E, because E is where it will matter.

This does not retract the calibration. `hismove` *is* a known-answer test — his move must reduce 375→374,
and it did — so the anchor was redundant there. But it does mean the sentence "every reduction we run is
guarded by the anchor" is not true today, and the plan should not repeat it.

**Card 6 — the residue. What the anchor does not catch, even when green.**

This is the part I was asked to press hardest on, so I will state it as a claim that can be wrong rather
than as a caution. The anchor makes two asks — the known minimum still refuses; the known minimum minus
one atom is colourable — plus a containment test in `sweep_candidate` (the `stray` check, lines 538–546).
Six blind spots, each with the cheapest thing that would catch it:

| # | what the anchor cannot see | why | cheapest catch |
|---|---|---|---|
| a | **excess material** — a stage that is too big: wrong radius, a duplicated orbit, a cross law emitting edges that should not exist | `refuses(anchor)` is monotone in edges and vertices; adding anything keeps it UNSAT | the restriction identity (check 2), already there — and a registered `Stage.fingerprint()` / `fp_base` per row, which E's registration can carry at no cost |
| b | **every deletion but one** — `anchor[:-1]` drops the single highest-indexed atom | one ask, one atom | the phase-1 criticality census (all single deletions), which exists and was run once on the record: 508 critical / 0 droppable (§S.3 B-10). It is the strong form of this check |
| c | **the whole counting layer** — `up_to`, the rung group, `max_minima` truncation, level completeness | the anchor asks about one selection; `\|{M}\|` and `A` are properties of a level | `LevelSet.require_complete`, plus the Burnside cross-check that S.2 #1 already did by hand: raw count, orbit count, and the group order must close arithmetically |
| d | **the companion's identity** — check 1 pins that the companion's fingerprint is CONSTANT across a sweep, never that it is the RIGHT companion | a run against the wrong published half is internally perfectly consistent — this is literally the phase D finding (376/96/`A451` against 376/82/`A433`) | a companion fingerprint registered per row, in the prediction, before the run |
| e | **right graph, wrong question** — target and rung | echoed into the record but compared against nothing | the per-row registration, mechanically diffed against the record afterwards |
| f | **a fault in code shared by both sides of check 2** | `check_invariants` compares the stage against a `reference` built by `build_reference` from the same base, the same unit-edge predicate and the same cross law. A bug in any of those corrupts both sides identically and the restriction identity still holds | see below — this is the important one |

**The unifying statement, which is the residue in one sentence.** Checks 1, 2 and 3 are *internal
consistency*: they compare the pipeline against itself. Check 4 is the **only check that compares
against a truth from outside the pipeline** — a vertex list Parts published. So:

> **On ground truth, the apparatus has exactly one external check, and on a new base it has none.
> What survives is internal consistency, which by construction cannot detect a fault in shared code.**

**And the constructive half, offered as a construction and not a finding.** There *is* a second external
check available, and it does not need a known minimum: **exact-arithmetic geometry verification** —
every edge's length re-derived over ℚ(√3,√5,√11) from the stated rotation law, independent of the graph
builder. It already exists (`tools/parts_edge_verify.py`; the handoff §4 records it run on all 2,279
edges of the edge object with cross edges re-derived from the *stated* law). My guess, spitballing: that
verifier is the anchor's replacement on new ground, and **phase E is the only place it can be
calibrated** — run it on a row where the anchor also fires, and check that they agree, and check that a
planted geometric fault trips the verifier and not merely the anchor. If that calibration is not done in
E it cannot be done later, because later there is no anchor to agree with.

**Card 7 — where to plant the fault, so the plant tests the anchor and not check 2.**
A plant that breaks the restriction identity proves check 2. To exercise the anchor *specifically*, the
plant must be invisible to checks 1–3, which means it must be in the code the reference and the stage
share. Three candidates, cheapest first:

1. **Perturb one lattice point off the unit circle** in the base — the reference is rebuilt from the same
   base, so checks 1–3 agree with each other and the anchor's known minimum stops refusing. This is the
   plant that shows the anchor is the external check.
2. **Swap the companion for a different published half of the same size** — checks 1–3 pass (the
   fingerprint is *constant*, just wrong); the anchor should notice if the anchor's refusal depends on
   the companion. Prediction worth registering: I expect this one **not** to fire on every anchor, because
   a minimum of the L side may still refuse against a different S half in some frames. If it does not
   fire, that is residue entry (d) demonstrated rather than argued, and it is worth more than a plant
   that fires.
3. **Truncate the level** (`max_minima`) and check that nothing downstream reads the truncated count as a
   count — `Count` is built to refuse this (`truncated-*` must name its population), so this plant tests
   whether the *plan's* reporting path honours the type.

**Card 20 — phase F already named the anchor problem, and its two replacements are both internal.**
`plans/M63-phaseF-beat-509.md` §2.6 gets there first and says it plainly:

> *"**Not transferring, and this is a fail-open risk worth naming:** `contains-a-known-minimum` — the
> anchor control that fired free on all 89 map entries — **has no known minimum on a new base**, so it
> silently degrades to checking nothing."*

Three things E should take from that, each of which changes what E owes:

1. **F's count is right for `run_map` and does not know about the other two call sites.** "Fired free on
   all 89 map entries" is true. It is also the complete list: `run_loop` and `hismove` pass `None`
   (card 5). F's risk is present tense, not future tense, and E is where that is discovered.
2. **F's two proposed replacements are both internal consistency checks.** They are (i) a non-vacuity
   ask — the arena as a whole refuses four colours — and (ii) an end-of-run criticality check, every
   single-vertex deletion colourable. Both are excellent and both use *the same CNF builder and the same
   geometry as the thing they are checking*. Neither touches residue (f): a fault in code shared by the
   stage and its reference corrupts the arena's refusal and the criticality census identically. So §2.6's
   replacement list restores coverage of (b) — every deletion, and in the strong form — and restores
   nothing of the external-truth property that made the anchor valuable.
3. **§2.6 lists "exact geometry on every edge" among the controls that TRANSFER, and that line is
   ambiguous in a way that decides whether the list is honest.** The stage's geometry is *built* by
   `typem.unit_edges_fast` plus `CrossLaw.edges` in exact arithmetic. **A builder being exact is not a
   check.** The check is an independent re-derivation from the *stated* law, and the only implementation
   of that in this repository is `parts_edge_verify.py` leg 4 — which exists precisely because its author
   saw the circularity ("rather than by calling the committed edge builder, which would be circular") and
   which is welded into an object-level verifier for the 509.

So the two plans meet here, and the seam is E's to close: **lifting `parts_edge_verify` leg 4 to a
stage-level check is what makes phase F §2.6's own transferring-controls claim true**, and phase E is the
only place it can be calibrated, because calibration means running it where the anchor also fires. Worth
relaying to whoever holds the phase F plan; I am not editing it.

### Group C — comparisons that are not comparisons (the principal's #3)

**Card 11 — the companion rule lives in prose, and the type cannot hold it.**
S.1 2(a) is binding: *"`|{M}|` and `A` are comparable only once that row's companion is identified."*
`Comparison` (`tools/parts_report.py:135`) has fields `what, ours, his, attestation, mode, gated,
freeze_commit`. **There is no companion field, and `ours`/`his` are bare `int | None`** — so a
`|{M}|` comparison silently drops the `SetSize`/`Count` structure that `parts_report`'s own module
docstring says a bare integer must never lose. `relation` returns `no-comparison` when a side is None,
but there is nowhere to put *why*, and §S.4 asks for `not-compared` **with that reason**.

This repository's own standard is the answer: push the invariant into the type. **Suggested,
hypothetically:** a `Comparison` whose `what` names `|{M}|` or `A` requires a `companion` (a fingerprint
or `"unidentified"`), and refuses to construct without it; and `no-comparison` carries a reason string.
Then a row that compares an accumulator without naming the companion is not a discipline failure — it is
a `ValueError`. Cost: an hour, and it retires the rule from prose permanently.

**Card 9 — the 8/3 row's three attested targets are not three independent facts.**
§S.4: *"Three attested targets: `|M| = 367`, 27 minima up to the named group, and `A = v375e1862`."*
Two observations:

- **`A = ⋃{M}`** — it is the union of the level, not an independent measurement. Once the 27 minima are
  right, the 375 follows. It is a strong *check* on the level (a union that misses is a level that is
  wrong) but it is not a second attestation.
- **`|M| = 367` is free.** The row starts *from* his published 367-vertex **minimum** `v367e1822`. A stage
  whose vertex set is exactly a minimum has no deletable vertex, so `w*` returns at iteration zero with
  `|M| = 367`, before the rule proposes anything. The headline number of the row is attained by doing
  nothing.

So the row has **one** genuinely at-risk quantity: *the level at that weight has 27 members up to the
named group, and their union is his 375*. That is still exactly the right row to run — it is the only
one whose companion is an **edge**, hence constant, hence the one row where `|{M}|` and `A` are
comparable without reconstructing a moving companion (card 10). But "three attested targets" oversells
it, and the plan should say what the row risks.

**Card 10 — which E rows can compare `|{M}|` and `A` at all.** My reading, to be corrected:

| row | companion | does it move? | so `\|{M}\|` / `A` are |
|---|---|---|---|
| 8/3 mono-pair (367, 27, `v375e1862`) | an **edge** | no — there is no second half to alternate with | **comparable**; this is the row's whole value |
| √3 triple (221, 120, `v238e1131`) | a five-vertex pin | no, same reason | comparable, if the pin is reconstructible |
| L M6B 374 rung 2 (78, `v406e2076`) | an S half, at some state of his loop | **yes** | comparable only once that state is identified — otherwise `|M|` alone |
| L M6C 374 (76, `v400e2034`) | an S half | **yes** | same |
| S M6B (141, 4, `v172e804`) | an L half | **yes** | same |
| S M6C (150, 28, `v167e772`) | an L half | **yes** | same |

If that reading is right, it is a useful thing for the plan to state up front: **the two gadget-companion
rows are the ones that can be compared on all three quantities, and the four half-companion rows may
collapse to `|M|`-only unless the companion is reconstructed first.** Reconstructing it is the phase D
method and it costs no solver — a refusal test over the 24 orientations (handoff §7). Whether it is
*determinable* for these four rows is the open question, and it should be answered before the rows are
scheduled, not after they return a number that cannot be compared.

**Card 18 — the required held-out loop row cannot test the clause it was put there to discharge.**
*Sharper form of card 9, and after cards 5/6 the most consequential thing in this record.*

§S.1 #3, the requirement: *"Reducing his published `A` to his `M` tests only reduction, so at least one
held-out run must start **below** his accumulator and **reach his `|M|`** with the frozen loop."*

§S.4, the row put there to discharge it: *"start from his published 367-vertex minimum `v367e1822` and
let the frozen loop run … `|M| = 367`, 27 minima …, `A = v375e1862`."*

`v367e1822` **is his `M`**. §3 records the mono-pair row as `A375 → M367`. A stage whose vertex set is
exactly a minimum has no deletable atom — and this holds at every rung, since deleting an orbit deletes
a superset of some vertex and `G − v` colourable gives `G − O` colourable. So `w*` returns at iteration
zero and `|M| = 367` is on the record before the rule has proposed anything.

Two consequences:

1. **The row satisfies the letter of S.1 #3 and not its work.** "Start below his accumulator" holds
   (367 < 375). "Reach his `|M|`" holds vacuously.
2. **Under the frozen config the row can never report `improved`.** 367 is the true minimum, so the
   loop's only reachable verdicts are `grew`, `stalled` and `budget-spent`. Its only possible positive
   signal is clause **2(c)** — `{M}` grows at fixed `|M|` and fixed rung with vertices added — which is
   a different clause from the one S.1 #3 names. (And `run_loop`'s `clause_2b` string is hard-coded to
   *"reached |M| <= 374 from our 375-level accumulator"*, which on this row would be false text under a
   green `require_frozen` — card 3 again, now with a consequence rather than only an inelegance.)

The row is **not** empty: reaching 27 minima and `A = 375` requires the rule to expand correctly, and it
is still the only row whose companion is an edge. But the clause it is listed against is not the clause
it can discharge.

question: does-the-required-loop-row-test-clause-2b
  evidence: §S.4's required loop row starts from `v367e1822`, which §3 records as his `M` for the
    `A375 → M367` mono-pair row; a stage on a minimum has no deletable atom at any rung, so `|M| = 367`
    returns at iteration zero, and `improved` is unreachable because 367 is the true minimum
  expected: a held-out run that starts below his accumulator and does work to reach his `|M|`
  ask: which clause does this row discharge — 2(b), which S.1 #3 requires, or 2(c)?
  if 2(c): the plan says so plainly, S.1 #3 is discharged by a different row or reported NOT MET, and
    "reported as not run is not an ending" applies to the clause rather than to the row
  if it must be 2(b): the starting state changes to one whose minimum is strictly above 367 — a proper
    subset of his `A375` that still refuses, so the loop must expand to get back to 367; that is
    genuinely held out, starts below his accumulator, and makes the loop do the work
  answered by: the engineer, then the product owner — this is a scope question, not a measurement
  cost: one decision; the alternative starting state costs one refusal ask per candidate subset
  hunch: it is a 2(c) row as written, and the fix is one line of scope rather than a new row
  falsifier: a reading of S.1 #3 on which reaching `|M|` at iteration zero is the test it asked for
  rank: 3

### Group D — no aggregate verdict (the principal's #4)

**Card 16 — this one is in better shape than the others, and has one hole.** `parts_report`'s module
docstring is explicit: *"No aggregate verdict, and in particular no `reproduced` field … Rows say
`agrees` or `differs`, and nothing sums them."* The type has no boolean that adds up. Good.

The hole is not in the instrument, it is in the prose that will be written around it: with seven rows and
a `relation` field taking three values, a summary sentence of the form "six of seven agree" is one
sentence away and is an aggregate verdict wearing a count. **The one wording I would ban in advance:**
any sentence containing a fraction of rows. §S.4 already requires "a written human judgement over the
frozen rows, and no aggregate verdict" — I would add that the judgement names **each disagreeing row by
name and what it would take to resolve it**, so a disagreement cannot be discharged by the count of its
neighbours.

### Group E — the two facts from tonight

**Card 12 — the calibration overlaps none of E's rows, and the plan should say so before someone argues
it does.** The principal asked, genuinely openly, whether one E row has become redundant. My answer is
no, and the argument is specific rather than defensive:

`hismove` calls `PL.sweep_candidate` **directly** (`parts_diag.py:195`). It therefore validates: one
candidate evaluation, `Stage` on the §5.6 lattice with an S-half companion, `reduce_stage`, and the
target/`require_any` machinery. It does **not** touch:

- `run_loop` — the loop driver, its ranking, its escalation schedule, its stall logic, its checkpoint.
  E's required row runs all of it;
- **any of the three new companion constructors.** §S.3 B-2 (mono-pair edge), B-3 (non-mono-set clique)
  and B-7 (five-vertex √3 pin) are all *"not done"*. That is unwritten code, and unwritten code is not
  validated by a run of different code;
- the counting layer at a rung other than 1 on a new problem.

So the calibration's reach is real and large — it converts every inertness result on the large half into
a fact about expansion — and it is orthogonal to E. **The redundancy argument should be recorded with
its answer**, because "the calibration passed, so E can be trimmed" is a sentence that will be available
later to anyone under schedule pressure, and the time to refute it is before it is needed.

**Card 8 — the required loop row will score his ordering, not ours, and this is checkable in minutes.**

`_rank_ours` sorts by `(-freed_per_vertex, his_rank)` (`tools/parts_rule.py`, the `_rank_ours` body).
`his_rank` is the census rank — his own decreasing-admission-degree order. §S.3 B-12 measured the
proxy: **`look_ahead.freed` read 0 of 336 necessary atoms on every single orbit tried, including an
orbit his own recorded move used.**

If the proxy is flat on the mono-pair's menu too, then `freed_per_vertex` is 0 for every candidate, the
first sort key is constant, and **`rule="ours"` and `rule="his_degree"` produce the identical ordering**
— both are in the frozen `RULES` table by name. The row would then score *his published device*, and a
null would be reported as "our rule failed" when the honest reading is "our rule was never in the room".

The freeze anticipated exactly this and wrote the escape in advance, which is to its credit:
*"if the held-out map is signal-free … the rule is scored by outcome on ONE held-out row — one bit — and
no map stands behind it."* My ask is narrower and earlier:

question: is-the-ranking-signal-alive-on-the-held-out-row
  evidence: `_rank_ours` sorts by (-freed_per_vertex, his_rank); §S.3 B-12 measured
    `look_ahead.freed` = 0 on every orbit tried at A403, his own move's orbits included
  expected: a ranking with a live first key
  ask: on the 8/3 mono-pair's candidate menu, is `look_ahead.freed` non-zero for any candidate?
  if yes: the rule has content on this row; run it as planned and the one bit means what it says
  if no: `ours` == `his_degree` on this row by construction, and the plan must say BEFORE the run
    that the row scores his ordering; the free control is to run `--rule his_degree` and confirm the
    outcome is identical, which converts a null from "our rule failed" into a derivation
  answered by: run — `look_ahead` over the menu at `wall_ask=60`, tens of asks, no level enumeration
  cost: minutes, and it is the cheapest thing in phase E
  hunch: flat, on the B-12 pattern
  falsifier: one candidate with non-zero freed
  rank: 2

**Card 4 — the frozen loop E promises to run does not exist yet, and when it does it will be outside the
hash.** `run_loop` hard-codes its problem:

- lines 321–323: `Stage(base, v451e2400, v136e564, side="L", rung=1, pin=True)`, and line 324 **refuses
  to start** unless the starting record's fingerprint matches that rebuild;
- line 522: `base = P.Base(P.PARTS_R)`;
- line 330: the companion is loaded from `REF11` by filename.

E's required row starts from `v367e1822` with an **edge** companion. `Stage.__init__` takes `L_tuples,
S_tuples` on the §5.6 lattice and applies `cross_law.edges` between the halves — it cannot express an
edge companion at all, which is why B-2 is "not done". So the row needs (i) a new companion constructor
and (ii) a `run_loop` parameterised by its starting stage. Both are new code, both sit outside the
hashed config, and `require_frozen` will return green across the change.

That is not an accusation of bad faith — it is a structural fact about where the freeze's boundary is,
and it is the same boundary as card 1. **The honest instrument is a second registration** naming, per
row: the starting object, the companion constructor and its fingerprint, the stage fingerprint, the
rung, the counting group, the wall, the level cap, and the predicted values — committed before the run.
Then "frozen" means something for all seven rows instead of one.

**Card 19 — four of the seven pre-registered rankings were never implemented, and one of them is his
own published device.** `data/m62/m63-sweep-protocol.json` is a hand-written pre-registration frozen
before phase D's first outcome was read, and it is the right shape for E's per-row predictions — outcome
variables, a *banned_as_an_outcome* clause, the rankings to be scored, the scoring rule. **E should copy
its shape rather than invent one.** But it names seven rankings and `parts_rule.RULES` holds three
(`ours`, `his_degree`, `random`). Unimplemented: `his_indicators` (his §5.10's three numerical
indicators, *"reported SEPARATELY and never combined, because he states no combining rule and an
invented one would be ours wearing his name"*), `his_priority`, `n_new_asc`, `n_new_desc`.

§S.4 already records the consequence — *"phase D never implemented the indicators … so his device is
still untested and P-D1 is unscored"* — and it matters more now than it did then, because of card 8. If
`ours` degenerates to `his_degree` on the held-out row, then the one bit E buys scores **his
decreasing-admission-degree order** and nothing else, while the one published device that might have
had power (`his_indicators`) has still never been run. The fork §S.4 states — *"if they do not [rank
top], then no published device predicts his own recorded move"* — is therefore still open, and E's
write-up should not imply otherwise.

### Group F — cost (the principal's #6)

**Card 17 — E's compute estimate is probably wrong by about 5×, and the fix is one column.**
Tonight's measurement: the calibration found its optimum in **188 s** and then spent **79 minutes and
counting** enumerating the level — at 11,700 minima and climbing. Two orders of magnitude.

Now read E's rows against that:

| quantity a row needs | what it costs | which E rows need it |
|---|---|---|
| `\|M\|` only | the optimum — minutes | none of them, alone |
| `\|{M}\|` and `A` | the **complete level** — hours | **all six reduction rows, and the loop row** (card 9: the level *is* the row) |

§S.4 prices E at *"3–4 engineer-days; compute several hours in light jobs"*. Six-to-seven complete level
enumerations at this scale, under the one-heavy-job-at-a-time rule, is not several hours in light jobs.
**Suggested:** every row in the plan's cost table carries a column saying **optimum or level**, and the
schedule is built from the level rows. Two consequences fall out for free:

- the rows are orderable — the cheap `|M|`-only checks can all run first and surface an apparatus fault
  before a day of enumeration is spent;
- **`max_minima` becomes a decision that must be made in advance, per row.** A capped level yields a
  `Count` with method `truncated-at-budget`, which is a **floor**, and a floor against his 27 or his 120
  can only ever say "≥". The plan should decide, before the run, whether a truncated level is an
  acceptable answer for each row — because deciding afterwards, when the run has been going for six
  hours, is deciding with the cost in the room.

---

## §4 — What I would put first, if asked

Not a ruling; the engineer plans. In the order I would spend the first day:

1. **Card 13's pre-run group computation** — three group orders per row, no solver, seconds each. It is
   the only thing that can tell you *in advance* whether your `|{M}|` rows test the fitted convention or
   merely restate it, and it forecloses the one post-hoc escape that is otherwise available.
2. **Card 8's proxy check** — minutes, and it decides what the one required loop row is actually scoring.
3. **Card 5's three-line fix** — make "anchor not supplied" a printed verdict rather than a missing key,
   then card 6's residue written down, then card 7's plant. In that order: the residue statement is what
   travels to phase G; the plant only demonstrates it.
4. Then the rows, cheapest-quantity-first (card 17).

## §5 — Where I expect to be wrong

Stated so it can be scored later.

- **Card 9's "`|M| = 367` is free"** rests on the stage built from a minimum having no deletable vertex.
  If the mono-pair stage's fixed/atom structure differs from the type-M one — a pin, a fixed pair — the
  arithmetic could shift by one or two. The shape of the point survives; the exact claim might not.
- **Card 10's companion table** is my reading of which companions move. I have not verified that the
  √3-triple pin is constant across his loop, only that it has no second half to alternate with.
- **Card 13** is the strongest claim here and the one I would most like contradicted. If a second row
  has already discriminated the three groups and his number picked `Aut(A)` again, the fit is confirmed
  and the card collapses to a labelling note. I looked and did not find one; I may have missed it.


---

## §6 — If the product owner asks: three things that need a ruling, and the rest is the engineer's

*In the house report format. Nothing here is settled by me.*

| rank | the decision | my recommendation | the alternative I weighed | why this one | confidence |
|---|---|---|---|---|---|
| **must decide before E runs** | **Does the required held-out loop row discharge clause 2(b), or 2(c)?** (card 18) Starting from `v367e1822`, which *is* his `M`, `|M| = 367` returns at iteration zero and `improved` is unreachable | Keep the row, reclassify it as the 2(c)/reduction row it is, and add a starting state strictly above 367 (a proper subset of his `A375` that still refuses) as the 2(b) row | Keep it as the 2(b) row and note the caveat in prose — buys a day, leaves S.1 #3 discharged by a vacuous reading | E's product is a warranty, and a warranty with a vacuous clause is worth less than one with an honestly unmet clause | **high** on the mathematics; **medium** on the scope call — if S.1 #3 is read as satisfied by the whole Table 5 row rather than by its `\|M\|` clause, I am wrong about what it wanted, and that reading is the product owner's |
| **must decide before E runs** | **What registers the six reduction rows?** (cards 1–4) `6158162` freezes the expansion rule; no reduction path calls `require_frozen`, and `--require-frozen` is opt-in | A second, per-row registration committed before any run — starting object, companion constructor and fingerprint, stage fingerprint, rung, counting group, artifact the number will be read from, wall, level cap, predicted values — on the shape of `m63-sweep-protocol.json` | Declare the current freeze sufficient and rely on discipline | Six of seven rows are otherwise unregistered, and the phrase "judged under the frozen configuration" would be true of one row | **high** |
| **decide when convenient** | **Does E ship the stage-level geometry check?** (cards 6, 20) It is the only external check that survives to a base with no known minimum, and E is the last place it can be calibrated | Ship it: lift `parts_edge_verify` leg 4 to stage level, calibrate it where the anchor also fires, plant one off-circle lattice point | Leave it to phase G, which is where it is needed | In G there is no anchor to calibrate against, so it would ship uncalibrated — and an uncalibrated check that only ever says pass is this project's named failure | **medium-high** — if the lift is more than a day, the trade changes |

**Already settled by me, needing nothing:** card 13 was overstated and is corrected in place (the counting
convention has two independent confirmations, not zero; what survives is that the *live* rival — `Aut(A)`
against the full base group — has been separated on no row ever run).


---

## §7 — Read against the draft, 2026-09-11

The plan landed at 1,083 lines with a §P scoring the cards, thirteen four-part decisions in §6, and six
things it could not settle in §7. Cards 1-20 are adopted or refused with a reason; none was absorbed in
silence. It corrected me once, with evidence, and that correction is right (below). Two joints are still
soft, and one of them is the kind this identity exists to catch.

**Where it corrected me, and it is right.** Residue entry (d), the companion's identity: I claimed the
anchor is blind to a wrong companion. It is not — §S.2 #7 measured `v375e1916` refusing with `S141` in
12 of 24 frames and with `S136` in **none**, so a wrong companion can kill the anchor's refusal. My claim
holds only for the fingerprint check taken alone. The plan kept my registered prediction for the plant
anyway (P-E19, 0.55) because a *frame-compatible* wrong companion may still pass, which is the half of
the claim that survives.

**Card 21 — P-E18's attribution clause is unavailable if P-E20 resolves as predicted, and the cause
this milestone has actually observed is not on the list.**
This is the one I would not let through. Two registered predictions are logically coupled and the plan
does not say so:

- **P-E20** (0.6): on all six reduction rows `Aut(A)` and the whole base group **coincide**, so no row
  separates the live ambiguity.
- **P-E18** (0.5): at least one `|{M}|` disagrees while its `|M|` agrees — *"the convention, not the
  reduction"*.

If P-E20 is true, the `Aut(A)`-against-full-group ambiguity cannot produce any discrepancy, and the only
convention ambiguity left is `Aut(A)` against companion-fixed — confirmed three times, and wrong by a
factor of **5.5× to 11.6×** on the rows measured, not by a near miss. So **under P-E20, P-E18's stated
attribution is not available**, and a disagreement would have to be attributed to something the plan has
not named. That is precisely the inductive escape clause: a branch that is itself a guess, inconsistent
with what is already held.

**And the cause this milestone has repeatedly measured is missing from the list: his printed numbers.**
`§S.3 A-7` — *"each `A` file sums EXACTLY to its own caption … both discrepancies live in his printed
per-row columns and not in his data"*, with Table 3's file at 412 against a column summing to 402.
`§S.3 G-2` — *"his printed 375 column is strictly narrower than BOTH the M6A and the M6B level in the
same two cells — so the column is a property of neither run."* Three of four `A` columns do not check.

So a `|{M}|` disagreement has **at least three live attributions**, and only one is on the plan's list:

| attribution | what distinguishes it, decidable after the fact |
|---|---|
| the counting convention | the disagreement is a clean multiple in the 5.5–11.6× band, and the audit's other group keys hold his number |
| an incomplete level | `Count.method` is not `exhaustive-level`, or `max_minima` bound |
| **his printed number** | our level is closed under the declared group, the audit's three keys all miss his value, and `A = ⋃{M}` still equals his published accumulator file literally — the pattern A-7 already found twice |

The third is the one with precedent in this milestone, and it is the one that will look least attractive
to reach for, which is exactly why it should be registered now. **Suggested: P-E18 is split into its
three attributions, each with its discriminator, written before the run.**

**Card 22 — the cost disagreement: the plan's conclusion is right and its formula is on the wrong
quantity.** §4 rebuts my card 17 with numbers and wins: *"`S166` closed a complete level with 8 minima
in 587 s and `L451` one with 282 minima in 605 s … Phase E's rows carry 4, 27, 28, 76, 78 and 120
minima."* I concede the conclusion — 10-40 minutes per level is the right forecast and my ~5× was wrong.

But **8, 282, 4, 27, 120 are canonical counts, and the enumeration walks the RAW level.** The measured
ratios: `S166` 48 raw to 8 canonical (6×); `L451` 3,264 to 282 (11.6×); `M6B403` 360 to 66 (5.5×). So
`L451` enumerated **3,264** minima in 605 s, not 282 — which is why the forecast holds, and holds with
more room than the plan claims. Applied properly, E7 at 120 canonical is roughly **660-1,400 raw**, still
inside the `L451` envelope.

The conclusion survives; the formula does not, and a formula stated on the canonical count is off by
5-12× the moment phase G inherits it for a base whose group order differs. **One clause fixes it: the
level stage is priced on the raw level size, which is the canonical count times the declared group's
order divided by the average stabiliser — and E-pre.1 computes exactly the group needed to estimate it,
before any row runs.**

**Card 23 — a bound cap makes a row `|M|`-only, not a `≥` comparison.** P-E23 (0.3) says a bound
`max_minima` makes `|{M}|` *"reported as a floor (`≥`) and not as a value"*. A floor is not a comparison:
`≥ 27` against his 27 renders as satisfied and is not agreement. `Count` already refuses to hide this
(`truncated-at-budget` must name its population), so the fix is in the reporting rule, not the type:
**a row whose cap binds reports `|{M}|` as `not-compared`, with "the cap bound at N" as the reason** —
the same treatment the plan already gives an unidentified companion.

**What I am not pressing on, having read it.** §6 decisions 4, 9, 10 and 11 (the named `anchor-not-supplied`
verdict, the per-row registration, lifting leg 4, the `his_degree` control arm) are the four that carry the
phase, and each is argued from a reading of the code rather than a preference. Decision 12 is correctly
escalated rather than settled. §7's six open items are honest, and item 3 — that a stall at
`max_iterations = 6` is unanswerable without breaking the freeze, and a continuation run must be labelled
and reported separately — is the right call and the one most likely to be eroded later.


---

## §8 — The three soft parts the engineer asked me to press, answered

*It committed the plan at `2608d17`, scored all twenty cards in its §P, corrected me three times, and asked
for a targeted reading of three places rather than a sweep. Taking them in its order.*

### (a) Is E3b's construction reachable? — decidable by ONE run, and the run also builds the state

The question: does a set exist that hits all 27 minima of `A375` whose complement still refuses?

**State it as a constraint and it stops being a search.** `W ⊆ A375` refuses and contains no minimum
`M_i` exactly when `W` omits at least one atom of each `M_i` — that is the clause
`⋁_{a ∈ M_i} ¬select(a)`, one clause per minimum, **27 clauses** on the instance `reduce_stage` already
builds. So:

> Run the reduction of `A375` with those 27 clauses added. Either it returns **no refusing selection**,
> and then *every* refusing selection of `A375` contains one of the 27 minima — E3b is impossible inside
> his accumulator, and clause 3 is honestly NOT MET; or it returns a minimal `W` with `min(W) ≥ 368`,
> which **is** E3b's starting state, delivered with its own minimum already computed.

One run, two answers, neither wasted, and it is a **decision** rather than a level — the cheap kind, on
the plan's own split. It belongs beside E-pre.1 and E-pre.2 as **E-pre.3**, because it decides whether a
scheduled row exists before the phase commits to it, which is what the other two pre-runs are for.

Two structural remarks that sharpen it:

- **The deletions must avoid the forced atoms.** Phase C's partition — *"423 forced (present in every
  refusing selection, by downward closure) and 153 free"* — means deleting a forced atom makes the
  remainder colourable outright. So the hitting set lives entirely in the free atoms, and whether one
  exists there is exactly what the 27 clauses decide.
- **Why this is not obviously possible, which is why it is worth deciding rather than asserting.** The 27
  are the minimal refusing selections *at weight 366*. A `W` of the kind E3b wants must contain a
  minimal refusing selection of weight **≥ 367** — i.e. `A375`'s refusing family must have minimal
  elements at more than one weight. Nothing measured so far says it does. The engineer is right that
  "clause 3 reported NOT MET" is a bigger call than the plan made it; the good news is that it is now a
  **pre-run** call costing one decision, not a discovery made after a row has been scheduled.

### (b) R4's catcher is wrong for both directions of the fault, and f7's direction is inverted

Read at `tools/parts_reduce.py:544`:

```
if target is not None and state.w_star is None and wh > target:
    target_lb = wh; break      # NO refusing selection of weight <= target
```

`wh` is the MaxSAT optimum over the harvested hypergraph — a rigorous **lower** bound on `w*` — and the
break fires only *before* an optimum is found. Therefore:

- **Too-lax target** (larger, the plan's f7: `incumbent` for `incumbent − 1`): `w* ≤ incumbent ≤ target`,
  so the break never fires, the search runs to the true `w*`, and the verdict is **correct**. It costs
  time and nothing else. **f7's stated expectation — *"returns `inert` for a candidate that would have
  improved"* — has the direction wrong**; a too-lax target cannot produce a false `inert`.
- **Too-tight target** (smaller, `incumbent − 2`): the run answers *its own question* truthfully —
  `no-selection-at-target` — and the loop reads that as "did not improve". **This is the off-by-one that
  produces a false `inert`**, and it is at least as realistic as the one planted.

So R4's catcher fails on both sides. Idempotence cannot catch the lax case because there is no error to
catch, and it cannot catch the tight case because a target-refuted run has **no object to re-reduce** —
the docstring is explicit: *"A target-refuted run has NO level and therefore no `A` and no `|M|`."*

**Two catchers that do work, both already half-built:**

1. **The registration diff.** The record echoes `target`, `rung` and `side`; §6 decision 9's per-row
   registration states them. Mechanically diffing the two is R4's real catcher, and it is being built
   anyway for another reason — it only needs naming as R4's and running.
2. **A one-unit tripwire on the loop's negatives.** A `no-selection-at-target` record carries
   `target_lb`, the bound at which the break fired. **When `target_lb == target + 1` the candidate was
   refuted by exactly one unit** — precisely the population a too-tight target would misreport. Re-asking
   only those at `target + 1` is a cheap standing check on every `inert` the loop ever emits.

**Suggested plant swap:** replace f7 with `target = incumbent − 2`, whose expected answer is *"nothing
fires, and the loop reports `inert` for a candidate that improves"* — the claim f7 makes but cannot
demonstrate.

### (c) Sequencing E9.5 — the order is right; the exposure is not ordering

The plan already puts E9.5 at item 3b, before the registration commit at item 4. That is the right order
and I would not move it. Two refinements:

- **Its dependency is narrower than the schedule implies.** Calibration needs a stage where the anchor
  *also* fires, i.e. one containing a published minimum. E2's stage qualifies — `v367e1822 ⊆ A375` — so
  E9.5 depends on E1 plus one stage build, **not** on the row sequence. If E1 lands early, E9.5 can move
  up, and it should.
- **The exposure is that it is silently tradeable.** Half a day of engineering sitting in front of rows
  that are about to return interesting numbers is the item that gets deferred "just until after E3", and
  after phase E there is no anchor left to calibrate against. Ordering cannot prevent that; **visibility
  can.** Put *"the lifted geometry check ran and agreed with the anchor on a row where both fire"* into
  the acceptance list §X.1 drafts for §S.4, and into E10's written judgement. Then deferring it is a
  visible unmet acceptance item at the close rather than a quiet omission — which is the same discipline
  the phase applies to every other unmet clause.


---

## §9 — I retract my own catcher, and the retraction is the better finding

*Written 2026-09-11 after the plan was committed with it. The one-unit tripwire I proposed twice, and
which the product owner called the best item in its message, is **structurally degenerate**. It flags
every candidate and it cannot distinguish the fault it was built for. Measured on the committed artifact,
not argued.*

**The measurement.** `data/m62/m63-map-A412.json`, all 89 entries: `primary.verdict` is
`no-selection-at-target` **89 of 89**; `incumbent` is 373 on every entry; `asked_at_target` is 372 on
every entry; the lower bound parsed out of `primary.bound` is **373 on every entry**. So
`target_lb − target = 1` for **89 of 89**.

**The mechanism, which is why it is a tautology and not a coincidence.** For an expansion `W' = W ∪ D`,
every refusing selection of `W` survives in `W'`, so `w*(W') ≤ incumbent`. `wh` is a lower bound on
`w*(W')`, hence `wh ≤ incumbent`. The break fires at the first `wh > target = incumbent − 1`, i.e. at
`wh = incumbent` exactly. **Every inert candidate in an expansion sweep returns `target_lb = target + 1`,
by construction.** And a too-tight target (`incumbent − 2`) breaks at `wh = incumbent − 1`, which is
*also* `target + 1`. So the tripwire flags everything and separates nothing.

**What I got wrong, mechanically.** I read `target_lb == target + 1` off one entry and treated a
structural identity as a discriminating observation — a pattern seen once and promoted, which is the
failure this identity's own ledger rule exists to prevent, committed by the person who spent the evening
catching it in others. I registered no falsifier for it. Had I asked "what would a *non*-one margin look
like, and is it reachable here?", the answer would have come out in one line of algebra before the
proposal, not after.

**So R4's catcher is the registration diff alone** — the record's echoed `target`, `rung` and `side`
compared against the per-row registration — and that one does work, because it compares against a
committed intention rather than against a quantity the design pins. The tripwire should be struck from
the plan, or kept only with its scope stated: it is meaningful for a **targeted reduction whose target is
not derived from a surviving incumbent**, which is not the loop path and not phase D's map.

**And the finding that replaces it is worth more than the catcher was.** The loop's negatives carry **no
margin information at all, by construction**: every inert candidate returns the identical bound, so *"how
close was this candidate?"* is unanswerable from the 89-candidate map, and no re-reading of it can
recover a gradient. That makes **three independent instruments now reading flat on single-orbit
expansion** — the look-ahead proxy (0 freed on every orbit tried, §S.3 B-12), the shoulder-against-cut
comparison (*"neither vindicated nor convicted, and the comparison has no power"*, handoff §3), and now
the target bound, flat by design. Three flat instruments on one question is a structural fact about what
this measurement *can* return, not three coincidences — and it is the honest frame for phase D's map:
**one bit per candidate, and no gradient was ever available to extract.**

**One reporting defect found in passing.** `primary.bound` is stored as an English sentence — *"no
refusing selection of <= 372 over all selections (lower bound 373, rung 1, 0 undecided)"* — in 89 of 89
entries, although `Bound` is a structured dataclass with `lower`, `upper`, `rung`, `undecided` and
`target` as fields. Any later check over these records must parse prose with a regular expression, which
is how a field silently changes meaning between runs. If the map is ever regenerated, the structured
`Bound` should be stored beside the rendered string.


---

## §10 — The evening's methodological finding, stated for a stranger

*Added at the close. The two retractions tonight were the same error with opposite signs, and the pair
generalises further than either half. Written to be usable by someone who knows nothing about this
milestone.*

**A plant and a discriminator are the same object seen from two sides, and both owe the same question
before they are believed: what does the uninformative outcome look like, and can it happen?**

- The planted fault `f7` set a target too **lax**. A lax target cannot trip the break, so the control
  could not have fired — the plant would have been recorded as "survived every control" at 0.9
  confidence, and the survival would have been read as evidence about the guard when it was evidence
  about the plant.
- The one-unit tripwire asked whether `target_lb == target + 1`. The design forces that on every inert
  candidate, so the discriminator could not have discriminated — it would have been recorded as flagging
  a meaningful population when it flags all of them.

Both were about to produce a **confident record**, which is what makes them worse than an absent check:
an absent check leaves a reader with less than they thought, and a dead one leaves them with something
that looks like more.

**Why the project's existing rule did not catch either.** `CLAUDE.md` already requires that a check be
*seen to fail* before it is believed. `f7` would have passed that test — a fault was planted, a control
was run, an outcome was recorded. The missing step is one earlier than the rule reaches: **the plant
itself could not have made the control fire.** The rule needs its predecessor:

> Before believing a control's pass, or proposing a discriminator, state the uninformative outcome and
> confirm it is reachable. A control whose failure mode is unreachable has not been tested by passing,
> and a discriminator whose null is unreachable has not discriminated by firing.

**And the asymmetry that produced both misses, which is the transferable part.** Each of us applied the
question rigorously to the other's instrument and never to our own: the engineer wrote a seven-row table
asking exactly "what would this control fail to catch?" about somebody else's guard, and wrote a residue
catcher without asking it of that; I demanded a reachable failure of its plant and proposed a
discriminator without checking mine could discriminate. **The question is cheap and it is the one nobody
asks of the thing they just built** — which is the entire case for a second reader, and the reason the
second reader must be pointed at their own output too (`<turn_the_cut_on_yourself>`).

**The companion lesson, and it accounts for every finding tonight:** *prose about code is not code.*
Seven errors were found between two readers this evening — four of the engineer's, three of mine — and
**every one was found by opening a module rather than by arguing**: the freeze's coverage, the anchor's
call sites, the target break's direction, the ranking's sort key, the counting artifacts, the map's
margin, the bound stored as a sentence. None was subtle once the file was open. A plan's sentence about
what its code does is a hypothesis with the standing of any other.
