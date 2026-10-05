# Brief FS131-KB2 — the strengthened bend constructed, and `exists_preBend` over it, on `fs131-w5`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KB2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the strengthened bend's construction — land `bend_toward_collar` (FS131-I5o's statement) in a module of its own upstream of `BaseDense`, construct it (the multi-arc collar lens, the push, full circles as their own case), then prove `exists_preBend` over it, saving after each part
  launch: now, beside FS131-KL1 (the limit constructions' planner, on `fs131-w5c`) and FS131-ML1 (MERGE's landing, on `fs131-w4mm`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a clause of `bend_toward_collar` that cannot be constructed as stated, a statement that looks false, a lemma it needs that lives only in a wave-4 module, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-KB2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5`; you continue it from Stage 43, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): a new module `Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` (upstream of `BaseDense`; importing what `bendMap` and the surgery need), `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` (`exists_preBend` and children beside it; not `cv_exists`), `data/fs131/i5o/BendCollar.lean` (to delete once its content is in the library); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5g", which you extend), `plans/FS131-I5-implementation.md`, `tools/fs131_kb_*.py`, `data/fs131/kb/`, `data/fs131/reports/FS131-KB2.md`; **not** `HexRing`, `BaseWalk` (`bv_l3`'s move is the next job's), `Terminal`, `Dense`, `MapGraph`, nor wave 4's modules on this branch (stale copies — cite their statements; a change there would not land)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are building the strengthened bend that wave 5's pre-bend step needs, in the Lean backlog. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`, and wave 5 (termination and density) is nearly proved — `row134BaseUA`, row 134's
base step with unit arcs, has just become a kernel theorem on this branch, and `n3_base` waits only on `exists_preBend`. FS131-I5o found that wave 4's landed
bend (`bendMap`) cannot give E4-BEND-UN's collar where an end of the arc is a horn (its lens tips are always transversal), stated the strengthened bend in the
form it believes true, and wrote construction notes. You build it.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and `exists_preBend`
is on wave 5's path. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

The leaf, `sorry` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` at `4a0e5c28` (read it whole there), and the child I5o stated (read it whole in its scratch file), their first lines:

> theorem exists_preBend {F : ArcMap 6} (hF : F.Valid) {u : ℂ} (hu2 : F.Covers u 2) (hu : F.IsCubicTrichromatic u) (hH : F.BaseHyp u)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean

> theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/data/fs131/i5o/BendCollar.lean

E4-BEND-UN, the derivation the child reads back against (read its argument in full in `plans/FS131-E4-derivation.md`):

> - **E4-BEND-UN** — the toward-bend keeps the un-enclosure hypothesis — [hand], one mind, a sketch at the collar push — § Argument for E4-BEND-UN.
> — source: plans/FS131-E4-derivation.md

I5o's construction notes — read § 41.2 in full, and §§ 41.1 and 41.3:

> 1. **Why `bendMap` cannot give the collar** (wave 4, `UnitArc` on `main`, `bendMap P θ₁ θ₂ a L j`): the bent map has exactly one new `Arc` `a` through both
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md 41.2 Notes for the construction job (the collar bend)

> 2. **The construction in mind.** (a) *The lens boundary*: at a horn end, a circle arc through `A` tangent to `α` with curvature strictly between `1` and `κ_ρ`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md 41.2 Notes for the construction job (the collar bend)

> 6. **Full circles** (`hlen`): a whole inert circle `ω(P) ⊆ Γ` has no ends; it needs its own case (an annular lens bounded by a concentric circle of radius
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md 41.2 Notes for the construction job (the collar bend)

The findings and rulings that shaped the child, and the rulings that launch you:

> 359. **FS131-I5o, by message (mid-job): `exists_preBend`'s strengthened bend needs more than wave 4's bend machinery** — ruling 317 (b)'s trigger. (1)
> — source: plans/FS131-close-inventory.md

> 360. **Ruling on item 359.** (a) **Accepted: the strengthened bend as a stated child of `exists_preBend`**, read back against E4-BEND-UN in I5o's record, with
> — source: plans/FS131-close-inventory.md

> 365. **FS131-I5o, by message: a correction to item 363 — finding (1) retracted, finding (2) narrowed.** (1) **Retracted** (one retraction, I5o's): a unit arc
> — source: plans/FS131-close-inventory.md

> 366. **Ruling on item 365: FS131-E6 withdrawn; KB2 unblocked.** (a) No Ephodos job: finding (1) is retracted by its author with a validity argument, and
> — source: plans/FS131-close-inventory.md

> 369. **FS131-I5o handed back: `row134BaseUA` is held on `fs131-w5`** (Stage 42 SAVED, harness ≈ 384k by the task notice; record `fs131-w5`'s
> — source: plans/FS131-close-inventory.md

> 370. **Rulings on I5o's held items, and its slot.** (a) **`bv_l3` moves**, statement verbatim, to `BaseWalk` after `l3_base` (where its route's inputs live),
> — source: plans/FS131-close-inventory.md

> 317. **Rulings on I5f's questions, and its slot.** (a) **I5f's slot → FS131-I5g on `fs131-w5`**, the same half: `row134BaseUA`'s four first (`reduce` by I5f's
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

## Done means

1. **Your readback first**: check every quotation above against its source; read I5o's Stages 38–42 and E4-BEND-UN's argument; build `fs131-w5` once as given
   (`4a0e5c28`) before editing anything. Commit and push.
2. **The child landed**: `bend_toward_collar` moved from `data/fs131/i5o/BendCollar.lean` into the new module `Plane/ValidMap/BendCollar`, statement verbatim
   (checked by script), `sorry` at first; build. Commit. Delete the scratch file.
3. **The construction**: the collar lens (bounded by several arcs, horn-shaped tips where an end is a horn), the push and its homeomorphism, the clauses
   (validity, same domain, `RingArcsWithin`, R1–R3, no new inert arc, colour transport), and full inert circles as their own case — children in `BendCollar`,
   saved after each; re-price after the first two.
4. **`exists_preBend` over it**: the iteration of record § 41.3 (strong induction on the number of maximal constant-sided unit arcs centred in `B̄(u, 1)`), the
   finiteness child, and `hfree` from `BaseHyp` with local finiteness — in `BaseDense`, beside the leaf. No backlog statement changed, no new `axiom`, no
   `native_decide`; run `tools/fs131_i5_stmt_check.py d61edefc` before each stage commit. Do not edit a file while a build of it runs.
5. **Your record**, stages headed "Stage n — SAVED (FS131-KB2)", "Theorems this phase proved", each with its build log and an axioms print including a control on
   `sorryAx`; the report in standing rule 11's form. You do not merge `main` or another branch into this one, run the gate, or touch `main`. Leave no background
   process running. Stopping at a saved stage with parts left, named, is a good report.

## What is yours to decide

The construction, the children and their order, the exact form of the lens, and where a supporting lemma lives within your touches. I5o's notes are a route,
not a rule; its child is the statement to build, and a clause it cannot meet is a message to me with the configuration, never a silent change. If the collar
lens turns out not always constructible, stop and message me with the configuration: that goes to Ephodos. Three failed attempts on one route is a dispatch to
the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can
only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.
