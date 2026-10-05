# Brief FS131-I5l — wave 5 of the Lean backlog, the `Terminal` half continued: the CV-HD cluster, the limit constructions and `cv_exists` on `fs131-w5c`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5l
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's fourth `Terminal` implementer — continue FS131-I5k's work on `fs131-w5c` from its Stage 34, in item 341's order, saving after each leaf
  launch: now, beside FS131-IMM2 (MERGE, on `fs131-w4mm`) and FS131-RW1 (the boundary walk's WALK lane, on `fs131-w5p`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, a step of a hand derivation that fails in Lean, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5l.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5c`; you continue it from Stage 35, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`): `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/HornShadow.lean`; in `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` only `cv_exists` and children beside it; supporting lemmas in `FlankUA` or a new module upstream of `Terminal` (statements of other files unchanged); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5h", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-I5-implementation.md`, `tools/fs131_i5h_*.py`, `tools/fs131_i5l_*.py`, `data/fs131/i5k/`, `data/fs131/i5l/`, `data/fs131/reports/FS131-I5l.md`; **not** `HexRing`, `Cor3`, `BaseWalk`, `Dense`, `MapGraph` or `BaseDense` outside `cv_exists` (the other lanes'), nor wave 4's modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are continuing the `Terminal` half of wave 5 of the Lean backlog. Wave 5 is **termination and density**: the terminal valid map the moves reach,
the ends of stuck chains, row 134's base step with unit arcs, and the density results built on it. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`. FS131-I5k has just closed the ends of stuck chains: NB3-END items 3–5 are kernel
theorems, so FS112-N3-END (`n3_end`) has no `sorry` beneath, and `cv_class` is proved over two leaves still open. The seven leaves left on this half are yours.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5 lands only
when its lanes finish. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your leaves, on `fs131-w5c` at `8458054e` — `cv_hd_main`, `y3_end_needs`, `cv_hd`, `c_double`, `c_ends`, `exists_red`, `exists_terminal` (`Terminal`) and
`cv_exists` (`BaseDense`) — each read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md` §§ 3.2 and 8.2. What I5k handed back, and the ruling that launches you:

> 340. **FS131-I5k handed back: FS112-N3-END is held** (Stage 34 SAVED, harness ≈ 434k by the task notice; record `fs131-w5c`'s `plans/FS131-I5-implementation.md`,
> — source: plans/FS131-close-inventory.md

> 341. **Ruling on I5k's slot: the `Terminal` continuation, FS131-I5l, on `fs131-w5c` from Stage 34.** In flight after it: 1 (IMM2) + 1 (RW1) + 1 (I5l) = 3. Choice:
> — source: plans/FS131-close-inventory.md

Where each leaf stands, in I5k's words — read its Stages 33–34 in full, and I5h's Stage 28 notes:

> - **`cv_hd`** (M, over `cv_hd_main`): the cycle `G_N → υ± = 1 → H_S → λ± = −1 → G_N`. `G_N → υ±` is already in the kernel inside `n3_end`'s
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 34 — SAVED (FS131-I5k): `cv_class` proved over `cv_hd`, `c_double` and a general form of E5

> - **`cv_hd_main`** (H: FS114-CVB § 1.6, both branches; its `¬G_N` branch consumes `y3_end_needs`), **`y3_end_needs`** (H: YB3 § 3.1): not started.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 34 — SAVED (FS131-I5k): `cv_class` proved over `cv_hd`, `c_double` and a general form of E5

> - **`c_double`** (E–M over `cv_hd`): all four arcs unit gives `λ±`, hence `G_N ∧ H_S` by `cv_hd`; the (Q) arcs from `flankQ_upper_of_qrOnly` /
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 34 — SAVED (FS131-I5k): `cv_class` proved over `cv_hd`, `c_double` and a general form of E5

> - **`c_ends`** (M, with `stuckAlong_of_run`), **`exists_red`**, **`exists_terminal`** (H, the limit constructions), **`cv_exists`** (`BaseDense`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 34 — SAVED (FS131-I5k): `cv_class` proved over `cv_hd`, `c_double` and a general form of E5

The planar job's fence, which stands:

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

`exists_merge` has left wave 4 (it lands later on its own), so nothing in wave 5 may cite it:

> 295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate,
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read I5k's Stages 32–34, I5h's Stage 28, and the hand derivations each leaf's
   route names (FS114-CVB § 1.6, YB3 § 3.1, and the plan's §§ 3.2 and 8.2 rows); build `fs131-w5c` once as given (`8458054e`) before editing anything. Commit and
   push.
2. **The order of item 341**: `cv_hd` over `cv_hd_main` (with `y3_end_needs`), `c_double`, `c_ends`, then `exists_red`, `exists_terminal`, `cv_exists`. Save
   after each leaf; no statement changed, no new `axiom`, no `native_decide`; re-price from your first two hard leaves. Run `tools/fs131_i5h_stmt_check.py
   72149b07` before each stage commit. Do not edit a file while a build of it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control that must show `sorryAx`. You do not merge into `fs131-w5`, take `main` into this branch, run the gate, or touch `main`; the merge happens
   on my word. A wave-4 lemma proved on `main` but `sorry` here may be cited by statement (it resolves at the landing); a copy under a new name, like
   `isRingArc_lower_ua`, only when the citation cannot work, with a docstring saying so.
4. **Your record**, stages headed "Stage n — SAVED (FS131-I5l)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage
   with leaves left, named, is a good report.

## What is yours to decide

The proofs, their children and order within the order's dependencies, and where a supporting lemma lives within your touches. I5k's notes are a route, not a
rule. If a step of a hand derivation fails in Lean, stop that leaf and message me with the step and the smallest counterexample or the missing hypothesis — it
goes back to Ephodos — and go on with the others. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You
start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.
