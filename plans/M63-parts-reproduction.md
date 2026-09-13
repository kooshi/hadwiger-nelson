# M63 — reproduce `[Parts2020a]`'s minimization algorithm, end to end

*Opened 2026-09-10 on Kooshi's direction: **"the next session will be 100% repro of his algo. The
session after that will be introducing our new angle on it, as described in the stub."** The stub
holding the new angle is `plans/M62-evolutionary-type-m.md`, which stays OPEN and resumes after
this. The handoff that minted this milestone is `plans/STUB-parts-reproduction.md` (FS-33, rank 1);
this file supersedes it and records where its frame was wrong.*

*The goal widened on 2026-09-11 (Kooshi): reproduce **or beat** the record. §6 is rewritten in place for
it; **§S is the current state** — what the reproduction has already met, the gap audit of every promise
below, and the roadmap C–G with acceptance checklists; phase C's subplan is
`plans/M63-phaseC-joint-stage.md`. The sections after §S are the milestone's original design and keep
their authority where §S does not revise them.*

---

## §S — Where M63 stands, the gap audit, and the roadmap (current state, 2026-09-11)

### S.1 — The goal, and what "reproduce" and "beat" accept

Kooshi, 2026-09-11, verbatim: *"Resume M63 as the product owner, and spawn fresh subagents to subplan,
then implement each phase. […] The goal is to reproduce or beat Part's record. […] Don't let the agents
lazily omit parts of the implementation. We can absolutely beat the record, it is just a matter of
implementation."* And later the same day: *"After we match or beat it, the next high value tweaks are
different base graphs, and the additional ~400 rotation angles that were discovered previously, which
should hopefully let us go even smaller."*

**The acceptance, as the product owner decided it on 2026-09-11** (answering Poros's card 3; clause 2(c)
tightened the same day on Poros's card 5). One sentence per claim, each a test that can fail:

1. **The record reproduced.** Our own minima, assembled as `L374 ∪ ρS136`, give 509 vertices and 2,442
   edges and refuse four colours, checked by SAT on exact geometry. No Lean certificate is required for
   reproducing a known object (§O(4) stands).
2. **The algorithm reproduced.**
   - **(a) Replay, as a control only — and each row names the companion his loop held at that moment.**
     Reduce his `A412` at rung 1 and at the rung-2 subgroup and compare with his 1,092 and 78 under the
     named count convention (S.2). States 3–4 turned out to be one reduction of `A412` at two rungs, which
     is exactly why this is a control and not the proof.

     **The companion is a per-row parameter of his table, not a constant** (phase D §R3.4). His loop
     alternates, so the small object it holds changes as it runs: at state 1 the small side had not been
     reduced and the partner was its **accumulator** `v166e774`; by state 2 it had been, and the partner
     was the minimum `v136e564`. Measured — his sparsest 376-vertex minimum `v376e1890` is **colourable
     against `v136e564` in all 24 frames and refuses against `v166e774` in all 24**, while four other
     published small halves refuse in none. Reducing `A451` against `v136e564` therefore returns his
     `|M| = 376` but 82 minima against his 96 and an accumulator of 433 against his 451: **a different
     problem, not a defect.**

     **So:** `|M|` is comparable across rows; **`|{M}|` and `A` are comparable only once that row's
     companion is identified**, and a row reported without one states the vertex count alone and says the
     companion is unidentified. The general form, which is what travels: *the companion is whatever his
     loop held at that moment, and it changes as the loop runs; comparing our numbers against a row of his
     table without reconstructing that state is comparing two different problems.*
   - **(b) The expansion step:** a rule, registered and committed before it runs, starting from our
     375-level accumulator (which equals his `A403`) with no knowledge of his orbits, chooses the
     expansion, and the loop reaches `|M| ≤ 374` on the L side.
   - **(c) His second success clause, honestly:** `{M}` grows at a fixed `|M|` **and a fixed rung**, in an
     iteration where the rule **added vertices** to the working graph. A rung relaxation alone does not
     count (it took `{M}` from 40 to 3,264 at 375 with no expansion, M64 §R1); his own 78 → 1,092 stays a
     replay comparison.
   - **Diagnostic, never a gate:** where the move his files imply ranks under the rule. That move is the
     other halves of `(0,0,2,2)` and `(0,0,2,6)` plus the orbits `(0,0,0,4)`, `(0,0,6,6)` (S.2). His own
     stated priorities do not single it out (Poros M3), so a rule transcribing them may not reach 374 —
     that is a finding; tuning on the L path is allowed, stamped TUNING, and followed by the freeze.
3. **Generalization — phase E is required for M63 to close.** "Reported as not run" is not an ending.
   Reducing his published `A` to his `M` tests only reduction, so at least one held-out run must start
   **below** his accumulator and reach his `|M|` with the frozen loop.
4. **Beat.** Headline: a unit-distance graph with **fewer than 509 vertices** that refuses four colours.
   Secondary: **509 vertices with fewer than 2,406 edges**, his own tie-break (`[Parts2020a]` §1, *"it is
   customary to choose among these the graph with the fewest edges"*). **Either is called a record only
   once certified in the Lean kernel** (`UDCert` plus the LRAT chain, exact geometry).

   *Corrected 2026-09-11 by the product owner: this bar first read "fewer than 2,442 edges", which was
   **already beaten in print** — `[deGreyParts2023]` discards 36 edges from the 509 and the published state
   is **2,406** (phase D's planner, §X.1). The 2,442 figure is the record as `[Parts2020a]` published it,
   not the state of the art. Two consequences, both good: an edge sweep of the 509 has a **known non-zero
   answer**, so it is a positive control as well as a record attempt; and his discard was a non-exhaustive
   greedy pass, so the exact edge minimum at 509 vertices is unrun by anyone (phase D, D6). Edge removal
   can never make a vertex removable — if `G − v` is 4-colourable so is `(G − e) − v` — so no edge sweep
   can cost the vertex claim or phase C's C4.1 control.*

### S.2 — What phase C's planning measured (2026-09-11)

Solver-free unless marked. Scratch probes, re-derived by committed instruments in phase C
(`plans/M63-phaseC-joint-stage.md` §C2); Poros's independent measurements are marked and were
re-derived here unless said otherwise.

| # | fact | how |
|---|---|---|
| 1 | **The L375 level set is his M6A 375 row.** 3,264 raw minima = **282 up to `Aut(A)`** (order 12, companion free to move), his Table 1 count; also 282 under the whole order-24 group; 3,264 with the companion fixed (`Aut(A) ∩ Aut(C)` is trivial). Poros predicted 282 first, by Burnside over M64's rung census: (3264 + 3·40)/12. | orbit count on the stored record, stage fingerprint `0700718c…` matched |
| 2 | **Our `A` equals his `v403e2112` literally** — 403 vertices, zero differing; the 12 group elements mapping ours onto his are the stabiliser. Against `v403e2106` (M6B) three vertices differ each way and no element maps one onto the other. | set comparison |
| 3 | His `v375e1920` (M6A) **is one of our minima** (12 of its group images are in the level set). His `v375e1916` (M6B) is in no image of it and inside no image of our `A`. | set membership |
| 4 | **The tails are inside his 282.** L-edge counts: body minima 1920–1930, the two tail profiles `(5,2,10,7)` (120 raw) and `(6,2,10,6)` (24 raw) at 1925–1926 — inside his attested 1920–1930. So the defect is Table 2's 375 range column, headed **"M6A&B"** — one column for runs of 282 and 66 minima. **Open, phase C3.** | per-minimum edge count |
| 5 | **M64's P9 is vacuous.** The stage carries 24 off-centre connection edges (its auxiliary orbit is full), but **every one of the 3,264 minima realises exactly 18**, through one and the same 6-subset of `(0,0,2,6)`. Deleting atoms that lie in no minimum cannot change the minimum level, so "restrict to 18 edges" cannot remove the tails. M64 §4 phase E's "our stage is genuinely wider" is withdrawn. | cross-edge census per minimum |
| 6 | His parenthetical **"1 (2)"** reproduces: the fewest-edge members (6 raw, 1920 edges) all have stabiliser order 2. | stabiliser in the base group |
| 7 | **The subtype is a property of the pair.** His M6B `v375e1916` refuses four colours with his `S141` in 12 of 24 frames and with `S136` in **none**; control: `v375e1920 ∪ ρS136` refuses. *(48 SAT asks.)* | refusal asks |
| 8 | **The joint working graph contains the record.** `v374e1860 ⊆ v412e2106` literally; the six group elements `g` with `g(S136) ⊆ A166` all give the same `g⁻¹(A166)`, which contains `S136`. `A412 ∪ ρ·g⁻¹(A166)` has 577 vertices, 2,904 edges, **576 deletable atoms**. The record stage rebuilds at 509 / 2,442. | set algebra, stage build |
| 9 | **States 3–4's accumulators are `A403` plus the named orbits plus two unnamed half-fills** (Poros M1–M2, re-derived): `A406 ∖ g(A403 ∪ O)` is the other half of `(0,0,2,2)`; `A412` adds the other half of the auxiliary orbit `(0,0,2,6)` too; `(4,0,0,0)` is already 6/6 in `A403`, so "filling orbit (4,0,0,0)" adds no vertex. `A406 ⊆ g(A412)` for 12 of 24 elements. The M6B pair behaves identically. | min over the 24 frames |
| 10 | His stated expansion priorities do not select his move from `A403`: four half-filled 12-orbits compete, and his reserve rule ranks `(0,0,0,4)`, `(0,0,6,6)` 6th and 7th of 49 eligible orbits (**Poros M3, not re-derived**; used only to keep the rank a diagnostic). | Poros record §Measurements |
| 11 | **Ask costs on our incremental oracle:** L451 — 11,942 colourable at 0.006 s and 4,741 refusing at 0.02 s, 605 s; S166 — 13,176 at 0.009 s and 3,076 at 0.108 s, 587 s. His were ~1 s and ~10 s (§5.8). | stored records |
| 12 | **Instrument defects** (reading, one ask): `parts_report.require_frozen` raises `AttributeError: 'str' object has no attribute 'hexdigest'` on first use and no self-test calls it; `parts_verify.py` rewrites its tracked artifact's date on every run (it dirtied the tree during planning; restored by path); `reduce_stage`'s checkpoint is written but never read, so nothing resumes; `Oracle.ask` has no wall, so `undecided` is structurally 0 and "zero undecided asks" cannot fail; every record's `M_set.up_to` reads "as-found frames"; both reduction records and two M64 artifacts were produced by uncommitted scripts. | reading + one ask |
| 13 | The rotation files hold the **top 150 of 412** and **top 200 of 396** classes, sieved on the Moser lattice's radius spectrum, not on the §5.6 lattice the record lives on. | the JSON |
| 14 | **The S stage's order-3 rung is exact at 142 vertices** (55 atoms, 21 minima, 129 correction sets, 67 s, closed bound); M64 §R10 had only `≥ 139` there. The full order-6 rung reproduces §R10's 142 (31 atoms, 1 minimum, 17.6 s). *(Two reductions.)* | `reduce_stage` with `rung_maps` |

### S.3 — The gap audit

*Every promise of §3, §4, §5, §O and §E, M64 §R8's not-done list and FS-35's precondition. Status:
**done** (evidence), **partly**, **not done** (named phase), **retired** (argued unnecessary here, no
approval needed because later work removed the object it was about), **drop?** (a drop that needs the
product owner's explicit approval). Row ids are stable for citation.*

**The `drop?` condition was DISCHARGED BY MEASUREMENT on 2026-09-11, and it did NOT fire.** It was
approved in conditional form (Poros card 6): the drop arguments rested on ask costs from stages
with a frozen companion, and the joint stage was the first without one, so the rows were to come
back if its asks rose tenfold. **C4.0 measured it like for like — cold and pinned against cold and
pinned — and the joint stage costs about 2× the frozen-companion stages** (6.66 s against 3.07 and
3.58), with warm-against-warm at ~3× and 3–13×. The tenfold threshold clears on neither pairing;
the 16–88× first reported was a cold figure against a warm baseline, plus a missing pin worth 62×
(§R2.4). **The cost-control rows B-8, B-11, D-6 and X-7's guard nevertheless RETURN for D, F and
G — on the per-row grounds in §R2.4b, never on the dial**, because no gated row's need was
governed by per-ask cost in the first place (Poros card 15). Product owner's ruling, 2026-09-11. **C-5 and B-12 are no longer drops at all** (Poros card 8): they carry a second role, in
phase D's expansion rule, that the cost argument never touched.

| id | promise (address) | status | evidence, or the argument | goes to |
|---|---|---|---|---|
| G-1 | `\|M\|` at 136 / 375 / 374 / 376 (§3 rank 1) | **done for all four** | 136 §R1; 375 M64 run, S.2 #1; **376 at the order-3 rung on `A451` against the companion his loop actually held there — the S accumulator `v166e774` — reproduces four-for-four: 376 vertices, 96 minima, `A` = his `v451e2400` literally, L-edges 1890–1947** (`data/m62/m63-D1a-A451-rung3-vs-A166.json`; §R3.4). Against `v136e564` the same reduction returns 376 with 82 minima and `A` = 433, kept deliberately as the object the companion finding is made of (`m63-D1a-A451-rung3.json`). **374 at rung 1 on `A412` against `v136e564`**: `w* = 373`, zero undecided asks; **374 at the rung-2 subgroup**: 374 at seven order-2 rungs. The rung-1 level is **still enumerating** (past 17,360 minima at 2.9 CPU h, checkpoint `data/m62/ckpt/m63-D1b.ckpt.json`) | the rung-1 374 level's `\|{M}\|` closes in E |
| G-2 | `{M}` ranges and the stable/unstable partition (§3 rank 2) | partly — **unchanged by phase D** | L375 ranges differ in two orbits, attributed to his column (S.2 #4). **The partition is not in his text**: "stable" means *the same non-empty vertex set in every minimum* (§6 of his paper) and is marked only by gray shading, and a single-valued range does not imply it — our `(2,0,2,4)` is 10 in every minimum with a varying vertex set. §3(c)'s "31 stable orbits" read the ranges and is therefore unproven. **C2/C3 settled the ranges and left the partition unattested** (§R2.4c): three complete levels audited, and his printed 375 column is strictly narrower than BOTH the M6A and the M6B level in the same two cells — so the column is a property of neither run. Every orbit row now carries a status measured on our own level (`stable` / `unstable-constant-count` / `unstable-varying-count`), which is the honest form of the partition; his gray-shading marker is not extracted. **Phase D extracted no shading and computed no orbit statuses on a 374 or 376 level**, so the row stands exactly where C3 left it | E, or a scoped shading extraction |
| G-3 | edge counts decomposed (§3 rank 3) | **done for four rows, and the fifth disagrees for a reason registered in advance** | audited as `Comparison` rows, low AND high endpoint each: S136 **564–567**, L375 **1920–1930**, M6B 375 **1916–1926**, all agreeing (§R2.4c); phase D adds **L376 at 1890–1947, both endpoints exact**, once the row's companion is `v166e774`. The decomposition is always whole — `e(L)`, `e(S)`, centre-cross, and off-centre cross by radius family — and `e_S_his` books the twelve centre-to-S edges to the S side as he does (§R2.6). **The rung-2 374 row reads 1860–1874 against his 1868–1884**, and that disagreement was registered as **P-D16 in a commit before the run reached that rung** and then confirmed: `v374e1860` is `⟨g₂₃⟩`-invariant with stabiliser exactly 2, so it must lie in his rung-2 level and his range must start at 1860. Reading **both** endpoints prunes the causes to one live reading — a companion incomparable with `S136` (§H2.9). The rung-1 374 row's range waits on its enumeration | rung-1 374 → E; the 24-frame test that would settle his rung-2 row → E |
| G-4 | `{M}` grows at fixed `M` (§3 rank 4) | **phenomenon observed; clause 2(c) NOT MET, and now not met twice over** | the complete 89-candidate sweep of `A412` grew `{M}` **once, at fixed `\|M\| = 374` and fixed rung 1 with vertices added — 1 of 63 menu candidates, 1,692 new minima, 0 of 26 shoulder candidates** (`data/m62/m63-map-A412.json`), but that candidate came from the sweep's seeded random block and **clause 2(c) requires the RULE to have added them**. The frozen rule's own run then produced no growth at all: six iterations, every one `unchanged` (`data/m62/m63-loop-A403.json`, commit `0139f29`). The replay comparison 78 → 1,092 (S.1 2a) is a separate clause and waits on the rung-1 374 level closing | 2(b) follow-on, then E |
| G-5 | `\|{M}\|`, `\|A\|` reported (§3 rank 5) | **done for four rows** | under his convention (the stabiliser of the reduced part, companion free): **8 / 166**, **282 / 403**, **66 / 403**, each matching his Table 1 with `A` equal to his published accumulator LITERALLY; phase D adds **96 / 451** at the order-3 rung once the companion is `v166e774`. All levels closed under the counting group, so these count orbits contained rather than orbits meeting (§O6, §R2.4c). Reported, never gated. **Two further phenomena are on record and are not defects:** at the rung-2 374 row our count equals his 78 while `A` is 402 and is not his `v406e2082` up to the group, and the two 78-member levels are **incomparable** — each contains a member the other lacks (§R3.13, §H2.9). Per S.1 2(a), `\|{M}\|` and `A` are comparable only once that row's companion is identified | the rung-1 374 row → E |
| G-6 | held-out set (§3): S M6A, 8/3 mono-pair, √3 triple, L M6B/M6C | partly | S M6A reduction was spent as the calibration (§R1) | E (required, S.1 #3) |
| A-1 | 43 files parse to their filenames (§4 A) | done | 40/43 exact plus three findings, §1; `parts-ref11-verified.json` | — |
| A-2 | every lattice graph inside `Base(2.6)` | done | §1(vi) | — |
| A-3 | the 509 splits `1860+564+12+6` | done | §1(i) | — |
| A-4 | `v374e1860` vs Table 3's `M` column | done | §1(iii), four in-range differences | — |
| A-5 | `v136e564` vs Table 4 M6A | done | §1(iv) | — |
| A-6 | `v412e2106` vs Table 3's `A` column | done | P1, §1(ii) | — |
| A-7 | Table 5 (−16) and Table 7 (+3) `A` columns vs `v375e1862`, `v289e1389` | **partly — unchanged by phase D** | each `A` file sums EXACTLY to its own caption (375, 238, 289), so both discrepancies live in his printed per-row columns and not in his data — the same shape as Table 3's, whose file has 412 against a column summing to 402. **c2.9 fired**: Table 6's column transcribed row by row against `v238e1131` gives **zero differing rows**, so the checker can agree and not merely differ. Tables 5 and 7 remain **NOT-COMPARED** row by row (§R2.4d). **Phase D did not transcribe them**: they sat behind the replays in §5's order of work and the replays were overtaken by the companion finding. The two tables are the accumulators of E's own held-out problems — the 8/3 mono-pair `v375e1862` and the √3 triple `v289e1389` — so the transcription is cheapest in the phase that runs those rows | **E** (was D) |
| A-8 | the invariance group of the three off-base files | retired | §1(vi) bounded it out: none is on the path or in the held-out set | — |
| B-1 | key property with a frozen-side companion (§4 B) | done | `parts_stage.Stage` | — |
| B-2 | mono-pair companion (an edge) | not done | — | E |
| B-3 | non-mono-set companion (a joined 3-clique) | not done | — | E |
| B-4 | pendant companions setting the symmetry | drop? | output symmetry is set by `rung_maps` (M64 §R4); input-symmetry dedup is empty on type-M stages because `Aut(W ∪ C)` is trivial (S.2 #1). Revisit only if an E stage has a nontrivial `Aut(W ∪ C)` | — |
| B-5 | the §5.9 3-clique pin | done | `Stage.pin_is_sound`, self-test fires | — |
| B-6 | radial vertex order | done | base order, `Stage.cnf` | — |
| B-7 | five-vertex pin for the √3 triple | not done | — | E |
| B-8 | cyclic implication chain for mono-sets | drop? | an encoding alternative to the clique companion; asks cost ≤ 0.11 s (S.2 #11), nothing to accelerate; E revisits if the triple's asks are slow | — |
| B-9 | one-time CNF | done | `parts_reduce.Oracle` | — |
| B-10 | controls: `v374e1860 ∪ ρS136` refuses; single deletions colourable | **done** | c4.1's phase-1 census over the record with BOTH halves deletable reads 508 critical / 0 droppable / 0 unknown — every single-vertex deletion on either side is colourable — and the level is the record itself, uniquely (§R2.2) | — |
| B-12 | the 8-4-2-1 batching of phase 1 (§2, his §5.8) | **done in its look-ahead role — and the quantity it prices is degenerate** | `parts_rule.look_ahead` deletes eight necessary atoms at once from the enlarged graph and one refusal frees all eight — sound because the property is upward closed; a colourable answer halves the batch, and an `unknown` counts the batch as NOT freed and is reported, so a budget fact never reads as a graph fact. **The batching works and what it measures does not discriminate:** the proxy reads **0 freed of 336 necessary atoms on every single orbit tried, including an orbit his own recorded move used** (§R3.b). Poros's reading, carried because it bounds the claim: freeing a necessary atom needs the graph without it to refuse, and every edge from the new material to that atom vanishes with it, so the proxy watches only the *singleton* correction sets — **whether any single orbit widens a NON-singleton correction set is unmeasured, and that is the cheaper route**. Its phase-1 role remains unnecessary at the measured costs | the unmeasured half → 2(b) follow-on |
| B-11 | each lever measured against a recorded trace | drop? | priced against his 10 s asks; ours are 0.006–0.11 s; revisit in F/G if asks grow 100×. **Caveat for E's √3 row** (Poros): his attested 0.2 s there was measured *with* the five-vertex assignment, which he reports at ~10× and which fails for the 1/√3 triple — so that lever is part of the number's provenance, and a timing compared with his must say whether it was on | E (the √3 row) |
| C-1 | degree 2 by `hyperedges_run.py` on M62's arena (§4 C) | retired | `reduce_stage` harvests every degree lazily (sizes 1–10 stored, M64 §R3); M62's arena is off the path (M62 §R23) | — |
| C-2 | degree ≥ 3 harvested | done | same | — |
| C-3 | every hyperedge re-verified by an independent rebuild; no hyperedge contains another | not done | correction sets are verified by construction only | C2 |
| C-4 | hyperedge counts carry their enumeration | done | `Count(…, "harvested")` | — |
| C-5 | the cheap statistics: non-isolated count, component profile, `α`, the `2^m` induced-matching bound, `α + \|free\|` test | **not done** | they have a second role my drop argument missed (Poros card 8): the free-vertex count, the small-degree hyperedge counts and `α` of the degree-2 graph **are** §5.10's numerical indicators, and §5.6's third strategy ranks candidate expansions by them. **D2 was not implemented in phase D** — no `indicators` exists anywhere in `tools/` at HEAD — so none of the three quantities is in committed code and **P-D1 is unscored**. The ordering reason for scoring his device first is spent (the rule is frozen and has run), but the question is not: *no published device of his selects his own recorded move* is now established for §5.6's priority sentence and for the reserve's degree order at both the single-orbit and the set-valued rung (§R3.b2), and §5.10's indicators are the one device still untested. Their *sizing* role is still superseded | **2(b) follow-on** |
| C4-1 | the joint minimum over his two accumulators, both halves deletable (phase C4) | **partly — bracketed, not closed** | two runs of ~4.9 h each, neither reaching an optimum: C4a (the record's frame) **504 ≤ \|M\| ≤ 509 vertices**, C4b (the second frame) **500 ≤ \|M\| ≤ 577**, both from the MaxSAT bound over harvested correction sets, `minima 0`, `undecided 0`. The problem is a minimum hitting set over **153 free atoms** (423 of 576 are forced by phase 1, and his record keeps 85 of the 153, against ≥ 80 proved) | D (collect the verdicts from the checkpoints) |
| D-1 | enumerate the whole optimal level (§4 D) | done | `reduce_stage`, `exhaustive-level` | — |
| D-2 | dedup by the input group before verifying | retired for type M; **the phase D rider is DROPPED** (approved 2026-09-11) | `Aut(W ∪ C)` is trivial (S.2 #1); the 12-fold multiplicity is `Aut(A)` with the companion moving, not a symmetry of the stage, so images must still be verified. The rider — *"D may measure propose-images-as-candidates on the `A412` level"* — was **not run**, and the sweep removed its motivation: every single orbit in the closed menu has been evaluated and refused (0 of 63), so a different *generator* of single-orbit candidates cannot help at that state. The live question is multi-orbit, which is a different rider (see M64-2). **Dropped, approved 2026-09-11 — a measurement removed its consumer, not fatigue**: the complete sweep's zero leaves nothing for a different single-orbit *generator* to feed | **dropped** (approved 2026-09-11) |
| D-3 | `A = ⋃{M}` | done | §R1, S.2 #2 | — |
| D-4 | `A`'s growth curve and a stall stop | **done, and exercised end to end** | `parts_rule.run_loop` carries the per-iteration history and a stall counter feeding his own escape (raise the vertex budget and re-rank); `stalled` is a verdict, not a success. **Exercised on the held-out state**: six iterations from the 403-vertex accumulator, `unchanged` each time, the escalation firing at the third stall (vertex budget 12 → 40), `many_then_trim` reached at the last rung, verdict `stalled` at 3,715 s (`data/m62/m63-loop-A403.json`). The history rows carry `(iteration, verdict, \|M\|, vertex budget, elapsed)`; `\|{M}\|` and `\|A\|` per iteration are O-3's gap and are not in them | — |
| D-5 | S level to exhaustion | done | §R1 | — |
| D-6 | the level in parallel | drop? — the level half stands dropped, the across-candidates half returned and ran | levels still close in minutes on one core, so the level-parallel item is unchanged. The half §1(c) brought back for D is parallelism **across candidates**, and it ran: 89 independent candidates at **12 workers**, 1,801 s wall (`data/m62/m63-map-A412.json`). **Control d6.4 — a `jobs=16` run agreeing with `jobs=1` on the same candidates — was not exercised**, the map having run only at 12, so the parallel path's agreement rests on the per-entry invariants (the restriction identity and the known-answer anchor, both firing on all 89) rather than on a serial comparison | d6.4 → wherever the map is next run (2(b) follow-on / F) |
| D-7 | the **exact** edge minimum of the 509, an item no plan carried before phase D's §PA(e) found `[deGreyParts2023]` fn. 2 | **partly — bracketed, not closed** | the edge minimisation is the same reduction with edges as atoms, so `reduce_stage` needed no change (§M collapse 1). **Floor `e_min ≥ 1831`**: the individually-critical census completed at 1,831 critical, 609 individually removable, 2 undecided — and an undecided ask is recorded as *not* critical, so the floor is understated rather than overstated (`data/m62/m63-edge-phase1-509.json`). **Certified upper bound `e_min ≤ 2279`**: a greedy 1-minimal pass dropped 163 of 2,442 edges and the object passes all six verification legs — unpinned refutation in a separate process with a different CaDiCaL, exact geometry on all 2,279 edges with the cross edges re-derived from the *stated* rotation law, minimum degree 4, an LRAT replay by our own checker over 7,699,212 RUP steps with five planted faults all firing, and colourability controls both ways (`m63-edge-greedy-509.json`, `m63-edge-verify-509.json`). **The hitting set over the 448-edge window is unrun**, so the exact minimum is unknown. **The object is a measurement and not a record**: its kernel certification was cancelled by Kooshi — thinning his graph is not our product — and the route measurement is in `plans/M63-kernel-certification-route.md` | the exact minimum → F; no certificate before a graph of our own |
| E-1 | expansion: partial orbits first, then the reserve `R` (§4 E) | **done** | `parts_loop.menu_candidates` (fills first, then the reserve in his decreasing-degree order) and `parts_rule.many_then_trim` (his SECOND published strategy, which no earlier plan carried). The menu is enumerated under three **named** readings with the adopted one recorded in every artifact — 49 strict / 57 literal-internal / 57 literal-plus-cross on `A412` — and the **fills exemption his degree test misses is measured**: 17 partially occupied orbits of which **5 are fill-only**, so the menu is **62**, plus **26** shoulder candidates at degree exactly 3 (`parts_loop.menu_census`). His stated priorities remain non-decisive on his own move (Poros M3; §R3.b2 adds the set-valued rung), which is why the ranking is ours and frozen | — |
| E-2 | L and S alternating against a frozen companion | **partly** | the **L** loop ran against the frozen companion `v136e564` — six iterations, verdict `stalled` (`m63-loop-A403.json`) — and the **S** side was swept by the scoped probe (`plans/M63-probe-S-expansion.md`), so each side has now been expanded against a frozen partner. **The alternation itself was not run**: every phase D run holds one side frozen for its whole life, and nothing fed an improved L minimum back into an S reduction | the alternation → E; the joint → F |
| E-3 | the rung set by pendants | retired | B-4 | — |
| E-4 | stall escape by more new vertices | **done, and exercised** | his own escape, as an explicit schedule of vertex budgets frozen in commit `6158162` (`escalation_schedule` `[12, 40]`) rather than tuned during the run; at the last rung it reaches `many_then_trim`, the set-valued move. **It fired**: at the third stall the budget rose to 40 and `many_then_trim` proposed **48 vertices across six orbits**, which returned `no` with its bound closing (§R3.b). **And the trim is exonerated as the binding constraint**: all 30 vertices of his own recorded move survive it in zero passes, at degrees 4 (×15), 6 (×9) and 8 (×6) against a threshold of 3 — `trim-preserves-his-move` (`data/m62/m63-trim-test.json`). The binding constraint is the cap of six interacting with the ordering | — |
| E-5 | the four-state path | partly — **three of the four states now name their companion** | state 2 met (S.2 #1–2); **state 1 reproduces four-for-four** once its companion is identified as the S accumulator `v166e774` (§R3.4); states 3–4 are one reduction of `A412` at two rungs, of which the rung-2 row disagrees with his printed edge range in the way P-D16 predicted in advance, and the rung-1 row is still enumerating | E |
| E-6 | state 1 from its input (Heule-529's `L393`) | retired | not held; state 1's *output* is checked by reducing `A451` at the order-3 rung (D). `G529` is public at `github.com/marijnheule/CNP-SAT` (`[Heule2019]`) if ever wanted | — |
| P1 | Table 3's `A` sums to 402 | met | §1(ii) | — |
| P2 | `v166e774 → 136`, 8, 564–567 | met | §R1 | — |
| P3 | `v451e2400 → 375`, varying only where Table 2 marks unstable | partly | 375 met; two range differences (S.2 #4); partition needs the shading | C2, C3 |
| P4 | degree-2 count on the 757 arena in the tens | retired | the arena is off the path | — |
| P5 | MIS enumeration infeasible on 757, affordable on `A412` | retired | explicit MIS enumeration is not implemented | — |
| P6 | §5.10 indicators subsumed by `exact.py` | **restated, and not done** | the comparison with `exact.py` is off the path, but the indicators are not: the useful form is *do they rank the orbits his own move used above the rest?* (Poros card 8). **Phase D did not implement them** (see C-5), so **P-D1 is unscored and P6 is undischarged** | **2(b) follow-on** |
| P7 | seeding `exact.py` with the degree-2 census | retired | same | — |
| P8 | one iteration `A412 → 374` ≈ 3.5 h ±2× | **scored, and the revised forecast is exceeded** | the original assumed 2–4 s asks; measured 0.006–0.14 s (S.2 #11, §R3.1). D registered a revised forecast of **20–90 min on one core for ~13k raw minima**. Measured: the *optimum* is reached cheaply — `w* = 373`, zero undecided — but the **level enumeration has passed 2.9 CPU hours and 17,360 minima and is still running**, so the forecast's binding assumption was the level size, not the per-ask rate. That is P-D10's replacement derivation seen from the other side: **the cost of a reduction at this scale is the enumeration** | close the number when the enumeration lands (E) |
| O-1 | the completeness invariant (§O 1) | done | `reduce_stage` | — |
| O-2 | `exact-at-rung`; the rung travels with the number | done | `Bound.render` | — |
| O-3 | per-iteration `(\|M\|, \|{M}\|, \|A\|)`, `stalled` as a verdict, stall feeds expansion | **partly** | `parts_rule.run_loop` logs a per-iteration line with the verdict, `\|M\|`, the vertex budget and the stall counter, and checkpoints per iteration; `stalled` is a verdict and the loop ended on it. **The richer line of §E is still not wired** — `\|{M}\|` and `\|A\|` deltas, `Y`'s shape, the candidate count, the target, the correction sets, both ask populations, the checkpoint's age and the `kill-safe:` clause — and **`parts_report.iteration_line` is still defined and never called** (checked at HEAD) | E |
| O-4 | kernel certificate declined for M63 | standing | for the reproduced 509 (S.1 #1); reversed for any beat (S.1 #4) | F |
| O-5 | vacuity verdicts `base-fails` / `no-reduction` / `companion-suffices` | **done** | `companion-suffices` added and fired on a stub oracle (c1.4); `no-reduction` moved to the branch it names (`w* = total weight`), where c4.1 then landed on it | — |
| X-1 | no verdict word for optimality (§E) | done | `Bound` | — |
| X-2 | a count carries its method | done | `Count` | — |
| X-3 | `\|{M}\|` names its group | partly | the type exists; every record writes "as-found frames" | C1 |
| X-4 | comparisons carry their mode | **done** | `parts_audit.audit_level` emits them, stamped `TUNING - not evidence`, each with its attestation count; and **absence is never a blank** — a field his table does not attest, or one our level is too truncated to support, prints as `not-compared` with the reason. The S166 audit's 14 `not-compared` orbit rows are that rule working (§R2.4c) | — |
| X-5 | the freeze is a commit (`require_frozen`) | **done** | two defects fixed in C (a hex digest of a hex digest; an `.items()` diff that raises on a nested list); `_freeze_control` plants all five cases in a scratch git repository and all five fire. **Phase D made the freeze**: commit `6158162`, artifact `data/m62/m63-freeze.json`, **before** the scored run, with `require_frozen` exercised red and green — the frozen configuration passes and a configuration with one parameter changed is refused by name. The freeze states **in advance** what happens if the held-out map is signal-free (the rule is then scored by one bit on one held-out row, and the acceptance must say so) and carries four bans, including that no ranking may be graded against an outcome it also predicts | — |
| X-6 | the per-iteration line | **partly** | a line exists and carries four of the specified quantities; the specified line does not (see O-3) | E |
| X-7 | a level forecast before entry, and refusal of an unboundable level | **done in its replacement form for the sweep; not for the loop** | `parts_report.level_forecast` computes a forecast and **names its assumption in the same breath** (exercised in that module's self-test), and `parts_loop map --dry-run` prints a pre-launch forecast in asks and correction sets at the measured D0 rates, with the secondary decision's factor declared **unmeasured** and the first candidate named as what measures it. `max_minima` and the conflict-slice wall are the refusals and report truncation, and a truncated level **halts** rather than taints: `run_loop` refuses a starting record carrying `A_sample` (control d4.1, exercised in `parts_rule --self-test`), and `LevelSet.require_complete` refuses to supply necessary atoms from an incomplete level. **`run_loop` itself prints no pre-level forecast** | the loop's own forecast → E, with X-6 |
| X-8 | artifact schema: `fp`, `canonical_fp`, `fp_base`, per-member profile, stamps | **done** | schema 2 (`parts_run.finish_record`) carries `problem_sha256`, `config_sha256`, `stage_identity`, `A_fp` per half, `A_canonical_fp_L` (the minimum over the 24 group images), `minima_fp`, per-member `member_profiles`, the atom labels as `(half, tuple)` so a reader can map atoms without rebuilding the stage, the registered predictions, a greppable `headline`, `launches` and `provenance`. On disk in the C3 and `.v2` records | — |
| M64-1 | phase E / P9 (18 connection edges) | retired | vacuous (S.2 #5); the tail question is C3 | — |
| M64-2 | phase F: expansion as an integer program over profiles | **not done — and it is now the live shape rather than a spare one** | single-orbit expansion from `A412` is closed at zero over a complete menu (0 of 63 improve, 1 grows); his own recorded successful move added **four orbits at once**; and the forced monotonicity argument says a superset of a succeeding set also succeeds, so **over-proposing costs time but never correctness** (§R3.b2). A set-valued rule is therefore what the follow-on needs, and an integer program over profiles is one form of it — one candidate rule among others, scored, never gated | **2(b) follow-on** |
| M64-3 | conjugacy of `Aut(A)`'s involutions (P7's second half) | **done for the multiset agreement; the row-to-class pairing is RETIRED** (approved 2026-09-11) | `parts_audit.involution_classes`: L's `Aut(A)` (order 12) has 6 conjugacy classes, of which three are involution classes of sizes 3, 3, 1 — and M64 §R10's seven stored order-2 rung values are three 375s, three 376s and one ≥ 377, a multiset partitioning exactly as the classes do. S: one involution class of size 3, all three rungs reading 138. **Phase D neither wanted nor needed the pairing**: the rung of a published row is read directly off his own file as a stabiliser computation — his `v376e1890` has stabiliser order 3 and the base group has exactly one order-3 subgroup — which identified state 1's rung in 30 seconds and `H2#4` as his rung-2 row solver-free (§R3.4; §R3.12 P-D17). **Retired, approved 2026-09-11 — a measurement removed its consumer, not fatigue**: the stabiliser computation on his own published file answers the rung question outright, so the pairing has nothing left to serve | **retired** (approved 2026-09-11) |
| M64-4 | rungs not searched to their minima | **done — every rung of both stages is now exact** | the L rung `H2#6` (225 orbits) closes at **377**, confirming `≥ 377` as an equality; all three S order-2 involutions close at **138** with 2 minima each, confirming `≥ 138`; the S order-3 rung closed at **142** incidentally via c1.1's resume control. P-C2.6 met on both clauses (§R2.4d) | — |
| M64-5 | separate obligation/experience passes | recorded | M64 closed; M63 phase C runs all three | — |
| M64-6 | P5, idealness of `Y` | drop? | needs a complete `Y`; off the record path | — |
| M64-7 | P10, the free completeness control | not done | first meaningful on a level set produced after its classes | C2, C3 |
| M64-8 | `m63-profiles-{S,L}.json` without a producer | retired | superseded by `m64-faces.json` (producer `parts_faces.analyse`); kept untouched | — |
| M64-9 | `m64-rung-lattice.json`, `m64-orbit-closure.json` produced by scratch scripts | **done** | `parts_faces.rung_lattice` / `orbit_closure`; `--reproduce-m64` rebuilds both sides with verification asks and reports `reproduces-m64`, 16 L rungs and 6 S rungs, 67 s (§R2) | — |
| M64-10 | both reduction records without a committed driver | **done** | `tools/parts_run.py`; both records regenerate `regenerated-identical` as `.v2.json` beside the originals (c1.7, §R2) | — |
| FS35-1 | the look-ahead's two quantities along his recorded path | **partly — closed at our 375 state, and unchanged by the rest of D** | `tools/parts_diag.py:fs35` on the complete 375 level: **two exchange classes**, affine dimension 2 of 4, sixteen rungs with closure bounds, atom classes reconciling as 336 + 24 + 14 of 18 = 374 (`data/m62/m63-fs35-1-375.json`). **The replayed 374 and 376 states were not reached** — each needs its own stage at its own rung, and the rung-1 374 level is still enumerating — so **P-D9 is unscored**. The identity probe P-D6 was not computed at any state | E |
| H-1 | `parts_verify.py` dirties the tree on every run | **done** | it rewrites only when `files` or `base_radius` moves; c1.6 ran it twice into a scratch path, second run `unchanged: not rewritten`, mtime identical, `git status` clean | — |
| H-2 | checkpoint without resume | **done** | `ReductionState` + `load_checkpoint`; c1.1 kills the S166 order-3 rung at iteration 58 of 82 and the relaunch reproduces the level exactly (§R2) | — |
| H-3 | no ask wall | **done, by a different mechanism** | CaDiCaL implements no `interrupt()` at all (P-C1.2 falsified); the budget is a conflict-slice loop under a time wall, and c1.3 shows `unknown` is neither impossible nor automatic (§R2.3) | — |
| H-4 | rotation lists truncated and sieved on the wrong lattice | not done | S.2 #13 | G |
| H-5 | `Stage` hard-wires `ρ₁₅` | **done for the parameter** | `typem.CrossLaw`, `Stage(cross_law=…)`; c5.1 the law reproduces the committed one edge for edge (126), c5.3 another cosine gives a different edge set, c5.4 an in-K rotation is refused naming Theorem B | G (the laws at `cos θ ∉ K`) |
| H-6 | `Stage.pin_is_sound` was a vacuous control at every rung above 1 | **done** | it identified pin atoms by each atom's **lowest set bit**; at rung 1 an atom is one vertex and that is right, but above it an atom is an orbit and a pin vertex need not be its lowest-numbered member, so the control found no pin atoms and printed the benign verdict `pin-is-fixed` while checking nothing — both of 2026-09-11's order-3 runs did exactly that. **Fixed at commit `13454c3`** (`any((m >> v) & 1 for v in self.pin)`, present at HEAD), with the part that matters planted beside it: the **shipped rule run next to the fixed one** on a stage where they differ — at the order-3 rung, 150 atoms, **0 pin atoms by the shipped rule and 2 by the fixed one** — so the control is seen to fail on the code it replaces. No number is retracted: the symmetry break itself is sound because `Stage.cnf` makes the pin clause conditional on the atom's presence | — |

### S.4 — The roadmap, C onward

**Phase C — the joint test, the instruments the loop needs, and the audit closed.**
*Subplan: `plans/M63-phaseC-joint-stage.md`.* Purpose: run the cheapest experiment that can meet the
record (Poros card 1: reduce both halves at once over his own accumulators), and make every instrument
phases D–F stand on honest — resumable, walled, reproducible from committed code, frozen for real.
Acceptance:
- [ ] C1: `reduce_stage` resumes exactly (planted interruption → identical minima, `Y`, bound); a planted
  1 ms ask wall renders the bound open; `companion-suffices` fires on its stub; `require_frozen` refuses
  absent / dirty / differing freezes and passes a committed matching one, in a scratch git repository;
  `parts_verify.py` run twice leaves `git status` clean; `tools/parts_run.py` regenerates the S166 and
  L451 records with identical minima, `Y` and bounds; `parts_faces` regenerates M64's rung lattice and
  orbit closure identically.
- [ ] C2: `tools/parts_audit.py` self-test fires; audits of S166 and L451 written with every applicable §3
  row as a tuning-mode `Comparison`; Table 2's shading extracted with its arithmetic control passing (or
  refused as unreliable and reported); Tables 5 and 7 checked; the conjugacy classes and the three open
  rungs closed; `Y` re-verified (sampled, stated).
- [ ] C3: the M6B 375 level set on `v403e2106` with `S141`, predictions committed first; the "M6A&B"
  column's meaning decided or reported undecided with its numbers.
- [~] C4: the joint stage's positive control fired in its strongest form — the 509 returns exactly itself
  (508 critical atoms, exactly one minimum, 0 droppable, §R2.2). **The two joint runs did NOT close.**
  After 4.9 h each (2026-09-11 22:47, the machine, five heavy jobs sharing the machine) neither has found a
  single minimum, so the result is a rigorous bracket and not a value: C4a, the frame holding the record,
  **504 ≤ \|M\| ≤ 509 vertices**; C4b, the second relative frame, **500 ≤ \|M\| ≤ 577**. The `≤ 508` stop
  rule never fired and stays armed in both runs. Both checkpoint every 30 s and resume exactly, and were
  left running; collecting the verdicts is phase D's first act. C4b was launched four minutes after C4a
  rather than after it closed (§A.2 #2), so the two ran concurrently and the three-hour report did not
  happen. Full scoring: `plans/M63-phaseC-joint-stage.md` §R2.
- [ ] C5: `CrossLaw` controls fire; the L451 stage fingerprint is unchanged under the explicit law.
- [ ] The audit rows assigned to C updated in place here; §R2 written; Poros's record committed.

*Cost:* 2–3 engineer-days; compute about 1–2.5 h, single core per run, never more than 8 cores; the joint
run is announced before launch if its forecast exceeds 15 minutes.

**Phase D — the loop, with a rule that finds its own moves.** Purpose: S.1 #1 and #2.
Acceptance:
- [ ] Replay controls, tuning mode, the named convention, **each row against the companion his loop held
  at that state** (§S.1 2(a); phase D §R3.4): 376 at the order-3 rung on `A451` **against the S accumulator
  `v166e774`** (his 96, `A = v451e2400`, 1890–1947 edges) — against `v136e564` the same reduction returns
  376 with 82 minima and `A = 433`, which is a different problem and is recorded as such; 374 at rung 1 on
  `A412` **against `v136e564`** (1,092; `A = v412e2106`; 1860–1884; P8 scored); 374 at the rung-2 subgroup
  (78; `A406 = v406e2082` up to the group; 1868–1884), computed both as the invariant part of the rung-1
  level and by a direct rung-2 reduction, which must agree. **A row whose companion is not identified
  reports `|M|` alone**, and `|{M}|` and `A` read `not-compared` with that reason.
- [ ] **His own published ranking device is scored first** (Poros card 8). §5.6's third strategy ranks
  candidate expansions by §5.10's numerical indicators — the free-vertex count, the small-degree
  hyperedge counts, and the size of the maximum independent set of the degree-2 hyperedge graph. Run it
  on about fourteen candidate expansions of `A403` (the four partial fills and the top ten reserve
  orbits) and report whether the orbits his own move used rank top. **If they do**, D registers *his*
  device as the rule, and the earlier negative localises to two sentences rather than to his method.
  **If they do not**, then no published device predicts his own recorded move: D's rule is ours alone,
  scorable only by outcome, and the record says that plainly. Discharges P6 in its useful form.
  *(≈ 6,000 asks, tens of minutes at the measured costs.)*
  **Moved to the clause 2(b) follow-on, 2026-09-11** (§S.3 rows C-5 and P6): phase D never implemented
  the indicators — its replays were overtaken by the companion finding, and the rule was frozen and run
  without them — so his device is still untested and P-D1 is unscored.
- [ ] **A candidate rule of our own, offered by Poros and unverified:** rank an expansion by **how many
  currently necessary atoms it frees** — an atom is necessary exactly when it is a singleton correction
  set, and an expansion helps when the new material covers what such an atom covered alone. Priced in
  tens of asks by his own 8-4-2-1 batching, and scorable on his recorded move, because both level sets
  are complete: the atoms necessary at 375 and not at 374 are exactly what his move freed.
- [ ] The expansion rule committed before it runs — candidates, ranking, batch size, stall response — each
  choice with its reason; his stated priorities are an input, not the definition.
- [ ] The loop runner: the per-iteration line, `stalled` as a verdict, exact resume per iteration, the
  pre-level forecast with its assumption (X-7's replacement).
- [ ] From our 375-level accumulator with no reference to his orbits, the rule-driven loop reaches
  `|M| ≤ 374` on the L side (S.1 2b).
- [ ] In an iteration where the rule added vertices, `{M}` grows at fixed `|M|` and fixed rung (S.1 2c).
- [ ] The rank of his implied move under the rule, reported (diagnostic).
- [ ] Our own `L374 ∪ ρS136`: 509 vertices, 2,442 edges, `1860 + 564 + 12 + 6`, refusing four colours by
  SAT on exact geometry (S.1 #1).
- [ ] FS-35's two quantities at each replayed state (FS35-1).
- [ ] The freeze committed; `require_frozen` exercised red and green on the real file.
- [ ] If C4 read exactly 509, the rule is also run on the joint level set — as F's first experiment, not
  as reproduction.

*Cost:* 3–5 engineer-days; compute: replays 1–2 h, loop runs several hours, one heavy job at a time.

**Phase E — generalization, required for M63 to close.** Purpose: S.1 #3.
Acceptance:
- [ ] Companion constructors — mono-pair edge, non-mono-set clique, the five-vertex √3 pin — each with a
  planted control that flips (a wrong length; a triple that is not forced).
- [ ] Held-out predictions committed after the freeze and before any held-out run; every row a frozen
  `Comparison`.
- [ ] **The held-out list excludes the M6B 375 row in writing.** Phase C3 spent it (approved 2026-09-11),
  the audit marks it SPENT, and **M6B 374 at rung 2 stays held out**.
- [ ] Reduction generalization on his published accumulators: L M6B 374 at rung 2 (78, `v406e2076`); L
  M6C 374 (76, `v400e2034`); S M6B (141, 4, `v172e804`) and M6C (150, 28, `v167e772`); the 8/3 mono-pair
  (367, 27, `v375e1862`); the √3 triple (221, 120, `v238e1131`).
- [ ] **Loop generalization, starting below his accumulator — the required run is the 8/3 mono-pair**
  (Poros card 7): start from his published 367-vertex minimum `v367e1822` and let the frozen loop run. It
  is genuinely held out, it starts below his accumulator, and its companion is **an edge**, which M63 §3
  calls the sharpest of the held-out set because it exercises the companion abstraction rather than a
  second type-M half. Three attested targets: `|M| = 367`, 27 minima up to the named group, and
  `A = v375e1862` with Table 5's ranges.
- [ ] **The mechanism control, not the held-out run:** the S side from a rung-2-symmetric 138-vertex
  minimum (M64 §R10), whose containment of any 136-minimum is forbidden by the closure gap, so the loop
  must expand to reach 136. It is a control because the S reduction was spent as this milestone's
  calibration (§R1), so no S number is held out any longer.
- [ ] A written human judgement over the frozen rows, and no aggregate verdict.

*Cost:* 3–4 engineer-days; compute several hours in light jobs.

**Phase F — beat 509.** Purpose: S.1 #4.
Acceptance:
- [ ] The certification path, rehearsed on the first candidate: exact unit distances over
  `ℚ(√3,√5,√11)`, an LRAT proof checked, and a Lean kernel certificate on the pattern of
  `Proofs/HadwigerNelson/Instances/Heule510.lean`, `#print axioms` exactly the standard three; the
  construction stated so a reader can rebuild it.
- [ ] Headline or secondary record certified — or the menu below exhausted and reported with its
  enumerations.
- [ ] Each experiment's prediction and cost committed before it runs: (a) if C4 read 509, the rule-driven
  loop on the joint level set — **which first requires that level exhausted, or its completeness checked
  from ask-derived correction sets**, because the union of a capped level is a sample and not the loop's
  state variable (Poros card 9); (b) larger joint accumulators — his L files of all three subtypes against
  `A166 ∪ A172 ∪ A167`, frames found; (c) S reduced against one L minimum per profile class of the 1,092,
  and L against the 8 S classes; (d) other connection orbits at `ρ₁₅` — M62 §R20's `(0,0,2,6) + (24,0,0,0)`
  subtype at 18 edges, and `(20,0,0,4)`, `(16,0,6,2)` (FS-30's cheap lead); (e) the loop continued past
  his stopping point from a larger reserve; (f) symmetric seeds from the rung lattice; **(g) his own
  negative on the disk radius** — *"expanding the base graph and increasing the radius of the disk did not
  lead to new results in our case"* (§5.6). **The radius half is STRUCK, 2026-09-11: the question is
  answered without a run.** Under all three readings of his admission rule **zero** orbits outside his
  `r = 2` disk qualify, on all three accumulators; and the deflation was tested — thirteen excluded orbits
  sit *closer* to his boundary than the `√5` pair and all score lower, so **admissibility is not ordered by
  radius**. His negative is therefore a fact about his **filter**, not his **disk**
  (`plans/M63-phaseD-the-loop.md` §X.3, from the phase D advisor's P5). What remains of (g) is the
  **base-graph half** — `⊕ⁿHᵐ` variants — and phase D tests the claim at **two runs** through the `√5`
  orbit on each half rather than at a radius sweep.

*Cost:* open-ended; an experiment is 1 h – 1 day of compute; a certificate about a day.

**Phase G — other bases and the sieve's rotations.** Purpose: Kooshi's second direction (S.1). **Approved
2026-09-11 as its own milestone**, numbered at M63's close; its row stays here so the sequence is whole.
How it relates to M62 and FS-30 is settled at that close, not now.
Acceptance:
- [ ] Rotations re-sieved on the §5.6 lattice's own radius spectrum; the full admissible list persisted.
- [ ] A cross-edge law per rotation class — the collinear law when `cos θ ∈ K` (C5's parameter), a new
  derivation when `cos θ ∉ K` — each checked against `ρ₁₅`'s edge set and Heule-510.
- [ ] Rotations ranked by distinct radius families, the 2-adic wall and 6-openness, **never by cross-edge
  count** (maximal coupling keeps a rotation inside `ℚ(√3,√11)`, where Theorem B four-colours it; FS-30).
- [ ] The non-vacuity census first: one refusal ask per rotation on a base sized from that rotation's own
  endpoint-radius bound (`8/√15` at `ρ₁₅`, M62 §R22), reported as a `Count` with its enumeration.
- [ ] For each passing rotation, the joint reduction (C4) and the frozen loop (D) to a closed optimum.
- [ ] Other bases: `⊕ⁿHᵐ` variants and a radius sweep at `ρ₁₅` from 2.44, each through its own gate.
- [ ] Any graph below the record of the day certified as in F.

*Cost:* the laws and the census 2–3 days; per-rotation runs tens of minutes each; one to two weeks.

**Order.** C → D → (freeze) → F and E. F before E, as the product owner leans, **on one condition: the
freeze commit precedes both**, so nothing F learns can edit the configuration E is judged under. E's runs
are light and can interleave with F's under the one-heavy-job rule.

### S.5 — Designing for G now

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| `Stage` takes the cross-edge law as a parameter (`CrossLaw`), with the collinear law parameterised by `cos θ ∈ K` and `ρ₁₅ = collinear(7/8)` as the default (C5) | full rotation generality in C; or no parameter until G | the derivation behind `ρ₁₅`'s law holds verbatim for every rotation whose sine leaves `K`: `Re(ρ·conj(u)v) = k` with `ρ = c + i·s√D`, `√D ∉ K`, forces `q = 0` (collinear with the centre) and `c·p = k`. So one parameter covers that whole class for a few hours, and D is not rewritten. Classes with `cos θ ∉ K` need a derivation worth paying for only once G's census shows more than one rotation refuses (Poros card 4) | high |
| The base stays a constructor argument; no abstract base protocol in C–F | abstract `Base` protocol now | every M63 tool labels orbits by his `(a,b,c,d)/12` tuples and the pin triangle is written in them; a second lattice has other coordinates, so the protocol could not be tested before G supplies one. `Base(r)` already sweeps the radius on his lattice, which covers F(e) | medium — if F needs a non-§5.6 lattice, pay for the protocol then |
| Per-rotation base sizing is G's | a radius argument derived from the law in C | the bound `t² ≤ 1/(1 − c²)`-type computation is per law and meaningless while only `ρ₁₅` exists | high |
| The freeze pins `cross_law = collinear(7/8)` and `fp_base(Base(2.6))` inside the config hash | pin only the base | generality in the code is fine; generality in what is compared with his tables is not | high |
| G is its own milestone | G as M63's last phase | different product (constructions at rotations `[Parts2020a]` §4 says are "not known yet"), its own prior-art question (Polymath16 on other rotations), and no reproduction discipline; M63's closure (E) does not depend on it | medium — if F lands a record fast and G's census is one afternoon, folding its first step into M63 is harmless |

---

## §0 — The product, in one sentence

**Not** *"we can produce his numbers"* — that is a fit, and it is reachable by tuning a dozen free
choices toward published answers one plausible adjustment at a time. The product is:

> **we know why a descent cannot reach the record, we own the loop that can, and it works on a
> problem he did not publish the answer to.**

The measured reason this milestone exists: nine certified 1-minimal descents on our own arena land
at **582–609** with the record **509** eleven standard deviations below their mean, and
`[Parts2020a]` §5.8 names the mechanism in print — **overcompression**, *"the minimal asymmetric
graph is usually not a subgraph of the minimal symmetric graph"*. A descent produces **one**
minimum; his loop's state variable is **`A = ⋃{M}`, the union of ALL minima at the current size**,
and without the whole set there is nothing to carry between iterations and the loop degenerates
into exactly the descent that provably cannot arrive.

---

## §PA — Prior-art gate (WORKFLOW step 3a)

The prior art *is* the object: this milestone reproduces one named paper. The gate therefore runs
inward, and what it found is a reading debt, not a missing citation.

**Read on 2026-09-10, first time:** `[Parts2020a]` §5.1, §5.2, §5.3, §5.4, §5.9, §5.10, §5.11, §6
in full, and Tables 1–7. Added to the §5.4–§5.8 read of the day before. `BIBLIOGRAPHY.md` now
carries per-section markers; **do not write another whole-paper `READ`** — that marker has been
wrong three times on this file (`G50`).

**Still unread and named so it is not lost:** nothing in §§1–7. §8 is acknowledgements. Figures 1–7
are images and have not been examined pixel-wise; Figure 1 is load-bearing for the M6A/M6B/M6C
distinction and its content is recovered from §4's text instead.

**What the gate bought, which is why it is not a formality:**

- **Reference [11] resolves and the data is live.** *"Comments in Polymath16, thread 15, comment
  24942 … see also Polymath16/Code and data/This dropbox folder/JP/Large"* — the folder is
  published on the Polymath wiki's *Hadwiger-Nelson problem* page (recovered through the Internet
  Archive) and is still served by Dropbox. **43 `.vtx` files**, exact Mathematica radicals, one
  vertex per line, plus `graphs.txt` — his own index against Table 1. Held at
  `data/m62/parts-ref11/`, provenance and checksums beside them. **This is the whole milestone's
  test harness and it changes the plan** (§3).
- **His coordinate convention, verbatim** (`JP/Pink/readme.txt`): `(a + sqrt(33)*b)/12 = x`,
  `(sqrt(3)*c + sqrt(11)*d)/12 = y` — identical to ours, so his orbit labels and ours are the same
  objects and not a coincidence of notation.
- **Two disputed rows of Table 1 settled from his own index**, closing the parenthetical the
  consolidation left open in ledger row 59: the 214-vertex non-mono-pair is at **distance 3**
  (`(±3/2, 0)`), not `√3`, and the 312-vertex one is at **1/3** (`(±1/6, 0)`), not `1/√3`. The
  valuation law's prediction is unchanged either way — `v_𝔭` is 0 for all four — which is why the
  ambiguity was survivable, but the record should now say which.

---

## §1 — What was verified before any of this was designed

Every convention this milestone rests on is a guess until it is checked against data we did not
choose. All of the following ran on 2026-09-10 and are the self-test of `tools/parts_repro.py`
(`python3 tools/parts_repro.py`, ~25 s, prints every comparison, exits non-zero on any failure).

**The base, the group, the labels.** `typem.parts_lattice(2.6)` gives **4,513 points in 229
orbits, group-closed exactly** (zero images outside, over all 24 elements), orbit sizes
`{1: 1, 6: 14, 12: 59, 24: 155}`.

**His orbit-label rule, recovered rather than assumed.** His labels are all-even, non-negative and
carry a zero coordinate — but that does not pin a member: the radius-1/3 orbit contains both
`(4,0,0,0)` and `(2,0,2,0)`, and he writes `(4,0,0,0)`. The rule that reproduces **all 41 labels of
Table 2** is *maximize the number of zero coordinates, then take the lexicographic minimum*; the two
obvious alternatives (plain lexicographic minimum; the member on an axis) do not. Under it the 229
orbit labels are **injective**, all 41 Table-2 labels are canonical representatives of our orbits,
and every Table-2 filling fits inside its orbit's size.

**Heule-510 is a type-M object over his base, exactly.** A type-M graph is `G = L ∪ ρS` with `L`
drawn in `K = ℚ(√3,√11)` and `ρ = ρ₁₅ = (7+i√15)/8` adjoining `√15 ∼ √5`, so the split needs no
search — a vertex is on the `L` side exactly when it is `√5`-free. Measured on
`tools/heule510.json`, held here since M06:

- **375 + 136 sharing the origin**, `374 + 135 + 1 = 510`, and **every point of both sides lands on
  his denominator-12 lattice — zero off it.**
- **The L side reproduces Table 2's 375 column on all 41 rows, zero mismatches, zero extra orbits.**
- The S side uses **exactly Table 4's fourteen orbits**, with every filling inside his `{M}` ranges
  — so Heule's `S136` is one of his eight minimal S-graphs.

**The connecting edges are his two orbits with his counts, from our own cross-edge law.** On the
`r = 2.6` base the `ρ₁₅` cross edges give **12 in the reference orbit `(0,4,4,0)` at radius 2** and
**12 in the auxiliary orbit `(0,0,2,6)`**, whose two radii are `√11/2 ∓ √3/6` to machine precision —
his §4 values. And the auxiliary orbit is **ONE orbit at TWO radii**: two of the twenty-four group
elements are Galois, so an orbit carries the conjugate squared norms `n` and `σ(n)`, and
`(0,0,2,6)`'s twelve points sit six at `1.9470` and six at `1.3696`. An auxiliary edge joins one
Galois half on the L side to the other on the S side.

**Both cross-edge families have the same coupling constant, and that is why one rotation realizes
both.** With `t`, `r` the two endpoint radii, a unit cross edge collinear with the centre forces

  `c = (t² + r² − 1) / (2tr) = 7/8 = Re(ρ₁₅)`,

which holds for the reference pair `(2, 2)` and for the auxiliary pair `(√((17±√33)/6))` alike —
checked to 1e-15. **This is the content of his unexplained sentence** *"Unlike graphs of type A, the
existence of triangles of the second kind is essential"*: the second family is not a second
construction, it is the same rotation's conjugate-ring channel — which is M31's quadrature law
(ledger row 27) met from his side.

**The 2504-versus-2502 loose end is CLOSED, and it was never a disagreement.** Decomposed:

| | L | S | reference | auxiliary | total |
|---|---|---|---|---|---|
| our `tools/heule510.json` | 1920 | **566** (Heule's S) | 12 | 6 | **2504** |
| his Table 1 "510" row | 1920 | **564** (his own S) | 12 | 6 | **2502** |
| his Table 1 "509" row | 1860 | 564 | 12 | 6 | **2442** |

Our file holds **Heule's** S with the **same** L; his row holds **his improved** S — and §6 says
*"Here we hardly improved the result of Heule at all; only two edges were removed."* `566 − 564 = 2`.
Measured: his `v136e564.vtx` and Heule's S have the same 136-vertex count and **different vertex
sets**. The `12 + 6` is also the subtype read off the edge count: **M6** means six auxiliary edges.

### What his own files say that his tables do not

`tools/parts_verify.py` parses all 43 `.vtx` files exactly and checks each against its own
filename. **40 of 43 reproduce their vertex AND unit-edge counts exactly**, in exact arithmetic,
with a parse that shares no code with the paper. The three that do not are a finding, not a
failure, and so is what the other 40 settle.

**(i) The record decomposes into four independently attested terms.** `v509e2442` splits as
`L(374) ∪ ρ₁₅S(136)` sharing the origin with **zero points off his lattice**, and

  `2442 = 1860 (L) + 564 (S) + 12 (reference) + 6 (auxiliary)`

with `e(L)` and `e(S)` recomputed here from the vertex lists. The `12 + 6` is the subtype read off
the edges: **M6** *is* six auxiliary edges.

**(ii) Table 3's `A` column has exactly two typos, and his own file names them.** The printed column
sums to **402** against its caption's **412**. `v412e2106.vtx` has **412 vertices in exactly Table
3's 37 orbits**, and differs from the printed column in **two rows only** — `(0,0,2,2)` printed 8,
actually **12**; `(0,0,2,6)` printed 6, actually **12** — each the orbit's full size, and
`(12−8) + (12−6) = 10`, exactly the deficit. **P1 met.** Table 5's (−16) and Table 7's (+3) are
untested; their `A` files are held (`v375e1862`, `v289e1389`) and the same check settles them.

**(iii) A single printed `M` column is NOT reliable, and the `{M}` ranges ARE.** His own
`v374e1860.vtx` has 374 vertices in exactly Table 3's 37 orbits but differs from the printed `M`
column in **four** rows — and **all four differences lie inside the printed `{M}` ranges**
(`(0,0,2,2)` 6 vs 8, range 6–8; `(2,0,6,4)` 4 vs 2, range 0–8; `(4,0,10,2)` 4 vs 0, range 0–4;
`(6,2,8,0)` 8 vs 12, range 8–12), while **all 31 stable orbits agree exactly**. So either the file
is a different member of `{M}` than the column describes, or the column carries typos as the `A`
column demonstrably does — and either way **§3's gate design is vindicated on his own data**: gate
on the ranges and on the stable/unstable partition, never on one printed column.

**(iv) `v136e564` reproduces Table 4's M6A `M` column exactly, all 14 rows**, and `v166e774`'s
fillings dominate it orbit by orbit and sum to 166. Heule's own S — recovered in §1 from
`heule510.json` — has `(0,4,0,0) = 5`, `(6,2,4,0) = 15`, `(6,0,4,6) = 7`, every one inside Table 4's
`{M}` ranges: **Heule's S136 is one of Parts's eight minimal S-graphs.**

**(v) His objects are stored each in its own frame, and containment holds only up to the group.**
`v136e564 ⊄ v166e774` as stored (six vertices outside) — but **six of the twenty-four group elements
map it inside**. A reproduction that tests `M ⊆ A` literally will report a false negative; the test
is `∃g ∈ Aut B : g(M) ⊆ A`. The L-side files happen to be framed compatibly
(`v374e1860 ⊆ v412e2106`, `v374e1868 ⊆ v406e2082`, `v376e1890 ⊆ v451e2400`,
`v375e1920 ⊆ v403e2112`, all literal), which is exactly how this would have gone unnoticed.

**(vi) Three of his objects are on a TRANSLATE of the base, not on a second component of it —
and the first reading of this was wrong, killed by the modelling pass's own seam test.** The three
off-base files are `v214e977` and `v226e1037` (the distance-3 non-mono-pair and its `A`) and
`v312e1502` (the 1/3 one). Every one of their points satisfies `a ≡ b ≡ c ≡ d (mod 2)` with
`a − b + c + d ≡ 2 (mod 4)`, where every other object satisfies `≡ 0`. **It is tempting, and wrong,
to read that as "the lattice has two components and we implement one":** built and measured, the
`≡ 2` set at `r = 2.6` has 4,448 points and **71,168 group images outside itself** — it is not
group-closed and is not a lattice under the order-24 group about the origin, where the `≡ 0` set is
closed exactly (0 outside). What is true is one line further on: `φ(p) = a − b + c + d mod 4` is
additive, so the difference of any two `≡ 2` points is `≡ 0`, and **translating such a graph by any
one of its own vertices lands every point back on the base** (measured: 214 of 214, parities intact).
So they are ordinary base graphs anchored off the origin, and the reason is geometric — their forced
pair sits at `(±3/2, 0)` whose **midpoint is not a lattice point**, so the object cannot be centred
where its symmetry is. None of the three is in the reproduction path or in the held-out set (the
`8/3` mono-pair `v367e1822` and the `√3` non-mono-triple `v221e1006` are both on the base), so this
is a bounded, named residual: **what group those three ARE invariant under is open and this milestone
does not need it.**

---

## §2 — His algorithm as our objects

**His variables (§5.3), which we adopt verbatim** — `M ⊆ A ⊆ W ⊆ R ⊆ B`, `M ∈ {M}`, `⋃{M} = A`:

| his | what it is | ours |
|---|---|---|
| `B` | base graph of the search area | `parts_repro.Base(2.6)` |
| `R` | reserve: a high-symmetry overgraph of `A` to draw new vertices from | to build (§S.4 phase D) |
| `W` | working graph — `A` plus candidate new vertices, kept near **1000** (§5.11) | `parts_stage.Stage`'s deletable part |
| `A` | **accumulative graph, `⋃{M}` — the loop's state variable** | `reduce_stage`'s `A`; equals his `v166e774` (§R1) and his `v403e2112` (§S.2) as sets |
| `{M}` | the set of ALL minima at the current size | `reduce_stage`'s complete level; up to `Aut(A)` it is his 8 (§R1) and his 282 (§S.2) |
| `M` | one minimum | every descent we have ever run |
| `C` | **companion graph**: reifies the key property as a graph | `Stage`'s frozen other side; the edge and clique companions are §S.4 phase E |
| `Y` | **relationships hypergraph**: sets that cannot be wholly deleted | the minimal correction sets `reduce_stage` harvests at every degree, stored since M64 §R3 |

**`C` is the abstraction that gives one paper fifteen results, and it is not "the frozen other
side".** §5.3: *"for an L-graph, it is an S-graph and vice versa, for a mono-pair it is an edge of
the corresponding length, for a non-mono-set it is a 3-clique, each vertex of which is connected to
all vertices of this set."* Modelled as "the other half of a type-M graph" we lose every non-M row
of Table 1 — which is exactly the held-out set §3 depends on. `C` also does a second job: **the
symmetry-setting pendants live in it** (below).

**Symmetry is FOUR things (§5.4), not one**, and our ladder measured the wrong one:

- `Aut B` — the base group, order 24. Ours.
- `Aut W` — of the working graph.
- **input symmetry `Aut(W ∪ C)`** — the group that **deduplicates** candidates.
- **output symmetry `Aut{M}`** — the **granularity of the search variables**: candidates are unions
  of output-orbits, so a higher rung means fewer, bigger variables.

Deduplication uses *"the set of permutations of the **quotient group**"*, so output must be normal
in input. And both are **engineered by modifying the object**: §5.8 — *"The input and output
symmetry can be changed by **adding hanging vertices** to the graph `W`, that is vertices of degree
1, which can be taken as part of the input and output companion graphs `C`. The hanging vertices are
those connected to a high-degree vertex of graph `W`, that are not deleted during reduction."*
Degree-1 pendants on high-degree vertices, living in `C`, never deleted, costing nothing against the
vertex budget. **Symmetry is a dial you set on `W ∪ C`, not a filter on candidates.**

*Consequence, and it retires a comparison the handoff stub invited:* Table 1's symmetry column is
*"taking into account the connection edges"* — the symmetry of `L` **with its connections** — while
our `24/6/3/2/1` ladder was the symmetry of an arena selection. **His 376-at-symmetry-3 and our
558-at-symmetry-3 are two quantities on two objects and must not be compared.** Also: `1 (2)` means
*the set* has output symmetry 1 and *the fewest-edge member* has symmetry 2 — it is not a second
search parameter.

**Phase 1 — build `Y`.** A hyperedge of degree `n` is an `n`-set whose simultaneous deletion loses
the key property, minimal. Sought stepwise in increasing degree. **Degrees used (§6): 2 or 3 for L,
3 or 4 for S and non-mono-triples**; up to 5 where the object is under 250 vertices.

**Phase 2 — enumerate.** Check the key property for all subgraphs containing at least one vertex of
every hyperedge, **in order of increasing vertex count**. Equivalently on the DELETED sets, which
are much smaller (§5.7): the deleted set must be **independent in `Y`**, and we want the largest —
so **maximum independent set of `Y` = minimum hitting set of `Y`**, which is what `tools/exact.py`
already computes by implicit hitting set. His explicit recipe (maximal independent sets of the
degree-2 graph, plus free vertices, split on degree ≥ 3, ordered by decreasing deletion count,
pruned against the incumbent) is the same problem stated as an enumeration.

**Three termination rules, and the first is what makes `{M}` well-defined:** *"The check is
terminated if at some step **at least one** subgraph with the key property is found"* — evaluated at
the END of a step, so **the entire winning level is checked and `{M}` falls out for free**. Then:
only subgraphs no larger than the previous iteration's `M` need checking; and the check may be
terminated if a step's candidate count exceeds a threshold — **so `{M}` is complete-or-truncated and
he does not say which.**

**The loop's success criterion (§5.5), which is the piece with no analogue here:** *"The iteration
is considered successful if it leads to a change in the graph `A`: that is, either to a reduction of
the order of the minimum graph `M` **or else to an expansion of the set of minimal graphs `{M}`**."*

**8-4-2-1 (§5.8), and it belongs in phase 1 where we do not have it.** *"The sets of deleted
vertices are first divided into groups of 8 … If the result is False, then this means that each of
the sets can be deleted individually. If True (which takes relatively little time), then the sets
are grouped in fours … then in pairs … finally individually."* The precondition is the cost split we
measured independently on our own kernel — **refusing asks 10–15 s, colourable asks 0.02–2.8 s** —
so one expensive refusal clears eight candidates. We own this shape in `descent3.py`'s
gallop-then-bisect, in the **descent**; he applies it to **hypergraph construction**.

**Rough reduction (§5.10), and it is what our descent already is.** *"Before using it, one should
use a rough reduction method to obtain an acceptable initial graph"* — trimming by radius, iterative
removal of small-degree vertices, fixing vertices whose removal loses the property, deleting base
orbits largest-first, and selection by cheap numerical indicators (free-vertex count, small-degree
hyperedge counts, the maximum independent set of the degree-2 hyperedge graph). **Our 559-vertex
census-certified object is the INPUT to his fine search, not a competitor to his 509.**

---

## §3 — The acceptance test, and where the handoff stub's version was wrong

The stub proposed gating on six numbers: `|{M}|` and `A` at 376, 375 and 374. **That is the wrong
test in a way that matters, and the advisory pass caught it.**

**(a) `A` is the least reliable quantity in the paper.** Summing the per-orbit `A` columns against
their own captions: Table 3 gives **402** where it claims **412**; Table 5 gives **391** where it
claims **375**; Table 7 gives **292** where it claims **289**; only Table 6 agrees. Errors in both
directions, one of them 4% in the direction of impossibility. Every `M` column checks. *A gate that
cannot fail cleanly is the failure mode this repository has minted four times.*

**(b) `|{M}|` is convention-dependent and possibly truncated.** "Non-isomorphic" means non-isomorphic
under the quotient group his run happened to be configured with (§5.8), not abstract isomorphism;
and §5.5's threshold clause means the enumeration may have stopped early. **1092 is a number
produced by his run, under a convention he does not state, possibly a lower bound.**

**(c) The reliable, convention-free, multi-dimensional target is the orbit-filling RANGES**, and
they are attested twice — Table 2's `{M}` columns and Table 3's `{M}` column agree on all six
varying orbits. The 374-vertex minima differ in **exactly six orbits**, whose fillings total 40:

| orbit | `{M}` range | orbit | `{M}` range |
|---|---|---|---|
| `(0,0,2,2)` | 6–8 | `(4,0,10,2)` | 0–4 |
| `(2,0,6,4)` | 0–8 | `(10,0,2,4)` | 4–12 |
| `(2,0,2,4)` | 8–10 | `(6,2,8,0)` | 8–12 |

and **31 other orbits have single-valued ranges**. *Stable* in his sense — the same non-empty vertex
set in every minimum — is marked only by gray shading and is **not** implied by a single value: our L375
level keeps exactly 10 of `(2,0,2,4)` in every minimum with a varying vertex set (§S.3 G-2). **A pipeline
whose minima vary in an orbit he shades as stable is not running his algorithm, whatever count it
reports** — a clean falsifier once the shading is read (§S.4 phase C2).

**(d) And the archive makes three of these checkable rather than arguable.** We now hold `A` itself
— `v412e2106.vtx`, `v451e2400.vtx`, `v403e2106/2112.vtx`, `v406e2076/2082.vtx`, `v166e774.vtx` —
so "does Table 3's `A` column really sum to 412?" is a computation on his own file, not a reading of
his table. **Phase A settles it.**

### The gate, as it now stands

| rank | what | gate? |
|---|---|---|
| 1 | `\|M\|` — 136, 374, 375, 376 — triply attested (Table 1, caption, a summing decomposition) | **YES, hard** |
| 2 | the `{M}` orbit-filling ranges and the stable/unstable partition — doubly attested | **YES, hard** |
| 3 | edge counts, decomposed as `e(L) + e(S) + 12 + (subtype number)` — four independent terms | **YES, hard** |
| 4 | the loop's second success clause: **`{M}` grows at fixed `M` and fixed rung, in an iteration that added vertices** (§S.1 2c); his 78 → 1092 at 374 is a rung relaxation, kept as a replay comparison | **YES, qualitative** |
| 5 | `\|{M}\|` and `\|A\|` | reported, **never gated** |

### And the held-out set, which is what makes it a reproduction rather than a fit

**The lie this milestone can tell is specific:** the pipeline has a dozen free choices (which orbits
to add and in what order; the symmetry rung; the hyperedge degree cap; the enumeration threshold;
which half or quarter of each partial orbit; the isomorphism convention). Every one of them, nudged
to move a count from 84 toward 96, will feel exactly like getting the algorithm right, and the
result is an instrument that reproduces his checkpoints on his path and **generalizes nowhere** —
which is precisely what the next session cannot use, because it runs a different path. `G21`, with
the acceptance criterion being his published answer, and invisible: a green run on every number.

**So: tune on the L path only; then FREEZE; then run untouched on the held-out set, predictions
written down first.** Table 1 gives fifteen result rows over five independent reduction problems:

- **S-subgraph M6A** — `A166 → M136`, `|{M}| = 8`, edges 564–567, and his §5.10 worked example with
  its check count and wall clock. The cheapest complete instance of his algorithm in the paper.
- **mono-pair 8/3** — `A375 → M367`, 27 minima, Table 5 with its own ranges. **Sharpest of the
  held-out set**, because its companion `C` is *an edge*, not an S-graph — it exercises the
  companion abstraction, the piece most likely to be modelled as a special case.
- **non-mono-triple `√3`** — `A238 → M221`, 120 minima, Table 6.
- **L-subgraph M6B and M6C** — 374 at symmetry 2, `|{M}| = 78` and `76`.

---

## §4 — Phases, each with the control it must pass

### Phase A — the calibration corpus *(mostly done; §1)*

Parse all 43 `.vtx` files exactly, check every one against its own filename, and settle the `A`
question. **Controls:** vertex and unit-edge counts equal `v<V>e<E>` for every file; every lattice
graph lies inside `Base(2.6)`; `v509e2442` splits as `L(374) ∪ ρ₁₅S(136)` sharing the origin with
`2442 = 1860 + 564 + 12 + 6`; his `v374e1860`'s orbit fillings equal Table 3's `M` column and
`v136e564`'s equal Table 4's `M6A` column. **Then compute `v412e2106`'s fillings and compare with
Table 3's `A` column** — that decides whether the 402/412 gap is his table or our transcription.

### Phase B — the key-property checker with his companion graph and his accelerators

`key_property(W, C)` = *`W ∪ C` is not 4-colourable*, with `C` one of: a frozen S-graph (for L), a
frozen L-graph (for S), **an edge of the given length** (mono-pair), **a 3-clique joined to every
vertex of the set** (non-mono-set). Plus §5.9's levers, none of which we use:

- the **3-clique pin** at `L`'s `(0,0)`, `(1,0)`, `(1/2, √3/2)` — three unit clauses, no new
  variables. Distinct from the value-precedence encoding measured FLAT in FS-32 §R3.
- **vertex order by increasing Euclidean distance from the centre**.
- **multi-vertex colour assignment** — for a `√3` non-mono-triple, combining symmetry breaking with
  `C` pins **five** vertices at once for a reported ~10×.
- the **cyclic implication chain** `v₁,k ⇒ v₂,k ⇒ … ⇒ v_m,k ⇒ v₁,k` per colour, to force a set
  monochromatic with fewer clauses than a companion graph.
- **one-time extraction of the common part of the CNF** (§5.8).

**Control:** reproduce known verdicts on his own objects (`v374e1860 ∪ ρS136` refuses four;
`v374e1860` alone with `C` = his `S136` refuses four; each with one vertex deleted is colourable
where the census says so). **And each lever is measured separately against the recorded trace, so a
speedup claim names its population** (`G21`, fourth instance).

### Phase C — the hypergraph `Y`

Degree 1 by the existing census. Degree 2 by `hyperedges_run.py` **at the full order-24 collapse,
not 6** — `C(n,2)/24`, roughly `7,900` orbit asks on a 613-candidate object, against the `31,000`
the file currently assumes. **Requires the selection to be orbit-closed**, which is true before a
descent breaks symmetry and false after, so the census runs first. Degree 3 **harvested, never
enumerated** — from failed bisections and from `exact.py`'s minimalized correction sets.

**Controls:** every hyperedge re-verified by an independent rebuild of the induced graph; no
hyperedge contains a lower-degree one; and the count carries its enumeration (which pairs were
asked, which were reached by symmetry).

**Before enumerating anything, compute the three cheap statistics** that say whether phase 2 fits:
the number of non-isolated vertices of the degree-2 graph, its component profile (the maximal
independent set count is exactly multiplicative over components), and its independence number
`α`. A **rigorous lower bound** on the candidate count is `2^m` for an induced matching of size `m`,
computable greedily in milliseconds — and `α(G₂) + |free| < |W| − target` is a genuine impossibility
test that costs one RC2 solve.

### Phase D — phase 2, and `{M}`

Minimum hitting set by `exact.py`, **extended to enumerate the whole optimal level** by blocking
each found optimum and re-solving; deduplicate by the input group *before* verifying (up to 24×
fewer asks, and it is what makes his counts non-isomorphic); `A = ⋃{M}`.

**The level is an antichain** — the incumbent updates once per level, not once per ask — so it is
embarrassingly parallel and the sequential-acceptance floor that has burned this project twice does
not apply here. Polarity, easy to get backwards: **a success keeps the property, hence UNSAT, hence
the expensive ask**; the level costs `L` cheap asks plus `|{M}|` expensive ones.

**Report `A`'s growth curve** and stop when it has not grown for `k` consecutive minima, so the
stopping decision is visible rather than implicit. On the S case, run the level to exhaustion — it
costs minutes and it is the calibration.

### Phase E — the loop

`A = ⋃{M}`; expansion by partially-filled base orbits first (*"especially orbits with a small number
of vertices (6 or 12)"*), then the reserve `R` (an orbit joins `R` *"if, when added to the graph
`A`, the degree of some of its vertices is at least 4"*, added in decreasing vertex degree); L and S
alternating against a frozen companion; the symmetry rung set by pendants in `C`. Escape a local
minimum by *"increasing the number of new vertices introduced in the expansion stage"*.

**The path to walk, and it has FOUR states, not the three the handoff stub recorded:**

| # | output symmetry | `M` | `\|{M}\|` | `A` | move |
|---|---|---|---|---|---|
| 1 | 3 | 376 | 96 | 451 | from Heule-529's `L393` + orbits `(0,0,12,0)`, `(0,0,2,2)`, `(4,0,10,2)`, `(10,0,2,4)` |
| 2 | 1 | 375 | 282 | 403 | reduce `A451` |
| 3 | 2 | 374 | 78 | 406 | + orbits `(0,0,0,4)`, `(0,0,6,6)`, fill `(4,0,0,0)` *as he writes it; his files add the other halves of `(0,0,2,2)` and `(0,0,2,6)`, and `(4,0,0,0)` is already full in `A403` (§S.2 #9)* |
| 4 | 1 | **374** | **1092** | 412 | the same working graph at rung 1 — **`M` unchanged, `{M}` grows fourteenfold** |

**States 3 and 4 are one working graph reduced at two rungs, not two loop moves** (§S.2 #9):
`A406 ⊆ g(A412)`, so state 4's fourteenfold growth is a **rung relaxation** — which grows `{M}` with no
expansion at all (M64 §R1: 40 → 3,264 at 375). It is a replay control; the loop's own test is §S.1
2(b)–(c).

*We do not hold Heule's 529, so state 1's stated input is unavailable; `v451e2400.vtx` (his `A451`)
is, so states 2→3→4 are runnable end to end on his own data.*

---

## §5 — Registered predictions

| # | prediction | decided by |
|---|---|---|
| P1 | ~~Table 3's `A` column really does sum to 402, and `v412e2106.vtx` has 412 vertices — i.e. the table is missing rows, not mistyped~~ **MET, and sharper than registered: not missing rows but two typos, each under-reporting a FULL orbit, and the deficit is exactly 10** (§1) | phase A, done |
| P2 | reducing `v166e774` returns `M = 136` and `\|{M}\| = 8` with edges in 564–567 | **met** (§R1) |
| P3 | reducing `v451e2400` at output symmetry 1 returns `M = 375`, and its minima vary only in the orbits Table 2's `375` `{M}` column marks unstable | **partly met**: 375 met (M64); two range differences attributed to his column (§S.2 #4); the shading test is §S.4 C2 |
| P4 | the degree-2 hyperedge count on our own 757 arena is in the **tens**, not 10³–10⁴, because a pair cannot be critical when 248 vertices delete freely | **retired** — M62's arena is off the path (§S.3) |
| P5 | maximal-independent-set enumeration on the 757 arena is infeasible at every symmetry rung (induced-matching bound `2^m`), and affordable on his `A412` — the controlling variable is the **gap** `\|W\| − \|M\|`, ~38 for him and ~248 for us | **retired** — explicit enumeration is not implemented (§S.3) |
| P6 | the §5.10 numerical indicators are subsumed by `exact.py`'s hitting-set bound; the MIS-of-degree-2 bound never exceeds it | **retired** — `exact.py` is off the path (§S.3) |
| P7 | seeding `exact.py --seed-corr` with the degree-2 census moves its lower bound materially (it sat at 176 after 100 iterations on 245 fat correction sets; a size-2 core is worth ~1/2 per vertex against ~1/148) | **retired** — same (§S.3) |
| P8 | one full iteration at his scale (`A412 → 374`) costs ≈ 3.5 h on the 32-core desktop, ±2×, dominated by ~10⁵ SAT asks at a mean of 2–4 s (phase 2 is dominated by *colourable* asks, which are fast) | phase D — the ask means it assumed are ~100× the measured ones (§S.2 #11); the revised forecast is registered there |

---

## §6 — What this milestone must NOT do

- **Beating 509 is now part of the goal — the comparison discipline is not relaxed.** Kooshi,
  2026-09-11: *"The goal is to reproduce or beat Part's record. […] We can absolutely beat the record,
  it is just a matter of implementation."* That replaces this bullet's earlier *"Not beat 509"*. What
  stays is the discipline around **comparisons with his tables**: tune on his L path only, stamped
  TUNING; freeze in a commit; run the held-out problems untouched — because that is what lets
  "reproduced" mean *his algorithm* and not *a fit to his numbers*. **A record needs no such
  discipline** — a smaller graph certified in the Lean kernel speaks for itself — so record-hunting runs
  (§S phases C4 and F) may use any configuration, on one condition: **nothing they learn may edit the
  frozen configuration before phase E has run** (§S.4, Order). The acceptance for both halves is §S.1.
- **Not tune on the held-out set.** Freeze after the L path, write predictions down, then run the
  held-out problems untouched (§S.4 phase E).
- **Not report a joint reduction as his algorithm.** He minimized L and S separately against a frozen
  companion (§5.3), and Table 1's M-type rows have **blank** `A` and `{M}`: he ran no loop on the 509
  itself. A joint reduction with both halves deletable (§S phase C4, and F) is a record-hunting
  experiment — compared with his tables on `|M|` and edges only, never as a reproduction row.
- **Not leave the base unfrozen.** `Base(2.6)` is frozen here, with `orbits_meeting_disk(2.0)`
  available so "his stated construction" and "our truncation" can be compared rather than assumed
  equal. The next session's genome is a bitset over a fixed base; if the base moves, nothing compares.
- **Not generalize toward FS-6.** A rehearsal that is also a generalization is neither.
- **Not let `exact.py` stand in for his algorithm.** The mapping is real — his hyperedges are our
  minimal correction sets, his phase 2 is our hitting set — and it is **his algorithm with the beam
  collapsed to one**, which is exactly what overcompression says cannot reach the record. A
  hitting-set solver returns *an* optimum; his phase 2 returns *every* optimum at the first feasible
  size, and that set is the loop's state.
- **Not report an uncertified verdict as a find.** Verdict vocabulary: no word means "clean"; a cap
  is never a negative; every count carries its enumeration; any phase over ~15 minutes checkpoints
  and resumes exactly; report from inside a phase, not only at its end.

---

## §7 — Instruments, costs, addresses

**New this milestone:** `tools/parts_repro.py` (his base, labels, type-M split, fillings, and the
self-test that is §1), `tools/parts_vtx.py` (exact parser for his `.vtx` files, including the nested
radicals `√(5(7±√33)/2) = (√55 ∓ √15)/2` that appear on the S side of the assembled graphs),
`tools/parts_verify.py` (all 43 objects against their own filenames).

**Data:** `data/m62/parts-ref11/` (his archive, trimmed to `JP/` + provenance + checksums, 740 KB —
the 73 MB zip and 57 MB of plots were dropped, with the live URL and checksum kept as the evidence),
`data/m62/parts-table2-orbit-fillings.json`, `data/m62/parts509-orbit-fillings.json`,
`data/m62/parts-ref11-verified.json`.

**Existing and reused:** `typem.py`, `census*.py`, `descent3.py`, `exact.py`, `hyperedges*.py`
(written, never run), `lowerbound.py`, `mkstate.py`, `symstate.py`.

**Not needed, decided rather than deferred:** a Rust engine. The SAT oracle is >99% of the cost and
the enumeration around it is bookkeeping; the host language moves the wall clock by zero, where the
solver version moves it 20% and §5.9's encoding levers a reported 10×. The one trigger that would
change this: a level's candidate list past ~10⁶ after pruning, where orbit canonicalization of
bitsets lands on the critical path.

**Solver:** CaDiCaL 1.5.3 measured best here (1.9.5 +19% on our recorded trace, 3.0.0 ≥ 6× worse);
the engineering advisor measured 1.9.5 8% *better* on its own trace, so that row is a live
disagreement and is not load-bearing for anything in this plan.


---

## §M — The domain-modelling pass (WORKFLOW step 5, `debruijn-domain-modeling`)

The pass was run on his vocabulary before any of it was implemented. It produced one collapse, one
correction to a finding made earlier the same day (§1 vi), and three predictions that were confirmed
on his own files afterwards.

### The collapse: `granularity` and `sym` are the same unnamed role

`mkstate.build(..., granularity="vertex"|"orbit")` and `symstate.build(..., sym=24|6|3|2|1)` are two
parallel mechanisms doing one job — **N declarations identical modulo naming, a role unnamed.** The
role is *the partition of `W`'s deletable vertices into indivisible atoms*, and it always comes from
the same place: **the orbits of a chosen subgroup.** Vertex granularity is the trivial subgroup;
orbit granularity is the whole base group; a symmetry rung is a subgroup in between. One type, three
constructors, and the flag disappears.

### The model

| object | shape | why this and not the alternative |
|---|---|---|
| `Lattice` | `a ≡ b ≡ c ≡ d (mod 2)` **and** `a − b + c + d ≡ 0 (mod 4)` | the mod-4 clause is part of the lattice, not a component choice — dropping it costs group-closure (§1 vi). A graph anchored elsewhere is a **translate**, handled by translating. |
| `Base` | the lattice truncated once at a generous radius, carrying per-orbit `(r_min, r_max)` | *"within radius r"* then becomes a **selection predicate with two honest readings** — `meets` (`r_min ≤ r`, his stated *"completely or partially"*) and `inside` (`r_max ≤ r`, our `parts_lattice`) — instead of a constructor parameter that silently picks one. An orbit carries two conjugate radii, so a disk is not group-invariant and no single number can be the answer. |
| `Drawing` | a vertex set over the base plus its derived edges | `M`, `A`, `W`, `R`, and the `L`/`S` halves are one type in five roles. Five types would be five copies of one thing. |
| `Companion` | **(extra vertices, extra edges)** adjoined to `W`; the key property is *`W ∪ C` refuses four colours* | four constructors — `frozen_side`, `mono_pair` (0 vertices, 1 edge), `non_mono_set` (a 3-clique joined to every member), `pendants` — and **C's vertices are never deletable**, which is exactly why pendants set the symmetry for free. This is our own kernel's bridge (`Pigeonhole.mono_pair_of_not_colorable_append`, ledger row 31) as a data structure, and it is what turns one paper into fifteen results. |
| `Symmetry` | a **pair** `(inp, out)` with `out ◁ inp ≤ Aut(W ∪ C)` | not four ad-hoc parameters. `out` is the **output** symmetry and its orbits are the atoms; `inp` is the **input** symmetry and the quotient `inp/out` is the dedup group. Normality is what makes the quotient act, and it is an invariant of the type rather than an unstated assumption. |
| `Atoms` | the `out`-orbits of `W`'s deletable vertices | derived, never configured. The unit of every deletion, hyperedge and candidate. |
| `Y` | an **antichain** of atom-sets | minimality is an invariant enforced at insertion. *"No hyperedge may contain a lower-degree one"* was going to be a control run afterwards; it is a property of the type. |
| `{M}` | a set of **canonical representatives** under the `inp/out` action (the minimum over the images) | *"quotient or canonical form?"* — the group is finite and small, so canonical form, computed once at insertion. That makes *"non-isomorphic"* a property of the type instead of a convention in prose, which is what §3 needed. |
| `A` | the union over the **full `inp`-orbit** of each representative | **not** the union of the representatives. `A` must be `inp`-invariant, and canonicalizing first would break that — this is finding (v) as a design rule instead of a nuisance. |

### Three predictions the model made before being consulted, all confirmed on his own files

- **Table 1's symmetry column is `|Stab(M)|`.** Measured in `Aut B`: `v374e1860` → **2** (his row reads
  *"1 (2)"*), `v136e564` → **1** (his row reads *"1"*). So the parenthetical is the actual stabilizer
  of the fewest-edge member and the bare number is the `out` subgroup the search was constrained to —
  it is not a second search parameter.
- **The accumulative graph is more symmetric than its minima**, because it carries `inp` where they
  carry `out`: `v412e2106`, `v406e2082`, `v451e2400`, `v403e2112` all have stabilizer **12** against
  `v374e1860`'s **2**; `v166e774` has **6** against `v136e564`'s **1**.
- **Canonicalization separates genuinely different minima and collapses group-images.** The four held
  374-vertex minima give **4 distinct canonical forms**; a planted group-image of `v374e1860`
  canonicalizes equal to it (control fires); `v374e1864` does not (negative control fires).

### What the model refuses to represent

An atom that is not an `out`-orbit; a hyperedge that contains another; a `{M}` holding two
group-images of one graph; a `Symmetry` whose `out` is not normal in `inp`; a `Companion` vertex in
the deletable set. Each of those was reachable in the current tools and each is a way the
reproduction could report a number that means something else.

---

## §O — The obligation-modelling pass (WORKFLOW step 5, `debruijn-obligation-modeling`)

### The space, and the one theorem everything is an instance of

The state space is the finite lattice of subsets `S ⊆ Atoms`. One predicate:

  `R(S)` := *`W[S ∪ fixed] ∪ C` refuses four colours* — the key property.

**`R` is upward closed**, because adding vertices to a graph that is not 4-colourable cannot make it
4-colourable — and *that is a property of the SHAPE the domain pass chose*, not a separate fact:
expressing every key property as non-colourability of `W ∪ C` makes monotonicity structural. Dually
`¬R` (colourability) is downward closed, so the maximal colourable sets and their complements — the
**minimal correction sets** — are the extremal data, and

> **`R(S)` ⟺ `S` meets every minimal correction set.**

That is MCS/MUS hitting-set duality, it is exact in both directions, and it is why Parts's phase 2
and our `exact.py` are the same algorithm: **his hypergraph `Y` IS the family of minimal correction
sets, and his phase-2 enumeration IS minimum hitting set.**

### (1) Completeness, as an invariant rather than a hope

Write `Y*` for the complete family and `Y ⊆ Y*` for what has been harvested. Three obligations:

**(a) Termination of the optimality loop.** Each non-optimal iteration produces a correction set `C`
that the current hitting set `h` misses, so `C ∉ Y` and `|Y|` strictly grows. **Measure:
`|Y*| − |Y|`**, bounded because `Atoms` is finite. At most `|Y*|` iterations.

**(b) The lower bound is rigorous at every instant.** `Y ⊆ Y*` means *fewer* constraints, so
`mhs(Y) ≤ mhs(Y*)`; and when the returned `h` satisfies `R(h)`, `h` is a transversal of `Y*`, giving
`mhs(Y*) ≤ w(h) = mhs(Y)` and hence equality. **The sandwich closing IS the optimality proof** — a
run stopped early still reports an honest interval, which is why a budgeted run here does not lie.

**(c) Completeness of `{M}`.** Enumerate at weight exactly `w*`, holding `E` = optima found:

> **Invariant.** `E ⊆ {S : R(S), w(S) = w*}`, and every `S` with `R(S)` and `w(S) = w*` that is not
> in `E` is still feasible for the current MaxSAT instance.

*Preservation.* A blocking clause removes only a member of `E` (already `R`-true and recorded); a
new correction set removes only sets that are not `R`-true. **Neither ever removes an unrecorded
`R`-true `w*` set.** *Termination.* Each iteration grows `E` or grows `Y`; **measure
`(#{S : w(S) = w*} − |E|, |Y*| − |Y|)`, lexicographic.** *At exit (UNSAT).* No `w*` set both hits
all of `Y` and avoids `E`; every `R`-true `w*` set hits all of `Y* ⊇ Y`; hence it is in `E`. ∎

*The one step that is easy to get wrong and is written down here so it is not:* when `¬R(h)`, **do
not block `h`.** Blocking it would be sound but wasteful; adding the correction set `h` misses
removes `h` and infinitely many like it, and blocking would let the same `h` return under a
different guise. And **every correction set must be verified before insertion** — `exact.py`'s are
derived from an actual colouring, so they are verified by construction; a *guessed* one would let
`mhs(Y)` exceed the truth and turn the lower bound into an unsound optimality claim. Its shrink loop
is also safe under a capped ask, because it treats *undecided* as *still needed*, and a non-minimal
correction set is still a correction set.

### (2) Soundness of the pre-filters — three sound, one NOT, and the one that is not is the report

| filter | obligation | verdict |
|---|---|---|
| degree-1 census fixes criticals | if deleting `{a}` alone loses `R`, every `S` missing `a` is `⊆ Atoms∖{a}`, and `¬R` is downward closed | **sound**, from monotonicity alone |
| correction-set pruning | `R(S) ⟹ S` meets every correction set | **sound**, the duality |
| beat-the-incumbent pruning | we want only the first feasible size; a candidate that cannot reach it cannot be in `{M}` | **sound**, and it is what makes `{M}` the level set rather than everything |
| **the atom partition** | restricting to `out`-symmetric candidates **provably loses minima** — that is overcompression, his own §5.8 | **NOT sound, and must never be reported as if it were** |

**Monotonicity is the hypothesis everything leans on, so name where it breaks:** *"χ is exactly 5"*
is not monotone; *"1-minimal"* is not; *"admits a proper 4-colouring"* is downward, not upward. The
guard is structural — a key property is admissible here **only** if it is expressible as
`¬ Colorable(W ∪ C, 4)`, which is what the `Companion` type enforces.

**The last row is this milestone's sharpest reporting obligation**, and it is exactly where a word
meaning "clean" would lie. The verdict for a search at `out ≠ 1` is **`exact-at-rung`**, never
`exact`; `exact` is available only at `out = 1`; and the rung travels in the same sentence as the
number, per `G21`. Nothing else in the vocabulary may be read as "we found the minimum".

**Canonicalization merges exactly the `inp`-orbits and nothing else** (measured: the four held
374-vertex minima give four distinct forms, a planted group image collapses, a genuine sibling does
not). So the honest report is **`|{M}| up to Aut B`**, never *"up to isomorphism"* — which is also
precisely the ambiguity that makes his own `1092` un-gateable (§3).

### (3) The outer loop has NO measure, and saying so is the finding

Expansion adds vertices, so `|W|` is unbounded above; and his own success criterion fires when
`{M}` grows at fixed `|M|`, so `|M|` is not a measure either. **The loop does not terminate, and
the real stopping rule is "`A` stopped changing".** Therefore:

- report `(|M|, |{M}|, |A|)` **every iteration**, with `A`'s growth curve;
- **`stalled` is a verdict, not a success** — all three unchanged for `k` iterations;
- a stall is a control signal: his own escape is *"increasing the number of new vertices introduced
  in the expansion stage"*, so the monitor feeds the next expansion rather than ending the run.

### (4) What the kernel owes: nothing, and the decline is priced

The reproduction certifies **his** object, not a new one, and *"a formalization of a known theorem
is no longer news"* is standing policy. **But the cheap thing should be named rather than left as a
gap**: `¬ Colorable(Parts-509, 4)` through the existing `UDCert` + LRAT chain would be the
**smallest kernel-certified 5-chromatic unit-distance graph anywhere**, at 509 vertices and 2442
edges — *smaller than Heule-510, which this repository already certifies* — so the machinery is
built and the instance is the smallest it has ever been handed. **Priced at an afternoon on the M06
pipeline and DECLINED for M63**, because it is a control on a calibration corpus rather than a
result, and because the objects that will need certifying are the ones our own pipeline finds.
Recorded so that *"we reproduced the record and never certified it"* is a decision and not an
oversight.

### (5) Vacuity guards, each with its own verdict word

- **`R(Atoms)` must hold before phase 1** — if the working graph itself does not keep the property,
  every claim downstream quantifies over an empty set. Verdict **`base-fails`**, its own word,
  folded into nothing. (This is the base-satisfiability guard the census already carries as control
  flow; it is here promoted to a value, exactly as `Arity.arityFloor_eq_zero_iff` did for the
  emptiness detector.)
- **`w* = w(Atoms)`** — nothing is deletable, `{M} = {W}`. Not vacuous but trivial. Verdict
  **`no-reduction`**.
- **`w* = 0`** — the empty selection keeps the property, i.e. `C` alone refuses four colours, so
  `W` is doing no work at all. Verdict **`companion-suffices`**, and it is a bug in the setup rather
  than a result.

---

## §E — The experience-modelling pass (WORKFLOW step 5, `debruijn-experience-modeling`)

**The cut, for this milestone.** What the system knows and the record will not is **the order things
happened in** — was the parameter set fixed before or after the number was seen? That is not
recoverable from a results table, and it is the entire difference between a reproduction and a fit.
So it has to be serialized, and the only serialization that cannot be quietly edited is **git**.

### The four things now structurally impossible, in `tools/parts_report.py`

Not discouraged — **unwritable**. Every refusal is planted and watched to fire by
`python3 tools/parts_report.py` (13 checks, all green).

1. **There is no verdict word for optimality at all.** A search returns
   `Bound(lower, upper, rung, undecided)`, and `closed` is true only when `lower == upper` **and**
   `undecided == 0`. Whether that is *the* minimum or the minimum over `out`-symmetric selections is
   read off `rung`, which every rendered form carries: `minimum 374 over all selections` versus
   `minimum 376 over rung-3-symmetric selections`. §O(2) proved the atom restriction unsound, so the
   rung is the scope and cannot be separated from the number.
2. **A count without its enumeration will not serialize.** `Count(n, method, of)`, with `method`
   from a closed list and `truncated` a **value** of it rather than an absence — `G21`'s general
   form. `Count(5, "clean")` raises; so does a truncated count that does not name its population.
3. **`|{M}|` cannot be a bare integer.** `SetSize(count, up_to)` — the group is a required field.
   His own `1092` is un-gateable precisely because his paper does not name the group, and this type
   is what stops us reproducing that ambiguity in our own record.
4. **A comparison to his tables carries the mode it was produced in.** In `tuning` mode every row
   renders stamped `** TUNING - not evidence **`; a `frozen` row cannot be constructed without the
   commit its prediction was registered in. Rows also carry his value's **attestation count**,
   because the verification pass measured that all four of his `M` columns check and three of four
   `A` columns do not.

**And there is no `reproduced` field, deliberately.** Rows say `agrees` or `differs` and nothing
sums them. Reproduction is a judgement over a whole held-out set, made once by a human reading
frozen predictions against frozen results; a per-row boolean that adds up to it is the fit wearing
a checkmark.

### The freeze is a commit, not a config field

`data/m62/m63-freeze.json` holds the frozen configuration (not yet written); `require_frozen(config)` —
**which as shipped crashes on its first use, §S.3 X-5, repaired in phase C1** — refuses to run
a held-out experiment unless (i) the file exists, (ii) **it has no uncommitted edits** — *a freeze
that can be edited after the fact is not a freeze* — and (iii) the config offered equals the frozen
one, naming the differing entries when it does not. Every artifact stamps `freeze_commit` and
`config_sha256`, so *"was this tuned after we froze?"* is answered by `git log`.

### The per-iteration line, for a loop with no measure

Since §O(3) says the outer loop does not terminate and *"`A` stopped changing"* is the real stopping
rule, the line carries **exactly the three quantities his success criterion is about, each with its
delta** — all three zero **is** the stall — plus the hypergraph's shape and the stall counter:

```
it 7   rung 3   W 451   |M| 376 (+0)  |{M}| 96 (+14)  |A| 451 (+0)   Y: d1 88 d2 611 d3 24   STALL 4/6   [f47e1f3·a19c4d21]
```

**And a level is forecast before it is entered, never after** *(as specified it presumes his explicit
candidate list, which the implicit hitting set never builds; §S.3 X-7 proposes the replacement)*. The cost is `|candidates|` cheap asks
plus `|{M}|` **expensive** ones — a success KEEPS the property, hence UNSAT, hence the 10-second ask
— and the expensive count is unknown until it happens, so `level_forecast` returns the projection
**and the assumption it rests on**, printed in the same breath. A level whose candidate count cannot
be bounded (§4 phase C's induced-matching `2^m` test) is **REFUSED before any ask**, which is the
verdict that saves the six hours rather than discovering them.

### The artifact schema, so "same object?" is a comparison

**Two fingerprints per selection, not one** — `fp` over his `(a,b,c,d)` coordinates as found, and
`canonical_fp` over the group-canonical frame — because finding (v) showed his own files are each in
their own frame and a literal containment test reports a false negative. Plus `fp_base`, over the
radius, orbit labels and orbit sizes, so *"do not leave the base unfrozen"* is checkable rather than
promised. `{M}` carries each member's **orbit-filling profile**, which is both §3's gate and the
space M62's genome will live in. Every artifact stamps machine, cores, git commit, git-dirty,
freeze commit and config hash.

---

## §R1 — THE DECISIVE EXPERIMENT: his S-subgraph reduction, reproduced on every attested number

*Run 2026-09-10 on the machine, one core, 588 s. Artifact `data/m62/m63-S166-reduction.json`;
instruments `tools/parts_stage.py`, `tools/parts_reduce.py`, `tools/parts_minima.py`.*

**The setup, and why it is decisive.** Both the input and the output of one complete iteration of
his algorithm are published: `v166e774.vtx` is his accumulative S-graph `A`, and `v136e564.vtx` is
one of the minima it reduces to. Our pipeline saw only the input. The companion `C` was his own
`v374e1860` (an L-subgraph), frozen; the rung was **1**, which is the output symmetry his Table 1
gives for that row; nothing was tuned, because there was nothing to tune — this was the first run.

**First, the stage reproduces his 509 from our own geometry.** `Stage(L374, S136)` builds
**509 vertices, 2442 edges, and exactly 18 connection edges not touching the shared centre** — his
`12` reference plus `6` auxiliary, i.e. the subtype name `M6` read off the edge count — with the
cross edges coming from *our* `ρ₁₅` law and nothing from his tables. It refuses four colours.

**Then the reduction, against Table 1's S-subgraph M6A row:**

| quantity | `[Parts2020a]` | ours | |
|---|---|---|---|
| `\|M\|` | **136** | **136** — `minimum 135 over all selections`, plus the shared centre | agrees |
| edges of `M` | **564–567** | **{564: 6, 565: 6, 566: 24, 567: 12}** | agrees, and both endpoints attained |
| `\|A\|` | **166** | **166 — and `A` equals his `v166e774` AS A SET** | agrees |
| `\|{M}\|` | **8** | **8** up to `Aut(A)` (order 6); 24 up to `Aut(A) ∩ Aut(C)` (order 2); 48 as found | agrees, once the group is named |
| his own `v136e564` | — | **is one of our 48 minima** (six of its group images appear) | — |

**`A = ⋃{M}` recovering his published accumulative graph vertex for vertex is the strongest single
result here**, because `A` is the loop's state variable and it is the thing a descent has no
analogue for. The level closed properly — *"next candidate weighs 136 > 135: the level is
complete"*, method `exhaustive-level`, **zero undecided asks** — so the bound is
`lower = upper = 135` at rung 1 and is therefore the true minimum, not a rung-restricted one.

**And it settles the convention his paper leaves unstated, by measurement.** §3 recorded `|{M}|` as
un-gateable because *"non-isomorphic"* is never defined and §5.8 removes duplicates by *"the set of
permutations of the quotient group"* — a property of his run. Our 48 raw minima give **24** up to
the stage's own input symmetry `Aut(W ∪ C)` and **8** up to `Aut(A)`, the symmetry of the reduced
graph with the companion free to move with it. **His number is 8**, so that is his convention, and
`|{M}|` is gateable for the rest of the milestone where it was not before. *This is exactly what the
experience pass's `SetSize` type was for: a bare integer would have hidden the question.*

**The hypergraph, for calibration.** 96 degree-1 hyperedges (critical atoms) of 165, then 773
correction sets in all — by size `{1: 96, 2: 106, 3: 133, 4: 179, 5: 53, 6: 130, 7: 39, 8: 22,
9: 13, 10: 2}`. His §6 says he used *"degrees 3 or 4 for S-subgraph"*; harvesting them lazily from
the solver's own models reaches degree 10 for free.

**The cost, with its populations separated** (they differ by 12×, so a merged mean would describe a
mixture nobody can reproduce): **13,176 colourable asks at 0.009 s** and **3,076 refusing asks at
0.108 s**, 16,252 in all, **zero undecided**, 588 s on one core. His own §5.10 budget for the
S reduction was *"slightly more than 10⁵ checks … slightly more than a day on a standard laptop"* —
we are 6× fewer asks and 150× faster in wall clock, on one core, which says the implicit
hitting-set form is a real improvement on his explicit enumeration and not merely a restatement.

**One instrument incident, caught by the house rule and not by luck.** The first run of phase 2 was
**silent for five minutes at 99.5 % CPU** — my own tool breaking *"report from inside a phase, never
only at its end"*, because the loop logged on `OPTIMUM FOUND` and every fifth minimum and nothing
else. It was killed and rebuilt with a time-gated per-iteration line carrying the rising lower
bound, the two ask populations with their separate means, and a tick inside the correction-set
shrink; only then was it possible to see that the bound was climbing 118 → 135 rather than stuck.
 shrink. The lesson generalised into the house rule this milestone now runs under.

---

## §R2 — Phase C: what ran, what fired, and what every registered prediction scored

*Written 2026-09-11 by de Bruijn (the phase C implementer) as the phase ran, on the machine (the
32-core desktop, 125 GB). The subplan is `plans/M63-phaseC-joint-stage.md`; its §6 is the acceptance
checklist this section answers box by box. The product owner's §A.2 redirection set the order: the
cross-edge law, the ask wall, exact resume, the minimum driver, C4's three controls, the predictions
committed, the announcement, the launch — then everything else while the run goes.*

### R2.1 — The scoring of every registered prediction (subplan §4)

| # | registered | measured | verdict |
|---|---|---|---|
| P-C1.1 | both regenerations are `regenerated-identical` on minima, bound and `A`; **`Y` identical too** | L451 and S166 both `regenerated-identical` on stage fingerprint, bound, verdict, `M_vertices`, `A`, `A_atoms`, level size and the minima as a set. `Y`: 719 against 703 on L, 759 against 773 on S, differing both ways | **met on the level, FALSIFIED on `Y`** — and the falsifier was already in the plan: §O2 proves the harvest is a launch artifact, so the prediction demanded something the same subplan had shown could not be demanded. Recorded as a lesson about registering a prediction against a proof one already holds |
| P-C1.2 | PySAT's `cadical153` honours `interrupt()` | it raises `NotImplementedError('Limited solve is currently unsupported by CaDiCaL')` — from inside the timer thread, where the exception is printed and swallowed while the ask runs on | **FALSIFIED, and worse than its own falsifier.** The registered falsifier was "the 1 ms wall returns unsat"; the truth is that the wall does not return at all. Replaced by a conflict-budget loop (R2.3) |
| P-C4.0 | the joint stage's asks rise above the frozen-companion stages but **stay under a second** (Poros, 0.60) | quiet, min of three, CPU: full working graph **5.73 s** refusing, the record's own selection **8.74 s** refusing, the record minus one atom 0.008 s; phase-1 population 0.170 s colourable / **1.758 s** refusing against 0.006–0.009 / 0.02–0.108 | **FALSIFIED on the expensive population** (16–88× and seconds, not tenths), **met on the cheap one** (20–28×, still under a second) |
| P-C5.1 | the explicit law reproduces the L451 fingerprint and the record's 2,442 edges at no measurable cost | fingerprint `0700718c70107448b8658a630c5456ee` unchanged; the record stage rebuilds at 509 / 2,442; 126 ordered cross edges on the base under both laws | **met** |
| P-C4.1 | the joint minimum over `A412 ∪ ρ·g⁻¹(A166)` is exactly 509 vertices (planner 0.60, Poros 0.65) | no optimum after 4.9 h; rigorous lower bound **503 atoms = 504 vertices**, incumbent upper bound 509 (the record is a selection of this working graph and refuses) | **not decided** — window {504, …, 509}; the falsifier (≤ 508) has not fired |
| P-C4.2 | if 509, every minimum found splits as (374, 136) | `minima 0`: no minimum exists to split. Phase 1 splits the forced atoms 333 L / 90 S and the free atoms 78 L / 75 S | **not decided**, and undecidable while P-C4.1 is |
| P-C4.3 | phase 1 < 60 s; the bound closes within 90 minutes; ≥ 1,500 correction sets | phase 1 **85 s** / **106 s**; the bound has not closed in **4.9 h**; correction sets **1,966** / **1,846** | **FALSIFIED**, two clauses of three — and decided now: no later verdict can rescue the 90-minute clause |
| P-C4.4 | C4b, the second relative frame, also closes at 509 (0.5, no higher) | no optimum after 4.8 h; lower bound **499 atoms = 500 vertices**, no upper bound below the working graph's 577 | **not decided** — window {500, …, 577} |
| P-C2.1 … P-C2.7 | the S166 and L451 audits, the shading, Tables 5–7, `Y`, the open rungs, the involution class | *pending — C2* | *pending* |
| P-C3.1, P-C3.2 | the M6B level and the "M6A&B" column | *pending — C3* | *pending* |

### R2.2 — The joint stage, and the controls whose answers were known in advance

**c4.1, the positive control, fired in its strongest form.** Over the record itself with both halves
deletable: verdict **`no-reduction`**, minimum **508 atoms + the shared centre = 509 vertices**,
**exactly one minimum** (`exhaustive-level`, 0 undecided), phase-1 census **508 critical, 0
droppable, 0 unknown**, 58 s. The answer is a theorem given his published minimality of 374 against
`S136` and 136 against `L374` plus upward closure (§O9), so this is a control with a derived
expectation rather than a hope. **It also discharges B-10's unchecked half**: every single-vertex
deletion of the record, on either side, is colourable — and that is what "0 droppable" says.

Poros's sharper form earned its keep: *"it refuses"* would have passed on a stage carrying spurious
cross edges; *508 critical with exactly one minimum* would not.

**The planted S-omission fired solver-free.** The bug (`deletable = Lbits & ~centre` for `"LS"`) is
literally the L-only stage's deletable set, so building it gives 373 atoms over one half and the
control reports `joint-stage-omits-a-side`. Planting the bug rather than a stand-in for it means no
solver's mood can explain the result away.

**c4.2** `pin-agrees-everywhere` on the joint stage over `A412 ∪ ρ·g⁻¹(A166)`, 12 checks.
**c4.3** `joint-degenerates-to-L`: 20 of 20 seeded selections agree verdict for verdict between the
joint stage with every S atom forced kept and the L-only stage over the same working graph.

**A control that came free and is worth more than either planted one.** The joint working graph
contains the record, so the record's own 508-atom selection is a near-optimal ask whose verdict is
known in advance — it refuses — and the record minus one atom is colourable. Both fired, on a stage
built independently of c4.1's.

### R2.2b — C4a and C4b: NO VERDICT, a rigorous partial bound, and a halt

**Both runs terminated at five hours without closing, within seven seconds of each other, and
neither wrote its record.** Logs end mid-iteration with no verdict line and no traceback.

> **Record note (review 2026-09-13).** The per-iteration numbers in this subsection come from `build/gate/m63/c4a.log`,
> `c4b.log` and a checkpoint under `data/m62/ckpt/`, none of which was committed (`build/` is gitignored; the checkpoint
> directory is ignored since `5c752e5`), so the `[504, 509]` bracket is a reading of uncommitted logs and is not
> re-checkable from `data/`. Separately: the `his_recorded_move` field that `3e343e5` found FALSE is corrected only in
> `data/m62/m63-map-A412.json`; `m63-sweep-protocol.json` (a frozen pre-registration, deliberately unedited) and the producer
> `tools/parts_loop.py` still carry the old text — `data/m62/README.md` marks them.

| | C4a (frame coset 1) | C4b (frame coset 2) |
|---|---|---|
| last iteration | 1576 | 1455 |
| **lower bound reached** | **503** of the 508 ceiling | **500** of 508 |
| correction sets `Y` | 1,998 | 1,877 |
| asks | 32,357 colourable @0.0425 s / 7,559 refusing @0.4678 s | 29,295 @0.0429 s / 6,714 @0.5151 s |
| **undecided** | **0** | **0** |
| elapsed | 18,228 s | 17,990 s |
| log stops | 22:57:55 | 22:57:48 |
| last checkpoint | 22:57:15 | 22:57:24 |

**THEY DID NOT CRASH. The product owner terminated them at 22:57**, one `SIGTERM` to each of two
verified process groups, seconds apart — which is exactly why they died together. I reported it as
an unexplained simultaneous termination and halted, because that is what the evidence supported
before the cause was known; the reasoning was right and the external cause was the product owner.
**A future reader finding two intact checkpoints must not conclude these runs crashed.**

**No verdict exists, and none will: the joint route is abandoned**, on Kooshi's ruling —

> *"It seems like shrinking the two halves together are not worth the computational cost it
> incurs. Freezing one half appears to have produced a vertex critical graph, so unless you can
> prove shrinking both halves together can beat it, its slow speed seems objectively worse."*

No such proof exists, so slower is worse. **The checkpoints are not to be resumed.** The wider
correction the ruling carries, and it outranks the runs: the product is reproducing his *method*
so it can reach objects he never did, and the joint route had drifted into optimising *his
specific object* instead.

**The bracket is the deliverable, and it is what makes this a closed question rather than a sunk
cost**: the joint route was never worth more than five vertices, and that is now measured rather
than guessed.

**WHAT IS ESTABLISHED ANYWAY, and it is not nothing.** The lower bound from a hitting set over the
harvested `Y` is rigorous at every instant (`mhs(Y) ≤ mhs(Y*)`, §O(1b)), and both runs had **zero
undecided asks**, so nothing is conditional on a budget. Therefore, over `A412 ∪ ρ·g⁻¹(A166)`:

> **No joint selection of 503 atoms or fewer refuses four colours** — so the joint minimum in
> frame 1 is **at least 504 vertices**, and at most 509 (c4.1's derived ceiling, since the record
> itself is a refusing selection inside this working graph). **The joint minimum lies in
> [504, 509] vertices.** In frame 2 the same argument gives **at least 501**.

So the record could not have been beaten by more than five vertices on this material, and the
question C4 exists to answer — *is it 509 or fewer* — is narrowed to a five-vertex window but
**not answered**. P-C4.1 is **unresolved**, not falsified.

**Prediction scoring, for the clauses that are decidable:**

- **P-C4.3 — SPLIT.** "phase 1 < 60 s" is **falsified** (85 s). "the bound closes within 90
  minutes" is **falsified** decisively (five hours, not closed). "≥ 1,500 correction sets" is
  **met** (1,998 and 1,877).
- **P-C4.1, P-C4.2, P-C4.4 — UNRESOLVED.** No minimum was ever recorded (`minima 0` in both), so
  the level was never reached and the split and the frame-2 comparison have nothing to score
  against. They must not be read as falsified.
- **The stop rule never came into play**: nothing at or below 508 atoms was ever found.

**The ninth instrument of this phase belongs to this run and is recorded with the other eight**
(§R2.5): the four-hour reporting point passed without a report, because I was blocking on exit
waiters.

### R2.3 — The ask budget is a conflict budget, and why that is a finding

The subplan specified `solve_limited(expect_interrupt=True)` with a `threading.Timer` calling
`interrupt()`, and told the implementer to query it first. On PySAT 1.9.dev15, **CaDiCaL implements
neither `interrupt()` nor `clear_interrupt()`** — both raise `NotImplementedError`. The timer thread
*does* run during the solve, so in production the exception is raised inside that thread, printed to
stderr and swallowed, while the ask continues: **a wall that silently does nothing**, which is the
failure this repository's standard names first.

What CaDiCaL does honour is `conf_budget` + `solve_limited`, and the control that says so is
two-sided: an easy instance returns a real verdict under a budget of 10⁹, a hard one returns
`unknown` at 1,000 conflicts. So `unknown` is neither impossible nor automatic. A bounded ask is now
a loop over conflict slices under a time wall — deterministic per slice, learned clauses kept across
slices, and free in the normal regime, where the first slice decides every ask (measured: c4.1 used
exactly 509 slices for its 509 budgeted asks).

**The wall's true granularity, which is the price of losing `interrupt()`:** the full-graph refusal
uses 95,301 conflicts in 5.74 s CPU, i.e. **16,613 conflicts per CPU second**, so one
100,000-conflict slice is **about 6 s**. That is the most a time wall can overshoot by, and it is
recorded beside the budget in every record.

Glucose, MiniSat, MapleChrono and MergeSat *do* honour `interrupt()`; CaDiCaL 1.5.3 is measured best
on this workload (§7), so the solver stays and the mechanism changed.

### R2.4 — Two ask-cost regimes, and which one the drop condition rests on

| population | frozen companion (L451 / S166) | joint stage, **quiet, min of 3, CPU** | joint stage, **in-run**, one incremental solver |
|---|---|---|---|
| colourable | 0.006 – 0.009 s | 0.170 s | **0.020 – 0.023 s** |
| refusing | 0.02 – 0.108 s | 1.758 s (single asks 5.7 – 8.7 s) | **0.20 – 0.28 s** |

**These answer different questions and neither is wrong.** A fresh solver, minimum of three, is the
right way to measure one ask reproducibly; it is the wrong way to forecast sixteen thousand of them
on a solver that keeps every clause it learns. The gap is about six-fold, and a forecast built from
the isolated figures overstates a real run by that factor — which was most of the six hours Poros's
card 11 forecast for C4a.

**And there is a THIRD regime, an order of magnitude worse than either, which phase C found by
accident and phase D must not.** `parts_stage.refuses` builds a fresh solver per call. Measured on
the M6B pair (`v375e1916` against a framed `v141e594`, 544 vertices, a FROZEN companion — the cheap
kind of stage):

| the same stage, refusing ask | cost |
|---|---|
| warmed incremental oracle, mid-run | 0.02 – 0.11 s |
| cold fresh solver (`PS.refuses`) | **186 s, 229 s** (two elements; a colourable one took 0.49 s) |

That is not a six-fold gap, it is about a thousand-fold, and it is entirely the warm-up: the same
instance, the same solver, the same machine. **The colourable direction stays cheap cold** (0.49 s),
which is why nothing noticed until a search asked the refusing direction twenty-four times.

The consequence, measured rather than inferred: `frames --refuses-with` costs **~40 minutes** on
this pair, because 12 of the 24 frames refuse (§S.2 #7) at ~200 s each — and that, not a wedge, is
what phase C3 spent its first forty minutes doing behind a log that said nothing (§R2.5). **The fix
for phase D is one incremental solver per frame search rather than one per ask**, or asking a cheap
discriminator first; the fix for the log is already committed.

*This also re-reads C4.0's own numbers.* Its 5.7 s and 8.7 s were taken on fresh solvers by design,
minimum of three — which is why they are the right figures for a per-ask comparison and the wrong
ones for a run forecast.

**CORRECTION, 2026-09-11, and it is mine.** An earlier draft of this section defended the drop
condition as *"cold against cold, the frozen-companion stages measured the same way"*. **That is
false.** C4.0's joint figures are cold; the frozen-companion baseline beside them (0.006–0.009 /
0.02–0.108) is read off the stored records' `asks` block, which is the **in-run mean over a whole
run on one incremental oracle** — warm. So the 16–88× that fires the condition behind four drop
rows is computed **across the warm/cold seam**, the very seam this section establishes is worth up
to three orders of magnitude. The missing cell — a cold refusing ask on a frozen-companion stage —
was never measured, and I asserted its absence away.

**THE MEASUREMENT LANDED, AND THE CONDITION DOES NOT FIRE.** Cold, fresh solver, minimum of three
(one rep on the two M6B rows), CPU seconds, quiet box — **all eight rows, complete**:

| stage, one cold refusing ask | **pin on** | **pin off** | the pin is worth |
|---|---|---|---|
| L451, frozen companion | **3.07 s** | 190.60 s | **62×** |
| S166, frozen companion | **3.58 s** | 224.67 s | **63×** |
| **joint `A412 ∪ ρ·g⁻¹(A166)`** | **6.66 s** | 259.00 s | **39×** |
| M6B, frozen companion | **6.60 s** | 248.82 s | **38×** |

**The pin is worth 38–63× across four independent stages** — the claim first recorded as "62× and
63× on two" is widened in base and loosened in precision. **And the spread is itself evidence for
the split §R2.4e derives from the geometry**: a portable palette component (~6× by symmetry
arithmetic, since a rainbow triangle trivialises `S₄` where a centre pin leaves 6) plus an
**arena-specific guidance component**, which is exactly the part that should vary between stages.
It does, by a factor of 1.7 across these four.

**One reading that changes nothing but corrects an assumption**: M6B is a frozen-companion stage
and costs **6.60 s** pinned, against L451's 3.07 s and beside the joint stage's 6.66 s. So "has a
frozen companion" is not what sets the cost — **size is** — and the joint stage sits alongside a
one-sided stage of similar size rather than above it.

**Like for like — cold against cold, pinned against pinned — the joint stage is 1.9–2.2× the
frozen-companion stages.** Not sixteen-fold, not eighty-eight-fold: about two. And warm against
warm was already about 3× cheap, 3–13× expensive. **So on neither honest pairing does the tenfold
threshold clear**, and the 16–88× that appeared to fire it was the warm/cold seam plus the pin,
never a property of the joint stage.

**And card 14's fork is settled against the warm-up reading: the "third regime" is the missing
pin.** §5.9's pin is worth **62× and 63× on two independent stages** — a replicated number, against
his own reported ~10× for his levers — and my 186–229 s came from `frames`, which built with
`pin=False`, while C4.0's 5.7 s had it on. Poros's falsifier (*cold-with-pin and cold-without-pin
within a factor of two*) did not fire; they differ by sixty-two. Warm-up is real but second-order
here: cold-and-pinned (3.07 s) against warm-in-run (0.02–0.11 s) is ~30–150×, and cold-and-unpinned
against warm is the ~2,000× I first attributed wholly to warm-up.

**What this does to the drop decision, stated plainly because it reverses a recorded conclusion.**
The product owner recorded *"the conditional mechanism has fired; B-8, B-11, D-6 and X-7's guard
come back for D, F and G"*. On the corrected measurement **the mechanism does not fire**. Combined
with R2.4b — where no gated row's need is governed by per-ask cost anyway — the position is:
*the dial does not fire, and it would not have governed those rows if it had.* The rows should
return or not on the per-row grounds in R2.4b's table, which is where D, F and G should read them.

**And the "third regime" above is not yet attributable to warm-up** (Poros, card 14). The two
numbers that produced it differ in the **pin** as well as the stage: `frames` builds its stages
with `pin=False` and measured 186–229 s, while C4.0 builds through `Stage.cnf` with **the pin ON**
and measured 5.7 s. §5.9's pin and radial ordering are worth a reported 10× and live exactly where
the CNF is built, so *cold* and *missing an accelerator* are indistinguishable in this log — the
same shape as the other four instruments. The run under way asks one cold refusing ask on four
stages with the pin on and off; **until it lands, the warm-up reading in this section is a
hypothesis, not a result.**

**Three quantities, one threshold, and they have come apart** (Poros's reading, adopted verbatim
because it outlives this phase):

| quantity | reads | governs |
|---|---|---|
| absolute in-run cost | 0.029 / 0.27 s | run duration, the resume path, scheduling |
| the warm refusing-to-colourable asymmetry | 0.27 / 0.029 ≈ **9×**, close to his own 1 s against 10 s | whether 8-4-2-1's premise holds — **it survives warm**, so the lever fails on card 12's structure, not on the asymmetry |
| the warm/cold ratio | 32× to 2,000× | whether parallelism helps at all — and it argues against fanning out on this family |

**The risk to name for F and G:** *if a later phase re-instates the parallel sweep because "costs
rose", it will be using the first quantity to decide a question governed by the third.* M62 §R21
measured only a 2× per-ask loss on its own family and still capped the speedup near half the core
count; at 10²–10³ a cold worker discards a state worth more than the parallelism buys.

### R2.4b — Which gated row the tenfold condition actually governs: none of them

*Poros's card 15, answered by derivation over quantities already measured — no asks. The condition
was attached to every proposed drop as one dial; each row turns out to have its own quantity, and
three of those are now measured.*

> **THE GOVERNING REASON, as ruled by the product owner on 2026-09-11. These are TWO findings and
> a later phase can misuse the second, so they are stated apart** (Poros's phrasing note, adopted):
>
> 1. **The dial was MEASURED AND FOUND NOT TO GOVERN.** Card 15's table below is what carries the
>    decision: each gated row's need traces to its own quantity, and none of them is per-ask cost
>    on the object the condition was measured on. This is what retires the dial.
> 2. **Separately, the dial did not fire.** Like for like — cold and pinned against cold and
>    pinned — the joint stage costs about **2×** the frozen-companion stages, nowhere near tenfold
>    (§R2.4). This removes the dial; it is not the reason the rows are kept.
>
> **The four cost-control rows still return for D, F and G, each on its own per-row ground below.**
> The alternative weighed was letting them lapse, which is the literal reading of the approval's
> condition and the wrong outcome: the condition was a proxy and the per-row needs are real.
> *A row that returns for a reason that turned out false is a row nobody can defend later.*
> **What must not be read here:** that the rows were wanted anyway and the measurement was
> decoration. The measurement is what removed the dial; the table is what kept the rows.

| gated row | what its need is actually governed by | current reading | verdict |
|---|---|---|---|
| **B-8** cyclic implication chain for mono-sets | per-ask cost **on the stage phase E will build** (a √3 triple), not on the joint stage | warm in-run refusing 0.27 s here; E's stage unbuilt | the closest thing to a cost row — and the measured number still does not govern it, because it was taken on a different object |
| **B-11** each lever measured against a recorded trace | **comparability with his attested timings**, not our cost | his 0.2 s for √3 triples was measured *with* the five-vertex assignment (§5.9) | not a cost row; the condition is provenance, and a timing compared with his must say whether that lever was on |
| **D-6** the level in parallel | the **warm/cold ratio** | 32× – 2,000× | not a cost row, and its own quantity argues **against** fan-out rather than for it |
| **X-7** the `2^m` level-forecast guard | the level's **size** and the enumeration's shape | the joint level at 509 holds ≥ 13k raw L-minima | not a cost row at all |
| **B-4** pendant companions | superseded **structurally** — `Aut(W ∪ C)` is trivial on type-M stages | — | never a cost question |
| **M64-6** idealness of `Y` | needs a **complete** `Y`; off the record path | — | never a cost question |
| *(B-12, 8-4-2-1)* | *no longer a drop*; killed by card 12 on singleton density, not by cost | 423 of 576 atoms are singleton correction sets | the warm asymmetry (9×) leaves his premise intact; the structure does not |

**So no gated row's need rises and falls with per-ask cost on the object the condition was measured
on.** The tenfold dial has been a proxy standing in for four different questions, and the decision
it produced — the cost-control rows return for D, F and G — is right for those rows for *their own*
reasons, not for the one the dial measured. **F and G inherit this table rather than the dial**, so
that a later "costs rose" cannot move a row it does not govern. The cold-against-cold pair is still
worth having, as the per-ask figure it is and nothing more.

**The condition attached to the seven proposed drops ("if they rise tenfold or more, the
cost-control items come back") is judged on C4.0's quiet numbers**, which are decisive (16–88×) and
were taken in the right regime: minimum of three, CPU seconds, nothing else running. The in-run
means corroborate and do not carry the verdict — they were taken with up to eight other Python jobs
on the box, and that load is recorded with them rather than reported as clean. **The conditional
mechanism has fired**: B-8, B-11, D-6 and X-7's guard come back for D, F and G, with this
measurement as their stated reason. That is the condition working, not a reversal.

**8-4-2-1 would have LOST on this phase 1, and the reason generalises** (Poros cards 11–12, and his
correction to my model). A batched group clears in one ask only when the union of its deletions
contains no correction set; being droppable *one at a time* is that statement for singletons only,
so per-atom density overestimates the clear rate. On the joint stage 423 of 576 atoms are singleton
correction sets, so a group of eight drawn anywhere contains one almost surely and must be split
8 → 4 → 2 → 1 at up to fifteen asks where eight would have done; on the record stage every atom is
critical, so every group splits to the bottom. **The sharpened, zero-ask form goes to phase D**: on
the stored `Y`, what fraction of eight-subsets *of the non-necessary atoms* has a `Y`-independent
union, under the natural order and under an order built inside a maximum independent set of `Y`, and
what does it look like at group sizes 2 and 4? That is answerable with no solver at all.

### R2.4c — The three audits, and what the M6B level says about his printed column

*Artifacts: `data/m62/m63-audit-{S166,L451,M6B403}.json`, mode `tuning`, no aggregate verdict.*

| row | S166 | L451 | M6B403 |
|---|---|---|---|
| `\|M\|` vertices | **136 = 136** | **375 = 375** | **375 = 375** |
| edges, low | **564 = 564** | **1920 = 1920** | **1916 = 1916** |
| edges, high | **567 = 567** | **1930 = 1930** | **1926 = 1926** |
| `\|A\|` | **166 = 166**, `A-equal` literally | **403 = 403**, `A-equal` | **403 = 403**, `A-equal` |
| `\|{M}\|` up to `Aut(A)`, companion free | **8 = 8** (order 6) | **282 = 282** (order 12) | **66 = 66** (order 6) |
| his own minimum is one of ours | 6 images | 12 images | 6 images |
| fewest-edge member's stabiliser | 1 — his *"1"* | 2 — his *"1 (2)"* | 2 — his *"1 (2)"* |
| level closed under the counting group | true | true | true |

**Every attested scalar of three independent rows of his Table 1 agrees**, each level certified
complete with zero undecided asks. The S-side edge row is the one the accounting convention of
R2.6 would have broken: it reads 564 only because `e_S_his` books the twelve centre-to-S edges to
the S side as he does.

**P-C2.1 is met on six of its seven clauses and honestly NOT-COMPARED on the seventh.** Table 4's
M6A ranges were never transcribed, so the S166 audit reports **0 of 14 orbit rows compared, 14
not-compared** rather than an empty differing-list that would read as agreement. That is the
silent-omission trap this instrument was designed against, caught by the design rather than by me.

**P-C2.2 is met exactly as registered:** of 35 compared orbit rows on L451, exactly `(2,0,6,4)`
and `(10,0,2,4)` differ and nothing else does.

#### The "M6A&B" column: UNDECIDED by the registered rule, and narrower than both runs

| orbit | his printed 375 column | our M6A level (282) | our M6B level (66) |
|---|---|---|---|
| `(2,0,6,4)` | **0 – 4** | 0 – 6 | **2 – 6** |
| `(10,0,2,4)` | **8 – 12** | 6 – 12 | **6 – 10** |

The decision rule registered before the run (subplan §C3) says: *an M6B member with
`(2,0,6,4) ≥ 5` ⟹ neither reading; the column is undecided and the numbers are reported.* **An M6B
member reaches 6.** So:

- **P-C3.1 MET on every clause** — 375 vertices, **66** up to `Aut(A)`, union equal to his
  `v403e2106` literally, edges 1916–1926, fewest-edge stabiliser 2.
- **P-C3.2 FALSIFIED** — its falsifier was exactly "an M6B member with `(2,0,6,4) ≥ 5`".
- **Poros's registered prediction FALSIFIED** — the printed column is not the M6B run's own ranges;
  M6B reads 2–6 and 6–10 against the printed 0–4 and 8–12.
- **The column is therefore UNDECIDED between M6A's, M6B's and the shared profiles** — and the
  reason is sharper than "undecided": **the printed column is strictly narrower than BOTH complete
  levels, in the same two cells.** It is not the union (0–6, 6–12), not the intersection (2–6,
  8–10), and not either run.

**The tension worth carrying to D, because it is not resolved here.** His *counts* reproduce
exactly — 8, 282 and **66**, on three independent rows, under the convention §R1 measured — while
his *ranges* on these two orbits are narrower than the complete levels those very counts describe.
If his `{M}` were our `{M}`, both would agree. Two readings survive: a **printing defect in the
range column**, which is the economical one given Table 3's `A` column carries two proven typos and
Tables 5 and 7 do not sum to their captions; or **his enumeration stopping early** (§5.5's threshold
clause), which his matching counts argue against. **A defect landing on the same two cells for two
different subtypes is a property of the column, not of either run** — which is what §S.2 #4
concluded from the M6A side alone, now with a second independent witness.

### R2.4d — His own minima are inside his own column, and the rungs that closed

**The check that would have settled the range question outright, and did not.** His published
375-vertex minima, against his printed 375 column, zero solver — the method §1(iii) used on
Table 3's `M` column:

| his file | vertices | orbits outside his printed column | `(2,0,6,4)` | `(10,0,2,4)` |
|---|---|---|---|---|
| `v375e1920` (M6A) | 375 | **0** | **4** (printed 0–4) | **8** (printed 8–12) |
| `v375e1916` (M6B) | 375 | **0** | **4** | **8** |

So **the column does not contradict his own files**; it is narrower than both complete levels while
still containing the members he published.

**And that datum does NOT rank the three readings below — it removes a contradiction without
discriminating** (Poros, card 18, adopted). The two disputed cells are **one fact, not two**: the
conservation law ties `(2,0,6,4) + (10,0,2,4) = 12`, which every range here satisfies (his 0–4 ↔
8–12, our M6A 0–6 ↔ 6–12, our M6B 2–6 ↔ 6–10), so a member at 4 is at 8 *by arithmetic*. His
published minima are one point on that line, and 4 is a common value in our own level. Read as
"his files are consistent with his column" it is worth having; read as support for any one of the
three readings it is worth nothing.

**Poros's card 17 proposed that this closes to one reading**, by: our levels are complete, a
complete level is unique for a stage, his `A` equals ours literally and his counts equal ours, so
his `{M}` is ours and the printed range must be a defect — *and* that argument **refutes** early
stopping rather than disfavouring it, since a truncated enumeration is a proper subset and must
count strictly fewer, which his does not. **Steps 1, 4 and 5 are accepted; step 2 is not
closable here.** "The same stage" rests on `A` matching literally, and the missing datum is his
companion: our L451 stage is `v451e2400` against `v136e564`, his is *"a frozen S-graph"* he does
not name for that row. There is nothing of his to fingerprint — his archive publishes vertex
lists, not stages — so no fingerprint comparison exists to settle it.

**Three readings therefore survive, and D inherits all three:** a printing defect in the column;
**mixed provenance** — a column computed from an earlier or partial state printed beside a count
from the final one, which the boundary coincidence fits and which his own "M6A&B" heading (one
column already serving two runs) makes unexotic; or a stage difference surviving all four attested
agreements. **What phase C establishes is narrower and stands on its own: the column describes
neither complete level, and the early-stop explanation is refuted by the counts.**

**The open rungs (M64-4).** All three S involutions close at **138 vertices** (137 atoms + the
shared centre), 2 minima each, confirming M64's `≥ 138`; and the S order-3 rung was already closed
at **142** incidentally by c1.1's resume control. The L rung is re-running: **the first attempt
reported "BELOW the stored lower bound — refutes the duality or rung-independence", and it refutes
nothing.** My script filtered the subgroups to the one whose orbit count matches the open row
(225) but passed that *filtered* index to a lookup over the **unfiltered** list of order-2
subgroups, so it built a 232-atom rung, got its correct answer of 375 vertices, and compared it
against the 225-atom rung's bound. The S side was immune only because all three of its order-2
subgroups have 86 orbits, so the two indexings coincide. **A control that fires loudly on a
mismatched pairing is as dangerous as one that cannot fire** — a sixth instrument, and the first of
this phase whose failure was noisy rather than silent.

**Re-run with the index resolved in the same list the lookup uses, and asserted against the stored
row's orbit count before the run: `H2#6`, 225 atoms = the stored row's 225, minimum 376 atoms =
377 vertices, 600 minima, 99 s. M64's `≥ 377` is CONFIRMED AS AN EQUALITY.** So every rung of both
stages is now exact:

| rung | M64 said | closed at | how |
|---|---|---|---|
| L, order 2, 225 orbits | ≥ 377 | **377** | this run |
| S, order 2, 86 orbits (all three) | ≥ 138 | **138** each, 2 minima each | this run |
| S, order 3, 55 orbits | ≥ 139 | **142** | incidentally, by c1.1's resume control |

**P-C2.6 is MET on both its clauses** ("the open L rung closes at its lower bound, 377; the open S
involution closes at 138"). M64 §R10's rung lattice is now closed everywhere it was open, and the
S-side result also confirms the class-function reading of R2.4d: three involutions in one
conjugacy class, three identical closed values.

**A-7, the `A` columns of Tables 5–7, settled on the file side.** Each of his `A` files sums
*exactly* to its own caption:

| table | his `A` file | file total | caption | his PRINTED column sums to |
|---|---|---|---|---|
| 5 | `v375e1862` | **375** | 375 | 391 (**+16**) |
| 6 | `v238e1131` | **238** | 238 | 238 (agrees) |
| 7 | `v289e1389` | **289** | 289 | 292 (**+3**) |

So the −16 and +3 live in his **printed per-row columns**, not in his data — the same shape as
Table 3's `A` column, whose file has 412 against a column summing to 402 and whose two typos §1(ii)
localised.

**c2.9 FIRES, and it is the control that matters most here.** Table 6 is the one `A` column whose
printed sum matches its caption, which is exactly why the plan chose it as the positive control: a
checker that has only ever been pointed at columns known to disagree has not been shown able to
*agree*. Transcribed row by row (23 orbits, two side-by-side halves, printed sum 238) and compared
against his own `v238e1131`: **zero differing rows, `A-column-agrees`.** So when the same checker
reports a difference elsewhere, that is a statement about the column and not about the checker.

**Tables 5 and 7 stay NOT-COMPARED row by row**: their printed per-row columns were not
transcribed, and `check_A_column` reports the file's fillings rather than inventing a target. What
is settled for them is the file side — each sums exactly to its caption — which localises the
defect to the printed column without saying which cells carry it. Phase D can have the two
transcriptions cheaply now that the checker has a passing positive control.

**A free check the transcription bought, and it is lopsided.** His §5.6 guesses that *"for a
triples a good approximation will be provided by graphs with symmetries of order 3 or 6; for pairs
with symmetries of order 2 or 4"*. Scored against his own fifteen result rows (no solver, no base
— `parts_audit.his_symmetry_guess`):

| his guess | score on his own rows | misses |
|---|---|---|
| **pairs**: order 2 or 4 | **7 / 7** | none — every mono- and non-mono-pair row he published has symmetry 2 or 4 |
| **triples**: order 3 or 6 | **2 / 5** | `√7` (sym 1), `√3` (sym 1), `1/√3` (sym 1) |

So the half of his heuristic that is exact is the half about **pairs**, and the triples half is
wrong for the majority of his own published triples — including the `√3` triple, which is phase
E's row. A miss is not an error in his paper: the guess is about **where to look**, and looking at
order 3 first costs only the search that finds order 1 anyway.

**Where this matters is G, and only G.** M64 §R10's rung lattice supersedes the guess wherever a
stage and its `Y` already exist — every rung's minimum is then free from `Y`, with no guessing —
which is everywhere in C–E. It does **not** supersede it in phase G's fresh arenas, where no stage
has been built and a guess is all there is. There the measured reading is: **trust it for pairs,
do not trust it for triples**, and prefer building `Y` early enough that the rung lattice can
replace it.

### R2.4e — Does the 62× pin reach outside this phase? Two different pins say: much less than it looks

*Poros's card 19 asks whether M62's recorded costs sit on an inflated baseline, since §5.9's pin
arrived with this milestone. The cheap half is a grep, and it changes the question.*

**There are TWO pins in this codebase and they are not the same lever:**

| builder | what it pins | clauses | used by |
|---|---|---|---|
| `parts_stage.Stage.cnf` | the §5.9 **rainbow triangle**, conditional on presence | **3** | every M63 stage |
| `typem.cnf_for`, `typem.side_cnf`, `typem.patterns` | **the centre only**, one colour | **1** | `m62_run`, `m62_descent`, `growsearch`, `m62_subtypes`, `five_dial` |
| `mkstate.py` | a triangle **and** the centre | 3 + 1 | the pre-M63 state builders |
| `symstate.py` | the centre only | 1 | — |

**So the M62-era ask paths were not unpinned — they pinned the centre.** My 62× is *triangle
against **nothing***, because `Stage(pin=False)` emits no unit clause at all. The transferable
quantity is *triangle against **centre***, which is a different and smaller thing: a rainbow
triangle fixes three colours and kills all 24 palette permutations; a centre pin fixes one and
kills 4, leaving 6. **On palette symmetry alone the transferable factor is ~6×, not 62×** — the
remaining ~10× in my measurement is whatever the extra two unit clauses buy in search guidance,
which is real but is exactly the part that need not transfer to another arena.

**So card 19's conditional should be stated at the right size**: M62's costs are not obviously on
a 60×-inflated baseline; they are on a baseline weaker by at most the residual palette factor plus
an unmeasured guidance term. **The settling run is Poros's, with one correction — it must be
triangle-against-centre on an M62-era object, not triangle-against-nothing**, or it measures the
wrong difference and inflates the answer exactly as the naive reading does. That run is phase D's.

**Untouched either way, and worth saying because it is the load-bearing M62 conclusion:** §R23's
argument that a descent cannot reach the record rests on the *spread* of a distribution — nine
1-minimal descents at 582–609, eleven standard deviations from 509 — not on any clock. No pin
changes it.

**And the lever has a ceiling, which bounds what any later phase can hope for from it** (Poros,
card 19's amendment, sharpened here). The palette group of a proper 4-colouring is `S₄`, order 24.
A rainbow `k`-clique pin fixes `k` colours and leaves `(4 − k)!`:

| pin | leaves | kills |
|---|---|---|
| the centre alone (`k = 1`) | `3! = 6` | 4 |
| **the rainbow triangle (`k = 3`)** | **`1! = 1`** | **all 24** |
| a hypothetical `K₄` (`k = 4`) | `0! = 1` | all 24 — **no more** |

**So the triangle already trivialises the palette group, and no pin of any kind — clique or not —
can break more palette symmetry than it does.** That it is also the largest clique available is a
separate fact and ours: **four plane points are never pairwise unit-distant** (ledger row 58,
`Mascot.not_forces_of_unit_drawing`), so there is no `K₄` to tempt anyone in the first place. Two
independent reasons not to go looking for a bigger pin.

**What is left, therefore, is not symmetry but placement and problem structure** — his §5.9 says
*"The choice of Q significantly affects the speed"*, and his five-vertex assignment for `√3`
triples is not a clique pin at all, which is why it can fix five vertices. **This is the same
conclusion as "the residual ~10× may not transfer", reached from the geometry instead of from the
measurement**: the palette half of the lever is exhausted and portable, the guidance half is
arena-specific. And it sharpens **B-11 for phase E**: his five-vertex trick works for the `√3`
triple and *not* for `1/√3`, so E's `√3` row inherits both its speed and its provenance caveat.

### R2.4f — If this session ends before the verdicts: exactly what is running and what to do

*Written while the runs are live, because a handoff composed after the fact is a handoff nobody
can act on. Everything phase C produced is committed; only the two joint verdicts and three
ask-cost rows are outstanding.*

| job | what it is | log | checkpoint | how to resume |
|---|---|---|---|---|
| **C4a** | the record-bearing run: `A412 ∪ ρ·g⁻¹(A166)`, `--reduce LS`, rung 1, `--max-minima 64` | `build/gate/m63/c4a.log` | `data/m62/ckpt/m63-joint-A412-A166.ckpt.json` | re-issue the same `parts_run.py reduce` command with the same `--checkpoint`; budgets may change, the problem may not |
| **C4b** | the second relative frame, `--S-frame coset:2` | `build/gate/m63/c4b.log` | `…-coset2.ckpt.json` | same |
| **cold-vs-cold** | card 14's attribution table, 5 of 8 rows done | `build/gate/m63/coldcold.log` | none (re-runnable in ~25 min) | re-run the scratch probe; the three missing rows are joint `pin=False` and both M6B rows |

**What a resume redoes at worst** (§O2, measured): the in-flight ask, one in-progress
correction-set shrink, and up to 30 s of completed level iterations. Never a restart. A checkpoint
that has been moved or edited should be resumed with `--verify-checkpoint N`, which re-asks `N`
restored correction sets and refuses rather than continuing on an unverified one.

**What remains to be done when a verdict lands**, in order:

1. **Score P-C4.1 – P-C4.4** in R2.1's table against the rows as registered in the subplan §4 —
   the minimum in vertices, the `(374, 136)` split if 509, the cost clauses, and C4b's frame.
2. **If either run returns ≤ 508 vertices: STOP.** Send the product owner §E5's template within
   the hour, *then* run the exact-geometry re-check of one minimum and a CaDiCaL refusal with an
   LRAT proof. **The geometry and the refusal come before the word "record"**, and the Lean
   certificate is phase F's, not phase C's.
3. Update **§S.3's C4 rows** and R2.1, write the headline into R2.2, and commit.
4. **Commit `plans/POROS-2026-09-11-m63-phaseC.md` by path** — the close requires it and it is the
   only file of mine still uncommitted, deliberately, because the advisor is still writing to it.
5. Poros's **cards 13, 16 and 18** are deliberately deferred behind the verdicts: the
   frame-isomorphism test, the shared-formula frame search, and the companion-sensitivity run.
   None gates the close; each is a phase D input.

**The stop rule is armed in both runs' configuration and in this record**, so it survives the
session that launched them.

### R2.5 — Six instruments, and the sixth is the one that stops the lesson being wrong

Five instruments failed in this phase by saying **"nothing to see" when what they meant was "I
could not see"**, each caught by its owner:

1. the ask wall that could not fire and reported nothing (R2.3);
2. the exception raised inside a timer thread, printed and swallowed, while the work continued;
3. **my own c1.3 control**, which asked the same question twice on one solver and read a verdict —
   the repeat came back from learned clauses at zero conflicts, so the one-conflict budget never
   bit. *A limit that cannot fire looks exactly like a limit that is generous.* Fixed by asking on
   a fresh solver, and paired with a positive half: the same ask under no budget then returns
   `unsat` on the same solver, so an exhausted budget leaves the oracle usable;
4. **the process-group file, twice**, which recorded the pid of the `setsid` wrapper rather than the
   job. `setsid` forks when the caller is a process-group leader, and **its own argv contains the
   python command line**, so a `ps` resolution taken seconds after launch matches the wrapper. Both
   times the monitor reported a healthy job dead — once after gathering the full log, the surviving
   processes, the checkpoint and the kernel log, which is the only reason it did not enter the
   record as a crash. The fix is the one `CLAUDE.md` already prescribes and I reached past: **the
   job writes its own pid and then `exec`s**, so the file cannot hold a wrapper.

5. `parts_run.frames --refuses-with` builds and asks 24 stages and **logs nothing while it does**,
   so C3 sat at 99 % CPU with an empty log for forty minutes. It took a `log` parameter it never
   called. Fixed and committed.

**The sixth failed the opposite way, and it is the one that keeps the lesson honest.** The
open-rung script filtered the subgroups to the one whose orbit count matched the open row and then
passed that *filtered* index to a lookup over the **unfiltered** list, so it ran one rung and
compared the answer against a different rung's bound — printing **"BELOW the stored lower bound —
refutes the duality or rung-independence"**, a loud claim about a theorem, from a two-line index
mismatch. Re-run correctly it confirms the bound as an equality.

**A control that fires loudly on a mismatched pairing is as dangerous as one that cannot fire.**
Without this entry the list reads as *make your checks noisy*, and that is the wrong lesson: five
of these were silent and one was loud, and all six were wrong about the same thing — **what they
were actually comparing**. The rule that covers all six is not "be loud" but *say what was
compared against what, and assert the pairing before believing the verdict* — which is why the
corrected script asserts the built rung's orbit count against the stored row **before** it runs.

**A SEVENTH, self-inflicted and cheap to state:** a `grep '[g]it commit'` used to clear one hung
process matched the shell wrapper whose *command line contained that string* — my own running
shell — and killed it mid-command. `CLAUDE.md` has a standing rule for exactly this and I reached
past it. Both joint runs were verified alive afterwards **by explicit PID rather than by pattern**,
which is the only form of that check worth making.

**AN EIGHTH, and it is the worst kind — a trust receipt that FAILED OPEN.** Diagnosed by phase D
and confirmed here by reading `Stage.pin_is_sound`, not by a run:

```python
pin_atoms = [ai for ai, m in enumerate(self.atoms)
             if ((m & -m).bit_length() - 1) in self.pin]   # the LOWEST SET BIT of the atom
```

At rung 1 an atom is one vertex, so the lowest set bit *is* that vertex and the control works — it
is what fires `pin-agrees-everywhere (12 checks)` and what catches the planted bug. **At any rung
above 1 an atom is an ORBIT**, and a pin vertex is found only if it happens to be the
lowest-numbered member of its orbit. Usually it is not, `pin_atoms` comes back empty, and the
function returns **`pin-is-fixed` — a benign-sounding verdict, from a control that checked
nothing.**

**Where that verdict was recorded in this phase, and what it should have said instead:** c1.1's
resume control (S166 at the order-3 rung), the three S order-2 rung closures, the S order-3 rung,
the L order-2 `H2#6` closure, and the `--verify-checkpoint` control's stage. In every one of those
the honest entry is *the pin control did not run here*, not *the pin control passed here*.

**What is NOT in question is the symmetry break itself.** It is the same presence-conditional
mechanism repaired earlier — `[-sel[ai], var(loc[v], j)]`, never an unconditional unit clause —
and it is genuinely exercised at rung 1 on these same stages, where `pin_is_sound` runs its 12
checks and the planted unconditional-pin bug is caught. So the rung minima (142, 138×3, 377) are
not in doubt; **the receipt for them is.** That distinction is the whole entry: *a control that
cannot run must not emit a word that reads like a pass.*

**Not fixed by phase C, deliberately** — my remaining budget was directed at the verdicts, so the
repair went onward rather than being squeezed in. **It has since landed: another agent fixed it at
`13454c3`**, testing the atom's intersection with the pin rather than its lowest bit.

**Its control is the part worth keeping**, and it is a better control than the one that was there.
The existing rung-1 plant is *behavioural* — restore the unconditional pin clause, watch
`pin-changes-answers` — and it could never have caught this, because at rung 1 the shipped rule
and the fixed rule agree exactly. The new control runs **both rules side by side at the order-3
rung, where they give 0 pin atoms against 2**: it fails on the shipped code and passes on the
fixed code, it is solver-free and deterministic, and it discriminates precisely where the old one
was blind. *That is the shape this phase kept needing — a control that separates the two things a
verdict word was conflating.*

**Nothing above is retracted by the fix.** The runs named still had no pin receipt when they ran,
and their minima still stand on the mechanism rather than on the receipt. A later reader should
take this entry as history with its repair recorded, not as a live defect to chase.

**A NINTH, and it is the most transferable sentence this phase produced.** The product owner set a
**time-based** obligation — *report at four hours if the bound has not closed* — on an agent that
was blocking on **exit** waiters. The four-hour point passed with no report, because:

> **A time-based obligation needs a timer, not an exit-waiter. A waiter can only tell you a thing
> has ENDED; it can never tell you a thing is LATE.**

The failure is shared and worth recording as shared: I armed exit waiters and then went
deliberately quiet to conserve budget, which is precisely the state in which no turn occurs and no
lateness can be noticed; the obligation was set knowing I was blocking on exits. **It is the same
family as the other eight** — an instrument that could not report the thing actually needed — and
it is the one most likely to recur, because every long run in this project is watched by something
that fires on completion. *Anything phrased "tell me if X has not happened by T" must be armed as
a timer at T, not as a watcher on X.*

### R2.6 — The accounting convention that would have manufactured a disagreement

Comparing our `e(S)` against his Table 1 reads **552 against his 564** — and both are right. The
shared rotation centre is an L-side vertex in our arena (the S-side copy is forbidden), so the 12
centre-to-S edges are booked as cross edges here, while **he counts the S-subgraph as 136 vertices
including the centre**. His decomposition `2442 = 1860 + 564 + 12 + 6` is our
`1860 + 552 + 12 (centre) + 12 (reference) + 6 (auxiliary)`. The audit now compares `e_S_his`, and
the convention is written into the function rather than into a comment somewhere else. **A false
`differs` is as damaging as a false `agrees`**, and this one was waiting inside the S-side audit.

### R2.6b — Which edge number an audit row means, now that the secondary bar has moved

`[deGreyParts2023]` footnote 2 discards 36 edges from the 509 without an exhaustive search, so
**the published edge state at 509 vertices is 2,406, not 2,442** (§S.1, corrected in place by the
product owner 2026-09-11). Two different numbers are therefore in play and every row that quotes
one must say which:

- **2,442** is `[Parts2020a]`'s own decomposition of his own object — `1860 + 564 + 12 + 6` — and it
  is what c5.5 and c4.1 reproduce. Every edge comparison phase C makes is of this kind: against his
  Table 1 **per-row** ranges (`L375` 1920–1930, `S136` 564–567), never against a record bar.
- **2,406** is the bar a *secondary* record must beat at 509 vertices. Nothing in phase C is
  compared against it, and nothing in phase C claims it.

So R2.6's accounting sentence stands as written — it is about his decomposition — and the audit's
`edge_profile` compares `e_L_his` / `e_S_his` against transcribed Table 1 rows, which are untouched
by the footnote.

### R2.7 — What phase C did NOT do, stated as such

- ~~`--verify-checkpoint` is not wired.~~ **Now wired, opt-in, with a two-sided control.** It
  guards the only direction that can make a lower bound **unsound**: a *stale* `Y` cannot (fewer
  constraints admit more candidates, and every candidate is verified by an ask before it is
  recorded), but an unverified **correction set** can, because it adds a constraint that is not
  true, so `mhs(Y)` may exceed the truth and the optimality claim fails. Ours are read off an
  actual colouring and so are verified by construction — a checkpoint that has been moved, edited
  or corrupted can restore one that never was. On load with the flag, `N` restored correction sets
  are re-asked: deleting `C` must leave the graph colourable, or the resume is **refused** and the
  failing sets are named. **Strictly opt-in** (`verify_checkpoint = 0` skips the block entirely),
  deliberately, so the default resume path is byte-for-byte what C4a and C4b would get while they
  are live. **The control fires both ways** on the S166 order-6 rung: the clean checkpoint is
  accepted (*"5 of 38 restored correction sets re-asked, all colourable on deletion"*), and one
  with a **droppable-alone atom planted as a singleton correction set** — which it is not, since
  deleting it alone keeps the property — is refused, naming the planted set.
- **The Table 2/3 shading is not extracted**, so the stable/unstable partition is **unattested**.
  The ranges do not depend on it, and every orbit row carries its status measured on *our* level
  (`stable` / `unstable-constant-count` / `unstable-varying-count`), which is a statement about our
  object either way. `parts_audit.table_shading` refuses through §E3's path rather than guessing.
- **Tables 3–7 are transcribed only as far as the A-column check needs**; Table 4's `deg` column is
  ambiguous in the layout dump and was not hand-typed, because a mis-parsed column is exactly the
  error the audit exists to catch.

---

## §R3 — Phase D: what ran, what it produced, and what it did not

*Written across two agents (the phase D implementer and its successor), 2026-09-11. Current state
only. The phase's own plan is `plans/M63-phaseD-the-loop.md`, whose §R3.x holds the first agent's
detail; this section is the milestone-level record. **Items still running carry `[RUNNING]` and what
is known so far, never a projection.***

### R3.a — The edge record attempt, and the chain a number must pass before it is one

**The object.** A greedy 1-minimal edge pass over the assembled 509-vertex record dropped **163 of
2,442 edges**, leaving **2,279 edges on 509 vertices** — against `[deGreyParts2023]` footnote 2's
published **2,406**, itself reached by a non-exhaustive discard of 36. One ask hit its budget and
its edge was **kept**, which is the conservative direction: the object can only be larger than
necessary, never non-refusing. The pass is **order-dependent by nature**, so this is an upper bound
and **never "the minimum"**.

**The exact edge minimum is now bracketed: `1831 ≤ e_min ≤ 2279`.** The floor is the completed
individually-critical census — 1,831 of 2,442 edges are individually critical, and a singleton
correction set *is* a critical edge, so the count is rigorous. The gap between the two is the
hitting set nobody has run.

**The verification chain, and why "a fresh solver" was not enough.** The pass re-asks its own object
with a fresh solver — but with the symmetry break still on, so *fresh solver* and *unpinned* were
two different claims. The pin is the one device in this chain with a prior failure in its own
history (an unconditional version produced a 373-vertex L-subgraph, one below the world record,
before a control caught it). So `tools/parts_edge_verify.py` re-derives the claim from the object
alone, sharing no code with the search:

| leg | what it removes |
|---|---|
| an **unpinned** CNF — no selectors, no symmetry break, nothing conditional | our own argument for the pin's soundness. **Measured: 109 s on the calibration object** |
| a **separate process and a different CaDiCaL** (the toolchain's 2.1.2 binary reading a file off disk) | the in-process solver's state, and its version |
| an **LRAT proof replayed by a checker written here** | CaDiCaL's own word |
| **exact geometry re-derived from the coordinates**, the cross edges from `CrossLaw`'s *stated* derivation rather than from the edge builder | a circular check of the builder against itself |
| the **§O6 degree floor** recomputed from the kept edge list | an edge dropped against a stale incumbent |

**Calibrated on a known positive first.** The untouched 509/2,442 object returns
`verified-refusing-edge-subgraph`: geometry 1,860 L-L + 30 L-S + 552 S-S exactly, minimum degree 4,
unsat in 109 s, a 653 MB proof replayed in 71 s over **1,472,347 RUP steps** with zero unsupported
steps, and both colourability controls firing.

**And the checker has been broken on purpose.** Five planted faults — a deleted hint, a flipped
literal, the empty clause removed, and **the proof checked against a different instance** — all five
caught. They are stored **in the artifact**, not merely in a log, because they are part of the claim.

**The 2,279-edge object passes all six legs** (`data/m62/m63-edge-verify-509.json`): geometry exact
on all 2,279 edges (1,732 L-L + 30 L-S + 517 S-S), minimum degree 4 with the degree sum 4,558
reconciling, **UNSAT unpinned in 1,250 s**, a **3.68 GB** LRAT proof replayed in 423 s over
**7,699,212 RUP steps** with zero unsupported steps, all five planted faults caught, and both
colourability controls firing. The unpinned leg costs **1,250 s here against 109 s on the full
2,442-edge object** — the right direction, since an edge-reduced graph is a tighter instance.

**Refuted twice, independently.** A second unpinned run of the same DIMACS in its own process with
**no proof logging at all** returned UNSAT in **20 m 33 s**, which also answers the question it was
started to answer: writing 3.7 GB of proof is **not** the bottleneck — the instance is simply hard.

**Until the Lean kernel certificate lands (phase F) the honest words are "a certified refusing
object below the published edge count, not yet a record"** (§S.1 #4).

### R3.b — Acceptance clause 2(b): the rule, frozen, and its held-out attempt

**The state is right.** Our 375-level accumulator is **403 vertices and equals his `v403e2112`
literally** — zero differing vertices either way, re-derived from our own record rather than read
from his file. Its complete level has **336 necessary atoms**, against `Y`'s harvested degree-1
layer of **312**: two different objects, and the distinction is what the look-ahead rests on.

**The rule is frozen in commit `6158162`**, before any scored run, and the refusal was exercised
both ways — the frozen configuration passes, a configuration with one parameter changed is refused
by name. The freeze states **in advance** what happens if the held-out map is signal-free: the rule
is then scored by one bit on one held-out row and no map stands behind it.

**The frozen rule does not reach 374, through five iterations and its own set-valued rung.**
Iterations 1–3 each ranked 29 single-orbit candidates and evaluated the top three — all refused at
the target, at 107 s, 84 s and 62 s for the first three and cheap resumes after. At the third stall
the escalation fired exactly as frozen and `many_then_trim` proposed **48 vertices across six
orbits**; that too returned `no`, in 139 s, with the bound closing at 374 and 375. **Clause 2(b) is
NOT MET by the frozen rule.**

**But the apparatus is sound, and that is what the diagnostic settles.** The six-orbit set contains
the missing halves of `(0,0,2,2)` and `(0,0,2,6)` but **not** `(0,0,0,4)` and `(0,0,6,6)`, so it is
not a superset of his recorded move and its negative could not distinguish a *ranking* failure from
an *apparatus* failure. Run as one candidate through the same `sweep_candidate` the rule used, **his
own four orbits (30 vertices) reach `w* = 373` — `|M| = 374` vertices — with zero undecided asks**
(`tools/parts_diag.py:hismove`, `LB 373 = w* 373`). So:

- **our state, companion and stage reproduce his recorded step exactly**, and every negative measured
  on this half is a fact about expansion rather than about our pipeline;
- **the frozen rule's failure is a RANKING failure**, and it is localised: the rule had the material
  — four of his six chosen orbits sit in the menu it ranked, and two of them are in the set it
  proposed — and did not assemble his four;
- **a positive provably exists at this state**, so if the held-out single-orbit map is also
  signal-free, the reading is the strong one Poros named: *singles are inert where a four-set works*.

**The look-ahead proxy is degenerate too, and that is a second finding rather than a repeat of the
first.** It reads **0 freed of 336 necessary atoms** on every single orbit tried — including on an
orbit his own recorded move used. The map had no *outcome* variance; this is no *predictor*
variance, so the rule falls back to his admission-degree order wherever the proxy cannot separate.

**What the zero does and does not say** (Poros's objection, adopted and worth carrying): an atom is
necessary because deleting it makes the graph colourable, so to *free* it the graph without it must
refuse — and **in that graph every edge from the new material to that atom has vanished with it**.
The proxy therefore watches only the *singleton* correction sets, which is the harder of two routes.
So: **no single orbit frees a necessary atom; whether any widens a non-singleton correction set is
unmeasured, and that is the cheaper route.** The first half is measured, the second is not, and
leaving the second implicit is how the claim gets over-read later.

### R3.b2 — The failure is omission, the binding constraint is the cap, and that inverts a judgement

*Poros's card 30, its derivation forced and its hunch then falsified by its own falsifier.*

**Forced, and it settles the category.** Adding vertices can never raise `w*`. His 30 vertices give
`w* = 373`. **Therefore every superset of those 30 reaches 374**, whatever else it carries. The
frozen rule's 48-vertex proposal is not a superset — it omits `(0,0,0,4)` and `(0,0,6,6)` — so what
it added was never *harmful*, only *insufficient*. The failure is **omission**, and it follows that
**over-proposing can cost time but never correctness**.

**Which inverts a judgement this milestone had recorded.** His stall escape — *"increasing the
number of new vertices introduced in the expansion stage"* — was written off as *"a knob and not a
criterion"*. That is right as a complaint about it being a **measure** and wrong as a dismissal:
under monotonicity **the knob is the mechanism that works and the ranking is the luxury**. His own
§5.11 ceiling of "several tens of redundant vertices" is the budget that made the knob unusable for
him, and it is a budget we are already twice past.

**Three candidate binding constraints, and the measurement kills the structural one.** The ordering,
the cap of six orbits, or the **trim** — only the trim could have been structural, since
`many_then_trim` strips new vertices of low final degree and a strategy that strips vertices his
move needs could never reproduce it *at any cap*. Measured (`tools/parts_diag.py:trimtest`):

| | |
|---|---|
| his 30 vertices surviving a single trim pass | **30** |
| surviving to a fixed point | **30**, in 0 passes |
| their degrees into the enlarged graph | **4 (×15), 6 (×9), 8 (×6)** — against a threshold of 3 |

**`trim-preserves-his-move`.** So the trim is not the constraint and is not even close; the advisor's
hunch died on the falsifier it had itself registered. **The binding constraint is the cap of six
interacting with the ordering** — his four orbits are all in the ranked menu, two of them made the
top six and two did not. And since over-proposing is free on correctness, the rule the successor
should write is *propose as much as you can afford to reduce, and rank only to choose under budget*
— not a better ranking.

**One run worth stating as a run rather than as three observations:** **no published device of his
selects his own recorded move** — not §5.6's priority sentence, not the reserve's degree order
(Poros M3), and not that degree order at the set-valued rung (here). That is a finding about the
paper, and it is the strongest available justification for scoring a reproduction by outcome.

### R3.c — His own move as a calibration bed, and two statistics that died before costing anything

His recorded four-orbit move from `A403` is the one labelled positive anyone holds for a set-valued
expansion, so it is the bed on which a set-valued ranking is calibrated *before* the expensive rung.
Two rival solver-free statistics over the 215 small correction sets, with a new vertex *serving* an
atom when it meets four of that atom's neighbours inside the accumulator:

| statistic | his move | 2,000 random four-subsets | percentile |
|---|---|---|---|
| union coverage | 12 | mean 4.5, max 60 | **0.80** |
| overlap | 0 | mean 0.0, max 12 | **0.00** |

**Both die.** Overlap is degenerate — almost everything scores zero, so his zero carries no
information. Union is directionally right and far too weak: **one random four-subset in five beats
his own recorded move**, and a statistic like that cannot find a needle among 635,376. Under the
*faithful* quantifier — widening a correction set needs compensation for **all** of it, not one
member — the statistic is **identically zero**, random maximum included, so union is dead on its
merits rather than on an operationalisation error. **So the set-valued rung is his craft rather than
ours**, said here rather than discovered afterwards.

Neither statistic touched the frozen rule: both are computed from his labelled move, and letting
either steer the running rule would be exactly the contamination the freeze exists to prevent.

### R3.e — Every prediction registered for phase D, scored by name

*The register is `plans/M63-phaseD-the-loop.md` §4. A prediction that cannot be scored says so and
says what it waits on; none is quietly dropped.*

| # | what was predicted | verdict |
|---|---|---|
| P-D0a | L-side refusing asks stay ≤ 0.15 s | **MET** — 0.138 / 0.144 s |
| P-D0b | refusing asks at the 374 level cost ≥ 3× those at 375 | **FALSIFIED** — ratio 0.96; the cold-ask form survives |
| P-D1 | his §5.10 indicators do not rank all four of his move's orbits in the top half | **NOT RUN** — D2 is not implemented |
| P-D2 | the frozen rule reaches `\|M\| ≤ 374` within 12 iterations | **NOT MET at the budget it was given.** The frozen rule ran its full schedule — six iterations, vertex budgets 12 then 40, ending at `many_then_trim` — and did not reach `\|M\| ≤ 374`. The registered 12-iteration form is **unscored**: no run of twelve iterations exists. §R3.b2's monotonicity argument says more iterations of the same ranking would not have helped, but that is a reading and not the prediction's test. |
| P-D3 | the rule's precision@3 beats uniform random on the `A403` map | **UNSCOREABLE so far** — the held-out map may only run after the rule's attempt, and on the in-sample map every ranking ties at zero |
| P-D3b | the menu's helpful density is neither 0 nor ≥ 40 of 49 | **FALSIFIED** — degenerate at zero over the complete 89-candidate menu |
| P-D4 | `{M}` grows at fixed `\|M\|` and fixed rung in a rule-driven iteration | **PHENOMENON OBSERVED, CLAUSE NOT MET** — once in 63, from the random block rather than from a rule |
| P-D5 | D1.b returns 374, and `\|{M}\|` equals 1,092 under none of the three conventions | **`[RUNNING]`** — 374 confirmed with zero undecided; the raw count is past 12,000 against his 1,092, so the *equality* is already out under the raw convention, and the quotient conventions need the level closed |
| P-D6 | the `Σ(lo + hi) = 2·\|M\|` identity holds on our 375 and both 374 levels | **NOT RUN** |
| P-D7 | the **exact** edge minimum of the 509 is below 2,406 | **CONFIRMED** — a certified refusing edge-subgraph at **2,279** puts `e_min ≤ 2279 < 2406`, so his non-exhaustive 36-edge discard was not optimal |
| P-D7b | the exact edge minimum lies strictly above §O6's floor of 1,016–1,018 | **CONFIRMED** — the completed critical-edge census gives `e_min ≥ 1831`, far above the degree floor, so the floor is honest and nowhere near tight |
| P-D8 | the two routes to D1.c agree exactly | **NOT SCORED** |
| P-D9 | the exchange-class vector changes at every one of D1's three replayed states | **UNSCORED** — computed at our 375 state only (two classes); each replayed state needs its own stage at its own rung |
| P-D10 | the targeted decision makes a failed candidate cost < 1/3 of a full reduction | **FALSIFIED as registered** (91%), and replaced by a derivation: the saving is the level enumeration |
| P-D11 | the small-half menu returns 136 on every candidate | **not this phase's** — the scoped probe's |
| P-D12 | the large half's helpful density exceeds the small half's | **NOT DECIDED** — both read zero on the primary |
| P-D13 | the literal reading grows the large menu by roughly the small half's factor | **NEGATIVE** — ×1.16, below the falsifier's 1.3 floor |
| P-D14 | at least one candidate outside his `r = 2` disk qualifies | **NEGATIVE**, scored before the phase opened and re-derived under all three readings |
| P-D15 | the two excluded `√5` orbits are inert | **CONFIRMED** — and all 26 shoulder candidates with them |
| P-D16 | our `H2#4` low edge endpoint is 1,860 against his published 1,868 | **CONFIRMED**, registered in a commit before the run reached that rung |
| P-D17 | comparing seven of our runs against one of his numbers invites an accidental match | **CONFIRMED BY INSTANCE** — the `H2#0` row returned his 78 at the wrong rung |

### R3.d — The pin receipt was vacuous above rung 1, and is not any more

`Stage.pin_is_sound` identified pin atoms by each atom's lowest set bit. At rung 1 an atom is one
vertex; above it an atom is an orbit, so the control found no pin atoms and returned a benign
verdict **while checking nothing** — both of 2026-09-11's order-3 runs printed exactly that. Fixed,
and the control that fails on the shipped code is planted beside it: at the order-3 rung, 150 atoms,
**0 pin atoms by the shipped rule and 2 by the fixed one**. No number is retracted — the break
itself is sound — but a receipt that fails open is worse than none.

