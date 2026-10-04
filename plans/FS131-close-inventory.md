# FS-131 close inventory (opened by Keryx, 2026-10-04 03:59 UTC; Keryx is its only writer until the close)

*Milestone: FS-131, the Lean backlog (`plans/STUB-lean-backlog.md`; its input `plans/LEAN-BACKLOG.md`, 259 rows). A kernel milestone: its plan is
de Bruijn's opening job (`plans/FS131-kernel-plan.md`). One line per item with its source; no narration. Each line is ticked done or declined with its
reason by the close.*

## What "Closed" means here (written before any job launched)

1. **Every one of the 259 rows of `plans/LEAN-BACKLOG.md` has one disposition**, recorded in the plan with its reason:
   - *formalize* — in its merged form where a merge line names it, else in the form its errata and cautions govern;
   - *merged into* another row, which carries it;
   - *excluded* — the audit's "do not formalize as stated" (an empty class), a superseded form, or a statement the kernel or a derivation showed
     false (then its corrected form is a row of its own, or the exclusion names the counterexample);
   - *outside theorem* — a published result entering as an `axiom` with the four items of `LEAN.md` § Assumptions.
2. **Every *formalize* row has a declaration that passes the full gate** (`LEAN.md` § The gate): the build green through `./scripts/build.sh`, zero
   `sorry`, `scripts/axioms.sh` clean with every purchase declared, `./scripts/vacuity.sh` green with its counts reconciled in `CLAUDE.md` § The gate,
   linters silent, spec examples passing, each check's negative control watched; and its formal statement read back against the row's statement in
   the plan.
3. **No hand result of ours is left as a hypothesis** of a backlog declaration at the close, unless it is outside the backlog and named.
4. **FS-129 is Closed** when its compositions (the backlog's § FS-129's compositions, 32 rows) pass the gate; its inventory is ticked then
   (`plans/FS129-close-inventory.md` items 4, 173).
5. A row the kernel shows wrong is a result, not a failure: a statement defect, routed to an Ephodos job; the row then follows item 1.

## The announcement rule (written before any report)

- A result is reported to Kooshi as **held** (kernel-checked) only when its declaration's `#print axioms` has been read from the gate's saved log
  (`build/gate/axioms/latest`), every axiom outside the standard three is a declared purchase named in the report, and the read-back of its formal
  statement against the row is in the plan. Before that it keeps its filed grade.
- A wave is reported **landed** only when its modules pass the full gate on one commit, read from `build/gate/*/latest`, not from a report's line.
- `LEDGER.md` rows are regraded to [kernel] only at a filing, from the implementer's drafts, with every assumption named.

## Rulings in force

1. **No phase-1 fence on the planner in this milestone.** Choice: de Bruijn's opening job reads the derivation files openly from the start.
   Alternative weighed: the standard phase-1 fence (the planner blind to the derivation records until its plan is committed). Why: here the claim
   list is the derivation files themselves — `plans/LEAN-BACKLOG.md` quotes each statement but not the definitions of its terms, which live in the
   derivation files — and the fence's only value under Workflow 3.1 is the chance of a second route (`.claude/output-styles/keryx.md` § What a
   result is), worth less than plannability across 259 results already derived. Confidence: high.
2. **The claim list is `plans/LEAN-BACKLOG.md`**, built by script and re-checked by `python3 tools/fs129_l1_backlog.py --check`; no separate
   `data/fs131/claims.md`. A disposition the plan gives that differs from the backlog's merge note or caution is a dated line in the plan with its
   reason, ruled by Keryx and logged here. Alternative: re-fix a claim list by hand. Why: the backlog was built for this, at Kooshi's decision 3
   (`plans/FS129-cross-application-audit.md` § 1), and a hand copy is where a paraphrase enters. Confidence: high.
3. **Scope is all 259 rows**, § Left the order and the closing section included: each gets a disposition, and the default for a row that left the
   order is *formalize* unless the plan gives a reason (caution C118: they left "because no seed rests on them, which is not the same as having no
   value"). Alternative: only § The order and § FS-129's compositions (210 rows). Why: the milestone's aim is that every hand result the project
   builds on is held or named, and Kooshi's word that formalization is never a cost (`CLAUDE.md` § Counter-priors). Confidence: medium-high; the
   opening job may argue a row out with its reason.
4. **Worktrees** (Kooshi, 2026-10-03, this session's launch: "If you use worktrees, be sure to use symlinks to avoid full rebuilds as we've done
   before."): the recipe of `plans/CRUNCH-2026-09-25-queue.md` § 1.6 — `.lake/packages` symlinked to the main tree's, `.lake/build` copied with
   `cp -a` (4.4 GB, 2026-10-03), because two trees compiling different edits into one symlinked build race on the same `.olean` paths. One Lean
   build at a time across all trees, under `scripts/slot.py`. The opening job runs alone, in the main tree.

5. **Builds from different worktrees may run at once when the slot admits them.** Choice: up to two Lean builds at a time across trees, each under
   `scripts/slot.py --mem 40` (its ledger admits reservations up to 90 GiB and refuses a third). Alternative weighed: the opening plan's "one Lean build
   at a time across all trees" (§ 6.1, § 7.5). Why: RAM is the constraint the rule protects, the slot enforces it with a hard cap per job, and the
   one-at-a-time rule dates from 60 GB builds (`plans/CRUNCH-2026-09-25-queue.md` § 1.6); with three jobs in three trees, strict serialization would idle
   two of them. Confidence: medium-high; a thrash or an OOM kill reverts it.
6. **FS116-O1-YESLIM moves from wave 3 to wave 2.** Choice: wave 2's planner states and plans it beside N-EASY. Alternative weighed: leave it in wave 3
   and let wave 3 wait for wave 2's landing. Why: it rests only on wave-2 rows (FS106-EQ; FS106-COMP through its merged FS129-SR2-YESLIM-EQ) and on
   N-EASY, which the opening plan put in wave 2 for it, and nothing rests on it — the one edge between waves 2 and 3 (checked by script over
   `data/fs131/k1/rows.json` and the CSV), so after the move the two waves are independent, as § 7.1 meant. Wave 2's planner is the table's one
   writer while waves 2 and 3 plan. Confidence: high.

## Registered expectations

- Keryx's priors (the coordinator's, not a lane's, not scored as a lane's): the hard part is the foundation — planar maps, tiles, arcs, vertices
  and rings, and measurable colourings — not the individual leaves; the outside theorems most likely to enter as axioms are Einsiedler–Lindenstrauss
  (measure rigidity), Voronov's and Sokolov–Voronov's theorems, and de Bruijn–Erdős if Mathlib lacks it; the kernel will find a handful of statement
  defects among the 210 ordered and composed rows.
- **FS131-K1's registered expectations** (de Bruijn's planner, `plans/FS131-kernel-plan.md` § 1.3, commit `67ed825a`, before reading the derivations
  closely; scored at the close): E1 statement defects among the 210 ordered and composed rows, median 12, 80 % interval [4, 30], P(≥ 5) = 0.8; E2 at
  least one of the 210 shown false as written, 0.55; E3 the wave-1 skeleton finds a defect, 0.6; E4 row 134's base enters as axioms, 0.6; E5 measure
  rigidity enters as an axiom if needed, 0.85; E6 de Bruijn–Erdős formalized or in Mathlib, 0.75; E7 Lebesgue density usable in Mathlib, 0.9; E8 Euler's
  formula for torus maps enters as a hypothesis or a separate job, 0.7; E9 waves, median 9, 80 % interval [6, 14]; E10 dispositions ≈ 195 formalize,
  ≈ 25 merged, ≈ 30 excluded, ≤ 8 outside theorems; E11 the foundation is the hard part, 0.8.

## Items

1. Opened 2026-10-04 03:59 UTC: this inventory; `data/fs131/` for briefs and reports. Kooshi's word: "You are go for the lean backlog milestone."
   Source: this commit.
2. **Brief FS131-K1, the opening** (`debruijn`, Opus; `data/fs131/briefs/FS131-K1-opening.md`): gated PASS (5 quotations). Record
   `plans/FS131-kernel-plan.md`; report `data/fs131/reports/FS131-K1.md`. Launched alone, in the main tree. Source: this commit.
3. **Brief FS129-AT1, the Proof Atlas** (`clerk`, Sonnet; `data/fs129/briefs/FS129-AT1-atlas.md`), beside FS131-K1: FS-129's open item 172 (two
   stale labels, the headless look per theme, the rebuild); Keryx republishes after. Gate: first run failed twice (no quotation in the statements
   section; a bare `index.html`), both real; fixed; PASS. Source: this commit.
4. **FS129-AT1 done** (report `data/fs129/reports/FS129-AT1.md`); filed as `plans/FS129-close-inventory.md` item 175 (the atlas republished,
   Version 6). Its correction owed — two stale page notes, the unviewed zoomed labels — rides with FS-131's first atlas update. Source: this commit.
5. **FS131-K1 stage 4** (`00e8260b`): 259 rows disposed — 205 formalize, 25 merged into, 29 excluded, 0 outside theorem (`data/fs131/k1/dispositions.csv`;
   `plans/FS131-kernel-plan.md` § 4.3). Keryx's receipt: `tools/fs131_k1_dispositions.py` re-run, exit 0, the same counts; R1's source read
   (`plans/FS114-derivation.md` FS114-K1: verdict "gap", handoff none); R4's source read (`plans/FS129-SR3-audit.md` stage 2: on V6's route the chain
   reads "simple" nowhere, V6-COUNT's last step on sectors); R13's source read (`plans/FS111-derivation.md` FS111-M-REDUCE-I: verdict derived, two minds).
6. **Ruling — K1's R1–R13 accepted as proposed**, with two conditions: R4's four V6 lemmas carry V6-COUNT's last step in its sector form (SR3 § 2.1), and
   R10's named hypothesis (row 123's chain) is listed in the plan as outside the backlog, as the Closed rule's item 3 requires. Alternative weighed:
   sending R4 (a statement widened from the filed V6 entries) to an Ephodos job first. Why: the widening is the audit's own derived reading, filed in
   SR3 with its step table, and the kernel is the second check; an Ephodos job would re-derive what SR3 already did. Confidence: high (R4: medium-high —
   the kernel decides).
7. **Tool defect, FS-129's backlog builder** (K1's F1): an entry whose verdict is "gap" (FS114-K1) entered § Left the order as a row; the builder
   should take derived entries only. For whoever next runs `tools/fs129_l1_backlog.py`; no re-run owed (K1 excluded the row). Source: K1's message;
   `plans/FS131-kernel-plan.md` § 4.3.
8. **Not a backlog row, formalized as a support** (K1's F2): FS111-M-REDUCE-I, which FS129-OR1-TOP5's `uses only:` names, beside TOP5 in wave 9.
9. **Prior-art debt** (K1; a listing only, not read): GitHub `decalion89/chromatic-number-of-the-plane` v1.1.0 claims Lean 4 proofs of χ(ℚ(√2,√3)²) = 4
   and of Fischer's χ(ℚ(√3,√11)²) = 4 — our ledger rows 103 and 57, whose kernel proofs `CLAUDE.md` § Publication lists as ours. Owed: a reading of
   the repository (what it proves, on which axioms, its dates) before any write-up claims those kernel proofs. For Kooshi to know.
10. **The foundation landed on `main`** (FS131-K1 stage 5, `3ec3b6c2`: Plane/Basic, UnitPairs, AeColouring, ArcMap). Keryx's receipt: the saved gate
    logs read — build 438/438 batches green (`build/gate/build/20261004T043057Z-1091664.log`); axioms digest 1,273 records, 1,257 clean, 11 axiom-free,
    5 declared purchases (`build/gate/axioms/20261004T043951Z-1129351.log`); vacuity declarations=7557, refutations-skipped=314, sites 279 unchanged
    (`build/gate/vacuity/20261004T044008Z-1129846.log`). Filed (K1's drafts): `CLAUDE.md` § Trust ledger and § The gate, and
    `scripts/vacuity-baseline.txt`'s header; both digests then read "match". The declaration delta 7438 → 7557 includes other jobs' since 2026-09-26.
11. **Wave 1's skeleton** (K1 stage 6): branch `fs131-w1` at `3358a401`, worktree `.claude/worktrees/fs131-w1` (packages symlinked, build copied —
    checked), 7 modules, 14 rows, 28 `sorry` leaves; plan `plans/FS131-kernel-plan.md` § 6 (`fa50d0a9`), § 6.1 the implementer's handoff.
    FS129-SR1-RINGBAND moved to wave 3 (ring vocabulary).
12. **Generalizations** (K1, at the wave-1 read-backs; the skeleton states the stronger forms): G1 FS129-SR2-HULLSET and FS111-M-HULL2 hold for
    preconnected pieces, not only path-connected; G2 FS106-DIAM (i)/(ii) and FS106-TS-C give distance < 1 between every two points; G3 FS129-SA1-FALC-FAN
    and -FALC-DICHO-K need no finiteness of H; G4 DICHO-K's second clause needs no hypothesis on χ(H). No Ephodos job runs; for the record job's
    errata at the close (the derivation entries state the narrower forms). Method note for every wave: "diameter ≤ 1" is stated pointwise, since
    `Metric.diam` is 0 on unbounded sets.
13. **FS131-K1 done** (report `data/fs131/reports/FS131-K1.md`; harness 526k by the task count — past the replacement line, so no resume): the plan
    complete through § 7 (ten waves; three outside-backlog hypotheses by name — `Row134Base`, `Row130Collapse`, `Row123Chain`, § 7.4; the gate design,
    § 7.5; a draft bearing for the stub, § 7.6). Its held items: a question for Ephodos before wave 7 or 8 (does "simple" for a fragment require tiles
    crossing the domain's boundary to be Jordan domains? § 7.3 item 2); a stub to mint (`Row134Base` in Lean, FS-110's repaired base, as its own
    planner-and-implementer job, § 7.4); predictions scored so far (E9 waves 10, inside [6, 14]; E10 205/25/29/0; E6, E7 met; E4 not met — a named
    hypothesis, not an axiom; E5 never arose; E3 not met in wave 1).
14. **Brief FS131-I1, wave 1's implementer** (`debruijn-implementer`, Sonnet; `data/fs131/briefs/FS131-I1-wave1.md`): gated PASS after one rewording
    (a backticked file extension read as a path). Worktree `.claude/worktrees/fs131-w1`, branch `fs131-w1` at `3358a401`. Source: this commit.
15. **Waves 2 and 3 planned in parallel** (pipelined beside wave 1's implementer; Kooshi's cap of three agents): worktrees `.claude/worktrees/fs131-w2`
    and `fs131-w3` made by Keryx with the recipe (packages symlinked, build copied), both branched at `3358a401`. Briefs FS131-K2
    (`data/fs131/briefs/FS131-K2-wave2.md`, 28 rows with YESLIM) and FS131-K3 (`data/fs131/briefs/FS131-K3-wave3.md`, 20 rows), each gated PASS.
    Source: this commit.
16. **The stub's bearing filed** from K1's draft (`plans/FS131-kernel-plan.md` § 7.6), verbatim, in `plans/STUB-lean-backlog.md` § Bearing on the answer.
17. **Held, with defaults** (from K1's report): (a) the question for Ephodos — does "simple" for a fragment require tiles crossing the domain's boundary
    to be Jordan domains? — default: an Ephodos job briefed before wave 7's planner, from K1's § 7.3 item 2; (b) the stub to mint, `Row134Base` in Lean
    (FS-110's repaired base, S–V Cor. 1 a.e.) as its own planner-and-implementer job — default: written before wave 5's planner, from K1's § 7.4.
18. **Statement defect — FS111-M-COVER-SC's second clause is false as written** (FS131-K2, message 2026-10-04): "that function is semiconcave with
    constant 1" fails wherever a boundary piece is a unit arc with its class outside the arc's disc — the lower arc `c − √(1 − t²)` has second derivative
    `(1 − t²)^(−3/2)`, equal to 1 only at `t = 0` (Keryx's receipt: sympy, `v'' = (1 − t²)^(−3/2)`, 1 at 0, `8√3/9` at 1/2). Counterexample: R7, a maximal
    cover (FS111-VMW-R7-MAX). The error is in the argument's reading (`plans/FS111-M-regularity.md` § 3.4, "the exterior disc's lower arc, `+1`"). The
    same clause stands in **FS111-M2-HULLC** (wave 6; two minds, and its own `model:` line names R7) and in SR2 item 17's merged form. Unaffected: the
    first clause (an enclosing or exterior unit disc per adjacent piece); ledger row 140's word "semiconcave", which carries no constant; the not-claimed
    semiconvexity. Correction owed: errata under both entries in `plans/FS111-derivation.md` and their `LEDGER.md` § B index lines (1295, 1318), drafted
    by the milestone's record job, filed by Keryx.
19. **Ruling — the corrected form** of FS111-M-COVER-SC's second clause (and of FS111-M2-HULLC's, at wave 6): curvature at most 1 in the viscosity sense —
    where `∂F_a` is locally the graph of `u` with `F_a` below, `u` is touched from above at each point by a unit arc or a concave arc, so
    `u'' ≤ (1 + u'²)^(3/2)` in the viscosity sense — stated as the row, with its corollary that `u` is semiconcave with constant `(1 + L²)^(3/2)` on any
    interval where it is `L`-Lipschitz (so every consumer that needs only "semiconcave" keeps it). Alternative weighed: the corollary alone as the row,
    or semiconcavity with every constant `C > 1` near each point. Why: the curvature form is the strongest true statement the argument reaches, is
    frame-free, and implies both others. Confidence: medium-high — one mind for the corrected form, and the kernel decides. Wave 6's planner restates
    HULLC the same way; a consumer that reads the constant 1 is a finding at that wave.
20. **FS131-K2 handed back at stage 4 (partial), harness ≈ 494k** (report `data/fs131/reports/FS131-K2.md`; branch `fs131-w2` at `3620923c`, commits
    checked): wave 2's foundation sorry-free (Plane/Cover, Suprema, CPColouring; 17 records on the standard three); 22 of 28 rows stated (48 `sorry`
    leaves), read back (§ 4.1); no outside theorem as an axiom (de Bruijn–Erdős in Mathlib as `nonempty_hom_of_forall_finite_subgraph_hom`;
    `[Falconer1981]` Lemma 1 formalized here through one two-circle lemma, K2's own derivation, one mind); `sq9 : AeColouring 9` inhabited with no
    `sorry` — the first kernel inhabitant of the measurable colouring class. Left: six example rows (FS111-M-R7, -M2-DISC7, -M3-BAND, -M3-HC,
    -M3-FIXCONV, -M3-IRREG; definitions sketched § 4.4) and the fresh obligation-modeling pass. Successor: FS131-K2b.
21. **Generalizations** (K2, § 4.1; the skeleton states the wider forms): FS111-M-SATC (iii) needs no maximality; FS106-REM (i) and FS121-D4-FACE hold for
    one measurable set with null unit pairs (REM's kept points need not lie in the set); FS129-MA2-FALC-HOSTS (ii) for any additive image of Λ sending no
    unit vector to 0, connectedness unused; FS129-SA1-SQRT3-LOCAL for any number field with `i ∉ F` (on `s² ≡ 3 (mod 4P)`); FS129-SA1-FALC-RES (ii) for
    every pair with PLACE-HOM's properties; FS116-O1-YESLIM and FS129-SR2-SUPK at every k; FS111-M-COVER-SC's first clause for preconnected pieces. A
    shorter route proposed (FS106-EQ (c) ⟹ (a): a union bound over finitely many integer radii in place of the weak (1,1) inequality; K2's reading,
    unproved). For the record job's errata.
22. **Ruling — two more named hypotheses from outside the backlog accepted**: `Row130M1` (FS-103's M1, χ_m⁰ ≤ k ⟹ χ_CP ≤ k) in FS106-EQ's χ_CP clause,
    the easy direction `chiM0_le_chiCP` formalized with none; and rows 78 and 88 (`hR78`, `hR88`, `hR88per`) in FS129-MA2-FALC-HOSTS (iii)–(iv), stated
    over any lattice or ring with those properties because de Grey's lattice and the three fields' rings are not in the library. Alternative weighed:
    hold those clauses until the objects and M1 are formalized. Why: the Closed rule's item 3 allows named hypotheses from outside the backlog, and the
    wider statements are what the kernel can check now. Confidence: high. **Stub to mint**: FS-103's M1 in Lean (the stationary limit of translates,
    Krylov–Bogolyubov, the Rajchman step), which discharges `Row130M1` — with K1's `Row134Base` stub (item 17 (b)).
23. **Question — does FS106-COMP's ⟸ direction need FS106-SUP's attainment clause?** (K2, § 4.2): SUPK, merged in place of SUP, drops attainment at
    general k (its not-claimed line); if QB § 2.7 reads it, the merged form lost a clause COMP needs. Routed to FS131-K2b, which reads QB § 2.7 and, if
    attainment is used, states it as carried content of SUP's merged row.
24. **Brief FS131-K2b, wave 2 finished** (`debruijn`, Opus; `data/fs131/briefs/FS131-K2b-wave2-finish.md`): the six example rows, the obligation-modeling
    pass over all 28, item 23's question, the handoff brought to 28 rows; continues K2's record on `fs131-w2`. Gated PASS after one fix (its quotation's
    source lives on the branch; the source line now names the worktree's copy). Source: this commit.
25. **FS131-K3 handed back at stage 2, harness ≈ 501k** (report on its branch, `.claude/worktrees/fs131-w3/data/fs131/reports/FS131-K3.md`; branch `fs131-w3` at `7d89b077`, commits checked): wave 3's
    foundation sorry-free and green (Plane/LocalMap, LocalMapExamples, CircleColouring; 45 records clean; two new example maps `halfPlane2`, `quadRing`;
    RINGBAND's two models inhabited); no statement defect, and no definitional choice changes a row (§ 2.2); the reading every row inherits — "a tile of
    colour c" read as the colour class `region c`, equal to the literal tile reading once `finite_tiles_near` is proved (§ 2.1). Stage 3 (the 20 rows'
    skeleton) is designed, not written: the record's section "For stage 3". Successor: FS131-K3b.
26. **Generalizations** (K3, "For stage 3"): FS116-N1-GERM-R in every valid map (its covering hypothesis idle); FS116-V4-TWIST without the covering
    hypothesis and "when p is a vertex"; FS116-N1-TWIST-D at any point; FS116-N1-GERM-S, -RING-Q-PRIME-S, FS129-SR2-TOUCHW, FS116-N1-QFREE4,
    FS116-N2-FIVERING at any k for their count of absent colours (the arguments read the count, not six); FS116-N1-ECHO with radius 2, essential boundary
    and density idle; FS129-OR1-WHOLE's R₂ clause for any arc whose inner side is one tile; FS116-S1-EXIT on the left derivative at `t_e` alone;
    FS116-Y4-FLANK's edge clause for any tiles bordering the two edges. For the record job's errata.
27. **Ruling — wave 3 takes the local-structure lemmas forward from wave 4** (K3's held decision): finitely many tiles meet a small disc about any point;
    the germ dichotomy; in a simple map each tile's cone at a point is one closed interval — as `Plane/LocalStructure` on `fs131-w3`. Alternative weighed:
    state the tile-literal conclusions only after wave 4, leaving FS116-V5-U1's last clause and FS129-OR1-WHOLE's covering clause unstated in wave 3. Why:
    the lemmas are the local foundation both waves read, wave 4 follows wave 3 in the order, and a row stated in two halves across waves is a seam a
    later reader can miss. Wave 4's planner is told its foundation list shrinks by these three. Confidence: high.
28. **Slip, the coordinator's** (found by K3): FS131-K3's brief named four rows merging into wave 3; there are six — FS112-SIX into FS116-N2-FIVERING and
    FS129-SR1-SIXQ, and FS116-RING-TRANSFER-C into FS116-N2-FIVERING and -N2-SIXRING were missed, because Keryx's script matched `merged_into` by exact
    equality and both have two targets. K3 carried both. Rule for later briefs: split `merged_into` on `;` (the check is now run that way, this commit's
    session). FS131-K2's brief was built by the same script; its wave's merges re-checked with the split: none missed.
29. **Wave 1 landed** (FS131-I1, report `data/fs131/reports/FS131-I1.md`; `main` fast-forwarded to `d59ffcdf`): 14 rows, 28 leaves proved, no statement
    changed, no axiom, no `native_decide`. **Announcement rule met, by Keryx's reading of the saved logs on the landed tree** (worktree `fs131-w1`):
    build 440/440, all targets up to date after the last merge (`build/gate/build/20261004T060308Z-1505660.log`); axioms 1,301 records — 1,285 clean, 11
    axiom-free, 5 declared purchases, no `sorryAx` (`build/gate/axioms/20261004T055957Z-1493361.log`); vacuity declarations=7624, refutations-skipped=319,
    sites 279, vacuous 0 (`build/gate/vacuity/20261004T060000Z-1493724.log`); self-test OK. Read-back receipt: `Plane.dist_lt_one_of_forall_dist_ne_one`
    (FS106-DIAM (i)) read against its row — a preconnected set with no unit pair has all distances < 1, the row's "diameter ≤ 1" strengthened (G2).
    Counts filed from I1's drafts: `CLAUDE.md` § Trust ledger and § The gate, `scripts/vacuity-baseline.txt`'s header; both digests read "match".
    Held (kernel), 14 rows: FS106-DIAM, FS106-TS-C, FS129-SR2-CLOSURE, FS111-V0-ID1, FS129-SR2-HULLSET, FS111-M-HULL2, FS111-M2-INT, FS111-M2-ZERO,
    FS116-V4-CHORD, FS129-SR1-TWOCIRC, FS121-D1-XCORNER, FS129-SA1-NOAFF-K (carrying FS84-S1-S1e), FS129-SA1-FALC-FAN, FS129-SA1-FALC-DICHO-K —
    each as stated in `plans/FS131-kernel-plan.md` § 6.2, on the standard three axioms. Ledger regrades wait for the milestone's filing.
30. **Tool defect — the vacuity scan does not track `AeColouring k` as a carrier** (I1; evidence `build/i1-vac-plant.log` in the worktree `fs131-w1`): a
    planted theorem over `(c : AeColouring 1)` raised no site, though `IsEmpty (AeColouring 1)` is in the evidence. No wave-1 statement is affected (every
    binder at a variable k); wave 2's statements over `AeColouring` and partial colourings would pass unchecked. Owed before wave 2 lands: extend
    `scripts/Vacuity.lean`. Job FS131-T1.
31. **I1's held items**: the scratch backups in the worktree's `build/` (`build/i1-backup`, `build/i1-*.log`; gitignored) — default: kept until the
    milestone's close, then removed with the worktree; the worktree `fs131-w1` itself — kept as the home of wave 1's gate logs until the close.
32. **Briefs FS131-K3b** (wave 3's skeleton, `debruijn`, Opus; `data/fs131/briefs/FS131-K3b-wave3-skeleton.md`) **and FS131-T1** (the vacuity carriers,
    `debruijn-implementer`, Sonnet, in the main tree; `data/fs131/briefs/FS131-T1-vacuity-carriers.md`), both gated PASS. **Slip, the coordinator's** (found
    by the gate, twice): each brief first quoted a hand-back message's text as if it were the report file's — the two differ — and named a worktree's file
    by a main-tree path. Fixed by copying each line from its file by script. Rule: quote a report from its file, never from the hand-back. Source: this commit.
33. **Generalization and sharpening — FS111-M3-BAND's first clause** (FS131-K2b, message 2026-10-04; one mind, the kernel decides): the row needs a block of
    diameter ≤ 1 and gives material at distance exactly 1 over the middle half of a flat side; the skeleton's `IsMUA.add_normal_mem_essSupport`
    (`Plane/CoverExamples` on `fs131-w2`) states it for any MUA set at any point `m` where the set fills the half-box behind `m` and its support misses the
    normal ray up to `δ` — then `m + e θ` lies in the support — so over the whole side (in HC, exactly the segment `σ_e`). The derivation's diameter bound
    (§ 1.5 fact 1) only kept `z` from excluding itself. No downstream change (BAND's consumer is HC's design). For the record job's errata.
34. **Item 23 settled — YES, a merged form lost a needed clause** (FS131-K2b, message 2026-10-04): FS106-COMP's ⟸ direction reads FS106-SUP's attainment —
    "If `µ₆(ε) = 1`, the attaining family covers the plane up to a null set, and I-D4's construction … is proper at every pair at distance in
    `(1 − ε, 1 + ε)`" (`plans/FS106-QB-verification.md` § 2.7, lines 206–208; Keryx's receipt: the lines read, the quotation matches across their wrap) —
    and FS129-SR2-SUPK, merged in SUP's place, drops attainment (its not-claimed line). Only the value-1 case is read, in the a.e.-cover sense. K2b carries
    it as SUP's merged content: `exists_bandNull_aeCover_of_mu_eq_one` in `Plane/Slack` (a leaf), at every k, by QB § 2.4's compactness argument with no
    stationarity (K2b's route, one mind); `forall_mu_six_lt_one_iff`'s statement unchanged. **Ruling: accepted.** Alternative weighed: restore SUP's full
    attainment clause at k = 6. Why: the value-1 form is what COMP reads, it holds at every k by an argument already on record, and the narrower clause is
    the stronger lemma. Confidence: medium-high (one mind for the every-k route; the kernel decides). Correction owed: an erratum on SUPK's not-claimed
    line (the value-1 a.e.-cover form holds at every k and COMP reads it), and on the merge line `data/fs129/l1/merges.csv` / `plans/FS129-SR2-audit.md`
    § 4.3 that put SUPK in SUP's place — for the record job.
35. **Item 30 done — FS131-T1** (report `data/fs131/reports/FS131-T1.md`, commit `49c3abb8`): the vacuity scan tracks `AeColouring` and `ArcMap.Valid`,
    `NonSiamese`, `Simple` (each structure's in-or-out call argued in `trackedProps`' docstring, with a four-step note for a later wave's carriers); a new
    filter skips a structure's machine-written API at site-making; `--self-test` plants 14 controls. Keryx's receipt: the main tree's scan log
    (`build/gate/vacuity/20261004T062713Z-1619534.log`) reads sites 280, generic 258, all else unchanged — one new site,
    `HadwigerNelson.Plane.chiM0_le :: AeColouring k`; the final self-test (`data/fs131/t1/selftest-3.log`) ends "every control fired". Filed from T1's drafts:
    `CLAUDE.md` § The gate and `scripts/vacuity-baseline.txt`'s header (sites 280, generic 258; both digests "match"), `LEAN.md` § The gate's control count
    ("fourteen"). Held: control 10 uses `AeColouring 3` — retarget it if the library ever refutes that instance.
36. **Tool defect — a theorem concluding `≠` or `¬` is skipped as a refutation** (T1): the reducing telescope turns the conclusion into `… → False`, so such a
    theorem makes no site, and over a concrete empty carrier it would be silent — wider than `LEAN.md` § The gate's law, which skips declarations concluding
    `False`. Pre-existing. Job FS131-T2 (`data/fs131/briefs/FS131-T2-vacuity-negations.md`, `debruijn-implementer`, Sonnet, main tree), gated PASS; before
    wave 2 lands.
37. **Statement defect — the merged sharp form of FS121-D4-FACE is false for gaps `g ≥ 2`** (FS131-K2b, message 2026-10-04): `Plane/Slack.face` and
    `face_densitySet` (on `fs131-w2`, from K2) carry FS121-V5-FACE-SHARP's hypothesis `2g − g² ≤ ρ²`, which every `ρ` satisfies once `g ≥ 2`
    (Keryx's receipt: `2g − g² ≤ 0` there); K2b's counterexample at `g = 3`, `ρ = 1/10` — a half-box at `x`, a small ball touching `y = x + e θ`, and the far
    box — has no unit pairs, both boxes in the set, and `y` in its support at distance 1 from `x`. The row's own form (`0 < 2g < ρ²`) forces `ρ ≤ 1/2` and
    `g < 1/8` and had no such case; the merge lost that bound. **Ruling: add `g < 1`** to `face` and `face_densitySet` (the derivation's regime: the far box
    between `x` and `x + e θ`). Alternative weighed: `g < 2`, which K2b believes true (one mind, unproved). Why: `g < 1` is the derivation's own regime,
    covers the row's original range, and is safe; `g < 2` would be a widening to argue later. `exists_face_fails` is unaffected. Confidence: high.
    Correction owed: an erratum on FS121-V5-FACE-SHARP (its hypothesis needs `g < 1`, or a proof for `1 ≤ g < 2`), for the record job.
38. **Wave 3's skeleton written** (FS131-K3b stage 5, `5d273f20` on `fs131-w3`, checked): six new modules, 96 `sorry` leaves, build 440/440, architecture
    check passing; the three geometric checks (FS116-N1-GERM-R's four intervals, FS116-Y4-FLANK, FS116-S1-EXIT) TRUE by computer algebra with planted faults
    firing (stage 4, `e8daebf9`); read-backs `plans/FS131-w3-kernel-plan.md` § 5.2 on the branch.
39. **Statement defect — a hidden assumption in FS116-V5-U1's last two clauses** (K3b): "the side cones hold two further colours" and "in a non-Siamese simple
    fragment, z has at least four colours" need `z` in the fragment's open set; K3b's counterexample is a valid, non-Siamese, simple map with `z = 0` outside
    its domain where 0 carries two colours and both side cones are empty (§ 5.3). The formal statements carry `hz : z ∈ F.dom`. **Ruling: accepted** — the
    derivation's setting always has the vertex in the domain, so no consumer changes. Alternative: none live (the clause is false without it). Confidence:
    high. Correction owed: an erratum on FS116-V5-U1 ("z in the fragment"), for the record job.
40. **Generalizations** (K3b, § 5.1): FS129-OR1-WHOLE's R₂ clause pointwise (only that `p + e(θ)` is a closure point of `T ∩ B(p, 1)` for a tile `T` of colour
    c; the arc form a corollary); FS129-SR1-SIXQ's (Q) clause at every `k ≥ 4`; RINGBAND's map bridge (FS110-N2-RING's setting) at every k, needing only a ring
    with no arc of Γ and a map `Fin k → ZMod 3` injective on the colours absent at p; a shorter route for FS116-Y4-FLANK's edge clause (radius below 1 gives a
    point inside the other unit disc; both radii 1 is TWOCIRC at equal turns). Re-pricing: OR1-WHOLE's covering clause needs only "every point of the domain
    lies in the closure of a tile", not `finite_tiles_near`; the local-structure work concentrates in one hard statement, the sector structure at a point.
41. **FS131-K3b done** (report on its branch, `.claude/worktrees/fs131-w3/data/fs131/reports/FS131-K3b.md`; `fs131-w3` at `05cb0a3e`): wave 3 stated in full —
    20 rows and the 6 merged into them, plus ruling 27's local-structure lemmas; 96 `sorry` declarations; leaf plans, an obligation-modeling pass (three
    engines; eight hard leaves) and the implementer's handoff (§ 7). Predictions scored (K3's § 1.4): expectation 1 (a row whose truth turns on the ring
    vocabulary's reading, p = 0.5) not met; expectation 2 (covering hypotheses idle, counts generalizable, p = 0.8) met. Its question — wave 3's vacuity
    carriers — goes to the implementer under T1's procedure.
42. **Brief FS131-I3, wave 3's implementer** (`debruijn-implementer`, Sonnet; `data/fs131/briefs/FS131-I3-wave3.md`), gated PASS: the vacuity step last,
    after FS131-T2's commit is on `main` (both edit `scripts/Vacuity.lean`). Source: this commit.
43. **Item 36 done — FS131-T2** (report `data/fs131/reports/FS131-T2.md`, commit `66f679a6`): a declaration is skipped as a refutation only when its stated
    conclusion is `False`; a stated `≠` or `¬ P` is audited (its own unfolded binder dropped, with the reason in `isRefutation`'s docstring). Keryx's receipt:
    the main tree's scan (`build/gate/vacuity/latest`) reads refutations-skipped 45, sites 357, generic 335, vacuous 0, unknown 2; T2's last self-test ends
    "every control fired" (20 controls). 274 declarations stopped being skipped; 55 of them make 77 new sites, all GENERIC (`data/fs131/t2/site-diff.txt`).
    Filed from T2's drafts: `CLAUDE.md` § The gate and `scripts/vacuity-baseline.txt`'s header (both digests "match"); `LEAN.md` § The gate's law sentence (T2's
    clause, verbatim) and control count ("twenty"). T2's note that `CLAUDE.md` still held 7438/313/279 was its launch snapshot (memory: subagents see the
    parent's loaded `CLAUDE.md`); the file on disk held T1's counts.
44. **FS131-K2b done** (report on its branch, `.claude/worktrees/fs131-w2/data/fs131/reports/FS131-K2b.md`; `fs131-w2` at `41c66271`, commits checked): all 28
    rows of wave 2 stated; 71 `sorry` leaves; build 443/443 with only `sorry` warnings; the six examples defined by formula with spec examples; the literal
    second clause of FS111-M-COVER-SC refuted on R7 in the skeleton (`not_forall_semiconcaveWith_one`); obligation pass (13 hard, 43 moderate, 15 easy; three
    to five implementer sessions); handoff § 10. Further generalizations (§ 7.3): HC's component clause at every closed null Z; IRREG for every closed nowhere
    dense Z of positive length; DISC7's lens clause for every two classes. Corrections owed (record job): FS111-M3-BAND's § 1.5 sentence on horn points holds
    only at λ = 1 (`band_excludes_horn` states the window); SUPK's not-claimed line (item 34); FACE's sharp entry (item 37). FACE at `g < 2` recorded as a
    reading with its killing test, not stated (per item 37).
45. **Brief FS131-I2, wave 2's implementer** (`debruijn-implementer`, Sonnet; `data/fs131/briefs/FS131-I2-wave2.md`), gated PASS: merge `main` first (the branch
    sits on wave 1's skeleton); wave 2's carriers under T1's procedure; whichever of waves 2 and 3 lands second merges the other's carrier entries. FS131-I3's
    brief amended the same day (T2 landed; the shared list). Source: this commit.
46. **Brief FS131-K4, wave 4's planner** (`debruijn`, Opus; `data/fs131/briefs/FS131-K4-wave4.md`), gated PASS; worktree `.claude/worktrees/fs131-w4` made by
    Keryx with the recipe, branched at wave 3's skeleton `05cb0a3e` (wave 4's row edges reach only waves 1 and 4, checked by script; its foundation reads
    wave 3's vocabulary). The brief names the pattern of waves 2–3 (each planner reached its line; plan for a successor). Source: this commit.
47. **The day's search deferred, not dropped** (`plans/SEARCH-QUEUE.md` row 6 open; Kooshi's rule: once a day, outside the milestone loop): the three slots go
    to waves 2 and 3's implementers and wave 4's planner, and two 40 GiB builds already fill most of the slot's 90 GiB. Default: the Searcher launches today in
    the first slot an implementer frees, with its memory sized against the builds then running.
48. **Statement defect in wave 2's skeleton — `vesica_apex_exact`** (FS131-I2, message 2026-10-04; `Plane/CoverExamples`, FS111-M3-BAND's third clause, exact
    half): stated for every `h < √3/2`, it is false for `h ≤ −2` — at `h = −2` the apex is `2i`, and every `z` with `z.im < 1` has `dist z (2i) ≥ 2 − z.im > 1`
    (Keryx's receipt: that inequality). The row speaks of a depth, so `h ≥ 0` was meant; a formalization slip of the skeleton, not a defect of the derivation.
    **Ruling: add `(h0 : 0 ≤ h)`.** Alternative weighed: `−2 < h`, the widest form I2 believes true (one mind). Why: the row's own reading, the consumers'
    range, and no proof owed beyond the row; the wider form, if wanted, is a separate lemma the implementer may add. Confidence: high. No erratum owed on the
    derivation.
49. **FS131-I2 handed back at stage 3, harness ≈ 357k by the task count (its own ≈ 400k)** (report on its branch,
    `.claude/worktrees/fs131-w2/data/fs131/reports/FS131-I2.md`; `fs131-w2` at `0e5febba`, checked): 23 of 71 leaves proved; `main` merged in; real build 443/443
    with only `sorry` warnings; axioms not audited (gate not run); `vesica_apex_exact` takes `0 ≤ h` per item 48, proved. Shared children sorry-free in
    `Plane/Cover` (a general measure-exhaustion lemma `exists_ae_maximal`, among others) and `Plane/Suprema`. Generalizations: `UnitPairsNull.congr_ae` and
    `volume_diff_essSupport` need no measurability. Slip: none of substance. 48 leaves left (13 hard untouched). Successor: FS131-I2b.
50. **FS131-I3 handed back at stage 1, harness ≈ 436k** (report on its branch, `.claude/worktrees/fs131-w3/data/fs131/reports/FS131-I3.md`; `fs131-w3` at
    `8a850e85`, checked): 55 of 96 leaves proved, no statement changed; rows with every clause sorry-free — FS116-V5-NE1, -V4-DICHOTOMY, -V4-MEET,
    -S1-CLUSTER, FS129-OR1-WHOLE, FS116-V4-TWIST, -N1-TWIST-D, -N1-GERM-R, -N1-ECHO (scratch audit only; the gate's log is still to be read); `Plane/Tiles`
    complete; engines 1 and 2 built, engine 3 (`localSectors`) not started. A real build of its last code commit was left running under the slot
    (`data/fs131/i3/build-stage1.log` on the branch); I3 may wake to read it. Re-pricing: FS116-N1-GERM-R, priced hard, came out as two half-plane lemmas
    (the calibration of `CLAUDE.md` § What compute actually helps). 41 leaves left. Successor FS131-I3b, launched once I3's build has finished and I3 has
    stopped (one writer per branch). Slip (I3's): one commit message (`b45ef041`) lacks the attribution lines.
51. **Brief SEARCH-2026-10-04** (the Searcher, Opus; `data/search/briefs/SEARCH-2026-10-04.md`), gated PASS: row 6 only (C-T-BIKE), the Searcher's call whether to
    run it, one hour, at most 8 GiB per run. Launched in the slot I2 freed, per item 47's default. Source: this commit.
52. **FS131-K4 handed back at stage 5 (partial), harness ≈ 389k** (report on its branch, `.claude/worktrees/fs131-w4/data/fs131/reports/FS131-K4.md`; `fs131-w4` at
    `d0c56af0`, checked): wave 4's foundation `Plane/ValidMap/Basic` sorry-free (frames with exact curvature, horns, sectors and degree counted with `encard`,
    contacts and their kinds, shadows, MERGE/SHAVE preconditions, `Terminal`, `IsStuck`, Condition 5, `𝓜_K`); 9 of 29 rows stated (25 `sorry` theorems); no
    statement defect — the cusp reading the opening plan expected does not arise (a cusp horn is one sector). Generalizations: FS110-N3-CONF and -W-MERGE with
    unit arcs allowed; FS110-N3-DEG in a non-strict form with curvatures in [−1, 1], the strict form under Condition 5; FS110-N4-SHADOW's concentric clause about
    a tangent arc's far side alone; FS112-LOCK and the N2-SIGN lemma for whole colour classes. Layout: FS112-N3-NOBOTH sits in `Plane/ValidMap/UnitArc`. Slip
    (K4's): the obligation-modeling pass not run — owed by the successor over all rows. FS114-L60-WALK's clause L60-D5 carried to wave 5 with FS112-N3-BASE
    (ruling R8 covers the rest). Successor: FS131-K4b.
53. **Ruling — FS110-N4-STUCK assumes NB-4's conclusion** (at most three colours at a point), the class its argument reads, as K4 stated it; FS110-NB-4 is not a
    backlog row. Alternative weighed: add FS110-NB-4 to the backlog now as a supporting lemma. Why: N4-STUCK's own statement needs only the conclusion; a
    consumer that needs N4-STUCK without the hypothesis (a formal FS110-CLOSURE) formalizes NB-4 beside it, as FS111-M-REDUCE-I was (item 8). Wave 5's planner
    is told. Confidence: high.
54. **Ruling — Woodall's chain is its own job, FS131-W**: FS106-WO, FS106-TW and FS106-AE-MAP6 (Woodall's maps-need-six almost everywhere, with Townsend's
    lemma; their mathematics ours, ruling R9) are planned and implemented on their own branch, from wave 4's skeleton once FS106-L and FS106-TS-T are stated,
    and land before wave 9 (their only consumers outside the chain: FS111-C-SIX-M, FS111-M2-REDUCE-C, FS129-OR1-TOP5, all wave 9; checked by script). They keep
    wave 4 in the table; wave 4 lands without them. Alternative weighed: inside wave 4 (K4's question). Why: the proof is a whole theorem, wave 4's planning
    already outruns one context, and nothing before wave 9 waits on it. Confidence: high.
55. **Brief FS131-I2b, wave 2's second implementer** (`debruijn-implementer`, Sonnet; `data/fs131/briefs/FS131-I2b-wave2.md`), gated PASS; continues I2's record
    on `fs131-w2` from its stage 3 (48 leaves). Launched in the slot K4 freed. Queued next, as slots free: FS131-I3b (once I3 stops) and FS131-K4b. Source: this
    commit.
56. **Statement gap — FS111-M-COVER-SC's curvature clause, as skeletoned** (FS131-I2b, message 2026-10-04): `IsMaximalCover.curvatureLeOne` and
    `semiconcaveWith` (`Plane/MaximalCover`) take `IsLowerGraphOf` on the class's essential support, but the argument (`plans/FS111-M-regularity.md` § 3.4,
    lines 380–383: "each path-connected piece `P` of `F̃_a` near `x`") applies the enclosing-or-exterior dichotomy to pieces of the density set `F̃_a`, and for a
    general maximal-cover class the interior of the support need not lie in the density set (it does for regular classes). Not shown false; not derivable as
    stated. **Ruling: state `IsLowerGraphOf` on the density set** (the region below the graph lies in `densitySet (C a)`) — the class the argument reads (G92).
    Alternative weighed: add `IsRegularMUA (C a)` (I2b's other proposal). Why: the density-set form keeps the clause for every maximal cover, which is what the
    row and its derivation claim, and moves the hypothesis to exactly where the argument reads it; R7's use (`r7_lowerGraph`) then shows the region below its
    arc lies in its class's density set, which holds for its classes (closed sets, the region in the interior). Confidence: medium-high. The record job notes
    the reading under FS111-M-COVER-SC's erratum (item 18).
57. **Statement defect in wave 2's skeleton — `CurvatureLeOne` tests from the wrong side** (FS131-I2b, message 2026-10-04): the definition quantifies over every
    C² `φ` touching `u` from above and concludes `φ'' ≤ (1 + φ'²)^(3/2)` — false for every `u`, since `φ = u + N(s − s₀)²` touches from above with `φ''` unbounded
    in `N` (Keryx's receipt: that one line); concretely false on R7's lower arc, where `u'' = (1 + u'²)^(3/2)` exactly. The viscosity form of "curvature at most
    1" tests from below: `φ ≤ u` near `s₀`, `φ(s₀) = u(s₀)`, then `φ ≤ u ≤ ψ` with `ψ` the supporting unit arc gives `φ'' ≤ ψ'' ≤` the bound. A formalization slip
    in the skeleton's encoding of item 19's ruling (whose words — "touched from above at each point by a unit arc … in the viscosity sense" — name the supporting
    arc, not the test side). **Ruling: flip `u s ≤ φ s` to `φ s ≤ u s` in `CurvatureLeOne`**; `semiconcaveWith` re-derived from the corrected form. Alternative:
    none live. Confidence: high. No erratum on the derivation beyond item 18's.
58. **FS131-I2b handed back at stage 4, harness ≈ 328k** (report on its branch; `fs131-w2` at `23c92109`, checked): five more leaves — `twoCircle_preimage_null`,
    `falconer_lemma1` (Falconer's Lemma 1, measurable form), `CPColouring.exists_discrete_forcedSet`, `chromaticNumber_plane_le_chiM0` (N-EASY: χ(ℝ²) ≤ χ_m⁰(ℝ²),
    no MR), `IsMaximalCover.enclosing_or_exterior` (FS111-M-COVER-SC's first clause, without `x ∈ closure P`) — 28 of 71; build 443/443, only `sorry` warnings;
    items 56 and 57 applied. Open in `curvatureLeOne`: the equator configuration (contact at the exterior disc's equator) gives no supporting arc — routed to
    the successor with the coordinator's labelled inference (the lower-test set may be empty there) and an instruction to message if the clause is false.
    Re-pricing: two leaves priced hard came in moderate; about 40k tokens a leaf. 43 left. Successor FS131-I2c (`data/fs131/briefs/FS131-I2c-wave2.md`).
59. **FS131-I3 stopped** (its background build finished green: `data/fs131/i3/build-stage1.log` on `fs131-w3`, 440/440, "build: OK"; no process in its worktree;
    no commit since `8a850e85`). Successor FS131-I3b (`data/fs131/briefs/FS131-I3b-wave3.md`), 41 leaves. Both briefs gated PASS; launched together, beside the
    day's Searcher. FS131-K4b (wave 4's second planner) follows when the Searcher's slot frees. Source: this commit.
60. **The day's search done — SEARCH-2026-10-04** (report `data/search/2026-10-04/report.md`; record `plans/SEARCH-2026-10-04.md`): queue row 6 (C-T-BIKE)
    answered yes at nine named `d` [cert] — FS106-TS's one-offset reduction on an open window about `φ ≡ 0` (`d = 4/3, 3/2, 30/17, 19/10, 99/50`; measured for
    `d ∈ ((√13 − 1)/2, 2)`), FS-107's shared-colour ansatz only on its tangent curve (`d = 30/17, 24/13, 48/25, 80/41`; measured only for `d > √3`); below
    `(√13 − 1)/2` no two-coloured circle works on the grid (open). Keryx's receipt: `tools/search_20261004_check.py` re-run — ACCEPT on
    `fs107-tangent-d30_17.json` and `ts1-phi0-d19_10.json`, REJECT on the expected-failing `fs107-tangent-d8_5.json` and on the planted
    `plant-fs107-shift.json`. Filed verbatim from the record § 4.2: the queue's row-6 fate cell, and two "What is held" bullets of
    `plans/STUB-bicycle-windings.md` (one added, one replaced). **Not filed**: the stub's G21 line under "Provisional bearings" — Poros's section; for its next
    re-rank. Items for FS-130 if it opens: the Searcher's three questions for Ephodos (§ 4.1); the queue row's wording defect (the row's object is FS107-R
    § 3.6's special case, not FS106-TS's reduction — both run); prior-art debt (arc colourings of two unit circles not searched in print). The Searcher's
    overrun of its hand-back line is not a slip (agent budgets are guidance). No continuation proposed (FS-130 is ranked 18, bearing "none known").
61. **Statement defect in wave 3's skeleton — FS129-SR1-RINGBAND (iv)'s second conjunct** (FS131-I3b, message 2026-10-04; `CircleColouring.ringband_iv`,
    `Plane/RingBand`): "(no π/3-invariance of `S`) → `W = 6M + 3`" is false because the structure's `S` need only contain the true change points: I3b's
    counterexample adds non-change points `0.1 + 2πk` to the hexagon colouring's `S`, which keeps every structure field, breaks π/3-invariance, and leaves
    `W(π/6) = 2`. The row means the genuine change set; a formalization slip of the skeleton (the structure's `S` a superset), not a defect of the derivation.
    **Ruling: add `∀ x ∈ C.S, ¬ ∃ v, C.LeftVal x v ∧ C.RightVal x v` (every point of `S` a genuine change) to the second conjunct.** Alternative weighed: redefine
    `S` as exactly the change set in `Plane/CircleColouring` — a definition the implementer may not change and many statements use. Why: the minimal hypothesis
    that restores the row's meaning, where it is read. Confidence: high. No erratum owed on the derivation.
62. **Brief FS131-K4b, wave 4's second planner** (`debruijn`, Opus; `data/fs131/briefs/FS131-K4b-wave4.md`), gated PASS: K4's § 5.2 less Woodall's chain (17 items),
    FS106-L and FS106-TS-T first (Woodall's job branches from them), the obligation-modeling pass owed by K4, the handoff. Launched in the slot the Searcher
    freed. Source: this commit.
63. **Statement defect in wave 2's skeleton — `exists_not_uniform_kept` false for `η ≥ 1`** (FS131-I2c, message 2026-10-04; `Plane/Slack`): `KeptAt A η ε x` reads
    `ofReal (1 − η) · volume (ball x ρ) ≤ volume (ball x ρ ∩ densitySet A)`, whose left side is 0 once `η ≥ 1`, so every point is kept and the set of non-kept
    points is empty (Keryx's receipt: `ofReal` of a non-positive real is 0). The row's `η` is a fraction; a skeleton slip. **Ruling: add `(hη : η < 1)`.**
    Alternative: none live. Confidence: high. I2c believes the `η < 1` form true (k depending on η, a fine-scale zigzag; unproved); if it stalls there, that
    is a question for Ephodos, not a quiet change.
64. **Route note, not a defect — `sqrt3_local`** (I2c; `Arith/Dyadic`): the plan's route (Newton's lemma, then `sqrt3_local_of_congr`) fails, because
    `sqrt3_local_of_congr` takes `s² − 3 ∈ (4)·P` as a global ideal of `𝓞F` and a local square at P gives the congruence only at P; the statement is not in
    doubt. The implementer builds a P-local Kummer–Dedekind lemma (`s² − 3 ∈ P^(2e+1)`) as a child — formalization, its own to decide; mathematics beyond that
    comes back as a question.
65. **FS131-K4b stage 2** (`fs131-w4` at `f2a09351`): FS106-L and FS106-TS-T stated in `Plane/SVMap`, over open colour classes (region-only); build 441/441, only
    `sorry` warnings; read-backs in the record § 7. **FS131-W may branch from `f2a09351`.** Added to the foundation: `ArcMap.Condition6` (spec example proved);
    the inhabitant of "a valid map of the plane" is `sevenBrickMap`, M36's brick colouring read as an arc map.
66. **Ruling — Lebesgue's covering theorem for the square** (K4b's OUT-LEB; TS-T's first clause rests on it; Mathlib has neither it nor Brouwer nor Sperner):
    **its own planner-and-implementer job, FS131-LEB**, to formalize it (by Sperner's lemma or the route its planner chooses), with the skeleton's
    `lebesgue_covering_square` a `sorry`ed theorem meanwhile; an `axiom` with the four items of `LEAN.md` § Assumptions only if FS131-LEB has not landed when wave
    4's gate is otherwise green. Alternative weighed: the axiom now. Why: the theorem is published and classical (so an axiom is allowed), but it is a gap in
    Mathlib that every later use of plane topology here will want, and the four items need a source read that is not yet held. Confidence: high. **Prior-art
    / bibliography debt**: K4b cites Hurewicz–Wallman, *Dimension Theory*, Thm IV 2 (recalled, not read; not in `BIBLIOGRAPHY.md`, not in `~/source/library/`).
    FS131-LEB's planner reads a source (that book or a modern one) and proposes the row.
67. **Reading with a counterexample — FS106-L holds only for a change point in the open set** (K4b's L-READ; record § 7.3, adversary `not_lemmaL_of_not_mem`): at a
    frontier point a two-cone example refutes it; the row's words ("of the set") already place `b` in the set, so no defect of the row, but K4's draft form (b in
    `cl A ∩ cl B`) was false. FS131-W must apply (L) only at points of the open set (Townsend's annulus; Woodall's step 4) — for W's brief.
68. **Completeness, same shape as item 53** (K4b's F-A5): TS-T's Condition-5 clause rests on S–V Lemma 2 almost everywhere (not a backlog row); stated over its
    conclusion (at most three colours at every point), the class its argument reads. No backlog consumer reads the clause. Accepted. Generalization (G-L):
    lemma (L) needs no disjointness of the two colour classes.
69. **Ruling — FS112-C-DOUBLE moves from wave 4 to wave 5** (K4b, message 2026-10-04): its proof is "a sketch over FS112-Y3-END-NEEDS's levels with n reversed and
    FS112-N2-TERM" (`plans/FS112-derivation.md` line 237), and its (Q) conclusion is read in N2-TERM's terminal map `M*`; N2-TERM is a wave-5 row, and C-DOUBLE's
    only consumer, FS112-C-ENDS, is in wave 5 too (checked by script). The table missed the edge C-DOUBLE → N2-TERM (an index defect of the kind item 158 of
    FS-129's inventory names). **FS112-Y3-END-NEEDS (its corrected form) is formalized in wave 5 as a supporting lemma** beside C-DOUBLE, since C-DOUBLE as stated
    needs its proof (the pattern of items 8 and 53); wave 5's planner settles whether C-DOUBLE's "terminal valid map" means N2-TERM's `M*` or wave 4's `Terminal`.
    Alternative weighed: keep C-DOUBLE in wave 4 with Y3-END-NEEDS and N2-TERM's conclusion as named hypotheses. Why: N2-TERM is ours and lands in wave 5, so a
    hypothesis there would only be discharged later; moving the row puts it beside what it reads. K4b is the table's one writer for this change (brief
    amended). Confidence: high.
70. **FS131-I2c handed back at stage 5, harness ≈ 316k** (report on its branch; `fs131-w2` at `04c44d29`, checked): five more leaves — `disc7_lens`,
    `nonempty_cpColouring_nine` (a CP colouring with nine colours: `sq9` under a uniform random translation of the torus), and three derived closures resting on
    open leaves — 33 of 71; build 443/443, only `sorry` warnings; item 63 applied. **The equator configuration of `curvatureLeOne` is vacuous in both cases**
    (no defect; Keryx's inference of item 58 borne out). Found: `exists_tight` and `exists_bandNull_aeCover_of_mu_eq_one` need continuity in r of the
    three-dimensional unit-pair mass. Costs: 20k–90k tokens a leaf. 38 left.
71. **Order of launches changed** (Keryx): the slot I2c freed goes to wave 2's fourth implementer, FS131-I2d (`data/fs131/briefs/FS131-I2d-wave2.md`, gated PASS),
    ahead of FS131-W and FS131-LEB. Why: two implementers and one planner keep the pipeline balanced, and a landed wave yields held results and tests the
    landing (the vacuity carriers' merge) sooner; W is needed only by wave 9, LEB by wave 4's gate, which is not near. W and LEB take the next planner slots
    (when FS131-K4b hands back). Confidence: medium. Source: this commit.
72. **Item 56's encoding included the graph itself** (FS131-I2d, message 2026-10-04): `IsLowerGraphOf`'s first clause quantifies over `u s − δ < t ≤ u s`, so it puts
    points of the graph in the density set; a point on a smooth arc has density 1/2 in either side, so `r7_lowerGraph` is false as stated (I2d's counterexample:
    `s = 3/20`, `t = u s`, `z₀ = e(π/6)`, `θ = 2π/3`). Item 56 ruled "the region below the graph"; the encoding took the closed region. **Ruling: make the first
    clause strict, `t < u s`** — the open region below the graph, the pieces `P` of `F̃_a` the derivation's dichotomy reads (with `x ∈ cl P`). `curvatureLeOne` and
    `semiconcaveWith` are proved with the strict form. Alternative: none live. Confidence: high. Slip, shared: the coordinator's ruling did not say "open".
73. **FS131-I3b handed back at stage 2, harness ≈ 414k** (report on its branch; `fs131-w3` at `3012c049`, checked): **FS129-SR1-RINGBAND proved in full** — twelve
    leaves, axioms exactly the standard three in a real audit log (Keryx's receipt: `ringband_iv`, `W_mod_six`, `exists_pair_of_abs_W_le_two` read from
    `build/gate/axioms/20261004T083504Z-2241407.log` in the worktree); item 61 applied; SixFragment's easy half; build 440/440, only `sorry` warnings. Its
    `scripts/Axioms.lean` had lost the `=== PURCHASED ===` banner on the branch — restored (recheck at the merge). Generalization: in (iv)/(v), one good θ with
    `h ≠ 0` forces equal jumps at x and x + 60° (`J_eq_of_rho`, `inv_of_J_eq`). 21 left; successor FS131-I3c (`data/fs131/briefs/FS131-I3c-wave3.md`, gated PASS).
74. **FS131-K4b handed back at stage 3 (partial), harness ≈ 472k** (report on its branch; `fs131-w4` at `daac5779`, checked): six more rows stated — FS106-L
    (`lemmaL`, b in W), FS106-TS-T (three clauses, region-only and for arc maps), FS112-BOWTIE (an exact fragment, the wave's inhabitant of `IsHorn`,
    `IsStuck`, `TerminalOn`; the implementer checks each tile against `tools/fs112_yb3_frags.py`), FS112-N3-PAIRS, -N3-FAIL, -N3-ANTI, -N3-END; C-DOUBLE moved
    (`4ebc6b3c` on main, checker green). No defect. Generalization G-PAIRS: N3-PAIRS (i)–(ii) for fragments covering `B̄(u_i, 1)`. Narrowings recorded: N3-END's
    "the chain is the single vertex" not stated (needs wave 5's stuck-chain vocabulary; no consumer in waves 4–5); N3-FAIL's "exactly" read as "only" plus
    nonemptiness. Proposed bibliography row: Hurewicz–Wallman, *Dimension Theory* (Princeton 1941), Thm IV 2, and Lebesgue (Math. Ann. 70, 1911) — not held,
    recalled not read; for FS131-LEB's planner to read and confirm before filing. Left: nine unit-arc items, the obligation-modeling pass, the handoff.
75. **Order of planner launches** (Keryx): FS131-K4c (wave 4's plan finished) before FS131-W and FS131-LEB. Why: wave 4's implementer and wave 5's planner both wait
    on wave 4's full skeleton; W and LEB are needed only at wave 9 and at wave 4's gate. Supersedes item 71's "W and LEB take the next planner slots". Confidence:
    medium-high. Source: this commit.
76. **Brief FS131-K4c, wave 4's third planner** (`debruijn`, Opus; `data/fs131/briefs/FS131-K4c-wave4.md`), gated PASS: the nine unit-arc items of K4b's Stage 9,
    the domain- and obligation-modeling passes over the whole wave (neither K4 nor K4b ran them over its additions), every leaf's plan, the handoff. Source: this
    commit.
77. **Skeleton defect fixed in-wave by its planner — K4's `exists_shave`** (FS131-K4c, message 2026-10-04; `Plane/ValidMap/Contact`): it concluded `F'.Condition5` for
    any horn curvatures, false when `κ₂ > 1` and the clear split curvature is σ = 1 (the new boundary is then an arc of ω(N), a unit arc). Fixed by
    `−1 ≤ κ₁` and `κ₂ ≤ 1`, which every consumer already has (`woodallCone` gives [−1, 1], `stuck_structure` gives (−1, 1)); σ = ±1 then puts the split on
    the horn's own arc (FS112-WALK row 7). No other statement read the old form. Accepted (a planner's correction of its own wave's skeleton, reported at once).
78. **Generalization G-MOVES-UA** (K4c): the three moves (merge, ray-merge, shave) hold with unit arcs; `exists_shave` and `exists_rayMerge` drop Condition 5
    (ray-merge's bounds become `−1 ≤ κ₁`, `κ₄ ≤ 1`, FS112-WALK W3), and all three conclude `F'.RingArcsWithin F` — no new unit arc, a new foundation definition
    (every point on an arc of Γ on some ω(p) in F' was on one in F, same centre) replacing the vacuous-with-unit-arcs `F.Condition5 → F'.Condition5`. **For wave
    5's planner**: FS112-N2-RED and -N2-TERM read the moves in this form ("creating no unit arc"). Also new: `AgreesOff F' F U` (the moves' shared clause, meaning
    unchanged) and `IsCoveringPair` in the union sense.
79. **Ruling — FS112-N2-FLANK-Q stays in wave 4 over a named hypothesis, discharged in wave 5** (K4c, message 2026-10-04): its proof (`plans/FS112-N-proof.md` stage
    N2-4) reads the bends' terminality — FS112-N2-RED's conclusion, FS112-N2-TERM's clause 1, a wave-5 row; the table's edge is missing (as for C-DOUBLE, item 69).
    The opposite edge (N2-TERM's clause 3 cites FLANK-Q) makes no cycle, since N2-RED does not read FLANK-Q. K4c's statements `flankQ_upper`, `flankQ_lower`,
    `flankQ_both` take `hQR` (every arc of Γ on ω(N) with constant sides is (Q) or (R2)) and prove the row's content. **Wave 5's planner owes the discharged
    form**: the unconditional FLANK-Q, from N2-TERM's clause 1 — FLANK-Q is held only when that lands (the Closed rule's item 3 allows a backlog row as a
    hypothesis only until its own row lands). Alternative weighed: move FLANK-Q to wave 5 (item 69's way). Why: everything else it reads is in wave 4, and the
    conditional form is what N2-TERM's clause 3 needs anyway. Confidence: high.
80. **Generalizations** (K4c): U1's shadow clause needs no validity and holds for the outer class's points near the arc (G-U1); FLANK's shadow needs no map — any
    preconnected set inside `B(v, 1)` with N in its closure shadows every point near v of a horn with upper curvature ≤ 1, the whole horn
    (`inType_shadows_horn`), and "SHAVE's criterion is incomplete" is witnessed by the bowtie (`flank_incomplete_bowtie`) (G-FLANK); FS112-A4SIX at every k, "four
    colours" read as "exactly two colours absent" (G-A4SIX); the bends in one shape (`bend_away`, N2-AWAY with N2-TAN; FS112-BEND's two cases special cases).
    Reading (no defect): L60-EQ's "each end is a vertex carrying a third tile" as some tile approaching each end from the open half-plane facing away from the
    other end. All nine items stated (K4c's message; commit to follow).
81. **Wave 4 fully stated** (K4c, `fs131-w4` at `df041d0a`, checked): every row but Woodall's three (FS131-W) and C-DOUBLE (wave 5); build green, only `sorry`
    warnings; 97 declarations listed, 0 missing; architecture check passing. Leaf plans, the obligation-modeling pass and the handoff follow. FS131-W may branch
    from `df041d0a` (it holds FS106-L and FS106-TS-T, stated at `f2a09351`).
82. **FS131-I2d handed back at stage 6, harness ≈ 294k** (report on its branch; `fs131-w2` at `3bd6cf52`, checked; build log ends "Build completed successfully"):
    four leaves closed and one split — `r7_not_bandNull`, `r7_lowerGraph` (item 72 applied), **`IsMaximalCover.curvatureLeOne` and `semiconcaveWith`** (FS111-M-COVER-SC's
    corrected second clause and its corollary; the equator configuration excluded by first-order touching), `sq9_tight` — 37 of 71, 34 `sorry` left, mostly
    hard. I2d stopped early, judging no remaining leaf would close in its budget (the second implementer in a row to do so).
83. **Ruling — a re-planning job before a fifth implementer on wave 2**: FS131-K2c (`debruijn`, Opus; `data/fs131/briefs/FS131-K2c-wave2-replan.md`, gated PASS)
    decomposes the 34 leaves into children an implementer can close, confirms routes with `#check`, decides each outside theorem, and writes the handoff.
    Alternative weighed: a fifth Sonnet implementer on the same plan. Why: two implementers stopped early on the same hard leaves; the gap is in the plan's
    granularity, which is a planner's work, not more implementer attempts. Confidence: medium-high. Launched in the slot I2d freed; FS131-W and FS131-LEB wait for
    the next planner slot after FS131-K4c. Source: this commit.
84. **FS131-K4c done, harness ≈ 465k** (report on its branch; `fs131-w4` at `f620977c`, checked): wave 4 fully planned — the nine unit-arc items stated (fragments
    `l60Frag`, `isoFrag`), both modeling passes over the whole wave, a plan per leaf (86 `sorry` leaves; seven engines; about 35 easy, 35 moderate, 16 hard; K4's
    `l60_le` route corrected to interior points), the implementer's handoff (§ 14), and the wave-5 notes (§ 14.5: FLANK-Q's discharge, the moves' new form,
    C-DOUBLE's reading, N3-END's chain clause, L60-WALK, the outside-backlog hypotheses). Recommended wave-4 vacuity carriers in § 14.3 (the implementer records
    the call). Readings recorded: L60-EQ's third tile; the bends as "the arc is removed as an arc of ω(P)". Record slip (K4c's own): Stage 9 cites Lebesgue's
    ruling as item 65; it is 66.
85. **Brief FS131-W, Woodall's chain** (`debruijn`, Opus; `data/fs131/briefs/FS131-W-woodall.md`, gated PASS, the three rows quoted from the backlog): worktree
    `.claude/worktrees/fs131-ww` made by Keryx with the recipe, branched at wave 4's full skeleton `f620977c`. Launched in the slot K4c freed (items 75, 83).
    Queued next: FS131-I4 (wave 4's implementer) and FS131-LEB, as slots free. Source: this commit.
86. **Statement defect — FS121-V5-FACE-SHARP's failure half, `exists_face_fails`, false as stated** (FS131-K2c, message 2026-10-04; `Plane/Slack` at `3bd6cf52`): the
    entry claims failure "whenever ρ² < 2g − g²", but (1) for ρ ≥ 1/2 the far box itself has unit pairs of positive measure (no class holds it a.e.), and (2) for
    g² + ρ² > 1 the unit circles about the half-box's points cross the far box (K2c's example g = 19/20, ρ = 9/20; Keryx's receipt: 0.96² + 0.28² = 1.0000 and
    g² + ρ² = 1.105). **Ruling: add `2ρ < 1` and `g² + ρ² < 1`** — the regime the derivation reads (V5's own example g = 1/10, ρ = 2/5 lies in it; K2b's note: null
    unit pairs force ρ ≤ 1/2). With them K2c gives an explicit construction (class 9 = half box ∪ far box ∪ a small box Q at `x + e θ`, no unit pair at all; the
    rest coloured by `sq9`; k = 10), checked by hand, one mind. Alternative weighed: state only the derivation's single example. Why: the repaired range is the
    true form the construction reaches, and the kernel decides. Confidence: medium-high. Correction owed: with item 37, an erratum on FS121-V5-FACE-SHARP's
    both halves (positive half `g < 1`; failure half `2ρ < 1`, `g² + ρ² < 1`), for the record job.
87. **FS131-I3c handed back at stage 3, harness ≈ 485k** (report on its branch; `fs131-w3` at `98f4b279`, checked): FS116-S1-EXIT (`exit_lens`, `exit_lens_row`; three
    hypotheses idle), `ArcMap.germ_dichotomy`, FS116-Y4-FLANK (`flank_initialPieces`, `flank_cone`, so `flank`) — standard three axioms (Keryx's receipt:
    `germ_dichotomy`, `flank`, `exit_lens_row` read from `build/gate/axioms/20261004T092614Z-2442823.log` in the worktree). 80 of 96; 16 left, each with a plan
    in the record's Stage 3. Routes found: engine 3 without a sector parametrization; `sixCol (e(π/3)·x) = sixCol x + 1` for SixFragment; the sub-arc and the
    finiteness of Z for `qfree4` and FIVERING. Note for the merge: five helper lemmas moved into wave 1's `Plane/Chord`. Successor FS131-I3d
    (`data/fs131/briefs/FS131-I3d-wave3.md`, gated PASS), launched in the slot I3c freed. Source: this commit.
88. **Finding — two GAPs in the repaired chain of "maps need six" (FS106-WO, FS106-AE-MAP6), with unit-arc boundaries allowed** (FS131-W, message 2026-10-04, stage 1;
    one mind, before any skeleton; the page images of `[Woodall1973]` p. 198 read). **F1**: Woodall's step 5 reads "φ ≤ ⅓π" and "π − φ ≥ ⅔π" (the OCR the record's
    verifier V3 used — `plans/FS106-V-verification.md` stage 3, "Steps 5 and 7 use strict inequalities and survive" — lost the signs), so at φ = π/3 step 5 calls
    step 4's lemma at length exactly 2π/3, where Townsend's counterexample refutes it and the repair proves only lengths above 2π/3; it closes by one-sided collars
    unless both edges of the region are unit arcs centred at the arc's ends — Townsend's configuration, which nothing in the record excludes. **F2**: Woodall's
    step 7 (and 8) says the D|E edge "must terminate … only by meeting a vertex on the unit circle with center P" — false without Condition 5: the edge may meet
    ω(P) at Q and continue along it, so Q is a two-colour corner and step 6 never applies; W checked the scenario against lemma (L), TS-U and the sector
    constraints and found no contradiction. **F3**: TS's reduction to Townsend's printed lemma works only at a good degree-3 vertex; reaching one is Woodall's case
    analysis, where F1 and F2 sit. **Under Condition 5 both vanish and the chain closes as written.** Grade: GAP at named steps, one mind; not a refutation.
    **Bearing**: FS111-M-REDUCE-I, -M2-REDUCE-C and -VM2-EQ5 (`plans/FS111-derivation.md` lines 208–222, 618) use FS106-AE-MAP6 for the maps route M's regularity
    produces, whose interfaces are segments and arcs of integer radius (rows 140–141) — unit arcs included; so route M's "χ_m⁰(ℝ²) ≥ 6 at five" (FS-104's route (e))
    rests on F1 and F2 being closed. **Correction owed, pending the deriver** (not filed now — a GAP at one mind, routed): `LEDGER.md` row 132's "maps need six"
    clause and `CLAUDE.md` § The aim item 4's "Maps need six: `[Woodall1973]` Thm 6 and Townsend's manuscript, each repairing the other".
89. **Ruling — W's representation (F4)**: (a) state FS106-AE-MAP6 and Woodall's Thm 6 over wave 3–4's `ArcMap` (locally finite boundaries of segments and circular
    arcs, region-only validity), the class route M's regularity produces; the general Jordan-arc form (the row's "Conditions 2–4") recorded as owed. Alternative
    weighed: (b) general Jordan maps with the Jordan curve and θ-curve theorems and accessibility as outside theorems or a job. Why: Mathlib has none of that
    topology, the consumers' maps are arc maps, and the F1/F2 question is the same in either class. **For wave 9's planner**: FS111-M2-REDUCE-C composes AE-MAP6
    with REG-J′-C_k, stated over Jordan arcs; over `ArcMap` its interfaces must be segments and arcs. Confidence: high. **W's plan meanwhile, accepted**: formalize
    what holds (FS106-TW in a collar form; FS106-WO's step-4 lemma, strict; Townsend's ⅔π counterexample as an adversary), and state AE-MAP6 twice — unconditional,
    with F1's and F2's leaves marked open for the deriver, and under Condition 5, which the chain proves.
90. **Routed — F1 and F2 to an Ephodos job** (FS131-E1, queued for the first free slot): close each GAP or exhibit the configuration (a five-colour arc map,
    almost-everywhere proper, with unit-arc boundaries at Townsend's configuration or with an edge continuing along ω(P)), from W's record and the papers.
91. **Retraction and widening, W's own (item 88 corrected)** (FS131-W, message 2026-10-04): **F2 survives Condition 5.** At Woodall's step 7 the region D may reach
    ω(P) at a single point Q of the window — the outward tip of a D wedge (two sides, one boundary curve with a corner at Q), or an arc of radius below 1 tangent
    to ω(P) from inside — with E outside near Q and B absent, so Q carries only D and E; Condition 5 forbids neither. Checked against lemma (L) (the wedge sides'
    change points land beyond the arc's ends when Q is strictly inside the window), the d-sector at P and TS-U: no contradiction [planner's check, one mind].
    Woodall's "must terminate … at a vertex" holds only if such a corner counts as a vertex, and Condition 2's "at least three boundaries" excludes it.
    **Withdrawn**: "step 8 alike" — outside the window only B is allowed, so the accumulation point carries B, D, E and step 6 finishes it. **F1 stands**; it closes
    under Condition 5 by the second-order extension at the arc's ends. **So**: AE-MAP6 unconditionally has two open leaves (step 5's equality case, F1; step 7,
    F2); **under Condition 5 it still has one (step 7)** — item 88's "under Condition 5 both vanish and the chain closes" is withdrawn. Held leaves: FS106-TW,
    FS106-WO's strict step-4 lemma, the ⅔π adversary, steps 3, 5 (strict), 6 and 8. Retractions counted: W, one (item 88's Condition-5 clause and step 8). The
    correction owed (item 88) widens: row 132's "maps need six" and `CLAUDE.md` § The aim item 4 hold only modulo step 7 in every class, and modulo step 5's
    equality case with unit arcs — pending FS131-E1.
92. **FS131-K2c done, harness ≈ 427k** (report on its branch; `fs131-w2` at `bdba8ff5`): all 34 leaves re-planned (§ 12.2); children stated for 16 (all 12 in
    `Plane/Slack`, `falconer_reduction`, `chiM0_le_of_fragments` — now proved from its child — `exists_grundy`, both Dyadic leaves): 94 new theorems (2 proved),
    12 definitions; build green. Item 86 applied, with K2c's construction for the ruled form [hand, one mind]. Routes: a Fourier-free Rajchman step
    (`‖Th‖² = ⟨h, h ⋆ ρ⟩`); SUPK's lower bound by square windows; `tendsto_not_kept` by Markov; SQRT3-LOCAL through a P-local generator (item 64 repaired).
    GAP at a planning step: 18 leaves have routes but no stated children (lane A's 4, CoverExamples' 13, `exists_not_uniform_kept`); HC and IRREG need
    FS111-M3 §§ 2.2–2.4 read first. Slip (K2c's): a commit subject says 18 where 16 is true.
93. **Ruling — `[Falconer1981]` Lemma 2 (i) enters wave 2 as an axiom** (`falconer_lemma2_nonempty`, `Plane/FalconerReduction`, with the four items of `LEAN.md`
    § Assumptions done by K2c: docstring, read-back, model `upperHalfPlane_falconer_hyp`, `ARCHITECTURE.md` § Trust row). Alternative weighed: hold
    `falconer_reduction` back until a formalization job lands. Why: a published lemma (its proof Croft's Lemma 4, which we do not hold) is allowed as an axiom
    for a milestone (Kooshi, 2026-10-03, `LEAN.md` § Assumptions); its classical form, the connectedness of the density topology, is a formalization job worth
    doing before publication. Wave 2's landing then reads 6 declared purchases; `scripts/axioms.sh` learns the name at the landing (the implementer's). **Stub to
    mint**: formalize `falconer_lemma2_nonempty` (density topology connected) before publication. **Bibliography debt**: Croft (Falconer's ref. [1]) — title and
    venue to read off `[Falconer1981]` p. 189; not held. Confidence: high.
94. **Wave 2's next two jobs, sequenced** (K2c's second decision): FS131-I2e (implementer, on the 16 leaves whose children are stated; handoff § 13) and FS131-K2d
    (planner: children for the other 18, after the FS111-M3 reading) take the next free slots in that order; if they run together, K2d works in its own worktree
    branched from `fs131-w2`, touching only `Plane/CoverExamples`, `Arith/PlaceHom` and `Arith/FalconerField` (one writer per file; `exists_not_uniform_kept`
    left to a later stage), and merges back. The queue after FS131-E1: I2e, K2d, I4, LEB.
95. **Brief FS131-E1, the maps-six GAPs** (`ephodos`, Opus; `data/fs131/briefs/FS131-E1-maps-six-gaps.md`, gated PASS); claim list `data/fs131/claims-E1.md`
    (W's § 1.6, copied verbatim by script). Points the deriver at `[Townsend2005]` (held, read in full 2026-09-27) as the published proof to read first.
    Launched in the slot K2c freed (item 90). Source: this commit.
96. **FS131-W stage 3** (`fs131-ww` at `630018e5`): Woodall's chain stated over `ArcMap` — `Plane/Woodall/Basic` (collars, `ArcMap.SectorsAt`, Woodall's normal forms;
    sorry-free), `Plane/Woodall/Collar` (`townsend_lemma` = FS106-TW, `woodall_step4` = FS106-WO clause 2, the ⅔π adversary), `Plane/Woodall/Steps` (`ArcMap.aeMap6` =
    FS106-AE-MAP6, `aeMap6_of_condition5`, `woodall_thm6` = FS106-WO clause 1); open leaves `step5_eq` (Q1) and `step7` (Q2), the Condition-5 form `step7` only;
    build 444/444, only `sorry` warnings. Generalization G-TW: Townsend's lemma region-only, with one-sided collars whose side may vary with the angle (the seed
    one-sided, as every use has). **Vacuity rule for wave 9**: `aeMap6` says no valid five-coloured arc map exists, so any statement over such maps not concluding
    `False` is vacuous — compositions over "a valid five-coloured arc map" must be refutations (W folded the normal-form step into `aeMap6_merged`).
97. **FS131-W done, harness ≈ 270k** (report on its branch; `fs131-ww` at `7aaaf2c4`, checked): Woodall's chain planned over `ArcMap` — 31 leaves (15 in `Collar`, 16 in
    `Steps`), every one planned except the two open in the derivation (`step5_eq`, `step7`); `exists_woodallMerged` (Woodall's step 3, a global recolouring near the
    vertices) priced H+, likely its own implementer job; a stronger helper (`false_of_collars_closed`) carries `woodall_step4` and `step5_eq_of_condition5`. Drafts
    (plan § 5) for `CLAUDE.md` § The aim item 4, `LEDGER.md` row 132, `BIBLIOGRAPHY.md` ([Woodall1973] § 3 re-read from page images; [Townsend1979ms] re-read in
    full) and FS106's errata — **held until FS131-E1 reports** (item 88).
98. **Ruling — how Woodall's chain lands while two steps are open** (W's held decision): an implementer may build the chain's proved leaves now; the landing form
    waits for FS131-E1. If E1 closes the GAPs, the chain lands unconditionally; if not, it lands with the open steps as named propositions — hypotheses of
    `aeMap6`, `aeMap6_of_condition5` and `woodall_thm6`, in the way row 127 holds the main clause over named hypotheses — and FS106-AE-MAP6 stays unheld, recorded as
    GAP. Alternative weighed: (b) now, restating the three theorems before E1 reports. Why: E1 may change what the open statements should say; restating twice costs
    a planner job. Confidence: high. The Woodall implementer (FS131-IW) joins the queue after FS131-I4.
99. **Brief FS131-I2e, wave 2's fifth implementer** (`debruijn-implementer`, Sonnet; `data/fs131/briefs/FS131-I2e-wave2.md`, gated PASS): the 16 leaves K2c re-planned
    into stated children first, then any leaf whose route is complete; leaves `Plane/CoverExamples`, `Arith/PlaceHom`, `Arith/FalconerField` to FS131-K2d if it runs
    beside (item 94). Launched in the slot W freed. Queue after it: FS131-K2d, FS131-I4, FS131-IW, FS131-LEB. Source: this commit.
100. **Skeleton slip — `arcLength_bigBall_ge` false at R = 1** (FS131-I2e, message 2026-10-04; `Plane/Cover`, a child K2c stated): at `R = 1`, `u = z`, every
     `u + e θ` lies at distance exactly 1 from `z`, outside the open ball, so the arc length is 0 (Keryx's receipt: that observation). Its only consumer,
     `not_keptAt_of_half_lt`, has `R = 2ε > 1`. **Ruling: `(hR : 1 < R)`.** Alternative: none live. Confidence: high.
101. **FS131-I3d handed back at stage 4, harness ≈ 473k** (report on its branch; `fs131-w3` at `dbf34f37`, checked): seven leaves — `Simple.coneAt_eq_angleIcc` (interval
     cones, with no sector structure), `qfree4`, `fiveRing_finite_off_Q`, `fiveRing_length`, `touchW` (carrying FS116-N1-TOUCH), `germS_inward`, `germS_outward` — each
     on the standard three axioms in `build/gate/axioms/20261004T102246Z-2733747.log` (worktree); 87 of 96; 9 left. Correction to the plan (§§ 6.1–6.2): the sector
     engine is needed only for `finite_tiles_near` and its two corollaries (and through them `four_of_bothKind`, `germS_four`). Generalization:
     `IsJordanDomain.coneAt_eq_angleIcc` for any open set with Jordan-domain structure at a point. Slip (I3d's): a stale `scripts/Axioms.lean` record removed.
102. **Order changed** (Keryx): FS131-I3e (wave 3's fifth implementer, `data/fs131/briefs/FS131-I3e-wave3.md`, gated PASS) takes the slot I3d freed, ahead of FS131-K2d.
     Why: wave 3 is nine leaves from the second landing. Queue after it: K2d, I4, IW, LEB. Source: this commit.
103. **Kooshi's rulings, 2026-10-04** (verbatim): *"1. I extend the 3 agent cap with a rule: it was sized for 3 Opus agents. […] one
     Opus slot may be filled with two Sonnet agents. 2. You may trial an Opus implementer 3. What is the URL of the github repo? It was likely very recently
     published and also using AI. I'll check it out. 4. Please update the handoff, and I'll compact."* Filed: the staffing line of `.claude/output-styles/keryx.md`
     § Staffing (an Opus agent one slot, a Sonnet agent half; three slots); the project memory. **The Opus-implementer trial**: run `debruijn-implementer` with the
     Agent tool's `model: "opus"` override, as wave 2's next implementer after FS131-I2e (the most Sonnet history on comparable hard leaves: I2–I2e), and compare
     leaves closed per session against I2–I2e (inventory items 49, 58, 70, 82). The GitHub repository (item 9): the record holds its name only, from a search
     listing (`plans/FS131-kernel-plan.md` § 3.2) — `decalion89/chromatic-number-of-the-plane`, release v1.1.0; the same listing pass saw a Zenodo record claiming a
     formal verification that the plane is seven-chromatic (not read). Kooshi reads the repository.
104. **Brief FS131-K2d, wave 2's last planning stage** (`debruijn`, Opus; `data/fs131/briefs/FS131-K2d-wave2-children.md`, gated PASS): state the ◇ children of
     § 12.2 for the 17 leaves in `Plane/CoverExamples`, `Arith/PlaceHom`, `Arith/FalconerField`; plan `exists_not_uniform_kept`'s in the record (`Plane/Slack` is
     I2e's). Worktree `.claude/worktrees/fs131-w2d`, branch `fs131-w2d` from `fs131-w2` at `29082313`; `.lake/packages` symlinked, `.lake/build` copied from
     `fs131-w2`'s (no build running there at the copy). K2d merges `fs131-w2` into its branch at the end; the merge back into `fs131-w2` is the next implementer's
     first step. Launched in the free slot (handoff § 4 item 1): slots 0.5 + 0.5 + 1 + 1 = 3. Queue after it: the Opus-implementer trial (after I2e), I4, IW, LEB.
105. **The two listings' addresses** (item 9; recovered from the web-search results returned to FS131-K1 on 2026-10-03, at Kooshi's request): the Zenodo record,
     "The Hadwiger-Nelson Problem: (title removed)",
     an outside record; the GitHub release, https://github.com/decalion89/chromatic-number-of-the-plane/releases/tag/v1.1.0. Neither read here.
106. **FS131-E1 mid-flight finding** (message 2026-10-04; record `plans/FS131-E1-derivation.md` § 3, commit `3f775af7`): **E1-NO45** — "in a five-colour
     almost-everywhere-proper arc map in Woodall's normal form, no point lies on the boundary of exactly four or exactly five sectors" [hand, one mind] —
     Townsend 2005 Thm 5 (ii) made rigorous, through E1-CROSS, E1-COVER (≥ 6 branch points on ω(P)), E1-BAD (≤ 5 exceptional points, given strict step 5) and
     step 6. With **E1-NOBRANCH** (some branch point exists; needs the Jordan curve theorem for segment-and-arc curves, which Mathlib lacks — item 89) it gives
     **E1-MAPS6** [derived, one mind]: maps need six for arc maps, almost everywhere, reading neither step 5 at equality nor steps 7–8. F1 and F2 are
     **bypassed, not closed** (its *not claimed*). Not claimed: the Jordan-arc form (D-SV Conditions 2–4). Caveats for the formal statement: (N1) per sector;
     the arc-map form read at three places. Keryx's receipt: control e1-count run — `k=4: tuples=12341 max_points=5 …; fewer_than_six_everywhere=True`, as its
     expect line; `--fault` gives `fewer_than_six_everywhere=False`; the angle bound (k = 4: at most 2π − π = π; k = 5: at most 2π/3) checked by hand.
     **Routing**: the Woodall chain's plan changes — leaves `step5_eq`, `step7` (and step 8) dropped; E1-SEE, -RAY, -CROSS, -COVER, -BAD, -NO45, -NOBRANCH
     added; the Jordan curve theorem for arc curves priced or routed around by W's collars. A planner pass on `fs131-ww` (FS131-W2; resuming W, ≈ 270k, if it
     is the cheaper reader) takes the Opus slot E1 frees, **after E1's report** (it is still writing the chain corrections). FS131-IW waits for it; I3e's half
     slot goes to FS131-I4. Corrections to row 132 and § The aim stay held until the report (item 88). Credit: E1, by name.
107. **FS131-E1 done, harness ≈ 490k** (report `data/fs131/reports/FS131-E1.md`; record `plans/FS131-E1-derivation.md`, commits `7ecfc505`, `0f064d8f`, `3f775af7`,
     `44374550`, `4a1276e6`, checked; derive gate PASS on Keryx's run, four controls each firing on its fault): Q1 and Q2 **excluded** (E1-Q1, E1-Q2), both through
     E1-NO45 (item 106); E1-MAPS6 [derived, one mind]: maps need six for arc maps, Jordan form owed; E1-GEN6 a generalization (not used). Predictions: Q1, Q2 each
     "derived — excluded" at 0.75, both met (Brier 0.0625 each; registered after the route was sketched, its § 1.4). **Filed verbatim from its § 4.3** (this
     commit): FS106-WO and FS106-AE-MAP6 errata (`plans/FS106-derivation.md`), `LEDGER.md` row 132 (three phrases, the milestone list), `CLAUDE.md` § The aim
     item 4, `BIBLIOGRAPHY.md` read-status of `[Woodall1973]` and `[Townsend2005]`; fact audit `--base 7c7a1513` PASS, `--dupes` run, `tools/bib_audit.py` clean.
     **Items 88 and 91's correction is discharged for arc maps and stands for Jordan maps.** Wave 9 note: FS111-M2-REDUCE-C and -VM2-EQ5 state their regularity
     over Jordan arcs — restored only when the arrangement is an arc map (item 89); FS111-M-REDUCE-I's use is restored. Stub to mint: AE-MAP6 for Jordan boundaries
     (item 89), now with one named obstacle (E1-BAD's count with oscillating edges). Statement defect (minor, E1's): Q2's "every angle > π/3" leaned on step 5 at
     equality; harmless. Prior-art debt: Reid–Jungreis–Witte 1990, Zaks 1992 (cite Woodall; judged off-topic by title). **Held for Kooshi**: a blind second mind
     on E1-NO45 before de Bruijn formalizes it, or the kernel as the second check (Workflow 3.1's default). Over its line (490k vs 480k): not a slip.
108. **Kooshi, 2026-10-04 (verbatim in `data/external/EXT-HN1-request.md`)**: an outside repository, an outside repository, appears to
     settle Hadwiger–Nelson with a short proof; *"Please have an opus agent of some kind pull and verify this. I'm authorizing a special purpose slot for this."*
     **Brief EXT-HN1** (`debruijn`, Opus; `data/external/briefs/EXT-HN1-outside-claim.md`, gated PASS): pin the commit, read every file before anything runs,
     read the headline statement aloud against the claim down to Mathlib's definitions, build sandboxed (`bwrap`, network off for the build, under the slot),
     compile the headline's file directly, `#print axioms`, locate any defect with the smallest demonstration; read-only toward the outside world. Launched in
     the special slot, outside the three-slot cap (Kooshi's word).
109. **Brief FS131-W2, Woodall's chain re-planned** (`debruijn`, Opus, a fresh planner rather than W resumed — W's 270k would leave too little room for the
     re-plan, and a fresh reading of E1's argument line by line is the first check of it by a second reader, not a second mind; `data/fs131/briefs/FS131-W2-woodall-replan.md`,
     gated PASS): `step5_eq`, `step7` and step 8 out; E1-SEE, -RAY, -CROSS, -COVER, -BAD, -NO45, -NOBRANCH in over `ArcMap`; the Jordan curve theorem for
     segment-and-arc curves decided; leaf plans and the handoff current. Row statements unchanged. Launched in the slot E1 freed: slots 0.5 + 0.5 + 1 + 1 = 3,
     plus EXT-HN1 in the special slot. FS131-IW waits for it.
110. **EXT-HN1 early answer** (message 2026-10-04; commit pulled `outside-commit-1`, one Lean file `OutsideClaim.lean`, 102 lines):
     the headline `outside_headline` concludes only `(∑ i, outside_measure r (C.color i)) < 2 * π` for a six-set cover of one circle of radius `r`, from the
     hypothesis `h_safe : ∀ i, OutsideDensity r (C.color i)` — "a unit-safe set has angular measure `< π/3`" — which is assumed, never proved; no graph, no chromatic
     number, no conclusion `False`; "= 7" only in the README and comments. The assumed claim is false (for `r < 1/2` the whole circle has no unit pair and measure
     `2π`; for `r ≥ 1/2` the circle's unit graph is rotation by `±θ`, degree ≤ 2, so every circle is 3-colourable). Build broken as shipped (no `require mathlib`,
     no manifest, default target's root absent). **Keryx's receipt**: read the file at that commit in the agent's working copy — `outside_headline`'s statement,
     its proof (six reals each `< π/3` sum to `< 2π`) and the definitions `OutsideColoring`, `outside_safe`, `OutsideDensity`, `outside_measure` as quoted; and the `r < 1/2`
     case by hand (diameter `2r < 1`). Agent continuing: compile against Mathlib, small Lean refutations, `#print axioms`.
111. **Kooshi's ruling, 2026-10-04 (verbatim)**: *"lean proof serves as the check That's our new standard so we kill two birds with one stone."* — no blind second
     mind on E1-NO45; FS131-W2's formalization is its check (item 107's held decision, closed). On the outside repositories: *"The other github repo is better,
     but they're far behind us."* (`decalion89/chromatic-number-of-the-plane`, item 105; its prior-art note — an independent Lean formalization of rows 103 and
     57 — stays a debt for `BIBLIOGRAPHY.md` at the close.)
112. **Statement defect candidate — a cusp breaks `four_of_bothKind`'s route** (FS131-I3e, message 2026-10-04; `Plane/RingGerm`, FS116-V5-U1's four-colour clause):
     `hint` allows `β₁ = β₂`, so a tile's cone at `z` may be one direction (a cusp between two tangent arcs; `Simple` allows it — a Jordan domain can have a cusp).
     A cusp `c`-tile in the facing cone, a `d`-tile whose interval cone covers both side cones and the facing cone around the cusp, and a `c′` sector meet every
     hypothesis with three colours at `z` and no contradiction found locally — a local picture, not a built fragment. The plan's route (a colour in both side
     cones overlaps `c`'s or `c′`'s tile cone in an interval) needs non-degenerate cones. **Ruling**: `four_of_bothKind`'s `hint` takes `β₁ < β₂`;
     `four_of_bothKind_simple` takes a hypothesis that no tile with `z` in its closure has a cone of one direction (no cusp at `z`; the Lean form the
     implementer's). Alternative weighed: hold wave 3's landing until a deriver settles the cusp case. Why not: the repaired forms are weaker, so they cannot be
     wrong where the originals are right, and a stronger form, if the cusp case holds, is a new theorem later, not a restatement; wave 3 is nine leaves from
     landing. Confidence: high that the repair is sound; medium that the hand clause fails with cusps. **Correction owed** (to the record job / an Ephodos
     job, queued as **FS131-E2**: prove the four-colour clause with a cusp at `z`, or build the valid fragment): FS116-V5-U1's four-colour clause is held only
     with no cusp at `z`; its hand consumers — FS116-V5-DICHO, FS116-V5-CROSS-S, V5's second derivations of FS116-N3-SEMI, -PAIR, -CROSS — inherit the question.
     **Wave 4 note**: FS112-N3-NOBOTH (`noBoth`, "four colours or a repeated colour") likely has the same cusp case — for wave 4's implementer brief.
113. **EXT-HN1 build result** (message 2026-10-04; record `plans/EXT-HN1-verification.md` stage 2, commit `02a06d16`): the repository's own build compiles
     nothing (`lake build` exit 1, "no such file … HadwigerNelson.lean"; `lake env lean` exit 1, "unknown module prefix 'Mathlib'"). In the auditor's harness
     (TOML lakefile requiring Mathlib v4.28.0, the file unchanged) it builds, `#print axioms` gives the standard three for `outside_headline` and
     `unit_clique_verified`, lean4checker replays clean with its controls firing. The audit module proves, against their unchanged definitions, on the standard
     three: `not_outsideDensity_quarter` (the assumed density lemma false at `r = 1/4`), a `OutsideColoring (1/4)` failing `h_safe`, and
     `outside_headline_hypotheses_never_hold` — for every `r ≥ 0`, no six-colouring of the circle satisfies the hypothesis, so the theorem applies to nothing.
114. **FS131-I2e handed back at stage 7, harness ≈ 330k** (report on its branch; `fs131-w2` at `ded70272`, checked): four of the 16 re-planned leaves —
     `keptAt_band` (FS106-REM clause 1), `AeColouring.exists_grundy` (FS121-D3-GRUNDY), `face` (FS121-D4-FACE), `exists_face_fails` (FS121-V5-FACE-SHARP's
     failure half, item 86) — and 31 children; 125 → 90 `sorry` declarations. Keryx's receipt: build log `build/gate/build/20261004T105629Z-2873941.log`
     (worktree) ends "Build completed successfully (5604 jobs)", 90 distinct warnings, every one `declaration uses \`sorry\``; `data/fs131/i2/i2e-axioms.txt`
     has no `sorryAx` and only the standard three. Prices held within ×2 (actuals: Cover arcs 45k, `keptAt_band` 25k, `exists_grundy` 60k, `face` 85k,
     `exists_face_fails` 45k). Generalization: `exists_isMaxIn` with a.e. inclusion (`B ≤ᵐ Tᶜ`) — the trick for any "maximal inside a complement" argument.
     Its "item 100 has no row" is mistaken: item 100 is filed. Open: 12 of the 16 re-planned leaves; Cover 2, Slack 46, FalconerReduction 9, YesLimit 4,
     Dyadic 12 `sorry` lines, plus K2d's three files. **Next on wave 2**: the Opus-implementer trial (item 103), when an Opus slot frees (K2d or W2); it
     merges `fs131-w2d` first if K2d has handed back. Credit: I2e, for the item-100 slip found and four hard leaves closed.
115. **Brief FS131-I4, wave 4's first implementer** (`debruijn-implementer`, Sonnet; `data/fs131/briefs/FS131-I4-wave4.md`, gated PASS; carries item 112's cusp note
     for `noBoth`). Launched in the half slot I2e freed: slots 0.5 (I3e) + 0.5 (I4) + 1 (K2d) + 1 (W2) = 3, plus EXT-HN1 in the special slot.
116. **FS131-I3e handed back at stage 5, harness ≈ 400k** (report on its branch; `fs131-w3` at `4f7b949d`, checked): `finite_tiles_near`,
     `mem_coloursAt_iff_exists_tileOf`, `coneAt_region_eq_biUnion` (engine 3, with no sector engine — a "good radius" and a farthest-point lemma) and `germS_four`;
     `ringQPrimeS` now sorry-free; item 112 applied (`hint` strict; `four_of_bothKind_simple` takes `hnc : ∀ T, F.IsTile T → z ∈ closure T → ∀ β, coneAt T z ≠
     angleIcc β β`, its proof done). Keryx's receipt: the two statements read at `RingGerm.lean` lines 2248 and 2257; five `sorry` left by count (`SixFragment` 3,
     `RingGerm` 2); build log `build/gate/build/20261004T110435Z-2915550.log` OK — but it predates the item-112 edit, compiled only in scratch. **Correction
     owed to the plan** (I3e's): `sixFrag_nonSiamese` needs each of S_0, Q_4, G_2 (cut at 3/2) connected, which the plan's route omits. Slip (I3e's):
     `LocalStructure`'s module docstring says "Every leaf is sorry". Axioms from scratch `#print axioms`, not a gate log.
117. **Brief FS131-I3f, wave 3's sixth implementer** (`debruijn-implementer`, Sonnet; `data/fs131/briefs/FS131-I3f-wave3.md`, derived from I3e's by script, gated
     PASS): the last five leaves, the gate, the vacuity step, the landing. Launched in I3e's half slot: slots 0.5 (I4) + 0.5 (I3f) + 1 (K2d) + 1 (W2) = 3, plus
     EXT-HN1 in the special slot.
118. **FS131-K2d done, harness ≈ 445k** (report on its branch; `fs131-w2d` at `f7eeace4`, checked): children stated for all 17 leaves in its three files; 13 leaves
     closed from their children (`exists_placeHom`, `noAffine_fields`, `falconerFan_five_field`, `falconerFan_five_placeHom`, `sq9_saturated_both`,
     `r7_aeColouring`, `r7Cls_saturated`, `r7_boundary`, `r7Cls_isMaximalCover`, `disc7_isMaximalCover`, `disc7_isRegularMUA`, `disc7_upperDensity`,
     `g1Bounds_hcGap`); 4 assemblies planned, not written; 77 children `sorry`. **Proved [kernel]**: `Instances/FalconerOrbit` — `finitePlane7_fanGap`,
     `finitePlane7_slack`, `gamma11_orbit`, `gamma19_orbit` (each `decide +kernel`, 2–4 s), `tipFree_of_orbit`, `finitePlane11_tipFree`, `finitePlane19_tipFree`;
     K2c's `gamma7_orbit` not needed. Keryx's receipt: build log `build/gate/build/20261004T110617Z-2928418.log` (w2d) "Build completed successfully (5605 jobs)";
     `Instances/FalconerOrbit.lean` has no `sorry` and no `native_decide`; `3dffa363` an ancestor of the branch. Generalization: FALC-RES clause (i) reads no
     connectedness, clause (ii) no transcendence of `t`. **GAP at a planning step**: `exists_not_uniform_kept`'s fringe colouring does not handle fringe-to-fringe
     unit pairs (§ 17.1; `k = 9 + 3N` proposed); if no proper formula comes out, a deriver writes out FS106-TQ's control C2 (queued behind FS131-E2). Slip
     (Keryx's, in the K2d brief): `fatZ_spec` listed as a leaf, proved since `344a9081` (my `awk` attributed a later `sorry` to it). Slip (K2d's): a planted
     fault that did not fire (the planted statement was true), replaced and logged. **Merge**: `fs131-w2d` merged into `fs131-w2` by Keryx (`ddc5b5c8`,
     `--no-ff`, clean; the only files beyond K2d's tree are I2e's record, report and axioms print, so K2d's build covers the Lean).
119. **Brief FS131-I2f, the Opus-implementer trial** (`debruijn-implementer` with `model: "opus"`, item 103; `data/fs131/briefs/FS131-I2f-wave2.md`, gated
     PASS): every remaining wave-2 leaf and child (154 `sorry` lines at `ddc5b5c8`), the gate, the landing; its record counts what it closes, for comparison
     with I2–I2e (items 49, 58, 70, 82, 114). Launched in K2d's Opus slot: slots 0.5 (I3f) + 0.5 (I4) + 1 (W2) + 1 (I2f) = 3, plus EXT-HN1.
120. **FS131-W2 mid-flight findings** (message 2026-10-04, reading E1's argument line by line as its formalizer; to be carried in its record's stage 7):
     (1) **Argument step of E1-BAD false** (`plans/FS131-E1-derivation.md` § 3.5, "Counting": "only for the one of these two on s's side"): `P = 0`, a sector `s` of
     angle π bounded by the two arc-ends at `P` of the circle of radius 1/2 about `(0, −1/2)`, `s` outside it — both `Y₊ = (0, 1)` and `Y₋ = (0, −1)` have both
     branches of `ω(Y)` at `P` in `s`. Keryx's receipt: `tools/fs131_w2_bad_pi.py` (worktree `fs131-ww`) prints `both_exceptional=True`, `--fault` (radius 2)
     `False`; and by hand `|w − (0, −½)|² = sin²t + (cos t − ½)² = 5/4 − cos t > 1/4` for `t ≠ 0`. **E1-BAD's statement survives as a total count** (at most
     edges + π-sectors), and so does E1-NO45: the two points are the normals `P + e(a ± π/2)` of the π-sector's edges, which already hold any unit-arc
     centres of those edges, so at most `k` exceptional points [W2's argument, one mind]. Control e1-count bounds correctly for the wrong reason. **Correction
     owed**: § 3.5's argument (no statement change) — an erratum in E1's record, filed from W2's stage 7 when committed. Rows 132 and § The aim item 4 stand.
     (2) **W's definitions differ from E1's (N1)/(N2)** (E1's § 3.0 caveat): W's `ArcMap` allows an arc between two tiles of one colour and several arcs
     leaving a point in one direction, so "(N1) per sector" and "(N2)" are not expressible in `WoodallNormal`; two steps read them (E1-COVER (c); E1-BAD's
     one-per-edge). W2 absorbs both with no added hypothesis: E1-COVER closed with a colour class in place of a region (a clopen argument on the arc, and a
     new lemma — a connected subset of the closure of an open set with no unit pair has diameter at most 1, from wave 1's
     `dist_ne_one_of_mem_of_mem_closure`), and E1-BAD's edge case by a second-order lemma (along the circles of curvature `κ` tangent to an edge, at least one
     of the two normals carries a collar in both adjacent colours' shadows). The formal E1-NO45 needs only `WoodallNormal` with angles weakened to `≥ π/3`.
     (3) **Generalization** (W2's): E1-COVER holds for any valid map, any number of colours, at a point whose picture has positive angles and at most one colour
     absent (E1-GEN6's form); the arc-map form is read only at `P` and its edges — **for the Jordan-boundaries stub** (item 107): the obstacle is local to the
     vertices of three, four and five sectors. (4) **The Jordan curve theorem is not needed**: E1-NOBRANCH's conclusion is W's `exists_three_le_sectors`, from
     wave 4's `ArcMap.ts_t` (FS106-TS-T), which rests on `lebesgue_covering_square` (FS131-LEB, item 66) — so Woodall's chain lands after LEB, like wave 4.
     Queue for the next Opus slot, by bearing: FS131-E2 (the cusp case — it may touch frontier hand results), then FS131-LEB (it blocks wave 4 and Woodall's chain).
121. **EXT-HN1 issue check** (message 2026-10-04; logs `data/external/hn1/issue-check/`, with its stage 3): the issue's Lean block (2,575 characters, sha256
     `9219ccba…`) compiles three ways — its own module beside the unchanged outside file, with `autoImplicit` off, and pasted after the original with the import
     removed (the Lean 4 Web form) — each exit 0, no warnings; both `#print axioms` lines the standard three. Three prose sentences said more than the record:
     "Everything here was checked in Lean" (the general three-colouring is a hand argument; "needs three" needs the unit triangle, hand only); "no six-colouring
     of any circle" (Lean has `r ≥ 0`; at `r < 0` the circle is empty); and **"even a true density bound would not give χ(ℝ²) = 7" — mathematically wrong**
     (Keryx's slip): a true bound at one radius would rule out six-colouring that circle, hence the plane. All three corrected in
     `data/external/EXT-HN1-issue.md`; Keryx's receipt: the block's sha256 with its final newline re-computed, `9219ccba`, unchanged from the compiled one.
     Also: `threeArcs` and `arcClass_unit_safe` (the three-arc colouring at radius `1/√3`) now kernel-checked in the audit file, to be committed at its stage 3.
     Credit: EXT-HN1, for catching the coordinator's false sentence before it was posted.
122. **EXT-HN1 done, harness ≈ 200k** (report `data/external/reports/EXT-HN1.md`; record `plans/EXT-HN1-verification.md`; commits `4a9fca37`, `02a06d16`, `73487cf1`,
     `661fb6e1`, checked): the outside claim states no Hadwiger–Nelson result (items 110, 113); `threeArcs : OutsideColoring (1/√3)` added [kernel, outside harness];
     every circle 3-colourable [hand, one mind]; the README's Lean 4 Web link decodes to the shipped file exactly. **Related listings settled**: the Zenodo
     record an outside record is the same author (ORCID (removed)), claim and files (md5); the decalion89 release is a different author (S. Galán) and claim.
     **Bibliography rows filed** (proposed by EXT-HN1, `BIBLIOGRAPHY.md` § A): `[Outside2026]` (author from Zenodo's creator field, checked in
     `data/external/hn1/related/an outside record`) and `[Galan2026]` (from its CITATION.cff); `tools/bib_audit.py` clean. Slip (EXT-HN1's): two
     sub-minute `lake env lean` runs outside `scripts/slot.py`. Tool note: in a sandbox with a toolchain's `bin` first on `PATH`, `LEAN_CC=clang` finds the
     toolchain's broken clang — give `/usr/bin/clang`. **Held, default keep**: the Mathlib harness at `~/.cache/ext-hn1/` (7.6 GB, outside the repository) stays
     for re-checks until the issue is answered, then is deleted. The special slot closes with this job.
123. **The EXT-HN1 Mathlib harness deleted** (Kooshi, 2026-10-04: *"You can delete the audit build. I don't think that author will have anything to say worth
     8GB of space."*): `~/.cache/ext-hn1/` (7.6 GB; build logs and the Mathlib v4.28.0 harness, no running process using it) removed. The audit's evidence stays in
     `data/external/hn1/` (the outside file, the audit module, the harness lakefile and manifest, every log); a re-check re-fetches Mathlib's cache. Item 122's
     held line closed.
124. **FS131-W2 done, harness ≈ 520k** (report on its branch; `fs131-ww` at `058c65f8`, checked): Woodall's chain re-planned with **no open leaf** —
     `step5_eq`, `step7`, `step8`, `step5_eq_of_condition5`, `aeMap6_merged_of_condition5` removed; new module `Plane/Woodall/NoFourFive` (E1-SEE, -RAY, -CROSS,
     -COVER, -BAD and the refined second-order lemma; 20 theorems, `sorry` at every leaf); E1-NO45 = `ArcMap.false_of_four_le_sectors` (`Steps`); E1-NOBRANCH =
     `exists_three_le_sectors`; `aeMap6_normal` = step 6 at three sectors + E1-NO45 at four and five. Keryx's receipt: build log
     `build/gate/build/20261004T113659Z-3156654.log` (ww) "Build completed successfully (5346 jobs)", no warning but `declaration uses sorry`;
     `tools/fs131_w2_decls.py --check` "53 theorems, 53 records; 0 missing, 0 stale". **E1-BAD erratum filed** in `plans/FS131-E1-derivation.md` after § E1-BAD's
     argument, verbatim from W2's § 7.4 (item 120's correction owed: done). Two planner's checks proved in scratch (`dist_le_one_of_subset_closure`, E1-SEE).
     **Rulings on its held items**: (a) the two Condition-5-only leaves stay removed — alternative, restore them as content of their own; why: nothing consumes
     them once `aeMap6_of_condition5` is a corollary of `aeMap6`, and step 5 at equality is not a row; confidence high. (b) The non-row statement change
     (`WoodallNormal`'s and `step6`'s angles `π/3 <` → `π/3 ≤`) is accepted — a weaker hypothesis, so stronger theorems. FS131-IW starts from § 9.5's handoff;
     the chain lands unconditionally after waves 3–4 and FS131-LEB. Over its line (520k vs 480k): not a slip.
125. **FS131-I4 handed back at stage 3, harness ≈ 425k** (report on its branch; `fs131-w4` at `d011c17d`): 26 of 86 leaves — FS110-N4-FIN (`n4_fin`), FS112-N2-RAY,
     FS110-N3-CONF, FS110-N4-SHADOW, N2-SIGN, FS112-FLANK, `flankQ_both`, FS106-TS-T's arc-map clauses (`ts_t` and kin, over two `sorry` children incl.
     `lebesgue_covering_square`), engine 1 and inhabitant plumbing; 60 left (Contact 10, UnitArc 23, SVMap 5, BaseSteps 22). Real build under the slot, 1741
     modules, exit 0 (`data/fs131/i4/build-stage3*.log`); axioms from scratch prints. **Plan gap**: `localSectors` (wave 3's plan § 6 item 3, "the sector structure
     at a point") was never stated on `fs131-w3` — I3e proved `finite_tiles_near` without it — and it gates `woodallCone`, `woodallCone_strict`,
     `exists_hasDegree_of_mem_dom`, `noBoth`'s repeated-colour clause, engine 5, `flankQ_upper/lower`, `stuck_structure`. Corrections owed to the plan: § 13.5's
     polar-region connectedness for the shadow leaves is unnecessary (one explicit ray point); `bowtie_mem_dom` is not E (it needs `0 ∈ interior (closure
     bowtieTiles)`). Slip (I4's): its first build was not "as given". Tools: `data/fs131/i4/iter.sh`, `chk.sh`, `w3snap.sh` (wave 3's proved modules into a scratch
     mirror), `tools/fs131_i4_addrecords.py`.
126. **Ruling — whose is `localSectors`**: it is stated as wave 3's plan specifies it (`.claude/worktrees/fs131-w3/plans/FS131-w3-kernel-plan.md` § 6, item 3), in
     `Plane/LocalStructure` if FS131-I3f states it for `flank_edge_exists` (that leaf was planned as its corollary; I3f is told), and otherwise by wave 4's next
     implementer in a wave-4 module importing `Plane/LocalStructure`, once wave 3 has landed (built on I3e's `GoodAt` machinery). Alternative weighed: a
     planner job to state it. Why not: its statement is already specified line by line in wave 3's plan; only its proof is new. Confidence: medium-high — if
     the spec turns out to need design (I3e's route suggests a different shape), the implementer messages me and it goes to a planner.
127. **Claim list `data/fs131/claims-E2.md` fixed and brief FS131-E2** (`ephodos`, Opus; `data/fs131/briefs/FS131-E2-cusp-case.md`, gated PASS): Q1 the cusp case
     of FS116-V5-U1's four-colour clause, Q2 the same for FS112-N3-NOBOTH, Q3 the consumers' fates. Launched in W2's Opus slot.
128. **Brief FS131-IW, Woodall's chain implementer** (`debruijn-implementer`, Sonnet; `data/fs131/briefs/FS131-IW-woodall.md`, gated PASS): § 9.5's order; its proofs
     are the check on E1-NO45 (item 111). Launched in the half slot I4 freed, ahead of wave 4's successor, because it checks the newest one-mind hand result:
     slots 0.5 (I3f) + 1 (I2f) + 1 (E2) + 0.5 (IW) = 3. **Next half slot**: FS131-I4b (wave 4's successor; item 126's `localSectors`). **Gate quirk, unreproduced**:
     the gate placed § 9.5's opening lines "not under § 9.5" (W2's plan repeats near-identical paragraphs in § 4.7); a minimal two-section repro passed, so the
     cause is not yet known — the brief quotes lines unique to § 9.5 instead. Not filed in agent-forge until reproduced.
129. **FS131-I2f (the Opus-implementer trial) handed back at stage 9, harness ≈ 380k** (report on its branch; `fs131-w2` at `7c890ed9`, checked): 37 `sorry`
     lines closed and 5 children added (154 → 117); **five rows sorry-free** — FS129-SA1-PLACE-HOM (`exists_placeHom`), FS129-SA1-NOAFF-FIELDS (`noAffine_fields`),
     FS129-SA1-FALC-RES (i) and (ii) (`falconerFan_five_field`, `falconerFan_five_placeHom`), FS111-W-SQ9 (`sq9_tight_saturated`), FS111-M3-BAND (clause 1,
     `IsMUA.add_normal_mem_essSupport`; its others were closed) — and DISC7's first two clauses. Keryx's receipt: build log
     `build/gate/build/20261004T114615Z-3230511.log` (w2) "Build completed successfully (5605 jobs)", 117 distinct warnings, all `declaration uses sorry`;
     `data/fs131/i2/i2f-axioms.txt` has no `sorryAx` and prints the standard three for each named row theorem; 117 `sorry` lines by count. A shorter Mathlib
     route found (`Localization.subalgebra.ofField` + `IsLocalization.lift` for the residue map). Tool defect: the coordinator's scratch overlay `ol` holds
     stale real oleans from earlier sessions — successors use private overlays (in I2g's brief). Slip (I2f's): its readback build waited 20 min for a slot and
     read its first edits. **The trial, scored** (item 103's measure): per session, closures comparable in number to the best Sonnet session on this wave
     (I2e: 35 `sorry` declarations at ≈ 330k; I2f: 37 lines at ≈ 380k), but the items closed carried about three times the planners' price (I2f: ≈ 780k at
     the Sonnet rate, done for ≈ 120k of proof work by its own count; I2e's items: within ×2 of price, nothing cheaper), and five whole rows against I2e's
     four leaves. That is roughly 1.5× the priced work per unit of budget — one session, a mixed item set, a rough figure.
     Whether implementers move to Opus is Kooshi's (staffing); default: Sonnet, the standing rule, unless he says otherwise.
130. **Briefs FS131-I2g (wave 2, seventh implementer) and FS131-I4b (wave 4, second implementer)** (`debruijn-implementer`, Sonnet; `data/fs131/briefs/FS131-I2g-wave2.md`,
     `data/fs131/briefs/FS131-I4b-wave4.md`, both gated PASS; I4b carries item 126's `localSectors` ruling and item 125's two plan corrections and the cusp note).
     Launched in I2f's Opus slot as two half slots: 0.5 (I3f) + 0.5 (IW) + 1 (E2) + 0.5 (I2g) + 0.5 (I4b) = 3. FS131-LEB stays queued: it blocks only the
     landings of wave 4 and Woodall's chain, both far from their last leaf.
131. **FS131-I3f handed back at stage 6, harness ≈ 415k** (report on its branch; `fs131-w3` at `5537611a`, checked): `sixCol_locallyConstant` (FS116-Y2-SIXFRAG's
     clause) proved on a lens formulation; rotation lemmas (`sixCol_rot`, `arg_rot`, `inSixLens_rot`, general-index arc membership) for the rest; item 112's
     `RingGerm` edits confirmed in a real build. Keryx's receipt: build log `build/gate/build/20261004T115020Z-3251979.log` (w3) "Build completed successfully
     (5348 jobs)", exactly four distinct `declaration uses sorry` warnings (`RingGerm` 2245, 2379; `SixFragment` 844, 849); no process left running in the tree.
     Four leaves left, each large: `sixFrag_valid` (~800 lines of pair geometry; the QQ pair hard), `sixFrag_nonSiamese` (~400), `four_of_bothKind` and
     `flank_edge_exists` (a sector engine each). Tool: `tools/fs131_i3_cert.py`, an LP certificate finder Lean re-checks (no certificate at degree 3 for QQ or
     the sector cross lemma). Slip (I3f's): `LocalStructure`'s docstring still unfixed. It did not state `localSectors`.
132. **Ruling — `localSectors` is wave 3's after all, stated by FS131-I3g** (supersedes item 126's fallback): the two `RingGerm` leaves each need a sector engine,
     and wave 4 needs one for six leaves; one engine, stated as wave 3's plan § 6.1 item 3 specifies it and proved on I3e's `GoodAt` machinery, serves all
     three. Alternative weighed: leave it to wave 4's implementer after wave 3 lands (item 126) and let I3g build its own engines for the two leaves. Why not:
     three engines where one is planned, and wave 4 would wait for wave 3's landing to get it. FS131-I4b is told to iterate against it once I3g commits it
     (via `w3snap.sh`) and not to state its own. Confidence: high.
133. **Brief FS131-I3g, wave 3's seventh implementer** (`debruijn-implementer`, Sonnet; `data/fs131/briefs/FS131-I3g-wave3.md`, gated PASS): `localSectors` first,
     messaged on commit; then `four_of_bothKind`, `flank_edge_exists`, and the `SixFragment` leaves as context allows. Launched in I3f's half slot: 0.5 (IW) +
     0.5 (I2g) + 0.5 (I4b) + 0.5 (I3g) + 1 (E2) = 3. Kooshi's model decision (item 129) would apply to the next wave-3 successor.
134. **Statement defect (a Lean slip) — the Dyadic statements drop "i ∉ F"** (FS131-I2g, message 2026-10-04; `Arith/Dyadic`): `hi : ∃ ι : L, ι ^ 2 = -1` with
     `finrank F L = 2` lets `L` be any quadratic extension when `i ∈ F`. Counterexamples: `sqrt3_dyadic` at `F = ℚ(ζ₁₂)`, `L = F(√2) = ℚ(ζ₂₄)`, `P` above 2 (`L/F`
     ramified there); `exists_root_quadratic` at `F = ℚ(i)`, `L = F(√2)`, `s = 1`, `d = 2`, `δ = 2` (`γ = −1 + i ∈ F`). Keryx's receipt: the ramification index
     of 2 is `φ(8) = 4` in `ℚ(ζ₂₄)` and `φ(4) = 2` in `ℚ(ζ₁₂)`, so `L/F` is ramified at `P`; and `sqrt3_dyadic`'s own docstring (`Arith/Dyadic.lean` line 314)
     reads "if `√3 ∈ F` and `i ∉ F`" — the row's hypothesis, dropped from the formal statement. **Ruling**: `hi` becomes `∃ ι : L, ι ^ 2 = -1 ∧ ι ∉ Set.range
     (algebraMap F L)` in `exists_root_quadratic`, `dyadicConclusion_of_coeffs`, `sqrt3_local_of_congr`, `sqrt3_local` and `sqrt3_dyadic` (with finrank 2 it makes
     `L = F(i)`, the row's reading). Alternative weighed: state `L` as `F⟮ι⟯` explicitly. Why not: the implementer's form is the smallest change and says the
     same. Confidence: high. No hand result changes; credit I2g.
135. **Ruling — I3g's order accepted, with the engine kept shared** (FS131-I3g, message 2026-10-04, proposing a re-order): it proves `four_of_bothKind` and
     `flank_edge_exists` first, on an inversion-coordinates engine (`ζ = (w − y)e(−δ)`, `ν = ζ/|ζ|²`: every curve through `y` becomes a line, regions near a
     direction are convex, and the disjoint-interiors lemma for tiles' cones falls out), then states `localSectors` if its budget remains. Its observation:
     wave 4's `Plane/ValidMap/Basic` defines its own `IsSector`/`HasSectors`, and nothing in wave 4's tree yet cites a wave-3 `localSectors`. **Condition**: the
     engine's general lemmas (the inversion chart, convexity near a direction, disjoint interiors of tiles' cones) go in `Plane/LocalStructure` as public lemmas,
     not private to `RingGerm`, so wave 4 can use them. Alternative weighed: `localSectors` strictly first (item 132). Why not: the two leaves gate wave 3's
     landing and the cheaper route is complete; FS131-I4b has 50-odd leaves that do not need sectors. **Routed**: I ask I4b which shape its six sector-leaves
     need (the plan's branch list, or its own `HasSectors` with directions), and relay the answer to I3g. Confidence: medium-high.
136. **FS131-I4b's answer on the sector shape** (message 2026-10-04, verbatim in its essentials): "my IsSector/HasSectors alone are not enough; the plan form
     (branch germs) is what the leaves read." What the six leaves need at `v ∈ dom`: (1) finiteness and stabilisation — for small `r` the set of sectors is
     finite and its count constant in `r`; (2) description by branches — "for v in dom, some r₀ and a finite list of branch germs (direction + signed curvature,
     or a segment direction) whose union is the arcs in ball v r₀, such that for r < r₀ the sectors are exactly the regions between consecutive branches", each
     sector's cone an angle interval, and a one-direction cone's sector equal to a `hornSet` with the bounding curvatures; (3) the disjoint-interiors lemma,
     convexity near a direction, and the inversion chart "would serve directly". Its bridge lemma, in wave 4's vocabulary: "for v in dom, eventually in r, every
     S with IsSector v r S either has a cone of nonempty interior, or ∃ β κ₁ κ₂, S = hornSet v β κ₁ κ₂ r with κ₁ < κ₂, and the number of sectors is constant."
     **Ruling**: FS131-I3g states `localSectors` in wave 3's plan form, in wave 3's vocabulary, with each branch germ carrying its tangent direction and signed
     curvature (0 for a segment) and the sectors for `r < r₀` the regions between consecutive branches — finiteness and stabilisation included; the bridge
     lemma, which needs wave 4's `IsSector` and `hornSet` (defined only in wave 4's tree), is a wave-4 child for FS131-I4b or its successor. Alternative: state
     the bridge in wave 3. Why not: wave 3 cannot see wave 4's definitions. Confidence: high.
137. **Kooshi, 2026-10-04 (verbatim)**: *"I've just checked back in and seen the Opus result. Yes, all implementers should be Opus based on those results. Thank you
     for the experiment."* — and: *"What does the general quality of the code look like so far? I'll authorize another special case auditor for what we've
     implemented so far."* **Filed**: `.claude/output-styles/keryx.md` § Staffing (models) and its lanes table, `CLAUDE.md` § The pipeline (the implementer's
     model), `.claude/agents/debruijn-implementer.md` (`model: opus`, its description), the memory's model note; `scripts/identities.py check` PASS. **Applied to
     launches, not to running work**: the four Sonnet implementers now running (I2g, I3g, I4b, IW) finish on Sonnet; every successor launches on Opus, which
     counts one slot, so at most three implementers run at once (fewer than the four Sonnet halves today). **The audit**: FS131-QA1, an Opus code-quality
     auditor in a special slot outside the cap (brief follows).
138. **Brief FS131-QA1, the code-quality audit** (`debruijn`, Opus, Kooshi's special slot; `data/fs131/briefs/FS131-QA1-quality-audit.md`, gated PASS): statement
     fidelity sampled (≥ 15 row theorems, definitions unfolded to Mathlib's), the foundations' definitions, trust, measured code quality, a plain verdict
     with ranked findings; read-only everywhere. Keryx's own counts before it (for comparison, not a finding): Lean files changed since `49c3abb8` — w2 13
     files ≈ 7.9k lines, w3 10 ≈ 9.7k, w4 15 ≈ 5.9k, ww 19 ≈ 5.9k (the last two include earlier waves' skeleton files); no `maxHeartbeats` raised and no
     linter switched off in any of them.
139. **FS131-E2 mid-job finding** (message 2026-10-04; `plans/FS131-E2-derivation.md` stage 2, commit `a8f30705`, derive gate PASS by its report): **Q1 derived**
     (FS131-E2-U1-CUSP, hand, one mind) — in a non-Siamese **simple** fragment the four-colour clause holds with cusps: I3e's local picture needs one tile on both
     sides of the cusp, so its closure meets itself at `z` and it is not a Jordan domain. **Q2 derived** (FS131-E2-NOBOTH-CUSP) — NOBOTH's two minds handled the
     cusp ("a cusp horn included", N3; "a horn inside a γ-sector already splits it", NB3 §1.4): a tile wrapped round a cusp counts as a repeated colour, so wave 4's
     `noBoth` stands. **The monster, exact** (FS131-E2-MONSTER, `tools/fs131_e2_frag.py`): a valid non-Siamese fragment with a both-kind unit arc at 0, a horn tile
     with a cusp at 0, one tile on both sides of it, three colours at 0, every hypothesis of `four_of_bothKind` as stated at `05cb0a3e` met — **so that form was
     false, and item 112's `β₁ < β₂` was needed**; the repaired form is not refuted. **The model** (FS131-E2-MODEL): a simple fragment with a cusp at a both-kind
     centre and four colours — the case is real. Keryx's receipt: `--variant monster` prints "FRAG ALL OK", `--plant recolour` "FRAG FAIL (3)"; NB3's sentence
     read at `plans/FS112-NB3-verification.md` §1.4. **Correction owed to item 112**: "held only with no cusp at `z`" is wrong for the simple class — the hand
     clause stands in full there (one mind); the general class form needs non-degenerate cones (the monster). **Ruling — the strengthening**: `hnc` in
     `four_of_bothKind_simple` is mathematically unnecessary; E2's separation lemma (`Simple.coneAt_eq_angleIcc_sep`, its § 2.7: a tile's cone is an interval
     whose open interior no other tile's cone meets), from `localSectors` and the planned `jordan_two_branches`, removes it (§ 2.4's proof shape), and wave 4's
     `noBoth` needs the same separation. FS131-I3g states the separation lemma beside `localSectors`, and restores `four_of_bothKind_simple`'s `05cb0a3e` statement
     (no `hnc`) if its budget allows; otherwise wave 3 lands with `hnc` and a successor adds the stronger form after. Alternative weighed: require it before
     landing. Why not: the two `RingGerm` leaves gate the landing and nothing in Lean consumes the simple form yet. Confidence: high.
140. **FS131-E2 answered item 112** (report `data/fs131/reports/FS131-E2.md`; record `plans/FS131-E2-derivation.md`): the four-colour clause of FS116-V5-U1 **holds with cusps** in the non-Siamese simple class (FS131-E2-U1-CUSP, [hand], one mind); FS112-N3-NOBOTH holds with cusps in every valid map (FS131-E2-NOBOTH-CUSP; its two minds had the case in a clause). Item 112's "held only with no cusp at `z`" is withdrawn; no hand consumer inherits anything (§ 3.1); no ledger row or `CLAUDE.md` statement changes. The skeleton's general `four_of_bothKind` (05cb0a3e, `β₁ ≤ β₂`) is **false**: FS131-E2-MONSTER, an exact valid non-Siamese fragment, simple but for one tile wrapped round a cusp, three colours at a both-kind centre — so the ruling's `β₁ < β₂` was needed there. `four_of_bothKind_simple` holds **without `hnc`** through a separated-interval lemma on `localSectors` (`Simple.coneAt_eq_angleIcc_sep`, record § 2.7). *(E2's draft 1, filed verbatim.)* **FS131-E2 done, harness ≈ 460k** (report `data/fs131/reports/FS131-E2.md`; commits `21f307d5`, `a8f30705`,
     `def966a2`, `b4a71151`, checked; Keryx's run of the derive gate: PASS, three controls each firing on its fault). Q3: every consumer survives as stated.
     Results beside Q1–Q2: FS131-E2-SECT [hand], -ONESECT and -SEP [derived] (sector separation; one sector per tile in a simple map; a tile's cone a closed
     interval whose open part meets no other tile's cone); generalization — the clause needs only "non-Siamese, every tile at `z` one sector at `z`".
     Predictions P1–P4 met (mean Brier 0.024; registered after reading the arguments). **Filed verbatim from its § 3.4** (this commit): draft 2, a dated note
     under FS116-V5-U1 (`plans/FS116-derivation.md`: "two further colours" reads "a colour other than `c`, `c′` in each side cone"; V5's PAIR derivation does not
     read the entry); draft 3, `plans/FS116-N3-proof.md` § 2.1 (c) (removing the repeated colour also needs simple); draft 4, `plans/FS129-derivation.md` under
     FS129-SR1-BENDLE3 ("one sector per tile", not "one cone per tile"). **For wave 4** (relayed with the `localSectors` commit): `noBoth`'s proof must run on
     `IsSector` sectors with SECT's separation, not on tile cones; formal consumers of `four_of_bothKind_simple` (C17, FS129-SR1-BENDLE3; DICHO and SEMI if they route
     through it) inherit `hnc` until it is dropped (item 139's ruling).
141. **Brief FS131-LEB, Lebesgue's covering theorem for the square** (`debruijn` planner, Opus; `data/fs131/briefs/FS131-LEB-lebesgue.md`, gated PASS): a
     self-contained module on its own branch `fs131-leb` (worktree `.claude/worktrees/fs131-leb` from `main` at `bbee15f0`; packages symlinked, build copied
     from `main`'s), so it lands on `main` ahead of wave 4 and Woodall's chain; source read and bibliography row proposed (item 66's debt); it may prove leaves
     itself. Launched in E2's Opus slot: 0.5 × 4 (IW, I2g, I4b, I3g) + 1 (LEB) = 3, plus QA1 in the special slot.
142. **FS131-QA1 mid-job findings** (message 2026-10-04): (1) **Statement says less than its row — FS106-TS-T's Condition-5 and Condition-6 clauses**
     (`fs131-w4`, `Plane/SVMap.lean`, `ts_t_trichromatic` line 348, `ts_t_degree_three` line 357): the row reads "with Condition 5 it is trichromatic, with
     Condition 6 of degree 3"; the Lean drops `Condition5` and assumes `h3 : ∀ x, (F.coloursAt x).ncard ≤ 3`, which makes "trichromatic" immediate from
     TS-T's `≥ 3`. The row's content — Condition 5 ⟹ at most three colours, S–V Lemma 2 almost everywhere (SB § 2.1 A5) — is neither formalized nor on the
     named-hypothesis list; the docstring cites ruling 53, written for FS110-N4-STUCK, and FS110-NB-4 gives "no vertex of four colours (nor five)" only in a
     tight six-map in 𝓜_K under Condition 5, narrower than every almost-everywhere-proper map. Keryx's receipt: the two statements and their docstring read at
     those lines. **Ruling**: TS-T's Condition-5 and -6 clauses are held **over S–V Lemma 2's conclusion** ("every point carries at most three colours"), a
     carried hypothesis; it joins the named hypotheses (`Row130M1`, `hR78`, `hR88`, `hR88per`, `Voronov11`) for the close, and FS106-TS-T's regrade must say
     "Condition-5 clause over S–V Lemma 2's conclusion". The statements stay as they are now. **Owed at wave 4's landing**, to a planner: state the clauses
     with `F.Condition5`, with S–V Lemma 2 (in the class it holds) as a named lemma or an imported `axiom` with `LEAN.md` § Assumptions' four items — or
     confirm the carried form. Alternative weighed: restate now. Why not: no consumer reads these two clauses yet, and the class S–V Lemma 2 holds in needs a
     planner's reading first. Confidence: high for the record; the restatement's form is the planner's. Credit QA1.
     (2) **Six cross-branch name collisions** (`tools/fs131_qa1_dupes.py`, `data/fs131/qa1/dupes.txt`): `Plane.framePt` (w2 `Slack` vs K4's `ValidMap/Basic`,
     different definitions), `Plane.dist_rot` (w2 vs w3, different statements), `Plane.eq_norm_mul_e_arg` (w2 vs w3), `Plane.e_add_int_mul_two_pi` (w3 vs ww,
     different forms), `Plane.e_mul_conj_e` (w3 vs ww, identical), `Plane.abs_dot_le` (w4 vs ww, identical). **Ruling**: at every landing merge, after merging
     `main`, the landing implementer runs `tools/fs131_qa1_dupes.py`; the branch landing later renames its copy (different statements) or deletes it and uses
     the landed one (identical), before the gate. Added to the landing procedure in the handoff and to every implementer brief from now on. Confidence: high.
143. **FS131-I4b handed back at stage 4, harness ≈ 320k** (report on its branch; `fs131-w4` at `f1f26a8a`, checked): six leaves — FS112-ISO (`ArcMap.iso`, all eight
     clauses, and `isoCol_locallyConstant`), `l60_eq_third` (over two wave-3 `sorry`s, so `sorryAx` until wave 3 lands), FS106-L's adversary
     `not_lemmaL_of_not_mem`, `bowtieArcs_nondegenerate`, `bowtieArcs_locallyFinite`; 54 left. Keryx's receipt: `data/fs131/i4/build-i4b-stage4b.log` (w4) "build:
     OK — 442 of 442 batches", exit 0; 54 `sorry` by count (BaseSteps 20, UnitArc 20, Contact 10, SVMap 4). **Corrections owed to wave 4's plan** (for the next
     wave-4 job): `lemmaL`'s sweep route (§ 13.5) is incomplete — the sweeps are open with `S_A ⊆ cl B`, `S_B ⊆ cl A`, but the contradiction needs `S_A ∩ S_B ≠ ∅`,
     a two-dimensional covering step the plan does not state; `lock` clause 1 (§ 4.17) needs N-E2 between the outer tile at `w` and a second tile of colour
     `c′` to exclude `P + 2e(θ)` — validity at `w` alone does not. Tool defect (I4b's): the scratch mirror's `chk.sh` can elaborate a name the real build
     lacks (`Real.pi_gt_three`); every stage ends with a real build. About 20 of the 54 wait on `localSectors` (item 132). Pace: about six leaves per 250k at
     this difficulty on Sonnet. **Next on wave 4**: an Opus implementer (item 137), when a whole slot is free — the half slot I4b freed stays empty until then.
144. **FS131-QA1 done, harness ≈ 380k** (report `data/fs131/reports/FS131-QA1.md`; record `plans/FS131-QA1-audit.md`; commits `1905567e`, `bbee15f0`, `e7a91c31`, `2153ea8e`,
     `ce54a729`, `b27070a2`, checked): **overall B+** — statement fidelity and trust A−, engineering hygiene B. Fidelity sampled on 22 statements across 20 rows
     in all five bodies: 17 the same as their row or stronger; 3 changed by recorded rulings and right (COVER-SC, FACE-SHARP, RINGBAND (iv)); 1 a frame that
     holds less than it reads (FALC-HOSTS (iv)); 1 weaker with no ruling (TS-T's Condition-5/6 clauses — ruled at item 142). Definitions: no trap; every carrier
     with an example and a counter-example; eight small findings (D1–D8). Trust: one axiom in ≈ 30,000 lines, read back, four items done, used once as
     declared; no `native_decide`, no raised heartbeats; the named hypotheses used as declared. Quality: low brittleness (72 mid-proof bare `simp`), median
     proof 4–10 lines, six long concrete proofs (129–288 lines), no dead or WIP code, docstrings ≈ 100 % but for 84 wave-2 theorems; all 2,258 declarations
     public in one namespace — the cause of the name collisions. Wave 3's seven skeleton statement changes break nothing in wave 4 or Woodall's chain.
     Keryx's receipt: `scripts/axioms.sh` lines 86–104 read — the CLEAN section is checked only for `native_decide` and `sorryAx`, so a CLEAN record carrying an
     imported axiom would pass (the tool defect is real); FALC-HOSTS (iv)'s docstring read at `Arith/FalconerField.lean` 270–274.
     **Rulings on its held items**: (a) TS-T — item 142. (b) **The two gate defects** — the axiom gate's CLEAN section gets a subset check (the standard three
     only) and an IMPORTED category for declared outside theorems; the vacuity scan tracks `CPColouring` and `AeProperRegions` (empty at `k ≤ 1`, as
     `AeColouring` was) — one project-tooling job, **FS131-T3** (Opus implementer, on `main`), queued for the next whole slot, to land before wave 2 or 4 does.
     (c) **Merge order**: by readiness (wave 3 is nearest), each landing implementer resolving the append points and running the duplicate tool (item 142);
     not a fixed order. (d) **Corrections owed to wave 2, before it lands**: FALC-HOSTS (iv)'s docstring says the frame proves only "a fan's `t − a` is a
     non-zero forced difference of `R`", the fields and `P = R ∩ 𝔓⁴` entering only on instantiation (and its ledger line at the close); docstrings for the 84
     wave-2 theorems (`tools/fs131_qa1_quality.py` checks; `linter.missingDocs` does not check theorems) — both in wave 2's next brief. (e) **Before
     publication** (D-class): the duplicated vocabulary across branches (`unitShadow`/`shadow`, `essMulticolour`/`essColours`, `IsContactFor`/`SaturatedAt`,
     `ne1_region`/`not_mem_coloursAt_of_dist_eq_one`, `dot_sub`/`dot_sub_left`) unified, and the home-made `dot` replaced by Mathlib's real inner product on `ℂ`;
     helper lemmas made `private` or namespaced. **Held for Kooshi**: a second audit pass over the statements no implementer has reached (wave 2's 13 `sorry`
     row theorems, wave 4's 113 skeleton statements); default, not run — each implementer reads its statements back as it reaches them. Tools kept:
     `tools/fs131_qa1_decls.py`, `tools/fs131_qa1_dupes.py`, `tools/fs131_qa1_quality.py`, each with a self-test and a watched control. Credit QA1.
145. **FS131-I3g mid-job** (message 2026-10-04; commit `81608c71` on `fs131-w3`): `four_of_bothKind` and `flank_edge_exists` **proved** (scratch axioms: the standard
     three); the inversion engine public at the end of `Plane/LocalStructure` as item 135 required (`Rgn`/`levD`/`invC` chart, `isPreconnected_Rgn_lev`,
     `GoodAt.exists_wedge`, `coneAt_interiors_disjoint`, `exists_initialPiece_of_cone`, `Arc.exists_initialPiece_of_approach`). Left: `sixFrag_valid`,
     `sixFrag_nonSiamese`, then `localSectors` (branch form) and `Simple.coneAt_eq_angleIcc_sep`; I3g takes `localSectors` next, while its engine is fresh, and
     the `SixFragment` leaves after if budget allows. Accepted without a message: wave 4 has no implementer running, and the engine is the cheaper thing for
     this context to finish. Keryx's receipt: the commit exists; `sorry` lines by count — `RingGerm` 0, `SixFragment` 2, `LocalStructure` 0.
146. **FS131-LEB mid-job: Lebesgue's covering theorem for the square proved in full** (message 2026-10-04; branch `fs131-leb`): no `sorry`, build green, standard
     three axioms by its report; the gate running. Modules `Topology/SpernerGrid` (Sperner's lemma on a triangulated grid, a mod-2 door count) and
     `Topology/LebesgueCovering` (Lebesgue number lemma, grid, least-index labelling; Hurewicz–Wallman's grouping, Thm IV 2, pp. 42–44 of the 1948 edition, read
     from an archive.org scan), namespace `HadwigerNelson.LebesgueCovering` (chosen so wave 4's `open … Topology` cannot make `closedSquare` ambiguous). Wave 4's
     `sorry` discharges in one line, tested against a verbatim copy (`data/fs131/leb/Wave4Bridge.lean`). Generalizations proved: any closed rectangle and any
     finite index type (`lebesgue_covering_rect`); the cubical KKM three-set form (`exists_mem_inter_three`); read off the proof, not stated: the top/bottom
     hypothesis is needed only for sets missing the left side. No statement defect; wave 4's statement true and not vacuous. **The landing is a ruling of
     mine** (its brief, Done means 6), on the gate's saved logs at its report.
147. **FS131-I3g handed back at stage 7, harness ≈ 425k** (report on its branch; `fs131-w3` at `93ca3468`, checked): `four_of_bothKind` and `flank_edge_exists` proved,
     statements unchanged (item 145); the inversion engine public (`coneAt_interiors_disjoint`, `GoodAt.exists_wedge` — wave 4 can use it directly —,
     `isPreconnected_Rgn_lev`, `exists_initialPiece_of_cone`, `Arc.exists_initialPiece_of_approach`); 110 audit records added. Keryx's receipt: build log
     `build/gate/build/20261004T124303Z-3587986.log` (w3) "Build completed successfully (5348 jobs)", exactly two `sorry` warnings (`SixFragment` 844, 849);
     `tools/fs131_k3b_decls.py --check` "400 names, 0 missing". Not started (budget): `localSectors`, the separation lemma. **Brief FS131-I3h**, wave 3's first Opus
     implementer (`data/fs131/briefs/FS131-I3h-wave3.md`, gated PASS): the two `SixFragment` leaves, the gate, the landing; then `localSectors` and the separation
     lemma (and `four_of_bothKind_simple` without `hnc`) on `fs131-w3b` from the landed `main`. Ordered ahead of FS131-T3 and wave 4's Opus implementer: wave 3 is
     the nearest landing, and T3's gate fix concerns imported axioms, which wave 3 has none of. Launched in the whole slot I3g and I4b freed: 0.5 (IW) + 0.5
     (I2g) + 1 (LEB) + 1 (I3h) = 3.
148. **FS131-I2g handed back at stage 12, harness ≈ 457k** (report on its branch; `fs131-w2` at `59976a11`, checked): 26 `sorry` lines closed (117 → 91).
     **FS129-SA1-FALC-RED sorry-free** — `falconer_reduction` and `le_chiM_of_falconerFan`, on the standard three plus the declared import
     `falconer_lemma2_nonempty` (informally: a Falconer fan with irrational angle at `k` colours makes every cover of the plane by `k` measurable sets carry a
     unit pair in one set, so `χ_m(ℝ²) ≥ k + 1`); `Plane/Cover` and `Plane/FalconerReduction` sorry-free; eight Dyadic children (incl. `comap_conductor_sup_eq_top`
     by a 2×2 trace system, no `Algebra.discr`) and seven Slack leaves; item 134 applied in its five declarations. Keryx's receipt: build log
     `build/gate/build/20261004T124458Z-3603574.log` (w2) "Build completed successfully (5619 jobs)", 91 distinct `sorry` warnings, 91 `sorry` lines by count;
     `data/fs131/i2/i2g-axioms.txt` prints `falconer_reduction` with the declared import beside the standard three. **This is the first record that QA1's gate
     defect (item 144 (b)) would misfile** — `le_chiM_of_falconerFan` sits in the CLEAN block and the CLEAN check does not reject the import — so FS131-T3 must
     land before wave 2's gate. Left: Slack 39, CoverExamples 44, Dyadic 4 (`dyadicConclusion_of_minpoly`, the Kummer–Dedekind engine, the hard one), YesLimit 4
     (waits on `chiM0_le_iff_muZero_eq_one`). Recipe: `QuasiMeasurePreserving.ae` times out unless `(p := …)` is explicit. Its re-pricing: about a third of
     K2c's table at the Sonnet rate. The half slot it freed waits for a whole one (implementers are Opus).
149. **A stray wait loop stopped** (Keryx): FS131-I2g left a shell loop in `fs131-w2` (PID 3517281, 28 min) waiting for its build log's **last** line to contain
     "build: "; the build finished OK at 07:36 (`build/gate/build/20261004T122644Z-3444226.log`) but printed that word on the second-to-last line, so the
     loop would never end, and on ending it would have resumed I2g past its hand-back. Killed by PID; it forfeits nothing (a `sleep 10` poll, no work). Lesson
     for briefs: a wait loop matches the build's result line anywhere in the log's tail, not only its last line.
150. **FS131-IW handed back at stage 3, harness ≈ 537k** (report on its branch; `fs131-ww` at `a731f352`, checked): `Plane/Woodall/Collar` (15) and
     `Plane/Woodall/NoFourFive` (20) **sorry-free**; in `Steps`, `SectorsAt.coloursAt_eq`, `exists_three_le_sectors`, **`false_of_four_le_sectors` (E1-NO45)**,
     `aeMap6_merged`, `aeMap6_normal`, `aeMap6`, `aeMap6_of_condition5`, `woodall_thm6` proved; 4 left (`exists_sectorsAt`, `exists_woodallMerged`, `step5_lt`,
     `step6`). **E1-NO45's argument closed in Lean as planned, from its citations** (`step6`, `exists_sectorsAt`, and three unlanded statements: `lemmaL`,
     `ArcMap.dense_interiorPts`, `ArcMap.Valid.unitPairsNull_region`) — E1-BAD's count, E1-COVER on colour classes, the refined second-order lemma, the avoiding
     arc, the three-colour point: **the check item 111 asked for, done for the argument; its citations are the open part.** Townsend's π/3 lemma and Woodall's
     strict step-4 lemma (with the 2π/3 sharpness example) and engines A–D proved, over `lemmaL`. No statement defect. Keryx's receipt: build log
     `build/gate/build/20261004T125346Z-3674506.log` (ww) "Build completed successfully (5346 jobs)"; `sorry` lines Collar 0, NoFourFive 0, Steps 4;
     `tools/fs131_w2_decls.py --check` "115 theorems, 115 records; 0 missing, 0 stale"; the iteration axiom summary lists 90 of 115 records clean, E1-NO45 among
     those carrying `sorryAx` through its citations. **Plan gap**: `step5_lt` and `step6` need a preconnected piece of a colour class approaching the point along
     a cone direction (a horn included) — a child lemma, not a statement change. Order fix (IW's): `aeMap6_merged` moved after `aeMap6_normal`. Slip (IW's): its
     first build was not "as given". Over its line (537k): not a slip. **Brief FS131-IWb** (Opus; `data/fs131/briefs/FS131-IWb-woodall.md`, gated PASS): the
     child lemma, then the four leaves. Launched in the whole slot I2g and IW freed, ahead of T3 and waves 2 and 4 by bearing (route M's link, nearest
     completion): 1 (LEB) + 1 (I3h) + 1 (IWb) = 3.
151. **FS131-LEB done and LANDED on `main`** (report `data/fs131/reports/FS131-LEB.md`; record `plans/FS131-LEB-kernel-plan.md`): **Lebesgue's covering theorem for
     the square held in the kernel** — `HadwigerNelson.LebesgueCovering.lebesgue_covering_square`, wave 4's statement verbatim, on `[propext, Classical.choice,
     Quot.sound]` — with `lebesgue_covering_rect` (any rectangle, any finite index type), `lebesgue_covering_rect'` (a set touching the left side may run bottom
     to top; strictly wider — wave 4's hypotheses force four sets), `exists_mem_inter_three` (the cubical KKM form), Sperner's lemma on the triangulated grid
     (`HadwigerNelson.SpernerGrid.exists_rainbowCell`, a mod-2 door count) and a model of the hypotheses (`quadrant_hypotheses`); 549 lines, two modules
     `Topology/SpernerGrid`, `Topology/LebesgueCovering`. The planner proved it outright. **Landing (Keryx's ruling, its brief's Done means 6)**: the gate green on
     `18735b71`'s Lean content (build 440/440 with no warning, axioms OK 1292 clean, vacuity OK, self-test OK, architecture PASS, `#lint` 0 errors, the wave-4
     bridge's planted fault failing to elaborate); `main` (`f20f7d46`, no Lean change since `bbee15f0`) merged in (`44009804`), the gate re-run on the merged
     commit — build "all 1728 modules already up to date … 0 module(s) with warnings", "axioms: OK — 1292 clean, 11 axiom-free, 5 declared purchase(s)",
     "vacuity: OK", "vacuity self-test: OK", architecture PASS, no `sorry` (`data/fs131/leb/gate.status` all 0) — logs committed (`33471a75`); `main`
     fast-forwarded to `33471a75` and pushed. Keryx's receipts: every log above read; the statement read at `Topology/LebesgueCovering.lean` line 300 against
     wave 4's `Plane/SVMap` statement (identical); `gate_report.py` — CLAUDE.md § Trust ledger "match (clean and purchases compared)", the baseline header and
     CLAUDE.md § The gate "match (9 of 9 compared)" after filing. **Filed** (this commit): CLAUDE.md § Trust ledger (1292 clean, 5 declared purchases, 11
     axiom-free, 1,308 records) and § The gate (`declarations=7673`; the site counts unchanged); `scripts/vacuity-baseline.txt` header; `BIBLIOGRAPHY.md` rows
     `[HurewiczWallman1948]` and `[VanderWoude2023]` (both fetched into `~/source/library/pdf/`, title pages and page counts checked: 184 and 30 pp.) — item 66's
     prior-art debt closed; `LEAN.md` § Searching — Lean, two lines (the `HadwigerNelson.X` namespace-shadow trap; `push_neg` deprecated at the pin). **For
     wave 4's next implementer**: discharge `lebesgue_covering_square` with `:= LebesgueCovering.lebesgue_covering_square c hs F hF hcov hLR hBT`, import
     `Proofs.HadwigerNelson.Topology.LebesgueCovering` in `Plane/SVMap` (and its `ARCHITECTURE.md` Imports cell), drop the "disposition owed" sentence, and
     cite the 1948 printing (Thm IV 2, p. 42); ruling 66's axiom fallback retired. Also owed: `ARCHITECTURE.md` § 3's prose counts were already stale on `main`
     (true: 1,725 `.lean` files and 165 imported modules at `bbee15f0`) — for the next filing. Stub, only if a consumer appears: the `n`-cube form.
152. **The fact audit on item 151's filing** (`tools/claude_md_fact_audit.py --base 47a6ad6a`): six flags, every one a superseded gate count replaced in place —
     `declarations=7624 refutations-skipped=45 sites=357` (code), `declarations=7624` (chunk), `1285`, `1301`, `7624` (num) — which `CLAUDE.md`'s current-state
     rule requires to go (the old values are in git: `47a6ad6a`); nothing else lost, no pointer dangling, the PROTECTED regions intact; `--dupes` unchanged.
     Slip (Keryx's): the filing was committed in the same command that ran the audit, before its output was read; the result was read after and is as above.
     Audits run before the commit from now on.
153. **Brief FS131-T3, the axiom gate** (`debruijn-implementer`, Opus, project tooling on `main`; `data/fs131/briefs/FS131-T3-axiom-gate.md`, gated PASS): CLEAN checked
     as a subset of the standard three; an IMPORTED section for records resting on a declared outside theorem, the declared list in one documented place;
     `scripts/gate_report.py` counting it; controls watched firing; the procedure by which a wave declares an import; drafts for the Trust ledger sentence.
     **Scope change from item 144 (b)**: the vacuity half (`CPColouring`, `AeProperRegions`) is not T3's — those carriers exist only on waves 2 and 4's branches,
     so each wave registers them at its own landing (added to their next briefs). Launched in LEB's slot: 1 (I3h) + 1 (IWb) + 1 (T3) = 3.
154. **Statement defect — a definition: `SectorsAt`'s fifth clause makes `exists_sectorsAt` false** (FS131-IWb, message 2026-10-04; `fs131-ww` at `a731f352`,
     `Plane/Woodall/Basic.lean` line 66, `Plane/Woodall/Steps` `exists_sectorsAt (hP : F.IsPlaneMap) (v : ℂ) : ∃ n d c, F.SectorsAt v n d c`): the clause
     `annSector v 0 r (d i + δ) (d (i+1) − δ) ⊆ F.region (c i)` fails for a sector merged across an arc between two same-coloured sides. Smallest counterexample:
     one colour, one segment `Arc.seg (−1) 1`, `v = 0` — no picture (`n ≥ 2` needs adjacent colours to differ; at `n = 1` the open range of length `3π/2` holds a
     direction of the segment, whose points are not interior). The same happens in a valid map (the hexagonal seven-colouring with a slit inside a hexagon, at
     the slit's midpoint) and at three-colour points with a split class — where the consumers (E1-NO45, `exists_three_le_sectors`) apply it. Keryx's receipt: the
     clause and the theorem's hypotheses read at those lines. **Ruling**: drop clause 5 from `SectorsAt`. Only three proofs read it (E1-RAY inner and outer,
     `NoFourFive` 692 and 706; E1-BAD's interior case `not_mem_coloursAt_of_mem_Ioo`, 1088), each re-proved from the cone clause — E1-RAY through wave 3's
     `coneAt_region_eq_biUnion` and a preconnected tile (the connected-piece child lemma), E1-BAD's interior case by inner and outer collars and the robust kill —
     with no statement change; `exists_sectorsAt` then follows from wave 3's engine (`GoodAt.exists_wedge`) without `localSectors` (priced H, 600–900 lines). FS131-IWb
     may edit that one definition and re-route those three proofs. Alternative weighed: weaken it to `⊆ closure (F.region (c i))`. Why not: it keeps nothing
     the readers need once they go through the cone clause, and it makes `exists_sectorsAt` need the colours along each tangent branch. Confidence:
     medium-high — if a re-route fails, it comes back. Credit IWb: a definition defect found before anything was built on its false leaf.
155. **Item 154 refined — clause 5 replaced by `v ∈ F.dom`, not deleted** (FS131-IWb, message 2026-10-04): with the clause simply dropped, E1-RAY
     (`SectorsAt.collarAt_shadow_inner_of_mem` / `_outer_of_mem`) is false, because its re-route through wave 3's `coneAt_region_eq_biUnion` needs the point in
     the domain. Counterexample: `v = 0 ∉ dom`, colour 0 on radial pieces `⋃ₘ annSector 0 2^(−2m−1) 2^(−2m) a b` with gaps accumulating at 0, colour 1 on the
     open sector `(b, a + 2π)`, no arcs — the picture `n = 2` meets every other clause, and the inner collar falls in a radial gap infinitely often. **Ruling**:
     clause 5 becomes `v ∈ F.dom` at the same position (no projection moves; true wherever `exists_sectorsAt` produces a picture, since `hP` makes the domain the
     plane; `const_sectorsAt` still holds), and the three readers re-route as item 154 says, with `hv` from the new clause. Alternative: drop it and add `v ∈ F.dom`
     as a hypothesis to E1-RAY and its callers. Why not: a hypothesis on every caller where one clause carries it once. Confidence: high. Credit IWb.
156. **FS131-IWb handed back at stage 6, harness ≈ 438k** (report on its branch; `fs131-ww` at `f73cb1e3`, checked): `step5_lt` (Woodall's strict step 5) and `step6`
     (Townsend's π/3 lemma) **proved**, statements unchanged; the connected-piece child `exists_preconnected_of_mem_coneAt` proved (with the inner and outer collar
     corollaries); items 154–155 applied (`SectorsAt`'s fifth clause now `v ∈ F.dom`; E1-RAY and E1-BAD's interior case re-routed through the cone clause — they
     now cite wave 3's `coneAt_region_eq_biUnion`, so carry `sorryAx` until wave 3 lands). Keryx's receipt: build log
     `build/gate/build/20261004T133104Z-3845273.log` (ww) "Build completed successfully (5346 jobs)"; `Steps` has 2 `sorry`; `SectorsAt` reads `v ∈ F.dom ∧` at its
     fifth clause. Corrections owed to W's plan: `step5_lt` needs no δ or truncated sector; `step6` needs no "at most three cut angles". Generalization:
     `SectorsAt.collarAt_opposite` for any `n ≥ 1`, no validity. Left: `exists_sectorsAt` (H, 600–800 lines; route in its record's stage 6 on wave 3's engine, or a
     bridge from I3h's `localSectors`) and `exists_woodallMerged` (Woodall's step 3, re-priced H+, 1,500–3,000 lines, **no derivation of the global
     modification with every clause in the record** — FS110-W-MERGE is the local step). **Rulings**: (a) `exists_sectorsAt` goes to the chain's next implementer by
     the stage-6 route, a bridge from `localSectors` its call if that lands first; (b) step 3 goes to a derivation first — **FS131-E3** (Ephodos; claim list
     `data/fs131/claims-E3.md`; brief `data/fs131/briefs/FS131-E3-woodall-step3.md`, gated PASS): Q1 the modification as the Lean states it, Q2 a route around it.
     Alternative: a planner straight on step 3. Why not: no derivation holds the global clauses, and a route around it would save the 1,500–3,000 lines.
     Launched in IWb's slot: 1 (I3h) + 1 (T3) + 1 (E3) = 3.
157. **Wave 3 LANDED on `main`** (FS131-I3h, report on its branch; `origin/main` fast-forwarded to the gated commit `0fdacddb` by `git push origin HEAD:main` from
     the w3 worktree; tip `0ff8f659` adds the record and report). **The second wave held in the kernel**: both `sixFrag` leaves proved (FS116-Y2-SIXFRAG validity and
     non-Siamese — the QQ pair by the Reuleaux triangle on `e(∓30°)` and `√3`, `linear_combination` with `s² = 3`; the pieces in polar bands of interior points),
     all 502 wave-3 records on the standard three or fewer. Keryx's receipts: build log `build/gate/build/20261004T135527Z-4016354.log` (w3) — "All targets
     up-to-date (5350 jobs)", 0 warnings; `gate_report.py axioms` on `build/gate/axioms/20261004T135536Z-4017034.log` — "1810 records — 1794 clean …, 11 axiom-free,
     5 declared purchase(s)", `sorryAx` 0; vacuity `build/gate/vacuity/20261004T135539Z-4017362.log` — "declarations=8385 refutations-skipped=57", "sites=459
     vacuous=0 stale=0 declared=3 witnessed=21 generic=433 unknown=2"; `check_architecture` PASS; `0fdacddb` an ancestor of `origin/main`. Vacuity carriers
     registered: `IsRingArc`, `IsChangePoint`, `IsHub`, `IsQArc` IN; `IsEssBoundary`, `SaturatedAt` OUT (reasons beside the list). Corrections owed and filed
     at the next main-tree commit: `CLAUDE.md` § Trust ledger and § The gate, `scripts/vacuity-baseline.txt` header (drafts in its record). Fixed by I3h:
     `ARCHITECTURE.md` Imports cells of `Plane/LocalStructure` and `Plane/Lens`. Cosmetic tool defect: the self-test still prints "twenty planted defects" for 32
     expectations. Collisions with the landed wave 3 (`data/fs131/i3/dupes-h.log`): `dist_rot`, `eq_norm_mul_e_arg` (w2), `e_add_int_mul_two_pi`, `e_mul_conj_e`
     (ww) — those branches rename at their merges (item 142). **Coordination**: the main tree's `main` sat 71 commits behind with FS131-T3's uncommitted edits to
     the axiom gate's files; T3 told to WIP-commit, merge `origin/main` (resolving `scripts/Axioms.lean`: 502 new records), rebuild, re-check, push; Keryx holds
     main-tree commits until it does. Not done: `localSectors` and the separation lemma (budget). **Brief FS131-I3i** (Opus; `data/fs131/briefs/FS131-I3i-localsectors.md`,
     gated PASS): `localSectors` from I3h's draft, the separation lemma, `four_of_bothKind_simple` without `hnc`, on `fs131-w3b` (from `origin/main` `0ff8f659`,
     build copied from w3's), landed by its own gate. Launched in I3h's slot: 1 (T3) + 1 (E3) + 1 (I3i) = 3. Over its line (537k): not a slip.
158. **Statement defect — definitions: `WoodallMerged` and `WoodallNormal` are unsatisfiable on every valid plane map; `exists_woodallMerged` is false at
     `k = 7`** (FS131-E3, message 2026-10-04; `fs131-ww` at `f73cb1e3`, `Plane/Woodall/Basic.lean` lines 74, 81): `SectorsAt` admits **phantom horns** — at a
     boundary direction `θ` between sectors of colours `A ≠ B`, insert a `B`-horn then an `A`-horn: adjacent colours stay distinct, `d` stays monotone, the cones
     are unchanged (θ already lies in both neighbours' intervals), so `A` repeats on a sector of positive angle and `WoodallMerged` (a `∀`-over-pictures form)
     fails; concretely at an edge midpoint of the hexagonal seven-colouring, `n = 2, d = (0, π, 2π), c = (A, B)` becomes `n = 4, d = (0, π, π, π, 2π),
     c = (A, B, A, B)`. Every valid plane map has a point of two colours with a picture, so `F′.WoodallMerged` is false for every valid plane `F′`:
     `exists_woodallMerged` is false at `k = 7`, and at `k ≤ 5` it is equivalent to `aeMap6` itself. **Consequence: `aeMap6_normal`, `aeMap6_merged` and
     `false_of_four_le_sectors` (through `hN`) hold only vacuously — item 150's "E1-NO45's argument closed in Lean … the check item 111 asked for" is withdrawn
     as stated**: the argument's steps were formalized and are sound logic, but the theorem's hypothesis is unsatisfiable, so it certifies nothing about real
     maps until the definitions are fixed and the proofs re-run (E3: small edits). Keryx's receipt: the two definitions read (∀ over every `SectorsAt` picture),
     and their only inhabitants `const_woodallNormal` / `const_woodallMerged` are the one-colour constant map, where no two-sector picture exists — which is why
     no inhabitant check caught it. **Ruling**: the ∃-forms E3 proposes — `WoodallMerged`: at every point (or every point of `≥ 3` colours) of the domain, **some**
     picture whose repeated colours are horns; `WoodallNormal`: at every point of `≥ 3` colours, **some** picture with injective colours and every angle `≥ π/3`
     — with E3 drafting their exact Lean statements and the adapted chain (its note: `aeMap6_merged`'s argument works on the picture it is handed;
     `false_of_four_le_sectors` takes the auxiliary point's normal picture from the ∃-form, `n′ = 3`; `exists_sectorsAt` then leaves the chain), and the next
     Woodall job applying them. Alternative weighed: forbid phantom horns inside `SectorsAt` (a minimality clause). Why not: E3's ∃-forms need no new clause and
     keep `SectorsAt` as the cones define it. Confidence: high on the defect (the construction is elementary), medium-high on the fix pending E3's derivation.
     **Lesson, for `LEAN.md` § The gate at the next filing**: a refutation-shaped theorem's Prop-valued hypothesis is skipped by the vacuity scan, so its
     inhabitant must exercise every clause (here: a valid map with a point of two or more colours), never a degenerate model where the clause is vacuous.
     Credit E3.
159. **The main tree current again; wave 3's counts filed** (FS131-T3's message 2026-10-04): T3 WIP-committed (`a09b2254`), merged `origin/main` (`58a1cea5`; `scripts/Axioms.lean`
     merged clean — wave 3's records under CLEAN, the new IMPORTED section above CLEAN, PURCHASED last), built (441 batches, 14 modules rebuilt, 0 warnings), and
     re-ran its audit on the merged state (1810 records: 1794 clean, all within the standard three; 11 axiom-free; 0 imported; 5 purchases; 23 controls behave)
     and pushed (`0db64494`); E3's two commits landed in between, history linear. **Filed** (this commit): `CLAUDE.md` § Trust ledger (1794 clean, 1,810 records)
     and § The gate (`declarations=8385 refutations-skipped=57 sites=459`, `vacuous=0 stale=0 declared=3 witnessed=21 generic=433 unknown=2`);
     `scripts/vacuity-baseline.txt` header; `LEAN.md` § The gate, the inhabitant rule extended (item 158's lesson). Keryx's receipts, read **before** this commit:
     `gate_report.py vacuity` — baseline header and CLAUDE.md § The gate "match (9 of 9 compared)"; `gate_report.py axioms` on `build/gate/axioms/20261004T141303Z-4086598.log`
     — "match (clean and purchases compared …)"; fact audit — losses are only the superseded counts (`1292`, `1308`, `357`, the two old count strings). The I3i
     brief, written while the tree was busy, committed here.
160. **FS131-T3 done, harness ≈ 330k** (report `data/fs131/reports/FS131-T3.md`; record `plans/FS131-T3-axioms.md`; commits `9df42b80`, `a09b2254`, `58a1cea5`, `0db64494`,
     `9afe260c`, `de4d8cc9`): the axiom gate repaired — the defect reproduced first on `main` (a planted axiom under CLEAN passed, "1293 clean"); CLEAN now fails
     any record whose axioms are not within the standard three; a new **IMPORTED** section (above CLEAN; PURCHASED stays last because
     `tools/check_architecture.py` reads everything after its banner as a purchase) holds records resting on a declared outside theorem, declared only by
     `#eval AxiomAudit.declareImport ``Full.Name` lines there (Lean refuses a name that is not an axiom under `Proofs/` whose docstring names a bibliography key);
     PURCHASED narrowed (only the standard three, native axioms and declared imports); the gate fails if `ARCHITECTURE.md` § Trust omits a declared import, and on
     any undeclared axiom in the library; `scripts/gate_report.py` counts IMPORTED and reads a three-count sentence; 23 two-sided controls, and four mutants of the
     checker each turning controls red. Four tool defects fixed on the way (shortened axiom names; PURCHASED's laxity; unaudited library axioms; a root-namespace
     purchase skipped). **Wave 2 dry run**: four records move to IMPORTED — `falconer_reduction`, `le_chiM_of_falconerFan`, `exists_mem_falconerE`, `fan_tip_ae_mem`
     (two beyond the brief's) — listed by `data/fs131/t3/wave_dryrun.sh`. **Filed verbatim from its drafts** (this commit): `CLAUDE.md` § Trust ledger's paragraph
     (three counts: 1794 clean, 5 declared purchases, 0 imported); `LEAN.md` § Trust ledger's last row and the paragraph after the table; `LEAN.md` § The gate's
     axioms item with `--self-test`. Also: `tools/claude_md_fact_audit.py`'s `GATE_CHANGES` gains the two transitions this session made ((1285, 5) → (1292, 5) at
     LEB's landing; (1292, 5) → (1794, 5) at wave 3's). Keryx's receipts, read before this commit: `gate_report.py axioms` on
     `build/gate/axioms/20261004T141303Z-4086598.log` — "match (clean, purchases and imported compared)"; fact audit `--base c6f8d56d` — "AUDIT PASSED (0
     failure(s))". Open for the tool's owner (T3's question): `GATE_RE` reads only (clean, purchases), so a change in the imported count alone passes it unseen.
161. **FS131-E3 done, harness ≈ 470k** (report `data/fs131/reports/FS131-E3.md`; record `plans/FS131-E3-derivation.md`; commits `d21f2998`, `69660332`, `64fa012f`, `81e35157`):
     **Q1 as stated FALSE** (E3-PHANTOM [hand, one mind]; E3-Q1 [derived]; item 158). **Q1 repaired in the form the chain reads — TRUE** (E3-BALL [derived,
     one mind]): every valid plane arc map has a valid plane arc map in which every point of `closedBall 0 R` of three or more colours has a picture in
     **NiceAt** form (positive-angle sectors carry distinct colours; every horn sits between two distinct colours), Condition 5 kept and not required of the
     input; finitely many merges, each by **E3-W** (Woodall's criterion with an explicit radius, by the sagitta of a unit circle in a small disc: two open ray
     segments of a unit-pair-free open set less than π apart clear the wedge up to radius `r₁ cos(α/2)/2`) — no contacts on the unit circle, no Condition 5, no
     Woodall cone. Woodall's horn-only conclusion everywhere: GAP, not needed by the chain (it would need FS110-W-MERGE's contact cone past Condition 5). **Q2: no
     modification-free route** (E3-FAKE [hand]: at a vertex reading A, B, A, C, Townsend's hypothesis fails on arcs of positive length). The chain needs NiceAt
     only on `closedBall 0 3`, only at points of three or more colours (E3-CHAIN [derived]); `exists_sectorsAt` drops out of the chain. Lean drafts in its § 4.1
     (`NiceAt`, `WoodallMerged K`, `WoodallNormal K`; `exists_woodallMerged … (R : ℝ)`, `NiceAt.normal`, `false_of_four_le_sectors` with `hN : WoodallNormal
     (sphere v 1)`, `aeMap6_normal`, `aeMap6_merged`, `aeMap6`), with non-degenerate inhabitants (`halfDisc.NiceAt 0`, a new `threeSectorDisc : ArcMap 3`) and a
     phantom-picture adversary that would have caught item 158. Price: 900–1,400 lines once `localSectors` lands, against 1,500–3,000 for the horn-only form.
     Predictions P1–P4 met. Keryx's receipts: derive gate on the record — "GATE: PASS (0 failures, 3 warnings)", three controls each firing on its fault;
     `tools/fs131_e3_phantom.py` prints `honest=True:ok merged=True phantom=True:ok phantom_merged=False` (the phantom picture breaks the ∀-form). Slip (E3's):
     its push published T3's two local commits, unchanged. **Rulings on its held items**: (a) **NiceAt adopted** as the ∃-form of `WoodallMerged` (and
     `WoodallNormal K`), localized as E3-CHAIN reads — alternative, Woodall's horn-only ∃-form; why: the chain reads NiceAt, it is proved and cheaper, the
     horn-only form is a GAP; confidence high. (b) Woodall's horn-only conclusion everywhere is **not wanted now** — no consumer; recorded as an optional stub
     (FS110-W-MERGE past Condition 5) for whoever needs it. **Next**: a planner pass on Woodall's chain (FS131-W3) applies E3's § 4.1 drafts and states E3-BALL's
     children with leaf plans, then an implementer. Credit E3: a definition defect that made a proved-looking chain vacuous, found before it was relied on.
162. **Briefs FS131-W3 and FS131-I2h** (both Opus; gated PASS): **W3** (`debruijn` planner; `data/fs131/briefs/FS131-W3-woodall-nice.md`) applies E3's § 4.1 drafts to
     Woodall's chain — the ∃-form definitions, the adapted statements, non-degenerate inhabitants and a phantom-picture adversary — re-proves the small
     adaptations, states E3-BALL's children with leaf plans (saying which need `localSectors`), and writes the handoff. **I2h** (`debruijn-implementer`;
     `data/fs131/briefs/FS131-I2h-wave2.md`) continues wave 2's 91 lines and carries the owed items: QA1's 84 docstrings and FALC-HOSTS (iv)'s docstring, the four
     imported records moved under T3's procedure, `CPColouring` registered as a vacuity carrier, the collisions with wave 3 (`dist_rot`, `eq_norm_mul_e_arg`)
     resolved at the merge; then the gate and the landing. Launched in T3's and E3's slots: 1 (I3i) + 1 (W3) + 1 (I2h) = 3. Next: wave 4's Opus implementer
     (the LEB discharge, the two plan gaps, `localSectors` once I3i lands it, `AeProperRegions` as a carrier).
163. **FS131-I3i mid-job: `localSectors` proved** (message 2026-10-04; `fs131-w3b` at `d8a3177f`, pushed), in I3h's drafted shape unchanged — `HadwigerNelson.Plane.localSectors
     (F) {v} (hv : v ∈ F.dom) : ∃ r₀ n G, F.IsSectorChart G v r₀` in `Plane/LocalStructure` § `LocalSectors`; in the same commit `ArcMap.Simple.coneAt_eq_angleIcc_sep`
     (E2 § 2.7 verbatim), `IsSectorChart.exists_tile_inter_ball` (E2's ONESECT, derived from the landed `IsJordanDomain.local_connected` — no Jordan curve theorem),
     and `four_of_bothKind_simple` **without `hnc`** (its `05cb0a3e` statement; item 139's strengthening done — the four-colour clause of FS116-V5-U1 now holds in
     Lean for simple maps, cusps included, once the gate reads it). Build green, 0 warnings; scratch axioms the standard three. Exported for wave 4:
     `isSectorChart_of`, `BranchGerms.dir_lt_nextDir`, `Mono.disjoint`, `exists_angle`, `Mono.not_mem_angleIoo`, `coneAt_sector`, `sector_nonempty`, inhabitant
     `halfDisc_sectorChart`. Keryx's receipt: the commit exists on `origin`, and the theorems read at that commit. Next: its gate and landing. Relayed to FS131-W3.
164. **FS131-W3 mid-job: Woodall's chain restated on E3's repair and re-proved** (message 2026-10-04; `fs131-ww` at `89a4aad0`): E3's drafts applied verbatim —
     `NiceAt`, `WoodallMerged K`, `WoodallNormal K` (∃-forms); `NiceAt.normal`, **`false_of_four_le_sectors`** (now with `hN : WoodallNormal (sphere v 1)`),
     `aeMap6_normal`, `aeMap6_merged` (over `closedBall 0 3`) and `aeMap6` **proved** on the satisfiable definitions; non-degenerate inhabitants (`threeSectorDisc`,
     a valid disc of three `2π/3` sectors, in both forms on the whole plane; `halfDisc`) and **phantom adversaries** (`threeSectorDisc_not_forall_merged`,
     `_not_forall_normal`: the old ∀-forms fail there); `exists_sectorsAt` and `exists_three_le_sectors` out of the chain. `main` merged (`6e681acb`, wave 3 and LEB):
     collisions resolved (`e_mul_conj_e` deleted as identical; `e_add_int_mul_two_pi` renamed `e_add_two_pi_mul_int`). **None of E3-BALL's children needs
     `localSectors`**: wave 3's landed `GoodAt` engine supplies every local fact (thin cones off finitely many directions; in a good ball only the centre
     carries three colours, so three-colour points are finite on compacts; the NiceAt picture chart-free; the merge an `ArcMap.recolour` of an open annular
     sector). **Generalization of E3-W**: "ω(v) misses S" is automatic (wave 1's `dist_ne_one_of_mem_of_mem_closure`), and the segments need only lie in the
     closure — `clear_wedge` in the new `Plane/Woodall/Merge` (skeleton, `sorry` leaves). No statement defect. Keryx's receipt: the two commits exist on
     `origin`; `false_of_four_le_sectors`, `aeMap6_merged`, `aeMap6` and the inhabitants read at `89a4aad0`. **With this, item 150's check on E1-NO45 is restored
     on real definitions, modulo its citations** (E3-BALL's leaves and the cited unlanded statements) — the withdrawal of item 158 stands for the old form.
