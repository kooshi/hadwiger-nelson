# Brief FS131-ICT2 — the three-colour criterion to the gate: lint, the ruled drops, the gate on one commit, the read-aloud and the drafts

*Written 2026-10-16 15:43 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ICT2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the successor implementer of ledger row 79's three-colour criterion — every leaf is proved and built by the job before you; you apply two ruled statement drops, run lint, the full gate on one commit with the statement comparison, read the head statements aloud against row 79, and draft the front page
  launch: now, in the same worktree and on the same branch as the job before you, with `main` merged in by me; beside you the `p`-adic implementer and the density planner in other worktrees, writing none of your files
  mission: § Why this job
  statements: § Where the work stands
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be kept or a gate step fails in a way no rule explains, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-ICT2.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-ICT2-three-colour.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kel1`, on its branch `fs131-ktc1` (at `ffe203401`: the previous job's last commit with `main` merged in, which brought the collapse's seven modules and its edits to `Arith/FloorPlanes` and `Rigidity/ClassRatio`; `.lake/build` is a copy of `main`'s current build, so the first build recompiles the three `CayleyThree/` modules and the root): the three modules under `Proofs/HadwigerNelson/CayleyThree/` (proofs; statements only as ruled below); `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs by the gate's own rules; `plans/FS131-ICT2-three-colour.md`; your scripts and logs under `data/fs131/ict2/`; `data/fs131/reports/FS131-ICT2.md`. Front-file edits are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after the drops and lint, after the gate, after the read-aloud and after the drafts; hand back at a saved stage before about 500k

Hello. You arrive with the mathematics done: every leaf of the three modules is proved and the build is green. What is
left is the check that makes it a landing.

## Why this job

The rule this project publishes by is Kooshi's W2 (`data/fs131/REQUEST-2026-10-13.md`): any finding of ours is
formalized. Ledger row 79 is one; the job before you proved it in a wider form than the row states, by my ruling of item
996. The brief that job worked to, `data/fs131/briefs/FS131-ICT1-three-colour.md`, holds the head statements as typed and
its § Done means steps 3–7, which still hold.

## Where the work stands

My log of the previous job's hand-back, with my ruling on its two unread hypotheses:

> 1012. **FS131-ICT1 handed back at stage 6, past its line (logged 2026-10-16 15:42 UTC; "JOB FS131-ICT1 — STAGE 6 SAVED"; about 565k by the harness's count — not to be resumed; branch `fs131-ktc1` at `0ab9c6614`; record `plans/FS131-ICT1-three-colour.md`, report `data/fs131/reports/FS131-ICT1.md` there).** Every one of the 53 leaves of `CayleyThree/{Circular, Fibre, Density}` proved, about 1,690 lines against the plan's 2,230 (275, 830, 590); the build green at `e71acf2a9` (4 modules rebuilt, 0 with warnings); a probe, not the audit, reads the 15 head and model statements on the standard three; `mcshane_model` corrected by item 1003's ruling; new public helper constants listed for the statement comparison (record §§ 3.4, 4, 5). Not run: `lake lint`, the merge of `main`, the gate, the statement comparison, the vacuity scan's new sites, the read-aloud, the drafts (record § 5). The coset reduction and the cell clause did not ride. **My receipts:** the seven commits exist; `grep -cw sorry` reads 0 in the three modules; I read `even_pmHeight_sub_sum` (`Fibre.lean` l. 179, `hc : ProperAlong s c`, referenced only by `have _ := hc`) and `exists_le_mul_of_imp_eq_zero` (l. 433, `hadd`). **Ruling, four parts, on the two unread hypotheses.** *Choice:* drop both from those helper statements, update their call sites, and list each in the gate's statement comparison as a ruled change (a hypothesis no proof reads; the statement strictly more general). *Alternative weighed:* keep them, referenced by `have _ := h` — declined: that is the linter silenced by another means, which items 993 and 998 declined; and neither is a statement a reader cites (item 998 kept `0 ≤ c` because it is part of a bound as a reader states it). *Why:* consistency with items 993 and 998. *Confidence:* medium-high. **Next:** a successor implementer for stage 7 onward (FS131-ICT2), in the same worktree and branch.
> — source: plans/FS131-close-inventory.md

And the earlier ruling on the false skeleton statement it corrected:

> 1003. **FS131-ICT1: a statement defect in the skeleton, `CayleyThree.mcshane_model` false as typed (logged 2026-10-16 14:55 UTC; by message; branch `fs131-ktc1` at `3d8d4bf91`, `Circular` proved, all 14 leaves, about 275 lines against the plan's 440).** `Density.lean` ll. 71–72: `mcshane (fun y => ∑ j, y j) {0} ⊥ 0 x = ∑ j, x j`. With `B = {0}` and `L = ⊥` the set under the `sInf` (l. 39) is the single value `h 0 + 0 + l1 x = l1 x`, so the left side is `Σ_j |x_j|`; at `m = 1`, `x = ![-1]` it reads `1 = −1`. The model meets every hypothesis of § 1; only the conclusion is wrong; no other leaf reads it (it is § 1's inhabitant for the gate). **My receipt:** I read the definition at l. 38–39 and the statement at ll. 71–72; the counterexample is as stated. **Ruling, four parts.** *Choice:* (a) keep the model and correct the conclusion to `= l1 x`, its docstring and the module docstring's sentence saying the extension is `h 0 + ‖x‖₁ = ‖x‖₁`; the gate's statement comparison lists it as a ruled change (a false skeleton statement corrected). *Alternative weighed:* (b) take `h = l1`, so that "the extension is `h`" stays true — declined: at (a)'s model the extension differs from `h`, so the check pins the definition's value where a definition that wrongly returned `h` would fail it. *Why:* the stronger spec, and the job's own suggestion. *Confidence:* high. **Credited:** the job found a false statement in the planner's skeleton and stopped that leaf rather than prove around it.
> — source: plans/FS131-close-inventory.md

Its record is `plans/FS131-ICT1-three-colour.md`: § 5 lists what is left in order, §§ 3.4, 4 and 5 the new public helper constants for the
statement comparison's allow-list. The plan is `plans/FS131-KTC1-three-colour-plan.md`; its § 3.7 names the structures
whose models the vacuity scan will ask for, and its § 3.8 drafts the front-page lines.

## Done means

1. **Stage 1 — the readback**: check the two quotations above; restate in your record what is left and the order.
2. **The ruled drops**: `hc` from `CayleyThree.even_pmHeight_sub_sum` and `hadd` from `exists_le_mul_of_imp_eq_zero`, their
   call sites updated, the build green; then `lake lint` (a saved stage).
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/ict2/`, its logs
   there), every count change explained against `main`'s last gate (`data/fs131/ico2/gate/`, the collapse's, gated on
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

The laptop: 12 cores, 31 GB, shared with two other jobs. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` is for iteration only. The worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a
tmpfs: keep what your record cites under `data/fs131/ict2/`. Nothing with a `sorry` reaches `main`.
