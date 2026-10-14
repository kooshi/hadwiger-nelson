# Brief FS131-FC6 — file the front-page drafts of a landing that is already on `main`, verbatim, and run the checks that read the front page

*Written 2026-10-14 21:21 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FC6
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing
  role: the pen for one filing — the density bound's Lean modules landed on `main` just now, and the front page shows the counts from before them; you put the landing agent's drafts into their slots word for word, run the checks that compare the front page with the gate's receipts, and report every place where you would have had to choose
  launch: now, in a tree of your own; three other jobs work in other trees and write no file you write; the next landing will quote the front page as it stands after yours
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot is not found exactly once, if two drafts touch the same words, or if a check fails in a way no draft explains; the report goes to `data/fs131/reports/FS131-FC6.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `data/fs131/reports/FS131-FC6.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1` (branch `fs131-f6`, cut from `main` just now; the tree holds a compiled library you do not need and must not touch; no build is run): the files the drafts name — whichever of `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md`, `tools/claude_md_fact_audit.py` and `data/fs131/claims-NF2.md` they name — and nothing else of the front files; your own script and outputs under `data/fs131/fc6/`; `data/fs131/reports/FS131-FC6.md`. Commit on your branch by explicit path; the coordinator merges it
  budget: about 200k by the harness's count, as guidance; save a stage (a commit) after the slots are checked, after the drafts are in, and after the checks; hand back at a saved stage if you pass about 300k

Hello. Five filings like this one were done on this machine in the last two days; the last clerks guessed at nothing,
and raised the lost tokens I then ruled on. This is the same job for the landing that followed.

## Why this job

The density bound landed on `main` just now through the full gate: every Lebesgue-measurable planar set with no two
points at distance one has upper density at most 0.2470 (`[AmbrusEtAl2023]` Theorem 1), on the standard three axioms,
its computer-assisted certificate checked by the kernel. Its landing agent wrote 16 drafts for the front page (25
slots), each with the exact words it replaces or follows. Until they are filed the front page (`CLAUDE.md`) shows 9,101
records.

The drafts are a lane's words and go in verbatim: I coordinate and do not author, and you are my pen. Where you would
otherwise have to guess, write a `CHECK:` line and do not guess.

## What is filed

The landing's hand-back and its merge, as I logged them, with my receipts:

> 927. **FS131-LDB1 handed back; merged into `main`; the announcement rule met (logged 2026-10-14 21:20 UTC; "JOB FS131-LDB1 — DONE"; 554k by the harness's count; branch `fs131-wldb` at `cf8568956`, gated commit `7a2acfef8`; record `plans/FS131-LDB1-landing.md`).** From its hand-back message: "The full gate passed on its first run on one commit, `7a2acfef8`"; "`HadwigerNelson.Plane.oneAvoidingDensityBound : Plane.OneAvoidingDensityBound` … [kernel], on `[propext, Classical.choice, Quot.sound]` … The stored statement says exactly what the paper says, with the bound stated at every centre"; "`HadwigerNelson.Plane.mOne_eq_iSup_bandFree` … on the standard three … So the kernel holds 1/7 ≤ m₁(ℝ²) ≤ 0.2470 on one constant. With no hypothesis, m₁ ≤ 0.2470 and m₁ < 1/4 exist only as those two theorems applied to `oneAvoidingDensityBound`"; the counts of item 925, each predicted and met; `DensityBound.DualCert.IsIndep` declared a `.condition`; corrections owed (FS131-IDB1's record holds FS133-LD1's drafts, its own `LEAN.md` drafts rebuilt as draft 12; FS131-IDB2's audit block listed this line's `mOne`, replaced); a slip of its own (a coverage control by name prefix, caught by its count); a tool defect (neither density-bound generator has a `--check` mode); open gate items (lean4checker not run; `m₁ < 1/4` only as an application; `Chain.out` not recomputed; `ARCHITECTURE.md` rows' prose stale); 16 drafts with 25 slots checked once each (`data/fs131/ldb1/drafts-slots.py`). **My receipts:** item 925 (the gate's digests read); the two commits after `7a2acfef8` touch only `plans/` and `data/` (`git diff --name-only`); `main`'s commits since the merged base `7c8f9af82` touch only `plans/` and `data/`; `git merge-tree` clean; **merged `--no-ff` as `2d71a0872`; `git diff 7a2acfef8 main` outside `plans/` and `data/` is empty**; pushed to the backup. **The announcement rule of item 910 is met on its letter: `[AmbrusEtAl2023]` Theorem 1, `m₁(ℝ²) ≤ 0.2470`, is held** — a kernel theorem on `main` on the standard three axioms, through the gate, its certificate checked by the kernel with no `native_decide`; the theorem is theirs, the finite-window route, the formalization and the kernel check this project's. **Rulings, four parts.** (1) *The two instance-only type changes:* they stand (item 917); high. (2) *`IsIndep` as a `.condition`:* accepted — a predicate in the route theorem's hypotheses that the certificate discharges, not an assumption of the library; alternative, a theorem at the empty set — declined, a new statement for no reader; medium-high — changed if the assumptions tool's classes are revised in the tooling job. (3) *`m₁ ≤ 0.2470` and `m₁ < 1/4` with no hypothesis:* stated as two corollaries at the chain's landing (ruled new statements), so the front page can cite them by name; until then the filing cites the application; high. (4) *The filing:* the Clerk, from the 16 drafts, base `8eece67b0`, item 928; high. **The reference compiled tree for `main`** is now `fs131-w10g` (its build is the gated one, equal to `main` outside records). **Size noted for the publication pass:** `data/fs131/ldb1/` is 39 MB of logs (the axioms self-test's receipt alone 286k lines).
> — source: plans/FS131-close-inventory.md

**The drafts** are in `plans/FS131-LDB1-landing.md`, section "Drafts for the front page (FS131-LDB1)" (to the heading "Open gate items at
this landing"). Each names its file, its section and the exact words on `main` it replaces or follows. The landing
agent's checker of those slots is `data/fs131/ldb1/drafts-slots.py`.

**My choices where a draft leaves one to the coordinator** (file what the drafts say; use these only where a draft
offers alternatives or says "the coordinator's"):

1. Whose it is, exactly as the drafts say it: the theorem is `[AmbrusEtAl2023]`'s; the finite-window route, the
   formalization and the kernel check are this project's. No value of `χ(ℝ²)` moves.
2. No milestone changes state in this filing.
3. The proof atlas is not touched by this job (one rebuild at the publication pass).
4. If `CLAUDE.md` would pass 80,000 bytes, file nothing more in it and write a `CHECK:` with the byte count: the move
   that meets a size budget is mine to rule.

## Done means

1. **Slots first** (a saved stage): run `python3 data/fs131/ldb1/drafts-slots.py main` in your tree; every slot found
   exactly once and the control absent, or you stop and message me with the slot that failed.
2. **The drafts in, by a script** (`data/fs131/fc6/file_fs131_ldb1.py`; the pattern is the last filing's
   `data/fs131/fc5/file_fs133_ld1.py`): it asserts every slot before it writes anything, replaces or inserts each
   draft's quoted text exactly (the lines under `>` in the record, joined as the target file wraps its lines; nothing
   reworded, nothing added), and prints what it did per draft. A draft that says counts "stand" changes nothing and
   is reported as such. (A saved stage.)
3. **The checks that read the front page**, each with its full output kept under `data/fs131/fc6/`:
   - the three digests of this landing's receipts against the previous landing's:
     `python3 scripts/gate_report.py axioms data/fs131/ldb1/gate/receipt-axioms-final.log data/fs133/ld1/gate/receipt-axioms-final.log CLAUDE.md`,
     the same with `vacuity` and `scripts/vacuity-baseline.txt` before `CLAUDE.md`, and with `assumptions` and
     `scripts/assumptions-ledger.txt` before `CLAUDE.md`;
   - `python3 tools/claude_md_fact_audit.py --base 8eece67b0` and the same tool with `--dupes`. **A token the audit
     reports lost is not allow-listed by you**: list it as a `CHECK:` with where it was and what replaced it;
   - `python3 tools/bib_audit.py`;
   - the size budgets the fact audit enforces (`CLAUDE.md` under 80,000 bytes).
4. **The report** (`data/fs131/reports/FS131-FC6.md`, and the same text as your hand-back): per draft — filed, or
   "stands", or `CHECK:` with the reason; each check's last lines; every `CHECK:`; the commits on your branch.

## What is yours to decide

How the script is written; the order of the drafts; how to join a draft's lines to the target file's wrapping.
Nothing about the words: if a draft looks wrong to you — a count that does not match the receipt it cites, a
sentence that contradicts the record's own table — file nothing for that draft and say what you saw.

## The machine

This session is on the laptop, away from the remote: **commit on your branch and do not push**. No Lean build
is part of this job; do not start one, and do not touch the tree's `.lake` folder. `/tmp` is wiped at power-off: keep
what the report cites under `data/fs131/fc6/`.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
