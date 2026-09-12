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
- the phase D implementer's D1.a report, 2026-09-11 (`a0ff3ca8b76d21ad9`) — read against: the replay control reproducing his state-1 row (376 vertices, 96 minima, `A = v451e2400`, edges 1890–1947), since it reduces **his own** published accumulator against **his own** published companion with no free parameter — surprised: yes; `|M|` agrees exactly while `|{M}|` reads 82 against 96 and the accumulator 433 against 451, short by **18** with nothing of ours outside his, and the edge range's low endpoint short by **18** too. Its proposed explanation (our rung is larger than his, so his state 1 is an order-2 rung) is refuted by P8 in thirty seconds of group theory on a file we already hold, which is the second time this phase that the deciding object was in the record while a multi-core probe was being launched at the question

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
run of each. **Cards 7, 8 and 9** went to the **phase D implementer** (`a0ff3ca8b76d21ad9`), a third
addressee, and are below in their own section — card 7 because the product owner named the map's
over-reading risk and card 1 is what created it, card 8 because its design consequence (what the
singleton sweep writes to disk) cannot be taken retroactively, card 9 because the fifth arm the
plan funds to test my own hunch would not have tested it, and **card 10** to both engineers at once
after the S engineer corrected card 8's pair pricing — it asks which of three nested pair menus the
sweeps use, and carries two corrections to my own cards. **Cards 11, 12 and 14** went to the S
engineer as its sweep ran (the promoted set's disk status; whether run time tracks anything but size;
whether cost tracks added edges), and **card 13** to the implementer (the target knob making the
declared secondary outcome unobservable). Cards 10, 11 and 12 are answered, each answer killing or
scoping something of mine: two readings dead on the radius axis, the closed list scoped to singles,
and three separate corrections to the menu figure 57.* Fates are the phases' to write beside
each card; the planner reports cards 1, 2, 3, 5, 6, the three §§5.5–5.11 items and both corrections as
having fates in its own §P.*

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

## Cards 7–25 — sent to the phase D implementer (`a0ff3ca8b76d21ad9`) and the S engineer
(`aa10420df4950eda9`), 2026-09-11

*Prompted by the product owner naming the map's over-reading risk before the sweep runs. Card 1 argued
for the map, so its failure modes are mine to name.*

question: is-the-map-scored-on-the-data-that-built-it
  evidence: four ways in. (i) Trying `k` rankings against one 57-point map and reporting the best
    inflates the best by selection alone. (ii) If the outcome is degenerate every ranking scores alike
    and nothing can be said of any — the S half is 7 of 14 decided, all inert at 136 with the identical
    48 minima — and G21 says a negative then measures the enumeration, not the rankings. (iii) The
    salvage move when the primary outcome is all-zero is to substitute a softer one, and the softest to
    hand — **atoms freed** — IS one of the candidate rankings, so it would be scored against itself.
    (iv) A rule invented after seeing the map is hypothesis generation, not evidence.
  expected: the map is ground truth, so scoring against it is safe
  ask: are the ranking list and the outcome variable frozen in a commit before the first candidate's
    outcome is read?
  if yes: the `A412` map is the training set and the `A403` map — computed after the frozen rule's
    attempt, as cards 1 and 5 already require — is a held-out test at no extra cost; report every arm's
    full curve, never the best arm
  if no: the sweep yields a map that cannot score anything, and its only honest use is as the
    enumeration it is — still worth having, and it should be said in those words
  answered by: Implementer (de Bruijn, phase D)
  cost: one commit before the first run
  hunch: the outcome is degenerate on the L half too, and (iii) is the failure that actually happens,
    because substituting a softer outcome feels like salvage rather than a design change
  falsifier: any single-orbit candidate on the L half lowering `|M|`
  rank: 7

*Caveat sent with it: `A403` and `A412` are nearly the same object, so their maps are correlated and the
split is weak; it costs nothing, so take it, but the genuinely held-out test stays phase E's 8/3
mono-pair.*

question: what-does-an-all-inert-singleton-sweep-close
  evidence: **his one recorded successful expansion was a four-set** — orbits `(0,0,0,4)` and
    `(0,0,6,6)` plus the other halves of `(0,0,2,2)` and `(0,0,2,6)` (parts:808-810; M63 §S.2 #9) — and
    every sweep now running is singletons. Seven of the S half's fourteen are decided, all inert at 136
    with the identical 48 minima and an unchanged accumulator. His §5.11 ceiling (*"usually limited to
    several tens"*, parts:724-729) and his tens-of-hours reductions are a reason he would bundle orbits
    into one expensive reduction, so the four-set may be his cost regime rather than a structural fact;
    both readings are live, which is what makes this a question.
  expected: a singleton sweep answers "can this half be expanded"
  ask: does an all-inert singleton sweep close the half, or only its singletons — and is the pair rung
    entered on the S half, where `C(14,2) = 91` runs is about 15 core-hours?
  if singles only: the S negative is reported with that scope, the pair rung becomes the cheapest
    remaining beat attempt anywhere, and the singleton sweep's artifacts are kept resumable so a pair
    run reuses them rather than redoing them
  if the half is closed: state the argument, because nothing measured supports it and his own recorded
    move contradicts it
  answered by: Implementer, and the S-expansion engineer
  cost: one scope sentence now; 91 runs later if entered
  hunch: singles are inert on both halves and pairs are where the answer is; his four-set is the
    evidence, and it is the best reason to expect what the S half is already showing
  falsifier: a single orbit lowering `|M|` on either half
  rank: 8

**Reading, and it sharpens card 1 rather than undercutting it.** Pairs on the S half are 91 and
enumerable; pairs on the L half are `C(57,2) = 1,596` and are not. **Enumeration dies exactly one rung
up, on the L half — which is precisely where a ranking rule must be trusted.** So the map's argument is
not that it finds the move but that it is the only ground truth against which the depth-2 rule can be
scored at depth 1.

question: does-the-L-sweep-run-its-shoulder-in-full
  evidence: my hunch `the-filter-is-the-rule` says the reserve gate (229 orbits → 57) may carry most of
    his rule's content, and the plan answers it with a fifth arm sampling orbits that fail the gate.
    **That arm is a straw control:** under the strict reading the L degrees run
    `{0:48, 1:56, 2:33, 3:23, 4:18, 5:13, 6:12, 7:2, 8:2, 9:1, 10:1}`, so a uniform sample below the
    gate is drawn overwhelmingly from degrees 0 and 1 — useless for a trivial reason — and would
    confirm "the filter does something" while saying nothing about where the cut belongs. The
    implementer proposed instead regressing density on degree *within* 4–10, but that measures **is
    degree a good ranking**, not **is the gate a good filter**: density flat across 4–10 and zero at
    ≤ 3 would mean degree is useless above the gate while the gate does everything, so "flat ⟹ the cut
    is arbitrary" is an invalid inference. The instrument for a threshold is a comparison *at* it.
  expected: the gate question is answered by sampling below the gate
  ask: does the L sweep run its degree-3 shoulder in full, making the gate question a comparison at the
    threshold rather than a sample below it?
  if yes: about 23 extra runs — a 40% larger sweep — buy a complete, nearly balanced comparison at the
    cut (23 at degree 3 against 18 at degree 4, both complete rather than sampled), and the hunch
    becomes answerable rather than merely registered
  if no: the gate question is reported as untested, which is honest and cheap, and the fifth arm is
    dropped rather than shipped as a straw control that would read as evidence
  answered by: Implementer (de Bruijn, phase D)
  cost: about 23 runs, or one sentence
  hunch: the gate carries more of the rule than any ranking within it does
  falsifier: density at degree 3 matching density at degrees 4–10
  rank: 9

**A correction to my own P4, sent with card 9.** That histogram, and its shoulder counts of 3 on the S
side and 23 on the L side, were measured under the **strict** reading — the one I withdrew. Under the
adopted reading (b) the degrees shift upward, so **both the eligible set and the shoulder need
recomputing**, and "23 at degree 3" must not be carried as a number. The 57 / 59 / 12 menu counts are
under reading (b) and stand.

**Three per-entry invariants offered for the sweep** (the implementer's own check — vertex count plus
recomputed edges — catches a mis-frame but not a wrong companion). (1) *The companion fingerprint is
constant across a sweep*, by construction; assert it against one stored value, free. (2) **The
restriction identity, the one to plant if only one:** an expanded stage contains the unexpanded stage
as an induced subgraph on the original vertices, so its induced edge set restricted to the original
atoms and the companion must equal the unexpanded stage's exactly — adding vertices cannot change edges
among existing ones. This catches a wrong companion *and* a wrong frame, because both alter cross edges
among the *original* vertices, which is exactly where a vertex-count check is blind; one set comparison,
no solver. (3) *The known-answer anchor*, one ask: a known minimum of the unexpanded stage must still
refuse, and minus any vertex must be colourable — invariant under every expansion, so any variation is
the instrument. None of the three catches *right graph, wrong question* (a target knob asking ≤ 373 when
it should ask ≤ 374); for that the artifact must echo the target and rung it actually used against the
config hash.

question: which-of-three-pair-menus-is-the-sweeps-menu
  evidence: **the S engineer's correction to card 8, accepted:** admission is relative to the
    accumulator, so for distinct orbits the absent set of `O₂` is unchanged by adding `O₁` while every
    degree into `A ∪ O₁` is ≥ the degree into `A` — sequential admission therefore strictly contains
    pairs-of-singles, and **my 91 and 1,596 are lower bounds, not counts**. But three menus are nested,
    not two. **(a)** both orbits from `menu(A)`: 91 on the S half, `C(57,2) = 1596` on the L half.
    **(b)** sequential with recomputation: the engineer's, ≥ 91, possibly > 200. **(c)** simultaneous
    admission (some vertex reaches degree 4 in `A ∪ O₁ ∪ O₂`): larger still, and the only one admitting
    a pair whose members each fail alone and qualify together — which (b) can never reach, since
    neither orbit can go first. **His own text favours (a)**: *"Graph R … is updated after several
    successful iterations"* (parts:516-517) — after iterations, not after each orbit — so within one
    expansion step the candidate set is fixed and a k-orbit move draws k orbits from one `R`.
    **Empirical tie-breaker, from measurements already on the record: all four orbits of his one
    recorded move were in `menu(A403)`** — `(0,0,0,4)` and `(0,0,6,6)` at degree 6, `(0,0,2,2)` and
    `(0,0,2,6)` at degree 4 (predecessor's M3; my P1 ranks 8, 45, 47).
  expected: the pair menu is pairs of singles
  ask: does the pair sweep use his fixed-reserve menu of 91, the recomputed sequential one, or
    simultaneous admission?
  if his fixed-R menu: 91 runs, and (b)'s extra members are reported as an untested widening rather
    than run
  if the recomputed one: the cost doubles or worse and the sweep is no longer reproducing his rule —
    fine as a beat attempt, but it must not be labelled reproduction
  answered by: Engineer (S half, `aa10420df4950eda9`), with the phase D implementer for the L half
  cost: one decision; 91 runs against perhaps 200
  hunch: (a) is his rule and (b) is the better search, so the honest artifact runs (a) first and
    reports (b)'s extra members separately — then a negative on 91 is a statement about *his* rule
  falsifier: an orbit in his recorded move that was below threshold against `A403`
  rank: 10

**A second widening, orthogonal to the engineer's, and unmeasured.** His sentence gives **two**
expansion modes: *"filling in the partially occupied base orbits of graph `A` and (or) adding new
vertices from reserve graph `R`"* (parts:513-515). The degree-≥ 4 test is stated **only for membership
of `R`** — the *additions*; a **fill** of an already-partially-occupied orbit is subject to no degree
test in the text, only to its own priority (*"especially to orbits with a small number of vertices
(6 or 12)"*, parts:522-524). **Two of his four move-orbits were fills.** If fills are exempt, the menu
gains every partially occupied orbit below threshold — 16 orbits were partially occupied at `A403`
(predecessor's M3), of which only some clear degree 4. Not measured here; it is one line in the census
the S engineer is already running.

**A correction to my own card 8, derived by the S engineer and accepted.** Card 8 told the implementer
to keep the singleton sweep's artifacts resumable and listed *"stage, harvested correction sets,
level"*. **The correction sets are exactly the item that must not be imported:** a refusing selection
in a pair stage may satisfy none of them through the second orbit, so importing one as a
keep-at-least-one constraint could exclude a genuine record, and the sound repair widens each set and
weakens it. What is safely resumable is the **colourability cache** — a selection's colourability
depends on the selection and the companion alone, never on `W` — and **non-criticality**, which
transfers upward while criticality does not. Both were the savings anyway; the correction sets were
never the expensive part.

question: does-promotion-reach-outside-his-disk
  evidence: my P5 closed list — no orbit outside his `r = 2` disk reaches the admission threshold under
    any of the three readings — was computed **against the bare accumulator only**. Promotion is
    exactly the mechanism that could break it: the S engineer measures the S pair menu at **112 = 91 +
    21**, the 21 bringing in **14 distinct orbits** that fail against the bare accumulator and qualify
    once one orbit is present, and reports that **both degree-3 shoulder orbits are promoted to full
    admission**. One S shoulder orbit is `(0,4,8,0)`, both radii exactly √5, outside his disk (P4, P6).
    The 46 excluded orbits split 11 with `abcd ≠ 0` and 35 with `abcd = 0` (P7).
  expected: the closed list is a statement about the material — it is a statement about singles
  ask: does any promoted orbit lie outside his `r = 2` disk, and is `(0,4,8,0)` among the promoted?
  if yes: material his own base excluded is reachable as the second half of a pair; the closed-list
    finding is scoped to singles here, and the pair sweep becomes the first search in this project that
    can leave his disk at all
  if no: the closed list survives promotion as well as all three readings, and F(g)'s radius half is
    closed against pairs too — a stronger statement than I have made
  answered by: Engineer (S half) — one line from the promoted set it already holds
  cost: a lookup
  hunch: yes, and `(0,4,8,0)` specifically — its own finding is that promotion favours orbits attaching
    poorly to the accumulator, and outside-disk orbits are peripheral by definition
  falsifier: the promoted set lying entirely inside the disk
  rank: 11

**Fate of card 10 — answered by the S engineer, 2026-09-11, better than it was asked.** It does not
choose: (a) ⊆ (b), so it runs **112** and reports **21 promoted** and **91 pairs-of-singles** with
separate enumerations, which yields a statement about *his* rule and a labelled widening from one
sweep, for about four core-hours. It accepts the textual argument for (a) and the empirical
tie-breaker. **(c) measures 350** — 238 beyond (b), of which **203 have both orbits below threshold
alone**. Those 203 are a class his algorithm *structurally cannot reach*, under either his fixed
reserve or sequential recomputation, since neither orbit can go first: **(c) is not a wider version of
his search but a different one, so no result from the 203 can enter a reproduction claim** — which is
also what makes them the most interesting group on the merits. **The fills widening measures empty on
the S side** (two partially occupied orbits, both already clearing degree 4) and is live on the L side,
where 16 were partially occupied at `A403`. **Consequence for my own number: 57 is an undercount for a
second, independent reason** — it applied the degree test to every orbit including partially occupied
ones — so after the reading correction (49 → 57) and the pair-count correction, the menu figure needs a
third recomputation and must not be carried as 57.

question: is-time-to-decide-tracking-anything-but-size
  evidence: eight of fourteen S singles decided, all inert, the accumulator bit-for-bit identical each
    time; two still running, one of them `(0,0,6,6)`, over an hour at the record threshold. But
    `(0,0,6,6)` adds 12 absent vertices (gap 30 → 42) and is **not** the largest addition:
    `(12,0,2,6)`, `(12,2,6,0)` and `(6,4,6,0)` each add 24 (gap → 54), `(12,2,2,0)` adds 18.
  expected: run time is a cost and it tracks the gap
  ask: of the decided candidates, do the per-candidate gaps and CPU times show that size explains which
    runs are slow?
  if size explains it: nothing here; record time as a cost column and move on
  if it does not: time-to-decide is tracking proximity to the boundary rather than problem size, and
    belongs in the map as a per-candidate **flag for a second look**
  answered by: Engineer (S half), from its own run log
  cost: a lookup
  hunch: size does not explain it — a +12 candidate outlasting three +24 candidates is the wrong way
    round
  falsifier: the +24 candidates turning out to be the slow ones
  rank: 12

**The trap card 12 sits next to, stated so it is not walked into.** Card 7 predicted that a degenerate
primary outcome would invite substituting a softer one, and eight-for-eight inert with identical
accumulators **is** that case, arrived on schedule. Solver time is the nearest graded signal to hand
and must **not** become the outcome variable: `CLAUDE.md`'s own ledger (row 13) records that SAT pool
statistics measure the solver rather than the colouring space, and time moves with load, seed, clause
order and the incumbent on a box at load 9. Record it, flag on it, never rank on it. The graded outcome
that is safe is combinatorial — `|{M}|` and the level's structure — and on the S side it is flat, which
is the *strongest* form of the negative and should be reported as such: not "no improvement" but **"the
level did not move at all, eight times"**.

**Fate of card 11 — answered by the S engineer, 2026-09-11. Yes, and it scopes my own finding.** Of
the 14 orbits promoted only as a pair's second member, **one lies outside his `r = 2` disk:
`(0,4,8,0)`, both radii exactly √5**, promoted to full admission by `(12,0,2,6)` and by `(0,2,10,0)`.
**So the honest form of P5/P6 is: *no single orbit outside his disk qualifies, and pairs are how you
get there*** — the closed list is a statement about singles, and the pair sweep is the first search in
this project that can leave his disk. `(0,4,8,0)` is now tested twice: alone through the degree-3
shoulder, where it is below threshold, and as a promoted second member, which is the form with a real
chance.

hunch: promotion-is-enriched-in-outside-disk-material
  claim: the promoted set is enriched in orbits outside his `r = 2` disk, because promotion favours
    orbits that attach poorly to the accumulator and outside-disk orbits are peripheral by definition
  basis: derived
  falsifier: the promoted set's outside-disk share matching or falling below the base's
  registered: 2026-09-11
  status: killed (by: the S engineer's lookup — 1 of 14 promoted against 46 of 229 in the base, 7%
    against 20%, mildly *depleted*. The conclusion card 11 drew was right for a different reason)

hunch: promoted-pairs-are-spatially-close
  claim: promoted pairs are closer together than pairs in general — similar radii, neighbouring
    angular sectors — which would make promotion predictable rather than merely measured
  basis: derived
  falsifier: promoted pairs no closer than pairs in general
  registered: 2026-09-11
  status: killed on the radius half (by: median small-radius difference 0.757 across the 46 promoted
    pairs against 0.613 across all 112 — promoted pairs are slightly *farther* apart). The angular
    half is untested and is not claimed either way

**The diagnosis for both, and it is the part worth keeping.** Both predictions ordered things by
radius — after P6 had established, and I had written down, that *degree into the accumulator is not
monotone in radius*, which was the whole reason his published disk negative turned out to be about his
filter rather than his disk. Outside-the-disk is a statement about an orbit's smaller Galois-conjugate
radius; peripheral-to-`A166` is a statement about degree into a 166-point set; they are close to
unrelated, and I had already proved that to myself. **Radius is not the geometry that governs anything
on this problem, and two dead predictions on one axis is where I stop predicting on it.** No
replacement mechanism is offered: the obvious one, that promotion tracks inter-orbit adjacency, is true
by definition rather than a finding. The S engineer's own regularity — promotions come overwhelmingly
from the *weak* candidates, `(4,0,2,2)` bringing six while the four strongest bring none — stands
unexplained, and is worth more unexplained than wrapped in a story I have twice got wrong.

question: does-the-target-knob-make-clause-2c-unobservable
  evidence: the implementer derived that **the target's entire saving is the level enumeration** — the
    lower bound must climb to `w*` before it can exceed `w* − 1`, so the harvest is paid in full
    (measured 22.0 CPU s against 24.2 on a one-minimum control, 91%, against a registered forecast of
    under a third). The consequence it did not draw: an **inert** candidate is one with `w* =`
    incumbent, i.e. `|M|` unchanged — exactly the population in which phase D's clause 2(c) lives
    (`{M}` grows at fixed `|M|` and fixed rung after the rule added vertices, M63 §S.1 2c) and exactly
    the declared *secondary* outcome of card 7's frozen list. A targeted run returns
    `no-selection-at-target` and never enumerates the level, so `{M}` is never computed where it could
    have grown. The S engineer's sweep is **untargeted** and therefore holds every level — which is why
    it can say the accumulator is bit-for-bit identical eight times, a statement a targeted run cannot
    make.
  expected: the target knob is a cost optimisation orthogonal to what the sweep measures
  ask: with the knob on, where does the sweep observe `{M}` growth at fixed `|M|` — the declared
    secondary outcome, and clause 2(c)?
  if nowhere: the sweep answers `|M|` only, its map is binary **by construction**, card 7's degeneracy
    becomes a certainty rather than a risk, and clause 2(c) must be observed in the loop proper and
    said so in the plan
  if on a subset: name the subset and what selects it, because a binary primary outcome cannot
  answered by: Implementer (de Bruijn, phase D)
  cost: one decision before the sweep runs
  hunch: run targeted for the primary and pay the full level on a **pre-declared** subset — the two √5
    orbits, the shoulder comparison, and any candidate whose harvest differs materially from the
    unexpanded stage's, that last being free from the harvest already paid. Pre-declared because a
    subset chosen after the outcomes are read is card 7's failure through a side door
  falsifier: a way to read `{M}` off a targeted run that I have not seen
  rank: 13

**Fate of card 12 — answered by the S engineer, 2026-09-11, and the hunch was understated.** Spearman
between added vertices and CPU is **−0.738** over eight decided candidates; the slowest run is the
second-smallest addition, and five of the six slowest slots are held by 24-vertex additions at the
*bottom*. Its own honest weakening: n = 8 with one influential point, so the defensible claim is
**size does not predict cost on this sample and certainly not upward**. Correction sets track CPU at
+0.786, near-tautological. **The consequence, which is the finding:** phase D's forecasts size runs by
the gap (the L451 anchor, gap 76 at 605 s), and gap is uninformative about cost across 33–54 on the one
side where it has been tested — so the model must be re-measured before it sizes 57, not inherited.

question: does-cost-track-added-edges-rather-than-added-vertices
  evidence: decomposing the engineer's own table. `(12,0,0,0)` is slow for two independent reasons:
    18,522 asks against 14,002–16,722, **25% more**; and 64 ms per ask against 45–55 ms, with a
    middling refusing mean of 0.149 s, so netting the refusing asks out leaves roughly **60 ms per
    colourable ask against 41–55 ms**. More asks *and* harder colouring — a denser addition, not a
    larger one. And that orbit is not generic: **both its radii are exactly 1, so it is the six points
    at unit distance from the shared centre** — the unit hexagon about the pinned origin, bringing at
    least twelve edges (six to the centre, six around the ring) from six vertices, before any edge into
    the rest of `A166`. The table carries added *vertices* and no column for added *edges*, which the
    stage already knows.
  expected: cost tracks problem size, as added vertices or as the gap
  ask: does the added-edge count order the eight CPU times where added vertices does not?
  if it does: the sweep's cost model is edges rather than vertices, forecasts re-base on a quantity
    available before any run, and "smaller additions cost more" stops being unexplained — small orbits
    near the centre are dense, large orbits far out are sparse
  if it does not: the inversion stays unexplained and stays flagged, and n = 8 with one influential
    point is the right weight to give it
  answered by: Engineer (S half) — one column from stages already built
  cost: a lookup, no solver
  hunch: edges order it, and the outlier is the densest possible addition rather than a fluke
  falsifier: added edges correlating no better with CPU than added vertices does
  rank: 14

**A second, weaker flag on the same candidate, to check only if the edge column fails.** The stage's
default pin triangle is `((0,0,0,0), (12,0,0,0), (6,0,6,0))` (`parts_stage.Stage.__init__`), and the
anomalous candidate is the orbit **labelled** `(12,0,0,0)`. Different vertices in the doubled index
space — the pin is L-side, the candidate adds S-side — so no collision and no fault claimed. But the
pin exists to break symmetry and is worth 62–63× by the implementer's measurement, and adding a
rotation-symmetric hexagon about the pinned centre is the one move that could partially restore a
symmetry the pin was breaking, inflating the ask count on exactly that candidate. Discriminator: one
re-run with a different pin triangle. If the anomaly moves, per-candidate costs are not comparable
across the sweep.

**Fate of card 14 — answered by the S engineer, 2026-09-11; the hunch splits and the cost model
dies.** Over nine decided candidates, Spearman against CPU: added vertices **−0.284**, added edges
**−0.353**, edges per added vertex **−0.043**, asks +0.650. The gap is flat too (33–54 against CPU
669–1180). Checked here before accepting: per-ask cost runs 44.9–63.7 ms and ask counts 14,002–18,522,
so both factors move and neither tracks any pre-run quantity. **Nothing computable before a run
forecasts it.** The ninth point moved the vertex coefficient from −0.738 to −0.284, which is the best
illustration of why the weakened claim was the right one.

hunch: cost-tracks-added-edges
  claim: the sweep's cost model is added edges rather than added vertices, so forecasts can re-base on
    a quantity available before any run and "smaller additions cost more" stops being unexplained
  basis: derived
  falsifier: added edges correlating no better with CPU than added vertices does
  registered: 2026-09-11
  status: killed (by: the S engineer's measurement — edges −0.353 against vertices −0.284, no
    improvement, and density flat at −0.043. What the miss cost: one lookup the engineer was already
    positioned to make, and it retired a wrong cost model before phase D sized a sweep on it)

hunch: the-slow-outlier-is-the-densest-addition
  claim: `(12,0,0,0)` is slow because it is the unit hexagon about the shared centre — the densest six
    vertices in the base — and not because of a fluke
  basis: derived
  falsifier: its edges per added vertex lying in the range of the other candidates
  registered: 2026-09-11
  status: confirmed (by: 8.0 edges per added vertex against 2.5–4.0 for every other candidate, twice
    the densest other, with six cross edges to the companion because every one of its points is at
    distance 1 from the shared centre; and its cost decomposing into 25% more asks *and* slower asks)

**So density explains *which* candidate is anomalous and orders *none* of the others.** The right
statement is that the outlier is explained and the ordering is not.

**The pin flag — the S engineer declined the re-run, correctly, and replaced my instrument.** Its
reason is the one I should have applied myself: time is already a flagged cost column and never a
ranking key, so resolving whether per-candidate costs are strictly comparable buys nothing this probe
reports. **Its cheaper discriminator beats my re-run outright:** measure the stage's automorphism order
per candidate with the committed symmetry function — no solver — since the hypothesis is exactly that
a symmetric hexagon about the pinned centre restores a symmetry the pin was breaking. If that order
matches the others, the idea dies for free. Passed to the implementer for whenever the pair phase wants
per-candidate forecasts.

**Consequence for card 5, which was mine.** Timing the first candidate alone still establishes the
*regime* (is a refusing ask 0.02 s or 4 s) and remains worth the wall clock; it does **not** give a
per-candidate forecast and must not be used as one. Budget the sweep as candidates × mean with ~2×
headroom (observed spread 1.76×), never as a schedule of predicted costs, and do not order the runs
cheapest-first — there is no cheapest-first to compute.

question: is-a-timeout-counted-as-an-inert-candidate
  evidence: nothing pre-run predicts cost (above), so the 57-candidate sweep must run under a wall. The
    machinery has one (C1.1) returning `undecided`. But the map's primary outcome is **binary** — `|M|`
    improved or not — and a candidate that exhausts a wall has not been shown inert. Card 1's prize is
    the base rate; folding `undecided` into inert biases it **downward**, and the candidates most
    likely to exhaust a wall are those nearest the boundary, which are exactly the ones worth finding.
    The S engineer's nine-for-nine identical levels are safe only because that sweep is untargeted and
    every run closed; a targeted sweep under a wall has no such guarantee.
  expected: the wall is a cost control, orthogonal to what the map records
  ask: does the map carry three outcome states — improved, inert, undecided — with undecided never
    folded into inert?
  if three: the base rate is reported over **decided** candidates with the undecided count beside it,
    and a wall hit is a scheduling fact rather than a mathematical one
  if two: every wall hit reads as evidence of inertness, the base rate is biased in the one direction
    that matters, and the bias is invisible in the artifact
  answered by: Implementer (de Bruijn, phase D)
  cost: one column, and one line in the base-rate arithmetic
  hunch: the artifact probably already carries the verdict word while the base-rate arithmetic does not
    honour it — different places in the code, and only the second one matters
  falsifier: the base-rate computation already excluding undecided candidates
  rank: 15

**Fate of card 13 — adopted by the implementer, 2026-09-11, with a better fix than mine.** `{M}`
growth at fixed `|M|` is a **decision**, not an enumeration, so it is observable on *every* candidate
and the pre-declared subset disappears. Its derivation, checked here step by step: for
`S ⊆ atoms(W)`, `W'[S] ∪ C = W[S] ∪ C`, so every minimum of `W` survives in `W'` and every minimum of
`W'` using no new atom is a minimum of `W`; hence **`{M}` grew ⟺ some refusing selection of weight
`≤ w*` contains an atom of `Δ`** — one extra hard clause at `target = w*`. **The premise is free:** the
first decision returning `no-selection-at-target` at `w* − 1` gives `w*(W') ≥ w*`, and monotonicity
gives `≤`, so inertness is established rather than assumed. Unclaimed bonus: a positive answer is
**constructive** — the witness is an explicit new minimum using the new material, which is the object
the loop's next iteration wants.

question: is-the-second-decision-2x-or-a-second-certification
  evidence: by the implementer's own mechanism — the bound must climb before it can exceed the
    target — the restricted decision must drive the **Δ-constrained** lower bound above `w*`, and the
    correction sets that certified the unrestricted bound `≥ w*` need not certify the constrained
    bound `≥ w*+1`: every `w*`-weight selection *containing* a new atom must be refuted, and those are
    selections the first run had no reason to visit. **Its own transfer lattice states the split** — a
    restricted run and a plain run share every *graph* fact and no *search* fact — so the inherited
    harvest is real while the **additional** harvest the constrained certification needs is
    unmeasured. And the common case is the expensive polarity: on the S half nine of nine candidates
    have bit-for-bit identical levels, so `{M}` did not grow and non-existence must be certified every
    time.
  expected: the second decision costs about what the first did
  ask: on the S half's nine decided candidates, where the answer is known to be "no growth" and the
    level is known, what does the restricted decision actually cost?
  if about 1×: the 2× estimate holds, clause 2(c) is observable on every candidate, and card 13's
    subset is gone for good
  if a large fresh harvest: the second decision is a second certification, the pre-declared subset
    returns, and it must be declared in the freeze commit **before** any outcome is read — a subset
    chosen after the costs are known is selected by the cost, which is card 7's failure in a third
    costume
  answered by: run — the restricted decision on nine stages already built, against a known answer
  cost: nine decisions on the cheap side; a calibrated bed rather than a forecast
  hunch: closer to 2× than to 20×, since the inherited correction sets are the bulk — but not past
    60%, and the polarity is the expensive one
  falsifier: a restricted decision costing more than the unrestricted run it follows
  rank: 16

### P8 — the stabiliser of his own published 376 minimum kills the rung explanation (30 s, no solver)

*The implementer's D1.a reduced `v451e2400` against `v136e564` at the order-3 rung and got `|M|` = 376
(his exactly), but `|{M}|` = 82 against his 96, accumulator 433 against his 451 — short by **18**, with
nothing of ours outside his — and L-edge range 1908–1947 against his 1890–1947, the low endpoint short
by **18**. Its reading: our rung is strictly larger than his, so his state 1 sits at an order-2 rung;
a 45-core-minute sweep of seven order-2 and three order-6 rungs was launched. The record already held
the object that decides it — his own fewest-edge 376 minimum `v376e1890.vtx`, at exactly the low
endpoint our level does not reach.*

```
group element orders: [1, 2 x15, 3 x2, 6 x6]   ->  exactly two order-3 elements,
                                                   hence a UNIQUE order-3 subgroup
v376e1890 : stabiliser order = 3  (element orders 1, 3, 3)
v451e2400 : stabiliser order = 12
v375e1920 : stabiliser order = 2
v403e2112 : stabiliser order = 12
```

**Calibrated against two facts established by others before being believed:** the same computation
returns **2** for `v375e1920`, exactly his printed parenthetical in `1 (2)` at the 375 row, and **12**
for `v403e2112`, which is §S.2 #2's stabiliser.

**What it kills.** His sparsest 376 minimum *is* order-3-invariant, under the unique order-3 subgroup —
so his state 1 is the order-3 rung and so is ours. And no **larger** rung can be his, since a bigger
group cannot fix a set whose stabiliser has order 3. The order-2 and order-6 rungs cannot carry
`v376e1890` at a symmetry above 3. **The rung explanation is dead and the two 18s are not a rung
artefact.**

question: does-his-sparsest-376-refuse-against-our-companion
  evidence: P8 above. `v376e1890` is his fewest-edge 376 minimum, at exactly the low endpoint 1890
    that the implementer's level (1908–1947) does not reach, and it is **literally** inside his
    `v451e2400`, which is that stage's `W` (§1(v)). So if it refuses against our companion in our
    frame it is a legal selection of our stage at weight 376 and our level should contain it. The two
    live hypotheses are the ones phase C already met: **the companion** (§S.2 #7 — *the subtype is a
    property of the pair*; his M6B L refuses with `S141` and never with `S136`) and **the frame**
    (§1(v) — containment holds only up to the group; six of 24 elements map `v136e564` inside
    `v166e774`).
  expected: the level is closed and zero-undecided, so it holds every order-3-invariant minimum
  ask: does `v376e1890 ∪ ρ·g(v136e564)` refuse four colours, over the 24 frames `g`?
  if it refuses in our frame: the level is **incomplete despite reporting closed** — far more serious
    than a rung difference, and it reaches every number this phase has produced
  if it refuses in another frame only: the stage's frame is the fault, the 18 missing vertices are the
    ones that frame reaches, and §1(v)'s warning has fired a second time
  if it refuses in no frame: his 376 level used a **different S companion**, the 14 missing minima are
    exactly those needing it, and his Table 1 L rows do not all share one S — a finding about his paper
  answered by: run — 24 refusal asks on a graph already built, seconds at the measured cost
  cost: seconds, against 45 core-minutes for the rung sweep on a box at load 9
  hunch: it refuses in no frame and the companion is the explanation, because §S.2 #7 found exactly
    this on the M6B side and nobody has checked whether it holds across his L rows too
  falsifier: it refuses in our own frame
  rank: 17

**The consequence either way:** if the companion explains it, then *"reduce his `A` and compare with
his `|{M}|`"* is not well posed unless the companion is pinned **per row** — and phase C pinned the
375 row's by measurement, not from his text. That makes the companion a per-row parameter of the whole
comparison table, which corrects how phase D's replay controls are specified rather than just this one
number.

**Fate of card 17 — answered by the implementer, 2026-09-11: the companion, as hunched.**
`v376e1890` is a rung-3 selection of our stage (125 whole atoms, 0 partial — order-3-invariant,
exactly as P8 predicted), is **not** among our 82 minima, and `v376e1890 ∪ ρ·g(v136e564)` is
**colourable in 24 of 24 frames**. So the level is complete and correctly excludes it — the alarming
branch did not fire — and **his 376 row used a different S companion**. Adopted as a correction to
D1's acceptance rather than a note: **`|M|` is comparable across his rows; `|{M}|` and the accumulator
are comparable only once that row's companion is identified.** The two 18s now have a candidate
explanation rather than a coincidence, and the companion hunt tests it — run with a positive control
(`v375e1920 + S136` must refuse in some frame) before any negative is believed. The 45-core-minute
rung sweep is kept as the first complete order-2 / order-6 census on that stage, with the record
stating what it was launched as.

### Registered before the edge phase-1 count exists

The implementer's edge instrument is green (the assembled 509 reconciles with `1860 + 564 + 12 + 6`;
the §O6 degree floor fires on a planted degree-3 vertex) and its phase 1 is running: 2,439 asks, since
a singleton correction set **is** a critical edge, so the count `c` is a rigorous floor on the edge
minimum.

- **Forced: `c ≤ 2,406`.** `[deGreyParts2023]`'s 36-edge reduction is itself a refusing subgraph, so it
  contains every critical edge. **`c > 2,406` would be a fault in the instrument or in their footnote,
  never a finding** — a free external calibration of a new instrument against published prior art, and
  it belongs in the artifact as an assertion.
- **`c = 2,406` exactly ⟹ the question closes today:** every individually-removable edge is one of
  their 36, and they report the 36 jointly removable, so the exact edge minimum is 2,406.
- **`c < 2,406` ⟹** there are individually-removable edges they missed; the minimum lies in
  `[c, 2406]` and the gap is the hitting-set phase's, because individually removable is not jointly
  removable.
- **My expectation, 65%: `c < 2,406`** — they state they did not search exhaustively. Falsifier:
  `c = 2,406`.

question: is-the-edge-minimum-unrestricted-or-pin-conditional
  evidence: the three pin edges are fixed as non-deletable because deleting one makes the symmetry
    break unsound (it would return `unsat` for a colourable graph). Sound and necessary — but the
    optimum the instrument computes is then the minimum over edge-subgraphs **containing the pin
    triangle**, which is ≥ the unrestricted edge minimum. The *criticality census* is unaffected: a
    non-pin deletion leaves the triangle intact, so each of the 2,439 tests is sound and `c ≤ 2,406`
    still holds, criticality being a property of `G`. **The optimum is what narrows.** And the
    comparison with 2,406 is apples-to-apples only if their object contains that triangle, which
    cannot be checked — the footnote publishes the count, not the graph.
  expected: the instrument computes the exact edge minimum of the 509
  ask: is the edge minimum this instrument computes the unrestricted one, or the minimum over
    subgraphs containing the pin triangle?
  if pin-conditional: the headline says so in those words, and the unrestricted number needs a re-pin
    on a triangle present in the candidate, or an unpinned run paying the symmetry cost — priced, and
    declined in writing if too dear
  if unrestricted: the argument is shown, because a refusing subgraph omitting a pin edge is outside
    the search space by construction
  answered by: Implementer (de Bruijn, phase D)
  cost: one sentence, or one priced alternative
  hunch: pin-conditional, and the gap is probably zero in fact and unproven in principle
  falsifier: an argument that every minimum edge-subgraph must contain that particular triangle
  rank: 18

**Fifth instance of the pattern, and the first to reach a publishable number.** The pin is worth
62–63×, is correct about cost, and silently narrows what the optimum *means* — the same shape as the
degenerate outcome (card 7), the target knob (13), the wall (15) and the empty restriction the
implementer found itself. The difference: the previous four affected a map we build for ourselves,
while this one affects a number that would be written up as *the exact edge minimum of the 509-vertex
graph*. **A conditional minimum reported as an unconditional one is the characteristic failure this
repository's own standard names.**

**Fates of cards 16 and 18 — the implementer, 2026-09-11.** **Card 16 measured at 1.4×** on the first
sweep candidate, back to back on one checkpoint (primary 133.2 s, secondary 186.3 s) — but on the
**cheap** polarity: that candidate *grew*, so the restricted search found an optimum instead of
certifying non-existence. My caution was about the other branch, which is unmeasured; the hunch is
**partially confirmed (cheap branch), open (expensive branch)**, and the first non-growing candidate
settles it. The pre-declared subset goes unused and stays in the frozen protocol as the record of what
would have been done. **Card 18 repaired better than either of my proposals:** the three pin unit
clauses become *conditional on the three pin edges being present* — all three kept ⟹ the triangle is a
triangle ⟹ three distinct colours ⟹ fixing which is WLOG ⟹ the full 62×; any dropped ⟹ the clauses are
vacuous ⟹ the ask is merely unpinned. Sound in both branches, **unrestricted in scope**, and firing on
a vanishing fraction since a minimum drops ~36 of 2,442. `side_fixed = 0`, so `w*` is the edge count
with no constant to mistake. The control inverts with it: not *"the pin edges are protected"* but
**"dropping a pin edge is safe"**, with the unconditional version restored as a negative that must
read `pin-changes-answers`.

**A reading note for the artifact.** The first candidate's two rows — *"no selection at target 373"*
beside *"minimum 373 keeping a new atom"* — read as a contradiction until one holds that the shared
centre is never deletable, so `|M| = weight + 1` and weight 373 is `|M| = 374`. It stopped me for a
moment; it will stop a reader. Say it once in the frozen protocol.

question: does-his-success-criterion-still-discriminate-at-our-scale
  evidence: his successful-iteration test is *"A changed — either `|M|` fell or `{M}` grew"*
    (parts:500-504), and his own recorded growth event was 78 → 1,092 at fixed `|M|`, treated as the
    notable outcome of an entire iteration. **Candidate one of 57 grows the level by 1,692** at fixed
    `|M| = 374`, against his attested 1,092 for the unexpanded level (not yet reproduced here) — the
    level more than doubles on the first thing tried. Meanwhile the S half is ten for ten with
    bit-for-bit identical levels, so the halves differ in kind and not only in degree.
  expected: `{M}` growth is the rare, informative secondary outcome — the non-degenerate signal card 7
    feared we would lack
  ask: across the sweep, what fraction of candidates grow `{M}`, and does his success criterion
    therefore fire on nearly all of them?
  if nearly all grow: his criterion is **vacuous at our scale** — it can neither rank nor choose, so
    the loop has no stated criterion for its move and defining one becomes a phase D deliverable
    rather than an inherited constant
  if growth is rare: it is the graded, combinatorial, non-circular outcome the map needs, card 7's
    degeneracy worry closes, and growth size is the natural ranking key — subject to being *validated*
    against `|M|` outcomes rather than assumed to be progress
  answered by: run — the sweep itself answers it as a by-product; a column already being computed
  cost: nothing new
  hunch: nearly all grow; 1,692 on the first try is not how a rare event behaves
  falsifier: fewer than half the candidates growing `{M}`
  rank: 19

**The half of card 19 that is not about counting.** Growth is his criterion for *success*; nothing
shows it is *progress*. A bigger accumulator makes the next stage bigger and dearer, and his §5.11
ceiling (*"usually limited to several tens"*) is the wall that behaviour runs into — so a rule ranking
by growth may be ranking by how fast it exhausts its own budget. Same shape as FS-35's re-aim, which
saw that termination was never his problem and stagnation was; the mirror is that **growth is not the
opposite of stagnation, and neither measures getting closer to a smaller graph.** If nearly everything
grows, the loop needs a criterion separating useful growth from expensive growth, and nobody has one —
including him. **And one consequence for the map's use rather than its construction:** it evaluates 57
candidates against a *fixed* accumulator, so the moment one is accepted the menu changes. The map is
sound for choosing the loop's **first** move and not its second, which belongs beside the map rather
than being discovered when the second iteration disagrees with it.

**The target's saving is smaller than its derivation said, and the correction is mine as much as
theirs.** The mechanism — *"the target's saving is exactly the level enumeration, and nothing else"* —
is precise and I accepted it. But when the secondary **fires** it does not merely decide: it
enumerates, returning all 1,692 new minima. By the monotonicity theorem the expanded level splits
exactly as old ⊔ new, so the two-question pair enumerates the *new* part while an untargeted run would
enumerate both. **The saving is the old part only** — and on candidate one the old part (his attested
1,092, not reproduced here) is *smaller* than the new. A minority of the enumeration, not the
near-total implied. Not a reason to change the design, which still saves the old part and delivers
clause 2(c) on every candidate; but the forecast should read **saving = old / (old + new), measured
per candidate**, and card 19's hunch says that fraction is systematically unfavourable.

question: does-the-halt-on-capped-level-rule-cover-the-secondary
  evidence: when the secondary fires it **enumerates** the restricted level — 1,692 new minima on
    candidate one — and those new minima are precisely what the next accumulator is built from (the
    implementer's own words). So the secondary is a level enumeration whenever it fires; its size is
    unbounded a priori (twelve new points gave 1,692, a 24-point orbit could give more); and card 19's
    hunch says it fires nearly always. The rule *"a capped level halts the loop, and no loop may start
    from a capped union"* was written for the **primary** level, where the predecessor's card 9 closed
    it.
  expected: the secondary is a decision, so the capped-level rule does not reach it
  ask: does "a capped level halts the loop" apply to the secondary's restricted level, and what is its
    wall?
  if it applies: the secondary needs its own cap and halt, and a capped secondary may never feed an
    accumulator — stated in the same sentence as the primary's rule so the two cannot drift apart
  if it does not: a **partial** set of new minima can silently become the loop's state variable, which
    is the failure card 9 closed one level up — and worse here, because it corrupts the accumulator
    rather than a report
  answered by: Implementer (de Bruijn, phase D)
  cost: one rule and one wall
  hunch: it does not currently apply, because the secondary was designed as a decision and became an
    enumeration only at the moment it fired — which is how a rule written for one object misses its
    twin
  falsifier: the code already capping and halting on the restricted level
  rank: 20

**Two operational notes from the implementer, both worth keeping.** (i) The sweep's first launch died
on `KeyError: 'base'` because **Python 3.14 changed the default process start method on Linux from
fork to forkserver**, so workers re-imported the module and never saw the parent's state. That will
bite every multiprocessing user in this repository under the new interpreter, and the symptom points
nowhere near the cause — it belongs with the environment notes, not in this milestone's plan. (ii) The
`d6.2` behavioural plant **did not fire**: exhibiting the unsoundness needs a selection colourable
only with two pin vertices equal, which random drops do not find. It was replaced by a structural,
deterministic guard (no unit clause in one encoding, exactly three in the other) and the record says
the behavioural check is **not discriminating here** rather than keeping a tick it did not earn.
**Second control this phase replaced rather than kept on false pretences** — the first was my own
cross-edge check, which failed loudly and turned out to be mine.

question: does-the-cnf-use-the-same-broken-atom-identification
  evidence: the implementer found that `Stage.pin_is_sound` identifies pin-carrying atoms by each
    atom's **lowest set bit** — correct when an atom is one vertex, wrong at every rung above trivial,
    where an atom is an orbit and a pin vertex need not be its lowest member. At rung 3 it finds zero
    and returns the benign `pin-is-fixed`, checking nothing; **both of today's order-3 runs printed
    it**, one being D1.a, whose 82-against-96 started card 17. Its reassurance — no number retracted,
    because the break is sound, the clause being conditional on presence in `Stage.cnf` — is an
    assertion about a **different function** than the one found broken.
  expected: the conditional encoding is independent of the broken identification
  ask: does `Stage.cnf` identify the atoms its pin clauses are conditional on by the same
    lowest-set-bit rule?
  if independent: the receipt failed open and nothing else did; the one-line fix and the planted
    control are the whole repair
  if the same rule: the rung-3 runs were either **unpinned** (sound, but the 62× was never obtained
    there, so every cost number measured at that rung — D1.a's 63 CPU seconds included — was measured
    without it) or **unconditionally pinned** (unsound, and the rung-3 numbers need re-deriving)
  answered by: record — one read of `Stage.cnf`
  cost: minutes
  hunch: independent, since the conditional device was described as already existing for a deletable
    pin vertex, so it predates today
  falsifier: a shared helper computing pin atoms for both
  rank: 21

**A direction-of-error bound, derived, which contains the worst case without a run.** An unsound pin
can only **remove** colourings, never add them — it fixes three colours, ruling some proper colourings
out of the search and none in. So **every colourable verdict is safe regardless**, which covers card
17 entirely: its conclusion rests on 24 of 24 asks returning *colourable*, so the companion result
stands whatever the read says. Only **refusing** verdicts could be spurious, and a spurious refusal
would add a member to a level and could pull a minimum down — while both observed numbers move the
other way (82 against his 96, fewer not more; `|M| = 376`, matching exactly rather than low). The
evidence on disk is therefore consistent with soundness and the one conclusion that could have been at
risk is immune by the direction of the error. This bounds the damage; it does not establish there is
none, so the read still has to happen.

**Card 20's disposition, recorded because the framing matters.** Implemented rather than noted, with
both rules in one sentence so twins cannot drift apart: a secondary whose restricted level did not
close now reads `yes-but-level-truncated` — growth established, since one witness suffices, count a
lower bound, **and the entry may not seed a loop iteration**. The implementer also noted the risk was
**latent rather than live** (the secondary runs uncapped, so it exhausts unless an individual ask times
out, and every entry on disk carries its undecided count, making completeness computable after the
fact). That is the more honest framing and worth keeping in those words: a fix closing a door nobody
walked through is worth less than one that rescues something, and saying which costs nothing.

**Fate of card 21 — answered by me, with a grep I should have run instead of asking.** `Stage.cnf`
is **correct at every rung**, and the defect is confined to the control. Lines 176–181 build `of` by
walking **every** set bit of each atom (`mm &= mm - 1` clears the lowest each pass), so the
lowest-set-bit expression at line 179 is the standard bit-*iteration* idiom, not a representative, and
`of` is a complete vertex→atom map. Line 205 then takes `ai = of.get(v)` for each pin **vertex**, so
the conditional literal `-sel[ai]` names the atom that actually contains it, wherever it sits in the
mask; absent from every atom means fixed, and the clause is unconditional, which is right.
`pin_is_sound` line 218 tests `((m & -m).bit_length() - 1) in self.pin` — the lowest bit only. **So no
numbers move at any rung**, the second branch closes too (the pin clauses *were* emitted at rung 3, so
the 62× was genuinely obtained and the rung-3 costs stand), and my direction-of-error bound is a belt
nobody needs. **The one-line fix is the CNF's own construction:**
`[ai for ai, m in enumerate(self.atoms) if any((m >> v) & 1 for v in self.pin)]`.
And the comment at 197–203 raises the stakes rather than lowering them: **this exact unsoundness was
live, on a run reporting a 373-vertex L-subgraph — one below the world record — and `pin_is_sound` is
what caught it.** A receipt that once caught a record-breaking false positive and has since been blind
above the trivial rung is the strongest argument there is for the rule that found it.

**The reproduction, and where the rest stood at the time of writing.** Against `v166e774` his state 1
returns **376, 96, `A = v451e2400` literally, and edges 1890–1947** — all four attested numbers, both
endpoints exact, closed, zero undecided, 139 s, and 96 under all three counting conventions. **The
three symptoms were one cause**: the 14 missing minima, the 18 missing points and the 18-edge-short
range bottom were one wrong pairing seen from three directions. The sweep stood at 22 of 89, every
candidate "cannot beat 374"; the edge census at 1,200 of 2,442 with **330 individually removable**,
steady near 27%.

question: which-edge-deliverable-is-this-phase-buying
  evidence: extrapolating 330 of 1,200, about **670 of 2,442 edges are individually removable**, so
    `c ≈ 1,770` and the exact minimum lies in roughly **[1,770, 2,406]** — a window of some 630 edges.
    My 65% call resolves on the low branch, but the *margin* is the finding: **~670 individually
    removable against only 36 known jointly removable** (`[deGreyParts2023]`). That gap is the entire
    difficulty, and it means the exact minimum is a hard hitting-set instance rather than a sweep.
    Meanwhile a **greedy 1-minimal pass** — test each edge in the current graph, drop it if refusal
    survives, repeat — costs a few thousand asks at the measured rates and yields a certified refusing
    subgraph with an exact edge count: an *upper* bound, directly comparable with 2,406.
  expected: "the exact edge minimum" is one deliverable at one price
  ask: is the phase buying the exact minimum, or a greedy 1-minimal upper bound, and does it know they
    differ by orders of magnitude in cost?
  if greedy first: a few thousand asks plausibly beats the published 2,406 outright — a record on his
    own tie-break, bankable before the implementer's context runs out
  if exact only: it may not finish, and the phase ends with a floor near 1,770 and no object, which is
    a real result but not the one the acceptance implies
  answered by: Implementer (de Bruijn, phase D)
  cost: one decision; a few thousand asks for the greedy pass
  hunch: greedy first, exact as a stretch — an upper bound you can certify beats a floor you cannot
    close, and they are not alternatives, since greedy also seeds the hitting set
  falsifier: the hitting set closing the 630-edge window cheaply
  rank: 22

hunch: the-companion-is-the-other-sides-accumulator
  claim: his companion at each row is **the other side's accumulator at that point in his alternating
    loop**, not that side's minimum — state 1 reproduces against the S accumulator `A166` while the
    375 row reproduced against the S minimum `S136`, so the companion is not merely per-row but may
    follow a rule
  basis: measured
  falsifier: a remaining row reproducing against a companion that is neither the other side's
    accumulator nor its minimum at that state, or state 1 also reproducing against `S136`
  registered: 2026-09-11
  status: open — the remaining rows test it for free. If it holds, phase E can **name** each row's
    companion in advance instead of searching for it; if it fails, the companion is ad hoc and every
    held-out row costs a search first, which is a cost fact phase E needs before it starts

### P9 — his involution is the same one in every published 374 row (30 s, no solver)

*The implementer's order-2 row returned `|M| = 374` with **78 minima, his attested number exactly**,
but a 402-vertex accumulator against his 406 and an edge range shifted low by eight, and read it as
"the same signature as before". **It is not.** At state 1 the level count did not land (82 against 96);
here it does. A wrong companion gives a **subset** level — fewer minima, smaller accumulator, which is
state 1 exactly. An **equal-sized** level with a smaller accumulator is a different phenomenon. My own
hypothesis was that "the order-2 rung" is ambiguous, since there are fifteen involutions in the
order-24 group and seven in the stage's order-12 stabiliser — unlike order 3, which P8 showed is a
unique subgroup. Measured before sending:*

```
v374e1868  (M6A rung 2)      stab order  2   fixing [0, 23]
v374e1864  (M6B rung 2)      stab order  2   fixing [0, 23]
v374e1872  (M6C rung 2)      stab order  2   fixing [0, 23]
v374e1860  (the RECORD's L)  stab order  2   fixing [0, 23]
v406e2082  (his rung-2 A)    stab order 12   fixing [0,2,4,6,10,12,13,15,16,18,21,23]
v412e2106  (his rung-1 A)    stab order 12   fixing [0,2,4,6,10,12,13,15,16,18,21,23]
```

**The ambiguity hypothesis is dead:** every published 374 minimum, across all three subtypes and both
his rung-1 and rung-2 rows, is fixed by exactly `⟨g23⟩`. **So his rung is recoverable from his own
files by a stabiliser computation with no solver** — and paired with the companion rule, *both*
parameters of his loop are readable off his published objects. That is worth more to whoever takes
clause 2(b) than to this row. Calibration: both accumulators give order 12 with *identical* fixing
sets, matching `v451e2400` and `v403e2112` from P8 — **accumulators are order-12-invariant while
their members are order-2 or order-3**, the orbit-closure story from another direction.

question: is-the-records-own-L-in-our-rung-2-level
  evidence: P9 — `v374e1860`, the record's own L half, is invariant under exactly the involution his
    rung-2 rows use, and carries 1,860 edges, while his rung-2 range starts at **1,868**. So **his
    rung-2 level omits an order-2-invariant 374-vertex refuser with fewer edges than anything in it**,
    and the implementer reports our range shifted low by eight, which reaches 1,860.
  expected: an order-2-invariant 374 refuser lies in his order-2 level
  ask: is `v374e1860` among the 78 minima our rung-2 run returned?
  if yes: our 78 and his 78 are different sets of the same size, ours containing the record's own L
    and his not — completing the "same count, smaller accumulator" puzzle and making the companion the
    difference here too, by a route that does not need the counts to differ
  if no: the equality of counts needs another explanation, and two levels coinciding while their
    accumulators differ would be a fault rather than a companion
  answered by: record — one membership test against the level already on disk
  cost: seconds
  hunch: yes
  falsifier: `v374e1860` absent from our level
  rank: 23

hunch: the-order-2-rung-is-ambiguous
  claim: "the order-2 rung" names one of seven involutions in the stage's order-12 stabiliser, so the
    implementer's rung-2 row may simply be a different subgroup from his — a wrong-rung explanation
    rather than a wrong-companion one
  basis: derived
  falsifier: his published rung-2 minima all sharing one involution
  registered: 2026-09-11
  status: killed (by: P9 — all four published 374 minima are fixed by exactly `⟨g23⟩`, the same
    involution, across three subtypes and two rungs. What the miss cost: nothing; formed and tested
    in one step, and it converted into the useful finding that his rung is recoverable without a
    solver)

**Fate of card 23 — answered solver-free and *forced*, 2026-09-11, and it corrected the implementer
twice.** If the record's own L half is invariant under a rung's group and is a union of that rung's
atoms, it is a feasible weight-373 selection; since `w* = 373` it is a minimum; so an exhaustive level
at that rung must contain it. Measured over the seven order-2 rungs: `v374e1860` is invariant and a
union of atoms at **`H2#4 = ⟨g₂₃⟩` and at none of the other six**. **And the row reported to me as
"374 with 78 minima, his attested number exactly" was `H2#0 = ⟨g₁₅⟩`, not his rung** — so that 78 was
a coincidence of count between two different problems. The correction that stopped it becoming a claim
was the separation insisted on in P9: at state 1 the count did *not* match and the level was a subset;
here the count matched and the rung was wrong. Two phenomena that both look like "nearly reproduces"
from a distance.

question: why-does-his-rung-2-range-start-at-1868
  evidence: his two M6A rows are **one working graph at two rungs** (M63 §4, §S.2 #9:
    `A406 ⊆ g(A412)`), so they share a companion, whatever it is. `v374e1860` is in his **rung-1**
    level (it is that row's low endpoint, and the file exists); it is `⟨g₂₃⟩`-invariant with
    stabiliser **exactly** 2 (P9) — which is also what his own `1 (2)` notation claims for that row's
    fewest-edge member, so his table and the measurement agree; his **rung-2** level is the same
    problem restricted to `⟨g₂₃⟩`-invariant selections at the same weight; `v374e1860` satisfies the
    restriction. **So it must lie in his rung-2 level and that range must start at 1860. He publishes
    1868–1884.** The argument needs only that both rows share a companion, not which.
  expected: his two rows at one working graph are mutually consistent
  ask: is his 1868 a truncated level, a different companion, or a typo?
  if truncated: his `|{M}| = 78` and `A = v406e2082` are **lower bounds, not counts** — and M63 §3(b)
    already flags his `{M}` as complete-or-truncated with no statement either way, which reaches every
    rung-2 comparison in the table
  if a different companion: his rung-1 and rung-2 rows do not share one, contradicting the
    one-working-graph-two-rungs reading and sharpening the companion rule to vary between adjacent
    **states**
  if a typo: two are already demonstrated (M63 §1(ii), Table 3's `A` column), 1868 against 1860 is one
    digit, and the row is otherwise exact
  answered by: run — D1.c at `H2#4` produces our low endpoint, **forced to 1860** by the same
    invariance argument; the comparison with his 1868 is then a known mismatch with three candidate
    causes
  cost: nothing new — it is the run already being walked towards
  hunch: typo or truncation, not split further; what is confident is that it is **not our fault**,
    which is exactly what a mismatch at D1.c would otherwise be read as
  falsifier: our `H2#4` low endpoint coming out at 1868, which would break the invariance argument and
    mean something is wrong on our side after all
  rank: 24

**Registered before D1.c reaches `H2#4`: our low endpoint will be 1860.** That is the value of card 24
— when the run lands, 1860-against-1868 is a prediction confirmed rather than a reproduction failure.
Without it, the natural reading of "our range is eight low again" is that we have the wrong companion a
second time, and that reading would be wrong.

**The methodological half, for the handoff.** The `H2#0` coincidence is an instance of what phase E
meets on every held-out row: **a check comparing seven of our runs against one of his numbers has
seven chances to match by accident.** The count 78 landing on the wrong rung is exactly that, and it
nearly became a claim. The discipline that removes it — compare only against the run identified as his
— is made *cheap* by P9: the rung is a stabiliser computation and the companion is the rule, so the
pinning is available **before** any run rather than argued after. The capability removes the hazard
that motivated it.

### The sweep's verdict, and two of my hunches scored against it

**Card 16's expensive branch, measured over 56 candidates, inverts.** Certifying non-existence:
primary mean 210.6 s, secondary mean **28.9 s**, median ratio **0.1**, max 0.5. Correction sets 472.7
against 479.4 — **six** fresh ones. So the branch I flagged as the worry is the cheap one, by twenty.
Mechanism: requiring a new atom *adds weight*, so the constrained bound clears the target almost
immediately on the inherited `Y`. The expensive case is **enumerating when a solution exists** — the
1.4× and the `old/(old+new)` correction — so both halves are one mechanism rather than two
observations. My caution was right in form and the world went the other way.

hunch: the-expensive-polarity-needs-a-fresh-harvest
  claim: certifying that no `Δ`-using selection exists at `w*` needs correction sets the first run had
    no reason to harvest, so the second decision is a second certification rather than a cheap rider
  basis: derived
  falsifier: the restricted decision certifying non-existence at a small fraction of the primary's cost
  registered: 2026-09-11
  status: killed (by: 56 candidates, median ratio 0.1 and six fresh correction sets. Right in form,
    wrong in outcome, and in the favourable direction)

hunch: nearly-all-candidates-grow
  claim: `{M}` growth fires on nearly every candidate, so his success criterion is vacuous at our scale
  basis: derived
  falsifier: fewer than half the candidates growing `{M}`
  registered: 2026-09-11
  status: killed (by: **1 of 58 grew**. The first candidate was *the* one, and I promoted structure
    seen once — a named failure, and mine. The implementer's added reason failed the same way, from
    the same single point. **The second half survives untouched:** growth is his criterion for success
    and nothing makes it a criterion for progress)

**What the falsification gives back, and it is stronger than "inert".** A minimum has weight exactly
`w*`, so using a new atom means dropping an old one. Growth failing on 57 of 58, and on 10 of 10 on
the S half, says **the added material is essentially never in *any* optimal solution** — not merely
insufficient to improve, but unused — and the two halves agree independently on different
accumulators. **That is evidence for card 8:** if no single orbit is ever used by an optimum, whatever
made his four-orbit move work comes from the combination, which is the promotion phenomenon the S
engineer measured. Singles being unused makes pairs the only place an answer could live rather than
merely the next rung.

question: what-scores-a-ranking-when-the-map-has-no-variance
  evidence: **0 of 58 improve, 1 of 58 grows.** Card 1 argued for the map as the ground truth against
    which rankings are scored; with no variance in either outcome every ranking ties at zero and the
    map scores nothing. What it establishes is clean and complete — single-orbit expansion from `A412`
    does not reach 373, every per-entry invariant firing, zero undecided asks — but that is an
    **answer**, not a scoring surface. Clause 2(b) still requires a registered rule, and the fresh
    agent taking it will open this map expecting ground truth and find a column of zeros.
  expected: the map would carry enough variance to rank per-orbit devices
  ask: with the map signal-free, what scores the rule clause 2(b) requires — the pair sweep, the
    `A403` map, or one bit from the held-out row?
  if the `A403` map: it is the only place a positive is known to exist nearby, since his own recorded
    move reached 374 from that state — so it discriminates whether singles are inert **at that state**
    or inert **in general**, which is the difference between a tuning failure and a fact about singles
  if nothing does: say so in the handoff — the rule is scored by outcome on one held-out row, which is
    one bit, and the acceptance should say that plainly rather than imply a map stands behind it
  answered by: Implementer (de Bruijn, phase D), in the handoff, and whoever takes clause 2(b)
  cost: one paragraph now; the `A403` map is already scheduled
  hunch: the `A403` map, and singles are inert there too — closing card 8 affirmatively and making a
    single-orbit ranking the wrong object entirely
  falsifier: any single orbit improving from `A403`
  rank: 25

**Card 1, judged against its own outcome.** Its argument was that a 55-candidate map beats ranking
against his one recorded move, because one move is one bit. **The map returned less than one bit.**
That does not make it a mistake — it answered its own question completely, and a complete negative
over 89 candidates is worth more than a partial positive — but its *second* purpose is dead and the
next agent should be told in advance rather than discover it. The `A403` map changes purpose with it:
no longer a held-out test for a rule, but the discriminator for whether the inertness of singles is a
property of that state or of singles as such.

**A representation note worth carrying past this phase.** The shared centre and the two-sided index
space have now produced three faults in three agents within one afternoon: my cross-edge control
reading 54 against the record's 18 (base relation instead of the stage's induced edges); the S
engineer's frozen-image control; and the implementer's edge oracle assuming every S-indexed edge has
one L endpoint, which met the companion's own 564 internal edges. Three independent minds, three
different ways, one representation. That is no longer carelessness — **the doubled index space with a
side-owned shared vertex is treacherous**, and the standing rule that falls out of it is the one that
caught mine: *take edges from the stage, never from a relation computed on the base.*

**The pattern worth naming, since this is its third instance.** Card 7: a degenerate primary outcome
invites substituting a softer one. Card 13: the target knob makes the secondary outcome unobservable.
Card 15: a wall hit reads as a negative. **Each is an optimisation that is correct about cost and
silently wrong about meaning, and each is invisible in the number it produces.** If there is a fourth
it will be in the same family — something that makes a run cheaper by not computing the thing the map
was for — which is worth one pass over the sweep's design, asking that question of every shortcut in
it.

**Cost revision, in my own direction of error.** If the implementer's large-half forecast holds — 2–5
minutes of harvest against 20–90 minutes of level enumeration — then 57 harvests is about **five
core-hours**, not the 8–70 I priced card 1 at. My estimate was pessimistic by roughly an order of
magnitude, and the target knob is why. Not banked until the cost probe lands.

### P7 — is `abcd = 0` his small-orbit priority in disguise? No (15 s, no solver)

*Formed and tested in one step, before being sent to anyone, so it influenced nothing.* His §5.6 says
*"We noticed that all useful orbits satisfy the relation `abcd = 0`"* (parts:535). I guessed this was a
cost artifact like the disk radius — that `abcd ≠ 0` is equivalent to orbit size 24, the most expensive
size to add under his §5.11 ceiling. On `Base(2.6)`:

| | size 1 | size 6 | size 12 | size 24 |
|---|---|---|---|---|
| `abcd = 0` | 1 | 14 | 59 | **113** |
| `abcd ≠ 0` | 0 | 0 | 0 | **42** |

**One direction holds, the other fails.** Every `abcd ≠ 0` orbit has size 24, so his discarded class
lies entirely inside the most expensive size — but 113 of the 155 size-24 orbits satisfy `abcd = 0`, so
the heuristic discards 42 while keeping 113 equally expensive ones and **is not the size rule
restated**. Against the disk: `abcd ≠ 0` splits 31 inside / 11 outside, `abcd = 0` splits 152 / 35 —
mild enrichment outside, nothing to build on. What survives is weaker: his rule never cost him a cheap
orbit, so it was low-regret under his ceiling whatever its basis, and **the basis remains
unexplained** — which makes the four `abcd ≠ 0` orbits in the S engineer's promoted set a sharper test
than my reading would have framed them.

hunch: abcd-is-the-size-rule-in-disguise
  claim: his *"all useful orbits satisfy `abcd = 0`"* is his small-orbit priority restated, because
    `abcd ≠ 0` is equivalent to orbit size 24 — making it the third of his published heuristics (after
    the disk radius and the four-orbit bundle) to be an artifact of a cost regime we are 150× outside
  basis: derived
  falsifier: size-24 orbits with `abcd = 0`
  registered: 2026-09-11
  status: killed (by: P7 — 113 of the 155 size-24 orbits satisfy `abcd = 0`, so the conditions are
    not equivalent and the heuristic discards 42 orbits while keeping 113 of the same cost. Only
    `abcd ≠ 0 ⟹ size 24` survives. What the miss cost: nothing — formed and tested in one step, and
    the three-cost-artifacts pattern was never asserted to anyone)

hunch: his-successful-moves-are-sets-not-singletons
  claim: single-orbit expansions are inert on both halves, and the useful expansions are sets — his one
    recorded success was a four-set, and the S half's first seven singletons are inert with an
    unchanged level
  basis: read
  falsifier: any single orbit lowering `|M|` on either half
  registered: 2026-09-11
  status: open

---

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
