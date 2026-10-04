# Brief FS131-K5 — wave 5 of the Lean backlog: plan its foundation and skeleton (termination, the stuck chains' ends, row 134's base, density)

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K5
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan wave 5's kernel module — its foundation sorry-free, its 13 rows as a skeleton with `sorry` at every leaf, each read back against its row, a plan per leaf, the implementer's handoff; and draft the `Row134Base` stub
  launch: now, beside FS131-I2k (wave 2's implementer) and FS131-I4f (wave 4's implementer), each in its own worktree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a generalization or shorter route, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K5.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w5-kernel-plan.md`
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): new modules under `Proofs/HadwigerNelson/` (the opening plan names `Plane/ValidMap/Dense` and `Plane/ValidMap/Terminal`; the layout is yours), supporting lemmas in the foundation modules under `Proofs/HadwigerNelson/Plane/` (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-w5-kernel-plan.md`, `tools/fs131_k5_*.py`, `data/fs131/k5/` (the stub draft goes there as `data/fs131/k5/STUB-row134-base-lean.md`), `data/fs131/reports/FS131-K5.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. You are planning the fifth wave of the milestone that turns this project's hand-derived results into kernel-checked ones. Waves 1 and 3 are
landed on `main` (held in the kernel), with Lebesgue's covering theorem and wave 3's sector structure `localSectors`; waves 2 and 4 are fully planned and
their implementers are proving them now (wave 4 has 41 of its 86 leaves proved); Woodall's chain is proved apart from wave 4's statements. Wave 5 is
**termination and density**: the terminal valid map `M*` that the moves reach (N2-RED, N2-TERM), the ends of stuck chains (C-ENDS, C-DOUBLE), row 134's base
step (N3-BASE, over the outside-backlog hypothesis `Row134Base`), and the density statements built on it (N3-DENSE3, CV-EXISTS, OR1-LOCALDENSE, DISC1TS,
BV-HEX, CVB-THOM, ROTHEX, N3-COR3, CV-HD). It stands on wave 4's vocabulary of valid maps; waves 6–9 stand on it.

Read first: the opening plan `plans/FS131-kernel-plan.md` §§ 4–7 (its § 6 is the model your record should match; its § 7.3 is this job's checklist; its
§ 7.4 names `Row134Base`); then wave 4's plan on its branch, `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 2, 3.2, 14.2 and 14.5 — the
vocabulary you inherit (its moves, horns, contact types, `Terminal`), its read-back conventions, and its notes written for you. Your worktree holds wave 4's
skeleton with the proofs its implementers have committed so far (`9a8de899`), so its modules are in your tree.

Two patterns worth knowing before you start. First, every planner on this milestone so far reached its context line before finishing and handed back at a
saved stage with a precise list for a successor: commit the foundation, then the skeleton module by module, and if your context runs short, hand back with
what is left named — that is a good report. Second, **definitions can be unsatisfiable without anyone noticing until a proof needs an inhabitant**: Woodall's
merged and normal forms were first stated with conditions no map meets (horns that could not exist; inventory item 158), and the fix was ∃-forms checked by
an explicit inhabitant. So `LEAN.md` § The gate's inhabitant rule now binds the planner too: every structure a theorem takes as a hypothesis gets a named
inhabitant that exercises every clause at once, at a parameter the theorem does not refute.

## Why this job

Since Workflow 3.1 a milestone closes only when its Lean module passes the gate; this milestone formalizes the hand results the milestones before
it left on paper. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your rows are the 13 rows of `data/fs131/k1/dispositions.csv` with wave 5 and disposition *formalize*: FS114-BV-HEX, FS114-CVB-THOM, FS112-N3-COR3,
FS112-ROTHEX, FS112-N3-BASE, FS112-N3-DENSE3, FS114-CV-EXISTS, FS129-OR1-LOCALDENSE, FS129-SR2-DISC1TS (the opening plan's `Plane/ValidMap/Dense`);
FS114-CV-HD, FS112-N2-TERM, FS112-C-ENDS (its `Plane/ValidMap/Terminal`); and FS112-C-DOUBLE, moved here from wave 4. Two more rows merge into them and
must be carried: FS112-DISC1 into FS129-SR2-DISC1TS, FS112-N2-RED into FS112-N2-TERM. FS112-C-ENDS, -C-DOUBLE and -N3-BASE are governed by caution
C116 — formalize them with the errata filed under it, which `plans/LEAN-BACKLOG.md` quotes at their rows. Each row's statement is quoted, with its errata
and merge notes, in `plans/LEAN-BACKLOG.md` at the row's heading; the definitions are in the derivation files (`plans/FS112-derivation.md`,
`plans/FS114-derivation.md`, `plans/FS129-derivation.md`) at the address the backlog gives — for the FS-112 rows, in the older grammar, read
`plans/FS112-derivation.md`'s errata section too. The opening plan's rules for how every row is stated:

> 3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in
> — source: plans/FS131-kernel-plan.md § 7.3 What each wave's planning job must hold

> 4. **Names every hypothesis from outside the backlog** in the declaration's docstring and in § 7.4's list; never imports a hand result of ours as an
> — source: plans/FS131-kernel-plan.md § 7.3 What each wave's planning job must hold

Read all six items of that section. Three obligations reach you from wave 4. C-DOUBLE's move, with its supporting lemma:

> 69. **Ruling — FS112-C-DOUBLE moves from wave 4 to wave 5** (K4b, message 2026-10-04): its proof is "a sketch over FS112-Y3-END-NEEDS's levels with n reversed and
> — source: plans/FS131-close-inventory.md

(the item continues there: FS112-Y3-END-NEEDS, in its corrected form, is formalized in wave 5 beside C-DOUBLE, and you settle whether C-DOUBLE's "terminal
valid map" means N2-TERM's `M*` or wave 4's `Terminal`). FLANK-Q's discharge:

> - **FLANK-Q's discharge obligation** [inventory items 79–80, ruled 2026-10-04]: `flankQ_upper`, `flankQ_lower` take `hQR` — every arc of `Γ` on `ω(N)` (resp.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md ### 14.5 Notes for wave 5's planner (from wave 4's planners; Keryx's rulings in brackets)

and FS112-N3-END's chain clause ("and the chain is the single vertex", inventory item 74), stated here with the stuck-chain vocabulary. § 14.5 lists the
rest — the moves' form, FS114-L60-WALK's five consumers over `l60_le`'s non-strict bound, wave 4's outside-backlog hypotheses, and three readings fixed in
wave 4 that a wave-5 statement may meet.

**`Row134Base`** enters as a named hypothesis (the opening plan § 7.4), never as an `axiom` and never imported: state it as a Lean `Prop` in your foundation,
take it as a hypothesis of FS112-N3-BASE and its consumers, and name it in their docstrings. Its own formalization is a separate planner-and-implementer
job, so you also draft that job's stub (`data/fs131/k5/STUB-row134-base-lean.md`): what `Row134Base` states, read against `[SokolovVoronov2025]` Cor. 1 and
FS-110's repairs (FS110-CB, -CD, -CE), where it is used, what its proof needs (Lemma 5, Prop. 18, Lemma 6's `< 9` branch, CUSP-BASE), what wave 4 and 5
already supply, and your estimate of its leaves — written so a fresh planner with no memory of this session can open it. I file it; the ruling:

> 191. **Ruling: IWd's slot goes to wave 5's planner (FS131-K5), now.** Choice: launch the planner. Alternative weighed: a second wave-4 implementer on a branch
> — source: plans/FS131-close-inventory.md

## Done means

1. **Wave 5's foundation** (the opening plan § 7.1's row for wave 5: stuck chains along the normal line; `F(M)`, `R(M)`; `Row134Base` as a `Prop`).
   Sorry-free, with a spec example per definition, a named inhabitant per structure a theorem takes as a hypothesis (every clause at once), and one fresh
   `debruijn-domain-modeling` pass. Where a derivation never fixed a definition the rows' words need, write your choice, the alternatives, and which rows
   each would change — and message me if the choice changes what a row says.
2. **The skeleton**: every row of wave 5 (and Y3-END-NEEDS, FLANK-Q's unconditional form, N3-END's chain clause) in Lean with `sorry` at every leaf,
   building through the worktree's `./scripts/build.sh` with only the `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py`
   exit 0) and `scripts/Axioms.lean` updated on the branch.
3. **Your record**, `plans/FS131-w5-kernel-plan.md` on the branch, in the opening plan's § 6 form: the read-back of each formal statement against its row,
   a plan per leaf (route, Mathlib lemmas confirmed with `#check`, named children, what is hard), the obligation-modeling pass
   (`debruijn-obligation-modeling`, invoked fresh), the vacuity carriers and their inhabitants, and a handoff section for the implementer in the form of
   wave 4's § 14. Stages headed "Stage n — SAVED"; "Theorems this phase proved" (usually none).
4. **The stub draft** at `data/fs131/k5/STUB-row134-base-lean.md`.
5. The report, in standing rule 11's form.

## What is yours to decide

The representation, the module layout, the order of the rows, and any outside theorem (formalize anything under about an hour of agent work, else an
`axiom` with the four items of `LEAN.md` § Assumptions — never one of our own hand results). If a row cannot be stated without a hypothesis its derivation
hid, or a term is never fixed, that is a finding: message me at once. A widening the kernel allows is a generalization: message me as well. If a wave-5 row
turns out to need a row from wave 6 or later, say so and stop that leaf. You start no agents of your own (standing rule 1: delegation is one level deep,
because the coordinator can only review work it knows exists).

## Stages

1. **The readback**: check the quotations above against their sources; restate your rows, the merged rows, the three obligations from wave 4 and the caution
   in your record. Confirm the worktree builds as given (one `./scripts/build.sh` run under the slot). Commit on the branch and push it
   (`git push -u origin fs131-w5`).
2. **The foundation**, sorry-free, validated, building, with the definitions' choices recorded. Commit.
3. **The skeleton and the read-backs**, module by module, committing after each. Message me the commit when all are stated.
4. **The leaf plans, the obligation-modeling pass, the stub draft.** Commit.
5. **The handoff section**, then report.

## The machine, the branch, and the landing

- **The worktree is ready**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5`, branch `fs131-w5` at `9a8de899` (wave 4's branch as FS131-I4e left
  it, which already merged `main` with waves 1 and 3 landed), `.lake/packages` a symlink to the main tree's and `.lake/build` its own copy, made by the
  project's recipe. Never replace that copy with a symlink: two trees compiling into one build race on the same compiled files.
- **Builds** only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G
  BATCH=4 ./scripts/build.sh`; never `lake build`. Up to two such builds from different worktrees may run at once when the slot admits them — with two
  implementers building beside you, expect to wait on exit 75 (wait ten minutes and retry). The first build rebuilds what changed since the copied build.
  `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence that a module is green.
- **Nothing with a `sorry` reaches `main`** (the opening plan § 7.5): your work stays on `fs131-w5` and lands with the wave, after its implementer's gate,
  once wave 4 has landed. Wave 4's statements may still gain children as its implementer works on `fs131-w4`, but never change: build on them as committed;
  wave 5's implementer merges `fs131-w4` (or `main`, once wave 4 lands) before its gate.

## Amendment 2026-10-04 (Keryx) — F-BASE ruled; F-WALK5, R-CDOUBLE, R-CHAIN, R-MOD accepted

Your five findings are logged as `plans/FS131-close-inventory.md` item 196 and ruled in item 197. In short: your unit-arc statement of the base stays, but as
wave 5's **intermediate `Prop`**, proved inside this milestone — not as the outside hypothesis. The walk's assembly (N3-BASE's table) is a wave-5 theorem, so
FS112-N3-BASE's Lean proof is the pre-bend plus the walk. The named outside hypotheses are only the pieces of `[SokolovVoronov2025]` (in FS-110's repaired
forms) that the walk uses by statement, each a named `Prop`; any piece the walk reads inside a proof is ours to formalize. The reason is the milestone's
Closed rule, item 3: no hand result of ours may be left as a hypothesis unless it is outside the backlog, and N3-BASE is a wave-5 row.

What this asks of you, as far as your context allows (handing the rest to a successor planner in your § 5 is a good report):
1. Rename the intermediate so it does not read as the outside hypothesis (`Row134BaseUA`, or your choice), and add the walk's assembly to the skeleton as a
   theorem with its leaves, or name it in § 5 for the successor.
2. In the record, list which pieces of `[SokolovVoronov2025]` the walk uses by statement (the candidates for named outside `Prop`s) and which it reads inside
   a proof; if the second list is the whole argument, say so plainly — I then place it in this milestone as its own planner job.
3. Rewrite the stub draft (`data/fs131/k5/STUB-row134-base-lean.md`) to cover only what stays outside, or say it covers nothing.

F-WALK5's `stuck_structure_ua`, R-CDOUBLE's `IsTerminalMap`, R-CHAIN's chain vertices and R-MOD's `IsModification` are accepted as stated. You still start no
agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
