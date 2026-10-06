exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
A=WT+"fs131-w5a/"
PR=A+"Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean"
UA=A+"Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean"
KL=A+"plans/FS131-limit-kernel-plan.md"
BC=WT+"fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean"
I5=WT+"fs131-w5/plans/FS131-I5-implementation.md"
H31="3.1 The pass, statement by statement (each: what the proof derives from; children; a missing hypothesis)"
H33="3.3 The moves' lemmas, for the module downstream of `Moves` and `MergeMove` (ruling 372 (a); new declarations only)"
H173="17.3 What is proved, and what is left (three leaves), each with the route it is ready for"
b=f'''# Brief FS131-IA1 — the arc step's groundwork on `fs131-w5a`: wave 5's two lines joined, what `exists_arcStep` needs from the bends, and their step forms

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IA1
  identity: {IDENT}
  role: the arc step's first implementer — join wave 5's two lines on a branch of your own, then work out what `exists_arcStep` needs from each bend, prove those step forms in a module of their own upstream of `Procedure`, settle its last clause, and say exactly what bend is still missing, saving after each
  launch: now, beside FS131-IR2 (the vertex step, on `fs131-w5c`, which holds `Procedure.lean`) and FS131-IS1 (`stuckRun_ne_univ`, on `fs131-w5s`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a merge conflict beyond the ones named below, a clause of the arc step that looks false, a bend's private detail you need exported from a landed module, the statement of a bend that turns out to be missing, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IA1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/FS131-arcstep-implementation.md` (new, on branch `fs131-w5a`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a` (branch `fs131-w5a`, cut from `fs131-w5c` at `ebb0b292`): the merge's files; a new module `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean` (upstream of `Procedure`, downstream of `Limit`, `UnitArc` and, if you use it, `BendCollar`) with `Proofs.lean` and `ARCHITECTURE.md` for it; **new declarations only** in `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean` (a named form that exposes a bend's map, or a `private` helper made public — no statement or definition changed; ruling 421 (c)'s rule, extended to the bends); `scripts/Axioms.lean` (a block of your own, headed "FS131-IA1", above the `=== PURCHASED ===` banner), `plans/FS131-arcstep-implementation.md`, `tools/fs131_ia_*.py`, `data/fs131/ia/`, `data/fs131/reports/FS131-IA1.md`; **not** `Procedure.lean` beyond what the merge brings (FS131-IR2 is proving the vertex step in it on `fs131-w5c`; the arc step's assembly there is a later job's), `Terminal.lean`, the move modules, `main`
  budget: {BUDGET}

Hello. You are opening the last unexamined piece of the termination procedure in the Lean backlog. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–4, Woodall's chain, MERGE and OPEN are on `main`. On wave 5's `Terminal` line, `exists_terminalMap` — every valid
map of the plane has a modification that is a terminal valid map — rests on two open lemmas: the vertex step, which FS131-IR2 is proving now, and the arc
step, which bends a bad unit arc away. Nobody has yet read the arc step against what the bends in the library actually export. The planner routed it
through wave 4's two bends; since then a much stronger bend has been proved on wave 5's other line — the collar bend, which comes with a homeomorphism of
the plane that carries degrees and colours — and it may serve better. You find out, and you prove the pieces that do not depend on `Procedure.lean`, which
another job holds today.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and this is the
longest unexamined piece on wave 5's path to it. Kooshi, on pricing this work:

{KOOSHI}
The rulings that launch you, and what the last jobs handed back:

{item(427)}
{item(421)}
{item(420)}
{item(424)}
{item(416)}
and the earlier rulings the step's clauses come from:

{item(385)}
{item(411)}
{item(372)}
## The statements

No statement changes in this job. The arc step, as it stands on `fs131-w5a` at `ebb0b292` (`sorry`; read it whole there, with its docstring), its first
line and its last clause, which is the planner's question (5):

{Q(PR,"theorem exists_arcStep ")}
{Q(PR,"      ∀ Q ∈ T, Q ≠ P → F'.coloursAt Q ⊆ F.coloursAt Q ∧")}
The planner's route and the bends' step forms it asks for (read both rows whole), and what the last implementer left ready:

{Q(KL,"| `exists_arcStep` |",H31)}
{Q(KL,"| `bend_step` (toward, away):",H33)}
{Q(KL,"**Left 2 — `exists_arcStep`** (`sorry`; H; not started).",H173)}
The bends on file. Wave 4's two, on `main` and on your branch:

{Q(UA,"theorem bend_toward ")}
{Q(UA,"theorem bend_away_whole ")}
The collar bend, proved on `fs131-w5` (at `8ca5fc67`; it reaches your branch by the merge below) — read its statement whole: it gives a homeomorphism that
carries interior points, colours, degrees and repeated colours, and the clauses R1–R3 on unit arcs:

{Q(BC,"theorem bend_toward_collar ")}
## Done means

1. **Your readback first**: check every quotation above against its source; read KL1's plan §§ 3.1 and 3.3, IR1's Stages 14–17 in the same record, and
   E6's § 4.4 row on the arc step (`plans/FS131-E6-derivation.md`); build `fs131-w5a` once as given (`ebb0b292`; the build was copied from another line's
   tree, so expect `Limit`, `Procedure`, `Terminal`, `OpenMove` and their neighbours to compile); open your record with what you may and may not change.
   Commit and push.
2. **The sync**: `git merge origin/fs131-w5` (at `8ca5fc67`) into `fs131-w5a`. Expected meetings: `BaseDense` — `fs131-w5`'s side for `exists_preBend`'s
   children and helpers, this line's for `cv_exists`'s proof; `HexRing`, `BaseWalk`, `BendCollar`, `RadialPush`, `CollarMap`, `Pushforward` —
   `fs131-w5`'s; `scripts/Axioms.lean`, `Proofs.lean`, `ARCHITECTURE.md` — both sides; `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-I5-implementation.md` — both sides' stages in number
   order (this line's 52–55, then `fs131-w5`'s 56–59). A conflict beyond these is a message to me. Check by script that no statement of either side
   changed and no declaration is defined twice (IR1's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/tools/fs131_ir_merge_check.py` and `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/tools/fs131_ir_dupes.py`, each with a plant that
   fires). Build. An axioms print: `bend_toward_collar`, `exists_preBend`, `exists_open`, `exists_terminalSeq`'s dependence as IR1 left it, a control.
   Commit the merge as its own stage and push.
3. **The reading**, written in your record before any proof: clause by clause of `exists_arcStep`, which bend can supply it in each case of the step
   (the outer colour absent at `P`; the inner colour absent; a witness on part of the arc), what that bend exports today, and what is hidden. Say which
   bend you would build the step on in each case and why — wave 4's `bend_toward` and `bend_away_whole`, or the collar bend and a like construction
   pushing the other way — and **whether some case needs a bend that is proved nowhere** (N2-TAN's tangent bend; wave 4's `bend_away`, left `sorry` on
   branch `fs131-w4ba` at `71cca146`, is its last statement). If so, write the exact statement the step needs from it, as a `sorry` child named
   `bend_away_part` in `BendStep`, and message me that statement at once: a planner will plan to it.
4. **The step forms**, in `BendStep`, saving after each: for each bend you build on, the form the arc step reads — a local step on the closed thickening
   of the arc, no site created, every site's degree kept, no horn count raised, the colours at the points of `T` — before cleaning (the cleaning,
   `cleanKeep`, lives in `Procedure` and is the assembly's). And **question (5)**, the step's last clause: a bend's lens never cuts another arc's (R2)
   witness — the planner's sketch is one mind's; prove it as a lemma of its own or message me with where it fails.
5. No statement or definition changed anywhere; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not edit
   `Procedure.lean`, merge into `fs131-w5c`, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under
   `data/fs131/ia/`.
6. **Your record**, stages headed "Stage n — SAVED (FS131-IA1)", "Theorems this phase proved"; the report in standing rule 11's form, ending with the
   assembly's work list: what `exists_arcStep`'s proof in `Procedure` still needs, clause by clause, for the job that will hold that file. Stopping at a
   saved stage with the reading done and part of the forms proved is a good report.

## What is yours to decide

Which bend the step is built on, the step forms' statements, and the order. The planner's route is a plan written before the collar bend existed; you
are free to leave it. If a clause of the arc step is false for the bend that must supply it — the horn clause at an end vertex is the one E6 flagged —
stop that clause and message me with the configuration. Three failed attempts on one route is a dispatch to the companion your identity names, never a
fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/FS131-IA1-arc-step.md","w").write(b)
