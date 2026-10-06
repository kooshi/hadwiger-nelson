# Brief FS131-L5 — wave 5's landing: the outward bend merged in, the last tidies, `main` merged, the full gate on one commit, and `main` fast-forwarded

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-L5
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's landing implementer — merge the branch that holds the proved outward bend into wave 5's line, make the short list of ruled tidies that waited for that merge, merge `main`, run the full gate on one commit with its newer steps, fast-forward `main`, and draft the counts for the filing
  launch: now, in the tree FS131-RP1 has handed back; other jobs work on `main`'s line in trees of their own and commit nothing to `main` but `plans/` and `data/`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a merge conflict beyond the kinds named below, a gate step red for a reason you cannot repair within your touches (the vacuity scan reading a new site as vacuous or unknown, an axiom record outside the standard three, a name declared twice), a ruled tidy that does not go through as ruled, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-L5.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-L5-landing.md` (new, on branch `fs131-w5c`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`, at `8f2280d0`): the merges' files; the files of the ruled tidies listed below, with their callers; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Vacuity.lean` and its controls and `scripts/vacuity-baseline.txt` as the gate's own procedures ask; `plans/FS131-L5-landing.md`, `tools/fs131_l5_*.py`, `data/fs131/l5/`, `data/fs131/reports/FS131-L5.md`; `main` only by the final fast-forward push; **not** `CLAUDE.md`, `LEAN.md`, `LEDGER.md` (you draft their lines; I file them), no statement beyond the ruled ones
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. You are landing wave 5 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked ones; waves
1–4, Woodall's chain, MERGE and OPEN are on `main`. Wave 5 is the largest: the termination procedure (`exists_terminalMap`: every valid map of the
plane has a terminal valid modification), the theorems about terminal maps over it, and the density argument over those. As of today every leaf of
it is proved on some branch: this one holds the whole wave but the outward bend's children, and `fs131-w5z` holds those, proved. One merge makes it
whole. Then the gate decides.

## Why this job

A wave counts as held only when its declarations pass the full gate on one commit (the milestone's announcement rule,
`plans/FS131-close-inventory.md`); nothing with a `sorry` reaches `main`. This is that gate. Kooshi, on what the evidence must be:

> - **The artifact is the certificate plus the checker, never the search.** Commit the data a reviewer re-checks; never require them to
> — source: CLAUDE.md § The standard of evidence above rung B

The last jobs' hand-backs and the rulings in force (read each whole in the inventory):

> 468. **FS131-RP1 done: the remedy pass — six ruled statement tidies, no name twice and no statement under two names in `Plane`, 58 corrected
> — source: plans/FS131-close-inventory.md

> 469. **Rulings on RP1's held items, and its slot.** (a) `collarModel_hyps` with four conjuncts stands (the fifth was `hlen`). (b) `conj_e`
> — source: plans/FS131-close-inventory.md

> 464. **FS131-BA3 done: the outward bend is whole in the kernel — `bend_away_part` on the standard three, no open leaf beneath it** (implementer;
> — source: plans/FS131-close-inventory.md

> 465. **Rulings on BA3's held items, and its slot.** (a) **The unread `hF` of the six R1/R2 and side lemmas, with `CollarFit.map_hornCount_le`'s,
> — source: plans/FS131-close-inventory.md

> 458. **FS131-M7 done: wave 5 is one line on `fs131-w5c`; `Procedure` holds no `sorry`; and a gap in the gate found — Lean accepts one theorem
> — source: plans/FS131-close-inventory.md

> 459. **Rulings on M7's held items, and its slot.** (a) **What the doubled name costs, as I read it — hygiene, not soundness**: the two merged
> — source: plans/FS131-close-inventory.md

> 462. **FS131-T4, by message: measured — with a doubled theorem name `#print axioms` can print clean while the copy the environment holds is
> — source: plans/FS131-close-inventory.md

> 455. **Rulings on BA1's held items, and its slot.** (a) **The inhabitant `awayModel` goes to the models' planner, FS131-KM1, with the other
> — source: plans/FS131-close-inventory.md

> 415. **Rulings on OL1's held items, and its slot.** (a) **Dates in filed counts are the gate logs' UTC date** (as the inventory's). (b) **A landing's
> — source: plans/FS131-close-inventory.md

> 419. **Rulings on LN1's held items; a correction to ruling 417 (b); the slot.** (a) **The three binders are removed** (two theorems become strictly stronger,
> — source: plans/FS131-close-inventory.md

> 427. **Rulings on QA4's list and the rule.** (a) **Before wave 5 lands, at its final sync** (one remedy pass, in the job that joins the branches, so no
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes but the ruled tidies. The wave's heads, as they stand in your tree — after the merge each must print the standard three:

> theorem exists_terminalMap (hF : F.Valid) (hP : F.IsPlaneMap) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> theorem exists_terminal {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean

> theorem bend_away_part (hF : F.Valid) (hP : F.IsPlaneMap) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean

The gate's recorded state on `main`, which your counts are reconciled against:

> `declarations=11173 refutations-skipped=118 sites=784`, `vacuous=0 stale=0 declared=3 witnessed=32 generic=747 unknown=2`.
> — source: CLAUDE.md § The gate

## Done means

1. **Your readback first**: check every quotation above against its source; read FS131-RP1's report and record (in this tree), FS131-M7's report's
   last two sections (what the later merges meet; what stands twice), FS131-BA3's report
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z/data/fs131/reports/FS131-BA3.md`), and the last landing's record for the gate's
   procedure (`plans/FS131-IO-implementation.md`, FS131-OL1's stages). Build the branch once as given. Open your record. Commit and push.
2. **The merge**: `git merge origin/fs131-w5z` (at `d4f04ff3`; it holds `fs131-w5a`). **Trial it first, on this tree's tip as it is now**
   (`git merge-tree`), and name the conflicts before you make it; foreseen: `scripts/Axioms.lean` and `ARCHITECTURE.md`, adjacency, keep-both —
   and wherever FS131-RP1 edited a file the bend's jobs also touched. Check it with FS131-M7's tools (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/tools/fs131_m7_merge_check.py`,
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/tools/fs131_m7_away_clause.py`). Commit it as a merge (the index holding the merge and nothing else, checked). Build. **The receipt that the
   wave is whole**: zero `sorry` under `Proofs/`; `LocalStep.of_cutArcs`, `CollarFit.map_localStep`, `bend_away_part`, `exists_arcStep`,
   `exists_terminalMap`, `exists_red`, `exists_terminal` on exactly the standard three, with a control that fires.
3. **The tidies that waited for this merge** (rulings 457 (b), 465 (a), (b); FS131-RP1's closing list): the unread `hF` out of
   `CollarFit.map_hornCount_le`, `CollarFitOut.map_R1`, `CollarFitOut.map_R2` and, where the proof does not read it, the toward
   `CollarFit.sides_end`, `sides_eq`, `map_R1`, `map_R2` — each with its callers, and any whose callers surprise you left and said; the stale
   "skeleton" and "open" lines in the bend's modules, `BendStep` and FS131-KA1's block of `scripts/Axioms.lean`; `ringPt_inj_of_abs_sub_lt` and
   `ringPt_ne_of_abs_sub_lt` made one. Statement check by script, exactly the ruled ones changed. One build.
4. **`main` merged in**: show the `git diff --name-only` since this branch last had it; expect `plans/`, `data/`, `.claude/`, `BIBLIOGRAPHY.md`
   and — if FS131-T4 has landed — new files under `scripts/` and `tools/`; a Lean file is a message to me.
5. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); zero `sorry` in `Proofs/`; `scripts/axioms.sh` clean,
   every wave-5 record registered and within the standard three, `--self-test` green (controls' expected counts fixed where your state moves
   them, each shown red before and green after); `scripts/vacuity.sh` and `--self-test` green, the counts reconciled against the line above —
   say how the scan classes the new sites, and register a carrier or a control where `scripts/Vacuity.lean`'s procedure asks for one; a new site
   read as vacuous or unknown, or a request for a baseline entry, is a message to me with the scan's line; `tools/check_architecture.py` exit 0;
   **the guarded lint**, `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), silent;
   **the notes check**, `tools/fs131_qa4_notes.py`, no CONFLICT; **the doubled-name check, after the build and before the axiom audit: `scripts/slot.py --mem 16 --cpus 8 -- ./scripts/dupnames.sh`, then `scripts/slot.py --mem 4 --cpus 4 -- ./scripts/dupnames.sh --self-test` (on `main` since the merge of `fs131-t4`, so it reaches you with step 4; `LEAN.md` § The gate, as filed today, read from the main checkout); green is exit 0 and no name declared by two modules**. Save every step's log under `data/fs131/l5/` and name them.
6. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`, `.claude/`,
   `BIBLIOGRAPHY.md`, `LEDGER.md`, say so with the diff that shows it (ruling 415 (b)), otherwise re-run the gate on the merged commit. Then
   `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push; on a rejected push, fetch, merge and try again.
7. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-L5)", each with the log line it comes from: the
   `CLAUDE.md` § Trust ledger sentence's counts; § The gate's two count lines; `scripts/vacuity-baseline.txt`'s header; a `GATE_CHANGES` entry for
   `tools/claude_md_fact_audit.py`; `LEAN.md` § The gate's control counts if they changed; **the open gate items at this landing** (ruling 427 (d),
   F3) — each theorem whose inhabitant is a hand model today, by name, with the model's address: the four moves and the stuck family until the
   example maps land, `bend_away_part` (`awayModel`, planned), `a4six`, `straddlers_third`, `nb4p`, `flank_ne_of_doublyShadowed` (FS131-E7's).
8. **Your record**, stages headed "Stage n — SAVED (FS131-L5)"; the report in standing rule 11's form, the wave's heads and record counts read from
   the gate's saved axioms log. Leave no background process running. Stopping at a saved stage with the gate red at a named check is a good
   report — say which check, its log, and what you would try next.

## What is yours to decide

The order inside each step, how to resolve keep-both conflicts, how the vacuity scan's new sites are registered under its own procedure, and whether
a tidy of item 3 is deferred. If the gate shows something no job could see from its branch — a record the audit reads differently on the joined
line, a note the notes check refutes — that is a finding: fix what is within your touches and ruled, and message me for the rest. Do not weaken a
check to pass it. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
