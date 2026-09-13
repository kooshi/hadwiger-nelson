# data/m62 — M62 (the evolutionary type-M search), M63 (Parts reproduction), M64 (orbit-filling polytope)

236 entries under one directory (M63's data was never given its own `data/m63x` home the way other milestones
get one — only phase H4's later output landed in `data/m63/`, see that directory's README). Three plans:
`plans/M62-evolutionary-type-m.md` (beat 509, the smallest known 5-chromatic unit-distance graph, by a genome
search over Theorem-B-admissible rotations); `plans/M63-parts-reproduction.md` plus its per-phase files
`plans/M63-phase{C,D,E,F,G,H,H2,H3,H4}-*.md` (reproduce and then try to improve on [Parts2020a]'s 509- and
510-vertex constructions exactly, vertex by vertex); `plans/M64-orbit-filling-polytope.md` (the rung-lattice
theory that explains why M62/M63's symmetry-restricted searches bottomed out where they did). **Almost
everything below is tools-side and solver-only or explicitly marked "not a find" in its own `claim_scope` —
none of it is a kernel claim.** The one exception is the Parts reference data (`parts-ref11/`), which is
third-party material verified here by exact arithmetic (still not a Lean/kernel claim).

Regenerate with `tools/typem.py`, `tools/typem_exact.py` (M62); `tools/parts_run.py`, `tools/parts_reduce.py`,
`tools/parts_audit.py`, `tools/parts_diag.py`, `tools/parts_rule.py`, `tools/parts_edges.py`,
`tools/parts_edge_verify.py`, `tools/parts_faces.py` (M63); the M64 producers named per-row below (some point
at uncommitted `scratchpad/` scripts — flagged where they do).

## 1. M62 type-M search — top-level records

| file | kind | population / headline | trust |
|---|---|---|---|
| `rotations-r2.05.json`, `rotations-exact-moser-r2.05.json` | `typem-rotation-sieve` | Rotation classes of the Moser-spindle-family base at radius² = 2.05, first in floats then in exact ℚ(√3,√5,√11,√33) arithmetic; "REJECTED-IN-K" = Theorem B already 4-colours anything that rotation would build | tools-only, exact arithmetic where marked; a class listed "admits cross edges" is not a working construction |
| `rotations-moser-r2.05.json` | `typem-rotation-sieve` | The exact-radicand version's full census over the 87 distinct squared radii of this base (ordered pairs), with per-class squareness decided in the tower, no float in any verdict | tools-only, exact |
| `radicands-exact-moser-r2.05.json` | `typem-exact-radicand-sieve` | Every radicand class at this base, exact sign decisions via `ksign`; nothing truncated | tools-only, exact |
| `rotations-exact-parts-r2.0.json`, `rotations-exact-parts-r2.44.json` | `typem-exact-angle-census` | The same exact rotation census run against Parts's own base at radius 2.0 and at 2.44 (the radius containing Heule-510 — see `round1/verify244.log` below) | tools-only, exact |
| `subtype-census.json` | `typem-subtype-census` | Exhaustive over all 127 non-empty subsets of the 7 cross-edge orbits on the full symmetric-core base: which subsets keep it 5-chromatic (SAT), minimality over orbit subsets only | solver-only (each subset one SAT call); "candidate subtype", not vertex-minimal |
| `parts-lattice.json` | `parts-lattice-base` | The radius-2.0 base alone: 1,603 points / 92 orbits, 11,286 unit edges, 126 cross edges; full arena refuses 4 colours | solver-only (one UNSAT call); explicitly "NOT a find", only shows the base is non-vacuous |
| `pl-ckpt.json` | `parts-lattice-descent` bitmask checkpoint | In-progress descent state (round 0, 3,031 present vertices) | in-progress checkpoint; `claim_scope`: "no verdict here is a find" |
| `pl-subtypes.json` | `parts-lattice-subtype-census` | A cross-kind subtype census on the lattice base analogous to `subtype-census.json` | solver-only; UNSAT rows are "non-vacuous subtypes, not finds" |
| `p24-ckpt.json`, `seq-ckpt.json` | bitmask checkpoints (L/S present-sets, round, seconds) | Intermediate states of an L/S orbit-filling descent (rounds 0 and 1, 6,379 and 8,239 present vertices) | in-progress checkpoints, no verdict |
| `shrink-ckpt.json` | bitmask checkpoint | A shrink search's present-set at n = 12,552 | in-progress checkpoint, no verdict |
| `smus_orbit757.json` | plain record | A 40-orbit / weight-624 group selection (a smallest-minimal-unsatisfiable-subset-style candidate on the 757-vertex orbit closure — see §2) | candidate only, no solver trace attached in this file |
| `exact757.json` | `exact-reduction-in-progress` | A hitting-set-style exact reduction on the 757-vertex object, in progress: lower bound 183, upper bound 756 (product of a rising LB and a witnessed UB), 258 correction sets after 114 iterations | in-progress; not optimal by its own `optimal: false` flag |
| `orbit-grow.json` | `typem-orbit-grow` | Smallest radius-ordered **orbit** prefix of the symmetric core refusing 4 colours (614 orbits / 6,925 vertices, 10 asks) | solver-only; `claim_scope`: "REFUSED-4 (candidate, NOT certified)… not minimal, not a find" |
| `orbit-shrink-ckpt.json` | bitmask checkpoint | An orbit-level shrink descending from `orbit-grow.json`'s object (462 orbits / 5,191 vertices after 7 asks) | in-progress checkpoint |
| `grow-result.json` | `typem-grow` | The vertex-level (non-orbit) analogue of `orbit-grow.json` | solver-only, same "candidate, NOT certified" scope |

## 2. Shrink/destroy-repair searches for a sub-509 witness (subdirectories)

All of these are attempts, after M63's phase-B arena-and-orbit-closure work found that **Heule-510's own
orbit closure inside the r = 2.44 arena is 757 vertices** (`round1/verify244.log`), to shrink that 757-vertex
object below the published 509/510 record by SAT-guided search. None beat the record; the best certified
1-minimal object found is **582 vertices** (`c582`, see below), matched by M64's independent rung-lattice
computation. **Every verdict here is solver-only** (CaDiCaL asks, no LRAT/DRAT kept).

| subdirectory | file count | what it holds | trust |
|---|---|---|---|
| `c510/` | 17 (`census.json` + 8×`w*.jsonl`/`w*.err` worker pairs) | A single-deletion criticality census (`single-deletion-criticality-census`) on a 510-vertex candidate: per-vertex-group verdict `critical`/`droppable-alone`/`undecided`, 8 parallel workers | solver-only; `w*.jsonl` are the raw per-group verdicts, `w*.err` the human-readable progress log, `census.json` the rolled-up summary |
| `c582/` | 21 (`census.json` + 10×`w*.jsonl`/`w*.err`) | The same census on the 582-vertex object, **582 of 582 asked groups critical, 0 droppable, 0 undecided** — the record `plans/FRONTIER-STUBS.md` cites as census-certified | solver-only, but exhaustive over this object's vertex groups |
| `g510/` | 17 (`s0`–`s7`.json/.err` + `state.pkl`) | A genetic/evolutionary destroy-and-repair search seeded at weight 510 (best weight found stays 509/510, `best_keep` lists) | solver-only, heuristic search, no improvement over the record |
| `g582/` | 17 (same layout) | The same search seeded at weight 582 (best weight stays 582) | solver-only, no improvement |
| `lns510/` | 17 (same layout) | A large-neighbourhood-search variant seeded at weight 510 | solver-only, no improvement |
| `lns582/` | 13 (6 seeds instead of 8, + `state.pkl`) | The LNS variant seeded at weight 582 | solver-only, no improvement |
| `d757/r0A/` | 23 (`s0`–`s11`.json, `.err`, `state.pkl`; three seeds missing a `.json` — presumably interrupted) | Round 0 of a gallop/bisect binary-search shrink directly on the 757-vertex orbit closure, 12 parallel seeds, each converging to a `weight_keep`/`weight_dropped` split (asks logged as "gallop"/"bisect" steps) | solver-only |
| `d757s2/` | 44 (`final.json`, `progress.json`, `r0A/` round-0: 8 seeds × 3 files + `state.pkl`, `r0B/` round-1: 8 workers × 2 files + `state.pkl`) | Round 0: 8-seed gallop/bisect shrink with per-seed correction sets (`r0A/*.corr.jsonl`); round 1: an 8-worker single-deletion census (`r0B/w0`–`w7`) on the round-0 survivor; `final.json`: **keep = 290 vertices held critical, lower_bound = 580** | solver-only, restricted to an order-2-symmetric selection |
| `d757s3/` | 44, same two-round layout | Order-3-symmetric restriction; **final lower_bound = 558** (the value M62/M64 call the 558-at-order-3 rung) | solver-only |
| `d757s6/` | 44, same two-round layout | Order-6-symmetric restriction; **final lower_bound = 576** (the 576-at-order-6 rung) | solver-only |
| `d757v/r0p1/` | 33 (`w0`–`w15`.jsonl/.err, `state.pkl`) | A 16-worker single-deletion ("droppable-alone") census variant on the 757-vertex object | solver-only |
| `portfolio-run1/` | 9 log files (`pf.log`, `pf_seed0`–`pf_seed7.log`) | Solver-portfolio calibration on the 3,205-vertex/182-group arena: 8 CaDiCaL seeds racing at a fixed conflict budget, plain-text logs only | tools-only exploratory logs, not a JSON record |
| `round1/` | 3 log files | `mktrace0.log`: an ask-by-ask SAT/UNSAT trace building the same 3,204-weight arena; `sweep1.log`: a solver/mode/pin configuration sweep (CaDiCaL 1.5.3/1.9.5/3.0.0, incremental mode, centre pinning) recording per-config wall/CPU time and verdict strings; `verify244.log`: **the control that established Heule-510 sits exactly inside the r = 2.44 arena** (510/510 vertices found, 2,504/2,504 edges match Heule's own list, orbit closure = 757 vertices) — the origin of every `d757*` search above | tools-only exploratory logs; `verify244.log` is the closest thing here to a load-bearing control, and it is a plain solver trace, not kernel-checked |

## 3. Parts's own data — third-party reference, verified here (not a Lean claim)

| item | what it holds | trust |
|---|---|---|
| `parts-ref11/PROVENANCE.md`, `SHA256SUMS.txt` | Provenance note: Parts's own vertex-list dropbox export (reference [11] of arXiv:2010.12665, recovered via the Wayback Machine and the still-live dropbox link), 76,045,248-byte download, checksums | third-party data; download provenance documented, not a claim of ours |
| `parts-ref11/JP/Large/*.vtx` (43 files), `JP/Pink/*.vtx`, `*.nod`, `readme.txt`, `graphs.txt` | Parts's raw vertex lists (Mathematica-syntax exact coordinates) for every named graph in his paper's Table 1, plus his own index mapping files to table rows | third-party data, as downloaded |
| `parts-ref11-verified.json` | **All 43 of Parts's graphs independently checked** by exact integer arithmetic in ℚ(√3,√5,√11): vertex count, distinctness, and unit-edge count match every filename; negative controls (moving a vertex by 1/12, duplicating a vertex) confirmed to break the match | **verified-data** — exact arithmetic, re-checkable, with the three structural findings recorded in `PROVENANCE.md` (v509/v510 = an L-subgraph ∪ a ρ₁₅-rotated copy of the S-subgraph; 41 of 43 graphs lie in K = ℚ(√3,√11), only the two M-graphs leave K — Theorem B measured directly on Parts's own published objects) |
| `parts-vertex-lists.json` | Machine-readable export of all 43 graphs as integer coordinate tuples (Parts's own `(a,b,c,d)` convention), with the verification/decomposition facts in `_meta`; round-trips (recomputing unit edges from the integers alone reproduces all 43 edge counts) | verified-data, independently reproducible |
| `parts-table1.json` | Hand transcription of Parts's Table 1, with every numeric field re-checked against his own `.vtx` files by `tools/parts_audit.py`; two disputed rows (the 214- and 312-vertex non-mono-pair distances) resolved from his own `graphs.txt` wording (distance 3 and 1/3, not √3 and 1/√3) | verified-data (transcription + independent re-check), corrects CLAUDE.md ledger row 59's two flagged rows |
| `parts-table2-orbit-fillings.json` | Orbit fillings of five L-subgraphs (Parts's minimum 374 plus Heule-510/517/529's L-subgraphs 375/382/393 as controls) | verified-data; the 375 column is checkable against `tools/heule510.json` with no free parameters |
| `parts509-orbit-fillings.json` | The 509-vertex graph's orbit decomposition: L (374, subtype M6A/M6B) + S (136, subtype M6A) sharing one centre orbit, 374+136−1 = 509, 2442 edges | verified-data, derived from Parts's own Table 3/4 orbit labels |

## 4. M63 phase C/D — the reduction engine and its diagnostic instruments

"Reduction" here means: given an L- or S-subgraph and a companion, compute the exact minimum vertex count
(over some symmetry-restricted family of selections) that still refuses the target colour count — the
computational core of trying to reproduce/improve Parts's construction.

| file | kind | headline | trust |
|---|---|---|---|
| `m63-D0-cost-probe.json`, `m63-D0-cost-probe-L451.json` | `m63-cost-probe` | Phase D0: measures the CPU cost of one reduction ask at two stages (L 412+S 135 = 547 v / 2,694 e; L 451+S 135 = 586 v / 2,988 e), the number that decided phase D's affordability | solver-only timing measurement |
| `m63-S166-reduction.json` | `m63-reduction` | **The stored, current** S-side reduction record: minimum 135 vertices over all selections (matches Parts's own S-subgraph count) | solver-only (exhaustive-level SAT enumeration), reported "reduced"/"complete" |
| `m63-S166-reduction.pre-Y.json` | same kind, older schema | An earlier version of the same record, computed **before** the "Y" accumulator phase was added; superseded by the plain file, kept for provenance (plans cite it explicitly as what §R1/§R2 were computed from) | superseded by `m63-S166-reduction.json` |
| `m63-S166-reduction.v2.json` | `m63-reduction`, regenerated | A same-day **regeneration-for-comparison** of the S166 reduction, written beside the stored one and never meant to overwrite it (`plans/M63-phaseC-joint-stage.md`); used to confirm reproducibility | verified-data in the sense of an independent re-derivation matching the stored record; not itself authoritative |
| `m63-L451-reduction.json` | `verdict`-only schema (older) | **The stored, current** L-side reduction record for L451+S135: minimum 375 over all selections, 3,264 minima found, |M| = 374 vertices — the record M64's whole orbit-filling-polytope analysis (§1 above, "624/576/558/582") is built on | solver-only (exhaustive-level), "reduced" |
| `m63-L451-reduction.pre-Y.json` | same, older schema | Pre-"Y"-phase version, superseded by the plain file | superseded |
| `m63-L451-reduction.v2.json` | `m63-reduction`, regenerated | Same-day regeneration-for-comparison, kept beside, not overwriting | independent re-derivation, not itself authoritative |
| `m63-D1a-A451-rung3.json` | `m63-reduction` | L reduction of v451e2400 against v136e564 (frame coset 1 of 2), **rung-3-symmetric** selections only: minimum 375, |M| = 376 vertices | solver-only, "reduced"/"complete" |
| `m63-D1a-A451-rung3-vs-A166.json` | `m63-reduction` | The same rung-3 reduction against companion v166e774 instead: minimum 375, |M| = 376 | solver-only |
| `m63-D1b-A412-rung1.json` (75 MB) | `m63-reduction` | L reduction of v412e2106 against v136e564, **rung-1** (no symmetry restriction): minimum 373, |M| = 374, level 26,724 — the largest reduction run in this campaign | solver-only, exhaustive-level |
| `m63-M6B403-reduction.json` | `m63-reduction` | L reduction of v403e2106 against v141e594 (frame coset 1 of 4): minimum 374, |M| = 375, level 360 | solver-only |
| `m63-probe-red-o*.json` (11 files, one per orbit tag `o0_0_8_0` … `o6_4_6_0`) | `m63-reduction` | The same reduction re-run seeded at eleven different single-orbit starting points, for the phase-D expansion sweep (§5 below) | solver-only, each "reduced"/"complete" |
| `m63-probe-ckpt-o*.json` (13 files) | `m63-reduction-checkpoint` | Mid-run checkpoints (`ReductionState`) for the same eleven-plus orbit tags; `status` is `complete` for most, `in-progress` for two (`o0_0_6_6`, `o12_0_2_6`) | in-progress/complete checkpoints, no `undecided` outstanding in any file |
| `m63-audit-L451.json`, `m63-audit-M6B403.json`, `m63-audit-S166.json` | `m63-audit` | Cross-checks (`tools/parts_audit.py:audit_level`) confirming the reduction's minimum (374/375/135) reproduces exactly across independent orbit-row comparisons, level-complete | verified-data in the sense of an independent re-derivation against the stored reduction records; not kernel |
| `m63-freeze.json` | `m63-freeze` | The frozen configuration (ranking rule, escalation schedule, held-out state = our 375-level accumulator = Parts's v403e2112 vertex-for-vertex) for phase D's expansion sweep, committed **before** any candidate's outcome was read, per the product-owner ruling that a self-scored map is a mirror not a measurement | pre-registration document, not a measurement |
| `m63-sweep-protocol.json` | `m63-sweep-protocol` | The companion pre-registered evaluation protocol (outcome variables, scoring rule, in-sample-vs-held-out split) for the same sweep | pre-registration document; its `his_move_absent_by_construction` field asserts "the four orbits his move used are not in this candidate set at all" — **found FALSE**: two of the four (`(0,0,0,4)`, `(0,0,6,6)`) ARE live partial-fill candidates, tested singly, and came back inert. Per `plans/M63-phaseD-the-loop.md` (line ~2029), **the frozen file is deliberately left uncorrected** (retro-editing a pre-registration would destroy the one property it has); the correction lives in `plans/M63-phaseF-beat-509.md` §X.2 and in `m63-map-A412.json`'s own (correct) `his_recorded_move` field |
| `m63-loop-A403.json` | `m63-loop` | Six iterations of the frozen ranking rule applied at state A403: result **`stalled`** at 375 vertices (12 then 40 candidates evaluated per iteration, never improving) | solver-only, iterative |
| `m63-trim-test.json` | `m63-trim-test` | Tests whether trimming low-final-degree vertices survives / preserves "his move" (Parts's recorded expansion) | solver-only; verdict `trim-preserves-his-move` |
| `m63-card28.json`, `m63-card28-forall.json` | `m63-card28` | Whether Parts's own four-orbit expansion move is a statistical outlier on union/overlap coverage against random four-subsets of the menu (verdict: **outlier-on-neither**, union at the 80th percentile, overlap at the 0th) | tools-only statistical comparison against a random baseline, not a solver claim |
| `m63-fs35-1-375.json` | `m63-fs35-1` | The look-ahead orbit-closure-bound computation (§FS35-1) at the 375-vertex A403 state: 2 exchange classes, affine dimension 2, sixteen symmetry rungs each with a closure-bound upper bound on `M_H` | tools-only, exact combinatorial computation (no solver call) |
| `m63-his-move.json` (87 MB) | `m63-his-move` | Whether the apparatus reproduces Parts's own recorded four-orbit expansion step (adds 30 vertices at incumbent weight 374): verdict **`yes`** — explicitly flagged `not_a_gate`: "diagnostic only" | tools-only reproduction check, large per-candidate trace |

## 5. M63 phase D — the expansion map and its probe candidates

| item | what it holds | trust |
|---|---|---|
| `m63-map-A412.json` | The completed expansion map: **89 candidates** scored against the 374-vertex accumulator, 63 decided "no" + 26 "shoulder" (not run to a verdict), 0 "yes" — i.e. no single tested orbit expansion improved on the incumbent | solver-only per-candidate SAT asks |
| `m63-map-A412-first.json` | An earlier **truncated** run of the same map (`--limit`), only 2 of 89 candidates reached | superseded by `m63-map-A412.json`. Its own `his_recorded_move` field, read in isolation here, is honest about the truncation ("not reached… a truncated run"); the false claim named above lives in `m63-sweep-protocol.json`, not in this file's own text — flagged together with it per the task note, so recorded here for completeness |
| `m63-map-A412/entry-*.json` (178 files) | One file per scored candidate orbit-combination (e.g. `entry-(0,0,0,4):3.json`): the candidate's added vertices, orbit membership, provenance (`partial-fill`), and outcome | solver-only, one SAT ask's worth of detail per file |
| `m63-probe-menu-S166.json` | The candidate menu for the S-side companion probe (v166e774 against base v374e1860, threshold 4): 217 rows, each an orbit label with degree/admission counts and (where admitted) a pointer to its `.vtx` file | tools-only menu construction, no solver verdict itself |
| `m63-probe-pair-candidates.json` | 112 candidate vertex-pair combinations for the pair-probe stage | tools-only enumeration |
| `m63-probe-pair-menu.json` | 14 "singles" (orbit tags) and the 112/91 pair/within-singles counts derived from them | tools-only enumeration |
| `m63-probe-pair-menus.json` | Per-pair menu detail (`a`, `b`, `c_new`, `b_union_c` fields) for the pair-probe candidates | tools-only enumeration |
| `m63-probe-S166-o*.vtx` (13 files, tagged `o0_0_6_6` … `o6_4_6_0`) | Exact Mathematica-syntax vertex lists for the S-side single-orbit probe candidates (each an augmented v374e1860 base + one orbit) | exact-coordinate data files, not themselves a verdict |
| `m63-probe-P1-o*-o*.vtx` (15 files) | Exact vertex lists for one family of paired-orbit probe candidates | exact-coordinate data files |
| `m63-probe-P2-o*-o*.vtx` (~78 files, every ordered pair among 14 orbit tags) | Exact vertex lists for the second, larger paired-orbit probe family | exact-coordinate data files |
| `m63-rows/A403.json` | The registered "held-out row" record: our 375-level accumulator (403 vertices) confirmed identical to Parts's own v403e2112, registered **after** the 2026-09-11 freeze (so it could not be re-frozen to fit an observed outcome) | tools-only registration record, derived from `m63-L451-reduction.json` |

## 6. M63 phase F/G/H — edge minimisation and the ρ₆₃ arena certificate

| file | kind | headline | trust |
|---|---|---|---|
| `m63-edge-phase1-509.json` | `m63-edge-phase1` | Single-deletion edge criticality on the published 509/2442-edge graph: **1,831 individually critical edges**, 609 droppable-alone, 2 undecided — a rigorous *lower* bound on the true edge minimum (1,831 ≤ e_min ≤ Parts's published 2,406) | solver-only, exhaustive over 2,442 edges bar 2 undecided |
| `m63-edge-greedy-509.json` | `m63-edge-greedy` | A greedy 1-minimal edge-reduction pass: **2,279 edges kept** (163 dropped from 2,442), beating Parts's published 2,406 discard; order-dependent, an upper bound only | solver-only; `verdict: greedy-1-minimal`, explicitly not the true minimum |
| `m63-edge-verify-509.json` | `m63-edge-verify` | Independent verification of the 2,279-edge object: refusal re-derived and checked with a hand-written RUP/LRAT replayer with **5 planted-fault self-tests, all firing correctly**, plus two SAT controls (removing one more edge / one more vertex both become colourable) | **solver + self-checked replayer, not kernel-checked** — `verdict: verified-refusing-edge-subgraph`, and its own text says "this is an UPPER bound... never the minimum" |
| `m63-phaseG-screen-r2.44.json` | `phaseG-filter4-arena-screen` | A screen over candidate bases/rotations at radius 2.44 against Theorem B's colourability filter, with a unit-edge control and calibration rows | solver + exact-arithmetic filter, tools-only |
| `m63-phaseH-base-r452.json`, `m63-phaseH-base-r6.json` | `m63-phaseH-base` | Two candidate base constructions (at r² = 4.52 and r² = 6) for the phase-H arena, with generator images, unit-edge controls, and a `sat_new` field | solver-only, exploratory |
| `m63-phaseH-control-nou-r452.json` | `m63-phaseH-base` | A control variant of the r² = 4.52 base with the extra point `u` omitted | solver-only, control |
| `m63-phaseH2-rho63-certificate.json` | proof-object record | **The row-64 χ ≥ 5 argument for the ρ₆₃ arena**: a 4-condition (C1–C4) case split — C1/C2 are 20 CaDiCaL UNSAT calls (1 + 19), C4 is a finite check over 552 listed interface patterns with no solver — concluding "NOT four-colourable, conditional on C1–C4" | **solver-only** (C1/C2), plus a finite combinatorial check (C4) not re-verified by any independent checker here; **not kernel-checked, no DRAT checker was run against the proofs** |
| `m63-phaseH2-rho63-proof-manifest.json` | manifest | Per-proof stats (name, verdict, seconds, CNF/DRAT sizes) for the 20 UNSAT calls above: 198.2 s total, 362.1 MB of DRAT proofs | **the DRAT/CNF files themselves were never committed** (they lived under `/tmp`); only this size/verdict manifest and the certificate survive — the underlying proofs are not re-checkable from this repository |

## 7. M64 — the orbit-filling polytope

| file | kind | headline | trust |
|---|---|---|---|
| `m64-rung-lattice.json` | rung-lattice record (`scratchpad/lattice.py` against `tools/parts_faces.py`) | The complete symmetry-subgroup lattice for both the L-side (16 rungs) and S-side (6 rungs) reductions, with per-rung minima: **L order 1: 375 · order 6: 376 · order 12: 379** etc.; **S order 1: 136 · order 6: 142** — 15 of 16 L rungs and 4 of 6 S rungs exact, the rest lower bounds | **verified-data**: exhaustive over the subgroup lattice, "costs no colouring ask at all" beyond one verification ask per rung (58 s total); producer script `scratchpad/lattice.py` is **not committed under `tools/`** |
| `m64-orbit-closure.json` | closure-bound record (`scratchpad/orb2.py` against `tools/parts_faces.py`) | The two-line theorem (upward-closed correction-set families give a solver-free upper bound `min_M \|cl_H(M)\|` on any symmetry rung's minimum) plus its verification on the S/L data | verified-data (hand two-line theorem + exhaustive check); producer `scratchpad/orb2.py` **not committed under `tools/`** (partially addressed by commit 8ecc22f — see task note) |
| `m64-faces.json` | face/orbit-class data | The complete correction-set / atom-class structure for both S and L, feeding the rung-lattice and closure computations | verified-data, exhaustive |
| `m64-phaseD.json`, `m64-phaseD-layers.json` | polytope-face record | LP-vs-integer optimum gaps for S (125.25 vs 135) and L (369.0 vs 374), the "survivor" integer points excluded by the affine hull or by exchange equalities, and (in `-layers`) the smallest constraint layer that excludes each survivor | verified-data (exact LP + integer enumeration over harvested constraints) |
| `m64-rungs.json` | rung listing | Vertex counts by symmetry class: `live-order-2` / `dead-order-2` / `full-order-12`, 16 entries each | verified-data |
| `m64-rungs.pre-Y.json` | rung listing, older | Byte-identical content to `m64-rungs.json` in this snapshot; kept as the pre-"Y"-phase provenance copy | superseded by `m64-rungs.json` (no observed difference at this snapshot) |

## Not recorded here

Per the task's list of headlines with no committed record on disk:

- **The joint reduction bracket [504, 509]** (M63 phase C's "C4a") — never closed to a value; the joint route
  was abandoned by Kooshi. The `build/gate/m63/c4a.log`, `c4b.log` and a checkpoint that would support it were
  never committed.
- **M62's "55 patterns on the 5,401-point L half"** — no file under `data/m62/` corresponds to this figure
  (flagged independently by the Poros review per FINDINGS).
- **Phase H3's certificate** (the shape-free n = 2 arena's 4-colourability at every radius) — the ~47 KB
  certificate and its `recheck.py` live only in `build/m63-phaseH3-solver/` (gitignored); no file under
  `data/`.
- **Phase H4's free-deletion census, pilot, and compulsion sweep** — see `data/m63/README.md`'s own
  "Not recorded here" section; only the additive-family gauge dial (§ above, item 6's phase-H2 material is
  distinct from phase H4) is committed, in `data/m63/`.
- **FS-32's vertex-criticality asks** (Heule-510/553, 0/510 and 0/553) — the plan-touching commit
  (`e89192a`) only edited the plan text; no `data/` file backs the table.
