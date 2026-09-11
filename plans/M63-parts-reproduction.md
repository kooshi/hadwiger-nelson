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
   - **(a) Replay, as a control only:** reduce his `A412` at rung 1 and at the rung-2 subgroup and compare
     with his 1,092 and 78 under the named count convention (S.2). States 3–4 turned out to be one
     reduction of `A412` at two rungs, which is exactly why this is a control and not the proof.
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
   Secondary: **509 vertices with fewer than 2,442 edges**, his own tie-break (`[Parts2020a]` §1, *"it is
   customary to choose among these the graph with the fewest edges"*). **Either is called a record only
   once certified in the Lean kernel** (`UDCert` plus the LRAT chain, exact geometry).

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

| id | promise (address) | status | evidence, or the argument | goes to |
|---|---|---|---|---|
| G-1 | `\|M\|` at 136 / 375 / 374 / 376 (§3 rank 1) | partly | 136 §R1; 375 M64 run, S.2 #1 | 374, 376 → D |
| G-2 | `{M}` ranges and the stable/unstable partition (§3 rank 2) | partly | L375 ranges differ in two orbits, attributed to his column (S.2 #4). **The partition is not in his text**: "stable" means *the same non-empty vertex set in every minimum* (§6 of his paper) and is marked only by gray shading, and a single-valued range does not imply it — our `(2,0,2,4)` is 10 in every minimum with a varying vertex set. §3(c)'s "31 stable orbits" read the ranges and is therefore unproven | C2 (shading, partition), C3 (column) |
| G-3 | edge counts decomposed (§3 rank 3) | partly | 509 = 1860+564+12+6 §1(i); S136 564–567 §R1; L375 1920–1930 S.2 #4 | C2 commits L375; 374/376 → D |
| G-4 | `{M}` grows at fixed `M` (§3 rank 4) | not done | now two clauses: the replay comparison 78 → 1,092 (S.1 2a) and the tightened rule-driven clause (S.1 2c) | D |
| G-5 | `\|{M}\|`, `\|A\|` reported (§3 rank 5) | partly | S 8 / 166 §R1; L375 282 / 403 S.2 #1–2; **gateable now**, the convention measured on both sides | C2; 374/376 → D |
| G-6 | held-out set (§3): S M6A, 8/3 mono-pair, √3 triple, L M6B/M6C | partly | S M6A reduction was spent as the calibration (§R1) | E (required, S.1 #3) |
| A-1 | 43 files parse to their filenames (§4 A) | done | 40/43 exact plus three findings, §1; `parts-ref11-verified.json` | — |
| A-2 | every lattice graph inside `Base(2.6)` | done | §1(vi) | — |
| A-3 | the 509 splits `1860+564+12+6` | done | §1(i) | — |
| A-4 | `v374e1860` vs Table 3's `M` column | done | §1(iii), four in-range differences | — |
| A-5 | `v136e564` vs Table 4 M6A | done | §1(iv) | — |
| A-6 | `v412e2106` vs Table 3's `A` column | done | P1, §1(ii) | — |
| A-7 | Table 5 (−16) and Table 7 (+3) `A` columns vs `v375e1862`, `v289e1389` | not done | §1(ii) "untested" | C2 |
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
| B-10 | controls: `v374e1860 ∪ ρS136` refuses; single deletions colourable | partly | refusal §R1; both-side criticality unchecked | C4's positive control |
| B-11 | each lever measured against a recorded trace | drop? | priced against his 10 s asks; ours are 0.006–0.11 s; revisit in F/G if asks grow 100× | — |
| C-1 | degree 2 by `hyperedges_run.py` on M62's arena (§4 C) | retired | `reduce_stage` harvests every degree lazily (sizes 1–10 stored, M64 §R3); M62's arena is off the path (M62 §R23) | — |
| C-2 | degree ≥ 3 harvested | done | same | — |
| C-3 | every hyperedge re-verified by an independent rebuild; no hyperedge contains another | not done | correction sets are verified by construction only | C2 |
| C-4 | hyperedge counts carry their enumeration | done | `Count(…, "harvested")` | — |
| C-5 | the cheap statistics: non-isolated count, component profile, `α`, the `2^m` induced-matching bound, `α + \|free\|` test | drop? | they size his explicit maximal-independent-set enumeration, which we do not run; our levels close in ~10 min and our cost depends on the number of minima, which `2^m` does not bound. The alternative is ~1 h on the two stored `Y` for the record | — |
| D-1 | enumerate the whole optimal level (§4 D) | done | `reduce_stage`, `exhaustive-level` | — |
| D-2 | dedup by the input group before verifying | retired for type M | `Aut(W ∪ C)` is trivial (S.2 #1); the 12-fold multiplicity is `Aut(A)` with the companion moving, not a symmetry of the stage, so images must still be verified. D may measure "propose images as candidates" on the `A412` level | D (measurement only) |
| D-3 | `A = ⋃{M}` | done | §R1, S.2 #2 | — |
| D-4 | `A`'s growth curve and a stall stop | not done | — | D |
| D-5 | S level to exhaustion | done | §R1 | — |
| D-6 | the level in parallel | drop? | levels close in minutes on one core; revisit in F/G | — |
| E-1 | expansion: partial orbits first, then the reserve `R` (§4 E) | not done | Poros M3: his stated priorities are not decisive on his own move | D |
| E-2 | L and S alternating against a frozen companion | not done | — | D (L loop); F (joint) |
| E-3 | the rung set by pendants | retired | B-4 | — |
| E-4 | stall escape by more new vertices | not done | — | D |
| E-5 | the four-state path | partly | state 2 met (S.2 #1–2); states 1, 3, 4 as replay controls | D |
| E-6 | state 1 from its input (Heule-529's `L393`) | retired | not held; state 1's *output* is checked by reducing `A451` at the order-3 rung (D). `G529` is public at `github.com/marijnheule/CNP-SAT` (`[Heule2019]`) if ever wanted | — |
| P1 | Table 3's `A` sums to 402 | met | §1(ii) | — |
| P2 | `v166e774 → 136`, 8, 564–567 | met | §R1 | — |
| P3 | `v451e2400 → 375`, varying only where Table 2 marks unstable | partly | 375 met; two range differences (S.2 #4); partition needs the shading | C2, C3 |
| P4 | degree-2 count on the 757 arena in the tens | retired | the arena is off the path | — |
| P5 | MIS enumeration infeasible on 757, affordable on `A412` | retired | explicit MIS enumeration is not implemented | — |
| P6 | §5.10 indicators subsumed by `exact.py` | retired | `exact.py` is off the path (§6) | — |
| P7 | seeding `exact.py` with the degree-2 census | retired | same | — |
| P8 | one iteration `A412 → 374` ≈ 3.5 h ±2× | not done | it assumed 2–4 s asks; measured 0.006/0.02 s (S.2 #11). Revised forecast registered in D: 20–90 min single core for ~13k raw minima | D |
| O-1 | the completeness invariant (§O 1) | done | `reduce_stage` | — |
| O-2 | `exact-at-rung`; the rung travels with the number | done | `Bound.render` | — |
| O-3 | per-iteration `(\|M\|, \|{M}\|, \|A\|)`, `stalled` as a verdict, stall feeds expansion | not done | `parts_report.iteration_line` exists, unused | D |
| O-4 | kernel certificate declined for M63 | standing | for the reproduced 509 (S.1 #1); reversed for any beat (S.1 #4) | F |
| O-5 | vacuity verdicts `base-fails` / `no-reduction` / `companion-suffices` | partly | `base-fails` done; `no-reduction` labels the wrong branch; `companion-suffices` absent | C1 |
| X-1 | no verdict word for optimality (§E) | done | `Bound` | — |
| X-2 | a count carries its method | done | `Count` | — |
| X-3 | `\|{M}\|` names its group | partly | the type exists; every record writes "as-found frames" | C1 |
| X-4 | comparisons carry their mode | partly | `Comparison` exists and is self-tested; nothing emits rows | C2 |
| X-5 | the freeze is a commit (`require_frozen`) | not done — **broken** | crashes on first use (S.2 #12), never exercised | C1 fixes; D commits the freeze |
| X-6 | the per-iteration line | not done | — | D |
| X-7 | a level forecast before entry, and refusal of an unboundable level | drop? as specified | its premise is his candidate list, which implicit hitting set does not build. Replacement in D: a pre-level forecast from the measured per-minimum cost and a *stated* level-size assumption, with `max_minima` and the wall as the refusals (both implemented, reported as truncation) | D (replacement) |
| X-8 | artifact schema: `fp`, `canonical_fp`, `fp_base`, per-member profile, stamps | partly | stage/base fingerprints and provenance present; per-member profiles, canonical fingerprints, config hash absent | C1 |
| M64-1 | phase E / P9 (18 connection edges) | retired | vacuous (S.2 #5); the tail question is C3 | — |
| M64-2 | phase F: expansion as an integer program over profiles | not done | one candidate rule among others, scored, never gated | D |
| M64-3 | conjugacy of `Aut(A)`'s involutions (P7's second half) | not done | minutes, no solver | C2 |
| M64-4 | rungs not searched to their minima | partly | §R10 made 15/16 L and 4/6 S rungs exact from `Y`; the S order-3 rung closed at 142 in planning (S.2 #14); open: one L rung (≥ 377) and one S involution (≥ 138) | C2 |
| M64-5 | separate obligation/experience passes | recorded | M64 closed; M63 phase C runs all three | — |
| M64-6 | P5, idealness of `Y` | drop? | needs a complete `Y`; off the record path | — |
| M64-7 | P10, the free completeness control | not done | first meaningful on a level set produced after its classes | C2, C3 |
| M64-8 | `m63-profiles-{S,L}.json` without a producer | retired | superseded by `m64-faces.json` (producer `parts_faces.analyse`); kept untouched | — |
| M64-9 | `m64-rung-lattice.json`, `m64-orbit-closure.json` produced by scratch scripts | not done | — | C1 |
| M64-10 | both reduction records without a committed driver | not done | — | C1 |
| FS35-1 | the look-ahead's two quantities along his recorded path | partly | exchange classes from his four published ranges (M64 §0 ix); closure bounds need a level set at each state | D |
| H-1 | `parts_verify.py` dirties the tree on every run | not done | S.2 #12 | C1 |
| H-2 | checkpoint without resume | not done | S.2 #12 | C1 |
| H-3 | no ask wall | not done | S.2 #12 | C1 |
| H-4 | rotation lists truncated and sieved on the wrong lattice | not done | S.2 #13 | G |
| H-5 | `Stage` hard-wires `ρ₁₅` | not done | `parts_stage.py:57` | C5 (the parameter); G (the laws) |

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
- [ ] C4: the joint stage's positive control (the 509 returns exactly itself); the joint run on
  `A412 ∪ ρ·g⁻¹(A166)` to a closed optimum, predictions committed first, checkpointed; **if ≤ 508
  vertices, stop and report to the product owner the same hour.**
- [ ] C5: `CrossLaw` controls fire; the L451 stage fingerprint is unchanged under the explicit law.
- [ ] The audit rows assigned to C updated in place here; §R2 written; Poros's record committed.

*Cost:* 2–3 engineer-days; compute about 1–2.5 h, single core per run, never more than 8 cores; the joint
run is announced before launch if its forecast exceeds 15 minutes.

**Phase D — the loop, with a rule that finds its own moves.** Purpose: S.1 #1 and #2.
Acceptance:
- [ ] Replay controls, tuning mode, the named convention: 376 at the order-3 rung on `A451` (his 96,
  `A = v451e2400`, 1890–1947 edges); 374 at rung 1 on `A412` (1,092; `A = v412e2106`; 1860–1884; P8
  scored); 374 at the rung-2 subgroup (78; `A406 = v406e2082` up to the group; 1868–1884), computed both as
  the invariant part of the rung-1 level and by a direct rung-2 reduction, which must agree.
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
- [ ] Reduction generalization on his published accumulators: L M6B 374 at rung 2 (78, `v406e2076`); L
  M6C 374 (76, `v400e2034`); S M6B (141, 4, `v172e804`) and M6C (150, 28, `v167e772`); the 8/3 mono-pair
  (367, 27, `v375e1862`); the √3 triple (221, 120, `v238e1131`).
- [ ] **Loop generalization, starting below his accumulator:** first, the S side from a rung-2-symmetric
  138-vertex minimum (M64 §R10), whose containment of any 136-minimum is forbidden by the closure gap, so
  the frozen loop must expand to reach 136 — report `A` against `v166e774` and `|{M}|` against 8. Second,
  the 8/3 mono-pair from a rung-symmetric start above 367. The product owner's shape (start from
  `v136e564` alone) is kept as a third run; it is weaker because `|M|` is already 136 there, so it tests only
  growth of `{M}`.
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
  loop on the joint level set; (b) larger joint accumulators — his L files of all three subtypes against
  `A166 ∪ A172 ∪ A167`, frames found; (c) S reduced against one L minimum per profile class of the 1,092,
  and L against the 8 S classes; (d) other connection orbits at `ρ₁₅` — M62 §R20's `(0,0,2,6) + (24,0,0,0)`
  subtype at 18 edges, and `(20,0,0,4)`, `(16,0,6,2)` (FS-30's cheap lead); (e) the loop continued past
  his stopping point from a larger reserve; (f) symmetric seeds from the rung lattice.

*Cost:* open-ended; an experiment is 1 h – 1 day of compute; a certificate about a day.

**Phase G — other bases and the sieve's rotations.** Purpose: Kooshi's second direction (S.1). **Recommended
as its own milestone** at M63's close (four-part decision in S.5), carried here so the roadmap is whole.
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
