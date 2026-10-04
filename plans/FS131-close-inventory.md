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
- The lanes' expectations: copied here from the opening job's first saved stages.

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
