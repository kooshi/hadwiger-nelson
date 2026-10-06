# Brief FS131-M7 — wave 5's lines joined on `fs131-w5c`, and the arc step proved from the bends: the last `sorry` of `Procedure` closed over the outward bend's children

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-M7
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's join — merge the arc step's line and the outward bend's skeleton into the branch that holds `Procedure`, resolve the one declaration both sides state, make one ruled one-place edit, write the arc step's last lines into `Procedure` from the text a sibling job compiled, and check the result
  launch: now, in the tree FS131-IR3 has handed back, beside FS131-BA1 (on `fs131-w5a`) and FS131-BA2 (on `fs131-w5z`), the two implementers of the outward bend
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a conflict beyond the two named below, a name both sides declare other than the one named, a line of the compiled text that does not compile in the joined tree for a reason you cannot see, a statement the join shows false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-M7.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-M7-sync.md` (new, on branch `fs131-w5c`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`, at `9f28e42a`): the two merges' files (conflicts resolved as § Done means 2 says); in `Proofs/HadwigerNelson/Plane/ValidMap/ArcStep.lean` the deletion of its copy of `LocalStep.of_cutArcs` and the one edit to `ArcBend.of_away`'s hypothesis; in `Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean` the import of `ArcStep`, `IsMaxRingArc.meet`, `exists_arcStep`'s docstring and proof, and the module docstring's lines about the arc step; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (a block of your own, headed "FS131-M7", above the `=== PURCHASED ===` banner), `plans/FS131-M7-sync.md`, `tools/fs131_m7_*.py`, `data/fs131/m7/`, `data/fs131/reports/FS131-M7.md`; **not** the outward bend's six modules nor `BendStep.lean` beyond what the merge brings (two jobs are proving their children on other branches: an edit here collides with theirs), no statement of a proved declaration, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are joining wave 5 of the Lean backlog into one line. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Wave 5 ends in `exists_terminalMap` — every valid map of the plane has a terminal valid modification — a procedure of two steps. In the last
day five jobs worked it on four branches: the vertex step is now whole in the kernel on this branch; the arc step's assembly is proved in a module of
its own on a second; the one bend it still needs is planned, its top theorem proved from 36 open children, on a third, and two implementers are
proving those children now. What is missing is small and exact: the lines that prove `exists_arcStep` in `Procedure` from the assembly. They are
written and compile in a scratch file. They cannot be placed until the branches meet. You make them meet and place them.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). After this
job, every open leaf of wave 5 is one of the outward bend's children: the two implementers' branches then come home as merges of proofs in files
nobody else touches, and the landing waits on that bend alone. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the last jobs handed back, and the rulings in force:

> 449. **FS131-IR3 done: the vertex step is whole in the kernel — all four cases proved as stated; `Procedure` holds one `sorry`, the arc step**
> — source: plans/FS131-close-inventory.md

> 450. **Rulings on IR3's held items, and its slot.** (a) **Wave 5's lines are joined now, not after the outward bend**: FS131-M7, on
> — source: plans/FS131-close-inventory.md

> 447. **FS131-IA2 done: the arc step's assembly upstream of `Procedure` is proved; the last lines for `Procedure` are written and compiled in
> — source: plans/FS131-close-inventory.md

> 448. **Rulings on IA2's held items, and two slots.** (a) **At the merge of the arc lines, `BendAway`'s `LocalStep.of_cutArcs` is kept and
> — source: plans/FS131-close-inventory.md

> 445. **FS131-KA1 done: the outward collar bend planned — its statement attacked and found true, `bend_away_part` proved from 36 open children
> — source: plans/FS131-close-inventory.md

> 443. **The W1/W2 lemma's exact text, relayed** (FS131-KA1's message to "main", 2026-10-06; sent verbatim to FS131-IA2 by message, and appended to
> — source: plans/FS131-close-inventory.md

## The statements

No statement of a proved declaration changes in this job. The arc step as it stands on this branch — already the ruled statement, `sorry` — and the
text that proves it, written and compiled against `Procedure` and `ArcStep` by FS131-IA2 (read the report's last section whole; the scratch file is
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/data/fs131/ia2/ProcedureLastLines.lean`, and it reaches your tree by the merge):

> theorem exists_arcStep (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> ## The last lines for `Procedure` (compiled as `data/fs131/ia2/ProcedureLastLines.lean`; `lake env lean` only)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/data/fs131/reports/FS131-IA2.md

The declaration both sides state, proved on the arc step's line and `sorry` in the outward bend's skeleton with the same signature — keep the
skeleton's (`BendAway`), delete this one (an implementer is copying its proof into `BendAway` on another branch):

> theorem LocalStep.of_cutArcs {M : ArcMap k} {K : Set ℂ} {S : Set Arc} {P : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/ArcStep.lean

The interface's away instance, whose hypothesis is `bend_away_part`'s conclusion as one conjunction; the planner weakened two clauses of that
conclusion after this was written (the horn clause, which this already has, and the last clause), so its hypothesis `hM` follows the statement as it
stands in the skeleton's `BendStep`:

> theorem ArcBend.of_away {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/ArcStep.lean

> ### 3.0 The statement as it now stands, and the two weakenings (both pre-ruled)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-bendaway-kernel-plan.md

## Done means

1. **Your readback first**: check every quotation above against its source; read FS131-IA2's report whole and its record's Stages 6–8
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/plans/FS131-arcstep-implementation.md`), FS131-IR3's Stage 23 in this branch's
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md` (the restatement already made), and the planner's § 3.0 and § 3.1. Build this branch once as given (expect it
   up to date: 6 distinct `sorry` warnings, one in `Procedure`). Open your record with what you may and may not change. Commit and push.
2. **The merges**, each its own commit, each checked before the next: first `git merge origin/fs131-w5y` (at `3f8270c0`); then
   `git merge dd8c2c33` — **that commit, not `origin/fs131-w5a`'s tip**, which an implementer is moving. A trial of each shows two conflicts:
   `scripts/Axioms.lean` — keep every block; `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md` — both sides' stages in number order (this line's 60–62 after
   56–59). The density half's modules (`BaseDense`, `HexRing`, `BendCollar`, `BaseWalk` and their neighbours) come from `fs131-w5y`'s side, where
   FS131-IA1 joined them; this branch's copies were stale and are replaced without conflict. A conflict beyond these is a message to me. Check by
   script that no statement of either side changed and which names are declared twice (the tools of the earlier joins are in your tree after the
   first merge; today they are at `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/tools/fs131_ia_merge_check.py` and `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/tools/fs131_ia_dupes.py`; each with a plant that fires). A merge is committed as a merge, not by
   path: check the index holds the merge and nothing else first, and say so.
3. **The one doubled declaration**: `LocalStep.of_cutArcs` — delete `ArcStep`'s copy with its proof; `ArcStep` then reads `BendAway`'s (through
   `BendStep`'s imports, or by an import of its own). `CollarFit.map_localStep` and what rests on it are then on `sorryAx` through `BendAway`'s
   `sorry` until the implementer's proof arrives by a later merge: expected, and said in your record. **The one ruled edit**: `ArcBend.of_away`'s
   hypothesis follows `bend_away_part`'s conclusion as the skeleton has it; its proof changes where it read the old last clause (the interface's
   field `left` needs only the contact at the angle, which is now the clause itself).
4. **The last lines**, in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean`: the import of `ArcStep` (and its `ARCHITECTURE.md` row); `IsMaxRingArc.meet`; `exists_arcStep`'s
   docstring and proof, from FS131-IA2's text; the module docstring's lines about the arc step corrected (a collar bend, uncleaned, read through
   `ArcStep`). The statement and the caller's lines are already in place — do not change them.
5. **The check**: a build; the `sorry` warnings by file — expect them only in the outward bend's six modules and at `BendStep`'s
   `CollarFit.map_hornCount_le`, none in `Procedure`, `Terminal`, `ArcStep`, `BaseDense`, `HexRing` or `BendCollar`; an axioms print —
   `exists_arcStep`, `exists_procStep`, `exists_terminalSeq`, `exists_terminalMap`, `exists_red`, `exists_terminal` with `sorryAx` and nothing else
   foreign; `exists_vertexStep`, `stuckRun_ne_univ`, `bend_toward_collar`, `exists_preBend`, `bv_l3`, `exists_open` on the standard three; a control
   that fires. `tools/check_architecture.py` exit 0. No statement of a proved declaration changed (by script, the one allowed edit named). No new
   `axiom`, no `native_decide`.
6. You do not run the gate, touch `main`, edit the outward bend's modules, or begin the remedy pass (the docstring and statement tidies of the
   audit: a later job's, on this line). Do not edit a file while a build of it runs. Leave no background process running, and keep what your
   record cites under `data/fs131/m7/`.
7. **Your record**, stages headed "Stage n — SAVED (FS131-M7)"; the report in standing rule 11's form, ending with **what the two later merges
   will meet** (the implementers' branches `fs131-w5a` and `fs131-w5z` coming into this line: which files, which conflicts you foresee) and the
   list of names that stand twice or statements that stand under two names in the joined tree, for the remedy pass. Stopping at a saved stage with
   the merges checked and the last lines not yet placed is a good report.

## What is yours to decide

How to resolve the two expected conflicts, the place of `IsMaxRingArc.meet` and of the import, and whether `ArcStep` takes `BendAway` by an import of
its own. If FS131-IA2's text needs a change to compile in the joined tree — it was compiled against the old `bend_away_part` restated in scratch —
make the smallest one and record the diff. If the join shows something the three lines' jobs could not see from their own branches, say so. Three
failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
