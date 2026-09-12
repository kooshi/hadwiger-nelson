# M63 phase D — the close audit: §S.3's D rows, and phase D against its own plan

*Written 2026-09-11 by the phase D close auditor, a fresh agent, from the committed record alone. Two
deliverables: **§A**, paste-ready replacement text for the phase D rows of the master plan's gap audit
(`plans/M63-parts-reproduction.md` §S.3), which this agent may not edit — the product owner is its writer;
and **§B–§E**, an audit of phase D against its own plan (`plans/M63-phaseD-the-loop.md`), every promise
marked done / not done / not decided with an evidence pointer, and every not-done item assigned to a later
phase or proposed for dropping.*

*No computation was launched for this file. Reading, grepping and one log tail only; no process was
signalled, killed or cleaned up.*

**Shorthand used in the `goes to` column, defined once.** **2(b) follow-on** = the fresh agent the product
owner scoped for acceptance clause 2(b) (`plans/M63-SESSION-HANDOFF-2026-09-11.md` §6.2). It is the
successor of phase D rather than a roadmap phase; in roadmap terms its work sits with F, and it is named
separately here so nobody reads "F" as "after E".

---

## §A — Replacement text for §S.3's phase D rows

*One physical line per row, matching the table's existing structure `| id | promise (address) | status |
evidence, or the argument | goes to |` and its `\|M\|` pipe escaping. Rows not listed here are untouched
by phase D. Two **new** rows are proposed at the end and need the product owner's approval before they
acquire stable ids.*

### A.1 — Rows to replace

| G-1 | `\|M\|` at 136 / 375 / 374 / 376 (§3 rank 1) | **done for all four** | 136 §R1; 375 M64 run, S.2 #1; **376 at the order-3 rung on `A451` against the companion his loop actually held there — the S accumulator `v166e774` — reproduces four-for-four: 376 vertices, 96 minima, `A` = his `v451e2400` literally, L-edges 1890–1947** (`data/m62/m63-D1a-A451-rung3-vs-A166.json`; §R3.4). Against `v136e564` the same reduction returns 376 with 82 minima and `A` = 433, kept deliberately as the object the companion finding is made of (`m63-D1a-A451-rung3.json`). **374 at rung 1 on `A412` against `v136e564`**: `w* = 373`, zero undecided asks; **374 at the rung-2 subgroup**: 374 at seven order-2 rungs. The rung-1 level is **still enumerating** (past 17,360 minima at 2.9 CPU h, checkpoint `data/m62/ckpt/m63-D1b.ckpt.json`) | the rung-1 374 level's `\|{M}\|` closes in E |
| G-2 | `{M}` ranges and the stable/unstable partition (§3 rank 2) | partly — **unchanged by phase D** | L375 ranges differ in two orbits, attributed to his column (S.2 #4). **The partition is not in his text**: "stable" means *the same non-empty vertex set in every minimum* (§6 of his paper) and is marked only by gray shading, and a single-valued range does not imply it — our `(2,0,2,4)` is 10 in every minimum with a varying vertex set. §3(c)'s "31 stable orbits" read the ranges and is therefore unproven. **C2/C3 settled the ranges and left the partition unattested** (§R2.4c): three complete levels audited, and his printed 375 column is strictly narrower than BOTH the M6A and the M6B level in the same two cells — so the column is a property of neither run. Every orbit row now carries a status measured on our own level (`stable` / `unstable-constant-count` / `unstable-varying-count`), which is the honest form of the partition; his gray-shading marker is not extracted. **Phase D extracted no shading and computed no orbit statuses on a 374 or 376 level**, so the row stands exactly where C3 left it | E, or a scoped shading extraction |
| G-3 | edge counts decomposed (§3 rank 3) | **done for four rows, and the fifth disagrees for a reason registered in advance** | audited as `Comparison` rows, low AND high endpoint each: S136 **564–567**, L375 **1920–1930**, M6B 375 **1916–1926**, all agreeing (§R2.4c); phase D adds **L376 at 1890–1947, both endpoints exact**, once the row's companion is `v166e774`. The decomposition is always whole — `e(L)`, `e(S)`, centre-cross, and off-centre cross by radius family — and `e_S_his` books the twelve centre-to-S edges to the S side as he does (§R2.6). **The rung-2 374 row reads 1860–1874 against his 1868–1884**, and that disagreement was registered as **P-D16 in a commit before the run reached that rung** and then confirmed: `v374e1860` is `⟨g₂₃⟩`-invariant with stabiliser exactly 2, so it must lie in his rung-2 level and his range must start at 1860. Reading **both** endpoints prunes the causes to one live reading — a companion incomparable with `S136` (§H2.9). The rung-1 374 row's range waits on its enumeration | rung-1 374 → E; the 24-frame test that would settle his rung-2 row → E |
| G-4 | `{M}` grows at fixed `M` (§3 rank 4) | **phenomenon observed; clause 2(c) NOT MET, and now not met twice over** | the complete 89-candidate sweep of `A412` grew `{M}` **once, at fixed `\|M\| = 374` and fixed rung 1 with vertices added — 1 of 63 menu candidates, 1,692 new minima, 0 of 26 shoulder candidates** (`data/m62/m63-map-A412.json`), but that candidate came from the sweep's seeded random block and **clause 2(c) requires the RULE to have added them**. The frozen rule's own run then produced no growth at all: six iterations, every one `unchanged` (`data/m62/m63-loop-A403.json`, commit `0139f29`). The replay comparison 78 → 1,092 (S.1 2a) is a separate clause and waits on the rung-1 374 level closing | 2(b) follow-on, then E |
| G-5 | `\|{M}\|`, `\|A\|` reported (§3 rank 5) | **done for four rows** | under his convention (the stabiliser of the reduced part, companion free): **8 / 166**, **282 / 403**, **66 / 403**, each matching his Table 1 with `A` equal to his published accumulator LITERALLY; phase D adds **96 / 451** at the order-3 rung once the companion is `v166e774`. All levels closed under the counting group, so these count orbits contained rather than orbits meeting (§O6, §R2.4c). Reported, never gated. **Two further phenomena are on record and are not defects:** at the rung-2 374 row our count equals his 78 while `A` is 402 and is not his `v406e2082` up to the group, and the two 78-member levels are **incomparable** — each contains a member the other lacks (§R3.13, §H2.9). Per S.1 2(a), `\|{M}\|` and `A` are comparable only once that row's companion is identified | the rung-1 374 row → E |
| A-7 | Table 5 (−16) and Table 7 (+3) `A` columns vs `v375e1862`, `v289e1389` | **partly — unchanged by phase D** | each `A` file sums EXACTLY to its own caption (375, 238, 289), so both discrepancies live in his printed per-row columns and not in his data — the same shape as Table 3's, whose file has 412 against a column summing to 402. **c2.9 fired**: Table 6's column transcribed row by row against `v238e1131` gives **zero differing rows**, so the checker can agree and not merely differ. Tables 5 and 7 remain **NOT-COMPARED** row by row (§R2.4d). **Phase D did not transcribe them**: they sat behind the replays in §5's order of work and the replays were overtaken by the companion finding. The two tables are the accumulators of E's own held-out problems — the 8/3 mono-pair `v375e1862` and the √3 triple `v289e1389` — so the transcription is cheapest in the phase that runs those rows | **E** (was D) |
| B-12 | the 8-4-2-1 batching of phase 1 (§2, his §5.8) | **done in its look-ahead role — and the quantity it prices is degenerate** | `parts_rule.look_ahead` deletes eight necessary atoms at once from the enlarged graph and one refusal frees all eight — sound because the property is upward closed; a colourable answer halves the batch, and an `unknown` counts the batch as NOT freed and is reported, so a budget fact never reads as a graph fact. **The batching works and what it measures does not discriminate:** the proxy reads **0 freed of 336 necessary atoms on every single orbit tried, including an orbit his own recorded move used** (§R3.b). Poros's reading, carried because it bounds the claim: freeing a necessary atom needs the graph without it to refuse, and every edge from the new material to that atom vanishes with it, so the proxy watches only the *singleton* correction sets — **whether any single orbit widens a NON-singleton correction set is unmeasured, and that is the cheaper route**. Its phase-1 role remains unnecessary at the measured costs | the unmeasured half → 2(b) follow-on |
| C-5 | the cheap statistics: non-isolated count, component profile, `α`, the `2^m` induced-matching bound, `α + \|free\|` test | **not done** | they have a second role my drop argument missed (Poros card 8): the free-vertex count, the small-degree hyperedge counts and `α` of the degree-2 graph **are** §5.10's numerical indicators, and §5.6's third strategy ranks candidate expansions by them. **D2 was not implemented in phase D** — no `indicators` exists anywhere in `tools/` at HEAD — so none of the three quantities is in committed code and **P-D1 is unscored**. The ordering reason for scoring his device first is spent (the rule is frozen and has run), but the question is not: *no published device of his selects his own recorded move* is now established for §5.6's priority sentence and for the reserve's degree order at both the single-orbit and the set-valued rung (§R3.b2), and §5.10's indicators are the one device still untested. Their *sizing* role is still superseded | **2(b) follow-on** |
| D-2 | dedup by the input group before verifying | retired for type M; **the phase D rider is proposed for dropping** | `Aut(W ∪ C)` is trivial (S.2 #1); the 12-fold multiplicity is `Aut(A)` with the companion moving, not a symmetry of the stage, so images must still be verified. The rider — *"D may measure propose-images-as-candidates on the `A412` level"* — was **not run**, and the sweep removed its motivation: every single orbit in the closed menu has been evaluated and refused (0 of 63), so a different *generator* of single-orbit candidates cannot help at that state. The live question is multi-orbit, which is a different rider (see M64-2). **Proposed drop; product owner's approval needed** | drop? |
| D-4 | `A`'s growth curve and a stall stop | **done, and exercised end to end** | `parts_rule.run_loop` carries the per-iteration history and a stall counter feeding his own escape (raise the vertex budget and re-rank); `stalled` is a verdict, not a success. **Exercised on the held-out state**: six iterations from the 403-vertex accumulator, `unchanged` each time, the escalation firing at the third stall (vertex budget 12 → 40), `many_then_trim` reached at the last rung, verdict `stalled` at 3,715 s (`data/m62/m63-loop-A403.json`). The history rows carry `(iteration, verdict, \|M\|, vertex budget, elapsed)`; `\|{M}\|` and `\|A\|` per iteration are O-3's gap and are not in them | — |
| D-6 | the level in parallel | drop? — the level half stands dropped, the across-candidates half returned and ran | levels still close in minutes on one core, so the level-parallel item is unchanged. The half §1(c) brought back for D is parallelism **across candidates**, and it ran: 89 independent candidates at **12 workers**, 1,801 s wall (`data/m62/m63-map-A412.json`). **Control d6.4 — a `jobs=16` run agreeing with `jobs=1` on the same candidates — was not exercised**, the map having run only at 12, so the parallel path's agreement rests on the per-entry invariants (the restriction identity and the known-answer anchor, both firing on all 89) rather than on a serial comparison | d6.4 → wherever the map is next run (2(b) follow-on / F) |
| E-1 | expansion: partial orbits first, then the reserve `R` (§4 E) | **done** | `parts_loop.menu_candidates` (fills first, then the reserve in his decreasing-degree order) and `parts_rule.many_then_trim` (his SECOND published strategy, which no earlier plan carried). The menu is enumerated under three **named** readings with the adopted one recorded in every artifact — 49 strict / 57 literal-internal / 57 literal-plus-cross on `A412` — and the **fills exemption his degree test misses is measured**: 17 partially occupied orbits of which **5 are fill-only**, so the menu is **62**, plus **26** shoulder candidates at degree exactly 3 (`parts_loop.menu_census`). His stated priorities remain non-decisive on his own move (Poros M3; §R3.b2 adds the set-valued rung), which is why the ranking is ours and frozen | — |
| E-2 | L and S alternating against a frozen companion | **partly** | the **L** loop ran against the frozen companion `v136e564` — six iterations, verdict `stalled` (`m63-loop-A403.json`) — and the **S** side was swept by the scoped probe (`plans/M63-probe-S-expansion.md`), so each side has now been expanded against a frozen partner. **The alternation itself was not run**: every phase D run holds one side frozen for its whole life, and nothing fed an improved L minimum back into an S reduction | the alternation → E; the joint → F |
| E-4 | stall escape by more new vertices | **done, and exercised** | his own escape, as an explicit schedule of vertex budgets frozen in commit `6158162` (`escalation_schedule` `[12, 40]`) rather than tuned during the run; at the last rung it reaches `many_then_trim`, the set-valued move. **It fired**: at the third stall the budget rose to 40 and `many_then_trim` proposed **48 vertices across six orbits**, which returned `no` with its bound closing (§R3.b). **And the trim is exonerated as the binding constraint**: all 30 vertices of his own recorded move survive it in zero passes, at degrees 4 (×15), 6 (×9) and 8 (×6) against a threshold of 3 — `trim-preserves-his-move` (`data/m62/m63-trim-test.json`). The binding constraint is the cap of six interacting with the ordering | — |
| E-5 | the four-state path | partly — **three of the four states now name their companion** | state 2 met (S.2 #1–2); **state 1 reproduces four-for-four** once its companion is identified as the S accumulator `v166e774` (§R3.4); states 3–4 are one reduction of `A412` at two rungs, of which the rung-2 row disagrees with his printed edge range in the way P-D16 predicted in advance, and the rung-1 row is still enumerating | E |
| P6 | §5.10 indicators subsumed by `exact.py` | **restated, and not done** | the comparison with `exact.py` is off the path, but the indicators are not: the useful form is *do they rank the orbits his own move used above the rest?* (Poros card 8). **Phase D did not implement them** (see C-5), so **P-D1 is unscored and P6 is undischarged** | **2(b) follow-on** |
| P8 | one iteration `A412 → 374` ≈ 3.5 h ±2× | **scored, and the revised forecast is exceeded** | the original assumed 2–4 s asks; measured 0.006–0.14 s (S.2 #11, §R3.1). D registered a revised forecast of **20–90 min on one core for ~13k raw minima**. Measured: the *optimum* is reached cheaply — `w* = 373`, zero undecided — but the **level enumeration has passed 2.9 CPU hours and 17,360 minima and is still running**, so the forecast's binding assumption was the level size, not the per-ask rate. That is P-D10's replacement derivation seen from the other side: **the cost of a reduction at this scale is the enumeration** | close the number when the enumeration lands (E) |
| O-3 | per-iteration `(\|M\|, \|{M}\|, \|A\|)`, `stalled` as a verdict, stall feeds expansion | **partly** | `parts_rule.run_loop` logs a per-iteration line with the verdict, `\|M\|`, the vertex budget and the stall counter, and checkpoints per iteration; `stalled` is a verdict and the loop ended on it. **The richer line of §E is still not wired** — `\|{M}\|` and `\|A\|` deltas, `Y`'s shape, the candidate count, the target, the correction sets, both ask populations, the checkpoint's age and the `kill-safe:` clause — and **`parts_report.iteration_line` is still defined and never called** (checked at HEAD) | E |
| X-5 | the freeze is a commit (`require_frozen`) | **done** | two defects fixed in C (a hex digest of a hex digest; an `.items()` diff that raises on a nested list); `_freeze_control` plants all five cases in a scratch git repository and all five fire. **Phase D made the freeze**: commit `6158162`, artifact `data/m62/m63-freeze.json`, **before** the scored run, with `require_frozen` exercised red and green — the frozen configuration passes and a configuration with one parameter changed is refused by name. The freeze states **in advance** what happens if the held-out map is signal-free (the rule is then scored by one bit on one held-out row, and the acceptance must say so) and carries four bans, including that no ranking may be graded against an outcome it also predicts | — |
| X-6 | the per-iteration line | **partly** | a line exists and carries four of the specified quantities; the specified line does not (see O-3) | E |
| X-7 | a level forecast before entry, and refusal of an unboundable level | **done in its replacement form for the sweep; not for the loop** | `parts_report.level_forecast` computes a forecast and **names its assumption in the same breath** (exercised in that module's self-test), and `parts_loop map --dry-run` prints a pre-launch forecast in asks and correction sets at the measured D0 rates, with the secondary decision's factor declared **unmeasured** and the first candidate named as what measures it. `max_minima` and the conflict-slice wall are the refusals and report truncation, and a truncated level **halts** rather than taints: `run_loop` refuses a starting record carrying `A_sample` (control d4.1, exercised in `parts_rule --self-test`), and `LevelSet.require_complete` refuses to supply necessary atoms from an incomplete level. **`run_loop` itself prints no pre-level forecast** | the loop's own forecast → E, with X-6 |
| M64-2 | phase F: expansion as an integer program over profiles | **not done — and it is now the live shape rather than a spare one** | single-orbit expansion from `A412` is closed at zero over a complete menu (0 of 63 improve, 1 grows); his own recorded successful move added **four orbits at once**; and the forced monotonicity argument says a superset of a succeeding set also succeeds, so **over-proposing costs time but never correctness** (§R3.b2). A set-valued rule is therefore what the follow-on needs, and an integer program over profiles is one form of it — one candidate rule among others, scored, never gated | **2(b) follow-on** |
| M64-3 | conjugacy of `Aut(A)`'s involutions (P7's second half) | **done for the multiset agreement; the row-to-class pairing proposed retired** | `parts_audit.involution_classes`: L's `Aut(A)` (order 12) has 6 conjugacy classes, of which three are involution classes of sizes 3, 3, 1 — and M64 §R10's seven stored order-2 rung values are three 375s, three 376s and one ≥ 377, a multiset partitioning exactly as the classes do. S: one involution class of size 3, all three rungs reading 138. **Phase D neither wanted nor needed the pairing**: the rung of a published row is read directly off his own file as a stabiliser computation — his `v376e1890` has stabiliser order 3 and the base group has exactly one order-3 subgroup — which identified state 1's rung in 30 seconds and `H2#4` as his rung-2 row solver-free (§R3.4; §R3.12 P-D17). **Proposed retired, the pairing having no consumer** | retired (approval) |
| FS35-1 | the look-ahead's two quantities along his recorded path | **partly — closed at our 375 state, and unchanged by the rest of D** | `tools/parts_diag.py:fs35` on the complete 375 level: **two exchange classes**, affine dimension 2 of 4, sixteen rungs with closure bounds, atom classes reconciling as 336 + 24 + 14 of 18 = 374 (`data/m62/m63-fs35-1-375.json`). **The replayed 374 and 376 states were not reached** — each needs its own stage at its own rung, and the rung-1 374 level is still enumerating — so **P-D9 is unscored**. The identity probe P-D6 was not computed at any state | E |

### A.2 — Two new rows proposed (ids need the product owner's blessing)

| D-7 | the **exact** edge minimum of the 509, an item no plan carried before phase D's §PA(e) found `[deGreyParts2023]` fn. 2 | **partly — bracketed, not closed** | the edge minimisation is the same reduction with edges as atoms, so `reduce_stage` needed no change (§M collapse 1). **Floor `e_min ≥ 1831`**: the individually-critical census completed at 1,831 critical, 609 individually removable, 2 undecided — and an undecided ask is recorded as *not* critical, so the floor is understated rather than overstated (`data/m62/m63-edge-phase1-509.json`). **Certified upper bound `e_min ≤ 2279`**: a greedy 1-minimal pass dropped 163 of 2,442 edges and the object passes all six verification legs — unpinned refutation in a separate process with a different CaDiCaL, exact geometry on all 2,279 edges with the cross edges re-derived from the *stated* rotation law, minimum degree 4, an LRAT replay by our own checker over 7,699,212 RUP steps with five planted faults all firing, and colourability controls both ways (`m63-edge-greedy-509.json`, `m63-edge-verify-509.json`). **The hitting set over the 448-edge window is unrun**, so the exact minimum is unknown. **The object is a measurement and not a record**: its kernel certification was cancelled by Kooshi — thinning his graph is not our product — and the route measurement is in `plans/M63-kernel-certification-route.md` | the exact minimum → F; no certificate before a graph of our own |
| H-6 | `Stage.pin_is_sound` was a vacuous control at every rung above 1 | **done** | it identified pin atoms by each atom's **lowest set bit**; at rung 1 an atom is one vertex and that is right, but above it an atom is an orbit and a pin vertex need not be its lowest-numbered member, so the control found no pin atoms and printed the benign verdict `pin-is-fixed` while checking nothing — both of 2026-09-11's order-3 runs did exactly that. **Fixed at commit `13454c3`** (`any((m >> v) & 1 for v in self.pin)`, present at HEAD), with the part that matters planted beside it: the **shipped rule run next to the fixed one** on a stage where they differ — at the order-3 rung, 150 atoms, **0 pin atoms by the shipped rule and 2 by the fixed one** — so the control is seen to fail on the code it replaces. No number is retracted: the symmetry break itself is sound because `Stage.cnf` makes the pin clause conditional on the atom's presence | — |

---

## §B — Phase D against its own acceptance checklist (`plans/M63-phaseD-the-loop.md` §7)

*Item by item, in the plan's own order. "Not decided" is reserved for a question that was asked and
returned no verdict, as distinct from one never asked.*

### B.1 — D0 / D0.5, the regime and the knob

| promise | verdict | evidence |
|---|---|---|
| ask costs in CPU seconds, min of three runs, machine and concurrent load named | **done** | `data/m62/m63-D0-cost-probe{,-L451}.json`: machine the machine, 32 cores, load recorded at start **and** end (6.87 → 7.07), cold 9.41 s, near-optimal refusing 0.138 s, colourable 0.055 s |
| **correction sets per minute reported** | **not done** | the probe reports asks, their means and totals, and the slice budget; there is **no correction-sets-per-minute field**. §5's forecasts are nonetheless written in correction sets, and the map's per-entry `correction_sets` supplies the rate after the fact (461 for the identity entry at 122 CPU s) |
| P-D0a, P-D0b scored | **done** | P-D0a **MET** (0.138 / 0.144 s under a 0.15 s bar); P-D0b **FALSIFIED** at ratio 0.96, with the cold-ask form surviving (9.41 vs 4.62 s) |
| `target=` implemented; d0.1 fires both ways; no targeted record renders as a minimum | **done** | §R3.2: `target=141` returns the identical level, `target=140` returns `no-selection-at-target` with lower bound exactly 141. `parts_report.Bound` gained a `target` branch in which the word *minimum* is unreachable, a targeted bound is never `closed`, and a bound whose lower does not exceed its target raises — all three asserted in that module's self-test |
| P-D10 scored | **done** | **FALSIFIED as registered** (91%, not < 1/3) and replaced by a derivation: the saving is exactly the level enumeration, refined by card 16 to `old/(old+new)` per candidate and then measured at 1.4× on the growing candidate and **median 0.06** on the 62 non-growing ones |

### B.2 — D1, the replays

| promise | verdict | evidence |
|---|---|---|
| 376 at rung 3 on `A451`: vertices, edges, `A`, counts under all three conventions | **done** | four-for-four against `v166e774` (`m63-D1a-A451-rung3-vs-A166.json`); the against-`S136` run kept as the object the finding is made of |
| 374 at rung 1 on `A412`: vertices, edges, `A` as a set, counts | **partly** | `\|M\| = 374` with zero undecided is established; the counts, the edge range and `A` as a set need the level, **still enumerating** |
| 374 at the rung-2 subgroup: vertices, edges, `A` up to the group, counts | **done, with a registered disagreement** | seven order-2 rungs run; `H2#4` identified as his solver-free; 78 minima (his count), `A` = 402 (not his 406 up to the group), edges 1860–1874 against his 1868–1884. **The artifact is `build/m63d/d1c.json`, untracked scratch from an uncommitted script** — see §D.4 |
| **d1.1** — D1.c computed both ways, and the two agree | **not done** | only the direct rung-2 route was run; the second route is the invariant part of the rung-1 level, which is still enumerating. **P-D8 unscored** |
| **d1.2** — a relabelled truncated level refuses every downstream claim | **done in substance** | `parts_faces.LevelSet.require_complete` refuses, and `parts_rule --self-test` exercises it ("a truncated level cannot supply necessary atoms"). Note the label: that self-test line is tagged **d3.2**, which is a different control in the plan |
| **d1.3** — each replay stage contains a known minimum of his | **done on the stages it was run on** | fires on both D0 stages (`contains-a-known-minimum`, refusing then colourable) and on **all 89** map entries as the per-candidate anchor; not recorded for the rung-2 replay rows |
| P8's revised forecast scored | **partly** | scored and exceeded; see §A row P8 |

### B.3 — D2, his device

| promise | verdict | evidence |
|---|---|---|
| all three §5.10 quantities implemented, reported separately | **not done** | no `indicators` / `alpha_degree2` anywhere in `tools/` at HEAD |
| run on ~14 candidates; the rank of his four orbits under each indicator | **not done** | — |
| the verdict written either way; **d2.1** fires; P-D1 scored; P6 discharged | **not done** | **P-D1 unscored, P6 undischarged, d2.1 unexercised.** The phase says so plainly in §R3.11: D2 was scheduled after the replays and the replays were overtaken by the companion finding, which had to be settled first because it decides what a replay comparison *means* |

### B.4 — D3, the machinery and the rule

| promise | verdict | evidence |
|---|---|---|
| `reserve` re-derives the counts, or reports a different number with its reason | **done** | 49 strict / 57 literal-internal / 57 plus-cross on `A412`, re-derived in committed code (`parts_loop.menu_census`), **and a different number reported with its reason**: the fills exemption his degree test misses adds 5 fill-only candidates, so the menu is 62 and the sweep 88 + identity |
| `candidates` proposes fills before reserve orbits; `many_then_trim` implemented; **d3.1** fires | **done** | both in committed code; `Candidate(frozenset(), "reserve")` raises `no-op-expansion`, asserted in two self-tests, with the identity candidate the one exemption |
| `look_ahead` reads necessary atoms off a **complete** level; the 336-against-312 distinction re-derived | **done** | `run_loop`'s start line prints `necessary 336 (Y's degree-1 layer: 312)`, computed from the level rather than copied |
| **d3.2** — the proxy separates a candidate freeing zero from one freeing many | **cannot fire as specified; superseded by a measurement** | the proxy read **0 freed on every candidate tried**, so `proxy-cannot-separate` is the measured state of the instrument rather than a control that fired. **Proposed retired as a control**, with the measurement recorded in its place |
| **d3.3** — an 8-batch agrees with the eight individual verdicts | **not done** | no `batch-agrees` verdict appears in any artifact; the batching's soundness rests on the upward-closure argument alone |
| **d3.4** — a context offered one of his files aborts | **done** | `Ctx.check_clean` returns `context-carries-no-answer-key` on a clean context and raises on one naming his archive; both in `parts_rule --self-test` |
| the rule written, committed, and the freeze commit made **before** any scored run; `require_frozen` red and green | **done** | commit `6158162`, `data/m62/m63-freeze.json` |

### B.5 — D4, the loop

| promise | verdict | evidence |
|---|---|---|
| the per-iteration line carries the ten specified quantities | **not done** | four of them; see §A rows O-3 / X-6 |
| `stalled` is a verdict | **done** | the run ended `stalled` with the schedule exhausted |
| **d4.1** — a starting record carrying `A_sample` is refused | **done** | `parts_rule --self-test` |
| **d4.2** — a loop killed mid-iteration and resumed reproduces its history and minima | **not done** | the loop checkpoints per iteration and `run_loop` resumes from one, but **no planted kill/resume comparison was run**, and `loop-resume-identical` appears nowhere in the code |
| **d4.3** — `stall_limit` unchanged iterations give verdict `stalled`, never `complete` | **done** | six iterations, verdict `stalled` |
| **d4.4** — an `A`-dependent rung re-resolved after an expansion is caught | **partly** | implemented as a hard raise in `parts_rule.step` when a stage returns at a rung above 1, with the reason written out; **never exercised, because the whole loop ran at rung 1**, where the hazard is absent |
| **clause 2(b): the rule reaches `\|M\| ≤ 374` from our 375-level accumulator** | **NOT MET** | six iterations, all `unchanged`, verdict `stalled` at 3,715 s (`m63-loop-A403.json`, commit `557aece`). **The diagnostic settles the category:** run through the same `sweep_candidate` the rule used, **his own four orbits (30 vertices) reach `w* = 373`, i.e. 374 vertices, with zero undecided asks**, so the state, companion, stage and pipeline reproduce his recorded step exactly and **the failure is a ranking — more precisely an omission — failure, not an apparatus failure** (§R3.b, §R3.b2) |
| **clause 2(c): `{M}` grows at fixed `\|M\|` and fixed rung in an iteration where the rule added vertices** | **phenomenon observed, clause NOT MET** | observed once in 63 on a randomly chosen candidate; the rule's own six iterations grew nothing |
| the rank of his implied move under the rule, reported as a diagnostic | **partly** | reported qualitatively — four of his six chosen orbits sat in the menu the rule ranked and two were in the set it proposed — and his move's *outcome* is measured (`build/m63d2/hismove.log`). **No numeric rank is recorded in any artifact**; `his_move_rank` exists in the plan's schema and in no file |

### B.6 — D5, our own record

| promise | verdict | evidence |
|---|---|---|
| `L374 ∪ ρS136`: 509 vertices, 2,442 edges, `1860 + 564 + 12 + 6`, refusing on exact geometry; **d5.1** fires | **done** | `parts_edges.assemble_record` and its self-test; the stage books the twelve centre-to-S edges to the L side and so reads `1860 + 552 + 30`, of which **18 cross edges are off the centre** — his 18 exactly |

### B.7 — D6, the sweep, the map, FS-35, the edges

| promise | verdict | evidence |
|---|---|---|
| the `A412` sweep ran first, its first candidate **alone and timed** | **done** | `m63-map-A412-first.json`: `(6,2,8,0)`, 12 vertices, 559-vertex working graph, primary 133.2 s, secondary 186.3 s |
| the menu enumerated under a **stated reading**, the count a parameter, both readings given; P-D13, P-D14 scored | **done** | three readings in the artifact; P-D13 **NEGATIVE** (×1.16, below the 1.3 floor); P-D14 **NEGATIVE** under all three readings |
| block 1 (seeded random) before block 2; truncation as a `Count` naming its block; shoulder included; outside-disk flagged | **done, and no truncation occurred** | the sweep completed at 89; every entry carries `block` and `block_index` |
| the helpful density reported first, for each half; P-D3, P-D3b, P-D12 scored | **done** | density is the third field of the artifact and the shoulder has its own; **P-D3b FALSIFIED** (degenerate at zero), **P-D3 UNSCOREABLE** on this map (every ranking ties), **P-D12 NOT DECIDED** (both halves read zero on the primary) |
| the `A403` map runs **only after** the rule's attempt; **d6.4** fires at the core count used | **the ordering held; the map was not run and d6.4 was not exercised** | no `m63-map-A403*` artifact exists. The ordering constraint is satisfied — the rule's attempt happened first — but vacuously |
| the map artifact carries what makes it re-scorable | **done** | verified on the file: no stored score; `block` and `block_index` on all 89; `asked_at_target` on all 89; a three-way density with `not_run` beside it; the admission reading named; outside-disk and fill-only flags; an explicit note that any ranking is a read-off |
| no rendering presents a one-sided bound as a minimum; **the four §E3 refusal texts asserted as golden strings** | **partly** | the rendering rule is enforced by construction and asserted in `parts_report._self_test`. **None of the four §E3 texts appears verbatim in `tools/` at HEAD**; two exist in substance as shorter messages (the targeted-bound refusal, the `A_sample` refusal) and two were never built (the density refusal, the edge-sweep-impossible text — though the verdict word itself exists and fires) |
| the `no_filter_random` sample run, or dropped under the stated cut and said so | **done by a declared substitution** | replaced by the 26-candidate **shoulder** block (Poros card 9), recorded in the frozen protocol **before** the sweep with the reason: a no-filter sample would be drawn overwhelmingly from degrees 0 and 1 and would confirm "the filter does something" while saying nothing about where the cut belongs. Both sides of the cut then read zero, so the threshold question is *answered for single orbits* and *has no power as a ranking comparison* |
| exchange-class vector and closure bound at each replayed state plus our 375; FS35-1 closed; P-D6, P-D9 scored | **partly** | 375 only (`m63-fs35-1-375.json`); **P-D9 unscored**; **P-D6 not computed at any state** |
| the edge sweep as an edge-atom stage, reporting **the exact edge minimum** with its bound closed, greedy beside it; d6.1, d6.2, d6.3, d6.7, d6.8, d6.9 fire; P-D7 scored; escalated if it beats 2,406 | **partly — a bracket, not the minimum** | the edge-atom stage was built and its controls fire: **d6.1** (a stage over the wrong halves is refused before any ask), **d6.2** (restructured after card 18 — the pin is now *conditional on its own three edges*, so the search is unrestricted; the behavioural plant is reported as **not discriminating here** and replaced by a structural guard: the conditional CNF has no unit clause, the unconditional one has exactly three), **d6.7** (509 / 2,442, every edge an atom, `side_fixed = 0`), **d6.8** (`centre-critical`: `G − centre` is colourable, so the floor rises to **1,018**), **d6.9** (fires on a planted low-degree vertex and passes on the real object), **d6.3** superseded by the six-leg chain. **The exact minimum was not computed**: floor 1,831, certified upper bound 2,279, a 448-edge window. **P-D7 CONFIRMED** and **P-D7b CONFIRMED**. Escalated the same hour, and ruled a measurement rather than a record |
| the §O6 floor stated with its hypothesis and every returned object checked | **done** | 1,016 as proved, 1,018 once d6.8 answered; `floor_check` on every returned object |
| the record says in one sentence that an edge-minimal subgraph is still a unit-distance graph | **done** | §R3.6 and the verification artifact's geometry note |

### B.8 — Close

| promise | verdict | evidence |
|---|---|---|
| M63 §R3 written | **done** | the phase plan's §R3.0–R3.15 and the master plan's §R3.a–R3.e |
| §S.3's D rows updated in place | **this file, §A** — the rows are supplied as text because one agent writes that file | — |
| every §4 prediction scored by name | **partly — 15 of 19 resolved, 4 open, none dropped** | resolved: P-D0a, P-D0b, P-D3, P-D3b, P-D4, P-D7, P-D7b, P-D10, P-D12, P-D13, P-D14, P-D15, P-D16, P-D17, and P-D2 (below). Open with what each waits on: **P-D1** (D2 unimplemented), **P-D5** (the enumeration), **P-D6** (never computed), **P-D8** (the second route), **P-D9** (the replayed states). **P-D11** belongs to the probe. **P-D2 needs its verdict corrected — see §D.1** |
| the small-half agent's results folded in, P-D11 scored | **not done** | the probe is still running: 13–14 of 14 singles decided, every one inert at 136 with a bit-for-bit identical level, and the pair phase (112 pairs, 21 promoted first) is next. Its own §8 Outcomes reads "(pending)", so **P-D11 is unscored** and the fold-in is outstanding |
| `BIBLIOGRAPHY.md` carries the `[deGreyParts2023]` row | **done** | present |
| Poros's phase D record committed by path; every card answered | **done** | `plans/POROS-2026-09-11-m63-phaseD.md`, 2,082 lines, thirty cards all fated, with a handover section and the advisor's own scorecard |

### B.9 — §6, "what must not be done": compliance

| ban | held? |
|---|---|
| 1 no rule that can see his answers; no map before the freeze | **held** — `d3.4`; `A412` declared in-sample in the frozen protocol; `A403` unrun |
| 2 no loop continued from a truncated level | **held** — d4.1 plus `require_complete` |
| 3 no record produced under a target called a minimum | **held** — the `Bound.target` branch makes the word unreachable |
| 4 no forecast in wall-clock alone | **held** — asks, correction sets and conflict slices throughout; `unknown` reachable and reported |
| 5 no joint result as a reproduction row | **held** — the joint runs are phase C's |
| 6 no count without its enumeration, no bound without its rung, no verdict word meaning "clean" | **held** |
| 7 no held-out problem touched | **held** — M6B 374 at rung 2, M6C, S M6B/M6C, the 8/3 mono-pair and the √3 triple are untouched |
| 8 no stored record overwritten | **held** — regenerations sit beside the originals as `.v2` |
| 9 **no Lean** | **crossed, knowingly, and rolled back** — see §D.3 |
| 10 no artifact without a committed producer | **partly** — see §D.4 |

---

## §C — Every not-done item, assigned or proposed for dropping

*Nothing in §B marked "not done" or "partly" is missing from this table. A drop needs the product owner's
explicit approval; everything else is an assignment, not a request.*

| # | item | assignment |
|---|---|---|
| 1 | D2 — his §5.10 indicators; P-D1; P6; control d2.1 (also §S.3 rows C-5, P6) | **2(b) follow-on** |
| 2 | the `A403` held-out map — now a discriminator between *inert at that state* and *inert as such*, with an unambiguous reading because a positive provably exists there | **2(b) follow-on** |
| 3 | d6.4, the parallel/serial agreement of the map | **2(b) follow-on**, at whatever core count that map runs |
| 4 | d3.3, the 8-batch agreeing with eight individual verdicts | **2(b) follow-on** |
| 5 | d4.2, a planted kill/resume of the loop reproducing its history | **2(b) follow-on** |
| 6 | d4.4 exercised at a rung above 1 (implemented, never triggered) | **F**, which is where symmetric seeds first make it live |
| 7 | the numeric rank of his implied move under the frozen rule | **2(b) follow-on** — it is readable at `A403`, where the loop ran |
| 8 | B-12's unmeasured half: whether a single orbit widens a **non-singleton** correction set | **2(b) follow-on** |
| 9 | M64-2, a set-valued expansion rule (an IP over profiles is one form) | **2(b) follow-on** |
| 10 | the loop artifact's provenance: `freeze_commit` and `config_sha256` are `null` on the one artifact that scores an acceptance clause (§D.2) | **2(b) follow-on**, and re-stamped when the loop next runs |
| 11 | the two §E3 refusal texts that were never built, as golden strings | **2(b) follow-on** |
| 12 | correction sets per minute in the cost probe | **2(b) follow-on** — one derived field |
| 13 | d1.1 and P-D8, the two routes to D1.c | **E** — it needs the rung-1 level |
| 14 | P-D5, and the 374 row's `\|{M}\|`, `A` and edge range (§S.3 G-1, G-3, G-5, E-5) | **E** — handed over running |
| 15 | FS35-1 at the replayed states; P-D9; and P-D6, never computed at any state | **E** |
| 16 | the richer per-iteration line, and the loop's own pre-level forecast (§S.3 O-3, X-6, X-7) | **E** |
| 17 | the stable/unstable partition and the shading extraction (§S.3 G-2) | **E**, or a scoped extraction |
| 18 | Tables 5 and 7 transcribed row by row (§S.3 A-7) | **E** — they are E's own held-out accumulators |
| 19 | E-2's alternation: an improved L minimum fed back into an S reduction | **E** |
| 20 | the 24-frame test that would settle his rung-2 companion (§H2.9), decisive at 24 asks | **E** |
| 21 | the exact edge minimum — the hitting set over the 448-edge window `[1831, 2279]` | **F** |
| 22 | promote `build/m63d/d1c.json` and the companion hunt to committed producers and artifacts (§D.4) | **2(b) follow-on** — it is the evidence under a confirmed prediction and under §S.1 2(a) |
| 23 | P-D11 and the small-half fold-in | **the probe**, which is still running; fold in at its close |
| **D1** | D-2's rider, "propose images as candidates on the `A412` level" — the closed menu's zero removes its motivation, and the live question is multi-orbit | **DROPPED**, approved 2026-09-11 (§F) |
| **D2** | M64-3's row-to-class pairing — a stabiliser computation on his own published file answers the rung question directly, so the pairing has no consumer | **RETIRED**, approved 2026-09-11 (§F) |
| **D3** | control d3.2 as a *control* — the proxy cannot separate anything because it reads zero everywhere; the measurement replaces it, and keeping a control that cannot fire is the failure mode this milestone names | **RETIRED**, the measurement in its place, approved 2026-09-11 (§F) |

---

## §D — Findings: things the plan did not promise, and promises that no longer read true

### D.1 — Two stale verdicts in files I may not edit

1. **The master plan's §R3.e scores P-D2 as `[RUNNING]` — "not met so far: iterations 1 and 2 both
   unchanged".** The run finished: six iterations, verdict `stalled` (commit `0139f29`, after `7aee94f`
   wrote that row). **The honest verdict is narrower than "falsified"** and worth stating exactly, because
   the registered form says *within 12 iterations* and the frozen configuration allowed **six**:
   > **P-D2 — NOT MET at the budget it was given.** The frozen rule ran its full schedule — six
   > iterations, vertex budgets 12 then 40, ending at `many_then_trim` — and did not reach `\|M\| ≤ 374`.
   > The registered 12-iteration form is **unscored**: no run of twelve iterations exists. §R3.b2's
   > monotonicity argument says more iterations of the same ranking would not have helped, but that is a
   > reading and not the prediction's test.
2. **The phase D plan's §R3.11 ("What phase D did NOT do") is stale.** It was written by the first
   implementer and lists D3's `look_ahead`, `many_then_trim`, the ranking, the freeze and D4's loop as not
   implemented; the successor implemented all of them. Suggested one-line pointer for whoever next owns
   that file, rather than a rewrite: *"Superseded from D3 onward by the master plan's §R3.a–R3.e and by
   `plans/M63-phaseD-close-audit.md`: the rule, the loop and the freeze were built by the successor; what
   remains not done is listed there."*

### D.2 — The artifact that scores clause 2(b) does not carry its freeze

`data/m62/m63-loop-A403.json` has `"freeze_commit": null`, `"config_sha256": null` and
`"git_dirty": true`. The rule's definition *is* in the file, and the freeze itself is a commit
(`6158162`) with its own artifact, so nothing is unverifiable — but the one artifact whose job is to
record a scored acceptance clause does not name the freeze it ran under, which is the property the freeze
mechanism exists to give. Cheap to fix at the next run; listed as item 10 in §C.

### D.3 — Ban 9, "no Lean", was crossed and then rolled back

Phase D's §6 reserves every kernel certificate for F. The certification of the 2,279-edge object was
nevertheless started — 468 modules and 81.3 MB emitted, and **one segment really was put through the
kernel and accepted** (39.6 CPU s, 8.90 GB peak) — and was then cancelled by Kooshi on the grounds that
thinning Parts's own graph is a measurement rather than a product. **Nothing was committed as Lean and the
generated modules were deleted**; what survives is a route measurement in
`plans/M63-kernel-certification-route.md`. Recording it as a deviation taken with the product owner's
knowledge, not as a violation — and noting that the surviving measurement is worth more than the ban it
crossed: an unpinned 3.7 GB refutation is not checkable here, one pinned triangle buys 31×, and the whole
pinned certificate prices at 5.36 CPU hours **measured, not projected**.

### D.4 — Two load-bearing results rest on untracked scratch with uncommitted producers

`build/` is gitignored, so both of these are local-only and regenerable by nothing committed:

- **`build/m63d/d1c.json`** holds the seven order-2 rung rows, including `H2#4` — the row that carries
  **P-D16**, a prediction registered in a commit before the run and now **confirmed and cited in the master
  plan**. Its producer is `build/m63d/d1c.py`, untracked.
- **`build/m63d/companion_hunt.json`** holds the eight-companion × 24-frame hunt that identified
  `v166e774`. Its conclusion is now **§S.1 clause 2(a) of the master plan**, the phase's most portable
  finding. Its producer is untracked too.

The claim itself is not in danger: the *reproduction* of state 1 against the identified companion is a
committed artifact from a committed producer (`m63-D1a-A451-rung3-vs-A166.json` via `tools/parts_run.py`),
and it is stronger evidence than the search that found it. But the milestone has already audited this exact
shape once, as rows M64-9 and M64-10 ("produced by uncommitted scripts"), and it is the standard's own
rule (§6 item 10). Promotion is item 22 in §C.

### D.5 — §X.7 is already fixed, which contradicts the handoff's ruling

The product owner's handoff (§6.2) says *"§X.7 is the one still open… Ruling: it is fixed as part of the
freeze commit, not now."* On disk it is **already fixed and committed**: `13454c3` rewrote
`Stage.pin_is_sound` to test **any** member of an atom rather than its lowest set bit, HEAD carries that
line, the working tree is clean for that file, and the master plan's own §R3.d describes it as fixed with
its planted control. The freeze commit (`6158162`) predates the fix and does not touch that file, so the
ruling as written cannot be carried out as stated. **Recommendation:** treat X.7 as closed, record it as
new row H-6 (§A.2), and note in the handoff that the fix landed before the ruling was written. The two
reasons behind the ruling are not damaged — no number is retracted, and the fix is one line plus a control
that fails on the code it replaces.

*Flagged rather than acted on: the brief told me to mark X.7 open-and-ruled, and the evidence said
otherwise. **Resolved the same day — X.7 is closed and row H-6 is accepted** (§F), on timestamps the
product owner checked rather than took on trust: the fix `13454c3` at 21:32:37 against the freeze
`6158162` at 21:03:54, twenty-nine minutes earlier and touching only `data/m62/m63-freeze.json`. The
ruling's reasoning fell with its premise — the freeze never covered tool code, so a control repaired
after it was never outside what phase E is judged under.*

### D.6 — Phase D delivered four things its plan never promised

1. **The companion finding** (§R3.4) — his partner graph changes as his loop runs, which corrected an
   acceptance item rather than an implementation. Now §S.1 clause 2(a).
2. **The verification chain** (§R3.a) — six independent legs for any future record claim, with five planted
   faults stored **in the artifact** rather than in a log, and calibrated on a known positive first. It is
   now a standing ruling (handoff §5).
3. **The transfer lattice** (§R3.7) — which facts travel between a restricted and an unrestricted run:
   a decided ask both ways, a refusing selection and non-criticality upward, criticality and correction
   sets downward only. It is what makes the secondary question cheap, and it is not Parts-specific.
4. **Two environment-level rules**: Python 3.14's `forkserver` default (now in `CLAUDE.md`), and *a
   monitoring check owes the same negative control as a correctness check* (§H2.7), which came within one
   step of a false crash report.

### D.7 — One promise that no longer makes sense as written

The plan's §3.2 built the outcome map as **the scoring surface for the expansion rule**. It is not one, and
cannot be: the density came back degenerate at zero, so every ranking ties and precision@k is undefined
over a column of zeros. The map is an **answer** — single-orbit growth from `A412` is closed over a
complete menu, with every per-entry invariant firing and not one undecided ask — and its second purpose is
dead (§H2.8, Poros's card 25 raised against its own card 1). Anything downstream that says "score the rule
against the map" needs rewriting as "score the rule by outcome on one held-out row, and say that one bit is
what stands behind it" — which is exactly what the freeze anticipated in writing, before the run.

---

## §E — Live at the time of writing (do not touch)

- **The 374-level enumeration (D1.b)** — past its optimum at `w* = 373` with zero undecided, 2.9 CPU hours
  in, past 17,360 minima against his 1,092, checkpointing every few seconds to
  `data/m62/ckpt/m63-D1b.ckpt.json`. It closes §C items 13, 14 and part of 15.
- **The small-half probe**, its pair phase, and phase C's two joint reductions, all owned by other agents.

*An idle owning agent beside a running job is the healthy state here; nothing in this audit required going
near the process table, and nothing was signalled.*

---

## §F — Rulings, 2026-09-11

*Every decision this audit put to the product owner was taken the same day, and both further pushbacks
were accepted. Recorded here so the agent applying §A does not re-derive them.*

| item | ruling |
|---|---|
| §D.5 — X.7 | **Closed; new row H-6 accepted.** Checked against the timestamps rather than taken on trust: the fix is `13454c3` at 21:32:37, the freeze `6158162` at 21:03:54 — twenty-nine minutes earlier — and the freeze touched only `data/m62/m63-freeze.json`, never `tools/parts_stage.py`. The handoff's ruling was wrong on its premise **and** on its reasoning. The product owner is correcting the handoff, noting that the fix landed before the ruling was written |
| §D.1(1) — P-D2 | **"NOT MET at the budget it was given", not falsified**; the wording in §D.1 stands. Scoring it falsified would claim a refutation the run never performed — the registered form said twelve iterations and the frozen schedule allowed six |
| §C — D1, D2, D3 | **All three approved**: D-2's propose-images rider dropped, M64-3's row-to-class pairing retired, control d3.2 retired with its measurement in its place. Approved on the stated ground — each lost its consumer to a **measurement** rather than to fatigue, which is the first kind of drop and not the kind an audit exists to catch |
| §C item 22 — the scratch artifacts | **Promote both**, `build/m63d/d1c.json` and `companion_hunt.json`. The standard is that the artifact is the certificate and the checker, never the search; the claim is safe but the evidence under a confirmed prediction may not live in a gitignored directory |
| §D.3 — ban 9 | **A knowing deviation, not a violation** — crossed and rolled back on the product owner's instruction, with the committed route measurement the thing that survives |

**Both pushbacks accepted.** §D.7: the outcome map is not a scoring surface, so anything downstream reading
"score the rule against the map" becomes *"score by outcome on one held-out row, and say that one bit is
what stands behind it"* — a degenerate density means every ranking ties and precision@k is undefined.
§D.1(2): phase D's §R3.11 gets the one-line pointer, not a rewrite of another agent's results section.

**Application.** A separate agent applies §A's rows into `plans/M63-parts-reproduction.md` together with
these rulings. **This audit is closed**; the open work is §C's assignments, which belong to E, F, the
clause 2(b) follow-on and the probe.
