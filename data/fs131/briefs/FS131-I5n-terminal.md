# Brief FS131-I5n — wave 5 of the Lean backlog, the `Terminal` half finished: MERGE's statement corrected, CV-HD's branch `G_N`, `y3_end_needs`, and the limit constructions on `fs131-w5c`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5n
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's fifth `Terminal` implementer — first replace the stale `exists_merge` statement on `fs131-w5c` by ruling 269's form (ruling 348 (a)), then continue FS131-I5l's work from its Stage 38 in item 350's order, saving after each leaf
  launch: now, beside FS131-RW2 (the boundary walk, on `fs131-w5p`) and FS131-IMM3 (MERGE, on `fs131-w4mm`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, a step of a hand derivation that fails in Lean, a need for a MERGE clause the ruling-269 form lacks, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5n.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5c`; you continue it from Stage 39, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`): `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/HornShadow.lean`; in `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` only `exists_merge`'s statement and docstring (ruling 348 (a), its `sorry` body kept); supporting lemmas in `FlankUA` or a new module upstream of `Terminal` (statements of other files unchanged); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5h", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-I5-implementation.md`, `tools/fs131_i5h_*.py`, `tools/fs131_i5n_*.py`, `data/fs131/i5l/`, `data/fs131/i5n/`, `data/fs131/reports/FS131-I5n.md`; **not** `HexRing`, `Cor3`, `BaseWalk`, `Dense`, `MapGraph`, `BaseDense` (the other lanes'), nor any other declaration of wave 4's modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing the `Terminal` half of wave 5 of the Lean backlog. Wave 5 is **termination and density**: the terminal valid map the moves reach,
the ends of stuck chains, row 134's base step with unit arcs, and the density results built on it. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`. On this half every leaf is now proved or proved over four that are left:
`cv_hd_main_inType`, `y3_end_needs`, `exists_red` and `exists_terminal`. FS131-I5l found that the last two need W-MERGE, which wave 5 had barred; that bar is
lifted, but only against MERGE's corrected statement — the copy on this branch is an older form that cannot be satisfied. Your first step fixes that.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and these four leaves
are on wave 5's path beside MERGE's proof. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your four leaves, on `fs131-w5c` at `6d316ef2`, each read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md` §§ 3.2 and 8.2 (`cv_hd_main_inType` is I5l's new child, stated as CVB § 1.6's branch
`G_N`). Where each stands, in I5l's words — read its Stages 36–38 in full:

> 1. **`cv_hd_main_inType`** (H; CVB § 1.6 "Branch `G_N`"). Route in Lean: `lower_flank_horns_at_N` gives `Q±` (the `h`-horns at `N` along `±a`), `N`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 38 — SAVED (FS131-I5l): the shared first step of the two `G_N`-level leaves, the MERGE engine; the CV-HD block placed after NB3-END's lemmas; the handover

> 2. **`y3_end_needs`** (H; YB3 § 3.1 Steps 3–4). Step 2 is `lower_flank_horns_at_N` (its hypotheses are exactly `y3_end_needs`'s with `κ₂ = 1`).
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 38 — SAVED (FS131-I5l): the shared first step of the two `G_N`-level leaves, the MERGE engine; the CV-HD block placed after NB3-END's lemmas; the handover

> 3. **`exists_red`, `exists_terminal`** (H, the limit constructions): **both cite W-MERGE (`exists_merge`)** — N2-RED merges at the centre of every
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 38 — SAVED (FS131-I5l): the shared first step of the two `G_N`-level leaves, the MERGE engine; the CV-HD block placed after NB3-END's lemmas; the handover

MERGE's statement in ruling 269's form, which replaces the copy on this branch — its first line (copy the whole statement and docstring by script, and check
them identical):

> theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean

What I5l handed back, the defect in the old form, and the rulings that launch you:

> 347. **FS131-I5l handed back** (Stage 38 SAVED, harness ≈ 381k by the task notice; record `fs131-w5c`'s `plans/FS131-I5-implementation.md`, Stages 35–38;
> — source: plans/FS131-close-inventory.md

> 268. **Statement defect — `exists_merge` (FS110-W-MERGE) is unsatisfiable as stated** (FS131-QA3, by message, 2026-10-04; record `plans/FS131-QA3-audit.md`
> — source: plans/FS131-close-inventory.md

> 269. **Ruling on item 268: `exists_merge` and `exists_merge_aux` take `F'.coloursAt v ⊆ F.coloursAt v` in place of the off-rim clause.** Choice: IM2 replaces the
> — source: plans/FS131-close-inventory.md

> 348. **Ruling on item 347: MERGE returns to wave 5's path; its continuation takes I5l's slot.** (a) **`exists_red` and `exists_terminal` may cite W-MERGE —
> — source: plans/FS131-close-inventory.md

> 350. **Ruling on I5m's slot: the `Terminal` continuation, FS131-I5n, on `fs131-w5c` from I5l's Stage 38**, as item 348 (d) queued: first ruling 348 (a)'s swap
> — source: plans/FS131-close-inventory.md

The planar job's fence, which stands:

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

## Done means

1. **Your readback first**: check every quotation above against its source; read I5l's Stages 35–38, and the hand derivations the routes name (CVB § 1.6,
   YB3 § 3.1, N2-RED, N2-TERM); build `fs131-w5c` once as given (`6d316ef2`) before editing anything. Commit and push.
2. **MERGE's statement corrected first** (ruling 348 (a)): in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean`, `exists_merge`'s statement and docstring replaced by the text of
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean`'s, copied by script, with a check that the two statement texts are now identical (the diff in your record) and the `sorry` body kept; build. Commit.
3. **The order of item 350**: `cv_hd_main_inType`, `y3_end_needs`, then `exists_red`, `exists_terminal` (citing `exists_merge` in ruling 269's form only). Save
   after each leaf; no backlog statement changed but item 348's swap, no new `axiom`, no `native_decide`; re-price from your first two hard leaves. Run
   `tools/fs131_i5h_stmt_check.py 72149b07` before each stage commit (after the swap, expect `exists_merge` to be the one statement it reports as changed,
   if it checks `Contact` — say so in the record). Do not edit a file while a build of it runs.
4. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control that must show `sorryAx` (`exists_merge` itself serves). You do not merge into `fs131-w5`, take `main` into this branch, run the gate, or
   touch `main`. Stopping at a saved stage with leaves left, named, is a good report.
5. **Your record**, stages headed "Stage n — SAVED (FS131-I5n)", "Theorems this phase proved"; the report in standing rule 11's form. Leave no background
   process running when you hand back.

## What is yours to decide

The proofs, their children and order within the order's dependencies, and where a supporting lemma lives within your touches. I5l's notes are a route, not a
rule. If `exists_red` or `exists_terminal` needs a MERGE clause that ruling 269's form does not give, stop that leaf and message me with the clause — never use
the old form. If a step of a hand derivation fails in Lean, stop that leaf and message me with the step and the smallest counterexample or the missing
hypothesis, and go on with the others. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no
agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.
