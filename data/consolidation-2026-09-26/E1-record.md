# E1 — record: design (b) on `CLAUDE.md` (remove incidentals, keep intrinsics)

*Job E1 of the 2026-09-26 documentation consolidation; brief `data/consolidation-2026-09-26/briefs/E1-extract-incidentals.md`. Opus 5.5.*

**Commit before my first edit (E2 diffs from it): `230ea964`.** `CLAUDE.md` at that commit: 299,491 bytes. Gates there: fact audit
`--base 230ea964` PASS, `--self-test` PASS (9 plants), `--dupes` 10 runs / 628 B, `fs71_ledger_b_check --strict` PASS, `bib_audit` PASS,
`check_architecture` PASS.

## Stage 1 — SAVED: the inventory

The moves are specified once, in `data/consolidation-2026-09-26/e1/moves.py` (each an exact span of `CLAUDE.md`, from a unique start
anchor through an end anchor, both included; the cut text goes to its destination **verbatim**). The table below is that script's
`inventory` output, unedited (`data/consolidation-2026-09-26/e1/inventory.md`).

| move | address | bytes cut | pointer bytes | net | destination | incidental because |
|---|---|---:|---:|---:|---|---|
| M1 | G21: from '**And a periodic search measures its per' to '`N ≤ 120`. ' | 349 | 0 | 349 | `plans/GROKKING-INSTANCES.md` §G21 | a second instance of G21's own rule (a verdict measures its enumeration; here the enumeration is the period cap) |
| M2 | G21: from '**And a one-period census measures its p' to 'measures that point. ' | 452 | 0 | 452 | `plans/GROKKING-INSTANCES.md` §G21 | a further instance of G21's rule; its lesson is G73's Do ('compute its Θ_k cells before calling it rigid') and G68's last sentence |
| M3 | G21: from '; and **a finite configuration measures ' to 'emptied the claim (row 126).' | 2,160 | 63 | 2,097 | `plans/GROKKING-INSTANCES.md` §G21 | instances of rules stated elsewhere: G21's own (finite configuration, rank-1 scan, proof checked by points, a verdict names its route); 'Make the gate fail' (plants that could not fire; a wrong-reason red; a positive control proves only its generator's shapes); quote verbatim (G51's standing rules; standing rule 5). G74's Do carries FS81-T8 |
| M5 | G49: from "**FS-79's instance, the question itself:" to 'the day it was needed. ' | 1,329 | 53 | 1,276 | `plans/GROKKING-INSTANCES.md` §G49 | instances of G49's head rule (question as well as method; discipline's words) and of its Do (a held paper is prior art for questions it was not read for), whose one example stays (FS-71's six re-attributions) |
| M6 | G50: from "**FS-79's instances:**" to 'went unsearched. ' | 1,526 | 0 | 1,526 | `plans/GROKKING-INSTANCES.md` §G50 | instances of G50's rule (held-but-unread blocks; an abstract is not a reading); the one example kept is FS-100's, which is also the Do's (grep BIBLIOGRAPHY.md before fetching or calling unheld) |
| M7 | G50: from "**FS-100 stage 5's:**" to 'group of polynomial growth"). ' | 369 | 0 | 369 | `plans/GROKKING-INSTANCES.md` §G50 | an instance of G49's discipline's-words rule and G21's (a zero read as support); its mathematics is G76's Do (Einsiedler–Fish's pigeonhole before calling a measure question ×2×3-hard) |
| M8 | G72: from 'FS-73 (the instance); FS-79' to "ayer 2's invariant not found. " | 2,389 | 80 | 2,309 | `plans/GROKKING-INSTANCES.md` §G72 | the killing test's per-milestone history; its state (twelve of thirteen) and the one exception (the thirteenth) stay; 'no-gos count' is item 23's |
| M9 | Frontier § The prior-art position: from '**Not ours:** band rigidity' to '(`[Croft1967]`).' | 4,640 | 117 | 4,523 | `LEDGER.md` beside § The claim list | the brief's named incidental: an attribution enumeration whose home in kind is LEDGER.md § The claim list |
| M10 | Frontier § Paths forward, ranks 30–59: from '| 30 | **FS-39' to 'g rooms and loose ends | low |' | 4,843 | 298 | 4,545 | `plans/FRONTIER-STUBS.md` (already there) | the brief's named incidental: rows ranked ≥ 30, each present and current in plans/FRONTIER-STUBS.md (checked token by token) |
| M11 | § Building, Kill by PID: from '(b) The\nrepair attempt' to 'an\nunrelated failure. ' | 343 | 60 | 283 | `plans/GROKKING-INSTANCES.md` §Building | a second instance of the paragraph's own first sentence (`pkill -f`/`pgrep -f` matches the shell that runs it) |
| g1 (glue) | G21: 'P3b typed' → 'P3b (FS-79) typed' | 0 | 8 | − | — | P3b's milestone, which M2's cut removed from the sentence before |
| g2 (glue) | G50: 'may hold PE-2. *Do:' → 'may hold PE-2. More instances: `plans/GROKKING-INSTANCES.md` §G50. *Do:' | 0 | 53 | − | — | the pointer |

net bytes out of CLAUDE.md: 17,668; CLAUDE.md 299,491 -> 281,823

The header pass (stage 4) adds back a few hundred bytes: the budget parenthesis records this pass, the one-home sentence names the new file.

### The test I applied, and what it kept

A passage moves only if its lesson is **stated elsewhere in `CLAUDE.md`** (then it is a second or later instance) or it is **history**
(which milestone, which night, a count of past closes). A passage stays if it is the **only statement** of a rule, a condition, a *why*, a
*Do* or killing test, a demotion record, or the one example of its rule — the brief's "when unsure, it is intrinsic". Considered and **kept**:

| passage | kept because |
|---|---|
| G21: M63 phase G's four defects, "the mechanism is selection" | the rule's own example and reasoning |
| G21: FS-71's census ("a conclusion with no chain is the shape to re-derive first") | only statement of that rule; item 19 points at G21 for the four-to-one under-grading |
| G21: "Read a solver's colouring before searching its periods" + its Fourier example | only statement of that method rule |
| G21: P3b's "a control at the scale of the question" | a condition on G21's "point every instrument at a known positive"; stated nowhere else |
| G21: FS-81's first two (relation tree a weak finder, screen first, UNDECIDED never NONEMPTY; contended times, re-ask alone) | only statements of two method rules |
| G49: the two-database zero; FS-73's held blog text (the Do's Polymath16 clause); row 88's `ab:` limit | sub-rules with their only example; FS-71's six re-attributions kept as the Do's one example |
| G50: FS-100's (the Do's example); "EL2021 … §2 … still unread where it may hold PE-2" | the Do's only example; a current-state debt a milestone reasons from |
| G72: "twelve of thirteen" and the thirteenth | the killing test's current state and its one exception |
| G79's killing-test record; G67's first data points; G71's, G74's killing-test status | inside the *Do / Killing test* span (the brief's intrinsic) |
| G51's "Its runs" | readings (routes converge; contest moved to verification) and the standing rules they left |
| § Building: Sixth instance (another agent's monitor), (a) the wrong pgid, `/proc` scan, `flock` wrapper, pipes, script edits | each the only example of its own sub-rule |
| "Make the gate fail": every paragraph | each is a distinct rule with its only example (the sibling `pgrep -f` monitor is the only example of the liveness-check costume the "never let a pattern … decide anything" rule names) |
| § What compute actually helps: FS-75 "once more" | a condition (even the two-leaf re-price ran 2–3× high) |
| Frontier: the Last-updated line, open milestones, the **Ours** sentence | the proposal's "every session"; the claim itself |

### Found while inventorying (for the owner)

- `LEDGER.md`'s claim-list preamble (written by J05, `b6d96724`) says `CLAUDE.md` keeps "the whole **Not ours** list, which stays in context
  against misclaims" — a *why* for keeping it in context. The brief moves it (design (b)); I keep the why as an instruction in the pointer
  ("read it before calling anything ours") and rewrite that preamble sentence to current state in the same commit. Held: whether the owner
  wants the list back in context for that reason.
- M10's rows were checked against `plans/FRONTIER-STUBS.md` before cutting: every fact token of every row ranked 30–59 is in its own
  FRONTIER-STUBS row, except the grouped rank labels (`38–42` …), which that file numbers one per row; a word-level comparison found only
  connective words missing. FRONTIER-STUBS's rows are the fuller and newer (e.g. FS-62's carries Kooshi's 2026-09-26 target).

Would-have-searched log: none (no search; every figure is exact arithmetic on committed files).

## Stage 2 — SAVED: the tooling

`tools/claude_md_fact_audit.py`, extended minimally:
- **The corpus** is `CLAUDE.md` + `LEDGER.md` + `plans/GROKKING-INSTANCES.md` (new `--instances`, default that path; joined only where
  the file exists, at the base revision as in the working tree, as the ledger already was). `--dupes` reads all three, so a passage left in
  two places is counted. `corpus_files` is now module-level so the self-test runs the real joining code.
- **`EXTERNAL_HOMES`** (token → file, reason): a *verified* allowance — the audit reads the named file and fails ("external home … lacks")
  unless the token is there. For text whose home was never this corpus: the paths-forward rows ranked ≥ 30, authoritative in
  `plans/FRONTIER-STUBS.md`. Empty until stage 3's frontier commit.
- **Self-test plants** (`self_test_files`), each through the real file-joining code, each with its partner:

| plant | must | result |
|---|---|---|
| a prose block moved to the instances file, verbatim | pass (partner) | passed |
| the same move with a once-only number (1950) deleted from the instances copy | fail, "lost num" | fired: lost num token '1950' |
| the same move with the instances file not joined | fail, "lost" | fired: lost num token '1950' |
| the number dropped from the corpus, its external home holding it | pass (partner) | passed |
| the number dropped, its external home lacking it | fail, "external home" | fired: external home … lacks num token '1950' |
| the block left in both files | `--dupes` count rises | 10 → 11 |

Gates at this commit: `--self-test --base 230ea964` PASS (15 plants); `--base 230ea964` PASS (corpus line printed; 0 external homes);
`--dupes` 10; `fs71_ledger_b_check --strict` PASS; `bib_audit` PASS; `check_architecture` PASS.
