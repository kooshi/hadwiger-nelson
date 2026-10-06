# Brief FS131-IA1 — the arc step's groundwork on `fs131-w5a`: wave 5's two lines joined, what `exists_arcStep` needs from the bends, and their step forms

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IA1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the arc step's first implementer — join wave 5's two lines on a branch of your own, then work out what `exists_arcStep` needs from each bend, prove those step forms in a module of their own upstream of `Procedure`, settle its last clause, and say exactly what bend is still missing, saving after each
  launch: now, beside FS131-IR2 (the vertex step, on `fs131-w5c`, which holds `Procedure.lean`) and FS131-IS1 (`stuckRun_ne_univ`, on `fs131-w5s`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a merge conflict beyond the ones named below, a clause of the arc step that looks false, a bend's private detail you need exported from a landed module, the statement of a bend that turns out to be missing, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IA1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-arcstep-implementation.md` (new, on branch `fs131-w5a`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a` (branch `fs131-w5a`, cut from `fs131-w5c` at `ebb0b292`): the merge's files; a new module `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean` (upstream of `Procedure`, downstream of `Limit`, `UnitArc` and, if you use it, `BendCollar`) with `Proofs.lean` and `ARCHITECTURE.md` for it; **new declarations only** in `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean` (a named form that exposes a bend's map, or a `private` helper made public — no statement or definition changed; ruling 421 (c)'s rule, extended to the bends); `scripts/Axioms.lean` (a block of your own, headed "FS131-IA1", above the `=== PURCHASED ===` banner), `plans/FS131-arcstep-implementation.md`, `tools/fs131_ia_*.py`, `data/fs131/ia/`, `data/fs131/reports/FS131-IA1.md`; **not** `Procedure.lean` beyond what the merge brings (FS131-IR2 is proving the vertex step in it on `fs131-w5c`; the arc step's assembly there is a later job's), `Terminal.lean`, the move modules, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

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

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The rulings that launch you, and what the last jobs handed back:

> 427. **Rulings on QA4's list and the rule.** (a) **Before wave 5 lands, at its final sync** (one remedy pass, in the job that joins the branches, so no
> — source: plans/FS131-close-inventory.md

> 421. **Rulings on IR1's held items, and its slot.** (a) **`clean` and `cleanKeep` both stay** until wave 5 has landed; unifying them (one colour function)
> — source: plans/FS131-close-inventory.md

> 420. **FS131-IR1 handed back** (Stage 17 SAVED, harness ≈ 505k by the task notice; record `fs131-w5c`'s `plans/FS131-limit-kernel-plan.md`, Stages 12–17;
> — source: plans/FS131-close-inventory.md

> 424. **FS131-I5q done: wave 5's non-`Terminal` lane holds no open leaf of its own** (harness ≈ 574k by the task notice, past its line; record `fs131-w5`'s
> — source: plans/FS131-close-inventory.md

> 416. **FS131-CC2 done: the collar bend is proved** (harness ≈ 514k by the task notice; record `fs131-w5k`'s `plans/FS131-collar-C-implementation.md`,
> — source: plans/FS131-close-inventory.md

and the earlier rulings the step's clauses come from:

> 385. **Rulings on E6's held items, and its slot.** (a) **`exists_arcStep`'s horn clause accepted** ("`∀ x j, F.HasHornCount x j → ∃ j′ ≤ j, F′.HasHornCount x
> — source: plans/FS131-close-inventory.md

> 411. **Rulings: the three slots, filled from the queue of the handoff.** (a) **FS131-CC2**, lane C's continuation on `fs131-w5k` (item 406 (d)). (b)
> — source: plans/FS131-close-inventory.md

> 372. **Rulings on item 371.** (a) **`ArcMap.clean` accepted** as the plan's repair, with the moves' new exported lemmas as **new declarations only** (no landed
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. The arc step, as it stands on `fs131-w5a` at `ebb0b292` (`sorry`; read it whole there, with its docstring), its first
line and its last clause, which is the planner's question (5):

> theorem exists_arcStep (hF : F.Valid) (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

>       ∀ Q ∈ T, Q ≠ P → F'.coloursAt Q ⊆ F.coloursAt Q ∧
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

The planner's route and the bends' step forms it asks for (read both rows whole), and what the last implementer left ready:

> | `exists_arcStep` | derives over three bends and **question (5)** | in-only or inert (`c' ∉ P_cl(P)`): `bend_toward`; out-only, no witness on the whole arc: `bend_away_whole`; out-only with a partial witness: N2-TAN's tangent bend (not in `main`'s `UnitArc` by that name — grep `n2_tan`, `bend_away` first; if absent, a new child **`bend_away_part`**, H). Then `exists_clean`. `badCount P` drops (the arc removed or left as (R2) pieces; `P`'s colours and its other arcs' witnesses untouched: the lens lies within `ε` of the arc, the witnesses at distance `2`). Last clause: the lens's closure avoids `T` off the arc (`T` locally finite, `ε` small); centres on the arc's open part only lose `c`; **(5)**: a witness `R₂(β) ⊆ cl(region d)` cannot cross the open arc (beyond it lies the outer tile, colour `c' ≠ d` when `d = c`; tangency puts it locally outside) — one mind's sketch, child **`witness_not_cross`**. **H** |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-limit-kernel-plan.md 3.1 The pass, statement by statement (each: what the proof derives from; children; a missing hypothesis)

> | `bend_step` (toward, away): `LocalStep F F' (cthickening ε (ringArc P θ₁ θ₂))`, sites' degrees unchanged, no site created, colours at points of `T` off the arc unchanged | `UnitArc`'s `bendMap` (arcs, lens `L`), `bendMap_region`; **private detail** — `bendMap`'s arc set is not exported by `bend_toward`'s statement |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-limit-kernel-plan.md 3.3 The moves' lemmas, for the module downstream of `Moves` and `MergeMove` (ruling 372 (a); new declarations only)

> **Left 2 — `exists_arcStep`** (`sorry`; H; not started). Its consumer reads every clause as stated (Stage 15), the horn clause included. Ready:
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-limit-kernel-plan.md 17.3 What is proved, and what is left (three leaves), each with the route it is ready for

The bends on file. Wave 4's two, on `main` and on your branch:

> theorem bend_toward (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean

> theorem bend_away_whole (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean

The collar bend, proved on `fs131-w5` (at `8ca5fc67`; it reaches your branch by the merge below) — read its statement whole: it gives a homeomorphism that
carries interior points, colours, degrees and repeated colours, and the clauses R1–R3 on unit arcs:

> theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

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
fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
