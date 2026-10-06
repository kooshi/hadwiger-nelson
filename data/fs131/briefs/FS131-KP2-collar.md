# Brief FS131-KP2 — the collar bend's construction planned: `bend_toward_collar` laid out as named children over KB2's design D1, on `fs131-w5`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KP2
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan the collar bend's construction — read KB2's design D1 against `main`'s bend and cut machinery (now on this branch), lay `bend_toward_collar` out as named children with `sorry` at each, read each back, a plan and a price per child, the obligation pass, and a handoff that can split the work between two implementers; prove a child yourself where it is short
  launch: now, beside FS131-IL2 (the limit's lane A, on `fs131-w5c`) and FS131-IO1 (OPEN, on `fs131-wop`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a clause of `bend_toward_collar` that D1 cannot meet, a statement that looks false, a piece of `main`'s machinery that is private where you need it, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-KP2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-collar-kernel-plan.md` (new, on branch `fs131-w5`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): `Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` (`bend_toward_collar`'s children; its statement unchanged) and new modules upstream of it if your layout wants them; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5g", which you extend), `plans/FS131-collar-kernel-plan.md`, `tools/fs131_kp2_*.py`, `data/fs131/kp2/`, `data/fs131/reports/FS131-KP2.md`; **not** `BaseDense` (the remaining `exists_preBend` children are another job's), `HexRing`, `BaseWalk`, `Terminal`, nor any declaration `main` brought (new declarations only)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k — read your token count at every saved stage

Hello. You are planning the largest remaining construction on wave 5's main branch, in the Lean backlog. The milestone, FS-131, turns this project's
hand-derived results into kernel-checked ones; waves 1–4, Woodall's chain and MERGE are on `main`, and `main` has just been merged into this branch, so its bend
and cut machinery (`bendMap`, `cutArcs`, `toward_clear`, …) is here. Wave 5's pre-bend step `exists_preBend` is proved over the strengthened bend
`bend_toward_collar` and three small children; the strengthened bend itself — a lens with a horn-shaped tip at a horn end, which `main`'s `bendMap` cannot give
— is designed (KB2's D1) and priced at 3,000–4,000 lines. It gets a plan before its implementers.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and `n3_base`,
`localDense` and `dense3` rest on `exists_preBend`. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

The leaf, `sorry` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` at `ae881022` (read it whole there, with its docstring), its first line:

> theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

KB2's design — read its record § 44 in full, and I5o's notes § 41.2:

> - **The lens boundary `β`**: `C_A`, `C_B`, the circles of radius `R < 1` internally tangent to `ω(P)` at `A`, `B` (centres `P + (1 − R)e(θ₁)`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md 44.3 The construction's design (D1; for the construction leaves)

What the earlier jobs found and handed back, and the rulings that launch you:

> 359. **FS131-I5o, by message (mid-job): `exists_preBend`'s strengthened bend needs more than wave 4's bend machinery** — ruling 317 (b)'s trigger. (1)
> — source: plans/FS131-close-inventory.md

> 365. **FS131-I5o, by message: a correction to item 363 — finding (1) retracted, finding (2) narrowed.** (1) **Retracted** (one retraction, I5o's): a unit arc
> — source: plans/FS131-close-inventory.md

> 369. **FS131-I5o handed back: `row134BaseUA` is held on `fs131-w5`** (Stage 42 SAVED, harness ≈ 384k by the task notice; record `fs131-w5`'s
> — source: plans/FS131-close-inventory.md

> 378. **FS131-KB2 handed back** (Stage 46 SAVED, harness ≈ 420k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 43–46;
> — source: plans/FS131-close-inventory.md

> 386. **FS131-M5 done: `main` merged into `fs131-w5`** (harness ≈ 368k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 47–51;
> — source: plans/FS131-close-inventory.md

> 387. **Rulings on M5's held items, and its slot.** (a) **The two module-local copies stay `private`** until after wave 5 lands; their move to common homes on
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read KB2's record § 44, I5o's § 41, and `main`'s bend machinery now on this branch
   (`bendMap`, `bend_toward`, `toward_clear`, `cutArcs` and its lemmas in `Plane/ValidMap/UnitArc` and `Surgery`); build the branch once as given (`ae881022`);
   restate in your record what you are planning and what you may change. Commit and push.
2. **The route checked**: D1 read against the child's clauses (validity, same domain, `RingArcsWithin`, R1–R3, no new inert arc, the homeomorphism and colour
   transport) and against `main`'s machinery — which parts are reused as they stand, which need new children, and any clause D1 cannot meet (a message to me).
3. **The skeleton**: `bend_toward_collar` reduced to named children with `sorry` at each, building through the worktree's `./scripts/build.sh` with only `sorry`
   warnings; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; its statement unchanged (checked by
   script); no new `axiom`, no `native_decide`.
4. **Your record**, `plans/FS131-collar-kernel-plan.md`: a plan per child (route, Mathlib and `main` lemmas confirmed with `#check`, what is hard, a price),
   the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), inhabitants for any structure taken as a hypothesis, and a handoff for the
   implementers — with how two of them could split the work by file. A child you can prove in about an hour, prove, and say so.
5. The report, in standing rule 11's form. You do not merge another branch into this one, run the gate, or touch `main`. Stopping at a saved stage with what is
   left named is a good report.

## What is yours to decide

The layout, the cut into children, their names, and where each lives within your touches. KB2's D1 is a design, not a rule: a simpler construction you find
is yours, said in the record. Formalize any outside fact under about an hour of agent work; else an `axiom` with `LEAN.md` § Assumptions' four items — never
one of our own hand results. If `bend_toward_collar` is false as stated for some configuration in its hypotheses, that is a finding: message me at once with
the smallest counterexample. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it
knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.
