# Brief FS131-IWb — Woodall's chain in the kernel, continued: the last four leaves of `Plane/Woodall/Steps`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IWb
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the second implementer on Woodall's chain ("maps need six") — state the connected-piece child lemma the plan lacks, then prove `step5_lt`, `step6`, `exists_sectorsAt` and `exists_woodallMerged`, saving after each; the gate and the landing wait for waves 3–4 and FS131-LEB
  launch: now, beside FS131-I3h (wave 3, Opus) and FS131-LEB (Lebesgue's covering theorem, about to land), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IWb.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IW-implementation.md` (on branch `fs131-ww`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww` (branch `fs131-ww`): the four modules under `Proofs/HadwigerNelson/Plane/Woodall/` (children only in `Basic` and `NoFourFive`, whose definitions do not change), supporting lemmas in the foundation modules (statements of other waves unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-IW-implementation.md`, `tools/fs131_iw_*.py`, `data/fs131/iw/`, `data/fs131/iwb/`, `data/fs131/reports/FS131-IWb.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the second implementer on Woodall's chain, and the first on Opus. The first, FS131-IW (Sonnet), proved `Plane/Woodall/Collar` and
`Plane/Woodall/NoFourFive` whole and eight of `Plane/Woodall/Steps`'s twelve leaves — among them E1-NO45 (`ArcMap.false_of_four_le_sectors`), the lemma a
deriver found today to bypass two broken steps of Woodall's 1973 proof, and the assembled theorems `aeMap6`, `aeMap6_of_condition5` and `woodall_thm6`.
E1-NO45's argument closed in Lean exactly as planned, from its citations: that was the check Kooshi's standard asks of a one-mind hand result (inventory
items 111, 150). Four leaves remain, and two of them need a child lemma the plan did not state.

## Why this job

"Maps need six, almost everywhere" is what route M's reduction of `χ_m⁰(ℝ²) ≥ 6` rests on (`CLAUDE.md` § The aim, item 4; `LEDGER.md` row 132). The chain's
assembled theorems are proved over four open leaves and a few statements of waves 3–4 not yet landed; closing the four leaves leaves only those.

## The statements

The leaves are the four `sorry` declarations in `Plane/Woodall/Steps` on branch `fs131-ww` at `a731f352` — `step5_lt`, `step6`, `exists_sectorsAt`,
`exists_woodallMerged` — read back in `.claude/worktrees/fs131-ww/plans/FS131-W-kernel-plan.md` §§ 3.1 and 8.4–8.5, planned in §§ 4.5 and 9.3. The rule (from § 9.5; read the paragraph whole):

> waves unchanged), and imports (updating `ARCHITECTURE.md`, `scripts/Axioms.lean`, then `tools/fs131_w2_decls.py --check`). It may not change any
> — source: .claude/worktrees/fs131-ww/plans/FS131-W-kernel-plan.md § 9.5

IW's record ends:

> `aeMap6_merged` proved and moved after `aeMap6_normal`; `finRotate_ne_symm` added (`n ≥ 3`: the rotation has no 2-cycle). `tools/fs131_w2_decls.py --check`: 115
> — source: .claude/worktrees/fs131-ww/plans/FS131-IW-implementation.md § Stage 3 — SAVED: `aeMap6_merged`; the final build

and the plan gap it found:

> **Plan gap found at `step5_lt` (read while pricing it; not yet a statement defect).** § 4.5's route puts an inner collar about each `ψ` of the arc
> — source: .claude/worktrees/fs131-ww/plans/FS131-IW-implementation.md § Stage 2 — SAVED: the leaves, in

(the paragraph continues there: `SectorsAt` supplies only a direction in the cone of a colour class, a class is a union of tiles and not connected, and
`aeMap6_merged` uses `step5_lt` exactly at a horn; the route is through wave 3's tiles — `exists_mem_coneAt_region`, proved on `fs131-w3` — or the finitely
many arcs near the point). Wave 3's implementer has meanwhile made public, at the end of `Plane/LocalStructure` on `fs131-w3`, an inversion-coordinates engine
(`coneAt_interiors_disjoint`, `GoodAt.exists_wedge` — a thin wedge about a direction meets an arc only if the arc passes through the point tangent to it —
`exists_initialPiece_of_cone`, `Arc.exists_initialPiece_of_approach`); it may be the shortest route to the child lemma. Wave 3 is about to land on `main`
(FS131-I3h); merge `main` once it has, to use those proofs.

## Done means

1. **Your readback first**: check the three quotations against their sources; build the worktree once as given (`a731f352`) before editing anything; restate
   in your record what you may and may not change. Commit and push.
2. **The child lemma** stated (a preconnected piece of a colour class approaching a point along a cone direction, for a horn and for any sector, in the form
   `step5_lt` and `step6` read) and proved, with its `scripts/Axioms.lean` record — a child, not a statement change; if it needs a hypothesis a row lacks,
   message me.
3. **`step5_lt` and `step6`**, then **`exists_sectorsAt`**, then **`exists_woodallMerged`** (re-price it first; IW priced it H+ and suggested a job of its own —
   if it outgrows your context, stop at a saved stage and say so), no statement changed, no new `axiom`, no `native_decide`; save after each.
4. **The gate and the landing** wait for waves 3–4 and FS131-LEB; when they have landed and your leaves are done, merge `main`, run
   `tools/fs131_qa1_dupes.py` (item 142: rename or delete this branch's colliding names — `e_add_int_mul_two_pi`, `e_mul_conj_e`, `abs_dot_le` are known), then
   the gate.
5. **Your record** (you continue IW's), stages headed "Stage n — SAVED", with "Theorems this phase proved"; the report in standing rule 11's form.

## What is yours to decide

The proofs, their children and order within § 9.5's, and where a supporting lemma lives. If a leaf cannot be proved as written, stop that leaf, message me
at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on
one route is a dispatch to the companion your identity names, never a fourth.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5), and
several trees are building today, so on exit 75 wait ten minutes and retry. `lake env lean` (with § 9.5's flags) is for iteration only, never evidence.
The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`. You start no agents of your own
(standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## Amendment 2026-10-04 (Keryx) — `SectorsAt`'s fifth clause, ruled

Your finding is ruled as `plans/FS131-close-inventory.md` item 154. You may change exactly one definition: drop the fifth clause of `SectorsAt` in
`.claude/worktrees/fs131-ww/Proofs/HadwigerNelson/Plane/Woodall/Basic.lean` (the `annSector … ⊆ F.region (c i)` clause, line 66), with its docstring
saying so and the item number. Then re-route the three proofs that read it — E1-RAY inner and outer and E1-BAD's interior case in `Plane/Woodall/NoFourFive` —
through the cone clause, as you proposed, with no statement change; do this first, so the definition change never leaves the build red. Then go on with the
child lemma, `step5_lt`, `step6`, and `exists_sectorsAt` on wave 3's engine. Record every change in your record with the item number. Everything else in this
brief stands, and you still start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## Amendment 2026-10-04 (Keryx) — item 154 refined

Ruled as `plans/FS131-close-inventory.md` item 155: the fifth clause of `SectorsAt` is **replaced by `v ∈ F.dom`** at the same position, not deleted; the three
readers re-route through the cone clause with `hv` from it. Everything else in the previous amendment stands.
