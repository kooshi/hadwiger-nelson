# Brief FS131-ICT3 — the three-colour criterion to the gate: lint, the ruled drops, the gate on one commit, the read-aloud and the drafts

*Written 2026-10-16 17:37 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ICT3
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the successor implementer of ledger row 79's three-colour criterion — every leaf is proved and built by the first job, and the second applied the two ruled statement drops, rebuilt green and wrote the gate's tools before a pause Kooshi called; you add five spec examples, run lint, the full gate on one commit with the statement comparison, read the head statements aloud against row 79, and draft the front page
  launch: now, in the same worktree and on the same branch as the two jobs before you; beside you the `p`-adic implementer and the density form's implementer in other worktrees, writing none of your files
  mission: § Why this job
  statements: § Where the work stands
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be kept or a gate step fails in a way no rule explains, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-ICT3.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-ICT3-three-colour.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kel1`, on its branch `fs131-ktc1` (at `4ea3653d4`: the second job's last commit, with `main` merged in since, no Lean; `.lake/build` holds the second job's green build of exactly these sources, so a rebuild after the spec examples recompiles only what they touch): the three modules under `Proofs/HadwigerNelson/CayleyThree/` (proofs; statements only as ruled below); `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs by the gate's own rules; `plans/FS131-ICT3-three-colour.md`; your scripts and logs under `data/fs131/ict3/` (the second job's tools under `data/fs131/ict2/` and `tools/fs131_ict2_*.py` are yours to run and fix in place); `data/fs131/reports/FS131-ICT3.md`. Front-file edits are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after the spec examples and lint, after the gate, after the read-aloud and after the drafts; hand back at a saved stage before about 500k

Hello. You arrive with the mathematics done: every leaf of the three modules is proved, the two ruled drops are in, and
the build is green. What is left is five small examples and the check that makes it a landing. The job before you stopped
at a pause Kooshi called, with its stage saved and the rest written out in order; it cannot be resumed (item 1020 below),
so its record is yours to start from.

## Why this job

The rule this project publishes by is Kooshi's W2 (`data/fs131/REQUEST-2026-10-13.md`): any finding of ours is
formalized. Ledger row 79 is one; the first job proved it in a wider form than the row states, by my ruling of item
996. The brief the first job worked to, `data/fs131/briefs/FS131-ICT1-three-colour.md`, holds the head statements as typed and
its § Done means steps 3–7, which still hold.

## Where the work stands

My log of the second job's stop, and why you, not it, carry on:

> 1019. **FS131-ICT2 stopped at stage 2 for the pause (item 1016; logged 2026-10-16 16:09 UTC; "JOB FS131-ICT2 — STAGE 2 SAVED"; about 130k by the harness's count — below its line, resumable by message; branch `fs131-ktc1` at `56c51e6bc`; record `plans/FS131-ICT2-three-colour.md` there).** Item 1012's two drops applied (`hc` from `CayleyThree.even_pmHeight_sub_sum`, three call sites; `hadd` from `exists_le_mul_of_imp_eq_zero`, its docstring corrected); the build green (735 of 735 batches, 4 modules rebuilt, 0 with warnings, no `sorry`); the gate's tools written, none run or controlled yet. **Owed, a correction for the successor:** five definitions with no spec example (`circularColoring`, `tightSet`, `fibre`, `Winding.flip`, `coloringOneTwo`), which `LEAN.md` § The gate asks for — a source edit, so before the gate's build. On resuming: continue it by message from its record § 2.4 step 2 (lint, the comparison, the audit block, the gate on one commit, the axioms, the read-aloud, the drafts), the spec examples added first.
> — source: plans/FS131-close-inventory.md

> 1020. **Restart after the pause of item 1016 (logged 2026-10-16 17:33 UTC; Kooshi: "Alright, let's ramp back up. Please read the handoff to continue.").** This is a new session: the previous session's agents are not reachable by message (`ListAgents`: "No reachable agents"), so items 1018's and 1019's "resume by message" cannot run. *Choice:* a fresh successor for each, briefed from its predecessor's record — FS131-IQP3 from `plans/FS131-IQP2-padic.md` § 1.2 step 1, FS131-ICT3 from `plans/FS131-ICT2-three-colour.md` § 2.4 step 2 with the five spec examples first; and the density form's implementer, FS131-IFR1, from FS131-KFR1's plan. *Alternative weighed:* wait for the old agents — not live, they belong to the ended session. *Why:* both predecessors saved their stages and wrote what is left in order, so a successor loses only the readback. *Confidence:* high. Worktrees reused as they stand (`il5` at `59634120b`, `kel1` at `56c51e6bc`, `kcl1` at `627ec43ba`), each with its own `.lake/build`.
> — source: plans/FS131-close-inventory.md

My log of the first job's hand-back, with my ruling on its two unread hypotheses (the second job applied it):

> 1012. **FS131-ICT1 handed back at stage 6, past its line (logged 2026-10-16 15:42 UTC; "JOB FS131-ICT1 — STAGE 6 SAVED"; about 565k by the harness's count — not to be resumed; branch `fs131-ktc1` at `0ab9c6614`; record `plans/FS131-ICT1-three-colour.md`, report `data/fs131/reports/FS131-ICT1.md` there).** Every one of the 53 leaves of `CayleyThree/{Circular, Fibre, Density}` proved, about 1,690 lines against the plan's 2,230 (275, 830, 590); the build green at `e71acf2a9` (4 modules rebuilt, 0 with warnings); a probe, not the audit, reads the 15 head and model statements on the standard three; `mcshane_model` corrected by item 1003's ruling; new public helper constants listed for the statement comparison (record §§ 3.4, 4, 5). Not run: `lake lint`, the merge of `main`, the gate, the statement comparison, the vacuity scan's new sites, the read-aloud, the drafts (record § 5). The coset reduction and the cell clause did not ride. **My receipts:** the seven commits exist; `grep -cw sorry` reads 0 in the three modules; I read `even_pmHeight_sub_sum` (`Fibre.lean` l. 179, `hc : ProperAlong s c`, referenced only by `have _ := hc`) and `exists_le_mul_of_imp_eq_zero` (l. 433, `hadd`). **Ruling, four parts, on the two unread hypotheses.** *Choice:* drop both from those helper statements, update their call sites, and list each in the gate's statement comparison as a ruled change (a hypothesis no proof reads; the statement strictly more general). *Alternative weighed:* keep them, referenced by `have _ := h` — declined: that is the linter silenced by another means, which items 993 and 998 declined; and neither is a statement a reader cites (item 998 kept `0 ≤ c` because it is part of a bound as a reader states it). *Why:* consistency with items 993 and 998. *Confidence:* medium-high. **Next:** a successor implementer for stage 7 onward (FS131-ICT2), in the same worktree and branch.
> — source: plans/FS131-close-inventory.md

And the earlier ruling on the false skeleton statement it corrected:

> 1003. **FS131-ICT1: a statement defect in the skeleton, `CayleyThree.mcshane_model` false as typed (logged 2026-10-16 14:55 UTC; by message; branch `fs131-ktc1` at `3d8d4bf91`, `Circular` proved, all 14 leaves, about 275 lines against the plan's 440).** `Density.lean` ll. 71–72: `mcshane (fun y => ∑ j, y j) {0} ⊥ 0 x = ∑ j, x j`. With `B = {0}` and `L = ⊥` the set under the `sInf` (l. 39) is the single value `h 0 + 0 + l1 x = l1 x`, so the left side is `Σ_j |x_j|`; at `m = 1`, `x = ![-1]` it reads `1 = −1`. The model meets every hypothesis of § 1; only the conclusion is wrong; no other leaf reads it (it is § 1's inhabitant for the gate). **My receipt:** I read the definition at l. 38–39 and the statement at ll. 71–72; the counterexample is as stated. **Ruling, four parts.** *Choice:* (a) keep the model and correct the conclusion to `= l1 x`, its docstring and the module docstring's sentence saying the extension is `h 0 + ‖x‖₁ = ‖x‖₁`; the gate's statement comparison lists it as a ruled change (a false skeleton statement corrected). *Alternative weighed:* (b) take `h = l1`, so that "the extension is `h`" stays true — declined: at (a)'s model the extension differs from `h`, so the check pins the definition's value where a definition that wrongly returned `h` would fail it. *Why:* the stronger spec, and the job's own suggestion. *Confidence:* high. **Credited:** the job found a false statement in the planner's skeleton and stopped that leaf rather than prove around it.
> — source: plans/FS131-close-inventory.md

The second job's record is `plans/FS131-ICT2-three-colour.md`: its § 2.4 is the remaining work in order, and its § 2.3 lists the gate's
tools it wrote — none run or plant-tested yet, so run each with its control first and fix what the first run shows. The
first job's record is `plans/FS131-ICT1-three-colour.md`: §§ 3.4, 4 and 5 list the new public helper constants for the
statement comparison's allow-list. The plan is `plans/FS131-KTC1-three-colour-plan.md`; its § 3.7 names the structures
whose models the vacuity scan will ask for, and its § 3.8 drafts the front-page lines.

One wording rule, new today (inventory item 1022): the repository is public, and the second job's record gives the
reason for Kooshi's pause in words the privacy guard refuses. Do not repeat them: in your record, messages and report,
the pause is "a pause Kooshi called", nothing more. I will reword the predecessor's lines at the merge.

## Done means

1. **Stage 1 — the readback**: check the four quotations above; restate in your record what is left and the order (the second job's § 2.4, corrected where the source disagrees).
2. **The spec examples, then lint**: an `example` for each of the five definitions with none of its own —
   `circularColoring`, `tightSet`, `fibre`, `Winding.flip`, `coloringOneTwo` — each one that would fail if the definition
   drifted (`LEAN.md` § The gate); the build green; then `lake lint` (a saved stage). The two ruled drops are done
   (item 1019); check them in the source, nothing more.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (the second job's copy, `data/fs131/ict2/run-gate.sh`; its logs
   under `data/fs131/ict3/gate/`), every count change explained against `main`'s last gate (`data/fs131/ico2/gate/`, the collapse's, gated on
   `7c72b9bf7`); the statement comparison against `data/fs131/ict1/statements-before.txt.gz` (the dumper
   `data/fs131/ict1/lean/StatementDump.lean`; a comparator shaped like `data/fs131/ico2/statements.py`), with the three
   ruled changes (`mcshane_model`'s conclusion, the two drops) and the new helper constants listed; the vacuity scan's new
   sites with each structure hypothesis's inhabitant named; `#print axioms` of every head statement (expected: the
   standard three). Commit any statement dump you add gzipped, as `data/fs131/ict1/statements-before.txt.gz` is (inventory item 1011:
   two uncompressed 48.7 MB dumps went public before this rule).
4. **The read-aloud** of each head statement against ledger row 79, in your record, with what is not claimed.
5. **The drafts** for the front files (the plan's § 3.8, brought to what is proved), each naming its slot. The prior-art
   search the plan's § 3.6 asks for has not been run (item 1000): word nothing as new; say "prior art not yet searched"
   where a novelty line would go.
6. **The report**, in the standing rules' form.

## What is yours to decide

Every proof change the drops need, and how the comparator is built. Not yours: any stored statement beyond the three
ruled changes.

## The machine

The laptop: 12 cores, 31 GB, shared with two other implementers. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` is for iteration only. The worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a
tmpfs: keep what your record cites under `data/fs131/ict3/`. Nothing with a `sorry` reaches `main`.
