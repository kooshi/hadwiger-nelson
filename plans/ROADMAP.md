# ROADMAP — the descent era, as two interwoven tracks

*Created 2026-09-01 on Kooshi's direction: "we've transitioned from structured milestones to chasing
tangents while the iterations churn, which is a good use of time, but risks losing ideas — let's make
a proper roadmap, and one we can follow while we curate and improve the iterations." This file is
the OPERATIONAL BOARD. It does not replace the two documents that already govern: `CLAUDE.md`
§ Frontier / § Paths forward stays the ranked milestone list rewritten at every milestone close, and
`plans/STANDING-QUESTIONS.md` stays the durable ledger where every idea gets an identifier and an
epistemic status. This board says what runs NEXT on each track and how the tracks interleave.
Update triggers: every iteration commit, every work-order close, every tangent finding — the same
day, in the entry's own row. Deprecate, never delete.*

**The mission in one line.** Replace the distance-2 "cheat" edges of a non-5-colourable
{1, 2}-distance graph with genuine unit-distance material, one certified batch per iteration, until
one cheat remains (a proof that the plane needs six colours) or the loop hits a wall we can name.

## Track A — the iterations (the loop churning)

### A.0 One iteration, and who runs each phase today

| # | phase | Python (reference) | Rust `descent` | status of the port |
|---|---|---|---|---|
| 0 | floor (which cheats are essential alone) | `batchkill.py --recurse` | — | WO-12 |
| 0′ | vertex census + deletion commit | `--vertex-census`, `tools/vertex_delete.py`, `--commit-deletions` | — | WO-12 |
| 1 | enumerate the classes of the batch | Python cubes | `enumerate` (WO-6/7/11) | **done** |
| 1′ | sub-batch curve + filter | `tools/subbatch.py` | WO-8 stub | Python |
| 2 | pool build + export | `--pool-only` (vectorized 2026-08-31; ~1.5 h at 1.47 M points) | export consumer | WO-12 first port |
| 3 | profile (kill each class from the pool) | tiers | `replay` (WO-1/2/10) | **done**; hygiene at scale = WO-3 |
| 4 | hitting set | scipy MILP | — | WO-12 |
| 5 | design + shrink the halo | cover/ddmin | `design` (WO-5/5b/5d/10) | **done**; WO-9 knob, WO-5c paused |
| 6 | **certify** + commit (the truth-maker) | lookup (checkpointed) + one-hot & 3-bit UNSAT + exact geometry | — | WO-12, reviewed first |
| — | columns: χ(unit part), recursion floor, field census, weighted ladder | `m50_skewscan.py --unitchi`, `--recurse`, `field_census.py`, `--scan` | — | χ(unit) is a halt clause in WO-12 |

Standing halt clauses (never softened): μ ≤ 1 ⟹ HALT AND VERIFY; χ(unit part) 4 → 5 ⟹ HALT and
certify the new 5-chromatic witness; a REFUSED certificate ⟹ INVESTIGATE, never retry; any
hardware event ⟹ HALT; an unknown is never folded into a verdict.

### A.1 Where the loop is

| iteration | object | cheats standing | what happened |
|---|---|---|---|
| seed | Exoo–Ismailescu, 214 pts | 446 | — |
| 1–2 (M50) | 1,008 pts | 403 | two certified batches, 43 cheats |
| 3 (M51) | 1,862 pts, 13,037 unit edges | 393 | 854-point halo; commit 2026-08-28 |
| 3′ deletion | 186 live seed vertices | **298** | 28 seed vertices deleted, certified both encodings |
| 4 (M51) | 1,981 pts, 13,796 unit edges | **273** | sub-batch of 28 (37,316 classes); 119-point 1-minimal halo, zero stalls; commit 2026-09-02 05:34Z; it-5 floor 27 of 273, 0 unknown |
| **M52 (2026-09-02, live)** | the it-4 object, its ρ₁₅ copies, their compositions | 273 (plain) | **the loop is PAUSED**: anatomy → composition ranking → cull by enumeration → shrink → the decision (`plans/M52-copy-lock-objects.md`); the next milestone is it-5 from the chosen object or a pivot |
| 5 | the put-back and kept cheats rejoin the floor | — | same loop |

### A.2 The curation queue — improvements to the loop, each mapped to the phase it speeds

| item | phase | state | what it buys | order |
|---|---|---|---|---|
| WO-10 contract v0.9 | 3, 5 | pending; live A2 = the it-4 profile (the 16 → 12 worker refusal, the block line) | the deleted-vertex dialect pinned in SPEC | **next engine session** |
| WO-11 contract v0.10 | 1 | pending after v0.9 | the informed split pinned; A2's 2.32× miss recorded with D61 | 2 |
| WO-3 courier + `qualify` + profile hygiene | 3, deploy | **frozen; premise retired, replan authorized** (subplan `WO-3-courier-and-hygiene-subplan.md`, 0788b3b: the static-musl packaging route — moot now the 128-core server runs Arch and the native binary ships as-is; `qualify` verb, budget ladder + claim-of-one, D62–D67 filed and SPEC v0.11 drafted all still live) | one results bundle, machine qualification, head-of-line rules — **prerequisite of any server run** | 3 |
| WO-12 loop binary | all | stub; NUMA-aware, halt clauses, phase coverage table | the single binary that churns iterations on the 128-core server | 4 (pool port first) |
| WO-9 point order | 5 | frozen, negative by theorem; a knob | 1–2 % of the shrink; a quiet-slot job | 5 |
| **WO-14 the culler** (`descent cull --groups cheats\|vertices`: group-MUS with cores + recursive model rotation on a long-lived solver, IHS minimum, ferry-format outputs) | M52 cull + shrink | **LANDED 2026-09-02 (engine main, merge of wo14-impl 85fdfdd): `descent cull --groups cheats\|vertices`, `--census`, chunked acceptance; gate 269/269 verified by the owner; A3 273/273 with the floor census; A4 partial (49/273, resumable); follow-up order = licence holding (D75) + drain on signal (D76) + the clean A/B.** The planner's headline: the cull stalled on the CNF, not compute — hard clauses + palette order over unit ∪ standing decide in 121 s where the guarded selector encoding sat at 1,302 s; rotation 0 % on cheats, 3.5 witnesses/call on vertices; long-lived solver negative here; IHS = WO-15 | the cull and the shrink of the copy-lock objects, and every later iteration's floor/cull | **1** |
| WO-13 long-lived solver (pins as assumptions) | 1 | stub | D45 + D61: cold starts and the 2.5× pinned-cube penalty | when enumeration binds (the full-floor stage, 2.59 M classes) |
| WO-4 SIMD kernels | 3, 5, 6 | stub; opens with a tier census that decides its worth | solver-free tiers; the certify's lookup masks | after the census |
| WO-5c ask order inside a trial | 5 | paused | early exit on critical points | if the shrink is ever the floor |
| WO-8 sub-batch filter in Rust | 1′ | stub; Python does it in seconds | removes one Python step from the loop | inside WO-12 |
| Python: certify per-stage checkpoints | 6 | **landed** (iteration-3 incident fix) | a killed commit resumes | — |
| Python: pool build vectorized | 2 | **landed** 2026-08-31 (2 h 46 m → 1.5 h) | — | ported in WO-12 |
| process rules | all | in force | 16 threads on memory-tight/wall-capped phases; one heavy job; every phase > 15 min checkpoints; first pass always wall-capped | — |

### A.3 The server plan (the 128-core, dual-socket, 1.5 TB box)

Prerequisites, in order: (1) WO-3's static binary and `descent qualify` (a multi-hour zero-event
memory run on the server before its first multi-day job); (2) WO-12's pool port (the one phase
whose Python cost scales worst); (3) the certify port, reviewed first — the loop's truth-maker;
(4) NUMA placement (per-node pools, first-touch after pinning, per-node export replicas;
`numastat` as the control); (5) the driver with its halt clauses and per-iteration report. The
first server job before the loop binary exists: the full 39-cheat-floor enumeration + profile (2.59 M
classes) as a courier run — the sub-batch's "what do we lose" question answered by comparison
(Track B, T10).

## Track B — the tangents (ideas, theory, and the mathematics the iterations throw off)

### B.0 The rule

An idea enters `plans/STANDING-QUESTIONS.md` with an identifier (K = kernel-ready, T = theory
frame, Q = Kooshi's, F = refuted) the day it is spoken; this board gives it a slot. A tangent
that matures into a milestone gets a stub in `plans/` (the stub rule, `WORKFLOW.md` step 2) and a
row in `CLAUDE.md` § Paths forward at the next close. Nothing is worked from memory.

### B.1 Kernel-ready pieces (cost: an afternoon each; compute: none — these run WHILE the box is busy)

| id | statement | consumer |
|---|---|---|
| K1 | the spare-colour lemma: a (k−1)-colourable graph forces no pair at k | the χ(unit) monitor's theorem; every 5-colour gadget is ≥ 5-chromatic |
| K3 | the absorbing lemma: forcing is monotone under augmentation | the descent's licence, one line |
| K2 | the compactness bridge: finite separating colourings ⟺ the infinite closure's | Q3, the closure-transfer angle |
| K4 | the entropy floor (same-graph scope) | the generator screen (Q1) |
| — | the pair-gluing licence `PartnerLattice.lean` | **landed** at M50 |

### B.2 Findings of the last week awaiting their theory (each measured exactly; none yet a theorem)

| id | finding | the question it opens | next step |
|---|---|---|---|
| Q6 | the seed is two triangular crystals split by exactly the Moser twist arccos(5/6), joined by a 12-edge axis interface — ten already removed, the heavy pair 206–210/206–211 last | is the interface the whole 5-forcing, and does the descent's order of consumption prove it? | after it-4 commits: does the heavy pair fall, and what kills it (the anatomy of its halo) |
| Q7 | the halo's ring system: every halo-to-seed distance spike in ℚ(√33) on √3-ladders; (7−√33)/6 is the M33 3-cover-core shell; shells touch at fixed algebraic gaps | one shell vocabulary across the seed object and the seam fabric (G4) — a theorem about glue points of ℚ(√33) rings? | state the ring-radius classification as a Glue.lean corollary; check it on iteration 4's halo |
| T10 | the sub-batch works but drops cross-cheat interactions ("what do we lose") | is the sub-batch's hitting set a subset of the full batch's? by how much per iteration? | the full-stage courier run (A.3) compared against the sub-batch commit |
| T11 | width stalls: kills that are thousands of weak points cooperating; restricted pools (pdeg12) kill 42/42 hard classes at 3.1× | is width a property of the class or of the pool choice? does the stall fraction grow across iterations (G33's falsifier)? | the stall census per iteration as a standing column |
| T12 | solver reuse 2.3× (up to 250× per hard ask); locality grouping inconclusive (trajectory variance); SMT 16 > 32 on tight phases | engineering facts, not mathematics — they bound what the server buys | the definitive locality test on the server (WO-13 regime) |

### B.3 Registered but not run (each has a stub or a registration; none blocks the loop)

| item | where registered | why it waits |
|---|---|---|
| Parts-{1,φ} weighted-ladder replication | `plans/STUB-nominated-gadgets.md` | decorrelates "the dial nominates" from "E–I was built this way"; background job, runs in any gap |
| width-stall overlap census; smoothness probe; P5 radicand 60-vs-59 | `plans/M51-descent-engine.md` §B8 | sittings; need a stall batch and a quiet box |
| the exhaustive arity ladder on the certified 23-core; the randomized re-shrink | `plans/M45-arity-floor.md` §R7 | cheap, promotable; nobody has had a free afternoon |
| the multi-hour zero-event memory run on the desktop | `CLAUDE.md` § Toolchain | the box is always busy; the server needs the same before day one |

### B.4 Milestone candidates (stubs exist; ranked in `CLAUDE.md` § Paths forward)

| milestone | frame | trigger |
|---|---|---|
| nominated gadgets (unnumbered stub — milestones are numbered at minting, Kooshi 2026-09-02; formerly mapped as M52) | the stall response: minimal in-context gadgets for the (4,A)/√3/√7 pairs; the in-context → context-free gradient | the descent stalls hard, or Q6's heavy pair refuses every pool |
| M46 colouring automaton | the description instrument | a stage whose separating list has structure worth naming |
| M47 multidistance | the {1, √3, 2} plane and its relatives | literature gate first |
| Q1 crystal generator | fuse 5-forcers, screen by entropy rate | after K4 and T9(i) |
| Q2 no-stall reframing | χ ≥ 6 as "stalls have impossible anatomy" | needs the reachable class defined |
| Q3 closure transfer | the stall ⟺ a separating colouring of the infinite closure | after K2 |
| Q4 rigidity currency | log-odds N_sep : N_eq as the progress metric | a standing column once the loop binary reports it |

### B.5 Kooshi's ideas queue

Q1–Q5 in `STANDING-QUESTIONS.md` §Q; Q6–Q7 added 2026-09-01 (his visualizer observations, measured);
**Q8 (duplicate + rotate by the derived spindle angle) and Q9 (duplicate + mirror across the forced
pair's line) added the same night** — the χ = 5 construction trick applied to the descended object,
in two regimes: (a) a 5-chromatic UNIT graph by the spindle theorem if the unit part forces a pair
equal at four colours; (b) the copy as a 1,862-point halo against the sub-batch's classes. Probe
`tools/copy_probe.py`, predictions registered in the ledger.

## How the tracks interleave

| when the loop is in… | Track A does | Track B does meanwhile |
|---|---|---|
| a long unattended phase (enumerate, profile, design, certify) — hours | monitors the phase (stall watcher, progress line) | kernel pieces (K1–K4: no compute); engine PLANNING sessions in worktrees; ledger writing |
| a short attended phase (adopt, hitting, commit, republish, columns) — minutes | runs the steps in order | nothing — attention is the resource |
| a gap between iterations | records the commit's columns and the findings | measurement tangents that need the box (B.3), one heavy job at a time |
| a stall (no affordable sub-batch, or a refuser every pool misses) | halts and names the wall | the nominated-gadgets stub becomes the frame |

Rules that bind both: one heavy job on the box; one work order per engine session, planned and
implemented by different agents, one writer per worktree, I push; every finding recorded the day it
lands (his standing instruction, 2026-08-31); a headline carries its population (G21).

## The next seven days, in order (rewritten 2026-09-05, the field-wall session)

*The field wall is a theorem (`plans/FIELD-WALL-THEOREM.md`); M53 halted on it; the residue obstruction
(T17), the wall-break census (T18) and the first wall-breaking replay (T19: 0 kills) are in. The board:*

1. **Read the partner-pool sample** (`build/m54/replay-partner-sample/`, 394 of the 3,936 in-field
   survivors against the 572,992-point pool of every nontrivial 2-adic class, 300-s walls): the
   kill/unknown split decides whether any depth-one out-of-field material kills at five colours or
   whether the endgame is width-only (M52's copies: 0 kills; single breakers: 0 kills).
2. **Read the rigidity dial** (`build/m54/rigidity-dial-it4.json`, the exact four-colour forced-equal
   sweep of the it-4 unit part by 2-adic valuation class): if forcing sits only at valuation 6,
   Q10's reading stands and the dial's next point is the it-5-grade fabric.
3. **M54 — the five-colour dial (CLOSED 2026-09-06; the theorem in the kernel, two C = ∅ 5-chromatic objects, the 2,229-point one pairwise floppy at five colours in 31 s; next rung named in `CLAUDE.md` § Paths forward item 1) — was: LIVE 2026-09-05, Kooshi: "You are go for the 5 dial milestone";
   `plans/M54-five-colour-dial.md`)**: the critical-set localization theorem in the kernel first (a pair
   compulsion at χ colours lives inside the critical set's complement's neighbourhoods — in the plane a
   forcing graph has ≤ 2 critical vertices, 0 beyond distance 2), then the calibrated sub-dials
   (criticality census, ν), the F₂₄₇ cross-lattice census of the 1,175-point witness, and the
   five-colour sweep on the grown object. Supersedes item 3(b) below.
3b. **M55 — absorption (CLOSED 2026-09-06; `plans/M55-absorption.md`)**: the theorem that "many spindles
   over one fabric" cannot carry a compulsion at any number of spindles (a copy hangs by its fused centre
   and one chord, the base extends, ν ≤ the number of spindles), the ν dial, the single-centre flower
   (critical centre at every depth; floppy in seconds), and the F₂₄₇ cross thickening as the only
   construction that moved the redundancy dial (T24). Next per `CLAUDE.md` § Paths forward: thickened
   material, not stars.
3c. **M56 — the arithmetic of tightness (CLOSED 2026-09-06; `plans/M56-arithmetic-of-tightness.md` §R)**: the
   additive yardstick (`tools/additive.py`, `Additive.lean`) calibrated on K at four colours (F_true 171 ⊆ F_K 187 ⊆
   F_add 2,513 — additive at depths 1 and 3, not at depth 2), read on the seed (its forced pair is the unique
   additively forced pair; 18 of 35 colourings additive; E–I's G exactly additive) and on every witness (no additive
   4-colouring — the spindle chord lies in 4Λ, L8; additive 5-colourings whose forced pairs are all separated
   non-additively; no jackpot). Next per `CLAUDE.md` § Paths forward: the Kempe classes of K-fabric's
   4-colourings (the 16-pair residue), the additive richness dial on the witnesses' fields, the seed as the
   design template.
4. **Kooshi's pick between** (item 3 as it stood before M54 was minted): (a) minting the kernel milestone for Theorem B
   (`plans/STUB-field-wall-kernel.md`, names probed); (b) the endgame design question — what
   5-rigid wall-broken material looks like, G19/G25 with the theorem underneath; (c) continuing the
   in-field loop as in-context reduction (admissible batches by `tools/residue_floor.py`; it cannot
   end and its floor is three).
5. The carried engineering: WO-16, the 3-bit cube front-end for the culled set (R3), WO-3's server
   replan — unchanged, none blocking.

3d. **M57 — additive rigidity (CLOSED 2026-09-06; `plans/M57-additive-rigidity.md` §R)**: the reduction theorem in the kernel (all 5-colourings additive + a 5Λ-pair ⟹ χ ≥ 6), rigidity as Kempe-closure with the solver-free gauge γ, G exactly rigid and every unit-distance object we hold open by orders of magnitude, the F₂₄₇ thickening 5-divisible at depth one (no additive family). The frontier set re-ranked: FS-2 re-aimed (what carries forcing without rigidity), FS-6 minted (a family-keeping thickening).

3e. **The finite-plane pivot (2026-09-06, after M57; `reference/Chat-analysis/VERIFICATION.md`)**: χ(F²) ≤ χ(UD(𝔽_p, 2)) at a degree-one prime above p ≡ 3 (mod 4); χ(UD(𝔽₁₁,2)) = 5 seals K, K(√5), K(√247), Heule's field — χ(ℚ(√3,√5,√11)²) = χ(K(√247)²) = 5 exactly; de Grey's field and K(√7) open pending the planes at 131 and 83. The frontier set re-ranked: **M58 = FS-7 the field sieve** (`plans/M58-field-sieve.md`, with the shadow sieve); FS-6 on de Grey's field; FS-2 scoped; FS-8 Haugland; FS-9/FS-10 the untaken rooms; FS-3 demoted.

