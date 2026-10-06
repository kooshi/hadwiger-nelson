# Brief FS131-IS1 — `stuckRun_ne_univ`, the last open theorem in `Terminal`, on `fs131-w5s`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IS1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: `Terminal`'s last implementer — prove `stuckRun_ne_univ` (a stuck run in a terminal six-map is not the whole line of vertices) with its child `shadow_recursion`, on a branch of your own, saving after each child
  launch: when a slot frees (inventory item 421 (e)), beside FS131-IR2 (the vertex step, on `fs131-w5c`, the branch yours was cut from) and the other jobs then running, each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job if the theorem or its child cannot be proved as written, a statement looks false, or for a question you cannot work around; the report goes to `data/fs131/reports/FS131-IS1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (wave 5's record on branch `fs131-w5s`; you continue it from Stage 60, headed as yours — Stages 56–59 are kept for FS131-I5q's on `fs131-w5`, so the later merges join the copies cleanly)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5s` (branch `fs131-w5s`, cut from `fs131-w5c` at `ebb0b292`): `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean` (`stuckRun_ne_univ` and children beside it); `Proofs/HadwigerNelson/Plane/ValidMap/HornShadow.lean` and `Proofs/HadwigerNelson/Plane/ValidMap/FlankUA.lean` for supporting lemmas, **added at the end of the file** (FS131-IR2 may add lemmas to `FlankUA` on its branch; additions at the end merge cleanly); `scripts/Axioms.lean` (a block of your own, headed "FS131-IS1", above the `=== PURCHASED ===` banner), `plans/FS131-I5-implementation.md`, `tools/fs131_is_*.py`, `data/fs131/is/`, `data/fs131/reports/FS131-IS1.md`; **not** `Procedure.lean`, `Limit.lean`, the move modules (FS131-IR2's, on its branch), `BaseDense`, `BendCollar`, `HexRing`, `Proofs.lean`, nor any statement (a change goes to me)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving the last open theorem of the `Terminal` lane in the Lean backlog. The milestone, FS-131, turns this project's hand-derived results
into kernel-checked ones; waves 1–4, Woodall's chain, MERGE and OPEN are on `main`. Wave 5's `Terminal` module studies terminal six-maps — valid six-colour
maps of the plane where no simplifying move is left — and its last leaf says a stuck run cannot go on forever in both directions. FS131-M6 proved the
theorem beside it (the horn bounds at every chain vertex) and left a route for this one, with one child still to write. The procedure's two step lemmas
are being proved on the branch yours was cut from; this theorem shares nothing with them, which is why it has a branch of its own.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`); with this
theorem `Terminal` holds no `sorry`. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the last jobs handed back, and the rulings that launch you:

> 398. **FS131-M6 handed back: `fs131-w5` merged into `fs131-w5c`** (Stage 55 SAVED, harness ≈ 446k by the task notice; record `fs131-w5c`'s
> — source: plans/FS131-close-inventory.md

> 420. **FS131-IR1 handed back** (Stage 17 SAVED, harness ≈ 505k by the task notice; record `fs131-w5c`'s `plans/FS131-limit-kernel-plan.md`, Stages 12–17;
> — source: plans/FS131-close-inventory.md

> 421. **Rulings on IR1's held items, and its slot.** (a) **`clean` and `cleanKeep` both stay** until wave 5 has landed; unifying them (one colour function)
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. The theorem, as it stands on `fs131-w5s` at `ebb0b292` (read it whole there, with its docstring), its first line:

> theorem stuckRun_ne_univ {F : ArcMap 6} (hM : F.IsTerminalMap) {v : ℂ} {α : ℝ} (hv : F.StuckAlong v α)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5s/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean

The route on record, every input named — M6's, which opens (read the paragraph whole):

> **Left — `stuckRun_ne_univ`**, not attempted (budget). Route, KL1's § 3.1 with what Stage 54 adds: along `univ` every `P_j = v + j n` is a chain vertex
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5s/plans/FS131-I5-implementation.md Theorems this phase proved (FS131-M6)

and the planner's row for it:

> | `stuckRun_ne_univ` | derives **given one new child** | along `univ` every vertex is stuck along `±α`; bounds `≠ ±1` (`cv_l0` at the neighbour: a bound `1` puts an arc of `ω(N)` in `Γ` centred at a chain vertex); child **`shadow_recursion`**: for consecutive run vertices `w`, `w + n`, `λ_w ≤ curvDown λ_{w+n}` and `curvUp υ_w ≤ υ_{w+n}` (no SHAVE at a stuck vertex: `shaveAvailable_of_not_doublyShadowed`'s contrapositive with unit arcs, then SH1 `shadow_hornSet_subset_S`/`_N` places the flank's shadow) — then `n4_fin`. Wave 4's `stuck_chain` did the propagation under Condition 5 without the recursion. **M–H** |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5s/plans/FS131-limit-kernel-plan.md 3.1 The pass, statement by statement (each: what the proof derives from; children; a missing hypothesis)

## Done means

1. **Your readback first**: check every quotation above against its source; read the record's Stages 54–55 and the hand derivation behind the route
   (FS110's N4-SHADOW and N4-FIN in `plans/FS110-derivation.md` and the proof file it names); build `fs131-w5s` once as given (`ebb0b292`; expect it up to
   date) before editing anything; open Stage 60 with what you may and may not change. Commit and push.
2. **"No bound is ±1"** first (M6 calls it short now), then the child **`shadow_recursion`**, stated with a docstring that reads it back against
   N4-SHADOW; re-price in the record once the child is stated and its first step compiles.
3. **`stuckRun_ne_univ`** with no `sorry` of its own; then an axioms print: `stuckRun_ne_univ` and `shadow_recursion` on the standard three, and a control
   on `sorryAx`. `Terminal`'s `sorry` count by grep before and after.
4. No statement changed, no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge into `fs131-w5c`, run the gate,
   or touch `main`. Leave no background process running, and keep what your record cites under `data/fs131/is/`.
5. **Your record**, stages headed "Stage n — SAVED (FS131-IS1)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved
   stage with the child stated and part proved, the rest named with its route, is a good report.

## What is yours to decide

The proofs, the child's exact statement, any further children, and where a supporting lemma lives within your touches. M6's route is a plan, not a rule; if
the recursion comes out in a different form than `λ_j ≤ curvDown λ_(j+1)`, take the form the kernel accepts and say so. If the theorem cannot be proved as
written, stop, and message me with the smallest counterexample or the missing hypothesis. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
