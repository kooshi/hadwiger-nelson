# Poros — M63 phase D, before the subplan is committed (2026-09-11)

*Advisory record. Poros states questions; de Bruijn owns every answer, and every construction here is
offered in the hypothetical mood. Not committed by me; the phase's engineer commits it by path. The
paper is `~/source/library/pdf/arXiv-2010.12665-parts-509-minimization.pdf`; `parts:N` is a line of
`~/source/library/notes/parts-2010.12665-layout-text.txt`, quoted beside the number. Scratch scripts and
outputs:
`/tmp/claude-1000/-home-kooshi-source-lean-dir/461b308c-55b7-48c5-b5df-641026e31b79/scratchpad/poros-phaseD/`.
Predecessor: `plans/POROS-2026-09-11-m63-phaseC.md`, whose nine cards and handover I inherit.*

## Survey

**The goal, in the principal's words (Kooshi, 2026-09-11, relayed by the product owner).** *"The goal
is to reproduce or beat Part's record. […] We can absolutely beat the record, it is just a matter of
implementation."* And: *"continue driving this loop of subagents … with the goal of the best record
5 chromatic unit graph we can get."* The record is `[Parts2020a]`'s 509 vertices / 2,442 edges,
`L(374) ∪ ρ₁₅·S(136)` sharing one centre. **The product is the smallest 5-chromatic unit-distance graph
we can certify**, his own tie-break (fewest edges) second.

**The frame on its five axes, each with where it lives.**

| axis | as phase D's acceptance holds it | address |
|---|---|---|
| object | his outer loop: an expansion rule over candidate orbits, alternating with the reduction stage, on the **L** side against a frozen S companion | `M63 §S.4` phase D; `parts:512-555` |
| question | *can a rule we register before it runs find an expansion unaided and reach `\|M\| ≤ 374`?* | `M63 §S.1` 2(b) |
| discipline | local search with a per-candidate ranking; his own vocabulary is a reserve graph and a priority | `parts:512-555`, `parts:698-722` |
| audience | this repository; the reproduction claim is judged by the frozen `Comparison` rows | `M63 §S.1` |
| product | **D produces no smaller graph.** Every D clause is reproduction — the replay controls, the rule, the assembled 509. "Beat" is entirely phase F | `M63 §S.4` phases D and F |

**The gap the survey opens on.** D's acceptance is a reproduction checklist, and the goal moved to the
record. Those are compatible only if D's instrument is also F's, and the one part of D that F needs —
the expansion step — is the part scored on a single recorded move that his own stated priorities do not
select (predecessor's M3). Underneath that sits an assumption nobody has tested: **that the candidate
menu is too large to try.** It is his assumption, from a cost regime where one reduction took *"several
tens of hours"* (parts:848). Ours take **ten minutes** (M63 §S.2 #11). §Measurements P1 closes the menu
at **55 single-orbit candidates over his base — 49 on the L side, 6 on the S side, and none outside his
disk** — and 55 reductions is a day of compute. That reframes both of the questions the product owner
put to me: what a rule is scored on (a 55-point outcome map, not one bit), and whether the loop is the
route (its rule is load-bearing only at depth ≥ 2). P1 also finds the second half of the record
untouched: **the S half of the 509 is Heule's, reduced once and never expanded, by him or by us.**

## Evidence inventory

*Expectation written before each reading; one item per line, as the gate reads them.*

- `plans/POROS-2026-09-11-m63-phaseC.md`, whole (430 lines) — read against: nine cards with their fates and an open list — surprised: yes; the handover's item (i), the joint run over `A412 ∪ ρ·g(A166)`, is the only open item that can end the milestone with the goal met, and it is still outstanding, so phase D is being planned against an unknown verdict
- `plans/M63-parts-reproduction.md` §S.1–S.4 (310 lines) — read against: phase D's acceptance as a checklist — surprised: yes; **not one D clause produces a graph smaller than 509**. D reproduces (replay controls, the rule, our own `L374 ∪ ρS136` at 509); every beat experiment is phase F, behind 3–5 engineer-days of reproduction discipline
- `plans/M63-parts-reproduction.md` §4 phases D–E, §5 (65 lines) — read against: his four-state path and the registered predictions — surprised: no; states 3–4 are one working graph at two rungs, as the predecessor established
- `[Parts2020a]` extraction, §§5.5–5.11, §6, §7 (parts:480-884) — read against: the expansion step as an algorithm — surprised: yes, twice. (i) **The S half never entered his loop**: §6 *"Reduction of S-subgraphs is briefly discussed in 5.10. Here we hardly improved the result of Heule at all; only two edges were removed"* (parts:811-812), and §5.10 records the whole S route as rough reduction — 187 vertices → several 169-vertex graphs chosen by numerical indicators → **one** reduction at output symmetry 1 (parts:716-722) — while his four-state expansion narrative is entirely L (parts:798-810). (ii) His disk clause is *testable*: *"choosing orbits that fall completely or partially on a disk of radius r = 2 (expanding the base graph and increasing the radius of the disk did not lead to new results in our case)"* (parts:527-530)
- `tools/parts_repro.py:141` `orbits_meeting_disk`, and a grep for its callers — read against: someone has computed what lies outside his disk — surprised: yes; the function exists, its own docstring names the comparison to make (*"Compare against a truncation to see whether … they need not"*), and **it has never been called** — the only mentions are its definition and one line of `M63 §6`
- `tools/parts_reduce.py:317-351, 448-511` `reduce_stage` — read against: a minimum-only mode for a cheap sweep — surprised: no; `max_minima` truncates and the record is labelled CAPPED with an `A_note`, which is the predecessor's card 9 already implemented
- `plans/M63-phaseC-joint-stage.md` §3, §4, §A, §H, §L (≈ 200 lines) — read against: what is running now and what D inherits — surprised: no; C4a is the long pole and C4b follows it, so D is planned while the joint verdict is unknown. §L's lesson is carried: **audit the source, not the plan**
- `plans/FRONTIER-STUBS.md`, whole (86 lines) — read against: a ranked route to a smaller graph that is not this loop — surprised: yes; there is none. FS-30 (412 unconsumed rotation classes) and phase G are the only other routes to a smaller type-M object and both sit after M63; every other ranked stub is aimed at χ ≥ 6, not at the record
- `plans/STUB-expansion-measure.md` (FS-35), whole — read against: the look-ahead re-aim and its half-hour precondition — surprised: no
- `data/m62/m64-phaseD-layers.json` — read against: FS-35 §1(3)'s claim that `Y`'s degree-1 and degree-2 layers are *"stored per run"* — surprised: yes; the file holds nine profile rows and a `smallest_layer_that_excludes`, not a layer census. The layers may be inside the 9.5 MB reduction record; **unchecked here**
- my probe `scratchpad/poros-phaseD/out.txt` (§Measurements P1) — read against: material outside his disk that passes his own reserve rule — surprised: yes, in the negative direction and then in a better one: **zero** outside orbits reach his threshold on any accumulator, and the live menu is 49 / 49 / 6
- the phase D planner's opening message, 2026-09-11 (`a2a15ba6914ca0d30`) — read against: three questions with candidate answers — surprised: yes; its own preferred scoring surface (b), *"rank correlation against outcome over MANY candidate expansions"*, **presupposes the outcome map card 1 proposes to build** — as do its (a) and (c). All three are consumers of ground truth, not alternatives to it

## Hunch ledger

*Inherited hunches are marked; new ones registered before card 1 was written.*

hunch: the-disk-radius-negative-is-structural
  claim: his §5.6 negative — *"increasing the radius of the disk did not lead to new results"* — is not a
    report of a search that failed but a property of his base: because the order-24 group does not
    preserve a Euclidean disk, *"orbits meeting the disk of radius 2"* already sweeps in every Galois
    partner out to radius ≈ 2.55, so what a larger disk adds is far out and touches nothing. P1: of the
    46 orbits of `Base(2.6)` outside his `r = 2` disk, **none** has an absent vertex of unit-degree ≥ 4
    into `A403`, `A412` or `A166`; the best reaches 3 of 4
  basis: measured
  falsifier: an orbit outside `r = 2` with an absent vertex of unit-degree ≥ 4 into any accumulator on
    the record's path
  registered: 2026-09-11
  status: open — the measurement is mine and must be re-derived; the mechanism above is a construction,
    and a measured hunch is confirmed only by derivation or replication

hunch: the-single-orbit-menu-is-enumerable
  claim: one reduction of `A412` plus one reserve orbit (gap 38 → 50) closes in under 90 minutes on one
    core, so the 55-candidate single-orbit sweep is 8–70 core-hours; extrapolated from the two stored
    records, where the most expensive reduction ever run here is the L451 stage at gap 76 in 605 s and
    S166 is gap 30 in 587 s (M63 §S.2 #11)
  basis: analogy
  falsifier: the `A412 + (8,0,0,4)` reduction exceeds three hours or does not close
  registered: 2026-09-11
  status: open

hunch: the-S-half-is-the-untouched-half
  claim: `S136` is at the floor of the material it was searched over and not at the floor of the
    problem: it is Heule's own S (M63:468-471, *"Heule's S136 is one of Parts's eight minimal
    S-graphs"*), it was reduced once from a rough-reduction accumulator, and its six-orbit expansion
    menu has never been tried by anyone — and P1 measures that menu at exactly six orbits
  basis: read
  falsifier: a published or recorded S-side expansion iteration; or all six single-orbit expansions
    returning `|M| = 136` with `A166`'s own level set unchanged
  registered: 2026-09-11
  status: open

hunch: the-joint-minimum-on-his-accumulators-is-509  *(inherited, predecessor's ledger)*
  claim: over `L ⊆ A412` and `S ⊆ A166` in the record's frame, both sides deletable, the minimum
    refusing union has exactly 509 vertices; about 35% on fewer
  basis: prior
  falsifier: a joint refusing selection of 508 or fewer vertices
  registered: 2026-09-11
  status: open — phase C's C4a decides it

hunch: 509-is-still-the-record  *(inherited, predecessor's ledger)*
  claim: no 5-chromatic unit-distance graph with fewer than 509 vertices has been published or posted as
    of 2026-09-11 (recalled, not read)
  basis: prior
  falsifier: a paper, preprint or Polymath16 post with a smaller certified graph
  registered: 2026-09-11
  status: open — addressed to the phase's prior-art gate; `[Haugland2026]` (arXiv:2608.04542) is held and
    unread here

## Cards

*Five written, and the gate's "three is a menu, more is a spray" warning is answered rather than
ignored: they are not one menu put to one mind, and only two are live with any one addressee at a time.
Cards 1–3 went to the **phase D planner** (`a2a15ba6914ca0d30`) — card 1 in full as the turn, cards 2
and 3 by pointer — and card 3 was answered in the same exchange (it adopted the stricter form, that a
capped level halts the loop). Card 4 went to the **S-expansion engineer** (`aa10420df4950eda9`), a
different addressee with a different job, and is the admission-threshold question it was told to bring
to me; card 2 was pulled forward by the product owner and is that engineer's whole assignment, run in
its nine-candidate form. Card 5 went to the planner on its own, after the product owner made the
49-candidate L sweep phase D's first implementation item — it is here because one of its branches is a
one-way door; it was adopted in both halves. Card 6 went to both engineers at once, because it asks one
run of each. Fates are the phases' to write beside each card; the planner reports cards 1, 2, 3, 5, the
three §§5.5–5.11 items and both corrections as having fates in its own §P.*

question: is-the-depth-one-expansion-menu-enumerable-at-our-speed
  evidence: P1 (mine, 90 s, one core, re-derivable): `Base(2.6)` has 229 orbits, 183 meeting his `r = 2`
    disk and 46 outside; **control — every vertex of `v403e2112`, `v412e2106`, `v451e2400`, `v166e774`,
    `v374e1860`, `v136e564` lies in an orbit meeting `r = 2`**, so the cut is real. His reserve rule
    (parts:517-521, an absent vertex of unit-degree ≥ 4 into `A`) admits **49 orbits at `A403`, 49 at
    `A412`, 6 at `A166`, and zero outside `r = 2` on any of the three** (best outside degree 3). So the
    single-orbit menu over his base is closed at 55. Costs: L451 (gap 76) 605 s, S166 (gap 30) 587 s,
    `A412` forecast 20–90 min (§S.2 #11, P8); his own were *"several tens of hours"* (parts:848). Every
    candidate rule on the table — his §5.6 priority, his reserve degree order, his §5.10 indicators, the
    predecessor's necessary-atom count — scores **orbits**, which is exactly what a per-orbit outcome
    map labels.
  expected: D ranks candidates because the menu is too large to try, as his §5.6 assumes
  ask: at our reduction speed, is the 55-candidate single-orbit menu cheap enough to run outright, so D
    computes the outcome map instead of ranking against his one recorded move?
  if yes: the map is the scoring surface — 55 labelled outcomes (new `|M|`, new `|{M}|`, atoms freed)
    against which all four candidate rules are scored by rank correlation; the 6 S candidates and the 49
    at `A412` are beat attempts past his recorded path and touch no reproduction claim, while the `A403`
    map is computed **after** the frozen rule has had its attempt, turning the owner's one-bit rank
    diagnostic into a full ranking evaluation with no contamination
  if no: the enlarged gap explodes the level, the rule is genuinely load-bearing, and D should say
    plainly that its rule is scored on one bit plus phase E's held-out run — with the S block of six
    still affordable alone and still the cheapest beat attempt
  answered by: run — one expanded reduction, `A412` plus its top reserve orbit `(8,0,0,4)` (12 absent,
    gap 38 → 50), timed in CPU seconds with the machine and concurrent load named; it is also the first
    beat attempt, since a 373 ends the milestone
  cost: one reduction, 10–90 minutes, one core
  hunch: it closes under 90 minutes (ledger: the-single-orbit-menu-is-enumerable)
  falsifier: that reduction exceeding three hours or not closing
  rank: 1

question: has-anyone-ever-expanded-the-S-half
  evidence: the record is `L374 ∪ ρS136` sharing the centre, and Heule-510 is `L375 ∪ ρS136` (his Table
    2 lists Heule's L at 375, 382, 393 for 510, 517, 529) — so **the entire 510 → 509 gain is one vertex
    on the L side**. His §6: *"Here we hardly improved the result of Heule at all; only two edges were
    removed"* (parts:811-812; `566 − 564 = 2`, M63:428-433), and M63 §1(iv) found **Heule's own S136 is
    one of his eight minimal S-graphs**. His §5.10 gives the S route as rough reduction, 187 → 169 by
    numerical indicators → one reduction (parts:716-722); his expansion narrative is entirely L
    (parts:798-810). P1: `A166`'s reserve menu is **six orbits**, topped by `(0,0,6,6)` at degree 8 with
    all 12 absent — the same orbit his L move added. M63 §S.4 gives the S side one loop run, as phase
    E's *mechanism control*, and no beat attempt anywhere.
  expected: the record's two halves have had comparable search effort
  ask: is the S half's 136 a floor of the problem, or the floor of the only material anyone ever searched
    over?
  if untouched: the six-candidate S sweep is the cheapest beat attempt in this milestone — one vertex
    anywhere beats 509 — and it needs no expansion rule at all, so it runs while the L loop is built
  if a floor: the reason goes in writing — that the S minimum is pinned by the frozen L and the 18
    connection edges — and the L side carries the whole beat, which re-ranks phase F
  answered by: run — the six single-orbit expansions of `A166` against the frozen `L374`, each reduced to
    a closed optimum
  cost: six reductions at the S166 scale (587 s measured), about an hour on one core
  hunch: at least one of the six changes `{M}` at 136; I would not bet past 50% on any reaching 135
  falsifier: all six returning `|M| = 136` with `A166`'s level set unchanged
  rank: 2

question: may-a-capped-iteration-propose-or-only-report
  evidence: the planner intends a truncated level to make that iteration's `A` a sample and propagate the
    verdict (its Q3, 2026-09-11), extending the predecessor's card 9 from C4a to every iteration. But the
    loop reads `A` twice, not once: the reserve is *"a base orbit is included in `R` if, when added to
    the graph `A`, the degree of some of its vertices is at least 4"* (parts:517-521), and the stopping
    rule is *"`A` stopped changing"* (M63 §O(3)). For `A' ⊆ A` the reserve is **not monotone in either
    direction**: a vertex absent from both loses degree, so candidates drop out; and a vertex of `A ∖ A'`
    becomes absent and may enter with degree ≥ 4, so candidates appear that the true `A` never offered.
    P1 measures the live menus at 49 and 6, so one spurious or missing orbit is 2–17% of the menu.
  expected: labelling the artifact suffices, as it did for C4a where the capped union was only reported
  ask: may a capped iteration propose an expansion and declare a stall, or may it only report?
  if only report: a capped iteration must re-run uncapped before it proposes, and `stalled` is never a
    verdict of a capped run — the cap becomes a budget event, not a state transition
  if it may propose: the plan states in writing that the menu it proposes from is neither a subset nor a
    superset of the true one, and every stall verdict carries the cap that produced it
  answered by: derivation — the two-line non-monotonicity above, re-derived by the engineer
  cost: minutes
  hunch: only report — the stall verdict is a completeness claim and a capped level has no completeness
  falsifier: a proof that `reserve(A') ⊆ reserve(A)` whenever `A' ⊆ A`, which would make the cap sound in
    one direction and a propagating label sufficient
  rank: 3

## Measurements

*Script `scratchpad/poros-phaseD/outside_disk.py`, output `out.txt`. It imports
`tools/parts_repro.Base`, `tools/parts_repro.orbits_meeting_disk`, `tools/typem.unit_edges_fast` and
`tools/parts_vtx.load_lattice`, and writes only to stdout. One core, `nice`, 90 s, on the shared
desktop while phase C's reduction was running.*

### P1 — what lies outside his `r = 2` disk, and what his own reserve rule admits

`Base(2.6)`: 4,513 points, **229 orbits**, sizes `{1:1, 6:14, 12:59, 24:155}`; **38,730 exact unit
edges** (independently matching the predecessor's M3, which is the cross-check that the base is the
same object). `orbits_meeting_disk(base, 2.0)` returns **183**; **46 orbits lie outside**, sizes
`{6:3, 12:20, 24:23}`.

**Control — his own files against the cut.** Every vertex of `v403e2112` (35 orbits), `v412e2106` (37),
`v451e2400` (38), `v166e774` (14), `v374e1860` (37) and `v136e564` (14) lies in an orbit meeting
`r = 2`: **0 outside, on all six**. So his clause is read correctly and the cut is meaningful.

**His reserve rule** (parts:517-521), read as *an absent vertex of the orbit with ≥ 4 unit neighbours
already in `A`*:

| accumulator | reserve-eligible orbits | of them outside `r = 2` | best degree from an outside orbit |
|---|---|---|---|
| `v403e2112` (L, 375 state) | **49** | **0** | 3, at `(18,0,0,6)` |
| `v412e2106` (L, 374 state) | **49** | **0** | 3, at `(18,0,0,6)` |
| `v166e774` (S) | **6** | **0** | 3, at `(0,4,8,0)` |

His own *"about 40 are included in R"* (parts:534) sits just under our 49, on a larger disk — consistent.

**The L menu's head, at `A412`** (rank, max degree, absent/size, label): 1 `(8,0,0,4)` 10, 12/12;
2 `(6,2,4,0)` 9, 12/24; 3 `(12,2,6,0)` 8, 24/24; 4 `(12,2,2,0)` 8, 12/24; 5 `(4,0,4,4)` 7, 24/24;
6 `(10,0,8,2)` 7, 24/24. **The S menu, complete**: `(0,0,6,6)` 8, 12/12; `(12,2,2,0)` 6, 18/24;
`(12,0,0,0)` 6, 6/6; `(12,0,2,6)` 4, 24/24; `(12,2,6,0)` 4, 24/24; `(0,0,8,0)` 4, 3/6.

**Readings.** (i) The radius half of M63 §S.4 phase F(g) — *"his own negative on the disk radius … cheap
to re-test"* — is answered without a solver and in the negative: there is nothing out there to test with,
because the order-24 group is not disk-preserving and his `r = 2` clause already admits every Galois
partner out to radius ≈ 2.55. **The base-graph half of F(g) (`⊕ⁿHᵐ` variants) is untouched by this and
remains open.** (ii) The single-orbit expansion menu over his base is therefore **closed at 55**, and
that is a measured fact rather than an assumption — which is what makes cards 1 and 2 askable.

### P2 — the exchange-class identity, derived (no compute)

The phase D planner measured `Σ_orbits (lo + hi) = 2|M|` on three of his four published `{M}` columns
(750/750, 748/748, 748/748) and a **deficit** of 3 on the 376 column (749 against 752), and asked
whether *pair classes ⟹ identity, not conversely* is the right implication. It is, and the shape of the
failure is informative:

- a **2-element** exchange class summing to `c` with both extremes realized gives
  `lo₁+hi₁+lo₂+hi₂ = (lo₁ + c − lo₂) + (lo₂ + c − lo₁) = 2c`; a stable orbit gives `2f`. So every
  varying orbit in a realized pair class ⟹ the identity;
- a **3-element** class summing to `c` gives `Σ(lo+hi) = 3c − Σlo`, an **excess** of `c − Σlo ≥ 0`,
  never a deficit;
- so a **deficit** can only come from an **unrealized corner** — the range box is not tight, which is
  generic for a projected polytope — or from a typo.

**Therefore the identity is not a transcription control**: a correct table violates it structurally, so
a mismatch does not localize to a typo. Free registered prediction, since D replays 376 at the order-3
rung on its own acceptance list: our 376 level either reproduces the deficit 3 (structure, and the
pair-class story needs a third class there) or reaches 752 (his column carries a typo). The pair class
is visible in his printed table: `(2,0,6,4)` 0–4 and `(10,0,2,4)` 8–12 give `4 + 20 = 24 = 2 × 12`.

### P3 — edge removal cannot free a vertex (no compute)

`[deGreyParts2023]` footnote 2 (the planner's prior-art find, 2026-09-11) reports 36 discardable edges
in the 509, so `e₅ ≤ 2,406` is published and M63 §S.1 #4's secondary bar of "fewer than 2,442 edges" is
already beaten in print. It cannot cost the vertex claim: if `G − v` is 4-colourable then so is
`(G − e) − v ⊆ G − v`, so **no edge removal can make a vertex removable**, and phase C's C4.1
positive control (every vertex of the record critical) is untouched by any edge sweep. And because he
states he did not exhaust, an exhaustive edge-critical sweep of our own 509 yields the exact edge
minimum of that graph — a number nobody holds.

### P4 — the degree shoulder below his threshold, and how adjacency-poor the S half is

*Script `scratchpad/poros-phaseD/degree_shoulder.py`, 90 s, one core, `nice`, stdout only. Asked for by
the S-expansion engineer (`aa10420df4950eda9`, its Q2): how robust is the six-orbit menu to the exact
value of his threshold?*

Maximum absent-vertex degree per orbit, over every orbit of `Base(2.6)` with an absent vertex:

| accumulator | orbits with an absent vertex | ≥ 4 | = 3 | = 2 | = 1 | = 0 |
|---|---|---|---|---|---|---|
| `v166e774` (S) | 217 | **6** | **3** | 14 | 55 | **139** |
| `v403e2112` (L) | 210 | 49 | 29 | 24 | 58 | 50 |
| `v412e2106` (L) | 209 | 49 | 23 | 33 | 56 | 48 |

The three S orbits at degree exactly 3: `(6,4,6,0)` 24/24, radii 1.6589 / 2.5654; `(0,2,10,0)` 12/12,
1.7321 / 1.7321; and **`(0,4,8,0)` 12/12, radii both exactly √5 = 2.2361 — outside his `r = 2` disk**.

**Readings.** (i) Lowering his threshold from 4 to 3 takes the S menu from six to **nine**, and to 2
would take it to 23 — so nine is the natural stopping point and nine runs make the sweep independent of
the threshold's exact value. (ii) `(0,4,8,0)` is the best candidate anywhere outside his disk on either
half (it is P1's "best outside degree is 3" for the S side), so the nine-run form is **also the first
reduction anyone has run against material his own base excluded**. (iii) **The S half is
adjacency-poor:** 139 of 217 orbits touch `A166` at degree zero, against 48 of 209 for `A412`; its whole
base neighbourhood is about nine orbits where the L half's is 72 at degree ≥ 3. So a clean nine-way
negative would very nearly *close* the single-orbit question for the S half rather than sample it —
which raises the value of reporting the inert candidates in full, and is why I am holding E1 at 20%
rather than raising it: the reason nobody expanded the S half may be that there is almost nothing to
expand it with.

hunch: the-S-half-is-adjacency-poor
  claim: the S accumulator's entire base neighbourhood is about nine orbits (6 at degree ≥ 4, 3 at
    exactly 3, and 139 of 217 orbits at degree 0), against 72 at degree ≥ 3 for `A412`, so a
    single-orbit negative on the S side is close to a complete answer rather than a sample
  basis: measured
  falsifier: an orbit at degree ≥ 4 into `A166` that P1 and P4 both missed, or a cross-degree union
    materially exceeding nine
  registered: 2026-09-11
  status: open

**A correction accepted from the S engineer, 2026-09-11.** My card 2 said *"one vertex anywhere beats
509"*. True of the count, false of the claim: the object is `L374 ∪ ρ·S135` sharing the centre and it is
a record when the geometry is exact and a refutation exists, not when a counter reads 508. Its wording,
not mine, is the one to keep.

### P5 — three readings of his reserve rule (expectations registered before the run)

*The S-expansion engineer's re-derivation disagrees with my P1 about the **rule**, not the geometry: its
provenance control reproduces 4,513 points, 229 orbits, 38,730 unit edges and my six under the strict
reading. Its literal reading of parts:517-521 — "when added to the graph `A`, the degree of some of its
vertices is at least 4" — counts the added orbit's **own internal edges** and, on the S side, the ρ₁₅
**cross edges** to the frozen companion, and gives 12 rather than 6. The product owner asks which
reading I hold, and warns that if the same undercount applies to the L side then card 1's 49 is wrong
and phase D's main sweep is mis-sized. Three nested readings: (a) strict, mine; (b) literal-internal;
(c) literal plus cross.*

**The position I hold, written before the numbers.** The question is not grammar — the engineer's
grammar is better than mine — but whether a reading is a **filter**. An orbit with no edge at all into
`A` is a disconnected piece, and a disconnected piece of at most 24 base points cannot change whether
`A ∪ C` refuses four colours. So a reading that admits orbits with zero attachment to `A` is not his
rule, whatever the sentence reads like. I therefore hold **(a) as the likelier intent and (c) as the
right thing to sweep**, and the engineer's union is the correct operational choice regardless.

| # | registered expectation | what kills it |
|---|---|---|
| E8 | the counts are nested and (b) admits substantially more than (a) on both halves | (b) equalling (a) |
| E9 | **the tie-breaker:** at least 10 of the orbits (b) adds on the L side have **zero** edges into `A`, which is the evidence that (b) is not a filter | (b) adding few or no detached orbits, which would make the literal reading defensible and my (a) the wrong one |
| E10 | the closed-list claim survives under (a) and (c) and **fails** under (b) — a far, fully absent orbit has internal unit edges of its own. Under (c) cross edges reach only radius ≤ `8/√15 ≈ 2.0656` while every outside orbit has small radius > 2, so (c) adds at most a trickle outside the disk | outside-disk orbits admitted under (c) in numbers |
| E11 | the cross-edge control returns **18** between `v374e1860` and `v136e564` in one of the two conventions | any other count, which voids my cross-degree numbers and not the engineer's |
| E12 | the S menu under (c) is **12**, reproducing the engineer's count | a third number, which means one of us has a bug in the rule and not in the points |

hunch: the-literal-reading-is-not-a-filter
  claim: reading his admission degree in `A ∪ O` rather than into `A` admits base orbits that touch `A`
    nowhere, and such an orbit cannot change whether `A ∪ C` refuses four colours, so the literal
    reading cannot be the rule that produced his *"about 40 are included in R"*
  basis: derived
  falsifier: the literal reading admitting few or no orbits detached from `A`
  registered: 2026-09-11
  status: killed (by: P5 — the literal reading admits **zero** orbits with no edge into `A`, on all
    three accumulators, so every orbit it adds already attaches and my functional objection has no
    bite; the readings differ only on orbits whose attaching vertex reaches 4 with help from its own
    orbit-mates, which is a good filter. The engineer's reading stands and mine loses its argument.
    What the miss cost: nothing run on it — the position was registered and tested in the same hour,
    and its operational conclusion, sweep the union, was already the engineer's)

**P5's results, scored against the expectations above.**

| accumulator | (a) strict, mine | (b) literal-internal | (c) literal + cross | outside `r = 2`, any reading | detached under (b) |
|---|---|---|---|---|---|
| `v166e774` (S) | 6 | 11 | 12 | **0** | **0** |
| `v403e2112` (L) | 49 | 59 | 59 | **0** | **0** |
| `v412e2106` (L) | **49** | **57** | 57 | **0** | **0** |

- **E8 met**, but modestly: the L menu rises 49 → 57 at `A412`, not a doubling. **Card 1's menu is
  therefore 69, not 55** (57 + 12), or about 71 carrying the degree-3 shoulder — +25%, so the
  exhaustive form still prices at roughly 12–105 core-hours and card 1's argument stands. Size phase
  D's sweep at 57.
- **E9 killed**, and it was my tie-breaker; see the hunch above.
- **E10 met, and more strongly than registered.** I predicted the closed list would *fail* under (b).
  It does not: zero outside-disk orbits are admitted under any reading, on any accumulator. The disk
  finding is robust to the rule, which is what the product owner asked to have re-tested.
- **E11 FAILED, and it is mine — then it was explained, and no count moved.** The control (the
  cross-edge machinery must return **18** between `v374e1860` and `v136e564`) returned **54**. The S
  engineer found the cause the same hour (`scratchpad/probe-S/crosscheck.py`, its plan §6 c1b): the
  stage itself carries **30** cross edges, 12 incident to the shared centre and **18 not** — the
  record's 18 exactly — while a whole-base relation emits **both orientations** of a centre edge and
  additionally attributes centre edges to a **phantom S-side centre** (the halves share the centre and
  it is L-side only). So `54 = 18 real + 36 centre-bookkeeping` against the stage's `30 = 18 + 12`, the
  non-centre counts agree exactly, and **neither instrument has a geometry fault**.
  **No re-run is needed, by a squeeze:** `(b)` counts no cross edges so `(b) ≤ (c)`; the correction only
  *removes* cross edges so `corrected-(c) ≤ raw-(c)`; on the L side `raw-(c) = (b)` already (cross-degree
  promoted nothing), so `(b) ≤ corrected-(c) ≤ raw-(c) = (b)` and **59 and 57 are exact**. The same
  squeeze gives the S side 12: its single promotion, `(10,0,0,2)`, rests on a real edge — the engineer
  verified each member at degree 1 into `A166`, 3 with its orbit-mates, plus one genuine cross edge to
  the shared centre (both radii exactly 1, so the orbit sits on that circle), and `3 + 1 ≥ 4` however
  the edge is counted. **My "the menu may be 11" is withdrawn.** The standing caveat narrows rather than
  disappears: column (c) is sound wherever the shared centre is not involved, the centre is the only
  place it inflates, and the one candidate where it mattered survives.
- **E12 met** (12), with E11's caveat attached to it.

**The run list as it now stands:** twelve under the union of readings, plus the two degree-3 orbits the
literal reading does not already promote — `(0,2,10,0)` and `(0,4,8,0)`; `(6,4,6,0)` from the shoulder
is inside the twelve. **Fourteen candidates**, exactly one of them (`(0,4,8,0)`, radius √5) outside his
search disk.

### P3b — the cross-edge control, reconciled; and a free control for the edge sweep

**The reconciliation, from both engineers and checked here.** The record's stage carries **30** cross
edges, 12 incident to the shared centre and **18** not — his published 18. His own decomposition counts
the centre on the S side (`1860 + 564 + 12 + 6`), the stage counts it on the L side
(`1860 + 552 + 30`), and `564 − 552 = 12` is exactly the centre-to-S edges: **same object, two
conventions, both right**. My 54 is neither, and its excess is entirely centre-attribution in a
whole-base relation (the centre lies on no ray, so a separate clause appends both orientations, and a
whole-base filter also credits a phantom S-side centre). **The committed law is sound** — 126 on the
base, 18 off-centre on the record, confirmed independently by the phase D planner, the S engineer and
the product owner — so the fault is in my caller alone and, by E11's squeeze, no count in use depends
on it.

**The control is repaired and now fires green** (re-run on the product owner's own call, 90 s, one
core):

```
stage: 509 vertices, 2442 edges
cross total 30;  touching the shared centre 12;  NOT touching it 18
CONTROL GREEN -- expected 509/2442, cross 30, off-centre 18
```

**The mechanism of my own error, stated so it does not recur.** I intersected `L374` and `S136` as sets
of *base* indices — one index space shared by both halves, in which a lattice tuple belonging to both
halves is the same index wearing two roles — instead of the stage's doubled space, where L occupies
`0..n`, S occupies `n..2n` and the S-side centre is forbidden outright (`parts_stage.py:38, 90`). A
cross edge is then a pair straddling `stage.A.n`, and the count is unambiguous. The general form of the
mistake, worth carrying: **a relation computed on the base is not the same object as the stage's
induced edge list, and only the latter knows which side a shared point is on.** `parts_stage.py:248`
says the same thing from the other end — *"his S-subgraph counts it — `v136e564` is 135 S points plus
the shared centre"*. Take edges from the stage, never from the base relation.

So **column (c) is repaired rather than void**, and its values stand as measured: 12 on the S side, 59
and 57 on the L side — the last two also pinned independently by E11's squeeze.

**A free control for the edge sweep** (the planner's domain pass collapsed the edge sweep into the same
`Stage` with edges as atoms, giving the *exact* edge minimum of the 509 rather than a greedy 1-minimal
set — the quantity `[deGreyParts2023]` says nobody computed). Let `G` be the record, vertex-critical by
C4.1, so `G − v` is 4-colourable for every `v`. Let `H ⊆ G` be any refusing edge-subgraph on the same
vertices. Then `H − v ⊆ G − v` is 4-colourable, so a vertex of degree ≤ 3 in `H` could be coloured last
and `H` would be 4-colourable. Therefore:

> **every vertex of every refusing edge-subgraph of the 509 has degree ≥ 4**

— an assertion that costs milliseconds per candidate and fires on exactly the failure an edge sweep is
prone to, and a floor of `509 × 4 / 2 = **1018**` edges. Far from the published `≤ 2406`, so it closes
nothing, but it is a stated lower bound where none existed and a sweep reporting below it has failed.
Scope note for the write-up: the minimum is over a *fixed* vertex set and the object stays a genuine
unit-distance graph, because such a graph requires every edge to be a unit pair and never that every
unit pair be an edge — the convention `[deGreyParts2023]`'s footnote is already using.

### P6 — the excluded orbits by radius, and why √5 is not the nearest shell

*The phase D planner re-derived my census independently and confirmed every number, and added one I did
not have: the L side's best excluded orbit `(18,0,0,6)` also sits at exactly √5, matching the S side's
`(0,4,8,0)`. Two halves, same radius, same degree 3, one short of his threshold. Before treating that as
a coincidence worth a card, the obvious deflation had to be tested — that √5 is simply the first orbit
radius past his cut. It is not. (`Base(2.6)` only, no unit edges, ~15 s, one core.)*

The 46 excluded orbits begin at `r_small = 2.00708`, and **thirteen sit closer to his boundary than
√5 = 2.23607**: `(-17,-1,-5,5)` and `(22,0,2,4)` at 2.00708, `(24,0,2,2)` 2.01736, `(24,0,6,2)`
2.02438, `(2,0,14,0)` and `(14,0,0,6)` at 2.02759, `(8,2,14,0)` 2.04154, `(6,0,14,0)` and
`(-7,-1,-1,7)` at 2.08167, `(4,2,14,0)` 2.11491, `(-19,-1,-3,5)` and `(-11,-1,-1,7)` at 2.12466,
`(20,0,2,6)` 2.15724, `(-13,-1,-3,7)` 2.16681.

**Reading.** The orbits nearest his cut score *below* 3 while the best excluded scorer on each half sits
further out — so **degree into the accumulator is not monotone in radius**. "Increase the radius of the
disk" was never the right knob: the useful quantity is degree, the geometry does not order it by
distance, and his published negative is therefore a fact about his **filter**, not about his disk. That
closes M63 §S.4 phase F(g)'s radius half for a reason rather than for a measurement. (Incidentally, only
about seven of the 46 lie within the ρ₁₅ cross-edge bound `8/√15 ≈ 2.0656`, so cross-degree could never
have rescued the rest.)

question: should-the-two-sqrt5-orbits-be-in-the-sweeps
  evidence: P6 above, with the planner's independent re-derivation of both orbits. `(18,0,0,6)` into
    `A403`/`A412` and `(0,4,8,0)` into `A166` are the only excluded material on either half coming
    within one of his own threshold — both at exactly √5, both at degree 3 — while thirteen orbits
    closer to his cut score lower.
  expected: the nearest excluded shell is where excluded material would qualify, if anywhere
  ask: do the two √5 orbits enter their sweeps despite scoring 3, as the only excluded material within
    one of his threshold?
  if yes: one run each out of 57 and 14, and the pair is the first reduction ever run against material
    his own base excluded — on both halves, at the same radius
  if no: the closed-list finding is reported as measured-but-never-tested, and F(g)'s radius half stays
    a claim about a filter rather than about the material
  answered by: Planner (de Bruijn, phase D) and the S-expansion engineer
  cost: two runs
  hunch: both inert — the value is the closure, not the find
  falsifier: either √5 orbit lowering `|M|` or growing `{M}`
  rank: 6

---

## Second consult — the planner's five decisions, 2026-09-11

*Its message arrived while card 1 was being written; my answers went back in the same message that
carried the card. Fates are the phase's to record.*

| its decision | my position |
|---|---|
| 1. the C4 branch changes the starting record, not the instrument (a CLI flag) | agreed, nothing to add |
| 2. score the rule **by outcome against ablation controls at equal ask budget** (uniform random, his degree order, his §5.10 indicators) | not circular, but **unpowered**, and the map is the cheaper way to run it — card 1 and the ledger entry below |
| 3. a capped level **halts** the loop (`level-truncated`), stricter than my card 3 | adopt; it does not bite F, because the escape from a level that will not exhaust is **a rung, not a sample** — a rung-`H` level is complete at that rung and smaller, every rung's minimum is free from `Y` (M64 §R10), and his own path walks 24 → 6 → 3 → 2 → 1 |
| 4. the necessary-atom rule must be defined on the complete level, not the harvested degree-1 layer (336 vs 312 on L451) | accepted, and it corrects my predecessor and me: the *atoms-freed* column of the outcome map is a consequence of D's replay, not a free check. The word "free" is withdrawn |
| 5. FS-35's retirement precondition does not fire; the prior-art find on `e₅ ≤ 2,406` | agreed; see P2 and P3 |
| 6. the expensive ask regime is the companion-free one, so D's L loop stays cheap | half right, and the **proxy is the problem**: L451 has gap 76 at 0.02 s refusing while the joint stage has gap **68** at 4.18 s, so neither the companion nor the gap explains 200×. M62 §R22's measured law is slack over the nearest refutation, and both are proxies for it. The fix is already on D's list — the `A412` rung-1 replay measures the regime before the loop is built |

hunch: the-ablation-is-unpowered-without-the-map
  claim: the four-arm ablation at equal ask budget cannot discriminate any ranking from uniform random
    unless the density of successful candidates among the 49 lies in a middle band, and that density is
    unmeasured; given the outcome map, uniform random's expected score at budget `k` is a hypergeometric
    read-off and every per-orbit ranking's score is its top-`k`, so the map **is** the ablation, once,
    for every ranking including ones invented later
  basis: derived
  falsifier: an ablation design whose discriminating power does not depend on the base rate of
    successful candidates — or a measured base rate in the middle band obtained more cheaply than the map
  registered: 2026-09-11
  status: open

hunch: the-filter-is-the-rule
  claim: the largest part of his expansion rule's content is the **reserve filter** (P1: 229 orbits →
    49), not the ranking within it; since all four of the planner's arms are drawn from the filtered
    set, a tie across them would read as "our ranking does nothing" when the truth is "the filter does
    everything"
  basis: derived
  falsifier: a fifth arm — uniform over all partially-absent orbits with no degree-≥ 4 gate — scoring as
    well as the filtered arms at equal budget
  registered: 2026-09-11
  status: open

hunch: the-last-iterations-are-the-expensive-ones
  claim: on a frozen-companion L stage, refusing asks at the 374 level cost materially more than at the
    375 level, because the instance is tightest near the global optimum — which is where his own ~10 s
    M-type asks (parts:846) were measured, and where D's loop spends its longest runs; this is M62
    §R22's slack law applied to the loop's endgame
  basis: derived
  falsifier: the `A412` rung-1 replay's refusing asks measuring at the L451 stage's 0.02 s
  registered: 2026-09-11
  status: open

---

## Expectations registered before the S-menu probe reports

*Card 2 was pulled forward by the product owner on 2026-09-11 and given to a scoped agent
(`aa10420df4950eda9`) as its whole job: the six single-orbit expansions of `A166` against the frozen
`L374`. Written before any of its numbers landed, and sent to it in the same form. It re-derives my
menu rather than taking it, which is the arrangement.*

**The control comes first.** Its recount must return **six** eligible orbits at `A166` with my labels
and degrees — `(0,0,6,6)` 8, `(12,2,2,0)` 6, `(12,0,0,0)` 6, `(12,0,2,6)` 4, `(12,2,6,0)` 4,
`(0,0,8,0)` 4 — and 49 at `A412`. A different count means P1 is wrong and every card resting on it
re-opens before a solver is started.

**Two monotonicity facts, derivations rather than predictions, which fix what the outcomes can be.**
Adding vertices to `W` cannot raise the minimum, and cannot lose a minimum either — the colourability
of a selection `S` depends on `S ∪ C` alone, so every old minimum survives as a minimum unless
something strictly smaller appears. So each run lands in exactly one of three states: `|M| ≤ 135`
(a record), `|M| = 136` with `{M}` strictly larger (his own *successful iteration*, and the opening of
depth 2), or inert.

| # | registered expectation | falsifier |
|---|---|---|
| E1 | at least one of the six returns `|M| ≤ 135` — **20%** | any run at ≤ 135 (confirms), all six at 136 (kills) |
| E2 | at least one of the six grows `{M}` at 136 — **65%** | all six leaving `A166`'s level of 8 unchanged |
| E3 | if anything moves at all, it is `(0,0,6,6)` — **50%** given that something moves. It is rank 1 by his own degree criterion (8), all 12 of its vertices are absent from `A166`, and it is one of the two orbits his own **L**-side move added (parts:808-810) | something moves and `(0,0,6,6)` is inert |
| E4 | **the diagnostic, and the probe's real by-product:** if his published degree order has any content on the S side, movement concentrates in ranks 1–3 (degrees 8, 6, 6) rather than ranks 4–6 (degree 4). This is a **six-point sample of card 1's outcome map** — the first data anyone holds on whether his ranking predicts outcome | movement appearing only at degree 4 |
| E5 | each run closes in **under 30 minutes on one core**; the two 24-vertex additions (ranks 4 and 5) are the slowest. The S stage keeps its frozen `L374` companion, so it should stay in the cheap regime, and the product owner's 16–88× figure is for **companion-free** stages | any run over 30 minutes or not closing — which would itself be worth more than the probe, since it falsifies "frozen companion ⟹ cheap" |
| E6 | **the dangerous direction of error is spurious, not missing.** A missing edge makes the graph easier to colour, so it can only cause an under-claim; a **spurious** edge makes refusal easier and can manufacture a false record. So anything below 136 gets exact re-verification that every edge of the winning object is at distance exactly 1, and the stage's atom count against its vertex count to rule out a duplicated point, **before** the word record | — |
| E7 | if S reaches 135 against the frozen `L374`, the union is `374 + 135 − 1 = 508`, and its edge count decomposes as `1860 + e(S) + (connection)` where the connection term is recomputed from exact geometry rather than carried over from the record's `12 + 6` — a new orbit inside radius `8/√15 ≈ 2.0656` changes the cross-edge set (M62 §R22: 126 cross edges on the full arena, every endpoint within that radius) | a connection count taken from the record rather than recomputed |

question: does-the-reserve-threshold-count-cross-edges
  evidence: P1 counted unit-degree into `A166` with lattice unit edges only and returned six eligible
    orbits. His rule (parts:517-521) reads *"if, when added to the graph `A`, the degree of some of its
    vertices is at least 4"* — and on the S side the stage's graph is the S material **plus** its ρ₁₅
    cross edges to the frozen `L374`; the record carries 18 of them, 12 reference and 6 auxiliary (M63
    §1(i)). M62 §R22 derives that every ρ₁₅ cross-edge endpoint has radius ≤ `8/√15 ≈ 2.0656` and that
    the arena's 126 cross edges are unchanged from `r = 2.00` to `r = 2.44`. Three of my six candidates
    have their large radius above that bound — `(0,0,6,6)` 2.5243, `(12,0,2,6)` 2.1888, `(12,2,6,0)`
    2.1404 — so cross edges can reach only their small-radius members.
  expected: the menu is six, under either reading
  ask: is the admission degree counted inside the S half alone, or in the whole stage including cross
    edges to the frozen L?
  if S-only: the menu is the six measured, and the probe's job is exactly six runs
  if whole-stage: the menu is strictly larger, every addition has small radius ≤ `8/√15`, and the
    recount happens before anything is reported — a menu reported one way and searched the other is the
    failure this card exists to prevent
  answered by: run — the same census with cross-degree added, seconds, no solver
  cost: seconds
  hunch: the whole-stage reading adds at least one orbit to the six
  falsifier: the recount returning six
  rank: 4

question: which-accumulator-does-the-first-sweep-run-on
  evidence: the product owner made the 49-candidate L sweep phase D's first implementation item,
    parallel across candidates, on the reading that *"the large half is where the room is"*
    (2026-09-11). Two facts bear on how it is pointed. (i) `A403` is the state the reproduction clause
    judges the frozen rule from (M63 §S.1 2(b)), so a sweep there **computes the answer the rule is
    supposed to find**, and once computed it cannot be un-computed; `A412` is past his recorded
    stopping point, so a sweep there is a beat attempt touching no reproduction claim. (ii) Parallel
    runs contaminate per-run cost measurement, and the cost regime is load-bearing: four audit drops
    (B-8, B-11, D-6, X-7's guard) are conditional on C4.0's regime, the planner's forecast rests on
    *frozen companion ⟹ cheap*, and phase C's hardening requires CPU seconds user+sys, minimum of
    three, machine and concurrent load named. Three solver jobs already share the box.
  expected: the sweep's accumulator and its scheduling are implementation details
  ask: does the first sweep run on `A412`, and does its first candidate run alone and timed?
  if yes: the 49 are beat attempts with a measured cost regime, and the `A403` map is computed after
    the frozen rule has had its attempt — card 1's branch, with the owner's one-bit rank diagnostic
    becoming a full ranking evaluation and no contamination
  if the sweep runs on `A403`, or all 49 launch at once: clause 2(b) is decided before the rule is
    written, and the single cost datum phase D's forecasts rest on is never taken
  answered by: Planner (de Bruijn, phase D)
  cost: one decision, plus one run's wall clock
  rank: 5

hunch: the-large-half-is-where-the-room-is
  claim: **the product owner's, 2026-09-11, registered by me so the sweep scores it rather than assumes
    it** — the large half holds more improvable room than the small one, because its base neighbourhood
    is about 72 orbits at degree ≥ 3 against the small half's 9
  basis: derived
  falsifier: the 49-candidate sweep returning a *lower* success density per candidate than the
    nine-candidate S sweep — candidate count measures search-space size, not the density of successful
    moves, and that density is exactly the base rate card 1 exists to measure. Counter-consideration
    for the record: the large half is the half he actually worked (four states, ~100 laptop hours,
    parts:798-810, 862-863) while the small half he never expanded, so the prior per candidate is not
    equal across the halves; against that, his §7 says *"Not all options have been studied yet"*
    (parts:871-873)
  registered: 2026-09-11
  status: open

hunch: the-S-menu-is-six-only-under-the-narrow-reading
  claim: counting his admission degree over the whole stage (S material plus ρ₁₅ cross edges to the
    frozen `L374`) admits at least one orbit that the S-only count rejects, and every such orbit has
    small radius ≤ `8/√15 ≈ 2.0656`
  basis: derived
  falsifier: the cross-degree recount returning the same six orbits
  registered: 2026-09-11
  status: open
