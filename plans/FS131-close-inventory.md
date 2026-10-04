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
