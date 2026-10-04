# Brief FS131-IW — Woodall's chain in the kernel: replace the `sorry` declarations on branch `fs131-ww`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IW
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow
  role: the first implementer on Woodall's chain ("maps need six") — prove its leaves from the planners' skeleton and plan, in the handoff's order, saving after each; the gate and the landing wait for waves 3–4 and FS131-LEB
  launch: now, beside FS131-I2f and FS131-I3f (implementers), and FS131-E2 (a deriver, no Lean), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IW.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IW-implementation.md` (on branch `fs131-ww`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww` (branch `fs131-ww`): the four modules under `Proofs/HadwigerNelson/Plane/Woodall/` (children only in `Basic` and `NoFourFive`, whose definitions do not change), supporting lemmas in the foundation modules (statements of other waves unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-IW-implementation.md`, `tools/fs131_iw_*.py`, `data/fs131/iw/`, `data/fs131/reports/FS131-IW.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are formalizing a classical theorem in the form this project repaired today: every five-colour map colouring of the plane whose boundaries are
segments and circular arcs has two points at distance exactly 1 in one colour's open regions — "maps need six", Woodall 1973, Thm 6. Two planners on Opus
wrote the plan: FS131-W stated the chain over `ArcMap` and found two steps of the printed proof that fail; a deriver, FS131-E1, bypassed both with one new
lemma (E1-NO45: no point of a five-colour map in Woodall's normal form lies on the boundary of exactly four or five sectors); FS131-W2 put E1's argument
into the plan, found and repaired one wrong counting step in it, and left no open leaf. Your proofs are the check on E1-NO45: Kooshi's standard is that
the Lean proof is the second check of a hand result (inventory item 111), and this one stands on one mind until you prove it.

## Why this job

"Maps need six, almost everywhere" is what route M's reduction of `χ_m⁰(ℝ²) ≥ 6` rests on (`CLAUDE.md` § The aim, item 4; `LEDGER.md` row 132), and its
newest link, E1-NO45, has been checked only by the planner's reading. A statement that cannot be proved as written is the finding this job most needs to
hear about, at once.

## The statements

The statements are the `sorry` declarations of the four Woodall modules on branch `fs131-ww` at `058c65f8`, read back in
`.claude/worktrees/fs131-ww/plans/FS131-W-kernel-plan.md` §§ 3.1 and 8.4–8.5, with the leaf plans in §§ 4.5 and 9.3 and the handoff in § 9.5. Read § 9.5 in
full first; from its first paragraph:

> `.lake/build` its own copy — never replace it with a symlink), on wave 4's full skeleton `f620977c`. Four modules: `Plane/Woodall/Basic` (sorry-free;
> — source: .claude/worktrees/fs131-ww/plans/FS131-W-kernel-plan.md § 9.5

and from its rule:

> waves unchanged), and imports (updating `ARCHITECTURE.md`, `scripts/Axioms.lean`, then `tools/fs131_w2_decls.py --check`). It may not change any
> — source: .claude/worktrees/fs131-ww/plans/FS131-W-kernel-plan.md § 9.5

(each sentence runs on there; read both paragraphs whole).

## Done means

1. **Your readback first**: check both quotations against their source; restate in your record what you may and may not change; build the worktree once,
   exactly as given (`058c65f8`), before editing anything. Commit and push.
2. **The leaves proved in § 9.5's order** — `Collar`'s foundation, then `NoFourFive`'s region-only tools, then its map-level leaves through E1-BAD, then the
   rest of `Collar`, then `Steps` — no statement changed, no new `axiom`, no `native_decide`; save after each leaf; re-price from your first two hard leaves
   and say so in the record. `exists_woodallMerged` is last: re-price it first and ask me for a separate job if it outgrows your context.
3. **Waves 3–4 and Lebesgue's covering theorem are not yours**: their statements are cited as committed at `f620977c`. Merge `main` only once wave 3 or 4
   has landed there; `lebesgue_covering_square` stays a `sorry` until FS131-LEB lands. The gate runs when every leaf is proved and those have landed.
4. **Your record**, in stages headed "Stage n — SAVED", with "Theorems this phase proved": one line per row theorem — its declaration, its axioms (from a
   `#print axioms` print until the gate runs, saying so), the row it was read against.
5. The report, in standing rule 11's form. Stopping at a saved stage with leaves left, and naming them, is a good report.

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
