# Brief FS131-FSF1 — file the fractional chromatic number's drafts

*Written 2026-10-17 04:03 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FSF1
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; you file drafts verbatim and decide nothing
  role: Keryx's pen for the filing of a landing that is already merged: its drafts for the front files, each at the slot it names
  launch: now, in a worktree with no Lean build, on a branch cut from `main`; no other agent is running
  mission: § Why this job
  statements: § Why this job
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot text does not occur exactly once, or a draft is unclear; the report goes to `data/fs131/reports/FS131-FSF1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/FS131-FSF1.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/filing2` (branch `fs131-fsf1` at `898484b49`; no Lean build): `CLAUDE.md`, `plans/KERNEL-HOLDS.md`, `plans/FILINGS.md`, `LEDGER.md` (row 71 and § B's row FS56-T3 only), `CLOSED-QUESTIONS.md` (§ 1.6 only), `BIBLIOGRAPHY.md` (the cells draft 8 names), `LEAN.md`; your script `data/fs131/fcs1/file-fsf1.py` and its outputs beside it; `data/fs131/reports/FS131-FSF1.md`. Commit on your branch by explicit path; I merge it; never push. A commit hook runs the privacy guard: if it refuses a commit, reword nothing — message me with the file and rule
  budget: about 150k by the harness's count, as guidance; hand back before about 250k

Hello. The fractional chromatic number of the plane over ℚ(√3, √11) landed on `main` a few minutes ago; this filing brings
the front files to what the kernel now holds. The last filing of this kind (FS131-FRF1) is a good model: its script is
`data/fs131/fcs1/file-frf1.py`.

## Why this job

The landing, with my rulings on what is filed, by whom, and where the new row goes:

> 1095. **FS131-ISF2 handed back DONE; the fractional chromatic number over ℚ(√3, √11) lands on `main` (logged 2026-10-17 04:03 UTC; about 402k by the harness's count; record `plans/FS131-ISF2-seam-fractional.md`, report `data/fs131/reports/FS131-ISF2.md`).** The full gate green on `31df25939` (`main` merged at `1c8e07920`, item 1094's resolution; item 1089's docstring edit made): audit 12,291 records (11,436 clean, +330; 730 axiom-free, +155; 120 imported; 5 purchases), all of `main`'s 11,806 prints unchanged; vacuity `declarations=23377` (+575, reconciled by name), `refutations-skipped=247` (+1, `G27.conj_indep`, refutes nothing), sites unchanged; assumptions unchanged; 625 stored constants byte-identical across the merge and edit; the lint's negative control watched red, then restored byte-identical. **My receipts:** `#print axioms` run by me on the gated build (`data/fs131/isf2-review/Ax.lean`): `Instances.SeamFractional.fractionalChromaticNumber_seamPlane`, `finIndepRatio_seamPlane`, `iSup_fractionalChromaticNumber_seamPlane`, `IndepLaw.density_le_quarter_seamField`, `numberField_seamField`, and rank 7's `RationalFour.exists_coloring_forbidding_iff` and `exists_equiv_coloring_add_eq_residue` in the merged tree — all on `[propext, Classical.choice, Quot.sound]`; the guard over every message and new blob of `main..fs131-ksf1` (17 commits, 229 blobs, the generated data included): 0 refusals. **Announcement rule (items 995, 1083): met** — merged as `0f171c1d4`, `main` equal to `31df25939` in `Proofs/`, `Proofs.lean`, `scripts/` and the package files; the gated build moved into the main tree (the old one deleted), `build.sh`: all 2242 modules up to date. **Rulings, four parts as one:** *Choice:* (1) `Instances/SeamFractional`'s stale module docstring ("prior art: FS131-PAS2's to find") lands as it is and is fixed in the next gated change (owed); (2) the shared gate runner's missing previous-log argument (`data/fs131/clone1/run-gate.sh` gives `gate_report.py` none, so no row comparison) goes to the tooling list; (3) a Clerk files its drafts 1–6, 8, 9 and 11; draft 7 (C14's novelty line) goes into the README and `RESULTS.md` rows I write; not 10 (the Proof Atlas, owed) or 12 (applied). *Alternative:* fix the docstring now and re-gate (about 30 minutes). *Why:* Kooshi's W24 winds the session down after this push; the stale words are inside a Lean file, and the public pages carry the right line. *Confidence:* high. **Credited:** the lint control FS131-IRF1 left unrun, run and watched; the count reconciliation by name. Running: none until the filing.
> — source: plans/FS131-close-inventory.md

## What to file

From `plans/FS131-ISF2-seam-fractional.md` § Drafts for the front page: **drafts 1, 2, 3, 4, 5, 6, 8, 9 and 11**, verbatim, each at the slot it names.
**Not** draft 7 (C14's novelty line: I write it into the README and `RESULTS.md`), draft 10 (the Proof Atlas) or draft 12
(applied on the branch already).

- **Draft 3** replaces `CLAUDE.md`'s "Last filed" entry; the entry it replaces (rational four-space's) goes, in full, to
  the top of `plans/FILINGS.md` in that file's own form, as FS131-FRF1 did for the ring of unit vectors' entry.
- **Draft 9**'s clause goes into `plans/KERNEL-HOLDS.md` directly after the clause on rational four-space (the one that
  ends "`HadwigerNelson.RationalFour.*`, standard three axioms.") and before the closing sentence "Also χ(Heule-510) …".
- **Do not** add a clause to `CLAUDE.md`'s "In short:" list, nor touch `README.md` or `RESULTS.md`: I write those.

Where a slot text differs from its file only by line wrapping, match ignoring whitespace; where it differs in words,
stop and message me.

## Done means

1. **The script** (`data/fs131/fcs1/file-fsf1.py`): every slot found exactly once (whitespace-insensitive) before anything
   is written; a plant (one slot changed by a character) seen to fail first.
2. **The checks after filing:** `python3 tools/check_architecture.py` (its last line); the fact audit,
   `python3 tools/claude_md_fact_audit.py --base main --also .claude/skills/grokkings/SKILL.md plans/GROKKINGS-RETIRED.md RUNNING.md plans/CLAUDE-MD-HISTORY.md LEAN.md plans/WHERE-THE-PROBLEM-STANDS.md plans/HISTORY-WORKFLOW-3.0.md plans/KERNEL-HOLDS.md plans/FILINGS.md`
   — report every `FAIL` line; superseded counts replaced by the drafts' new counts are expected, anything else is a finding;
   `CLAUDE.md`'s size from the audit's `size:` line; and `--dupes` (its exit status).
3. **The report**, in the standing rules' form: each item filed with its file and line after filing, each substitution
   made (where), any slot that did not match, and the checks' outputs.

## What is yours to decide

Nothing beyond how the script finds each slot. Do not reword, merge, shorten or reorder a draft. Where you would have to
guess, write a `CHECK:` line in the report instead.
