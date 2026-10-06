# Brief FS131-OL1 — OPEN lands: `main` merged into `fs131-wop`, the full gate, and `main` fast-forwarded

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-OL1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: OPEN's landing implementer — merge `main` into `fs131-wop`, run the full gate on one commit, fast-forward `main`, and draft the counts for the filing
  launch: now, beside FS131-CC2 (the collar bend's lane C, on `fs131-w5k`) and FS131-IR1 (the procedure's last steps, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a gate check that will not go green for a reason outside this brief, a vacuity site the scan reads as vacuous or unknown, a statement the gate shows false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-OL1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate above all), and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IO-implementation.md` (OPEN's record on branch `fs131-wop`; you continue it from Stage 16, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop` (branch `fs131-wop`): the merge's files; `scripts/Axioms.lean`, `scripts/Vacuity.lean`, `scripts/vacuity-controls.lean`, `scripts/vacuity-baseline.txt` (its header; a new entry is my ruling, not yours), `scripts/axioms-selftest*` (the controls' expected counts, if your state moves them); `Proofs.lean`, `ARCHITECTURE.md`; `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` for a linter or docstring fix only (no statement or definition changes); `plans/FS131-IO-implementation.md`, `tools/fs131_ol_*.py`, `data/fs131/ol/`, `data/fs131/reports/FS131-OL1.md`; then `main`, by fast-forward only
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are landing OPEN, the fifth simplifying move of the termination procedure, in the Lean backlog. The milestone, FS-131, turns this project's
hand-derived results into kernel-checked ones; waves 1–4, Woodall's chain and MERGE are on `main`. FS131-E6 found that a lone horn can be unshaveable and
derived a repair, a thin wedge recoloured beside the horn; three implementers proved it on `fs131-wop`, a branch that is `main` plus one module, `OpenMove`,
with no `sorry` anywhere. `exists_open` rests on exactly the standard three. You bring it through the gate and onto `main`. The work stopped for a day at a
halt; nothing was lost.

## Why this job

A result counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). The branch is
gate-ready now, and the procedure's vertex step cites `exists_open`. What the last implementer handed back, and the rulings that launch you:

> 408. **FS131-IO3 done — OPEN held** (Stage 15 SAVED at Kooshi's halt, all three of its items finished; harness ≈ 384k by the task notice; record `fs131-wop`'s
> — source: plans/FS131-close-inventory.md

> 409. **Ruling on OPEN: it lands on `main` by its own gate-and-land job on restart** (queue item (3), as ML1 landed MERGE, item 375): the gate on `fs131-wop`
> — source: plans/FS131-close-inventory.md

> 411. **Rulings: the three slots, filled from the queue of the handoff.** (a) **FS131-CC2**, lane C's continuation on `fs131-w5k` (item 406 (d)). (b)
> — source: plans/FS131-close-inventory.md

(its part (d) matters to you: FS131-IR1 merges `origin/fs131-wop` at `a20bb6f5` into wave 5's branch today, so that commit must stay an ancestor of what you
land — add commits on top; never rewrite the branch.) OPEN's history, for the statement and its two repaired fields:

> 384. **FS131-E6 done: F6 is real, and repaired with no backlog statement changed** (harness ≈ 540k by the task notice; record `plans/FS131-E6-derivation.md`;
> — source: plans/FS131-close-inventory.md

> 391. **FS131-IO1 handed back** (Stage 3 SAVED, harness ≈ 408k by the task notice; record `fs131-wop`'s `plans/FS131-IO-implementation.md`, Stages 1–3; report
> — source: plans/FS131-close-inventory.md

> 393. **FS131-IO2, by message: `open_allowedCone` is false as stated; a one-field repair to `OpenConfig`.** Why: in OPEN's new map the closure of the
> — source: plans/FS131-close-inventory.md

> 397. **FS131-IO2, by message: `open_degree_horns` is also false as stated; a second one-field repair to `OpenConfig`.** `OpenConfig.ray` puts the ray strictly
> — source: plans/FS131-close-inventory.md

> 400. **FS131-IO2 handed back** (Stage 10 SAVED, harness ≈ 560k by the task notice — past its line; it stopped at Stage 9 to run the handover; record
> — source: plans/FS131-close-inventory.md

How the last landing went, which this one follows (its record is `plans/FS131-IMM-implementation.md` on `main`, from Stage 13):

> 375. **MERGE LANDED on `main`, held in the kernel: FS131-ML1 done** (harness ≈ 334k by the task notice; record `fs131-w4mm`'s `plans/FS131-IMM-implementation.md`,
> — source: plans/FS131-close-inventory.md

> 376. **MERGE's landing counts filed** (Keryx, drafts 1, 2, 4 verbatim): `CLAUDE.md` § Trust ledger (3784 clean, 14 axiom-free, 3,807 records, FS131-ML1) and
> — source: plans/FS131-close-inventory.md

What IO3 says is left:

> Of this brief: nothing. Of OPEN's landing, for the coordinator (not this job's to run): the full gate on a branch carrying `fs131-wop`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/plans/FS131-IO-implementation.md 15.3 What is left, and the next step

## The statements

No statement changes in this job. The theorem you land and the definition it counts with, as they stand on `fs131-wop` at `a20bb6f5` (read each whole there):

> theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean

> def HasHornCount (v : ℂ) (j : ℕ) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean

## Done means

1. **Your readback first**: check every quotation above against its source; read OPEN's record (Stages 10–15 in full) and ML1's landing stages; build the
   branch once as given (`a20bb6f5`; expect it up to date or two modules rebuilt, 0 warnings) and re-run IO3's axioms check (`data/fs131/io/iter.sh
   data/fs131/io/AxiomsIO.lean` into a file under `data/fs131/ol/`, then `tools/fs131_io_axioms.py <file> --expect 105`; expect 103 on exactly the standard
   three). Open Stage 16 with what you may and may not change. Commit and push.
2. **The merge**: `main` into `fs131-wop`. Since the branch point `11a34d9d`, `main` changed only `BIBLIOGRAPHY.md`, `plans/` and `data/fs131/briefs/` —
   show the `git diff --name-only` that says so, and stop and message me if it names a Lean file or a script. Build.
3. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); zero `sorry` in `Proofs/`; `scripts/axioms.sh` clean (every OPEN
   record within the standard three, registered in `scripts/Axioms.lean`; no `native_decide`) and `--self-test` green (fix the controls' expected counts if
   your state moves them, each shown red before and green after); `scripts/vacuity.sh` and `--self-test` green, with the counts reconciled against the line
   in `CLAUDE.md` § The gate — say how the scan classes each new site (`OpenConfig` and the surgery's binders among them), and register a carrier or a
   control under the procedure in `scripts/Vacuity.lean`'s docstring where it asks for one, each control numbered after the last on `main`;
   `tools/check_architecture.py` exit 0. `exists_open`'s hypotheses have no Lean inhabitant yet (its docstring says so; E6's twelve-colour map inhabits them
   at [hand]): if the scan reads any new site as vacuous or unknown, or asks for a baseline entry, stop and message me with the scan's line.
4. **The landing**: if `main` moved meanwhile (I commit to `plans/` and `data/` often), merge it again; if the new commits touch only `plans/` and `data/`,
   say so with the `git diff --name-only` that shows it, and otherwise re-run the gate on the merged commit. Then `git push origin HEAD:main` from the
   worktree — a fast-forward only, never a force-push; on a rejected push, fetch, merge and try again.
5. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-OL1)": the `CLAUDE.md` § Trust ledger sentence's counts, § The gate's two
   count lines, `scripts/vacuity-baseline.txt`'s header (which you write), a `GATE_CHANGES` entry for `tools/claude_md_fact_audit.py`, and `LEAN.md` § The gate's
   control count if it changed — each with the log line it comes from, and the saved gate logs' paths so that `scripts/gate_report.py` can re-read them.
6. **Your record**, stages headed "Stage n — SAVED (FS131-OL1)", "Theorems this phase proved"; the report in standing rule 11's form, with `exists_open` and
   `OpenMove`'s record count read from the gate's saved axioms log. Leave no background process running. Stopping at a saved stage, the gate red at a named
   check, is a good report.

## What is yours to decide

How each check is made green within this brief: which controls' counts move, how a new site is registered, and what the drafts say. If the gate shows an OPEN
statement false or vacuous with no remedy here, stop and message me with the declaration and what the check showed. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
