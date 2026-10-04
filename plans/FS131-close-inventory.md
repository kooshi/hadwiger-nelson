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
