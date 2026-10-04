# Brief FS131-KB — the base of row 134 with unit arcs: plan `row134BaseUA`'s proof as a skeleton of leaves (wave 5's base)

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KB
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan the proof of `row134BaseUA` (row 134's base step, unit arcs allowed) — confirm that nothing in it is used from the literature by statement, settle the two open questions, lay out its leaves as a skeleton with `sorry` at every leaf, read each back, give a plan per leaf, run the obligation pass, and write the base's implementer handoff
  launch: now, in the fourth slot Kooshi granted (inventory item 211), beside FS131-I2l (wave 2), FS131-I4h and FS131-IC1 (wave 4), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a missing lemma, a piece of the literature you find used by statement, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-KB.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w5base-kernel-plan.md`
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5b` (branch `fs131-w5b`): new modules for the base under `Proofs/HadwigerNelson/Plane/ValidMap/` (your layout), `Proofs/HadwigerNelson/Plane/ValidMap/Dense.lean` only to move `row134BaseUA` and its four consumers (`n3_base`, `localDense`, `dense3`, `cv_exists`) into a module downstream of your base if the imports require it — statements unchanged, `Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean` only for `NoInertNear` if you change it (§ The statements), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-KB"), `plans/FS131-w5base-kernel-plan.md`, `tools/fs131_kb_*.py`, `data/fs131/kb/`, `data/fs131/reports/FS131-KB.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. You are planning the proof of the base step of row 134 — the step at a cubic trichromatic vertex of a valid six-coloured map, with unit arcs
allowed, that the density results of wave 5 (and through them FS-114's existence of a counterexample-free valid map) rest on. The milestone is FS-131, the
Lean backlog: it turns this project's hand-derived results into kernel-checked ones, wave by wave. Waves 1 and 3 are landed; waves 2 and 4 are being proved;
wave 5 is planned (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md`, its handoff in § 10) except for this one statement, which its first planner, FS131-K5, stated as
an intermediate `Prop` and found to be **ours to formalize in full**: on the walk's table (FS112-N3-BASE, `plans/FS112-N-proof.md` stage N3-3), every piece of
Sokolov and Voronov's argument is read inside a proof, none by statement. Your job is to turn that walk into a Lean skeleton the base's implementer can work
from.

K5 drafted this job's input as a stub, kept on your branch: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5b/data/fs131/k5/STUB-row134-base-lean.md`. Read it first and in full — what `Row134BaseUA` states
in Lean, why this form and not the Condition-5 base, where it is used, what its proof needs and who supplies each piece, the records to read in order, its
estimate (40–60 leaves), and the risks to check first.

## Why this job

Since Workflow 3.1 a milestone closes only when its Lean module passes the gate, and the backlog closes only when no hand result of ours is left as a hypothesis
(the inventory's § What "Closed" means, item 3). Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

The statement is `row134BaseUA : Row134BaseUA` in `Proofs/HadwigerNelson/Plane/ValidMap/Dense.lean` on your branch (`Row134BaseUA` is defined in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5b/Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean`). Its placement:

> 197. **Ruling on F-BASE: the unit-arc statement stays, as an intermediate `Prop` proved inside FS-131 — not as the outside hypothesis.** Choice: K5's unit-arc
> — source: plans/FS131-close-inventory.md

(the item continues there). The stub's own summary of what stays outside:

> Inventory item 197: the unit-arc statement of the base is wave 5's intermediate `Prop` **`Row134BaseUA`**, proved inside FS-131 (`row134BaseUA`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/data/fs131/k5/STUB-row134-base-lean.md ## What stays outside: provisionally nothing

(it continues there: FS110-CB, -CD, -CE, -CC and `plans/BASE-V-verification.md` were not read by K5, and a pure circle-colouring lemma cited from the paper
without re-proof is the one kind of by-statement use to look for). Two questions are yours to settle before the skeleton:

1. **`NoInertNear`'s scope** — the ruling:

> (b) **`NoInertNear` (exclude only inert arcs not ending at `u`?) is the base planner's call**, since `Row134BaseUA` is an intermediate of ours and the
> — source: plans/FS131-close-inventory.md

2. **Lemma 3 with contact arcs** — wave 5's second planner, FS131-K5b, found that `bv_l3` needs `RingProper` (finitely many points of `ω(u_i)` on `Γ`), so the
   walk's step 8 at a pigeonhole vertex whose circle carries an in- or out-contact arc has no Lemma 3 as stated; settle first whether such arcs can occur
   there, or whether a Lemma 3 tolerating them is needed (BASE-V did not derive one). K5b's notes for you are `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md` § 10.5.

The wave-5 statements you may use as given (each a skeleton leaf on `fs131-w5`, proved by wave 5's implementer): FS112-N3-COR3 (`cor3`), FS112-ROTHEX
(`Plane/ValidMap/HexRing`), FS114-BV-HEX's four clauses, and wave 4's FS112-N3-PAIRS, -N3-FAIL, -N3-ANTI, -N3-NOBOTH (`Plane/ValidMap/BaseSteps`,
`Plane/ValidMap/UnitArc` on `fs131-w4`, being proved now). If the walk needs one of them in a different form than stated, that is a finding: message me.

## Done means

1. **Your readback first**: check the quotations above against their sources; build the branch once as given (`764cc558`); restate in your record what you
   are planning and what you may change. Commit and push (`git push -u origin fs131-w5b`).
2. **The confirmation**: read FS110-CB, -CD, -CE, -CC (`plans/FS110-derivation.md` and the files it names) and `plans/BASE-V-verification.md` for any piece of
   `[SokolovVoronov2025]` used by statement; for each found, state it as a named `Prop` (with the paper's statement quoted and its page) and message me. If none,
   say so in the record.
3. **The two questions settled** in the record, each with the choice, the alternative, and which statements it changes; message me before changing `NoInertNear`.
4. **The skeleton**: `row134BaseUA`'s proof laid out as named lemmas with `sorry` at every leaf, in your module layout, building through the worktree's
   `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated.
   Each leaf read back against the walk's line it formalizes.
5. **Your record**, `plans/FS131-w5base-kernel-plan.md`, in the opening plan's § 6 form: a plan per leaf (route, Mathlib lemmas confirmed with `#check`, named
   children, what is hard), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), inhabitants for any structure the leaves take as a
   hypothesis, and a handoff for the base's implementer in the form of wave 4's plan § 14 — including how your branch merges into `fs131-w5`.
6. The report, in standing rule 11's form. Stopping at a saved stage with what is left named is a good report.

## What is yours to decide

The layout of the base's modules, the order and names of its leaves, how the walk is cut into lemmas, and the answers to the two questions (with the message
before any change to `NoInertNear`). Formalize any outside fact under about an hour of agent work; else an `axiom` with `LEAN.md` § Assumptions' four items —
never one of our own hand results. If a step of the walk fails as written, that is a statement defect of row 134's base (and of rows 135 and 137 above it):
message me at once. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows
exists).

## The machine, the branch, and the landing

- **The worktree is ready**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5b`, branch `fs131-w5b` at `764cc558` (wave 5's branch as FS131-K5b left it), `.lake/packages` a symlink to the main tree's and
  `.lake/build` its own copy. Never replace that copy with a symlink: two trees compiling into one build race on the same compiled files.
- **Builds** only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
  ./scripts/build.sh`; never `lake build`. Up to two such builds from different worktrees may run at once when the slot admits them; four agents are building
  today, so on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only.
- **Nothing with a `sorry` reaches `main`**: your branch merges into `fs131-w5` when I say so (wave 5's implementer works on `fs131-w5` meanwhile, on leaves
  other than `row134BaseUA` and its four consumers), and lands with wave 5 after wave 4.
